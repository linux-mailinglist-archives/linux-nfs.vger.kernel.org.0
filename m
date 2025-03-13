Return-Path: <linux-nfs+bounces-10593-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8980DA5F8D1
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 15:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CCE3ADC91
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 14:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57B3267396;
	Thu, 13 Mar 2025 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMxSxtEd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B627E267B1D
	for <linux-nfs@vger.kernel.org>; Thu, 13 Mar 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876987; cv=none; b=Sg7e+shgQw1tkBuksFiNn6FYAHoHxnOkOUM5W3m2S8NdGQrJCed21gnkZ2uYK4LtaDltG6YGKb2daYzTPWYT/jnzruL0ikJsKq4/DQFYwS6oLc1QB5Rc9BggEqpgucwtYUYdScfOxWLDDWYHITDbbIugInzlTj1APakaFN5kes0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876987; c=relaxed/simple;
	bh=14TjbOEU37beSz4CBIM6+J8BP3CyRU4+sMIIw+MV12w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+Mm0sPW0JrWku30J6fiX52vrM2Sgeq+TWJxUWZHeb1AuGdC9cQbanbEroDKtcBqwwgo5mRqmYutt15MxIZeYQrNZRZ4huqwMZASdBo5aTyzKMgle04DJhaFFbLeoRpCX7JRBL1TE336qARg1Dj8/lX7bjHex40/vFBOU2iCa0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMxSxtEd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741876984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s9qBs6EgEAZAzvq5XFVYEzvEYqq3v9opXaip6GgQ9DM=;
	b=TMxSxtEdZZ9OhGRKX2U0KmEr0XEtYAyyMz4n2KCTH8onEeiFBbqX/HVL896oWdQ3vpF6Ql
	buPt8h7p36N3PITzVyHVHPCKdZtRKL/Vg8wemPFy+vzAAnuc2jz0XD1uWWne6IyVdlG1Dc
	sjj2KSFxUHfp603Bk36vEzAKDKrNwu4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-rshLF-VAOJqO-UGviYsQ0g-1; Thu,
 13 Mar 2025 10:43:03 -0400
X-MC-Unique: rshLF-VAOJqO-UGviYsQ0g-1
X-Mimecast-MFC-AGG-ID: rshLF-VAOJqO-UGviYsQ0g_1741876982
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18B73180036E;
	Thu, 13 Mar 2025 14:43:02 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.76.7])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D9C41800268;
	Thu, 13 Mar 2025 14:43:01 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/1] Mount option rdirplus extension
Date: Thu, 13 Mar 2025 10:42:59 -0400
Message-ID: <cover.1741876784.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

v2 - Instead of adding "force_rdirplus", extend rdirplus=force
v3 - Fix broken bitwise operator

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


