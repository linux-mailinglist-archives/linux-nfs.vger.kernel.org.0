Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4A46ED68C
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Apr 2023 23:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjDXVIQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Apr 2023 17:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjDXVIO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Apr 2023 17:08:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9786184
        for <linux-nfs@vger.kernel.org>; Mon, 24 Apr 2023 14:08:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9E6181F88F;
        Mon, 24 Apr 2023 21:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682370491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qNqF9lt1VGiwkNxgKI1S7fxgWB8ln4b7o0cffADwrWo=;
        b=FijMpOO6XZChui0YLqm0TR9EcmAtpaDYTrDxRL/9aQAnNydXx5vE6gCFlLybDVH2Y6T/PC
        aiPgizfq33h69qTQ0TlYpwOhXPG7UdIUEq0ubH+jzXc0ou5kaO64fb5Pk010JGaUZ0f4KK
        Wrd6PrexH6RurebNjHMLxd6EfMobBTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682370491;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qNqF9lt1VGiwkNxgKI1S7fxgWB8ln4b7o0cffADwrWo=;
        b=i+qty8lDkKPbeJs73oFfCFItLXHgfL9qMJ4T4wa2CG7T5F0gnhrdAMFsbflxn300gcjhaf
        3gH6EV3XLkf8yoAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 292F61390E;
        Mon, 24 Apr 2023 21:08:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /tsjCLvvRmSzIAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 24 Apr 2023 21:08:11 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, NeilBrown <neilb@suse.de>,
        Cyril Hrubis <chrubis@suse.cz>, linux-nfs@vger.kernel.org,
        Steve Dickson <steved@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH v3 0/3] NFS: test on all filesystems
Date:   Mon, 24 Apr 2023 23:08:15 +0200
Message-Id: <20230424210818.2885479-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

finally I managed to finish the support for LTP NFS tests to be running
on all available testing filesystems via TST_ALL_FILESYSTEMS=1.

I believe this will help to cover more bugs than testing on single
underlying filesystem.

Thank you to Neil Brown to help with the debugging of umounting loop
device, which was the problem in the past.

Kind regards,
Petr

Petr Vorel (3):
  nfs_lib.sh: Cleanup local and remote directories setup
  nfs_lib.sh: Unexport on proper side on netns
  nfs: Run on all filesystems

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 82 +++++++++++++++------
 1 file changed, 61 insertions(+), 21 deletions(-)

-- 
2.40.0

