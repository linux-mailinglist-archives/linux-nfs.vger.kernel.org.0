Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB0C527234
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiENOvP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiENOvD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:51:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFF934674
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A22460F70
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E83C34116;
        Sat, 14 May 2022 14:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652539845;
        bh=d9LhUJRq5+rDWcd7ORCDZXtKzVKUehbDccHatHbEXFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C0E6aCjgqVH8GsKt+gNel+MOzrNPiSmSW8PytWZOpDMr/jAe1pbRycL+g5r0zp7GX
         +9brzwDaCXYw/spMesjaNgZFA2xr51ir5mnzPo1F3+B7Q9N08JAhJgblIWaja+aMn+
         a2nWpVEBEFOLueYvu8unQmkWGuTdGSctwoiMyeg/L7dvJdzs43dd0UQmEb00ozqUmM
         72VroZZ+VBNbsBTutbLypy4cjRJo6TH8+Vj1IhbPoayvjK9ir7morZYA3U+iPpK3+T
         03CFH6/QIPyPVpazrCc7nkPDDiCWVKBDADy/cOJb8sY9OmjnMkrwSjTmNhYS/JrTNj
         fAMprxx2ThupA==
From:   trondmy@kernel.org
To:     Steve Dickson <SteveD@redhat.com>,
        "J.Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/6] nfs4_getacl: Add support for the --dacl and --sacl options
Date:   Sat, 14 May 2022 10:44:34 -0400
Message-Id: <20220514144436.4298-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514144436.4298-4-trondmy@kernel.org>
References: <20220514144436.4298-1-trondmy@kernel.org>
 <20220514144436.4298-2-trondmy@kernel.org>
 <20220514144436.4298-3-trondmy@kernel.org>
 <20220514144436.4298-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add support for the NFSv4.1 dacl and sacl attributes.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 nfs4_getfacl/nfs4_getfacl.c | 72 +++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 7 deletions(-)

diff --git a/nfs4_getfacl/nfs4_getfacl.c b/nfs4_getfacl/nfs4_getfacl.c
index 1222dd907c9e..954cf7edb19a 100644
--- a/nfs4_getfacl/nfs4_getfacl.c
+++ b/nfs4_getfacl/nfs4_getfacl.c
@@ -42,15 +42,30 @@
 #include <ftw.h>
 #include <getopt.h>
 
+#define OPT_DACL	0x98
+#define OPT_SACL	0x99
+
 static void usage(int);
 static void more_help();
 static char *execname;
-static void print_acl_from_path();
+static void print_acl_from_path(const char *, enum acl_type);
 static int ignore_comment = 0;
 
-static int recursive(const char *fpath, const struct stat *sb, int tflag, struct FTW *ftwbuf)
+static int print_acl(const char *fpath, const struct stat *sb, int tflag, struct FTW *ftwbuf)
+{
+	print_acl_from_path(fpath, ACL_TYPE_ACL);
+	return 0;
+}
+
+static int print_dacl(const char *fpath, const struct stat *sb, int tflag, struct FTW *ftwbuf)
 {
-	print_acl_from_path(fpath);
+	print_acl_from_path(fpath, ACL_TYPE_DACL);
+	return 0;
+}
+
+static int print_sacl(const char *fpath, const struct stat *sb, int tflag, struct FTW *ftwbuf)
+{
+	print_acl_from_path(fpath, ACL_TYPE_SACL);
 	return 0;
 }
 
@@ -59,6 +74,8 @@ static struct option long_options[] = {
         {"help",         0, 0, 'h' },
         {"recursive",     0, 0, 'R' },
         {"omit-header",  0, 0, 'c'},
+        {"dacl",         0, 0, OPT_DACL},
+        {"sacl",         0, 0, OPT_SACL},
         { NULL,          0, 0, 0,  },
 };
 
@@ -66,6 +83,9 @@ int main(int argc, char **argv)
 {
 	int opt, res = 1;
         int do_recursive = 0;
+	int (*recursive)(const char *fpath, const struct stat *sb,
+			 int tflag, struct FTW *ftwbuf) = print_acl;
+	enum acl_type type = ACL_TYPE_ACL;
 	
 	execname = basename(argv[0]);
 
@@ -88,6 +108,14 @@ int main(int argc, char **argv)
 			case 'c':
 				ignore_comment = 1;
 				break;
+			case OPT_DACL:
+				type = ACL_TYPE_DACL;
+				recursive = print_dacl;
+				break;
+			case OPT_SACL:
+				type = ACL_TYPE_SACL;
+				recursive = print_sacl;
+				break;
 			case 'h':
 				usage(1);
 				res = 0;
@@ -111,23 +139,51 @@ int main(int argc, char **argv)
 				printf("Invalid filename: %s\n", argv[optind]);
 		}
 		else
-			print_acl_from_path(argv[optind]);
+			print_acl_from_path(argv[optind], type);
 		res = 0;
 	}
 out:
 	return res;
 }
 
-static void print_acl_from_path(const char *fpath)
+static void print_acl_from_path(const char *fpath, enum acl_type type)
 {
 	struct nfs4_acl *acl;
-	acl = nfs4_acl_for_path(fpath);
+
+	switch (type) {
+	case ACL_TYPE_ACL:
+		acl = nfs4_getacl(fpath);
+		break;
+	case ACL_TYPE_DACL:
+		acl = nfs4_getdacl(fpath);
+		break;
+	case ACL_TYPE_SACL:
+		acl = nfs4_getsacl(fpath);
+		break;
+	}
+
 	if (acl != NULL) {
 		if (ignore_comment == 0)
 			printf("# file: %s\n", fpath);
 		nfs4_print_acl(stdout, acl);
 		printf("\n");
 		nfs4_free_acl(acl);
+	} else {
+		switch (errno) {
+		case ENODATA:
+			fprintf(stderr,"Attribute not found on file: %s\n",
+				fpath);
+			break;
+		case EREMOTEIO:
+			fprintf(stderr,"An NFS server error occurred.\n");
+			break;
+		case EOPNOTSUPP:
+                        fprintf(stderr,"Operation to request attribute not "
+				       "supported: %s\n", fpath);
+			break;
+		default:
+			perror("Failed operation");
+		}
 	}
 }
 
@@ -142,7 +198,9 @@ static void usage(int label)
 	"   -H, --more-help	 display ACL format information\n"
 	"   -h, --help		 display this help text\n"
 	"   -R, --recursive	 recurse into subdirectories\n"
-	"   -c, --omit-header	 Do not display the comment header (Do not print filename)\n";
+	"   -c, --omit-header	 Do not display the comment header (Do not print filename)\n"
+	"       --dacl           display the NFSv4.1 dacl\n"
+	"       --sacl           display the NFSv4.1 sacl\n";
 
 	fprintf(stderr, gfusage, execname);
 }
-- 
2.36.1

