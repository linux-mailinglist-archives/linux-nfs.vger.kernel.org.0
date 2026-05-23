Return-Path: <linux-nfs+bounces-21872-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC+oCF3bEWq0rQYAu9opvQ
	(envelope-from <linux-nfs+bounces-21872-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 18:52:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FEE5BFE4E
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 18:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BDBB300E5F9
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 16:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC1C31195B;
	Sat, 23 May 2026 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuhqxF+c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB63221FB6
	for <linux-nfs@vger.kernel.org>; Sat, 23 May 2026 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555161; cv=none; b=mX+xxoA2jzb9s0Hqa6owMYPRjYZYy/80opUvYp6kfi6IYlKbWRssQ6g4B9en+vJ/OsZ662fIl8Bb8f/4QJPCdo1K6nthGNcjJNHyb/wd8iPNdS5fBX1GaO3OXqNyy5gKiIM6ajNkEj18gfD+G6k26Zf5ifo3xExEHV7frP5I3U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555161; c=relaxed/simple;
	bh=tNixGLk/kHI+rRk29OiHg7VCLfhrEZEjsKn/9rXhn9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uexZSceYQKP8PIH+EHRmtNRfBknBEMNRPgGnInsAYWRb+Y9g5LacRYicW5Ueyj86jTj2Gg2X1rDabfGrxfkEknu4EqnzvrFtcnaaZrhPu4yv5qWu+7s0f7G7ofkvKMfCRD448elT0Z/89YCEsWb1rpPs+BMzWbIH4pOOM2f6cZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuhqxF+c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8312B1F000E9;
	Sat, 23 May 2026 16:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779555160;
	bh=0jP8nTyRtg0rkBk4SpSIH5+VkUx1g4zqZ9hM0xx+gw8=;
	h=From:To:Cc:Subject:Date;
	b=NuhqxF+cRNpIsqZg7ahb+osq/uCyEekk1HytHLBLt0yJ9nb6xhua5W/3g7VcUNE1K
	 bInZEH9XrkNkJx/z/bmxewCRM3hRIIZYH/hXG5XWGPoLrv74U18BzReZ/fb/BR34Px
	 zu0CmYHHbyaOVPLxDBSxnTmoxRnuFD7dqWXPtwBchzIkXvwVozdr+E4npnB9qEF6pO
	 75u0fSqP2FsQxtmgGJxI2zdW9rxuxiIurhNmwiECK/BWaxfJD9QlimMSotxHk0h1hy
	 D+fAaDAvmdWkO75OxechN3ZsAZ7Yssar0i6eGF7eIWfV4twEzY1fBayu4DsUfE7bmw
	 yvVSDPYJKe+YQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Chris Mason <clm@meta.com>
Subject: [PATCH] SUNRPC: Reject short RFC 4121 MIC tokens in gss_krb5_verify_mic_v2
Date: Sat, 23 May 2026 12:52:37 -0400
Message-ID: <20260523165237.510204-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21872-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mic.data:url]
X-Rspamd-Queue-Id: 89FEE5BFE4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

gss_krb5_verify_mic_v2() reads the token ID at ptr[0..1], the flags
byte at ptr[2], and padding at ptr[3..7], then passes
ptr + GSS_KRB5_TOK_HDR_LEN and cksum_len to gss_krb5_mic_build_sg().
None of these accesses check read_token->len first.

The minimum safe token size is GSS_KRB5_TOK_HDR_LEN (16) plus
ctx->krb5e->cksum_len (12-24, depending on the enctype).  All callers
accept shorter tokens from the wire:

 - gss_unwrap_resp_integ() enforces only an upper bound
   (offset + len <= rcv_buf->len) before allocating
   mic.data = kmalloc(len) and passing it to gss_verify_mic().
   A malicious NFS server can therefore supply a short checksum
   opaque, producing a small slab allocation that the Kerberos MIC
   verifier reads past.

 - gss_validate() enforces only len <= RPC_MAX_AUTH_SIZE (400)
   before passing the wire-supplied length to
   gss_validate_seqno_mic(), which constructs a mic xdr_netobj
   and calls gss_verify_mic().

 - svcauth_gss_verify_header() enforces only
   checksum.len >= XDR_UNIT (4 bytes) before dispatching to
   gss_verify_mic().

 - svcauth_gss_unwrap_integ() checks only that the checksum fits
   in gsd->gsd_scratch.

Add a length guard at the top of gss_krb5_verify_mic_v2(), before any
ptr[] access or scatterlist construction.  Well-formed MIC tokens from
gss_krb5_get_mic_v2() already have exactly GSS_KRB5_TOK_HDR_LEN +
cksum_len bytes, so valid traffic is unaffected.

Reported-by: Chris Mason <clm@meta.com>
Fixes: de9c17eb4a91 ("gss_krb5: add support for new token formats in rfc4121")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_unseal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_unseal.c b/net/sunrpc/auth_gss/gss_krb5_unseal.c
index b5fb70419faa..4d12d49434c2 100644
--- a/net/sunrpc/auth_gss/gss_krb5_unseal.c
+++ b/net/sunrpc/auth_gss/gss_krb5_unseal.c
@@ -89,6 +89,9 @@ gss_krb5_verify_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *message_buffer,
 
 	dprintk("RPC:       %s\n", __func__);
 
+	if (read_token->len < GSS_KRB5_TOK_HDR_LEN + cksum_len)
+		return GSS_S_DEFECTIVE_TOKEN;
+
 	memcpy(&be16_ptr, (char *) ptr, 2);
 	if (be16_to_cpu(be16_ptr) != KG2_TOK_MIC)
 		return GSS_S_DEFECTIVE_TOKEN;
-- 
2.54.0


