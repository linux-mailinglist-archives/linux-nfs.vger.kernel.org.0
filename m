Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4BB46872
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2019 22:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbfFNUAU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jun 2019 16:00:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41959 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfFNUAU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jun 2019 16:00:20 -0400
Received: by mail-io1-f66.google.com with SMTP id w25so8348736ioc.8
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2019 13:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xc7ronT0Pcj8DKHR9phcsbPa0p2saIP2y7Dzd+EiEPc=;
        b=HHSUvgc5DhikeNbDFz5iKsWTmFb6cLHnOQMN4maY97gYvB1apylDv4nuvEZNUfT3my
         STpNB05c/DqmV56kcS1R0+mleF2GN6mMKlnpUKQSP/QqsedQgS6LvzJwlP0b9NW+/zn+
         fKC3AXXBmiqsRhajxgM//mqOr1K3/RZdCu8i27zfvfUdxXgtHwRr06FFGMxuxagYSWcp
         km1P//KLCOybKKYOpUCb4R+qzwpMMljMCmuwWdQjsG1SMbG+dy/s+et15fAu+F5ejgv0
         cdJTPgPI8Xcj2Js0TgjU/6bQd81iYUshw4npCMP4k/gsViDf/XxdSQ/oDGGpp1m7/mYI
         c4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xc7ronT0Pcj8DKHR9phcsbPa0p2saIP2y7Dzd+EiEPc=;
        b=ukwyBPc3EJvgMOct1MGWNvm5hQvUDKOsYb2esa99Ytn54uxlxn94ZFC9iGOw32HDk8
         QazyihlTJmMf83R/Y1noHJWtAoiWI7Ov4JyeIgi/Y5+Rug6yyUAK6bVF7b8GLJ5WDFHp
         8WTBqkw8vA1DU5xdkMBKMhyIbNa+NIAWpe5k9/XzaaTClnms4DXv+DlDXC0J3NJGL/Y0
         UhtXWHwh82+CgUSC9yJfuLJZxAXt0Y+k4gudpXRrykPvA2r+fXlkLMAoD+s4ne1sg0Yj
         OETEP4fM1dx2isdKlKel/O6mnTa9nXbjqGHhAnbObWnYHM0OzfIjvZ6eJ5AmNtyIYBw7
         ZJ9Q==
X-Gm-Message-State: APjAAAWQa+bdJaoPj5Pgc1eOQw8k6WExN+FGzUkFJDHB93qpALkIt0xi
        N1uYzlYQ+63vwrPsm/z9xWeq3rXvb+w=
X-Google-Smtp-Source: APXvYqwBbQV2szVL8W8lirJIfIc3r/VzOCdy6fMCZVCSYpAaD8tN6QeLFZjqSGa047bSmwqc/Ewc6Q==
X-Received: by 2002:a05:6602:2248:: with SMTP id o8mr19269677ioo.90.1560542419670;
        Fri, 14 Jun 2019 13:00:19 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id p63sm4623407iof.45.2019.06.14.13.00.18
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 13:00:19 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 01/11] NFS NFSD: defining nl4_servers structure needed by both
Date:   Fri, 14 Jun 2019 16:00:06 -0400
Message-Id: <20190614200016.12348-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190614200016.12348-1-olga.kornievskaia@gmail.com>
References: <20190614200016.12348-1-olga.kornievskaia@gmail.com>
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
index 22494d1..38612d7 100644
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
1.8.3.1

