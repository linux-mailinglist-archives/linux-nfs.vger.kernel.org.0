Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07F5C918B8
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Aug 2019 20:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfHRSVT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Aug 2019 14:21:19 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39665 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfHRSVS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Aug 2019 14:21:18 -0400
Received: by mail-io1-f65.google.com with SMTP id l7so16099202ioj.6
        for <linux-nfs@vger.kernel.org>; Sun, 18 Aug 2019 11:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e0FzJ3SCnYfgoRJMyYFvOTE7Uq0eJCh95e4kIH4zM2Q=;
        b=sW0zotvgAL03H4KRNUc5jOeW4tVMzXbGpb6P+P6gh1qqQCxU563eUcuu//L/dhRkoM
         4kUNcRBz1Cds5SYsmdroewWxyFch8pulltPTEpTt0yBfTrRS5hlx1v5CF/14yE4/WVob
         MV3TFF4wbKvxjjkGByPiot8d/V95Sx5rSKn7NKomn0619hTwcvqqTombM0OA1RxPODZS
         sAjISjNwxzjGznlCAXhXvlS0IiEo7Qz1piPbp4AKcPC0Ka3KwsykQtzVM1DKp38eL6zP
         2Ys0aclFRkcbtPeg2E4QIXv4tF6lGthEdnGFFjfjVbDlhbWmnOE2pWvTmcgHYBNX3ZW0
         smhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e0FzJ3SCnYfgoRJMyYFvOTE7Uq0eJCh95e4kIH4zM2Q=;
        b=O0sj1xrh6XkXoU5dHbL+LeOhnZyoFrR+ff7bsW/jb5kc5aCluup+ZYhc9YPaZWy0x3
         BP/slMvFNGFHv/GU9r1Job2ptrUA9+t4qK1BXY1lMSStS9MDWC7aya6W4GiDFSqxeKhk
         nZ/f6sIsCVDeg92rfHiVQKs+Y1wsgkL4HNaPTj8GyxlcwroDoUpMvIVjT53ftxkTxtCA
         TaVgazgVcTpEzxZP/3l/V3SnZTYl6DPccsAK+4OgF3dx9RcnnW3LIZZC9UF90aK+Ao3o
         vFBRmoRlHBbTcr7qr4lFvu2EtoCOiELW3izoEKprCAg7EujPA3GFjTJqOlFvskopvz1j
         RU2A==
X-Gm-Message-State: APjAAAU4036CRQ8M9EPDmWIFnNAn4l3CihhRZbyluEyQROlTujExh4XF
        yAo01ZRW+fwFkxyv0EuJAA==
X-Google-Smtp-Source: APXvYqwihKogACLPzfiEW1NScrF2KfOcLpWyxv+AHIOF0lYKHb40bX3hyn/YhEKlCuX4FrCkBoF6Xg==
X-Received: by 2002:a6b:7409:: with SMTP id s9mr8596114iog.210.1566152477441;
        Sun, 18 Aug 2019 11:21:17 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id n22sm10317844iob.37.2019.08.18.11.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:21:16 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 03/16] notify: export symbols for use by the knfsd file cache
Date:   Sun, 18 Aug 2019 14:18:46 -0400
Message-Id: <20190818181859.8458-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818181859.8458-3-trond.myklebust@hammerspace.com>
References: <20190818181859.8458-1-trond.myklebust@hammerspace.com>
 <20190818181859.8458-2-trond.myklebust@hammerspace.com>
 <20190818181859.8458-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@primarydata.com>

The knfsd file cache will need to detect when files are unlinked, so that
it can close the associated cached files. Export a minimal set of notifier
functions to allow it to do so.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/notify/fsnotify.h             | 2 --
 fs/notify/group.c                | 2 ++
 fs/notify/mark.c                 | 6 ++++++
 include/linux/fsnotify_backend.h | 2 ++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index 5a00121fb219..f3462828a0e2 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -54,8 +54,6 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
 {
 	fsnotify_destroy_marks(&sb->s_fsnotify_marks);
 }
-/* Wait until all marks queued for destruction are destroyed */
-extern void fsnotify_wait_marks_destroyed(void);
 
 /*
  * update the dentry->d_flags of all of inode's children to indicate if inode cares
diff --git a/fs/notify/group.c b/fs/notify/group.c
index 0391190305cc..133f723aca07 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -108,6 +108,7 @@ void fsnotify_put_group(struct fsnotify_group *group)
 	if (refcount_dec_and_test(&group->refcnt))
 		fsnotify_final_destroy_group(group);
 }
+EXPORT_SYMBOL_GPL(fsnotify_put_group);
 
 /*
  * Create a new fsnotify_group and hold a reference for the group returned.
@@ -137,6 +138,7 @@ struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
 
 	return group;
 }
+EXPORT_SYMBOL_GPL(fsnotify_alloc_group);
 
 int fsnotify_fasync(int fd, struct file *file, int on)
 {
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 99ddd126f6f0..1d96216dffd1 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -276,6 +276,7 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 	queue_delayed_work(system_unbound_wq, &reaper_work,
 			   FSNOTIFY_REAPER_DELAY);
 }
+EXPORT_SYMBOL_GPL(fsnotify_put_mark);
 
 /*
  * Get mark reference when we found the mark via lockless traversal of object
@@ -430,6 +431,7 @@ void fsnotify_destroy_mark(struct fsnotify_mark *mark,
 	mutex_unlock(&group->mark_mutex);
 	fsnotify_free_mark(mark);
 }
+EXPORT_SYMBOL_GPL(fsnotify_destroy_mark);
 
 /*
  * Sorting function for lists of fsnotify marks.
@@ -685,6 +687,7 @@ int fsnotify_add_mark(struct fsnotify_mark *mark, fsnotify_connp_t *connp,
 	mutex_unlock(&group->mark_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(fsnotify_add_mark);
 
 /*
  * Given a list of marks, find the mark associated with given group. If found
@@ -711,6 +714,7 @@ struct fsnotify_mark *fsnotify_find_mark(fsnotify_connp_t *connp,
 	spin_unlock(&conn->lock);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(fsnotify_find_mark);
 
 /* Clear any marks in a group with given type mask */
 void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
@@ -809,6 +813,7 @@ void fsnotify_init_mark(struct fsnotify_mark *mark,
 	mark->group = group;
 	WRITE_ONCE(mark->connector, NULL);
 }
+EXPORT_SYMBOL_GPL(fsnotify_init_mark);
 
 /*
  * Destroy all marks in destroy_list, waits for SRCU period to finish before
@@ -837,3 +842,4 @@ void fsnotify_wait_marks_destroyed(void)
 {
 	flush_delayed_work(&reaper_work);
 }
+EXPORT_SYMBOL_GPL(fsnotify_wait_marks_destroyed);
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 2de3b2ddd19a..1915bdba2fad 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -475,6 +475,8 @@ extern void fsnotify_destroy_mark(struct fsnotify_mark *mark,
 extern void fsnotify_detach_mark(struct fsnotify_mark *mark);
 /* free mark */
 extern void fsnotify_free_mark(struct fsnotify_mark *mark);
+/* Wait until all marks queued for destruction are destroyed */
+extern void fsnotify_wait_marks_destroyed(void);
 /* run all the marks in a group, and clear all of the marks attached to given object type */
 extern void fsnotify_clear_marks_by_group(struct fsnotify_group *group, unsigned int type);
 /* run all the marks in a group, and clear all of the vfsmount marks */
-- 
2.21.0

