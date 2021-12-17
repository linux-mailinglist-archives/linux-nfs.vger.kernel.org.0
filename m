Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C22A4795A5
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 21:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbhLQUnO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 15:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240854AbhLQUnL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 15:43:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0CEC061747
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 12:43:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3792B82A92
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 20:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BE5C36AE5;
        Fri, 17 Dec 2021 20:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639773786;
        bh=rnhhIpWtY8PNGtPdtpMDzct5kkYnqktEh8EeAQzezM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dynjfss6d2wErbAw4w+0lZDM09rs+CE6HvaEqexFjNXqIiHHsqYIpIOKrwl3K5Q81
         fyYZm9vAl8DJAuj24ybYnVlT9RAv0RJwI/pjH2jtydvl+HTYosJfINc9upk7wAf7eD
         Lt42AKkKycmvncf02+qQuJlsk2s+Gom0Cvt1HT2CU6+EcrUjl4/NcMNOMlm/iIwCGD
         /21GkSSSkIzciNZTRK6aUwFP8XGb27jQHnmphfZvRFD+4dwm/uPWeLLK+kOwQ4taEa
         thP4GYuYX3t3hdbKWgy53ZEhORes7jpcx9u0xme2moHa3JHGEALjgVFDgcE+FFOGor
         mt8DgeVc77rzQ==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/5] NFSv4: Just don't cache negative dentries on case insensitive servers
Date:   Fri, 17 Dec 2021 15:36:55 -0500
Message-Id: <20211217203658.439352-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217203658.439352-2-trondmy@kernel.org>
References: <20211217203658.439352-1-trondmy@kernel.org>
 <20211217203658.439352-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the directory contents change, we cannot rely on the negative dentry
being cacheable.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 731d31015b6a..2822681192b0 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1436,6 +1436,9 @@ int nfs_neg_need_reval(struct inode *dir, struct dentry *dentry,
 		return 0;
 	if (NFS_SERVER(dir)->flags & NFS_MOUNT_LOOKUP_CACHE_NONEG)
 		return 1;
+	/* Case insensitive server? Revalidate negative dentries */
+	if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE))
+		return 1;
 	return !nfs_check_verifier(dir, dentry, flags & LOOKUP_RCU);
 }
 
-- 
2.33.1

