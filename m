Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745203F689E
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Aug 2021 20:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbhHXSCs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Aug 2021 14:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbhHXSCn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Aug 2021 14:02:43 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8675C05340B
        for <linux-nfs@vger.kernel.org>; Tue, 24 Aug 2021 10:51:19 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id ay33so12604643qkb.10
        for <linux-nfs@vger.kernel.org>; Tue, 24 Aug 2021 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8KwAKcBqY1TTWZry4fngp7gp1LU/zMCzkYKAzNot33s=;
        b=gcXvRmjF2rcd03VroQvZmTx18uunvwsDyuumN6Xewc9ub5eCsFt0rq6WeUdhIHK8h1
         EKR7WZg2j3kF5ozpx9zDR0cqlHdT5E77RYHI8wWL2SveEAwLwTbKjFN3sevKUZSuynl0
         Ztoncz4Jfw7+cpHP5XPTug2lnZLKF8pXl5lhZp8iFIK8fmlWRNL9QqOsAj7C3S5E4Axx
         GO9zRYgCAs7XtIS8UklvRtv7cCh8LicHLzeQFFjgqbrU26ukP0qJpo/ypb5Opr1HsJ3n
         0dAhQGpvjAS5fLFk/2mfLqvfCbBf0smel/E5T24Pu5udMxVEQCawz56DuTIhFm1GbAh2
         ibug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8KwAKcBqY1TTWZry4fngp7gp1LU/zMCzkYKAzNot33s=;
        b=XHKtuRh2iAPMOjWhDhnCO3r4Dv8aMoW1bTV7YGuCMJRwbIsOJN6GP1jg/YuhNLx520
         UxM6m9UKlbcObLslJ+awyREbuvnQRvTsqfb6CnKXp6FHxbjN2+byeLbxLPNs/CQkOUHg
         FyCGddnhvgyPXh4airlQYzSQaH0hHzipfMDs+ixZBrtYVSSpBeO3ow6+omLW4jpcL2xr
         Moqs9joBfQjw5flQTIRyyekXTzfGcfnqCzWz2b3R/yGy7c8MzIUpuKH67v412FUb/QFT
         9tBr9zONR9uVreeBmfE0eOy5FxKpQ80E7h6AU11pFFJ3U980MWgQ1+BFHYpiUrZF9hl0
         bOlA==
X-Gm-Message-State: AOAM533go5j+LZdMVc3GNSuoFNCGC3q2YAcMCGlx9Z78UDb5stOG6dc8
        GmA+avdefP039z+G9vdola8=
X-Google-Smtp-Source: ABdhPJxpz7Gw7P/dpDUDXn9LvpeVIFYvWufj/ypB5YRKzWIjHev3riQ/VUOKuWuMLXU/8SBa9I/daQ==
X-Received: by 2002:a05:620a:d4d:: with SMTP id o13mr27579080qkl.466.1629827478835;
        Tue, 24 Aug 2021 10:51:18 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:549b:da99:adb5:676c])
        by smtp.gmail.com with ESMTPSA id n18sm11519658qkn.63.2021.08.24.10.51.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:51:18 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] [man]: adding new mount option max_connect
Date:   Tue, 24 Aug 2021 13:51:04 -0400
Message-Id: <20210824175108.19746-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210824175108.19746-1-olga.kornievskaia@gmail.com>
References: <20210824175108.19746-1-olga.kornievskaia@gmail.com>
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

