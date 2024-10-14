Return-Path: <linux-nfs+bounces-7127-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B4D99BEF0
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 06:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247691F23B04
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 04:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930EF1AF4E2;
	Mon, 14 Oct 2024 03:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB+1O6qH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6811AE01F;
	Mon, 14 Oct 2024 03:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878382; cv=none; b=olT4aVU94BAVXh/dXf0WP4kF9uLX/ZnrB6c1CrhQ02/zlGAlMwZ9nYtED/jl5fvhfSyGnU02qGlCQ7V2QrKsAYmGz2N6tVgSIVk7RZMjzdXR0l3Z4lgay0OZ/v3YqR4yNF5tYoYbirN3PEzwfA3Rmyd1imx9NJoJJ8WFwNWv4oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878382; c=relaxed/simple;
	bh=rRcIWR39L/c4VzSiwhFgs1wkLAHR+F62x40Lh9RisjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9tei3d1r2irwiCRK5lpEbgkZktjewy4eZZaRPVNtadTGLNryI/tuc37mqgSCHzYylhDgBqG/K1bMHsbtdsvkyyJzT9bFWUfJYXs5OH3DhOz107G3+Ye8ChXDSJFJkvAElaXELwqPgNdUWG0whKKAAoyGxZVyahF99NULYhaNQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB+1O6qH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07B2C4CEC3;
	Mon, 14 Oct 2024 03:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878382;
	bh=rRcIWR39L/c4VzSiwhFgs1wkLAHR+F62x40Lh9RisjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KB+1O6qHdjWqfeRt0yVdRMlPArQxNeWDKE/xTVwMxjEOZAh/PgKmHJXGVfG0AyGgS
	 O8NVwbCFTHxBvhRRbSjGUVYdH8XaINiCnkjS7dPi7znHLF9FDD4WeZESPQpuE/J6LN
	 uaRSoStyJBmgoQoUt+GdKIxfp8xjDVbIBUCjrFB/AGZmcwzt7zxMF934bJoT9AjTzR
	 WKHWOFF8bVNpMDm2C4kLVY8WYlCjtZ7m6yN7Pu/S2eRSEd0jZRkcDPW6smGGix8b+K
	 evoWyF0XfybwhODW1yHHBiXhohRpNWhwz6EAlEDZhXQ+ekZKzOmtrH5K5gMUFSClwE
	 BvbdVF+xcPj0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dai Ngo <dai.ngo@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 7/8] NFS: remove revoked delegation from server's delegation list
Date: Sun, 13 Oct 2024 23:59:22 -0400
Message-ID: <20241014035929.2251266-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035929.2251266-1-sashal@kernel.org>
References: <20241014035929.2251266-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
Content-Transfer-Encoding: 8bit

From: Dai Ngo <dai.ngo@oracle.com>

[ Upstream commit 7ef60108069b7e3cc66432304e1dd197d5c0a9b5 ]

After the delegation is returned to the NFS server remove it
from the server's delegations list to reduce the time it takes
to scan this list.

Network trace captured while running the below script shows the
time taken to service the CB_RECALL increases gradually due to
the overhead of traversing the delegation list in
nfs_delegation_find_inode_server.

The NFS server in this test is a Solaris server which issues
CB_RECALL when receiving the all-zero stateid in the SETATTR.

mount=/mnt/data
for i in $(seq 1 20)
do
   echo $i
   mkdir $mount/testtarfile$i
   time  tar -C $mount/testtarfile$i -xf 5000_files.tar
done

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Reviewed-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/delegation.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 6a3ba306c3216..8eb11198ac65c 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -984,6 +984,11 @@ void nfs_delegation_mark_returned(struct inode *inode,
 	}
 
 	nfs_mark_delegation_revoked(delegation);
+	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
+	spin_unlock(&delegation->lock);
+	if (nfs_detach_delegation(NFS_I(inode), delegation, NFS_SERVER(inode)))
+		nfs_put_delegation(delegation);
+	goto out_rcu_unlock;
 
 out_clear_returning:
 	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
-- 
2.43.0


