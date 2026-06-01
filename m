Return-Path: <linux-nfs+bounces-22174-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKFkAEDDHWrPdQkAu9opvQ
	(envelope-from <linux-nfs+bounces-22174-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 19:37:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5769C623533
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 19:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF306308F930
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 17:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27423E008F;
	Mon,  1 Jun 2026 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwqVH3TN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3E83DE427;
	Mon,  1 Jun 2026 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335092; cv=none; b=HtP66G4f6tXVI48QSpJ+xEyieQ69z0dwxv6bOYYieWRdzBUxmW3Wh4EU+TBQ1KQEdhWfT2CHY6YJ8f1IuCUovPWAjJKifv+zJKVN8aWbk2gPtWXI0xLx8Kjsc1PFvV+SDylzo3LGqRY0ktCcYh0Q2HHMeEVC3K+56YRTku6FdWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335092; c=relaxed/simple;
	bh=Z4Sa04OPguVVMhb/R/j+wi8hB7rLuPo3U1Pzf+0g9+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s3lUT/JgdieBoTeqvb3BTsXLzmUx2j9hT76HLAdiSQt3o5JY/YgIpr3vAgcVqkTvewSLNcdmUn0BzBNmxCk3+EV2MMStwYDbY+mKt2/gQrXXYTrE0wDSMf6XAD/ACZoV2V2n8abnprRj75qxMP+7vTQqroKV4b9pYD/6Nvw+Zlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwqVH3TN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D461F0089A;
	Mon,  1 Jun 2026 17:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780335091;
	bh=guAkVFVqRYjiojYXLWG1CxAWJyMoK1eDqsYRwZSIzfk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OwqVH3TNSybSqPdQHqLv/T4nZDNIWtukr8D/heDIaobzHcq2EgTnaIwSm1LFaQnmg
	 rMvJ/S0o2x+TIf+eAY7qkUrFwlr68KjV8Mn30sVqnxbn9+cUl9cEOp3PglzngXuQZG
	 sK0A1I1Qop9i8HMYwF0Uq2RtyFPcHhTTORPgZJHpfTgEmBeI7RqJKy8e8rLPxOlAGh
	 465QHvesDRFgvEDPPK3ZwE2dLPjuKirfK5B5mKvsD6z5/dNxgaXRLuk+1TwiWkdaih
	 S3PzTK6hBqK2UUhEwavR7zGZNcyoOVcc1r5vAHB21tWeQ1cbiAlHeUReQJEzDFkPSB
	 IRBuOJ2Q5vPGQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 01 Jun 2026 13:31:05 -0400
Subject: [PATCH 2/8] nfsd: hold rcu across localio cmpxchg retry
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-nfsd-testing-v1-2-d0f61e536df8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2871; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=jhosRCdsgV6tnLgxdUeYl40e/QY6nryL/Up0X7W5E1U=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHcHsalO2+YDzIwJkenGGyCsjupUPONoMWKa8m
 G6LiYq2ZhaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCah3B7AAKCRAADmhBGVaC
 FaCgD/4/oYOTTjXT/VBZNGPCdowG/75XvmyT0jFIMEyt/lP+1zI9ZMFqREPe8pFM72aI8xlY0z8
 s9wG3M+OMO8OwRavd5615G3FvPz6I1EsZsnNsdG/d8Mq4ua0VK3r2KoUuMpAar119b7c+HChtFY
 BXeXEmvToHEUQR042Q2dDF6ruz10N+yW/WyLQ6wUz2GCawy9QPvInVJsTY/PBi+qwpQNNkJqTkM
 2PhoEAXKCVEECzKvDsleSs5QGdeIGXZjG/tSP1M1yQPm7CDN0X9TRv+pkOHAY6wsdD7AFEgbV4A
 Fi4iQ7O9HXOp3cehsc53MbyV9U5z4bXcz3wqTl+8FYHVjeTEP+L0h3Vr/HGlLHvP1fNhDc5W434
 u/iV3kdMbqbhKxrvf4q7exSHEbm8P5SBS+sgWuW/wHVqKyQ2ijVoBNr37EiaYc66NCcDlrc0bRX
 6dkoyCly0zsdPoMYZIWrl1p6Vlj2zkMPBd9ZEM8XPFuf8TxphR8C1jMWUSz+EuK2oK/R6n5JyHF
 rWIErPKrz7lPheaG4IoPss/T1+tJ/SNk/82B+aDeAoDL7LxJ2QFRvX6ukn/2Dgcmoeqn4vZn03S
 08aWD8JhF9ylX2yj/Yr/wfPHx5x0B3IqExBZSv8Kj30vICOoIXqki1E8+hvbVJEw+H1a1jbSaC1
 WdBbVZ/9yD5PVmQ==
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22174-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: 5769C623533
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

nfsd_file objects are freed via call_rcu (filecache.c:296), and
nfsd_file_slab is created without SLAB_TYPESAFE_BY_RCU
(KMEM_CACHE(nfsd_file, 0) at filecache.c:789), so the slab page
backing a freed nfsd_file becomes freely reclaimable once the RCU
grace period elapses.

The again: retry block in nfsd_open_local_fh() loads a pointer with
cmpxchg and then calls nfsd_file_get(new) (which is
refcount_inc_not_zero) without holding rcu_read_lock. The sole caller
nfs_open_local_fh() drops rcu_read_lock before invoking this helper,
so no outer reader-side critical section covers the load.

    CPU 0 (nfsd_open_local_fh)        CPU 1 (nfsd_file_put_local)
    -----                             -----
    new = cmpxchg(pnf, NULL, ...)
                                      nf = xchg(pnf, NULL)
                                      nfsd_file_put(nf)
                                        last ref -> call_rcu()
                                      /* grace period elapses;
                                         slab page recycled */
    nfsd_file_get(new)
      refcount_inc_not_zero(&new->nf_ref)
      /* operates on recycled memory */

A non-zero word at the nf_ref offset of the recycled object makes the
refcount bump appear to succeed, and the caller then dereferences
new->nf_net and new->nf_file out of freed memory.

Fix by taking rcu_read_lock() immediately before the cmpxchg and
releasing it on all three exits of the if (new) block: the goto-again
retry, the lost-race cleanup path, and the install-succeeded path.
nfsd_file_put() and nfsd_net_put() stay outside the RCU section so
they remain free to block.

Fixes: e6f7e1487ab5 ("nfs_localio: simplify interface to nfsd for getting nfsd_file")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/localio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index be710d809a3b..c3eb0557b3e1 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -97,11 +97,15 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 		}
 		nfsd_file_get(localio);
 	again:
+		rcu_read_lock();
 		new = unrcu_pointer(cmpxchg(pnf, NULL, RCU_INITIALIZER(localio)));
 		if (new) {
 			/* Some other thread installed an nfsd_file */
-			if (nfsd_file_get(new) == NULL)
+			if (nfsd_file_get(new) == NULL) {
+				rcu_read_unlock();
 				goto again;
+			}
+			rcu_read_unlock();
 			/*
 			 * Drop the ref we were going to install (both file and
 			 * net) and the one we were going to return (only file).
@@ -110,6 +114,8 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 			nfsd_net_put(net);
 			nfsd_file_put(localio);
 			localio = new;
+		} else {
+			rcu_read_unlock();
 		}
 	} else
 		nfsd_net_put(net);

-- 
2.54.0


