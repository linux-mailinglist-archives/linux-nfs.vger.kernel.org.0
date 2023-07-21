Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663DD75C6F8
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 14:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGUMjF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 08:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjGUMjE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 08:39:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FDE2D56
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 05:38:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 77FCF1F897;
        Fri, 21 Jul 2023 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689943138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Q6321VdtsaFyz231nyTF10eoGD8o/cIKY3P6vG38TKc=;
        b=D2BNZun4zA0U5Rq5bIGsvk0l3KerkRL0BwW3BULY2XzCJwW58O1oe/2w5xX9NCAsiM+pq1
        +9yrtyuiQvtYHkBE9kcRPmyI47hPpzCn2B54vKn2gYZtUWd6Ie+vMkPoBhBECPhP47aPvU
        XpTxMexvZK0P4oKOLu3xRr66FSXtVls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689943138;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Q6321VdtsaFyz231nyTF10eoGD8o/cIKY3P6vG38TKc=;
        b=j7ps4kKQ1pxX3MUkWZJvjBFn7CWa0rDLrF0fbK9CG1lqr2qgRiqmJPHShkfHArKICLSjWC
        KzFODzkBa0XajHCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0ECF0134BA;
        Fri, 21 Jul 2023 12:38:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 02v6AGJ8umSpUgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 21 Jul 2023 12:38:58 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] nfs_lib.sh: Set NFS 4.2 on TCP as the default
Date:   Fri, 21 Jul 2023 14:38:52 +0200
Message-Id: <20230721123852.1420080-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Previously NFS 3 on UDP was the default, which leaded to test being
skipped when tests run without parameters:

TCONF: UDP support disabled on NFS server

This does not have an effect when tests run properly via
runtest/net.nfs, which specify parameters. It just safes typing
-t tcp (and optionally -v 4.2) when one runs single test manually.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

I'm pretty sure, we don't want to have UDP as the default (besides
skipped with TCONF it was acked by Jeff [1]). But I wonder if NFS 4.2 is
the best as the default version. Maybe just 4 or 4.1?

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/e4d22ae6cefb34463ed7d04287ca9e81cd0949d8.camel@kernel.org/

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index abf7ba5a2..dae15a2e1 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -4,9 +4,9 @@
 # Copyright (c) 2015-2018 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2001
 
-VERSION=${VERSION:=3}
+VERSION=${VERSION:=4.2}
 NFILES=${NFILES:=1000}
-SOCKET_TYPE="${SOCKET_TYPE:-udp}"
+SOCKET_TYPE="${SOCKET_TYPE:-tcp}"
 NFS_TYPE=${NFS_TYPE:=nfs}
 
 nfs_usage()
-- 
2.40.1

