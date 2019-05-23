Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8A0B27FA9
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2019 16:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfEWO3G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 May 2019 10:29:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730818AbfEWO3G (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 May 2019 10:29:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C876C05B03F;
        Thu, 23 May 2019 14:29:05 +0000 (UTC)
Received: from bcodding.csb (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1916136F9;
        Thu, 23 May 2019 14:29:05 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id BD634109C3CC; Thu, 23 May 2019 10:28:41 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     "J . Bruce Fields" <bfields@redhat.com>, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/5] lockd: prepare nlm_lockowner for use by the server
Date:   Thu, 23 May 2019 10:28:37 -0400
Message-Id: <b9e00c87d9664e0a1ca675ddeaa88fa40335a88c.1558620385.git.bcodding@redhat.com>
In-Reply-To: <cover.1558620385.git.bcodding@redhat.com>
References: <cover.1558620385.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 23 May 2019 14:29:05 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The nlm_lockowner structure that the client uses to track locks is
generally useful to the server as well.  Very similar functions to handle
allocation and tracking of the nlm_lockowner will follow. Rename the client
fuctions for clarity.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/lockd/clntproc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index d9c32d1a20c0..529f0be547bc 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -46,13 +46,14 @@ void nlmclnt_next_cookie(struct nlm_cookie *c)
 	c->len=4;
 }
 
-static struct nlm_lockowner *nlm_get_lockowner(struct nlm_lockowner *lockowner)
+static struct nlm_lockowner *
+nlmclnt_get_lockowner(struct nlm_lockowner *lockowner)
 {
 	refcount_inc(&lockowner->count);
 	return lockowner;
 }
 
-static void nlm_put_lockowner(struct nlm_lockowner *lockowner)
+void nlmclnt_put_lockowner(struct nlm_lockowner *lockowner)
 {
 	if (!refcount_dec_and_lock(&lockowner->count, &lockowner->host->h_lock))
 		return;
@@ -81,28 +82,28 @@ static inline uint32_t __nlm_alloc_pid(struct nlm_host *host)
 	return res;
 }
 
-static struct nlm_lockowner *__nlm_find_lockowner(struct nlm_host *host, fl_owner_t owner)
+static struct nlm_lockowner *__nlmclnt_find_lockowner(struct nlm_host *host, fl_owner_t owner)
 {
 	struct nlm_lockowner *lockowner;
 	list_for_each_entry(lockowner, &host->h_lockowners, list) {
 		if (lockowner->owner != owner)
 			continue;
-		return nlm_get_lockowner(lockowner);
+		return nlmclnt_get_lockowner(lockowner);
 	}
 	return NULL;
 }
 
-static struct nlm_lockowner *nlm_find_lockowner(struct nlm_host *host, fl_owner_t owner)
+static struct nlm_lockowner *nlmclnt_find_lockowner(struct nlm_host *host, fl_owner_t owner)
 {
 	struct nlm_lockowner *res, *new = NULL;
 
 	spin_lock(&host->h_lock);
-	res = __nlm_find_lockowner(host, owner);
+	res = __nlmclnt_find_lockowner(host, owner);
 	if (res == NULL) {
 		spin_unlock(&host->h_lock);
 		new = kmalloc(sizeof(*new), GFP_KERNEL);
 		spin_lock(&host->h_lock);
-		res = __nlm_find_lockowner(host, owner);
+		res = __nlmclnt_find_lockowner(host, owner);
 		if (res == NULL && new != NULL) {
 			res = new;
 			refcount_set(&new->count, 1);
@@ -456,7 +457,7 @@ static void nlmclnt_locks_copy_lock(struct file_lock *new, struct file_lock *fl)
 {
 	spin_lock(&fl->fl_u.nfs_fl.owner->host->h_lock);
 	new->fl_u.nfs_fl.state = fl->fl_u.nfs_fl.state;
-	new->fl_u.nfs_fl.owner = nlm_get_lockowner(fl->fl_u.nfs_fl.owner);
+	new->fl_u.nfs_fl.owner = nlmclnt_get_lockowner(fl->fl_u.nfs_fl.owner);
 	list_add_tail(&new->fl_u.nfs_fl.list, &fl->fl_u.nfs_fl.owner->host->h_granted);
 	spin_unlock(&fl->fl_u.nfs_fl.owner->host->h_lock);
 }
@@ -466,7 +467,7 @@ static void nlmclnt_locks_release_private(struct file_lock *fl)
 	spin_lock(&fl->fl_u.nfs_fl.owner->host->h_lock);
 	list_del(&fl->fl_u.nfs_fl.list);
 	spin_unlock(&fl->fl_u.nfs_fl.owner->host->h_lock);
-	nlm_put_lockowner(fl->fl_u.nfs_fl.owner);
+	nlmclnt_put_lockowner(fl->fl_u.nfs_fl.owner);
 }
 
 static const struct file_lock_operations nlmclnt_lock_ops = {
@@ -477,7 +478,7 @@ static const struct file_lock_operations nlmclnt_lock_ops = {
 static void nlmclnt_locks_init_private(struct file_lock *fl, struct nlm_host *host)
 {
 	fl->fl_u.nfs_fl.state = 0;
-	fl->fl_u.nfs_fl.owner = nlm_find_lockowner(host, fl->fl_owner);
+	fl->fl_u.nfs_fl.owner = nlmclnt_find_lockowner(host, fl->fl_owner);
 	INIT_LIST_HEAD(&fl->fl_u.nfs_fl.list);
 	fl->fl_ops = &nlmclnt_lock_ops;
 }
-- 
2.20.1

