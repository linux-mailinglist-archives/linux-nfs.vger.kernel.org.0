Return-Path: <linux-nfs+bounces-23262-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pIKbBEPsU2r1gAMAu9opvQ
	(envelope-from <linux-nfs+bounces-23262-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 21:34:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD41745C64
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 21:34:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EuxtgkDd;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23262-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23262-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DB893022FBA
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 19:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23E82FFF89;
	Sun, 12 Jul 2026 19:31:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3183B27EF
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jul 2026 19:31:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783884687; cv=none; b=BiCd6XRkN3pz6++ogLuyIO4GHt42fQKAh+t9B/IJqts1hL3ypJhtOQ3/jT8Ha68y+C2l5lMljMHkLAhIZcT5ai1PX575Yf2ishn/UgG8wZ3ox9kNf6JwSuVvx1DpfcVLmQH6QVwaRBcSIx9n6DbEEuCzLY4rvNhPG+RBVzvMw50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783884687; c=relaxed/simple;
	bh=uySJmDDTRi1pwqPtv+CHo5p9Q/4FHoZNvtfKi9S3LTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKuoBzkQQWJRZDHYXsVNbc+x/8JK2PP2TvhhIPdQEqL4YFxOAW4d6IyuwDJh7XOCCkfKPyYppiXHpH4hV1KaBa8syavCwwjn0O/e1FwRHkcUdOmaH4PPDGlOyPhRmCvi6v+lotnegE9WAYfQFMxRx+FgCA9gz/yxn3A/zp4J/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuxtgkDd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3BE1F00A3E;
	Sun, 12 Jul 2026 19:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783884686;
	bh=m58T0TsBQh3XOrAj7DOdWTL9FAXAQ8go6g13U0AcNxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EuxtgkDdZH3zFnubEZZuIjjCO3lnqcPgluQHsJc5T2zzAaCilNJug2hwa3BEVsUFm
	 oeUMrjVJq1ic4alTPbNtPCsulL7hdok41cKb2F2f+3h4QlYXel/RZwcwMo5x6Jg10a
	 UTR4V6+D1YXO0Bh912rbykvVsudH9sI4HQsfPXdAmu8TfsFc73tNRMmVL03P/hjaOM
	 lNcFyktaJWGItNadrFGqD2L8w9maFDiVcynx/yW3qhPjXCnjm+UOYH7r0EeLkFuPRJ
	 d5OIcqF7iNW5Mptjm/lVWoDLRYXT54ZrnZlk6Mjrqisef8SiUZkpt3KBZjZ+L80ZGI
	 pU4v+4YeLAVtw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 3/5] xdrgen: Do not declare union XDR functions in the definitions header
Date: Sun, 12 Jul 2026 15:31:20 -0400
Message-ID: <20260712193122.116845-4-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23262-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3AD41745C64

Unlike the struct, enum, typedef, and pointer templates, the union
definitions template also emits xdrgen_decode_*() and
xdrgen_encode_*() prototypes for a public union into that header.
Those prototypes name struct xdr_stream, which the definitions
header neither includes nor forward-declares, so any translation
unit that includes the definitions header without xdr.h already in
scope draws -Wvisibility warnings. The same public prototypes are
emitted into the declarations header, which does include
<linux/sunrpc/xdr.h>, making the definitions-header copies
redundant.

Drop the prototype emission from the union definitions template so
it matches the other type templates. Public unions keep their
encode and decode prototypes through the declarations header.

Fixes: 4b132aacb076 ("tools: Add xdrgen")
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 .../net/sunrpc/xdrgen/templates/C/union/definition/close.j2 | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/definition/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/definition/close.j2
index 5fc1937ba774..19ee759d70c6 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/union/definition/close.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/definition/close.j2
@@ -1,9 +1,3 @@
 {# SPDX-License-Identifier: GPL-2.0 #}
 	} u;
 };
-{%- if name in public_apis %}
-
-
-bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, struct {{ name }} *ptr);
-bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const struct {{ name }} *ptr);
-{%- endif -%}
-- 
2.54.0


