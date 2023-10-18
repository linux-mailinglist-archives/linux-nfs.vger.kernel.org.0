Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF7D7CDFA6
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Oct 2023 16:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345526AbjJRO1U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Oct 2023 10:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345438AbjJRO1J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Oct 2023 10:27:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE6030CA
        for <linux-nfs@vger.kernel.org>; Wed, 18 Oct 2023 07:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697639077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jn3IE8fVQ+MkCWQtv3yw/Yzn5j90c65owH4AJV1W7WU=;
        b=htyU0DplQwFGQr6h9srLokXR3gnFSXBg4WbfseevrPNRWVBNItjJYU2MTHof3kPrHy6R99
        Euy54ZUQfRnXqddLCAyQ08szmXhYxD3WxOrv41Usjs/t154EZd0vjqdi8Dqx6j0ZSmH4j+
        0w9N8qedu4tzRFb6KAPomjgNixVJZ1M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-F3lyvaXkNIq4hnHOJzfw0g-1; Wed, 18 Oct 2023 10:24:34 -0400
X-MC-Unique: F3lyvaXkNIq4hnHOJzfw0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BB1A88B77F;
        Wed, 18 Oct 2023 14:24:21 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0433F1121318;
        Wed, 18 Oct 2023 14:24:19 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSv4: Allow per-mount tuning of READDIR attrs
Date:   Wed, 18 Oct 2023 10:24:18 -0400
Message-ID: <27DF51B5-0794-497B-A3F5-99F16B14D787@redhat.com>
In-Reply-To: <6157b73e380e5b625cd8ed0133ef392d0dd4bd8b.camel@kernel.org>
References: <cover.1697577945.git.bcodding@redhat.com>
 <bd900de1d19bc56e6df5b44379f373617acc894e.1697577945.git.bcodding@redhat.com>
 <ZS/V+4Cuzox7erqz@tissot.1015granger.net>
 <6157b73e380e5b625cd8ed0133ef392d0dd4bd8b.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 18 Oct 2023, at 9:33, Jeff Layton wrote:

> On Wed, 2023-10-18 at 08:56 -0400, Chuck Lever wrote:
>> On Tue, Oct 17, 2023 at 05:30:44PM -0400, Benjamin Coddington wrote:
>>> Expose a per-mount knob in sysfs to set the READDIR requested attributes
>>> for a non-plus READDIR request.
>>>
>>> For example:
>>>
>>>   echo 0x800 0x800000 0x0 > /sys/fs/nfs/0\:57/v4_readdir_attrs
>>>
>>> .. will revert the client to only request rdattr_error and
>>> mounted_on_fileid for any non "plus" READDIR, as before the patch
>>> preceeding this one in this series.  This provides existing installations
>>> an option to fix a potential performance regression that may occur after
>>> NFS clients update to request additional default READDIR attributes.
>>>
>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>> ---
>>>  fs/nfs/client.c           |  2 +
>>>  fs/nfs/nfs4client.c       |  4 ++
>>>  fs/nfs/nfs4proc.c         |  1 +
>>>  fs/nfs/nfs4xdr.c          |  7 ++--
>>>  fs/nfs/sysfs.c            | 81 +++++++++++++++++++++++++++++++++++++++
>>>  include/linux/nfs_fs_sb.h |  1 +
>>>  include/linux/nfs_xdr.h   |  1 +
>>>  7 files changed, 93 insertions(+), 4 deletions(-)
>>
>> Admittedly, it would be much easier for humans to use if the API was
>> based on the symbolic names of the bits rather than a triplet of raw
>> hexadecimal values.

This isn't aiming to be an ease-of-use interface.  This is tinkering with
the innards of the client.  If you're doing this, you better know how to
convert between bases, because you're going to need that and more.

If we want to make it nice, patches to nfsctl can follow.

> I think there are some significant footguns with this interface. It'd be
> very easy to set this wrong and get weird behavior.  OTOH, we could push
> that complexity into userland and provide some sort of script in nfs-
> utils for tuning this.
>
> That said...
>
> When we look at interfaces like this, we have to consider that they may
> be around for a long, long time (decades, even), and people will come to
> rely on them to do strange things that are difficult for us to support.
> If we have someone saying that their READDIR performance slowed down, we
> now have to grab those settings from this sysfs file and validate them
> when trying to help them.
>
> Personally, I'd prefer a simple binary "make it work the old way"
> switch, if we're concerned about performance regressions here. I think
> that's the sort of thing that is simple to explain to admins that are
> suffering from this problem and (more importantly) the sort of setting
> we can later remove when it's no longer needed.
>
> Adding this sort of fine-grained knob will create more problems than it
> solves, as people will (inevitably) use it incorrectly.

I disagree that it will create more problems than it solves.

Also, sysfs isn't there for you to experiment with in production, and
sysadmins know this.  Sysfs is "_The_ filesystem for exporting kernel
objects".   There are plenty of ways to hose a system and corrupt data by
playing around with sysfs.

If we take the position that everything in NFS' sysfs must have a higher
standard of safety than even module parameters (see recover_lost_locks),
that means we better look at making every sysfs interface non-shoot-footy,
which is just insane.  Just take a look at a sampling of writeable files,
here's a couple:

/sys/block/sda/device/delete
/sys/kernel/sunrpc/xprt-switches/switch-1/xprt-0-local/dstaddr

Ben

