Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68564493040
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jan 2022 23:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349293AbiARWAT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jan 2022 17:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiARWAT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jan 2022 17:00:19 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D837DC061574
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jan 2022 14:00:18 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id F22986C0C; Tue, 18 Jan 2022 17:00:16 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org F22986C0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1642543216;
        bh=MmPaJ7SQ/ZgnQfvgzMR+1YqgblqtTeDgmqRRh+vB2+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KxO4E+xKAkWLKfofbLKYVIlWuNhnXy07/LqDId2t2pklLGb1aaWRsF0WHLaZpzQIw
         THDWEB6+J0Ul9wvqCT7pOsJXt/xNvZFj77qIcF44fyG98YzX6I2NtEoSLx89iHCeso
         SFrTDSIsL8PGwJ+s8g3EzpXzjU0a1F7OzoHQ4Ap4=
Date:   Tue, 18 Jan 2022 17:00:16 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Jonathan Woithe <jwoithe@just42.net>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/2] lockd: fix server crash on reboot of client holding lock
Message-ID: <20220118220016.GB16108@fieldses.org>
References: <20220114103901.GA22009@marvin.atrad.com.au>
 <C7A57602-4DDD-4952-BA38-03F819DBD296@oracle.com>
 <20220115081420.GB8808@marvin.atrad.com.au>
 <927EED04-840E-4DA6-B2B1-B604A7577B4E@oracle.com>
 <20220115212336.GB30050@marvin.atrad.com.au>
 <20220116220627.GA19813@marvin.atrad.com.au>
 <1E71316C-9EE8-4C71-ADA1-71E2910CA070@oracle.com>
 <20220117074430.GA22026@marvin.atrad.com.au>
 <20220117220851.GA8494@marvin.atrad.com.au>
 <20220117221156.GB3090@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117221156.GB3090@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

I thought I was iterating over the array when actually the iteration is
over the values contained in the array?

Ugh, keep it simple.

Symptoms were a null deference in vfs_lock_file() when an NFSv3 client
that previously held a lock came back up and sent a notify.

Reported-by: Jonathan Woithe <jwoithe@just42.net>
Fixes: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/lockd/svcsubs.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index cb3a7512c33e..54c2e42130ca 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -179,19 +179,20 @@ nlm_delete_file(struct nlm_file *file)
 static int nlm_unlock_files(struct nlm_file *file)
 {
 	struct file_lock lock;
-	struct file *f;
 
 	lock.fl_type  = F_UNLCK;
 	lock.fl_start = 0;
 	lock.fl_end   = OFFSET_MAX;
-	for (f = file->f_file[0]; f <= file->f_file[1]; f++) {
-		if (f && vfs_lock_file(f, F_SETLK, &lock, NULL) < 0) {
-			pr_warn("lockd: unlock failure in %s:%d\n",
-				__FILE__, __LINE__);
-			return 1;
-		}
-	}
+	if (file->f_file[O_RDONLY] &&
+	    vfs_lock_file(file->f_file[O_RDONLY], F_SETLK, &lock, NULL))
+		goto out_err;
+	if (file->f_file[O_WRONLY] &&
+	    vfs_lock_file(file->f_file[O_WRONLY], F_SETLK, &lock, NULL))
+		goto out_err;
 	return 0;
+out_err:
+	pr_warn("lockd: unlock failure in %s:%d\n", __FILE__, __LINE__);
+	return 1;
 }
 
 /*
-- 
2.34.1

