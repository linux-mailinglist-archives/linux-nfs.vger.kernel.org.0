Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C119AB8EF9
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 13:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438179AbfITL0L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Sep 2019 07:26:11 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32927 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438184AbfITL0L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Sep 2019 07:26:11 -0400
Received: by mail-io1-f68.google.com with SMTP id m11so15407969ioo.0
        for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2019 04:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tm3Z204lhcQueHhZs5vFp/leKoUofNIJTGBebGTHcyI=;
        b=DouOPYI0AeVNZ9nYPuPDBOTnNEy+FK3Wp6GlEVjzxmQRRX++jM2bRECxE2w/JW4Ub2
         0Dp9FoK9qFr7JNBMsuoLgIXJGS0qnevkonC8alfPBeJqrZn2UmN+z31+ZYHox9WsN0Fk
         E5YGuQWzvp2J4LDz5Sz+cWztVBAIuL5aXLt59Kxuiml8g8ZalvSk48qH9Ya564yLKMGh
         6nE1GP9yyVRHxt9H1i4MTVFgS82YRyGRb+eBw6GpuQBQUTxJ+9nyY2QWK63px5JJidoH
         pjfTRVN3iHLXmV3IiRAmHeI9595JKZOr9dqR9T98ZCzplMyOHR/6jeh3e558sVuag5Cl
         YwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tm3Z204lhcQueHhZs5vFp/leKoUofNIJTGBebGTHcyI=;
        b=AOVgfyerQSROdLVdEwboivIqiOxXXEq9UyYfk6lKsp0kckBz3zMQHocc1M3PMhtw2V
         cjkI8fbudCrxyqCz85j1ZhmXObrH2Mt5QRPUD/fUTxN2hI4HcXTa8+DRthTUPuLNAa08
         mybGdr6hU7JBqNcx7gk4pLnXDMMV3mJhRdgItT560O57S5ADWoWGQFcMTxx39QkPOZNI
         i0buRHNuOsy17/1kIAtDajWqGOc/Ao6g7BacHGx8N+sMJQwl+0pj2LYKMHvz28uZ6HMa
         kO8PSq42tMkx6eGaz7YmpzOoUfS6OOjncF5fJJpdTvq0aBlXS9EbjN233gNclRYCjKt3
         NSmw==
X-Gm-Message-State: APjAAAXOCjtyolzRl3eN3l5ynggNct6MMmj4H/753S/mdviKUEf2svmZ
        UK1IwCXdLbQMXmMnEGnTEQ==
X-Google-Smtp-Source: APXvYqxkyb8PQz7rti0W5pGgdJOgo20Rv7KxfMmfxyQ61kc06u/5IePRLExq7BS/gR66Ti9PCMp6dg==
X-Received: by 2002:a5d:97cf:: with SMTP id k15mr4253011ios.151.1568978770042;
        Fri, 20 Sep 2019 04:26:10 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q74sm1308736iod.72.2019.09.20.04.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 04:26:09 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: [PATCH v3 7/9] NFSv4: Fix OPEN_DOWNGRADE error handling
Date:   Fri, 20 Sep 2019 07:23:46 -0400
Message-Id: <20190920112348.69496-8-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920112348.69496-7-trond.myklebust@hammerspace.com>
References: <20190920112348.69496-1-trond.myklebust@hammerspace.com>
 <20190920112348.69496-2-trond.myklebust@hammerspace.com>
 <20190920112348.69496-3-trond.myklebust@hammerspace.com>
 <20190920112348.69496-4-trond.myklebust@hammerspace.com>
 <20190920112348.69496-5-trond.myklebust@hammerspace.com>
 <20190920112348.69496-6-trond.myklebust@hammerspace.com>
 <20190920112348.69496-7-trond.myklebust@hammerspace.com>
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

