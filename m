Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA44AC336
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Sep 2019 01:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393122AbfIFXgZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 19:36:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41022 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393113AbfIFXgZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 19:36:25 -0400
Received: by mail-io1-f68.google.com with SMTP id r26so16549270ioh.8
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 16:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TPUfdYPGh1LJiLP+QwTwv/M1dCmtn0bG5VMIacE+U3c=;
        b=eLH/WSVCLR2HsgBWGaBj0INr9V+Ia76jzkz1Ry1pagG1Kgv/uZ92KWHbDc+cLtahND
         umCvd9KZltek+QFaRDNPf/G6rfaHgHAH0Ofpoc8EI3ZtPbRxrIiJGoTGYoMKRTnPNoTw
         9Kdd5klE9BhsA2M3esqw2d/do89Kvh89DRtK5DbqEaDCXI2SaQZlab8TzravdJoFVcwY
         vSzQFdNDFyQr8eIxAuDNc/+qRuWTRGSaeIJFYUR08gKAV+8JbH2XloMAuIeED0S04jet
         6Zroh/u1zsSUUtZ7VqpOnonq+B4jQSXaRlWrBF5TGA2MODvWZvQhdCtNYyicqyc9wwmj
         txTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TPUfdYPGh1LJiLP+QwTwv/M1dCmtn0bG5VMIacE+U3c=;
        b=JG6K54eEyi+lDlWrmi7TO4dD9uo9pFYC5RTsbiZxZC2Z1p40SbXw1I2ZH8VBhS+JBF
         v44X2DKW6IVTuaZ1vjSNnZJkF0f6k8FeOZrHSxcb1z8DEhb0pp9wT94b9RJlH/a8P2oi
         WBoLLs1E80Nz6mbqVkOX6CMpMnha0uc73KNG8qhMsbPt2Q6sKTOrQQT0oOlPFhrTOV3F
         4bhBN1cX/8PI0uSpekVQVKkLZK3fEV9+W3ymg839erql55IJ1VV3z5fjU+DBlQMO1Ntu
         mayIW1R0Hqe9GV3WAuIBP4YeGm5Vv35qRgBWMvM9bsH0m+PDXaRRxys+O5lBp8KaYg0r
         FvQA==
X-Gm-Message-State: APjAAAVFZZ2DOj/MeYTaJsHPKWCUeb5V5qkQ9tM92WS3l2vCMSvYYm2N
        jFw45WKtb2hZFX6sFw9SWaw=
X-Google-Smtp-Source: APXvYqywZhFBzZv9Hibg5MQodaEWBTA/8vrjQ0VC0v0Ykw4RXKKfTzW+aqXrsuzifKNAgXVKPEqYng==
X-Received: by 2002:a02:2a0b:: with SMTP id w11mr12739803jaw.43.1567812984186;
        Fri, 06 Sep 2019 16:36:24 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r138sm10439360iod.59.2019.09.06.16.36.23
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 16:36:23 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 11/21] NFS based on file size issue sync copy or fallback to generic copy offload
Date:   Fri,  6 Sep 2019 19:36:01 -0400
Message-Id: <20190906233611.4031-12-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
References: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

For small file sizes, it make sense to issue a synchronous copy (and
save an RPC callback operation). Also, for the inter copy offload,
copy len must be larger than the cost of doing a mount between the
destination and source server (14RPCs are sent during 4.x mount).

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42.h     |  2 +-
 fs/nfs/nfs42proc.c |  4 ++--
 fs/nfs/nfs4file.c  | 16 +++++++++++++++-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs42.h b/fs/nfs/nfs42.h
index 02e3810cd889..c891af949886 100644
--- a/fs/nfs/nfs42.h
+++ b/fs/nfs/nfs42.h
@@ -16,7 +16,7 @@
 #ifdef CONFIG_NFS_V4_2
 int nfs42_proc_allocate(struct file *, loff_t, loff_t);
 ssize_t nfs42_proc_copy(struct file *, loff_t, struct file *, loff_t, size_t,
-			struct nl4_server *, nfs4_stateid *);
+			struct nl4_server *, nfs4_stateid *, bool);
 int nfs42_proc_deallocate(struct file *, loff_t, loff_t);
 loff_t nfs42_proc_llseek(struct file *, loff_t, int);
 int nfs42_proc_layoutstats_generic(struct nfs_server *,
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 9c7feacb0358..aab6b7b6a24a 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -357,7 +357,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 			struct file *dst, loff_t pos_dst, size_t count,
 			struct nl4_server *nss,
-			nfs4_stateid *cnr_stateid)
+			nfs4_stateid *cnr_stateid, bool sync)
 {
 	struct nfs_server *server = NFS_SERVER(file_inode(dst));
 	struct nfs_lock_context *src_lock;
@@ -368,7 +368,7 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 		.dst_fh		= NFS_FH(file_inode(dst)),
 		.dst_pos	= pos_dst,
 		.count		= count,
-		.sync		= false,
+		.sync		= sync,
 	};
 	struct nfs42_copy_res res;
 	struct nfs4_exception src_exception = {
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 2af30b7f5bfd..897832564923 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -138,6 +138,7 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 	struct nl4_server *nss = NULL;
 	nfs4_stateid *cnrs = NULL;
 	ssize_t ret;
+	bool sync = false;
 
 	/* Only offload copy if superblock is the same */
 	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
@@ -146,8 +147,21 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 		return -EOPNOTSUPP;
 	if (file_inode(file_in) == file_inode(file_out))
 		return -EOPNOTSUPP;
+	/* if the copy size if smaller than 2 RPC payloads, make it
+	 * synchronous
+	 */
+	if (count <= 2 * NFS_SERVER(file_inode(file_in))->rsize)
+		sync = true;
 retry:
 	if (!nfs42_files_from_same_server(file_in, file_out)) {
+		/* for inter copy, if copy size if smaller than 12 RPC
+		 * payloads, fallback to traditional copy. There are
+		 * 14 RPCs during an NFSv4.x mount between source/dest
+		 * servers.
+		 */
+		if (sync ||
+			count <= 14 * NFS_SERVER(file_inode(file_in))->rsize)
+			return -EOPNOTSUPP;
 		cn_resp = kzalloc(sizeof(struct nfs42_copy_notify_res),
 				GFP_NOFS);
 		if (unlikely(cn_resp == NULL))
@@ -162,7 +176,7 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 		cnrs = &cn_resp->cnr_stateid;
 	}
 	ret = nfs42_proc_copy(file_in, pos_in, file_out, pos_out, count,
-				nss, cnrs);
+				nss, cnrs, sync);
 out:
 	kfree(cn_resp);
 	if (ret == -EAGAIN)
-- 
2.18.1

