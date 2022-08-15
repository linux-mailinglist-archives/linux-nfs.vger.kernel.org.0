Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22689592C1B
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Aug 2022 12:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241308AbiHOIjP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Aug 2022 04:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241110AbiHOIjN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Aug 2022 04:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17362205D9
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 01:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660552751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RtCG0fMMsALwDFLyg5EOuNj36gZMfyU4x6lmh7oVWAQ=;
        b=bMjzGz11ZT5ZpkIC5GHq2w5zPSoFBUryIjqejAvOnYwKprSBxzzI7tNbkOyaGasdmOdqIT
        QoivyPLfc9uLwISZ10I84Kei/YLMbxaZ/zgyFuAQJVP0UZgxTespWIBX5yHjcdC7enkmo6
        A/61/egpVE40jBRSH7HBLBPcUisU6Lw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-avz4XaOzOTm-MhDto53Sqw-1; Mon, 15 Aug 2022 04:39:09 -0400
X-MC-Unique: avz4XaOzOTm-MhDto53Sqw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AA5618E5340
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 08:39:09 +0000 (UTC)
Received: from plambri-t490s.lan (unknown [10.33.36.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7A33C15BA6
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 08:39:08 +0000 (UTC)
From:   Pierguido Lambri <plambri@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfs4_setfacl: add a specific option for indexes
Date:   Mon, 15 Aug 2022 09:39:08 +0100
Message-Id: <20220815083908.65720-1-plambri@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs4_setfacl had the possibility to use an optional index
to add/remove an ACL entry.
This was causing some confusion as numeric files could be interpreted
as indexes.
This change adds an extra command line option '-i' to specifically
handle the indexes.
The index can be used only with certain operations (add and remove).
The new syntax, when using indexes, would be:

~]# nfs4_setfacl -i 3 -a A::101:rxtncy file123

Signed-off-by: Pierguido Lambri <plambri@redhat.com>
---
 nfs4_setfacl/nfs4_setfacl.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/nfs4_setfacl/nfs4_setfacl.c b/nfs4_setfacl/nfs4_setfacl.c
index d0485ad..c3bdf56 100644
--- a/nfs4_setfacl/nfs4_setfacl.c
+++ b/nfs4_setfacl/nfs4_setfacl.c
@@ -148,7 +148,7 @@ int main(int argc, char **argv)
 		return err;
 	}
 
-	while ((opt = getopt_long(argc, argv, "-:a:A:s:S:x:X:m:ethvHRPL", long_options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "-:a:A:i:s:S:x:X:m:ethvHRPL", long_options, NULL)) != -1) {
 		switch (opt) {
 			case 'a':
 				mod_string = optarg;
@@ -158,21 +158,14 @@ int main(int argc, char **argv)
 			add:
 				assert_wu_wei(action);
 				action = INSERT_ACTION;
-
-				/* run along if no more args (defaults to ace_index 1 == prepend) */
-				if (optind == argc)
-					break;
-				ace_index = strtoul_reals(argv[optind++], 10);
-				if (ace_index == ULONG_MAX) {
-					/* oops it wasn't an ace_index; reset */
-					optind--;
-					ace_index = -1;
-				} else if (ace_index == 0) {
-					fprintf(stderr, "Sorry, valid indices start at '1'.\n");
-					goto out;
+				break;
+			case 'i':
+				ace_index = strtoul_reals(optarg, 10);
+				if (ace_index == 0) {
+                                    fprintf(stderr, "Sorry, valid indices start at '1'.\n");
+                                    goto out;
 				}
 				break;
-
 			case 's':
 				mod_string = optarg;
 				goto set;
@@ -184,9 +177,6 @@ int main(int argc, char **argv)
 				break;
 
 			case 'x':
-				ace_index = strtoul_reals(optarg, 10);
-				if(ace_index == ULONG_MAX)
-					mod_string = optarg;
 				goto remove;
 			case 'X':
 				spec_file = optarg;
@@ -248,6 +238,9 @@ int main(int argc, char **argv)
 					case 'A':
 						fprintf(stderr, "Sorry, -a requires an 'acl_spec', whilst -A requires a 'spec_file'.\n");
 						goto out;
+					case 'i':
+						fprintf(stderr, "Sorry, -i requires an index (numerical)\n");
+						goto out;
 					case 's':
 						fprintf(stderr, "Sorry, -s requires an 'acl_spec'.\n");
 						goto out;
@@ -283,6 +276,9 @@ int main(int argc, char **argv)
 	if (action == NO_ACTION) {
 		fprintf(stderr, "No action specified.\n");
 		goto out;
+	} else if (action != INSERT_ACTION && action != REMOVE_ACTION && ace_index >= 0) {
+		fprintf(stderr, "Index can be used only with add or remove.\n");
+		goto out;
 	} else if (numpaths < 1) {
 		fprintf(stderr, "No path(s) specified.\n");
 		goto out;
@@ -548,9 +544,10 @@ static void __usage(const char *name, int is_ef)
 	"%s %s -- manipulate NFSv4 file/directory access control lists\n"
 	"Usage: %s [OPTIONS] COMMAND file ...\n"
 	" .. where COMMAND is one of:\n"
-	"   -a acl_spec [index]	 add ACL entries in acl_spec at index (DEFAULT: 1)\n"
-	"   -A file [index]	 read ACL entries to add from file\n"
-	"   -x acl_spec | index	 remove ACL entries or entry-at-index from ACL\n"
+	"   -a acl_spec		 add ACL entries in acl_spec at defaul index (DEFAULT: 1)\n"
+	"   -A file 		 read ACL entries to add from file\n"
+	"   -i index 		 use the entry-at-index from ACL (only for add and remove)\n"
+	"   -x acl_speci 	 remove ACL entries\n"
 	"   -X file  		 read ACL entries to remove from file\n"
 	"   -s acl_spec		 set ACL to acl_spec (replaces existing ACL)\n"
 	"   -S file		 read ACL entries to set from file\n"
-- 
2.37.2

