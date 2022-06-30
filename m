Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8C45621B6
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jun 2022 20:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbiF3SJW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jun 2022 14:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiF3SJV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jun 2022 14:09:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE8938DB3
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jun 2022 11:09:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e28so23313423wra.0
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jun 2022 11:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=um0+O+Im066oJVRiOH9S+it9rt5ukFDym9sSmC/5imk=;
        b=MGExlnlx3CKGjBVGPunOcgF/3RKoOcJCq0MFskBTeX1YqHeI4cUDrKJSNtRKwe92v9
         yT4Q9m6wAnrL/zh6M7XGG1GfLL5v8xczZaF2th6NHgGl2gPNNwmbA8Ym9OkVsj9+kVlu
         1Ljws4KwhFHrI/yylY3pxu5fa203BPSqItNIswNC/4CCiebw3QzLo/8yGctdW55PCIQG
         hjdHbeIemTcIckzbn2P8pAYenPU0eX9/bIsChDojnIbzjJvJgdNARbaeZd0YJdtpofLK
         dwvSw44YJPRMlSMX8tV/aqNLyVekbNrC+7akYSH96k8dLWtfdZOE1Mce34GeRVi69Bpi
         LDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=um0+O+Im066oJVRiOH9S+it9rt5ukFDym9sSmC/5imk=;
        b=LKTYW15cJps985KB2OmGyWpl4luvR12l8ChYqAho3vPWFiLW8+KwO6jGVOcFLwDe9/
         uyjg0z+HaDFdD/RTTsjwzN/1uwOkJ4CP0+valVfNbQjgGFGEjQ97r9c/qGL6Qg00yiOZ
         zNbRlV8DBa8re1VVF2w3QAvxoGBsuiRhMJGPpAE1Ip+SKQFITJo7tHRaVrvRucudrYy0
         VrG2nPtJOU3pRZMh5liYHQh9K50VExAiE9VORGeQzQ1QeNWrTjsyrQmLjvbojOJcb/0X
         of+j1CME/IMMDypoVzFARCr05RgzfJBVeXS0pRP5XLBAjvhG0YBfMdbONUoZjRptAlA+
         nkGw==
X-Gm-Message-State: AJIora+flaUnlrmYrDZc7CwUKKsWuWHtFzRynIQTYKUOnH7rY9Ma1BrW
        1dwBEWOQoWQHHvSDj0vTnSrbwlSPtns0zaSlXjo=
X-Google-Smtp-Source: AGRyM1tNgRsmk/ZYk+98D2jVrM9RAFzPOQdNJYS9etnxxIMCS7cqGcvuc2CDww+g2y2idcIXWu0zHBN4WbqTxur2C5c=
X-Received: by 2002:adf:ef11:0:b0:21b:a557:b06d with SMTP id
 e17-20020adfef11000000b0021ba557b06dmr9786794wro.434.1656612558513; Thu, 30
 Jun 2022 11:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <165660978413.2453.15153844664543877314.stgit@klimt.1015granger.net>
 <faae3bdaf5fc4b1c2ff481977bd1bf091bb0c8b6.camel@hammerspace.com>
In-Reply-To: <faae3bdaf5fc4b1c2ff481977bd1bf091bb0c8b6.camel@hammerspace.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 30 Jun 2022 14:09:02 -0400
Message-ID: <CAFX2Jfmxi2_M=Ptt=2M7dbks62Gkdia2913yod5zaZ8bV9vGwA@mail.gmail.com>
Subject: Re: [PATCH v1] SUNRPC: Fix READ_PLUS crasher
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "zlang@redhat.com" <zlang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 30, 2022 at 2:03 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Thu, 2022-06-30 at 13:24 -0400, Chuck Lever wrote:
> > Looks like there are still cases when "space_left - frag1bytes" can
> > legitimately exceed PAGE_SIZE. Ensure that xdr->end always remains
> > within the current encode buffer.
> >
> > Reported-by: Bruce Fields <bfields@fieldses.org>
> > Reported-by: Zorro Lang <zlang@redhat.com>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216151
> > Fixes: 6c254bf3b637 ("SUNRPC: Fix the calculation of xdr->end in
> > xdr_get_next_encode_buffer()")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  net/sunrpc/xdr.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Hi-
> >
> > I had a few minutes yesterday afternoon to look into this one. The
> > following one-liner seems to address the issue and passes my smoke
> > tests with NFSv4.1/TCP and NFSv3/RDMA. Any thoughts?
> >
> >
> > diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> > index f87a2d8f23a7..916659be2774 100644
> > --- a/net/sunrpc/xdr.c
> > +++ b/net/sunrpc/xdr.c
> > @@ -987,7 +987,7 @@ static noinline __be32
> > *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
> >         if (space_left - nbytes >= PAGE_SIZE)
> >                 xdr->end = p + PAGE_SIZE;
> >         else
> > -               xdr->end = p + space_left - frag1bytes;
> > +               xdr->end = p + min_t(int, space_left - frag1bytes,
> > PAGE_SIZE);
>
> Since we know that frag1bytes <= nbytes (that is determined in
> xdr_reserve_space()), isn't this effectively the same thing as changing
> the condition to
>
>         if (space_left - frag1bytes >= PAGE_SIZE)
>                 xdr->end = p + PAGE_SIZE;
>         else
>                 xdr->end = p + space_left - frag1bytes;

I added some printk's without this patch, and I'm seeing space_left
larger than PAGE_SIZE and frag1bytes set to 0 in that branch right
before the crash. So the min_t() will choose the PAGE_SIZE option
sometimes.

Anna

>
> ?
> >
> >         xdr->buf->page_len += frag2bytes;
> >         xdr->buf->len += nbytes;
> >
> >
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
