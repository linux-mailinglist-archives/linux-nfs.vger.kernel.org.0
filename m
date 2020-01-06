Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 418321317AF
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 19:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgAFSm5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 13:42:57 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:32894 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgAFSm5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 13:42:57 -0500
Received: by mail-yb1-f193.google.com with SMTP id n66so22489709ybg.0
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 10:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZzMvDGwLMIkB9C9Mnpqvof7jU4+XKEfowxtMHzq78MU=;
        b=WznSV9ImlTta1YRBvtek1rSlw9cJGey9zI4EsMg7KdGt3ESH/tkpJnYpCxTTFNwM/T
         GnjqFTuDlBXoA24fCCikg4emZo49AAFAM9FYTUVe74w7da04DAc0F/jr87+KL9uILUfS
         Lu6ZBvKUOV/ifsj5Fd8vxN3KMuvQRI0q8KxH47FGEJhKR7ue8A5Pl0lwIV8Ph6WFiDLS
         C1cfwDQ7Kk1ALkPiNeZ1DR1Z9h6L5bg0PK+/3EPoMHGQcvUgGYcVi73LdyAY5CmF8DPN
         +HzgMyNIXMkIn+EHtBOqsnRS2N8KRsujsym6kdl663vTr9JRHcT4pjI96dRyz8Flng1j
         K1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzMvDGwLMIkB9C9Mnpqvof7jU4+XKEfowxtMHzq78MU=;
        b=uK3/9ZhuW8J1M2mKHe2lByRnmevZqIIq8pRg7B0o4Fu6UzQJYzmjLUa62XAFKPD/4u
         86EreZvOH9RnfSsdcd1Ha8DK6IRTVK/226J+fPwRAdzJ1m1cyyJVh+1QQG/BJdCSrXXI
         IDjWGAwXyWyIzuM/PQiLWd+vAdRPXOqXGmcFDGqWz3InYlIHKGyJg9/+fBVyiB6D8feZ
         Ggb0aTN056oyLgC/pFMhozgkoXT1L6bzlbSTysysbcCPF4A9Zjd+Ibp+W2qxFhsvJjSh
         LjDSGaSGSpcp3alepiMfGz/qgXFUHYZvwap9lHdRNp77+me9/mLgSWl3OEx+MGXy1qX+
         sqCA==
X-Gm-Message-State: APjAAAWBPXLFzWl83qq4e1Mm7hWNtgGdiNOEoCTwjZq2cvO4zAeETIPF
        VcugGSHaIasRnTZWT0huhn4OKbh+og==
X-Google-Smtp-Source: APXvYqxKbTJyCFIBZujXQaKEuB5jG/yAObmaCy/Rej/VZ0agv+IbcgjoqKprp0GQA10BtOp6bNA5+A==
X-Received: by 2002:a5b:286:: with SMTP id x6mr75061895ybl.92.1578336175599;
        Mon, 06 Jan 2020 10:42:55 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u136sm28223497ywf.101.2020.01.06.10.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 10:42:55 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 8/9] nfsd: Ensure sampling of the commit verifier is atomic with the commit
Date:   Mon,  6 Jan 2020 13:40:36 -0500
Message-Id: <20200106184037.563557-9-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106184037.563557-8-trond.myklebust@hammerspace.com>
References: <20200106184037.563557-1-trond.myklebust@hammerspace.com>
 <20200106184037.563557-2-trond.myklebust@hammerspace.com>
 <20200106184037.563557-3-trond.myklebust@hammerspace.com>
 <20200106184037.563557-4-trond.myklebust@hammerspace.com>
 <20200106184037.563557-5-trond.myklebust@hammerspace.com>
 <20200106184037.563557-6-trond.myklebust@hammerspace.com>
 <20200106184037.563557-7-trond.myklebust@hammerspace.com>
 <20200106184037.563557-8-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When we have a successful commit, ensure we sample the commit verifier
before releasing the lock.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs3proc.c | 3 ++-
 fs/nfsd/nfs3xdr.c  | 8 ++------
 fs/nfsd/nfs4proc.c | 4 ++--
 fs/nfsd/vfs.c      | 8 ++++++--
 fs/nfsd/vfs.h      | 2 +-
 fs/nfsd/xdr3.h     | 1 +
 6 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index cea68d8411ac..ffdc592868a6 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -683,7 +683,8 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
 		RETURN_STATUS(nfserr_inval);
 
 	fh_copy(&resp->fh, &argp->fh);
-	nfserr = nfsd_commit(rqstp, &resp->fh, argp->offset, argp->count);
+	nfserr = nfsd_commit(rqstp, &resp->fh, argp->offset, argp->count,
+			resp->verf);
 
 	RETURN_STATUS(nfserr);
 }
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 195ab7a0fc89..4aaa85f42da2 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -1125,16 +1125,12 @@ int
 nfs3svc_encode_commitres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_commitres *resp = rqstp->rq_resp;
-	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
-	__be32 verf[2];
 
 	p = encode_wcc_data(rqstp, p, &resp->fh);
 	/* Write verifier */
 	if (resp->status == 0) {
-		/* unique identifier, y2038 overflow can be ignored */
-		nfsd_copy_boot_verifier(verf, nn);
-		*p++ = verf[0];
-		*p++ = verf[1];
+		*p++ = resp->verf[0];
+		*p++ = resp->verf[1];
 	}
 	return xdr_ressize_check(rqstp, p);
 }
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7fce319e5b85..c24a4f96c973 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -581,9 +581,9 @@ nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 {
 	struct nfsd4_commit *commit = &u->commit;
 
-	gen_boot_verifier(&commit->co_verf, SVC_NET(rqstp));
 	return nfsd_commit(rqstp, &cstate->current_fh, commit->co_offset,
-			     commit->co_count);
+			     commit->co_count,
+			     (__be32 *)commit->co_verf.data);
 }
 
 static __be32
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index b2984a996ab8..1d69a1e78b03 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1105,7 +1105,7 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
  */
 __be32
 nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
-               loff_t offset, unsigned long count)
+               loff_t offset, unsigned long count, __be32 *verf)
 {
 	struct nfsd_file	*nf;
 	loff_t			end = LLONG_MAX;
@@ -1130,6 +1130,8 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		err2 = vfs_fsync_range(nf->nf_file, offset, end, 0);
 		switch (err2) {
 		case 0:
+			nfsd_copy_boot_verifier(verf, net_generic(nf->nf_net,
+						nfsd_net_id));
 			break;
 		case -EINVAL:
 			err = nfserr_notsupp;
@@ -1140,7 +1142,9 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
 						 nfsd_net_id));
 		}
 		up_write(&nf->nf_rwsem);
-	}
+	} else
+		nfsd_copy_boot_verifier(verf, net_generic(nf->nf_net,
+					nfsd_net_id));
 
 	nfsd_file_put(nf);
 out:
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 69d23e9926cf..29e30688ccfb 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -74,7 +74,7 @@ __be32		do_nfsd_create(struct svc_rqst *, struct svc_fh *,
 				struct svc_fh *res, int createmode,
 				u32 *verifier, bool *truncp, bool *created);
 __be32		nfsd_commit(struct svc_rqst *, struct svc_fh *,
-				loff_t, unsigned long);
+				loff_t, unsigned long, __be32 *verf);
 #endif /* CONFIG_NFSD_V3 */
 int 		nfsd_open_break_lease(struct inode *, int);
 __be32		nfsd_open(struct svc_rqst *, struct svc_fh *, umode_t,
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 99ff9f403ff1..21fc1f14bcad 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -223,6 +223,7 @@ struct nfsd3_pathconfres {
 struct nfsd3_commitres {
 	__be32			status;
 	struct svc_fh		fh;
+	__be32			verf[2];
 };
 
 struct nfsd3_getaclres {
-- 
2.24.1

