Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894E3405DEF
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Sep 2021 22:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245620AbhIIUOv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Sep 2021 16:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbhIIUOr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Sep 2021 16:14:47 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0E3C061574
        for <linux-nfs@vger.kernel.org>; Thu,  9 Sep 2021 13:13:38 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id r21so2590486qtw.11
        for <linux-nfs@vger.kernel.org>; Thu, 09 Sep 2021 13:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9CV4sf0ktH7OKVIRf3Ydps98+HVvU2Dr196Z1OYIKzk=;
        b=KVhEBDr/W21ia1GQrxzOX3IZkBQOIp3nR0p28F+HU8TjU7qqBwINYqvHFyEOqXfNgI
         mIAIrdoG5svD8Zax6bLCP0+FaVFivJTz2LcDK7LaFOpug5IJv3QGeXrmsZcKNXsWSqbC
         J1xyweNINls6bipeUmTPSTrQWJfoKi7ByJ5X8IrE+Nl9Y5qZELRBXftE1hNOnLJ5HX9Z
         a/CMHdGMqeU+ZBZGeUT+ALDtZqJx2enPkC5Rg0fkRacvJRQNyB2qZQsu/h7t7VNcW/z0
         cEv705NOSLIYqCJZEZgYeEy61PrSj/IV4e2FL+bbD1jEFRUWy+dtio5xWkng7Vzt79y+
         RhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9CV4sf0ktH7OKVIRf3Ydps98+HVvU2Dr196Z1OYIKzk=;
        b=c9v/J0hzbXaJ+SvGBywrc5aI7vwHK2EZPYGJYxTmuMC8Q4kX/5K9AzdLe1d1iEDRYU
         6GuzOKtSzrn8ipGsVV0D9uPHceCN/rpuU7Ba8t95TS1IFFf2YODOX/d1CJZ8xFUEi1XT
         9xIZM7zFq8xWj4LcHLwx/QXfPmpqiaiuDinaSF/dGBzscFTU74w08knGnmmWt78WYDIG
         cz8W7mjLxb3UCi/Go5+aicLVPPVgjXptI/n//S/0u8n0po2EYvRJxz7mr1UxqQdVlSUg
         /2+o+I/OuEOfC2twH6XF3AVZZmMWo/E2UoGOHyCRxSrsRfYa1+caiWeQzGhIGIIV9Fff
         XP9g==
X-Gm-Message-State: AOAM530EYstpRZdiATg1miXT6ifXNmGQpBwWRYVNGfa95mJRhgRnJ6Li
        FGvFB+YluQv/QEBRbPnhiRg=
X-Google-Smtp-Source: ABdhPJwhusWpXGb3p3rnKLR/KqMHUYNRcB2V3vb9uPCr9fZa8qKG3KKYGCT+HLkwu/fjWBX422BpGg==
X-Received: by 2002:a05:622a:15d0:: with SMTP id d16mr4540904qty.185.1631218417230;
        Thu, 09 Sep 2021 13:13:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id l13sm2104020qkp.97.2021.09.09.13.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:13:36 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 14/14] NFS: Remove the nfs4_label argument from decode_getattr_*() functions
Date:   Thu,  9 Sep 2021 16:13:27 -0400
Message-Id: <20210909201327.108759-15-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210909201327.108759-1-Anna.Schumaker@Netapp.com>
References: <20210909201327.108759-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Wa can check if the fattr has an allocated label when needed

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs4xdr.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 5c7d37633cc8..1e3b1db7afa9 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4582,8 +4582,7 @@ static int decode_attr_mdsthreshold(struct xdr_stream *xdr,
 
 static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
 		struct nfs_fattr *fattr, struct nfs_fh *fh,
-		struct nfs4_fs_locations *fs_loc, struct nfs4_label *label,
-		const struct nfs_server *server)
+		struct nfs4_fs_locations *fs_loc, const struct nfs_server *server)
 {
 	int status;
 	umode_t fmode = 0;
@@ -4698,8 +4697,8 @@ static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
 	if (status < 0)
 		goto xdr_error;
 
-	if (label) {
-		status = decode_attr_security_label(xdr, bitmap, label);
+	if (fattr->label) {
+		status = decode_attr_security_label(xdr, bitmap, fattr->label);
 		if (status < 0)
 			goto xdr_error;
 		fattr->valid |= status;
@@ -4712,7 +4711,7 @@ static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
 
 static int decode_getfattr_generic(struct xdr_stream *xdr, struct nfs_fattr *fattr,
 		struct nfs_fh *fh, struct nfs4_fs_locations *fs_loc,
-		struct nfs4_label *label, const struct nfs_server *server)
+		const struct nfs_server *server)
 {
 	unsigned int savep;
 	uint32_t attrlen,
@@ -4731,8 +4730,7 @@ static int decode_getfattr_generic(struct xdr_stream *xdr, struct nfs_fattr *fat
 	if (status < 0)
 		goto xdr_error;
 
-	status = decode_getfattr_attrs(xdr, bitmap, fattr, fh, fs_loc,
-					label, server);
+	status = decode_getfattr_attrs(xdr, bitmap, fattr, fh, fs_loc, server);
 	if (status < 0)
 		goto xdr_error;
 
@@ -4742,16 +4740,10 @@ static int decode_getfattr_generic(struct xdr_stream *xdr, struct nfs_fattr *fat
 	return status;
 }
 
-static int decode_getfattr_label(struct xdr_stream *xdr, struct nfs_fattr *fattr,
-		struct nfs4_label *label, const struct nfs_server *server)
-{
-	return decode_getfattr_generic(xdr, fattr, NULL, NULL, label, server);
-}
-
 static int decode_getfattr(struct xdr_stream *xdr, struct nfs_fattr *fattr,
 		const struct nfs_server *server)
 {
-	return decode_getfattr_generic(xdr, fattr, NULL, NULL, NULL, server);
+	return decode_getfattr_generic(xdr, fattr, NULL, NULL, server);
 }
 
 /*
@@ -6179,7 +6171,7 @@ static int nfs4_xdr_dec_lookup(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 	status = decode_getfh(xdr, res->fh);
 	if (status)
 		goto out;
-	status = decode_getfattr_label(xdr, res->fattr, res->fattr->label, res->server);
+	status = decode_getfattr(xdr, res->fattr, res->server);
 out:
 	return status;
 }
@@ -6209,7 +6201,7 @@ static int nfs4_xdr_dec_lookupp(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 	status = decode_getfh(xdr, res->fh);
 	if (status)
 		goto out;
-	status = decode_getfattr_label(xdr, res->fattr, res->fattr->label, res->server);
+	status = decode_getfattr(xdr, res->fattr, res->server);
 out:
 	return status;
 }
@@ -6236,8 +6228,7 @@ static int nfs4_xdr_dec_lookup_root(struct rpc_rqst *rqstp,
 		goto out;
 	status = decode_getfh(xdr, res->fh);
 	if (status == 0)
-		status = decode_getfattr_label(xdr, res->fattr,
-						res->fattr->label, res->server);
+		status = decode_getfattr(xdr, res->fattr, res->server);
 out:
 	return status;
 }
@@ -6331,7 +6322,7 @@ static int nfs4_xdr_dec_link(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 	status = decode_restorefh(xdr);
 	if (status)
 		goto out;
-	decode_getfattr_label(xdr, res->fattr, res->fattr->label, res->server);
+	decode_getfattr(xdr, res->fattr, res->server);
 out:
 	return status;
 }
@@ -6361,7 +6352,7 @@ static int nfs4_xdr_dec_create(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 	status = decode_getfh(xdr, res->fh);
 	if (status)
 		goto out;
-	decode_getfattr_label(xdr, res->fattr, res->fattr->label, res->server);
+	decode_getfattr(xdr, res->fattr, res->server);
 out:
 	return status;
 }
@@ -6394,7 +6385,7 @@ static int nfs4_xdr_dec_getattr(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 	status = decode_putfh(xdr);
 	if (status)
 		goto out;
-	status = decode_getfattr_label(xdr, res->fattr, res->fattr->label, res->server);
+	status = decode_getfattr(xdr, res->fattr, res->server);
 out:
 	return status;
 }
@@ -6532,7 +6523,7 @@ static int nfs4_xdr_dec_open(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 		goto out;
 	if (res->access_request)
 		decode_access(xdr, &res->access_supported, &res->access_result);
-	decode_getfattr_label(xdr, res->f_attr, res->f_attr->label, res->server);
+	decode_getfattr(xdr, res->f_attr, res->server);
 	if (res->lg_res)
 		decode_layoutget(xdr, rqstp, res->lg_res);
 out:
@@ -6616,7 +6607,7 @@ static int nfs4_xdr_dec_setattr(struct rpc_rqst *rqstp,
 	status = decode_setattr(xdr);
 	if (status)
 		goto out;
-	decode_getfattr_label(xdr, res->fattr, res->fattr->label, res->server);
+	decode_getfattr(xdr, res->fattr, res->server);
 out:
 	return status;
 }
@@ -7031,7 +7022,7 @@ static int nfs4_xdr_dec_fs_locations(struct rpc_rqst *req,
 		status = decode_getfattr_generic(xdr,
 					&res->fs_locations->fattr,
 					 NULL, res->fs_locations,
-					 NULL, res->fs_locations->server);
+					 res->fs_locations->server);
 		if (status)
 			goto out;
 		if (res->renew)
@@ -7044,7 +7035,7 @@ static int nfs4_xdr_dec_fs_locations(struct rpc_rqst *req,
 		status = decode_getfattr_generic(xdr,
 					&res->fs_locations->fattr,
 					 NULL, res->fs_locations,
-					 NULL, res->fs_locations->server);
+					 res->fs_locations->server);
 	}
 out:
 	return status;
@@ -7475,7 +7466,7 @@ int nfs4_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 		return -EAGAIN;
 
 	if (decode_getfattr_attrs(xdr, bitmap, entry->fattr, entry->fh,
-			NULL, entry->fattr->label, entry->server) < 0)
+			NULL, entry->server) < 0)
 		return -EAGAIN;
 	if (entry->fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID)
 		entry->ino = entry->fattr->mounted_on_fileid;
-- 
2.33.0

