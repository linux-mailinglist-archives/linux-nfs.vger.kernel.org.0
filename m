Return-Path: <linux-nfs+bounces-217-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F277FF5B4
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 17:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FDC52817D6
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEB3537F9;
	Thu, 30 Nov 2023 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B9UCRKnt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B831710EF;
	Thu, 30 Nov 2023 16:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43779C433C8;
	Thu, 30 Nov 2023 16:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361862;
	bh=xU2O8DDROLqfxq5MZ/LBNoqvuViADVxMXbEtiXkV5ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B9UCRKntvb8+chXIyAiCSam9q5uFppMzXB7KjPtBS+Ja6SEc1IqJoxwhhhEB3UmoE
	 XSXUdo6K4yb14RVvhTAUrg0PpMnJP4TD/nUzLH2bENfH/kj66eYQrKQ7je3vma6oXg
	 mqiEKhs+uyLcoIUbCVcMyQs3zReFYrJM3VSXqX68=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.1 53/82] NFSD: Fix "start of NFS reply" pointer passed to nfsd_cache_update()
Date: Thu, 30 Nov 2023 16:22:24 +0000
Message-ID: <20231130162137.654346332@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162135.977485944@linuxfoundation.org>
References: <20231130162135.977485944@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 1caf5f61dd8430ae5a0b4538afe4953ce7517cbb ]

The "statp + 1" pointer that is passed to nfsd_cache_update() is
supposed to point to the start of the egress NFS Reply header. In
fact, it does point there for AUTH_SYS and RPCSEC_GSS_KRB5 requests.

But both krb5i and krb5p add fields between the RPC header's
accept_stat field and the start of the NFS Reply header. In those
cases, "statp + 1" points at the extra fields instead of the Reply.
The result is that nfsd_cache_update() caches what looks to the
client like garbage.

A connection break can occur for a number of reasons, but the most
common reason when using krb5i/p is a GSS sequence number window
underrun. When an underrun is detected, the server is obliged to
drop the RPC and the connection to force a retransmit with a fresh
GSS sequence number. The client presents the same XID, it hits in
the server's DRC, and the server returns the garbage cache entry.

The "statp + 1" argument has been used since the oldest changeset
in the kernel history repo, so it has been in nfsd_dispatch()
literally since before history began. The problem arose only when
the server-side GSS implementation was added twenty years ago.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfssvc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1027,6 +1027,7 @@ out:
 int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
 	const struct svc_procedure *proc = rqstp->rq_procinfo;
+	__be32 *nfs_reply;
 
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
@@ -1053,6 +1054,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp
 	 */
 	svcxdr_init_encode(rqstp);
 
+	nfs_reply = xdr_inline_decode(&rqstp->rq_res_stream, 0);
 	*statp = proc->pc_func(rqstp);
 	if (*statp == rpc_drop_reply || test_bit(RQ_DROPME, &rqstp->rq_flags))
 		goto out_update_drop;
@@ -1060,7 +1062,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp
 	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
 		goto out_encode_err;
 
-	nfsd_cache_update(rqstp, rqstp->rq_cachetype, statp + 1);
+	nfsd_cache_update(rqstp, rqstp->rq_cachetype, nfs_reply);
 out_cached_reply:
 	return 1;
 



