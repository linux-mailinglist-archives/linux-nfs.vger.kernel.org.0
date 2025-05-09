Return-Path: <linux-nfs+bounces-11638-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E353EAB1D0D
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1151898082
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F035E245003;
	Fri,  9 May 2025 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6reL5+O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0C723C384;
	Fri,  9 May 2025 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817450; cv=none; b=rMh24O1sw3U1hZa+oRRDs/Wq7kK/YklbWSqlvdtDGUWjPyfJtghsHAmcr3LGENshFaPPjkajVcWipz+jxXC92Don6N4cuO6lPnOvDEi6KpZglj7q36X71Hc5euuz+/SEmoWh4WFWDBS3FmJLea0sx6Z3mng0nEtmwbc1jbpZH6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817450; c=relaxed/simple;
	bh=M/Lfrf087qO9B79H+xDEzfJt9VMUmhaCde0lA04a4TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uT9BfS3Zg6drDQL394vVYXRUtbqEGbaOvpXteXZ5QEel4ydIbxVlszWmUA5HtNGZd/p99DhDMwWr6Pt/1C7T+VxihoQjjusYSowtJWH5ocbmr6yC1dge9MCBhAjwf3Ztj7drtN0wzHL49Eu1CYzP+4AUMJDunG3S2FizRmgmC+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6reL5+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16054C4CEEF;
	Fri,  9 May 2025 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817450;
	bh=M/Lfrf087qO9B79H+xDEzfJt9VMUmhaCde0lA04a4TU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6reL5+OfjdzGdngSSdv5a5Z7lp+l0lG6HMbzbztueojEU32I4Gv861F0benWlnGS
	 MhcvdanLHdX7bgSRRuxsWY6IH+a8I8d1xjqmaBoPmVF7AcIrJrL/mjkDMzdZXE4Ury
	 t53MFBXtgM/MA+H/YLG7ZaOPeqosR/UXUSrl8qFjIjk6paTzNlxa2f+DO+PCoDEyP2
	 m4pgVS8xdyN5a8Q2nwjNZdKvl8TOuYvZzmII/sbmu07+YWUxqzMJn+q7se4f8T/vze
	 p3CDWUy9MVqUddwA0JqxEj4zYIithUchJ3XNSo7n1UpZD2rywCbj+3YgCUzPBfUyRN
	 Rhm+Xltinyk5w==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 16/19] NFSD: Remove NFSD_BUFSIZE
Date: Fri,  9 May 2025 15:03:50 -0400
Message-ID: <20250509190354.5393-17-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509190354.5393-1-cel@kernel.org>
References: <20250509190354.5393-1-cel@kernel.org>
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c  |  2 +-
 fs/nfsd/nfs4state.c |  2 +-
 fs/nfsd/nfs4xdr.c   |  2 +-
 fs/nfsd/nfsd.h      | 13 -------------
 4 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ffd8b1d499df..f28c8726755f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3845,7 +3845,7 @@ static const struct svc_procedure nfsd_procedures4[2] = {
 		.pc_ressize = sizeof(struct nfsd4_compoundres),
 		.pc_release = nfsd4_release_compoundargs,
 		.pc_cachetype = RC_NOCACHE,
-		.pc_xdrressize = NFSD_BUFSIZE/4,
+		.pc_xdrressize = 3+NFSSVC_MAXBLKSIZE/4,
 		.pc_name = "COMPOUND",
 	},
 };
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ff6a3870cc6d..911ad4ecfe30 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4394,7 +4394,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				    nfserr_rep_too_big;
 	if (xdr_restrict_buflen(xdr, buflen - rqstp->rq_auth_slack))
 		goto out_put_session;
-	svc_reserve(rqstp, buflen);
+	svc_reserve_auth(rqstp, buflen);
 
 	status = nfs_ok;
 	/* Success! accept new slot seqid */
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9eb8e5704622..b5742d86b88d 100644
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
index 232aee06223d..b9ac81023c13 100644
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


