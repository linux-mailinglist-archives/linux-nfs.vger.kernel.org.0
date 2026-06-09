Return-Path: <linux-nfs+bounces-22415-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N2AfOApUKGoMCQMAu9opvQ
	(envelope-from <linux-nfs+bounces-22415-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:57:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 405C96631E9
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:57:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Awl9q9tu;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22415-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22415-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C34D93082C39
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893CD4DD6C5;
	Tue,  9 Jun 2026 17:48:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797474DC54E;
	Tue,  9 Jun 2026 17:48:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027282; cv=none; b=sqwq8dL5+bvKij1TOd/CAgBw0t3XE/FAmfVoRirL5NKR2G3dMYJm4YYOTdFfaff1Vnp0kx1HFmlXfBtMi4fwL6yVkvXj1SCng3W0uYXn5Eh2XIcxUK7uscBbljr9lC5zMbuBi51RjCcIWxPsn910H4y2w6SJEnZK9js8rir7PAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027282; c=relaxed/simple;
	bh=+rxPQ6oAE0p/Q4OGK6v8FZlkDtkd3fH11hIexGCDKI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ge2r5390XdJ6CIRKRJ9/tauRkon4OaQGKj8awy7k1HaX+beQstf1nnZpmAZWXPWx+t/M3eDWewyevSynZXH91Cn8qvniTTgNkzWwPHkKUzMThVcy9VSzrwb+wI07yZSEhwN3P4v8iezKSlb+d7pb0RJrAkNfEsq9oBqwnLHYWEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Awl9q9tu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD211F00893;
	Tue,  9 Jun 2026 17:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781027281;
	bh=DnDZp+b6bsA0t2dC0iM15A3EwgkBFB7/zFfve8bdYNc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Awl9q9tun2m/s/0PiaUcmAXrsJwb/QNmOzJz2oYHbBTIbC3nMlJo+JGGuPkv12Ns1
	 ZtqiIszcOIApmL+lTYcLcyzzrBduffkSGe7s8WmTSmsPsk2qwcxntPvWtMe0brlOWy
	 xVYNRGvc9nq7FE9FW5DtT2t2Nk08l6x/4AV7UITc6phjLQDy+RBT0YANSDsPCyy6LQ
	 HiBVB6mX+5tLveaE6s0oJjKHtXPNEjaGaDGu4ez7eVgi72SUbVoSG+TtZcxglhde1S
	 RS/kWTZGLdKZjI585w6u0oK/HKqdb+UCLhGo/TBGq4d2liu/UPmXYRGtQQ61Q2W72e
	 7xAAyoTq4uLGA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 09 Jun 2026 13:47:29 -0400
Subject: [PATCH 08/19] nfsd: validate nseconds in TIME_DELEG decode paths
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-nfsd-testing-v1-8-e83acead2ae8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2493; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+rxPQ6oAE0p/Q4OGK6v8FZlkDtkd3fH11hIexGCDKI4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKFG7HMn/HTPaYBZaRGxQgWejVQj3HzFu8FIUm
 xlEhhzQ3L2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaihRuwAKCRAADmhBGVaC
 FckLD/49ULnUkLNOmF0aOG4MS8JBp2WM1RC22ZJtX76kDOBezXrjsZkeW4fWlyHiKOIaCX1m8BV
 3i5CqbmQ1tnvn8a24BFddxSOvJQdFWYDkOgM3g0FzXAylY8Ss0cuHPFUmu9ZnNc4fa3QroDTpl6
 th+PrbkH0mtA3JSvbNCEUA/sIlEmRZPeSrKcyHg1bQbnPBikBhQRFTWfIM/QdQKl4j3ftqLuWPG
 ZSNETpI/HvgYIbogOx1iEcdDbCcczpqdute3x5BnwPM98HvBpESzKEs5N7WWWI8WF8vKJPOGcH1
 y1yt4rQrb906AwZFfuoYW0gpgX7+9wSFORqolwLKu5D5cHqzuM613iW9kEVqIIYxTtqLcv9oA0K
 kxPbaKjukwlIslLvn8dYufFza21Hr+hN60tVea+dER/atxiNuSB1UMTbXSnpvmzWLkgzyBO1YdI
 rXWOKrh7oVo+jjbcToNv/QnHE0YXpw6I88XOA+dFYfRC8omI7MSuZyRlzqCncbhwCOjdJt+q7aE
 2Tfg/PnqCcrr7SWilacG3zmHqjvDsv4Jdh3gfc8iqe6nNpqC3cg7pbmY+ymFoP0mNuuDTdTOy+G
 xgwi5F5JXMZBn2cR6kDdjYDg8EKcxR0JKKq4WwqZv94Vh6wToQV+f0yvjS0OZJVGo2SSN6x/QoQ
 +5Ra1l+T5pQdXZA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-22415-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 405C96631E9

The xdrgen-based TIME_DELEG_ACCESS and TIME_DELEG_MODIFY decode arms
store a raw uint32_t nseconds directly into tv_nsec without enforcing
nseconds < NSEC_PER_SEC. The legacy nfsd4_decode_nfstime4 has this
check but the TIME_DELEG paths do not. A malformed timespec can
propagate through notify_change() to disk.

Add range checks in both nfs4xdr.c (SETATTR path) and
nfs4callback.c (CB_GETATTR path).

Fixes: 6ae30d6eb26b ("nfsd: add support for delegated timestamps")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 4 ++++
 fs/nfsd/nfs4xdr.c      | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 1628bb9ef9dd..7c868afc329e 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -108,6 +108,8 @@ static int decode_cb_fattr4(struct xdr_stream *xdr, uint32_t *bitmap,
 
 		if (!xdrgen_decode_fattr4_time_deleg_access(xdr, &access))
 			return -EIO;
+		if (access.nseconds >= NSEC_PER_SEC)
+			return -EIO;
 		fattr->ncf_cb_atime.tv_sec = access.seconds;
 		fattr->ncf_cb_atime.tv_nsec = access.nseconds;
 
@@ -117,6 +119,8 @@ static int decode_cb_fattr4(struct xdr_stream *xdr, uint32_t *bitmap,
 
 		if (!xdrgen_decode_fattr4_time_deleg_modify(xdr, &modify))
 			return -EIO;
+		if (modify.nseconds >= NSEC_PER_SEC)
+			return -EIO;
 		fattr->ncf_cb_mtime.tv_sec = modify.seconds;
 		fattr->ncf_cb_mtime.tv_nsec = modify.nseconds;
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1e4a51926910..056a8df3fd50 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -637,6 +637,8 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 
 		if (!xdrgen_decode_fattr4_time_deleg_access(argp->xdr, &access))
 			return nfserr_bad_xdr;
+		if (access.nseconds >= NSEC_PER_SEC)
+			return nfserr_inval;
 		iattr->ia_atime.tv_sec = access.seconds;
 		iattr->ia_atime.tv_nsec = access.nseconds;
 		iattr->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET | ATTR_DELEG;
@@ -646,6 +648,8 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 
 		if (!xdrgen_decode_fattr4_time_deleg_modify(argp->xdr, &modify))
 			return nfserr_bad_xdr;
+		if (modify.nseconds >= NSEC_PER_SEC)
+			return nfserr_inval;
 		iattr->ia_mtime.tv_sec = modify.seconds;
 		iattr->ia_mtime.tv_nsec = modify.nseconds;
 		iattr->ia_ctime.tv_sec = modify.seconds;

-- 
2.54.0


