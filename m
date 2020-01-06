Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 083CB1317AC
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 19:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgAFSmy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 13:42:54 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:32892 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgAFSmx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 13:42:53 -0500
Received: by mail-yb1-f193.google.com with SMTP id n66so22489640ybg.0
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 10:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3gv2Uv5Vo9nayPlWr/mLsAQL4tqjnJ1W4jdHwtQk72w=;
        b=A0RVLw9UXvaoCqp5O7Z4MoKjy+n56Ui1CkGZfxChF8rkE00M5WIRJ52jppBAZL6X4X
         WrYYp6YRJ9n5e9pRaUYip3LuIAcCgAYYtNHGFKngztRnizt++suTFj08+o2t090WTHYg
         Qpd51hwnb25HgvXyDQD6O+Y6AfUn/OJSbv9d1+r4FCj1dy+t56kMbkypso2PJ0TtXzHc
         Wy2VBO1xeW/aMyK9YxgmT/KiOdzs6yMfcxLt0uuBU0KR/dNTbhpXVHvu4elQtQ0tGwYO
         4pM/e9paC+al0X7/mYsNxOtFk8/2aubQXRtROuyWgo7JI9AIPqlJ4sFyvVTRu5JVHYL8
         R6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3gv2Uv5Vo9nayPlWr/mLsAQL4tqjnJ1W4jdHwtQk72w=;
        b=nGOFUAY8lmKSEh2MYc59PKDrO7xC2rQRG6jW4fvlgucCI81sAk4T32NYSx6mBG9hZ0
         Qh+gbkPGXJ/vOlIqwxPj6hjtKBs6B67kKCElBD9vPZgOULQAnGLWajmi7w30D85lhkN1
         D/ON5waWL/SA9pGhImH8SUp6MJXSzDYerMxWXlRGEk3iScsAGk7jZXWazvr9qHB6Ozy6
         LvHDccGcLAsP7BQNdAQ5fL2MIJc54clVbZfABSdUGobYZaF5GZc8JC+i8HYJNQwNMHSL
         Y1bvGGKO/1eHUDUpMeb/FsZTNY7DAMp0vRIxcnqxgoecnZq+Cxmo34PoXiJVWvxA8Oft
         52AA==
X-Gm-Message-State: APjAAAVikiulf6TqsDnFtnbbTbqK5j2tcK8HfILoku5eOCcjn3KyMXdT
        7TrmgNGDTB9tc784YLFfTA==
X-Google-Smtp-Source: APXvYqwNIm+MJ6EVzyTCUEBZ5A2aSBqq57LgTzxTzGE6DmSvKDeLojDTF8FAErFvUjfQ8FCYg1SmFQ==
X-Received: by 2002:a25:d88d:: with SMTP id p135mr79102374ybg.205.1578336172532;
        Mon, 06 Jan 2020 10:42:52 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u136sm28223497ywf.101.2020.01.06.10.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 10:42:52 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/9] nfsd: Ensure exclusion between CLONE and WRITE errors
Date:   Mon,  6 Jan 2020 13:40:33 -0500
Message-Id: <20200106184037.563557-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106184037.563557-5-trond.myklebust@hammerspace.com>
References: <20200106184037.563557-1-trond.myklebust@hammerspace.com>
 <20200106184037.563557-2-trond.myklebust@hammerspace.com>
 <20200106184037.563557-3-trond.myklebust@hammerspace.com>
 <20200106184037.563557-4-trond.myklebust@hammerspace.com>
 <20200106184037.563557-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that we can distinguish between synchronous CLONE and
WRITE errors, and that we can assign them correctly.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/vfs.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 7e7e31dfc672..b2984a996ab8 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -536,22 +536,33 @@ __be32 nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
 	struct file *src = nf_src->nf_file;
 	struct file *dst = nf_dst->nf_file;
 	loff_t cloned;
+	__be32 ret = 0;
 
+	down_write(&nf_dst->nf_rwsem);
 	cloned = vfs_clone_file_range(src, src_pos, dst, dst_pos, count, 0);
-	if (cloned < 0)
-		return nfserrno(cloned);
-	if (count && cloned != count)
-		return nfserrno(-EINVAL);
+	if (cloned < 0) {
+		ret = nfserrno(cloned);
+		goto out_err;
+	}
+	if (count && cloned != count) {
+		ret = nfserrno(-EINVAL);
+		goto out_err;
+	}
 	if (sync) {
 		loff_t dst_end = count ? dst_pos + count - 1 : LLONG_MAX;
 		int status = vfs_fsync_range(dst, dst_pos, dst_end, 0);
 
 		if (!status)
 			status = commit_inode_metadata(file_inode(src));
-		if (status < 0)
-			return nfserrno(status);
+		if (status < 0) {
+			nfsd_reset_boot_verifier(net_generic(nf_dst->nf_net,
+						 nfsd_net_id));
+			ret = nfserrno(status);
+		}
 	}
-	return 0;
+out_err:
+	up_write(&nf_dst->nf_rwsem);
+	return ret;
 }
 
 ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
-- 
2.24.1

