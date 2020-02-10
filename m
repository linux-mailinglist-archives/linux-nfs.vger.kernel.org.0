Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3123115835F
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2020 20:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgBJTQK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Feb 2020 14:16:10 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35402 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgBJTQK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Feb 2020 14:16:10 -0500
Received: by mail-yw1-f68.google.com with SMTP id i190so3953347ywc.2
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2020 11:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8aMIdSbKzgajTBdWOQFKylPBEb9etNnzN78zz1ELB7I=;
        b=G7rLe0vcAN4k2w8fEwt+dfhRGowGdgQsW7H6EqQi0X7v958EekjBav0RJ2GIt/5XXX
         yyDDEztaQoh7CwUK/jTwype/bOBlCqekGZDuvUWz8N1CBNrQZC73j5P5sqZJemrxJKzf
         19GWrq+DlNX2HqddfL7OB7/pYnBUwFI7kXsOmOmwSTi9++NidqCQEMOBd1ubA1+BlLCW
         /yzBSFEQNVm8B6Nj0CkTZINWZQtWsuYL0Df+GuKcbe9Pk8dBUDT2NrQYkqWlFwd4l2kj
         Xo6PXL92Li+0c1o+zZF6ajbLrBhYV8eYXXuC0lOl29wgYUS9I+k+sosFxt0TU62+s2SU
         0mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8aMIdSbKzgajTBdWOQFKylPBEb9etNnzN78zz1ELB7I=;
        b=efSfjIGGzncPbkkuFtuQJ3ijX0CTePFoJmE+FhiP90APeXjmryLVe07Mcqy0XCkCOz
         KJofMzh0b4QaYLD+jtB+F5q15PPvsU/nbcQYdAotasUOzImmy8FuSEH+/BhNcf7NTBKK
         8TwmPzawowSYZmSBUSMrQodN9/jfa9LKMei9bwJeWtjxmAdMX1rXK7y/Q/lbonOkq5/D
         K+0UF9VUwBJ/giR9D6LbRfesAHH65iKxuUJOHOHUvroDrZX5VuMbcIdBWeh0ndi4+fsY
         b05WmQaNPP5WmQTiEkUYfG2t3J0ZAnDHvyvnrsL6SwNaXtJnhiacaNuD0C7E0QDxiPIP
         3rXg==
X-Gm-Message-State: APjAAAW8OrIjxxDFzl2fcObLUbcm+3iS/Isyo4UJZ87/QQzM0qRAIZHV
        coVXKZjZll1SIhCqFPG0Hp6Z2vVQyw==
X-Google-Smtp-Source: APXvYqw6Lw96yfg2kRot6kWWIMC/Twgbh0BFhBjVOdPxZgDdgOP27mjsEn9+A7PhoIms29RGg/tt3g==
X-Received: by 2002:a81:52cd:: with SMTP id g196mr2362676ywb.89.1581362167649;
        Mon, 10 Feb 2020 11:16:07 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id o4sm660222ywd.5.2020.02.10.11.16.06
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:16:07 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/8] SUNRPC: Don't take a reference to the cred on synchronous tasks
Date:   Mon, 10 Feb 2020 14:13:40 -0500
Message-Id: <20200210191345.557460-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210191345.557460-3-trond.myklebust@hammerspace.com>
References: <20200210191345.557460-1-trond.myklebust@hammerspace.com>
 <20200210191345.557460-2-trond.myklebust@hammerspace.com>
 <20200210191345.557460-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the RPC call is synchronous, assume the cred is already pinned
by the caller.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/clnt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 2345e563c2f4..252b044cdcdf 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1127,6 +1127,9 @@ struct rpc_task *rpc_run_task(const struct rpc_task_setup *task_setup_data)
 
 	task = rpc_new_task(task_setup_data);
 
+	if (!RPC_IS_ASYNC(task))
+		task->tk_flags |= RPC_TASK_CRED_NOREF;
+
 	rpc_task_set_client(task, task_setup_data->rpc_client);
 	rpc_task_set_rpc_message(task, task_setup_data->rpc_message);
 
-- 
2.24.1

