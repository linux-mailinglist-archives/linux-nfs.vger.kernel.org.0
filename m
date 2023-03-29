Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDAC6CDB97
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Mar 2023 16:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjC2OJ3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Mar 2023 10:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjC2OJ0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Mar 2023 10:09:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CFC4C17
        for <linux-nfs@vger.kernel.org>; Wed, 29 Mar 2023 07:08:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 228B9B8232D
        for <linux-nfs@vger.kernel.org>; Wed, 29 Mar 2023 14:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805B1C433D2;
        Wed, 29 Mar 2023 14:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680098893;
        bh=WYIMfd7jDC+1GWpf5JZKzZffLjkpVi2BsA57sgKUkjY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AvQW4Nn1fCfqSVF7u9GfgLIoL6xSVQPOSkGz8TtmPQioOrZ9poCkNhDDchINHLZ8h
         UcL4z48ePjAHiQk8hurbGF8GzOMCZC8fvZPEDbkB89G+IBvGmLr6XTB/XH7RKYhpyd
         cSvroNS6WDtkNa3no5JG+pIJLpscOgu/dHW6BNQRnY2aI/FMdCtcnzdRAi680nrML1
         ghXpMEF+Z2vXNafokkIQDmknFyEQ1+hgi86G8g8OKc5E50eNJxw/oGni8pTaMYUxFz
         VPzmEP3Lf7XfKNK6MbKphge+QRN6HZjmSET/Dzt2O9eQBYvydTQuEXGANqstWk6B/V
         30xXz1CnueIQA==
Subject: [PATCH v2 1/4] libexports: Fix whitespace damage in
 support/nfs/exports.c
From:   Chuck Lever <cel@kernel.org>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org, rick.macklem@gmail.com,
        kernel-tls-handshake@lists.linux.dev
Date:   Wed, 29 Mar 2023 10:08:12 -0400
Message-ID: <168009889255.2522.14900308408258808762.stgit@manet.1015granger.net>
In-Reply-To: <168009806320.2522.10415374334827613451.stgit@manet.1015granger.net>
References: <168009806320.2522.10415374334827613451.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Clean up.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 support/nfs/exports.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index 2c8f0752ad9d..7f12383981c3 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -122,7 +122,7 @@ getexportent(int fromkernel, int fromexports)
 	if (first || (ok = getexport(exp, sizeof(exp))) == 0) {
 		has_default_opts = 0;
 		has_default_subtree_opts = 0;
-	
+
 		init_exportent(&def_ee, fromkernel);
 
 		ok = getpath(def_ee.e_path, sizeof(def_ee.e_path));
@@ -146,7 +146,7 @@ getexportent(int fromkernel, int fromexports)
 	if (exp[0] == '-' && !fromkernel) {
 		if (parseopts(exp + 1, &def_ee, 0, &has_default_subtree_opts) < 0)
 			return NULL;
-		
+
 		has_default_opts = 1;
 
 		ok = getexport(exp, sizeof(exp));
@@ -239,7 +239,6 @@ void secinfo_show(FILE *fp, struct exportent *ep)
 	if (ep->e_secinfo[0].flav == NULL)
 		secinfo_addflavor(find_flavor("sys"), ep);
 	for (p1=ep->e_secinfo; p1->flav; p1=p2) {
-
 		fprintf(fp, ",sec=%s", p1->flav->flavour);
 		for (p2=p1+1; (p2->flav != NULL) && (p1->flags == p2->flags);
 								p2++) {
@@ -621,7 +620,7 @@ parseopts(char *cp, struct exportent *ep, int warn, int *had_subtree_opt_ptr)
 			ep->e_anonuid = strtol(opt+8, &oe, 10);
 			if (opt[8]=='\0' || *oe != '\0') {
 				xlog(L_ERROR, "%s: %d: bad anonuid \"%s\"\n",
-				     flname, flline, opt);	
+				     flname, flline, opt);
 bad_option:
 				free(opt);
 				return -1;
@@ -631,7 +630,7 @@ bad_option:
 			ep->e_anongid = strtol(opt+8, &oe, 10);
 			if (opt[8]=='\0' || *oe != '\0') {
 				xlog(L_ERROR, "%s: %d: bad anongid \"%s\"\n",
-				     flname, flline, opt);	
+				     flname, flline, opt);
 				goto bad_option;
 			}
 		} else if (strncmp(opt, "squash_uids=", 12) == 0) {
@@ -649,13 +648,13 @@ bad_option:
 				setflags(NFSEXP_FSID, active, ep);
 			} else {
 				ep->e_fsid = strtoul(opt+5, &oe, 0);
-				if (opt[5]!='\0' && *oe == '\0') 
+				if (opt[5]!='\0' && *oe == '\0')
 					setflags(NFSEXP_FSID, active, ep);
 				else if (valid_uuid(opt+5))
 					ep->e_uuid = strdup(opt+5);
 				else {
 					xlog(L_ERROR, "%s: %d: bad fsid \"%s\"\n",
-					     flname, flline, opt);	
+					     flname, flline, opt);
 					goto bad_option;
 				}
 			}
@@ -709,7 +708,7 @@ out:
 	if (warn && !had_subtree_opt)
 		xlog(L_WARNING, "%s [%d]: Neither 'subtree_check' or 'no_subtree_check' specified for export \"%s:%s\".\n"
 				"  Assuming default behaviour ('no_subtree_check').\n"
-		     		"  NOTE: this default has changed since nfs-utils version 1.0.x\n",
+				"  NOTE: this default has changed since nfs-utils version 1.0.x\n",
 
 				flname, flline,
 				ep->e_hostname, ep->e_path);


