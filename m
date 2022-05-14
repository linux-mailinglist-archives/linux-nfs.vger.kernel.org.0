Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A969B527236
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiENOvP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbiENOvD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:51:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B685AA451
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 554C360F47
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8C7C34116;
        Sat, 14 May 2022 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652539842;
        bh=AxffH804IbJxdgJRI2Z+Xm+gT/miBEcDgrf32xjeZAo=;
        h=From:To:Cc:Subject:Date:From;
        b=q/A+/ipdisrljB11tczc1wH8oa3mLOn3g/DSOp8Tn7IryXb/PcfhlPuNDTQis/pwX
         0zC0UweVHk2PyMzRDbSu74nKswsJCRxeHN1aSQRqx1W4jXa0hzNXECBe7Kx7XK2mBD
         jeXxdIeVDj0GPY+2ZgL+tqQJuq5umb5uOqy3hzMOWYxGdc3/FinenuHe6T8RAS19im
         lKzdLgdFujS0anb9nF7cErTRx7LgdMMkFXZw3ioQFSxtkCHm+LY8wPpRFMt1UDrnWY
         ljGPjTYCWKm3j05VJIlXLIuGO/K5GC1cGsh357wsg1niibqohekPG8SLMm52p6t4cn
         FR+khS4EMgQjg==
From:   trondmy@kernel.org
To:     Steve Dickson <SteveD@redhat.com>,
        "J.Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/6] Allow nfs4-acl-tools to access 'dacl' and 'sacl'
Date:   Sat, 14 May 2022 10:44:30 -0400
Message-Id: <20220514144436.4298-1-trondmy@kernel.org>
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The following patch set matches the kernel patches to allow access to
the NFSv4.1 'dacl' and 'sacl' attributes. The current patches are very
basic, adding support for encoding/decoding the new attributes only when
the user specifies the '--dacl' or '--sacl' flags on the command line.

Trond Myklebust (6):
  libnfs4acl: Add helpers to set the dacl and sacl
  libnfs4acl: Add support for the NFS4.1 ACE_INHERITED_ACE flag
  The NFSv41 DACL and SACL prepend an extra field to the acl
  nfs4_getacl: Add support for the --dacl and --sacl options
  nfs4_setacl: Add support for the --dacl and --sacl options
  Edit manpages to document the new --dacl, --sacl and inheritance
    features

 include/libacl_nfs4.h             | 18 +++++++
 include/nfs4.h                    |  6 +++
 libnfs4acl/Makefile               |  2 +
 libnfs4acl/acl_nfs4_copy_acl.c    |  2 +
 libnfs4acl/acl_nfs4_xattr_load.c  | 14 +++++-
 libnfs4acl/acl_nfs4_xattr_pack.c  | 22 ++++++--
 libnfs4acl/nfs4_ace_from_string.c |  3 ++
 libnfs4acl/nfs4_get_ace_flags.c   |  2 +
 libnfs4acl/nfs4_getacl.c          | 84 +++++++++++++++++++++++++++++++
 libnfs4acl/nfs4_new_acl.c         |  1 +
 libnfs4acl/nfs4_setacl.c          | 49 ++++++++++++++++++
 man/man1/nfs4_getfacl.1           | 14 ++++++
 man/man1/nfs4_setfacl.1           |  8 +++
 man/man5/nfs4_acl.5               | 10 ++++
 nfs4_getfacl/nfs4_getfacl.c       | 73 ++++++++++++++++++++++++---
 nfs4_setfacl/nfs4_setfacl.c       | 67 ++++++++++++++++++++++--
 16 files changed, 359 insertions(+), 16 deletions(-)
 create mode 100644 libnfs4acl/nfs4_getacl.c
 create mode 100644 libnfs4acl/nfs4_setacl.c

-- 
2.36.1

