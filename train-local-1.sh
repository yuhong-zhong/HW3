set -euxo pipefail

echo "submitting a AI Platform job.."

MODEL_NAME="cifar10"

CURRENT_DATE=`date +%Y%m%d_%H%M%S`
JOB_NAME=train_${MODEL_NAME}_${CURRENT_DATE}

MY_BUCKET="/tmp/cifar10/"
#gsutil cp -r ${PWD}/cifar10_estimator/cifar-10-data $MY_BUCKET/

gcloud ai-platform local train $JOB_NAME \
    --runtime-version 1.15 \
    --job-dir=$MY_BUCKET/model_dirs/cifar_${CURRENT_DATE} \
    --package-path cifar10_estimator/ \
    --module-name cifar10_estimator.cifar10_main \
    -- \
    --data-dir=$MY_BUCKET/cifar-10-data \
    --num-gpus=0 \
    --train-steps=1000

