Return-Path: <linux-nfs+bounces-11328-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA82A9F9BD
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 21:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F111A85F8A
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 19:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A952989A9;
	Mon, 28 Apr 2025 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EchwvkQb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410AA2989B3;
	Mon, 28 Apr 2025 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869040; cv=none; b=Q5tUdb42zAEJPDf8AnpE7K/TgWxjZcYvR7XKqKVpHATuoajV24ButvewMek5lC1pDPcBQHRoyCiBvaOlueiKHFWHM2IvVXXFCwk21tzVrhTNXtVzLUVdfoR8/nHHZAy3b85aoV/hw5enyI1cAyhd0vsBPZT8lKkulrXucr0JtWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869040; c=relaxed/simple;
	bh=MLFijvn9A2PBRAiCejkw0WIxqWbYziVs31yMA8m9hBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtCjtJeo8lLX2lkiQdrmFv2IIZvhdRUiYO/b43ylHNmAWBMSPopW74o/JfCYYGh2Ic5h2bJrX1xdbOZfjLhbOeoi4oOYVy12ti33+rgfmoMAbVgedGq2+lLqRQVKBI2OcwUBdLIo+6Gafl6BvBqlJowh85/zcbxGYNGRt2X11Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EchwvkQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8922FC4AF0B;
	Mon, 28 Apr 2025 19:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745869037;
	bh=MLFijvn9A2PBRAiCejkw0WIxqWbYziVs31yMA8m9hBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EchwvkQbCJK+PrIGtY9v7h5MZ53SqkFWh0FfERG6liwujy86RnWyFd1jwQqnxvma3
	 WDMpCHVZZ/9SYy+jCYtXDHYL4JN9+CEtr4It60g3c8DGgxAfw9JHlCAod2PjQFziUS
	 dVuHq/bdRtSr6powLO6HA6Nzagq4G+Rvo33xC8x3ip9SvTw7GGUYyvUCzi30HTRANT
	 DVc5SL+dzs8VkRuYzUwiaY60A1WrYE8GrDEbxnHbMzmv5XQBJZDnrMR0YBbtsa2A8U
	 D9rXGd3dSvk5Q+DM++QepcJSBAv9QdQzlkoe/doUBIEORKZv2Bh0AA3r+zHHJUPNNL
	 ySYSSKuNLXACA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 11/14] NFSD: Remove NFSD_BUFSIZE
Date: Mon, 28 Apr 2025 15:36:59 -0400
Message-ID: <20250428193702.5186-12-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428193702.5186-1-cel@kernel.org>
References: <20250428193702.5186-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Clean up: The documenting comment for NFSD_BUFSIZE is quite stale.
NFSD_BUFSIZE is used only for NFSv4 Reply these days; never for
NFSv2 or v3, and never for RPC Calls. Even so, the byte count
estimate does not include the size of the NFSv4 COMPOUND Reply
HEADER or the RPC auth flavor.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c  |  2 +-
 fs/nfsd/nfs4state.c |  2 +-
 fs/nfsd/nfs4xdr.c   |  2 +-
 fs/nfsd/nfsd.h      | 13 -------------
 4 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b397246dae7b..59451b405b5c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3832,7 +3832,7 @@ static const struct svc_procedure nfsd_procedures4[2] = {
 		.pc_ressize = sizeof(struct nfsd4_compoundres),
 		.pc_release = nfsd4_release_compoundargs,
 		.pc_cachetype = RC_NOCACHE,
-		.pc_xdrressize = NFSD_BUFSIZE/4,
+		.pc_xdrressize = 3+NFSSVC_MAXBLKSIZE/4,
 		.pc_name = "COMPOUND",
 	},
 };
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 59a693f22452..8adcee9dc4d3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4402,7 +4402,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				    nfserr_rep_too_big;
 	if (xdr_restrict_buflen(xdr, buflen - rqstp->rq_auth_slack))
 		goto out_put_session;
-	svc_reserve(rqstp, buflen);
+	svc_reserve_auth(rqstp, buflen);
 
 	status = nfs_ok;
 	/* Success! accept new slot seqid */
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 44e7fb34f433..ac1bc2431f27 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2564,7 +2564,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 	/* Sessions make the DRC unnecessary: */
 	if (argp->minorversion)
 		cachethis = false;
-	svc_reserve(argp->rqstp, max_reply + readbytes);
+	svc_reserve_auth(argp->rqstp, max_reply + readbytes);
 	argp->rqstp->rq_cachetype = cachethis ? RC_REPLBUFF : RC_NOCACHE;
 
 	argp->splice_ok = nfsd_read_splice_ok(argp->rqstp);
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index e2997f0ffbc5..91d144655351 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -50,19 +50,6 @@ bool nfsd_support_version(int vers);
 /* NFSv2 is limited by the protocol specification, see RFC 1094 */
 #define NFSSVC_MAXBLKSIZE_V2    (8*1024)
 
-
-/*
- * Largest number of bytes we need to allocate for an NFS
- * call or reply.  Used to control buffer sizes.  We use
- * the length of v3 WRITE, READDIR and READDIR replies
- * which are an RPC header, up to 26 XDR units of reply
- * data, and some page data.
- *
- * Note that accuracy here doesn't matter too much as the
- * size is rounded up to a page size when allocating space.
- */
-#define NFSD_BUFSIZE            ((RPC_MAX_HEADER_WITH_AUTH+26)*XDR_UNIT + NFSSVC_MAXBLKSIZE)
-
 struct readdir_cd {
 	__be32			err;	/* 0, nfserr, or nfserr_eof */
 };
-- 
2.49.0


