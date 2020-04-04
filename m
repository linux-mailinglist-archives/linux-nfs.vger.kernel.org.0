Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A81E119E304
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2020 07:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgDDFgr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 4 Apr 2020 01:36:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46746 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgDDFgq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 4 Apr 2020 01:36:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id q3so4682196pff.13
        for <linux-nfs@vger.kernel.org>; Fri, 03 Apr 2020 22:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y5LZWQ+2og2pxUsuNjlgh915MdpETwWeVPIQzoYBrsY=;
        b=BWNL7lN80zcLgEINQHVVW3mXYnFOy70bZc8hTVZyLxk23p3rLUNXBlJlCTe3VOTq9Y
         77uM72LF2WyskM3OrNq4H0160ZOTAuFDiCCRMpVVYmcWcUkqwpp6Ei9TlsSaweIoIbGe
         XuLpWCb9atVEhWa4772HDcpEE5Qn5sGnXO477wzWJTPHT2ENKmWtiyZSI/7BCXNMg7VR
         QyE3tPhQx1nGkVGJWU5Lq8Ou5akfc9iijt5z8RBTWGgBV6Hir5L7xqOYIXqaq6tQS4iU
         DGFBgPQsF6oip5SEqQPaC2im7bkOCjxHvqjMvIjQlr7EGXbzw92nt3qGh7wu+u00e2XG
         WNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y5LZWQ+2og2pxUsuNjlgh915MdpETwWeVPIQzoYBrsY=;
        b=tpN7ceCNwhb9mSws6WotNrtXYkCe7x1Oa66yzMpWIzwrpW1m9EFGJJWknj9pPehMbF
         VBLFdx6+p/Xvf/VNh+2Z8S8hFJ3ITtKymJ2Sys3zUi1jK19cc/bQFTXDy99Ek1C4Shwn
         rbV64T3W7dckjQM0TV7UA/KSG2Snj/WzSdyl+q+o3J3+pSZLzY5Tm6Xj1EFL6265bgQj
         u1QYpvh2QVREYxJhI5zBOdP2MIrhByZGK4+IRp12IJTnJrM/5ROWt7Su5jUYstSScZh4
         07JXQtQCSLxaYk0JU9bwh9/9ZdooEfSZ7Xm9AK/p50HUhzTyPZiQaX1eRSviziqt7Ons
         f/Nw==
X-Gm-Message-State: AGi0PuY890+prEN4mG4YwEcw7XMZEQe8bG3rITvvJkJkXXhfnqiGcIHw
        519aPJDS12IlViVejFO3uHxKyTvhZrw=
X-Google-Smtp-Source: APiQypKtRNFV8Y1OV+VYL3jhqqLw2JyXFj5Hpu+0lanGc9Q3LAk1Wl6xrim0Gdk/tttYFRyXbn2DZw==
X-Received: by 2002:a63:3141:: with SMTP id x62mr11609437pgx.275.1585978605056;
        Fri, 03 Apr 2020 22:36:45 -0700 (PDT)
Received: from localhost.localdomain (astound-69-42-19-227.ca.astound.net. [69.42.19.227])
        by smtp.gmail.com with ESMTPSA id x75sm7009538pfc.161.2020.04.03.22.36.43
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 22:36:44 -0700 (PDT)
From:   Rosen Penev <rosenp@gmail.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsidmap: define NS_MAXMSG if undefined
Date:   Fri,  3 Apr 2020 22:36:42 -0700
Message-Id: <20200404053642.2632532-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

uClibc-ng does not define it.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 support/nfsidmap/libnfsidmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/libnfsidmap.c
index d11710f1..bce448cf 100644
--- a/support/nfsidmap/libnfsidmap.c
+++ b/support/nfsidmap/libnfsidmap.c
@@ -89,6 +89,10 @@ gid_t nobody_gid = (gid_t)-1;
 #define NFS4DNSTXTREC "_nfsv4idmapdomain"
 #endif
 
+#ifndef NS_MAXMSG
+#define NS_MAXMSG 65535
+#endif
+
 /* Default logging fuction */
 static void default_logger(const char *fmt, ...)
 {
-- 
2.25.1

