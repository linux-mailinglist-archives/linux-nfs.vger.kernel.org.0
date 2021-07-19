Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61ED83CE728
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jul 2021 19:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345888AbhGSQXf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jul 2021 12:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36841 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350732AbhGSQUp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Jul 2021 12:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626714083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWbiNwfa1F4M71nSKUEZf49QjTSkIDZ9be9aaf79teg=;
        b=GQfvgHCQ2fokpn6kyDjR327s2yKW+Yib1UTQkmLJXn4fHTLwWrF2rmXEc0/Y37miQR7gym
        SqRXdd+LOOtDHCMimdLSxXzLjMMdNczPIoQ+Yd1eCB2uM2ujC3sQdcjlB6u8GGOIs6WPWn
        cgwGcoKxLJjefvlh++u/LMR+yTK0v3Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-nOfvkCavMFuiFOMIAGYdKw-1; Mon, 19 Jul 2021 13:01:21 -0400
X-MC-Unique: nOfvkCavMFuiFOMIAGYdKw-1
Received: by mail-ej1-f69.google.com with SMTP id y3-20020a17090614c3b0290551ea218ea2so1185025ejc.5
        for <linux-nfs@vger.kernel.org>; Mon, 19 Jul 2021 10:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CWbiNwfa1F4M71nSKUEZf49QjTSkIDZ9be9aaf79teg=;
        b=L/z9q4QLXrVIB2iH0xgZyzbV9NpS1QQLix80LUvfjZ0cDC0m9Tl6t/2dg1/OeEd6h6
         hrg8CrkHlXPFVtTU3SXBtGyYa8AC8u+/DoVhnSZJC2iXw09yZT9YzKs/k3r7HNMpbtJ3
         O1H8b2FyhYdZjTqDCrMekwbhrFUGHfx7a8bGF0cOVjeBctQ+ZBV4NqRVi3X1MSit/cD3
         U1Mue8ABMnUoYT9WXtvqq3WqQ/18TiSSRTrDraHrxgcj8VornOD1DGEKZI6uOZP4arT6
         QPUUa1okz3YHM8ID4pUdigIoNcdOo2hU/e/lRvFJDhWZ4SSc7OQR0CgLs4jq9suRmlkJ
         WynQ==
X-Gm-Message-State: AOAM530WE7eejtOgCmg3F54T0TOQCJvGTf5WuvPmv9ogPxwsAYajuK3J
        aaLDJaFC+mG4JpbvkDuN29vXduMuIdYLH2nxUdmB6Pl58tI/VQAcJcjwxtdRRKIyOPjdAfM0IIY
        82DIYoZ2n4Xl1e2yQ/5C7BC5ezhkgpAPgVHon
X-Received: by 2002:a17:906:2413:: with SMTP id z19mr27633090eja.215.1626714080625;
        Mon, 19 Jul 2021 10:01:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJ4qFd7qmcjGBdC/DTR2GfnxHlp+kQu35t2kFc/HlYOj7cdBfkHP4CuK8mP/B6dq6wjHnMoL67m0b6v+R4FWk=
X-Received: by 2002:a17:906:2413:: with SMTP id z19mr27633061eja.215.1626714080342;
 Mon, 19 Jul 2021 10:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210719100343.20545-1-jiyin@redhat.com>
In-Reply-To: <20210719100343.20545-1-jiyin@redhat.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 19 Jul 2021 13:00:44 -0400
Message-ID: <CALF+zOnyCpGSfQgOe35fcYqE872K1B-zC6-gn4PDoi5G3kDzpw@mail.gmail.com>
Subject: Re: [PATCH] mount.nfs: move 'sloppy' option to beginning of the options
To:     Jianhong Yin <jiyin@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        "Dickson, Steve" <steved@redhat.com>,
        Jianhong Yin <yin-jianhong@163.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 19, 2021 at 6:03 AM Jianhong Yin <jiyin@redhat.com> wrote:
>
> mount.nfs -o quota,sloppy still get regression fail, fix it
> and add sloppy item in nfs(5)
>
> Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
> ---
> test log:
> '''
> [root@rhel-85-latest nfs-utils]# ./utils/mount/mount.nfs -oquota,sloppy localhost:/export /mnt/nfsmp  -v
> mount.nfs: timeout set for Mon Jul 19 05:53:37 2021
> mount.nfs: trying text-based options 'sloppy,vers=4.2,addr=::1,clientaddr=::1'
> localhost:/export on /mnt/nfsmp type nfs (quota,sloppy)
>
> [root@rhel-85-latest nfs-utils]# umount /mnt/nfsmp/
> [root@rhel-85-latest nfs-utils]# ./utils/mount/mount.nfs -oquota -s localhost:/export /mnt/nfsmp  -v
> mount.nfs: timeout set for Mon Jul 19 05:54:05 2021
> mount.nfs: trying text-based options 'sloppy,vers=4.2,addr=::1,clientaddr=::1'
> localhost:/export on /mnt/nfsmp type nfs (quota)
>
> [root@rhel-85-latest nfs-utils]# ./utils/mount/mount.nfs -osloppy,quota,sloppy localhost:/export /mnt/nfsmp  -v  -s
> mount.nfs: timeout set for Mon Jul 19 05:57:21 2021
> mount.nfs: trying text-based options 'sloppy,vers=4.2,addr=::1,clientaddr=::1'
> localhost:/export on /mnt/nfsmp type nfs (sloppy,quota,sloppy)
> '''
>
>  utils/mount/mount.c | 4 ++++
>  utils/mount/nfs.man | 7 +++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/utils/mount/mount.c b/utils/mount/mount.c
> index b98f9e00..dbe9edf6 100644
> --- a/utils/mount/mount.c
> +++ b/utils/mount/mount.c
> @@ -344,6 +344,10 @@ static void parse_opts(const char *options, int *flags, char **extra_opts)
>
>                         /* end of option item or last item */
>                         if (*p == '\0' || *(p + 1) == '\0') {
> +                               if (strcmp(opt, "sloppy") == 0) {
> +                                       ++sloppy;
> +                                       continue;
> +                               }
>                                 parse_opt(opt, flags, *extra_opts, len);
>                                 opt = NULL;
>                         }
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index f98cb47d..f1b76936 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -555,6 +555,13 @@ using the FS-Cache facility. See cachefilesd(8)
>  and <kernel_source>/Documentation/filesystems/caching
>  for detail on how to configure the FS-Cache facility.
>  Default value is nofsc.
> +.TP 1.5i
> +.B sloppy
> +The
> +.B sloppy
> +option is an alternative to specifying
> +.BR mount.nfs " -s " option.
> +
>  .SS "Options for NFS versions 2 and 3 only"
>  Use these options, along with the options in the above subsection,
>  for NFS versions 2 and 3 only.
> --
> 2.18.1
>

LGTM

Did this test to verify:
# for o in blah,vers=4.1,sec=sys,sloppy blah,vers=4.1,sloppy,sec=sys
sloppy,blah,vers=4.1,sec=sys vers=4.1,blah,sec=sys,sloppy
vers=4.1,blah,sloppy,sec=sys vers=4.1,sloppy,blah,sec=sys
sloppy,vers=4.1,blah,sec=sys sloppy,vers=4.1,sec=sys,blah; do
./utils/mount/mount.nfs -o $o 127.0.0.1:/exports /mnt/test; if [ $?
-ne 0 ]; then echo ERROR: on options $o; break; fi; umount /mnt/test;
done; echo SUCCESS on kernel $(uname -r) nfs-utils at $(git log
--oneline | head -1)
SUCCESS on kernel 5.12.15-300.fc34.x86_64 nfs-utils at f840d4c878f0
mount.nfs: move 'sloppy' option to beginning of the options


Reviewed-and-tested-by: Dave Wysochanski <dwysocha@redhat.com>

