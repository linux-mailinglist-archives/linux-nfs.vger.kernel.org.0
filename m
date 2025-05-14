Return-Path: <linux-nfs+bounces-11721-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D65AB6C6A
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 15:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F483AEE95
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 13:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537552797B8;
	Wed, 14 May 2025 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCmhrq+Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9834927702D
	for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747228565; cv=none; b=W+lHzAkrm7hTW/yrCuzi667goNLlby4jpZGh507AY8x5fDOCliT5/H8pU31ekQgj73FUMkXxBmfUE9ZE4OuEL0/eOv8jX86fi1u4YzIpDK1WaJU6dBkZt+IU0xWxqZZdvsyji54bzg3pA3qgpeU6I14JQrbyUVllGqCYixbqnw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747228565; c=relaxed/simple;
	bh=WxmKKkBynQCeFBBLG2jlfmtsj/C+IeAQtKICrXN6enU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcqpS1CCKFEhFQordMM+F2vwHMlbQ+2QSBQMBSBwKKpGbsoviJEch581SyCtOyFqLn4DxNXSpkdjeTRD+5wrZgT5b2sv0jiDbwTg5F8sTywpAYT9UTyzAB9kkoGMS1fYBZ1R2lEGFDPzoNBoZVKHZmcIDgjPCwF9gyrnyYw29BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BCmhrq+Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747228562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gv5T0LOm53ww2gw1CoIkj405g3nCgKt46Pxs1SfGPas=;
	b=BCmhrq+Q3ygGGlyIMyfPFa5EC/UneFtSQvnWQEOo4HLVJBHsXJLrpiFNRHr3Ooi4z/CbUu
	p8o+F4c0mYEMehtGxuDBiPYjDBadj5tQBWAYBVlWLe32pgifwCtnivQqI5DDnM9lkVg3z6
	gQSGJTya9Iu5xqFOw3CVVzcQ6uso9wA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-s2Qi3LMUMWCE4mnNQAydvA-1; Wed,
 14 May 2025 09:15:58 -0400
X-MC-Unique: s2Qi3LMUMWCE4mnNQAydvA-1
X-Mimecast-MFC-AGG-ID: s2Qi3LMUMWCE4mnNQAydvA_1747228557
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 805E81801A12;
	Wed, 14 May 2025 13:15:57 +0000 (UTC)
Received: from [10.22.65.7] (unknown [10.22.65.7])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8AD461953B82;
	Wed, 14 May 2025 13:15:56 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: trondmy@kernel.org, Trond Myklebust <trondmy@hammerspace.com>,
 anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Support btime and other NFSv4 specific attributes
Date: Wed, 14 May 2025 09:15:54 -0400
Message-ID: <CFFDBCDF-F7E1-447C-ABB8-4777995906D2@redhat.com>
In-Reply-To: <20211227190504.309612-1-trondmy@kernel.org>
References: <20211227190504.309612-1-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hey Trond and Anna - this series looked ready to go, but seems to have ne=
ver gotten upstream.  Was there a problem that needed work?

I'd like to rebase these and submit them, but will hold off if its a non-=
starter..

Ben


On 27 Dec 2021, at 14:04, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> NFSv4 has support for a number of extra attributes that are of interest=

> to Samba when it is used to re-export a filesystem to Windows clients.
> Aside from the btime, which is of interest in statx(), Windows clients
> have an interest in determining the status of the 'hidden', and 'system=
'
> flags.
> Backup programs want to read the 'archive' flags and the 'time backup'
> attribute.
> Finally, the 'offline' flag can tell whether or not a file needs to be
> staged by an HSM system before it can be read or written to.
>
> The patch series also adds an ioctl() to allow userspace retrieval and
> setting of these attributes where appropriate. It also adds an ioctl()
> to allow retrieval of the raw NFSv4 ACCESS information, to allow more
> fine grained determination of the user's access rights to a file or
> directory. All of this information is of use for Samba.
>
>
> - v2: Rebase on top of Anna's linux-next
>
> Anne Marie Merritt (3):
>   nfs: Add timecreate to nfs inode
>   nfs: Add 'archive', 'hidden' and 'system' fields to nfs inode
>   nfs: Add 'time backup' to nfs inode
>
> Richard Sharpe (1):
>   NFS: Support statx_get and statx_set ioctls
>
> Trond Myklebust (4):
>   NFS: Expand the type of nfs_fattr->valid
>   NFS: Return the file btime in the statx results when appropriate
>   NFSv4: Support the offline bit
>   NFSv4: Add an ioctl to allow retrieval of the NFS raw ACCESS mask
>
>  fs/nfs/dir.c              |  71 ++---
>  fs/nfs/getroot.c          |   3 +-
>  fs/nfs/inode.c            | 147 +++++++++-
>  fs/nfs/internal.h         |  10 +
>  fs/nfs/nfs3proc.c         |   1 +
>  fs/nfs/nfs4_fs.h          |  31 +++
>  fs/nfs/nfs4file.c         | 550 ++++++++++++++++++++++++++++++++++++++=

>  fs/nfs/nfs4proc.c         | 175 +++++++++++-
>  fs/nfs/nfs4trace.h        |   8 +-
>  fs/nfs/nfs4xdr.c          | 240 +++++++++++++++--
>  fs/nfs/nfstrace.c         |   5 +
>  fs/nfs/nfstrace.h         |   9 +-
>  fs/nfs/proc.c             |   1 +
>  include/linux/nfs4.h      |   1 +
>  include/linux/nfs_fs.h    |  15 ++
>  include/linux/nfs_fs_sb.h |   2 +-
>  include/linux/nfs_xdr.h   |  80 ++++--
>  include/uapi/linux/nfs.h  | 101 +++++++
>  18 files changed, 1355 insertions(+), 95 deletions(-)
>
> -- =

> 2.33.1


