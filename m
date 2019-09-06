Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 434CAAC0CC
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2019 21:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393126AbfIFTqt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 15:46:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43534 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392364AbfIFTqs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 15:46:48 -0400
Received: by mail-io1-f68.google.com with SMTP id u185so15333316iod.10
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zC59tALfmdN9jaU/KWaxLujie6gIK8PIpn0ojbDfP7w=;
        b=IIaHXPuk3w5sO1kNiIwp1tdst4TEpHLjVVrqcnX1mdYflUHfmaXYmf1F1LwbZubIpU
         DA6TgPZQ2SQ0haX1VQsuRk5rsRlYPd9OTMv2+UZmHBZ9Dl6/4fwGDN7nSM5UjHPlRDrB
         X3wsS56LtlYtzqLYcP+0n1qgISiJYsuLKcQAcG50I96QM1h5KhTBF6eKtfitCOmHAdWl
         KBuXPZ51O2geZewlJtV3vtz7WhYCaixh0RHErh+zrD8Mw71UruoVStPbE9giFnQ0ny54
         9MvxfHS+/5QJB6/rPpy6nunHjwbZD1N8E0Nhe6WiNsfsjtfviI9v8HfJWU4X0RU7OOrM
         hxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zC59tALfmdN9jaU/KWaxLujie6gIK8PIpn0ojbDfP7w=;
        b=gUy+ruTc1uagH0njbqunBLxmHZZmPQjShdsUDwgeJmBeanGA9ePb4Y6FgwQlYZP+pT
         cqyDHfi1eYMdv/7IdlKZ1xO9unmxd9nc0/PRODG6+X4wnyocuRjJ6+8mYE9NgRfzpOtq
         21V0Oat51SzAVC5jzPUIGeD0aso2JPdR8hJUiM+SU3+qcklF3OzurUhgSNgmzpq7WTpR
         4QNgIXQolNj5Ybeq9H/HpTo78b2eAv3XOt6dbKhg/6FNJMTVG4wZzcatbUH0IYT3967u
         RBJa1JkTHwXndEcRvMmzcojBP8O3alWLv1sTMviKETvL/lq+t+sv7cz5NG7j4NaCSgtq
         jMlg==
X-Gm-Message-State: APjAAAV0A3YPTBjPTjz7OkP5PtprvItbtGO7wpjLG4YNvYahY9X8dCgy
        N4S9w5RCgpO4Q11n+UwjuRs=
X-Google-Smtp-Source: APXvYqxgkDT5SUr0YUf/0Ab/TGKlFo4OqG0h5RMk8xRK23YqRps4sKJcrhD0+EoCVtdXXksKUDZuGA==
X-Received: by 2002:a6b:9203:: with SMTP id u3mr12394078iod.3.1567799207774;
        Fri, 06 Sep 2019 12:46:47 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id i14sm5118085ioi.47.2019.09.06.12.46.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 12:46:47 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 13/19] NFSD return nfs4_stid in nfs4_preprocess_stateid_op
Date:   Fri,  6 Sep 2019 15:46:25 -0400
Message-Id: <20190906194631.3216-14-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
References: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Needed for copy to add nfs4_cp_state to the nfs4_stid.

Signed-off-by: Andy Adamson <andros@netapp.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4proc.c  | 24 ++++++++++++++----------
 fs/nfsd/nfs4state.c | 11 ++++++++---
 fs/nfsd/state.h     |  3 ++-
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8beda99..38f15f6 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -782,7 +782,8 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
 	/* check stateid */
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					&read->rd_stateid, RD_STATE,
-					&read->rd_filp, &read->rd_tmp_file);
+					&read->rd_filp, &read->rd_tmp_file,
+					NULL);
 	if (status) {
 		dprintk("NFSD: nfsd4_read: couldn't process stateid!\n");
 		goto out;
@@ -954,7 +955,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
 	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
 		status = nfs4_preprocess_stateid_op(rqstp, cstate,
 				&cstate->current_fh, &setattr->sa_stateid,
-				WR_STATE, NULL, NULL);
+				WR_STATE, NULL, NULL, NULL);
 		if (status) {
 			dprintk("NFSD: nfsd4_setattr: couldn't process stateid!\n");
 			return status;
@@ -1005,7 +1006,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
 	trace_nfsd_write_start(rqstp, &cstate->current_fh,
 			       write->wr_offset, cnt);
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
-						stateid, WR_STATE, &filp, NULL);
+					stateid, WR_STATE, &filp, NULL, NULL);
 	if (status) {
 		dprintk("NFSD: nfsd4_write: couldn't process stateid!\n");
 		return status;
@@ -1032,7 +1033,8 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
 static __be32
 nfsd4_verify_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		  stateid_t *src_stateid, struct file **src,
-		  stateid_t *dst_stateid, struct file **dst)
+		  stateid_t *dst_stateid, struct file **dst,
+		  struct nfs4_stid **stid)
 {
 	__be32 status;
 
@@ -1040,14 +1042,16 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
 		return nfserr_nofilehandle;
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->save_fh,
-					    src_stateid, RD_STATE, src, NULL);
+					    src_stateid, RD_STATE, src, NULL,
+					    NULL);
 	if (status) {
 		dprintk("NFSD: %s: couldn't process src stateid!\n", __func__);
 		goto out;
 	}
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
-					    dst_stateid, WR_STATE, dst, NULL);
+					    dst_stateid, WR_STATE, dst, NULL,
+					    stid);
 	if (status) {
 		dprintk("NFSD: %s: couldn't process dst stateid!\n", __func__);
 		goto out_put_src;
@@ -1078,7 +1082,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
 	__be32 status;
 
 	status = nfsd4_verify_copy(rqstp, cstate, &clone->cl_src_stateid, &src,
-				   &clone->cl_dst_stateid, &dst);
+				   &clone->cl_dst_stateid, &dst, NULL);
 	if (status)
 		goto out;
 
@@ -1265,7 +1269,7 @@ static int nfsd4_do_async_copy(void *data)
 
 	status = nfsd4_verify_copy(rqstp, cstate, &copy->cp_src_stateid,
 				   &copy->file_src, &copy->cp_dst_stateid,
-				   &copy->file_dst);
+				   &copy->file_dst, NULL);
 	if (status)
 		goto out;
 
@@ -1351,7 +1355,7 @@ struct nfsd4_copy *
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					    &fallocate->falloc_stateid,
-					    WR_STATE, &file, NULL);
+					    WR_STATE, &file, NULL, NULL);
 	if (status != nfs_ok) {
 		dprintk("NFSD: nfsd4_fallocate: couldn't process stateid!\n");
 		return status;
@@ -1410,7 +1414,7 @@ struct nfsd4_copy *
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					    &seek->seek_stateid,
-					    RD_STATE, &file, NULL);
+					    RD_STATE, &file, NULL, NULL);
 	if (status) {
 		dprintk("NFSD: nfsd4_seek: couldn't process stateid!\n");
 		return status;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7857942..78926c6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5583,7 +5583,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 __be32
 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, struct svc_fh *fhp,
-		stateid_t *stateid, int flags, struct file **filpp, bool *tmp_file)
+		stateid_t *stateid, int flags, struct file **filpp,
+		bool *tmp_file, struct nfs4_stid **cstid)
 {
 	struct inode *ino = d_inode(fhp->fh_dentry);
 	struct net *net = SVC_NET(rqstp);
@@ -5634,8 +5635,12 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	if (!status && filpp)
 		status = nfs4_check_file(rqstp, fhp, s, filpp, tmp_file, flags);
 out:
-	if (s)
-		nfs4_put_stid(s);
+	if (s) {
+		if (!status && cstid)
+			*cstid = s;
+		else
+			nfs4_put_stid(s);
+	}
 	return status;
 }
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 5dbd169..25c7a45 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -616,7 +616,8 @@ struct nfsd4_blocked_lock {
 
 extern __be32 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, struct svc_fh *fhp,
-		stateid_t *stateid, int flags, struct file **filp, bool *tmp_file);
+		stateid_t *stateid, int flags, struct file **filp,
+		bool *tmp_file, struct nfs4_stid **cstid);
 __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		     stateid_t *stateid, unsigned char typemask,
 		     struct nfs4_stid **s, struct nfsd_net *nn);
-- 
1.8.3.1

