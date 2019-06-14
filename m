Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F06F46882
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2019 22:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfFNUBA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jun 2019 16:01:00 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37019 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfFNUBA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jun 2019 16:01:00 -0400
Received: by mail-io1-f66.google.com with SMTP id e5so8456208iok.4
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2019 13:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jOGnRdmnKEVxYoAacsG8HHMnQ37g5MRdn9njQ6D0VUM=;
        b=eDaaSlyVJXZN1o6DnmFl32ZSuip4TdZJCow54AL2nhH7Dg/UQ++kgj1+ornwOuVwlu
         Bg6KhlgVoISm1IOxIEiMNq6STGDyJVl/GL1tb9AAWSRxBFucgF+99E1WxkQlKd4BAkey
         eCbBxavhiMJv7u8aylbgcjGeNvwmrHxGA4niArktZ/YRkehY5xW/QJ1B7sz5n7ZaDsTB
         Tt8uoUKeS9vwE0YbLZHSaN0jBSUsyD0WhhG9AK3mh4uA8QdVQcMPG63T3Jxu6a0fRYHv
         e1JqO4tI7IJF1Vv2SbFlXeOIXGtdWhnoSqOHjrnqsn8CuB7raeXaDv7SCJapPJ8ITlcu
         G0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jOGnRdmnKEVxYoAacsG8HHMnQ37g5MRdn9njQ6D0VUM=;
        b=YnuAfd1WWV01w5INdRtezdNIjWI/1Wy8Cu80KSvnTYSBl4oagXwieQ8h4L/XWduhtb
         MepnFb89DY7hOIPyr2ou+oFhM9IajAMFo8R4x8L1MK6q41/ZbP62p6Ae0jB619ZwsR96
         r3y5WziHMJLRQFo/ImOoqmzISzraBQC6c8pso29oNtegAlasXBTzzNhQ+LC3efHS52i9
         2emiv+u9zbLKrRYKi4UxqiQ5jwb6HLMp/LbIihrYq3xqkK96sDkJc3GpICAxi3ANS/k0
         mzHLDfgAegBRhGTEvfJJgUwrW3I2tN2ZV6bPa5unnkxe7svQx+gBIQ8JZYyx1CG//3DC
         anlA==
X-Gm-Message-State: APjAAAUQUZML+cb5ZS84l4jyxJbEEML9218/vBrGstXrUdV2YYhTp4hU
        t3qRVTp/IeeyZb1vYEpq6H4FD+GfW0g=
X-Google-Smtp-Source: APXvYqyaV1QEJfS5ksCkEpkwCWOV8pO550gJbPznBX8eczytKyLjEIFT2ZA8+SEXC9rRLHlQpa3XsA==
X-Received: by 2002:a02:3c07:: with SMTP id m7mr34709641jaa.64.1560542458860;
        Fri, 14 Jun 2019 13:00:58 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id p4sm6528115iod.68.2019.06.14.13.00.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 13:00:58 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 3/8] NFSD return nfs4_stid in nfs4_preprocess_stateid_op
Date:   Fri, 14 Jun 2019 16:00:49 -0400
Message-Id: <20190614200054.12394-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190614200054.12394-1-olga.kornievskaia@gmail.com>
References: <20190614200054.12394-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Needed for copy to add nfs4_cp_state to the nfs4_stid.

Signed-off-by: Andy Adamson <andros@netapp.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4proc.c  | 17 ++++++++++-------
 fs/nfsd/nfs4state.c |  8 ++++++--
 fs/nfsd/state.h     |  3 ++-
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8beda99..cfd8767 100644
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
@@ -1040,14 +1041,16 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
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
+					    NULL);
 	if (status) {
 		dprintk("NFSD: %s: couldn't process dst stateid!\n", __func__);
 		goto out_put_src;
@@ -1351,7 +1354,7 @@ struct nfsd4_copy *
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					    &fallocate->falloc_stateid,
-					    WR_STATE, &file, NULL);
+					    WR_STATE, &file, NULL, NULL);
 	if (status != nfs_ok) {
 		dprintk("NFSD: nfsd4_fallocate: couldn't process stateid!\n");
 		return status;
@@ -1410,7 +1413,7 @@ struct nfsd4_copy *
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					    &seek->seek_stateid,
-					    RD_STATE, &file, NULL);
+					    RD_STATE, &file, NULL, NULL);
 	if (status) {
 		dprintk("NFSD: nfsd4_seek: couldn't process stateid!\n");
 		return status;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 618e660..05c0295 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5187,7 +5187,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 __be32
 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, struct svc_fh *fhp,
-		stateid_t *stateid, int flags, struct file **filpp, bool *tmp_file)
+		stateid_t *stateid, int flags, struct file **filpp,
+		bool *tmp_file, struct nfs4_stid **cstid)
 {
 	struct inode *ino = d_inode(fhp->fh_dentry);
 	struct net *net = SVC_NET(rqstp);
@@ -5238,8 +5239,11 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	if (!status && filpp)
 		status = nfs4_check_file(rqstp, fhp, s, filpp, tmp_file, flags);
 out:
-	if (s)
+	if (s) {
+		if (!status && cstid)
+			*cstid = s;
 		nfs4_put_stid(s);
+	}
 	return status;
 }
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 0b74d37..5da9cc3 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -607,7 +607,8 @@ struct nfsd4_blocked_lock {
 
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

