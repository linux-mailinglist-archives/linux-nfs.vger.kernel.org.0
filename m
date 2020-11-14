Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5BF2B2D58
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Nov 2020 14:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgKNNc7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 Nov 2020 08:32:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgKNNc7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 Nov 2020 08:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605360777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IYKhhQT8Sedpn8Ox/PR9aS+larB5VafOh/F4z8tpD24=;
        b=Dn1gXLHXle++Jp1OgXTV7NYP6QTKo6mH21+2h6n8gmt8fY1bLAS1s8nCTMT3ABNoBDjnIf
        dK8D+NitZ8IXsWjkBveQ5n5AB92OEsOLNXG5fbGy25K+q+zv7VRl8yo9qbqP+XtHARZdmD
        ZJmJY8L0j2Qzla/gJbg6FIpcs/tsAlM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-1aChAAIiMtqogrwrVhvr1A-1; Sat, 14 Nov 2020 08:32:55 -0500
X-MC-Unique: 1aChAAIiMtqogrwrVhvr1A-1
Received: by mail-ej1-f70.google.com with SMTP id o27so5744302eji.12
        for <linux-nfs@vger.kernel.org>; Sat, 14 Nov 2020 05:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IYKhhQT8Sedpn8Ox/PR9aS+larB5VafOh/F4z8tpD24=;
        b=ne7oL8hIjVe1X3r+SnhAI6mchbI/GJsh5vQdwS8ewxpObDGgBpOumQH83N4S9gLu6J
         LYfJlp3IzoJ3nva6DlOPBcwBqtnkBjsb/aRTh3ENs7mEw6Csw5/vToXl9CEERxX6veF1
         2B9Ad3p4ZgpY/5/og0btE/5ZqIi74leL7l3pDu8OrWA4YXVbBhsC4lzg6eVRyEmkGnOP
         PrdLTwPW2NrQuDCXuCwPyRcn2Ou34T3oWxmzHg7n3o2GDipwYryk98Ap2djkL6bkMhF7
         NJ3qvMCA/quA5nbMjxQ4hca02ZDUXHm1vK3wNd23+4UzAFePkdtZFl7VNXIQpv4LEl8H
         81qQ==
X-Gm-Message-State: AOAM532DBLpJZh5LzzDVzPjOkRzWURuTeSbESU97GPDMCXiDdIa9dIz8
        tjEeHsLimCa3b1+ndv7ra925badgRpfzlv7qfJ3U9dF2FYuilBerGTFVFxdDJ5YlxR5+OnCuV+9
        +HCMlG2r+dq2BrtZaI0o4EmGRLXojn/B75N7H
X-Received: by 2002:aa7:cb02:: with SMTP id s2mr7221015edt.211.1605360774264;
        Sat, 14 Nov 2020 05:32:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQEvxH2lHN+Kk+zyinIM8vIpCu85AUwiaqKPt/K32jPSVtHAUG4Adsyq9SD3xHIK3wbezEQEHkS21VP0AQSWc=
X-Received: by 2002:aa7:cb02:: with SMTP id s2mr7221009edt.211.1605360774068;
 Sat, 14 Nov 2020 05:32:54 -0800 (PST)
MIME-Version: 1.0
References: <20201110213741.860745-1-trondmy@kernel.org> <CALF+zOkdXMDZ3TNGSNJQPtxy-ru_4iCYTz3U2uwkPAo3j55FZg@mail.gmail.com>
 <CALF+zO=-Si+CcEJvgzaYAjd2j8APV=4Xwm=FJibhuJRV+zWE5Q@mail.gmail.com>
 <723ef5d47994e34804f5514b06940e96620e2b70.camel@hammerspace.com> <6b07ff95824f5b46237fa07f5f72d8261d764007.camel@hammerspace.com>
In-Reply-To: <6b07ff95824f5b46237fa07f5f72d8261d764007.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Sat, 14 Nov 2020 08:32:18 -0500
Message-ID: <CALF+zOnvne6xyKSTbzkYBcJXfeCKwgc9nmdo4Hzz60dUE-sJog@mail.gmail.com>
Subject: Re: [PATCH v5 00/22] Readdir enhancements
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 12, 2020 at 1:26 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Thu, 2020-11-12 at 16:51 +0000, Trond Myklebust wrote:
> >
> > I was going to ask you if perhaps reverting Scott's commit
> > 07b5ce8ef2d8
> > ("NFS: Make nfs_readdir revalidate less often") might help here?
> > My thinking is that will trigger more cache invalidations when the
> > directory is changing underneath us, and will now trigger uncached
> > readdir in those situations.
> >
> > >
>
> IOW, the suggestion would be to apply something like the following on
> top of the existing readdir patchset:
>
> ---
>  fs/nfs/dir.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 3f70697729d8..384a4663f742 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -956,10 +956,10 @@ static int readdir_search_pagecache(struct
> nfs_readdir_descriptor *desc)
>  {
>         int res;
>
> -       if (nfs_readdir_dont_search_cache(desc))
> -               return -EBADCOOKIE;
> -
>         do {
> +               if (nfs_readdir_dont_search_cache(desc))
> +                       return -EBADCOOKIE;
> +
>                 if (desc->page_index == 0) {
>                         desc->current_index = 0;
>                         desc->prev_index = 0;
> @@ -1082,11 +1082,9 @@ static int nfs_readdir(struct file *file, struct
> dir_context *ctx)
>          * to either find the entry with the appropriate number or
>          * revalidate the cookie.
>          */
> -       if (ctx->pos == 0 || nfs_attribute_cache_expired(inode)) {
> -               res = nfs_revalidate_mapping(inode, file->f_mapping);
> -               if (res < 0)
> -                       goto out;
> -       }
> +       res = nfs_revalidate_mapping(inode, file->f_mapping);
> +       if (res < 0)
> +               goto out;
>
>         res = -ENOMEM;
>         desc = kzalloc(sizeof(*desc), GFP_KERNEL);
>
>

If you want to pursue this let me know and I will run through some
tests with this patch (or some other patch) and all NFS versions.
I've mostly been testing with NFSv4 because that has been the
problematic case, but this would affect NFSv3 too.

I too had been looking at 07b5ce8ef2d8 because it causes NFSv3 to
behave differently than NFSv4 (I saw with NFSv3,
nfs_attribute_cache_expired() was always false while a directory is
being listed).  I pondered whether this was the right direction for
NFSv4 as well since that causes us to avoid dropping the pagecache and
kinda "neuters" it for a period of time while a large directory
listing was in progress.  However I didn't see a way to achieve the
NFSv3 behavior for NFSv4 and I wasn't convinced NFSv3 behavior was
necessarily the best approach.

