Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88D5FB42CA
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 23:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391679AbfIPVOJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 17:14:09 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44122 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391664AbfIPVOJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 17:14:09 -0400
Received: by mail-io1-f68.google.com with SMTP id j4so2380239iog.11
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 14:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TfW6tXQ8tUdc6Mp+z/yRFlFQYYquXAi5hBJpsjLZkxw=;
        b=ji9ii9HcXD+WwKqsaK/pSL4fjJura9rHNSoGaDQYpLpE63MXlFpDrDzUEQalJriag5
         wNsFHKJ7mxRP9hqHqzS+j9Ettm6QVhLl4VdSdVKiBx+OalFFOYzY7R1mJGcvAYho9Eyx
         F6OI947XQguN74KlrjA3IG6X78c5zXoPqKot5nPAtM7TqG25DmMu9SDfPCWYqRsyNyQ3
         nEf8Nh7dJiq/POixeJHyNBIv7Nj7MsabdWAwSQcwxh47EpA4oGvAmXE2XTb9vLRbJ1VR
         L2FgOi74GuloJ8IK0ckcO9JsOHPZyKanflinQ7E6ua/1I9XGYlFKQeIlTwsywPL/Rrz1
         CRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TfW6tXQ8tUdc6Mp+z/yRFlFQYYquXAi5hBJpsjLZkxw=;
        b=iJf2zNA96761gj91YQCAKLlRSDqZUVoA0MZxc+Dz0m0Jum8HydmVd1UPYtvX5hyZjZ
         8Cf7Wh9lTc1LpOiKhbcPE52JzevpzkzJaC81AtEJWB5LDtPijUJqzB9f5hfrCjKbMw7z
         e6Mc7DBzAKlrlEPobShqBoy3gGYJhYTP2zDPYqzLffkNNUaqjn08gs4LpQfJSw4OGMRC
         UpM5KWevnVGp5+cp6+f0AGQp5paUHEdHspE25k0M09RhoMfDCCwUQ0/Dvdqu/PsaQQFR
         UscWdxLsH0WOYZFnExJAqTYIacb85FR/QtnkvNgczR9D4jIAlxvs5F/CuqJyERNsCYaL
         gfwg==
X-Gm-Message-State: APjAAAUkUwsDLIqX79mcrRB3msOxkVK4Wb4lt2W0InDbOqiXTpq7HQuL
        WdmcR510TmYW7H7C2MZQ1QA=
X-Google-Smtp-Source: APXvYqzYQgMIBKlbmWXk9jKSxSq2Hv3U+bZL7rWhtuXjVBlinFnA1A/ipX3jc7LQuYRfHNtK2ol8VA==
X-Received: by 2002:a6b:640f:: with SMTP id t15mr356475iog.71.1568668448390;
        Mon, 16 Sep 2019 14:14:08 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l186sm71853ioa.54.2019.09.16.14.14.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 14:14:07 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 13/19] NFSD return nfs4_stid in nfs4_preprocess_stateid_op
Date:   Mon, 16 Sep 2019 17:13:47 -0400
Message-Id: <20190916211353.18802-14-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Needed for copy to add nfs4_cp_state to the nfs4_stid.

Signed-off-by: Andy Adamson <andros@netapp.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4proc.c  | 21 +++++++++++----------
 fs/nfsd/nfs4state.c | 11 ++++++++---
 fs/nfsd/state.h     |  3 ++-
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4e3e77b..6c0d216 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -776,7 +776,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
 	/* check stateid */
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					&read->rd_stateid, RD_STATE,
-					&read->rd_nf);
+					&read->rd_nf, NULL);
 	if (status) {
 		dprintk("NFSD: nfsd4_read: couldn't process stateid!\n");
 		goto out;
@@ -948,7 +948,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
 	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
 		status = nfs4_preprocess_stateid_op(rqstp, cstate,
 				&cstate->current_fh, &setattr->sa_stateid,
-				WR_STATE, NULL);
+				WR_STATE, NULL, NULL);
 		if (status) {
 			dprintk("NFSD: nfsd4_setattr: couldn't process stateid!\n");
 			return status;
@@ -999,7 +999,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
 	trace_nfsd_write_start(rqstp, &cstate->current_fh,
 			       write->wr_offset, cnt);
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
-						stateid, WR_STATE, &nf);
+						stateid, WR_STATE, &nf, NULL);
 	if (status) {
 		dprintk("NFSD: nfsd4_write: couldn't process stateid!\n");
 		return status;
@@ -1026,7 +1026,8 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
 static __be32
 nfsd4_verify_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		  stateid_t *src_stateid, struct nfsd_file **src,
-		  stateid_t *dst_stateid, struct nfsd_file **dst)
+		  stateid_t *dst_stateid, struct nfsd_file **dst,
+		  struct nfs4_stid **stid)
 {
 	__be32 status;
 
@@ -1034,14 +1035,14 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
 		return nfserr_nofilehandle;
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->save_fh,
-					    src_stateid, RD_STATE, src);
+					    src_stateid, RD_STATE, src, NULL);
 	if (status) {
 		dprintk("NFSD: %s: couldn't process src stateid!\n", __func__);
 		goto out;
 	}
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
-					    dst_stateid, WR_STATE, dst);
+					    dst_stateid, WR_STATE, dst, stid);
 	if (status) {
 		dprintk("NFSD: %s: couldn't process dst stateid!\n", __func__);
 		goto out_put_src;
@@ -1072,7 +1073,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
 	__be32 status;
 
 	status = nfsd4_verify_copy(rqstp, cstate, &clone->cl_src_stateid, &src,
-				   &clone->cl_dst_stateid, &dst);
+				   &clone->cl_dst_stateid, &dst, NULL);
 	if (status)
 		goto out;
 
@@ -1260,7 +1261,7 @@ static int nfsd4_do_async_copy(void *data)
 
 	status = nfsd4_verify_copy(rqstp, cstate, &copy->cp_src_stateid,
 				   &copy->nf_src, &copy->cp_dst_stateid,
-				   &copy->nf_dst);
+				   &copy->nf_dst, NULL);
 	if (status)
 		goto out;
 
@@ -1346,7 +1347,7 @@ struct nfsd4_copy *
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					    &fallocate->falloc_stateid,
-					    WR_STATE, &nf);
+					    WR_STATE, &nf, NULL);
 	if (status != nfs_ok) {
 		dprintk("NFSD: nfsd4_fallocate: couldn't process stateid!\n");
 		return status;
@@ -1405,7 +1406,7 @@ struct nfsd4_copy *
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					    &seek->seek_stateid,
-					    RD_STATE, &nf);
+					    RD_STATE, &nf, NULL);
 	if (status) {
 		dprintk("NFSD: nfsd4_seek: couldn't process stateid!\n");
 		return status;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index da1093d..78e03af 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5584,7 +5584,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 __be32
 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, struct svc_fh *fhp,
-		stateid_t *stateid, int flags, struct nfsd_file **nfp)
+		stateid_t *stateid, int flags, struct nfsd_file **nfp,
+		struct nfs4_stid **cstid)
 {
 	struct inode *ino = d_inode(fhp->fh_dentry);
 	struct net *net = SVC_NET(rqstp);
@@ -5633,8 +5634,12 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	if (status == nfs_ok && nfp)
 		status = nfs4_check_file(rqstp, fhp, s, nfp, flags);
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
index 46f56af..d9e7cbd 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -617,7 +617,8 @@ struct nfsd4_blocked_lock {
 
 extern __be32 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, struct svc_fh *fhp,
-		stateid_t *stateid, int flags, struct nfsd_file **filp);
+		stateid_t *stateid, int flags, struct nfsd_file **filp,
+		struct nfs4_stid **cstid);
 __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		     stateid_t *stateid, unsigned char typemask,
 		     struct nfs4_stid **s, struct nfsd_net *nn);
-- 
1.8.3.1

