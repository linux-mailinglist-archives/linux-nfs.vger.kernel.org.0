Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FFB6FE6FD
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 00:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbjEJWIX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 May 2023 18:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbjEJWIP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 May 2023 18:08:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C103A93
        for <linux-nfs@vger.kernel.org>; Wed, 10 May 2023 15:08:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 53D941FD6B;
        Wed, 10 May 2023 22:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683756489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WdJAnD5vm2Rp1czJeCnrRDV8GmsYmpWf7CQith3fNbU=;
        b=gI2at4NdtxhM9AuGljoP34dMaFSZ+WcpW8sG5MbVV5a/3owdq+EZUYsRLOi5hlRYIPj5R4
        CqzgyaVN13qnIbcCxjK4m0ZTYyo0lWIuY7TDGUI9XikB+BaK+O0NQyn8qml5PgSEtTB/gy
        GMagQbzRj1OscTaGDRrX5Oo+dhkzLWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683756489;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WdJAnD5vm2Rp1czJeCnrRDV8GmsYmpWf7CQith3fNbU=;
        b=OYehOv6KvpK8ik0wRiV8U+1FHJsroyamGTFAZJ7guCIUqqfzj0Q01FkdBMiN386vh3fs9M
        9qGq26VIuHZQ4xAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A5BF13519;
        Wed, 10 May 2023 22:08:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GG8FAccVXGT0BAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 10 May 2023 22:08:07 +0000
Subject: [PATCH 2/2] SUNRPC: attempt to reach rpcbind with an abstract socket
 name
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Steve Dickson <steved@redhat.com>
Date:   Thu, 11 May 2023 08:06:24 +1000
Message-ID: <168375638440.26246.2133144878410119230.stgit@noble.brown>
In-Reply-To: <168375610447.26246.3237443941479930060.stgit@noble.brown>
References: <168375610447.26246.3237443941479930060.stgit@noble.brown>
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

NFS is primarily name-spaced using network namespaces.  However it
contacts rpcbind (and gss_proxy) using AF_UNIX sockets which are
name-spaced using the mount namespaces.  This requires a container using
NFSv3 (the form that requires rpcbind) to manage both network and mount
namespaces, which can seem an unnecessary burden.

As NFS is primarily a network service it makes sense to use network
namespaces as much as possible, and to prefer to communicate with an
rpcbind running in the same network namespace.  This can be done, while
preserving the benefits of AF_UNIX sockets, by using an abstract socket
address.

An abstract address has a nul at the start of sun_path, and a length
that is exactly the complete size of the sockaddr_un up to the end of
the name, NOT including any trailing nul (which is not part of the
address).
Abstract addresses are local to a network namespace - regular AF_UNIX
path names a resolved in the mount namespace ignoring the network
namespace.

This patch causes rpcb to first try an abstract address before
continuing with regular AF_UNIX and then IP addresses.  This ensures
backwards compatibility.

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
 net/sunrpc/rpcb_clnt.c |   39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index 5a8e6d46809a..a925165f4d0d 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -36,6 +36,7 @@
 #include "netns.h"
 
 #define RPCBIND_SOCK_PATHNAME	"/var/run/rpcbind.sock"
+#define RPCBIND_SOCK_ABSTRACT_NAME "\0/run/rpcbind.sock"
 
 #define RPCBIND_PROGRAM		(100000u)
 #define RPCBIND_PORT		(111u)
@@ -216,21 +217,22 @@ static void rpcb_set_local(struct net *net, struct rpc_clnt *clnt,
 	sn->rpcb_users = 1;
 }
 
+/* Evaluate to actual length of the `sockaddr_un' structure.  */
+# define SUN_LEN(ptr) (offsetof(struct sockaddr_un, sun_path)		\
+		      + 1 + strlen((ptr)->sun_path + 1))
+
 /*
  * Returns zero on success, otherwise a negative errno value
  * is returned.
  */
-static int rpcb_create_local_unix(struct net *net)
+static int rpcb_create_af_local(struct net *net,
+				const struct sockaddr_un *addr)
 {
-	static const struct sockaddr_un rpcb_localaddr_rpcbind = {
-		.sun_family		= AF_LOCAL,
-		.sun_path		= RPCBIND_SOCK_PATHNAME,
-	};
 	struct rpc_create_args args = {
 		.net		= net,
 		.protocol	= XPRT_TRANSPORT_LOCAL,
-		.address	= (struct sockaddr *)&rpcb_localaddr_rpcbind,
-		.addrsize	= sizeof(rpcb_localaddr_rpcbind),
+		.address	= (struct sockaddr *)addr,
+		.addrsize	= SUN_LEN(addr),
 		.servername	= "localhost",
 		.program	= &rpcb_program,
 		.version	= RPCBVERS_2,
@@ -269,6 +271,26 @@ static int rpcb_create_local_unix(struct net *net)
 	return result;
 }
 
+static int rpcb_create_local_abstract(struct net *net)
+{
+	static const struct sockaddr_un rpcb_localaddr_abstract = {
+		.sun_family		= AF_LOCAL,
+		.sun_path		= RPCBIND_SOCK_ABSTRACT_NAME,
+	};
+
+	return rpcb_create_af_local(net, &rpcb_localaddr_abstract);
+}
+
+static int rpcb_create_local_unix(struct net *net)
+{
+	static const struct sockaddr_un rpcb_localaddr_unix = {
+		.sun_family		= AF_LOCAL,
+		.sun_path		= RPCBIND_SOCK_PATHNAME,
+	};
+
+	return rpcb_create_af_local(net, &rpcb_localaddr_unix);
+}
+
 /*
  * Returns zero on success, otherwise a negative errno value
  * is returned.
@@ -332,7 +354,8 @@ int rpcb_create_local(struct net *net)
 	if (rpcb_get_local(net))
 		goto out;
 
-	if (rpcb_create_local_unix(net) != 0)
+	if (rpcb_create_local_abstract(net) != 0 &&
+	    rpcb_create_local_unix(net) != 0)
 		result = rpcb_create_local_net(net);
 
 out:


