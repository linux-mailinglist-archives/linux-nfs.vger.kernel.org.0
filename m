Return-Path: <linux-nfs+bounces-3613-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D106390069A
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552121F23FE6
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB92198E7D;
	Fri,  7 Jun 2024 14:27:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C757198E7F
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770454; cv=none; b=UM58kwpq4MPsw9R9dFWtu8ZI0u6YsChPxa5yhrrfrht8HT887U5WRbPiUprtWsZzVcd3s/IZcLwvYtMdqES6cRuzsKa37+bMUZa7BpvTHGKQKPyVldyFZ6rjz5TNxS7nZfyLyN5mnZzx69JfXHvJm53av4GXfbTgbGEKxhlJtqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770454; c=relaxed/simple;
	bh=PnbZ2rAVwSTpr8VMXXeufiYQ6cwjrQBGlajXR2yonAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eU1/2FFSVAZsCtoIPm2Q5i95Y+AkgeQajAM9Kd4eEJz/h0+miwEEG+ttrJZdU6yoOix+iCMqxWSrO40uNJl5TGVCuyX8AxthncXCjnDGAbuw4zVJJWqIWNJLidZVYe0TnydkiGfGCXP9oVrSL83GK0x9bBHOdzoh9LpqYv7aOCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44030e79ed4so10110321cf.1
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770452; x=1718375252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnRfIXMBCXp6mDxxGEDpH55Hza44GJ6WYKe/SX8RBgk=;
        b=p+xYLS3hFZyQgJ8c0OI2qoSuzE75H6SIj0NF5OfTIcayCrALn05BH8jriapOGl7+57
         mYrvVZ+FUrrejAlxenz+GAkZESNoxaRv/YkZDZ6AHc/1lTCP53dJFFTlO1JpLF8L+lg+
         96QJmw0k/MceXeeEh98QSciOQW+cru73WBgpl91t+NV1lSWs/bHuvtqggmNbPZaFeeHD
         B5cbHFp9QFG/gXv5IkdlAxjpMFv45n76HN6j0QswuYBjIuCkzAGhlAf/qQ2iyIUJAK7n
         IPj39M0HG7qcDFe9MUb5a6RsaZDWOdAO0vFFu7XlGTF0LyOWArLbVcc3OPzH4qYwGM+j
         oWNA==
X-Gm-Message-State: AOJu0YyUA1sJYI6TitVAK7gl3rFuUveXGmJTPi+rjE2j1tjxOgVSySD0
	oxPWrurxrfVrYzDepzD4Z+tTFF495QjeSuZiyD0jsIkdVsAB7YAC1u+guDcCqGf+9tx7n9WtUrY
	rqqI=
X-Google-Smtp-Source: AGHT+IE085ZM4YMliyeopPR2l9fzkNNqfhIk4wkhMIkE9Qtmix8DbCOTogjs0ksuj5/qW03/DFjJrA==
X-Received: by 2002:ac8:5257:0:b0:440:4735:7bb7 with SMTP id d75a77b69052e-44047357d7dmr18233631cf.1.1717770451770;
        Fri, 07 Jun 2024 07:27:31 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4404a8ee860sm3941211cf.94.2024.06.07.07.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:31 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 28/29] nfs/nfsd: consolidate {encode,decode}_opaque_fixed in nfs_xdr.h
Date: Fri,  7 Jun 2024 10:26:45 -0400
Message-ID: <20240607142646.20924-29-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607142646.20924-1-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eliminates duplicate functions in various files.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c |  6 ------
 fs/nfs/nfs3xdr.c                       |  9 ---------
 fs/nfs/nfs4xdr.c                       | 13 -------------
 fs/nfsd/localio.c                      |  7 ++-----
 include/linux/nfs_xdr.h                | 20 +++++++++++++++++++-
 5 files changed, 21 insertions(+), 34 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 0a9eccb44085..c2681ebd553c 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -2185,12 +2185,6 @@ static int ff_layout_encode_ioerr(struct xdr_stream *xdr,
 	return ff_layout_encode_ds_ioerr(xdr, &ff_args->errors);
 }
 
-static void
-encode_opaque_fixed(struct xdr_stream *xdr, const void *buf, size_t len)
-{
-	WARN_ON_ONCE(xdr_stream_encode_opaque_fixed(xdr, buf, len) < 0);
-}
-
 static void
 ff_layout_encode_ff_iostat_head(struct xdr_stream *xdr,
 			    const nfs4_stateid *stateid,
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index d2a17ecd12b8..95a2fb0733ae 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -2591,15 +2591,6 @@ static void nfs3_xdr_enc_getuuidargs(struct rpc_rqst *req,
 	/* void function */
 }
 
-// FIXME: factor out from fs/nfs/nfs4xdr.c
-static int decode_opaque_fixed(struct xdr_stream *xdr, void *buf, size_t len)
-{
-	ssize_t ret = xdr_stream_decode_opaque_fixed(xdr, buf, len);
-	if (unlikely(ret < 0))
-		return -EIO;
-	return 0;
-}
-
 static inline int nfs3_decode_getuuidresok(struct xdr_stream *xdr,
 					struct nfs_getuuidres *result)
 {
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index d3b4fa3245f0..6b35b1d7d7ce 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -968,11 +968,6 @@ static __be32 *reserve_space(struct xdr_stream *xdr, size_t nbytes)
 	return p;
 }
 
-static void encode_opaque_fixed(struct xdr_stream *xdr, const void *buf, size_t len)
-{
-	WARN_ON_ONCE(xdr_stream_encode_opaque_fixed(xdr, buf, len) < 0);
-}
-
 static void encode_string(struct xdr_stream *xdr, unsigned int len, const char *str)
 {
 	WARN_ON_ONCE(xdr_stream_encode_opaque(xdr, str, len) < 0);
@@ -4352,14 +4347,6 @@ static int decode_access(struct xdr_stream *xdr, u32 *supported, u32 *access)
 	return 0;
 }
 
-static int decode_opaque_fixed(struct xdr_stream *xdr, void *buf, size_t len)
-{
-	ssize_t ret = xdr_stream_decode_opaque_fixed(xdr, buf, len);
-	if (unlikely(ret < 0))
-		return -EIO;
-	return 0;
-}
-
 static int decode_stateid(struct xdr_stream *xdr, nfs4_stateid *stateid)
 {
 	return decode_opaque_fixed(xdr, stateid, NFS4_STATEID_SIZE);
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index ace99f371c13..c4324a0fff57 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -8,6 +8,8 @@
 #include <linux/sunrpc/svcauth_gss.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/nfs.h>
+#include <linux/nfs_fs.h>
+#include <linux/nfs_xdr.h>
 #include <linux/string.h>
 
 #include "nfsd.h"
@@ -203,11 +205,6 @@ static __be32 nfsd_proc_getuuid(struct svc_rqst *rqstp)
 
 #define NFS_getuuid_sz XDR_QUADLEN(UUID_SIZE)
 
-static inline void encode_opaque_fixed(struct xdr_stream *xdr, const void *buf, size_t len)
-{
-	WARN_ON_ONCE(xdr_stream_encode_opaque_fixed(xdr, buf, len) < 0);
-}
-
 static void encode_uuid(struct xdr_stream *xdr, uuid_t *src_uuid)
 {
 	u8 uuid[UUID_SIZE];
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 2a438f4c2d6d..daa4115f6be6 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1826,6 +1826,24 @@ struct nfs_rpc_ops {
 	void	(*init_localioclient)(struct nfs_client *);
 };
 
+/*
+ * Helper functions used by NFS client and/or server
+ */
+static inline void encode_opaque_fixed(struct xdr_stream *xdr,
+				       const void *buf, size_t len)
+{
+	WARN_ON_ONCE(xdr_stream_encode_opaque_fixed(xdr, buf, len) < 0);
+}
+
+static inline int decode_opaque_fixed(struct xdr_stream *xdr,
+				      void *buf, size_t len)
+{
+	ssize_t ret = xdr_stream_decode_opaque_fixed(xdr, buf, len);
+	if (unlikely(ret < 0))
+		return -EIO;
+	return 0;
+}
+
 /*
  * Function vectors etc. for the NFS client
  */
@@ -1844,4 +1862,4 @@ extern const struct rpc_program nfslocalio_program3;
 extern const struct rpc_version nfslocalio_version4;
 extern const struct rpc_program nfslocalio_program4;
 
-#endif
+#endif /* _LINUX_NFS_XDR_H */
-- 
2.44.0


