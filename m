Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E1F6F46CF
	for <lists+linux-nfs@lfdr.de>; Tue,  2 May 2023 17:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjEBPNk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 May 2023 11:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjEBPNj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 May 2023 11:13:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638092D52
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 08:13:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 233FF1FD6E;
        Tue,  2 May 2023 15:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683040417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Dg0G3Hlm9JSNx1ZLqXIQLLdwdWB2kPYklJ9tLF+0H1Y=;
        b=Uar4GXfU8NnCOxtnM/r6cE2+DFdZi0VSzp1jEtbzq1zN3zZQAPqeKf889Cu35FAqe2ho4/
        d3+s+VGHoo8ohq3qFyX1fPOH5NA1BqjL4SGvly4oBj5wEFpAmeHjYEmnWGMq7Vfo3Q6YGf
        S7Nsjn2v2ctunDodygiYuAaFTFEkcb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683040417;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Dg0G3Hlm9JSNx1ZLqXIQLLdwdWB2kPYklJ9tLF+0H1Y=;
        b=EdACrY9nKze3XGBlcvTEnlGOU3E4kDR6l0wViHWdFbnbJMFl5ysh4QAtDjgP5DspOlBu1Z
        0nKQ7OrJwDwD8xDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6BFB134FB;
        Tue,  2 May 2023 15:13:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xBqQLqAoUWRFGgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 02 May 2023 15:13:36 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <petr.vorel@gmail.com>, NeilBrown <neilb@suse.de>,
        Cyril Hrubis <chrubis@suse.cz>, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 1/1] nfs08.sh: Skip on vfat
Date:   Tue,  2 May 2023 17:13:48 +0200
Message-Id: <20230502151348.3677809-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Petr Vorel <petr.vorel@gmail.com>

vfat does not see '2' on various distros:
* openSUSE Tumbleweed 20230427 (kernel 6.2.12-1-default, nfs-utils 2.6.3,
  mkfs.fat 4.2 (2021-01-31))
* Debian 12 bookworm (kernel 6.1.0-6-amd64, nfs-utils 2.6.2, mkfs.fat 4.2
  (2021-01-31))

NOTE: on it fails completely (on all filesystems) on Debian 11 bullseye
(kernel 5.10.0-8-amd64, nfs-utils 1.3.3, mkfs.fat 4.2 (2021-01-31)) -
likely due 1.3.3, thus skip the test completely.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

testing NFS on all filesystems showed this problem.
Problem on older Debian shows it's likely not related to vfat, but to
something in NFS. Any idea what is wrong?

NOTE: this should be merged before upcoming LTP release.

Kind regards,
Petr


 testcases/network/nfs/nfs_stress/nfs08.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/testcases/network/nfs/nfs_stress/nfs08.sh b/testcases/network/nfs/nfs_stress/nfs08.sh
index 759b4e418..e1c152e2d 100755
--- a/testcases/network/nfs/nfs_stress/nfs08.sh
+++ b/testcases/network/nfs/nfs_stress/nfs08.sh
@@ -8,6 +8,23 @@
 # Based on reproducer from Neil Brown <neilb@suse.de>
 
 TST_TESTFUNC="do_test"
+TST_SKIP_FILESYSTEMS="vfat"
+TST_SETUP="do_setup"
+
+do_setup()
+{
+	local util_version
+
+	nfs_setup
+
+	util_version=$(mount.nfs -V | sed 's/.*nfs-utils \([0-9]\)\..*/\1/')
+	if ! tst_is_int "$util_version"; then
+		tst_brk TBROK "Failed to detect mount.nfs major version"
+	fi
+	if [ "$util_version" -lt 2 ]; then
+		tst_brk TCONF "Testing requires nfs-utils > 1"
+	fi
+}
 
 do_test()
 {
-- 
2.40.0

