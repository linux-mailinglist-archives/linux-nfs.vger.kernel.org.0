Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8260673ED13
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jun 2023 23:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjFZVsV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jun 2023 17:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjFZVsS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Jun 2023 17:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1198A172A
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jun 2023 14:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687816047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PvTDCMey1CYEwr6NpUGgqZlGtDm5m5oqSyTNc54STfg=;
        b=Z/6xHaJ+KxyPIkPghChtWXyGi3aXpafdcxJjYiNN773Y71/g/XFAtRVBi1U3aqgmo0s1KS
        9zw3j5rTveYj4QebpsnD32RagYpN3ITYko65mIWOu0/uGm2IMJqZQc4e3PP7z/l/OVBeYz
        yrQ7BCnQzQL7HEumpLWaTIyODdEJgdg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-iH_L0sfgN7iDBFv1e8eddQ-1; Mon, 26 Jun 2023 17:47:23 -0400
X-MC-Unique: iH_L0sfgN7iDBFv1e8eddQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25C1B858290;
        Mon, 26 Jun 2023 21:47:23 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87D4E492B03;
        Mon, 26 Jun 2023 21:47:22 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@gmail.com>
Subject: Re: [PATCH v4 05/11] NFS: add superblock sysfs entries
Date:   Mon, 26 Jun 2023 17:47:21 -0400
Message-ID: <BB4C7A5D-BC97-4422-B5DE-D9267EB29882@redhat.com>
In-Reply-To: <20230626211223.GA3771155@dev-arch.thelio-3990X>
References: <cover.1686851158.git.bcodding@redhat.com>
 <095dda5e682c8367335b9fa448f2834b9435ee69.1686851158.git.bcodding@redhat.com>
 <20230626211223.GA3771155@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 26 Jun 2023, at 17:12, Nathan Chancellor wrote:

> Hi Benjamin,
>
> On Thu, Jun 15, 2023 at 02:07:26PM -0400, Benjamin Coddington wrote:
>> Create a sysfs directory for each mount that corresponds to the mount's
>> nfs_server struct.  As the mount is being constructed, use the name
>> "server-n", but rename it to the "MAJOR:MINOR" of the mount after assigning
>> a device_id. The rename approach allows us to populate the mount's directory
>> with links to the various rpc_client objects during the mount's
>> construction.  The naming convention (MAJOR:MINOR) can be used to reference
>> a particular NFS mount's sysfs tree.
>>
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>
> I am not sure if this has been reported or fixed already, so I apologize
> if this is a duplicate. After this change landed in -next as commit
> 1c7251187dc0 ("NFS: add superblock sysfs entries"), I see the following
> splat when accessing a NFS server:

Hi Nathan, oh yes - I see there are a few paths through nfs4_init_server()
where we can exit early due to an error or duplicate client, in which case
nfs_free_server() tries to clean up the server kobject before it has been
initialized.

I think we can simply do:

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 4967ac800b14..4046072663f2 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1013,8 +1013,10 @@ void nfs_free_server(struct nfs_server *server)

        nfs_put_client(server->nfs_client);

-       nfs_sysfs_remove_server(server);
-       kobject_put(&server->kobj);
+       if (server->kobj.state_initialized) {
+               nfs_sysfs_remove_server(server);
+               kobject_put(&server->kobj);
+       }
        ida_free(&s_sysfs_ids, server->s_sysfs_id);

        ida_destroy(&server->lockowner_id);

Are you able to test that?  If not, totally fine - I think I should be able
to reproduce the problem and send a patch.

Ben

