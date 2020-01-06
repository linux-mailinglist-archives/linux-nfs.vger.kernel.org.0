Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD56131763
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 19:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgAFSU0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 13:20:26 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:47075 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFSUZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 13:20:25 -0500
Received: by mail-yb1-f193.google.com with SMTP id k128so11451628ybc.13
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 10:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rtsdhCrWJX5DzFNesThGe18gpecWEgRIZqACkkfv9FA=;
        b=hLMKcID/Xevb2W4Cd7mfa+CTclzY755gzF/d8BmPejubC682KWHkY07DSzTaD7Z2PL
         972kBiiTSf6HPED4E7ULjQnix9p2QOJKFV0NQKV+7NJZAsGrhbQgWOu6hXNsiU1BBUCN
         /yHgE+lmo8G27C8hRtqN9ZkFL/QMfP7vd9mjfw5SaoS1dGVOAwwjR5lwOwWfg+BJwHtt
         s2lrNlq5HtLlKQt6LuRcZKdQkikjpSQ4Dx72CDBN6AJ9SaeBc4akf8jDcZJZJmr0TiT7
         OxmX6mAmZr3cJXlA7w7uJPXZZfYfzH86i26BOqUHGeAID+wyoLFGOK1H4roIblpSU+4F
         K/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rtsdhCrWJX5DzFNesThGe18gpecWEgRIZqACkkfv9FA=;
        b=Bk7eD9frxIXPrKWq5Y+p7EvkU+syzIOKTkGxUPzemyX9EUffTtwxaPMVliweY7T4fd
         9HDJ5XGf9E+ltVNY1EnsT+9MaDJwmBK4SpnXvOUnvyXzzeMM3GJ2u+7C6fL5IdjogbFo
         dGVQWGgZgupe5bE6gPYoZFTun5tgQhDNz0IbFHE8NLiRXGmb2C01SY++U2BdhHi6qp7k
         95lmZuF6F8deYEIjI6dV4XKLRGiTTNjL1t8+27ZmT1HMI9cVDBEk6byHaQuN8UtAfUku
         ovefYTSFOhPTKhsinKO/UjMk7Q6ECCCjYR1ZzSdUPQ6x2FFY7NR5jUN9r3tsnuxbF4gW
         Wr6g==
X-Gm-Message-State: APjAAAXUfFoOnZprY8/bkZVzRBh055ecLDXh6wBix7AUJEtvInRCo6ud
        hNDiT1QQdHvrtT1e2yQWjV+qGr3lew==
X-Google-Smtp-Source: APXvYqwGwgbvKBUnvYTSapiB2dOBRuhX09qdl4Z7eG5UuTYAyrdbDHuKOwu54dMq+JJocQNNnKKkVw==
X-Received: by 2002:a25:743:: with SMTP id 64mr77285395ybh.178.1578334824728;
        Mon, 06 Jan 2020 10:20:24 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id r31sm24800524ywa.82.2020.01.06.10.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 10:20:24 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RESEND 2/6] nfsd: cleanup nfsd_file_lru_dispose()
Date:   Mon,  6 Jan 2020 13:18:04 -0500
Message-Id: <20200106181808.562969-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106181808.562969-2-trond.myklebust@hammerspace.com>
References: <20200106181808.562969-1-trond.myklebust@hammerspace.com>
 <20200106181808.562969-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/filecache.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 0a3e5c2aac4b..c048e3071db7 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -256,8 +256,6 @@ nfsd_file_do_unhash(struct nfsd_file *nf)
 		nfsd_reset_boot_verifier(net_generic(nf->nf_net, nfsd_net_id));
 	--nfsd_file_hashtbl[nf->nf_hashval].nfb_count;
 	hlist_del_rcu(&nf->nf_node);
-	if (!list_empty(&nf->nf_lru))
-		list_lru_del(&nfsd_file_lru, &nf->nf_lru);
 	atomic_long_dec(&nfsd_filecache_count);
 }
 
@@ -266,6 +264,8 @@ nfsd_file_unhash(struct nfsd_file *nf)
 {
 	if (test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
 		nfsd_file_do_unhash(nf);
+		if (!list_empty(&nf->nf_lru))
+			list_lru_del(&nfsd_file_lru, &nf->nf_lru);
 		return true;
 	}
 	return false;
@@ -402,15 +402,14 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 static void
 nfsd_file_lru_dispose(struct list_head *head)
 {
-	while(!list_empty(head)) {
-		struct nfsd_file *nf = list_first_entry(head,
-				struct nfsd_file, nf_lru);
-		list_del_init(&nf->nf_lru);
+	struct nfsd_file *nf;
+
+	list_for_each_entry(nf, head, nf_lru) {
 		spin_lock(&nfsd_file_hashtbl[nf->nf_hashval].nfb_lock);
 		nfsd_file_do_unhash(nf);
 		spin_unlock(&nfsd_file_hashtbl[nf->nf_hashval].nfb_lock);
-		nfsd_file_put_noref(nf);
 	}
+	nfsd_file_dispose_list(head);
 }
 
 static unsigned long
-- 
2.24.1

