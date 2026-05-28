Return-Path: <linux-nfs+bounces-22057-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAEiCya6GGqsmggAu9opvQ
	(envelope-from <linux-nfs+bounces-22057-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 23:56:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D212E5FA9F7
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 23:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F826307AC6C
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6240D367F40;
	Thu, 28 May 2026 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SodWuNrt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100DB367B81;
	Thu, 28 May 2026 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005339; cv=none; b=gl0IUQJ/tviowEhiQHdv9myHCVirHVsG4WFmPFIoD3fRAcnsu3EHMia4lMrhHg0+mGoTjK8Pns42o7zDOogub9giM8ww00WebWPgYBl+c3Wv5P/xoYfs3emWr2YmcA9cKrbypMYdbqmubUG9Gj2nrZWmidJzvRUm2spAAHj8Sjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005339; c=relaxed/simple;
	bh=mGJVvZo9pTZBX+sMN/JjmrBkf4z2jBAjKn61+R0qI6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F1oRJQmP1eeiolqFujqO8Wbl0LJUJFQ6PIOWhZBqZhj23rCxfMCKXKkYhIel0BteHDjtwzF5Xyi/SIj1lac2KioF/rZEzaOJKq3jM6pMCNAcF1C6TTKsK40TBKqBjMO7kJkVLqTqr9N7aM+dEPSMdXAovS+MkmAQ7lksLZl6iFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SodWuNrt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847CD1F00A3D;
	Thu, 28 May 2026 21:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780005334;
	bh=kXcChEzVlnxyp0TLNxJmodA24yVV9lKapnt3Z+Taqp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SodWuNrt+p0jGlkC5+Zsp06dRyODq4bp6XGfLz8CYZEtKetdIC7C+4cxoSU1y4r9E
	 hWBbw2WnVKWh/cfTVeqrJ89679N+jE1sbkj9E+HnKi6XMvgRrFN0egp3ZZI86u/82b
	 CJhwH6Vh2n9D5LPdEyuVyPPkpAGwprTteoNQ8FA20lxlMfzO11+WIhCjDt8jXbDXqa
	 EgWMAZGsd398POsk/xsMFzKCI4RdsGpowvZzylNOhN352zND+vq8fm2QP1XNfuPdnY
	 SCVSgSbwpchaO/GYQulHZd1Li7WocxG/Tr8i35PuDr98AHGxTt+xrmz50OZ/JZIpTg
	 F6UrUS+5GgS2Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 28 May 2026 17:55:17 -0400
Subject: [PATCH 06/10] NFSD: Enable return of an updated stable_how to NFS
 clients
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-nfsd-fixes-v1-6-e78708eff77d@kernel.org>
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
In-Reply-To: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Scott Mayhew <smayhew@redhat.com>, 
 Trond Myklebust <Trond.Myklebust@netapp.com>, 
 Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>, 
 Rick Macklem <rmacklem@uoguelph.ca>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6219; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=D2zRN4G1nHhfU/M0zPTKcCcUcIm2L9GJqomla9PCqvI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGLnLbYWRie82+AbNz+9KrirVA2dFJKeMRvESg
 r77+WatiX6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahi5ywAKCRAADmhBGVaC
 FVfCEACph1B7Y4nm1fqSJ5PfOq2YosITIwruGzxX/YdwaE6uki8zKDQ5hyyPKYEEQdbVkn2w6PA
 J9TZ0hh/Mm7uqoYUEEg7JhfijgcBcRxRbnWf8jRTlubjSdsn39HdXYyLCZSqvFeiccoehckRN0i
 qlXSZ2sp01OZxc8PbpuGLaLoopaEbun9GpKmwVdbSzLpUY9/9WU9a5sdU0WJjyYOjiYgzA8Z0Pt
 //cL74XYSa8DqmQQ46I/YW0GnKhMDnVD+2UyXtUDjz19Vc1RBH1poF4QmwpzZ6jo/jtPF0TAkjU
 awI3OvirOr1ajT4pumuLSKaJLJK0AXGn23U+GhFj4zAGiQjXC6QjVoLJd5kTUpXutMh4jQQ9D6/
 Mnu6iHuU4tWuyMzZmHB15puKpSIN3/7fRzVtXmq4HwKoGejAKg40f4I/37o3p8FUBpivBfZ4DRl
 H1CVnHlNbal0bOvMtz59aGdQ0RwBAlConFIC09TQ0DuWq8JhhERO0kESqh2KmnCewG+BJNM18uW
 tYB0UQkYJkNHg7saOfa3WgW/X5ZafPUBQl0Wnh8+STRZlicjqyEUgEquK3qE9aUnTjCj+xfIdsj
 9Yd43pRHHpYbIYeHr1l1cvj0z4LwcWxc7qacwp0j0OyWtz+826gHFMxGLsHSk+TxHc1XgJcO2vI
 c3xXmKecceU4Esg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22057-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D212E5FA9F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

In a subsequent patch, nfsd_vfs_write() will promote an UNSTABLE
WRITE to be a FILE_SYNC WRITE. This indicates that the client does
not need a subsequent COMMIT operation, saving a round trip and
allowing the client to dispense with cached dirty data as soon as
it receives the server's WRITE response.

This patch refactors nfsd_vfs_write() to return a possibly modified
stable_how value to its callers. No behavior change is expected.

Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Fixes: 3f3503adb332 ("NFSD: Use vfs_iocb_iter_write()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |  2 +-
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/nfsproc.c  |  3 ++-
 fs/nfsd/vfs.c      | 11 ++++++-----
 fs/nfsd/vfs.h      |  6 ++++--
 fs/nfsd/xdr3.h     |  2 +-
 6 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index aeda7a802bdf..dd5ac59e87d6 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -236,7 +236,7 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
 	resp->committed = argp->stable;
 	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
 				  &argp->payload, &cnt,
-				  resp->committed, resp->verf);
+				  &resp->committed, resp->verf);
 	resp->count = cnt;
 	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5f2b9bfc3a84..ac03f9d89288 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1355,7 +1355,7 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	write->wr_how_written = write->wr_stable_how;
 	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
 				write->wr_offset, &write->wr_payload,
-				&cnt, write->wr_how_written,
+				&cnt, &write->wr_how_written,
 				(__be32 *)write->wr_verifier.data);
 	nfsd_file_put(nf);
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 8873033d1e82..d0a7316f00a5 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -251,6 +251,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 	struct nfsd_writeargs *argp = rqstp->rq_argp;
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 	unsigned long cnt = argp->len;
+	u32 committed = NFS_DATA_SYNC;
 
 	dprintk("nfsd: WRITE    %s %u bytes at %d\n",
 		SVCFH_fmt(&argp->fh),
@@ -258,7 +259,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
-				  &argp->payload, &cnt, NFS_DATA_SYNC, NULL);
+				  &argp->payload, &cnt, &committed, NULL);
 	if (resp->status == nfs_ok)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 1e89c7ff9493..7f07292d1569 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1414,7 +1414,7 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * @offset: Byte offset of start
  * @payload: xdr_buf containing the write payload
  * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
- * @stable: An NFS stable_how value
+ * @stable_how: IN: Client's requested stable_how, OUT: Actual stable_how
  * @verf: NFS WRITE verifier
  *
  * Upon return, caller must invoke fh_put on @fhp.
@@ -1426,11 +1426,12 @@ __be32
 nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	       struct nfsd_file *nf, loff_t offset,
 	       const struct xdr_buf *payload, unsigned long *cnt,
-	       int stable, __be32 *verf)
+	       u32 *stable_how, __be32 *verf)
 {
 	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct file		*file = nf->nf_file;
 	struct super_block	*sb = file_inode(file)->i_sb;
+	u32			stable = *stable_how;
 	struct kiocb		kiocb;
 	struct svc_export	*exp;
 	struct iov_iter		iter;
@@ -1609,7 +1610,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * @offset: Byte offset of start
  * @payload: xdr_buf containing the write payload
  * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
- * @stable: An NFS stable_how value
+ * @stable_how: IN: Client's requested stable_how, OUT: Actual stable_how
  * @verf: NFS WRITE verifier
  *
  * Upon return, caller must invoke fh_put on @fhp.
@@ -1619,7 +1620,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
  */
 __be32
 nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
-	   const struct xdr_buf *payload, unsigned long *cnt, int stable,
+	   const struct xdr_buf *payload, unsigned long *cnt, u32 *stable_how,
 	   __be32 *verf)
 {
 	struct nfsd_file *nf;
@@ -1632,7 +1633,7 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
 		goto out;
 
 	err = nfsd_vfs_write(rqstp, fhp, nf, offset, payload, cnt,
-			     stable, verf);
+			     stable_how, verf);
 	nfsd_file_put(nf);
 out:
 	trace_nfsd_write_done(rqstp, fhp, offset, *cnt);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index e09ea04a51b9..36cd9f6edd8b 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -132,11 +132,13 @@ __be32		nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				u32 *eof);
 __be32		nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				loff_t offset, const struct xdr_buf *payload,
-				unsigned long *cnt, int stable, __be32 *verf);
+				unsigned long *cnt, u32 *stable_how,
+				__be32 *verf);
 __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct nfsd_file *nf, loff_t offset,
 				const struct xdr_buf *payload,
-				unsigned long *cnt, int stable, __be32 *verf);
+				unsigned long *cnt, u32 *stable_how,
+				__be32 *verf);
 __be32		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
 				char *, int *);
 __be32		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index a7c9714b0b0e..1ff7b11c397c 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -152,7 +152,7 @@ struct nfsd3_writeres {
 	__be32			status;
 	struct svc_fh		fh;
 	unsigned long		count;
-	int			committed;
+	u32			committed;
 	__be32			verf[2];
 };
 

-- 
2.54.0


