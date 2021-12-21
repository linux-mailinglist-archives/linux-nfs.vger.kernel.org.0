Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DC347C2BD
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 16:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbhLUPX2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 10:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239272AbhLUPX1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 10:23:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD9FC06173F
        for <linux-nfs@vger.kernel.org>; Tue, 21 Dec 2021 07:23:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE2D161654
        for <linux-nfs@vger.kernel.org>; Tue, 21 Dec 2021 15:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43167C36AE8
        for <linux-nfs@vger.kernel.org>; Tue, 21 Dec 2021 15:23:26 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC] NFSD: Fix zero-length NFSv3 WRITEs
Date:   Tue, 21 Dec 2021 10:23:25 -0500
Message-Id:  <164010014140.6448.18108343631467243001.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2658; h=from:subject:message-id; bh=nM2VxyY5nDtGSGYJadFE7WyaixhAnB0PKnxp+tAvCc0=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhwfFm+kFbM5YJ4p5qSHPqU0ccxTE7ZFFJuQEYCNcO +tT4zKuJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYcHxZgAKCRAzarMzb2Z/lydeD/ 9gHtK6KUncwarqASvJJdWvQrATCuaJUnDL3eYBasSj89d+J58PUZGKLXSmKqNBx8to5SLUbblMR3rm yAH6d1qp8WcfBBYhXNxrIH2nRfOJV+BO5jyLLjPifve8AI2l3vLJdCkIlpagsFP3J0v4wExwSPiFVE Qrc1PVReoA1zlCkJPKLJi4rbsq1tt1tZWJYUSvFAEDKYT2ycTNzq4eJ1Uyape0tBNIbOo5sGh59rOP Q4/VhXjtuvut1jSqQC88k/VyguaoZwfWCdJ4MOgIIyoPu7YpvIcF+VrA4c7EVZBUhoExjeAZoDAT0N KcbVRG2datWT/1Ahl0H0NWj2MpdJzzBv5KR5gVb+jMNGx+67KdIVa6h8he3MRKOMkY5KPBjoDCNu/1 k5kujaNTerLW6emK4IktG/wEavRHZU8aBlZ/CSIHRxDzv67A3RVrcLQMCKg1UHz4sduGbOs10OAlt8 K2Z5jIC0k9ZpwbJZtkCM7K6pmlDukamo2qwGz1D5makH02/LhjTtA0qUOeEgAm5/N210Oc8GajT0/Q dD0LFVkpcSvJryCqXN2O0AyI8sUDjw8EjWg0ngCZoF0IxOwUyNmLHCM2mHn9RPkYNOMFBOdW75yqXs UYLMLM2fa1dkuODdb8pEUW+MjyB2RIcPE3toF6RlablhVZt7GyZu+G/wFpdQ==
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
length WRITEs to exercise this spec requirement, but interestingly
the Linux NFS client does not appear to emit zero-length WRITEs,
instead squelching them.

I'm not aware of a test that can generate such WRITEs for NFSv3, so
I wrote a naive C program to generate a zero-length WRITE and test
this fix.

Fixes: 14168d678a0f ("NFSD: Remove the RETURN_STATUS() macro")
Reported-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---

Here's an alternate approach to addressing the zero-length NFSv3
WRITE failures.


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
 

