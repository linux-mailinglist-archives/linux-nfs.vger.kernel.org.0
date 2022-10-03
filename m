Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4885F34BA
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Oct 2022 19:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJCRop (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 13:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJCRom (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 13:44:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D213A304
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 10:44:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F3E461193
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 17:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD4DC433D6;
        Mon,  3 Oct 2022 17:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664819074;
        bh=5GTGL4ViTtMMjSNBZ5MZJEzv17jU75OEbJty7Qu+baU=;
        h=From:To:Cc:Subject:Date:From;
        b=qQmyhtr56WTi20Feh1Apa0fKrh6m3Ov09Px1fMYHf8B6u1ijWy5XH87RWD3OzRqTG
         ihs7sGwMMMpjRY8eFLLCVGo5KlW4EVY4yZ4QBhfIyxBGYhVgxiZBr3Mil1t96v/WLU
         tEB2oBsal/xAXsYRGcfHLc1q4Q5Geu8JWust4unM7qYrDAQmNPxjXVsgzI2TJofmAZ
         AV10q8sga8XtOiudxE9cwqc5RT89pRIOEEsxb7w6DLv24XFhxlntEUOE+exusPVCR7
         UI1JUw8n8hQtEu6C4OdZuHSkFiWEiei4Nta3yxW+7wPPHawtpJZzOYWf7G2xqlPZfs
         rbailgY+s3jnw==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH 1/3] NFSv4.2: Move TRACE_DEFINE_ENUM(NFS4_CONTENT_*) under CONFIG_NFS_V4_2
Date:   Mon,  3 Oct 2022 13:44:31 -0400
Message-Id: <20221003174433.476685-1-anna@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

NFS4_CONTENT_DATA and NFS4_CONTENT_HOLE both only exist under NFS v4.2.
Move their corresponding TRACE_DEFINE_ENUM calls under this Kconfig
option.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs4trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 6ee6ad3674a2..37c4c105ed29 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2097,6 +2097,7 @@ TRACE_EVENT(ff_layout_commit_error,
 		)
 );
 
+#ifdef CONFIG_NFS_V4_2
 TRACE_DEFINE_ENUM(NFS4_CONTENT_DATA);
 TRACE_DEFINE_ENUM(NFS4_CONTENT_HOLE);
 
@@ -2105,7 +2106,6 @@ TRACE_DEFINE_ENUM(NFS4_CONTENT_HOLE);
 		{ NFS4_CONTENT_DATA, "DATA" },		\
 		{ NFS4_CONTENT_HOLE, "HOLE" })
 
-#ifdef CONFIG_NFS_V4_2
 TRACE_EVENT(nfs4_llseek,
 		TP_PROTO(
 			const struct inode *inode,
-- 
2.37.3

