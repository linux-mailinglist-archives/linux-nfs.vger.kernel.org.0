Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0718023A17
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2019 16:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbfETOdg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 May 2019 10:33:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbfETOdg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 May 2019 10:33:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D63B75D5FF;
        Mon, 20 May 2019 14:33:30 +0000 (UTC)
Received: from bcodding.csb (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9ECDF5D9CA;
        Mon, 20 May 2019 14:33:30 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 73D30109C3CB; Mon, 20 May 2019 10:33:07 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     "J . Bruce Fields" <bfields@fieldses.org>
Cc:     Xuewei Zhang <xueweiz@google.com>, linux-nfs@vger.kernel.org
Subject: [PATCH] Revert "lockd: Show pid of lockd for remote locks"
Date:   Mon, 20 May 2019 10:33:07 -0400
Message-Id: <952928a350da64fd8de3e1a79deb8cc23552972f.1558362681.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 20 May 2019 14:33:35 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This reverts most of commit b8eee0e90f97 ("lockd: Show pid of lockd for
remote locks"), which caused remote locks to not be differentiated between
remote processes for NLM.

We retain the fixup for setting the client's fl_pid to a negative value.

Fixes: b8eee0e90f97 ("lockd: Show pid of lockd for remote locks")
Cc: stable@vger.kernel.org

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/lockd/xdr.c  | 4 ++--
 fs/lockd/xdr4.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 9846f7e95282..7147e4aebecc 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -127,7 +127,7 @@ nlm_decode_lock(__be32 *p, struct nlm_lock *lock)
 
 	locks_init_lock(fl);
 	fl->fl_owner = current->files;
-	fl->fl_pid   = current->tgid;
+	fl->fl_pid   = (pid_t)lock->svid;
 	fl->fl_flags = FL_POSIX;
 	fl->fl_type  = F_RDLCK;		/* as good as anything else */
 	start = ntohl(*p++);
@@ -269,7 +269,7 @@ nlmsvc_decode_shareargs(struct svc_rqst *rqstp, __be32 *p)
 	memset(lock, 0, sizeof(*lock));
 	locks_init_lock(&lock->fl);
 	lock->svid = ~(u32) 0;
-	lock->fl.fl_pid = current->tgid;
+	lock->fl.fl_pid = (pid_t)lock->svid;
 
 	if (!(p = nlm_decode_cookie(p, &argp->cookie))
 	 || !(p = xdr_decode_string_inplace(p, &lock->caller,
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 70154f376695..7ed9edf9aed4 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -119,7 +119,7 @@ nlm4_decode_lock(__be32 *p, struct nlm_lock *lock)
 
 	locks_init_lock(fl);
 	fl->fl_owner = current->files;
-	fl->fl_pid   = current->tgid;
+	fl->fl_pid   = (pid_t)lock->svid;
 	fl->fl_flags = FL_POSIX;
 	fl->fl_type  = F_RDLCK;		/* as good as anything else */
 	p = xdr_decode_hyper(p, &start);
@@ -266,7 +266,7 @@ nlm4svc_decode_shareargs(struct svc_rqst *rqstp, __be32 *p)
 	memset(lock, 0, sizeof(*lock));
 	locks_init_lock(&lock->fl);
 	lock->svid = ~(u32) 0;
-	lock->fl.fl_pid = current->tgid;
+	lock->fl.fl_pid = (pid_t)lock->svid;
 
 	if (!(p = nlm4_decode_cookie(p, &argp->cookie))
 	 || !(p = xdr_decode_string_inplace(p, &lock->caller,
-- 
2.20.1

