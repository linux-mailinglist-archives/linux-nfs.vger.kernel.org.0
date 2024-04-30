Return-Path: <linux-nfs+bounces-3105-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B82B8B8119
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 22:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2231C23F28
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 20:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1B1199EBC;
	Tue, 30 Apr 2024 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtkjsVNK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760FF199EBB
	for <linux-nfs@vger.kernel.org>; Tue, 30 Apr 2024 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507530; cv=none; b=XOXF/NjRihAGqsGl2SUH2/c3gxKcX2qIxZ2Y3pYPlRnylU8etdY17SPbImC7v1b/KWovRf7v5oD/siOzPJokbYsc7fVzGtwazJY1ZmUwTHww7gySE2YgIUZvgmuWsXgn4/G68K7pBICESoJFOuXI2qRCny2oHMO8AjQgAGyegm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507530; c=relaxed/simple;
	bh=XJ/YIy+81aspaipHqwa60MH0eZw7tqngDsumo0wjvrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mt+gaNjRsq20CHB7oH/7KmBofbDHbPoGgtpJDC1Qvvwfl8pHPpB4mlMWz9N8RfUv5/m7jHfwecv42SjS/FYoveLbh5Dg05c2y3ZDGxG+fe6psmltT9BWzLMst8eV/fciiv25hnGecvZuhmhBk0ROyAlcDcWPTUzVF/eytUZUG5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtkjsVNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FCBC4AF17;
	Tue, 30 Apr 2024 20:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714507530;
	bh=XJ/YIy+81aspaipHqwa60MH0eZw7tqngDsumo0wjvrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dtkjsVNKzNCCLLQstgOTSbclNuJulktmSyyti7QVgPGevzf+l0vuZ1VRLPQipAI0q
	 00+GCQGmPAA9Ae6tH9uCd7hU9V+xOcxdF6yZa0Swc1Ilvd7/9WVX9282GE18PiM/ki
	 nxchT4RlYCCcmn9/mj+y1JWv+8O7lZ7mYkQRxFvRYpuTaYwXKDBUrA90DJ+CZEQtbI
	 hMH5X//97LjSAtis87mm0n1q528P6kxDaA0+/RE/oGOW42C3ttyhJV1oknnkHXzDh8
	 2MgqFBB05MtLniL2h1P+zuij8Tf9/ZclB0jeZyoILepxS046UV/Mn7Rw6UIWZMeKtC
	 1Habki0V1+soQ==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 2/2] NFSD: Add COPY status code to OFFLOAD_STATUS response
Date: Tue, 30 Apr 2024 16:05:11 -0400
Message-ID: <20240430200519.6253-3-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430200519.6253-1-cel@kernel.org>
References: <20240430200519.6253-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Clients that send an OFFLOAD_STATUS might want to distinguish
between an async COPY operation that is still running, has
completed successfully, or that has failed.

The intention of this patch is to make NFSD behave like this:

 * Copy still running:
	OFFLOAD_STATUS returns NFS4_OK, the number of bytes copied
	so far, and an empty osr_status array
 * Copy completed successfully:
	OFFLOAD_STATUS returns NFS4_OK, the number of bytes copied,
	and an osr_status of NFS4_OK
 * Copy failed:
	OFFLOAD_STATUS returns NFS4_OK, the number of bytes copied,
	and an osr_status other than NFS4_OK
 * Copy operation lost, canceled, or otherwise unrecognized:
	OFFLOAD_STATUS returns NFS4ERR_BAD_STATEID

NB: Though RFC 7862 Section 11.2 lists a small set of NFS status
codes that are valid for OFFLOAD_STATUS, there do not seem to be any
explicit spec limits on the status codes that may be returned in the
osr_status field.

At this time we have no unit tests for COPY and its brethren, as
pynfs does not yet implement support for NFSv4.2.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 10 ++++++++--
 fs/nfsd/nfs4xdr.c  |  7 ++++++-
 fs/nfsd/xdr4.h     |  4 +++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7e6580384cdb..ea3cc3e870a7 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1793,6 +1793,7 @@ static int nfsd4_do_async_copy(void *data)
 	}
 
 do_callback:
+	set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
 	nfsd4_send_cb_offload(copy);
 	cleanup_async_copy(copy);
 	return 0;
@@ -2002,11 +2003,16 @@ nfsd4_offload_status(struct svc_rqst *rqstp,
 	struct nfsd4_copy *copy;
 	struct nfs4_client *clp = cstate->clp;
 
+	os->completed = false;
 	spin_lock(&clp->async_lock);
 	copy = find_async_copy_locked(clp, &os->stateid);
-	if (copy)
+	if (copy) {
 		os->count = copy->cp_res.wr_bytes_written;
-	else
+		if (test_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags)) {
+			os->completed = true;
+			os->status = copy->nfserr;
+		}
+	} else
 		status = nfserr_bad_stateid;
 	spin_unlock(&clp->async_lock);
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 85d43b3249f9..b1312312b99f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5271,7 +5271,12 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
 	if (nfserr != nfs_ok)
 		return nfserr;
 	/* osr_complete<1> */
-	if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
+	if (os->completed) {
+		if (xdr_stream_encode_u32(xdr, 1) != XDR_UNIT)
+			return nfserr_resource;
+		if (xdr_stream_encode_be32(xdr, os->status) != XDR_UNIT)
+			return nfserr_resource;
+	} else if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
 		return nfserr_resource;
 	return nfs_ok;
 }
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 62805931e857..fbdd42cde1fa 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -692,6 +692,7 @@ struct nfsd4_copy {
 #define NFSD4_COPY_F_INTRA		(1)
 #define NFSD4_COPY_F_SYNCHRONOUS	(2)
 #define NFSD4_COPY_F_COMMITTED		(3)
+#define NFSD4_COPY_F_COMPLETED		(4)
 
 	/* response */
 	__be32			nfserr;
@@ -754,7 +755,8 @@ struct nfsd4_offload_status {
 
 	/* response */
 	u64		count;
-	u32		status;
+	__be32		status;
+	bool		completed;
 };
 
 struct nfsd4_copy_notify {
-- 
2.44.0


