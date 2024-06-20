Return-Path: <linux-nfs+bounces-4165-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FD0910D6F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 18:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1C61F2173B
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 16:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF364156256;
	Thu, 20 Jun 2024 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFeEkL4R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328601AD4B9
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901990; cv=none; b=joeXkRoS0LM3zvbShQN9Kxuss4vKtzIutbMJxZ5pyTuM1ec5/Lf+GMnumBCT6aWiWz/6vO8Sa2QFcK4NnIbiVfr7Fu1BGjRDDYiA2zU8M+EL6s7tn3Kbp/ADirSMrtfLZxCdE4pjOQg+fNi6qZ45denW94jP83K5FAJAWWRENwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901990; c=relaxed/simple;
	bh=Iqdc18b71yd5rfjyx56KwNBcDaAUJPsAUoWlzT0kB9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNbgcz71NOkbF0uXg5J6H/e3eg1rJqQeVbfSQhBjkJ0bgKhoye6Q0inbcUYWGfAU/6LsIvy2yXwhK1J+kGPjVdUxHU67CJeByTR76KWCleQ8zWadcrl2NtYnuT+jeF/EmZbhz6qpFgCX/udC+t0k5Jk79G2x/CKDFX2LDe/N+mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JFeEkL4R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718901987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qykFAtq5iH1tdtpzJH/2DdAmc8C4INcfqisdlnxgLzo=;
	b=JFeEkL4Rq78ZK553Tn6gkA8cv9sGHLYR6QIF3O2HINWHl0HyzdBcGm7sBGFCaP7bs+wXXp
	BQCwrD4XaGlqbmR9SJN2E5LfKumG8OMQY5zLduGv8X9II3aPDVOcfJ7aRpnPDWgZlycCFg
	YguJZSIDEFEqA7y/5TQhJVvlYff13QU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-TNLXNZvtP66G4Z2_JUPCYg-1; Thu,
 20 Jun 2024 12:46:24 -0400
X-MC-Unique: TNLXNZvtP66G4Z2_JUPCYg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68FAC195DE3B;
	Thu, 20 Jun 2024 16:46:18 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAC5E3011D27;
	Thu, 20 Jun 2024 16:45:58 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 3/4] nfs/blocklayout: Fix premature PR key
 unregistration
Date: Thu, 20 Jun 2024 12:45:56 -0400
Message-ID: <3590D3CB-E9C3-4C78-8077-7458F9E6C966@redhat.com>
In-Reply-To: <762051B8-1265-42BA-8002-B4BD4E117488@redhat.com>
References: <20240619173929.177818-6-cel@kernel.org>
 <20240619173929.177818-9-cel@kernel.org>
 <D3359408-4D02-415A-9557-19A6EFE5DDCE@redhat.com>
 <ZnQ927sF7oRT+KmF@tissot.1015granger.net>
 <F421047C-FACF-46EF-9169-07C8FF5FCF3A@redhat.com>
 <ZnRO8BA/TlQjpCmg@tissot.1015granger.net>
 <762051B8-1265-42BA-8002-B4BD4E117488@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 20 Jun 2024, at 11:56, Benjamin Coddington wrote:

> On 20 Jun 2024, at 11:46, Chuck Lever wrote:
>
>> On Thu, Jun 20, 2024 at 11:30:54AM -0400, Benjamin Coddington wrote:
>>> On 20 Jun 2024, at 10:34, Chuck Lever wrote:
>>>
>>>> On Thu, Jun 20, 2024 at 09:51:46AM -0400, Benjamin Coddington wrote:=

>>>>> On 19 Jun 2024, at 13:39, cel@kernel.org wrote:
>>>>>
>>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>>>
>>>>>> During generic/069 runs with pNFS SCSI layouts, the NFS client emi=
ts
>>>>>> the following in the system journal:
>>>>>>
>>>>>> kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-=
0x6001405e3366f045b7949eb8e4540b51 (-2)
>>>>>> kernel: pNFS: using block device sdb (reservation key 0x666b60901e=
7b26b3)
>>>>>> kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-=
0x6001405e3366f045b7949eb8e4540b51 (-2)
>>>>>> kernel: pNFS: using block device sdb (reservation key 0x666b60901e=
7b26b3)
>>>>>> kernel: sd 6:0:0:1: reservation conflict
>>>>>> kernel: sd 6:0:0:1: [sdb] tag#16 FAILED Result: hostbyte=3DDID_OK =
driverbyte=3DDRIVER_OK cmd_age=3D0s
>>>>>> kernel: sd 6:0:0:1: [sdb] tag#16 CDB: Write(10) 2a 00 00 00 00 50 =
00 00 08 00
>>>>>> kernel: reservation conflict error, dev sdb, sector 80 op 0x1:(WRI=
TE) flags 0x0 phys_seg 1 prio class 2
>>>>>> kernel: sd 6:0:0:1: reservation conflict
>>>>>> kernel: sd 6:0:0:1: reservation conflict
>>>>>> kernel: sd 6:0:0:1: [sdb] tag#18 FAILED Result: hostbyte=3DDID_OK =
driverbyte=3DDRIVER_OK cmd_age=3D0s
>>>>>> kernel: sd 6:0:0:1: [sdb] tag#17 FAILED Result: hostbyte=3DDID_OK =
driverbyte=3DDRIVER_OK cmd_age=3D0s
>>>>>> kernel: sd 6:0:0:1: [sdb] tag#18 CDB: Write(10) 2a 00 00 00 00 60 =
00 00 08 00
>>>>>> kernel: sd 6:0:0:1: [sdb] tag#17 CDB: Write(10) 2a 00 00 00 00 58 =
00 00 08 00
>>>>>> kernel: reservation conflict error, dev sdb, sector 96 op 0x1:(WRI=
TE) flags 0x0 phys_seg 1 prio class 0
>>>>>> kernel: reservation conflict error, dev sdb, sector 88 op 0x1:(WRI=
TE) flags 0x0 phys_seg 1 prio class 0
>>>>>> systemd[1]: fstests-generic-069.scope: Deactivated successfully.
>>>>>> systemd[1]: fstests-generic-069.scope: Consumed 5.092s CPU time.
>>>>>> systemd[1]: media-test.mount: Deactivated successfully.
>>>>>> systemd[1]: media-scratch.mount: Deactivated successfully.
>>>>>> kernel: sd 6:0:0:1: reservation conflict
>>>>>> kernel: failed to unregister PR key.
>>>>>>
>>>>>> This appears to be due to a race. bl_alloc_lseg() calls this:
>>>>>>
>>>>>> 561 static struct nfs4_deviceid_node *
>>>>>> 562 bl_find_get_deviceid(struct nfs_server *server,
>>>>>> 563                 const struct nfs4_deviceid *id, const struct c=
red *cred,
>>>>>> 564                 gfp_t gfp_mask)
>>>>>> 565 {
>>>>>> 566         struct nfs4_deviceid_node *node;
>>>>>> 567         unsigned long start, end;
>>>>>> 568
>>>>>> 569 retry:
>>>>>> 570         node =3D nfs4_find_get_deviceid(server, id, cred, gfp_=
mask);
>>>>>> 571         if (!node)
>>>>>> 572                 return ERR_PTR(-ENODEV);
>>>>>>
>>>>>> nfs4_find_get_deviceid() does a lookup without the spin lock first=
=2E
>>>>>> If it can't find a matching deviceid, it creates a new device_info=

>>>>>> (which calls bl_alloc_deviceid_node, and that registers the device=
's
>>>>>> PR key).
>>>>>>
>>>>>> Then it takes the nfs4_deviceid_lock and looks up the deviceid aga=
in.
>>>>>> If it finds it this time, bl_find_get_deviceid() frees the spare
>>>>>> (new) device_info, which unregisters the PR key for the same devic=
e.
>>>>>>
>>>>>> Any subsequent I/O from this client on that device gets EBADE.
>>>>>>
>>>>>> The umount later unregisters the device's PR key again.
>>>>>>
>>>>>> To prevent this problem, register the PR key after the deviceid_no=
de
>>>>>> lookup.
>>>>>
>>>>> Hi Chuck - nice catch, but I'm not seeing how we don't have the sam=
e problem
>>>>> after this patch, instead it just seems like it moves the race.  Wh=
at
>>>>> prevents another process waiting to take the nfs4_deviceid_lock fro=
m
>>>>> unregistering the same device?  I think we need another way to sign=
al
>>>>> bl_free_device that we don't want to unregister for the case where =
the new
>>>>> device isn't added to nfs4_deviceid_cache.
>>>>
>>>> That's a (related but) somewhat different issue. I haven't seen
>>>> that in practice so far.
>>>>
>>>>
>>>>> No good ideas yet - maybe we can use a flag set within the
>>>>> nfs4_deviceid_lock?
>>>>
>>>> Well this smells like a use for a reference count on the block
>>>> device, but fs/nfs doesn't control the definition of that data
>>>> structure.
>>>
>>> I think we need two things to fix this race:
>>>  - a way to determine if the current thread is the one
>>>    that added the device to the to the cache, if so do the register
>>>  - a way to determine if we're freeing because we lost the race to th=
e
>>>    cache, if so don't un-register.
>>
>> My patch is supposed to deal with all of that already. Can you show
>> me specifically what is not getting handled by my proposed change?
>
> Well - I may be missing something, but it looks like with this patch yo=
u can
> still have:
>
> Thread
> A                           B
>
> nfs4_find_get_deviceid
> new{a} =3D nfs4_get_device_info
> locks nfs4_deviceid_lock
>                             nfs4_find_get_deviceid
>                             new{b} =3D nfs4_get_device_info
>                             spins on nfs4_deviceid_lock
> adds new{a} to the cache
> unlocks nfs4_deviceid_lock
> pr_register
>                             locks nfs4_deviceid_lock
>                             finds new{a}
>                             pr_UNregisters new{b}
>
> In this case, you end up with an unregistered device.

Oh jeez Chuck, nevermind - I am missing something, that we check the the
new{b} pnfs_block_dev->pr_registred before unregistering it.

So, actually - I think this patch does solve the problem.  I apologize fo=
r
the noise here.

Ben


