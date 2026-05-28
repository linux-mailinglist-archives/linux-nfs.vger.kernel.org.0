Return-Path: <linux-nfs+bounces-22044-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KSbCF+YGGqklQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22044-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:32:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A495F7249
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 485453026E67
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 19:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EDF32BF5A;
	Thu, 28 May 2026 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAHJY5rs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B15F30C60E;
	Thu, 28 May 2026 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996747; cv=none; b=l1MH0MJmEXpncK2X/cljmvSS5gYkAdPI9rknPnoxPaKsy7RelUbe7iSKAkpjaXbSP0iU2Bk5WV3SSjqn1nlKM9ZPLT7U81SgBiRDfpWuBvjRdNrsrJ3zrxK4Emtqkls384fm4WVNJSvEP78GiaN8nfWelwwP39ntE6u06Gu5E44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996747; c=relaxed/simple;
	bh=c4ckHtz1zzAIHz4UP6VnQUWglvWqZXAB4XCc96EP4Fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oAxk9zd0ZzRmIJFtC5QVndvvEr8mPZW1xGrRQXTKx7Pg/Gh/LmVA+EBQ7E5uvqGOr+C01kPyu/LgCyZD5wt95hstotVev8F0jmQ3ncfE1psBTfp+vxyjZj3NKmN1KZVDhxCPcetdPvl2RWDrhnzI1JMaXV++NtRDxdyTVrrDnrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAHJY5rs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732471F00A3A;
	Thu, 28 May 2026 19:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779996746;
	bh=LXJ5bnRonEDAf/rMIey2RDCgT5oyNaJooOAtm6qM4F8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MAHJY5rsWA4V1Glbc7n3xDDfS3MhO5JEf3rKeiptg2CwUgphYS1h4mc9N/coHBBCp
	 IlR5ZPvoi76SI+8zg9QSbP49ueXU/1T6EfSnV5CdsgF1biogUC9ZezcJF5rx6uYBSJ
	 7DEBwH0MRIWNJ8Rkg4ApSxNhaUCCcFLRWM30lUQpKnKlXF5J/ISHLWrf7ZbQIemhHG
	 +SjAhLc/alfkguAviWQBBOiaZq+kLbMRAhUXT5QMhleGN2IR4kG9H5IAa+s7oSdeTt
	 bCiVxHBb1+HnC3fpPHRop0CYdksiVA/OoHmaGo92aKI8Vs8Bht8kA2aYbzheyjqgjT
	 1hNIxvWuISVig==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 28 May 2026 15:32:08 -0400
Subject: [PATCH 1/6] SUNRPC: Reject krb5 v2 wrap tokens with oversized ec
 field
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-tier2-v1-1-d026a1415e0b@oracle.com>
References: <20260528-tier2-v1-0-d026a1415e0b@oracle.com>
In-Reply-To: <20260528-tier2-v1-0-d026a1415e0b@oracle.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
 Simo Sorce <simo@redhat.com>, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2280;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=KpTFfI2vubbOKV4w08TJwxdnfzYHKcZuZvS6qTONSBM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqGJhHpuuFLGlvKwLBodjkG4yo21opkp3o4slxQ
 ppkPVCcipeJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahiYRwAKCRAzarMzb2Z/
 l0SND/9o+yEpIAzwTXkgsfkprS3klVHfAzNhSoRF653OTGzuQdaHhy9xx7DAV3cmzE6LGpmKcnw
 pZf29ZL0KSOVvzSEgq4ESV9KD4mYH0WVPJB9u6IOJwVzDFfgmTZTlC9CbOUGYo4GJ+j85YS04i8
 EzaimL8/FTMIdzo2B3epCeazp6eqGo4oVCwQ8eFq2GpoE8pE48neRgMYwnSIpMMLsEgOyHQCtOO
 0HiBEaHUfZbkdL7IN25SC89c7yEKQlux0wNbg5gvyn/PQyF7VqCymLelhV/LbojIzllB9h9bgDP
 /J0WuJekY6sSwiRop6Y3duKt7h8Ls+9w+YhdQVY/XC3KGv/zKFb2UM+L5/wXGtkPkKqoQLooIqi
 p7/TmNKkjdkKhwjaX/9jqbrjW3WkI8qUnrxcFWV4jSa5fJOtLYf1lCnlCFFJ0qgqpntX7njAROe
 acyibxuBxhiH1AcOCP6hWCwsUoPep1HYf+opXyC2l+gmv43sQVqVtCMXQk7lHuIWyHydpIH/Gms
 yC+xsKa9fDMW0bFkwwMMAxGm3Z72XR5BQQ3c2fbl8Irtai+tljeVZONOpxdLMWeCz1O6Z18lmT8
 Pl6TF36bfWXImDChBPqBqfaPKU8mwLWTW52dlgXLeNpUlbuGeHxM3z46ZKn+VxYTZS9iGZRoHTP
 fF4SwOzdI2zdrCQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-22044-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 18A495F7249
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

gss_krb5_unwrap_v2() sets buf->len to a logical
length, which can be much smaller than head[0].iov_len
(the allocated receive-page capacity).  It then calls
xdr_buf_trim() with a trim length derived from the 16-bit
"extra count" (ec) field in the Kerberos v2 token header.

The ec field is authenticated by the post-decrypt memcmp()
against the encrypted header copy, so a randomly-mutated
value is rejected.  However, any peer holding a valid GSS
context can legitimately encrypt a token whose ec exceeds
the plaintext length.  Per RFC 4121, such a token is
structurally malformed.

Although xdr_buf_trim() now clamps the buf->len subtraction
to avoid unsigned underflow, the buffer is still left in a
semantically invalid state (zero length, inconsistent iov
lengths) when ec is oversized.

Reject these tokens before calling xdr_buf_trim(), giving
callers a well-defined GSS_S_DEFECTIVE_TOKEN error and
keeping the xdr_buf internally consistent.  The wrapped blob
begins at a nonzero offset -- both callers pass len as
offset + opaque_len -- so buf->len still counts the offset
bytes that precede the blob.  Compare the trim length
against the remaining wrapped segment, buf->len - offset,
rather than the whole buffer; comparing against buf->len
alone leaves an offset-wide window in which an oversized ec
passes the test and xdr_buf_trim() cuts into the bytes ahead
of the blob.

Fixes: cf4c024b9083 ("sunrpc: trim off EC bytes in GSSAPI v2 unwrap")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_wrap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index d84c35f779f5..d3f61c4b5a13 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -235,6 +235,8 @@ gss_krb5_unwrap_v2(struct krb5_ctx *kctx, int offset, int len,
 	buf->len = len - (GSS_KRB5_TOK_HDR_LEN + headskip);
 
 	/* Trim off the trailing "extra count" and checksum blob */
+	if (ec + GSS_KRB5_TOK_HDR_LEN + tailskip > buf->len - offset)
+		return GSS_S_DEFECTIVE_TOKEN;
 	xdr_buf_trim(buf, ec + GSS_KRB5_TOK_HDR_LEN + tailskip);
 
 	*align = XDR_QUADLEN(GSS_KRB5_TOK_HDR_LEN + headskip);

-- 
2.54.0


