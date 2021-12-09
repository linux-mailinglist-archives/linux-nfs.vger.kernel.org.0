Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D9246F454
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Dec 2021 20:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhLIT5V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Dec 2021 14:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhLIT5S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Dec 2021 14:57:18 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6006CC061746
        for <linux-nfs@vger.kernel.org>; Thu,  9 Dec 2021 11:53:44 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id s11so6440521ilv.3
        for <linux-nfs@vger.kernel.org>; Thu, 09 Dec 2021 11:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4jtbUus3x2mijhthivfWTrn47zByzbDnzBGITE/pGuE=;
        b=g+BpSGSYTbXX2PLZqYh4GSTWJjCdyGv1itVdysbxxONNhQ9RM4684h51eadnekaj6B
         zg2Ld0ZIWQXuLSw5cFAyM6mwVTMyrEwWnMnAUFge8NvDkFnDVnT8jC6/skRCxYhuhlNG
         lbAESFjYtsVSao79SdTiYYy0qRzcg+Sl4+m3yfwOq/c25rrK7o3Y5ViBEz4uG2RiVZw3
         uTIaKiRjF2tldY/6mk+CmP4n2ISKVOauJp6iadUsmn1f/oKs/pTVWuiUiYn7gRrQ0LBW
         8ca97DJVcPXrMWx6qcw1opElmXrSjlSQQGXOHsooEmGKMCUpQbucGcOBWxs0N37SWAbW
         phgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4jtbUus3x2mijhthivfWTrn47zByzbDnzBGITE/pGuE=;
        b=IqmAtgAcLFjDeh3CWr8AxP2FeMA65ufhSfOfua15OPGdn+GgsqEsozq3o+cHeiA212
         kc1TydpGK7tJy7a7Um8qySi9e3I4QeNj2YDw+d/wqtJQm9DEYvtdcRvSzftU6HIsRwGg
         9V0IqsoH1o3/O3Z4h7WGHxILRwlkv6xBEIrEDRcIVonj4FGC8TUSt2KRigQhJ6l+yO9L
         nWeJVptzUZm041mU8YWVnlOxOicQzgGnMwYtwXY2KA+K6SUaSmP7/QVtxqKTKqQ1fOQ5
         wiuULwYNc41BA/2MnAmsc0JtqPkS0TUrxRe8hFKVgsrlyvvuK3Do2xFMhdderiD+AVO2
         nWag==
X-Gm-Message-State: AOAM530THiXa1DISChMmu26TkkGhb1ycbZBFeF1O8hNmRUdaD+7cl4l9
        n1KHl/CCwuqKBVBBzIbj4P32qn7InMA=
X-Google-Smtp-Source: ABdhPJwKdIUlmvCZaBgzVB5YYERsw6O0v6BKfsKNWSMMSYUZECAun3VezBqx6/zNFG6t7yczhZ1yWg==
X-Received: by 2002:a05:6e02:1c2e:: with SMTP id m14mr17948160ilh.172.1639079623724;
        Thu, 09 Dec 2021 11:53:43 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:554d:272f:69a0:1745])
        by smtp.gmail.com with ESMTPSA id k9sm383541ilv.61.2021.12.09.11.53.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 11:53:43 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/7] NFSv4 handle port presence in fs_location server string
Date:   Thu,  9 Dec 2021 14:53:33 -0500
Message-Id: <20211209195335.32404-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211209195335.32404-1-olga.kornievskaia@gmail.com>
References: <20211209195335.32404-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

An fs_location attribute returns a string that can be ipv4, ipv6,
or DNS name. An ip location can have a port appended to it and if
no port is present a default port needs to be set. If rpc_pton()
fails to parse, try calling rpc_uaddr2socaddr() that can convert
an universal address.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4_fs.h       |  2 +-
 fs/nfs/nfs4namespace.c | 17 +++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 734ac09becf7..85c5d08dfa9c 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -281,7 +281,7 @@ int nfs4_submount(struct fs_context *, struct nfs_server *);
 int nfs4_replace_transport(struct nfs_server *server,
 				const struct nfs4_fs_locations *locations);
 size_t nfs_parse_server_name(char *string, size_t len, struct sockaddr *sa,
-			     size_t salen, struct net *net);
+			     size_t salen, struct net *net, int port);
 /* nfs4proc.c */
 extern int nfs4_handle_exception(struct nfs_server *, int, struct nfs4_exception *);
 extern int nfs4_async_handle_error(struct rpc_task *task,
diff --git a/fs/nfs/nfs4namespace.c b/fs/nfs/nfs4namespace.c
index f1ed4f60a7f3..3680c8da510c 100644
--- a/fs/nfs/nfs4namespace.c
+++ b/fs/nfs/nfs4namespace.c
@@ -165,15 +165,20 @@ static int nfs4_validate_fspath(struct dentry *dentry,
 }
 
 size_t nfs_parse_server_name(char *string, size_t len, struct sockaddr *sa,
-			     size_t salen, struct net *net)
+			     size_t salen, struct net *net, int port)
 {
 	ssize_t ret;
 
 	ret = rpc_pton(net, string, len, sa, salen);
 	if (ret == 0) {
-		ret = nfs_dns_resolve_name(net, string, len, sa, salen);
-		if (ret < 0)
-			ret = 0;
+		ret = rpc_uaddr2sockaddr(net, string, len, sa, salen);
+		if (ret == 0) {
+			ret = nfs_dns_resolve_name(net, string, len, sa, salen);
+			if (ret < 0)
+				ret = 0;
+		}
+	} else if (port) {
+		rpc_set_port(sa, port);
 	}
 	return ret;
 }
@@ -328,7 +333,7 @@ static int try_location(struct fs_context *fc,
 			nfs_parse_server_name(buf->data, buf->len,
 					      &ctx->nfs_server.address,
 					      sizeof(ctx->nfs_server._address),
-					      fc->net_ns);
+					      fc->net_ns, 0);
 		if (ctx->nfs_server.addrlen == 0)
 			continue;
 
@@ -496,7 +501,7 @@ static int nfs4_try_replacing_one_location(struct nfs_server *server,
 			continue;
 
 		salen = nfs_parse_server_name(buf->data, buf->len,
-						sap, addr_bufsize, net);
+						sap, addr_bufsize, net, 0);
 		if (salen == 0)
 			continue;
 		rpc_set_port(sap, NFS_PORT);
-- 
2.27.0

