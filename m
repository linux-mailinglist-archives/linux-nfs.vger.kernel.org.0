Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91ABB349AA8
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Mar 2021 20:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhCYTtV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Mar 2021 15:49:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40496 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229977AbhCYTtM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Mar 2021 15:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616701751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f8zZVKi1yrh4NuyLIYg+GmnYrUBERKXZbiBJx18CiA8=;
        b=AAB6jYAQFNvcTdz9EeAOXg0UN+IueZR6NWOM8b7gfYG7R/DGbv1Qi4tLj4kmg0lOBJX2su
        FXGGW6QlO1UHqUJbX2YPy46CE1IEmFYon2IFlNILDZk4CxGjSNyjXbI8+u4eAHfN27zwEW
        avabeP28Dg2BJ1DK8g7m+1GMJroJ0Vc=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-_1DzIDIeNwicyi_Iyz1rwQ-1; Thu, 25 Mar 2021 15:49:08 -0400
X-MC-Unique: _1DzIDIeNwicyi_Iyz1rwQ-1
Received: by mail-yb1-f199.google.com with SMTP id v124so7245114ybc.15
        for <linux-nfs@vger.kernel.org>; Thu, 25 Mar 2021 12:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f8zZVKi1yrh4NuyLIYg+GmnYrUBERKXZbiBJx18CiA8=;
        b=PclhTSPaL5V0qCprJNbYmmSXph7NulTCuhJvSI2RHakRuI4V7J6ocHmQh4V1Py+H6E
         7d2Wf+RJHDiQlD5LLuf2xIgMv3QRaMleNKmpZ/egc6t8V3oDsR+zDuzk0x++S9eYZHes
         l94yBvLraTc/zph3Av9ucMmLFUAqdzg/toUbuZ7Xn6fnJouhQmoqsLy/MEEwnap43VoN
         me0vBrd3GFWiAsUX9yw3sGyYW0kaFsvHFLFJXM0JYxJ9R1DoJjrGvBokwqACxFWJwH7o
         RpbjXs7hw+XqoNiqOzO7Dt67PPhKFxrINRiaAVCVXSz/fehBMRL7VbG9S6LZoBn+syin
         VBpw==
X-Gm-Message-State: AOAM532Ep0yQJRDZR7lXqrjWRHP3sqEIbNEZ+IxJTxOJm5lD+phecnzx
        eX6nZRRwpMESHsZN/SqYCMtOh7gwY9S2NjX3Q2BYL05I+sqpij2EzaFSeYr4l+HOxm0SK/mVZuA
        +8hCRs7MQwizoggaMXdppNZEcMmBopkos6IOx
X-Received: by 2002:a5b:d43:: with SMTP id f3mr14340197ybr.81.1616701748399;
        Thu, 25 Mar 2021 12:49:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfjRIRoczvaDXScXrMQQmZR3WJOgF5g1v17TfmXDV0dNfB3dfsP/S7UEgUXpHd3oNYQmLbo0Ze0KNzBhVVmSM=
X-Received: by 2002:a5b:d43:: with SMTP id f3mr14340177ybr.81.1616701748209;
 Thu, 25 Mar 2021 12:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210322210238.96915-1-omosnace@redhat.com> <20210325191903.GA18351@fieldses.org>
In-Reply-To: <20210325191903.GA18351@fieldses.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 25 Mar 2021 20:48:57 +0100
Message-ID: <CAFqZXNsg7XTEbzxEz+7oO9DLFTu=6-LzwXJpOdTZTzj5Td_2Ng@mail.gmail.com>
Subject: Re: [PATCH] exportfs: fix unexporting of '/'
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Steve Dickson <steved@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 25, 2021 at 8:27 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> On Mon, Mar 22, 2021 at 10:02:38PM +0100, Ondrej Mosnacek wrote:
> > The code that has been added to strip trailing slashes from path in
> > unexportfs_parsed() forgot to account for the case of the root
> > directory, which is simply '/'. In that case it accesses path[-1] and
> > reduces the path to an empty string, which then fails to match any
> > export.
> >
> > Fix it by stopping the stripping when the path is just a single
> > character - it doesn't matter if it's a '/' or not, we want to keep it
> > either way in that case.
>
> Makes sense to me.
>
> (Note nfs-exporting / is often a bad idea.  I assume you had some good
> reason in this case.)

I hit it in a test, so if the only issue is that it exposes more than
necessary, then I guess it's fine in this case :)

>
> --b.
>
> >
> > Reproducer:
> >
> >     exportfs localhost:/
> >     exportfs -u localhost:/
> >
> > Without this patch, the unexport step fails with "exportfs: Could not
> > find 'localhost:/' to unexport."
> >
> > Fixes: a9a7728d8743 ("exportfs: Deal with path's trailing "/" in unexportfs_parsed()")
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=1941171
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  utils/exportfs/exportfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> > index 262dd19a..1aedd3d6 100644
> > --- a/utils/exportfs/exportfs.c
> > +++ b/utils/exportfs/exportfs.c
> > @@ -383,7 +383,7 @@ unexportfs_parsed(char *hname, char *path, int verbose)
> >        * so need to deal with it.
> >       */
> >       size_t nlen = strlen(path);
> > -     while (path[nlen - 1] == '/')
> > +     while (nlen > 1 && path[nlen - 1] == '/')
> >               nlen--;
> >
> >       for (exp = exportlist[htype].p_head; exp; exp = exp->m_next) {
> > --
> > 2.30.2
>


--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

