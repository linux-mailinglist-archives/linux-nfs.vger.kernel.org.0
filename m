Return-Path: <linux-nfs+bounces-12122-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B79C6ACEA4D
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 08:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557E93ABDAB
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 06:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA6173451;
	Thu,  5 Jun 2025 06:35:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F881F2C44;
	Thu,  5 Jun 2025 06:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749105355; cv=none; b=Xn0Aotqeuk0ki72UwgFByTutyQeYaXTVj6RL/0EPvVgxMktzLK7WKOFLy/2zRYRXVx1PQk+m/rEC74z2EF7QjMTuiu7V8AmgLHhjMOK1pyV+uF7xLj81WOnChvJuETU7b+3IpmIcOM1sTgaqZxztTltts6dlOszkFDuBPZWynfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749105355; c=relaxed/simple;
	bh=3fVTZQULmeSj1kaoUxmb+CsZJulw3kIUf6Ah34p9Y3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cv5DnIbolo5Dmm6W/LMlIHKdbxim4NMKyPqYO5M32PV/p7A4dOdNrqFm5IdYDixuF2BsVQdtDkFNb3KiKlXrhjL7LafAlDCjY7hJx70fBLaUq1zppcRJYnz055FnpFcKGH7japDS3s4X6LiMJeenJrzDorZKYeap9Uv+FyW25wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bCZR12SLJz13M0N;
	Thu,  5 Jun 2025 14:33:49 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id D9458140203;
	Thu,  5 Jun 2025 14:35:43 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Jun 2025 14:35:42 +0800
Message-ID: <872dcf33-cc7e-48c0-810a-f27b59a603e1@huawei.com>
Date: Thu, 5 Jun 2025 14:35:42 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nfsd: Invoke tracking callbacks only after initialization
 is complete
To: Jeff Layton <jlayton@kernel.org>, <chuck.lever@oracle.com>,
	<neilb@suse.de>, <neil@brown.name>, <okorniev@redhat.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>
References: <20250513074305.3362209-1-lilingfeng3@huawei.com>
 <ae16dcf3d5c569bbff817ca442a7615e816a66e7.camel@kernel.org>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <ae16dcf3d5c569bbff817ca442a7615e816a66e7.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Hi Jeff,

Following our discussion, my colleague Yang Erkun proposed an alternative
solution: using the nfsd_mutex to prevent concurrency between
initialization/destruction and usage of client_tracking_ops.
Both our previous approaches (delayed pointer assignment and the
initialization flag) still leave a window where the issue could occur.
For example, after validating client_tracking_ops as non-NULL but before
invoking its callbacks, the pointer could be set to NULL during teardown.

I've prototyped the nfsd_mutex approach and confirmed it resolves the
problem. What are your thoughts on this solution?

Best regards,
Li Lingfeng

在 2025/5/13 20:34, Jeff Layton 写道:
> On Tue, 2025-05-13 at 15:43 +0800, Li Lingfeng wrote:
>> Checking whether tracking callbacks can be called based on whether
>> nn->client_tracking_ops is NULL may lead to callbacks being invoked
>> before tracking initialization completes, causing resource access
>> violations (UAF, NULL pointer dereference). Examples:
>>
>> 1) nfsd4_client_tracking_init
>>     // set nn->client_tracking_ops
>>     nfsd4_cld_tracking_init
>>      nfs4_cld_state_init
>>       nn->reclaim_str_hashtbl = kmalloc_array
>>      ... // error path, goto err
>>      nfs4_cld_state_shutdown
>>       kfree(nn->reclaim_str_hashtbl)
>>                                        write_v4_end_grace
>>                                         nfsd4_end_grace
>>                                          nfsd4_record_grace_done
>>                                           nfsd4_cld_grace_done
>>                                            nfs4_release_reclaim
>>                                             nn->reclaim_str_hashtbl[i]
>>                                             // UAF
>>     // clear nn->client_tracking_ops
>>
>> 2) nfsd4_client_tracking_init
>>     // set nn->client_tracking_ops
>>     nfsd4_cld_tracking_init
>>                                        write_v4_end_grace
>>                                         nfsd4_end_grace
>>                                          nfsd4_record_grace_done
>>                                           nfsd4_cld_grace_done
>>                                            alloc_cld_upcall
>>                                             cn = nn->cld_net
>>                                             spin_lock // cn->cn_lock
>>                                             // NULL deref
>>     // error path, skip init pipe
>>     __nfsd4_init_cld_pipe
>>      cn = kzalloc
>>      nn->cld_net = cn
>>     // clear nn->client_tracking_ops
>>
>> After nfsd mounts, users can trigger grace_done callbacks via
>> /proc/fs/nfsd/v4_end_grace. If resources are uninitialized or freed
>> in error paths, this causes access violations.
>>
>> Instead of adding locks for specific resources(e.g., reclaim_str_hashtbl),
>> introducing a flag to indicate whether tracking initialization has
>> completed and checking this flag before invoking callbacks may be better.
>>
>> Fixes: 52e19c09a183 ("nfsd: make reclaim_str_hashtbl allocated per net")
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>   fs/nfsd/netns.h       |  1 +
>>   fs/nfsd/nfs4recover.c | 13 +++++++++----
>>   2 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>> index 3e2d0fde80a7..dbd782d6b063 100644
>> --- a/fs/nfsd/netns.h
>> +++ b/fs/nfsd/netns.h
>> @@ -113,6 +113,7 @@ struct nfsd_net {
>>   
>>   	struct file *rec_file;
>>   	bool in_grace;
>> +	bool client_tracking_init_done;
>>   	const struct nfsd4_client_tracking_ops *client_tracking_ops;
>>   
>>   	time64_t nfsd4_lease;
>> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
>> index c1d9bd07285f..6c27c1252c0e 100644
>> --- a/fs/nfsd/nfs4recover.c
>> +++ b/fs/nfsd/nfs4recover.c
>> @@ -2096,7 +2096,11 @@ nfsd4_client_tracking_init(struct net *net)
>>   		pr_warn("NFSD: Unable to initialize client recovery tracking! (%d)\n", status);
>>   		pr_warn("NFSD: Is nfsdcld running? If not, enable CONFIG_NFSD_LEGACY_CLIENT_TRACKING.\n");
>>   		nn->client_tracking_ops = NULL;
>> +		nn->client_tracking_init_done = false;
>> +	} else {
>> +		nn->client_tracking_init_done = true;
>>   	}
>> +
> The problem seems real (theoretically at least), but I'm not a fan of
> this fix.
>
> If the problem is as you say, then why not just delay the setting of
> the client_tracking_ops until there is a method that works. IOW, set a
> temporary variable with an ops pointer and only assign
> client_tracking_ops at the end of the function/
>
> Would that also fix this issue?
>   
>>   	return status;
>>   }
>>   
>> @@ -2105,6 +2109,7 @@ nfsd4_client_tracking_exit(struct net *net)
>>   {
>>   	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>   
>> +	nn->client_tracking_init_done = false;
>>   	if (nn->client_tracking_ops) {
>>   		if (nn->client_tracking_ops->exit)
>>   			nn->client_tracking_ops->exit(net);
>> @@ -2117,7 +2122,7 @@ nfsd4_client_record_create(struct nfs4_client *clp)
>>   {
>>   	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>>   
>> -	if (nn->client_tracking_ops)
>> +	if (nn->client_tracking_ops && nn->client_tracking_init_done)
>>   		nn->client_tracking_ops->create(clp);
>>   }
>>   
>> @@ -2126,7 +2131,7 @@ nfsd4_client_record_remove(struct nfs4_client *clp)
>>   {
>>   	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>>   
>> -	if (nn->client_tracking_ops)
>> +	if (nn->client_tracking_ops && nn->client_tracking_init_done)
>>   		nn->client_tracking_ops->remove(clp);
>>   }
>>   
>> @@ -2135,7 +2140,7 @@ nfsd4_client_record_check(struct nfs4_client *clp)
>>   {
>>   	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>>   
>> -	if (nn->client_tracking_ops)
>> +	if (nn->client_tracking_ops && nn->client_tracking_init_done)
>>   		return nn->client_tracking_ops->check(clp);
>>   
>>   	return -EOPNOTSUPP;
>> @@ -2144,7 +2149,7 @@ nfsd4_client_record_check(struct nfs4_client *clp)
>>   void
>>   nfsd4_record_grace_done(struct nfsd_net *nn)
>>   {
>> -	if (nn->client_tracking_ops)
>> +	if (nn->client_tracking_ops && nn->client_tracking_init_done)
>>   		nn->client_tracking_ops->grace_done(nn);
>>   }
>>   

