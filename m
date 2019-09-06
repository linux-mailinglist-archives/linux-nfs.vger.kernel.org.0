Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3B52AC337
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Sep 2019 01:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393146AbfIFXg0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 19:36:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38443 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393142AbfIFXg0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 19:36:26 -0400
Received: by mail-io1-f66.google.com with SMTP id p12so16622692iog.5
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JXH2tCBLDWSi1+VlBVKyQNoUN9Q1nVxnah6pXhDF+WA=;
        b=U1lDaPyFZQQWgE3F3bwW6B+HBRcofWaIR2I4Fjf3R/atQkVIQwOZcOG5g7TMCfP+mC
         C/ROZ73aZpA4GY18X6ddzCsIMwavE+TeeSAvr+LdHAcAvdDSHy6Vl1DznZPVxrMLh0Cv
         bDUpjhMqNMUXVXpRi9Ip9a5abBBeaHX0+33cm0mweON0Bdot/7oF53Aox7J9nyqMP73h
         CHfbpGZ7412RiAV8OAu68UA9Et+kCQfVNB/pR0NHlohtsF4XCLmUIaTNMLuy3kcL4bks
         YcKJ3NLm06UMxO4CnbhAK0w9gL+nLDUiD8t/iWgNRjTZHX2+R7nHqSpAGES8aLHd8sbQ
         sP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JXH2tCBLDWSi1+VlBVKyQNoUN9Q1nVxnah6pXhDF+WA=;
        b=IgrlYu6gRo9j9dArOs9syP9Bb3WAdBn7uCg2nqOUALgr54uhO1pyiQvc+VgP0ohHWJ
         WEjxXB+CtXj4R3/lh8faqYdll04zWTlylBaPyDMsUz7RZIHqOhDeRSczfBdBaI5IZAUC
         i72FKcTcaEMsxX56DTlFygo3DWVQ0cAVJxtbZSeanJFqV7rj39KTsd/JhV6wnLZxprUL
         RrMbJ4nqzBJFqW5WwnbppJGcm4GsJjkm5UA9obBOX76R70jaDgo9bVunKDP67pUqS4lA
         cBHskyT3vubffikbrB8CYbZJcNbOarc7Hdiv2fk2Bi6z6lf3atBomwDRUfKiVQpeHMzd
         Vt3w==
X-Gm-Message-State: APjAAAU/NC8V6hjQubTW7fjI5cHRHPKPwLi6VWGGoSi+d4BWHNjoQd3a
        /+QulX0Hz9SYTxZR2GyidsA=
X-Google-Smtp-Source: APXvYqwPab2mAMAEjoIA8/9zQlG2boJxKv+zf5fNxOwH759HnOQUm+ckfMmj207qc8FgSEuSeBl8LQ==
X-Received: by 2002:a6b:6a19:: with SMTP id x25mr1580750iog.154.1567812985930;
        Fri, 06 Sep 2019 16:36:25 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r138sm10439360iod.59.2019.09.06.16.36.25
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 16:36:25 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 13/21] NFSD fill-in netloc4 structure
Date:   Fri,  6 Sep 2019 19:36:03 -0400
Message-Id: <20190906233611.4031-14-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
References: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
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
index af2947551e9c..687f8e15f386 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -19,6 +19,7 @@
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/svc_xprt.h>
 #include <linux/sunrpc/msg_prot.h>
+#include <linux/sunrpc/addr.h>
 
 #include <uapi/linux/nfsd/debug.h>
 
@@ -386,6 +387,37 @@ void		nfsd_lockd_shutdown(void);
 
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
2.18.1

