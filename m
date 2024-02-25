Return-Path: <linux-nfs+bounces-2076-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B775862DDF
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 00:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5581F21CE4
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Feb 2024 23:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8035E1BC36;
	Sun, 25 Feb 2024 23:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MZcaasle";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZO1kbGEu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MZcaasle";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZO1kbGEu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD941B964
	for <linux-nfs@vger.kernel.org>; Sun, 25 Feb 2024 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708904673; cv=none; b=H51X6fxcfeWL6tnYsRzpWq++i7gH4lG7fzvGIR1MuI7J/geDiIoW55/GTWa8YCYQGmo9o+q7ni7eWD+JUZdyvkFz3vTk43vvbaEzc4vWzJnhQUhCnXg3p7OPPkH5VLV65hz4sPqbfv8Poq+TXSpsXjL+RsdmnipbFOOLHsi0lDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708904673; c=relaxed/simple;
	bh=8Jfzt1gjxLeEyofHP08capBdUH/qR2L1TLCB+pB7bPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQvYGEx1KpdARL2ukdX377Hd9XEMgP2tJXZuv038W6YJJWlWnbfseCe3ttWRuIxhD0ahl6dWFg+wqVKnwbBDV5KZABjloqgx1NmL8o9IL+US/1pGdu7abWTTLK2Fbsm2sT5E4P6gxwZN0WorBpLxA8wA4Trl7B6x/QzLSNE8FpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MZcaasle; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZO1kbGEu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MZcaasle; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZO1kbGEu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ACA592247F;
	Sun, 25 Feb 2024 23:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708904669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLr6tWchbViQPygQ2MIiNWuGd24BFOb6YbQbL2TU+rw=;
	b=MZcaasleCOs6R3vWdEm+NKqQ3qrCTXqP6FMGzVqbFlUYvwQAzXmbpSHYhQkPAWRdEM42F2
	TsWA6ILzMDwU68FZoItWXxRLoYBg5A+kW7761FOH3aIxWrfAw6Fj+/O79gTHhZJF513Hna
	n+DpbfCECe+U+1XSa5QTgrESqp6WBUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708904669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLr6tWchbViQPygQ2MIiNWuGd24BFOb6YbQbL2TU+rw=;
	b=ZO1kbGEu7/izLG9Y81IcLGp5WoEZZ6K4xe59GCMyWdW0HBy/cK08gd/7Rjncrg6iSvy7D2
	3bKGm0Ipk8OT5PBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708904669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLr6tWchbViQPygQ2MIiNWuGd24BFOb6YbQbL2TU+rw=;
	b=MZcaasleCOs6R3vWdEm+NKqQ3qrCTXqP6FMGzVqbFlUYvwQAzXmbpSHYhQkPAWRdEM42F2
	TsWA6ILzMDwU68FZoItWXxRLoYBg5A+kW7761FOH3aIxWrfAw6Fj+/O79gTHhZJF513Hna
	n+DpbfCECe+U+1XSa5QTgrESqp6WBUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708904669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLr6tWchbViQPygQ2MIiNWuGd24BFOb6YbQbL2TU+rw=;
	b=ZO1kbGEu7/izLG9Y81IcLGp5WoEZZ6K4xe59GCMyWdW0HBy/cK08gd/7Rjncrg6iSvy7D2
	3bKGm0Ipk8OT5PBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 324EF13A89;
	Sun, 25 Feb 2024 23:44:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gi/yMdvQ22VQJAAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 25 Feb 2024 23:44:27 +0000
From: NeilBrown <neilb@suse.de>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org,
	Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 3/3] Try using a new abstract address when connecting rpcbind
Date: Mon, 26 Feb 2024 10:40:50 +1100
Message-ID: <20240225234337.19744-4-neilb@suse.de>
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
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MZcaasle;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZO1kbGEu
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: ACA592247F
X-Spam-Flag: NO

As RPC services are network services, it can make sense to localise
them in a network namespace on Linux.  Unfortunately the use of a path
name - /var/run/rpcbind.sock - to contact rpcbind makes that difficult
and requires a mount namespace to be created as well.

Linux supports abstract addresses for AF_UNIX sockets.  These start with
a nul byte and (by convention) no other nul bytes with the length
specified by the addrlen.  Abstract addresses are matched by byte
comparison without reference to the filesystem, and are local to the
network namespace in which are used.  Using an abstract address for
contacting rpcbind removes the need for a mount namespace.

Back comparability is assured by attempting to connect to the existing
well known address (/var/run/rpcbind.sock) if the abstract address
cannot be reached.

Choosing the name needs some care as the same address will be configured
for rpcbind, and needs to be built in to libtirpc for this enhancement
to be fully successful.  There is no formal standard for choosing
abstract addresses.  The defacto standard appears to be to use a path
name similar to what would be used for a filesystem AF_UNIX address -
but with a leading nul.

In that case
   "\0/var/run/rpcbind.sock"
seems like the best choice.  However at this time /var/run is deprecated
in favour of /run, so
   "\0/run/rpcbind.sock"
might be better.
Though as we are deliberately moving away from using the filesystem it
might seem more sensible to explicitly break the connection and just
have
   "\0rpcbind.socket"
using the same name as the systemd unit file..

The linux kernel already attempts to connect to the second option,
"\0/run/rpcbind.sock" since Linux v6.5 so this patch chooses that
option.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 src/rpcb_clnt.c       | 81 +++++++++++++++++++++++++++----------------
 tirpc/rpc/rpcb_prot.h |  1 +
 tirpc/rpc/rpcb_prot.x |  1 +
 3 files changed, 53 insertions(+), 30 deletions(-)

diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
index f587580228ab..5ddd81a08863 100644
--- a/src/rpcb_clnt.c
+++ b/src/rpcb_clnt.c
@@ -545,36 +545,50 @@ local_rpcb(targaddr)
 	size_t tsize;
 	struct netbuf nbuf;
 	struct sockaddr_un sun;
+	int i;
 
 	/*
 	 * Try connecting to the local rpcbind through a local socket
-	 * first. If this doesn't work, try all transports defined in
-	 * the netconfig file.
+	 * first - trying both addresses. If this doesn't work, try all
+	 * non-local transports defined in the netconfig file.
 	 */
-	memset(&sun, 0, sizeof sun);
-	sock = socket(AF_LOCAL, SOCK_STREAM, 0);
-	if (sock < 0)
-		goto try_nconf;
-	sun.sun_family = AF_LOCAL;
-	strcpy(sun.sun_path, _PATH_RPCBINDSOCK);
-	nbuf.len = SUN_LEN(&sun);
-	nbuf.maxlen = sizeof (struct sockaddr_un);
-	nbuf.buf = &sun;
-
-	tsize = __rpc_get_t_size(AF_LOCAL, 0, 0);
-	client = clnt_vc_create(sock, &nbuf, (rpcprog_t)RPCBPROG,
-	    (rpcvers_t)RPCBVERS, tsize, tsize);
-
-	if (client != NULL) {
-		/* Mark the socket to be closed in destructor */
-		(void) CLNT_CONTROL(client, CLSET_FD_CLOSE, NULL);
-		if (targaddr)
-			*targaddr = strdup(sun.sun_path);
-		return client;
-	}
+	for (i = 0; i < 2; i++) {
+		memset(&sun, 0, sizeof sun);
+		sock = socket(AF_LOCAL, SOCK_STREAM, 0);
+		if (sock < 0)
+			goto try_nconf;
+		sun.sun_family = AF_LOCAL;
+		switch (i) {
+		case 0:
+			memcpy(sun.sun_path, _PATH_RPCBINDSOCK_ABSTRACT,
+			       sizeof(_PATH_RPCBINDSOCK_ABSTRACT));
+			break;
+		case 1:
+			strcpy(sun.sun_path, _PATH_RPCBINDSOCK);
+			break;
+		}
+		nbuf.len = SUN_LEN_A(&sun);
+		nbuf.maxlen = sizeof (struct sockaddr_un);
+		nbuf.buf = &sun;
+
+		tsize = __rpc_get_t_size(AF_LOCAL, 0, 0);
+		client = clnt_vc_create(sock, &nbuf, (rpcprog_t)RPCBPROG,
+					(rpcvers_t)RPCBVERS, tsize, tsize);
+
+		if (client != NULL) {
+			/* Mark the socket to be closed in destructor */
+			(void) CLNT_CONTROL(client, CLSET_FD_CLOSE, NULL);
+			if (targaddr) {
+				if (sun.sun_path[0] == 0)
+					sun.sun_path[0] = '@';
+				*targaddr = strdup(sun.sun_path);
+			}
+			return client;
+		}
 
-	/* Nobody needs this socket anymore; free the descriptor. */
-	close(sock);
+		/* Nobody needs this socket anymore; free the descriptor. */
+		close(sock);
+	}
 
 try_nconf:
 
@@ -755,7 +769,7 @@ got_entry(relp, nconf)
 
 /*
  * Quick check to see if rpcbind is up.  Tries to connect over
- * local transport.
+ * local transport - first abstract, then regular.
  */
 bool_t
 __rpcbind_is_up()
@@ -782,15 +796,22 @@ __rpcbind_is_up()
 	if (sock < 0)
 		return (FALSE);
 	sun.sun_family = AF_LOCAL;
-	strncpy(sun.sun_path, _PATH_RPCBINDSOCK, sizeof(sun.sun_path));
 
-	if (connect(sock, (struct sockaddr *)&sun, sizeof(sun)) < 0) {
+	memcpy(sun.sun_path, _PATH_RPCBINDSOCK_ABSTRACT,
+	       sizeof(_PATH_RPCBINDSOCK_ABSTRACT));
+	if (connect(sock, (struct sockaddr *)&sun, SUN_LEN_A(&sun)) == 0) {
 		close(sock);
-		return (FALSE);
+		return (TRUE);
+	}
+
+	strncpy(sun.sun_path, _PATH_RPCBINDSOCK, sizeof(sun.sun_path));
+	if (connect(sock, (struct sockaddr *)&sun, sizeof(sun)) == 0) {
+		close(sock);
+		return (TRUE);
 	}
 
 	close(sock);
-	return (TRUE);
+	return (FALSE);
 }
 #endif
 
diff --git a/tirpc/rpc/rpcb_prot.h b/tirpc/rpc/rpcb_prot.h
index 7ae48b805370..eb3a0c47f66a 100644
--- a/tirpc/rpc/rpcb_prot.h
+++ b/tirpc/rpc/rpcb_prot.h
@@ -477,6 +477,7 @@ extern bool_t xdr_netbuf(XDR *, struct netbuf *);
 #define RPCBVERS_4 RPCBVERS4
 
 #define _PATH_RPCBINDSOCK "/var/run/rpcbind.sock"
+#define _PATH_RPCBINDSOCK_ABSTRACT "\0/run/rpcbind.sock"
 
 #else /* ndef _KERNEL */
 #ifdef __cplusplus
diff --git a/tirpc/rpc/rpcb_prot.x b/tirpc/rpc/rpcb_prot.x
index b21ac3d535f6..472c11ffedd6 100644
--- a/tirpc/rpc/rpcb_prot.x
+++ b/tirpc/rpc/rpcb_prot.x
@@ -411,6 +411,7 @@ program RPCBPROG {
 %#define	RPCBVERS_4		RPCBVERS4
 %
 %#define	_PATH_RPCBINDSOCK	"/var/run/rpcbind.sock"
+%#define	_PATH_RPCBINDSOCK_ABSTRACT "\0/run/rpcbind.sock"
 %
 %#else		/* ndef _KERNEL */
 %#ifdef __cplusplus
-- 
2.43.0


