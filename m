Return-Path: <linux-nfs+bounces-10587-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFD4A5F609
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 14:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5BF3A8A20
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 13:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFCC267735;
	Thu, 13 Mar 2025 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdNVAvns"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40D7266B74
	for <linux-nfs@vger.kernel.org>; Thu, 13 Mar 2025 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872931; cv=none; b=I6fz0HD8PLldZAxuVQ3/oIqwnR7bWQqKs35CY/r/UDyWnE2tu5UNU0Rfso7ccR/RJ/gDILHpJX6pSCF2vXW0BAlsu9a7rg4exKrdWtQXXwywdTErLONWJy8hVVbeEqQl/0nPpFnSLt2Ouq9l9fXbZ1Yya/I4ISprybTs4xO5cYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872931; c=relaxed/simple;
	bh=GSvuKDn6GvEj4StlyA9y4pE71cNqRY2cL2gZwvYxJgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tL9oaBh/gbbbHxvQIALTS44x0FskGegb1LJxpmaD6v4nDTOi8EGT+ANZ7HEZjPKO6XZgKI33L9aCBIzFlNHFqCJRovBPwKkYzI478XmvAz0smo7Sz08e5WT4fbSzbRdEizQcBUXagA3/SFNa6rv1fTXDjSKlVffH2sKnAJZevlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HdNVAvns; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741872927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cJptmV2ov9F43XWgGQgvpiN+Bxm0Brgya5E5ifNGox0=;
	b=HdNVAvnsqLVcILKjBBf7hvbvENUnPnfXFkB3E+H82Fq/nb0PUGh6vLXKvcHHHr1iY0CCBT
	vvYhfB55wRYY2mNzL/dMgQBhMdomP2nrElK94bynj4x6Gl1/NsTk7k6F4jwime4j3+n/WK
	XwP/Hosiz4XshEI7dhW6Z6t6wPwpxPE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-KGjL1ptYNkWWD2Vs9RyrpA-1; Thu,
 13 Mar 2025 09:35:22 -0400
X-MC-Unique: KGjL1ptYNkWWD2Vs9RyrpA-1
X-Mimecast-MFC-AGG-ID: KGjL1ptYNkWWD2Vs9RyrpA_1741872921
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E903D180AF59;
	Thu, 13 Mar 2025 13:35:20 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.7])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8464F1828AA7;
	Thu, 13 Mar 2025 13:35:19 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@hammerspace.com>, anna@kernel.org,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunrpc: add a rpc_clnt shutdown control in debugfs
Date: Thu, 13 Mar 2025 09:35:17 -0400
Message-ID: <0E1E14E2-BD4B-433B-8355-EEF45384BE83@redhat.com>
In-Reply-To: <ee74d5920532d81f77e503d6ef8bc5fbfc66d04e.camel@kernel.org>
References: <20250312-rpc-shutdown-v1-1-cc90d79a71c2@kernel.org>
 <7906109F-91D2-4ECF-B868-5519B56D2CEE@redhat.com>
 <997f992f951bd235953c5f0e2959da6351a65adb.camel@kernel.org>
 <8bf55a6fb64ba9e21a1ec8c5644355ffd6496c6e.camel@hammerspace.com>
 <ee74d5920532d81f77e503d6ef8bc5fbfc66d04e.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 13 Mar 2025, at 9:15, Jeff Layton wrote:

> On Wed, 2025-03-12 at 22:31 +0000, Trond Myklebust wrote:
>> On Wed, 2025-03-12 at 10:37 -0400, Jeff Layton wrote:
>>> On Wed, 2025-03-12 at 09:52 -0400, Benjamin Coddington wrote:
>>>> On 12 Mar 2025, at 9:36, Jeff Layton wrote:
>>>>
>>>>> There have been confirmed reports where a container with an NFS
>>>>> mount
>>>>> inside it dies abruptly, along with all of its processes, but the
>>>>> NFS
>>>>> client sticks around and keeps trying to send RPCs after the
>>>>> networking
>>>>> is gone.
>>>>>
>>>>> We have a reproducer where if we SIGKILL a container with an NFS
>>>>> mount,
>>>>> the RPC clients will stick around indefinitely. The orchestrator
>>>>> does a MNT_DETACH unmount on the NFS mount, and then tears down
>>>>> the
>>>>> networking while there are still RPCs in flight.
>>>>>
>>>>> Recently new controls were added[1] that allow shutting down an
>>>>> NFS
>>>>> mount. That doesn't help here since the mount namespace is
>>>>> detached from
>>>>> any tasks at this point.
>>>>
>>>> That's interesting - seems like the orchestrator could just reorder
>>>> its
>>>> request to shutdown before detaching the mount namespace.  Not an
>>>> objection,
>>>> just wondering why the MNT_DETACH must come first.
>>>>
>>>
>>> The reproducer we have is to systemd-nspawn a container, mount up an
>>> NFS mount inside it, start some I/O on it with fio and then kill -9
>>> the
>>> systemd running inside the container. There isn't much the
>>> orchestrator
>>> (root-level systemd) can do to at that point other than clean up
>>> what's
>>> left.
>>>
>>> I'm still working on a way to reliably detect when this has happened.
>>> For now, we just have to notice that some clients aren't dying.
>>>
>>>>> Transplant shutdown_client() to the sunrpc module, and give it a
>>>>> more
>>>>> distinct name. Add a new debugfs sunrpc/rpc_clnt/*/shutdown knob
>>>>> that
>>>>> allows the same functionality as the one in /sys/fs/nfs, but at
>>>>> the
>>>>> rpc_clnt level.
>>>>>
>>>>> [1]: commit d9615d166c7e ("NFS: add sysfs shutdown knob").
>>>>>
>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>
>>>> I have a TODO to patch Documentation/ for this knob mostly to write
>>>> warnings
>>>> because there are some potential "gotchas" here - for example you
>>>> can have
>>>> shared RPC clients and shutting down one of those can cause
>>>> problems for a
>>>> different mount (this is true today with the
>>>> /sys/fs/nfs/[bdi]/shutdown
>>>> knob).  Shutting down aribitrary clients will definitely break
>>>> things in
>>>> weird ways, its not a safe place to explore.
>>>>
>>>
>>> Yes, you really do need to know what you're doing. 0200 permissions
>>> are
>>> essential for this file, IOW. Thanks for the R-b!
>>
>> Sorry, but NACK! We should not be adding control mechanisms to debugfs.
>>
>
> Ok. Would adding sunrpc controls under sysfs be more acceptable? I do
> agree that this is a potential footgun, however. It would be nicer to
> clean this situation up automagically.
>
>> One thing that might work in situations like this is perhaps to make
>> use of the fact that we are monitoring whether or not rpc_pipefs is
>> mounted. So if the mount is containerised, and the orchestrator
>> unmounts everything, including rpc_pipefs, we might take that as a hint
>> that we should treat any future connection errors as being fatal.
>>
>
> rpc_pipefs isn't being mounted at all in the container I'm using. I
> think that's not going to be a reliable test for this.
>
>> Otherwise, we'd have to be able to monitor the root task, and check if
>> it is still alive in order to figure out if out containerised world has
>> collapsed.
>>
>
> If by the root task, you mean the initial task in the container, then
> that method seems a little sketchy too. How would we determine that
> from the RPC layer?
>
> To be clear: the situation here is that we have a container with a veth
> device that is communicating with the outside world. Once all of the
> processes in the container exit, the veth device in the container
> disappears. The rpc_xprt holds a ref on the netns though, so that
> sticks around trying to retransmit indefinitely.
>
> I think what we really need is a lightweight reference on the netns.
> Something where we can tell that there are no userland tasks that care
> about it anymore, so we can be more aggressive about giving up on it.
>
> There is a "passive" refcount inside struct net, but that's not quite
> what we need as it won't keep the sunrpc_net in place.
>
> What if instead of holding a netns reference in the xprt, we have it
> hold a reference on a new refcount_t that lives in sunrpc_net? Then, we
> add a pre_exit pernet_ops callback that does a shutdown_client() on all
> of the rpc_clnt's attached to the xprts in that netns. The pre_exit can
> then just block until the sunrpc_net refcount goes to 0.
>
> I think that would allow everything to be cleaned up properly?

Do you think that might create unwanted behaviors for a netns that might
still be repairable?   Maybe that doesn't make a lot of sense if there are no
processes in it, but I imagine a network namespace could be in this state
and we'd still want to try to use it.

I think there's an out-of-kernel (haven't tried yet) way to do it with udev,
which, if used, creates an explicit requirement for the orchestrator to
define exactly what should happen if the veth goes away.  When creating the
namespace, the orchestrator should insert a rule that says "when this veth
disappears, we shutdown this fs".

Again, I'm not sure if that's even possible, but I'm willing to muck around
a bit and give it a try.

Ben


