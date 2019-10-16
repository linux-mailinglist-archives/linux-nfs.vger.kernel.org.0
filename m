Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8695D9386
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2019 16:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392913AbfJPOSA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Oct 2019 10:18:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42627 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730937AbfJPOSA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Oct 2019 10:18:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id w14so36285634qto.9
        for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2019 07:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BdHrLxCp9g5Df1l1kF4KftxpClGxEjwux4GL0qZITMk=;
        b=Ozqy19Y1fdooxczI7Ku9sZKiDiw2Tzo09xfUi5VqAmCwCQnE1yloC5Ff6O6xeoQElh
         ePPycxWevBZl0/wV+5rDz4mEjHwKUcWyaYjeYAXvb5sIFnzSj3X/IykJT3bR61MxLxYY
         D8v4klDksNRvbW9uY8mV25Rcpkl9iIB+zXL/gD2787Ot+yqcHIo21FKUcUZBLl9iy10P
         WTJbdX2pWMLGXXKTLMysuScMa1Pdbf+yprRlhSKFUaLrkgwYYdtzBKZ1BHpDrwrC/GFG
         WwY0I4qmIkotff02z94zPb/lgT0S617pkIsXDL/qWjoNhxf3Z35O8q2556IV8gV59FgA
         //gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdHrLxCp9g5Df1l1kF4KftxpClGxEjwux4GL0qZITMk=;
        b=IXKC8pq8t+E+0FFVRPuU+bCBzG+dobvudKSdxnci7PUBUpDpZq7OgmCfP8VVJcxXBY
         fdS5Ng2oX3CgjrPCKGef+54l2J5Z8aZequXpgoF0XNdc5fuZ0C0s5OEexe1JAElXPbvB
         J1bUNd3SnGjE5UAfLtCJ0N8nlQW3hofpnalcO5+Cx4/4R7oZ+gOXst90b5rlz+NO/MwN
         aeFYB5vG/7GEPz7xEXE2wOtTqxBST8DTtxHfWVkaMhyolHGLjOSePkO/tQGkr6QRX91D
         c6JFq+DJqRem5euABwQpcAz/8tLLeVJO36iZLf6S/LE8ffSUiiJW7/kV8gCkvaNTq/PH
         jHTg==
X-Gm-Message-State: APjAAAVDou80TXnWCnt9UHJ/KsF6c3c6in2Z6RtAK1g5PuoNSWzZ8k/v
        3smh2yjxHe+2inCAFQt6G8/25I0=
X-Google-Smtp-Source: APXvYqyKypfgGjFD7lV/bQMomAMjOCD7lYuyBQVbRtt19DnB/sriw3dDTDsKT+h4VxsVSDDK4UhAhg==
X-Received: by 2002:ac8:6ed9:: with SMTP id f25mr7129373qtv.207.1571235479387;
        Wed, 16 Oct 2019 07:17:59 -0700 (PDT)
Received: from localhost.localdomain ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id g31sm14925361qte.78.2019.10.16.07.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 07:17:58 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Cc:     Neil Brown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 3/3] SUNRPC: Destroy the back channel when we destroy the host transport
Date:   Wed, 16 Oct 2019 10:15:46 -0400
Message-Id: <20191016141546.32277-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016141546.32277-2-trond.myklebust@hammerspace.com>
References: <20191016141546.32277-1-trond.myklebust@hammerspace.com>
 <20191016141546.32277-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When we're destroying the host transport mechanism, we should ensure
that we do not leak memory by failing to release any back channel
slots that might still exist.

Reported-by: Neil Brown <neilb@suse.de>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 8a45b3ccc313..41df4c507193 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1942,6 +1942,11 @@ static void xprt_destroy_cb(struct work_struct *work)
 	rpc_destroy_wait_queue(&xprt->sending);
 	rpc_destroy_wait_queue(&xprt->backlog);
 	kfree(xprt->servername);
+	/*
+	 * Destroy any existing back channel
+	 */
+	xprt_destroy_backchannel(xprt, UINT_MAX);
+
 	/*
 	 * Tear down transport state and free the rpc_xprt
 	 */
-- 
2.21.0

