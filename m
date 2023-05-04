Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF5E6F6CAD
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 15:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjEDNOG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 09:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjEDNOF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 09:14:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7F06194
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 06:14:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C20A422518;
        Thu,  4 May 2023 13:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683206043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6zuNBKSgyzbHvrNMhySy4dCq62+jMm3tUSN1h9NEC4s=;
        b=pXDDHv7xNKfV4bXbmDhqJjX660/o2DJREW6+E2HSwU+rIJmcEi5hSPPxC7pulfSmWL/WUZ
        +NVzHRDePn1TGIsOp2sr39S6UwwKiwXvsHP3u4Ww5chQ7NeW7Tu+tFJi1KNeP/jVIGJBbU
        fgAC4oeuhHXzMYKETno9sWQyyWdFEW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683206043;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6zuNBKSgyzbHvrNMhySy4dCq62+jMm3tUSN1h9NEC4s=;
        b=BiiWE5iJ1yTH+R4WlT9a3sUDVnEtWaiJI9TSo5S2VpB6wlesS8ISxWRBvd2RJb0dZ3RJox
        AtKHi0vm4BSVo0CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67F8713444;
        Thu,  4 May 2023 13:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A+9eF5uvU2TXVgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 04 May 2023 13:14:03 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, NeilBrown <neilb@suse.de>,
        Cyril Hrubis <chrubis@suse.cz>, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v5 0/5] NFS: test on btrfs, ext4, xfs filesystems
Date:   Thu,  4 May 2023 15:14:09 +0200
Message-Id: <20230504131414.3826283-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
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

changes v4->v5:
* test only on btrfs, ext4, xfs instead on all available filesystems
This increases coverage but minimises the runtime (compare to running on
all available filesystems) => should be safer to commit now, before git
freeze.
* increase sleep to 2 sec after first umount (to avoid "device in use")
* new commit to fix not enough space on nfs03.sh
TODO: better handling space

NOTE: this patchset also fixes problem with device in use in case
somebody used TMPDIR on mounted loop device on current master (without
TST_ALL_FILESYSTEMS=1).

Petr Vorel (5):
  nfs_lib.sh: Cleanup local and remote directories setup
  nfs_lib.sh: Unexport on proper side on netns
  nfs05.sh: Lower down the default values
  nfs03.sh: Lower down the default values
  nfs: Run on btrfs, ext4, xfs

 testcases/network/nfs/nfs_stress/nfs03.sh   |  4 +-
 testcases/network/nfs/nfs_stress/nfs05.sh   |  6 +-
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 73 +++++++++++++++------
 3 files changed, 57 insertions(+), 26 deletions(-)

-- 
2.40.0

