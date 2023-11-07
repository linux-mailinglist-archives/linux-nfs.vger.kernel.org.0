Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1667E410E
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Nov 2023 14:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjKGNuL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Nov 2023 08:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbjKGNtz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Nov 2023 08:49:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7FA1BF3
        for <linux-nfs@vger.kernel.org>; Tue,  7 Nov 2023 05:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699364819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YksAOz8jIIqTDuFlgpPwoyqahgKKroA62zwu9ledT3Y=;
        b=Oy/3D22ztB6GoGqsVpEbsbNT5LIDPuzAlLGckpQaHw2/MmL3veR7ufpOjDx6Y4p/35pv3F
        WOqccVVhrrCz0IhDDISQPxETDJKx2ifL1zyfSSUzWfTEncLFlwwW8KTy5525H7kHcDfZJT
        EpywbilzcIgn5KY8YF1jY6MfSD09GKc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-ncfvZXGzNZanT4NonQpDww-1; Tue, 07 Nov 2023 08:46:56 -0500
X-MC-Unique: ncfvZXGzNZanT4NonQpDww-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDA5C8219A3;
        Tue,  7 Nov 2023 13:46:55 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 863851121306;
        Tue,  7 Nov 2023 13:46:55 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Dan Aloni <dan.aloni@vastdata.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: mount options not propagating to NFSACL and NSM RPC clients
Date:   Tue, 07 Nov 2023 08:46:54 -0500
Message-ID: <80B8993C-645D-4748-93B3-88415E165B87@redhat.com>
In-Reply-To: <20231105154857.ryakhmgaptq3hb6b@gmail.com>
References: <20231105154857.ryakhmgaptq3hb6b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dan,

On 5 Nov 2023, at 10:48, Dan Aloni wrote:

> Hi,
>
> On Linux v6.6-14500-g1c41041124bd, I added a sysfs file for debugging
> `/sys/kernel/debug/sunrpc/rpc_clnt/*/info`, and noticed that when
> passing the following mount options: `soft,timeo=50,retrans=16,vers=3`,
> NFSACL and NSM seem to take the defaults from somewhere else (xprt).
> Specifically, locking operation behave as if in a hard mount with
> these mount options.
>
> Is it intentional?

Yes, it usually is intentional.  The various rpc clients that make parts of
NFS work don't all inherit the mount flags due to reasons about how the
system should behave as a whole.  I think that you can find usually find the
reasoning the git logs around "struct rpc_create_args".

Are you getting a system hung up in a lock operation?

Ben

