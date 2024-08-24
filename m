Return-Path: <linux-nfs+bounces-5673-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD03D95DA3F
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 02:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE176B22F99
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 00:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6182B4A05;
	Sat, 24 Aug 2024 00:45:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D82AD5E;
	Sat, 24 Aug 2024 00:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724460306; cv=none; b=m5JcvpalQbzmJRdniLfPbck8BDFZEgZloUKdoAuzXmxRhPZ1SORz71L2PcPOuckNs+/tBKYVs03GqwzdkdQoCMOzum/YpbDZ7h4MiXNvNtgEEbIqDhd6YVlDVME0cgu+yAcnhoSiwA8h2ZoFmKXY36KPRhWJqK0u7jiAuau1oCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724460306; c=relaxed/simple;
	bh=p/dOXVebINOPRQggnQsCdvcJNxKq6jyO/gEZ/Ha2L/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5b1w9EGFo3GuP8AMs5QeCg6dxTRvoVlMk5xJiDGDjluZw+JLIyEkTyCsQ8dGBPhyItpwtyBwOnEiTB0acSmZkeQ5p+BXMBXIp3aPrTCt7MdevuvnY99i0jdNhQ1KJj1m2bpLxfJHJLuQltHGK5Spakdt90+DZzvg3GAvs1GAMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WrJ9m4MKDz4f3jR7;
	Sat, 24 Aug 2024 08:44:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E57591A0568;
	Sat, 24 Aug 2024 08:44:58 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4UILclmezwqCg--.49940S3;
	Sat, 24 Aug 2024 08:44:58 +0800 (CST)
Message-ID: <81ba82dc-4869-d48d-f133-5b10cf5eb0b8@huaweicloud.com>
Date: Sat, 24 Aug 2024 08:44:56 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH 3/4] nfsd: remove the redundant blank line
To: Jeff Layton <jlayton@kernel.org>, Li Lingfeng <lilingfeng3@huawei.com>,
 trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com, neilb@suse.de,
 kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com
References: <20240823070049.3499625-1-lilingfeng3@huawei.com>
 <20240823070049.3499625-4-lilingfeng3@huawei.com>
 <808caff5016c82b338dc46b2a855732dae79d5ba.camel@kernel.org>
From: Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <808caff5016c82b338dc46b2a855732dae79d5ba.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3n4UILclmezwqCg--.49940S3
X-Coremail-Antispam: 1UD129KBjvJXoWrKr1DGF4DCr1xur1rArykGrg_yoW8Jr4xpF
	18AFn8CFs5Jr1kZw4Ivw4fAF1aq395Kr1UGas3tw1Yyr4aqrnYqF109r1Y9ryagrs3W34I
	vFsFvF98u3ZIgaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

Thank you for your response. I appreciate you taking the time to address 
my concerns. Moving forward, I will be more mindful and refrain from 
submitting patches like this.

在 2024/8/23 20:08, Jeff Layton 写道:
> On Fri, 2024-08-23 at 15:00 +0800, Li Lingfeng wrote:
>> Just remove the redundant blank line in do_open_permission. No function
>> change.
>>
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>   fs/nfsd/nfs4proc.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index 2e39cf2e502a..0068db924060 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -141,7 +141,6 @@ fh_dup2(struct svc_fh *dst, struct svc_fh *src)
>>   static __be32
>>   do_open_permission(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open, int accmode)
>>   {
>> -
>>   	if (open->op_truncate &&
>>   		!(open->op_share_access & NFS4_SHARE_ACCESS_WRITE))
>>   		return nfserr_inval;
> NACK. In general, we don't take whitespace patches. They just make
> backporting harder later if you have to do it. If you have a material
> change to make in this area, then go ahead and fix the whitespace, but
> otherwise don't bother.


