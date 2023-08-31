Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C400878F017
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 17:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244494AbjHaPSd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 11:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243146AbjHaPSc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 11:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C039CE4A
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 08:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693495062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9hHuvj9/RTyeBiFSatJS83lTgqVuSTU8WKdUK2LA6Cs=;
        b=SjR4ktOzmLq30FNleiLpycoTzzatB61cSfXXgpE46uVwoWI284um/3tFg0niL7SgHkdz0r
        4leLPoIamlfPm+dio49Kw9wN3rTlnnHkchxpsZGRbqffN7+uUQMcDCErz9zazsa0E47D1v
        WwCUa2ivvNMaf47WM7kcgxWpMAWCKTg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-xXl63SZ6NMKoNSKH8Cx4FA-1; Thu, 31 Aug 2023 11:17:38 -0400
X-MC-Unique: xXl63SZ6NMKoNSKH8Cx4FA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE39885CBE2;
        Thu, 31 Aug 2023 15:17:37 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB267492C18;
        Thu, 31 Aug 2023 15:17:36 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>, anna@kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] NFSv4: Always ask for type with READDIR
Date:   Thu, 31 Aug 2023 11:17:35 -0400
Message-ID: <6BE9526F-51FE-4CD9-AE95-EE69F7F0CAA6@redhat.com>
In-Reply-To: <f4837c30b2faedd6a736a19d93c79b93df230349.camel@kernel.org>
References: <82d1908e4f835a2f16a509a11b62b9d93ccb6cdf.1693424491.git.bcodding@redhat.com>
 <f793a08ed0db7bbe292c8aa6ec7241178c111cab.camel@kernel.org>
 <4eb846815a1cdd1a98e064305b57a890b46e2708.camel@hammerspace.com>
 <f4837c30b2faedd6a736a19d93c79b93df230349.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 30 Aug 2023, at 17:14, Jeff Layton wrote:

> On Wed, 2023-08-30 at 20:20 +0000, Trond Myklebust wrote:
>> On Wed, 2023-08-30 at 16:10 -0400, Jeff Layton wrote:
>>> On Wed, 2023-08-30 at 15:42 -0400, Benjamin Coddington wrote:
>>>> Again we have claimed regressions for walking a directory tree,
>>>> this time
>>>> with the "find" utility which always tries to optimize away asking
>>>> for any
>>>> attributes until it has a complete list of entries.=C2=A0 This behav=
ior
>>>> makes
>>>> the readdir plus heuristic do the wrong thing, which causes a storm
>>>> of
>>>> GETATTRs to determine each entry's type in order to continue the
>>>> walk.
>>>>
>>>> For v4 add the type attribute to each READDIR request to include it
>>>> no
>>>> matter the heuristic.=C2=A0 This allows a simple `find` command to
>>>> proceed
>>>> quickly through a directory tree.
>>>>
>>>
>>> The important bit here is that with v4, we can fill out d_type even
>>> when
>>> "plus" is false, at little cost. The downside is that non-plus
>>> READDIR
>>> replies will now be a bit larger on the wire. I think it's a
>>> worthwhile
>>> tradeoff though.
>>
>> The reason why we never did it before is that for many servers, it
>> forces them to go to the inode in order to retrieve the information.
>>
>> IOW: You might as well just do readdirplus.
>>
>
> That makes total sense, given how this code has evolved.
>
> FWIW, the Linux NFS server already calls vfs_getattr for every dentry i=
n
> a v4 READDIR reply regardless of what the client requests. It has to in=

> order to detect junctions, so we're bringing in the inode no matter
> what. Fetching the type is trivial, so I don't see this as costing
> anything extra there.
>
> Mileage could vary on other servers with more synthetic filesystems, bu=
t
> one would hope that most of them can also return the type cheaply.

It occurred to me that we could let those other server folks ask for
whatever attributes they wanted if we make it tunable at runtime:

https://lore.kernel.org/linux-nfs/8f752f70daf73016e20c49508f825e8c2c94f5e=
7.1693494824.git.bcodding@redhat.com/T/#u

Ben

