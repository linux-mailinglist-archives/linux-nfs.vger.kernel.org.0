Return-Path: <linux-nfs+bounces-21178-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFnfEStq72l3BAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21178-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:52:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C34473C4A
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DE80300EB70
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90493D3328;
	Mon, 27 Apr 2026 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLIS0CIj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8522A3D3314;
	Mon, 27 Apr 2026 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297866; cv=none; b=WIu8XhTsmf4V3g1scarmAsjNtjvAF8GJqJRUH/0fO/4PF6yOAYw+KsSAZkE71n1xTF1Q2n/bgzxnNohITwTQY2w34OKMVnso539V4w7bR3nkMav646b1xNYK0NfPRZbgNj5xntM/azEuDIS22d916rX7bKFEv+os4gGlogrFpRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297866; c=relaxed/simple;
	bh=JTmt3JFDvkBBf9PODZeKpqJ1BiAhHrub4zbtLN9echQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSpEzlY3HlSW1B6ledhtKkM9bPOI+te78DvxyitRpc+XCMDc/U6hkvBTvOcy/29Wm6RIGKOXTeqsKeZwlfEq+K10bkajTPDdlCYsqU68jaRRKBm/DBCsvdeq4trbsvSS7XF1Bfld6X92y4bSMTVjLgIivo3t2h2ZRAZpFYhfX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLIS0CIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059E1C2BCB4;
	Mon, 27 Apr 2026 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777297866;
	bh=JTmt3JFDvkBBf9PODZeKpqJ1BiAhHrub4zbtLN9echQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KLIS0CIjLexSzhJKaT6UE5JnQ7Y8We+RHu3p4aAbSrGg7YHXIlUc4LJEvsASA4sNI
	 0J0hnZiSith8vANgkINkdjsYZnNrU3WBVqoG+KCWcWXXrr1Tj9sDJxf8Krasn+knrc
	 AKJSgEi43dIc6lmOvslEBCjpGi3E9/SvEPP+tEa6pvj0HGMD77I6Z4gzo770lcFHUA
	 L5JfWRwdD9lHr28BjA1k6mLqP6wDJkCF1noCvzUBU+B8+ZPHDulm8rU8yUYd5dJA/G
	 PaJu4UjOmWBSwvm6WgWr5m/e6kFr8tbVCb/aIWGQQdALFQYnrmBVpd5V7vdZO4z5LN
	 4bgmvredRwgqA==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 27 Apr 2026 09:50:45 -0400
Subject: [PATCH 01/18] SUNRPC: Add Kconfig dependency on CRYPTO_KRB5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-crypto-krb5-api-v1-1-1fc1253b64c0@oracle.com>
References: <20260427-crypto-krb5-api-v1-0-1fc1253b64c0@oracle.com>
In-Reply-To: <20260427-crypto-krb5-api-v1-0-1fc1253b64c0@oracle.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
 David Howells <dhowells@redhat.com>, Simo Sorce <simo@redhat.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=pN/pJS/bGTfXa+FrZFMmxyQNaY5mpbA1aQznBVUAty0=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp72nFFgPAxPAIvsMHsoq6w0/JnZExL6/qpII+K
 bFheN7+6nCJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCae9pxQAKCRAzarMzb2Z/
 l4vsD/9lnwDS70mhwLB5vTJYQZcvU5FeBSnfIpGJtqwayhs5CDkfDb6qwxDcU8vFlclH6hT8EvD
 Abx/cAiFE6rRd/aAgKcEc9MADFb2t4iMn06ZaUX0HEOTcL3YdWYPdEwlqelTjclphZRB04cJnbK
 W66cxT1KLR2Acpb72EIdf9kGlAs0qDDSLE+YmX3M9cC0wM7Nkgy6XMiANod7F0bzBl9BlhihFGH
 5MiieBoPjhoNo9+9huqW6VOSwrcuDf3WtRY/nvUOcbHHJEuOCxQLtyUPop7RQVJJ3z7DwJfkdrR
 ODxzys2RVQvgX2TX2knSR3UtLyLxxTtvCl6wiKt+/koWPfRL9eGDx0ihjiMlrj7dNOuCUNLP7Pm
 JV8gbNcjlodAR3xwCOv24zEekgX1jhVBObCS3UdGNZgr8gcSHCoIo1xknBRtmR76n1FAqMHd4NA
 x9igJuZzfK19XqasQb0U2yGp06guDIEBjIFSpRwwrdXuhwxKgt7NCvGkA1tfo6ofqLnoLxFPRjR
 NKrb0gXm2fJIO7r6na1DCJArrd6lH6cVXq97YX/X+Wm/r+mm7kfOeEh+cvVdiVgiqQWbyiKQmdV
 g/8C2PNEnT9k14mAi/3qKjHGfXJlICQv0Aela9hTYZRtqdwiyw6x9tRBIqpJvF+rCSHGD68dQD6
 dsBFj++SZVT0WDQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 43C34473C4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21178-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Chuck Lever <chuck.lever@oracle.com>

The rpcsec_gss_krb5 module currently contains its own Kerberos 5
crypto implementation (key derivation, encryption, checksumming)
that duplicates functionality available in the common crypto/krb5
library. As a first step toward migrating to that library, add a
Kconfig select so that building rpcsec_gss_krb5 pulls in the
common Kerberos 5 crypto support.

The per-enctype Kconfig options (AES_SHA1, CAMELLIA, AES_SHA2)
remain: they continue to gate which encryption types are offered
by the GSS mechanism. The individual crypto algorithm selects
they carry become redundant once the migration is complete, since
CRYPTO_KRB5 already selects all needed ciphers and hashes.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
index a570e7adf270..381e76975ea9 100644
--- a/net/sunrpc/Kconfig
+++ b/net/sunrpc/Kconfig
@@ -21,6 +21,7 @@ config RPCSEC_GSS_KRB5
 	depends on SUNRPC && CRYPTO
 	default y
 	select SUNRPC_GSS
+	select CRYPTO_KRB5
 	select CRYPTO_SKCIPHER
 	select CRYPTO_HASH
 	help

-- 
2.53.0


