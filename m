Return-Path: <linux-nfs+bounces-8567-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B41039F28C3
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 04:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3188E18832B6
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 03:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2AB15383C;
	Mon, 16 Dec 2024 03:18:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E02322B
	for <linux-nfs@vger.kernel.org>; Mon, 16 Dec 2024 03:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734319102; cv=none; b=OVO6XDxVUjb9V/acwWY78z3wBRSVnqSWovfpAbDEx23Vrez2fMJShlljSWVl19KNm++Uzhph8/evSlqneo6IMtsqCor34tbNlZ40wj8PrBUIO9nU5JTYWv+S3KTZsUCX6noy5rPQfmk6TA42phF9HrplMQui8N+RMBY6BqihJzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734319102; c=relaxed/simple;
	bh=io19vsz7CTh1k6pfT8FngngGeFmejLD3ASRQh/sx7Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSFFq3QiOw/ddh8df5VHA/dd2EkeQAccYwwzXfTT4pTTHvyxWf73tKOKC3r6/GyDZTiJbLEjAvZgjhuRnsrpqEsZP+PTitviPh+rrHfcLvXofWsQNS4qXGn/ONGk65FKB8+BtfbqB/Hzfhzb5ej5ZE66w65iPlT4IcOBqqQQhBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YBQ9v1Q8Mz4f3jsr
	for <linux-nfs@vger.kernel.org>; Mon, 16 Dec 2024 11:17:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9C8881A0194
	for <linux-nfs@vger.kernel.org>; Mon, 16 Dec 2024 11:18:14 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgDHo4f1m19n2ZXqEg--.12842S3;
	Mon, 16 Dec 2024 11:18:14 +0800 (CST)
Message-ID: <eb4a56e2-d6d2-0491-fcf5-95d5c29cd7ab@huaweicloud.com>
Date: Mon, 16 Dec 2024 11:18:12 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] nfsd: do not use async mode when not in rcu context
To: chuck.lever@oracle.com, jlayton@kernel.org, linux-nfs@vger.kernel.org
Cc: yangerkun@huawei.com, liumingrui@huawei.com
References: <20241214134916.422488-1-yangerkun@huaweicloud.com>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20241214134916.422488-1-yangerkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHo4f1m19n2ZXqEg--.12842S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyrXFyrZFWrCw4rCw1fXrb_yoWruF18pF
	WfJayakaykJFy2gwsrXa4jvwnxK3ZY9Fy8Zw18K3yYvrn8Jr1kCw1rZFyj9ryYvrW8W3yx
	Zr40qa1DGw48ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU80fO7
	UUUUU==
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/12/14 21:49, Yang Erkun 写道:
> From: Yang Erkun <yangerkun@huawei.com>
> 
> shell:
> 
> mkfs.xfs -f /dev/sda
> echo "/ *(rw,no_root_squash,fsid=0)" > /etc/exports
> echo "/mnt *(rw,no_root_squash,fsid=1)" >> /etc/exports
> exportfs -ra
> service nfs-server start
> mount -t nfs -o vers=4.0 127.0.0.1:/mnt /mnt1
> mount /dev/sda /mnt/sda
> touch /mnt1/sda/file
> exportfs -r
> umount /mnt/sda
> 
> Commit f8c989a0c89a ("nfsd: release svc_expkey/svc_export with rcu_work")
> describe that when we call e_show/c_show, the last reference can down to
> 0, and we will call expkey_put/svc_export_put with rcu context, this may
> lead uaf or sleep in atomic bug. Finally, we introduce async mode to the
> release and fix the bug. However, some other command may also finally call
> expkey_put/svc_export_put without rcu context, but expect that the sync
> mode for the resource release. Like upper shell, before that commit,
> exportfs -r will remove all entry with sync mode, and the last umount
> /mnt/sda will always success. But after this commit, the umount will always
> fail, after we add some delay, they will success again. Personally, I think
> is actually a bug, and need be fixed.
> 
> Use rcu_read_lock_any_held to distinguish does we really under rcu context,
> and if no, release resource with sync mode.
> 
> Fixes: f8c989a0c89a ("nfsd: release svc_expkey/svc_export with rcu_work")
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>   fs/nfsd/export.c | 44 ++++++++++++++++++++++++++++++++------------
>   1 file changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index eacafe46e3b6..25f13e877c2f 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -40,11 +40,8 @@
>   #define	EXPKEY_HASHMAX		(1 << EXPKEY_HASHBITS)
>   #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
>   
> -static void expkey_put_work(struct work_struct *work)
> +static void expkey_release(struct svc_expkey *key)
>   {
> -	struct svc_expkey *key =
> -		container_of(to_rcu_work(work), struct svc_expkey, ek_rcu_work);
> -
>   	if (test_bit(CACHE_VALID, &key->h.flags) &&
>   	    !test_bit(CACHE_NEGATIVE, &key->h.flags))
>   		path_put(&key->ek_path);
> @@ -52,12 +49,25 @@ static void expkey_put_work(struct work_struct *work)
>   	kfree(key);
>   }
>   
> +static void expkey_put_work(struct work_struct *work)
> +{
> +	struct svc_expkey *key =
> +		container_of(to_rcu_work(work), struct svc_expkey, ek_rcu_work);
> +
> +	expkey_release(key);
> +}
> +
>   static void expkey_put(struct kref *ref)
>   {
>   	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
>   
> -	INIT_RCU_WORK(&key->ek_rcu_work, expkey_put_work);
> -	queue_rcu_work(system_wq, &key->ek_rcu_work);
> +	if (rcu_read_lock_any_held()) {

Emm...

This api won't work when we disable CONFIG_PREEMPT_COUNT...

> +		INIT_RCU_WORK(&key->ek_rcu_work, expkey_put_work);
> +		queue_rcu_work(system_wq, &key->ek_rcu_work);
> +	} else {
> +		synchronize_rcu();
> +		expkey_release(key);
> +	}
>   }
>   
>   static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
> @@ -364,11 +374,8 @@ static void export_stats_destroy(struct export_stats *stats)
>   					    EXP_STATS_COUNTERS_NUM);
>   }
>   
> -static void svc_export_put_work(struct work_struct *work)
> +static void svc_export_release(struct svc_export *exp)
>   {
> -	struct svc_export *exp =
> -		container_of(to_rcu_work(work), struct svc_export, ex_rcu_work);
> -
>   	path_put(&exp->ex_path);
>   	auth_domain_put(exp->ex_client);
>   	nfsd4_fslocs_free(&exp->ex_fslocs);
> @@ -378,12 +385,25 @@ static void svc_export_put_work(struct work_struct *work)
>   	kfree(exp);
>   }
>   
> +static void svc_export_put_work(struct work_struct *work)
> +{
> +	struct svc_export *exp =
> +		container_of(to_rcu_work(work), struct svc_export, ex_rcu_work);
> +
> +	svc_export_release(exp);
> +}
> +
>   static void svc_export_put(struct kref *ref)
>   {
>   	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
>   
> -	INIT_RCU_WORK(&exp->ex_rcu_work, svc_export_put_work);
> -	queue_rcu_work(system_wq, &exp->ex_rcu_work);
> +	if (rcu_read_lock_any_held()) {
> +		INIT_RCU_WORK(&exp->ex_rcu_work, svc_export_put_work);
> +		queue_rcu_work(system_wq, &exp->ex_rcu_work);
> +	} else {
> +		synchronize_rcu();
> +		svc_export_release(exp);
> +	}
>   }
>   
>   static int svc_export_upcall(struct cache_detail *cd, struct cache_head *h)


