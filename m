Return-Path: <linux-nfs+bounces-13697-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B16CDB288C6
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Aug 2025 01:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE4D17E517
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 23:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E87C13FEE;
	Fri, 15 Aug 2025 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhmG+0ZO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A95628853A
	for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300617; cv=none; b=YReDQi8wsGKApkSzO/vrj+fhCq3bC5BY2j85wAZjFyVnbjhoPOldo+Nfx8zRAcYXHzXkJG9d+HOyigrnO4tlm6W0iC4JUDxyRbFqgeAcWaZxfX/EQfvzmHqaSbSy/v3vTJ3DJqYtc0XSddcp022nCgkpj/aYTVu3my1ZRkqznZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300617; c=relaxed/simple;
	bh=fEs2zQwh4FAckUkWYy9cUxfvMdzxrwNy1++s5ACK4Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMw5758mie5tyzLQnA4SxpCU0sjhNUapUAEnsedqRxd5hnDkMwTXNIUGWYz4Zpdgki/K2GoVKnVcxkbrcfMJD6zs1YJAN3FckZNVjcNNTgDhJK5PwEjfCx/mcl/8VyX/LwB4LOALvuvVkzxAGrxQHifQPr7maWwwurC1P0yoZ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhmG+0ZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8755C4CEEB;
	Fri, 15 Aug 2025 23:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755300616;
	bh=fEs2zQwh4FAckUkWYy9cUxfvMdzxrwNy1++s5ACK4Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KhmG+0ZO5QoSVrVT1pQUi8cKaMNIzyqQtRIFTRxjqpIbst2R7tTcAr7KsYGg0Pi4/
	 1g5Y+Xcrp7zMpuu8V/Z6xd9nJr1nDWLINXpoGzwhcwzxjyI2x74IylDyhOO2jjPksk
	 tMuwnriF9Y9aP2g3fKZwNF5MvMeY7ipQiNb4uwTzL33UgDHnIYqzgC7mbzfanmDSxJ
	 2h4OWUpEsraB7Qrnme0C3rd7qg1k1FXW4QfHLJccC6gRMOxCVmX+PWTZIGJNcn/1uv
	 rA3uKySgMC4Odn7kdYARKbahjHiaJ+/DrJLySIfJ6ZFw8sLgV99o3mR6ZdHTa8KHrY
	 L0K/6z2NUJ6aw==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v8 9/9] NFS: add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
Date: Fri, 15 Aug 2025 19:30:03 -0400
Message-ID: <20250815233003.55071-10-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250815233003.55071-1-snitzer@kernel.org>
References: <20250815233003.55071-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NFS doesn't have DIO alignment constraints, so have NFS respond with
accommodating DIO alignment attributes (rather than plumb in GETATTR
support for STATX_DIOALIGN and STATX_DIO_READ_ALIGN).

The most coarse-grained dio_offset_align is the most accommodating
(e.g. PAGE_SIZE, in future larger may be supported).

Now that NFS has support, NFS reexport will now handle unaligned DIO
(NFSD's NFSD_IO_DIRECT support requires the underlying filesystem
support STATX_DIOALIGN and/or STATX_DIO_READ_ALIGN).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/inode.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 338ef77ae4230..7866d60b18452 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1066,6 +1066,21 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	if (S_ISDIR(inode->i_mode))
 		stat->blksize = NFS_SERVER(inode)->dtsize;
 	stat->btime = NFS_I(inode)->btime;
+
+	/* Special handling for STATX_DIOALIGN and STATX_DIO_READ_ALIGN
+	 * - NFS doesn't have DIO alignment constraints, avoid getting
+	 *   these DIO attrs from remote and just respond with most
+	 *   accommodating limits (so client will issue supported DIO).
+	 * - this is unintuitive, but the most coarse-grained
+	 *   dio_offset_align is the most accommodating.
+	 */
+	if ((request_mask & (STATX_DIOALIGN | STATX_DIO_READ_ALIGN)) &&
+	    S_ISREG(inode->i_mode)) {
+		stat->result_mask |= STATX_DIOALIGN | STATX_DIO_READ_ALIGN;
+		stat->dio_mem_align = 4; /* 4-byte alignment */
+		stat->dio_offset_align = PAGE_SIZE;
+		stat->dio_read_offset_align = stat->dio_offset_align;
+	}
 out:
 	trace_nfs_getattr_exit(inode, err);
 	return err;
-- 
2.44.0


