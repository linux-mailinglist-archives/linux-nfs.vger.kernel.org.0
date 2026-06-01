Return-Path: <linux-nfs+bounces-22173-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL0qIArCHWrPdQkAu9opvQ
	(envelope-from <linux-nfs+bounces-22173-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 19:31:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CCB623445
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 19:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91558301257E
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 17:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CCE3DD87C;
	Mon,  1 Jun 2026 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMIWPc35"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A633DEAE4;
	Mon,  1 Jun 2026 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335090; cv=none; b=UfeUaqPxZ5bOMKUALV7bECmZ1O6gZGYabn8MJtv68UOdKj5Mt3d0pIRmt2bOxUOSwvd8C3h3wimUoCIyjgbCh6OV12Bms/NXyKOP9MjJ6buoLEYZL1QSiky792xPvOvlrapwLN8DktBjACYeoWeMsDJa1PELiVYLp+s0T3c0eBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335090; c=relaxed/simple;
	bh=0kn14y4Zr87QdMm2kllBabws/iLsYCS38BAXri0J95A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjaJMYrn1+A5i7eCa6/q3xfbpNE5GUxs7id6aRZHzPl1a7dOZfcSpAd/hWAgyiwflNzYle0aD0Cv8yelBJ2RL8s5JkmSATtygInPKlr0oOBevvp4d4fi8YREI27gcFyJEaa1H1UTx/9IS4g1IO3Og6Z6Pd/4pIO45ppEEnWr2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMIWPc35; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E411F00899;
	Mon,  1 Jun 2026 17:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780335089;
	bh=spc3yZf0Leo44+aaUSe7k7gMiOCmlyn5q55vzDzy5s8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lMIWPc35DZWsaKICIWnV9gaFGUwu4frTyFKtHqbrDoiTRajzx5gc+At/LyjZtCqpi
	 2vObCQqa+ge5z4NXoqc5snk4bsfPNfRyB1PpOX4QCeZJCo4BVm1leCi1AliYMqcuUB
	 v6xHjc8Y9x1uq3r1TqqO7560RoioDGRWzLtVCCGggdMOnR5AM1ZgFXhE+Im+DtzSCD
	 Mylv/zYsKXORG6F12sRTLEU+y80JQq5WM1jdDIarqlE82+Th+3qjG/ZBnb/EjRpmPu
	 F1z0OJtZaTL5TLPB+hxUUHGdgU0CrdvQMGk2BAnCJ5bYD5liV+X1fdCk0DBuW2VadI
	 +KVVm+R7S+1TQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 01 Jun 2026 13:31:04 -0400
Subject: [PATCH 1/8] nfsd: defer vfree of compound ops to fix rpc_status
 UAF
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260601-nfsd-testing-v1-1-d0f61e536df8@kernel.org>
References: <20260601-nfsd-testing-v1-0-d0f61e536df8@kernel.org>
In-Reply-To: <20260601-nfsd-testing-v1-0-d0f61e536df8@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Anna Schumaker <anna.schumaker@oracle.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Mike Snitzer <snitzer@kernel.org>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1776; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0kn14y4Zr87QdMm2kllBabws/iLsYCS38BAXri0J95A=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHcHssIaCyGwFe2fkEINzHR6l8k/8ejW4bxxyW
 jqlxQSwy/6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCah3B7AAKCRAADmhBGVaC
 FUt5EACZSFZp7IeB60L+mfiGpu0vBXp15OALCSLfq6NxnhK1B3JQI/S+fK4FqWg/lSrMxebXFma
 dr96NQxll+9XtIjip8+mf01tYXMaHlTb06IcStnyR1NJLHzWfirf+gcbsAsEMhNkloUN2FcY//V
 s9//o4GaBakY2kd/4tjp+eLea6oeWnEkW7IPMqf1VThdHJ2QU6WaDkhogv4hMZHw8D4DjzM2yYw
 X87ArBqNWET2DuGd2RGkf1h5b/aoMyhR5u0ciXxwL+Rnn/qVf6TCjrH+SjKGS3ZjSsDyVk1+f2l
 TYJajAZ5J6TXuoPLOoKf9bYRnFfse6qI0ohsuAzp4TIJeykSX1DKsHxKbDPecU6ZHAHJ72wbrBa
 RyitH/89RvzdDmDFfk9edy1poCnw/EAtVk+IQnpJxIS9jhowiqVRANGtalu8/GF2l9ZHC/P+LAY
 RBXXhe4DcllWA5rFvB7F3C881HOrue8CjJ9IfrtBpZZQvHE/oM5ZpDJba5S085yIThcnXPIGcdj
 C+DqZxw6ggFUHNZpYRLf+Eoyh+QOBUiJZ5zXurUyulgNzlzAjljOCdJDTf2KicOtJ+BydQTlKQd
 PSlWWq7Vxor4+n15z7JCNIEw1zYY+uf3G4kFmzBlKplvN9V9XKLkY2MBuFKauK+S+U4YwZxs2B/
 ApzaFwrITTYvz7A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22173-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 87CCB623445
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The rpc_status netlink dumpit walks every in-flight svc_rqst under
rcu_read_lock and, for NFSv4 requests, reads opnums out of
args->ops[]. But args->ops is a separate vmalloc buffer freed
synchronously by vfree() in nfsd4_release_compoundargs() at the end
of every compound. The dumpit's rcu_read_lock pins the svc_rqst
struct itself (freed via kfree_rcu), but nothing defers the vfree
of the ops buffer across the RCU grace period. A concurrent compound
completion can therefore free the buffer while the dumpit is reading
it — a use-after-free on vmalloc memory.

The trailing seqcount recheck (smp_load_acquire of rq_status_counter)
cannot undo a load that already retired against freed memory.

Fix by replacing vfree(args->ops) with kvfree_rcu_mightsleep(), which
defers the free until after an RCU grace period. This makes the
existing rcu_read_lock in the dumpit sufficient to protect the read.
The tradeoff is that completed compound ops buffers (up to
200 * sizeof(struct nfsd4_op)) persist in memory slightly longer,
across one grace period, before being reclaimed.

Fixes: bd9d6a3efa97 ("NFSD: add rpc_status netlink support")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 487a1f62ce15..90272241dacc 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -6686,7 +6686,7 @@ void nfsd4_release_compoundargs(struct svc_rqst *rqstp)
 	struct nfsd4_compoundargs *args = rqstp->rq_argp;
 
 	if (args->ops != args->iops) {
-		vfree(args->ops);
+		kvfree_rcu_mightsleep(args->ops);
 		args->ops = args->iops;
 	}
 	while (args->to_free) {

-- 
2.54.0


