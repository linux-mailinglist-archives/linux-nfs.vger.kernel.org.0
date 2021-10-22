Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C27437B9A
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 19:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhJVRN5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 13:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbhJVRNl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 13:13:41 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A936C061764
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:24 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id h65so5471034qke.0
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D8uX/xki72nt+sXdqVs+czvAZ2u+0C0hWjF2S5EFh24=;
        b=cR74pEyJ3naCv7dA/xYN7bvMz/8My/FwIPrqrzlwNQxwSGG7kSQkHyoPO0CbANJ+kN
         2q1c/6bmEm5l38fLZdxo24cEYLZPED5XT5y0PJqMl9bKUMXCO/sWPuU2jBYlSMY0iytw
         tZZYeucKUJFOwo7y2lLRCYnQluZmhE4EcqRw9F+TZc14aDNu2HXxeqtBBe8qcQp6CUBL
         ZZPWRVUVYeoa8TRsv14P9CzgHveldGTj+y1cFBXvyzjHHx5ek5WSvbztC48+vpbHoLHY
         MDrdfw8e/fPtFlm7jybPlxiRES6JzuKNiA+OKyuKNLji3MP9dkP7F91ceeCW/AsL2jSj
         X/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=D8uX/xki72nt+sXdqVs+czvAZ2u+0C0hWjF2S5EFh24=;
        b=74+LFE3u6TZ9XuN8oi6Gdl4UY39j5Tz6R0OVFwAaFM082b+cInyb7z8GSp15wnS3EA
         Ojfb26s71BQY/ZOPsCKWRLMJT5Sy+GKPL0FmCZF51v9v7cvUFpnD3JY02o+HPdPHHJ3z
         Qj2Md2CBsfMUgLt5sdJb9xcigvUfYd3TFTHIPDPAWPNSoLOIHW4b26wCkVCB0sxPSrt9
         S8YnxCeP5qZnPlajlhQZBsM7GWtrROmfJ4V0wlZetibj5yD/TwsYryedvL6PZT5dUPUm
         D2ilKnBZf3Ao8m63+Z7kqVqzjmvtCQNzThnUNekfFGzJiOVJgGkLJOCMeAfXPXeIAZTJ
         divw==
X-Gm-Message-State: AOAM532EoT2Ajbq1sJBX598fb8uY079LMSmre34y/91WiD+qNFyCAOfd
        +z8khOBL9bZjmUpR/vnslZ4=
X-Google-Smtp-Source: ABdhPJxdU/v5vSf/83JdnWk9dVSQiEX0KatXUH+kO99u9WckI5tDxJNpygUAMnh7lM1v0rycJy2YTw==
X-Received: by 2002:a37:a212:: with SMTP id l18mr1149809qke.28.1634922683324;
        Fri, 22 Oct 2021 10:11:23 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id s22sm4484586qko.135.2021.10.22.10.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:11:23 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 14/14] NFS: Remove the nfs4_label argument from decode_getattr_*() functions
Date:   Fri, 22 Oct 2021 13:11:13 -0400
Message-Id: <20211022171113.16739-15-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
References: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
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
2.33.1

