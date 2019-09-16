Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAD7AB42CF
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 23:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391728AbfIPVOP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 17:14:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40355 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391714AbfIPVOO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 17:14:14 -0400
Received: by mail-io1-f66.google.com with SMTP id h144so2453312iof.7
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 14:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6OkpC9E05WzvbRfFRBqu0Uaj19M1WruuZAYSCLwXsQY=;
        b=DH7oi9IWqDfJeguC1iImkQWaw2MHscEUHX8FsxZxJn2aHIMAmZEc4AncwQT3bYRLOE
         yYDf0CDz9l4GRPYrtWOu6stL26vkxyyyZbY5/3NSRLahAPk6c6yzyKQ5MtmOwc8AsXI4
         9cyimmUQN2P5TD/aVZbE+F0+8E4MNZXzLK39UmjY9HpI75W6RUXrloySqVBrMq1Hbvut
         Aciq4Q9xnIEBXe1TRcvK7HD/TiP+wdWvtLbzi2fmGpEBX4iSklhYd4hUYBCFCXJeo7Me
         8+xn3g362fEn5aPAV0no2+N5P2mGq2bIGL5RS/mJ5IklZLkMHwEfrxRaV5j6VLcsTOLZ
         fq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6OkpC9E05WzvbRfFRBqu0Uaj19M1WruuZAYSCLwXsQY=;
        b=COSDSZW6FCbLrKODwe2kKTQ06Z7jRrIK51zzoksS78T2biTrbkNSL1u0nNfA/0aPQY
         /yMCBbvQ5bDybLSu1KKUoRl/WXOVIlO61MhmtAfUE3Ct875sVG1WKi9zbNwMCVW7YiWA
         Uhys6/44/vBkIBDrRMRKvrMEb2hExWEnDNj4K/HTZ78v+v4NX08IX61wCQkXXMyjP4Dt
         rUNAlvO7IdbHkl3KGQBYpn4ctb1993EoIQYwq11H/t+0v7m+dm4PP+PulFgHV5H7ZVbx
         n1DvFvZM+rNKQ8FuqHxxf3N3j7PHIxdcy/zNBuYXFD1POlRgYZ2qdapcHw7PBFDokoT6
         XjXQ==
X-Gm-Message-State: APjAAAVt1GPgMl30GLWCAhOgrWnjm864eB6cygQ2Y9xGh2u5dm72C6lt
        X3YNTz2PdQvX2N+EqryCC2E1good
X-Google-Smtp-Source: APXvYqzuJNpOSl9Pjo/4nSveEE3fZpLE7chQrmq0mNob9/tEyfCZgyBO8bq7+LsLDCQ07it4niUo1g==
X-Received: by 2002:a5d:9842:: with SMTP id p2mr429075ios.226.1568668453328;
        Mon, 16 Sep 2019 14:14:13 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l186sm71853ioa.54.2019.09.16.14.14.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 14:14:12 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 18/19] NFSD: allow inter server COPY to have a STALE source server fh
Date:   Mon, 16 Sep 2019 17:13:52 -0400
Message-Id: <20190916211353.18802-19-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
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
index 10cefb0..b7172a8 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -133,6 +133,16 @@ config NFSD_FLEXFILELAYOUT
 
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
index 90d0b67..7574ba7 100644
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
@@ -1956,6 +1964,45 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
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
@@ -2004,6 +2051,9 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
 		resp->opcnt = 1;
 		goto encode_op;
 	}
+	status = check_if_stalefh_allowed(args);
+	if (status)
+		goto out;
 
 	trace_nfsd_compound(rqstp, args->opcnt);
 	while (!status && resp->opcnt < args->opcnt) {
@@ -2019,13 +2069,14 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
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
index 0b4fe07..b16f602 100644
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

