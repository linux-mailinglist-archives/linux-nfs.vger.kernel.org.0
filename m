Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9176F6CB0
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 15:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjEDNOJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 09:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjEDNOH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 09:14:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA26E6194
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 06:14:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5F6CE22B0E;
        Thu,  4 May 2023 13:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683206045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/FKdR3mIdN4rPKTA6ko4I1q3qCq+vibsIIkLB7RacM=;
        b=dEGVOk1vro9p663Uf28UeoFc+8I1gDCRfsGtWPlPRF+sYOIAI47XOCNfwXtdr1qOBgro3p
        8PQ/3EEkLV26VQeMb8TJv2xofh2eZ/DF3rR+pjP8fnsWJ2HvaQGyuugL8xo7GvPmBwvouO
        nNKOEoTx+zKNDXBfKRAx1p+zwTmPhGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683206045;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/FKdR3mIdN4rPKTA6ko4I1q3qCq+vibsIIkLB7RacM=;
        b=HNiYDbgWLh/lCqln5c1bfs60SihWBJEh+d/SXg5pVsV+IubmbXwtZ+q1j1qAlO18uAVLGj
        MoipT0zNy5x1enCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F0F313444;
        Thu,  4 May 2023 13:14:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mPXhOpyvU2TXVgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 04 May 2023 13:14:04 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, NeilBrown <neilb@suse.de>,
        Cyril Hrubis <chrubis@suse.cz>, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v5 3/5] nfs05.sh: Lower down the default values
Date:   Thu,  4 May 2023 15:14:12 +0200
Message-Id: <20230504131414.3826283-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504131414.3826283-1-pvorel@suse.cz>
References: <20230504131414.3826283-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs05_make_tree.c runs make which needs on Btrfs quite a lot of
temporary space. This is a preparation for the next commit which
start using all filesystems via TST_ALL_FILESYSTEMS=1. Currently we use
300 MB, which was not enough for Btrfs:

Filesystem     Type      Size  Used Avail Use% Mounted on
/dev/loop0     btrfs     300M   62M   20K 100% /tmp/LTP_nfs05.Vau10kcszO/mntpoint

More space is required on ppc64le (higher page size ?).

Proper solution would be to detect available size in nfs05_make_tree.c
and lower down values based on free space.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs05.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs05.sh b/testcases/network/nfs/nfs_stress/nfs05.sh
index c18ef1ab4..760b585e4 100755
--- a/testcases/network/nfs/nfs_stress/nfs05.sh
+++ b/testcases/network/nfs/nfs_stress/nfs05.sh
@@ -8,9 +8,9 @@
 #
 # Created by: Robbie Williamson (robbiew@us.ibm.com)
 
-DIR_NUM=${DIR_NUM:-"10"}
-FILE_NUM=${FILE_NUM:-"30"}
-THREAD_NUM=${THREAD_NUM:-"8"}
+DIR_NUM=${DIR_NUM:-"5"}
+FILE_NUM=${FILE_NUM:-"20"}
+THREAD_NUM=${THREAD_NUM:-"5"}
 TST_NEEDS_CMDS="make gcc"
 TST_TESTFUNC="do_test"
 
-- 
2.40.0

