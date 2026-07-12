Return-Path: <linux-nfs+bounces-23267-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ciP8OX/6U2ouggMAu9opvQ
	(envelope-from <linux-nfs+bounces-23267-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:35:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEA5745D95
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:35:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=a4fvLukz;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23267-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23267-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AFF730041D1
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 20:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0AE370AED;
	Sun, 12 Jul 2026 20:35:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E293B4417
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jul 2026 20:34:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783888499; cv=none; b=IqwvH6P5t8DFFSv+8h1DVnA41DJtQJykaOpvDwH5ng8rWH3x+hmVALFLNShaYi34VZZMwJR6B17y5y2rqKIkd3sJ5/CX4IgKjTDAWjklt2u1sMG5dsrybnEmZdJHsZXX/DJoBsGD26mYuX2+87SFY797q7rVAPAZhI7cQqbBDjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783888499; c=relaxed/simple;
	bh=XCPjDoAiuoS0+LP0EB6C+ExWClbU07AvQEoQiI5Q+yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XV5JA7/aFAZg+G6qbvUYWtjujJusbc6U1cveUQFeB9m5OvmMSV4/xUuwYSP23ME3Nw5det6sm/PNa37+Vp6TOjr2xHBzPcu5R7KrAWHy3bCJy1UuLy4qkWMv7d+UxDzJHvxb1UyPHijlw006Gg4ci99Ec3AotTUJlSjWQvmVenQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4fvLukz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1814A1F000E9;
	Sun, 12 Jul 2026 20:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783888493;
	bh=BBsuhEDSs7hVBvNSptbyIvtN/GwPGlxfC6FWLIRAtSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a4fvLukzPRh53S8IgQfc9noK4egw7M6Myn+G1SmjBTb15gwkiqB9gRvu5MC+2w2ho
	 iFNFm7DOVS+vSB6B+fWjqCE1/FUHP7iAkcN6E57bl9SsFL5jLfqDShEiCoCwMUwd8r
	 EIr+kNvbYcNkGA+sNwo90NhFjlSrO1FMHRSuw9M3aj3vXljpfchAPYQkuUxcptXzyB
	 q09NrsDMcbm2GLyrGBVFigBcAvCOvtijMCLuLHt5pYmXa2jMiWMo4ld7G4iBTAMaLm
	 PjvO4CSJpTc65sF3gJ/DH0JVXUuccJjAE3uEADKYVdg3OGmGWx7Pam40qUOsDswxU7
	 JcLKrm4yVupqA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/5] xdrgen: Align the error caret under tab-indented source
Date: Sun, 12 Jul 2026 16:34:47 -0400
Message-ID: <20260712203451.124902-2-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712203451.124902-1-cel@kernel.org>
References: <20260712203451.124902-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23267-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7AEA5745D95

When xdrgen reports a parse or transform error, it prints the
offending source line followed by a caret marking the column. The
source line is emitted with its tab characters intact, but the caret
offset is computed from a tab-expanded copy of the text ahead of the
column. A terminal expands the line's leading tabs relative to the
four-space output indent, while the caret math expands the same tabs
from column zero, so the two disagree whenever the line is indented
with tabs and the caret lands past the token it should mark.

Render the displayed line with its tabs already expanded so the line
and the caret share one tab origin and the four-space indent cancels.
Fold the now-identical line-and-caret formatting out of both error
handlers into a single helper, so every caller reports the same
aligned output.

Signed-off-by: Chuck Lever <cel@kernel.org>
---
 tools/net/sunrpc/xdrgen/xdr_parse.py | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/net/sunrpc/xdrgen/xdr_parse.py b/tools/net/sunrpc/xdrgen/xdr_parse.py
index 241e96c1fdd9..3e76717d2f85 100644
--- a/tools/net/sunrpc/xdrgen/xdr_parse.py
+++ b/tools/net/sunrpc/xdrgen/xdr_parse.py
@@ -63,6 +63,22 @@ def get_xdr_enum_validation() -> bool:
     return enum_validation
 
 
+def format_source_caret(line_text: str, column: int) -> list[str]:
+    """Render an offending source line with a caret beneath a column.
+
+    Args:
+        line_text: The raw source line containing the error
+        column: 1-based column of the offending token within line_text
+
+    Returns:
+        Output lines for the diagnostic: a blank separator, the source
+        line with tabs expanded, and a caret aligned under the column.
+    """
+    expanded = line_text.expandtabs()
+    caret = len(line_text[: column - 1].expandtabs())
+    return ["", f"    {expanded}", f"    {' ' * caret}^"]
+
+
 def make_error_handler(source: str, filename: str) -> Callable[[UnexpectedInput], bool]:
     """Create an error handler that reports the first parse error and aborts.
 
@@ -110,10 +126,7 @@ def make_error_handler(source: str, filename: str) -> Callable[[UnexpectedInput]
             msg_parts.append(str(e).split("\n")[0])
 
         # Show the offending line with a caret pointing to the error
-        msg_parts.append("")
-        msg_parts.append(f"    {line_text}")
-        prefix = line_text[: column - 1].expandtabs()
-        msg_parts.append(f"    {' ' * len(prefix)}^")
+        msg_parts.extend(format_source_caret(line_text, column))
 
         sys.stderr.write("\n".join(msg_parts) + "\n")
         raise XdrParseError()
@@ -151,10 +164,7 @@ def handle_transform_error(e: VisitError, source: str, filename: str) -> None:
 
     # Show the offending line with a caret pointing to the error
     if line_text:
-        msg_parts.append("")
-        msg_parts.append(f"    {line_text}")
-        prefix = line_text[: column - 1].expandtabs()
-        msg_parts.append(f"    {' ' * len(prefix)}^")
+        msg_parts.extend(format_source_caret(line_text, column))
 
     sys.stderr.write("\n".join(msg_parts) + "\n")
 
-- 
2.54.0


