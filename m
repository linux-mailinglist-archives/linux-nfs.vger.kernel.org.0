Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3B72F220A
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jan 2021 22:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387911AbhAKVnI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jan 2021 16:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388032AbhAKVnH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jan 2021 16:43:07 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD47C0617A5
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 13:41:53 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id y13so716092ilm.12
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 13:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2lwSYtzRiaoTDkNyVvPYOL0d/MoaKnDuy9kjU6EPUtA=;
        b=bbk1r9mvRdg9Au2K5JE05aYYqY+CLpPZCOHl0b473nOvUR7dGhXMNJOlehAcayJgP3
         Wt4IgrmfxQaMqmBcMEFv5/ZBQLaq8VfgUow371bF6dp27HVTlB+KjPv8lbX7fXZuAz6X
         37jZ5vrW022KEPKW8S5U+o9WSLzI+rRd69gTj4AmBXBjmSzqRG1PHDNE++BvGjaRMWKA
         FK55OiJ4cn7oM9jweh5BZ/TUjdte1txCnp10o0eXsoGbqxlFeDorXiJknBl9tIESroC4
         V0nu4F0exFSpYT7KXsWP9v1iaAZuMFTyQr84xDmaevf1/6BbkBKy8zzF/RGt1Te9+ohB
         lOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2lwSYtzRiaoTDkNyVvPYOL0d/MoaKnDuy9kjU6EPUtA=;
        b=e3+/UiNO91k8TAF/1RZJNnO9nhIrZGFb0oAzbbgKgFCSYxZKtoPuLN8f1v/Aixs/nH
         +QqNbdQo12qzd6MRrDoO/TRM9W8wY3HeWmr8Pbm6QUc75/hm1kQVt9a9GhauDr1I9KoC
         WRzhLxw5Jm3rOdw0nj3kY2w+iPlzHzBVWDxFBze6D4GJxhQNLhxqXPQs1pSXdEBsh9UV
         wh/bP3pMaiVt35dYigsUaAp5Uc8aRRCo9G9OVmIm09DH4WV8kfL7xf3OXCnMAjWt5HGh
         G8QGEybvPxCR16C5FlExrFxkxbS2o9ag9Y+SqPMDsBtOu5GxZoc0h39vNvyWEXlPwwjP
         ua/g==
X-Gm-Message-State: AOAM531zD25zBRlfUJRul+2IkNMwM+J+wy0fzpm7/kXhfCO2Woyu3YX7
        NsVilNJdhvyXK5IuHCD4ax3t3VoQj6VXjQ==
X-Google-Smtp-Source: ABdhPJwjhFG2Sylmy40mCGV4UV5Cv7x6nkJCAgX2lFy5tl9oAOXEbm/NRliSBbLWa8vxcmT4UM2uwA==
X-Received: by 2002:a92:d44e:: with SMTP id r14mr1034188ilm.299.1610401312393;
        Mon, 11 Jan 2021 13:41:52 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 143sm681712ila.4.2021.01.11.13.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 13:41:51 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [RFC PATCH 7/7] sunrpc: Connect to a new IP address provided by the user
Date:   Mon, 11 Jan 2021 16:41:43 -0500
Message-Id: <20210111214143.553479-8-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
References: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We preserve the same port number, rather than providing a way to change
it. This keeps the implementation simpler for now.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/sysfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 537d83635670..47a7c9b8b143 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -70,6 +70,13 @@ static ssize_t rpc_netns_address_show(struct kobject *kobj,
 static ssize_t rpc_netns_address_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
+	struct rpc_netns_client *c = container_of(kobj,
+				struct rpc_netns_client, kobject);
+	struct rpc_clnt *clnt = c->clnt;
+	struct rpc_xprt *xprt = rcu_dereference(clnt->cl_xprt);
+	struct sockaddr *saddr = (struct sockaddr *)&xprt->addr;
+
+	xprt->addrlen = rpc_pton(xprt->xprt_net, buf, count - 1, saddr, sizeof(*saddr));
 	return count;
 }
 
-- 
2.29.2

