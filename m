Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B247731FB3
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jun 2023 20:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbjFOSI1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jun 2023 14:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbjFOSIY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jun 2023 14:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652C6295D
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686852455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4gtDvQA2j6yTNSWXiPlnRitmf5zVHoXFKngCn0TigBk=;
        b=EqyejBoKf8fvR6htb8Bn1Ux/0tP+s11bD4r1OD0FbHFg7DM84Liuq5ZLViEIat9E4kqoKI
        BRkHtFzRy3dnqplnTrA+etrQO/sy2ukhaMHsjsw7Alw5XffQdCVV2tq7ajMtKES1j8N1LZ
        JSjw1z9k9F/Om3kz0wzcJ0dJA89etSo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-GhZI7ngFNvm94kxSl1zFYA-1; Thu, 15 Jun 2023 14:07:33 -0400
X-MC-Unique: GhZI7ngFNvm94kxSl1zFYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EE418030AE
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:33 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E378E2166B25
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:32 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 00/11] NFS sysfs scaffolding
Date:   Thu, 15 Jun 2023 14:07:21 -0400
Message-Id: <cover.1686851158.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Its been awhile, so here's a version 4 of the NFS sysfs scaffolding.  This
version is similar to v3, but is network namespace aware.  Shutdown works
well to clean up serverless clients, unless there are pNFS DS clients.  A
future version (in the works) will support shutdown for DS clients as well.

The client identifier path (unchanged here) is a little awkward - I don't
think the "net" and "nfs_client" directories add anything useful, but they
were artifacts of working with the sysfs namespace API.   I don't think we
can change it now without risking silent breakage.  We get around needing
extra directories here by open-coding kset_create_and_add() in patch 3.

I have Anna's optional server feature control namespaced and working well,
but I've left it out for now because I'd like to split it into individual
attribute files once I saw how easy it was to map the features into sysfs
attributes.  This seems to better fit the sysfs' style of one
file-per-attribute. However, after getting things to work with namespaces I
found that the sysfs macros to do this are not namespace aware, and much of
the work would need either lots of open coding or our own set of macros to
reduce redudant lines of code.

Changes since version 3:
https://lore.kernel.org/linux-nfs/cover.1682097420.git.bcodding@redhat.com/

	- /sys/fs/nfs/* objects are network-namespace unique

Benjamin Coddington (11):
  NFS: rename nfs_client_kset to nfs_kset
  NFS: rename nfs_client_kobj to nfs_net_kobj
  NFS: Open-code the nfs_kset kset_create_and_add()
  NFS: Make all of /sys/fs/nfs network-namespace unique
  NFS: add superblock sysfs entries
  NFS: Add sysfs links to sunrpc clients for nfs_clients
  NFS: add a sysfs link to the lockd rpc_client
  NFS: add a sysfs link to the acl rpc_client
  NFS: add sysfs shutdown knob
  NFS: Cancel all existing RPC tasks when shutdown
  NFSv4: Clean up some shutdown loops

 fs/lockd/clntlock.c         |   6 +
 fs/nfs/client.c             |  22 ++++
 fs/nfs/nfs3client.c         |   4 +
 fs/nfs/nfs4client.c         |   4 +
 fs/nfs/nfs4proc.c           |   2 +-
 fs/nfs/nfs4state.c          |   3 +
 fs/nfs/super.c              |   6 +-
 fs/nfs/sysfs.c              | 235 ++++++++++++++++++++++++++++++------
 fs/nfs/sysfs.h              |  10 +-
 include/linux/lockd/bind.h  |   2 +
 include/linux/nfs_fs_sb.h   |   3 +
 include/linux/sunrpc/clnt.h |  11 +-
 net/sunrpc/clnt.c           |   5 +
 net/sunrpc/sysfs.h          |   7 --
 14 files changed, 274 insertions(+), 46 deletions(-)

-- 
2.40.1

