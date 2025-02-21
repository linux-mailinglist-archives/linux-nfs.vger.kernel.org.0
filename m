Return-Path: <linux-nfs+bounces-10259-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1F9A3F7A2
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 15:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14CAB7A21CE
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62071BD9E3;
	Fri, 21 Feb 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLYP3Yrc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CC2125B9
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149197; cv=none; b=s36/ZFQW2k8S0eOGUBw2gpUMTMf3yrpb9QmyoGQtt4k1siXLVzreuBAz29il3qH2AVB5zkoWE2qUaM3iIbqsLmVVkstghPrws01FDtbOgsKLWJgletfsvPrRF+jgcAG0UXqQ04/AfdLvjBipvRZt61oowpOj2oWlyo4wz0kjss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149197; c=relaxed/simple;
	bh=Rzk5I7Yp7wvQV0AOfohWaQqQLCabVcp8xw8pH5I2ZBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgixE5qayvUKzlmjwfYBA63TXVGkcCjZ/hAG5Fw1UckE75T44eoEq9jBgI8p3dxDHvkKw/h3QkshPcyAk9W0Ldl96yY3eO9xrOuj4GQ7LjctpI5FwDB+SjUr00QsslPOgmmjTnTiZmIz+ITYly0Tvp4KgcKC9rG0bagS7e6nX+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLYP3Yrc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740149194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=emcVIs6BI4Wj62Wj3L/WpukI2UxFVMWsSh2R8GXrlgk=;
	b=VLYP3YrcpMGN8I64BPTSkYElklmeiHzIsmXfQv8QwzUJRVjksByT2UPZ6jcwLyIDs5Q7HN
	dqsHW+JUDXxYd1mWaO2Y+6UWIJ34HYaTZjA1pam2V2KQukCrKtq357xrbIH0eW8okDtTkB
	lsozjSfqSTC2IjWnjeAB9XFJapAN8RU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-QAmZEhKZPCCloI7r4Srw8g-1; Fri,
 21 Feb 2025 09:46:31 -0500
X-MC-Unique: QAmZEhKZPCCloI7r4Srw8g-1
X-Mimecast-MFC-AGG-ID: QAmZEhKZPCCloI7r4Srw8g_1740149189
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3F2018E6952;
	Fri, 21 Feb 2025 14:46:28 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C3AA180087E;
	Fri, 21 Feb 2025 14:46:25 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
 Li Lingfeng <lilingfeng3@huawei.com>, neilb@suse.de, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, houtao1@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng@huaweicloud.com
Subject: Re: [PATCH] nfsd: decrease cl_cb_inflight if fail to queue cb_work
Date: Fri, 21 Feb 2025 09:46:22 -0500
Message-ID: <9272C75B-F102-4D42-9970-DF3D267E0629@redhat.com>
In-Reply-To: <c3f3c740498368905dd4adbabb75ee9e6728730b.camel@kernel.org>
References: <20250218135423.1487309-1-lilingfeng3@huawei.com>
 <0ae8a05272c2eb8a503102788341e1d9c49109dd.camel@kernel.org>
 <04ed0c70b85a1e8b66c25b9ad4d0aa4c2fb91198.camel@kernel.org>
 <9cea3133-d17c-48c5-8eb9-265fbfc5708b@oracle.com>
 <8afc09d0728c4b71397d6b055dc86ab12310c297.camel@kernel.org>
 <C9BBD33C-0077-44B0-BCE9-7E4962428382@redhat.com>
 <c3f3c740498368905dd4adbabb75ee9e6728730b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 21 Feb 2025, at 9:37, Jeff Layton wrote:

> On Fri, 2025-02-21 at 09:06 -0500, Benjamin Coddington wrote:
>> On 18 Feb 2025, at 9:40, Jeff Layton wrote:
>>
>>> On Tue, 2025-02-18 at 09:31 -0500, Chuck Lever wrote:
>>>> On 2/18/25 9:29 AM, Jeff Layton wrote:
>>>>> On Tue, 2025-02-18 at 08:58 -0500, Jeff Layton wrote:
>>>>>> On Tue, 2025-02-18 at 21:54 +0800, Li Lingfeng wrote:
>>>>>>> In nfsd4_run_cb, cl_cb_inflight is increased before attempting to=
 queue
>>>>>>> cb_work to callback_wq. This count can be decreased in three situ=
ations:
>>>>>>> 1) If queuing fails in nfsd4_run_cb, the count will be decremente=
d
>>>>>>> accordingly.
>>>>>>> 2) After cb_work is running, the count is decreased in the except=
ion
>>>>>>> branch of nfsd4_run_cb_work via nfsd41_destroy_cb.
>>>>>>> 3) The count is decreased in the release callback of rpc_task =E2=
=80=94 either
>>>>>>> directly calling nfsd41_cb_inflight_end in nfsd4_cb_probe_release=
, or
>>>>>>> calling nfsd41_destroy_cb in 	.
>>>>>>>
>>>>>>> However, in nfsd4_cb_release, if the current cb_work needs to res=
tart, the
>>>>>>> count will not be decreased, with the expectation that it will be=
 reduced
>>>>>>> once cb_work is running.
>>>>>>> If queuing fails here, then the count will leak, ultimately causi=
ng the
>>>>>>> nfsd service to be unable to exit as shown below:
>>>>>>> [root@nfs_test2 ~]# cat /proc/2271/stack
>>>>>>> [<0>] nfsd4_shutdown_callback+0x22b/0x290
>>>>>>> [<0>] __destroy_client+0x3cd/0x5c0
>>>>>>> [<0>] nfs4_state_destroy_net+0xd2/0x330
>>>>>>> [<0>] nfs4_state_shutdown_net+0x2ad/0x410
>>>>>>> [<0>] nfsd_shutdown_net+0xb7/0x250
>>>>>>> [<0>] nfsd_last_thread+0x15f/0x2a0
>>>>>>> [<0>] nfsd_svc+0x388/0x3f0
>>>>>>> [<0>] write_threads+0x17e/0x2b0
>>>>>>> [<0>] nfsctl_transaction_write+0x91/0xf0
>>>>>>> [<0>] vfs_write+0x1c4/0x750
>>>>>>> [<0>] ksys_write+0xcb/0x170
>>>>>>> [<0>] do_syscall_64+0x70/0x120
>>>>>>> [<0>] entry_SYSCALL_64_after_hwframe+0x78/0xe2
>>>>>>> [root@nfs_test2 ~]#
>>>>>>>
>>>>>>> Fix this by decreasing cl_cb_inflight if the restart fails.
>>>>>>>
>>>>>>> Fixes: cba5f62b1830 ("nfsd: fix callback restarts")
>>>>>>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>>>>>>> ---
>>>>>>>  fs/nfsd/nfs4callback.c | 10 +++++++---
>>>>>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>>>>> index 484077200c5d..8a7d24efdd08 100644
>>>>>>> --- a/fs/nfsd/nfs4callback.c
>>>>>>> +++ b/fs/nfsd/nfs4callback.c
>>>>>>> @@ -1459,12 +1459,16 @@ static void nfsd4_cb_done(struct rpc_task=
 *task, void *calldata)
>>>>>>>  static void nfsd4_cb_release(void *calldata)
>>>>>>>  {
>>>>>>>  	struct nfsd4_callback *cb =3D calldata;
>>>>>>> +	struct nfs4_client *clp =3D cb->cb_clp;
>>>>>>> +	int queued;
>>>>>>>
>>>>>>>  	trace_nfsd_cb_rpc_release(cb->cb_clp);
>>>>>>>
>>>>>>> -	if (cb->cb_need_restart)
>>>>>>> -		nfsd4_queue_cb(cb);
>>>>>>> -	else
>>>>>>> +	if (cb->cb_need_restart) {
>>>>>>> +		queued =3D nfsd4_queue_cb(cb);
>>>>>>> +		if (!queued)
>>>>>>> +			nfsd41_cb_inflight_end(clp);
>>>>>>> +	} else
>>>>>>>  		nfsd41_destroy_cb(cb);
>>>>>>>
>>>>>>>  }
>>>>>>
>>>>>> Good catch!
>>>>>>
>>>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>>>>
>>>>>
>>>>> Actually, I think this is not quite right. It's a bit more subtle t=
han
>>>>> it first appears. The problem of course is that the callback workqu=
eue
>>>>> jobs run in a different task than the RPC workqueue jobs, so they c=
an
>>>>> race.
>>>>>
>>>>> cl_cb_inflight gets bumped when the callback is first queued, and o=
nly
>>>>> gets released in nfsd41_destroy_cb(). If it fails to be queued, it'=
s
>>>>> because something else has queued the workqueue job in the meantime=
=2E
>>>>>
>>>>> There are two places that can occur: nfsd4_cb_release() and
>>>>> nfsd4_run_cb(). Since this is occurring in nfsd4_cb_release(), the =
only
>>>>> other option is that something raced in and queued it via
>>>>> nfsd4_run_cb().
>>>>
>>>> What would be the "something" that raced in?
>>>>
>>>
>>> I think we may be able to get there via multiple __break_lease() call=
s
>>> on the same layout or delegation. That could mean multiple calls to t=
he
>>> ->lm_break operation on the same object.
>>
>> Sorry for the late response, but isn't ->lm_break() already serialized=
 in
>> __break_lease for the same file_lease?  We don't call lm_break(fl) if
>> lease_breaking(fl).
>>
>
> lease_breaking() is only checked when want_write is false. IOW, if
> you're breaking the lease for write, then lm_break is always called.
>
> Is that a bug or a feature? I'm not sure, but it's been that way since
> ~2011.

Yeah.. why?

Thanks I missed that detail when I refreshed my memory of it just now.
Seems like you'd want to avoid constantly calling lm_break for both cases=
,
spamming the lock manager adds nothing.  2 cents.

Ben


