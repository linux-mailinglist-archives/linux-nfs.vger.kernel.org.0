Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C75E11E547
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 15:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfLMOLD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 09:11:03 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:41309 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfLMOLC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 09:11:02 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MTAJr-1iHwJ52Qnv-00UXmr; Fri, 13 Dec 2019 15:10:56 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 06/12] nfsd: pass a 64-bit guardtime to nfsd_setattr()
Date:   Fri, 13 Dec 2019 15:10:40 +0100
Message-Id: <20191213141046.1770441-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213141046.1770441-1-arnd@arndb.de>
References: <20191213141046.1770441-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:32H1E8vuq17NH2Cx7Vjm22p3ZCzBl6Ofe77Gpb5PjGXyE0MByqG
 Qe8AewdBTTn04K+UXAoEjWqdTSbuNlrt3u9k3GDQ00D0826A+JmZ6CwLDqhSf8QJ+19Lf4/
 9+NVRZNoiTqdylywasRZnkbGKjYuVewG6BpCdrqzvuOiXSCD6ZkM0Rwgj5lzYY+2Qr8ZL64
 qFOZU0LWFyy3tjWqBNvxQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vcCoIowR3aI=:aTY+fJ6vSdea/tBGyeGFLo
 RyeqFMHOXDHlijvgB9zL9U0QLiOwn1B0NZwNwFsVGbFTnAT5TU+xsHyzaPUXQwnwu/5r4vqzd
 v+VadyxdvpTaNOQw5wmJ/KstrSa7o5gENvdVNTEo8ZuQfvOs07KsZ5DD2A4yppl0MUQM38xzj
 xBBrGWyUOlIrkhWZNH6x+hfipMq4C3FzvfG+LrtPTse5OqCohck88JVE1mTkTHI3sg2+KkHTG
 jF9sSla2R0f/nrytEgTBcUQEG2buq5LK1S+eCzoTVz3S2N2q+3+/QNs8X2HTZ7d6fWXbfE5sW
 ms6UiN5db4ytofUqsccj8b3RMjxKsxZyYQaZEkxysP45KVt1ZqYDYaftsGUh9tQ5rrgpDcufB
 nK4x58IC45GEOgykLFlZF3vS+oqm00MCeO22cmvEjDy9GvBuAd6RdQDLMryZGTxf88jAiFDxK
 Q0XEVOcQmr4lgdADZGQEi+5v/iRbIRTjwsqzK0YRtzjnrtN520bteskuB9k4HWmOtV/I5H0jk
 1CqdHxqNzK6ekqTYBqyDi5unJFeIXw3aPAKxylEGJX/dS6z0IjVh2CoaMuptXN7ey6gRsU36O
 s7ysMo2g7loPbuf8E1PPYb3LP/X8h7Tfvcnqawg3Kzki80mgk9phFnCknLqa3dDapqQ8IRpLP
 RvZS0ZILQKfN3/tq6XGNy71fj/29oMvtZX30EllOM+reLhPR35Rhwi+iDvRqWpSs8Q/Huuhb5
 bT47b9q0vHrXpLTEtNYGJbcpJpc2+TLHB1WqRXymWMRi4hiW01bGnwbqWx1cUFmWwG+nEZQSk
 26t/vaUYJsRRb9EvfVyhr+uklCr2C4X2EUbLYoF1ijiCylAiz+7triwDbT3B0mKOOW136+bCk
 c7/8aVgnq9m3doyBiJgg==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Guardtime handling in nfs3 differs between 32-bit and 64-bit
architectures, and uses the deprecated time_t type.

Change it to using time64_t, which behaves the same way on
64-bit and 32-bit architectures, treating the number as an
unsigned 32-bit entity with a range of year 1970 to 2106
consistently, and avoiding the y2038 overflow.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfs4proc.c  | 2 +-
 fs/nfsd/nfs4state.c | 2 +-
 fs/nfsd/nfsproc.c   | 4 ++--
 fs/nfsd/vfs.c       | 4 ++--
 fs/nfsd/vfs.h       | 2 +-
 fs/nfsd/xdr3.h      | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4798667af647..bcf6803cf3a6 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -975,7 +975,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		goto out;
 	status = nfsd_setattr(rqstp, &cstate->current_fh, &setattr->sa_iattr,
-				0, (time_t)0);
+				0, (time64_t)0);
 out:
 	fh_drop_write(&cstate->current_fh);
 	return status;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1ac431aa29c4..5cb0f774218a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4671,7 +4671,7 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
 		return 0;
 	if (!(open->op_share_access & NFS4_SHARE_ACCESS_WRITE))
 		return nfserr_inval;
-	return nfsd_setattr(rqstp, fh, &iattr, 0, (time_t)0);
+	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
 }
 
 static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index c83ddac22f38..aa013b736073 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -113,7 +113,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 		}
 	}
 
-	nfserr = nfsd_setattr(rqstp, fhp, iap, 0, (time_t)0);
+	nfserr = nfsd_setattr(rqstp, fhp, iap, 0, (time64_t)0);
 done:
 	return nfsd_return_attrs(nfserr, resp);
 }
@@ -380,7 +380,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		 */
 		attr->ia_valid &= ATTR_SIZE;
 		if (attr->ia_valid)
-			nfserr = nfsd_setattr(rqstp, newfhp, attr, 0, (time_t)0);
+			nfserr = nfsd_setattr(rqstp, newfhp, attr, 0, (time64_t)0);
 	}
 
 out_unlock:
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c0dc491537a6..fd5ba6997447 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -358,7 +358,7 @@ nfsd_get_write_access(struct svc_rqst *rqstp, struct svc_fh *fhp,
  */
 __be32
 nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
-	     int check_guard, time_t guardtime)
+	     int check_guard, time64_t guardtime)
 {
 	struct dentry	*dentry;
 	struct inode	*inode;
@@ -1123,7 +1123,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *resfhp,
 	if (!uid_eq(current_fsuid(), GLOBAL_ROOT_UID))
 		iap->ia_valid &= ~(ATTR_UID|ATTR_GID);
 	if (iap->ia_valid)
-		return nfsd_setattr(rqstp, resfhp, iap, 0, (time_t)0);
+		return nfsd_setattr(rqstp, resfhp, iap, 0, (time64_t)0);
 	/* Callers expect file metadata to be committed here */
 	return nfserrno(commit_metadata(resfhp));
 }
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index cc110a10bfe8..bbb485177b25 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -48,7 +48,7 @@ __be32		 nfsd_lookup_dentry(struct svc_rqst *, struct svc_fh *,
 				const char *, unsigned int,
 				struct svc_export **, struct dentry **);
 __be32		nfsd_setattr(struct svc_rqst *, struct svc_fh *,
-				struct iattr *, int, time_t);
+				struct iattr *, int, time64_t);
 int nfsd_mountpoint(struct dentry *, struct svc_export *);
 #ifdef CONFIG_NFSD_V4
 __be32          nfsd4_set_nfs4_label(struct svc_rqst *, struct svc_fh *,
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 99ff9f403ff1..0fa12988fb6a 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -14,7 +14,7 @@ struct nfsd3_sattrargs {
 	struct svc_fh		fh;
 	struct iattr		attrs;
 	int			check_guard;
-	time_t			guardtime;
+	time64_t		guardtime;
 };
 
 struct nfsd3_diropargs {
-- 
2.20.0

