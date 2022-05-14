Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D8E527237
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbiENOvQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiENOvD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:51:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9198517ABC
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:50:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F6D7B808CF
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914EFC340EE;
        Sat, 14 May 2022 14:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652539844;
        bh=WEC8PsRGlYw3jcNP/Ogg7WlmDdggce5Cl0kX0a7nASo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RqvmXh5yHPLQGg4+OKwINl5mk5x74HeZvygiiGIWIMk3+QnOWm/2MmjRYsyYgjYoc
         sPslKIhzEhFbI6k5Z0UxuscpTxRphsPzA0MglAnLSpk57rrH2HJmym7NyoYyRmhclG
         IMs6UdCNWIBNp6J1I2cs79rOIbS/GhH/OiieeKNk586jVC3wOTpQiyHA+w8NR/UplK
         RhE17UiirkL1mfE9PfN+wKeLj4pLro4cLWoUvfXM/TKisfq7bVDL5yv7Inqvigqc5y
         zvqcR5SHgpmaSufORgK+b71+2YT5rxn+Lq1wXuoMLwdQrKLCEK9GoQSOL1DcDXW/xh
         cUBNN86IRgYig==
From:   trondmy@kernel.org
To:     Steve Dickson <SteveD@redhat.com>,
        "J.Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/6] libnfs4acl: Add support for the NFS4.1 ACE_INHERITED_ACE flag
Date:   Sat, 14 May 2022 10:44:32 -0400
Message-Id: <20220514144436.4298-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514144436.4298-2-trondmy@kernel.org>
References: <20220514144436.4298-1-trondmy@kernel.org>
 <20220514144436.4298-2-trondmy@kernel.org>
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

Use the letter 'I' to represent an inherited ACE.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/libacl_nfs4.h             | 1 +
 include/nfs4.h                    | 1 +
 libnfs4acl/nfs4_ace_from_string.c | 3 +++
 libnfs4acl/nfs4_get_ace_flags.c   | 2 ++
 nfs4_getfacl/nfs4_getfacl.c       | 1 +
 5 files changed, 8 insertions(+)

diff --git a/include/libacl_nfs4.h b/include/libacl_nfs4.h
index 76bbe90af54d..d54d82f94f97 100644
--- a/include/libacl_nfs4.h
+++ b/include/libacl_nfs4.h
@@ -54,6 +54,7 @@
 #define FLAG_SUCCESSFUL_ACCESS		'S'
 #define FLAG_FAILED_ACCESS		'F'
 #define FLAG_GROUP			'g'
+#define FLAG_INHERITED			'I'
 
 #define PERM_READ_DATA			'r'
 #define PERM_WRITE_DATA			'w'
diff --git a/include/nfs4.h b/include/nfs4.h
index da6eefb7fbc6..20bfa6b99634 100644
--- a/include/nfs4.h
+++ b/include/nfs4.h
@@ -62,6 +62,7 @@
 #define NFS4_ACE_SUCCESSFUL_ACCESS_ACE_FLAG   0x00000010
 #define NFS4_ACE_FAILED_ACCESS_ACE_FLAG       0x00000020
 #define NFS4_ACE_IDENTIFIER_GROUP             0x00000040
+#define NFS4_ACE_INHERITED_ACE                0x00000080
 
 #define NFS4_ACE_READ_DATA                    0x00000001
 #define NFS4_ACE_LIST_DIRECTORY               0x00000001
diff --git a/libnfs4acl/nfs4_ace_from_string.c b/libnfs4acl/nfs4_ace_from_string.c
index ab8401ae0629..7f1315434435 100644
--- a/libnfs4acl/nfs4_ace_from_string.c
+++ b/libnfs4acl/nfs4_ace_from_string.c
@@ -209,6 +209,9 @@ struct nfs4_ace * nfs4_ace_from_string(char *ace_buf, int is_dir)
 			case FLAG_GROUP:
 				flags |= NFS4_ACE_IDENTIFIER_GROUP;
 				break;
+			case FLAG_INHERITED:
+				flags |= NFS4_ACE_INHERITED_ACE;
+				break;
 			default:
 				fprintf(stderr,"Bad Ace Flag:%c\n", *field);
 				goto out_free;
diff --git a/libnfs4acl/nfs4_get_ace_flags.c b/libnfs4acl/nfs4_get_ace_flags.c
index 1d28ed4b5196..1f27d17ad4cd 100644
--- a/libnfs4acl/nfs4_get_ace_flags.c
+++ b/libnfs4acl/nfs4_get_ace_flags.c
@@ -53,6 +53,8 @@ char* nfs4_get_ace_flags(struct nfs4_ace *ace, char *buf)
 		*buf++ = FLAG_FAILED_ACCESS;;
 	if (flags & NFS4_ACE_IDENTIFIER_GROUP)
 		*buf++ = FLAG_GROUP;
+	if (flags & NFS4_ACE_INHERITED_ACE)
+		*buf++ = FLAG_INHERITED;
 	*buf = '\0';
 
 	return bp;
diff --git a/nfs4_getfacl/nfs4_getfacl.c b/nfs4_getfacl/nfs4_getfacl.c
index e068095b0d6b..1222dd907c9e 100644
--- a/nfs4_getfacl/nfs4_getfacl.c
+++ b/nfs4_getfacl/nfs4_getfacl.c
@@ -170,6 +170,7 @@ static void more_help()
 	"        'S'  successful-access\n"
 	"        'F'  failed-access\n"
 	"        'g'  group (denotes that <principal> is a group)\n"
+	"        'I'  inherited\n"
 	"\n"
 	"    * <principal> - named user or group, or one of: \"OWNER@\", \"GROUP@\", \"EVERYONE@\"\n"
 	"\n"
-- 
2.36.1

