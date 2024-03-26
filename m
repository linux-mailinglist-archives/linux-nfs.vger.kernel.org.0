Return-Path: <linux-nfs+bounces-2480-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC8C88CA80
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 18:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1F81C660FD
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 17:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF5A1CD20;
	Tue, 26 Mar 2024 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S27HFSzi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7350F1C6A4
	for <linux-nfs@vger.kernel.org>; Tue, 26 Mar 2024 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473209; cv=none; b=C5ML26IPGO/di/lUH4GK/8Vn1lxqXf5ffnCs/zSuNup27vROE4fDMLFnsuCsU85eBpSTUTuixp9Z0MoE003Bo5YEEBA5YTfhhWp2OURnhDwDPf6hOk2z7nv6Rl/zDVi5Yhv5R9x0WBBUNBcy83ku5VLy8QOSV83W0QbzVWhDCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473209; c=relaxed/simple;
	bh=cXmuMVK+zgDb+uN88yBgRNdCQhWi2wyEuwV11UXLIKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMoMoIwVPaXnv/dNoWoJ50fYTU73koqRelxGqLCDJCUUecG2oH+jbj+TNWOzDweU0jp7fxbd0LAk23D7DfCgMEMIlFM0cBJW+bWwMknHBwThoU6vQgAP5R7uT+5BuPgVwYAeVjGWPF9USGDlbZM9nv3OyOr5rYhZq/6ec0eFGnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S27HFSzi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711473206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6O6YSe5hs2dY1yeZMq21PoppQsCAtDRDCET6kUs7n+U=;
	b=S27HFSzifxjx1+nKrYh2/JodDWC/aPFvYdS/yHimwLZYFZalu/CKyVUOC/1vD5IuuQD6cL
	0K6vBO9+wZHh7JiHvM4Jorb6NRwe8pXJlnrXtLNjGy0s3DlnEddEfhzUYQzylQLcMNDD71
	4havEMX0nfduimQmQfB4iH40B9ia3R0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-H0IpCBMFNMCDzOpdlJTBjw-1; Tue,
 26 Mar 2024 13:13:23 -0400
X-MC-Unique: H0IpCBMFNMCDzOpdlJTBjw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20DEE3C367E7;
	Tue, 26 Mar 2024 17:13:23 +0000 (UTC)
Received: from [100.115.132.116] (unknown [10.22.50.19])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CA7B1121306;
	Tue, 26 Mar 2024 17:13:21 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jan Schunk <scpcom@gmx.de>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [External] : nfsd: memory leak when client does many file
 operations
Date: Tue, 26 Mar 2024 13:13:16 -0400
Message-ID: <1AE35F72-77CF-4F5A-9B65-72AB6A53A621@redhat.com>
In-Reply-To: <trinity-0ed602bd-15d4-4110-b3f4-668c2051904a-1711472684521@msvc-mesg-gmx122>
References: <trinity-068f55c9-6088-418d-bf3a-c2778a871e98-1711310237802@msvc-mesg-gmx120>
 <E3109CAA-8261-4F66-9D1B-3546E8B797DF@oracle.com>
 <trinity-bfafb9db-d64f-4cad-8cb1-40dac0a2c600-1711313314331@msvc-mesg-gmx105>
 <567BBF54-D104-432C-99C0-1A7EE7939090@oracle.com>
 <trinity-66047013-4d84-4eef-b5d3-d710fe6be805-1711316386382@msvc-mesg-gmx005>
 <6F16BCCE-3000-4BCB-A3B4-95B4767E3577@oracle.com>
 <trinity-ad0037c0-1060-4541-a8ca-15f826a5b5a2-1711396545958@msvc-mesg-gmx024>
 <088D9CC3-C5B0-4646-A85D-B3B9ACE8C532@oracle.com>
 <F594EBB2-5F92-40A9-86FB-CFD58E9CE516@redhat.com>
 <trinity-0ed602bd-15d4-4110-b3f4-668c2051904a-1711472684521@msvc-mesg-gmx122>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 26 Mar 2024, at 13:04, Jan Schunk wrote:

> Before I start doing this on my own build I tried it with unmodified li=
nux-image-6.6.13+bpo-amd64 from Debian 12.
> I installed systemtap, linux-headers-6.6.13+bpo-amd64 and linux-image-6=
=2E6.13+bpo-amd64-dbg and tried to run stap:
>
> user@deb:~$ sudo stap -v --all-modules kmem_alloc.stp nfsd_file
> WARNING: Kernel function symbol table missing [man warning::symbols]
> Pass 1: parsed user script and 484 library scripts using 110120virt/968=
96res/7168shr/89800data kb, in 1360usr/1080sys/4963real ms.
> WARNING: cannot find module kernel debuginfo: No DWARF information foun=
d [man warning::debuginfo]
> semantic error: resolution failed in DWARF builder
>
> semantic error: while resolving probe point: identifier 'kernel' at kme=
m_alloc.stp:5:7
>         source: probe kernel.function("kmem_cache_alloc") {
>                       ^
>
> semantic error: no match
>
> Pass 2: analyzed script: 1 probe, 5 functions, 1 embed, 3 globals using=
 112132virt/100352res/8704shr/91792data kb, in 30usr/30sys/167real ms.
> Pass 2: analysis failed.  [man error::pass2]
> Tip: /usr/share/doc/systemtap/README.Debian should help you get started=
=2E
> user@deb:~$
>
> user@deb:~$ grep -E 'CONFIG_DEBUG_INFO|CONFIG_KPROBES|CONFIG_DEBUG_FS|C=
ONFIG_RELAY' /boot/config-6.6.13+bpo-amd64
> CONFIG_RELAY=3Dy
> CONFIG_KPROBES=3Dy
> CONFIG_KPROBES_ON_FTRACE=3Dy
> CONFIG_DEBUG_INFO=3Dy
> # CONFIG_DEBUG_INFO_NONE is not set
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> # CONFIG_DEBUG_INFO_REDUCED is not set
> CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
> # CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> CONFIG_DEBUG_INFO_BTF=3Dy
> CONFIG_DEBUG_INFO_BTF_MODULES=3Dy
> CONFIG_DEBUG_FS=3Dy
> CONFIG_DEBUG_FS_ALLOW_ALL=3Dy
> # CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> user@deb:~$
>
> Do I need to enable other options?

You should just need DEBUG_INFO.. maybe stap can't find it?  You can try =
to add: -r /path/to/the/kernel/build

=2E. but usually I use this option for a cross-compile.  Usually I don't =
have to muck around without the debuginfo packages either.  If I don't ha=
ve them then I'm annotating the kernel directly.

Maybe just a view of what's happening in /proc/slabinfo would be enough..=


Ben


