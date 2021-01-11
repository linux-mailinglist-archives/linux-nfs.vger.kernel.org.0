Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BCA2F2209
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jan 2021 22:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbhAKVnH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jan 2021 16:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387911AbhAKVnG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jan 2021 16:43:06 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB9BC0617A4
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 13:41:52 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id q1so751667ilt.6
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 13:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SW9sK2N6g/Ta8eXWJeE/yuBYQzAt4OFHO0Wdl6GzXf4=;
        b=mM+mGeRyR0v8qN9T0jGRoCgAsb+iyvtD5nGj8K0ZtqGxLtftwCfIOblOCqTHCN0eH0
         bIWTrs1x+wURSt7pgykAFjL+7zO0YQj46V+VoX65KGAnxHBASEuy5zh08Y/73alfq8gn
         +KFAPSppVcpVUZiMoGSktgc+y/g3nM+U1wmo1JT4MsBgQUPI111bJuhWCX2rB6LwKXjw
         87kOQ9XLi9ULOSQLFtPdoBbDZxOSCpl6nipj/32nTZbmvcFNR6pSlB1aQFZf8W/TWxA8
         raie9/lPBBrHMU9OtZtDx3T9j0WhUj9qiySpstS6I+RR5TNjVsnTDpaBm36yC5dgfDnW
         PHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=SW9sK2N6g/Ta8eXWJeE/yuBYQzAt4OFHO0Wdl6GzXf4=;
        b=hMdkEMV0W4JrhKIRK0vDfk583aZvAxnzyWwo02luvmKQjXoIcF6VzQGZbDT86rOTk1
         aTLvefybpEHPWXh4irEzS334P7xlD1LxVHh+QCHV8JDvSd36b0+VIjeBsOBGIObmK7jX
         QvY0l6YJWMiofCS56M/7QdouWlw77+cNbMktvpEcoFLVoebxaVeuO8FPl5n7u335lMMm
         bBeYf9xHvMh1wG/ZIcgMHuUdOQZVx/4yL8eezNWsqCvBGGpOaOUO2RiYgUwxYdz8Xa+3
         vwtsgG/hbToEBgheGZD0pK4Jnnr+Y2zeWDYDQf6GZ6YJ0KbWZxVhq7LeY1pYqx+aWRw7
         at4Q==
X-Gm-Message-State: AOAM5320Q+JyaFuoEmh43BvdIXlOwaopoFqGpMyFK0+OzDx+uquKyYYF
        8/PhEFS1TqHUWLHueTK0SRue/rfgYzZg6g==
X-Google-Smtp-Source: ABdhPJx4B3GwY1vCSYOQKdbSCqHfqjBk9UO4lZahOysQAiYckk6InhPku3p2B/yPj31b1zgIhNGUHg==
X-Received: by 2002:a05:6e02:cc7:: with SMTP id c7mr1089336ilj.218.1610401311360;
        Mon, 11 Jan 2021 13:41:51 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 143sm681712ila.4.2021.01.11.13.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 13:41:50 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [RFC PATCH 6/7] sunrpc: Prepare xs_connect() for taking NULL tasks
Date:   Mon, 11 Jan 2021 16:41:42 -0500
Message-Id: <20210111214143.553479-7-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
References: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
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
 net/sunrpc/xprtsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index c56a66cdf4ac..250abf1aa018 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2311,7 +2311,8 @@ static void xs_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
 	unsigned long delay = 0;
 
-	WARN_ON_ONCE(!xprt_lock_connect(xprt, task, transport));
+	if (task)
+		WARN_ON_ONCE(!xprt_lock_connect(xprt, task, transport));
 
 	if (transport->sock != NULL) {
 		dprintk("RPC:       xs_connect delayed xprt %p for %lu "
-- 
2.29.2

