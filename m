Return-Path: <linux-nfs+bounces-22010-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLhdEpUHF2qn1gcAu9opvQ
	(envelope-from <linux-nfs+bounces-22010-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:02:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F13A5E67AF
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CCD33045391
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 14:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2148B36D51E;
	Wed, 27 May 2026 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNGa8LlA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E057F3D47DE;
	Wed, 27 May 2026 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893634; cv=none; b=O/b4knatriwHoPtK4XVUGJ4vPwo1JGm4fS5Z6xRB1ECXolMQx7z6/hkbeSt3+3VRPvRbMeCmVZ27v7b5LzDSthTgilvTAh/vc7nPuXoZUNH+5wLo/vX87HSz0GHTgwVttqGdsQUtYGYfX8dLnPXKyT1HV9EaZ7/kSz9TtDuHN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893634; c=relaxed/simple;
	bh=98MLjyvYrhzrQH4J5hiKb/zyKhZ8SpjtwX37jFESLtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nXeqT4wEd9+Q2gRKdG9Cy33WQeahHBV20h0QLZFwvU5sp4BIG152RgzM6sEqKkNi+05Sy4rhdupE/K/583Sh3jJLpf5e8m+9NwaomkUietj4PqV8eOjAWKfEfOlwPB+u10oCH9iJDDsGbN5bethJHmh4tHMUZv7wzkY6H0tGEIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNGa8LlA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7041F000E9;
	Wed, 27 May 2026 14:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779893632;
	bh=K2biNe7K+sWTnvQi5qsAYG5rVab2yt64WQhl+v7RAs4=;
	h=From:Date:Subject:To:Cc;
	b=dNGa8LlAcNL/O+ZAc8aVh0Uo9ca5dRMaN/s1sQtTdRPb2XcVGbxsBWO1fYts5UEvZ
	 nLi0JhBjmD80dqE3lveZ8jWFmRomhIij9p0z+tUeDES/BmA/jiiyKF0QJ5jOmYinAz
	 bnZHg8dU40PxG6S00TCc8odWkkBJkpB4//NRu4e7iXmUuNHXnDy8kbbYFUh9272T8z
	 FyuPlOOyWCXyJnCU1lLG7lPPxKEbadLprFZaft4EbBsaNIottIMsj5MAU0i/R+i2I2
	 E5yiHh17As5StRZbxlgQWiUNNJ8+3SYGzrHoNp6w5Yvi7LIIePpjLhKQ6GeH556voW
	 rQ5EbpJNDuIjA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 27 May 2026 10:53:37 -0400
Subject: [PATCH] nfsd: block non-SAVEFH ops after FOREIGN PUTFH to prevent
 NULL deref
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-putfh_foreign_fh_null_deref_consumers-v1-1-1b8a5aa28c59@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2N0QqDMAxFf0XyvELtcI79yhhFa6oBl0qyjoH47
 4a9ncOBe3dQFEKFR7OD4JeUCpu0lwbSMvCMjiZzCD7cfBd6t9VPXmIugjRzNOS6rnFCwRxTYa1
 vFHX+fh1S34acuhFsa7NMv//P83UcJ1YRc/R3AAAA
X-Change-ID: 20260527-putfh_foreign_fh_null_deref_consumers-083ac712fc5b
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2823; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=98MLjyvYrhzrQH4J5hiKb/zyKhZ8SpjtwX37jFESLtw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqFwV7CnjvpNzYHJu0CTvduIdn0V0p1aQzQWuqh
 YfrJIGIC22JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahcFewAKCRAADmhBGVaC
 FYhsD/0Z6a1teyZ+wsk4BurCfUEE4u/JAnp18E9HmH1KtKD+GltDfgs4NnSi2RPhl4Kl95R/975
 03JsvPqSQXREkuwF66I8l4TPuWdacm3lMXnuzKcdySTEMcgvReDnRDW0BQ06947dx4zax1/ERJ4
 V4VYgwv9ZfucZE3tRZZkaGAlipLx9wYdAXW0/jlOFLKOyuS+vxGLZds0dO2E2nwkaA7G+SO5x06
 FljH9Xx1dVwGwBe/XWtWCeqPQvOYTjO71w1iILQ85I+gfVOIP4AhdFJyBIzAPaKX7RXcvAzlRPx
 1DRBmMjUCOZfTpt/Is/bK4shknLn4sTOspiC0ZsUAvQBLQK+wnFFp7D00jA/d50rjkyPfUx1xk7
 eUEGX8btRKJcfrEaveOhu+TW+EY5eB3OghfdLNzYaxeJmEFx8ctYqVfN/TD/bD3EtTeImYA3KPp
 u4XxbOy4qbVl0VheICrIyhvIuoCDMyn/VxZVf042SYhncrH6h6DRcZVJ3TUEIEawSPy6Qb4c5qK
 7WCFk6T6EVwMg3h0IZt9tszmMroiCLQNlDop/qOV5xs53nBBpJG24qaHuRr+o6steVF+Z941I9x
 P5OHohLVvgKgQRdmlhWYvPYLo8a7p3N/xhT7ZVIyuZPKdAU58QUICjEbXom+wP8h087aM/pi1rC
 PhpfwQcCv+GfOcA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22010-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9F13A5E67AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When CONFIG_NFSD_V4_2_INTER_SSC is enabled, nfsd4_putfh() can return
success with fh_dentry and fh_export both NULL if fh_verify() returns
nfserr_stale and putfh->no_verify is true. The NFSD4_FH_FOREIGN flag
is set, but the compound dispatch loop only uses this flag to bypass
the nfserr_nofilehandle check -- it does not prevent subsequent ops
from running with a NULL fh_dentry.

A remote client can exploit this by crafting a COMPOUND that includes
an inter-SSC COPY (which causes check_if_stalefh_allowed() to set
no_verify=true on the saved PUTFH) with an additional op inserted
between the source PUTFH and SAVEFH. For example, SETATTR calls
fh_want_write() which dereferences fh_export->ex_path.mnt without
calling fh_verify() first, causing a NULL pointer dereference in the
nfsd kthread.

Fix this by gating the dispatch loop: when NFSD4_FH_FOREIGN is set
and fh_dentry is NULL, only OP_SAVEFH (needed for the inter-SSC flow)
and ops with ALLOWED_WITHOUT_FH (which don't need a resolved
filehandle) may proceed. All other ops receive nfserr_stale, per
RFC 7862 Section 15.2.3 which specifies that foreign filehandle
validation is deferred to the consuming operation and NFS4ERR_STALE
returned at that point.

Fixes: 3ad685d73ed8 ("NFSD: allow inter server COPY to have a STALE source server fh")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 34f2921e4ef8..00cd8dd460fc 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3138,9 +3138,22 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 				op->status = nfsd4_open_omfg(rqstp, cstate, op);
 			goto encode_op;
 		}
-		if (!current_fh->fh_dentry &&
-				!HAS_FH_FLAG(current_fh, NFSD4_FH_FOREIGN)) {
-			if (!(op->opdesc->op_flags & ALLOWED_WITHOUT_FH)) {
+		if (!current_fh->fh_dentry) {
+			if (HAS_FH_FLAG(current_fh, NFSD4_FH_FOREIGN)) {
+				/*
+				 * FOREIGN fh from inter-SSC PUTFH: only
+				 * SAVEFH may proceed with a NULL fh_dentry.
+				 * Per RFC 7862 S15.2.3, validation of a
+				 * foreign fh is deferred to the operation
+				 * that consumes it, and NFS4ERR_STALE is
+				 * returned at that point.
+				 */
+				if (op->opnum != OP_SAVEFH &&
+				    !(op->opdesc->op_flags & ALLOWED_WITHOUT_FH)) {
+					op->status = nfserr_stale;
+					goto encode_op;
+				}
+			} else if (!(op->opdesc->op_flags & ALLOWED_WITHOUT_FH)) {
 				op->status = nfserr_nofilehandle;
 				goto encode_op;
 			}

---
base-commit: b69fc3eaa867d0caa904634ea7a1b4569411b163
change-id: 20260527-putfh_foreign_fh_null_deref_consumers-083ac712fc5b

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


