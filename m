Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 924D21D048
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2019 22:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfENUET (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 May 2019 16:04:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfENUET (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 14 May 2019 16:04:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC80A5D5E6
        for <linux-nfs@vger.kernel.org>; Tue, 14 May 2019 20:04:19 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com.redhat.com (ovpn-116-241.phx2.redhat.com [10.3.116.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52DAD5D6A6
        for <linux-nfs@vger.kernel.org>; Tue, 14 May 2019 20:04:19 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] mount: Report correct error in the fall_back cases.
Date:   Tue, 14 May 2019 16:04:18 -0400
Message-Id: <20190514200418.19902-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 14 May 2019 20:04:19 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In mount auto negotiation, a v3 mount is tried
when the v4 fails with error that could mean
v4 is not supported.

When the v3 mount fails, the original v4 failure
should be used to set the errno, not the v3 failure.

Fixes:https://bugzilla.redhat.com/show_bug.cgi?id=1709961
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/mount/stropts.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
index 1bb7a73..901f995 100644
--- a/utils/mount/stropts.c
+++ b/utils/mount/stropts.c
@@ -889,7 +889,7 @@ out:
  */
 static int nfs_autonegotiate(struct nfsmount_info *mi)
 {
-	int result;
+	int result, olderrno;
 
 	result = nfs_try_mount_v4(mi);
 check_result:
@@ -949,7 +949,18 @@ fall_back:
 	if (mi->version.v_mode == V_GENERAL)
 		/* v2,3 fallback not allowed */
 		return result;
-	return nfs_try_mount_v3v2(mi, FALSE);
+
+	/*
+	 * Save the original errno in case the v3 
+	 * mount fails from one of the fall_back cases. 
+	 * Report the first failure not the v3 mount failure
+	 */
+	olderrno = errno;
+	if ((result = nfs_try_mount_v3v2(mi, FALSE)))
+		return result;
+
+	errno = olderrno;
+	return result;
 }
 
 /*
-- 
2.20.1

