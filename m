Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C34677D19
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jan 2023 14:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjAWNx4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Jan 2023 08:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjAWNx4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Jan 2023 08:53:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341D5125B2
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 05:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674481994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=91w3qtHMG1rHHKb+/xTu5k1yGzMQ+ZsGNG+KMNhcyio=;
        b=Vk+TYCMFqUr2T5Y4JVSitReBn6QLfuLp4vTVEVpPJfmtv8pke2YaregBHH6mv1/OVIGH9v
        VXgBlg9WExkS8FH/GpmlO+xqRORnNpsGtLi7NfVeXuyLDXbB/j8XHPA0YpJSrMHLnWEo7x
        4tMV+iF3dmze65OOlNd2AeNRqvMMhwo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-636-CHIk5UyzPTmU0GtjYE4D6w-1; Mon, 23 Jan 2023 08:53:13 -0500
X-MC-Unique: CHIk5UyzPTmU0GtjYE4D6w-1
Received: by mail-pg1-f197.google.com with SMTP id 69-20020a630148000000b00478118684c4so5501259pgb.20
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 05:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91w3qtHMG1rHHKb+/xTu5k1yGzMQ+ZsGNG+KMNhcyio=;
        b=oE/3eKZ7t1b4A8ISZTJ8g98RQKzaole4Iv2hCnikDnnY8a6Jz2INThfzb14aKJb8Hz
         /m3SFOKRvr7DlJeRI3O9honOV14buCdbA/4nX7D6bAyf8TqGbXDanQu5lQSlSvZvI+9/
         O152onzRDW9P4NpSsWVQf8QrSI+cwdHNJIPOaTjMoNtW1R8CVvUK6KxoqacvGqIFAAWT
         GsyH0AFWcDAj0whK8OTBVroUMMjxKdo1FfZgujgGSksxYicPTUbtzPyTdICEooiLGGWE
         jb+OVNRihqpHT1kB0fD8X///hWAgo0UWwxqkFdjCvTl819NxIKd02AKoGkxB94qGAkuX
         O9iA==
X-Gm-Message-State: AFqh2kqIrW1dHnc+Or1SmpEHoPPW8jIUpEWCyW2gNer4dKFep5rztRsi
        NVApraLxiaEdZG+WEYXmacFGaw+lyZHxXHeX19bizAM216HHlbsEyHk4Mkg0+vpVA1BXQcAPexB
        xgMGeFPAK9Yj9nfahxHTSskUMQDMx/CTRyRzG
X-Received: by 2002:a63:4e51:0:b0:4d1:851b:7bad with SMTP id o17-20020a634e51000000b004d1851b7badmr1775271pgl.203.1674481991422;
        Mon, 23 Jan 2023 05:53:11 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsGWHXDOkoQRdl6aZ3ufXQ9Hq9G1SC54n3oAXQIzGRCIOctocB41Zd4V0RcEsJVj9qagzgrK3vEGKehs3aQ2xQ=
X-Received: by 2002:a63:4e51:0:b0:4d1:851b:7bad with SMTP id
 o17-20020a634e51000000b004d1851b7badmr1775266pgl.203.1674481991148; Mon, 23
 Jan 2023 05:53:11 -0800 (PST)
MIME-Version: 1.0
References: <20221109133306.167037-1-dwysocha@redhat.com> <CC98B38C-2E79-40CE-BD9B-6E336BBD6552@oracle.com>
In-Reply-To: <CC98B38C-2E79-40CE-BD9B-6E336BBD6552@oracle.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 23 Jan 2023 08:52:34 -0500
Message-ID: <CALF+zO=u2p3BuH1nGt7DMekbRiJZGUuZZRF-D7pGULw5VoMo_A@mail.gmail.com>
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

On Wed, Nov 9, 2022 at 8:58 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Nov 9, 2022, at 8:33 AM, Dave Wysochanski <dwysocha@redhat.com> wrote:
> >
> > The sysfs path for the NFS4 client identfier should start with
> > the path component of 'nfs' for the kset, and then the 'net'
> > path component for the netns object, followed by the
> > 'nfs_client' path component for the NFS client kobject,
> > and ending with 'identifier' for the netns_client_id
> > kobj_attribute.
>
> Seems like the redundancy has some purpose and is baked-in to
> the path. I'd rather leave the sleeping dog as it is, enjoying
> the morning sun.
>
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
>
Hey Chuck,

I just realized the patch is still outstanding.  Now when I re-read
your comment, I'm not sure what it means.  Your comment sounds
like you feel the patch may not be necessary, but then you have
a "Reviewed-by". I am not sure if you mean this should be applied or not.

To be clear, the existing sysfs path does not exist, and we got a
complaint about this documentation inaccuracy, hence my patch.


>
> > Fixes: a28faaddb2be ("Documentation: Add an explanation of NFSv4 client identifiers")
> > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > ---
> > Documentation/filesystems/nfs/client-identifier.rst | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/filesystems/nfs/client-identifier.rst b/Documentation/filesystems/nfs/client-identifier.rst
> > index 5147e15815a1..a94c7a9748d7 100644
> > --- a/Documentation/filesystems/nfs/client-identifier.rst
> > +++ b/Documentation/filesystems/nfs/client-identifier.rst
> > @@ -152,7 +152,7 @@ string:
> >       via the kernel command line, or when the "nfs" module is
> >       loaded.
> >
> > -    /sys/fs/nfs/client/net/identifier
> > +    /sys/fs/nfs/net/nfs_client/identifier
> >       This virtual file, available since Linux 5.3, is local to the
> >       network namespace in which it is accessed and so can provide
> >       distinction between network namespaces (containers) when the
> > @@ -164,7 +164,7 @@ then that uniquifier can be used. For example, a uniquifier might
> > be formed at boot using the container's internal identifier:
> >
> >     sha256sum /etc/machine-id | awk '{print $1}' \\
> > -        > /sys/fs/nfs/client/net/identifier
> > +        > /sys/fs/nfs/net/nfs_client/identifier
> >
> > Security considerations
> > -----------------------
> > --
> > 2.31.1
> >
>
> --
> Chuck Lever
>
>
>

