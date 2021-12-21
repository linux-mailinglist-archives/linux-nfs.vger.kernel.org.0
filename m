Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AE447C436
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 17:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbhLUQwL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 11:52:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59934 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbhLUQwK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 11:52:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3372B817C3
        for <linux-nfs@vger.kernel.org>; Tue, 21 Dec 2021 16:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C46FC36AE9
        for <linux-nfs@vger.kernel.org>; Tue, 21 Dec 2021 16:52:08 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFSD: Fix zero-length NFSv3 WRITEs
Date:   Tue, 21 Dec 2021 11:52:06 -0500
Message-Id:  <164010544965.1786.4601957306894739409.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2894; h=from:subject:message-id; bh=UnzS0in99iPARZyEn88gNVzdD9tftRFvAnPZpEb/jm0=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhwgYwzKuLCb9R26WAJPIv+IgVSr//a0uEokxkdRq6 8wV5/hGJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYcIGMAAKCRAzarMzb2Z/l52WD/ 9nachxt1Eknsx0D2nrh8Oi+5gvtGP92a99UQkI5u1A7CeNAdlWqyBhipoKgZ3XwAwKciRZ0vNAjBjJ ayq1esA/hhgEXYmOxQ5aTK1UIoCCmipUvwBik4bJEUhjfpQptVcujQGE02F8L9BfQa4c93NTEfDdy3 5dx2zZXulKYc57LLfYtaLIWIJcaxFiaxaBgD2lhnSIH+zkZrlBqg0otBntxsqmL2ay4WpLh5TecxtS LLGjtgVmUqXD8vlf/0GAG8BP+PSO+dNPZ5iisuhxyvFlpaRWpIdvF/vrlqunvxsNFxQn4LbpbsU2fS yPXlJpWdm6k+NyrGb26nP7MFiHtX4oXtiExot84M9CTwP3oUCaBxIUn59eV4cK9SLQYQt2YrEZ9Rrp 09yoX0WT1E6V0dRrrlGfiWpX5Ao4vAEOD0nezmpJqAhGyqz4kchLRBErIWe1H/CaGiczrLDSQk3dnK pVDRlS2xewwlHdWTFH+Jj1EcT8IV2tc2tb2sUY2w+zzD3tlkJJ8QFsWiZ+fcHXhG+S+vTmwhxbDjAc Nl/cgKadjhJWmlV4OLx6NuNaMmYpHBMGwTsOuwTYdvhjFmggNyt8bgDNlYMGcZIR0xPXJ5DFXfo+1Z 6rDLIJMfP3ifrIoJpV1DMrG/m+PKAzZY+U4QyPrDto7RVK8tn68Ocr5PCAZA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The Linux NFS server currently responds to a zero-length NFSv3 WRITE
request with NFS3ERR_IO. It responds to a zero-length NFSv4 WRITE
with NFS4_OK and count of zero.

RFC 1813 says of the WRITE procedure's @count argument:

count
         The number of bytes of data to be written. If count is
         0, the WRITE will succeed and return a count of 0,
         barring errors due to permissions checking.

RFC 8881 has similar language for NFSv4, though NFSv4 removed the
explicit @count argument because that value is already contained in
the opaque payload array.

The synthetic client pynfs's WRT4 and WRT15 tests do emit zero-
length WRITEs to exercise this spec requirement. Commit fdec6114ee1f
("nfsd4: zero-length WRITE should succeed") addressed the same
problem there with the same fix.

But interestingly the Linux NFS client does not appear to emit zero-
length WRITEs, instead squelching them. I'm not aware of a test that
can generate such WRITEs for NFSv3, so I wrote a naive C program to
generate a zero-length WRITE and test this fix.

Fixes: 8154ef2776aa ("NFSD: Clean up legacy NFS WRITE argument XDR decoders")
Reported-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: stable@vger.kernel.org
---

Changes since v1:
- Patch description notes that this was introduced in an earlier commit
- Patch description notes that NFSv4 used to have the same issue


 fs/nfsd/nfs3proc.c |    6 +-----
 fs/nfsd/nfsproc.c  |    5 -----
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 4418517f6f12..2c681785186f 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -202,15 +202,11 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->committed = argp->stable;
 	nvecs = svc_fill_write_vector(rqstp, &argp->payload);
-	if (!nvecs) {
-		resp->status = nfserr_io;
-		goto out;
-	}
+
 	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
 				  rqstp->rq_vec, nvecs, &cnt,
 				  resp->committed, resp->verf);
 	resp->count = cnt;
-out:
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index eea5b59b6a6c..1743ed04197e 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -235,10 +235,6 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 		argp->len, argp->offset);
 
 	nvecs = svc_fill_write_vector(rqstp, &argp->payload);
-	if (!nvecs) {
-		resp->status = nfserr_io;
-		goto out;
-	}
 
 	resp->status = nfsd_write(rqstp, fh_copy(&resp->fh, &argp->fh),
 				  argp->offset, rqstp->rq_vec, nvecs,
@@ -247,7 +243,6 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
 		return rpc_drop_reply;
-out:
 	return rpc_success;
 }
 

