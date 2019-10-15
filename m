Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1EB0D7C40
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2019 18:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfJOQrH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Oct 2019 12:47:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38056 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfJOQrH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Oct 2019 12:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QkErEHMR2lVtAAo1wy1WfFiwDzajHOHLSvyZU3A60Gk=; b=o3raxPL3PWJwRiodkOsKHulPq
        yi41OQn9hfwg50w98rkcbzvySt51Lj9vF5FCr50typYyLNNndfuuUMdc1q02g4OYCadwuqJiEauBM
        Mf0Y9H7iYDlqJtvqUSplE7TTNcebh5TShGX5Th4s2riqgbrcirK6UrqTtzY81sjATh60D6F8amHKb
        fcwiyT5Z5ZoL7hD5GbUY/qnmOfr2HyEr5RfTL7uelDyO9lgo67SpHiIGycK5wecqDHV1I6nMC17K0
        G1mOhApzmmgxXkwtiyZR5KdEv+K36xpLSe74mG2QSDA5U0DFT4w4Z2dxjZx1CRYKeaAeYHKsFieug
        AgW7Odrxw==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKPyU-0008EX-LQ
        for linux-nfs@vger.kernel.org; Tue, 15 Oct 2019 16:47:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] lockd: remove __KERNEL__ ifdefs
Date:   Tue, 15 Oct 2019 18:46:59 +0200
Message-Id: <20191015164659.16339-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191015164659.16339-1-hch@lst.de>
References: <20191015164659.16339-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Remove the __KERNEL__ ifdefs from the non-UAPI sunrpc headers,
as those can't be included from user space programs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/lockd/debug.h | 4 ----
 include/linux/lockd/lockd.h | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/include/linux/lockd/debug.h b/include/linux/lockd/debug.h
index e536c579827f..eede2ab5246f 100644
--- a/include/linux/lockd/debug.h
+++ b/include/linux/lockd/debug.h
@@ -10,8 +10,6 @@
 #ifndef LINUX_LOCKD_DEBUG_H
 #define LINUX_LOCKD_DEBUG_H
 
-#ifdef __KERNEL__
-
 #include <linux/sunrpc/debug.h>
 
 /*
@@ -25,8 +23,6 @@
 # define ifdebug(flag)		if (0)
 #endif
 
-#endif /* __KERNEL__ */
-
 /*
  * Debug flags
  */
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index d294dde9e546..666f5f310a04 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -10,8 +10,6 @@
 #ifndef LINUX_LOCKD_LOCKD_H
 #define LINUX_LOCKD_LOCKD_H
 
-#ifdef __KERNEL__
-
 #include <linux/in.h>
 #include <linux/in6.h>
 #include <net/ipv6.h>
@@ -373,6 +371,4 @@ static inline int nlm_compare_locks(const struct file_lock *fl1,
 
 extern const struct lock_manager_operations nlmsvc_lock_operations;
 
-#endif /* __KERNEL__ */
-
 #endif /* LINUX_LOCKD_LOCKD_H */
-- 
2.20.1

