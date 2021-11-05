Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DD9446899
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Nov 2021 19:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhKESrZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Nov 2021 14:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232704AbhKESrY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 5 Nov 2021 14:47:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02A696023D
        for <linux-nfs@vger.kernel.org>; Fri,  5 Nov 2021 18:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636137884;
        bh=co9BSL7kA8ek+s+k1S9N+LJHMfm0GdaHpCORj4LAzTU=;
        h=From:To:Subject:Date:From;
        b=XS5m0qtEg/loyGpfYzlI9EsEPp4RqxX4AVLQGOPQik9QH82noL5s2CLQcx8InPy7/
         fQtWzTbbI19demuGDDsye0BlFvg9hNwNqKZaFd1xaLp8nAkrIhd7p3hvRs0MHbUgUm
         QM2wDMIlZTQn9tFBIb88edgRWMbJ9k2D2U27mbBqwwhhqOjKAQK5Eh4JJELQfdjC09
         px2NQKKioC4KOAUDmP0qFTyOGjFlnvAkNgduCoA6WjV5e66DJ8vjk3optOPrnYuzmR
         KxHl7RFDe/oH65jGylZ2v1jfMbmAjsUd8xfBxr7OLkhApxqgbZ6WY4nU3eJEA8hNW8
         cNyY9uVb6awhg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4.2: alloc_file_pseudo() takes an open flag, not an f_mode
Date:   Fri,  5 Nov 2021 14:38:15 -0400
Message-Id: <20211105183816.328639-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index f9f50fe1f3a4..208dcae68f58 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -351,7 +351,7 @@ static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
 		goto out_free_name;
 	}
 
-	filep = alloc_file_pseudo(r_ino, ss_mnt, read_name, FMODE_READ,
+	filep = alloc_file_pseudo(r_ino, ss_mnt, read_name, O_RDONLY,
 				     r_ino->i_fop);
 	if (IS_ERR(filep)) {
 		res = ERR_CAST(filep);
-- 
2.33.1

