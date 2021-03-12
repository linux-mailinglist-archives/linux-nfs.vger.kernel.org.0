Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916B8339902
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Mar 2021 22:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbhCLVS4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 16:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbhCLVSe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Mar 2021 16:18:34 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C46C061574
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 13:18:32 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 130so25821225qkh.11
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 13:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FxeqY0lbRXBBNFSL0hGXRSL8HmbSfYX5sIzVJ3Lknl0=;
        b=DIKfVXYUUlX0L8Du8/KwHTAzCJMzKuTp7rsxQwPXdB62WcS+Ljqlf+7M1gDcGhzMdu
         xE1VmlHUVCkWLKJl+pm5BldobYsflq/uaI9iTU5DJM5NylYRz8A32lHDwTvIUVzOvQQ1
         QFY/HjFbT6mkKu22deR5bo4zsCwbrhoi58CPAWJ6zxzlWFmruANREIvQoqyaZx+FTHbi
         VKHKLQVW4zXylvyXxcruI6xs3lwsjBNgpUgZUZrE7pBdEsTFpCYufR8E5EspGPYdTQsp
         c7qb6My8fmK/NVPI01bvRGjmy7Q2GQBwojZPC1pKx/imFLxeZI65oXm7W0d3Qs5EZFE8
         IBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FxeqY0lbRXBBNFSL0hGXRSL8HmbSfYX5sIzVJ3Lknl0=;
        b=EUDsx6yJ7l1XMuAUL96cIk1MGDECwWpbZNX4rhdqdwWQNeEQf9NASo04Qm69uyqj16
         O/kJm7FVa/2PKSOisfxO6g/hjRJGB6YfUC8rvE+fKHvjYIplBP6l66YEIynVKBNOV22G
         oRT/pDx9EWwZVQ7d+eeQw4Wjkpyv79uSOPXsL7frrn2/EGNtNmSVMWQSirw2kaH2P/rF
         053KGzkVxkX4ZrKOTBHJx3xHR1U2d1B3WgES645uCQX2oOm3zK4odaXEOS4D73AqUwqu
         aFL/qNJc86jpFg6rC1geqAkjCeSKcJGD1HQNOGptBXvFNXYNTFHjaEo7fMYFoMYOycEw
         xbLg==
X-Gm-Message-State: AOAM533fuJhJX4+ieMkqc2gqE+Jo5yNP2KFpse6s0DUJw05BKNt4Rnkq
        +OEQoifCwMUHv1/L4Ojc17LTkx0I0LKD9Q==
X-Google-Smtp-Source: ABdhPJzZNZ+oElIuD8hyAJsCRojd7E9P5s7T4v1j25FnAa9WEt4lxUh2f2/byzpW7g2RvL9nkFmg5A==
X-Received: by 2002:a37:40d5:: with SMTP id n204mr6611748qka.79.1615583911835;
        Fri, 12 Mar 2021 13:18:31 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id d24sm5177490qko.54.2021.03.12.13.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 13:18:31 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 4/5] sunrpc: Prepare xs_connect() for taking NULL tasks
Date:   Fri, 12 Mar 2021 16:18:25 -0500
Message-Id: <20210312211826.360959-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312211826.360959-1-Anna.Schumaker@Netapp.com>
References: <20210312211826.360959-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We won't have a task structure when we go to change IP addresses, so
check for one before calling the WARN_ON() to avoid crashing.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v3: Clean up WARN_ON_ONCE() to avoid a new if
---
 net/sunrpc/xprtsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index e35760f238a4..eb8df10aac9c 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2310,7 +2310,7 @@ static void xs_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
 	unsigned long delay = 0;
 
-	WARN_ON_ONCE(!xprt_lock_connect(xprt, task, transport));
+	WARN_ON_ONCE(task && !xprt_lock_connect(xprt, task, transport));
 
 	if (transport->sock != NULL) {
 		dprintk("RPC:       xs_connect delayed xprt %p for %lu "
-- 
2.29.2

