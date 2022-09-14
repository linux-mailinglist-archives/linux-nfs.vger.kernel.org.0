Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ECE5B8E32
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Sep 2022 19:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiINRbZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Sep 2022 13:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiINRbW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Sep 2022 13:31:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CA67F256
        for <linux-nfs@vger.kernel.org>; Wed, 14 Sep 2022 10:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663176679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SJAcaQM3ZwcdVItNf0KHvz1LyegbhSJ/0s07Hr9+kU8=;
        b=ckAVM+RUESyW6X9sh1rlqQgYrP3Xbt5dYdy5kgoxkLbQKJLTIKHUFbUp8kju4awCl0in2r
        b4G4TH8KrkmyTtolripucjXY33MQY/uCZ4wtGWRXywM3MMhjTQiGWoLzUeKpg041s6d2UM
        eKUzES4fpA+qXpfaIZ9s311czjjyPGg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-zAcqbZdKM52ivvbI7loH1g-1; Wed, 14 Sep 2022 13:31:17 -0400
X-MC-Unique: zAcqbZdKM52ivvbI7loH1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 621C5381078D
        for <linux-nfs@vger.kernel.org>; Wed, 14 Sep 2022 17:31:17 +0000 (UTC)
Received: from plambri-t490s.homenet.telecomitalia.it (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF5B240C6EC2
        for <linux-nfs@vger.kernel.org>; Wed, 14 Sep 2022 17:31:16 +0000 (UTC)
From:   Pierguido Lambri <plambri@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH v2 1/2] nfs4_setfacl: add a specific option for indexes
Date:   Wed, 14 Sep 2022 18:31:14 +0100
Message-Id: <20220914173115.296058-1-plambri@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 nfs4_setfacl/nfs4_setfacl.c | 60 +++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/nfs4_setfacl/nfs4_setfacl.c b/nfs4_setfacl/nfs4_setfacl.c
index e581608..d10e073 100644
--- a/nfs4_setfacl/nfs4_setfacl.c
+++ b/nfs4_setfacl/nfs4_setfacl.c
@@ -143,7 +143,7 @@ int main(int argc, char **argv)
 	int opt, err = 1;
 	int numpaths = 0, curpath = 0;
 	char *tmp, **paths = NULL, *path = NULL, *spec_file = NULL;
-	FILE *s_fp = NULL;
+	FILE *s_fp, *fd = NULL;
 
 	if (!strcmp(basename(argv[0]), "nfs4_editfacl")) {
 		action = EDIT_ACTION;
@@ -155,7 +155,7 @@ int main(int argc, char **argv)
 		return err;
 	}
 
-	while ((opt = getopt_long(argc, argv, "-:a:A:s:S:x:X:m:ethvHRPL", long_options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "-:a:A:i:s:S:x::X:m:ethvHRPL", long_options, NULL)) != -1) {
 		switch (opt) {
 			case 'a':
 				mod_string = optarg;
@@ -165,21 +165,14 @@ int main(int argc, char **argv)
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
@@ -191,9 +184,14 @@ int main(int argc, char **argv)
 				break;
 
 			case 'x':
-				ace_index = strtoul_reals(optarg, 10);
-				if(ace_index == ULONG_MAX)
-					mod_string = optarg;
+				/* make sure we handle the argument even if
+				 * it doesn't immediately follow the option
+				 */
+				if (optarg == NULL && optind < argc && argv[optind][0] != '-')
+				{
+					optarg = argv[optind++];
+				}
+				mod_string = optarg;
 				goto remove;
 			case 'X':
 				spec_file = optarg;
@@ -255,6 +253,9 @@ int main(int argc, char **argv)
 					case 'A':
 						fprintf(stderr, "Sorry, -a requires an 'acl_spec', whilst -A requires a 'spec_file'.\n");
 						goto out;
+					case 'i':
+						fprintf(stderr, "Sorry, -i requires an index (numerical)\n");
+						goto out;
 					case 's':
 						fprintf(stderr, "Sorry, -s requires an 'acl_spec'.\n");
 						goto out;
@@ -297,7 +298,21 @@ int main(int argc, char **argv)
 	if (action == NO_ACTION) {
 		fprintf(stderr, "No action specified.\n");
 		goto out;
-	} else if (numpaths < 1) {
+	} else if (action != INSERT_ACTION && action != REMOVE_ACTION && ace_index >= 0) {
+		fprintf(stderr, "Index can be used only with add or remove.\n");
+		goto out;
+	} else if (numpaths <= 0 && ace_index >= 0 && mod_string)
+	{
+		/* Make sure the argument is a file */
+		if (!(fd = fopen(mod_string, "r"))) {
+			fprintf(stderr, "No path(s) specified.\n");
+			goto out;
+		} else
+			fclose(fd);
+		paths = malloc(sizeof(char *) * (argc - optind + 1));
+		paths[numpaths++] = mod_string;
+	} else if (numpaths < 1)
+	{
 		fprintf(stderr, "No path(s) specified.\n");
 		goto out;
 	}
@@ -609,9 +624,10 @@ static void __usage(const char *name, int is_ef)
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
2.37.3

