Return-Path: <linux-nfs+bounces-4317-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9EF9184D0
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 16:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD201C20CC9
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A79C8F5C;
	Wed, 26 Jun 2024 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IP+znqgB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAE8176FA5
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413396; cv=none; b=Rct+rX+famvrIsdZOnN+TbeAOkvFpDYE92ZgqKKAGqO9e1wkbwGief3x+fAtgEp3H+HOK8V620HEaXe6Q0OK4xy8PjmgiIBf1HUmnIIcpwho5nT4VeQAOdZ+pvffCL6ipkSF7medXi7E1asSsoULPSK8/bP1ZJ4stiijtptfcNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413396; c=relaxed/simple;
	bh=Oalrc/8B//Nzm3k2ctPe7MFJwY6xv5nUMbJxusaSw24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOMTbD3ESOMDhSgaSuZP3aMIGO3cR7v8W8l1NVzl5HrFM/f79CT/4njdrklg5zhlBHzf3zUUbL9b3p4dMUJy4shrjInwpnTVkKrPzt9VPeEjHk2JXzBvPNYbtwRDwSpbjw95na2o9qKkpui9OQI9vZosS24V38T3sb8HZqGmdHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IP+znqgB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719413393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KG8fbXhNPDD83Eukc+oFWyfYiwF/FYcKUZ/CacEt1LY=;
	b=IP+znqgBpUBBZXx9qo7CsM27DiGi3O3VUxfGwMk0tEmvdI8rHDeuBUFrtTSLQB8bhAvSim
	abmpnOIGxITfy9uNgZxKagrGCAZeHqJ8qBESoUeSf0h3MQZVC7947G85y2kdJM0q0lG5QO
	eq470pKMsgI5LeBSpDJRFxTY7Zk9HCI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-ihaqr3vkPIGyB4uiNDO3Rw-1; Wed,
 26 Jun 2024 10:49:49 -0400
X-MC-Unique: ihaqr3vkPIGyB4uiNDO3Rw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 685E419560A6;
	Wed, 26 Jun 2024 14:49:48 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D32E61956050;
	Wed, 26 Jun 2024 14:49:46 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 1/3] nfs/blocklayout: Fix premature PR key
 unregistration
Date: Wed, 26 Jun 2024 10:49:44 -0400
Message-ID: <10B16A04-327D-4031-ABA0-72FAE31602EE@redhat.com>
In-Reply-To: <20240625200204.276770-6-cel@kernel.org>
References: <20240625200204.276770-5-cel@kernel.org>
 <20240625200204.276770-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 25 Jun 2024, at 16:02, cel@kernel.org wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
>
> During generic/069 runs with pNFS SCSI layouts, the NFS client emits
> the following in the system journal:
>
> kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0x600=
1405e3366f045b7949eb8e4540b51 (-2)
> kernel: pNFS: using block device sdb (reservation key 0x666b60901e7b26b=
3)
> kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0x600=
1405e3366f045b7949eb8e4540b51 (-2)
> kernel: pNFS: using block device sdb (reservation key 0x666b60901e7b26b=
3)
> kernel: sd 6:0:0:1: reservation conflict
> kernel: sd 6:0:0:1: [sdb] tag#16 FAILED Result: hostbyte=3DDID_OK drive=
rbyte=3DDRIVER_OK cmd_age=3D0s
> kernel: sd 6:0:0:1: [sdb] tag#16 CDB: Write(10) 2a 00 00 00 00 50 00 00=
 08 00
> kernel: reservation conflict error, dev sdb, sector 80 op 0x1:(WRITE) f=
lags 0x0 phys_seg 1 prio class 2
> kernel: sd 6:0:0:1: reservation conflict
> kernel: sd 6:0:0:1: reservation conflict
> kernel: sd 6:0:0:1: [sdb] tag#18 FAILED Result: hostbyte=3DDID_OK drive=
rbyte=3DDRIVER_OK cmd_age=3D0s
> kernel: sd 6:0:0:1: [sdb] tag#17 FAILED Result: hostbyte=3DDID_OK drive=
rbyte=3DDRIVER_OK cmd_age=3D0s
> kernel: sd 6:0:0:1: [sdb] tag#18 CDB: Write(10) 2a 00 00 00 00 60 00 00=
 08 00
> kernel: sd 6:0:0:1: [sdb] tag#17 CDB: Write(10) 2a 00 00 00 00 58 00 00=
 08 00
> kernel: reservation conflict error, dev sdb, sector 96 op 0x1:(WRITE) f=
lags 0x0 phys_seg 1 prio class 0
> kernel: reservation conflict error, dev sdb, sector 88 op 0x1:(WRITE) f=
lags 0x0 phys_seg 1 prio class 0
> systemd[1]: fstests-generic-069.scope: Deactivated successfully.
> systemd[1]: fstests-generic-069.scope: Consumed 5.092s CPU time.
> systemd[1]: media-test.mount: Deactivated successfully.
> systemd[1]: media-scratch.mount: Deactivated successfully.
> kernel: sd 6:0:0:1: reservation conflict
> kernel: failed to unregister PR key.
>
> This appears to be due to a race. bl_alloc_lseg() calls this:
>
> 561 static struct nfs4_deviceid_node *
> 562 bl_find_get_deviceid(struct nfs_server *server,
> 563                 const struct nfs4_deviceid *id, const struct cred *=
cred,
> 564                 gfp_t gfp_mask)
> 565 {
> 566         struct nfs4_deviceid_node *node;
> 567         unsigned long start, end;
> 568
> 569 retry:
> 570         node =3D nfs4_find_get_deviceid(server, id, cred, gfp_mask)=
;
> 571         if (!node)
> 572                 return ERR_PTR(-ENODEV);
>
> nfs4_find_get_deviceid() does a lookup without the spin lock first.
> If it can't find a matching deviceid, it creates a new device_info
> (which calls bl_alloc_deviceid_node, and that registers the device's
> PR key).
>
> Then it takes the nfs4_deviceid_lock and looks up the deviceid again.
> If it finds it this time, bl_find_get_deviceid() frees the spare
> (new) device_info, which unregisters the PR key for the same device.
>
> Any subsequent I/O from this client on that device gets EBADE.
>
> The umount later unregisters the device's PR key again.
>
> To prevent this problem, register the PR key after the deviceid_node
> lookup.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfs/blocklayout/blocklayout.c | 25 +++++----
>  fs/nfs/blocklayout/blocklayout.h |  9 +++-
>  fs/nfs/blocklayout/dev.c         | 91 ++++++++++++++++++++++++--------=

>  3 files changed, 94 insertions(+), 31 deletions(-)
>
> diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/bloc=
klayout.c
> index 6be13e0ec170..0becdec12970 100644
> --- a/fs/nfs/blocklayout/blocklayout.c
> +++ b/fs/nfs/blocklayout/blocklayout.c
> @@ -564,25 +564,32 @@ bl_find_get_deviceid(struct nfs_server *server,
>  		gfp_t gfp_mask)
>  {
>  	struct nfs4_deviceid_node *node;
> -	unsigned long start, end;
> +	int err =3D -ENODEV;

Just a nit - this err var seems unnecessary.. especially as still we do..=


>  retry:
>  	node =3D nfs4_find_get_deviceid(server, id, cred, gfp_mask);
>  	if (!node)
>  		return ERR_PTR(-ENODEV);

=2E. this, which seems clearer.  Looking at the return at the bottom make=
s me
think 'err' could be something else, but it can't.  Looks good to me
otherwise.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


