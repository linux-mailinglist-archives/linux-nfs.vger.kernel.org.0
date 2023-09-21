Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7207A9D39
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Sep 2023 21:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjIUT3x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Sep 2023 15:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjIUT3W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Sep 2023 15:29:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4540944A1
        for <linux-nfs@vger.kernel.org>; Thu, 21 Sep 2023 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695316029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MTerJnaRyqdB2zZTx1TLqngfBBD8/GcO3h7wb1fLAz4=;
        b=A2FsltI9AwrJzhyVbMbXeLBgv5NUIoGkdQaIVtEGgLtfsfqQ1tKKizqoXDr/uKtcs3Wv8t
        Twm+8hlADsv4MNrhjONotNuavA5a3BsoAJeQvmL4ZBlytvj2q1TBI9oSAO452Z21p9KkfI
        k6r3WqWFUsLrdooc3ERM104Av1VzukM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-P2TzOvi5NcSrJ0C4Y2nWsA-1; Thu, 21 Sep 2023 06:44:59 -0400
X-MC-Unique: P2TzOvi5NcSrJ0C4Y2nWsA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D505185A790;
        Thu, 21 Sep 2023 10:44:59 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96B642156701;
        Thu, 21 Sep 2023 10:44:58 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Charles Hedrick <hedrick@rutgers.edu>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: bad info in NFS context
Date:   Thu, 21 Sep 2023 06:44:57 -0400
Message-ID: <B7D023CD-2810-4BD6-8570-AB0C0EE95287@redhat.com>
In-Reply-To: <PH0PR14MB5493ED33985C95FEBE4DA808AAF9A@PH0PR14MB5493.namprd14.prod.outlook.com>
References: <PH0PR14MB5493ED33985C95FEBE4DA808AAF9A@PH0PR14MB5493.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 20 Sep 2023, at 19:14, Charles Hedrick wrote:

> Ubuntu 22 client and server (5.15). Mount is 4.2, sec=3Dsys. I add a us=
er to a group, but they can't see things that the group should be able to=
 see. /proc/net/rpc/auth.unix.gid/content shows that the nfs group cache =
has their group membership. Doing a mount -o vers=3D4.1 works (4.1 to for=
ce a different context). Other users that didn't try before work. It's be=
en several hours, and 4.2 still won't work for this user.
>
> What do I need to flush?
>
> Note that I'm using gssproxy on the server.

Have the user log out and then back in again after the group change, that=

should cause the user's NFS ACCESS cache to clear.

Ben

