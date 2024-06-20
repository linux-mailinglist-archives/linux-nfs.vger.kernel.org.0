Return-Path: <linux-nfs+bounces-4161-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DC9910AC9
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 17:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EE4AB20E54
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 15:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63F21AF695;
	Thu, 20 Jun 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFocArfe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66D11AC434
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899010; cv=none; b=Z9PKM+OuTs8FEj24z3BM6ctba9pfJoNMVOsCaO6StoI8GkaNrj32uk69tPuPh3i/Tq1W8gxHbkmDUkA8IlfO5Aqs+MBjDOmZ6AZGmzEFwrKBfN7e2D2VqZ/6lOneYkElFqYEqJLXZaO0z2jrzMRKoVd+AVdm0d1gOazUidpf2BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899010; c=relaxed/simple;
	bh=aHi6OmfkTsHezCoU0Gj0KPOqnjw29YfrvBBNCV+3NmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aeZVJ/NKadHZ6b01DPZ9hhDNsQmMOShnI37L2QKhZHGWoGZ/MRmLYzvP3lTpf22YH7Zlw97nhs9AGJ02y0j7bxMKIe/VFLQpzR5IR+oCI/FDFiSivXH5yciik6XYJYUWDIQcThmQE1HzbwW7eTg9nslRu/Cgohadrde68NsGKPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFocArfe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718899006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ryBjQ3KbauIQRaZR/uu2JvKcP418b30GTLVgqjPSDO4=;
	b=KFocArfebTlCGyEZe9gJSZpSMRcg/lShMuytUz0ysZBByEqNqO+srs649xuUld1bxtE/V/
	eGkf1fteausRGBjPWCZffvGcGjDhSJ+3+tqoqL3bj7h9AhYEZaN0iUo8wQ8TuC1lWVXGm4
	2BSQMyV42I4THRfUXeorh146YZnIqEQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-IxKtbnN1MJOvXkF0fEYoLA-1; Thu,
 20 Jun 2024 11:56:45 -0400
X-MC-Unique: IxKtbnN1MJOvXkF0fEYoLA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37B421956053;
	Thu, 20 Jun 2024 15:56:44 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44B333000218;
	Thu, 20 Jun 2024 15:56:42 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 3/4] nfs/blocklayout: Fix premature PR key
 unregistration
Date: Thu, 20 Jun 2024 11:56:40 -0400
Message-ID: <762051B8-1265-42BA-8002-B4BD4E117488@redhat.com>
In-Reply-To: <ZnRO8BA/TlQjpCmg@tissot.1015granger.net>
References: <20240619173929.177818-6-cel@kernel.org>
 <20240619173929.177818-9-cel@kernel.org>
 <D3359408-4D02-415A-9557-19A6EFE5DDCE@redhat.com>
 <ZnQ927sF7oRT+KmF@tissot.1015granger.net>
 <F421047C-FACF-46EF-9169-07C8FF5FCF3A@redhat.com>
 <ZnRO8BA/TlQjpCmg@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 20 Jun 2024, at 11:46, Chuck Lever wrote:

> On Thu, Jun 20, 2024 at 11:30:54AM -0400, Benjamin Coddington wrote:
>> On 20 Jun 2024, at 10:34, Chuck Lever wrote:
>>
>>> On Thu, Jun 20, 2024 at 09:51:46AM -0400, Benjamin Coddington wrote:
>>>> On 19 Jun 2024, at 13:39, cel@kernel.org wrote:
>>>>
>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>>
>>>>> During generic/069 runs with pNFS SCSI layouts, the NFS client emit=
s
>>>>> the following in the system journal:
>>>>>
>>>>> kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0=
x6001405e3366f045b7949eb8e4540b51 (-2)
>>>>> kernel: pNFS: using block device sdb (reservation key 0x666b60901e7=
b26b3)
>>>>> kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0=
x6001405e3366f045b7949eb8e4540b51 (-2)
>>>>> kernel: pNFS: using block device sdb (reservation key 0x666b60901e7=
b26b3)
>>>>> kernel: sd 6:0:0:1: reservation conflict
>>>>> kernel: sd 6:0:0:1: [sdb] tag#16 FAILED Result: hostbyte=3DDID_OK d=
riverbyte=3DDRIVER_OK cmd_age=3D0s
>>>>> kernel: sd 6:0:0:1: [sdb] tag#16 CDB: Write(10) 2a 00 00 00 00 50 0=
0 00 08 00
>>>>> kernel: reservation conflict error, dev sdb, sector 80 op 0x1:(WRIT=
E) flags 0x0 phys_seg 1 prio class 2
>>>>> kernel: sd 6:0:0:1: reservation conflict
>>>>> kernel: sd 6:0:0:1: reservation conflict
>>>>> kernel: sd 6:0:0:1: [sdb] tag#18 FAILED Result: hostbyte=3DDID_OK d=
riverbyte=3DDRIVER_OK cmd_age=3D0s
>>>>> kernel: sd 6:0:0:1: [sdb] tag#17 FAILED Result: hostbyte=3DDID_OK d=
riverbyte=3DDRIVER_OK cmd_age=3D0s
>>>>> kernel: sd 6:0:0:1: [sdb] tag#18 CDB: Write(10) 2a 00 00 00 00 60 0=
0 00 08 00
>>>>> kernel: sd 6:0:0:1: [sdb] tag#17 CDB: Write(10) 2a 00 00 00 00 58 0=
0 00 08 00
>>>>> kernel: reservation conflict error, dev sdb, sector 96 op 0x1:(WRIT=
E) flags 0x0 phys_seg 1 prio class 0
>>>>> kernel: reservation conflict error, dev sdb, sector 88 op 0x1:(WRIT=
E) flags 0x0 phys_seg 1 prio class 0
>>>>> systemd[1]: fstests-generic-069.scope: Deactivated successfully.
>>>>> systemd[1]: fstests-generic-069.scope: Consumed 5.092s CPU time.
>>>>> systemd[1]: media-test.mount: Deactivated successfully.
>>>>> systemd[1]: media-scratch.mount: Deactivated successfully.
>>>>> kernel: sd 6:0:0:1: reservation conflict
>>>>> kernel: failed to unregister PR key.
>>>>>
>>>>> This appears to be due to a race. bl_alloc_lseg() calls this:
>>>>>
>>>>> 561 static struct nfs4_deviceid_node *
>>>>> 562 bl_find_get_deviceid(struct nfs_server *server,
>>>>> 563                 const struct nfs4_deviceid *id, const struct cr=
ed *cred,
>>>>> 564                 gfp_t gfp_mask)
>>>>> 565 {
>>>>> 566         struct nfs4_deviceid_node *node;
>>>>> 567         unsigned long start, end;
>>>>> 568
>>>>> 569 retry:
>>>>> 570         node =3D nfs4_find_get_deviceid(server, id, cred, gfp_m=
ask);
>>>>> 571         if (!node)
>>>>> 572                 return ERR_PTR(-ENODEV);
>>>>>
>>>>> nfs4_find_get_deviceid() does a lookup without the spin lock first.=

>>>>> If it can't find a matching deviceid, it creates a new device_info
>>>>> (which calls bl_alloc_deviceid_node, and that registers the device'=
s
>>>>> PR key).
>>>>>
>>>>> Then it takes the nfs4_deviceid_lock and looks up the deviceid agai=
n.
>>>>> If it finds it this time, bl_find_get_deviceid() frees the spare
>>>>> (new) device_info, which unregisters the PR key for the same device=
=2E
>>>>>
>>>>> Any subsequent I/O from this client on that device gets EBADE.
>>>>>
>>>>> The umount later unregisters the device's PR key again.
>>>>>
>>>>> To prevent this problem, register the PR key after the deviceid_nod=
e
>>>>> lookup.
>>>>
>>>> Hi Chuck - nice catch, but I'm not seeing how we don't have the same=
 problem
>>>> after this patch, instead it just seems like it moves the race.  Wha=
t
>>>> prevents another process waiting to take the nfs4_deviceid_lock from=

>>>> unregistering the same device?  I think we need another way to signa=
l
>>>> bl_free_device that we don't want to unregister for the case where t=
he new
>>>> device isn't added to nfs4_deviceid_cache.
>>>
>>> That's a (related but) somewhat different issue. I haven't seen
>>> that in practice so far.
>>>
>>>
>>>> No good ideas yet - maybe we can use a flag set within the
>>>> nfs4_deviceid_lock?
>>>
>>> Well this smells like a use for a reference count on the block
>>> device, but fs/nfs doesn't control the definition of that data
>>> structure.
>>
>> I think we need two things to fix this race:
>>  - a way to determine if the current thread is the one
>>    that added the device to the to the cache, if so do the register
>>  - a way to determine if we're freeing because we lost the race to the=

>>    cache, if so don't un-register.
>
> My patch is supposed to deal with all of that already. Can you show
> me specifically what is not getting handled by my proposed change?

Well - I may be missing something, but it looks like with this patch you =
can
still have:

Thread
A                           B

nfs4_find_get_deviceid
new{a} =3D nfs4_get_device_info
locks nfs4_deviceid_lock
                            nfs4_find_get_deviceid
                            new{b} =3D nfs4_get_device_info
                            spins on nfs4_deviceid_lock
adds new{a} to the cache
unlocks nfs4_deviceid_lock
pr_register
                            locks nfs4_deviceid_lock
                            finds new{a}
                            pr_UNregisters new{b}

In this case, you end up with an unregistered device.


Also, you can have more than one thread doing the initial pr_register, bu=
t I
think as we've already discussed that's no big deal - it should be rare a=
nd
I don't think it returns an error.

Ben


