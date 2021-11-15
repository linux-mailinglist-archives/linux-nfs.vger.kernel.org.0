Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E10450A5D
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Nov 2021 17:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhKORBe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Nov 2021 12:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbhKORBT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Nov 2021 12:01:19 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957B5C061767
        for <linux-nfs@vger.kernel.org>; Mon, 15 Nov 2021 08:58:20 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id f20so15906635qtb.4
        for <linux-nfs@vger.kernel.org>; Mon, 15 Nov 2021 08:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uRK4hkiTZUWAj8cllnANNjoMKBWhSK9KFUzOvcsNuMo=;
        b=gRW0T62HV+UT9h6Yk9u86KO0O3WB3c6UhXA/f86Z5X7AptFebxL1MEk69/tiexmBwh
         ZvzGOXFmPKGSY54l7mNkhTa7Ec3BU/dmtgMMtRdjQ/q7G8NA/OSjdSPk/xkWR7Kugcqn
         9ORZQtY2a5m43CttZTNfVauM7FxfzMPBVn8DBHyixQf/JZvj7BxQ+NMM6OwhfkH1ml5l
         FmLbpnemQOv3QQ7JpLiBUQQ+b82R3BW5+zbzpt5Fh577tQQI51gslBJOtFqgucuw556L
         r+TSRVppHEHcr9AYSmuD2B7ECDirkfzz+qReTmndefTSTHbuh3MbotV9JnK8x4t0nRC4
         /lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=uRK4hkiTZUWAj8cllnANNjoMKBWhSK9KFUzOvcsNuMo=;
        b=C+p99S4F8gN22QV1GCWJRce3lMEPRNVVjvV8d/cfS6eM5BeqnziCobNXxYdP64hMUS
         jNVF3X/M6j1d6PnCfIR412oNcIcEa+xXL0snXnDmXl9c6U5DCikOos4GKratymmx4fOI
         3RRREHCkDXbDebOia0mwM+gHvVHe6LYBnqstv+EAkYRW5L3PiJWkkEKTEOCZpPshP15n
         HdKFBammhnaiHKWwCyA+mqeAm7HcixrPZBz97GV0kWTDU6gkrZ1e0vSpcJ6LtuHEEdEb
         sRDdMOdf12Ai4oRBYICrhEc/bwcnNltQ0lxQbKleSJaM24Ssk6k20GxFVa4eTGe78GPD
         lE2A==
X-Gm-Message-State: AOAM533d5NrnSrhFYQPzymkgxDL0ZG27gjHqmVHwPtPr5wnp+OSQptgJ
        /2REr6MyHIVvNIcpRr220D8PO+KdiiYvWA==
X-Google-Smtp-Source: ABdhPJy+IfTqyFfTCuPJMAGG1KY5pS7fFY8nW3jZafxG32VtoYNRkGZ4fADB8IxUo9qxJvPqIBGVFw==
X-Received: by 2002:a05:622a:11d1:: with SMTP id n17mr501421qtk.154.1636995499441;
        Mon, 15 Nov 2021 08:58:19 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id v7sm6988472qki.98.2021.11.15.08.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 08:58:19 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 1/3] sunrpc: Fix potential race conditions in rpc_sysfs_xprt_state_change()
Date:   Mon, 15 Nov 2021 11:58:16 -0500
Message-Id: <20211115165818.2583501-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We need to use test_and_set_bit() when changing xprt state flags to
avoid potentially getting xps->xps_nactive out of sync.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/sysfs.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 77e7d011c1ab..8f309bcdf84f 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -309,25 +309,28 @@ static ssize_t rpc_sysfs_xprt_state_change(struct kobject *kobj,
 		goto release_tasks;
 	}
 	if (offline) {
-		set_bit(XPRT_OFFLINE, &xprt->state);
-		spin_lock(&xps->xps_lock);
-		xps->xps_nactive--;
-		spin_unlock(&xps->xps_lock);
+		if (!test_and_set_bit(XPRT_OFFLINE, &xprt->state)) {
+			spin_lock(&xps->xps_lock);
+			xps->xps_nactive--;
+			spin_unlock(&xps->xps_lock);
+		}
 	} else if (online) {
-		clear_bit(XPRT_OFFLINE, &xprt->state);
-		spin_lock(&xps->xps_lock);
-		xps->xps_nactive++;
-		spin_unlock(&xps->xps_lock);
+		if (test_and_clear_bit(XPRT_OFFLINE, &xprt->state)) {
+			spin_lock(&xps->xps_lock);
+			xps->xps_nactive++;
+			spin_unlock(&xps->xps_lock);
+		}
 	} else if (remove) {
 		if (test_bit(XPRT_OFFLINE, &xprt->state)) {
-			set_bit(XPRT_REMOVE, &xprt->state);
-			xprt_force_disconnect(xprt);
-			if (test_bit(XPRT_CONNECTED, &xprt->state)) {
-				if (!xprt->sending.qlen &&
-				    !xprt->pending.qlen &&
-				    !xprt->backlog.qlen &&
-				    !atomic_long_read(&xprt->queuelen))
-					rpc_xprt_switch_remove_xprt(xps, xprt);
+			if (!test_and_set_bit(XPRT_REMOVE, &xprt->state)) {
+				xprt_force_disconnect(xprt);
+				if (test_bit(XPRT_CONNECTED, &xprt->state)) {
+					if (!xprt->sending.qlen &&
+					    !xprt->pending.qlen &&
+					    !xprt->backlog.qlen &&
+					    !atomic_long_read(&xprt->queuelen))
+						rpc_xprt_switch_remove_xprt(xps, xprt);
+				}
 			}
 		} else {
 			count = -EINVAL;
-- 
2.33.1

