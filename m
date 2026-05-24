Return-Path: <linux-nfs+bounces-21896-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKwsMChOEmqjxgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21896-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 24 May 2026 03:02:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B555C1002
	for <lists+linux-nfs@lfdr.de>; Sun, 24 May 2026 03:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F48A3011BEE
	for <lists+linux-nfs@lfdr.de>; Sun, 24 May 2026 01:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7658D18FDBD;
	Sun, 24 May 2026 01:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SptiVSrP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C00970818
	for <linux-nfs@vger.kernel.org>; Sun, 24 May 2026 01:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779584539; cv=none; b=mtZ3UdbKNCIcc6L1BluTaaW1guBaUBNeU6E54q2z8cJ442Us+YtJ2DXeTCLOBaaMHNzFnZ1FnQKLU8jA5rodD5xDnqmaB1u/Vgf3K9wFI0hy+yk9/aNC7Wdv//VDcteEUpgtCG4mlADRxlMN1ZAEPeW4YCjp1u8bhd9JmJlnmHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779584539; c=relaxed/simple;
	bh=xf18OctvDJmekJEhcQTgC5EIvg4Tamaj9PzYd5uGS20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIWcS5J2zhFVO8xP8gwp7qJd2pWoXbuPX0c1kxLTVEUqHwMVwc1CDCYZEivEnts6RARMCSOwCtGvGh9TosSnEA0o7CKoEuc6gSg6pvS84TnscL9AZ3P330ckyCDF/ZcBNFQoy3Vv0mGz3RWuL5iWgO5MxVKj0xZkgaYhGs4z+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SptiVSrP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5231F00A3A;
	Sun, 24 May 2026 01:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779584538;
	bh=ET26Bu/NVyBOAtya6YfO8eWjgRT22PtWtH2abyRfHJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SptiVSrPRE2c2t4S+DFeVmHK/DJcwY7YjDTOOp21ZtUkKE8Lgu8BhmWvoavEWt1OF
	 Hn75hppkpKPWnVNLYxVW/wBSCxMSyrwRKFHY+gq33ITN9KSd+ASl9Q9sp8vsYbWf/2
	 NQiRJfO8t7URoI5DxAn/9tmIDjCQCX3L5yR5p6zY/MrHqIuURnk8wUyYj+IIRYBUoa
	 9EUXX0oOf+DdSIQLlgA12UdWLzGKQHyB8rKXZWAA5pP2TJymgE7roO6NI082ag2v/N
	 hI28weDUHkVQTQ66RQDaJQ5zxkMsKlkTFqegLWyNxKf1gRkPM8GyTawWLUYWcHiloI
	 jOEYDLgrkpuYg==
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
Subject: [PATCH 2/4] SUNRPC: harden gss_unwrap_resp_priv length checks
Date: Sat, 23 May 2026 21:02:11 -0400
Message-ID: <20260524010213.557424-3-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21896-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: 24B555C1002
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

gss_unwrap_resp_priv() validates the RPCSEC_GSS opaque length with

    offset = (u8 *)(p) - (u8 *)head->iov_base;
    if (offset + opaque_len > rcv_buf->len)
            goto unwrap_failed;
    maj_stat = gss_unwrap(ctx->gc_gss_ctx, offset,
                          offset + opaque_len, rcv_buf);

Both operands are u32 and the sum is computed in u32. A reply with
opaque_len near 0xffffffff makes offset + opaque_len wrap to a small
value that is below rcv_buf->len, so the bound check passes and
gss_unwrap() is called with end < begin. The check also lacks a
lower bound, so any opaque_len in [0, GSS_KRB5_TOK_HDR_LEN) is
accepted and forwarded to gss_krb5_unwrap_v2(), whose pre-decrypt
header reads at ptr+4 and ptr+6 then run past the token.

A krb5p NFS server returning a crafted RPCSEC_GSS reply can drive
the client into out-of-bounds reads in gss_krb5_unwrap_v2() and the
rotate_left() loop that follows.

Fix by replacing the single combined check with three guards that
are safe in u32 arithmetic and that enforce the RFC 4121 minimum
outer token length:

    if (offset > rcv_buf->len)
            goto unwrap_failed;
    if (opaque_len > rcv_buf->len - offset)
            goto unwrap_failed;
    if (opaque_len < GSS_KRB5_TOK_HDR_LEN)
            goto unwrap_failed;

The first guard makes the subtraction in the second guard
unconditionally safe; offset is derived from a successful
xdr_inline_decode() in the head kvec, so in practice it already
satisfies the bound. The floor mirrors the server-side check added
in commit 7507012eeb98 ("SUNRPC: svcauth_gss: enforce krb5 token
minimum length").

Fixes: 2d2da60c63b6 ("RPCSEC_GSS: client-side privacy support")
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/auth_gss.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 9d3fb6848f40..8ddc65e894da 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -2072,7 +2072,11 @@ gss_unwrap_resp_priv(struct rpc_task *task, struct rpc_cred *cred,
 		goto unwrap_failed;
 	opaque_len = be32_to_cpup(p++);
 	offset = (u8 *)(p) - (u8 *)head->iov_base;
-	if (offset + opaque_len > rcv_buf->len)
+	if (offset > rcv_buf->len)
+		goto unwrap_failed;
+	if (opaque_len > rcv_buf->len - offset)
+		goto unwrap_failed;
+	if (opaque_len <= GSS_KRB5_TOK_HDR_LEN)
 		goto unwrap_failed;
 
 	maj_stat = gss_unwrap(ctx->gc_gss_ctx, offset,
-- 
2.54.0


