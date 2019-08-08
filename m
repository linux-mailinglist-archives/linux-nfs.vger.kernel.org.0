Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15C7286B42
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Aug 2019 22:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404324AbfHHUSx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Aug 2019 16:18:53 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38964 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404329AbfHHUSw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Aug 2019 16:18:52 -0400
Received: by mail-ot1-f68.google.com with SMTP id r21so117828062otq.6
        for <linux-nfs@vger.kernel.org>; Thu, 08 Aug 2019 13:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oYFP7LnHnffo4j/n4viWpRrrs/1IS/MsGu8QY/P3UN4=;
        b=Z35gemIb8IhcaebmrOiZFPUFAsqe8nJ3kpT38MnrMgO/3XSa9AmgGsniTpVZwsaacc
         mtC7Znlcs9MoasktJVySf1ORe9e3+yRt4wEwhEfmjnUHDCWPIN4EuEeDPcgjG0awsBH1
         UKAnU0lfEHimuE3H45HEb41kxNfPpox3pdEedmzR3ZwagSNJcX5kVsck+iKeHD2i1Z4i
         WYt+bNx6rzyhAwzFZ8WMWb0Wodx/KEQOHlw6npSc/4a5Da/5GzZRdT78lAzyoSHjd9D8
         7axSpI/JmqbLU78dEaqpO2n9mvmwFBCeKdTJrXwD45zI3tXenD07dTDC/9YrmA6Odoqz
         Irbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oYFP7LnHnffo4j/n4viWpRrrs/1IS/MsGu8QY/P3UN4=;
        b=acg5jbQVCGgATBWgvjq/JKieHPbrvfY+4swQrUtRErMbdQKiBEWQOwrLuymLHuBRtm
         ejHok4D8+dFQwXAXcPzRP+pbMbBe7xBVEoJfHdbMS5/FMQXAbIWfK2/m+HgSABS20N+F
         AqVOgdLYI3CNZ730mCXTBqppMVCcIgMgPOlEybElvGKO+4iv0qeUOlTpLKG6NmfrfEEZ
         AScGvjWxyUfp+bXYTWa0MeJ4lhGQyg1j6hM4fhxNnZMfRM4rpROPpMW7lUN/0tLpA4+S
         fksBVBq1Kvzad3u7vYlDwCQnuTH7Jo4K27WrpN4gFfg3aKODOG71UOkVdz5+wOyVzqoO
         bpoQ==
X-Gm-Message-State: APjAAAUqVWilO1ZXnHmN57SOsQQEyYN3O+Ce19RgWvVUpSB81PClTHZf
        Qdg+hfc/FpbBetvSR/tnUFw=
X-Google-Smtp-Source: APXvYqw9FuNmth0afsk1teiXK1tAYBfp/cGgxFqFzQhH4FSXVXISzIC1tBrcJJ3n53IK7FLdSwKTEg==
X-Received: by 2002:a5d:8451:: with SMTP id w17mr17749337ior.226.1565295532061;
        Thu, 08 Aug 2019 13:18:52 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id m20sm93590523ioh.4.2019.08.08.13.18.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 13:18:51 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 1/9] NFSD fill-in netloc4 structure
Date:   Thu,  8 Aug 2019 16:18:40 -0400
Message-Id: <20190808201848.36640-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
References: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

nfs.4 defines nfs42_netaddr structure that represents netloc4.

Populate needed fields from the sockaddr structure.

This will be used by flexfiles and 4.2 inter copy

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfsd.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index af29475..687f8e1 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -19,6 +19,7 @@
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/svc_xprt.h>
 #include <linux/sunrpc/msg_prot.h>
+#include <linux/sunrpc/addr.h>
 
 #include <uapi/linux/nfsd/debug.h>
 
@@ -386,6 +387,37 @@ static inline bool nfsd4_spo_must_allow(struct svc_rqst *rqstp)
 
 extern const u32 nfsd_suppattrs[3][3];
 
+static inline u32 nfsd4_set_netaddr(struct sockaddr *addr,
+				    struct nfs42_netaddr *netaddr)
+{
+	struct sockaddr_in *sin = (struct sockaddr_in *)addr;
+	struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)addr;
+	unsigned int port;
+	size_t ret_addr, ret_port;
+
+	switch (addr->sa_family) {
+	case AF_INET:
+		port = ntohs(sin->sin_port);
+		sprintf(netaddr->netid, "tcp");
+		netaddr->netid_len = 3;
+		break;
+	case AF_INET6:
+		port = ntohs(sin6->sin6_port);
+		sprintf(netaddr->netid, "tcp6");
+		netaddr->netid_len = 4;
+		break;
+	default:
+		return nfserr_inval;
+	}
+	ret_addr = rpc_ntop(addr, netaddr->addr, sizeof(netaddr->addr));
+	ret_port = snprintf(netaddr->addr + ret_addr,
+			    RPCBIND_MAXUADDRLEN + 1 - ret_addr,
+			    ".%u.%u", port >> 8, port & 0xff);
+	WARN_ON(ret_port >= RPCBIND_MAXUADDRLEN + 1 - ret_addr);
+	netaddr->addr_len = ret_addr + ret_port;
+	return 0;
+}
+
 static inline bool bmval_is_subset(const u32 *bm1, const u32 *bm2)
 {
 	return !((bm1[0] & ~bm2[0]) ||
-- 
1.8.3.1

