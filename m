Return-Path: <linux-nfs+bounces-21334-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMsaDhq+9GkDEQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21334-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 16:52:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9446E4AD642
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 16:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F87D3026757
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2026 14:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B6C3CE494;
	Fri,  1 May 2026 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0Y3S2gG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C043CE481;
	Fri,  1 May 2026 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647091; cv=none; b=tUlClu7VE0B3X4ZFCwd9MoM2RdbfiHVSXthTmaY1qlfILYIv9adjVHhGlyAy6AsPqB6ONrA5R0uT0Ynq73pdXclloNdUc5pyjOJZCpUAlGAf88kugHYCEJX70VqhHJIQE+9D31a2QjUpxzEbO/LPzYv98suBP2LI9tIVMdMEsbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647091; c=relaxed/simple;
	bh=UyZE3O+9MTuD6JawcvrDlgaUs2SG0Plb41/mQ0fmVC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=plOkBxb2liZsSSeahFqvUTf7d1jN1ln4KvLDk8KF9eBefOsPt9OACJ6J1vAjrsDWykqcWMVE7iFIidoYyF44kqBmEitTdgOMElMOYLW05Nb171IQzaqF2keHP+ZCypTC+8jWQxgnm5qEj6WD2nxyWJ2D8v5S3pNLDuRc9zV4+YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0Y3S2gG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D09EC2BCC7;
	Fri,  1 May 2026 14:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777647091;
	bh=UyZE3O+9MTuD6JawcvrDlgaUs2SG0Plb41/mQ0fmVC0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m0Y3S2gGP/IJ5IlZ3aDVy/ycqYcXYP54jUw3sUwJKDrOfjd7J8Aq9YGWwqazzjblK
	 SKigYSNgS5+q0q0ZFDokXiaJ01iLtj+FU2NppQw8ofVZ84GQecYMP8fnVWJ7/Q5Ckt
	 nN0UowlD8xIFE52hIs5w2HvXOeU3+Kd79hR1ikMqATNqEEfs28OhICbEofVD9EVLpp
	 /U9nMnLTxg1S0fBOB9PH2xkHr6emoClo5jIMrzUWdRTm9ufvqbzyVwpg/dYDk+zmOo
	 ksxe1n2pRKuJY+z9LDAC9YAogGdOo3HkQpIImwerYvQP2Exrl+WPMS/9TsUzVfK+yV
	 R/X/AyQ0bQz6g==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 01 May 2026 10:51:07 -0400
Subject: [PATCH 1/6] SUNRPC: Move cache_initialize() declaration to
 sunrpc-private header
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-cache-uaf-fix-v1-1-a49928bf4817@oracle.com>
References: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
In-Reply-To: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
To: Misbah Anjum N <misanjum@linux.ibm.com>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Yang Erkun <yangerkun@huawei.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2485;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=f19g8gb4ZDllUEQ/XuyKLXf2ZZo6fSjdCzNFYP7WVJE=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9L3w5haD4o1Scu4q1iIt+VXHRWISVGaFz6XXb
 +jtCyfhD2KJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafS98AAKCRAzarMzb2Z/
 lwL5D/9M+8LTwFG384Y2eqTq6x6iMV1DdLAGoJa4au0OUwOmkvPNKlIb/QGiuScR0R+cNFtIFQz
 /2zOdPaV/dsU/rkS2I4SQY1jywdOGiathwwBuJHGedNw+MPc1lFfmfX9MLSRhgTNFehxdHhl/5l
 6Dohzcq0wfJzPM21W+kepfC1SvCnCS3U1Vqvq03xnGtSpUhYenHrs64kA+XGA0U6MB2XCQr9xCa
 hbDAjj4/KFg7kNE2ptnkTzXAXWPk6AoQme641LyyDuCBEs9Zk1kGQWC/VPvDOr2e/nYOo3UTWJ6
 xm9Sk1oAqzhIXIuB32Md8TaSE2mfd5b554H1bf2oF9gzZuqtcHOfJWYr5ElTzSLZQZTKG3Cmzz1
 9fvqciOVeBPnxfn4zWQIzF+6wDffAUTEPvL4e7YFeiQAHcG62WQ92xoCbDCmx7ryzmda29PmP1/
 S425vIs5Zp49P67s+gDSdaVQs88HO23w+HZtJNQddg0OsReDw0YRGQgJdmP95G32xSjDpMaLQ34
 l6eZuuajKmCchmazoAWs7Pkfesu9jOswGbzLGUhB8Uo8ao8Mu3cddgC5zliV8v9CEnc4a4rIGqx
 xDbDJYXlaP62JqZey+bUxAphwmL+VzB+Tu1DoBhpTaj4kODefjd13yg+KZ24gQ6BQ7x5W0hzCG+
 KVet6Clar2GqxvA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 9446E4AD642
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21334-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Chuck Lever <chuck.lever@oracle.com>

cache_initialize() was introduced by commit 8eab945c5616 ("sunrpc:
make the cache cleaner workqueue deferrable", 2010) and placed in
the public include/linux/sunrpc/cache.h from the start, but it
has never been EXPORT_SYMBOL_GPL'd. The only caller, init_sunrpc()
in net/sunrpc/sunrpc_syms.c, is built into the same module that
defines the function, so external modules could not link against
the symbol even if they tried. The public declaration has been a
stale-public hygiene leak ever since.

Relocate the declaration to net/sunrpc/sunrpc.h alongside other
sunrpc-internal helpers and include that header from
net/sunrpc/cache.c so the compiler enforces prototype consistency
at the definition site. The public include/linux/sunrpc/cache.h
now reflects the actual external API surface.

No functional change.

Assisted-by: Claude:claude-opus-4-7[1m]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/cache.h | 1 -
 net/sunrpc/cache.c           | 1 +
 net/sunrpc/sunrpc.h          | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index 2735c332ddb7..83c88dc82e69 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -237,7 +237,6 @@ extern int cache_check(struct cache_detail *detail,
 extern void cache_flush(void);
 extern void cache_purge(struct cache_detail *detail);
 #define NEVER (0x7FFFFFFF)
-extern void __init cache_initialize(void);
 extern int cache_register_net(struct cache_detail *cd, struct net *net);
 extern void cache_unregister_net(struct cache_detail *cd, struct net *net);
 
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 391037f15292..488a14961b19 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -39,6 +39,7 @@
 #include "netns.h"
 #include "netlink.h"
 #include "fail.h"
+#include "sunrpc.h"
 
 #define	 RPCDBG_FACILITY RPCDBG_CACHE
 
diff --git a/net/sunrpc/sunrpc.h b/net/sunrpc/sunrpc.h
index e3c6e3b63f0b..7fa35ee8f9a4 100644
--- a/net/sunrpc/sunrpc.h
+++ b/net/sunrpc/sunrpc.h
@@ -41,6 +41,7 @@ struct svc_rqst;
 int rpc_clients_notifier_register(void);
 void rpc_clients_notifier_unregister(void);
 void auth_domain_cleanup(void);
+void __init cache_initialize(void);
 void svc_sock_update_bufs(struct svc_serv *serv);
 enum svc_auth_status svc_authenticate(struct svc_rqst *rqstp);
 #endif /* _NET_SUNRPC_SUNRPC_H */

-- 
2.53.0


