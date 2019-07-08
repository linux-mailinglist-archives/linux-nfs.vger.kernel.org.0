Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE6246294B
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 21:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391659AbfGHTYo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 15:24:44 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45597 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391658AbfGHTYo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jul 2019 15:24:44 -0400
Received: by mail-io1-f68.google.com with SMTP id g20so16752427ioc.12
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2019 12:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u4cDjbHMsQzeRKsi8cH8bry88PlBgp/Iza2eOmK8174=;
        b=YZ9gUHCMd71ERKQvOIKJ29438BP19yehjEBbrF/M7GWKQfr+6v6iiy9PUFioK9H/BX
         0krvJGvE+FNFNZEReKV+U0eERiSl2+DC5+PDWg7vKbSdnTmDj1sPY4K+vN/vGhPTAVvd
         joPBVu8DAYSFPnqSVvG/Fo6wEH+of6mZ6eV7t/gu+priHaD6/8ZSu7e1VNMgdEPYi9Tz
         Gn6HdcmUxk+4mLovR+dwkIeaJfiUD/RRfrd5zIjV6WL51ugofEamP495BUcNLT3gOW/S
         jNBS6cS//g5eYc0IiODZ1T0s0ZhCQTtcD5pY/F57b15QUYtiT3W1UWH7yDmRkrjOu8RU
         4nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u4cDjbHMsQzeRKsi8cH8bry88PlBgp/Iza2eOmK8174=;
        b=lWFzGh/Ls71gKuVcVr/s13bvdQvM3ft38muvTw8baxtdZPQXWAhI40lQ68WdXNSW4y
         Y5SNjHqbGugR7QTMxPqR4TSsTPrPyFij8BkB3FVt2cwkJHKnaDDXCzk900bsd1pEWNMW
         boSiEXfZX5Fg5PJuG+VkZaI8B2f+Dwqnx6t/C3MLjwmOmu9DAmdxCvlEDpLypXFrrhfv
         iOzhJgVioD7A7pWbJmNX+fXoWP0ByUiLD4Lem3kLOJtiOGEX9VAWQsVMa4RlVN01FLrU
         CPEa5bWcd8R1+YiqAqhB/ORJEQ2KYGGyAM56frntKQa0fmpMfKUHbXwG2863eIrC0Ntq
         CQOQ==
X-Gm-Message-State: APjAAAXMc+EEyTDu2JCtt0Cxue+szwu/Nea5lotB644EEA6Swl2UcWZE
        wBZYfyO+aiyqMNb98ZO+2GGMy7GCn4M=
X-Google-Smtp-Source: APXvYqyOrgjZqFzZbRVmXD/DBcmPQ5IIYDny7MhYvqLTZ+wJeqes6gPvtLF5udNPcPOBrlWmIliaoA==
X-Received: by 2002:a05:6638:517:: with SMTP id i23mr17716277jar.71.1562613883670;
        Mon, 08 Jul 2019 12:24:43 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id n17sm17026554iog.63.2019.07.08.12.24.42
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 12:24:43 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 01/12] NFS NFSD: defining nl4_servers structure needed by both
Date:   Mon,  8 Jul 2019 15:24:33 -0400
Message-Id: <20190708192444.12664-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
References: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

These structures are needed by COPY_NOTIFY on the client and needed
by the nfsd as well

Reviewed-by: Jeff Layton <jlayton@redhat.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/nfs4.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 22494d170619..38612d7bd17e 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -16,6 +16,7 @@
 #include <linux/list.h>
 #include <linux/uidgid.h>
 #include <uapi/linux/nfs4.h>
+#include <linux/sunrpc/msg_prot.h>
 
 enum nfs4_acl_whotype {
 	NFS4_ACL_WHO_NAMED = 0,
@@ -673,4 +674,27 @@ struct nfs4_op_map {
 	} u;
 };
 
+struct nfs42_netaddr {
+	char		netid[RPCBIND_MAXNETIDLEN];
+	char		addr[RPCBIND_MAXUADDRLEN + 1];
+	u32		netid_len;
+	u32		addr_len;
+};
+
+enum netloc_type4 {
+	NL4_NAME		= 1,
+	NL4_URL			= 2,
+	NL4_NETADDR		= 3,
+};
+
+struct nl4_server {
+	enum netloc_type4	nl4_type;
+	union {
+		struct { /* NL4_NAME, NL4_URL */
+			int	nl4_str_sz;
+			char	nl4_str[NFS4_OPAQUE_LIMIT + 1];
+		};
+		struct nfs42_netaddr	nl4_addr; /* NL4_NETADDR */
+	} u;
+};
 #endif
-- 
2.18.1

