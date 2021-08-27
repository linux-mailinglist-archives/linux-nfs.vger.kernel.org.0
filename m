Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5A23F9EEE
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Aug 2021 20:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhH0SiT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 14:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhH0SiT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 14:38:19 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F78C061757
        for <linux-nfs@vger.kernel.org>; Fri, 27 Aug 2021 11:37:30 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id u18so1572114qvq.3
        for <linux-nfs@vger.kernel.org>; Fri, 27 Aug 2021 11:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8KwAKcBqY1TTWZry4fngp7gp1LU/zMCzkYKAzNot33s=;
        b=son+yMvdvQL+aGvCctRYFihUhvzN4/1U+iJsjcpdzFBdN+ywOAeyJ2sSnLCouue666
         4bKZbdQez7gQhy6tnWHVXmya6+LYnpzCOwUhQGRWKSlSxkUGzItXhwkUsYgqlIJRy4TL
         Qu9urlTZBG7DJPnJ67PFepSZpA5OJQwoCPgscRbj0au078KfwxGO3UJVnR3VrlY5abex
         QNUIFsaXHKJE6q64H1NqclEebD//IlE2cgEVRNTV+zJQ0I9hjCNeb3BF4j3MAgvRtpxm
         HaqFlVZeVX8JbucFV7xcx5d1VoUs7mHrCu+mOvGLxZZwbtPYDVDQRJfTtlYroUoNzTPX
         vHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8KwAKcBqY1TTWZry4fngp7gp1LU/zMCzkYKAzNot33s=;
        b=ZyPaNA/h+9IRk3d1rm0UWkPul+ZWnhMjXEbZvLo/bbZ90wYkLoQV6CYs62swOQtqZt
         HEUCm2kshEsKmguokIjNKShdeE5RPFB3PuIZ9Vbhor3vWxeU3CVhgOoBh2iibkwTqOgZ
         cSuU2jY3iWvPNjzvuVgD6UJD+vI/50iWPfiiusKDxzc4LZD6/zdZKVgttJ/rQ0cYEUl3
         FSeTo3V/bnYmuwkF8PXRqHTThep4mzq0hgk6F5Lbrlpjs/AWNEaK8kcZsIGJvbuLKJ/2
         w3dznB8bjVVsuo8tfwaTVnEZNKWR/eQBuMG9j/9wuVSXWpMIbvkDc2gpQ31xtQq0oYNI
         LIjA==
X-Gm-Message-State: AOAM531CBW9Y/kMjfzhGrvWZf5hUQmiMWqZT/nvAqPEKd4wKc/2R8Lw7
        XaC4P3REoL3vklY2o+mgqTo=
X-Google-Smtp-Source: ABdhPJztznM23GdGM0HO9WQ70y+zNF86Bve9n9i5Ri0i2ALUqo37wWyJ+JjGVPKJfJJGCFeSZgeimg==
X-Received: by 2002:a0c:d68f:: with SMTP id k15mr11223760qvi.14.1630089449290;
        Fri, 27 Aug 2021 11:37:29 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:b143:41d3:e2f6:337b])
        by smtp.gmail.com with ESMTPSA id bl36sm5207463qkb.37.2021.08.27.11.37.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Aug 2021 11:37:28 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] [man]: adding new mount option max_connect
Date:   Fri, 27 Aug 2021 14:37:15 -0400
Message-Id: <20210827183719.41057-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210827183719.41057-1-olga.kornievskaia@gmail.com>
References: <20210827183719.41057-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

When client discovers trunkable servers, instead of dropping newly
created trunkable connections, add this connection to the existing
RPC client.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 utils/mount/nfs.man | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index f1b76936..57a693fd 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -416,6 +416,19 @@ Note that the
 option may also be used by some pNFS drivers to decide how many
 connections to set up to the data servers.
 .TP 1.5i
+.BR max_connect= n
+While
+.BR nconnect
+option sets a limit on the number of connections that can be established
+to a given server IP,
+.BR max_connect
+option allows the user to specify maximum number of connections to different
+server IPs that belong to the same NFSv4.1+ server (session trunkable
+connections) up to a limit of 16. When client discovers that it established
+a client ID to an already existing server, instead of dropping the newly
+created network transport, the client will add this new connection to the
+list of available transports for that RPC client.
+.TP 1.5i
 .BR rdirplus " / " nordirplus
 Selects whether to use NFS v3 or v4 READDIRPLUS requests.
 If this option is not specified, the NFS client uses READDIRPLUS requests
-- 
2.27.0

