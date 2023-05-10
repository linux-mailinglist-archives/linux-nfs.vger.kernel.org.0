Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03036FE722
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 00:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjEJWVX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 May 2023 18:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEJWVW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 May 2023 18:21:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F052198
        for <linux-nfs@vger.kernel.org>; Wed, 10 May 2023 15:21:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2F8E421963;
        Wed, 10 May 2023 22:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683757280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FCKZzg/bJaqLwyyS6CbOGVqSeW5TchuAtoflXRC5vxU=;
        b=XWM6tkGDeWff5b31bFmVzTbO5f3aIU/PviH95fEw2KdNYbbgtxEXyUUhC1v1Q5vPR8v/Py
        dnhEt1HdohuGln62s4Wqk75CyraVBzHFlDi3tMUeKLUNz8uxrTj7xSJjRHSVkVWutVbNZT
        xntniausT34S5fbZzFw9GRXWOWURoMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683757280;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FCKZzg/bJaqLwyyS6CbOGVqSeW5TchuAtoflXRC5vxU=;
        b=FZcuyUY8aq9EdXglucaup07i+2RuWcUxeeDDPLEN4N1RXVpmP2xCPafowOmdsp/JFk/cV3
        kCs+vFlU3briNRAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FFBD13519;
        Wed, 10 May 2023 22:21:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c+S0Ld0YXGQnCgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 10 May 2023 22:21:17 +0000
Subject: [PATCH 3/3] Try using a new abstract address when connecting rpcbind
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Steve Dickson <steved@redhat.com>
Date:   Thu, 11 May 2023 08:20:45 +1000
Message-ID: <168375724524.25049.94891375080862707.stgit@noble.brown>
In-Reply-To: <168375715312.25049.2010665843445641504.stgit@noble.brown>
References: <168375715312.25049.2010665843445641504.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

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

This patch chooses the second option, which seems least likely to raise
objections.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 src/rpcb_clnt.c       |   81 +++++++++++++++++++++++++++++++------------------
 tirpc/rpc/rpcb_prot.h |    1 +
 tirpc/rpc/rpcb_prot.x |    1 +
 3 files changed, 53 insertions(+), 30 deletions(-)

diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
index 7acd366a3073..1013d93724e9 100644
--- a/src/rpcb_clnt.c
+++ b/src/rpcb_clnt.c
@@ -532,36 +532,50 @@ local_rpcb(targaddr)
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
 
@@ -742,7 +756,7 @@ got_entry(relp, nconf)
 
 /*
  * Quick check to see if rpcbind is up.  Tries to connect over
- * local transport.
+ * local transport - first abstract, then regular.
  */
 bool_t
 __rpcbind_is_up()
@@ -769,15 +783,22 @@ __rpcbind_is_up()
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


