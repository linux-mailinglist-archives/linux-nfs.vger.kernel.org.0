Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72CE5BD50F
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Sep 2022 21:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiISTJQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Sep 2022 15:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiISTJP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Sep 2022 15:09:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2636E45064
        for <linux-nfs@vger.kernel.org>; Mon, 19 Sep 2022 12:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663614553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NqvJIwHBqdpz1MX4qTbfPqrfREvGU1co4DLRvt6EPBM=;
        b=XFh4lqok+5twgdjZSV3LHvh4TCiD5oozvdSKpnQFjGO4Y//4RX3OXFlHYoUWLpLhxjzEn4
        c1oqdXe04tEK1JH85mlzycKRowddTgZLFpbQzBZ+4qiMNtaXeccTSFFtWN0Jr5+79bpgtU
        p2qXTRn+52bhZplNBdc+r/6GeHJ8FqI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-364-eYuQBTLFNNSpmX5e5sMowg-1; Mon, 19 Sep 2022 15:09:11 -0400
X-MC-Unique: eYuQBTLFNNSpmX5e5sMowg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99592862FDC;
        Mon, 19 Sep 2022 19:09:10 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C11B207B34A;
        Mon, 19 Sep 2022 19:09:09 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org, neilb@suse.de
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
Date:   Mon, 19 Sep 2022 15:09:08 -0400
Message-ID: <9279E15C-0A9E-4486-BE45-5DA5DF40675D@redhat.com>
In-Reply-To: <361256cf42393e2af9691b40bd51594ce078f968.camel@hammerspace.com>
References: <165110909570.7595.8578730126480600782.stgit@noble.brown>
 <165274590805.17247.12823419181284113076@noble.neil.brown.name>
 <72f091ceaaf15069834eb200c04f0630eca7eaef.camel@hammerspace.com>
 <165274805538.17247.18045261877097040122@noble.neil.brown.name>
 <acdd578d2bb4551e45570c506d0948647d964f66.camel@hammerspace.com>
 <165274950799.17247.7605561502483278140@noble.neil.brown.name>
 <3ec50603479c7ee60cfa269aa06ae151e3ebc447.camel@hammerspace.com>
 <165275056203.17247.1826100963816464474@noble.neil.brown.name>
 <d6c351439c71d95f761c89533919850c91975639.camel@hammerspace.com>
 <D788BD7B-029F-4A4C-A377-81B117BD4CD2@redhat.com>
 <a56ca216aef75f419d8a13dd6c7719ef15bbcaab.camel@hammerspace.com>
 <54685EB8-7E6D-4EC4-8A9E-2BF55F41DABA@redhat.com>
 <f5a2163d11f73e24c2106d43e72d0400d5a282b6.camel@hammerspace.com>
 <FA952BF7-1638-4BD1-8DA9-683078CFDE8F@redhat.com>
 <361256cf42393e2af9691b40bd51594ce078f968.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 26 Aug 2022, at 20:52, Trond Myklebust wrote:

> Can we please try to solve the real problem first? The real problem is
> not that user permissions change every hour on the server.
>
> POSIX normally only expects changes to happen to your group membership
> when you log in. The problem here is that the NFS server is updating
> its rules concerning your group membership at some random time after
> your log in on the NFS client.
>
> So how about if we just do our best to approximate the POSIX rules, and
> promise to revalidate your cached file access permissions at least once
> after you log in? Then we can let the NFS server do whatever the hell
> it wants to do after that.
> IOW: If the sysadmin changes the group membership for the user, then
> the user can remedy the problem by logging out and then logging back in
> again, just like they do for local filesystems.

This goes a long way toward fixing things up for us, I appreciate it, and
hope to see it merged.  The version on your testing branch (d84b059f) can
have my:

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Tested-by: Benjamin Coddington <bcodding@redhat.com>

Ben

