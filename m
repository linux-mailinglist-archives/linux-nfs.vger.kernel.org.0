Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C4B7D753D
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 22:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjJYUMG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 16:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYUMF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 16:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC58111
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 13:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698264679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Mav3bfV//vVf2LGNO9I+R4QgrCE2H3bfrksrJq4AB2w=;
        b=ckCRvXJgdCFWaYTP5HQtAADlwqsrcnducGUbqlTwL8eiNcqv/QUvekAzxhXgEaLLYxy+0S
        982jsGLdybHRhOJCioJY9ACAiWa1fphNgMJSI/S8EkZxYU+wZv0MLvVwuIAe5GURlHr4U+
        XBJelNZQnb1TW8al8tf8GLmWMK/XEFo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-c4oPuCzTOEyB39dGKDmn2Q-1; Wed,
 25 Oct 2023 16:11:16 -0400
X-MC-Unique: c4oPuCzTOEyB39dGKDmn2Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 904CF3C40C09;
        Wed, 25 Oct 2023 20:11:16 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 327E61C060AE;
        Wed, 25 Oct 2023 20:11:15 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/2] NFSv4 READDIR d_type fixup
Date:   Wed, 25 Oct 2023 16:11:13 -0400
Message-ID: <cover.1698262608.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

Changes on v3:
	- fix a lkp warning about line spacing
	- hide the v4_readdir_attrs behind CONFIG_NFS_EXPERT_SYSFS

Benjamin Coddington (2):
  NFSv4: Always ask for type with READDIR
  NFSv4: Allow per-mount tuning of READDIR attrs

 fs/nfs/Kconfig            |  7 +++
 fs/nfs/client.c           |  4 ++
 fs/nfs/nfs4client.c       |  4 ++
 fs/nfs/nfs4proc.c         |  1 +
 fs/nfs/nfs4xdr.c          |  9 ++--
 fs/nfs/sysfs.c            | 91 +++++++++++++++++++++++++++++++++++++++
 include/linux/nfs_fs_sb.h |  1 +
 include/linux/nfs_xdr.h   |  1 +
 8 files changed, 113 insertions(+), 5 deletions(-)

-- 
2.41.0

