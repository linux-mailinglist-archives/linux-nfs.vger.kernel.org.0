Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF80B6780F7
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jan 2023 17:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjAWQJh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Jan 2023 11:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjAWQJg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Jan 2023 11:09:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A099F25E0F
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 08:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674490110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z6R3r8/AlsaeKPz1wJZCORr5uEw+JBjfz5bMdHi92x8=;
        b=adpGddYShOZQtGspKbdOBzrN7zlV8XhSG2ne4qiFmyQcZYhV2Qh91ebIKCvM6KChgQrZqV
        8JN/7rMmuTBBxZ8pdUGbTe+jL/P0essyjkmDIvjabUNIrpQoOIEqf9LEp4gxgskc0xjfWE
        8CwNhyjUoIEfJGjdCFoZfhqMU8awQ48=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-658-4s8MDis8MUSHOXTLi5Zogg-1; Mon, 23 Jan 2023 11:08:29 -0500
X-MC-Unique: 4s8MDis8MUSHOXTLi5Zogg-1
Received: by mail-pf1-f198.google.com with SMTP id p51-20020a056a0026f300b0058df209da03so5516513pfw.15
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 08:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6R3r8/AlsaeKPz1wJZCORr5uEw+JBjfz5bMdHi92x8=;
        b=GnxjUS7wt73521+/qaU57BF/Ll0dtQ5k/MGrk6W6MnDwCThDUAP2XnZ2H+Ms0JqyAc
         LMvtWRrdzHGGehDCnoKPcTUUxelCfh/9qE29+ZS+iOZZloCySqVfaiAK7Ue84p8gZNqn
         wTgFmVGZP6mopRtoj19TW3W1tysCCKADjDTIYUItqZrOytmXbOWasondQ4zkTyQr7+Ut
         X9S83Ue+k4VAVetCAfBcLi8GXUbYEQc37TtARYE87zSP01qKOVHXp6WkVTvVKXxZvbUj
         uhE282X++PJyxt/8HcwFDkGG0RDeQcrdLUSbjZa8vQT17LCbkJhxuK0XvPXx/0/ogeLO
         gCFQ==
X-Gm-Message-State: AFqh2krb4P3688QY6u4n9PTJuAG6Kb7khIpXaqw2dtY4ADJwxsi044A/
        3cYAUTx/O4B2oBZYebcSoRBAGh+/R3/5HmMQy/677feOxB03zIlqj8pMQ8D7j/KTWdW6eHkN9K3
        73eWn9aoIi1R3DPPAtqxyk0Ye0rrf+5fTBuvU
X-Received: by 2002:a62:e801:0:b0:58d:aeb6:2d66 with SMTP id c1-20020a62e801000000b0058daeb62d66mr3031405pfi.66.1674490108314;
        Mon, 23 Jan 2023 08:08:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt9p5JFqXrV43bO42ONeLa+N26wCc2F+1fgPqCma8hoVMzaKnzgidyXT+EYsPbULaeTLGu9H+5ZhL9iMnRCm2w=
X-Received: by 2002:a62:e801:0:b0:58d:aeb6:2d66 with SMTP id
 c1-20020a62e801000000b0058daeb62d66mr3031403pfi.66.1674490107994; Mon, 23 Jan
 2023 08:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20221109133306.167037-1-dwysocha@redhat.com> <CC98B38C-2E79-40CE-BD9B-6E336BBD6552@oracle.com>
 <CALF+zO=u2p3BuH1nGt7DMekbRiJZGUuZZRF-D7pGULw5VoMo_A@mail.gmail.com> <2817011C-299D-46B4-A8E2-D5EDA9FE1D08@oracle.com>
In-Reply-To: <2817011C-299D-46B4-A8E2-D5EDA9FE1D08@oracle.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 23 Jan 2023 11:07:51 -0500
Message-ID: <CALF+zOmKL8mDX8HDdVEwijbdHDmeXyKwCC2H2wtE=WrjOYJe3w@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Fix sysfs path for the NFSv4 client identifier
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 23, 2023 at 9:48 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> Hi DW -
>
> > On Jan 23, 2023, at 8:52 AM, David Wysochanski <dwysocha@redhat.com> wrote:
> >
> > On Wed, Nov 9, 2022 at 8:58 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>
> >>
> >>
> >>> On Nov 9, 2022, at 8:33 AM, Dave Wysochanski <dwysocha@redhat.com> wrote:
> >>>
> >>> The sysfs path for the NFS4 client identfier should start with
> >>> the path component of 'nfs' for the kset, and then the 'net'
> >>> path component for the netns object, followed by the
> >>> 'nfs_client' path component for the NFS client kobject,
> >>> and ending with 'identifier' for the netns_client_id
> >>> kobj_attribute.
> >>
> >> Seems like the redundancy has some purpose and is baked-in to
> >> the path. I'd rather leave the sleeping dog as it is, enjoying
> >> the morning sun.
> >>
> >> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> >>
> > Hey Chuck,
> >
> > I just realized the patch is still outstanding.  Now when I re-read
> > your comment, I'm not sure what it means.  Your comment sounds
> > like you feel the patch may not be necessary, but then you have
> > a "Reviewed-by".
>
> I was responding to Ben's suggestion elsewhere that the pathname
> had redundant components and should be simplified. After reviewing
> the code (and your patch) it appears that all the components are
> necessary to have, so the document change you proposed is
> appropriate.
>
Ah ok yes I remember now, thanks for explaining.

>
> > I am not sure if you mean this should be applied or not.
>
> Reviewed-by: means "OK to apply". The documentation is incorrect.
>
Ok.

>
> > To be clear, the existing sysfs path does not exist, and we got a
> > complaint about this documentation inaccuracy, hence my patch.
>
> Can you dig up the complaint bug and suggest a Link: tag to add?
>
It was such a small issue I was not planning to create a separate
bug, but I can do so easily if you would like that.

The comment was a private comment that came later on in this
bug, which you commented on a while back when there was discussion
on how to generate a unique id.
https://bugzilla.redhat.com/show_bug.cgi?id=1801326#c45
The bug was repurposed to documentation only.


>
> >>> Fixes: a28faaddb2be ("Documentation: Add an explanation of NFSv4 client identifiers")
> >>> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> >>> ---
> >>> Documentation/filesystems/nfs/client-identifier.rst | 4 ++--
> >>> 1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/Documentation/filesystems/nfs/client-identifier.rst b/Documentation/filesystems/nfs/client-identifier.rst
> >>> index 5147e15815a1..a94c7a9748d7 100644
> >>> --- a/Documentation/filesystems/nfs/client-identifier.rst
> >>> +++ b/Documentation/filesystems/nfs/client-identifier.rst
> >>> @@ -152,7 +152,7 @@ string:
> >>>      via the kernel command line, or when the "nfs" module is
> >>>      loaded.
> >>>
> >>> -    /sys/fs/nfs/client/net/identifier
> >>> +    /sys/fs/nfs/net/nfs_client/identifier
> >>>      This virtual file, available since Linux 5.3, is local to the
> >>>      network namespace in which it is accessed and so can provide
> >>>      distinction between network namespaces (containers) when the
> >>> @@ -164,7 +164,7 @@ then that uniquifier can be used. For example, a uniquifier might
> >>> be formed at boot using the container's internal identifier:
> >>>
> >>>    sha256sum /etc/machine-id | awk '{print $1}' \\
> >>> -        > /sys/fs/nfs/client/net/identifier
> >>> +        > /sys/fs/nfs/net/nfs_client/identifier
> >>>
> >>> Security considerations
> >>> -----------------------
> >>> --
> >>> 2.31.1
> >>>
> >>
> >> --
> >> Chuck Lever
>
> --
> Chuck Lever
>
>
>

