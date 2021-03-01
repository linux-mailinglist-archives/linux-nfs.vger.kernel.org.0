Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C06327610
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 03:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhCACSa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Feb 2021 21:18:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:58482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231802AbhCACS3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 28 Feb 2021 21:18:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E73D5AF77;
        Mon,  1 Mar 2021 02:17:47 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <SteveD@RedHat.com>
Date:   Mon, 01 Mar 2021 13:17:15 +1100
Subject: [PATCH 2/5] mountd: Don't proactively add export info when fh info is
 requested.
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Message-ID: <161456503508.22801.10952444290383474947.stgit@noble>
In-Reply-To: <161456493684.22801.323431390819102360.stgit@noble>
References: <161456493684.22801.323431390819102360.stgit@noble>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: NeilBrown <neil@brown.name>

When an "nfsd.fh" request is received from the kernel, we map the
file-handle prefix to a path name and report that (as required) and then
also add "nfsd.export" information with export flags applicable to that
path.

This is not necessary and was added as a perceived optimisation.
When updating data already in the kernel, it is unlikely to help as the
kernel can be expected to ask for both details at much the same time.
With NFSv3, new information is normally added by a MOUNT rpc request, so
this is irrelevant.
With NFSv4, the kernel requests the "nfsd.export" information when
walking down from ROOT, *before* requesting the nfsd.fh information, so
this "optimisation" causes unnecessary work.

A future patch will add logging of authentication requests, and this
double-handling would result in extra unnecessary log messages.

As this "optimisation" appears to have no practical value and some
(small) cost, let's remove it.

Signed-off-by: NeilBrown <neil@brown.name>
---
 support/export/cache.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 156ebfd4087c..49a761749ec6 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -96,7 +96,6 @@ static bool path_lookup_error(int err)
  * Record is terminated with newline.
  *
  */
-static int cache_export_ent(char *buf, int buflen, char *domain, struct exportent *exp, char *path);
 
 #define INITIAL_MANAGED_GROUPS 100
 
@@ -870,18 +869,13 @@ static void nfsd_fh(int f)
 	    !is_mountpoint(found->e_mountpoint[0]?
 			   found->e_mountpoint:
 			   found->e_path)) {
-		/* Cannot export this yet 
+		/* Cannot export this yet
 		 * should log a warning, but need to rate limit
 		   xlog(L_WARNING, "%s not exported as %d not a mountpoint",
 		   found->e_path, found->e_mountpoint);
 		 */
 		/* FIXME we need to make sure we re-visit this later */
 		goto out;
-	} else if (cache_export_ent(buf, sizeof(buf), dom, found, found_path) < 0) {
-		if (!path_lookup_error(errno))
-			goto out;
-		/* The kernel is saying the path is unexportable */
-		found = NULL;
 	}
 
 	bp = buf; blen = sizeof(buf);


