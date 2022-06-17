Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C7D54FDFB
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jun 2022 21:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243568AbiFQT45 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jun 2022 15:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiFQT44 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jun 2022 15:56:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EF454030
        for <linux-nfs@vger.kernel.org>; Fri, 17 Jun 2022 12:56:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51ABEB82693
        for <linux-nfs@vger.kernel.org>; Fri, 17 Jun 2022 19:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDC9C3411B;
        Fri, 17 Jun 2022 19:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655495813;
        bh=ctpJLKFl0LpMn+gbrPeJDsEJcesFVcJCoSVx3E8gFrc=;
        h=From:To:Cc:Subject:Date:From;
        b=jsOCH4oa602vxOwsHQuWwyNzYzTuqltfKG5OeVnhUnbXLn61/PT8LiHHkny/qXHJL
         Vz5ZJPzDAhs0wkVRQMIQo6U8aMU02ZFj4IfFknrQgze0SrwoatDU2NrbSyzdV7H6bC
         Yo0Lr/2r6XwpPHAgSH26oNszvn6ojSMSOyVYOVAKVaHMdDk+7OoJcNo2bwCL37Uubh
         +BqSxfQP2LJ+C7jus1tQd4SsuSbODJHEBbLFppcdDQVSc4cn/V3k+/fNiTNu2ToWWy
         qnwLXWL4zUVfppkrWff6CUUKFm/cZ8TmMLvFOmFODzhYvlYx/NtsICSmBcPPnfX1Gp
         rzkc4d3kHKHaQ==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org
Cc:     anna@kernel.org
Subject: [GIT PULL] NFS Client Bugfixes for 5.19-rc
Date:   Fri, 17 Jun 2022 15:56:51 -0400
Message-Id: <20220617195651.1028948-1-anna@kernel.org>
X-Mailer: git-send-email 2.36.1
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

Hi Linus,

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.19-2

for you to fetch changes up to 5ee3d10f84d0a32fc11a55c70c204b6d81fd9ef6:

  NFSv4: Add FMODE_CAN_ODIRECT after successful open of a NFS4.x file (2022-06-15 15:03:12 -0400)

----------------------------------------------------------------
NFS Client Fixes for Linux 5.19-rc

- Bugfixes:
  - Add FMODE_CAN_ODIRECT support to NFSv4 so opens don't fail
  - Fix trunking detection & cl_max_connect setting
  - Avoid pnfs_update_layout() livelocks
  - Don't keep retrying pNFS if the server replies with NFS4ERR_UNAVAILABLE

----------------------------------------------------------------
Dave Wysochanski (1):
      NFSv4: Add FMODE_CAN_ODIRECT after successful open of a NFS4.x file

Scott Mayhew (1):
      sunrpc: set cl_max_connect when cloning an rpc_clnt

Trond Myklebust (2):
      pNFS: Don't keep retrying if the server replied NFS4ERR_LAYOUTUNAVAILABLE
      pNFS: Avoid a live lock condition in pnfs_update_layout()

 fs/nfs/callback_proc.c |  1 +
 fs/nfs/dir.c           |  1 +
 fs/nfs/nfs4file.c      |  1 +
 fs/nfs/pnfs.c          | 21 +++++++++++++++------
 fs/nfs/pnfs.h          |  1 +
 net/sunrpc/clnt.c      |  1 +
 6 files changed, 20 insertions(+), 6 deletions(-)
