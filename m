Return-Path: <linux-nfs+bounces-22413-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XWKIO7pTKGr6CAMAu9opvQ
	(envelope-from <linux-nfs+bounces-22413-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:56:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5143A6631BC
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:56:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fRmXNNzb;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22413-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22413-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68DE23053E95
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 17:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BFF4DBD86;
	Tue,  9 Jun 2026 17:47:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0C54DBD78;
	Tue,  9 Jun 2026 17:47:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027278; cv=none; b=K5owJAZ37oZy8tfNFnuuMh9GMitv0RUjqRgBrCtp9r15+yCmvtbADT824LrXKbIq3Fr7+kYXi7JNxncThutN5tmLP4vvqlZZZzrEfhFja5b/rYJv2yT5bsLA1eLq4Nipv4+bPfCMsIO/u69EuEOs4qqvzlvcOa78edFKW1TrfvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027278; c=relaxed/simple;
	bh=UcyniYrgdklKohwqOSjznlAOhFMrpAAaEdmtNCcgQzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O3pcN5DsUVv4V7d8QmWzhXXohHkhUxChks5wJOLpnn+V0G4NN1RVnHurEodpbxXGNvdn4mBGPywgOouA1lIRx9Z368dQjYTs5UCCO8OpA99JpPRGuRAIkgc1Y+PsWyIILEtgRE1mFTZg6m5RxkP/B9JDX3ljmQwcaVHXowErddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRmXNNzb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7571F00898;
	Tue,  9 Jun 2026 17:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781027277;
	bh=oDiaR3AX5VPl8hUvSaDYt8zboOCbbg8Ha08a196qhP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fRmXNNzb7CBob9rEQ2I1fSzL7HBH9dAnyI6v32O2Zjgbyi+6k9FFojcVbLvacqAWa
	 Nr6jD1eolTe+vldqH2Nv/DBzPRuMjGyP+UImmoPjRFAFvQHjeJSY7ngskQzk3e8LPG
	 ekx+SDhUMirnrH7iqDHnzH2bkLRrVM16TtIVcfXh2ivHt3LdxMvtmpWkWiBUJPAszv
	 2P210aSjLiLjGM7v6uoZh3yfQg5Vy2oQL04E8SPjoiC9lyv8Fkm8ISSgjcvLjCnu57
	 eMrhGT/v+SxcHDnbxgnSMnQaJKWdXAElqSqB6Nkqrksp66LwtBjnseY+eR8SDkwJK7
	 UKa1hZMckCyrg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 09 Jun 2026 13:47:27 -0400
Subject: [PATCH 06/19] nfsd: check nfsd4_acl_to_attr() return value in
 nfsd4_create()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-nfsd-testing-v1-6-e83acead2ae8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=UcyniYrgdklKohwqOSjznlAOhFMrpAAaEdmtNCcgQzo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKFG6fTqxIuedofe151qw7Hw/6SskvBgrvZBPr
 Vm/dmgFPa+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaihRugAKCRAADmhBGVaC
 Ffu4D/wJ/puvzYwLsNEvMqG9Xt3aOqyV9aFaJldl2gMzlfgionKsWG6HK9ii4Kfh1t14b0vvtjp
 fjAowxeEL8SnOO4krF9+f7J5oL72tbOUfBmex1szVU5LvDTieQwFbS3jHtDymwTUZdQezfPjTSk
 /EEfSIgM9egS+5GDDtPEZdDC89yDfy3nPGTQBz87JL0KA7Cw3H2ZWUHq0lL15T3O/x4hGG7XtKF
 E/cluOwqfpiC5o5igeJ2x9uU+wNDWB51NZ/lnzuOrhjwA6A3rqypilY3zJ2oefhODKCCNx141HX
 tG+7icrCdffV+gDkQAhsta2BJLibwR+jF2MR8PNPFRPB988TDSH9rw53/6mIwXyULbFLxB9cwCR
 ACLLKdanpjzWKbpxE7wx8TfIS5UEsKQyn0MQwVwfpeFMITpZseaSsZXlX5otnLP8nTEY0+wS0NQ
 eCtgNQ8N/uuokolou2OtvnbeVI9bknZoT8cx0VIzrXya18jjge5bbvPn0PCM2sYUsre+1KMwO1O
 b2Qq/Nt6guffaFhlgzyrR4WeA2pg8OFmUCLXw3PacU7Gu5L9cxsoIZVAUmROgPhWIfxO7S3Jk7W
 /+Ao321W8RkfxHRWxbUJjuzWxPGIwxhOkDxBNxagI6xI3eCXGstzLLLVY2Evl/GP9IWQX0121re
 SiDyD5gEBaVxXfw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:brauner@kernel.org,m:bcodding@redhat.com,m:donald.hunter@gmail.com,m:lorenzo@kernel.org,m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:muchun.song@linux.dev,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:jlayton@kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,gmail.com,linux.dev,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22413-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5143A6631BC

nfsd4_create() stores the return value of nfsd4_acl_to_attr() in
status, but the switch(create->cr_type) block unconditionally
overwrites it in every branch. ACL translation errors are silently
discarded, and the CREATE proceeds without the requested ACL.

Add an early exit check after nfsd4_acl_to_attr(), matching the
pattern already used in nfsd4_setattr().

Fixes: 4c10614c7b47 ("NFSD: move setting of ACLs into nfsd_setattr()")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0c37d7c6d28c..69fee481581d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -855,6 +855,8 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		}
 		status = nfsd4_acl_to_attr(create->cr_type, create->cr_acl,
 								&attrs);
+		if (status != nfs_ok)
+			goto out_aftermask;
 	}
 	current->fs->umask = create->cr_umask;
 	switch (create->cr_type) {

-- 
2.54.0


