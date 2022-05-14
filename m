Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C72527239
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiENOvR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiENOvD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:51:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A81D13D
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:50:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F30F5B8075F
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B81C34115;
        Sat, 14 May 2022 14:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652539845;
        bh=S5yU+/+BjMk2kG8Zj7fh/VVfqeuexGUHdyMu/3JprrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k8x4EscrzEldhcmAMneuM2qinrz3yk7zhPf9BuNiT9ga0F86Sq+cQLTfJblVrL8vO
         qANOYWqwpscxkCm8VbaWp3SkxsbwtNZltvrrRZMux+LKTd1Dh6obPLMATnyn0GrIBN
         Ym584yyaFZjTjy5ORVQot6HfkiG+Yc5OtZa2KH709+pAO034VuTDnfzUSH1fgwwZVK
         IvTc/Bq1aOsbsOjeCRyhgPjNXEOAOhlC+MTvooFlQEHIG1urTCFTyNooubr4Jj7Tlg
         KJOWHEG2VhE1GvzYWNC5KgD8TYT1PbLUrGb4SWmBrgrZV5tUxiSfmnftItyHT1/4A8
         aIeZC6wFZDWTA==
From:   trondmy@kernel.org
To:     Steve Dickson <SteveD@redhat.com>,
        "J.Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/6] nfs4_setacl: Add support for the --dacl and --sacl options
Date:   Sat, 14 May 2022 10:44:35 -0400
Message-Id: <20220514144436.4298-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514144436.4298-5-trondmy@kernel.org>
References: <20220514144436.4298-1-trondmy@kernel.org>
 <20220514144436.4298-2-trondmy@kernel.org>
 <20220514144436.4298-3-trondmy@kernel.org>
 <20220514144436.4298-4-trondmy@kernel.org>
 <20220514144436.4298-5-trondmy@kernel.org>
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
 nfs4_setfacl/nfs4_setfacl.c | 67 +++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/nfs4_setfacl/nfs4_setfacl.c b/nfs4_setfacl/nfs4_setfacl.c
index d0485ad53024..e5816085c8b0 100644
--- a/nfs4_setfacl/nfs4_setfacl.c
+++ b/nfs4_setfacl/nfs4_setfacl.c
@@ -79,6 +79,9 @@
 #define EDITOR  		"vi"  /* <- evangelism! */
 #define u32 u_int32_t
 
+#define OPT_DACL	0x98
+#define OPT_SACL	0x99
+
 static int apply_action(const char *, const struct stat *, int, struct FTW *);
 static int do_apply_action(const char *, const struct stat *);
 static int open_editor(const char *);
@@ -110,6 +113,8 @@ static struct option long_options[] = {
 	{ "recursive",		0, 0, 'R' },
 	{ "physical",		0, 0, 'P' },
 	{ "logical",		0, 0, 'L' },
+	{ "dacl",		0, 0, OPT_DACL },
+	{ "sacl",		0, 0, OPT_SACL },
 	{ NULL,			0, 0, 0,  },
 };
 
@@ -124,6 +129,8 @@ static char *mod_string;
 static char *from_ace;
 static char *to_ace;
 
+static enum acl_type acl_type = ACL_TYPE_ACL;
+
 /* XXX: things we need to handle:
  *
  *  - we need some sort of 'purge' operation that completely clears an ACL.
@@ -272,6 +279,13 @@ int main(int argc, char **argv)
 				paths[numpaths++] = optarg;
 				break;
 
+			case OPT_DACL:
+				acl_type = ACL_TYPE_DACL;
+				break;
+			case OPT_SACL:
+				acl_type = ACL_TYPE_SACL;
+				break;
+
 			case 'h':
 			case '?':
 			default:
@@ -334,6 +348,50 @@ out:
 	return err;
 }
 
+static void nfs4_print_acl_error(const char *path)
+{
+	switch (errno) {
+	case ENODATA:
+		fprintf(stderr,"Attribute not found on file: %s\n", path);
+		break;
+	case EREMOTEIO:
+		fprintf(stderr,"An NFS server error occurred.\n");
+		break;
+	case EOPNOTSUPP:
+		fprintf(stderr,"Operation to request attribute not supported: "
+			       "%s\n", path);
+		break;
+	default:
+		perror("Failed operation");
+	}
+}
+
+static struct nfs4_acl *nfs4_retrieve_acl(const char *path,
+					  enum acl_type type)
+{
+	switch (type) {
+	case ACL_TYPE_DACL:
+		return nfs4_getdacl(path);
+	case ACL_TYPE_SACL:
+		return nfs4_getsacl(path);
+	default:
+		return nfs4_getacl(path);
+	}
+}
+
+static int nfs4_apply_acl(const char *path, struct nfs4_acl *acl,
+			  enum acl_type type)
+{
+	switch (type) {
+	case ACL_TYPE_DACL:
+		return nfs4_setdacl(path, acl);
+	case ACL_TYPE_SACL:
+		return nfs4_setsacl(path, acl);
+	default:
+		return nfs4_setacl(path, acl);
+	}
+}
+
 /* returns 0 on success, nonzero on failure */
 static int apply_action(const char *_path, const struct stat *stat, int flag, struct FTW *ftw)
 {
@@ -378,7 +436,7 @@ static int do_apply_action(const char *path, const struct stat *_st)
 	if (action == SUBSTITUTE_ACTION)
 		acl = nfs4_new_acl(S_ISDIR(st->st_mode));
 	else
-		acl = nfs4_acl_for_path(path);
+		acl = nfs4_retrieve_acl(path, acl_type);
 
 	if (acl == NULL) {
 		fprintf(stderr, "Failed to instantiate ACL.\n");
@@ -438,8 +496,11 @@ static int do_apply_action(const char *path, const struct stat *_st)
 	if (is_test) {
 		fprintf(stderr, "## Test mode only - the resulting ACL for \"%s\": \n", path);
 		nfs4_print_acl(stdout, acl);
-	} else
-		err = nfs4_set_acl(acl, path);
+	} else {
+		err = nfs4_apply_acl(path, acl, acl_type);
+		if (err == -1)
+			nfs4_print_acl_error(path);
+	}
 
 out:
 	nfs4_free_acl(acl);
-- 
2.36.1

