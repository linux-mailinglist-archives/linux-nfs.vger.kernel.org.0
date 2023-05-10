Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0E16FE721
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 00:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjEJWVS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 May 2023 18:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjEJWVQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 May 2023 18:21:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE15198
        for <linux-nfs@vger.kernel.org>; Wed, 10 May 2023 15:21:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6D14D1FD72;
        Wed, 10 May 2023 22:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683757274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DnJQnnWSkgfWAW7kKiqFjVXUn+NyuILojQqjlvMZ3q4=;
        b=WzQ8RVrFiAcUj/wefyd9T68rFuoI0gytOM65lGObgpklrgefPKHSWv6PXVibXKfEzs5T80
        ntTi8GTreYLvT7XMhuELqZ+xR8h8PqKN3XbjqndMHV/I3R2d7Dwgpr167l0IL1K/Mcqcot
        l8/xBZZiqFTH5VGmQlXraDytmijo9FE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683757274;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DnJQnnWSkgfWAW7kKiqFjVXUn+NyuILojQqjlvMZ3q4=;
        b=iKiHP/9XFKPecWOCYLHr7q9oCza5yW86KSIl7vwAIfZ5b0duy7HK3Kmk39B5O1W+e064RA
        EvSMvy5mohfmAdBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41F6A13519;
        Wed, 10 May 2023 22:21:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3c+EOdcYXGQhCgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 10 May 2023 22:21:11 +0000
Subject: [PATCH 2/3] Change local_rpcb() to take a targaddr pointer.
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Steve Dickson <steved@redhat.com>
Date:   Thu, 11 May 2023 08:20:45 +1000
Message-ID: <168375724524.25049.14612883811400503608.stgit@noble.brown>
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

Two callers of local_rpcb() want the target-addr, and local_rcpb() has
easy access to it.  So accept a pointer and fill it in if not NULL.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 src/rpcb_clnt.c |   35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
index d178d86eda44..7acd366a3073 100644
--- a/src/rpcb_clnt.c
+++ b/src/rpcb_clnt.c
@@ -89,7 +89,7 @@ static struct address_cache *copy_of_cached(const char *, char *);
 static void delete_cache(struct netbuf *);
 static void add_cache(const char *, const char *, struct netbuf *, char *);
 static CLIENT *getclnthandle(const char *, const struct netconfig *, char **);
-static CLIENT *local_rpcb(void);
+static CLIENT *local_rpcb(char **targaddr);
 #ifdef NOTUSED
 static struct netbuf *got_entry(rpcb_entry_list_ptr, const struct netconfig *);
 #endif
@@ -417,19 +417,12 @@ getclnthandle(host, nconf, targaddr)
 	    nconf->nc_netid, si.si_af, si.si_proto, si.si_socktype));
 
 	if (nconf->nc_protofmly != NULL && strcmp(nconf->nc_protofmly, NC_LOOPBACK) == 0) {
-		client = local_rpcb();
+		client = local_rpcb(targaddr);
 		if (! client) {
 			LIBTIRPC_DEBUG(1, ("getclnthandle: %s", 
 				clnt_spcreateerror("local_rpcb failed")));
 			goto out_err;
 		} else {
-			struct sockaddr_un sun;
-
-			if (targaddr) {
-				*targaddr = malloc(sizeof(sun.sun_path));
-				strncpy(*targaddr, _PATH_RPCBINDSOCK,
-				    sizeof(sun.sun_path));
-			}
 			return (client);
 		}
 	} else {
@@ -528,7 +521,8 @@ getpmaphandle(nconf, hostname, tgtaddr)
  * rpcbind. Returns NULL on error and free's everything.
  */
 static CLIENT *
-local_rpcb()
+local_rpcb(targaddr)
+	char **targaddr;
 {
 	CLIENT *client;
 	static struct netconfig *loopnconf;
@@ -561,6 +555,8 @@ local_rpcb()
 	if (client != NULL) {
 		/* Mark the socket to be closed in destructor */
 		(void) CLNT_CONTROL(client, CLSET_FD_CLOSE, NULL);
+		if (targaddr)
+			*targaddr = strdup(sun.sun_path);
 		return client;
 	}
 
@@ -619,7 +615,7 @@ try_nconf:
 		endnetconfig(nc_handle);
 	}
 	mutex_unlock(&loopnconf_lock);
-	client = getclnthandle(hostname, loopnconf, NULL);
+	client = getclnthandle(hostname, loopnconf, targaddr);
 	return (client);
 }
 
@@ -648,20 +644,11 @@ rpcb_set(program, version, nconf, address)
 		rpc_createerr.cf_stat = RPC_UNKNOWNADDR;
 		return (FALSE);
 	}
-	client = local_rpcb();
+	client = local_rpcb(&parms.r_addr);
 	if (! client) {
 		return (FALSE);
 	}
 
-	/* convert to universal */
-	/*LINTED const castaway*/
-	parms.r_addr = taddr2uaddr((struct netconfig *) nconf,
-				   (struct netbuf *)address);
-	if (!parms.r_addr) {
-		CLNT_DESTROY(client);
-		rpc_createerr.cf_stat = RPC_N2AXLATEFAILURE;
-		return (FALSE); /* no universal address */
-	}
 	parms.r_prog = program;
 	parms.r_vers = version;
 	parms.r_netid = nconf->nc_netid;
@@ -699,7 +686,7 @@ rpcb_unset(program, version, nconf)
 	RPCB parms;
 	char uidbuf[32];
 
-	client = local_rpcb();
+	client = local_rpcb(NULL);
 	if (! client) {
 		return (FALSE);
 	}
@@ -1329,7 +1316,7 @@ rpcb_taddr2uaddr(nconf, taddr)
 		rpc_createerr.cf_stat = RPC_UNKNOWNADDR;
 		return (NULL);
 	}
-	client = local_rpcb();
+	client = local_rpcb(NULL);
 	if (! client) {
 		return (NULL);
 	}
@@ -1363,7 +1350,7 @@ rpcb_uaddr2taddr(nconf, uaddr)
 		rpc_createerr.cf_stat = RPC_UNKNOWNADDR;
 		return (NULL);
 	}
-	client = local_rpcb();
+	client = local_rpcb(NULL);
 	if (! client) {
 		return (NULL);
 	}


