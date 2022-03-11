Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FBF4D6090
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Mar 2022 12:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbiCKL3R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Mar 2022 06:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiCKL3R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Mar 2022 06:29:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A980BCFBB6
        for <linux-nfs@vger.kernel.org>; Fri, 11 Mar 2022 03:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646998093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f8Z65QU/sPRK6Papy+C6+5xRCDPUUsts1NEh7BhXLpw=;
        b=XyWzm03Q1Yw5Bh2Z88/Q8DadmXU8cf0vfMhFZ+D32Ck0xhLC972pD00EzsUD3jPoLcRMvE
        qxqdu87IkxHE6zOVJAWU6JmvNImr8s0TeYu/YI48YwAfgBQPfkie3FkWPDpaan4FS9TSUk
        PKfcwngYoacyvYDZQ4r+udk3lCJcIVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-VuKjaQc1PfSwskQTQJ_d3Q-1; Fri, 11 Mar 2022 06:28:12 -0500
X-MC-Unique: VuKjaQc1PfSwskQTQJ_d3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7633C1800D50;
        Fri, 11 Mar 2022 11:28:11 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D67A83281;
        Fri, 11 Mar 2022 11:28:11 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v9 14/27] NFS: Improve heuristic for readdirplus
Date:   Fri, 11 Mar 2022 06:28:10 -0500
Message-ID: <A1B01312-F429-47AB-8EA3-4264C3FEF84A@redhat.com>
In-Reply-To: <28d6a094ddca6e4e6c15e055ec3ef6b10d57cbd3.camel@hammerspace.com>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
 <20220227231227.9038-5-trondmy@kernel.org>
 <20220227231227.9038-6-trondmy@kernel.org>
 <20220227231227.9038-7-trondmy@kernel.org>
 <20220227231227.9038-8-trondmy@kernel.org>
 <20220227231227.9038-9-trondmy@kernel.org>
 <20220227231227.9038-10-trondmy@kernel.org>
 <20220227231227.9038-11-trondmy@kernel.org>
 <20220227231227.9038-12-trondmy@kernel.org>
 <20220227231227.9038-13-trondmy@kernel.org>
 <20220227231227.9038-14-trondmy@kernel.org>
 <20220227231227.9038-15-trondmy@kernel.org>
 <A7BBBBF2-768E-487C-A890-7E5AF1D40027@redhat.com>
 <28d6a094ddca6e4e6c15e055ec3ef6b10d57cbd3.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10 Mar 2022, at 15:15, Trond Myklebust wrote:
>
> The problem is really that 'ls' (or possibly glibc) is passing in a
> pretty huge buffer to the getdents() system call.
>
> On my setup, that buffer appears to be 80K in size. So what happens is
> that we get that first getdents() call, and so we fill the 80K buffer
> with as many files as will fit. That can quickly run into several
> thousand entries, if the filenames are relatively short.
>
> Then 'ls' goes through the contents and does a stat() (or a statx()) on
> each entry, and so we record the statistics. However that means those
> first several thousand entries are indeed going to use cached data, or
> force GETATTR to go on the wire. We only start using forced readdirplus
> on the second pass.
>
> Yes, I suppose we could limit getdents() to ignore the buffer size, and
> just return fewer entries, however what's the "right" size in that
> case?

We can return fewer entries on the first call, so for the first pass the
right size is NFS_READDIR_CACHE_MISS_THRESHOLD + 1.  I sent a patch.

> More to the point, how much pain are we going to accept before we give
> up trying these assorted heuristics, and just define a readdirplus()
> system call modelled on statx()?

We cursed ourselves by creating the heuristic, and now we've had to maintain
it and try to make everyone happy.  The pain for us is when the behavior
keeps changing after sites have come to rely on previous performance.

I hope you can take a look at the patch.

Ben

