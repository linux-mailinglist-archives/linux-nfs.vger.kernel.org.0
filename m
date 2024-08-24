Return-Path: <linux-nfs+bounces-5674-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E130695DA43
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 02:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96826284F7E
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 00:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2439723D2;
	Sat, 24 Aug 2024 00:54:26 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF25EC4;
	Sat, 24 Aug 2024 00:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724460866; cv=none; b=BNSy9ejgxmpk/ajpbdWN+bCRUTdp60UwdVqb0PBzAxnSX/0/R35rm1P2f33gZdS8+/YtWWvveRhTtFZqS7C7ubdZWKRL6PLNqmTgnfsnQsQaPlE7slxjCIv3KxrA5nSIGvCtzmo0o9SjTNUjM+mkc8xrA/x8DuCRIN6ooq77UaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724460866; c=relaxed/simple;
	bh=0HqDaAa5GWkuH29k/CERXUkKuxnEFROcuM1UzPhqV+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T/OzDkfGKxyBw7whG13sjTPtGNvFBGNz7vedZZ1cVlM7Fi6ZXnSfW7bmQiGx2dFB9ElfCHjlMG8mUpo5F05s2EQ8cz/A7HUqS1UR+rSkIw1xQqpCUqwRU2naj5X+qz5XdM7KJO/B8CVdBIXAA3LbaTOumRwO+xmbmPmvtEHJXCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WrJNd6DF2z4f3jjk;
	Sat, 24 Aug 2024 08:54:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9F3DC1A058E;
	Sat, 24 Aug 2024 08:54:19 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4U6L8lm4t4qCg--.47415S3;
	Sat, 24 Aug 2024 08:54:19 +0800 (CST)
Message-ID: <ca5e64ca-ac6e-3d58-297a-d99c9f57d38e@huaweicloud.com>
Date: Sat, 24 Aug 2024 08:54:18 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH 2/4] nfsd: fix some spelling errors in comments
To: Jeff Layton <jlayton@kernel.org>, Li Lingfeng <lilingfeng3@huawei.com>,
 trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com, neilb@suse.de,
 kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com
References: <20240823070049.3499625-1-lilingfeng3@huawei.com>
 <20240823070049.3499625-3-lilingfeng3@huawei.com>
 <f27ca56a2b7de7ebb97a4170222047da56eb8eb7.camel@kernel.org>
From: Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <f27ca56a2b7de7ebb97a4170222047da56eb8eb7.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHL4U6L8lm4t4qCg--.47415S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryxJrWkKr4fKry7uF4kJFb_yoW8Xr17pF
	WrJas5GF48Xw4UGF4a9an7Gw1avw4kKr1UGrnaq3yavF90gr1fWFyqkr1rXr45KrWfuw4q
	gFsxKF9xZws8uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

在 2024/8/23 20:07, Jeff Layton 写道:
> On Fri, 2024-08-23 at 15:00 +0800, Li Lingfeng wrote:
>> Fix spelling errors in comments of nfsd4_release_lockowner and
>> nfs4_set_delegation.
>>
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>   fs/nfsd/nfs4state.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index a20c2c9d7d45..66a0c76850f3 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -5856,7 +5856,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   
>>   	/*
>>   	 * Now that the deleg is set, check again to ensure that nothing
>> -	 * raced in and changed the mode while we weren't lookng.
>> +	 * raced in and changed the mode while we weren't looking.
>>   	 */
>>   	status = nfsd4_verify_setuid_write(open, fp->fi_deleg_file);
>>   	if (status)
>> @@ -8335,7 +8335,7 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
>>    * @cstate: NFSv4 COMPOUND state
>>    * @u: RELEASE_LOCKOWNER arguments
>>    *
>> - * Check if theree are any locks still held and if not - free the lockowner
>> + * Check if there are any locks still held and if not - free the lockowner
> This is probably better grammatically:
>
>      Check if there are any locks still held and if not, free the lockowner
Thanks for your advice, it does look better.
>>    * and any lock state that is owned.
>>    *
>>    * Return values:


