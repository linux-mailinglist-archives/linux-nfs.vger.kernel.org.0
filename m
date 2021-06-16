Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FA43A8E1B
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 03:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhFPBM2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Jun 2021 21:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhFPBM1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Jun 2021 21:12:27 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9752C061574
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jun 2021 18:10:22 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id f5so732905qvu.8
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jun 2021 18:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vIOWLAR5baQ4wudUHjXS8yJqf6XzOgQ0+NlfjuEdhJQ=;
        b=VRJrGLy3RirE6u1SyrUiEpJ3+QC2TTSsnVwvLIaKFDSlIVJfCPmzvKhpDZFh4/RbRs
         nnnEq87U3Wq5A/utCYTnCj2ZvWXpvBklLf/5JuNvCi30G6EvV+sialAajM7QY/hbYQN/
         ro2GiEN5CG2tuGm0fxB9VRjHSTHTVvVJS6HlWeoKocWAYQE63K/SAfB2dHbLuKik/2Q8
         D3n1mhY5SW3jBFmLyAttCTOSkBXM32Capuy6yALks/Py/ajOzzVByOdlkkOPVAEJNkvv
         8Ke1z5U5HKDz458pCHJbhDaByaaHf7INdq2gK+JFaAjIQRTXmURd4ekI3mW4p/VgsLQ2
         6FhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vIOWLAR5baQ4wudUHjXS8yJqf6XzOgQ0+NlfjuEdhJQ=;
        b=j+hL8ls+oXBbfx6+E7G9u6oYWAVPM3i/ipbR9W2AokIIDMfa+k3g2300aQuhfvuKtJ
         Y4nxhqjfHJppiFzj0VFK1plEIJ52hJD3ARRyoN/WI5WcnUdBGpoTmZtfAR2qnc4Q8coK
         MVXZBtOw/NdPZPGMWLz3wzEcbOamqSzTbTsTN/4ZAetsjvgcoivm98hUOMr0dcpnsJAT
         JUlyrIzYeI8SvrQgbLM+0mRYFM4Jb2BjMO04jWTWHVOSSxQ7LflcTWd4lh82jcJyy+hW
         XD09g1/1M3Xk5u+mBEkpa7fxl407yAOAfg9gMr+09dhuW1Pyc4xe1yRn8rnPM7Uh9SoV
         TJZQ==
X-Gm-Message-State: AOAM530nKp/yxSWwH9XLT9nehoGCI6OZS/D+4iAJzkdGajhHf526AqAi
        gF53scNy1aXANwhkM/6HHwObdismDjdtUw==
X-Google-Smtp-Source: ABdhPJyM5RPi1t2jR7Iqu3ls77YFVn/YjU+lioREyVitfZgSQJls6e/IZXrIKZMqagwSbK7lJJLb7Q==
X-Received: by 2002:ad4:4241:: with SMTP id l1mr8307729qvq.2.1623805821896;
        Tue, 15 Jun 2021 18:10:21 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id m189sm546007qkd.107.2021.06.15.18.10.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jun 2021 18:10:21 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 5/6] NFSv4 add network transport when session trunking is detected
Date:   Tue, 15 Jun 2021 21:10:12 -0400
Message-Id: <20210616011013.50547-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210616011013.50547-1-olga.kornievskaia@gmail.com>
References: <20210616011013.50547-1-olga.kornievskaia@gmail.com>
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

