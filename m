Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937FB527233
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbiENOvP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbiENOvD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:51:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49E8186DE
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:50:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 888BDB808CF
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A51C340EE;
        Sat, 14 May 2022 14:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652539846;
        bh=BXw7iUghJyWb4rcPAbynJX9c0qgkAH1mwcRaEaiKH7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFl6bu9MBuBuB3imGAK2lcVY+gWJS1hY3HFqV+DDx9IHaoSHHRQBLqu/SnOF2jBeZ
         GyShfj3JDoaHAcvWLx3S6fzubx7h/HS6fYB6Ld+JodsRebV/P+daN2H2KRvQ0ltuwq
         hYl/H2xQG5o57pLZ8H3jk+Qj0mxzoOnaAG0mYCEmgEuDEUcKf8wExyzB6Vi2uG+uOW
         1OmdIYd43BaqobCae5+kHGsi2P3MQ9+yhIVUOEPAt7pUoh86jZtOOriGgXMvZIrALI
         r9hwcjiIzmmHQk7RxSPTd1aT3ur7QxN8a0eiUwqHNJgtDTYKwwtnUVtjnX3/eAjWTy
         ZELJ0Rkuw+Jyw==
From:   trondmy@kernel.org
To:     Steve Dickson <SteveD@redhat.com>,
        "J.Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 6/6] Edit manpages to document the new --dacl, --sacl and inheritance features
Date:   Sat, 14 May 2022 10:44:36 -0400
Message-Id: <20220514144436.4298-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514144436.4298-6-trondmy@kernel.org>
References: <20220514144436.4298-1-trondmy@kernel.org>
 <20220514144436.4298-2-trondmy@kernel.org>
 <20220514144436.4298-3-trondmy@kernel.org>
 <20220514144436.4298-4-trondmy@kernel.org>
 <20220514144436.4298-5-trondmy@kernel.org>
 <20220514144436.4298-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 man/man1/nfs4_getfacl.1 | 14 ++++++++++++++
 man/man1/nfs4_setfacl.1 |  8 ++++++++
 man/man5/nfs4_acl.5     | 10 ++++++++++
 3 files changed, 32 insertions(+)

diff --git a/man/man1/nfs4_getfacl.1 b/man/man1/nfs4_getfacl.1
index 7cf7cbf2cd0b..2a618fc356f9 100644
--- a/man/man1/nfs4_getfacl.1
+++ b/man/man1/nfs4_getfacl.1
@@ -34,6 +34,20 @@ flag is specified,
 .B nfs4_getfacl
 will not display the comment header (Do not print filename).
 
+If the
+.BR --dacl
+flag is specified,
+.B nfs4_getfacl
+will retrieve the dacl. This functionality is only available if
+the server supports NFSv4 minor version 1 or newer.
+
+If the
+.BR --sacl
+flag is specified,
+.B nfs4_getfacl
+will retrieve the sacl. This functionality is only available if
+the server supports NFSv4 minor version 1 or newer.
+
 The output format for an NFSv4 file ACL, e.g., is:
 .RS
 .nf
diff --git a/man/man1/nfs4_setfacl.1 b/man/man1/nfs4_setfacl.1
index 7144f0447ef9..47ab517c258c 100644
--- a/man/man1/nfs4_setfacl.1
+++ b/man/man1/nfs4_setfacl.1
@@ -101,6 +101,14 @@ in conjunction with
 in conjunction with
 .BR -R / --recursive ", a physical walk skips all symbolic links."
 .TP
+.BR "--dacl"	
+acts on the dacl only. This functionality is only available if
+the server supports NFSv4 minor version 1 or newer.
+.TP
+.BR "--sacl"	
+acts on the sacl only. This functionality is only available if
+the server supports NFSv4 minor version 1 or newer.
+.TP
 .BR --test	 
 display results of 
 .BR COMMAND ,
diff --git a/man/man5/nfs4_acl.5 b/man/man5/nfs4_acl.5
index e0b2a0a57e8b..7036ab72bc35 100644
--- a/man/man5/nfs4_acl.5
+++ b/man/man5/nfs4_acl.5
@@ -125,6 +125,16 @@ group - indicates that
 .I principal
 represents a group instead of a user.
 .TP
+.BR "INHERITED FLAG" " - can be used in any ACE"
+.TP
+.B I
+inherited - indicates that the ACE was inherited from the parent directory.
+This flag can only be used with the NFSv4.1 protocol or newer when using the
+.BR --dacl
+or
+.BR --sacl
+options.
+.TP
 .BR "INHERITANCE FLAGS" " - can be used in any directory ACE"
 .TP
 .B d
-- 
2.36.1

