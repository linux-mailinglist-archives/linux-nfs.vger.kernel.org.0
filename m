Return-Path: <linux-nfs+bounces-10568-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE0DA5E4B8
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 20:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2803AF435
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 19:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69B8800;
	Wed, 12 Mar 2025 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxeziDxf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B6D136A
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808782; cv=none; b=O5k3hLh8fnkIH6IqT0XloWIZyxr1ZvljjuAcIvUsTqQqG2+9iPKeqShNdTHI+00pffg1avk/rboz9WerNlfhGgj54mpIre4HrPpB6yVFF3JURYaFZWZBMHkASUSZGXbPyx1LuFs10X/2X6EzNtu3IujWzz5NXrKhQF73czT3Mqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808782; c=relaxed/simple;
	bh=TsT6CmXMtIDpSLhXAv3vaVBaWio+3AUrfJRFU698Ze8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IT31+MlfVzp6fHjcz/dloWsNaHXxq/Qvp2gnrHkUxeg0KuKXuL+KQpiCJN/0bHR+QKwAqk6zOL9fIY1nP2bn2MRczdn2tsrjVbfZrq0fVBgvBeohQ/ufj/khNmlOYHYlUW3s5MHjzcOLiZ9cwUHcbP7Uv0PGoTjnkiSxn7V/BXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxeziDxf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741808780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H9tGOjSlYfFZOfK2tT8URkkPyfRmakhmdpnLWr7o9NM=;
	b=RxeziDxfefddjfbVmzO3BLWQ7YpyF4HXnN/3M3iWvvtnH9X9iv6h/BxR3d74KNoNY6r2A8
	QR/O1WaeaTL43EvzZ7nAtu2gUQ7RQTrqS07dqhqrZSiKO6CQx7aTciGI0DFwCeym5BzWmV
	VaZTs//zpQiWHiJywyMMAzrwjuTQep8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-GIjygHqjOs60DW3YcG89lw-1; Wed,
 12 Mar 2025 15:46:16 -0400
X-MC-Unique: GIjygHqjOs60DW3YcG89lw-1
X-Mimecast-MFC-AGG-ID: GIjygHqjOs60DW3YcG89lw_1741808776
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5B2D1956050;
	Wed, 12 Mar 2025 19:46:15 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.76.7])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA1D11828A87;
	Wed, 12 Mar 2025 19:46:14 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 0/1] Mount option - force READDIRPLUS
Date: Wed, 12 Mar 2025 15:46:12 -0400
Message-ID: <cover.1741806879.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

After these two changes:

1a34c8c9a49e NFS: Support larger readdir buffers
and
85aa8ddc3818 NFS: Trigger the "ls -l" readdir heuristic sooner

.. we've disadvantaged/regressed some users workloads where the user is
forced to use NFSv3 (such that we cannot prime the dcache with d_type on
READDIR as we do for NFSv4), and where the workload is a search through a
large directory tree.  Previously, the smaller buffers and/or the larger
heuristic size worked to their advantage to optimize the client toward the
READDIRPLUS path.

We've been able to relieve some pain temporarily by putting a knob into
sysfs to allow them to set the operation to one of:

	- force READDIRPLUS
	- disable READDIRPLUS
	- use the default heurstic

That's exactly the solution they're looking for and we have most of that in
mount options today with the "rdirplus" and "nordirplus".  Missing only is
the option to force the client to always use READDIR plus.  What follows is
a patch to do that with a new mount option.  I'll follow this up with a man
page update to nfs-utils.

The global heuristic is always going to be wrong for some workloads and we
cannnot depend on something like a mount-wide option to always work well for
mixed workloads on the same mount.  A realistic long-term solution involves
allowing the applications to signal their intended behavior.

So, I am going to look at plumbing in a posix_fadvise() flag for
READDIRPLUS.  There's been some interest expressed already for other
filesystems[1].  I plan to send along patches for this and face the
discussions.  However, that work will take some time to filter up into the
utilities and into distros.  In the meantime, I hope we can add this simpler
mount option to help the folks that need the old behaviors in recent
kernels.

[1]: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhBWV3DfqaE=reuPjh8w92wwujA6Abj=Gt0YvapR4m_1g@mail.gmail.com/

Benjamin Coddington (1):
  NFS: New mount option force_rdirplus

 fs/nfs/dir.c              |  2 ++
 fs/nfs/fs_context.c       | 14 ++++++++++++--
 include/linux/nfs_fs_sb.h |  1 +
 3 files changed, 15 insertions(+), 2 deletions(-)


base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
-- 
2.47.0


