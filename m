Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C566C14D3
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Mar 2023 15:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjCTOf4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Mar 2023 10:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjCTOfy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Mar 2023 10:35:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4568823C5F
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 07:35:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3D3561558
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 14:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B33C433EF;
        Mon, 20 Mar 2023 14:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679322946;
        bh=Ho2a0Fb1NVpOC9wO5p7dPQkLq9nEpMEu/1j1Av1Vwf4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GSD1aOjQ/nvBRh1TesIDgVwlUtUIRCQ2a1pU5UDAZHaT5XpEURsduYGAL1V2LPYDS
         x5Nw7l/tjPaDiHnflkprgk4DwlXqjKLVXIYu+IfuUrPtZ5pWaNjYujIyUc5kTTn3Yl
         zDpXmZHoG2DsmdGBa4lU3esan+lhaFS1W+eg0BkbvZLzrN/1XcqY8vw7BqLdtP7cw2
         akQ21qw/73tRCCBCUqCxI8DtuX1iTgHx3K5UKur6D0lIevOYd0PHX3p0hw3hbIGYDk
         DCR8ewDfd9B7A8dwX2fhv1W7EnN1uCfcbgGwd+S8BkrpWg/hXUtN5iN3Ehiu2DhnUI
         9DIvzA1S7yNSg==
Subject: [PATCH v1 3/4] exportfs: Push xprtsec settings to the kernel
From:   Chuck Lever <cel@kernel.org>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 20 Mar 2023 10:35:44 -0400
Message-ID: <167932294491.3437.5540093843072637245.stgit@manet.1015granger.net>
In-Reply-To: <167932279970.3437.7130911928591001093.stgit@manet.1015granger.net>
References: <167932279970.3437.7130911928591001093.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 support/export/cache.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/support/export/cache.c b/support/export/cache.c
index 2497d4f48df3..9354f71db894 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -932,6 +932,7 @@ static void write_fsloc(char **bp, int *blen, struct exportent *ep)
 	release_replicas(servers);
 }
 #endif
+
 static void write_secinfo(char **bp, int *blen, struct exportent *ep, int flag_mask)
 {
 	struct sec_entry *p;
@@ -949,7 +950,20 @@ static void write_secinfo(char **bp, int *blen, struct exportent *ep, int flag_m
 		qword_addint(bp, blen, p->flav->fnum);
 		qword_addint(bp, blen, p->flags & flag_mask);
 	}
+}
+
+static void write_xprtsec(char **bp, int *blen, struct exportent *ep)
+{
+	struct xprtsec_entry *p;
+
+	for (p = ep->e_xprtsec; p->info; p++);
+	if (p == ep->e_xprtsec)
+		return;
 
+	qword_add(bp, blen, "xprtsec");
+	qword_addint(bp, blen, p - ep->e_xprtsec);
+	for (p = ep->e_xprtsec; p->info; p++)
+		qword_addint(bp, blen, p->info->number);
 }
 
 static int dump_to_cache(int f, char *buf, int blen, char *domain,
@@ -992,6 +1006,7 @@ static int dump_to_cache(int f, char *buf, int blen, char *domain,
 			qword_add(&bp, &blen, "uuid");
 			qword_addhex(&bp, &blen, u, 16);
 		}
+		write_xprtsec(&bp, &blen, exp);
 		xlog(D_AUTH, "granted access to %s for %s",
 		     path, *domain == '$' ? domain+1 : domain);
 	} else {


