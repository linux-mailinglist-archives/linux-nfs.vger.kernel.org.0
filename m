Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8B45638CE
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Jul 2022 19:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiGAR4o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Jul 2022 13:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiGAR4n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Jul 2022 13:56:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C133EF3B
        for <linux-nfs@vger.kernel.org>; Fri,  1 Jul 2022 10:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71DF960C33
        for <linux-nfs@vger.kernel.org>; Fri,  1 Jul 2022 17:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C40EC341C6;
        Fri,  1 Jul 2022 17:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656698200;
        bh=oAWXipt5Wcfh5i5yBa5GSq83sCfgGjKEZYo1td1kVbc=;
        h=From:To:Cc:Subject:Date:From;
        b=Nf1VRpy+3WMTKlghMbCm7vfT3K1HePA0Ex96PxKV/zS+0S3Vyr4mOC6NM/w+fe+Wj
         cUF0RPBWmbBAhzH9hSuh3vZR953F2kNmpm4YeBqLa3yc+QjUzwkTGb5tPrq9j92O2o
         blck/b4p88hIMl5dqZ63TcVmVL8DR8RXdQxMM+ffXGjYPgITCjUyFxOhj3ZaRjaHc8
         MNFJsC4lRu9l8yd3mQ8FvzQDh6CZFiZmfhB27DJ8ka193S53hbaTwK5zeAZAXYeNlJ
         /afvUyIiaXMi1Qld73y8gdXzURStRsXWljhdzP8Xmzlcy/dpbHAobErLHy9rAWu/af
         Gwz5Ie5yONZbg==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org
Cc:     anna@kernel.org
Subject: [GIT PULL] Please pull a few more NFS Client Bugfixes for Linux 5.19-rc
Date:   Fri,  1 Jul 2022 13:56:39 -0400
Message-Id: <20220701175639.1793038-1-anna@kernel.org>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.19-3

for you to fetch changes up to 4f40a5b5544618b096d1611a18219dd91fd57f80:

  NFSv4: Add an fattr allocation to _nfs4_discover_trunking() (2022-06-30 16:13:00 -0400)

----------------------------------------------------------------
More NFS Client Bugfixes for Linux 5.19-rc

- Bugfixes:
  - Allocate a fattr for _nfs4_discover_trunking()
  - Fix module reference count leak in nfs4_run_state_manager()

Thanks,
Anna

----------------------------------------------------------------
NeilBrown (1):
      NFS: restore module put when manager exits.

Scott Mayhew (1):
      NFSv4: Add an fattr allocation to _nfs4_discover_trunking()

 fs/nfs/nfs4proc.c  | 19 +++++++++++++------
 fs/nfs/nfs4state.c |  1 +
 2 files changed, 14 insertions(+), 6 deletions(-)
