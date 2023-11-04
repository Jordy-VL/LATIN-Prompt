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

%DLA_inference; instances_predictions.pth

- DLA extension (which (distilled DLA model it comes from)
    - teacher (CNN/ViT-b)
    - simkd
    - reviewkd

'''

GPU=4
MODELS=(llama2-7b-chat) # alpaca-7b-chat vicuna-7b-chat mistral-7b-chat
DATASETS=(docvqa_due_azure) #DUDE
DLA_MODELS=('') # CNN ViT-b simkd_ViT-t reviewkd_ViT-t simkd_CNN reviewkd_CNN
for model in ${MODELS[@]}; do
    for dataset in ${DATASETS[@]}; do
        #nohup bash script/llama_eval.sh 2 $model $dataset plain 'plain' > plain.out &
        #nohup bash script/llama_eval.sh 3 $model $dataset space 'space' > space.out &
        nohup bash script/llama_eval.sh 4 $model $dataset task_instruction_space > latin.out &
        for dla_model in  ${DLA_MODELS[@]}; do
            echo $dla_model
            # bash script/llama_eval.sh $GPU $model $dataset plain_DLA $dla_model
            # bash script/llama_eval.sh $GPU $model $dataset space_DLA $dla_model
            # bash script/llama_eval.sh $GPU $model $dataset task_instruction_space_DLA $dla_model
        done
    done
done