Return-Path: <linux-nfs+bounces-149-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E897FC8FC
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 23:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2219F2828C2
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 22:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A350D481A9;
	Tue, 28 Nov 2023 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7j4nNJs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D0B42A8B;
	Tue, 28 Nov 2023 22:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E751C433C8;
	Tue, 28 Nov 2023 22:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701208891;
	bh=Z5q1nWir3D4xeYI26VCmOgnrj7QJ+8lOh3nj9WRJglk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=V7j4nNJsyt1zC0QLK9fikj3/pgOt6Y3AzzsrI2J2W5TVmNkCyjGRC+vMpfWsf0zb9
	 KNgGzkxc1Vj+pMhptGyuxfYaHGNMbAsIhnSLjSGWiSqsGl/2IEBvfwcz1m5A+rg9SD
	 1cmpNdzVMNxIS2uQ63X8rVI/MksAQamLhsTXByqW32jFxw/hJuShv4sO2LRkLQ2GJq
	 FKz3C7PbVG9P+u/gWrzMmWi6OkjSdf1PmF/nthbbYZOGgN7D/ADYcWbsggAPjp1rm2
	 gqN9JRitstni3Pkyhg97vauDeUrA+D4giCU4SWzOD975vN4jEm0mLc30zQzowogRdc
	 85BbnCXsoqvNQ==
Subject: [PATCH 1/2] NFSD: Fix "start of NFS reply" pointer passed to
 nfsd_cache_update()
From: Chuck Lever <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Tue, 28 Nov 2023 17:01:30 -0500
Message-ID: 
 <170120889023.1725.6734851513409877139.stgit@klimt.1015granger.net>
In-Reply-To: 
 <170120886349.1725.10740679467794019580.stgit@klimt.1015granger.net>
References: 
 <170120886349.1725.10740679467794019580.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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
---
 fs/nfsd/nfssvc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 6b20f285f3ca..ca2a9d0eefc2 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1027,6 +1027,7 @@ nfsd(void *vrqstp)
 int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
 	const struct svc_procedure *proc = rqstp->rq_procinfo;
+	__be32 *nfs_reply;
 
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
@@ -1053,6 +1054,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	 */
 	svcxdr_init_encode(rqstp);
 
+	nfs_reply = xdr_inline_decode(&rqstp->rq_res_stream, 0);
 	*statp = proc->pc_func(rqstp);
 	if (*statp == rpc_drop_reply || test_bit(RQ_DROPME, &rqstp->rq_flags))
 		goto out_update_drop;
@@ -1060,7 +1062,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
 		goto out_encode_err;
 
-	nfsd_cache_update(rqstp, rqstp->rq_cachetype, statp + 1);
+	nfsd_cache_update(rqstp, rqstp->rq_cachetype, nfs_reply);
 out_cached_reply:
 	return 1;
 



