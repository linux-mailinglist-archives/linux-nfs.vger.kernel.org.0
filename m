Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4394C7CFB31
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Oct 2023 15:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345990AbjJSNe4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Oct 2023 09:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345979AbjJSNe4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Oct 2023 09:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EACB6
        for <linux-nfs@vger.kernel.org>; Thu, 19 Oct 2023 06:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697722447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sQBsXb/cdSmnkTR3Xz2B7T66YuT+o+RY1Du6wnMbFqk=;
        b=SHQgxFADpH8keaPsNbNs4xQOXShKN3DBdLrTFEFDAylXb0Lp2aSVZWdLr7mWGGmHLYU9Ta
        PjBZRx0zSSYq0gRIlgQknNxT/Y7HkmQXvnmZhsEIXhvFebTUaA+qXwaQL+HCwKe+Wq2Dnd
        daoET3ykij1NPbzbOE3eijQ1N80Wqb0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-xuBHKOFRPS-W5Go3sWSIJA-1; Thu, 19 Oct 2023 09:34:02 -0400
X-MC-Unique: xuBHKOFRPS-W5Go3sWSIJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E3DF1C0782B;
        Thu, 19 Oct 2023 13:34:02 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA6C340C6F7B;
        Thu, 19 Oct 2023 13:34:01 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] NFSv4 READDIR d_type fixup
Date:   Thu, 19 Oct 2023 09:33:59 -0400
Message-ID: <cover.1697722160.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a combined posting of two previously posted patches.  The first
unconditionally adds the type attribute to the list of requested attributes
for v4 READDIR.  The second patch enables a per-mount modification via sysfs
of any of the attributes the client will currently decode for v4 READDIR.

The first patch solves a real problem but may cause a performance regression
for some servers that require extra processing to return inode information
along with the namespace.  We performed an informal survey of most of the
major NFSv4 server vendors and although we did not learn of any that may be
impacted, the potential remains.

The second patch gives us a way to disable this new READDIR behavior should
we find a serious impact in an existing setup.  I would appreciate serious
consideration of this patch in light of the number of claimed performance
regressions that have been reported almost every time we touch this
sensitive operation on the client.

For example:

echo 0x800 0x800000 0x0 > /sys/fs/nfs/0\:57/v4_readdir_attrs

.. will revert the behavior change from patch 1.

Changes on v2:
	- fix patch 2/2 to compile without CONFIG_NFS_4

Benjamin Coddington (2):
  NFSv4: Always ask for type with READDIR
  NFSv4: Allow per-mount tuning of READDIR attrs

 fs/nfs/client.c           |  4 ++
 fs/nfs/nfs4client.c       |  4 ++
 fs/nfs/nfs4proc.c         |  1 +
 fs/nfs/nfs4xdr.c          |  9 ++--
 fs/nfs/sysfs.c            | 86 +++++++++++++++++++++++++++++++++++++++
 include/linux/nfs_fs_sb.h |  1 +
 include/linux/nfs_xdr.h   |  1 +
 7 files changed, 101 insertions(+), 5 deletions(-)


base-commit: 401644852d0b2a278811de38081be23f74b5bb04
-- 
2.41.0

