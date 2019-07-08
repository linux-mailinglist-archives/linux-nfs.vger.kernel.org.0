Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61A396294D
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 21:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391662AbfGHTYq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 15:24:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41913 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391660AbfGHTYq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jul 2019 15:24:46 -0400
Received: by mail-io1-f65.google.com with SMTP id j5so18498064ioj.8
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2019 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qGIXOv5aXr0Zm8keKgGz5sHMQb8AM7DNIw/w19/udWc=;
        b=tXMVQ0lo5RZLsrbEiQ/mas7hoN5UQsEp7Z3HZ6m3b3Br6O5mNrxf98jMMWObUf0iKo
         rnwLUCrApwDOp10qG47ppGRBVBiwGU4K6wzSDwtyo4hipEGWfUu0S11+PYDHwzBgWRju
         eRUIQFcGhGyq7skZE+LzXpl7ekmW6SHcmK72cbNQ8lMIL3tk05cu0Wc/7CMVbLlqopBV
         2KU8Red5qLK22rc2Ip/pzyam9NWQhM3Bc1r+Az9Me0V9wRzwKwsDABFPlTa7UNBRSWBe
         CkTdaZoGnpuKFqtBZUa5aOrz/pEmEukORwgw4g8cuRFrmL/YCUkSM5g65VYj7fhLm/Z3
         IzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qGIXOv5aXr0Zm8keKgGz5sHMQb8AM7DNIw/w19/udWc=;
        b=uJzhpEpSHzQlWrznh58Kj+yXbdL7UpalNeCghQwUTt6rp5DY3VFfAVgHPb1ChLf13v
         MuZ4vtY0BBC65zkDYW5+r3er80ySuDpyKyVUTTZAyb5EZXxl4/DDkQzsl+IPMQELiCDn
         v0WmNMS6toMBTWCRbCUdBnzy8MAEdUaaz6X6GHcMIPL6sZW8G/0YhQBW+51+tt5lGxng
         9U/KabihARrWQelk2vzP8jy2Q5CHn0iptOrtMEc23oo9Ik6xH9fa+M/u1diDF3G0p8Bw
         4tm1kImCQGvRiflT21PMT29NIgdwFFf2VF5q+0a9G7mDbKH9Bvmpg8zCVo4ZINVbal+0
         sdAg==
X-Gm-Message-State: APjAAAVxRci0Rr/CTfq6TGXkqP1434gWH50kfQFbBq4KdHs9UEO46EaQ
        mMwZTTasTG+Rt4AVNqRjGxc=
X-Google-Smtp-Source: APXvYqxP9Z5CW0kcXC3kHMU3Hyc9X7M30tX3OCPirtZC6cTtUL5IYXTUitqDjaPVbI/PpnVj7S/Ogw==
X-Received: by 2002:a02:54c1:: with SMTP id t184mr24329488jaa.10.1562613885651;
        Mon, 08 Jul 2019 12:24:45 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id n17sm17026554iog.63.2019.07.08.12.24.44
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 12:24:45 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 03/12] NFS: add ca_source_server<> to COPY
Date:   Mon,  8 Jul 2019 15:24:35 -0400
Message-Id: <20190708192444.12664-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
References: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Support only one source server address: the same address that
the client and source server use.

Signed-off-by: Andy Adamson <andros@netapp.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42.h          |  3 ++-
 fs/nfs/nfs42proc.c      | 26 +++++++++++++++++---------
 fs/nfs/nfs42xdr.c       | 12 ++++++++++--
 fs/nfs/nfs4file.c       |  7 ++++++-
 include/linux/nfs_xdr.h |  1 +
 5 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/nfs42.h b/fs/nfs/nfs42.h
index 4995731a6714..02e3810cd889 100644
--- a/fs/nfs/nfs42.h
+++ b/fs/nfs/nfs42.h
@@ -15,7 +15,8 @@
 /* nfs4.2proc.c */
 #ifdef CONFIG_NFS_V4_2
 int nfs42_proc_allocate(struct file *, loff_t, loff_t);
-ssize_t nfs42_proc_copy(struct file *, loff_t, struct file *, loff_t, size_t);
+ssize_t nfs42_proc_copy(struct file *, loff_t, struct file *, loff_t, size_t,
+			struct nl4_server *, nfs4_stateid *);
 int nfs42_proc_deallocate(struct file *, loff_t, loff_t);
 loff_t nfs42_proc_llseek(struct file *, loff_t, int);
 int nfs42_proc_layoutstats_generic(struct nfs_server *,
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 6317dd89cf43..e34ade844737 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -243,7 +243,9 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 				struct file *dst,
 				struct nfs_lock_context *dst_lock,
 				struct nfs42_copy_args *args,
-				struct nfs42_copy_res *res)
+				struct nfs42_copy_res *res,
+				struct nl4_server *nss,
+				nfs4_stateid *cnr_stateid)
 {
 	struct rpc_message msg = {
 		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_COPY],
@@ -257,11 +259,15 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 	size_t count = args->count;
 	ssize_t status;
 
-	status = nfs4_set_rw_stateid(&args->src_stateid, src_lock->open_context,
-				     src_lock, FMODE_READ);
-	if (status)
-		return status;
-
+	if (nss) {
+		args->cp_src = nss;
+		nfs4_stateid_copy(&args->src_stateid, cnr_stateid);
+	} else {
+		status = nfs4_set_rw_stateid(&args->src_stateid,
+				src_lock->open_context, src_lock, FMODE_READ);
+		if (status)
+			return status;
+	}
 	status = nfs_filemap_write_and_wait_range(file_inode(src)->i_mapping,
 			pos_src, pos_src + (loff_t)count - 1);
 	if (status)
@@ -325,8 +331,9 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 }
 
 ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
-			struct file *dst, loff_t pos_dst,
-			size_t count)
+			struct file *dst, loff_t pos_dst, size_t count,
+			struct nl4_server *nss,
+			nfs4_stateid *cnr_stateid)
 {
 	struct nfs_server *server = NFS_SERVER(file_inode(dst));
 	struct nfs_lock_context *src_lock;
@@ -368,7 +375,8 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 		inode_lock(file_inode(dst));
 		err = _nfs42_proc_copy(src, src_lock,
 				dst, dst_lock,
-				&args, &res);
+				&args, &res,
+				nss, cnr_stateid);
 		inode_unlock(file_inode(dst));
 
 		if (err >= 0)
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index ccabc0cd93dd..c03f3246d6c5 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -21,7 +21,10 @@
 #define encode_copy_maxsz		(op_encode_hdr_maxsz +          \
 					 XDR_QUADLEN(NFS4_STATEID_SIZE) + \
 					 XDR_QUADLEN(NFS4_STATEID_SIZE) + \
-					 2 + 2 + 2 + 1 + 1 + 1)
+					 2 + 2 + 2 + 1 + 1 + 1 +\
+					 1 + /* One cnr_source_server */\
+					 1 + /* nl4_type */ \
+					 1 + XDR_QUADLEN(NFS4_OPAQUE_LIMIT))
 #define decode_copy_maxsz		(op_decode_hdr_maxsz + \
 					 NFS42_WRITE_RES_SIZE + \
 					 1 /* cr_consecutive */ + \
@@ -216,7 +219,12 @@ static void encode_copy(struct xdr_stream *xdr,
 
 	encode_uint32(xdr, 1); /* consecutive = true */
 	encode_uint32(xdr, args->sync);
-	encode_uint32(xdr, 0); /* src server list */
+	if (args->cp_src == NULL) { /* intra-ssc */
+		encode_uint32(xdr, 0); /* no src server list */
+		return;
+	}
+	encode_uint32(xdr, 1); /* supporting 1 server */
+	encode_nl4_server(xdr, args->cp_src);
 }
 
 static void encode_offload_cancel(struct xdr_stream *xdr,
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 4e54432feb3b..b9825d02443e 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -134,6 +134,8 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 				      size_t count, unsigned int flags)
 {
 	struct nfs42_copy_notify_res *cn_resp = NULL;
+	struct nl4_server *nss = NULL;
+	nfs4_stateid *cnrs = NULL;
 	ssize_t ret;
 
 	/* Only offload copy if superblock is the same */
@@ -154,8 +156,11 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 			ret = -EOPNOTSUPP;
 			goto out;
 		}
+		nss = &cn_resp->cnr_src;
+		cnrs = &cn_resp->cnr_stateid;
 	}
-	ret = nfs42_proc_copy(file_in, pos_in, file_out, pos_out, count);
+	ret = nfs42_proc_copy(file_in, pos_in, file_out, pos_out, count,
+				nss, cnrs);
 out:
 	kfree(cn_resp);
 	return ret;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 0a7af40026d7..008facac8a30 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1435,6 +1435,7 @@ struct nfs42_copy_args {
 
 	u64				count;
 	bool				sync;
+	struct nl4_server		*cp_src;
 };
 
 struct nfs42_write_res {
-- 
2.18.1

