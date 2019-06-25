Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B0E55942
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2019 22:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfFYUnZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jun 2019 16:43:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46759 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfFYUnZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jun 2019 16:43:25 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so12806iol.13
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2019 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XOl1nsurZyPkVilKy+h7iNzd4SGzry0oEW0gzl9XHl0=;
        b=EDOntcmjeWSP0MHE3MWbUpMsRjnQvUcQ9Yuz7AUxW4bThJUHOw3qXMPopxziIWkPiJ
         +vYC0/qDxxN2XIm9/RopoXnKfK8ZqJ7BM4peq9TjjpMYGIOTbMCDphxvKQvMnYnsJzc+
         2CMq+P07MRI5w1i/xZqp4pJnLmeWqZbfgXi2cTT1MQujv4nifHLRk7U4QAbhMuO/La04
         x5GFt1HqtlAHsYEG0zv0GMwYE6akwTp6nEcWMZDds6rEjq9rfjfM2ufpQGbisBNZC94s
         ZSNrU/KSjSI7mmZxasUkYshxaTaHwjmnVaVolXKyFkYZUGn1lXtc9WbefoGOkoCEVYAp
         /vKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XOl1nsurZyPkVilKy+h7iNzd4SGzry0oEW0gzl9XHl0=;
        b=RqCTZrMX8BYnz050n0knGF7VhdIBZJK+hwtvYw00KXKp0SzEnpPbdExpROPx9vQ2GK
         Sk67+PZJrmmvv0fT2nVqZbS2q99guij+alTC/C2ZsDdSOQ43Zen6gOHLYX84qEdM89X1
         FMs3CMuuVnFrmmvACzh4XgigQjFzeJcnwKud4B4KweotpaTc4GF/CLlNwRXzNzTqeJo7
         CDr/rzkOn8ykMYfKG1WxftPy3NMBKH/ebZI9Zy1afw+tdYfh19W7Gh5IZU3Xm8/vgb87
         OiVbxc1As/4s1ZN6wBQSWNkhwwvn8DmuONe85DiqlMcpp914CCGGr7KvqGjzDBZThVHW
         K1BQ==
X-Gm-Message-State: APjAAAWFepDlJRqLONhcl0tiiwrl12RllVPdYrofBnQFOyFn4NiAd3LM
        pHHchsF3HhEx4DIUUU3laQ==
X-Google-Smtp-Source: APXvYqwosXs+6laJuBwPuEUi49Oxpms0NFomJpkQV9vcWPy8Eo9xruq3pzo9tHpGusrktXi679OfOw==
X-Received: by 2002:a6b:5a17:: with SMTP id o23mr713422iob.41.1561495404549;
        Tue, 25 Jun 2019 13:43:24 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id t133sm31278049iof.21.2019.06.25.13.43.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 13:43:23 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS/flexfiles: Use the correct TCP timeout for flexfiles I/O
Date:   Tue, 25 Jun 2019 16:41:16 -0400
Message-Id: <20190625204116.19825-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fix a typo where we're confusing the default TCP retrans value
(NFS_DEF_TCP_RETRANS) for the default TCP timeout value.

Fixes: 15d03055cf39f ("pNFS/flexfiles: Set reasonable default ...")
Cc: stable@vger.kernel.org # 4.8+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index a809989807d6..19f856f45689 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -18,7 +18,7 @@
 
 #define NFSDBG_FACILITY		NFSDBG_PNFS_LD
 
-static unsigned int dataserver_timeo = NFS_DEF_TCP_RETRANS;
+static unsigned int dataserver_timeo = NFS_DEF_TCP_TIMEO;
 static unsigned int dataserver_retrans;
 
 static bool ff_layout_has_available_ds(struct pnfs_layout_segment *lseg);
-- 
2.21.0

