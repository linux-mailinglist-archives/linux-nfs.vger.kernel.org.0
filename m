Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985E46F1C19
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Apr 2023 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346051AbjD1QAd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Apr 2023 12:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjD1QAc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Apr 2023 12:00:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300352D63
        for <linux-nfs@vger.kernel.org>; Fri, 28 Apr 2023 09:00:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C86E721A2B;
        Fri, 28 Apr 2023 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682697629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pYNhcoSI8w67TCWRIKTXvM7uOQtjaNFojNq9m6DCuhc=;
        b=ki1oVdg8VQ7cx4SwiRM32TxCFvg6c3ScL1vHFPgoqY8wfaaUS5/esTZD4Y3yGk11WU3Dqg
        DUrOK18BgvlNS1VlOhbjEQMeoUSXKVItjdCad848qOE3ajfpj0E8o5Z+xeSgXydKjJkJBp
        jsE/WOseISCK3TQXrsWCGLGjSo+bD+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682697629;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pYNhcoSI8w67TCWRIKTXvM7uOQtjaNFojNq9m6DCuhc=;
        b=ahs2DHLqX7+xM0Yc/GhO8ipVOlYRgXb/zy7t1vKwcCneWA7FpLAQmdFTjoRDgc0sxuHIlS
        8y2wOnUy36tixFCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E128138FA;
        Fri, 28 Apr 2023 16:00:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8ki3CZ3tS2SRbQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 28 Apr 2023 16:00:29 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, NeilBrown <neilb@suse.de>,
        Cyril Hrubis <chrubis@suse.cz>, linux-nfs@vger.kernel.org
Subject: [PATCH v4 0/4] NFS: test on all filesystems
Date:   Fri, 28 Apr 2023 18:00:34 +0200
Message-Id: <20230428160038.3534905-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
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

Hi,

change v3->v4:
new commit "nfs05.sh: Lower down the default values"
to fix nfs05.sh failure on Btrfs.

I'd like to get this change into upcoming LTP release.

Kind regards,
Petr

Petr Vorel (4):
  nfs_lib.sh: Cleanup local and remote directories setup
  nfs_lib.sh: Unexport on proper side on netns
  nfs05.sh: Lower down the default values
  nfs: Run on all filesystems

 testcases/network/nfs/nfs_stress/nfs05.sh   |  4 +-
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 82 +++++++++++++++------
 2 files changed, 63 insertions(+), 23 deletions(-)

-- 
2.40.0

