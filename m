Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D249413176C
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 19:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgAFSW5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 13:22:57 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37501 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgAFSW5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 13:22:57 -0500
Received: by mail-yb1-f193.google.com with SMTP id x14so22442362ybr.4
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 10:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WBGMjPijPmiyMt/LvriU5HH36qGZ3geiwIbw5s0fB9E=;
        b=epfUivBNeGiYNXRucyYAlWdc6QQ5q8/MUs6z0tqWqIJbnQQVIpHDTs4pSo6El3wF9i
         8lHpRmc5PE4I+PE+Fhrpa5dAOChmlAL00vkv2/31MwPFLtptwLHz175upM+PyxkdcvjQ
         5jvRdgni/rXYaNEMr1PQLgSGuO8AjUYfgV9IZ1s1At/et8CcsTih2hAs3jX875BhJP9o
         YdNwRcI0qb0ZbA76EtjNhiZSwApjFNLCyvQHsLoInRj6+2ztkL6wJ00xSRRIofUtrQwi
         +vpThzy+1OTDwfHV8KGh8XfE5iEkdg5V4O372TSSmSpkr5bytpi2cNCY/nNCf6LhHLyu
         lX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WBGMjPijPmiyMt/LvriU5HH36qGZ3geiwIbw5s0fB9E=;
        b=TeDWp8RiFMVc4Zm1m7b3F787uEFAiyXX+O2cbrX18LDmsqwi1rM7Ki+oIUJQ1DzK7z
         /wuEqa2yQxmxGizcT7/BnbkOC/pTYJNE40fuzj4PG+oRAoPkPRyCNrE1ER2pQgJvyIb1
         +Wr69+RDJ54nz93OGkVZ6ZY640UQaDPn3cyP+z9ffkZDHqeGxMQayMU6YJsUz9SMEHEs
         ApiY+jdotkYk6dZfrnlY2Ay0TZ7maNVQLnNxrEGgdP3x+wZ4+XdzdlIstfFWdfFVz0L0
         jKORniNUYZ1sTjv3TrJVCuLOYIi12GXKuMoryurmJ+2Ocv92JJY1vKkamQEXEOWAJGrm
         42tA==
X-Gm-Message-State: APjAAAU6vUlJbqIjLllg6RV02kQuBOwyannnDFsqSQHrdi/K9nk5Ve+6
        6Vh5PPPfGprHy5NELawqBw==
X-Google-Smtp-Source: APXvYqzJAe5bSlOASbD/KIjRVqUsxywBbOfPP6q3LZHXSxU+a04YA885LaLK+6MMV5iDsfviuS/oVQ==
X-Received: by 2002:a25:8009:: with SMTP id m9mr46039341ybk.208.1578334976513;
        Mon, 06 Jan 2020 10:22:56 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id a23sm27940630ywa.32.2020.01.06.10.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 10:22:55 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: Fix a soft lockup race in nfsd_file_mark_find_or_create()
Date:   Mon,  6 Jan 2020 13:20:47 -0500
Message-Id: <20200106182047.563178-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If nfsd_file_mark_find_or_create() keeps winning the race for the
nfsd_file_fsnotify_group->mark_mutex against nfsd_file_mark_put()
then it can soft lock up, since fsnotify_add_inode_mark() ends
up always finding an existing entry.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/filecache.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 9c2b29e07975..f275c11c4e28 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -132,9 +132,13 @@ nfsd_file_mark_find_or_create(struct nfsd_file *nf)
 						 struct nfsd_file_mark,
 						 nfm_mark));
 			mutex_unlock(&nfsd_file_fsnotify_group->mark_mutex);
-			fsnotify_put_mark(mark);
-			if (likely(nfm))
+			if (nfm) {
+				fsnotify_put_mark(mark);
 				break;
+			}
+			/* Avoid soft lockup race with nfsd_file_mark_put() */
+			fsnotify_destroy_mark(mark, nfsd_file_fsnotify_group);
+			fsnotify_put_mark(mark);
 		} else
 			mutex_unlock(&nfsd_file_fsnotify_group->mark_mutex);
 
-- 
2.24.1

