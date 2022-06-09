Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066C4545699
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jun 2022 23:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiFIVmj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Jun 2022 17:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiFIVmi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Jun 2022 17:42:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C037F65D39
        for <linux-nfs@vger.kernel.org>; Thu,  9 Jun 2022 14:42:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BCE151FE8F;
        Thu,  9 Jun 2022 21:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654810950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=srfUH11vAxusP56w7n6Jj5rGzywayqKayZosYErFi+4=;
        b=Atq4LeH9wjksbXCZxuz8zThRbrVu52eWmZAarOza0hUzZszU6LMB/p31bFCdgUBmaMOpn1
        K1luvVj3j7quhiA978DI/fuqwSFc07/CKghAfGBf4Bf5t84DHCUu/dbhty7CkajvcctSij
        m0Ro6aY+MuXPgUWSZCNo1W/nYRAr02U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654810950;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=srfUH11vAxusP56w7n6Jj5rGzywayqKayZosYErFi+4=;
        b=W18+EopwgLPDIEhnw1c1uTBQ2iWRuQbANbWxJRkZLEyNoH5cwA/SPxq1zJ505AStRDA6jM
        lwqBKPRGlnh5g/DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7DE3C13A8C;
        Thu,  9 Jun 2022 21:42:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 45B6HEVpomIQDgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 09 Jun 2022 21:42:29 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Steve Dickson <steved@redhat.com>,
        linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH 0/9] shell: nfs: $TST_ALL_FILESYSTEMS (.all_filesystems)
Date:   Thu,  9 Jun 2022 23:42:14 +0200
Message-Id: <20220609214223.4608-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.1
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

Hi,

this is quite ready $TST_ALL_FILESYSTEMS (i.e. support for LTP shell API
to run test on all available filesystems, equivalent of .all_filesystems
in C API). It's used in NFS tests, where I have questions (RFC).

As it uses testcases/lib/tst_supported_fs.c binary it supports the same
features as C API:
* detect supported filesystems
* run only on single filesystem with $LTP_SINGLE_FS_TYPE (debugging)

825e10a91 ("Skip tmpfs in all-filesystem shell tests")


TODO API:
* filtering filesystems when test does not run on certain filesystem
* (i.e. nfs01.sh on vfat) with $TST_SKIP_FILESYSTEMS (equivalent of
  skip_filesystems variable in C API)
* testcases/lib/tst_supported_fs.c skips tmpfs by default since
  825e10a91 ("Skip tmpfs in all-filesystem shell tests"). After
  implementing $TST_SKIP_FILESYSTEMS it could be removed.

TODO NFS tests:
* Do not require restart NFS server (otherwise legacy testcases/lib/daemonlib.sh
  would have to be used)

Comments are welcome.

Code is also at: https://github.com/pevik/ltp/tree/shell/all_filesystems.v2

Kind regards,
Petr

Petr Vorel (9):
  tst_test.sh: Add $TST_MOUNT_DEVICE
  df01.sh: Use TST_MOUNT_DEVICE=1
  tst_test.sh: allow ' in pattern for allowed variables
  shell: Add test for TST_MOUNT_DEVICE=1
  tst_test.sh: Add $TST_ALL_FILESYSTEMS
  tst_device: Remove unnecessary braces
  tst_device: Add clear command
  shell: Add test for TST_ALL_FILESYSTEMS=1
  nfs: Use TST_ALL_FILESYSTEMS=1

 doc/shell-test-api.txt                        |   3 +
 lib/newlib_tests/shell/tst_all_filesystems.sh |  27 +++++
 lib/newlib_tests/shell/tst_mount_device.sh    |  21 ++++
 testcases/commands/df/df01.sh                 |   5 +-
 testcases/lib/tst_device.c                    |  25 ++++-
 testcases/lib/tst_test.sh                     | 104 ++++++++++++------
 testcases/network/nfs/nfs_stress/nfs_lib.sh   |  25 +++--
 7 files changed, 159 insertions(+), 51 deletions(-)
 create mode 100755 lib/newlib_tests/shell/tst_all_filesystems.sh
 create mode 100755 lib/newlib_tests/shell/tst_mount_device.sh

-- 
2.36.1

