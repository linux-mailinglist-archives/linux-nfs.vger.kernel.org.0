Return-Path: <linux-nfs+bounces-21898-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNs5OTVOEmqjxgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21898-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 24 May 2026 03:02:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA6A5C1011
	for <lists+linux-nfs@lfdr.de>; Sun, 24 May 2026 03:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64F0D301572F
	for <lists+linux-nfs@lfdr.de>; Sun, 24 May 2026 01:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECB42E413;
	Sun, 24 May 2026 01:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hASntrQS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085FE70818
	for <linux-nfs@vger.kernel.org>; Sun, 24 May 2026 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779584541; cv=none; b=HV3Hdn2jHCfXE0YS+p5xoJt5UP3Y3wUWQa/KycQZL3Yh2MGA8PZNN6NJ2/0sQz3p9xSNcZKe0DkbhW+6x0WWtNPpodvkTpuEqhvkbCUbWNRqjLkZ98WSrQIkfwPzFDpGoww8b1kisdEIUnxlyBFuKB09Z2FEQOiDLjdEu5G5X8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779584541; c=relaxed/simple;
	bh=T32+T8HiZExIZtMOUDLQOhMAiLV9IlF68fYQD28FsCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XyHNvQGnHj/9UvHHCbzuYoVSbyb5wLuROqMri9c6l8GZH1eWEzdsQdtMeO0f5up7oXsO3uhbCtAumEr6hjWMMP5zp5voamp2MUcq/Q5gsfC8X92zzI0NRKzn9pucnAqERP+6RwPJ5ZY3QA/ym7aUSZOOeO4Kx+LxpXWHIvx+RPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hASntrQS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F471F00A3D;
	Sun, 24 May 2026 01:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779584539;
	bh=eGHBzKVJYN8sRkaPTEUvjWOR3Q99qX5FnfxO4UeN8Tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hASntrQS4lpC/oixdRCs43FVjKc1QBZ4DekJZtHurbHaOF99dNd2PVRqPSIM+Rz6I
	 /z63CbkJUahHADDRTubCQ/20FwyN9l3NTQ6P42Q5oKkiHn3Q3oBq8ayxaZYXZNx3EB
	 ZZFSSZlu7xYTh64KmQp7MpRmTzytAsOHVx7mbKrOA+CU5fy+w05LZPDJA5MirCUmwO
	 TP5Jz0YeVpkcPGbxd3qenO1KG+3o3s0gatK7puHJkEoWqKuY1vMP0PJ6lb1atcCWLT
	 CITstmI8zAer1KFLOP5A1/vDHZpW/t3HeEPDoBcFgPttyLx3tElfdx8FrNZcs0n4u8
	 3tmG54ruXLABg==
From: Chuck Lever <cel@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chris Mason <clm@meta.com>
Subject: [PATCH 4/4] SUNRPC: harden gss_krb5_unwrap_v2 against short tokens
Date: Sat, 23 May 2026 21:02:13 -0400
Message-ID: <20260524010213.557424-5-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524010213.557424-1-cel@kernel.org>
References: <20260524010213.557424-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21898-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: 4AA6A5C1011
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

gss_krb5_unwrap_v2() reads the EC and RRC header fields at ptr+4 and
ptr+6 before validating that the token is at least GSS_KRB5_TOK_HDR_LEN
(16) bytes long, and its rotate_left() helper passes buf->len - base
to xdr_buf_subsegment() without verifying that base <= buf->len. When
a caller hands in a sub-16-byte token, or a token whose declared len
leaves base past the end of the buffer, three distinct failures follow:

    gss_krb5_unwrap_v2(offset, len, buf)
      ptr = buf->head[0].iov_base + offset
      ec  = *(ptr + 4)              /* OOB read on short head */
      rrc = *(ptr + 6)              /* OOB read on short head */
      rotate_left(offset + 16, buf, rrc)
        xdr_buf_subsegment(buf, &subbuf,
                           base, buf->len - base)   /* u32 wrap when base > len */
        _rotate_left(&subbuf, shift)
          shift %= buf->len         /* divide-by-zero when base == len */

After decryption, the cleanup arithmetic has the same shape:

    movelen = min_t(unsigned int, buf->head[0].iov_len, len);
    movelen -= offset + GSS_KRB5_TOK_HDR_LEN + headskip;
    BUG_ON(offset + GSS_KRB5_TOK_HDR_LEN + headskip + movelen >
                                            buf->head[0].iov_len);

The BUG_ON re-adds the value just subtracted, so it reduces to
min(A, B) > A and is permanently false; it cannot catch the unsigned
underflow of movelen, which then drives a ~UINT_MAX-byte memmove().

Add four defense-in-depth guards inside the unwrap core so it is safe
regardless of what its callers validate:

  - reject tokens with len - offset < GSS_KRB5_TOK_HDR_LEN before
    touching ptr+4/ptr+6;
  - bail from rotate_left() when buf->len <= base, covering both the
    underflow and zero-length cases;
  - return early from _rotate_left() when buf->len is zero, so the
    shift %= buf->len modulo cannot fault;
  - replace the dead BUG_ON with a live check that returns
    GSS_S_DEFECTIVE_TOKEN before the movelen subtraction.

Fixes: de9c17eb4a91 ("gss_krb5: add support for new token formats in rfc4121")
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_wrap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index ac4b32df42b9..d84c35f779f5 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -73,6 +73,8 @@ static void _rotate_left(struct xdr_buf *buf, unsigned int shift)
 	int shifted = 0;
 	int this_shift;
 
+	if (!buf->len)
+		return;
 	shift %= buf->len;
 	while (shifted < shift) {
 		this_shift = min(shift - shifted, LOCAL_BUF_LEN);
@@ -85,6 +87,8 @@ static void rotate_left(u32 base, struct xdr_buf *buf, unsigned int shift)
 {
 	struct xdr_buf subbuf;
 
+	if (buf->len <= base)
+		return;
 	xdr_buf_subsegment(buf, &subbuf, base, buf->len - base);
 	_rotate_left(&subbuf, shift);
 }
@@ -154,6 +158,9 @@ gss_krb5_unwrap_v2(struct krb5_ctx *kctx, int offset, int len,
 
 	dprintk("RPC:       %s\n", __func__);
 
+	if (len - offset <= GSS_KRB5_TOK_HDR_LEN)
+		return GSS_S_DEFECTIVE_TOKEN;
+
 	ptr = buf->head[0].iov_base + offset;
 
 	if (be16_to_cpu(*((__be16 *)ptr)) != KG2_TOK_WRAP)
@@ -220,9 +227,9 @@ gss_krb5_unwrap_v2(struct krb5_ctx *kctx, int offset, int len,
 	 * head buffer space rather than that actually occupied.
 	 */
 	movelen = min_t(unsigned int, buf->head[0].iov_len, len);
+	if (movelen < offset + GSS_KRB5_TOK_HDR_LEN + headskip)
+		return GSS_S_DEFECTIVE_TOKEN;
 	movelen -= offset + GSS_KRB5_TOK_HDR_LEN + headskip;
-	BUG_ON(offset + GSS_KRB5_TOK_HDR_LEN + headskip + movelen >
-							buf->head[0].iov_len);
 	memmove(ptr, ptr + GSS_KRB5_TOK_HDR_LEN + headskip, movelen);
 	buf->head[0].iov_len -= GSS_KRB5_TOK_HDR_LEN + headskip;
 	buf->len = len - (GSS_KRB5_TOK_HDR_LEN + headskip);
-- 
2.54.0


