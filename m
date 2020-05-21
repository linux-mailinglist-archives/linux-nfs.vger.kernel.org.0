Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82381DCFE9
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgEUOfG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgEUOfE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:35:04 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBB8C061A0E;
        Thu, 21 May 2020 07:35:04 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j3so7234812ilk.11;
        Thu, 21 May 2020 07:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=X4fXdAWhojbxrpWwGIfQWlHhfLTmVqHl5gL0tZf73us=;
        b=m5Up8bwtApWBfm+Nk9jZbgzylZujl7Q+o2DwdXrNTpp5cBsnqgMPHUWGzBU6kkcwVj
         0DPsA6nQg+WN9Fp20jrZnxT2OO3+9zy3/YTy8K/wiN5wWb8rEwdCTWsoLKt/TGjbGDw+
         CiOb9i0JpVMFLOPQoTLZHXr8X3DLl1L34JwPc+1v9H1kdUO/ltxee2/5ikkCaLBA83yE
         R3wAVZ98VIxHPiZVL++nnITxwagdE8A7LmG1YFwiq+eKoii9uUyq6BJDwsWcpy/U6k07
         02eKop9N+87p7/HV2yTXsgTPUbDxuB1moD2OTWs6NUEGsy9fig0npK8D0ABt9crCP/G6
         YlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=X4fXdAWhojbxrpWwGIfQWlHhfLTmVqHl5gL0tZf73us=;
        b=of8NIHDzIXXH0b6autl35WaOMcOrneunHmz56vzclN515FzBzkGxw7BW6wQpKOnp3A
         4nk07lmI++kO7LToTZy6NtIPvZznZEbSE8hAaty5KpbfJpQFD3C3tly6FS5kZL0XEmiU
         ULXLEYJkzA8fjxXpcUaFFt76EwbGHfZEKwufDhuTy8PN/I9mT5BEU6DvtOrC5VUNVyyH
         czQHsAdejCh2BLW9QDmf83rZ88xCuqh6TifkglT/yupP6rJ4lGONbQoMMNN55LWNjihY
         YgxaQa1+QQ4lIBiUv1PtwK39C3TvVD/EL7qOB9A0wc3LvnvwkXV4mFvmR9fmfKFXMCWY
         BmSA==
X-Gm-Message-State: AOAM533iMa3691yABunE16TGaG+EfesIhVEMiELzQdlQe2nvyFggM7JX
        Wb+Kwxq688F7QyPQHQxgQ/+TnNPk
X-Google-Smtp-Source: ABdhPJwKBznlm2igqGZ+TW1/yeLJSZAx/pxMivE29Bn4XHJ6CSP8OH3FcCUoTRppewVhhsLeBExvzw==
X-Received: by 2002:a92:ce03:: with SMTP id b3mr9299499ilo.82.1590071703860;
        Thu, 21 May 2020 07:35:03 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e26sm2434348ioe.39.2020.05.21.07.35.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:35:03 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEZ2AX000870;
        Thu, 21 May 2020 14:35:02 GMT
Subject: [PATCH v3 15/32] SUNRPC: Remove "#include <trace/events/skb.h>"
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:35:02 -0400
Message-ID: <20200521143502.3557.91255.stgit@klimt.1015granger.net>
In-Reply-To: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
References: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
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

