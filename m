Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03827219135
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgGHUKL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgGHUKL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:10:11 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD067C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:10:10 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j10so35564444qtq.11
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9hH54RJI1BOH+IcqfuZkKiEYkZlSFSoQaM+ymLoKCSA=;
        b=dPlwL8xQnBl0NHMm10MXCLSpmJiRWo1UffhbajFe19tgRNHdQDPZfp8AI2j5uJa/OA
         hNgKiBtNyXM9FJ6Bq9YGiNciiBjgZusKXsBq02sYoBOU9H14gy5d/NLLSdYrF5Q/9gb6
         oXBoR1PysflprXLzWF9A4m+TkUidrjsoCpCuRz5lvxPKQum1ZQLm62Nh9JY7MdNbJJn8
         dprrsz6Gf+O9w+stc6OFdHihBa3Nk4naFGr/vwlUlbfqo8P22hiMsdXQNtbxlei84DrD
         DS1K0FY2kK2sEzMxKLl58CQzKhGJ3/E1OyXZ9Pis1wdtROMULsm4wWuX2V41F0t3xoZR
         xXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=9hH54RJI1BOH+IcqfuZkKiEYkZlSFSoQaM+ymLoKCSA=;
        b=kbesVJa9LKAmKeQG33oF4CCsvQCZ8FjOWBpj+6koK0REdRNN0tQq+PecdwO25AtHGu
         kFaetwFHpaNIuOK4IoE+FuiuBMlvA96HzvPi4xoan1h8K8MAbeGWPUaZpAcgit6O/4u9
         R5il/Ra3sS7K4+O3vAWvf//WEhAI5bc3jafl8ntbc5iWud8b1kcfcZtgfoptAC72pUgS
         lLT3AiSFvi78sY0LV3s0ZvppIlmbgka1JYPGg5/BCpvOdl9Un196LXQIhJkCdCD89R6w
         Ae4oVAZqBNW+Y2yQCO7S+vOY7MpKDIG3PbCk4pt1oPyVFUS+/LBThiBpCP96Zn879Iin
         dx7g==
X-Gm-Message-State: AOAM531tFn2SAhoVUWhKjXtjsYHNCaSJq+KlZqPvWHjgLZ785JI9Xpnd
        5jCBkzSkoJShmkBjcmlp4GHhJ5ks
X-Google-Smtp-Source: ABdhPJz7SFi8QptkBoIKtUcXGNSKu0iq9w0TcbWnVQ9nmD4tUsNsGOe9YedzJcGs1fnSKgx3395gqg==
X-Received: by 2002:ac8:41c7:: with SMTP id o7mr61125891qtm.257.1594239009925;
        Wed, 08 Jul 2020 13:10:09 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z68sm953477qke.113.2020.07.08.13.10.09
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:10:09 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068KA8x3006112
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:10:08 GMT
Subject: [PATCH v1 13/22] SUNRPC: Remove dprintk call site in call_decode
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:10:08 -0400
Message-ID: <20200708201008.22129.15426.stgit@manet.1015granger.net>
In-Reply-To: <20200708200121.22129.92375.stgit@manet.1015granger.net>
References: <20200708200121.22129.92375.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up.

When enabled, this dprintk adds a line in /var/log/messages after
every RPC that reports the task ID (no connection to on the wire
XID values) and the RPC's result (no connection to the program,
operation, or the arguments and results).

Thus it's value is pretty low. Let's remove it.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/clnt.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 2bdfc4d0d860..90e3d9dae34c 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2496,8 +2496,6 @@ call_decode(struct rpc_task *task)
 	case 0:
 		task->tk_action = rpc_exit_task;
 		task->tk_status = rpcauth_unwrap_resp(task, &xdr);
-		dprintk("RPC: %5u %s result %d\n",
-			task->tk_pid, __func__, task->tk_status);
 		return;
 	case -EAGAIN:
 		task->tk_status = 0;

