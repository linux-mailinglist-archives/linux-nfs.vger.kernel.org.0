Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8356F9FB2
	for <lists+linux-nfs@lfdr.de>; Mon,  8 May 2023 08:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjEHGU1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 May 2023 02:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjEHGU0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 May 2023 02:20:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3170815EFD
        for <linux-nfs@vger.kernel.org>; Sun,  7 May 2023 23:20:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B9A5E1FDA6;
        Mon,  8 May 2023 06:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683526822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v18pCjdlrePj2yQA6KUIcyTp5honaPyFMEvQMkCfy+Y=;
        b=RDzeu6Nn729bmhDXryMF8FkkxsDBpUKdr4waHQGfXAb2/Sd1q51V8YehSudJ+yBGYyQ+Pz
        FLYe/L4lA4JDKAHpu+IwOtvXQoCw/IP+Fhphl/8lullcSqKBqH0Fh1zjDRV3Sf0xk+GypR
        VPoN+uHb7njJN2bMQPX0U2yGQaeIkKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683526822;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v18pCjdlrePj2yQA6KUIcyTp5honaPyFMEvQMkCfy+Y=;
        b=ojE9NfXIqiaiGcHGjLYDqEyk4ozQjXmi9VL6YJYIv74jxWzjepw50QR4+ygss7UKjwpwRg
        JHGr+ltjHE77SBBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9321513499;
        Mon,  8 May 2023 06:20:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WOgwE6WUWGRVGAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 08 May 2023 06:20:21 +0000
Subject: [PATCH 1/2] fsidd: don't use assert() on expr with side-effect.
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 08 May 2023 16:19:11 +1000
Message-ID: <168352675193.17279.3466985331128410653.stgit@noble.brown>
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

assert() is not guaranteed to evaluate its arg.  When compiled with
-DNDEBUG, the evaluation is skipped.  We don't currently compile with
-DNDEBUG, but relying on that is poor form, particularly as this is
described as "sample code" in the git log.

So introduce assert_safe() and use that when there are side-effects.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/reexport/fsidd.c |   28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/support/reexport/fsidd.c b/support/reexport/fsidd.c
index 410b3a370d6d..3fef1ef3512b 100644
--- a/support/reexport/fsidd.c
+++ b/support/reexport/fsidd.c
@@ -26,6 +26,11 @@
 static struct event_base *evbase;
 static struct reexpdb_backend_plugin *dbbackend = &sqlite_plug_ops;
 
+/* assert_safe() always evalutes it argument, as it might have
+ * a side-effect.  assert() won't if compiled with NDEBUG
+ */
+#define assert_safe(__sideeffect) (__sideeffect ? 0 : ({assert(0) ; 0;}))
+
 static void client_cb(evutil_socket_t cl, short ev, void *d)
 {
 	struct event *me = d;
@@ -56,12 +61,11 @@ static void client_cb(evutil_socket_t cl, short ev, void *d)
 
 		if (dbbackend->fsidnum_by_path(req_path, &fsidnum, false, &found)) {
 			if (found)
-				assert(asprintf(&answer, "+ %u", fsidnum) != -1);
+				assert_safe(asprintf(&answer, "+ %u", fsidnum) != -1);
 			else
-				assert(asprintf(&answer, "+ ") != -1);
-		
+				assert_safe(asprintf(&answer, "+ ") != -1);
 		} else {
-			assert(asprintf(&answer, "- %s", "Command failed") != -1);
+			assert_safe(asprintf(&answer, "- %s", "Command failed") != -1);
 		}
 
 		(void)send(cl, answer, strlen(answer), 0);
@@ -78,13 +82,13 @@ static void client_cb(evutil_socket_t cl, short ev, void *d)
 
 		if (dbbackend->fsidnum_by_path(req_path, &fsidnum, true, &found)) {
 			if (found) {
-				assert(asprintf(&answer, "+ %u", fsidnum) != -1);
+				assert_safe(asprintf(&answer, "+ %u", fsidnum) != -1);
 			} else {
-				assert(asprintf(&answer, "+ ") != -1);
+				assert_safe(asprintf(&answer, "+ ") != -1);
 			}
 		
 		} else {
-			assert(asprintf(&answer, "- %s", "Command failed") != -1);
+			assert_safe(asprintf(&answer, "- %s", "Command failed") != -1);
 		}
 
 		(void)send(cl, answer, strlen(answer), 0);
@@ -106,15 +110,15 @@ static void client_cb(evutil_socket_t cl, short ev, void *d)
 		}
 
 		if (bad_input) {
-			assert(asprintf(&answer, "- %s", "Command failed: Bad input") != -1);
+			assert_safe(asprintf(&answer, "- %s", "Command failed: Bad input") != -1);
 		} else {
 			if (dbbackend->path_by_fsidnum(fsidnum, &path, &found)) {
 				if (found)
-					assert(asprintf(&answer, "+ %s", path) != -1);
+					assert_safe(asprintf(&answer, "+ %s", path) != -1);
 				else
-					assert(asprintf(&answer, "+ ") != -1);
+					assert_safe(asprintf(&answer, "+ ") != -1);
 			} else {
-				assert(asprintf(&answer, "+ ") != -1);
+				assert_safe(asprintf(&answer, "+ ") != -1);
 			}
 		}
 
@@ -129,7 +133,7 @@ static void client_cb(evutil_socket_t cl, short ev, void *d)
 	} else {
 		char *answer = NULL;
 
-		assert(asprintf(&answer, "- bad command") != -1);
+		assert_safe(asprintf(&answer, "- bad command") != -1);
 		(void)send(cl, answer, strlen(answer), 0);
 
 		free(answer);


