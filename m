Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9480AB1679
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2019 00:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfILWw3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Sep 2019 18:52:29 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36840 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfILWw3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Sep 2019 18:52:29 -0400
Received: by mail-vs1-f68.google.com with SMTP id v19so12221240vsv.3
        for <linux-nfs@vger.kernel.org>; Thu, 12 Sep 2019 15:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1YOc2hJgslHYNZK7zfdp0ccTAc/bK4UwGRmkdUEbUe8=;
        b=SPtZfbLdf/V+erG0AtW9e9YHtgUKiClWUMpDjJO04oXTOFM5AzwbvEnPnzQ3vzU2zW
         o7DDdvGM7dBzJy9ZCzHsnczQKMhPOgtpoc8j+40Wsq/qaGuxbX77UnjDmRDr2Tksyjbm
         fsIGFQMoPLAsGIEBOs4ePfGLMh86FCmWGELYqAkKDKZh79Ws3Dz9LjjyIwxKUhV6X30R
         /oU9K4V77WcJ70dVYkO657nfopBgwKm2+6xIX3KNi0zaL/S1PSJ5+erK4jj9W+zDeOs2
         vuulXG2SIdN664GnEqFFaGpC5v0XBwib3vYkzVCiOJ5fKCt0CQlZVdExWL4xqn61cUz0
         F1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1YOc2hJgslHYNZK7zfdp0ccTAc/bK4UwGRmkdUEbUe8=;
        b=lt2mxgox2l0gsb/K7U7PYWLtzEpy49a7Afj4k2dW9y6IUirQIwrWh5oLudHFr1NUf3
         SbTdfBk/5nvb6jVbfzGasjh2bsNhHl5ugE/ofa4aWSJaWqE7gIdLndGkDXI1i6MQDfYZ
         AkUFPYZLssdxUy9ZFlqe55yJ2paXsbDYE2XzJnjuqHJ1dU1/hr1van+I7yDEiyn5tCJ0
         +i0bu7Os+dp4V/TbmvAci4GGsnSRsD4Lc2+86tbnpNpYcIJSzCoS7scT1p/3HATnrxei
         I2/B3NXCi9Ktqqnr+qUDGYGpWv7HH4lU7ZchyVF5QtAgHS4IRHTjjV4g1z6WTO/8rAH+
         Wbig==
X-Gm-Message-State: APjAAAVfcEMMzYyeFDJG5XTjP8I+LczCXqSo28AgI9JdsOVfq3gLFS2c
        dAhkKlGzW1Xxvu3XWfC8xf7r6boSXPHqwhgZOhw=
X-Google-Smtp-Source: APXvYqwLw+62gklwaWuncUq4jVXFi9BUM8uX/3Fym0LCJ4cJrLlHUYbJWCqcEj6nBFbIFerd7KCtn/V4rbg3mYFhUtY=
X-Received: by 2002:a67:f1d3:: with SMTP id v19mr6238217vsm.194.1568328748454;
 Thu, 12 Sep 2019 15:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
 <20190906194631.3216-6-olga.kornievskaia@gmail.com> <20190912202352.GB5054@fieldses.org>
In-Reply-To: <20190912202352.GB5054@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 12 Sep 2019 18:51:58 -0400
Message-ID: <CAN-5tyFsXNWxBi3m=32hiOLakjdV_w1tk15i6k_DrSqbLk5Kig@mail.gmail.com>
Subject: Re: [PATCH v6 05/19] NFS: inter ssc open
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 12, 2019 at 4:23 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Fri, Sep 06, 2019 at 03:46:17PM -0400, Olga Kornievskaia wrote:
> > +static int read_name_gen = 1;
> > +#define SSC_READ_NAME_BODY "ssc_read_%d"
> > +
> ...
> > +     res = ERR_PTR(-ENOMEM);
> > +     len = strlen(SSC_READ_NAME_BODY) + 16;
> > +     read_name = kzalloc(len, GFP_NOFS);
> > +     if (read_name == NULL)
> > +             goto out;
> > +     snprintf(read_name, len, SSC_READ_NAME_BODY, read_name_gen++);
> ...
> > +     filep = alloc_file_pseudo(r_ino, ss_mnt, read_name, FMODE_READ,
> > +                                  r_ino->i_fop);
>
> So, I"m curious: does this "name" ever get used anywhere?  Can you see
> it from userspace somehow, for example?  Does it have some debugging
> value?  Or could it just be the empty string?

Name isn't seen anywhere (nor is the mount visible to the use -- ie
doing a mount command). It's needed to create a file structure to
represent the file opened the source server (without the open).
Honestly, I'm not sure what kind of weirdness can arise from having an
empty name string. Is there a reason for not trying to generate unique
names for this?

>
> --b.
