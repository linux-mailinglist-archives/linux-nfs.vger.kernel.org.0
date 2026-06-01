Return-Path: <linux-nfs+bounces-22176-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KkgMGrCHWrPdQkAu9opvQ
	(envelope-from <linux-nfs+bounces-22176-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 19:33:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EAC6234AA
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 19:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 597A8307DCF8
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 17:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003AC3E121A;
	Mon,  1 Jun 2026 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJrUSmMT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB5A3E0C42;
	Mon,  1 Jun 2026 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335095; cv=none; b=hmfKTu2dC4cCcYMqitQF/m3fop6wK9IgWx/NUYn26QklF1cWCqLXjZzLKSiCUkfR/gBA6RmjYeRSuZMa7pjUEbuVDqjsHvtz1m9pvvT4tpZkuTHQnOPSOnZ6yIMPZucttfQe4syAMylWyn4Q0cK/bga6mD78zYnh9TcQCWbAPVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335095; c=relaxed/simple;
	bh=5GmFOsoGsxUoKK42L6oIuiqD2T2yto1PqXZGDDjnR7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nd4CA9oxsBqFiH0wEweo0wxYggi6/n7NNHX9iZHqfNR5bBe1cDLAz79v59vZIVmqQK0ExJA+yGE7kSnLOWrLs2+tZXkC8KNuLlTiPV8jn3f3PeOeEuflEf5qA0WxKtini51B3AWUrcUOmMvfbjmJQrxskzR8k5Df9D6OXv386S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJrUSmMT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0700F1F00893;
	Mon,  1 Jun 2026 17:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780335094;
	bh=GQSR5xDyG6bHaFaZRpDiOp0QGRNuyvccZonIX15jpMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UJrUSmMTbgX5vjmmB0TMWWhHt3dOImZF2zlIrjq2+6arFOSlI+DHZWbiaIVUtHazp
	 DLNigXQ52asbaBWqxRUX3e3L5efXklre29C6WhueO0V5vxr1C4gRV0PRtCpcj7+mao
	 P9TtiRKypUdsf6FY/drHB8+B4pbnuXcbBh3mAUskKhXRLwcepxw1JTXmfmcrl4o9Pm
	 VXUxWzy1BrEDLNGhQuyq7+/EgzSz1hk6nxejQuFMWI1bTaZ88+oqR40RhmRX36ANpD
	 4umWW/aX1kyN1ejRaGGOstefofGrCCmrr94bfjRvs0OvgAurH36hqGGIrfSuElZVm0
	 d9UQ4erjHY4+A==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 01 Jun 2026 13:31:07 -0400
Subject: [PATCH 4/8] nfsd: guard nfsd_serv deref in nfsd_file_net_dispose
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-nfsd-testing-v1-4-d0f61e536df8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2274; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Dxlhw3GNlHUspVC5P+k7IYi9cq5Erg9fOpoK54g/QOM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHcHt43NoZF6LGaAsByvhk4q6Xx0KVytLMpLYg
 HBzLKbrrCWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCah3B7QAKCRAADmhBGVaC
 FXQTEACLhpPcbqoAkVAEQWuar545tpMSLjaEkFJSdmqG6Qss3K88SN0lSvfgSvGXw81E5S0gYVy
 7djv7RXwuwy2gJJkL6qd1cPFBijAoPmaGVNBJqs7HuYDOy3h1Y6WSTIQU3+y8Wmz7Cbgwl/j7Ls
 sZDEFdmRgKTxj4OhmAxcqRRbQ6hT6do+qYCgiArQguyu4f3kXMnDvh5gCZYo5MgEpV77r5IjfjA
 Sb3DxYXc7KfE+r0hb3ewch703Wqbdn8zI1TK6WJ7EX8/HTIisqWnmv1/pENSfQmHU35l79jnO0m
 f1obJ8AWXGSpp4eryIjw373KLXpAluWRr9AzLWGOvhNy6tnQBMcy4eJaCILYTHnfcu1kck1zVft
 HgvlYcgnQqyfRL+FXOlGo0EiwgA8QJTVgALNs96gz8H8xUFs++UM6uauR5EFsWthXZwtcocrGBn
 AYKHAgAlXrqmGQ+T+J279qUEnLEVo5VufplGC9PsSjEbvqn+SPu356WwPrkqn2v4MDm0JnVnZx+
 68JCz6/qSo9BBmCAHczTo+K453PRWQlB864c9dGdi8wY8nzwIp0cQXRMx/cIkX7LROM8gtoixDh
 jw1GAB5q4idcbrzDRX6Tn3dH7h2KmE8ZCOpwM9XGB176ZiQNacs/teSmmfsjUEZm0Q47L33ijBN
 FEY/XvikSqhL0qw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22176-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 55EAC6234AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

nfsd_file_net_dispose() is the consumer side of l->freeme: the nfsd
service thread loop calls it to drain entries that the filecache
garbage collector and shrinker append via
nfsd_file_dispose_list_delayed().  During per-net teardown,
nn->nfsd_serv is cleared before the filecache laundrette is shut
down, so the service thread can still run a dispose pass that finds
more than eight entries on l->freeme and dereferences a NULL
svc_serv:

    nfsd service thread loop
      nfsd_file_net_dispose(nn)
        if (!list_empty(&l->freeme)) {
            ...
            svc_wake_up(nn->nfsd_serv);   /* nn->nfsd_serv == NULL */
        }

The sibling helper nfsd_file_dispose_list_delayed() already documents
this ordering and caches nn->nfsd_serv into a local before testing it
for NULL.  nfsd_file_net_dispose() was introduced with the same raw
svc_wake_up(nn->nfsd_serv) call and never picked up the guard.

Fix by loading nn->nfsd_serv into a local svc_serv pointer and only
calling svc_wake_up() when it is non-NULL, matching the pattern in
nfsd_file_dispose_list_delayed().

Fixes: ffb402596147 ("nfsd: Don't leave work of closing files to a work queue")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/filecache.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2f0d4de779af..1e2e1f89216e 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -474,11 +474,20 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
 		for (i = 0; i < 8 && !list_empty(&l->freeme); i++)
 			list_move(l->freeme.next, &dispose);
 		spin_unlock(&l->lock);
-		if (!list_empty(&l->freeme))
-			/* Wake up another thread to share the work
+		if (!list_empty(&l->freeme)) {
+			/*
+			 * Wake up another thread to share the work
 			 * *before* doing any actual disposing.
+			 *
+			 * The filecache laundrette is shut down after
+			 * the nn->nfsd_serv pointer is cleared, but
+			 * before the svc_serv is freed.
 			 */
-			svc_wake_up(nn->nfsd_serv);
+			struct svc_serv *serv = nn->nfsd_serv;
+
+			if (serv)
+				svc_wake_up(serv);
+		}
 		nfsd_file_dispose_list(&dispose);
 	}
 }

-- 
2.54.0


