Return-Path: <linux-nfs+bounces-6676-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A0D988650
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Sep 2024 15:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2255B1F22459
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Sep 2024 13:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4756D183CAF;
	Fri, 27 Sep 2024 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J57tBXc7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3437C282FA
	for <linux-nfs@vger.kernel.org>; Fri, 27 Sep 2024 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727443991; cv=none; b=k3pP22lzXac8EKhwmSLym7JduKk9GvXnXoy041A0bjuUZ5tTwBiwjuN9XkxXMay/K7n8MeU/ylfAJNc+EKFkr0D73yckb49eZZ66RKDdedwWRvIGFF9Pw0mb+6Bl9ONr5C+u+L70uTaDumR6eAl1fNxMrSacFz9e+OcTmU2OCNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727443991; c=relaxed/simple;
	bh=+P58Gbna7t7AVL4V4Tf0rpBycNuw7Mm1yDc4T8Vns4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/38TPSR5C/Jkfnbqc8YMWmPLj3NfgVpUIGQ9EJTuiI/ryFLz93duvt4Cn9rQkvSoy/bwf1iWEKto1EMGWuDK9FVaEGARgmB9CAYZNyRfRm0cWUBgll/Eix0kkNQkmb2EDtOr5SH+TCZwIesSLgtE0dmMPthtNPPN7E9iWHEVxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J57tBXc7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727443988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EncI7J940LvYmxfYJuDAU0XrxnEWNF751y8/Pb64660=;
	b=J57tBXc7uTy1EF2zmORg0UZuSxc2BThgrD4wWnV6MHZ/GC6gLV2NLMvdE3tsZuncr/Xb4U
	OFhaTXH7/Nz9AUMIp4pQ4aDnw4usMLz6JOQpPFbRD47kWT9Ew5aHRNX2oZio19lf158XJb
	tdtkaVYK+GrHRXxNTx1OdvdxLH/Bcsc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-1zsCL-wsNNKpZytve0sySw-1; Fri,
 27 Sep 2024 09:33:05 -0400
X-MC-Unique: 1zsCL-wsNNKpZytve0sySw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD27718FDEDC;
	Fri, 27 Sep 2024 13:33:04 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3166D1955DCB;
	Fri, 27 Sep 2024 13:33:04 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Daniel Herman Shmulyan <danielhsh@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: 2 bugs in blkmap service
Date: Fri, 27 Sep 2024 09:33:02 -0400
Message-ID: <BB16B360-44D6-4848-95E9-A636C5CF8346@redhat.com>
In-Reply-To: <CAF+Si_qgqccM-BNKhya=_1G0dOb0YZc-94+OLWD3Z1D9kBJ8rQ@mail.gmail.com>
References: <CAF+Si_qgqccM-BNKhya=_1G0dOb0YZc-94+OLWD3Z1D9kBJ8rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 26 Sep 2024, at 2:35, Daniel Herman Shmulyan wrote:

> Hello and Good day

Hi Daniel,

> My name is Daniel, I was experimenting with pNFS block layout, and
> found 2 bugs  in blkmap utility.
> The source is here: https://git.linux-nfs.org/?p=steved/nfs-utils.git;
>
> I am not related to linux development community, so I am sending the
> email directly, hopefully it reaches the right people
>
> Bug1:
> Some block devices attach not directly under /dev/ but under sub dir
> like /dev/nvmesh/
> Example: /dev/nvmesh/disk00
> under /proc/partitions: this disk appears as nvmesh/disk00, but under
> /sys/block it appears as nvmesh!disk00. See Kernel function
> kobject_set_name_vargs().
> blkmapd does not call it and fails to detect block devices under
> subdir of /dev/ (because string matching of / and ! fails).
> Result: pNFS cannot detect and do IO to disks which with 'lsblk'
> appear under subdir.
>
> Bug2:
> Due to support for old kernels blockmapd incorrectly detects the minor
> version of a block device. It uses only 8 smallest bits for the minor
> version.
> This actually caused data corruption.
> I have two block devices (major:minor) of 252:257 and 252:1,
> The pNFS signature is found by blkmapd on disk 252:257 but pnfs IO
> actually goes to disk 252:1
>
> This is disastrous as some block device drivers deliberately reserve
> lower bits for partitions of disks, Which causes this issue to be
> critical.
> one vendor actually used 8 lowest bits to support 256 partitions,
> which means that his virtual disks are attached as (major:minor):
> 252:0
> 252:256
> 252:512 ...
>
> And pNFS IO always goes to only to the first disk
>
> Thanks
>
> I am not familiar with the procedure of opening a bug report to the
> kernel community, and I am very sorry if my direct Email is rude
> etiquette.
> I had the best intentions.

We have https://bugzilla.linux-nfs.org/ for nfs-utils bug reporting, but
also writing to the list about bugs is considered a good approach.

I don't think there's been much work on blkmapd recently, so you might need
to attempt to resolve these bugs on your own.  If you're serious about using
block-type NFS layouts, you might consider instead moving to SCSI layouts if
you can, as they are a more robust way to identify devices and
protect/fence.

Additionally there's been work over the years to extend SCSI layouts to NVMe
over fabric as well.   TLDR - block layouts are moving away from needing
blkmapd.

Ben


