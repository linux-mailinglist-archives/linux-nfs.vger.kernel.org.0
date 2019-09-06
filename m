Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B69CAC33F
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Sep 2019 01:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393168AbfIFXgf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 19:36:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44037 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392973AbfIFXge (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 19:36:34 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so16575429iog.11
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 16:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I5j82+sud6wMr9HQ0K7nLnJPiyyIsxbeQdF7mdSedEE=;
        b=l6J8q7S7gUqPz79UmQYPpZVh4PhC5DtRwV4h7C29/hYDlWXMVo1MhAGmpgKhdafokV
         la12U/i8gM2HLCEJULRxR08eQiKY+rlFE0rG++d9JqlsZ5Zgv2sh7TuoYiB1bSjXS9aW
         z7fkHqvHlrIkojkXqY1oS92XGPNpn+j5xQ2DVU6XhyH2h/ci4dR2zTk00hOlQ8v+pxYn
         cKrDWBcMiuoNxiiZRJ4NBF+jhytBFrrJ28mZIdURHivVkilJg0ttVz8aawMxhNAa6Eby
         PULJi7sCxzPmp3fs83YtcA4GOy3UGrlh6F36gwvfFsOa3AKB5o/Bj7+sJj1ufVigFy+V
         iDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I5j82+sud6wMr9HQ0K7nLnJPiyyIsxbeQdF7mdSedEE=;
        b=OD3WK+VNKVzZCct64ABgPQ9RaJblG8mqBh4x44lhuV0FopaQYu3Tx5MN1h5aN2pQVp
         n2Xd1QgyhI2Cxhifoexht+XRqTKV0AiGV/sQCtTVv9dg27WHw5T2UFTt0Oj+uKq0iHzr
         Zd1H2RRd3fvstC6U13H1Dhy2m4J4sW3DybQhFqhXJiFAxs6OToSqXs7YZ6eedp4MqGSr
         zPs55H4Pgxq/Pdt5qfo8e7SZO5nQvqShNfOg7mi6pbABQZf2/5Iijk14BB7DEETWEPpa
         0+WNzgNocIQCkEuZTjeT/oc+LODJftSDPHawnV94s9ypYU6L1pGqOsycrIoUH3XpEQIQ
         J4Ig==
X-Gm-Message-State: APjAAAWoDBCYd9GcK9guQUq66dIQogKxS5DtwB2qcXlGwvuqWBJwP2Hn
        RVVw9yrgbjd/qLSLHYEeGGA=
X-Google-Smtp-Source: APXvYqyToYHds6g9Wj7yeSZV/3XmFsiqHdAjZjUNSqT+MKLX7TF3kAC4+JpL6ydWQ6lc9KNmSn06Qg==
X-Received: by 2002:a02:a513:: with SMTP id e19mr938565jam.56.1567812993055;
        Fri, 06 Sep 2019 16:36:33 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r138sm10439360iod.59.2019.09.06.16.36.32
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 16:36:32 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 20/21] NFSD: allow inter server COPY to have a STALE source server fh
Date:   Fri,  6 Sep 2019 19:36:10 -0400
Message-Id: <20190906233611.4031-21-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
References: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The inter server to server COPY source server filehandle
is a foreign filehandle as the COPY is sent to the destination
server.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/Kconfig    | 10 ++++++++
 fs/nfsd/nfs4proc.c | 59 ++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfsfh.h    |  5 +++-
 fs/nfsd/xdr4.h     |  1 +
 4 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index d25f6bbe7006..bef3a58a6cf7 100644
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
index c38a0ef2ee75..69dd53bec80b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -504,12 +504,20 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -1964,6 +1972,45 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
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
@@ -2012,6 +2059,9 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 		resp->opcnt = 1;
 		goto encode_op;
 	}
+	status = check_if_stalefh_allowed(args);
+	if (status)
+		goto out;
 
 	trace_nfsd_compound(rqstp, args->opcnt);
 	while (!status && resp->opcnt < args->opcnt) {
@@ -2027,13 +2077,14 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
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
index 755e256a9103..b9c75680bc31 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -35,7 +35,7 @@ typedef struct svc_fh {
 
 	bool			fh_locked;	/* inode locked by us */
 	bool			fh_want_write;	/* remount protection taken */
-
+	int			fh_flags;	/* FH flags */
 #ifdef CONFIG_NFSD_V3
 	bool			fh_post_saved;	/* post-op attrs saved */
 	bool			fh_pre_saved;	/* pre-op attrs saved */
@@ -56,6 +56,9 @@ typedef struct svc_fh {
 #endif /* CONFIG_NFSD_V3 */
 
 } svc_fh;
+#define NFSD4_FH_FOREIGN (1<<0)
+#define SET_FH_FLAG(c, f) ((c)->fh_flags |= (f))
+#define HAS_FH_FLAG(c, f) ((c)->fh_flags & (f))
 
 enum nfsd_fsid {
 	FSID_DEV = 0,
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 687f81ddce6b..d76f9beddaf1 100644
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
2.18.1

