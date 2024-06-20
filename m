Return-Path: <linux-nfs+bounces-4156-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3823E9109E3
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 17:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C741F25B23
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 15:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEA51AED31;
	Thu, 20 Jun 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoggQmQJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985421E52F
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897472; cv=none; b=uJZSSUMAPe8YKPFGE7UPdo3cbDT8jfYuq+Uo3lq4te3ujKosBufY1kIBU3j9z/Z30RRm/o0sSxu4jiMzvcq9vKjNTqtE3++PkWPazwTwaN8aV+9kv/iIycNF9uh95cgzhu82UM7sorwxuKhj0YhkG1wLBP53f28EBBew38SyJ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897472; c=relaxed/simple;
	bh=bCGJ9Amjn0RgkGB+XAK6OsTGvBbqR3ojTqLqkM5F7q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKTDRmsWCoa+bB+fS+0rFxKkZbk5BIFL7BxlEXNZ6o0kyegjAgFUa++7p2nA59uhy1H4tdiwPF9kATtsGv04SZJJNybq7G+4vVEkq3ctEnvAkKBF07WP15bRHUFCkA4Wo1z8apSx+rAtxCgp4kEJuXh1NNj12TanhGtnlMGIozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OoggQmQJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718897469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3OW6IFe29wCE7xsPoB6QKQiz1wisti5Q7h/doO7XFc=;
	b=OoggQmQJxl2I0M2WZiJhaZY9styYnC8N8OmcmvX6Cyl3Ntm5TYYfcNuprUCsY0RX9HUyO+
	abo8swewgcSpY1qeG8QVdsZzD7V/5pioWJNOe24uOcmjecVOaQiStkV5NBo8u+BSrUUFTa
	gKnJA4TE5EMQNpJXABOYOik6BtiU+v0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-88Oq1foQNPKQvElHwPladw-1; Thu,
 20 Jun 2024 11:31:05 -0400
X-MC-Unique: 88Oq1foQNPKQvElHwPladw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A45A1956087;
	Thu, 20 Jun 2024 15:31:04 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D3543001D1F;
	Thu, 20 Jun 2024 15:30:57 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 3/4] nfs/blocklayout: Fix premature PR key
 unregistration
Date: Thu, 20 Jun 2024 11:30:54 -0400
Message-ID: <F421047C-FACF-46EF-9169-07C8FF5FCF3A@redhat.com>
In-Reply-To: <ZnQ927sF7oRT+KmF@tissot.1015granger.net>
References: <20240619173929.177818-6-cel@kernel.org>
 <20240619173929.177818-9-cel@kernel.org>
 <D3359408-4D02-415A-9557-19A6EFE5DDCE@redhat.com>
 <ZnQ927sF7oRT+KmF@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 20 Jun 2024, at 10:34, Chuck Lever wrote:

> On Thu, Jun 20, 2024 at 09:51:46AM -0400, Benjamin Coddington wrote:
>> On 19 Jun 2024, at 13:39, cel@kernel.org wrote:
>>
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> During generic/069 runs with pNFS SCSI layouts, the NFS client emits
>>> the following in the system journal:
>>>
>>> kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0x6=
001405e3366f045b7949eb8e4540b51 (-2)
>>> kernel: pNFS: using block device sdb (reservation key 0x666b60901e7b2=
6b3)
>>> kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0x6=
001405e3366f045b7949eb8e4540b51 (-2)
>>> kernel: pNFS: using block device sdb (reservation key 0x666b60901e7b2=
6b3)
>>> kernel: sd 6:0:0:1: reservation conflict
>>> kernel: sd 6:0:0:1: [sdb] tag#16 FAILED Result: hostbyte=3DDID_OK dri=
verbyte=3DDRIVER_OK cmd_age=3D0s
>>> kernel: sd 6:0:0:1: [sdb] tag#16 CDB: Write(10) 2a 00 00 00 00 50 00 =
00 08 00
>>> kernel: reservation conflict error, dev sdb, sector 80 op 0x1:(WRITE)=
 flags 0x0 phys_seg 1 prio class 2
>>> kernel: sd 6:0:0:1: reservation conflict
>>> kernel: sd 6:0:0:1: reservation conflict
>>> kernel: sd 6:0:0:1: [sdb] tag#18 FAILED Result: hostbyte=3DDID_OK dri=
verbyte=3DDRIVER_OK cmd_age=3D0s
>>> kernel: sd 6:0:0:1: [sdb] tag#17 FAILED Result: hostbyte=3DDID_OK dri=
verbyte=3DDRIVER_OK cmd_age=3D0s
>>> kernel: sd 6:0:0:1: [sdb] tag#18 CDB: Write(10) 2a 00 00 00 00 60 00 =
00 08 00
>>> kernel: sd 6:0:0:1: [sdb] tag#17 CDB: Write(10) 2a 00 00 00 00 58 00 =
00 08 00
>>> kernel: reservation conflict error, dev sdb, sector 96 op 0x1:(WRITE)=
 flags 0x0 phys_seg 1 prio class 0
>>> kernel: reservation conflict error, dev sdb, sector 88 op 0x1:(WRITE)=
 flags 0x0 phys_seg 1 prio class 0
>>> systemd[1]: fstests-generic-069.scope: Deactivated successfully.
>>> systemd[1]: fstests-generic-069.scope: Consumed 5.092s CPU time.
>>> systemd[1]: media-test.mount: Deactivated successfully.
>>> systemd[1]: media-scratch.mount: Deactivated successfully.
>>> kernel: sd 6:0:0:1: reservation conflict
>>> kernel: failed to unregister PR key.
>>>
>>> This appears to be due to a race. bl_alloc_lseg() calls this:
>>>
>>> 561 static struct nfs4_deviceid_node *
>>> 562 bl_find_get_deviceid(struct nfs_server *server,
>>> 563                 const struct nfs4_deviceid *id, const struct cred=
 *cred,
>>> 564                 gfp_t gfp_mask)
>>> 565 {
>>> 566         struct nfs4_deviceid_node *node;
>>> 567         unsigned long start, end;
>>> 568
>>> 569 retry:
>>> 570         node =3D nfs4_find_get_deviceid(server, id, cred, gfp_mas=
k);
>>> 571         if (!node)
>>> 572                 return ERR_PTR(-ENODEV);
>>>
>>> nfs4_find_get_deviceid() does a lookup without the spin lock first.
>>> If it can't find a matching deviceid, it creates a new device_info
>>> (which calls bl_alloc_deviceid_node, and that registers the device's
>>> PR key).
>>>
>>> Then it takes the nfs4_deviceid_lock and looks up the deviceid again.=

>>> If it finds it this time, bl_find_get_deviceid() frees the spare
>>> (new) device_info, which unregisters the PR key for the same device.
>>>
>>> Any subsequent I/O from this client on that device gets EBADE.
>>>
>>> The umount later unregisters the device's PR key again.
>>>
>>> To prevent this problem, register the PR key after the deviceid_node
>>> lookup.
>>
>> Hi Chuck - nice catch, but I'm not seeing how we don't have the same p=
roblem
>> after this patch, instead it just seems like it moves the race.  What
>> prevents another process waiting to take the nfs4_deviceid_lock from
>> unregistering the same device?  I think we need another way to signal
>> bl_free_device that we don't want to unregister for the case where the=
 new
>> device isn't added to nfs4_deviceid_cache.
>
> That's a (related but) somewhat different issue. I haven't seen
> that in practice so far.
>
>
>> No good ideas yet - maybe we can use a flag set within the
>> nfs4_deviceid_lock?
>
> Well this smells like a use for a reference count on the block
> device, but fs/nfs doesn't control the definition of that data
> structure.

I think we need two things to fix this race:
 - a way to determine if the current thread is the one
   that added the device to the to the cache, if so do the register
 - a way to determine if we're freeing because we lost the race to the
   cache, if so don't un-register.

We can get both with a flag that's always set within the nfs4_deviceid_lo=
ck,
something like NFS_DEVICEID_INIT.  If set, it signals we need to register=
 in
the case we keep the device, or skip de-registration in the case where we=

lost the race and throw it out.  We still need this patch to do the
registration after it lands in the cache.

Ben


