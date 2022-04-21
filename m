Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D79850A28E
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Apr 2022 16:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381577AbiDUOfb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Apr 2022 10:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352869AbiDUOf2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Apr 2022 10:35:28 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3643A3E5C2
        for <linux-nfs@vger.kernel.org>; Thu, 21 Apr 2022 07:32:39 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id bz24so3360234qtb.2
        for <linux-nfs@vger.kernel.org>; Thu, 21 Apr 2022 07:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N+eaXb83WZWILC/4zd+cxeDlHS5V4Xm8vt3n2PVd1uU=;
        b=eIXEs8Blt5SBPPlSeB1txHz/MoB40e5TpGdWAhkhs1HOSg16FSA7uVf9XEQehiiWhq
         ba1mLebM2NZKKBqtHmjTGE9gtlzHUfEdLFLaftPznthqUCG/Lros1y4nyuxTIw6PkOdu
         XYeqX7jQ5nlxUu/WgvXFJtxQramZpkWF0mAyIvGsKc1wu4N2AG53oLvZ/LD9B0Y+RdG6
         My51iX0TPpEkfFcSgh80VsSvJeIzvrw7bkOrgNC/VXMTlJAvhdQg7Az/qwFYkEHQZa5j
         qgHRzHli9Qq9qVV9E+liMrWZNIHf+KRDFNU5bijVsKVl7Pv/0+mv1yaXL3SNfqg8MrYS
         bgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N+eaXb83WZWILC/4zd+cxeDlHS5V4Xm8vt3n2PVd1uU=;
        b=eUXG5wi/tj2trUFSrDOPe73dj0zcouso5XqAMEIDgNOopeLTID6EbJ/ZoLE6bRB4QT
         jIFHHph097B4VeL6J3ZMZtiKsa2mrCsXPYJNp7+TdaqBM7vufnRMX4jy1ie0yJm8fnp7
         8NK8B5KNDlLJ792g+mkYdJE8I9qF1Xer3xrXb/kiPpspiZu8B+9GFzZ39rXXjT5tR6YX
         vSU7CMZC+7miAKFN+xoECHPybmvaLv+LTyp1tkao9w1nY4U+1jKMX6+UxHD73ppZnVeB
         Tdlme7oooekGmfe4lrlpzlOjdwjz/dxL3N9RhJ43xUObdxmGTgz2mqKBq/PLgfmFS8Sc
         xEMg==
X-Gm-Message-State: AOAM531W+B8yKkbFTfbeE8KplM9G5nXNZhZdiNZz2cGOEJnKt5eVovg1
        Sp2nIrxxllgTJh/FiaQXI+lmVCVEHzg=
X-Google-Smtp-Source: ABdhPJzUTKAT5+ZFm60bE7esVlVwvJwhfUExMzAw2m1FnADK0r1QlcaYZXoEKW5j1fA/56gY2Deb/Q==
X-Received: by 2002:a05:622a:14cb:b0:2e1:9fc5:424d with SMTP id u11-20020a05622a14cb00b002e19fc5424dmr17410448qtx.543.1650551558277;
        Thu, 21 Apr 2022 07:32:38 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:a128:daac:d85f:c77f])
        by smtp.gmail.com with ESMTPSA id f127-20020a379c85000000b0069c921d6576sm3093401qke.76.2022.04.21.07.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:32:37 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/1] SUNRPC release the transport of a relocated task with an assigned transport
Date:   Thu, 21 Apr 2022 10:32:34 -0400
Message-Id: <20220421143234.4944-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

A relocated task must release its previous transport.

Fixes: 82ee41b85cef1 ("SUNRPC don't resend a task on an offlined transport")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/clnt.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index af0174d7ce5a..98133aa54f19 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1065,10 +1065,13 @@ rpc_task_get_next_xprt(struct rpc_clnt *clnt)
 static
 void rpc_task_set_transport(struct rpc_task *task, struct rpc_clnt *clnt)
 {
-	if (task->tk_xprt &&
-			!(test_bit(XPRT_OFFLINE, &task->tk_xprt->state) &&
-                        (task->tk_flags & RPC_TASK_MOVEABLE)))
-		return;
+	if (task->tk_xprt) {
+		if (!(test_bit(XPRT_OFFLINE, &task->tk_xprt->state) &&
+		      (task->tk_flags & RPC_TASK_MOVEABLE)))
+			return;
+		xprt_release(task);
+		xprt_put(task->tk_xprt);
+	}
 	if (task->tk_flags & RPC_TASK_NO_ROUND_ROBIN)
 		task->tk_xprt = rpc_task_get_first_xprt(clnt);
 	else
-- 
2.27.0

