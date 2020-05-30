Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202AD1E9196
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgE3N3b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbgE3N3a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:29:30 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DA2C03E969;
        Sat, 30 May 2020 06:29:30 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id d1so5174755ila.8;
        Sat, 30 May 2020 06:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=X4fXdAWhojbxrpWwGIfQWlHhfLTmVqHl5gL0tZf73us=;
        b=W2VqvdndXy8Y9XCW7QtXp4piOKcqEVQFIFkawl2LbktlSkh+Cp4x4ySK8zDDA11tnD
         O9IcwR3efM7wQdPcXb8n4HixPKwgnNQtundsBUC4QOjvqaQMKvp7ADUx4KeSKDx32WVj
         7k6t4no90iq+HczeM2t+BUCLiWGxqyEsqskCpDM+rP9cmwKXluO63rTs9N1Xq7h1xizH
         0W7yO+uZfl6agTIwX6PpLY4sEGtH1caJzVyqgCuPzdlOypFIHjNoqdML904Yuxxv8sH/
         rEq0oHq/qGF0mpp8Fk7mk7roBZ8Y7l0wrG9IwwmaVzKaTHeYvGS+ynzGoxU1TnYcOpvl
         JABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=X4fXdAWhojbxrpWwGIfQWlHhfLTmVqHl5gL0tZf73us=;
        b=JRly4GZQJ/dBa+OhKfvxtBKtSS7rvtQIbZSqrgfiU2DM7G5NNMFfHmYenxBhWJr8tJ
         NWLKcu47nIcdLxnt5e1tmY9n7YBwubMlV9ZC4oMQZuYLs+fVA1OfM/He1WOrOID7sLd+
         kuMD86/xe9qwwO25qOSbtNDkCaCyiJl4N4ES1RQ5MTmsecttlblwv7FZ9qQKzf+OOyu/
         xq6dnQrFc1o55BSMxrMx6Ufi1nlVB2ixlT39ji6gEWltaTlg8dfFqA0+VDrL/R3kxoE8
         +1NOmp1g7aXnOEdqCszPPHegKmHt1Xuh9e4ObLvYK/eXbcLd6UpIYwoXc4XqWknMkoKs
         33yw==
X-Gm-Message-State: AOAM530WDbeRkKsJ63/4vHt2IutCL1eugpp7c16fPgLHS3MCiIAUw9+L
        tIV0aME/4GYwdZBOWVMMXsXD/ePh
X-Google-Smtp-Source: ABdhPJwG20iPcxSC637SpaNh7B4BrSzDg0eHgCZD4ZxiFffZzP3BHKAX/UDmZSa9GrovBoqy2vQyMA==
X-Received: by 2002:a92:dd04:: with SMTP id n4mr1276663ilm.220.1590845369634;
        Sat, 30 May 2020 06:29:29 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g15sm737999ilr.5.2020.05.30.06.29.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:29:29 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDTSMX001432;
        Sat, 30 May 2020 13:29:28 GMT
Subject: [PATCH v4 16/33] SUNRPC: Remove "#include <trace/events/skb.h>"
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:29:28 -0400
Message-ID: <20200530132928.10117.93518.stgit@klimt.1015granger.net>
In-Reply-To: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
References: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Commit 850cbaddb52d ("udp: use it's own memory accounting
schema") removed the last skb-related tracepoint from svcsock.c, so
it is no longer necessary to include trace/events/skb.h.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index cf4bd198c19d..1c4d0aacc531 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -45,7 +45,6 @@
 #include <net/tcp_states.h>
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
-#include <trace/events/skb.h>
 
 #include <linux/sunrpc/types.h>
 #include <linux/sunrpc/clnt.h>

