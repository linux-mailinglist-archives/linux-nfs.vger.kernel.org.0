Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427506FE72F
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 00:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjEJW2I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 May 2023 18:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbjEJW2F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 May 2023 18:28:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491A42D56
        for <linux-nfs@vger.kernel.org>; Wed, 10 May 2023 15:28:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E226D21994;
        Wed, 10 May 2023 22:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683757682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oySt+/k4oQpJvoHZlSaYx4amjfvrxaxHGtzf74/bvS0=;
        b=LrnbRRj2pseZDVbZOqZzrQWrhrPYxo4DqqmZkFZynY5CA69KP9nidOpT2Jh5Pr2Z9hIrcd
        MvUh+tfs/q/g1SoIJhOCho2aQQukvMygzsRqjDuXQo0bc6Mb/xB82t36Ht8nOYFH3VGPyb
        Jvoidbwx0gGO2WvTp4pv2/P941wnGTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683757682;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oySt+/k4oQpJvoHZlSaYx4amjfvrxaxHGtzf74/bvS0=;
        b=ZUELha1tIlx9V3+FpHetAZ0NpyzYDHvx8i6vKWM0Tv0fCLJ7atoGSTDCTMujfPt6sy6I6Y
        ws4tIHV9lBlZFHDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FFE513519;
        Wed, 10 May 2023 22:28:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u/wkDnAaXGR8DAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 10 May 2023 22:28:00 +0000
Subject: [PATCH 2/2] rpcinfo: try connecting using abstract address.
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Steve Dickson <steved@redhat.com>
Date:   Thu, 11 May 2023 08:27:36 +1000
Message-ID: <168375765675.30997.4851750258993172980.stgit@noble.brown>
In-Reply-To: <168375751051.30997.11634044913854205425.stgit@noble.brown>
References: <168375751051.30997.11634044913854205425.stgit@noble.brown>
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

rpcinfo doesn't use library calls to set up the address for rpcbind.  So
to get to it try the new abstract address, we need to explicitly
teach it how.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 src/rpcinfo.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/src/rpcinfo.c b/src/rpcinfo.c
index 0e14f78ad2de..4464cbc0941b 100644
--- a/src/rpcinfo.c
+++ b/src/rpcinfo.c
@@ -311,6 +311,13 @@ main (int argc, char **argv)
   return (0);
 }
 
+/* Evaluate to actual length of the `sockaddr_un' structure, whether
+ * abstract or not.
+ */
+#include <stddef.h>
+#define SUN_LEN_A(ptr) (offsetof(struct sockaddr_un, sun_path)	\
+			+ 1 + strlen((ptr)->sun_path + 1))
+
 static CLIENT *
 local_rpcb (rpcprog_t prog, rpcvers_t vers)
 {
@@ -334,6 +341,7 @@ local_rpcb (rpcprog_t prog, rpcvers_t vers)
   endnetconfig(localhandle);
   return clnt;
 #else
+  CLIENT *clnt;
   struct netbuf nbuf;
   struct sockaddr_un sun;
   int sock;
@@ -344,12 +352,26 @@ local_rpcb (rpcprog_t prog, rpcvers_t vers)
     return NULL;
 
   sun.sun_family = AF_LOCAL;
+
+#ifdef _PATH_RPCBINDSOCK_ABSTRACT
+  memcpy(sun.sun_path, _PATH_RPCBINDSOCK_ABSTRACT,
+         sizeof(_PATH_RPCBINDSOCK_ABSTRACT));
+  nbuf.len = SUN_LEN_A (&sun);
+  nbuf.maxlen = sizeof (struct sockaddr_un);
+  nbuf.buf = &sun;
+
+  clnt = clnt_vc_create (sock, &nbuf, prog, vers, 0, 0);
+  if (clnt)
+    return clnt;
+#endif
+
   strcpy (sun.sun_path, _PATH_RPCBINDSOCK);
   nbuf.len = SUN_LEN (&sun);
   nbuf.maxlen = sizeof (struct sockaddr_un);
   nbuf.buf = &sun;
 
-  return clnt_vc_create (sock, &nbuf, prog, vers, 0, 0);
+  clnt = clnt_vc_create (sock, &nbuf, prog, vers, 0, 0);
+  return clnt;
 #endif
 }
 


