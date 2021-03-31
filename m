Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3A7350844
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 22:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbhCaUfW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 16:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbhCaUfI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Mar 2021 16:35:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A7FC061574
        for <linux-nfs@vger.kernel.org>; Wed, 31 Mar 2021 13:35:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id kt15so31984786ejb.12
        for <linux-nfs@vger.kernel.org>; Wed, 31 Mar 2021 13:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cLgVCN874/goqJzqDdFAh/n5hKJJpo3VZokiGocwErg=;
        b=DczBFBwqK1iky7RwyX7ayw15T1sbvD16gHoMxkpgMP186brXijI7TLPiQVdvqmIojc
         RCXMIEymYUHiulfEukyUZidJq+qq1zNclsbp++UWV1jusexkyf2QIBHo422yqZpMJJax
         YqwU2yuLv1qPGHt01zYf6q3QFHHoyt7z4ekPPU9zmqxreUrsSRMfUVJV8KAJmGizo8i3
         G1ouzGUu3rj0C15AUtgXzpKR9cBNlZmhDuf1JC/usrzGjLdHKROQc/m4iQo/PK3ZAIRe
         LeN6IkLoS4BPNZwf0IY98+QnGVQ1eUTNUQblA7sa+xk6yhsOyjOy5bpYOYX/kwfKjtKk
         aMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLgVCN874/goqJzqDdFAh/n5hKJJpo3VZokiGocwErg=;
        b=XZDkYsHS7zpStXTSXdLotH7xIDKk2QEY6RAPT7xbPfqWFMrVsHfxRHPYeKczUeClVz
         ivZmuIrgQQ45EpksC23NNJQQnVes5O6tClw3GFHWuMC+kdMXLxCmRrc8mysFNL+VlGYE
         DyjB4jyac5dIO8ceSXj4fpwztTMVgG1YDLWc9jnRufVNw2QYjyu2yYunIsx3+y1lJuzg
         RTYfylS0cOO/+FOfnpt7e0PWeu2thJbcF9eZ9yT+G4ow6jAvAYKVV9M3cc0rKmQJP090
         m0uXbFFDSGV4B4vo7nqP7TC9mzkefrNguz3jNMgSsrvMnNd8tE9FaHrAxZ9G/ANWPcH/
         RZYg==
X-Gm-Message-State: AOAM531yc/985/oPLOnsUUxtPLB1X2qOKXh2U8H7u5TfPaFczx83JMsk
        XRTYQlV/OQRnfMoTRH2oY4bKqwrVhCKbxB3B9mY=
X-Google-Smtp-Source: ABdhPJz9/6l01dx9na8N+dg2uxzLpPKGAM6PMSALsGmqPBobacOgyYgTnLrXgopzXpXNiUhsVhu5BlixGtu0lqnp0RU=
X-Received: by 2002:a17:906:a0d4:: with SMTP id bh20mr5604306ejb.348.1617222906607;
 Wed, 31 Mar 2021 13:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210331193025.25724-1-olga.kornievskaia@gmail.com> <0ca40f087491acec8f26816b43b6d64bb624c35e.camel@hammerspace.com>
In-Reply-To: <0ca40f087491acec8f26816b43b6d64bb624c35e.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 31 Mar 2021 16:34:55 -0400
Message-ID: <CAN-5tyHQyHO8K7UjwhKhN9Xoz1nSXMB2cv8De=w9Rx-qphaHgg@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.2 fix handling of sr_eof in SEEK's reply
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 31, 2021 at 3:42 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Wed, 2021-03-31 at 15:30 -0400, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Currently the client ignores the value of the sr_eof of the SEEK
> > operation. According to the spec, if the server didn't find the
> > requested extent and reached the end of the file, the server
> > would return sr_eof=true. In case the request for DATA and no
> > data was found (ie in the middle of the hole), then the lseek
> > expects that ENXIO would be returned.
> >
> > Fixes: 1c6dcbe5ceff8 ("NFS: Implement SEEK")
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfs/nfs42proc.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > index 094024b0aca1..d359e712c11d 100644
> > --- a/fs/nfs/nfs42proc.c
> > +++ b/fs/nfs/nfs42proc.c
> > @@ -659,7 +659,10 @@ static loff_t _nfs42_proc_llseek(struct file
> > *filep,
> >         if (status)
> >                 return status;
> >
> > -       return vfs_setpos(filep, res.sr_offset, inode->i_sb-
> > >s_maxbytes);
> > +       if (whence == SEEK_DATA && res.sr_eof)
> > +               return -NFS4ERR_NXIO;
> > +       else
> > +               return vfs_setpos(filep, res.sr_offset, inode->i_sb-
> > >s_maxbytes);
> >  }
> >
> >  loff_t nfs42_proc_llseek(struct file *filep, loff_t offset, int
> > whence)
>
> Don't we also need to deal with SEEK_HOLE with the offset being greater
> than the end-of-file in the same way?

We do not because if there is no hole extent after the requested
offset, then there is an implied hole which is at the end of the file.
So if sr_eof is true we still need to pay attention to the returned
offset (ie it should be end of the file) and it's not an error
condition.

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
