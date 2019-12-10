Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02B27117FEB
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2019 06:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfLJFrL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Dec 2019 00:47:11 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46743 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfLJFrL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Dec 2019 00:47:11 -0500
Received: by mail-pl1-f196.google.com with SMTP id k20so6810800pll.13;
        Mon, 09 Dec 2019 21:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4PpU18WVGfu8W1dzcx6BhI1zCSeD4MNelLQRqcNILww=;
        b=h5ge2jCJXFDHTh1fWNcu/9O+pouL8MOCQbEZhpeRILATJTIZodskMGyfBI0trwPGi9
         RZaUTiMU+QaERHsiq82S1P5zomu67JjhrxMvp7pmJIUN+c3X53bU7H9m++MkmmE7f1DM
         mUU5gP1MAfR0M1GnsQQy5AgMzTvwcIkNKALNGg/X0P4KEtvx2GyaeR/fB9T4n+TGmjnv
         tq3q54IYY9Aug9l8RDTHBAcWSCVh6wjC2cfAchZwxgNlP5i5DsaiBtjjlvY9YSZUL/WE
         NuuOx0uIGb29R7dROxL2LwG8o+5YM8KrBpP1i8/DlHG7gdgT2mom/aB7MmFbAeIvQW3d
         FpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4PpU18WVGfu8W1dzcx6BhI1zCSeD4MNelLQRqcNILww=;
        b=Ari/iZ1BRjREVkNn9GcCiuQ+KE6R/WLSbfuSm/A1OQgAOmWDOxegKiZEX7V4Wz4lwQ
         IswtzX5fn9yAMc0PkIXQlbPOC2gkxbNAieRuSU61VarubPHKaLXIEwB31cJ0HZyBiSd3
         bqgY6MkgavBivJZLgKWbAKbkkpXDsuQqvDhvBJ4uDz9VPKN9V5zHRABJ+GbdxVbkzNrD
         uTBk5XC7sWlcshTXi3V6g/+uu4gDhs5Jrv+sem0JxGQpBQub6XYsPro0QA1rl7IXpuK2
         z6hZaxVKQnpg7SWJkjgqL6waTEwTFU/pliCaa5IYb24mn35HeOeMDzFR/7vmr1Fp01nH
         VdUg==
X-Gm-Message-State: APjAAAVac5YNbcaOGvBOlWt7QvKYO45Q4AzEtB9uXvuJwqqLsBaFq6pQ
        F95j84Jj82woPH0Js6mMKMo=
X-Google-Smtp-Source: APXvYqxXXcF/D0VDW40F8ndwD793QLu7WN4Wy9SPAeh1eHSRmWB3nlsOnuscllQ1evZKi4Vqv4acSg==
X-Received: by 2002:a17:902:8649:: with SMTP id y9mr33737643plt.67.1575956830540;
        Mon, 09 Dec 2019 21:47:10 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:13a2:ed96:d06d:42a7:9b38:e89c])
        by smtp.gmail.com with ESMTPSA id s2sm1433072pfb.109.2019.12.09.21.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 21:47:10 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        paulmck@kernel.org, joel@joelfernandes.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH] fs: nfs: dir.c: Fix sparse error
Date:   Tue, 10 Dec 2019 11:16:39 +0530
Message-Id: <20191210054639.30003-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch fixes the following sparse error:
fs/nfs/dir.c:2353:14: error: incompatible types in comparison expression (different address spaces):
fs/nfs/dir.c:2353:14:    struct list_head [noderef] <asn:4> *
fs/nfs/dir.c:2353:14:    struct list_head *

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e180033e35cf..b69370b6d317 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2350,7 +2350,7 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 	rcu_read_lock();
 	if (nfsi->cache_validity & NFS_INO_INVALID_ACCESS)
 		goto out;
-	lh = rcu_dereference(nfsi->access_cache_entry_lru.prev);
+	lh = rcu_dereference(list_tail_rcu(&nfsi->access_cache_entry_lru));
 	cache = list_entry(lh, struct nfs_access_entry, lru);
 	if (lh == &nfsi->access_cache_entry_lru ||
 	    cred != cache->cred)
-- 
2.17.1

