Return-Path: <linux-nfs+bounces-23265-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SXNVC5TrU2ragAMAu9opvQ
	(envelope-from <linux-nfs+bounces-23265-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 21:31:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA961745C30
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 21:31:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KBoCz+eY;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23265-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23265-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 896E4300B984
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 19:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5481023ABB9;
	Sun, 12 Jul 2026 19:31:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AEB369D45
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jul 2026 19:31:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783884689; cv=none; b=EOPWsmYqm1Q2SyiF2k1i/p0l4GgTc/SpuvIkJxCYO+oZB0aVaPPCJSR2X7kXT+rQKC5jwXl0mckLYL1NKPd2h68u6G3QofBQjftzyeZzADhnU6EfU8GESVFRjgivb6d7ad+wZk86eu0ob3S+uh2Axq2aDCW3S3WZQmlJCb125xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783884689; c=relaxed/simple;
	bh=lngkuuHP5o27dKmFUap3pTm8VOjSH6aaUyr+uw7/xS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EC1MxVbDh6RgymeMe1MEJnEy4KG5ya3LFnfjLXeH2ByB9FpJdmSpo4qQ9Vb28xgxRrZG1Zn8BOuA+jbXlGRVGH1lSZ2mlCJY9tgcvjW+X2tj1jV5F6Y4PRkdG+ajZxvf/bVEvvV6KS83G7iQHsOD4p21BD/VwRoRhUyMun14MI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBoCz+eY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C441F000E9;
	Sun, 12 Jul 2026 19:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783884688;
	bh=fRI7yE9PGulYCXpbCHTnY3p1vuPJ5HpwvVaALNE1Agc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KBoCz+eY5CtGm0IppzybLZnYpdjRFkU/yXtXTEd9zAtpuHMt6aqgntbc8RSIbz9af
	 HFkPUgKUV7JIKkqYrVUUdhjB8JXkdATP0rSZWzMatrqb3GMiyuCGUhNAQoAyPi9wNO
	 +oJ6CD7BROK+PwDlPK2Z1AOJ6K9j3rEel2CUpUpN79SpqEyvwJDD5ShJ8D4bxvTHv4
	 OuRRAWyiQuQAWYlhPd7/1wn67PoHSHMP6wtGbfPTTilBx/Ry2GNZ+KqXwJSy6h5SE5
	 onCXgttb7fR4dYGcyAFxpyvhuNvug+CQh216pJ9tl4OulXfgdAUO9EKwD4JZaBNe2x
	 RNXAOxPr+C/dg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 5/5] xdrgen: Fix opaque and string encoders for unbounded members
Date: Sun, 12 Jul 2026 15:31:22 -0400
Message-ID: <20260712193122.116845-6-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712193122.116845-1-cel@kernel.org>
References: <20260712193122.116845-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23265-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:jlayton@kernel.org,m:okorniev@redhat.com,m:dai.ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA961745C30

The variable-length opaque and string encoder templates emit an
unconditional bound check, "if (value->NAME.len > MAXSIZE) return
false". XDR represents an unbounded specifier (opaque foo<>, string
foo<>) as a maxsize of 0, so for an unbounded member the check
degenerates to "len > 0" and the generated encoder refuses every
non-empty value.

The decoder does not share this defect. It delegates to
xdrgen_decode_opaque() and xdrgen_decode_string(), which treat a
maxlen of 0 as unbounded and skip the length check. The sibling
variable-length array templates already guard their bound check
with maxsize != "0".

Guard the bound check the same way in each affected template -- the
struct and pointer forms of both the opaque and string encoders --
so an unbounded member encodes a payload of any length while a
bounded member keeps its limit.

An explicit zero-length bound (foo<0>) parses to the same maxsize of
0 and so also skips the check; xdrgen does not distinguish it from
the unbounded form, matching the decoder and the array encoders.

Fixes: 4b132aacb076 ("tools: Add xdrgen")
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/string.j2   | 2 ++
 .../templates/C/pointer/encoder/variable_length_opaque.j2       | 2 ++
 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/string.j2    | 2 ++
 .../xdrgen/templates/C/struct/encoder/variable_length_opaque.j2 | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/string.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/string.j2
index cf65b71eaef3..7ddc2bf3edac 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/string.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/string.j2
@@ -2,7 +2,9 @@
 {% if annotate %}
 	/* member {{ name }} (variable-length string) */
 {% endif %}
+{% if maxsize != "0" %}
 	if (value->{{ name }}.len > {{ maxsize }})
 		return false;
+{% endif %}
 	if (xdr_stream_encode_opaque(xdr, value->{{ name }}.data, value->{{ name }}.len) < 0)
 		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_opaque.j2
index 1d477c2d197a..5bf00070ae95 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_opaque.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_opaque.j2
@@ -2,7 +2,9 @@
 {% if annotate %}
 	/* member {{ name }} (variable-length opaque) */
 {% endif %}
+{% if maxsize != "0" %}
 	if (value->{{ name }}.len > {{ maxsize }})
 		return false;
+{% endif %}
 	if (xdr_stream_encode_opaque(xdr, value->{{ name }}.data, value->{{ name }}.len) < 0)
 		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/string.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/string.j2
index cf65b71eaef3..7ddc2bf3edac 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/string.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/string.j2
@@ -2,7 +2,9 @@
 {% if annotate %}
 	/* member {{ name }} (variable-length string) */
 {% endif %}
+{% if maxsize != "0" %}
 	if (value->{{ name }}.len > {{ maxsize }})
 		return false;
+{% endif %}
 	if (xdr_stream_encode_opaque(xdr, value->{{ name }}.data, value->{{ name }}.len) < 0)
 		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_opaque.j2
index 1d477c2d197a..5bf00070ae95 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_opaque.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_opaque.j2
@@ -2,7 +2,9 @@
 {% if annotate %}
 	/* member {{ name }} (variable-length opaque) */
 {% endif %}
+{% if maxsize != "0" %}
 	if (value->{{ name }}.len > {{ maxsize }})
 		return false;
+{% endif %}
 	if (xdr_stream_encode_opaque(xdr, value->{{ name }}.data, value->{{ name }}.len) < 0)
 		return false;
-- 
2.54.0


