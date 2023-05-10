Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEB36FE720
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 00:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjEJWVQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 May 2023 18:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEJWVO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 May 2023 18:21:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE36A198
        for <linux-nfs@vger.kernel.org>; Wed, 10 May 2023 15:21:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AC27D218EC;
        Wed, 10 May 2023 22:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683757268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A1qL/NZuTZE7wBEwxz7WTGCkTieZioViAK0njBNjWMg=;
        b=RV0JoTOfOTSFh52xnWSHT1HuKyvJJj2JDCl1IsmVOPd3qPmAUzhrnbQYMowcdmJeo/IsrI
        Z8MlsKBUN8masBXYpjEIGW4GqJeTnyfOdYbsiK+KMnh2fSPmRrEq7UV/GVj+qb1f9lD/SG
        BZOXP2tmwMhWuw9GL1rYWgj2rB0W/Jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683757268;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A1qL/NZuTZE7wBEwxz7WTGCkTieZioViAK0njBNjWMg=;
        b=N5c/TpemuhKeBJ5Wso2G6x/zIjGKpj8FlaZvQL+ahq2c7DqGbvL+CJrOuE+qhcjenc5aBb
        uY7QAPWio+4141AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95BF113519;
        Wed, 10 May 2023 22:21:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dTaSE9IYXGQYCgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 10 May 2023 22:21:06 +0000
Subject: [PATCH 1/3] Allow working with abstract AF_UNIX addresses.
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Steve Dickson <steved@redhat.com>
Date:   Thu, 11 May 2023 08:20:45 +1000
Message-ID: <168375724523.25049.3125416093703904461.stgit@noble.brown>
In-Reply-To: <168375715312.25049.2010665843445641504.stgit@noble.brown>
References: <168375715312.25049.2010665843445641504.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Linux supports abstract addresses for AF_UNIX.
These have .sun_path starting with '\0'.
When presented in human-readable form they have a leading '@' instead.
The length of the sockaddr must not include any trailing
zeroes after the abstract name, as they will treated as part of the
name and cause address matching to fail.

This patch makes various changes to code that works with sun_path to
ensure that abstract addresses work correctly.

In particular it fixes a bug in __rpc_sockisbound() which incorrectly
determines that a socket bound to ab abstract address is in fact not
bound.  This prevents sockets with abstract addresses being used even
when created outside of the library.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 src/rpc_com.h     |    6 ++++++
 src/rpc_generic.c |   18 ++++++++++++------
 src/rpc_soc.c     |    6 +++++-
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


