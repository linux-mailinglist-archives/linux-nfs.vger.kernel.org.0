Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178966A970D
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Mar 2023 13:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCCMQI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Mar 2023 07:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCCMQH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Mar 2023 07:16:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CC42A98D
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 04:16:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 752A7617FB
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 12:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5413DC433A1;
        Fri,  3 Mar 2023 12:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677845765;
        bh=QImhGiwMgC2a5kjWVOdn62d12dkIkumWp1T10s6oax4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B9zBhzjtYbahRfxJGDHir/2IpTsRbOAuwkpnlGzRqt0OnxgVz1RkXCQ1b9xalFUD6
         Yq9m0rPszQ5ZRQN3ZTwNNF+mnT0uD7sBFybr5dAXvBU7cB341gWKk12Yg0oZf6+3BF
         Dz5oynCPvpnWqTgqIGObrYVdDKipheM2reCWV/QiUbHJHaW05kI9E30aqRbh4ZKOyb
         59Bhk3faF2aX6zuakP1V6oSUTEAFUknGHKNR2zt3B6EK5o0CADOqrUcBJaU0V1kUBs
         B94dP/1AQzsBCBYTdzQXNukBBfYRMzlvig0U4fx0GZXwF0CpIYeZDy5bQTYgTqiDWs
         J+dgd0zw9LkDg==
From:   Jeff Layton <jlayton@kernel.org>
To:     trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, yoyang@redhat.com
Subject: [PATCH 1/7] lockd: purge resources held on behalf of nlm clients when shutting down
Date:   Fri,  3 Mar 2023 07:15:57 -0500
Message-Id: <20230303121603.132103-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303121603.132103-1-jlayton@kernel.org>
References: <20230303121603.132103-1-jlayton@kernel.org>
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
Signed-off-by: Jeff Layton <jlayton@kernel.org>
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

