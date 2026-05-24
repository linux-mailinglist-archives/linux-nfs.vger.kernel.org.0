Return-Path: <linux-nfs+bounces-21895-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7JW5NB5OEmq3xgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21895-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 24 May 2026 03:02:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 825105C0FFA
	for <lists+linux-nfs@lfdr.de>; Sun, 24 May 2026 03:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2721300D621
	for <lists+linux-nfs@lfdr.de>; Sun, 24 May 2026 01:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8079A1E1DF0;
	Sun, 24 May 2026 01:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANi4klcc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B97F2E413
	for <linux-nfs@vger.kernel.org>; Sun, 24 May 2026 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779584538; cv=none; b=qNmejJL4vtdLwfr+ov0hq0BfR1Vmbme6HU+PqXObzBvs4VbUHkV2DAOUuOIWLQIhc1ssN/jpekf3yymTVT8y5ESU5nxyVd8lIA9sWyNl/zx5ur3G8jHRXjjnQd67uhdZmgh/r8nezPt1KLlF1AQDXoxu2MLWLHjz1sD9ZYxzDf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779584538; c=relaxed/simple;
	bh=FDja62qw8bkI4CPImoD/etC1XjkiEcyv8eEKKEYaMg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Elg2eSZ76k7frIEbdojpqu4Y+ZDVypsUZQ/Ur/I4t71XEXHmP63IJCYeMGsK7rRcOAlZy8jGxQFnspKjx6KUK6TpYjrxTWOCM+41JnDFTx1swTISVNtXYYEmoZIrgOFGeFYaA/qmNhwvaOZXS7Wp9HMq7YNxeXBV4YfCPzE5REo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANi4klcc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF1A1F00A3C;
	Sun, 24 May 2026 01:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779584537;
	bh=SXz6vGnO0sovCOMh8rPvoswISDScH1ca7oeC2gQdrPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ANi4klcc8BKUUGIGZ3tM08GSANOHsMpKeZdZY+nAk358B285zZ7JGgk99VhmGAX60
	 jxPcrceWGGT1aPplycccGTKcRvkkQqngTL5fVCQuX5sQ2XAdB4G/wBYbmQ8TJJ9uwZ
	 dWs0onUdFL7XorFeTmvOpzQEUb59QK9ijOZUKY32vsIT8P4Gs2dDuKSUXStlTzBcv1
	 3VpERxqeASGI9HLOettzZutkzPk4bdVgEyHUSSHn47ac2rhhWiQc5AzbFPJ+rxJ732
	 qRBwpj/ZY7Dz4EQrUm6HO5BYqmDhcmg9iTgDBx5JlMnLEIUJmnlFJoxgmi4u3c6obm
	 +yyBsVfAgM3Ag==
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
Subject: [PATCH 1/4] SUNRPC: svcauth_gss: enforce krb5 token minimum length
Date: Sat, 23 May 2026 21:02:10 -0400
Message-ID: <20260524010213.557424-2-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21895-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email,meta.com:email]
X-Rspamd-Queue-Id: 825105C0FFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

svcauth_gss_unwrap_priv() validates only an upper bound on the
wire-supplied opaque length before handing the buffer to
gss_unwrap():

    if (len > xdr_stream_remaining(xdr))
            goto unwrap_failed;
    offset = xdr_stream_pos(xdr);
    ...
    maj_stat = gss_unwrap(ctx, offset, offset + len, buf);

The wire value `len` flows unchanged as the upper bound into the
krb5 unwrap path, so a len in [0, 16] passes this check and is
handed to gss_unwrap(). For a krb5 v2 context that lands in
gss_krb5_unwrap_v2(), which reads the 16-byte RFC 4121 token
header fields at ptr+4 and ptr+6 and then calls rotate_left()
before any integrity check. With a sub-header length the header
reads run past the token, and _rotate_left()'s `shift %= buf->len`
path can divide by zero when buf->len has been driven to zero by
the truncated token. A header-only token (len == 16) is equally
invalid: with a non-zero RRC field and the opaque blob ending at
the XDR buffer boundary, rotate_left() builds a zero-length
subbuffer, reaching the same division.

Reject the token at the server entry point before it reaches the
krb5 unwrap core. A valid sealed RFC 4121 token must contain
the 16-byte header plus at least some encrypted payload.

Fix by adding a minimum-length check immediately after the
existing upper-bound check:

    if (len <= GSS_KRB5_TOK_HDR_LEN)
            goto unwrap_failed;

Fixes: 7c9fdcfb1b64 ("[PATCH] knfsd: svcrpc: gss: server-side implementation of rpcsec_gss privacy")
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index d14209031e18..8e8aceb31270 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -949,6 +949,8 @@ svcauth_gss_unwrap_priv(struct svc_rqst *rqstp, u32 seq, struct gss_ctx *ctx)
 	}
 	if (len > xdr_stream_remaining(xdr))
 		goto unwrap_failed;
+	if (len <= GSS_KRB5_TOK_HDR_LEN)
+		goto unwrap_failed;
 	offset = xdr_stream_pos(xdr);
 
 	saved_len = buf->len;
-- 
2.54.0


