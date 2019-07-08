Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2011262944
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 21:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391653AbfGHTX6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 15:23:58 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34440 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbfGHTX6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jul 2019 15:23:58 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so37940521iot.1
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2019 12:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sknz4OyGK6wIft4IFNA/PN7brpN8OWGiEywebLIHXKQ=;
        b=Cv3P9G8dbCF50tdkmhmip7B0oGmdrDhDx2Qi2yajF1uWPN6axW26gj5Qtve9pebuSW
         VgTT9ZrvfL4cZ3yrjtddcUrguOLNmOVac1rVCeP1fLc9ZFZ4OBH7AKn3rSTHO4b+ndg+
         gdNq8PbqBpls5VvjVy/FAg+q1kn6Vp/EJUdAWDNM1+ik/8VbtvA5tXNHnwBeN251wQsJ
         ugmTRGnj2o2l9d1HwA04K6Q27+hPfwWCAEFDJejXEiCcrWLALCgnN27na5CBuBaAWqxe
         roWHYFA6uq8bnGSREsJR3gX5gyN/UXhb3Prnh5GhKuFJUWeOkaxkdslDrEhx0Jpd4uWv
         /3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sknz4OyGK6wIft4IFNA/PN7brpN8OWGiEywebLIHXKQ=;
        b=rPJdXqFGOldyJV3wy+q65HRw4dLB+MvoIFd53NlnOiAIeWNgA891r8Bpq2KueY4viT
         nOWCRtJTiLEPuX9l25ocoOW5U3Z4PCBlru2p6x2MKlCVRq77HBzRSz3gAQka7OBp4ge4
         0V28mtk5EoD4LoWHEPWQGDA6Jp9Az6sHqjhp+eSTwethRHfmTnzd1z6GXtE4WMhhQ4Ze
         rv5TGI7wo3y7WYesIFnJe5mZ0tyyKZUI8MHH8t6S6afI7F+8g4lH5sBegwmL69D90Cli
         s8tsyNrUdAg9YIra/R8+pOP7BtDGFJLGJSwrIxLw0dSiqMfnFL3w2NsJkeUsEPm+vxuO
         gOog==
X-Gm-Message-State: APjAAAU/FnFFts/anX5Q1qQNx+Xr6NUb8r7GdDHmv7jaqzmngQsTEBUH
        l6SUxmA8kbKfyfhS6CM8tXY=
X-Google-Smtp-Source: APXvYqzvPt+bDh1ZGykOG8ttYNuPwdYzRhJCQiqnbQdMRLQsT2JJrS02L2KLtUUYCNFXzbgFXXBiTQ==
X-Received: by 2002:a5d:88c6:: with SMTP id i6mr10308417iol.107.1562613836857;
        Mon, 08 Jul 2019 12:23:56 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id v3sm9212841iom.53.2019.07.08.12.23.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 12:23:56 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 7/8] NFSD: allow inter server COPY to have a STALE source server fh
Date:   Mon,  8 Jul 2019 15:23:51 -0400
Message-Id: <20190708192352.12614-8-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The inter server to server COPY source server filehandle
is a foreign filehandle as the COPY is sent to the destination
server.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/Kconfig    | 10 ++++++++++
 fs/nfsd/nfs4proc.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfsfh.h    |  5 ++++-
 fs/nfsd/xdr4.h     |  1 +
 4 files changed, 64 insertions(+), 5 deletions(-)

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
index 8c2273e..1039528 100644
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
@@ -1956,6 +1964,41 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
 		- rqstp->rq_auth_slack;
 }
 
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+static void
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
+			putfh = (struct nfsd4_putfh *)&saved_op->u;
+			if (!copy->cp_intra)
+				putfh->no_verify = true;
+		}
+	}
+}
+#else
+static void
+check_if_stalefh_allowed(struct nfsd4_compoundargs *args)
+{
+}
+#endif
+
 /*
  * COMPOUND call.
  */
@@ -2004,6 +2047,7 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
 		resp->opcnt = 1;
 		goto encode_op;
 	}
+	check_if_stalefh_allowed(args);
 
 	trace_nfsd_compound(rqstp, args->opcnt);
 	while (!status && resp->opcnt < args->opcnt) {
@@ -2019,13 +2063,14 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
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
index 9d7318c..fbd18d6 100644
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

