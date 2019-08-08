Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB4DC86B4B
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Aug 2019 22:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404695AbfHHUS7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Aug 2019 16:18:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45314 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404699AbfHHUS6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Aug 2019 16:18:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id x21so30525206otq.12
        for <linux-nfs@vger.kernel.org>; Thu, 08 Aug 2019 13:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=96csoeLSjTb50KBiWwpM8v2p5EFPAXKbclrkTbMvXN8=;
        b=HH2XgA1XUs5jRiCppJ33swhlz+rguAhdmrfJzDZDz7ZI/Nz4XIIuCj396BfizbKm9Q
         4iSUTqk6auIbdARhvyhuUrVFAPU0u0hN3jddrxwpL66+LLbNR+8rlitKG6V8hilP/CID
         qii/JLANI44iuEbSdU1kumfqgG0yk8Y4q4chhR9CxsxK6wxuGAeeYLopiXZc71l0Os2P
         qg7+DzvanYRykz9M7HQRU97ij0UzC95Ro4jCm3w8VxRqDtoguG3uGlL33eG+ooDJaY+A
         pZ87Jysp+h+Ly6AJuwnxVYz17gf0PbmaD2Xcj8NY/RYGE9YYRm+TueQbHkYkggi+mTb3
         CuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=96csoeLSjTb50KBiWwpM8v2p5EFPAXKbclrkTbMvXN8=;
        b=GfoSTkutqgUj+//hQCIF09Bntf7kEeTkfeWiweIGy+CasYDr77SFBtnJl05iKDthXB
         c8fQ3ga93nAeVLwuo9UqGz54bEN0QWUl1VysBQgvmQpNQBmRimkFIBhB02lJ1xKKfxFt
         B7ttMCc0xupoTugpD9jshmXukOmgiUcr6syRA+NexpXrhZSBrXRwdIna7roxM1c7iK/1
         d3AmIPqf8DGgAMR13FUMnOTKg++FPEWA2lJAqQGrRqKEbd8SFDm1LxO07C2FrMKMLYDl
         uDB0AESeQ5Q4nHLxCZSuWC8o2yU5iciIgiM2nSUUMVQj8IPPr2pTh/HTFuxPxbdhsn4P
         NdYw==
X-Gm-Message-State: APjAAAXaLC34M8lm3g0YvVCSsBm3F5T/WhrDlfiI37V1N/1yr9DuiAmA
        dJD0jCKJoz++lU1q4CnKQeM=
X-Google-Smtp-Source: APXvYqye4A2ltRkTzr7Gp+YYtcM+lSAE/08Ah8NdJRpaiC0QFlCV3mqe9gHCGzijLNhWkQmmXksk4g==
X-Received: by 2002:a05:6602:cc:: with SMTP id z12mr759190ioe.86.1565295537931;
        Thu, 08 Aug 2019 13:18:57 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id m20sm93590523ioh.4.2019.08.08.13.18.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 13:18:57 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 8/9] NFSD: allow inter server COPY to have a STALE source server fh
Date:   Thu,  8 Aug 2019 16:18:47 -0400
Message-Id: <20190808201848.36640-9-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
References: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The inter server to server COPY source server filehandle
is a foreign filehandle as the COPY is sent to the destination
server.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/Kconfig    | 10 +++++++++
 fs/nfsd/nfs4proc.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfsfh.h    |  5 ++++-
 fs/nfsd/xdr4.h     |  1 +
 4 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index d25f6bb..bef3a58 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -132,6 +132,16 @@ config NFSD_FLEXFILELAYOUT
 
 	  If unsure, say N.
 
+config NFSD_V4_2_INTER_SSC
+	bool "NFSv4.2 inter server to server COPY"
+	depends on NFSD_V4 && NFS_V4_1 && NFS_V4_2
+	help
+	  This option enables support for NFSv4.2 inter server to
+	  server copy where the destination server calls the NFSv4.2
+	  client to read the data to copy from the source server.
+
+	  If unsure, say N.
+
 config NFSD_V4_SECURITY_LABEL
 	bool "Provide Security Label support for NFSv4 server"
 	depends on NFSD_V4 && SECURITY
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ef961f1..e5a8da1 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -504,12 +504,20 @@ static __be32 nfsd4_open_omfg(struct svc_rqst *rqstp, struct nfsd4_compound_stat
 	    union nfsd4_op_u *u)
 {
 	struct nfsd4_putfh *putfh = &u->putfh;
+	__be32 ret;
 
 	fh_put(&cstate->current_fh);
 	cstate->current_fh.fh_handle.fh_size = putfh->pf_fhlen;
 	memcpy(&cstate->current_fh.fh_handle.fh_base, putfh->pf_fhval,
 	       putfh->pf_fhlen);
-	return fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
+	ret = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+	if (ret == nfserr_stale && putfh->no_verify) {
+		SET_FH_FLAG(&cstate->current_fh, NFSD4_FH_FOREIGN);
+		ret = 0;
+	}
+#endif
+	return ret;
 }
 
 static __be32
@@ -1967,6 +1975,45 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
 		- rqstp->rq_auth_slack;
 }
 
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+static __be32
+check_if_stalefh_allowed(struct nfsd4_compoundargs *args)
+{
+	struct nfsd4_op	*op, *current_op, *saved_op;
+	struct nfsd4_copy *copy;
+	struct nfsd4_putfh *putfh;
+	int i;
+
+	/* traverse all operation and if it's a COPY compound, mark the
+	 * source filehandle to skip verification
+	 */
+	for (i = 0; i < args->opcnt; i++) {
+		op = &args->ops[i];
+		if (op->opnum == OP_PUTFH)
+			current_op = op;
+		else if (op->opnum == OP_SAVEFH)
+			saved_op = current_op;
+		else if (op->opnum == OP_RESTOREFH)
+			current_op = saved_op;
+		else if (op->opnum == OP_COPY) {
+			copy = (struct nfsd4_copy *)&op->u;
+			if (!saved_op)
+				return nfserr_nofilehandle;
+			putfh = (struct nfsd4_putfh *)&saved_op->u;
+			if (!copy->cp_intra)
+				putfh->no_verify = true;
+		}
+	}
+	return nfs_ok;
+}
+#else
+static __be32
+check_if_stalefh_allowed(struct nfsd4_compoundargs *args)
+{
+	return nfs_ok;
+}
+#endif
+
 /*
  * COMPOUND call.
  */
@@ -2015,6 +2062,9 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
 		resp->opcnt = 1;
 		goto encode_op;
 	}
+	status = check_if_stalefh_allowed(args);
+	if (status)
+		goto out;
 
 	trace_nfsd_compound(rqstp, args->opcnt);
 	while (!status && resp->opcnt < args->opcnt) {
@@ -2030,13 +2080,14 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
 				op->status = nfsd4_open_omfg(rqstp, cstate, op);
 			goto encode_op;
 		}
-
-		if (!current_fh->fh_dentry) {
+		if (!current_fh->fh_dentry &&
+				!HAS_FH_FLAG(current_fh, NFSD4_FH_FOREIGN)) {
 			if (!(op->opdesc->op_flags & ALLOWED_WITHOUT_FH)) {
 				op->status = nfserr_nofilehandle;
 				goto encode_op;
 			}
-		} else if (current_fh->fh_export->ex_fslocs.migrated &&
+		} else if (current_fh->fh_export &&
+			   current_fh->fh_export->ex_fslocs.migrated &&
 			  !(op->opdesc->op_flags & ALLOWED_ON_ABSENT_FS)) {
 			op->status = nfserr_moved;
 			goto encode_op;
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 755e256..b9c7568 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -35,7 +35,7 @@ static inline ino_t u32_to_ino_t(__u32 uino)
 
 	bool			fh_locked;	/* inode locked by us */
 	bool			fh_want_write;	/* remount protection taken */
-
+	int			fh_flags;	/* FH flags */
 #ifdef CONFIG_NFSD_V3
 	bool			fh_post_saved;	/* post-op attrs saved */
 	bool			fh_pre_saved;	/* pre-op attrs saved */
@@ -56,6 +56,9 @@ static inline ino_t u32_to_ino_t(__u32 uino)
 #endif /* CONFIG_NFSD_V3 */
 
 } svc_fh;
+#define NFSD4_FH_FOREIGN (1<<0)
+#define SET_FH_FLAG(c, f) ((c)->fh_flags |= (f))
+#define HAS_FH_FLAG(c, f) ((c)->fh_flags & (f))
 
 enum nfsd_fsid {
 	FSID_DEV = 0,
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 687f81d..d76f9be 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -221,6 +221,7 @@ struct nfsd4_lookup {
 struct nfsd4_putfh {
 	u32		pf_fhlen;           /* request */
 	char		*pf_fhval;          /* request */
+	bool		no_verify;	    /* represents foreigh fh */
 };
 
 struct nfsd4_open {
-- 
1.8.3.1

