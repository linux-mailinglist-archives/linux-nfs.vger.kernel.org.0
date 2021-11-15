Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6F1450A5B
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Nov 2021 17:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhKORB0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Nov 2021 12:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhKORBX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Nov 2021 12:01:23 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D379EC061202
        for <linux-nfs@vger.kernel.org>; Mon, 15 Nov 2021 08:58:21 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id n15so16262659qta.0
        for <linux-nfs@vger.kernel.org>; Mon, 15 Nov 2021 08:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QEgfULIEexhl+Ei/oJkchMCR/I4cVTfFhd3T4Duv7bE=;
        b=T2f0Alkwhz/V7Z1Ixl3jGTEwm3APViQFUkoQ6VNXwburVHyP0NCJU6ZkbQBVr3pxd2
         spaLyqkL0Fp1H2mpj8wS2n7luEvv/3C2MuiE3s37I9G/4rmBYokqgDOEM23RediZvIXh
         sVn5nGNNk2Of7m0vW3pgc7apzQKSSRlrBSUwyot2u5vrn+4BRdwBxuTvYYlpmdp5YQbR
         0T8AQQCSJhHkYINJvGZcB96WVIVMEbZgiAlQTvROrpiPzi2snAIjbb1oE9z2/57KL71F
         OmIdYyLz2RmvChWklLfxczRtCRJsSpstEA1coQut2EZGg+pSOQ5mgxNy+fua+1KR4iOM
         ILqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QEgfULIEexhl+Ei/oJkchMCR/I4cVTfFhd3T4Duv7bE=;
        b=JqxeIOUgY2x2kKP4Bvlt5ywsDNfZGtE5CaqX/Fjpnxc9hh8ur3qJzf5wbYuM1hll3a
         uRl9iErrLWH3I3K6Wa55pI6xp8aVvvZWBbZAXgD1XcqwYVgKzwBOfwi0e/2WxzdJgX3b
         xMyV2CIqZ3RaXU4k6dV9h6lySF/nZoHGLoQeRiHzOvUICJa3RdpJYN/teO/kA6lTz2TK
         TV9OJOZzn6soXyNjgIbyjcgLf3QRZNmf7wHCjnRC1Rce4HRHVJy+8lm3uuGw4poyxCmF
         ccexZmyngovZoLTh6chG0+bLeF8sQ8vf+MkWz/WVJduxPqUhFe/N6pmuUs6hFF4usLNB
         tUTg==
X-Gm-Message-State: AOAM531JlyE04yfjh2OJ5+zO5lAKP/jK8lwouYqZiCy0U+iS1knLlZ1s
        Nwa3E/Xm+ZFWtXbXWnTKfaCt825QV+ch7w==
X-Google-Smtp-Source: ABdhPJyznOkO+p7cW8mIRcF9ezUldjCro6Cm0Btw8jbjeVxNqEOUtl5i1KdWTR13L5lgnX2PAJmJUg==
X-Received: by 2002:ac8:147:: with SMTP id f7mr405759qtg.329.1636995500909;
        Mon, 15 Nov 2021 08:58:20 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id v7sm6988472qki.98.2021.11.15.08.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 08:58:20 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 3/3] nfs: show dynamic nconnect
Date:   Mon, 15 Nov 2021 11:58:18 -0500
Message-Id: <20211115165818.2583501-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115165818.2583501-1-Anna.Schumaker@Netapp.com>
References: <20211115165818.2583501-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Through sysfs we can change the number of xprts attached to an
rpc_client. This lets us change the displayed nconnect= value to reflect
the actual number of connected xprts for the given mount.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 3aced401735c..f6ede7bf18f9 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -478,7 +478,7 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 		   rpc_peeraddr2str(nfss->client, RPC_DISPLAY_NETID));
 	rcu_read_unlock();
 	if (clp->cl_nconnect > 0)
-		seq_printf(m, ",nconnect=%u", clp->cl_nconnect);
+		seq_printf(m, ",nconnect=%u", rpc_clnt_xprt_switch_num_xprts(clp->cl_rpcclient));
 	if (version == 4) {
 		if (clp->cl_max_connect > 1)
 			seq_printf(m, ",max_connect=%u", clp->cl_max_connect);
-- 
2.33.1

