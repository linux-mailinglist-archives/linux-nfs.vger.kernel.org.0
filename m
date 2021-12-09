Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD8B46F455
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Dec 2021 20:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhLIT5X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Dec 2021 14:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhLIT5U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Dec 2021 14:57:20 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0246EC061746
        for <linux-nfs@vger.kernel.org>; Thu,  9 Dec 2021 11:53:47 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id x10so7949257ioj.9
        for <linux-nfs@vger.kernel.org>; Thu, 09 Dec 2021 11:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AsRhowv9GS1BKrI5gLUKrzXf/xeqD8Q3rmF2XHzw6BY=;
        b=nxtp/Y6SruBNWzzF3mxw+BpDtxyJ3nmA38o2BTE4uqJ89CHbnxDbOOGhJtE0VvGAze
         VpjOIHKyLuP8OxUuG6bN9WT84fY/AHWvvxf09IMWySC5+UaBnneIP30IhlvkIZmEIcBT
         ntHPkcU9Gw+9zxkDXQAiwUoj1/x18QX/jfzJcCCPl53/xkwLk0w1YbCKkwCubq65+zBN
         uBvuJwkf07D+PDibvKwdnDfcYMsv7VD4VMR0ofcF0YvSW+grPmCtMRBRol5JOnQCnXf8
         8lt/JQa0sblWdJnNxgdsWF693XU+3nI9qHKB0w9nUai5nMJPbMZr8HZdcfXztQcTHL83
         7Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AsRhowv9GS1BKrI5gLUKrzXf/xeqD8Q3rmF2XHzw6BY=;
        b=25kKUE5D10nIpeIzNUYPfW1nd0nhrS9tBaOOsxV999Dya30OjvFoqnmnj17p8fEL3w
         KfLNQIc1/TZtRYNRxhhCFg+d9B79F/WcCItT2BrDBhbJ9d6dAQDQ0+lduOceS3TJ/Yii
         tldduNmi5vpGnEGldEWNOKKhN+l1X8IuLJNfWMgPS6Ib/DnFfm+NylopKIjiw77BpE9p
         blZfdzTCjN2gd9vNZMpbeRRZHnG0vpGvjG8gb3+tfUS0v3tw1YA8fm+26GnQzyyj3+K/
         OHQvo9feg2qp/Ozsmgyqq18CuRNDOikwoFeSWTr0teE2+E06kkGUc/fcCuolxQZwxB5B
         aZTQ==
X-Gm-Message-State: AOAM531ScMFjESiZI92JuBqeaTO4Wpih7/QLnzBHv0j6hSQH6AOyPJi1
        u3XmSR+nFLz+1az+tAadeFBM24oJ8Ss=
X-Google-Smtp-Source: ABdhPJwrfxKWzSlOOJYpZDFhMegFEzxUiZeRbSlDD5nSxEHRD188dmMXxsYli5D/dufV56QiSC9x5A==
X-Received: by 2002:a05:6602:2d84:: with SMTP id k4mr17200622iow.168.1639079626397;
        Thu, 09 Dec 2021 11:53:46 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:554d:272f:69a0:1745])
        by smtp.gmail.com with ESMTPSA id k9sm383541ilv.61.2021.12.09.11.53.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 11:53:45 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 7/7] NFSv4.1 test and add 4.1 trunking transport
Date:   Thu,  9 Dec 2021 14:53:35 -0500
Message-Id: <20211209195335.32404-8-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211209195335.32404-1-olga.kornievskaia@gmail.com>
References: <20211209195335.32404-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

For each location returned in FS_LOCATION query, establish a
transport to the server, send EXCHANGE_ID and test for trunking,
if successful, add the transport to the exiting client.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9a6b53ec0eaa..0529c60c27e9 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3933,6 +3933,56 @@ int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 	return err;
 }
 
+static void test_fs_location_for_trunking(struct nfs4_fs_location *location,
+					  struct nfs_client *clp,
+					  struct nfs_server *server)
+{
+	int i;
+
+	for (i = 0; i < location->nservers; i++) {
+		struct nfs4_string *srv_loc = &location->servers[i];
+		struct sockaddr addr;
+		size_t addrlen;
+		struct xprt_create xprt_args = {
+			.ident = 0,
+			.net = clp->cl_net,
+		};
+		struct nfs4_add_xprt_data xprtdata = {
+			.clp = clp,
+		};
+		struct rpc_add_xprt_test rpcdata = {
+			.add_xprt_test = clp->cl_mvops->session_trunk,
+			.data = &xprtdata,
+		};
+		char *servername = NULL;
+
+		if (!srv_loc->len)
+			continue;
+
+		addrlen = nfs_parse_server_name(srv_loc->data, srv_loc->len,
+						&addr, sizeof(addr),
+						clp->cl_net, server->port);
+		if (!addrlen)
+			return;
+		xprt_args.dstaddr = &addr;
+		xprt_args.addrlen = addrlen;
+		servername = kmalloc(srv_loc->len + 1, GFP_KERNEL);
+		if (!servername)
+			return;
+		memcpy(servername, srv_loc->data, srv_loc->len);
+		servername[srv_loc->len] = '\0';
+		xprt_args.servername = servername;
+
+		xprtdata.cred = nfs4_get_clid_cred(clp);
+		rpc_clnt_add_xprt(clp->cl_rpcclient, &xprt_args,
+				  rpc_clnt_setup_test_and_add_xprt,
+				  &rpcdata);
+		if (xprtdata.cred)
+			put_cred(xprtdata.cred);
+		kfree(servername);
+	}
+}
+
 static int _nfs4_discover_trunking(struct nfs_server *server,
 				   struct nfs_fh *fhandle)
 {
@@ -3942,7 +3992,7 @@ static int _nfs4_discover_trunking(struct nfs_server *server,
 	struct nfs_client *clp = server->nfs_client;
 	const struct nfs4_state_maintenance_ops *ops =
 		clp->cl_mvops->state_renewal_ops;
-	int status = -ENOMEM;
+	int status = -ENOMEM, i;
 
 	cred = ops->get_state_renewal_cred(clp);
 	if (cred == NULL) {
@@ -3960,6 +4010,10 @@ static int _nfs4_discover_trunking(struct nfs_server *server,
 					 cred);
 	if (status)
 		goto out;
+
+	for (i = 0; i < locations->nlocations; i++)
+		test_fs_location_for_trunking(&locations->locations[i], clp,
+					      server);
 out:
 	if (page)
 		__free_page(page);
-- 
2.27.0

