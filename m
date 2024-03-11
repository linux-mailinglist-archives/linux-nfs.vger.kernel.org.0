Return-Path: <linux-nfs+bounces-2256-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF6B87799A
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 02:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA4B1C212D5
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 01:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A802310F1;
	Mon, 11 Mar 2024 01:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zWytLS2n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nG0IFx6C";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UqnTloaJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sk4vjawy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77AD10E9
	for <linux-nfs@vger.kernel.org>; Mon, 11 Mar 2024 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121437; cv=none; b=ukURlOHYf6k1lytvMXHBPnSaIY+m2depO/GcvM4lesTfLQGkFKk8U5bK1nFGJXIyg/7QEEwEXA5h6ANiBbqBdja0YwxnGZZbtXermNCffW86Ox+M9+D2Lkq8pNJOwUar54B5JdZfiUozd3pWSraUlX2mvpUOsayNKFrSJyd08jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121437; c=relaxed/simple;
	bh=0KIon+veWRKvkd+IRRdLL4kkrGjZVSvtIRXjksxdNdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQyusoCsyTaAMBrYI84jLmrNK63Pbhz8WRmhHx49Kj0W+8Q1arvsag8ifMgrw7kl1YJYIFwlbDuM7W5KnfiK2RbwlOtfj72mppMjuZc4sqXcYSqDLwXipia4yETybLnW0zWswjQRWiyoJb6LVdcyReUd0azmbM0iB7dr4n0i8CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zWytLS2n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nG0IFx6C; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UqnTloaJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sk4vjawy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F03B75C04E;
	Mon, 11 Mar 2024 01:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710121434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vf9NiwZ5jWIpnjSyWuhrJRDKjG1GG4UfHlAcd9pdBuw=;
	b=zWytLS2nbbmGdJbX/Ri2wWepFxEASasroOlqactan7CrlfnHADXBacb0UJRrhfgcUpxlgY
	5boEiya8j81gqOM9t22J4AfsJ17SbXjHmEqnU2zet2jOY/oceidj7ADKURATCO5sYzs6y6
	yQN+9CzZZxtFNoIIbSKpuEVMev/IsN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710121434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vf9NiwZ5jWIpnjSyWuhrJRDKjG1GG4UfHlAcd9pdBuw=;
	b=nG0IFx6C9qhwBshMJGHG44Wy3q9Tyr0KXk3+/nX2zSgLZsTzfVW+jTIFXlA0/syUXNIkhr
	370LxppxUxt74+Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710121433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vf9NiwZ5jWIpnjSyWuhrJRDKjG1GG4UfHlAcd9pdBuw=;
	b=UqnTloaJUU53V5CcKMEkF5NdxWr0E0Ph1dX+Og9BgtHhxqEcKheoVAyvl1Sz2E9FpQwWhW
	HHAihJg51JqjWjTOlA1CJ7p3aZ7dU6tvj4soADo96E2egWDmAVqSRDH+xTbDgXH8GjDJWj
	ol5fEJ3lQjALhSmUjKhm/ap2rcNnhT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710121433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vf9NiwZ5jWIpnjSyWuhrJRDKjG1GG4UfHlAcd9pdBuw=;
	b=sk4vjawycMX69T/KsEez93rnIT97K2ce4leyFGDBtS5wYabIyFfi3sAx7u5M7OwzwjodRS
	7gqPmEOULx+lPGCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFA86134AB;
	Mon, 11 Mar 2024 01:43:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5bu2HNhh7mX/fgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Mar 2024 01:43:52 +0000
From: NeilBrown <neilb@suse.de>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] Try using a new abstract address when connecting to rpcbind
Date: Mon, 11 Mar 2024 12:41:18 +1100
Message-ID: <20240311014327.19692-4-neilb@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
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
 src/rpcb_clnt.c       | 79 +++++++++++++++++++++++++++----------------
 tirpc/rpc/rpcb_prot.h |  1 +
 tirpc/rpc/rpcb_prot.x |  1 +
 3 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
index 2ed6ee65f8d6..6e7c3a0d008f 100644
--- a/src/rpcb_clnt.c
+++ b/src/rpcb_clnt.c
@@ -547,37 +547,51 @@ local_rpcb(targaddr)
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
 
-	if (client != NULL) {
-		/* Mark the socket to be closed in destructor */
-		(void) CLNT_CONTROL(client, CLSET_FD_CLOSE, NULL);
-		if (targaddr)
-			*targaddr = strdup(sun.sun_path);
-		return client;
+		/* Nobody needs this socket anymore; free the descriptor. */
+		close(sock);
 	}
 
-	/* Nobody needs this socket anymore; free the descriptor. */
-	close(sock);
-
 try_nconf:
 
 /* VARIABLES PROTECTED BY loopnconf_lock: loopnconf */
@@ -766,7 +780,7 @@ got_entry(relp, nconf)
 
 /*
  * Quick check to see if rpcbind is up.  Tries to connect over
- * local transport.
+ * local transport - first abstract, then regular.
  */
 bool_t
 __rpcbind_is_up()
@@ -793,15 +807,22 @@ __rpcbind_is_up()
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


