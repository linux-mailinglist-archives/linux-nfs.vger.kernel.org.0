Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5616D2D3504
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Dec 2020 22:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgLHVM1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Dec 2020 16:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgLHVM0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Dec 2020 16:12:26 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846B8C0613D6
        for <linux-nfs@vger.kernel.org>; Tue,  8 Dec 2020 13:11:46 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id cw27so19072717edb.5
        for <linux-nfs@vger.kernel.org>; Tue, 08 Dec 2020 13:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5WJqBMFahvlf5K6VZvTYKcVyBiHvDwWsqDLYTKYhJbw=;
        b=RwbbgIDYZ8Dyc//xOQLeYUhJKSjrcvg/o5Wd1uj2D3GefxBT+H+gWFoHHhb06pFjzl
         xQaSFsHzDEnjypQhueHumpfkIZcukNN4N9kWSoUvgjNIgBVd2kn1JfJhtr+vdfXS7CJq
         0d/QQ2S6azdBglrORWDkUHJhCrVXHYvqncmVDJEUDeADLU9GnK98mUeFVSPAZPcsdFBf
         mVYmoEPMlhaLFi1x7M5COQ3sTIHbLsvPOEzuwmqqEqPkXwt/G+fYYKkyTWJock/R+Uss
         cxgzcEEv1cqUqEIoi+rRbP0oUigCMZ5BmP1ztvhYyohj0PQDPmFgE5me0owy+jXqPm5i
         k2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5WJqBMFahvlf5K6VZvTYKcVyBiHvDwWsqDLYTKYhJbw=;
        b=sdFb/jZ7ANiqti7ZynayehKc2AiUr+pYn0Le4fNJEb0YbXvCOjKDaQckWEAU3n3ASt
         n1AvTvIrQcyMvI0gfk3xFlYFXU2RRVyCgrPznpUhdnTcTf9XQxBDE4n7paaxy4RE98v4
         f3JYzoyv4gaHRqEI3RXPBJ+MKny5IZIURHJZnJ8cfH1NHGRhyRYexqyD3JfUPFo4v9Qf
         VvrhuDpE0j2j3mYFHU2NDqPgzMMOkxxxtUXIW69e5mLH7FwPvtzcgYYbjEPWYvPhWZ9g
         dCmDyWLt9kLs8fVCBB/6ogsGndnJe//R0ryYxZG9930EQGITNYshEK6aseok0s+FRbe9
         Wndg==
X-Gm-Message-State: AOAM532pWJ4rIIw0qH8i4wmJLuBEkdMSblHfOEhObsTV23Rn4xBIBSYo
        m3m/RjyeQjf7/yJn+WhTOY/V4VxzZM18GxoQ4tQ=
X-Google-Smtp-Source: ABdhPJzNPa0WVop8/FtVc7dVngqPM85kKvDZ5McBFHbVNwCf/2g+OyQ5101J+u7HkbnY1Au6gG9voc2d1H1af+XA3to=
X-Received: by 2002:a50:fe87:: with SMTP id d7mr19204838edt.381.1607461905162;
 Tue, 08 Dec 2020 13:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20201208202925.597663-1-Anna.Schumaker@Netapp.com>
 <20201208202925.597663-2-Anna.Schumaker@Netapp.com> <2A6797DD-246D-4994-B38C-57AA0196D061@oracle.com>
In-Reply-To: <2A6797DD-246D-4994-B38C-57AA0196D061@oracle.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Tue, 8 Dec 2020 16:11:28 -0500
Message-ID: <CAFX2JfkNO9LL_iaRE_RGjP+BHKiZGk8Eedg88_MKkuZUAysThw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] SUNRPC: Keep buf->len in sync with xdr->nwords
 when expanding holes
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 8, 2020 at 3:56 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Dec 8, 2020, at 3:29 PM, schumaker.anna@gmail.com wrote:
> >
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > Otherwise we could end up placing data a few bytes off from where we
> > actually want to put it.
> >
> > Fixes: 84ce182ab85b "SUNRPC: Add the ability to expand holes in data pages"
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> > net/sunrpc/xdr.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> > index 71e03b930b70..5b848fe65c81 100644
> > --- a/net/sunrpc/xdr.c
> > +++ b/net/sunrpc/xdr.c
> > @@ -1314,6 +1314,7 @@ uint64_t xdr_expand_hole(struct xdr_stream *xdr, uint64_t offset, uint64_t lengt
> >               unsigned int res = _shift_data_right_tail(buf, from + bytes - shift, shift);
> >               truncated = shift - res;
> >               xdr->nwords -= XDR_QUADLEN(truncated);
> > +             buf->len -= 4 * XDR_QUADLEN(truncated);
>
> If I understand what you're doing here correctly, the usual idiom
> is "XDR_QUADLEN(truncated) << 2" .

Oh, that works too. I'll adjust the patch. Thanks for letting me know!

Anna

>
>
> >               bytes -= shift;
> >       }
> >
> > @@ -1325,7 +1326,7 @@ uint64_t xdr_expand_hole(struct xdr_stream *xdr, uint64_t offset, uint64_t lengt
> >                                       bytes);
> >       _zero_pages(buf->pages, buf->page_base + offset, length);
> >
> > -     buf->len += length - (from - offset) - truncated;
> > +     buf->len += length - (from - offset);
> >       xdr_set_page(xdr, offset + length, PAGE_SIZE);
> >       return length;
> > }
> > --
> > 2.29.2
> >
>
> --
> Chuck Lever
>
>
>
