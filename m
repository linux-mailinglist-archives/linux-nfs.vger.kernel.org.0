Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7304BC28A
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Feb 2022 23:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbiBRWXl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Feb 2022 17:23:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiBRWXk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Feb 2022 17:23:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6B91B3727;
        Fri, 18 Feb 2022 14:23:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83FCF61EAC;
        Fri, 18 Feb 2022 22:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B67C340E9;
        Fri, 18 Feb 2022 22:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645223001;
        bh=uk1s75mVlW0O44zX7T+aa8+8I7XuD1z0XbVB2oouvYc=;
        h=From:To:Cc:Subject:Date:From;
        b=XUUJa4dVoRtPTBuxAVdjTAbwNMl06sYOKkdF3LKNhgIxgFtzEK66RR73Jm7gKr/ZL
         kBHICiQCMO5lbzvQrzXMV31vb7qQpbMfL4OFCwsd+QLmtykXUVBTBuvU8zIJowxtDb
         Hhj9unpH9XcDcNBQB11wwchBiLdLhNGGUPtBXIHPSLQ0NSejwJLBp/PZT8W0sM/jyr
         fntSvAv/weR/GHpAIo+MMQ/Q9OLsVM4SFrOKfsI9gOKopz4oe/jRyvbYvNWVsjsnbV
         h85iSNDoEzjqsQ5xFUgkcF4oYPsSbcWTw6lacaJn8E9kkcOszvFwvLafRKqGCVFEUF
         O8eSXWktmRiaw==
From:   Anna Schumaker <anna@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please Pull A Few More NFS Client Bugfixes for Linux v5.17-rc
Date:   Fri, 18 Feb 2022 17:23:20 -0500
Message-Id: <20220218222320.386771-1-anna@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.17-3

for you to fetch changes up to d19e0183a88306acda07f4a01fedeeffe2a2a06b:

  NFS: Do not report writeback errors in nfs_getattr() (2022-02-16 15:15:22 -0500)

----------------------------------------------------------------
NFS Client Bugfixes for Linux 5.17-rc5

- Other Fixes:
  - Fix unnecessary changeattr revalidations
  - Fix resolving symlinks during directory lookups
  - Don't report writeback errors in nfs_getattr()

----------------------------------------------------------------
Trond Myklebust (3):
      NFS: Remove an incorrect revalidation in nfs4_update_changeattr_locked()
      NFS: LOOKUP_DIRECTORY is also ok with symlinks
      NFS: Do not report writeback errors in nfs_getattr()

 fs/nfs/dir.c      | 4 ++--
 fs/nfs/inode.c    | 9 +++------
 fs/nfs/nfs4proc.c | 3 +--
 3 files changed, 6 insertions(+), 10 deletions(-)
