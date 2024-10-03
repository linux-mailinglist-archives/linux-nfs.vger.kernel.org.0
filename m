Return-Path: <linux-nfs+bounces-6846-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5053998F715
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 21:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2AC1C21CB5
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 19:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1191ABEBB;
	Thu,  3 Oct 2024 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwuIIBN7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6442C1AAE0C
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984111; cv=none; b=eNV84dzwp+MWseG1ptaZUs9l1VJnbq9ShO8wD2Q74dSt3m9g4z6qno+goJiCfeC5gifmd8S824X3ss3szbSsWlS1HqSsvnhiOAvthp4FSYpxReOI3Iox4zqB2Jj1md2nOICqd5RhFl4MyPQJFaDuAvcLE+ZXY+1PjecBzmgfDCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984111; c=relaxed/simple;
	bh=dO9gozPdQl2OhaD5p9iHUgs5avHYX0qx6mcdaqSzgvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGezhtJS5Mj+/Ole2LhjJuUhRXUvZ6YlhImgfRDPYEWBHJ72DuPFUL7qxu/kB7S8Z38goX7aGZP39r/ON78KM6bm9jnvpPKwyTFkXvJQ/dUNtSyfpCJ8LgZxIhdftd0wlswrt8Ha1L1PjoPm23ndV9xct4gak5gU7Us1SPLGuYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwuIIBN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C37C4CEC5;
	Thu,  3 Oct 2024 19:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727984110;
	bh=dO9gozPdQl2OhaD5p9iHUgs5avHYX0qx6mcdaqSzgvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZwuIIBN7tZN7x0xAKa/l+UaZYPf7hmftHQYTZPvv3/g8ziN8rOf0QJx/C/Jf18dpD
	 7osM44OHVEBYWnepTfQVeV78aCfKeFQUvvWxnQUbZZ/3xxV1ORRyoIOo5pFJMM0qwb
	 b1GAhJtpve4caZSLkDUmoFpyESbZnTIr7tqR/jK4uaiBa4g0+WIOxDHZcCqUkz7U2B
	 IcgiHQOkxBRydVumR+O5Q7qZOczIcHN7LdxQ9tNpCEkeBW8t3XFlOx0D3WmLWJ4xZ1
	 DGQJYer0nTmO7qaeK3Zoit0ZM2I/XfrOqxGztCzprbtOyp+nPgyoPGeCBUh+zxo+dx
	 DD4wBD7f70cZQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [6.12-rc2 v2 PATCH 4/7] nfs/localio: remove redundant suid/sgid handling
Date: Thu,  3 Oct 2024 15:35:01 -0400
Message-ID: <20241003193504.34640-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241003193504.34640-1-snitzer@kernel.org>
References: <20241003193504.34640-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

nfs_writeback_done() will take care of suid/sgid corner case.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index d124c265b8fd..88b6658b93fc 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -521,12 +521,7 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
 	}
 	if (status < 0)
 		nfs_reset_boot_verifier(inode);
-	else if (nfs_should_remove_suid(inode)) {
-		/* Deal with the suid/sgid bit corner case */
-		spin_lock(&inode->i_lock);
-		nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
-		spin_unlock(&inode->i_lock);
-	}
+
 	nfs_local_pgio_done(hdr, status);
 }
 
-- 
2.44.0


