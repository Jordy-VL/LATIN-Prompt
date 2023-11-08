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

GPU=${1:-3}
MODELS=(llama2-7b-chat) # alpaca-7b-chat vicuna-7b-chat mistral-7b-chat
DATASETS=(docvqa_due_azure) #DUDE
DLA_MODELS=('vitb_imagenet_doclaynet_tecaher_ignore_tokens-Text') #('vitb_imagenet_doclaynet_tecaher') # CNN ViT-b simkd_ViT-t reviewkd_ViT-t simkd_CNN reviewkd_CNN
for model in ${MODELS[@]}; do
    for dataset in ${DATASETS[@]}; do
        #nohup bash script/llama_eval.sh 2 $model $dataset plain 'plain' > plain.out &
        #nohup bash script/llama_eval.sh 3 $model $dataset space 'space' > space.out &
        # nohup bash script/llama_eval.sh 4 $model $dataset task_instruction_space > latin.out &
        #nohup bash script/llama_eval.sh $GPU $model $dataset task_instruction > latin.out &


        for dla_model in  ${DLA_MODELS[@]}; do
            echo $dla_model
            nohup bash script/llama_eval.sh 1 $model $dataset plain $dla_model > plain.out &
            nohup bash script/llama_eval.sh 3 $model $dataset space $dla_model  > space.out &
            #nohup bash script/llama_eval.sh 3 $model $dataset task_instruction_space $dla_model > latin.out &
        done
    done
done