Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6457A6830
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Sep 2023 17:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjISPfY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Sep 2023 11:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjISPfX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Sep 2023 11:35:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705DC91
        for <linux-nfs@vger.kernel.org>; Tue, 19 Sep 2023 08:35:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F05C433C8;
        Tue, 19 Sep 2023 15:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695137717;
        bh=/Q/Lx12qDUzzN92fJp5Ct79TxTOC67rSpzWe1wxt8+w=;
        h=Subject:From:To:Cc:Date:From;
        b=g1anLvlHQWdiUbK9FHwP2JiHngIzGBvWnswR86JHcM+++nUEwa938Y0Qe2meqEiGZ
         m2hLvSn3AaslZDi4E0Wca0Z1WTv+XtMWU0XnrwelijjlW98/U0hVw+gOLGWAjvDwOW
         N1OA9TW3Sy/frfowf9Wu3RnqI9I8DP/2XgPMwCC5e0F1FTBXgaHFhaJpeJYTo4TNd9
         Ij5IUjhw4vs4MSG0t462zeaKsLrXge+aodFWOVbejzh5/7Bn8Ts6Zhm80R6OiOMeQT
         liKErrjmUEZpwyifB7qEZrelAQZpJXFzypJvFRPEB8lRCynD2N5ZJ3NkdNQpKwjPmt
         2b5bNtDWXylfw==
Subject: [PATCH v1] SUNRPC: Remove BUG_ON call sites
From:   Chuck Lever <cel@kernel.org>
To:     neilb@suse.de, brauner@kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Tue, 19 Sep 2023 11:35:15 -0400
Message-ID: <169513768769.145733.5037542987990908432.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

There is no need to take down the whole system for these assertions.

I'd rather not attempt a heroic save here, as some bug has occurred
that has left the transport data structures in an unknown state.
Just warn and then leak the left-over resources.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Acked-by: Christian Brauner <brauner@kernel.org>
---
 net/sunrpc/svc.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Changes since v1:
- Use WARN_ONCE() instead of pr_warn()

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 587811a002c9..3237f7dfde1e 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -575,11 +575,12 @@ svc_destroy(struct kref *ref)
 	timer_shutdown_sync(&serv->sv_temptimer);
 
 	/*
-	 * The last user is gone and thus all sockets have to be destroyed to
-	 * the point. Check this.
+	 * Remaining transports at this point are not expected.
 	 */
-	BUG_ON(!list_empty(&serv->sv_permsocks));
-	BUG_ON(!list_empty(&serv->sv_tempsocks));
+	WARN_ONCE(!list_empty(&serv->sv_permsocks),
+		  "SVC: permsocks remain for %s\n", serv->sv_program->pg_name);
+	WARN_ONCE(!list_empty(&serv->sv_tempsocks),
+		  "SVC: tempsocks remain for %s\n", serv->sv_program->pg_name);
 
 	cache_clean_deferred(serv);
 


