Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB802B4245
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 22:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387856AbfIPUqe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 16:46:34 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37404 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387796AbfIPUqe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 16:46:34 -0400
Received: by mail-io1-f67.google.com with SMTP id b19so2342333iob.4
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tm3Z204lhcQueHhZs5vFp/leKoUofNIJTGBebGTHcyI=;
        b=O8sSYwONTZCAlzWfm3VUd7zcnha2h957yO0p5/dMqBxsQ5/FCm00iONVd44wrQOqEL
         xRfVs828YC/V7qgF3hzFkJxUrqGyV2AejN2FrEs4gdHCELBNiLnbvpelJaB55F8n5jog
         oXwdZcBNv3+Kp7IrV63W8br32wOatuitLTJuQGeVJc0NTTYxqjKgUfZrS6wa+a33w3Eq
         5Ic6yHor36y53ZdCViTJhP87uhCntCmRrexH5XLYDceKD8LGIpZg8wPa0yMf1wthdG55
         FTIDjA0NLKpmkWnDjsc+foDt5+uKsXkAJ4hrR494N05xUzgSH4O+7J/Bu0JCY/F5YRJ5
         cvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tm3Z204lhcQueHhZs5vFp/leKoUofNIJTGBebGTHcyI=;
        b=GUT1ieDDRH7vOR35vg5KVolMmiZVNKj59wKX1V4rFRD1fAaQe0krq5D2NFGGadjt3I
         AN++0VJIosjE+V/mTdbVcBB+iWnFwfb+WydO0JpCgX2okmhFhIpeYTYodMM7zpLmdv/4
         hXHGqszKLRNxjf2nxC0GiKOlf6tfYRG4SzvWqE6b1nKbMjE/3r7ZxqMsSDvu5O+VLK0x
         3tk0/hBLg+ks3dkJnn69vAYbAW5PcJsE22+Ap+VxRA+RLyVaDFofHB5H4gKeYdEWavEb
         1RLCl6IQHUIETYDvkCshKbihlMhpD8bMTJedoo9ox0HVdTkbIVUFV52p3LOGvtq6gvVA
         WdRQ==
X-Gm-Message-State: APjAAAWxRGl2W87cQuMfoZivST3J8z+GjbIyjAZfFsy44rJaOtsrx3TU
        y8+PWf0+fjf518IP92UOTA==
X-Google-Smtp-Source: APXvYqyFEAEhfSWjuLcQvP9J3I+tizH5gudTZBCoFrvEOSIdlhvsO2FZ1irGWevC3e2x/G1tgeD6uw==
X-Received: by 2002:a6b:3906:: with SMTP id g6mr282823ioa.48.1568666793262;
        Mon, 16 Sep 2019 13:46:33 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id c6sm3528iom.34.2019.09.16.13.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:46:32 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 7/9] NFSv4: Fix OPEN_DOWNGRADE error handling
Date:   Mon, 16 Sep 2019 16:44:17 -0400
Message-Id: <20190916204419.21717-8-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204419.21717-7-trond.myklebust@hammerspace.com>
References: <20190916204419.21717-1-trond.myklebust@hammerspace.com>
 <20190916204419.21717-2-trond.myklebust@hammerspace.com>
 <20190916204419.21717-3-trond.myklebust@hammerspace.com>
 <20190916204419.21717-4-trond.myklebust@hammerspace.com>
 <20190916204419.21717-5-trond.myklebust@hammerspace.com>
 <20190916204419.21717-6-trond.myklebust@hammerspace.com>
 <20190916204419.21717-7-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If OPEN_DOWNGRADE returns a state error, then we want to initiate
state recovery in addition to marking the stateid as closed.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index cbaf6b7ac128..025dd5efbf34 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3394,7 +3394,9 @@ static void nfs4_close_done(struct rpc_task *task, void *data)
 					task->tk_msg.rpc_cred);
 			/* Fallthrough */
 		case -NFS4ERR_BAD_STATEID:
-			break;
+			if (calldata->arg.fmode == 0)
+				break;
+			/* Fallthrough */
 		default:
 			task->tk_status = nfs4_async_handle_exception(task,
 					server, task->tk_status, &exception);
-- 
2.21.0

