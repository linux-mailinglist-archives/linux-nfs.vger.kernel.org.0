Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF032AC0C9
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2019 21:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392509AbfIFTqq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 15:46:46 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45925 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392364AbfIFTqq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 15:46:46 -0400
Received: by mail-io1-f67.google.com with SMTP id f12so15341274iog.12
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 12:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oYFP7LnHnffo4j/n4viWpRrrs/1IS/MsGu8QY/P3UN4=;
        b=jDbrpG/DuFLTBs765iu9l69XllXeLOL/F0ipjh4ACio2/EgnISw3Vq2MzoYKK04L0K
         BkviwOB3AwZUaWkqcRU0SzDD6F+auJEt6Gq5pI3myk2M8kObrrBFjg+pX79CUhV16Pag
         N9eX/QKwBTkpUE5ZKVYvKKgDUHIFaSOz0q2aXZ4FaF/ouqlbkIWXIemepYPGP9oyOiA/
         moX6efuJ7YMHqWFFz2pgQv1n6jjPcZayMQAl1gX4kkdct88cnYAYHA14fni0JKm57DgJ
         OL3fqfyhnTT+B6YqerYPtJYeq+TFacjK9FMHJG2JmZ6F/DX9zxx36zw0CsiBwfdbm/Ra
         6KSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oYFP7LnHnffo4j/n4viWpRrrs/1IS/MsGu8QY/P3UN4=;
        b=HDWAQq+IUa1ChGIWDUR1faidbuJtp9Rdywk/7B+yYXw5ST8LmrRrv1UxVpGNvY5f0I
         jNo/RkuSjS3SKBy8rJwx0YXfIVf1fg71x+v21rEN6c13/P9a/WS2uKTCLiYj1LU+RZ+D
         BC/B/Y+6t5HauEJtT0vOwtL3oCmihbw72+xF/5lizvjBpquPAe42cM1BKkFdOUsTkkEP
         rxjgWMg9TXDNtIrXjwK0jzz7kBLRr4ZcCyXjTIirZwtHYZM1Eyjn6jGiMun88yFajx1p
         HuWdemxk07P/hAZFIhBKWq03u4Jp0z5WykY02UT4xdytaNhpZaWuPpWBo5ex8jRvvc6/
         4CuA==
X-Gm-Message-State: APjAAAUu5kxoJ/5Pyme4M7FDGmaiuCoWDErvo+nyzPhtu7O+SVrlvrO1
        qVCZrYXaHfFXvr48EULWJXo=
X-Google-Smtp-Source: APXvYqztxOm055zPL2mqo+7RDPoI7BKnRREIQsoOTooIh0Trx01+q8HgajEOteUbTNDlIOOLTlrXWQ==
X-Received: by 2002:a02:a403:: with SMTP id c3mr11338349jal.93.1567799205572;
        Fri, 06 Sep 2019 12:46:45 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id i14sm5118085ioi.47.2019.09.06.12.46.44
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 12:46:45 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 11/19] NFSD fill-in netloc4 structure
Date:   Fri,  6 Sep 2019 15:46:23 -0400
Message-Id: <20190906194631.3216-12-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
References: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
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

