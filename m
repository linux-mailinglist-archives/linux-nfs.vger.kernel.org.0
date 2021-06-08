Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1E73A016B
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 21:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbhFHSwH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 14:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbhFHSuG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 14:50:06 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0745C06114C
        for <linux-nfs@vger.kernel.org>; Tue,  8 Jun 2021 11:45:30 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id k4so21285662qkd.0
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 11:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YQfH20WiLnjQz8Qqiap58pTQSBe7q3eIJ9Ejp+u4pPs=;
        b=k4S0lZBkr+qHOUYrseRP7qCwV3qsrLltHI8k4KuY/eKMcsU/kktr7ri4WBAkomb/So
         zmsTxPangw4eaXX65S4rfyUr/RoJ76UNlUyoW/AeW+I29M6xCH2IcGalsLUV1U3G1Yy4
         AwrgLCNhKM39g3Xk4SJ2APu0Lidlfq0YLf9WLVsi6N4sD7dl3SkILKWuk7UtaWL4EIWb
         Imthorg0B4XAr677WjQ5joJlmpBXhjZIUtUSc08QqNJu/K7hKNscXC1k1kKSt0jNbGPX
         8FXQ7jl9TBOp492YzgLC2HYOHlFQJwH9MV8lCnNFMqP8rrs2/G1vN0/AFA+4EcSSPbRu
         2YRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YQfH20WiLnjQz8Qqiap58pTQSBe7q3eIJ9Ejp+u4pPs=;
        b=mXOcnm6YDHGamt8TekWl05ZLEQkE7DrRWOLpsxX6A+fqTFqCnzB5Y7uotAFg6tdGNV
         HHUDMopWMYYyRxCFKe/TwxneHyYSTNEO6WrIjMH1rkAYbyTqYZbt6GDj5b7f4Q3dyHss
         YldA26H1VZ675xKUHaLD3o597p+D+VGhzToFqyvEqpnVVG8AvedfXUCJj4a5VCjyks3B
         CbpLyE7AG9gOzQw5eLuSmBMPyyiWr2N6qTGvLJZdMN2IlvNk6mtJjCuGi0YdFuQAmX34
         0XsY7D+Nrd5njDHJY9Vrrj6bqoWzsekNpEyMp/IPUEvRtT/mKv3aYYs37yD1eS3V8DVF
         9SDQ==
X-Gm-Message-State: AOAM5310tyEaoysI1hpIz+c6f1DxFZ2rXNdfOClSxxaQqR11C0fduL0d
        ko6i3d7DRJzU7a/DXljt7oQEj31+yH0=
X-Google-Smtp-Source: ABdhPJwRBiy78m6r3sKK5d0+w4zIhXwWwOjiqzV/KIbH/OEtXyac/Hddd2aQZ7li73Mbp+uLJecmsw==
X-Received: by 2002:a37:68c7:: with SMTP id d190mr22332799qkc.485.1623177930064;
        Tue, 08 Jun 2021 11:45:30 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id f130sm12365620qke.37.2021.06.08.11.45.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 11:45:29 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Date:   Tue,  8 Jun 2021 14:45:27 -0400
Message-Id: <20210608184527.87018-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

After trunking is discovered in nfs4_discover_server_trunking(),
add the transport to the old client structure before destroying
the new client structure (along with its transport).

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4client.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 42719384e25f..984c851844d8 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -361,6 +361,44 @@ static int nfs4_init_client_minor_version(struct nfs_client *clp)
 	return nfs4_init_callback(clp);
 }
 
+static void nfs4_add_trunk(struct nfs_client *clp, struct nfs_client *old)
+{
+	struct sockaddr_storage clp_addr, old_addr;
+	struct sockaddr *clp_sap = (struct sockaddr *)&clp_addr;
+	struct sockaddr *old_sap = (struct sockaddr *)&old_addr;
+	size_t clp_salen, old_salen;
+	struct xprt_create xprt_args = {
+		.ident = old->cl_proto,
+		.net = old->cl_net,
+		.servername = old->cl_hostname,
+	};
+	struct nfs4_add_xprt_data xprtdata = {
+		.clp = old,
+	};
+	struct rpc_add_xprt_test rpcdata = {
+		.add_xprt_test = old->cl_mvops->session_trunk,
+		.data = &xprtdata,
+	};
+
+	if (clp->cl_proto != old->cl_proto)
+		return;
+	clp_salen = rpc_peeraddr(clp->cl_rpcclient, clp_sap, sizeof(clp_addr));
+	old_salen = rpc_peeraddr(old->cl_rpcclient, old_sap, sizeof(old_addr));
+
+	if (clp_addr.ss_family != old_addr.ss_family)
+		return;
+
+	xprt_args.dstaddr = clp_sap;
+	xprt_args.addrlen = clp_salen;
+
+	xprtdata.cred = nfs4_get_clid_cred(old);
+	rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
+			  rpc_clnt_setup_test_and_add_xprt, &rpcdata);
+
+	if (xprtdata.cred)
+		put_cred(xprtdata.cred);
+}
+
 /**
  * nfs4_init_client - Initialise an NFS4 client record
  *
@@ -434,6 +472,8 @@ struct nfs_client *nfs4_init_client(struct nfs_client *clp,
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

