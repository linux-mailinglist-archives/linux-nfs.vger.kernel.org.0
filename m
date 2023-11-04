Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018B07E0F05
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Nov 2023 12:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjKDLOP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 4 Nov 2023 07:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjKDLOO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 4 Nov 2023 07:14:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3461BF
        for <linux-nfs@vger.kernel.org>; Sat,  4 Nov 2023 04:14:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D4FC433C7;
        Sat,  4 Nov 2023 11:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699096452;
        bh=l3wFpZyX/13lGer+hOoC13euBfLCdUPhXg8d5zCHXh4=;
        h=From:To:Cc:Subject:Date:From;
        b=OGCSOTorzlBqamG3EKDHzhV/KLIlzoN1oL2yOp6aL1Alwf1w5nizE0/Z8KsfBgk5G
         NCoXwiKkhPVndZcNrh22RmHynCg8ThtUFsDDGIeFKkJCgKCwjyLHidUv/+6hN+m7+i
         2irp5deFpMGjEXftWxnvnHy1yftW1EiI0ZT32QBnXl/UOXJ1qAl2sI7wXzC7w6mGUf
         F1+2QioiFY3D+38WlKqkMaFtOYMloDF8IG2+DGk/DF3UuAVo1+x0zerLVpPDCORszA
         m45IeztwioEuxa5GMYk97Zx1Dp3/HkuyGHbxwqbnkXqwp/cU1nO+krbA3QOviYifxL
         teXOGSIU6ggRg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, neilb@suse.de, chuck.lever@oracle.com,
        netdev@vger.kernel.org, jlayton@kernel.org, kuba@kernel.org
Subject: [PATCH v4 0/3] convert write_threads, write_version and write_ports to netlink commands
Date:   Sat,  4 Nov 2023 12:13:44 +0100
Message-ID: <cover.1699095665.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introduce write_threads, write_version and write_ports netlink
commands similar to the ones available through the procfs.

Changes since v3:
- drop write_maxconn and write_maxblksize for the moment
- add write_version and write_ports commands
Changes since v2:
- use u32 to store nthreads in nfsd_nl_threads_set_doit
- rename server-attr in control-plane in nfsd.yaml specs
Changes since v1:
- remove write_v4_end_grace command
- add write_maxblksize and write_maxconn netlink commands

This patch can be tested with user-space tool reported below:
https://github.com/LorenzoBianconi/nfsd-netlink.git
This series is based on the commit below available in net-next tree

commit e0fadcffdd172d3a762cb3d0e2e185b8198532d9
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Fri Oct 6 06:50:32 2023 -0700

    tools: ynl-gen: handle do ops with no input attrs

    The code supports dumps with no input attributes currently
    thru a combination of special-casing and luck.
    Clean up the handling of ops with no inputs. Create empty
    Structs, and skip printing of empty types.
    This makes dos with no inputs work.

Lorenzo Bianconi (3):
  NFSD: convert write_threads to netlink commands
  NFSD: convert write_version to netlink commands
  NFSD: convert write_ports to netlink commands

 Documentation/netlink/specs/nfsd.yaml |  83 ++++++++
 fs/nfsd/netlink.c                     |  54 ++++++
 fs/nfsd/netlink.h                     |   8 +
 fs/nfsd/nfsctl.c                      | 267 +++++++++++++++++++++++++-
 include/uapi/linux/nfsd_netlink.h     |  30 +++
 tools/net/ynl/generated/nfsd-user.c   | 254 ++++++++++++++++++++++++
 tools/net/ynl/generated/nfsd-user.h   | 156 +++++++++++++++
 7 files changed, 845 insertions(+), 7 deletions(-)

-- 
2.41.0

