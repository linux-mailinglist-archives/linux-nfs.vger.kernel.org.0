Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FF95852AF
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jul 2022 17:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiG2Pcx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Jul 2022 11:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbiG2Pcw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Jul 2022 11:32:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C662682FA2
        for <linux-nfs@vger.kernel.org>; Fri, 29 Jul 2022 08:32:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 85761210B2;
        Fri, 29 Jul 2022 15:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659108770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=f/GorR3OsP29gPpoWqTrpg4QS0a83WAmsltKyWhY7Y8=;
        b=xBiJh16XcYyaZSY+OWGg3ulQw/2cSs+cN7FBs4gs3O9qK2m7BSs/n8xs1KKvJvbAvYCgLY
        6s8ZQQL6pdF7SyFMcErTBrIseSh9a+mQP+TCRIcadGRT8cPyfMBwlZ1+HoFQhITWRQ1QDe
        u1Oj0OpS2O/lK2nFOtw0sKV4N9HX++Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659108770;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=f/GorR3OsP29gPpoWqTrpg4QS0a83WAmsltKyWhY7Y8=;
        b=o8AuHOdIyWqWdsokghTqqKuDF8/kIUC8Q0zKnDaZwwPtvUptlVrqa1PhpqNjIfZfBXOyVe
        gqL6L19m8NR6u5CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A86A13A8E;
        Fri, 29 Jul 2022 15:32:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2xmUEKL942IKfQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 29 Jul 2022 15:32:50 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org,
        Cyril Hrubis <chrubis@suse.cz>,
        Chen Hanxiao <chenhx.fnst@fujitsu.com>
Subject: [RFC PATCH 1/1] metaparse: Replace macro also in arrays
Date:   Fri, 29 Jul 2022 17:32:46 +0200
Message-Id: <20220729153246.1213-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This helps to replace macros like:

    #define TEST_APP "userns06_capcheck"

    static const char *const resource_files[] = {
	TEST_APP,
	NULL,
    };

$ ./metaparse -Iinclude -Itestcases/kernel/syscalls/utils/ ../testcases/kernel/containers/userns/userns06.c
Before:
   "resource_files": [
     "TEST_APP"
    ],
    ...

After:
   "resource_files": [
     "userns06_capcheck"
    ],
    ...

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

This is a reaction on patch
https://patchwork.ozlabs.org/project/ltp/patch/20220722083529.209-1-chenhx.fnst@fujitsu.com/
First: I was wrong, inlining arrays does any change in the docparse output.
BTW I'd be still for inlining for better readability.

I'm not sure if this is not good idea, maybe some of the constants should be
kept unparsed, e.g.:

Orig:
   "caps": [
     "TST_CAP",
     "(",
     "TST_CAP_DROP",
     "CAP_SYS_RESOURCE",

Becomes:
   "caps": [
     "TST_CAP",
     "(",
     "TST_CAP_DROP",
     "24",

CAP_SYS_RESOURCE is replaced because it's a string, but IMHO it'd be better to keep it.
TST_CAP{_DROP,} aren't replaced because they aren't a plain strings.
Maybe replace only non-numerc values?

Kind regards,
Petr

 metadata/metaparse.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index 2384c73c8..0cc288b2d 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2019-2021 Cyril Hrubis <chrubis@suse.cz>
- * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+ * Copyright (c) 2020-2022 Petr Vorel <pvorel@suse.cz>
  */
 
 #define _GNU_SOURCE
@@ -286,9 +286,28 @@ static void close_include(FILE *inc)
 	fclose(inc);
 }
 
+static void try_apply_macro(char **res)
+{
+	ENTRY macro = {
+		.key = *res,
+	};
+
+	ENTRY *ret;
+
+	ret = hsearch(macro, FIND);
+
+	if (!ret)
+		return;
+
+	if (verbose)
+		fprintf(stderr, "APPLYING MACRO %s=%s\n", ret->key, (char*)ret->data);
+
+	*res = ret->data;
+}
+
 static int parse_array(FILE *f, struct data_node *node)
 {
-	const char *token;
+	char *token;
 
 	for (;;) {
 		if (!(token = next_token(f, NULL)))
@@ -315,6 +334,7 @@ static int parse_array(FILE *f, struct data_node *node)
 		if (!strcmp(token, "NULL"))
 			continue;
 
+		try_apply_macro(&token);
 		struct data_node *str = data_node_string(token);
 
 		data_node_array_add(node, str);
@@ -323,25 +343,6 @@ static int parse_array(FILE *f, struct data_node *node)
 	return 0;
 }
 
-static void try_apply_macro(char **res)
-{
-	ENTRY macro = {
-		.key = *res,
-	};
-
-	ENTRY *ret;
-
-	ret = hsearch(macro, FIND);
-
-	if (!ret)
-		return;
-
-	if (verbose)
-		fprintf(stderr, "APPLYING MACRO %s=%s\n", ret->key, (char*)ret->data);
-
-	*res = ret->data;
-}
-
 static int parse_get_array_len(FILE *f)
 {
 	const char *token;
-- 
2.37.1

