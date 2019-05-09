Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA17218C93
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2019 17:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfEIPAK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 May 2019 11:00:10 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38306 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfEIPAK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 May 2019 11:00:10 -0400
Received: by mail-it1-f196.google.com with SMTP id i63so3209414ita.3
        for <linux-nfs@vger.kernel.org>; Thu, 09 May 2019 08:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=jTJcjrURoeK2waouc+GXKvw2+JFb1K7d+xZdXEGijdM=;
        b=CPLMfGIHE+SFmbjc4Yx+swe0kEW0dKcwrq7lA4zMpfb/wq8ubgOCWYjLx9zUuC1ljc
         10VmJHfgpmeVJ7TGZbjH03vmb5jysjWyUVPo0GrN6Zgt+tE9g193x/AnP42J7VZgFhle
         mX1XdUFVf22fCqZl1qoGk9+gfFsRFG5FgxQyNs12l2mt3IHXIhxPeqQKitPq/ffAvFyY
         tlnDMrSEdxKVSU9sfNGoAaG9RuW7RDQdm8HyI/IssMsi0099tn55BYyoWaHDjCsCo251
         tWxkqooGZZvLjKJHDianyduvCdz4AZjfrJecGIaaoqJl/aQTw4hLQe9kbqfOZFkoMvMX
         NmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=jTJcjrURoeK2waouc+GXKvw2+JFb1K7d+xZdXEGijdM=;
        b=YQuyWdKItgaBEeVIqZVB69q3kCB4o1HZiXfSrQgvxURkxxIn31FZSl+fh3EFao6NqZ
         O7vOY0UvwznELVDGEKU/waHKU/LAfH38/dHeJCYlLuLaO15En6xTc4+qPqJfJSt+YCzY
         RzTOobnmFIaznFmlm/MvIkRk95SW+sDcch7nX5wcnsUn+dDxHKOcKacO9AICeQCljKMa
         KDtCeTyLCkD38IOGx+5U+/VWiDgGsAs3aTeY5rlZqomzwOS1jW22DT1VJCHNaitiGr33
         TVb3U1bNiLLaQheVmiRAlBbXpdU96ayMaPgJGXOn8eTJRSNPzdTIAgKmPanplgndetGR
         36eQ==
X-Gm-Message-State: APjAAAWSqYePMMSzMQvvzvJm+YsFTT0GP/FNoBlbMy456x/QXl4MWKO+
        H4ohmgnwDd7CQGxgE3qnif8ZK0ET
X-Google-Smtp-Source: APXvYqz/Yqq2XQ3OHcXBqEaykYK7M95S7CyiasDBtLJ/+i6ZPllKLE3iuszTqmQL1xcRRbstphwh0Q==
X-Received: by 2002:a24:eecf:: with SMTP id b198mr1990684iti.47.1557414009647;
        Thu, 09 May 2019 08:00:09 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x11sm793726ioj.49.2019.05.09.08.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 08:00:08 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x49F07M5005637;
        Thu, 9 May 2019 15:00:07 GMT
Subject: [PATCH] SUNRPC: Rebalance a kref in auth_gss.c
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 09 May 2019 11:00:07 -0400
Message-ID: <20190509150007.18641.65258.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Restore the kref_get that matches the gss_put_auth(gss_msg->auth)
done by gss_release_msg().

Fixes: ac83228a7101 ("SUNRPC: Use namespace of listening daemon ...")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/auth_gss.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 06fe17c..4ce42c6 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -551,6 +551,7 @@ static int gss_encode_v1_msg(struct gss_upcall_msg *gss_msg,
 	refcount_set(&gss_msg->count, 1);
 	gss_msg->uid = uid;
 	gss_msg->auth = gss_auth;
+	kref_get(&gss_auth->kref);
 	if (service_name) {
 		gss_msg->service_name = kstrdup_const(service_name, GFP_NOFS);
 		if (!gss_msg->service_name) {

