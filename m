Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7746F6CB1
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 15:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjEDNOK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 09:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjEDNOI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 09:14:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF1072A4
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 06:14:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CE25D339F4;
        Thu,  4 May 2023 13:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683206045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jeATmQa9pds8zoOmG2NvYcden3y1ZEJm268/wgu1Jw=;
        b=IzZY4dmxmsqNRW1oNwre6j9bqWEe7pzUkfMtC28Fy3cl2kv1tyeIqwFP1fhvl8zmnHwLUP
        GowfPtNsiSkCWi+4WNT1KPZwHIifT1UuqnlQaZMtCUXqA4dVfukVaE4v6EL3R4NynGSoCL
        wSrWHx9rOWy3DXa1llqI+b+NZYfHukc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683206045;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jeATmQa9pds8zoOmG2NvYcden3y1ZEJm268/wgu1Jw=;
        b=Ra3vFvOkzPBNA13Cm8XU0URILfWBK9hqusNaM0ThTRrVBvT+YIa3eObbU5nh4ByV3BrkBy
        AIAj9tsMWuoFncDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73C0313444;
        Thu,  4 May 2023 13:14:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AP6NGZ2vU2TXVgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 04 May 2023 13:14:05 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, NeilBrown <neilb@suse.de>,
        Cyril Hrubis <chrubis@suse.cz>, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v5 4/5] nfs03.sh: Lower down the default values
Date:   Thu,  4 May 2023 15:14:13 +0200
Message-Id: <20230504131414.3826283-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504131414.3826283-1-pvorel@suse.cz>
References: <20230504131414.3826283-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Needed for tmpfs on ppc64le:

nfs03 7 TINFO: Cleaning up testcase
nfs03 7 TINFO: === Testing on tmpfs ===
nfs03 7 TINFO: Skipping mkfs for TMPFS filesystem
nfs03 7 TINFO: Mounting device: mount -t tmpfs /dev/loop0 /tmp/LTP_nfs03.5oEyxwo5nP/mntpoint
nfs03 7 TINFO: timeout per run is 0h 15m 0s
nfs03 7 TINFO: mount.nfs: (linux nfs-utils 2.1.1)
nfs03 7 TINFO: setup NFSv3, socket type udp
nfs03 7 TINFO: Mounting NFS: mount -v -t nfs -o proto=udp,vers=3 10.0.0.2:/tmp/LTP_nfs03.5oEyxwo5nP/mntpoint/3/udp /tmp/LTP_nfs03.5oEyxwo5nP/3/0
nfs03 7 TINFO: Setting server side nfsd count to 1
nfs03 7 TINFO: Multiple processes creating and deleting files
nfs03 7 TINFO: creating dir1 subdirectories & files
nfs03 7 TINFO: make '100' directories
nfs03 7 TINFO: creating dir2 subdirectories & files
nfs03 7 TINFO: make '100' directories
nfs03 7 TINFO: cd dir1 & removing files
touch: cannot touch 'file5464': No space left on device
nfs03 7 TBROK: touch file5464 failed
touch: cannot touch 'file5364': No space left on device
nfs03 7 TBROK: touch file5364 failed
nfs03 7 TINFO: nfs03 7 Cleaning up testcase
TINFO: Cleaning up testcase

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs03.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs03.sh b/testcases/network/nfs/nfs_stress/nfs03.sh
index e5f4de67c..5884bb9b9 100755
--- a/testcases/network/nfs/nfs_stress/nfs03.sh
+++ b/testcases/network/nfs/nfs_stress/nfs03.sh
@@ -8,8 +8,8 @@ TST_CLEANUP="nfs03_cleanup"
 TST_SETUP="nfs03_setup"
 TST_TESTFUNC="do_test"
 
-DIR_NUM=${DIR_NUM:-"100"}
-FILE_NUM=${FILE_NUM:-"100"}
+DIR_NUM=${DIR_NUM:-"80"}
+FILE_NUM=${FILE_NUM:-"80"}
 THREAD_NUM=${THREAD_NUM:-"1"}
 ORIG_NFSD=
 
-- 
2.40.0

