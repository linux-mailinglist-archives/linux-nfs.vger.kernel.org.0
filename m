Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7A16A6C8C
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Mar 2023 13:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjCAMq3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Mar 2023 07:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCAMq2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Mar 2023 07:46:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E41A1C582
        for <linux-nfs@vger.kernel.org>; Wed,  1 Mar 2023 04:46:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CA65CCE1D13
        for <linux-nfs@vger.kernel.org>; Wed,  1 Mar 2023 12:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6921CC433EF;
        Wed,  1 Mar 2023 12:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677674784;
        bh=yjqt2p3dVkx/+q+gOrvRBcNe41DAUwjRAgY//IMQmEI=;
        h=From:To:Cc:Subject:Date:From;
        b=na/FHpXlpWiGhzvr+irhjk6FGD/w/TNpaPvjjTy+zult0SMsyNm94RbTnXEPzqv+P
         OHwek1QDCOJOtRxr1ew2YaMtTkPklFh1D+Q92LevhlT8LIRhVnQLhf9r5AqPFbXb5r
         TMTMZiyubAoN1zMpz5FnWY/NjexqYwPx/FTFYE1Z+HBqAQpmFrVsB8+H5XzgODV/RX
         68ynaN7HkxKcnAXl8NWs/i49iF0vBteqvJLaTa8Pf54SvTVk2z0teyj5uzgfe9ZK/s
         FTNL1+SQO8rYkb17kyGaGuekhAMcVLjhvUy1aupK6oeUKlk5FD2ySJWIm/tUJc8cmd
         X8yv5sUPFYRsw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        anna@kernel.org, Jeffrey Layton <jlayton@redhat.com>,
        Yongcheng Yang <yoyang@redhat.com>
Subject: [PATCH] lockd: purge resources held on behalf of nlm clients when shutting down
Date:   Wed,  1 Mar 2023 07:46:21 -0500
Message-Id: <20230301124621.26222-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeffrey Layton <jlayton@redhat.com>

It's easily possible for the server to have an outstanding lock when we
go to shut down. When that happens, we often get a warning like this in
the kernel log:

    lockd: couldn't shutdown host module for net f0000000!

This is because the shutdown procedures skip removing any hosts that
still have outstanding resources (locks). Eventually, things seem to get
cleaned up anyway, but the log message is unsettling, and server
shutdown doesn't seem to be working the way it was intended.

Ensure that we tear down any resources held on behalf of a client when
tearing one down for server shutdown.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2063818
Reported-by: Yongcheng Yang <yoyang@redhat.com>
Signed-off-by: Jeffrey Layton <jlayton@redhat.com>
---
 fs/lockd/host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/lockd/host.c b/fs/lockd/host.c
index cdc8e12cdac4..127a728fcbc8 100644
--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -629,6 +629,7 @@ nlm_shutdown_hosts_net(struct net *net)
 			rpc_shutdown_client(host->h_rpcclnt);
 			host->h_rpcclnt = NULL;
 		}
+		nlmsvc_free_host_resources(host);
 	}
 
 	/* Then, perform a garbage collection pass */
-- 
2.39.2

