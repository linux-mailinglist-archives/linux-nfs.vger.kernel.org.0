Return-Path: <linux-nfs+bounces-22605-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4EBbBDU7MWozegUAu9opvQ
	(envelope-from <linux-nfs+bounces-22605-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:01:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FBB68F0D9
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:01:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hQQf7Vmw;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22605-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22605-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AFD7304B3DA
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 11:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D2043E9FF;
	Tue, 16 Jun 2026 11:59:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D796643DA3F;
	Tue, 16 Jun 2026 11:59:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611153; cv=none; b=S9YogxQy4dTqo5d65JQQRgBIaCcXiye54iWqZuCfQMCmGvwcNfM438liILnm/4gCLYlRCSKSD6qTrwImPypmFNJWtrPrug1AAnG1g/fYq+KM1WmXQPrI7B3QHjNGqByQqkObxaBO3MYNQgZSV6g471nVHPpCtU8kdEEudY2lPzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611153; c=relaxed/simple;
	bh=e+KnnX6s+jXE0T3L0XzYeXF7g7/5iA65qjCst56f6BE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3tSBelX5gcFbRBtdgtZ+k59hof9/L7e0RsJQjy0fufSlg6RjnEai2uUDkmV7ZmVa7GEiaBTEcd2kxkRUclMLt39/Czpko3Z1XGdN/1NBjDugvfcFwgLQDZ4uICkik1fnTJs85WwGJcGtgSYqpBFFKjqLoAyM+mTrGhU2w636iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQQf7Vmw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98581F00ACF;
	Tue, 16 Jun 2026 11:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781611152;
	bh=ZAyjyAzLgCyEiI5ZJ26NF4mFYwz1W3tdSFAVgflbcAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hQQf7Vmwebe77tg2UJeRLMXJFedHhFgeJQk9Lvwa7407j34lr94eC4KpSevGhFPvp
	 4nbFEWr8sbcUa2jTqmh8GHeua8tzz79ayTOSmHCbQbJZYedJcHFyg1pnn9gbYyR9fF
	 dcpm9MtOnGdsyZeE6rlo66w7m/T/Ztsul887DuRvH6HmS0U8LTY9JwtbrwDky4O3Hc
	 aDgiWTz6GConPH6PxPrc5Ul/8kNJkZGqa9qDXsg9VWeF1WPC+K3bE3iWwnI55ECPlp
	 /ky5TAoz2M2KPXceEwnQ5LNYydnsevJ0ccjsGNb9GafCxRMpsOLQI29uXfmtp4tpGi
	 xRlWD1o/Hr0KQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jun 2026 07:58:46 -0400
Subject: [PATCH v7 03/20] nfs_common: add new NOTIFY4_* flags proposed in
 RFC8881bis
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-dir-deleg-v7-3-6cbc7eac0ade@kernel.org>
References: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
In-Reply-To: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Chuck Lever <cel@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3135; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=e+KnnX6s+jXE0T3L0XzYeXF7g7/5iA65qjCst56f6BE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMTqEHYyB98ZFreWh7G82D4JMRdNr+MrnIejql
 wQnmpK3+uqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajE6hAAKCRAADmhBGVaC
 Fe9jEACKa2XxkYwvOLZdys9D0VJoyNuab594EX8Ls7Vn3hZpn4A9xjb4CTS0Gn6J1xjVKzd/zGo
 EVVkWvuAmYh2JntadOUZYOxGn6ChKasn44NJjyyoFE7BmeXMVEyw0vex8vOYc9QdH5NGuA5KVDk
 DjXGf3SVkusf6MvQ+Az6osZdORIFqOpe7o7P4rVB9rCkuWJLy9cm4NfYbsIenNU4ZNEnzpuvSYL
 5ddRAD/SyNGBL2Rgj0P6WHq8lwEGGSBVHz3HZc2Tv6xSiRC97Cq7tZt5ScZwWVjSv00O9Y0T6/A
 2FF+H/n6Ns3m93qKasrYjHPG2jmRJBVuoF1EVNqKoakE7JMToY1YgAI9Fctb1n7y9cflvMi5dIP
 Aq3shg0P9LRNQZh2Rp/CaIJC18VLIiPRW+8gEQZpYklLeJhYTb9zkmIpy6dccR7NAKMKTqYXVPK
 9MVE5mEabEG2PorAw1/zotz4yADKAVZgR2gN3v4qO90iMdt7jYnEQWuyDFWilnOyqplHeEfpL2T
 rDRFPwIPU6Zc0crTs9DRY60wfID1WBRGWV0JT26McvN21YQy9Z093PyiKcoHiBwxby0etorCt1I
 197npH7MrjuvH0f6PJnWWaQi/saLlCYCKpA7WNaki7+rztw7Peva7SAFd2FTRgFkdNRzkLBMep8
 YjB5dF/SS4p1OiQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22605-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38FBB68F0D9

RFC8881bis adds some new flags to GET_DIR_DELEGATION that later patches
will consume. In particular, Linux nfsd can't easily provide info about
directory cookies and ordering. The new flags allow it to omit that
information.

There is some risk here -- RFC8881bis is still a working group document,
and has been for years. The changes to directory delegations have been
stable for the last year or so however, so the hope is that those parts
won't change (much).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/sunrpc/xdr/nfs4_1.x    | 14 +++++++++++++-
 fs/nfsd/nfs4xdr_gen.c                | 11 +++++++++++
 include/linux/sunrpc/xdrgen/nfs4_1.h | 11 +++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/sunrpc/xdr/nfs4_1.x b/Documentation/sunrpc/xdr/nfs4_1.x
index 72d439b71735..4c3842e23859 100644
--- a/Documentation/sunrpc/xdr/nfs4_1.x
+++ b/Documentation/sunrpc/xdr/nfs4_1.x
@@ -413,7 +413,19 @@ enum notify_type4 {
         NOTIFY4_REMOVE_ENTRY = 2,
         NOTIFY4_ADD_ENTRY = 3,
         NOTIFY4_RENAME_ENTRY = 4,
-        NOTIFY4_CHANGE_COOKIE_VERIFIER = 5
+        NOTIFY4_CHANGE_COOKIE_VERIFIER = 5,
+        /* Proposed in RFC8881bis */
+        NOTIFY4_GFLAG_EXTEND = 6,
+        NOTIFY4_AUFLAG_VALID = 7,
+        NOTIFY4_AUFLAG_USER = 8,
+        NOTIFY4_AUFLAG_GROUP = 9,
+        NOTIFY4_AUFLAG_OTHER = 10,
+        NOTIFY4_CHANGE_AUTH = 11,
+        NOTIFY4_CFLAG_ORDER = 12,
+        NOTIFY4_AUFLAG_GANOW = 13,
+        NOTIFY4_AUFLAG_GALATER = 14,
+        NOTIFY4_CHANGE_GA = 15,
+        NOTIFY4_CHANGE_AMASK = 16
 };
 
 /* Changed entry information.  */
diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
index 3a9c82418223..61346d9e6833 100644
--- a/fs/nfsd/nfs4xdr_gen.c
+++ b/fs/nfsd/nfs4xdr_gen.c
@@ -589,6 +589,17 @@ xdrgen_decode_notify_type4(struct xdr_stream *xdr, notify_type4 *ptr)
 	case NOTIFY4_ADD_ENTRY:
 	case NOTIFY4_RENAME_ENTRY:
 	case NOTIFY4_CHANGE_COOKIE_VERIFIER:
+	case NOTIFY4_GFLAG_EXTEND:
+	case NOTIFY4_AUFLAG_VALID:
+	case NOTIFY4_AUFLAG_USER:
+	case NOTIFY4_AUFLAG_GROUP:
+	case NOTIFY4_AUFLAG_OTHER:
+	case NOTIFY4_CHANGE_AUTH:
+	case NOTIFY4_CFLAG_ORDER:
+	case NOTIFY4_AUFLAG_GANOW:
+	case NOTIFY4_AUFLAG_GALATER:
+	case NOTIFY4_CHANGE_GA:
+	case NOTIFY4_CHANGE_AMASK:
 		break;
 	default:
 		return false;
diff --git a/include/linux/sunrpc/xdrgen/nfs4_1.h b/include/linux/sunrpc/xdrgen/nfs4_1.h
index bce993132bc0..356c3da9f4e0 100644
--- a/include/linux/sunrpc/xdrgen/nfs4_1.h
+++ b/include/linux/sunrpc/xdrgen/nfs4_1.h
@@ -376,6 +376,17 @@ enum notify_type4 {
 	NOTIFY4_ADD_ENTRY = 3,
 	NOTIFY4_RENAME_ENTRY = 4,
 	NOTIFY4_CHANGE_COOKIE_VERIFIER = 5,
+	NOTIFY4_GFLAG_EXTEND = 6,
+	NOTIFY4_AUFLAG_VALID = 7,
+	NOTIFY4_AUFLAG_USER = 8,
+	NOTIFY4_AUFLAG_GROUP = 9,
+	NOTIFY4_AUFLAG_OTHER = 10,
+	NOTIFY4_CHANGE_AUTH = 11,
+	NOTIFY4_CFLAG_ORDER = 12,
+	NOTIFY4_AUFLAG_GANOW = 13,
+	NOTIFY4_AUFLAG_GALATER = 14,
+	NOTIFY4_CHANGE_GA = 15,
+	NOTIFY4_CHANGE_AMASK = 16,
 };
 
 typedef enum notify_type4 notify_type4;

-- 
2.54.0


