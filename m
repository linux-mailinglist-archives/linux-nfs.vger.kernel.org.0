Return-Path: <linux-nfs+bounces-10598-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8250A5FCEA
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 18:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5D2174B05
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 17:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305BB1519BF;
	Thu, 13 Mar 2025 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYN04jHP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3189326A097
	for <linux-nfs@vger.kernel.org>; Thu, 13 Mar 2025 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885295; cv=none; b=bn6Y0ufd4TSRghj2NuxuM7Ktx7OOh4b+SCxJw8vxMzCKp5gzwrIeEUWSw+PCvsbA1woYzw6bv0TITJ0GJO59mXFj+N9o4X4YYMjIi1/orwXrnfO3MokBbMZY1wlxf9wPQqgZGS+nLitB5vut7ouUyfMd5/c79RvQKTrLMx8XWro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885295; c=relaxed/simple;
	bh=jzOYwxpHQlqkPNpEgFrDc0lMXemxJRhtjuIkbw6j/qM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K51kagf7t0V79RjuFZvM6x9XeRKRbOFwF0a5UcGO2H2EAfo4m6+s0JF62Nve884Y8ueEvVLwrG2kQ78jbJLtLLeRwZRFYzylfzWzlUTrybvPO+5sVcg4my7Wu+Gatu8ENz6POwt20Wnv5n2xwytEX6cOwzFkFq8/EZPJhabc0nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYN04jHP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741885292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lUgBzrsoCxxg9G20NTfedxMyEhMD9FdIzOSMN0zuquc=;
	b=XYN04jHPhrPbzxxNnYOpNbsizUWIokoaaEs4zBCPTv/wm+q3titOjKEaZwxQdULshzbzwL
	XRvUHloXA/O4Wy8R8k1ZP2vGhVCV8wBxfOg4rBjtwr9V/JX8SI5CUlP+oCsl0xpApaMQDj
	FAzLuKidLSokGCvoUugHs5lLAjcrNj0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-xM2vipyoNlOyi3kBasR6VQ-1; Thu,
 13 Mar 2025 13:01:28 -0400
X-MC-Unique: xM2vipyoNlOyi3kBasR6VQ-1
X-Mimecast-MFC-AGG-ID: xM2vipyoNlOyi3kBasR6VQ_1741885284
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 643B1195606C;
	Thu, 13 Mar 2025 17:01:24 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.76.7])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B576C18001E9;
	Thu, 13 Mar 2025 17:01:23 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 0/1] Mount option rdirplus extension
Date: Thu, 13 Mar 2025 13:01:21 -0400
Message-ID: <cover.1741885071.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

v2 - Instead of adding "force_rdirplus", extend rdirplus=force
v3 - Fix broken bitwise operator
v4 - Fix /another/ borken bitwise op, reorder option emit

-------------

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
a patch to do that by extending the existing rdirplus mount option to take
values.  I'll follow this up with a man page update to nfs-utils.

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
  NFS: Extend rdirplus mount option with "force|none"

 fs/nfs/dir.c              |  2 ++
 fs/nfs/fs_context.c       | 32 ++++++++++++++++++++++++++++----
 fs/nfs/super.c            |  1 +
 include/linux/nfs_fs_sb.h |  1 +
 4 files changed, 32 insertions(+), 4 deletions(-)


base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
-- 
2.47.0


