Return-Path: <linux-nfs+bounces-2074-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77423862DDD
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 00:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5921F2114C
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Feb 2024 23:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA241B96E;
	Sun, 25 Feb 2024 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uYCRzJTB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="joPTJzoW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uYCRzJTB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="joPTJzoW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB231B964
	for <linux-nfs@vger.kernel.org>; Sun, 25 Feb 2024 23:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708904658; cv=none; b=NroKfN0K467stJdLPajRBgZKEyjz86d/T2GHqZOuUlx14h6c6nU7IFK8gtmWptdowRt/MwwPEN8UA+lfhOQWpPvNHKD27W4iylgejtx03YydQcRdm+iXdBGPYwlsr4ENQ5YD2E4yVHtrsgV0lEC+VvLXiJyq/TE0yCp2Q5iZxSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708904658; c=relaxed/simple;
	bh=fTygNOnP+sx3HqtgQokDSEkdeIMqSqRqjn83M0tegO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfOG5p2tPxx/8uQ8XagMdK7M4EAeC8ADRXE2xStqKwLiOt+Everw5m291sFuA3BxK4AfPOQ63XketIT7uGJ0Upc7NdcJUKRGB3WT9nPm3uFlkNDcsQib47HCABzHeK2d6sw1TMXSjrUcgJ9/ChqkCGDU0BZMpiA7VbSzjVspetg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uYCRzJTB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=joPTJzoW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uYCRzJTB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=joPTJzoW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4DCDA22406;
	Sun, 25 Feb 2024 23:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708904654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vo39r89H0izKhQVn+7WXCzz84Khuz9WfpzQwhFbtRU=;
	b=uYCRzJTB7MjfeqIIzLTMKmoBmWdIfxxt7ioz4SVMw9S7H9cMI1wC3ykajPhg8Wx3Gk8jFk
	VYV1WrPJt2sZSEvof4hHLpjdx6dCjiRfhz2m7QeBZJOJU0yaS9WivUd8qYjPzJ7ORaMugR
	3p2e6+yZzgr+b9e5pKocNNKT07Sxuls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708904654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vo39r89H0izKhQVn+7WXCzz84Khuz9WfpzQwhFbtRU=;
	b=joPTJzoWfBZ7LrPZ20WFLVuICl5TsmMO1enUCJqv4ANvoALNMYbH32tnpryzXJ9q9w38el
	Z540l7sYY+IckbAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708904654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vo39r89H0izKhQVn+7WXCzz84Khuz9WfpzQwhFbtRU=;
	b=uYCRzJTB7MjfeqIIzLTMKmoBmWdIfxxt7ioz4SVMw9S7H9cMI1wC3ykajPhg8Wx3Gk8jFk
	VYV1WrPJt2sZSEvof4hHLpjdx6dCjiRfhz2m7QeBZJOJU0yaS9WivUd8qYjPzJ7ORaMugR
	3p2e6+yZzgr+b9e5pKocNNKT07Sxuls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708904654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vo39r89H0izKhQVn+7WXCzz84Khuz9WfpzQwhFbtRU=;
	b=joPTJzoWfBZ7LrPZ20WFLVuICl5TsmMO1enUCJqv4ANvoALNMYbH32tnpryzXJ9q9w38el
	Z540l7sYY+IckbAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1C3C13A89;
	Sun, 25 Feb 2024 23:44:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KB+2FMzQ22VFJAAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 25 Feb 2024 23:44:12 +0000
From: NeilBrown <neilb@suse.de>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org,
	Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 1/3] Allow working with abstract AF_UNIX addresses.
Date: Mon, 26 Feb 2024 10:40:48 +1100
Message-ID: <20240225234337.19744-2-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225234337.19744-1-neilb@suse.de>
References: <20240225234337.19744-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: ****
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
index aabbe4be896c..e649c87198a3 100644
--- a/src/rpc_generic.c
+++ b/src/rpc_generic.c
@@ -650,7 +650,8 @@ __rpc_taddr2uaddr_af(int af, const struct netbuf *nbuf)
 		if (path_len < 0)
 			return NULL;
 
-		if (asprintf(&ret, "%.*s", path_len, sun->sun_path) < 0)
+		if (asprintf(&ret, "%c%.*s", sun->sun_path[0] ?: '\0',
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


