Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF983DDBCA
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Aug 2021 17:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbhHBPDW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Aug 2021 11:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbhHBPDV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Aug 2021 11:03:21 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF38C06175F;
        Mon,  2 Aug 2021 08:03:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id nd39so31397798ejc.5;
        Mon, 02 Aug 2021 08:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4DHQv7pzjJWl9xFWDVMxvTq6zafn6EuHboXBTbyhH4=;
        b=ovlFZkDo+nnUX/oiH115DeSThUdK0QW9V4he8r5XUV4LsGTePJ9X02B6wBTC2cLas5
         LJeL4dh0t9q7imBkaQHZswTc6kyia1gOvW7sldh7Tn/5vSyque/70GtY0BJePVqwOarh
         D0+AceHSQr7sijRxLqy2ou9Sxyt1I1rPo7RjS/F2otw2xpd89DykMWAh1nj3jGS+9wZT
         Aluph98PE6CqN2d9CICRj+WSrYhzg752ndg3UG1tkIRwZaDs9l5CMJvVX3mig1R1Jw54
         ubCNVC41Guntoi1z/YfWJwW1N2q/nULQMRKDKldjQoZG8rsMRHrvjFdHXhWWSAvgHk1n
         on/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4DHQv7pzjJWl9xFWDVMxvTq6zafn6EuHboXBTbyhH4=;
        b=PwgOddFav6O9zCUArZ6cd4UD+k9ALCjtZC36eaQ54gv9F9/z9sbh7M7e1XfOkT2J+F
         l28jXx9eXccuihbBtiRSn5YlzAwIU54cHC+6lvYWq53b1lQXqFlC+S8jeCxfSXIEElpZ
         H3MPzcFcC9sNd/pYvPTlvUyPqNVfkJBL6SwN0M6lQkmATBhCqBt4Idm6ufEnV+inYo0t
         d+Xk4QDCa+V2BDH/zyuWnWIrwrqGO/c8e7mCfg8RTv8NNqzl0WoekTY+XoVd/viuNG6h
         Jx2odl2v6KGOrYyYF1cNwoLEO6TOiplZCWmTWLuwUcAPPuMLLHzGW22ZmT1POxHXP1p5
         jvGA==
X-Gm-Message-State: AOAM533L/5wZv2dW3HqysUYly47tK4DT/nvi0SK/JKS+7cnUu/bERuit
        uF2GJjhfQJ4oRspjrlzc3LpCoI2Uly/QqYMG7Fw=
X-Google-Smtp-Source: ABdhPJwVlWeOt3pNa/h6Iz3yRjpSN+AqwZhVaut4jXE2ugSVmTIuRm6YaUekYIQ/DIWb1/c9AyZJqxRXw/C/JpNe58E=
X-Received: by 2002:a17:907:b04:: with SMTP id h4mr15867079ejl.460.1627916590330;
 Mon, 02 Aug 2021 08:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210729044758.63219-1-jefflexu@linux.alibaba.com> <YQZ6g6ZszcMzVlt4@desktop>
In-Reply-To: <YQZ6g6ZszcMzVlt4@desktop>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Mon, 2 Aug 2021 11:02:54 -0400
Message-ID: <CAFX2JfkOcdGMbtT2BddJnGQ33cpzX+9Dunz35N5Lmb5Pmv1AXA@mail.gmail.com>
Subject: Re: [PATCH] common/rc: only force nfs4.2 non-default SEEK_HOLE behaviour
To:     Eryu Guan <guan@eryu.me>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>, fstests@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Eryu,

On Sun, Aug 1, 2021 at 6:43 AM Eryu Guan <guan@eryu.me> wrote:
>
> [cc nfs list]
>
> On Thu, Jul 29, 2021 at 12:47:58PM +0800, Jeffle Xu wrote:
> > Only NFSv4.2 supports non-defautl SEEK_HOLE behaviour. Thus default
> > SEEK_HOLE behaviour shall be allowed for NFSv4.0/4.1, or it will fail
> > generic/285, generic/448, generic/490 on NFSv4.0/4.1, complaining they
> > should support non-default SEEK_HOLE behaviour.
> >
> > The *.full log is like:
> >       File system supports the default behavior.
> >       Default behavior is not allowed. Aborting.
> >
> > Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>
> Looks correct to me, but I'd like nfs folks to take a look as well, to
> conform if only nfsv4.2 supports SEEK_DATA/SEEK_HOLE non-default
> behavior.

This is correct, non-default SEEK_DATA/SEEK_HOLE is only supported by NFS v4.2.

Thanks for checking!
Anna
>
> Thanks,
> Eryu
>
> P.S.
> Please cc the corresponding filesystem list next time if patch affects
> the specific fs.
>
> > ---
> >  common/rc | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/common/rc b/common/rc
> > index 25a838a3..9be6f89d 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -2495,10 +2495,10 @@ _fstyp_has_non_default_seek_data_hole()
> >               return 0
> >               ;;
> >       nfs*)
> > -             # NFSv2 and NFSv3 only support default behavior of SEEK_HOLE,
> > -             # while NFSv4 supports non-default behavior
> > -             local nfsvers=`_df_device $TEST_DEV | $AWK_PROG '{ print $2 }'`
> > -             [ "$nfsvers" = "nfs4" ]
> > +             # NFSv2, NFSv3, and NFSv4.0/4.1 only support default behavior of SEEK_HOLE,
> > +             # while NFSv4.2 supports non-default behavior
> > +             local nfsvers=`_mount() | grep $TEST_DEV | sed -n 's/^.*vers=\([0-9.]*\).*$/\1/p'`
> > +             [ "$nfsvers" = "4.2" ]
> >               return $?
> >               ;;
> >       overlay)
> > --
> > 2.27.0
