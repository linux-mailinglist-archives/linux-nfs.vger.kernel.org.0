Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1071835D1
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbfHFPyK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:54:10 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45597 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733105AbfHFPyJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:54:09 -0400
Received: by mail-oi1-f195.google.com with SMTP id m206so67303365oib.12;
        Tue, 06 Aug 2019 08:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=QnrcXAcJ7Zxl7prGWUMILJDKnfXF7uN4WFPQ5ciHeiY=;
        b=UmlAD5UKcslb9tjVX7hjQDdM1iuZ6/Yp566DA16Vyjd2fwtu6JcBQgXS1EM/IityOM
         pRJE3sgnzQ/gl4RlGudn0HZF5TSn3jovAMNKadHonXPS4FoWPDnddvUS1Do/srGjhDG/
         51PUHsX/Sttu/8UttaC3rj74QTZZBy7/xCVlqL2Hltq9GIH2+fb3pNwvZ1Fqxp/uGYkk
         CUadaMnqgBHFpPiBkeGPSzpkwBScimf+h+1nRDlR6xY9PexcytYgZ3pHeparmq/Fn6l7
         4eYmCacnOuVqnFCmmzSvawJHQRbK8i6pkn6VzWBfAMPjf8lUZZVijf3jYTbQ2VZWVqO0
         ucqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=QnrcXAcJ7Zxl7prGWUMILJDKnfXF7uN4WFPQ5ciHeiY=;
        b=CJEzXYfgJxYul/JgV/eIfqVEhY+4SwuosU0Dl9qbkO39DS+NbDE1nb5+QikCBtbFhe
         K8v/TrqVybwv7xHPk35LVXUhfkkLYRCj4aODfgW8Y8Wo+z74GQ2nxj99+YQ0NiXSxchH
         ghSTiNLxpCcUd6KOatkLM/eM87rDKmmC0qdMxGcJpN9RVjtlE/ErbKpFHwna/EqTT8K9
         n/2uTqojWq4AZtbXj6EuS/f3ej1UrFRN/otNX5Mn2UJ43F8DDdQVe2tKCSg8NBOvZHER
         Dd0ihP6Gii0ZzTxJFO/UjeMJMAaVHDFgl/tSF2lDaK9BgWVKFBEZdPouBxu+W0ET2lBo
         ghDQ==
X-Gm-Message-State: APjAAAVox+TPcX9gpo+GTmMbPt/xHqCivNhtUY9zIeZ0rd4uwimdrkw2
        ZA/YB3Q10BpFu29VijHdn2hBDlWv
X-Google-Smtp-Source: APXvYqxjm9SV+Gv6+nn501PFNeTKqM1Jz1W1/zbwZlTb+twb07Qn4DE6hpLVGyKOCUDhRdbV/P0QvQ==
X-Received: by 2002:a02:cc76:: with SMTP id j22mr4936236jaq.9.1565106848946;
        Tue, 06 Aug 2019 08:54:08 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x22sm65236245iob.84.2019.08.06.08.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:54:08 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76Fs7Us011523;
        Tue, 6 Aug 2019 15:54:07 GMT
Subject: [PATCH v1 04/18] xprtrdma: Boost client's max slot table size to
 match Linux server
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:54:07 -0400
Message-ID: <20190806155407.9529.39842.stgit@manet.1015granger.net>
In-Reply-To: <20190806155246.9529.14571.stgit@manet.1015granger.net>
References: <20190806155246.9529.14571.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've heard rumors of an NFS/RDMA server implementation that has a
default credit limit of 1024. The client's default setting remains
at 128.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xprtrdma.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/xprtrdma.h b/include/linux/sunrpc/xprtrdma.h
index 86fc38f..16c239e 100644
--- a/include/linux/sunrpc/xprtrdma.h
+++ b/include/linux/sunrpc/xprtrdma.h
@@ -49,9 +49,9 @@
  * fully-chunked NFS message (read chunks are the largest). Note only
  * a single chunk type per message is supported currently.
  */
-#define RPCRDMA_MIN_SLOT_TABLE	(2U)
+#define RPCRDMA_MIN_SLOT_TABLE	(4U)
 #define RPCRDMA_DEF_SLOT_TABLE	(128U)
-#define RPCRDMA_MAX_SLOT_TABLE	(256U)
+#define RPCRDMA_MAX_SLOT_TABLE	(16384U)
 
 #define RPCRDMA_MIN_INLINE  (1024)	/* min inline thresh */
 #define RPCRDMA_DEF_INLINE  (4096)	/* default inline thresh */

