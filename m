Return-Path: <linux-nfs+bounces-23264-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mXKTMJLrU2rZgAMAu9opvQ
	(envelope-from <linux-nfs+bounces-23264-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 21:31:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC97745C2D
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 21:31:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kYUFaKOo;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23264-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23264-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D893A300D6A0
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 19:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A397E30B502;
	Sun, 12 Jul 2026 19:31:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA92475CB
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jul 2026 19:31:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783884688; cv=none; b=TYDoPznb7PrVjXtjz3suOLDcYIrnrd/syGHgo6T8dKYG+KTbEgNlmkJt7krlv+wIwp/QWv9tfhVprYJaL+2wrUskuHDoeJzrCreAtBWAa6bfKnYESFMEdWauQ/fCzg/PZm2R0zEUwlyWOCXH1gZsaAOMQpWWMSWZrxyySWSVC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783884688; c=relaxed/simple;
	bh=y0UzX9qyPwfd/tjGCP1WHd8VoypPhcGmA0ohJOjzQMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSXCA0kKjq+hO22710/3Tev+/h42Eb3JB8QcNkmv4/aYd+kIqaz7JP6JFxeeNYpYRx4T5xL4JOy+yb9tWL6DL7X/0F0vdvCOjhyPF7KvA48ZMDmYK0026o6jR/2BdOBtc5D4kg1gHSd4R4E2G57z5uQlWuEXA9aa5QqOsB7zVNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYUFaKOo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD06F1F00A3D;
	Sun, 12 Jul 2026 19:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783884687;
	bh=wzWc7RY+DyoMJLQ8qg5ERujVxs9rQ62rjDj9W/Ftg/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kYUFaKOo+/J9kMTcp4aLpFoPDxsOeFauHKc9y/MgDPmZVjv3j834+OVE0frQFo8eo
	 HKARbKb3tOGLvJ87c9S25Pc/HBft0leSo/ASw3+Fh91sboXjTG28ec3gcxdhMm4YXW
	 ehm8e/p7YhqmFgG6ROsBY5Attmw4BJ754s+4cdxiElpu9JMHkc/GbX3mWVTC/hBA1m
	 UBLhMNlCNof7N0ahKg0dKxpwtdZ3utE3Ut50f3bq4UuaOyGp5K7AHUCF5kVaQjci/J
	 FhAdWNY8IX/KddcK2jTf20ZYEo25pCPfHNAGZah8fTfZ1cXqJ3xyaMXIIYb83Gl9YI
	 lNTve8A3XBrmA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 4/5] xdrgen: Add XDR width macros for short integer types
Date: Sun, 12 Jul 2026 15:31:21 -0400
Message-ID: <20260712193122.116845-5-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-23264-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 2EC97745C2D

Commit ae78eb497868 ("xdrgen: Implement short (16-bit) integer
types") taught the generator to emit XDR_short and
XDR_unsigned_short in the computed maxsize macros and added the
matching encode and decode primitives to _builtins.h, but it left
the two width macros themselves undefined in _defs.h.

Define XDR_short and XDR_unsigned_short, each one XDR unit wide, to
match the width the generator's maxsize table assigns them.

Fixes: ae78eb497868 ("xdrgen: Implement short (16-bit) integer types")
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 include/linux/sunrpc/xdrgen/_defs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/sunrpc/xdrgen/_defs.h b/include/linux/sunrpc/xdrgen/_defs.h
index 20c7270aa64d..8f3776ef3229 100644
--- a/include/linux/sunrpc/xdrgen/_defs.h
+++ b/include/linux/sunrpc/xdrgen/_defs.h
@@ -25,6 +25,8 @@ typedef struct {
 
 #define XDR_void		(0)
 #define XDR_bool		(1)
+#define XDR_short		(1)
+#define XDR_unsigned_short	(1)
 #define XDR_int			(1)
 #define XDR_unsigned_int	(1)
 #define XDR_long		(1)
-- 
2.54.0


