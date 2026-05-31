Return-Path: <linux-nfs+bounces-22133-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF8YO4YkHGr9KAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22133-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 14:07:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F50615F58
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 14:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 708373004414
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 12:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286643876C1;
	Sun, 31 May 2026 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivLgseGV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE435675A;
	Sun, 31 May 2026 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780229240; cv=none; b=OwumpkWTaSDk1aHWx0ajSvghGWibj+/H/MYKuvnXT0I2yAPQ7k18HTJVbObGiAPnB4eA+2GSEOBwoOxQwiFg/5A8GBMrRf5CDSaPRK1quJ6HXFnlCWSrqUYKpiP+1Z+yowjlJrWz/pGLaI7KJkZ7mevwZ2YNPEiERLYOIJeeyYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780229240; c=relaxed/simple;
	bh=pDfefIwGeTqgym4zVoCl76BNhjW6fjA8nWkPCV+le70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a1ywsk1oul4+TVFTRZoHYDbfMfUEKmNz/9b9G18PmQFicEjA8bDJaKgG7bbcI07puXhnjnJMs/ISSmtAf05wjG2Hstt3pAhG8avsckyyXMW052ca/ENVDJJvW9LvRpgIM1y5X4u6ItLczCwgsdWKl7Hh/nHJlAJWmSwG64LL8ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivLgseGV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7695D1F00898;
	Sun, 31 May 2026 12:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780229235;
	bh=YoRiMUaryZSGFhT8wAUY9kTP9Cw6Kv6CxgoFKueVcnY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ivLgseGVg+defFclyq522USBkTZRnX1wEw/xCeE+OwVMq5KbQMlC8R4tPcyYN0mkO
	 8TO+9RnHXBmyLqMdf+lBNTffZpXFwVXgp13Y2G59xeLLy067oIHn4NLtcidCfske0U
	 C5bSTh87F152lOn2EZlK41xmVMzLHImzcURZDdCpE4D8hbx/3aiet42Giv2ZMGeW2H
	 LKWeStlC5VDZOYxTTZ/l5UwVp89JUhpDcHGpIckA9KC09BizEWvmFw6K6XaHb2/nsf
	 Q6mZCngqR8QmHzcHUiMI1u0buY5LmMyFPh/MEcEjiA3PdlZwloaIVHKmBrgcDWe12u
	 qkoHh68gOF1og==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 31 May 2026 08:07:02 -0400
Subject: [PATCH 5/6] nfsd: release OPEN-decoded posix ACLs via op_release
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-nfsd-testing-v1-5-7bfa481b0540@kernel.org>
References: <20260531-nfsd-testing-v1-0-7bfa481b0540@kernel.org>
In-Reply-To: <20260531-nfsd-testing-v1-0-7bfa481b0540@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, David Howells <dhowells@redhat.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Rick Macklem <rmacklem@uoguelph.ca>, 
 Chris Mason <clm@meta.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2868; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1tZ8B9UhB+Bx9KMTHtRshtVhe+siQXAJ59Qok3jyItA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHCRrgZXwA9r4vBk8s2b+RxWxigny0hXBA3hgR
 kIAzE/EhbeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahwkawAKCRAADmhBGVaC
 FSgJEAC3/Uk0SVnr+BKELqi14bliUkpkfcFM85OmfqSh2gvTFwE9odtAAll4Om0uwLpRG9qe6Ez
 GCyBtCYBSQ7GhlBzDUZo6ypspitWwE7ugIjCdrDheU+PuC0DEz+s/t5Ois3e6Kl1+lqIQLHenW5
 HZH7X39KMSSLP8bWvMURNa026HV8xXydNAmv6TbHG466D48rF/h2JfOm9mFPe4WKTzo1jMtdJet
 09zYAeYXB7nNVoYa3T18KjNEZo2l6J4umIlrwxmVFzlXeQuylwLNlD93egE7kbsNRjTmsSr8DfA
 +1vX8I9MEexGTfp5lDQKoWK2g+N71IC6VokU9zB6dboQjpsUQ+i88CAPAeHmL19sXnGQn518Tue
 AkftR1NK/ll67uy2f7rzEzDFAHYOhZSSYQdWgEzn2Z9DamC1lbRgG99gRke6hYj/HxWNFpX9l1K
 4mS/t5Gr6hYHcxwQARhwIZUySINZEFTjiglIYGt4hxOzHz5y2SxUOKsM6ZxRBFIL+exh72a1Ysj
 P3+OqzM4DPwiXrEBX22nzj5XZvsOhEwdjNNcA+cBGyuNsT9+2S5NDxEPps7RRn8c/9Ybq0eTZyj
 T2VH4b/bD/LkUHylE+Tr957//FquzerxU1ocWGtMfTSogBNfWRuxgezJ9GYVQhhGQ7xj1+xOMOP
 bQje12CQK/B71RA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22133-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: 23F50615F58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

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
label: the compound dispatcher calls op_release unconditionally after
every op, so leaving the in-function pair in place would double-release
op_pacl and op_dpacl on every ACL-bearing OPEN that reaches
nfsd4_open(), underflowing the refcount and freeing the posix_acl
while it is still reachable through op->u.

Fixes: 5fc51dfc2eb1 ("NFSD: Add support for XDR decoding POSIX draft ACLs")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/nfs4proc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 017474cd63b5..76de265bb9e1 100644
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
@@ -3718,6 +3723,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_OPEN] = {
 		.op_func = nfsd4_open,
+		.op_release = nfsd4_open_release,
 		.op_flags = OP_HANDLES_WRONGSEC | OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN",
 		.op_rsize_bop = nfsd4_open_rsize,

-- 
2.54.0


