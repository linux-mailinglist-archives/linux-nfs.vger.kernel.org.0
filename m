Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835EF3F9EF2
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Aug 2021 20:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhH0SiY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 14:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhH0SiX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 14:38:23 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888F6C061757
        for <linux-nfs@vger.kernel.org>; Fri, 27 Aug 2021 11:37:34 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id m21so8147601qkm.13
        for <linux-nfs@vger.kernel.org>; Fri, 27 Aug 2021 11:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vIOWLAR5baQ4wudUHjXS8yJqf6XzOgQ0+NlfjuEdhJQ=;
        b=JBEDGAYo8LOo0H4XpY+jgeX9Vl41MxYM9smP/hmI6EOGH2dJR3IdlsfwOznzusd57S
         tnZDpELvqnVTefYRx+SAou9NCEM0LQLrq/Bwq2FczimD1DN+uBVgspyM1msahF2vmHHl
         dHcQ1bNLqBi68/Px0dNWYniatYod48XS7qhOplfhH8PHxoBlWVuS6OSDvoE5EanW3iwy
         0iTZJ7l47QzYJ6WSqA6KnkQAHpTh+oh8ZTfVsj2wGOmNpa9nyrUJY7EfyYBzzNmrAaPe
         uLAEy97V+ETYJzko3V3gWZWC0aHOgze4Lp+6W+pIiPfY8/HGhgbK+hCBRamZhL76+yCX
         Lrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vIOWLAR5baQ4wudUHjXS8yJqf6XzOgQ0+NlfjuEdhJQ=;
        b=dBrMVt0V+rbdbcy1piKMcbDYfU/jbM5Q3cH4jEd3SN9Ttv/8zTAs+Ih6urCGyG+0D0
         bau9X2Lsgtpmlu31QiB8/MX49g8lN9CpWcQeJCyjt82EgFa91ntJDm2z3Mz1a/i33erH
         HvQAwh104ntwFBdgTMqwf56QTFwQSQqNsMGKVKN7ffsdw64QiSBO/HYa7Gxdx7eaobD8
         9f8XgDlVW8QCTSK18uyJ79bWue/UwG0a3UxbrI8w+kCvevZGGX3HoAB4nh3wXgBWXRk2
         nwErC15Ey73CYXrbbSzlYorv7zj2LAtDxnizagSWIUK/xVZyQaj1TlZQylKl8YWFySyr
         vMtw==
X-Gm-Message-State: AOAM530dKuCLpgKRHlua+Y3RHaxhI2jmKUJtFdkil5FcGjRUpnvUtOjg
        07TrZShFbZehGlDnzan4QOA=
X-Google-Smtp-Source: ABdhPJz/oRsLpWU2zhCHGYTwce7isukKCLbF1cidzoRlTYso4weGVEvJGdSdpmo6egeZjtb/rtH5UQ==
X-Received: by 2002:a05:620a:2089:: with SMTP id e9mr10213761qka.298.1630089453690;
        Fri, 27 Aug 2021 11:37:33 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:b143:41d3:e2f6:337b])
        by smtp.gmail.com with ESMTPSA id bl36sm5207463qkb.37.2021.08.27.11.37.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Aug 2021 11:37:33 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 5/5] NFSv4.1 add network transport when session trunking is detected
Date:   Fri, 27 Aug 2021 14:37:19 -0400
Message-Id: <20210827183719.41057-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210827183719.41057-1-olga.kornievskaia@gmail.com>
References: <20210827183719.41057-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

After trunking is discovered in nfs4_discover_server_trunking(),
add the transport to the old client structure if the allowed limit
of transports has not been reached.

An example: there exists a multi-homed server and client mounts
one server address and some volume and then doest another mount to
a different address of the same server and perhaps a different
volume. Previously, the client checks that this is a session
trunkable servers (same server), and removes the newly created
client structure along with its transport. Now, the client
adds the connection from the 2nd mount into the xprt switch of
the existing client (it leads to having 2 available connections).

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4client.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 270caa1805a2..af57332503be 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -402,6 +402,33 @@ static int nfs4_init_client_minor_version(struct nfs_client *clp)
 	return nfs4_init_callback(clp);
 }
 
+static void nfs4_add_trunk(struct nfs_client *clp, struct nfs_client *old)
+{
+	struct sockaddr_storage clp_addr, old_addr;
+	struct sockaddr *clp_sap = (struct sockaddr *)&clp_addr;
+	struct sockaddr *old_sap = (struct sockaddr *)&old_addr;
+	size_t clp_salen;
+	struct xprt_create xprt_args = {
+		.ident = old->cl_proto,
+		.net = old->cl_net,
+		.servername = old->cl_hostname,
+	};
+
+	if (clp->cl_proto != old->cl_proto)
+		return;
+	clp_salen = rpc_peeraddr(clp->cl_rpcclient, clp_sap, sizeof(clp_addr));
+	rpc_peeraddr(old->cl_rpcclient, old_sap, sizeof(old_addr));
+
+	if (clp_addr.ss_family != old_addr.ss_family)
+		return;
+
+	xprt_args.dstaddr = clp_sap;
+	xprt_args.addrlen = clp_salen;
+
+	rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
+			  rpc_clnt_test_and_add_xprt, NULL);
+}
+
 /**
  * nfs4_init_client - Initialise an NFS4 client record
  *
@@ -436,6 +463,8 @@ struct nfs_client *nfs4_init_client(struct nfs_client *clp,
 		 * won't try to use it.
 		 */
 		nfs_mark_client_ready(clp, -EPERM);
+		if (old->cl_mvops->session_trunk)
+			nfs4_add_trunk(clp, old);
 	}
 	clear_bit(NFS_CS_TSM_POSSIBLE, &clp->cl_flags);
 	nfs_put_client(clp);
-- 
2.27.0

