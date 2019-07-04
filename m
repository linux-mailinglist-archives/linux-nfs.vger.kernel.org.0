Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 544485FEEF
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2019 02:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfGEAGQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Jul 2019 20:06:16 -0400
Received: from smtprelay0217.hostedemail.com ([216.40.44.217]:38912 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727313AbfGEAGQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Jul 2019 20:06:16 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 4CF6C18352282
        for <linux-nfs@vger.kernel.org>; Thu,  4 Jul 2019 23:58:06 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id BE6E11802A387;
        Thu,  4 Jul 2019 23:58:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1345:1359:1437:1534:1539:1567:1711:1714:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3865:4321:5007:6261:8603:10004:10848:11658:11914:12296:12297:12555:12895:12986:13069:13138:13231:13311:13357:14181:14384:14394:14721:21080:21627:30029:30054,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: foot67_6385f1f675e2e
X-Filterd-Recvd-Size: 1388
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Jul 2019 23:58:03 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] nfsd: Fix misuse of strlcpy
Date:   Thu,  4 Jul 2019 16:57:48 -0700
Message-Id: <b51141d12de77eb22101e81f9eb2c9cc44104d7a.1562283944.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1562283944.git.joe@perches.com>
References: <cover.1562283944.git.joe@perches.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Probable cut&paste typo - use the correct field size.

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/nfsd/nfs4idmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index 2961016097ac..d1f285245af8 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -83,7 +83,7 @@ ent_init(struct cache_head *cnew, struct cache_head *citm)
 	new->type = itm->type;
 
 	strlcpy(new->name, itm->name, sizeof(new->name));
-	strlcpy(new->authname, itm->authname, sizeof(new->name));
+	strlcpy(new->authname, itm->authname, sizeof(new->authname));
 }
 
 static void
-- 
2.15.0

