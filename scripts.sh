'''
What is variable?

(- model) --> for now just use llama2-7b-chat; could swap to alpaca/vicuna/mistral/qwen/zephyr... ; maybe even to larger models (H1: less dependence on layout?)
(- data) --> for now just use docvqa_due_azure; could swap to DUDE
- prompt type
    - plain
    - space
    - task_instruction_space [LATIN]
    - plain DLA
    - space DLA
    - task_instruction_space DLA [DLATIN]

# DLA_inference instances_predictions.pth

- DLA extension (which (distilled DLA model it comes from)
    - teacher (CNN/ViT-b)
    - simkd
    - reviewkd

'''

GPU=${1:-5}
MODELS=(llama2-7b-chat) # alpaca-7b-chat vicuna-7b-chat mistral-7b-chat
DATASETS=(infographics_vqa) #DUDE docvqa infographics_vqa
DLA_MODELS=(
#vitb_imagenet_doclaynet_tecaher_ignore_tokens-Text
#vitb_vitt_simkd_fpn_doclaynet_ignore_tokens-Text
#resnet101_imagenet_doclaynet_teacher_ignore_tokens-Text
#r101_r50_reviewkd_doclaynet_ignore_tokens-Text
vitt_imagenet_doclaynet_tecaher_ignore_tokens-Text
#r50_doclaynet_ignore_tokens-Text
#r101_r50_simkd_doclaynet_ignore_tokens-Text
#vitb_vitt_reviewkd_doclaynet_ignore_tokens-Text
#vitb_imagenet_doclaynet_tecaher_ignore_tokens-Text_conf0 #bonus
) # CNN ViT-b simkd_ViT-t reviewkd_ViT-t simkd_CNN reviewkd_CNN
for data in ${DATASETS[@]}; do
    for model in ${MODELS[@]}; do
        dataset=${data}_due_azure
        # nohup bash script/llama_eval.sh $GPU $model $dataset plain 'plain' > plain.out &
        # nohup bash script/llama_eval.sh $GPU $model $dataset space 'space' > space.out &
        # nohup bash script/llama_eval.sh 0 $model $dataset task_instruction > task_instruction.out &
        # nohup bash script/llama_eval.sh 1 $model $dataset task_instruction_space > task_instruction_space.out &
        # bash script/llama_eval.sh 0 $model $dataset task_instruction &
        # bash script/llama_eval.sh 1 $model $dataset task_instruction_space &
        # bash script/llama_eval.sh 5 $model $dataset space &

        for dla_model in  ${DLA_MODELS[@]}; do
            echo $dla_model
            #nohup bash script/llama_eval.sh 2 $model $dataset plain ${data}_$dla_model > plain.out &
            # nohup bash script/llama_eval.sh 3 $model $dataset space ${data}_$dla_model  > space.out &
            #nohup bash script/llama_eval.sh $GPU $model $dataset task_instruction_space ${data}_$dla_model > latin.out &
            # nohup bash script/llama_eval.sh 1 $model $dataset task_instruction_DLA ${data}_$dla_model > task_instruction_DLA.out &
            # nohup bash script/llama_eval.sh 2 $model $dataset task_instruction_space_DLA ${data}_$dla_model > task_instruction_space_DLA.out &
            #nohup bash script/llama_eval.sh 2 $model $dataset task_instruction ${data}_$dla_model > ${data}_${dla_model}.out &
            nohup bash script/llama_eval.sh 0 $model $dataset task_instruction_space ${data}_$dla_model > ${data}_${dla_model}.out &
        done
        #bash script/llama_eval.sh 5 $model $dataset plain &

    done
done