Return-Path: <linux-nfs+bounces-21177-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ID7Nedp72l3BAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21177-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:51:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 795CA473C1A
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45746300D4C0
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB183D1709;
	Mon, 27 Apr 2026 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvsWs1gD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276123D16F5;
	Mon, 27 Apr 2026 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297865; cv=none; b=AUcDpDrTYtRGNGOLQuoGVQoY70wQj9s78xnTk65yCYBwpME3lhGUZunvvtQ84CE1YzDuy4T5iT3qZRx+UPsa497Kt3wMtgJF+2XpA4VJ3Nv4jUUhXHNgLeGwbhS4sr/ng/fHMZruG22iumsq0p4Jv3ALJkHGBSAYSWVlQcIBKxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297865; c=relaxed/simple;
	bh=bZly/W7iPqKsOHvekoqvriPAW6jV4g/N5XUkx7ULlk0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hdmdXkc40MR/AwVhjmWMUySVaUh7aY1m8QcoXSGPLWENfcxxm9rfaocNzP53J8gYVYiG2ED3h+T3R6jSN2rK6IBLJwA+PlGakjXH7OrDFwspbx4fnBGJbOjHZIxzSa+AtCXqr9OhViEA+afsqPeYXYLJRGdveBY8G85Nlk7oqKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvsWs1gD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596FDC19425;
	Mon, 27 Apr 2026 13:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777297864;
	bh=bZly/W7iPqKsOHvekoqvriPAW6jV4g/N5XUkx7ULlk0=;
	h=From:Subject:Date:To:Cc:From;
	b=BvsWs1gDCo6L3rE0lZAEfnGreIIwR5UMFlO0VfEW6owMY9OskdxGmiwNuyt4CPt0B
	 1jcolpVBr0GHI9CvCJZWg5MYU58V9lXookZoz8TtsG7tt4HDqbQqCltZ87iEXc9UFZ
	 9gCSn9Ikl3WymVvg5/HKbnuwr0mqmERpev9OHMB8Oe7cyXRV42KFvBkSfD5zjnppFz
	 Wws5LfOX3mKD7iOBZ4HEePyV4pR6Wb2W4alitYKi5kLsV0rBl6/8uPJAQ6EtOklA4V
	 WcRZpR5ACD2n9ZMFiecHdMmoLlPrwrVTuBuWdJr3tzZsFBdqWMqvnf8LpG80KFk1BG
	 YQUO/FgjqDzkA==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH 00/18] Migrate rpcsec_gss_krb5 to the crypto/krb5 library
Date: Mon, 27 Apr 2026 09:50:44 -0400
Message-Id: <20260427-crypto-krb5-api-v1-0-1fc1253b64c0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALRp72kC/x3MwQ6CMAyA4VchPdsIIy7iqxgO2yjQaMrSLkZDe
 Henx+/w/zsYKZPBrdlB6cXGm1R0pwbSGmQh5KkaXOt823cek35y2fCh8YIhM8aByDnfez9coVZ
 Zaeb3/3gfq2MwwqhB0vr7JHqeZbYJC1lhWeA4vkmBVGqEAAAA
X-Change-ID: 20260316-crypto-krb5-api-b9ee22636698
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3763;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=bZly/W7iPqKsOHvekoqvriPAW6jV4g/N5XUkx7ULlk0=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp72m80pC78DpNgWqJGtrD7TukF1Lsb7HvjbtvS
 0AryKudXhWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCae9pvAAKCRAzarMzb2Z/
 lyB6EACyWOwqfs8wGrIGJ5Gk9OpOB7guUNForYPxw+t3679wrD29XKM4RrjfTd3IJgHAFJt2EC7
 xjio/GFdJWIPQRXo1BUM9QsWoYQah7lHv03qM5pnv8MKTfpTyLFe3QsY+7KuZsTC05QpQksxAS7
 gfuDRKcRVlQLVuszHezuAO1PbmOp6ublHO5Whk2qdtTdQrGu5kYrKIbiMPjn4T0eA8cBELig36U
 oDqjVpSlf+CxhF4YoDCnBIo2dPN6WXkZPQIEOQJMJpoiA5ZFSa1NW+ijdLSu6zKGKpkFTl88mYM
 m26H2h1o+MhqBpy5ZP/FksF2fYqrpkp9JLEbJj6ubusEtGTe6fObhO5vudr+IIgQDC2102F1Zvo
 IajHai1BKcnem6QXsPGX4ukb5p9u5uUTo4bbwYJSzmSG/fO7K/Ure15sZY8tFzfnHowyKrgvvJi
 V3vttoY1gucbwCJmGstAMOlMaB715+j087dn3PSNw1Ncq7q879bxx0CL+ci8b2SmqVC151Clu60
 gBxPl14+emQY9mY2F7cV5Qi+uRQYA4I+YWNedCHoozBPrVQWvVDRKdy/YdHiOd5bFCE72njpTLj
 ZRSP4ZjErkZS7f/1Sk9Bnb3L9XFnQE9zxjpa0upQdyKFc2fBuC8mSEBdWgvEKuNGgimbZbfKBpo
 aLljR7T68B8NLLg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 795CA473C1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21177-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:mid]

The rpcsec_gss_krb5 module carries its own Kerberos 5 crypto imple-
mentation: key derivation, CBC-CTS encryption, HMAC checksumming,
and the encrypt-then-MAC construction from RFC 8009. Keeping
cryptographic code inside an RPC module means it receives review
only from the SUNRPC maintainers, who lack deep crypto expertise.
Vulnerabilities and algorithmic errors can persist unnoticed.

Replacing the private SunRPC Kerberos implementation eliminates
this duplicated audit surface. A single implementation of Kerberos
5 key derivation and authenticated encryption is easier to verify
than two independent copies. New encryption types and hardware
offload added to crypto/krb5 will automatically become available
to SunRPC Kerberos consumers.

The crypto/krb5 library handles enctype differences internally, so
a single encrypt function and a single decrypt function serve all
enctypes, eliminating the per-enctype dispatch table that previously
existed in struct gss_krb5_enctype.

RFC 4121 Section 4.2.4 requires MIC checksums to cover the message
body followed by the GSS token header. The crypto/krb5 get_mic/
verify_mic API hashes optional metadata before the scatterlist
data, which is the wrong order for the GSS header. The header is
therefore placed at the end of the scatterlist rather than passed
as the metadata parameter, and a dedicated gss_krb5_mic_build_sg()
helper constructs this three-section layout (checksum area, message
body, token header) with proper sg_mark_end() termination.

This implementation was available during the Spring 2026 NFS bake-
a-thon, and received testing there.

---
Chuck Lever (18):
      SUNRPC: Add Kconfig dependency on CRYPTO_KRB5
      SUNRPC: Add crypto/krb5 enctype lookup to krb5_ctx
      SUNRPC: Add helpers to convert xdr_buf byte ranges to scatterlists
      SUNRPC: Add errno-to-GSS status conversion helper
      SUNRPC: Prepare crypto/krb5 encryption and checksum handles
      SUNRPC: Switch wrap token encryption to crypto/krb5
      SUNRPC: Switch wrap token decryption to crypto/krb5
      SUNRPC: Switch Camellia decrypt to crypto/krb5
      SUNRPC: Switch MIC token generation to crypto/krb5
      SUNRPC: Switch MIC token verification to crypto/krb5
      SUNRPC: Remove get_mic/verify_mic function pointers from enctype table
      SUNRPC: Remove wrap/unwrap function pointers from enctype table
      SUNRPC: Remove encrypt/decrypt function pointers from enctype table
      SUNRPC: Remove legacy skcipher/ahash handles from krb5_ctx
      SUNRPC: Remove dead code from rpcsec_gss_krb5
      SUNRPC: Remove per-enctype Kconfig options
      SUNRPC: Remove redundant crypto Kconfig dependencies
      SUNRPC: Remove dead rpcsec_gss_krb5 definitions

 include/linux/sunrpc/gss_krb5.h         |  105 --
 include/linux/sunrpc/xdr.h              |   16 +-
 net/sunrpc/.kunitconfig                 |   29 -
 net/sunrpc/Kconfig                      |   56 +-
 net/sunrpc/auth_gss/Makefile            |    4 +-
 net/sunrpc/auth_gss/gss_krb5_crypto.c   | 1014 ++++-------------
 net/sunrpc/auth_gss/gss_krb5_internal.h |  155 +--
 net/sunrpc/auth_gss/gss_krb5_keys.c     |  546 ---------
 net/sunrpc/auth_gss/gss_krb5_mech.c     |  441 ++------
 net/sunrpc/auth_gss/gss_krb5_seal.c     |   47 +-
 net/sunrpc/auth_gss/gss_krb5_test.c     | 1868 -------------------------------
 net/sunrpc/auth_gss/gss_krb5_unseal.c   |   36 +-
 net/sunrpc/auth_gss/gss_krb5_wrap.c     |   13 +-
 net/sunrpc/xdr.c                        |  266 +++--
 14 files changed, 573 insertions(+), 4023 deletions(-)
---
base-commit: f3a96328282e8d41ba9f478d24ac122e4cbd2989
change-id: 20260316-crypto-krb5-api-b9ee22636698

Best regards,
--  
Chuck Lever


