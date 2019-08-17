Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC90E91333
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2019 23:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfHQVYw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 17 Aug 2019 17:24:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46336 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfHQVYw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 17 Aug 2019 17:24:52 -0400
Received: by mail-io1-f68.google.com with SMTP id x4so13212813iog.13
        for <linux-nfs@vger.kernel.org>; Sat, 17 Aug 2019 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NeLO9jdAeEyl4NgS+9idWVlbfcyG6zf1VXRk6Y/uR1M=;
        b=O6y0uzD4tTxXFHHO+tSseldEe0p9sWpCyxvuKXxKWGHShBr8vj2ijR8mzViLGdZM9C
         59WeBBaleFDQodN9Ai5wyLeUzq+qdDedO/0w91hWrc/fF4NVxQypUMIYY9/U9Z67rt53
         eqxMjPojqGV8F6B3ZxYTImidk1eiYatIjwOnp9wFVa9ZAN34I9SfIC3fcayRDB8rnNLX
         G6E5Zw+jvJjwSFgeDTbUPFXvdi+hFAFbDagj18g5GBszKA8OkcAknHcAHS4dKLhOyHKi
         ZP/hy1XRB77N41hNx5evSO3lBb90U1qbdMmoKloh2TIswBUrc1knzL4X3SdrO7yjNzl0
         PPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NeLO9jdAeEyl4NgS+9idWVlbfcyG6zf1VXRk6Y/uR1M=;
        b=DXa/eRt+wbiIeBmu3P3SZD77TVbIdJXrt67dqjhkqFNFl3ZUeR6WgwB8pcrmnaRTs9
         TSFWznqha6nfZzXdo1nZJwQb0wk696z1ixepGeBgYQ6jlpx690gWc3i2+xSaISyeKbBM
         gActUggCWSfbEBK5PWrNdXto5rgzPkwFmd3P82rOQcClvu6UU2XwRsXZIVLxjaZx/Muy
         xoT1Aj1n5cY9U6hKbufo68zYF79+7s1eBc3yXhFwTzBXWvmNI/4GiuYbE2MqTtf1uLYc
         ErG1Vnb2RAPaiBpMkCe/WPMjbDj6Zi7mumInDsWDsf97/4VOtBAOLgacPksnIveQVqj2
         8Ayg==
X-Gm-Message-State: APjAAAXqqe3DpxqaSojz8pXbE8h12TauTLTEg5g9AApilz0Kz4PabV1A
        hv005H5lT2GMUOUiBfcgTEOsiSI=
X-Google-Smtp-Source: APXvYqz2+BlXgDb5FRLX8XHn4dLC6a1V8LYhtYuqXDYc/EBfYQDQ0sOuSAjulbFfcnt7uAwB6nxl6Q==
X-Received: by 2002:a5d:9583:: with SMTP id a3mr17751049ioo.54.1566077091423;
        Sat, 17 Aug 2019 14:24:51 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q3sm4609806ios.70.2019.08.17.14.24.50
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 14:24:50 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 8/8] SUNRPC: Handle connection breakages correctly in call_status()
Date:   Sat, 17 Aug 2019 17:22:17 -0400
Message-Id: <20190817212217.22766-8-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190817212217.22766-7-trond.myklebust@hammerspace.com>
References: <20190817212217.22766-1-trond.myklebust@hammerspace.com>
 <20190817212217.22766-2-trond.myklebust@hammerspace.com>
 <20190817212217.22766-3-trond.myklebust@hammerspace.com>
 <20190817212217.22766-4-trond.myklebust@hammerspace.com>
 <20190817212217.22766-5-trond.myklebust@hammerspace.com>
 <20190817212217.22766-6-trond.myklebust@hammerspace.com>
 <20190817212217.22766-7-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the connection breaks while we're waiting for a reply from the
server, then we want to immediately try to reconnect.

Fixes: ec6017d90359 ("SUNRPC fix regression in umount of a secure mount")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/clnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 9546a4c72838..f13ec73c8299 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2375,7 +2375,7 @@ call_status(struct rpc_task *task)
 	case -ECONNABORTED:
 	case -ENOTCONN:
 		rpc_force_rebind(clnt);
-		/* fall through */
+		break;
 	case -EADDRINUSE:
 		rpc_delay(task, 3*HZ);
 		/* fall through */
-- 
2.21.0

