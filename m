Return-Path: <linux-nfs+bounces-11712-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BC2AB63B5
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 09:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A63617A7EC
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 07:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CDC20A5DD;
	Wed, 14 May 2025 07:04:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FA1202F79;
	Wed, 14 May 2025 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747206267; cv=none; b=aKysv6G49xg/mh/3YO/rBxcx4A39LpA/yaBvepwbnJxp+clR4ndd52ZolTNOoM8nmfuAMKhQq1mZjosPx47Spv3GRJKtzF4ZkOPb7jSwFDgVwLmx0qYcVk/57h7ScOd1ud3Cc9f70vdc6zPXawHUi7Y3eXUeNo88dx2TAbvJWGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747206267; c=relaxed/simple;
	bh=VbuRVZHdPQlbpcGl9tKCf1Nv91DLSPKdy2wEglHl3bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BU40UrtrRfjZvwu4ijdXA9WvL3J/qYb9LoNdS32qSgk5utT0cAI6z1ErecP26/tWw23heXflK3cGNEU80v+Gp8u7Zkv4NaX7LE0scmk5lstHwTa6+8KEah/vgTXgKmdL+Q1EjlxKKbR5tBJA0VNYmMG6E62bB7lyO5I9h/dYLlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Zy44308z8z1Z1Yd;
	Wed, 14 May 2025 15:00:35 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id ECB511402E2;
	Wed, 14 May 2025 15:04:13 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 14 May 2025 15:04:13 +0800
Message-ID: <eafac8bf-009c-402a-a9a7-d8881100f3ca@huawei.com>
Date: Wed, 14 May 2025 15:04:12 +0800
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
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Hi Jeff,

Thank you for the review.

Delaying the assignment of client_tracking_ops until after initialization
completes successfully would indeed avoid the race condition without
needing an additional flag.
My initial choice to add client_tracking_init_done was motivated by
minimizing changes to existing code paths. Since client_tracking_ops is
checked in multiple callback functions, altering its assignment logic
would require auditing all references. The flag allowed a localized fix
without restructuring the initialization sequence.

I'll try to rework the patch to use a temporary variable for the ops during
initialization and only assign it to nn->client_tracking_ops once all setup
steps are confirmed successful. This should ensure that no callbacks are
invoked prematurely.

Lingfeng.

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

