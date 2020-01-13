set -euxo pipefail

echo "submitting a AI Platform job.."

MODEL_NAME="cifar10"

CURRENT_DATE=`date +%Y%m%d_%H%M%S`
JOB_NAME=train_${MODEL_NAME}_${CURRENT_DATE}

MY_BUCKET="gs://4121-data/"
#gsutil cp -r ${PWD}/cifar10_estimator/cifar-10-data $MY_BUCKET/

gcloud ai-platform jobs submit training $JOB_NAME \
    --runtime-version 1.15 \
    --job-dir=$MY_BUCKET/model_dirs/cifar_${CURRENT_DATE} \
    --config cifar10_estimator/cmle_config.yaml \
    --package-path cifar10_estimator/ \
    --module-name cifar10_estimator.cifar10_main \
    -- \
    --data-dir=$MY_BUCKET/cifar-10-data \
    --num-gpus=4 \
    --train-steps=10000

