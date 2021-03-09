Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E079332E39
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Mar 2021 19:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhCISYB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Mar 2021 13:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhCISXl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Mar 2021 13:23:41 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379EEC06174A
        for <linux-nfs@vger.kernel.org>; Tue,  9 Mar 2021 10:23:41 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id o1so10917365qta.13
        for <linux-nfs@vger.kernel.org>; Tue, 09 Mar 2021 10:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PMvBwUr43sXk816z08e0HPkkGATwk/3iFEDn175IbAs=;
        b=Qv4G8rOrQe7HcLDBuePZyJ2tnRNB24pCtNEsXWy8E3bf3IYdN64IB3TwrAL5fZ2VNg
         u9qDrfqfuQ1lmA+kcrIGyikS9+oiw5QNqNgyCJFl8W4OgAVtgIgkuhDpLSEuEh+3zxah
         Kns6OZwp+0vLU1i4os+Uxc+eUUk1+dZf6iBzDYEmUyGJrzHo+JYiIixVnlkAzB/wTkTe
         /7QtvY3zllZOdW0SudXAladaKudzpx9Gifouz/wru5U6thBYySbJZt+FWvu3aaygRf6B
         Y187t5lGQPVymCgAcLfUfmnE0nJlel6BvDwOyYq3EouHnBvzfAngbfjp1BoOzIPZcQpx
         K2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PMvBwUr43sXk816z08e0HPkkGATwk/3iFEDn175IbAs=;
        b=n3ZgrH57C4JmervgcZTSvYkML4aEy3ccXnlIo9IGH7F4nB55Atz2mR4/R+5p/R/f/Y
         ftuj35NmztOveN6L/MHL77swzFVrPG+zBqlVfEmg0SMR1g0YsgMw3ynMJMIi9I1PzI+l
         MDBBwJaYIH7Rhv/3yV1AO8tH6a0paRAFXfU1dHfsvQt6+96Ol9/ogZCMgdcNmI0wTKeZ
         pIbvfBAobGYlehkYzfzkcn7JOzjYotFHO66mRsIK6olxczSrPy5koOmxbA0zeg2WSn6c
         yBEOx7U1QFjrFleJLexxYWMgt6lViuE0eCW8zzdZ9DMoiiJYVGVkUNi6Pmmyk/6dwFbc
         wBrA==
X-Gm-Message-State: AOAM533jhwNhE/hanhf/uMGLy1cfbG/lb56lyA5vwB56USJ+yTCjF4si
        HUlP4Oh+W0Mi0kBduPJ5lBGnguxex70=
X-Google-Smtp-Source: ABdhPJzTM8eqaWtCbHfIz7ZIjz+laT5DTEobiUApwK59ByO6vSBOtDAx735tb2BmiTHRpN97scRolA==
X-Received: by 2002:ac8:5c0a:: with SMTP id i10mr25416327qti.356.1615314220261;
        Tue, 09 Mar 2021 10:23:40 -0800 (PST)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-11.netapp.com. [216.240.30.11])
        by smtp.gmail.com with ESMTPSA id l5sm10058032qtj.21.2021.03.09.10.23.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 10:23:39 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/1] NFSD: fix error handling in NFSv4.0 callbacks
Date:   Tue,  9 Mar 2021 13:23:37 -0500
Message-Id: <20210309182337.62308-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the server's attempts at sending a callback request fails either due
to connection or authentication issues, the server needs to set
NFS4ERR_CB_PATH_DOWN in response to RENEW so that client can recover.

Suggested-by: Bruce Fields <bfields@redhat.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4callback.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 052be5bf9ef5..f436d2ca5223 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1186,11 +1186,8 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 		rpc_restart_call_prepare(task);
 		return;
 	case 1:
-		switch (task->tk_status) {
-		case -EIO:
-		case -ETIMEDOUT:
+		if (task->tk_status)
 			nfsd4_mark_cb_down(clp, task->tk_status);
-		}
 		break;
 	default:
 		BUG();
-- 
2.27.0

