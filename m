Return-Path: <linux-nfs+bounces-22138-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UyZGJRu0HGpyRgkAu9opvQ
	(envelope-from <linux-nfs+bounces-22138-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 00:20:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 808816181A9
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 00:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F1073002F76
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 22:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC4633D6EA;
	Sun, 31 May 2026 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpMxsLgU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC59932E126;
	Sun, 31 May 2026 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780266004; cv=none; b=iuNdj7oF/Go2GaDHAZCIPgUjA0PmAah0yHilms953t7OgF+v3m8lV/N5NSURlbRJ+Zh3q3lBVFuJw3VoZSjmMbXEy9WP20xZWog10SIzsDTyc8e28AZXsUdHvrzEXhP5kNed7X/qpEOwIUGaYer7MtB8aW8SCZZrQzNSdyjjpsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780266004; c=relaxed/simple;
	bh=4d4tDlx5ExYV3NjTUOdSlcoC8xdF9AYJ8Vbj9bWxcGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rYyvFuYRh2bnnLp0irF+GNl20CP9urQWanC77mDuflhsF+WgKhBlVTZUD+AMb9UX+VtMIDraI1HsvbxcXabUdC38E2MgyQNwikbY5dfcz7zqKoNm6SLSbPcgBXKEvhAafGerf2GNa4qaTXYA8/lh8CzdILAxDkSCHNyroB6olwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpMxsLgU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA411F00893;
	Sun, 31 May 2026 22:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780266003;
	bh=ZIDQshxXpsH10xvID4DBalEqTsFBYGH8gZM+/6uOlOA=;
	h=From:Date:Subject:To:Cc;
	b=BpMxsLgUYBpYDeYiGxUp4rgQ1moizkTMMJGqcBlHEfUp1wBaBc5WKQIaUKRTmoYxq
	 vTpeM15eFcnyRPaFbCGtd25DwG6RtfpazXhblZ48vbdh+WB+AUi9FSkPaRBVHA8fKQ
	 hrB+Tdb3jBAF9qi3wACpvRiZ3BwoeAo69wj/+YnujEtsyNGn36yX08FE94rKKcGglA
	 VuN1p7nzYb6rcvRICuA6zFo8W6Uy9M6uYWxRTIOuswDtBOAVq2R1HM+zhA8IiMT3Az
	 VrZ411ir9D/5nfl168GxpL9pPsR5DWuVIUPXHceQddsOSsBoR5c5BJc9pUN9sADOGu
	 V6M3IkcD86Zbg==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 31 May 2026 18:19:57 -0400
Subject: [PATCH v2] nfsd: release OPEN-decoded posix ACLs via op_release
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-nfsd-testing-v2-1-e13e6355fc07@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMQQ7CIBCF4as0sxbDYFHrynuYLko7tBMNNECIp
 uHuYvcu/5e8b4NIgSnCrdkgUObI3tVQhwbGZXAzCZ5qg5LqLPUJhbNxEoliYjeLDpUyVuNInYZ
 6WQNZfu/co6+9cEw+fHY942/9A2UUUlyMHdorGqlbeX9ScPQ6+jBDX0r5AiGtKEGpAAAA
X-Change-ID: 20260531-nfsd-testing-9122bf51ce95
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Rick Macklem <rmacklem@uoguelph.ca>, 
 Chris Mason <clm@meta.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3685; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4d4tDlx5ExYV3NjTUOdSlcoC8xdF9AYJ8Vbj9bWxcGU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHLQStVOQdtcOZby8aj4eb7grIx2gEml3UIPb9
 JORYNx+vpyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahy0EgAKCRAADmhBGVaC
 FUOkD/9ZVMQ9PKwtFaSJOG+UstmyIi6c9T8O/i2wjunJ8n2jrwJfpGK8kqqUCH1rO1rKHVbGYQ8
 eqkJ59FuKIxrHhYQ5CySi3+NsQMZDftmyO0CsU9DH1h6CSqbxJbVgeCoKdcJRzBrOFsMTqZpKhF
 ArETx2Qnrd6DVQ7E/xfuELwzD3014gZlb6T3TUBzw5jq4Go1wSP8e3GfvJsaMHDJ/ZM4F/RtXq/
 bOQPQNqPLI1crCYRBHbRKy854s0lT79+Je0RkTCLXYbCJDnpc+//hAbwNAVue42IImu24jeoSfU
 lJkOn7ISIHoJc3jOxPwzqB02461E0VsDql+MboMDgBqhnM06cJuT+by1AJhOtRkm1h2UdZvDR4z
 SP3y7S0/hpJq97CdlViySs4UVr8sQBNsNkKgvft4b7aEvX2IuAeNH0T6lg6rUSoSi3pMk6/YCd7
 QaJbiRl7bKvl+1TTAKPP5U1FED7zxawdTSWCH5gmyE4MlaXuX6mVS+HjzSsSD8joAhB+tze5Ai7
 qHcfPwHA56Igf37Wa2QXfNvg9L38v1ipf7wEo9KJYN0K19MFBGuUHHLmzSsJJkT6EvZHLUGtWwl
 ObU9C352Osg4RLReq3iY9A1UC/FlmSgk1qZvpNq6H5vN9/Qv8T7BTSB+wMBeHcRgQat+ULmN7rq
 gRlhq3CwOdB9DkA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22138-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: 808816181A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd4_decode_createhow4() calls nfsd4_decode_fattr4(), which allocates
refcounted struct posix_acl objects via posix_acl_alloc() and stores
them in open->op_pacl and open->op_dpacl. These pointers must be
released once the OPEN compound finishes.

When nfsd4_decode_open_claim4() returns a non-seqid-mutating error,
the dispatcher short-circuits before op_func runs:

    nfsd4_proc_compound()
      opdesc->op_func == nfsd4_open_omfg
        if (!seqid_mutating_err(ntohl(op->status)))
            return op->status;   /* nfsd4_open() never runs */
      opdesc->op_release(&op->u)  /* must still release op_pacl/op_dpacl */

Before this change OP_OPEN had no .op_release in nfsd4_ops[], and the
release pair lived inside nfsd4_open() at its out_err: label. On the
short-circuit path nfsd4_open() is never invoked, so both posix_acl
refs leak on every malformed OPEN compound that carries valid POSIX
ACL createhow4 attributes.

Add nfsd4_open_release() and wire it as .op_release for OP_OPEN.
posix_acl_release() is NULL-safe, so the single release site covers
both the normal path and the nfsd4_open_omfg short-circuit. Remove
the matching posix_acl_release() pair from nfsd4_open()'s out_err:
label to avoid double-releasing.

The compound loop has two encoding branches: nfsd4_encode_operation()
for normal ops, and nfsd4_encode_replay() for v4.0 replayed ops.
op_release was only called from nfsd4_encode_operation(), so resources
attached to op->u leak on the replay path. Add an op_release call to
the replay branch as well to ensure cleanup on every path.

Fixes: 5fc51dfc2eb1 ("NFSD: Add support for XDR decoding POSIX draft ACLs")
Signed-off-by: Chris Mason <clm@meta.com>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- Ensure that op_release is called in the v4.0 replay case as well
- Link to v1: https://lore.kernel.org/r/20260531-nfsd-testing-v1-0-7bfa481b0540@kernel.org
---
 fs/nfsd/nfs4proc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 017474cd63b5..51998d7885ae 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -681,8 +681,6 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	nfsd4_cleanup_open_state(cstate, open);
 	nfsd4_bump_seqid(cstate, status);
 out_err:
-	posix_acl_release(open->op_dpacl);
-	posix_acl_release(open->op_pacl);
 	return status;
 }
 
@@ -704,6 +702,13 @@ static __be32 nfsd4_open_omfg(struct svc_rqst *rqstp, struct nfsd4_compound_stat
 	return nfsd4_open(rqstp, cstate, &op->u);
 }
 
+static void
+nfsd4_open_release(union nfsd4_op_u *u)
+{
+	posix_acl_release(u->open.op_dpacl);
+	posix_acl_release(u->open.op_pacl);
+}
+
 /*
  * filehandle-manipulating ops.
  */
@@ -3214,6 +3219,8 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 			op->replay = &cstate->replay_owner->so_replay;
 			nfsd4_encode_replay(resp->xdr, op);
 			status = op->status = op->replay->rp_status;
+			if (op->opdesc->op_release)
+				op->opdesc->op_release(&op->u);
 		} else {
 			nfsd4_encode_operation(resp, op);
 			status = op->status;
@@ -3718,6 +3725,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_OPEN] = {
 		.op_func = nfsd4_open,
+		.op_release = nfsd4_open_release,
 		.op_flags = OP_HANDLES_WRONGSEC | OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN",
 		.op_rsize_bop = nfsd4_open_rsize,

---
base-commit: 6c0004650ba248a12937ada16f9ba961b35ce2b5
change-id: 20260531-nfsd-testing-9122bf51ce95

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


