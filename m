Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E77F945A
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2019 16:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKLPeb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Nov 2019 10:34:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLPeb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Nov 2019 10:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QkErEHMR2lVtAAo1wy1WfFiwDzajHOHLSvyZU3A60Gk=; b=ZNwXZp2/646qRK4nWho1+RDl6R
        MtLSBR8uWZkDf2+4ybzfsPrX+aSQgpyLuaSXrn2UQDLKxleZZrJcoOjzbfnqvsVarCubwOjki63EV
        0Jf7hzfe7NYnmEMQO72PbgTQZf2PKUjyM32OeKPqoV1KLq34knCr9lvNve5RHRaNWPK4sbEHxe0va
        2NUBXG7cH/HXnNLARo5t6Y5/atuJFRhQOXtNyCkYJbN8dW1n+Iqsb01Pa60C7XYamH0diDlUjLTMS
        +8MfXht5legrZEtWUZqorhP24Cp3bhz0Kixa36Mi9Jht9Tmi2gHgwm2ZYezyXSfNcn6UgVAisg++Y
        ACrsqrqQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUYBZ-0002fH-E6; Tue, 12 Nov 2019 15:34:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] lockd: remove __KERNEL__ ifdefs
Date:   Tue, 12 Nov 2019 16:34:23 +0100
Message-Id: <20191112153423.27337-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191112153423.27337-1-hch@lst.de>
References: <20191112153423.27337-1-hch@lst.de>
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

