Return-Path: <linux-nfs+bounces-17217-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB6BCCD807
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E926303AC9C
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0700D2D8370;
	Thu, 18 Dec 2025 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIA9LGZc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10562D8DAF
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088852; cv=none; b=socRA8DrLqwkKK+XSBTr+XoDHCzzOSFw2VvOC6mD2hX0oOrSDhrkC52l1e67MdKNTjJxDCWdg9PKgz0ocZsFPXJ1cCFkUGyo3JptkC0Qn5iEuuVPsaixI7OCCpfGDSjYMCqLKqm4kzVn1TyfdBh3blbmwuxTQ4CpHfClXwO/6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088852; c=relaxed/simple;
	bh=A1hwG4IOUz56FP5TEVNmmS4DkWE0ItUf52qxV9TstCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuMVOduNyimnSTifT2ngC0dFgYs8noPvBZrm2nWIODIP5/nLVq6G/LOgjvvscLf6w4AEuUWzakFNWoI04TifLnCp71n0nNuTBOAL/53f5WS6qXv5H2UHAmSs67YZw42YjF9o0+lral6LUPzLGG4XLkOWANZGtgccmOzlzIjM1tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIA9LGZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042AEC113D0;
	Thu, 18 Dec 2025 20:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088852;
	bh=A1hwG4IOUz56FP5TEVNmmS4DkWE0ItUf52qxV9TstCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gIA9LGZc1Sr08+iqKmB0p2AxIvv1UlLF9Zk/cHLQtax3uRzwrAEgeezKoZxeIUmP5
	 fqeqD6o53XpkhQmccoYzJayy/5j0/7PfOoMLpILOcsntOqr+a+WTdnF/Qs6D22mBqD
	 /jPy/xw7oaZ3Vh8fF7ZnW+Ag7vRKhtM1BuCJfPkFRiX6AhjE8wvvawh4ctQa5i7Zr3
	 qC3S4+WtfGSxCCMflITAVPXYyi6haF2mySH1OWfCXomWosL55ucWKVM6fWIOSRUp0+
	 yf+F1khuWT/Ysc2N8cbnaniKxoL6stZyekJlwRfhbjmlEwHfIHYBORmQLMesP9ji1y
	 LElCplsMLxXaw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 29/36] lockd: Hoist file_lock init out of nlm4svc_decode_shareargs()
Date: Thu, 18 Dec 2025 15:13:39 -0500
Message-ID: <20251218201346.1190928-30-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218201346.1190928-1-cel@kernel.org>
References: <20251218201346.1190928-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Refactor: Remove one more dependency in fs/lockd/xdr4.c on the
"struct nlm_lock::fl" field in preparation for converting to
use machine-generated XDR.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 16 ++++++++++++----
 fs/lockd/xdr4.c     |  3 ---
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index c6baf0a73620..ae85526c9ec6 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -844,6 +844,7 @@ nlm4svc_proc_share(struct svc_rqst *rqstp)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_res *resp = rqstp->rq_resp;
+	struct nlm_lock	*lock = &argp->lock;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
 
@@ -858,14 +859,17 @@ nlm4svc_proc_share(struct svc_rqst *rqstp)
 	}
 
 	/* Obtain client and file */
-	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
+	locks_init_lock(&lock->fl);
+	lock->svid = ~(u32)0;
+	resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file);
+	if (resp->status)
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
 	/* Now try to create the share */
 	resp->status = nlmsvc_share_file(host, file, argp);
 
 	dprintk("lockd: SHARE         status %d\n", ntohl(resp->status));
-	nlmsvc_release_lockowner(&argp->lock);
+	nlmsvc_release_lockowner(lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rpc_success;
@@ -879,6 +883,7 @@ nlm4svc_proc_unshare(struct svc_rqst *rqstp)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_res *resp = rqstp->rq_resp;
+	struct nlm_lock	*lock = &argp->lock;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
 
@@ -893,14 +898,17 @@ nlm4svc_proc_unshare(struct svc_rqst *rqstp)
 	}
 
 	/* Obtain client and file */
-	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
+	locks_init_lock(&lock->fl);
+	lock->svid = ~(u32)0;
+	resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file);
+	if (resp->status)
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
 	/* Now try to lock the file */
 	resp->status = nlmsvc_unshare_file(host, file, argp);
 
 	dprintk("lockd: UNSHARE       status %d\n", ntohl(resp->status));
-	nlmsvc_release_lockowner(&argp->lock);
+	nlmsvc_release_lockowner(lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rpc_success;
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index f57d4881d5f1..57d513879ddf 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -268,9 +268,6 @@ nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_lock	*lock = &argp->lock;
 
-	locks_init_lock(&lock->fl);
-	lock->svid = ~(u32)0;
-
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
 		return false;
 	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
-- 
2.52.0


