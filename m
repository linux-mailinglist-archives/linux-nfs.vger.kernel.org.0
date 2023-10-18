Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7167CE75E
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Oct 2023 21:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjJRTJd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Oct 2023 15:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJRTJc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Oct 2023 15:09:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774E0119
        for <linux-nfs@vger.kernel.org>; Wed, 18 Oct 2023 12:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697656132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eJm2VOptx7PepimudTOmvz8Y1z9b6dN4O2gMGfDgu80=;
        b=W2lltrHMj1QBdZfLEcQiH3yTAaKmY/nyBPNUohRATyYDs4lGFiz/hZLkLjvn/8NN75P8cC
        WjslZYcEeN6NivuTFYMTAD+v1r7Tng6eqggYxXYN9XxAReg20Br/wApqbVnyxKHMzGceCE
        0avVoUOt9RwF78jSZ+QZ+u8f/ougEUQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-wOYZ-rLQOMmR6BHWC3Nu4Q-1; Wed, 18 Oct 2023 15:08:48 -0400
X-MC-Unique: wOYZ-rLQOMmR6BHWC3Nu4Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7760A881F01;
        Wed, 18 Oct 2023 19:08:47 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BFDF503E;
        Wed, 18 Oct 2023 19:08:46 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSv4: Allow per-mount tuning of READDIR attrs
Date:   Wed, 18 Oct 2023 15:08:45 -0400
Message-ID: <828F5AC6-99CA-417A-9475-41B6B9F35DB1@redhat.com>
In-Reply-To: <CAFX2JfkON+5MsYuw-SsvSg04M6Fy=BY_v7RZ9aAs35P7fD15Gw@mail.gmail.com>
References: <cover.1697577945.git.bcodding@redhat.com>
 <bd900de1d19bc56e6df5b44379f373617acc894e.1697577945.git.bcodding@redhat.com>
 <ZS/V+4Cuzox7erqz@tissot.1015granger.net>
 <6157b73e380e5b625cd8ed0133ef392d0dd4bd8b.camel@kernel.org>
 <ZS/qwYzQvrgJNEv6@tissot.1015granger.net>
 <CAFX2JfkON+5MsYuw-SsvSg04M6Fy=BY_v7RZ9aAs35P7fD15Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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

> On Wed, Oct 18, 2023 at 10:25 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On Wed, Oct 18, 2023 at 09:33:40AM -0400, Jeff Layton wrote:
>>> On Wed, 2023-10-18 at 08:56 -0400, Chuck Lever wrote:
>>>> On Tue, Oct 17, 2023 at 05:30:44PM -0400, Benjamin Coddington wrote:
>>>>> Expose a per-mount knob in sysfs to set the READDIR requested attributes
>>>>> for a non-plus READDIR request.
>>>>>
>>>>> For example:
>>>>>
>>>>>   echo 0x800 0x800000 0x0 > /sys/fs/nfs/0\:57/v4_readdir_attrs
>>>>>
>
> I understand why you're not adding a keyword for each attribute
> requested in a readdir, but would it be possible to have a single
> magic keyword like "reset" or "default" that is an alias for reverting
> to the default attributes?

Yes, it's possible.  But what happens when we change the defaults again?
"Reset" becomes meaningless after that.  That sort of sysfs addition is not
future-proof.  This file both shows the current and any future default set
of attributes being used on the client as well as allowing them to be
modified.

The only attributes that are allowed to be set are those that the client
would already request and properly decode in the readdir plus path.  The
foot-shooty space is the permutation of every combination of those 20
attributes, save the three cases we've been stomping on already: 1) the
non-plus case, 2) the new non-plus with type, and 3) the plus case with all
20 attributes.

I suppose I could test all those cases for weirdness, but I expect they'd
all "just work" for listing directories. (I have tested quite a few without
surprises.)  Perhaps some cases would expose assumptions in the attribute
cache on the client -- for example the client might expect _SIZE and
_SPACE_USED to always be updated in the same operation.  But, I don't expect
that to create devastating issues, and I really don't think anyone's going
to need to break the client by trying to ask for only _SIZE without
_SPACE_USED (all hypothetical).

Another way forward may be to just allow the addition or removal of _TYPE,
but the client I want to use allows me to request any of those attributes.
If this never ends up helping anyone, I'll eat my hat.

Ben

