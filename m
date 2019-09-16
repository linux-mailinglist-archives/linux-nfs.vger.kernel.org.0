Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9516CB42BF
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 23:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391497AbfIPVOB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 17:14:01 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33267 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfIPVOB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 17:14:01 -0400
Received: by mail-io1-f65.google.com with SMTP id m11so2570415ioo.0
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YMyVf3I47kNKbA6GqxE4gvBgqowMm+G+DipklXenmZE=;
        b=IfSBCHCIQJeZQfTzUoB+13w61WzUzZaS9dqlAMMz7pin3jq08myNg6hDtyVfh+zACW
         iu2TQRpD6HzpmbMTBOgsr/jbwWRdJLCkXwv16bK+wnBc+1bbv0P8dgzYNB2A+HVnTDDV
         pnWZaE3twGKl4QVbqjPMDb2btFimB+jXGUPUA3HVjkB54XLoT78ACLGLWRqpDPwqigei
         jUva2POs70hHavp9WyXD0OJGf8+9Yb2CVbQmNC1xOM8hgM0OKa7ah0FcuFGBYdM7FTST
         7mMBwmu+2AQzF+sjgKyRWsWHPuApaim2bBXOV2Ine6Pn4bme2R6iGfF43vRTgxl2rt9t
         j6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YMyVf3I47kNKbA6GqxE4gvBgqowMm+G+DipklXenmZE=;
        b=ul/+1ekLqIkUDrQJX1vHz9Ufv6KdS32jkiGpSEnfgKuOY7BuPchUw+DmNo/fE3VVKz
         wKjvMD3f60iNwX49QY4CcXeNVvZieQaZRKPaFCB+EyP6kT/fJKUsT9sNJgvu+DnQ2T66
         HchtnP5/E5J2xHWCQMgJQyVtO5hzCO3wFWzUr0doxz24hYemIpNxYqUwGP+3T3X83DcE
         /bgPb7M3vZ+2FIe3Kh0F5BWbrex58pdR3AG24Pw/2nDlm1nq/7UPNCfr3d/YGXxxnQNE
         eVQvPC35cG4uwas9toIsgj0oAuNXMt5zWngKA4Q4UL3TAJnCp+mP2y2f8fLNDmmRuz3/
         9cgA==
X-Gm-Message-State: APjAAAXH6dFHMjZUcAao/jQUF0GPFykRUJVuZKSmEp8PCEGMlwxR1icP
        0dFD8ofpy6zpkpN7wg6k2a4=
X-Google-Smtp-Source: APXvYqwCmjjJTUVDK24dw8yTzMZW9vCDcb7oIuEV9FxUAy2x/Cmel6CRDi0RyR286HhpqlQio/6m4g==
X-Received: by 2002:a5e:960f:: with SMTP id a15mr358669ioq.13.1568668438742;
        Mon, 16 Sep 2019 14:13:58 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l186sm71853ioa.54.2019.09.16.14.13.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 14:13:58 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 03/19] NFS: add ca_source_server<> to COPY
Date:   Mon, 16 Sep 2019 17:13:37 -0400
Message-Id: <20190916211353.18802-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
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
index 4995731..02e3810 100644
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
index 6317dd8..e34ade8 100644
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
index ccabc0c..c03f324 100644
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
index 8d845ef..1bec960 100644
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
index 0a7af40..008faca 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1435,6 +1435,7 @@ struct nfs42_copy_args {
 
 	u64				count;
 	bool				sync;
+	struct nl4_server		*cp_src;
 };
 
 struct nfs42_write_res {
-- 
1.8.3.1

