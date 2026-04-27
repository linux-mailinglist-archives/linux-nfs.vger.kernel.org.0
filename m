Return-Path: <linux-nfs+bounces-21194-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLKAMqpr72nFBAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21194-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:59:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A2106473E3D
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E85B30C2D33
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281393DA7C0;
	Mon, 27 Apr 2026 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnBDe5Jh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AD03D34BB;
	Mon, 27 Apr 2026 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297893; cv=none; b=BVOU1m7X7Q3I2HCYFvHF9je5RL3JKGrCaRipusRjezlfXP364jTnm1SIDm9LuMCurgahblw+PvgvKZj/mTDD52QRXf9D++SxLj8ke1u2tDhfql3PvI00UPCTM14rUPsj4kj3cZhBea4zTytNJ7rKHtUrc+5dtolJUBMn6aQYX8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297893; c=relaxed/simple;
	bh=q+MPGWj1hwF2SHIzOKggEEECV6wInR9whB+2Evd0YfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YIFO4XLFoAD5cLuwj9RDs0YBeP1dLZCVAe53BDIHVDiqV3z9jN5vvHswtMKM60E8m0o1F3DlluFkYz11JBUIVuCMUrdfscJ6MbxK2SsFBmEX2xJRayIo4T1WgZRvWCFjGe3/kGTLtMFk//JG83tVkePzpgZkTThvH0xtqsFkv90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnBDe5Jh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53796C19425;
	Mon, 27 Apr 2026 13:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777297892;
	bh=q+MPGWj1hwF2SHIzOKggEEECV6wInR9whB+2Evd0YfE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tnBDe5Jh0qY2ewG3LEIZ5u2ia6lHE+lu/wbZ2ewavzhY0NrKDiJAsjjDZvQW1EsEy
	 zip/CKeqn1umChekZHZbO5E+FzdBQpTwGCy/pniT20um+RcjAHAOx0ysf5QQxS/xP5
	 2ENR60oN4582uWLSBPQ/qQLV6vXvDP4ZxZonCzjoEiGPPX+P3FR6Qe218u04uBtIQX
	 +Nto+SQH0dnbEZRk26wcq+tapmKdq9wnH/4enqAQbQiUesj3dTywlvLB59W1I5pFNi
	 BwdZSZ/BKpO5WfgYJ/Nax+E5bUpqcVVbBF8ez+CF7R/NNdHlHYzydozbkVT01HuFci
	 yiPVEVRI9/08w==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 27 Apr 2026 09:51:01 -0400
Subject: [PATCH 17/18] SUNRPC: Remove redundant crypto Kconfig dependencies
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-crypto-krb5-api-v1-17-1fc1253b64c0@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=chuck.lever@oracle.com;
 h=from:subject:message-id; bh=6wfcb9eqdE0UdZxrAj+3ja/0k907mR3DqChptOCRX5o=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp72nHhB7soYZQlfsQ4VzTXddPZMLY00ASEuDwS
 yrNTzwy5L6JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCae9pxwAKCRAzarMzb2Z/
 l4fMD/43BWcrvVUPCO060RPXR3ghV86Vo1ddhYawulJphS38CLZcbeR9KwDfuGZsJV64uzorJYw
 uUyo4e1H6DEvSNnDNAmiOJQ+lbmIjKEKKW5+x/P0Yj8mAQ3DBsEnqL1KOvlG0RHz41qmhfYFHqV
 CS2bxpceMKYWnd+s/sPXQZvMKF1uZIJ4Q7PiVWsOfMrWf1+mrx5HkUrpu7BjK30qxuyivV+ZIGJ
 nAxTLasLj0wpGtv1hTckk0pIeu21lMdd7AgrJjgtksttqF1Q8taRF7IYgK+IdGIBubeRPlZ8DKy
 il1/S2l7UgZOhNkPnTgi+k4k+fbxtUU2EZLaVpzNWeiiUgoolEB5tXJkc8lYd0Xece7xYCNVhij
 M+GRTrpFiNJOV1oGgcX7Xs1lw/5HzYQ0E2LqbGERT+R64uZLWLBFkyFpMv64E/Zr5+n8gLQp1sl
 rbsCarzkwPcvCVCusoWnNww+YWorhFh6Mk15NzqEPi1HCFT1MteXIw7+EG1dBlrIT8rM6YcqWxC
 6QSfIffcbJg55J7Rqrc2OXFAKEgc/rUFfzi9E3MQNHqzUdnlV810W2Q08E0H95nX1h40rOT4f2J
 TtHAHiQrV3mncx49v7xn+tHi1FTy2tUN2BdS99Vsb8MrymS1x0j9OJuTEs1/YRVGcEGO/AB1+Ey
 +KGaw6Va3CdHR1A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: A2106473E3D
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
	TAGGED_FROM(0.00)[bounces-21194-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]

From: Chuck Lever <chuck.lever@oracle.com>

With all per-message crypto operations now routed through
crypto/krb5, rpcsec_gss_krb5 no longer calls individual
crypto algorithms directly. The CRYPTO_KRB5 symbol already
selects CRYPTO_SKCIPHER and CRYPTO_HASH (the latter
transitively via CRYPTO_HMAC).

Drop the top-level select CRYPTO_SKCIPHER and select
CRYPTO_HASH from RPCSEC_GSS_KRB5, as these are redundant
with CRYPTO_KRB5's own dependencies.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
index 305c55cdbd45..e7808e5714dc 100644
--- a/net/sunrpc/Kconfig
+++ b/net/sunrpc/Kconfig
@@ -22,8 +22,6 @@ config RPCSEC_GSS_KRB5
 	default y
 	select SUNRPC_GSS
 	select CRYPTO_KRB5
-	select CRYPTO_SKCIPHER
-	select CRYPTO_HASH
 	help
 	  Choose Y here to enable Secure RPC using the Kerberos version 5
 	  GSS-API mechanism (RFC 1964).

-- 
2.53.0


