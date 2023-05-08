Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB996F9FB3
	for <lists+linux-nfs@lfdr.de>; Mon,  8 May 2023 08:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjEHGUb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 May 2023 02:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjEHGUa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 May 2023 02:20:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63EB30FB
        for <linux-nfs@vger.kernel.org>; Sun,  7 May 2023 23:20:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 887331FD9F;
        Mon,  8 May 2023 06:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683526827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1bwegpWKqZGmA9wD3M8D0Kqjkw11Xvs3rGP/ihfzxMQ=;
        b=jFwMAzNQqOhc6dCgqqU/vCLXtLKn0J08onGUHzA1IMfsEYPytm57KAyj555Jnd1mQes8Ev
        4jaf/LRkSPv4+miHMfra+D8k8P5COewJpnLApCvFXxdPrHrmfLWjyujlIpVZr27PPqPXk9
        C3DoVrKWuZMyq616KbzXbtsQlaEcyxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683526827;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1bwegpWKqZGmA9wD3M8D0Kqjkw11Xvs3rGP/ihfzxMQ=;
        b=YXnpo4CcRz4cMPkBVnvPzavx+/tQcOioxoTIsdDE9zDJ8YDqxxYLWpSkKbMWc6nBvixS0q
        DqgSLCprXMPDh5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EF6E13499;
        Mon,  8 May 2023 06:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HI5wAaqUWGRmGAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 08 May 2023 06:20:26 +0000
Subject: [PATCH 2/2] fsidd: provide better default socket name.
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 08 May 2023 16:19:11 +1000
Message-ID: <168352675194.17279.12797722278244839616.stgit@noble.brown>
In-Reply-To: <168352657591.17279.393573102599959056.stgit@noble.brown>
References: <168352657591.17279.393573102599959056.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Having the default socket name be in the current directory is a poor
choice for a daemon that is expected to run as root.

It is also likely better to use an "abstract" socket name.  abstract
names do not exist in the filesystem namespace and are local to a
network namespace.  Using an abstract name ensures that the nfsd,
mountd, and fsidd are all in the same network namespace.

This patch:
 - uses a single #define for the default socket name, rather than 2;
 - allows the socket name to start with '@' which is interpreted to
   be a request to use the abstract name space (systemd uses the same
   convention).
 - changes the default to "@/run/fsid.sock".  I don't know of a formal
   standard for choosing names in the abstract name space, the defacto
   standard (seen in "ss -xa|grep @") is to use a name similar to what
   might be used in the filesystem.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/reexport/fsidd.c    |   10 ++++++----
 support/reexport/reexport.c |    3 +++
 support/reexport/reexport.h |    2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/support/reexport/fsidd.c b/support/reexport/fsidd.c
index 3fef1ef3512b..37649d065ce6 100644
--- a/support/reexport/fsidd.c
+++ b/support/reexport/fsidd.c
@@ -18,11 +18,10 @@
 
 #include "conffile.h"
 #include "reexport_backend.h"
+#include "reexport.h"
 #include "xcommon.h"
 #include "xlog.h"
 
-#define FSID_SOCKET_NAME "fsid.sock"
-
 static struct event_base *evbase;
 static struct reexpdb_backend_plugin *dbbackend = &sqlite_plug_ops;
 
@@ -167,11 +166,14 @@ int main(void)
 
 	sock_file = conf_get_str_with_def("reexport", "fsidd_socket", FSID_SOCKET_NAME);
 
-	unlink(sock_file);
-
 	memset(&addr, 0, sizeof(struct sockaddr_un));
 	addr.sun_family = AF_UNIX;
 	strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
+	if (addr.sun_path[0] == '@')
+		/* "abstract" socket namespace */
+		addr.sun_path[0] = 0;
+	else
+		unlink(sock_file);
 
 	srv = socket(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK, 0);
 	if (srv == -1) {
diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
index eddc9bf413f6..d597a2f73c93 100644
--- a/support/reexport/reexport.c
+++ b/support/reexport/reexport.c
@@ -38,6 +38,9 @@ static bool connect_fsid_service(void)
 	memset(&addr, 0, sizeof(struct sockaddr_un));
 	addr.sun_family = AF_UNIX;
 	strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
+	if (addr.sun_path[0] == '@')
+		/* "abstract" socket namespace */
+		addr.sun_path[0] = 0;
 
 	s = socket(AF_UNIX, SOCK_SEQPACKET, 0);
 	if (s == -1) {
diff --git a/support/reexport/reexport.h b/support/reexport/reexport.h
index 3bed03a9a0bb..856c3085a1dd 100644
--- a/support/reexport/reexport.h
+++ b/support/reexport/reexport.h
@@ -13,6 +13,6 @@ int reexpdb_fsidnum_by_path(char *path, uint32_t *fsidnum, int may_create);
 int reexpdb_apply_reexport_settings(struct exportent *ep, char *flname, int flline);
 void reexpdb_uncover_subvolume(uint32_t fsidnum);
 
-#define FSID_SOCKET_NAME "fsid.sock"
+#define FSID_SOCKET_NAME "@/run/fsid.sock"
 
 #endif /* REEXPORT_H */


