Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA351317B0
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 19:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgAFSm6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 13:42:58 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40322 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgAFSm5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 13:42:57 -0500
Received: by mail-yb1-f196.google.com with SMTP id a2so22483109ybr.7
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 10:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k0Mecl0wn/2ijPTPmzXjwP8L0u+EXy9SIn0iPg0tEoY=;
        b=frvkONYDvlipInfJm/4y4xOBEyEVUwRvD//YO90w1+tMfsE3vtT+2QMQ6pLSZ7PcgR
         TqYLkHIV6prdrABNl1/kwf6fQ+HSC9FcVbhiQvHz27lzjDdxnhtRVGj0lhO2XOchFcV6
         7wXAcnCDWDewrU2MSqZD211cm0G/JjF0/mX7eUcdCefsb+6QiUxYfWCz6I0Zdx4ot815
         FqRpT1XmdqCn0GfQd1K+4q/AFDpJ6fYhm7r4kIWyvAP4th/5UmSh9LxSqPmr2dx9dEY7
         i5RxztuJYo9ku+focQLqPYOM/HydOgB51xEEl2ffMyQrLiw8shfagN0EPDKgJ/IGFNNe
         T7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0Mecl0wn/2ijPTPmzXjwP8L0u+EXy9SIn0iPg0tEoY=;
        b=uMfg1xaqiL/h1Uxh+c0h8JVQRpxnEtsujaXs525y9ddyPJzywEPBSmfupbsXtA8jCy
         z7YjuCethAGcUL4W0rEWoC7ezdFtxc30k3Bmr1aPMd6YisQ7cg7FRnumanivdqL5S6dT
         Z+0b+0sVEkesd/wRzdMjJPueUq+skO9sqNwza5/w+u5Omik6FkPap0sZ2XyFZVrEf0j+
         92dqkyAbZ4aS+ACnPwO7h13vIwJ6d0IOPPYsKniTLnOkKCoUNFHGmqjjo/84ewFgkQ00
         rUCcoOjoalgXbl8OLkNkGbWQqm0s5UQ+NZZKkUTPMHg5+4L2t8yqtbtb3jDx2BoZc4H/
         Cd2w==
X-Gm-Message-State: APjAAAWfQOIom51m7FQS4stbKgYvQ5jFEyvuPUaLh7M4KEk6GN1kbcKr
        XgengFfUDPAXDjGVF1SQ1A==
X-Google-Smtp-Source: APXvYqwCbftuIoe/V78clr1PfLhTcsim16yE0/B+8ha6peKqjJPotpWACwb9ZN6MMArf6W3BZnSEHg==
X-Received: by 2002:a25:2557:: with SMTP id l84mr77933296ybl.217.1578336176676;
        Mon, 06 Jan 2020 10:42:56 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u136sm28223497ywf.101.2020.01.06.10.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 10:42:56 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 9/9] nfsd: Ensure sampling of the write verifier is atomic with the write
Date:   Mon,  6 Jan 2020 13:40:37 -0500
Message-Id: <20200106184037.563557-10-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106184037.563557-9-trond.myklebust@hammerspace.com>
References: <20200106184037.563557-1-trond.myklebust@hammerspace.com>
 <20200106184037.563557-2-trond.myklebust@hammerspace.com>
 <20200106184037.563557-3-trond.myklebust@hammerspace.com>
 <20200106184037.563557-4-trond.myklebust@hammerspace.com>
 <20200106184037.563557-5-trond.myklebust@hammerspace.com>
 <20200106184037.563557-6-trond.myklebust@hammerspace.com>
 <20200106184037.563557-7-trond.myklebust@hammerspace.com>
 <20200106184037.563557-8-trond.myklebust@hammerspace.com>
 <20200106184037.563557-9-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When doing an unstable write, we need to ensure that we sample the
write verifier before releasing the lock, and allowing a commit to
the same file to proceed.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs3proc.c |  2 +-
 fs/nfsd/nfs3xdr.c  |  8 ++------
 fs/nfsd/nfs4proc.c |  4 ++--
 fs/nfsd/nfsproc.c  |  2 +-
 fs/nfsd/vfs.c      | 12 +++++++++---
 fs/nfsd/vfs.h      |  5 +++--
 fs/nfsd/xdr3.h     |  1 +
 7 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index ffdc592868a6..288bc76b4574 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -203,7 +203,7 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
 		RETURN_STATUS(nfserr_io);
 	nfserr = nfsd_write(rqstp, &resp->fh, argp->offset,
 			    rqstp->rq_vec, nvecs, &cnt,
-			    resp->committed);
+			    resp->committed, resp->verf);
 	resp->count = cnt;
 	RETURN_STATUS(nfserr);
 }
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 4aaa85f42da2..e1f6c65049b3 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -751,17 +751,13 @@ int
 nfs3svc_encode_writeres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_writeres *resp = rqstp->rq_resp;
-	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
-	__be32 verf[2];
 
 	p = encode_wcc_data(rqstp, p, &resp->fh);
 	if (resp->status == 0) {
 		*p++ = htonl(resp->count);
 		*p++ = htonl(resp->committed);
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
index c24a4f96c973..af2cb7dcb74c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1006,7 +1006,6 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 
 	write->wr_how_written = write->wr_stable_how;
-	gen_boot_verifier(&write->wr_verifier, SVC_NET(rqstp));
 
 	nvecs = svc_fill_write_vector(rqstp, write->wr_pagelist,
 				      &write->wr_head, write->wr_buflen);
@@ -1014,7 +1013,8 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
 				write->wr_offset, rqstp->rq_vec, nvecs, &cnt,
-				write->wr_how_written);
+				write->wr_how_written,
+				(__be32 *)write->wr_verifier.data);
 	nfsd_file_put(nf);
 
 	write->wr_bytes_written = cnt;
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index c83ddac22f38..bb1fbb67f697 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -226,7 +226,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 		return nfserr_io;
 	nfserr = nfsd_write(rqstp, fh_copy(&resp->fh, &argp->fh),
 			    argp->offset, rqstp->rq_vec, nvecs,
-			    &cnt, NFS_DATA_SYNC);
+			    &cnt, NFS_DATA_SYNC, NULL);
 	return nfsd_return_attrs(nfserr, resp);
 }
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 1d69a1e78b03..8beed0fbf93a 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -962,7 +962,8 @@ static int wait_for_concurrent_writes(struct file *file)
 __be32
 nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 				loff_t offset, struct kvec *vec, int vlen,
-				unsigned long *cnt, int stable)
+				unsigned long *cnt, int stable,
+				__be32 *verf)
 {
 	struct file		*file = nf->nf_file;
 	struct svc_export	*exp;
@@ -1004,6 +1005,10 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 		up_write(&nf->nf_rwsem);
 	} else {
 		down_read(&nf->nf_rwsem);
+		if (verf)
+			nfsd_copy_boot_verifier(verf,
+					net_generic(SVC_NET(rqstp),
+					nfsd_net_id));
 		host_err = vfs_iter_write(file, &iter, &pos, flags);
 		up_read(&nf->nf_rwsem);
 	}
@@ -1074,7 +1079,8 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
  */
 __be32
 nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
-	   struct kvec *vec, int vlen, unsigned long *cnt, int stable)
+	   struct kvec *vec, int vlen, unsigned long *cnt, int stable,
+	   __be32 *verf)
 {
 	struct nfsd_file *nf;
 	__be32 err;
@@ -1086,7 +1092,7 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
 		goto out;
 
 	err = nfsd_vfs_write(rqstp, fhp, nf, offset, vec,
-			vlen, cnt, stable);
+			vlen, cnt, stable, verf);
 	nfsd_file_put(nf);
 out:
 	trace_nfsd_write_done(rqstp, fhp, offset, *cnt);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 29e30688ccfb..11a112617e91 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -94,11 +94,12 @@ __be32 		nfsd_read(struct svc_rqst *, struct svc_fh *,
 				loff_t, struct kvec *, int, unsigned long *,
 				u32 *eof);
 __be32 		nfsd_write(struct svc_rqst *, struct svc_fh *, loff_t,
-				struct kvec *, int, unsigned long *, int);
+				struct kvec *, int, unsigned long *,
+				int stable, __be32 *verf);
 __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct nfsd_file *nf, loff_t offset,
 				struct kvec *vec, int vlen, unsigned long *cnt,
-				int stable);
+				int stable, __be32 *verf);
 __be32		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
 				char *, int *);
 __be32		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 21fc1f14bcad..fed959a809e8 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -159,6 +159,7 @@ struct nfsd3_writeres {
 	struct svc_fh		fh;
 	unsigned long		count;
 	int			committed;
+	__be32			verf[2];
 };
 
 struct nfsd3_renameres {
-- 
2.24.1

