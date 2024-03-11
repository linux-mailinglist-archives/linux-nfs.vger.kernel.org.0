Return-Path: <linux-nfs+bounces-2254-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D6E877998
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 02:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4141B20F72
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 01:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8D8A47;
	Mon, 11 Mar 2024 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I3Q62an8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IEHdNWs5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I3Q62an8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IEHdNWs5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10884A3F
	for <linux-nfs@vger.kernel.org>; Mon, 11 Mar 2024 01:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121427; cv=none; b=fbdRUTq3KI2iFaHbciQpYic3yAgMMkL9K9G9Iisr3ANaI7SUDdaUTVR3ZdzJsCsFyTo8zF0p+o1p684NluBzXcyyTMQyVW8iMA5Hi1wIWvZtKDYT2bNiHq+zNDnEvBWC031u/imO3S78sc1vYz+FVAJlFACe5qf7oH/C+IyCNvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121427; c=relaxed/simple;
	bh=04++OgeyTQjhMJGzegf+TQQhsXtvH6nUjPpiEvlKpEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rz6i1yIhGs/zwY+nY5lTNrTrS38bvCC+mnqkut+d+G/bvIG9zRSgbEKMyO4TgwVgXsC+DyJEQ6QWnu5kUnol6znlv06D7LwgatwUUfQtIdbzwtuEhFhW6wi55xXLspHBN0hDdhEszFc73GPrM0Rq76h5espNKQ4O0QXblQNAGhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I3Q62an8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IEHdNWs5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I3Q62an8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IEHdNWs5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BD8B346B3;
	Mon, 11 Mar 2024 01:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710121423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sf0asoQDvM+uH1hr7+yzvNtjLodpQrx8XWUyqGyovY=;
	b=I3Q62an8rTYdBaeJq4c1cy66IEZlTPDri/Hcs7niLHVjoCj3t6lMmZ0cjhyANmaGWrC0MG
	bbVsznzvKNptQNliz1SpDiCn/pmqTPnSwV14yVbai21U2WrwE2v4l+o8Gm8gQT3iQG442Q
	1XijIifKq2WfSzaUXxpt6mynLjeHuLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710121423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sf0asoQDvM+uH1hr7+yzvNtjLodpQrx8XWUyqGyovY=;
	b=IEHdNWs5vBxCeKyZVZZ9mgF9D7RlE6e3awxGINgciOrlP0hIK46AhKjGWB8LwuGU7OHEJ3
	pcArWCcvQF1uxbAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710121423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sf0asoQDvM+uH1hr7+yzvNtjLodpQrx8XWUyqGyovY=;
	b=I3Q62an8rTYdBaeJq4c1cy66IEZlTPDri/Hcs7niLHVjoCj3t6lMmZ0cjhyANmaGWrC0MG
	bbVsznzvKNptQNliz1SpDiCn/pmqTPnSwV14yVbai21U2WrwE2v4l+o8Gm8gQT3iQG442Q
	1XijIifKq2WfSzaUXxpt6mynLjeHuLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710121423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sf0asoQDvM+uH1hr7+yzvNtjLodpQrx8XWUyqGyovY=;
	b=IEHdNWs5vBxCeKyZVZZ9mgF9D7RlE6e3awxGINgciOrlP0hIK46AhKjGWB8LwuGU7OHEJ3
	pcArWCcvQF1uxbAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B711134AB;
	Mon, 11 Mar 2024 01:43:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JqMuMM1h7mXxfgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Mar 2024 01:43:41 +0000
From: NeilBrown <neilb@suse.de>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] Allow working with abstract AF_UNIX addresses.
Date: Mon, 11 Mar 2024 12:41:16 +1100
Message-ID: <20240311014327.19692-2-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311014327.19692-1-neilb@suse.de>
References: <20240311014327.19692-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 4.90
X-Spam-Flag: NO

Linux supports abstract addresses for AF_UNIX.
These have .sun_path starting with '\0'.
When presented in human-readable form they have a leading '@' instead.
The length of the sockaddr must not include any trailing
zeroes after the abstract name, as they will treated as part of the
name and cause address matching to fail.

This patch makes various changes to code that works with sun_path to
ensure that abstract addresses work correctly.

In particular it fixes a bug in __rpc_sockisbound() which incorrectly
determines that a socket bound to an abstract address is in fact not
bound.  This prevents sockets with abstract addresses being used even
when created outside of the library.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 src/rpc_com.h     |  6 ++++++
 src/rpc_generic.c | 18 ++++++++++++------
 src/rpc_soc.c     |  6 +++++-
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/src/rpc_com.h b/src/rpc_com.h
index 76badefcfe90..ded72d1a647e 100644
--- a/src/rpc_com.h
+++ b/src/rpc_com.h
@@ -60,6 +60,12 @@ bool_t __xdrrec_getrec(XDR *, enum xprt_stat *, bool_t);
 void __xprt_unregister_unlocked(SVCXPRT *);
 void __xprt_set_raddr(SVCXPRT *, const struct sockaddr_storage *);
 
+/* Evaluate to actual length of the `sockaddr_un' structure, whether
+ * abstract or not.
+ */
+#include <stddef.h>
+#define SUN_LEN_A(ptr) (offsetof(struct sockaddr_un, sun_path)	\
+			+ 1 + strlen((ptr)->sun_path + 1))
 
 extern int __svc_maxrec;
 
diff --git a/src/rpc_generic.c b/src/rpc_generic.c
index aabbe4be896c..ee44c8d6eac4 100644
--- a/src/rpc_generic.c
+++ b/src/rpc_generic.c
@@ -650,7 +650,8 @@ __rpc_taddr2uaddr_af(int af, const struct netbuf *nbuf)
 		if (path_len < 0)
 			return NULL;
 
-		if (asprintf(&ret, "%.*s", path_len, sun->sun_path) < 0)
+		if (asprintf(&ret, "%c%.*s", sun->sun_path[0] ?: '@',
+			     path_len - 1, sun->sun_path + 1) < 0)
 			return (NULL);
 		break;
 	default:
@@ -682,9 +683,10 @@ __rpc_uaddr2taddr_af(int af, const char *uaddr)
 
 	/*
 	 * AF_LOCAL addresses are expected to be absolute
-	 * pathnames, anything else will be AF_INET or AF_INET6.
+	 * pathnames or abstract names, anything else will be
+	 * AF_INET or AF_INET6.
 	 */
-	if (*addrstr != '/') {
+	if (*addrstr != '/' && *addrstr != '@') {
 		p = strrchr(addrstr, '.');
 		if (p == NULL)
 			goto out;
@@ -747,6 +749,9 @@ __rpc_uaddr2taddr_af(int af, const char *uaddr)
 		strncpy(sun->sun_path, addrstr, sizeof(sun->sun_path) - 1);
 		ret->len = SUN_LEN(sun);
 		ret->maxlen = sizeof(struct sockaddr_un);
+		if (sun->sun_path[0] == '@')
+			/* Abstract address */
+			sun->sun_path[0] = '\0';
 		ret->buf = sun;
 		break;
 	default:
@@ -834,6 +839,7 @@ __rpc_sockisbound(int fd)
 		struct sockaddr_un  usin;
 	} u_addr;
 	socklen_t slen;
+	int path_len;
 
 	slen = sizeof (struct sockaddr_storage);
 	if (getsockname(fd, (struct sockaddr *)(void *)&ss, &slen) < 0)
@@ -849,9 +855,9 @@ __rpc_sockisbound(int fd)
 			return (u_addr.sin6.sin6_port != 0);
 #endif
 		case AF_LOCAL:
-			/* XXX check this */
-			memcpy(&u_addr.usin, &ss, sizeof(u_addr.usin)); 
-			return (u_addr.usin.sun_path[0] != 0);
+			memcpy(&u_addr.usin, &ss, sizeof(u_addr.usin));
+			path_len = slen - offsetof(struct sockaddr_un, sun_path);
+			return path_len > 0;
 		default:
 			break;
 	}
diff --git a/src/rpc_soc.c b/src/rpc_soc.c
index fde121db75cf..c6c93b50337d 100644
--- a/src/rpc_soc.c
+++ b/src/rpc_soc.c
@@ -701,7 +701,11 @@ svcunix_create(sock, sendsize, recvsize, path)
 	memset(&sun, 0, sizeof sun);
 	sun.sun_family = AF_LOCAL;
 	strncpy(sun.sun_path, path, (sizeof(sun.sun_path)-1));
-	addrlen = sizeof(struct sockaddr_un);
+	if (sun.sun_path[0] == '@')
+		/* abstract address */
+		sun.sun_path[0] = '\0';
+
+	addrlen = SUN_LEN_A(&sun);
 	sa = (struct sockaddr *)&sun;
 
 	if (bind(sock, sa, addrlen) < 0)
-- 
2.43.0


