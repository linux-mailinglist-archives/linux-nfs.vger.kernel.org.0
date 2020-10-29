Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240E929F6D6
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Oct 2020 22:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgJ2V3C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Oct 2020 17:29:02 -0400
Received: from mail.itouring.de ([85.10.202.141]:41520 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgJ2V3B (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 29 Oct 2020 17:29:01 -0400
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Oct 2020 17:29:01 EDT
Received: from tux.applied-asynchrony.com (p5b07e9c2.dip0.t-ipconnect.de [91.7.233.194])
        by mail.itouring.de (Postfix) with ESMTPSA id AE355CC304D;
        Thu, 29 Oct 2020 22:18:58 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 6D489F015C5;
        Thu, 29 Oct 2020 22:18:58 +0100 (CET)
To:     linux-nfs@vger.kernel.org
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: [PATCH] nfs-utils: remove leftover debugging messages
Organization: Applied Asynchrony, Inc.
Cc:     Steve Dickson <steved@redhat.com>
Message-ID: <eff057db-38f8-6c5f-7378-8ce1343f84fa@applied-asynchrony.com>
Date:   Thu, 29 Oct 2020 22:18:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


After updating to nfs-utils-2.5.2 I noticed extra output on the console
when exporting mounts. Apparently commit 482e72ba04 forgot to remove some
debugging messages and accidentally committed them.

Signed-off-by: Holger Hoffstätte <holger@applied-asynchrony.com>
---
  support/misc/nfsd_path.c  | 2 +-
  utils/exportfs/exportfs.c | 3 ---
  2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
index 8efbfcd3..65e53c13 100644
--- a/support/misc/nfsd_path.c
+++ b/support/misc/nfsd_path.c
@@ -110,7 +110,7 @@ nfsd_setup_workqueue(void)
  
  	if (!rootdir)
  		return;
-printf("rootdir %s\n", rootdir);
+
  	nfsd_wq = xthread_workqueue_alloc();
  	if (!nfsd_wq)
  		return;
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 9d5e575b..cde5e517 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -176,10 +176,8 @@ main(int argc, char **argv)
  		xlog(L_ERROR, "-r and -u are incompatible");
  		return 1;
  	}
-printf("point 1\n");
  	if (!setup_state_path_names(progname, ETAB, ETABTMP, ETABLCK, &etab))
  		return 1;
-printf("point 2\n");
  	if (optind == argc && ! f_all) {
  		if (force_flush) {
  			cache_flush(1);
@@ -193,7 +191,6 @@ printf("point 2\n");
  			return 0;
  		}
  	}
-printf("point 3\n");
  
  	/*
  	 * Serialize things as best we can
-- 
2.29.1

