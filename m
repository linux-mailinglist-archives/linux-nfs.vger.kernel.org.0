Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875227CE787
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Oct 2023 21:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjJRTSY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Oct 2023 15:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJRTSX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Oct 2023 15:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11899114
        for <linux-nfs@vger.kernel.org>; Wed, 18 Oct 2023 12:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697656653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lu437WjNSu6i//MOAAY7wGRxXw17gbmp66hPzlAp+CE=;
        b=Ergq/z9H5Wr4wtAuvciLw7k/4K7Wx9lz3h6zFaKa+qZdkFTo9RGmvsCRM1iXVemonkiXFX
        eIlT9ssi2yytwdP2iObH7UIELU2ZoN26iWWjuYAYa81xh+18hNxSD4ird1GKNBog0sxoSp
        ekafPWGHwCGWoffSmRT/ae4W4gwLIlY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-683-SgZ5bKLINf6J-EJQ5RI2KA-1; Wed, 18 Oct 2023 15:17:24 -0400
X-MC-Unique: SgZ5bKLINf6J-EJQ5RI2KA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FF0710201F0;
        Wed, 18 Oct 2023 19:17:24 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57AC2492BFA;
        Wed, 18 Oct 2023 19:17:23 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSv4: Allow per-mount tuning of READDIR attrs
Date:   Wed, 18 Oct 2023 15:17:22 -0400
Message-ID: <5468EC9F-A80B-4F63-90AB-1E27B9E8C227@redhat.com>
In-Reply-To: <CAFX2JfkON+5MsYuw-SsvSg04M6Fy=BY_v7RZ9aAs35P7fD15Gw@mail.gmail.com>
References: <cover.1697577945.git.bcodding@redhat.com>
 <bd900de1d19bc56e6df5b44379f373617acc894e.1697577945.git.bcodding@redhat.com>
 <ZS/V+4Cuzox7erqz@tissot.1015granger.net>
 <6157b73e380e5b625cd8ed0133ef392d0dd4bd8b.camel@kernel.org>
 <ZS/qwYzQvrgJNEv6@tissot.1015granger.net>
 <CAFX2JfkON+5MsYuw-SsvSg04M6Fy=BY_v7RZ9aAs35P7fD15Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 18 Oct 2023, at 14:38, Anna Schumaker wrote:
>> It's not yet clear sysadmins will even need a switch like this, so I
>> would go further and say you should hold off on merging anything
>> like it until there is an actual reported need for it.
>>
>> Now, full control over that bitmap is still very neat thing for
>> experimentation by NFS developers. Hiding this behind a Kconfig
>> option would let you merge it but then turn it off in production
>> kernels.
>
> Definitely a neat thing to have, but I'm also in favor of hiding it
> behind a kconfig option to start.

Ah, missed replying to this part in the last message:

Ok, if my last message isn't convicing enough, are we talking about
something like CONFIG_NFS_EXPERT_SYSFS?

I'm worried that trying to make NFS nicer/safer in sysfs just means we're
gatekeeping what's already a complex and breakable set of technologies in
the one place (sysfs) where we can actually expose some complexity.

Ben

