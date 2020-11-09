Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6502AC70D
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 22:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbgKIVUr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 16:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730459AbgKIVUq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 16:20:46 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50D2C0613CF
        for <linux-nfs@vger.kernel.org>; Mon,  9 Nov 2020 13:20:46 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id p12so7107668qtp.7
        for <linux-nfs@vger.kernel.org>; Mon, 09 Nov 2020 13:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sHV5eOK+G8n9EPQWL9oMmz3WBFmv12mVOlCUiLjD0qM=;
        b=h64RT1B/KDmNu5aC+Dl+VfsHCmM7Gv8XWAhUVYnU7FULcRPrJt8AUiJRzYv2f3xChc
         WQxKEOA/ynCR+4N0SYbJCAmiC01Z2EFxpvaNyryV9V2eGpoKcU5PrUw9822MxvactObv
         WTgGEgUgmunUMfrCxP9ERtDDo911DbcK4vpBuT+44rs6ml9v2moAaVC1cDzcLBrUINas
         Lo/MmfPPamHEj1jau6gC9JB4wt6+2cUTOk253jHUyzRwxgZJ7H7x/mJImkthAvZqg02x
         jif0ACWLSgr0V7J5yvNg39x3GmRNmWU37ayD0aaHPwkNr6/IrhJnxVLPiu4gv/o4c0+v
         b0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sHV5eOK+G8n9EPQWL9oMmz3WBFmv12mVOlCUiLjD0qM=;
        b=KakoJCtN1X7W+tVAn+XR4E7S/SRnQxGWpGAdnNkNnb5n3QF3wpNWFuWz6ZOZX+QL0i
         K3V5+bGkrEPTugg9/YyTlwo4Zo0XWcbl1jaEllySX8JxzdwZ3VOBRjzh7Q2Q0zkWBfhY
         +LmU7NxNRQmaJX0fj+L5mz7pTsbeJMhxgnH4Oo6YqnOMTI93V/1UzYDBTgpN6a7IECPj
         ZSuokEJ5/KLvhQWEdAZSGC2AOzglbcspaJGrTO+xnAmE4MOz0wu9BNo1+E6lCOT/Ijhx
         tji3s5kNJBTWIbBoEanywLzQaVBrJAxJol8ky/QBIqKcNZLV5OsoLVBrXkMkA1kiKMBq
         J1FA==
X-Gm-Message-State: AOAM531TUwjBuWU3EPyOiXBWHyMp9zjB9OcAZQqPlUWbgSao447u+9O4
        EXNR5O6EXc4/TbaunbJHLw3+HEEtPbQG
X-Google-Smtp-Source: ABdhPJx+uqGgqZ/YPXt0OxEYOY2xQ5St3OQp5NF9ofNpXn7YONkQhaKZUJUJTJiWru5oP5/+CVWxJg==
X-Received: by 2002:a05:622a:86:: with SMTP id o6mr1631168qtw.147.1604956845676;
        Mon, 09 Nov 2020 13:20:45 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id d188sm7025241qkb.10.2020.11.09.13.20.44
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:20:44 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/5] pNFS/flexfiles: Fix up layoutstats reporting for non-TCP transports
Date:   Mon,  9 Nov 2020 16:10:28 -0500
Message-Id: <20201109211029.540993-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201109211029.540993-4-trond.myklebust@hammerspace.com>
References: <20201109211029.540993-1-trond.myklebust@hammerspace.com>
 <20201109211029.540993-2-trond.myklebust@hammerspace.com>
 <20201109211029.540993-3-trond.myklebust@hammerspace.com>
 <20201109211029.540993-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that we report the correct netid when using UDP or RDMA
transports to the DSes.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 34 ++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index a163533446fa..c760238ba649 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -2279,18 +2279,41 @@ ff_layout_encode_netaddr(struct xdr_stream *xdr, struct nfs4_pnfs_ds_addr *da)
 		if (ff_layout_ntop4(sap, addrbuf, sizeof(addrbuf)) == 0)
 			return;
 		port = ntohs(((struct sockaddr_in *)sap)->sin_port);
-		netid = "tcp";
-		netid_len = 3;
+		switch (da->da_transport) {
+		case XPRT_TRANSPORT_TCP:
+			netid = "tcp";
+			break;
+		case XPRT_TRANSPORT_RDMA:
+			netid = "rdma";
+			break;
+		case XPRT_TRANSPORT_UDP:
+			netid = "udp";
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			return;
+		}
 		break;
 	case AF_INET6:
 		if (ff_layout_ntop6_noscopeid(sap, addrbuf, sizeof(addrbuf)) == 0)
 			return;
 		port = ntohs(((struct sockaddr_in6 *)sap)->sin6_port);
-		netid = "tcp6";
-		netid_len = 4;
+		switch (da->da_transport) {
+		case XPRT_TRANSPORT_TCP:
+			netid = "tcp6";
+			break;
+		case XPRT_TRANSPORT_RDMA:
+			netid = "rdma6";
+			break;
+		case XPRT_TRANSPORT_UDP:
+			netid = "udp6";
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			return;
+		}
 		break;
 	default:
-		/* we only support tcp and tcp6 */
 		WARN_ON_ONCE(1);
 		return;
 	}
@@ -2298,6 +2321,7 @@ ff_layout_encode_netaddr(struct xdr_stream *xdr, struct nfs4_pnfs_ds_addr *da)
 	snprintf(portbuf, sizeof(portbuf), ".%u.%u", port >> 8, port & 0xff);
 	len = strlcat(addrbuf, portbuf, sizeof(addrbuf));
 
+	netid_len = strlen(netid);
 	p = xdr_reserve_space(xdr, 4 + netid_len);
 	xdr_encode_opaque(p, netid, netid_len);
 
-- 
2.28.0

