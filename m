Return-Path: <linux-nfs+bounces-22418-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dUqgJg1VKGpICQMAu9opvQ
	(envelope-from <linux-nfs+bounces-22418-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 20:01:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 039E166325B
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 20:01:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=B8OYMgMn;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22418-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22418-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D3DD3099F10
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 17:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133814E3794;
	Tue,  9 Jun 2026 17:48:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F9C4E378B;
	Tue,  9 Jun 2026 17:48:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027289; cv=none; b=pbRhCRIJPajfv/QDz1i5q75477eTrr95lcwniiOb00o75aCXiP58PSs6vSFqO5kMO4IPbb/xwnlP8p7+YFh5TC7Drlt8rasIBYTYBoC+KpHTeRb9KrBHoh3LoJhTCEG4cqyKS6rXcU4WCYdNYeVKA0WupNA43VKlnWt3gjbKRjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027289; c=relaxed/simple;
	bh=IvN2zlHfIARbpsOFsJGDFUSqx8LtU530Le2fcUaJhSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R9VZ/av1nEtPH0IhaZ41go58htZOprS2+FVtWPX1LMoUo4zontFvmYk7/a6kFQX+NjztoyYADH6CyXZpLDJjyqJw0rP3U/mCcH0HUgKvU7LWXRb91t9EeHkkcALxgYfiTJ1YgyVmVjx0P9LSnqp29qsn/omTu06LkomUXHWx7Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8OYMgMn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B982E1F00898;
	Tue,  9 Jun 2026 17:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781027287;
	bh=76QSvTFrWccX2/RPGoLN0iB0eJf1tfF3NmxaGj9q8rI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=B8OYMgMnn6RYKdLw5WDu9iA96SlelnDuB9lzZ+CIpnlyrdSgV33qA3EFhWmc40N/Q
	 SIjVbVTLPOf6vcPYdthe94RkcT2611eYrhpXdGZk0whsyK2WMt2Vq+h1Usa+SKJxe4
	 b6f1H8s6OWQM/WfM9mo0zlezGi6LgV7j0xCSNHOyZTNX0d2zkbcAhV3glT2Y/PH4RX
	 8hiqjmDgeKiClLIHL16KJ3roKqUESSfGLBbn6MSnHB62f41shM85aSe2hw2uIxR9yQ
	 wnK7vY31uU+uWroQCSs6FocLgzjfp3fX5Ihbsa1u2vq2nOvIo6r/fXnTa/hhnoaGuy
	 fQMXulfesRsvA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 09 Jun 2026 13:47:32 -0400
Subject: [PATCH 11/19] nfsd: fix FL_SLEEP being set unconditionally for all
 LOCK types
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-nfsd-testing-v1-11-e83acead2ae8@kernel.org>
References: <20260609-nfsd-testing-v1-0-e83acead2ae8@kernel.org>
In-Reply-To: <20260609-nfsd-testing-v1-0-e83acead2ae8@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Benjamin Coddington <bcodding@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Muchun Song <muchun.song@linux.dev>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=IvN2zlHfIARbpsOFsJGDFUSqx8LtU530Le2fcUaJhSM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKFG7e7dBXC1TY3o7y6r7kiBrttEu+RWrfBg7o
 1AefvQw/f+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaihRuwAKCRAADmhBGVaC
 FaebD/9s8bwwN/uC/Vjot3XqgUHAQ6CzOcGv8sng4dO17gs3b8pval/8jcdtGw593Z0hX4JP2ym
 NWmZaUHDgdqDIt77140jMayuodIN2ueDQrNsE/wB6kJll3gy3U0MRXdGO5j+jE50tCX1NayaGWL
 JPP/7oHYfHbJUZuuZqPNEA3TVnXAMOW/krvkv61gYH9pPz6t9dbYXSnqjDZZqHK3r+8n/S7G4xw
 wdcGXxY2qowc9Gytk8hvg/eqT4w5kSju6nxxT9wqwHBBZbfvDpYjmLc6MAL3iWVaZuE4CyAgi4I
 J2SyjKBRCAPVZPlqmERWwQRXKT2pTmCfCIQCDeDcaK15aWkki7YPiKGAJ1ik4SScMq8fcWlDcdX
 5MZbz1+WAcPI4jaZH0FPM5A9mRqrg4tNwntAVkoju2iz2QwZFEx5V9TD5G33KcjpE+F3MOAmja8
 yZeXXrdttU2CY/JIMVmqw2DuZiNjR58xslt85eHOYhsaU1eFHqc7JCmYYHl3BHLur3hANpSsiF3
 0dI6saQpUqP9EjeB+ZoUmDpZvhJF8ZCpP2+JwCDWOmYcizJ/stMChJFhNv/xsbQRp2qszy1o0Hh
 5uwSNpF0N1u3Tt5bWQv27LY/GqV/UmkuflVnBaqh078fAgQq16CnJ8aYvK5Q3yV9121B6UiO0zg
 qGMtenQLS6U2/9A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:brauner@kernel.org,m:bcodding@redhat.com,m:donald.hunter@gmail.com,m:lorenzo@kernel.org,m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:muchun.song@linux.dev,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:jlayton@kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,gmail.com,linux.dev,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22418-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 039E166325B

The FL_SLEEP guard uses lk_type & (NFS4_READW_LT | NFS4_WRITEW_LT) which
computes lk_type & 7, non-zero for all valid lock types including
non-blocking ones. This was introduced by commit 7e64c5bc497c
("NLM/NFSD: Fix lock notifications for async-capable filesystems") when
refactoring from per-case switch arms.

Replace the bitmask test with explicit equality checks.

Fixes: 7e64c5bc497c ("NLM/NFSD: Fix lock notifications for async-capable filesystems")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 19aab4c52548..8c714001c116 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8589,10 +8589,11 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	}
 
-	if (lock->lk_type & (NFS4_READW_LT | NFS4_WRITEW_LT) &&
-		nfsd4_has_session(cstate) &&
-		locks_can_async_lock(nf->nf_file->f_op))
-			flags |= FL_SLEEP;
+	if ((lock->lk_type == NFS4_READW_LT ||
+	     lock->lk_type == NFS4_WRITEW_LT) &&
+	    nfsd4_has_session(cstate) &&
+	    locks_can_async_lock(nf->nf_file->f_op))
+		flags |= FL_SLEEP;
 
 	nbl = find_or_allocate_block(lock_sop, &fp->fi_fhandle, nn);
 	if (!nbl) {

-- 
2.54.0


