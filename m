Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6613B2578
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 05:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFXDbS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 23:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhFXDbS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 23:31:18 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6B0C061574
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 20:28:59 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id o5so6171721iob.4
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 20:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8GxraR82L9fNcxFEXCeukO6xiXhWsxYlbSPpiRziGFo=;
        b=JYFTRdX26WR0i1iPAHtCjl3Xa7ozCi8GoGIGTouI5e4NJfbVF12hjbHA/l/z4N9x3P
         MhBSIOEQGqvIXIAzCptHrxY1isNSwWyBl1eLKCNdZvSaw4we73N26VgqFk/kSC68qPFb
         sKwDnbF4b0mxwzERIOccEo9YMKevdG0wkbnS30DE07r+AAYDopGe4/AUzVYYXT33kduz
         XHaMWyueUWCu1p5/h9e9vQ3j+U82OlYepBKGBy82Jhpa6ogQbSsjLseY8JOEMiOwnoj2
         mnysZEGo9FG+24ZGG8xS5U/4hybUup3QHA+mHICwUVtSWgHM060j/lT7udWV811Q7rj8
         zqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8GxraR82L9fNcxFEXCeukO6xiXhWsxYlbSPpiRziGFo=;
        b=KcV/2J2SujDk2eSmZF9dokrnpC0Cn1ywUXotcUOCl9XH6Hmot41RT9ZxKTTKuhL8Uy
         wMRLSF+sK2yJhgIfVVvf7aPlQ8G2uUXwK8kbypNv18uwuQfwdVNtbqvZiKotnw3o3Sfg
         hwUFUZqDHwDWMI40MVDJ4SIbt57eDYT59WveSwOiYOa4vuTqbF9sY4BOmFl/+UxV/Nd/
         n+TuTAotSsrqnlE/e42xgEmDXkAiCVk2byZpqQlSFzHlEmzjZ9+mZT/Z6Gcq0Vf7JA3S
         GmuT4AoCu5zLyHYHOQRGtdC0aJTaH2TItHllKB1zjJtlHAWC/IFKX9KDguwPVQDvCw/r
         i82Q==
X-Gm-Message-State: AOAM530V21iy5pY2UHOIkMNkoDltBw31gdQx78sasO1aX6iczREwo6jh
        O1jl9OhmBWnetGCTZ3FX2FU=
X-Google-Smtp-Source: ABdhPJxTlh9gMzOtzeFIRH8vr036KCBguCdbOnUrdO2j2GfV/IG9/XOpR/8Z4p9aH2ebtM0DCJUwHA==
X-Received: by 2002:a5e:8513:: with SMTP id i19mr2268167ioj.50.1624505339229;
        Wed, 23 Jun 2021 20:28:59 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:fd18:15dc:e0e4:e39e])
        by smtp.gmail.com with ESMTPSA id g4sm1026780ilk.37.2021.06.23.20.28.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jun 2021 20:28:58 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/8] SUNRPC query transport's source port
Date:   Wed, 23 Jun 2021 23:28:48 -0400
Message-Id: <20210624032853.4776-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210624032853.4776-1-olga.kornievskaia@gmail.com>
References: <20210624032853.4776-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Provide ability to query transport's source port.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprtsock.h | 1 +
 net/sunrpc/xprtsock.c           | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xprtsock.h
index 3c1423ee74b4..8c2a712cb242 100644
--- a/include/linux/sunrpc/xprtsock.h
+++ b/include/linux/sunrpc/xprtsock.h
@@ -10,6 +10,7 @@
 
 int		init_socket_xprt(void);
 void		cleanup_socket_xprt(void);
+unsigned short	get_srcport(struct rpc_xprt *);
 
 #define RPC_MIN_RESVPORT	(1U)
 #define RPC_MAX_RESVPORT	(65535U)
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 2ad4d0df45fe..4611845ec1eb 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1653,6 +1653,13 @@ static int xs_get_srcport(struct sock_xprt *transport)
 	return port;
 }
 
+unsigned short get_srcport(struct rpc_xprt *xprt)
+{
+	struct sock_xprt *sock = container_of(xprt, struct sock_xprt, xprt);
+	return sock->srcport;
+}
+EXPORT_SYMBOL(get_srcport);
+
 static unsigned short xs_next_srcport(struct sock_xprt *transport, unsigned short port)
 {
 	if (transport->srcport != 0)
-- 
2.27.0

