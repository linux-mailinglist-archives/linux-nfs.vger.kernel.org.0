Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6616A562212
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jun 2022 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbiF3Sbk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jun 2022 14:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbiF3Sbk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jun 2022 14:31:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ACE42A1B
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jun 2022 11:31:37 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v14so28514975wra.5
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jun 2022 11:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r1ghyLwkC+AxO+JPrROs67uiqDnYE6VvdlYbeN5vpEI=;
        b=eW2Y46AhOFdrfyRhwz4vALCDUMDP1p8IerRDYUyE9XWzQubLVpyqsSDTkT8lRAWm5z
         wM8eDZGIhOiqLPQaJEIDQFIETEkytUCn8eu43a1U++1y2IQurSezzurLI33oa0IrsiKD
         nUb4nHxWD/t/9BOkTwypA34xjDODKolpUJkd1bm1ahn16P0q/Uw/BmWptOOZE7xTTj4z
         pTzkvsaEPRGWAfK1JyPhmMeQu/6VkiErd9AWBgkg5HDyVBWwGKX4lLmaRwuff2Y4DVmE
         LYMKAOx9DYsOduYL7ugSfwoiwglrLlIcbe2S9ESYqn3sd6lY4pfq8SwtCIk/WbaDuZqF
         CwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r1ghyLwkC+AxO+JPrROs67uiqDnYE6VvdlYbeN5vpEI=;
        b=kfhEQqqUTlj4duTVCup1dDrMcF2zXgGyckI9Pu5e85tSGTfrOow2zWGnDGqndavN3j
         hIXhphNOORtHT/bPfafJQI2Bpk+BNduxpk660JN892BOj4AK1Lpf0vF3RfcjndjR5U53
         UGQygRwTFy73vEp58rUdxiyWgRvfSmtvz4lFrVEk85R6w17fUW3MU4tLh8zF4h8ZZ540
         Qb+CXqsLL5qwhRbu42osPWzO1+Mtr5o3Kv/3zPMOhxxB6LBCG2+M5vKhh7WPeUf1wWNv
         BHfdDas7UV0OcYNUmnA5O/gSeZ/5C9hcjRlijh8983rgdOe4dHLiMgAyKMb7SEqDidXC
         fbVw==
X-Gm-Message-State: AJIora9NTGLR/zBEKvIFWkX52fDMCT9+okN0YVZfTVd5XbAz1Tu/Uz63
        h0PuG1CtKfGu5AbRWObdNhHsgvUaNXMN22EiAFaR0SRM
X-Google-Smtp-Source: AGRyM1uIg1S01ryMvQVgJAKP5m/I30aGm0SgP1/ByZcjS5ox4Dbop8y6wBg8C4gd+Cem2P/D0F/K0coaWcagAX1YgrI=
X-Received: by 2002:a5d:4c90:0:b0:21b:8b2a:1656 with SMTP id
 z16-20020a5d4c90000000b0021b8b2a1656mr9742163wrs.249.1656613896303; Thu, 30
 Jun 2022 11:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <165660978413.2453.15153844664543877314.stgit@klimt.1015granger.net>
 <faae3bdaf5fc4b1c2ff481977bd1bf091bb0c8b6.camel@hammerspace.com> <CAFX2Jfmxi2_M=Ptt=2M7dbks62Gkdia2913yod5zaZ8bV9vGwA@mail.gmail.com>
In-Reply-To: <CAFX2Jfmxi2_M=Ptt=2M7dbks62Gkdia2913yod5zaZ8bV9vGwA@mail.gmail.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 30 Jun 2022 14:31:20 -0400
Message-ID: <CAFX2JfmJTaHf+WQHgK28ap_xsG8w83qpo4re1TuAhf+SfU6Tjg@mail.gmail.com>
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

On Thu, Jun 30, 2022 at 2:09 PM Anna Schumaker <schumaker.anna@gmail.com> wrote:
>
> On Thu, Jun 30, 2022 at 2:03 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
> >
> > On Thu, 2022-06-30 at 13:24 -0400, Chuck Lever wrote:
> > > Looks like there are still cases when "space_left - frag1bytes" can
> > > legitimately exceed PAGE_SIZE. Ensure that xdr->end always remains
> > > within the current encode buffer.
> > >
> > > Reported-by: Bruce Fields <bfields@fieldses.org>
> > > Reported-by: Zorro Lang <zlang@redhat.com>
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216151
> > > Fixes: 6c254bf3b637 ("SUNRPC: Fix the calculation of xdr->end in
> > > xdr_get_next_encode_buffer()")
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > >  net/sunrpc/xdr.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > Hi-
> > >
> > > I had a few minutes yesterday afternoon to look into this one. The
> > > following one-liner seems to address the issue and passes my smoke
> > > tests with NFSv4.1/TCP and NFSv3/RDMA. Any thoughts?
> > >
> > >
> > > diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> > > index f87a2d8f23a7..916659be2774 100644
> > > --- a/net/sunrpc/xdr.c
> > > +++ b/net/sunrpc/xdr.c
> > > @@ -987,7 +987,7 @@ static noinline __be32
> > > *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
> > >         if (space_left - nbytes >= PAGE_SIZE)
> > >                 xdr->end = p + PAGE_SIZE;
> > >         else
> > > -               xdr->end = p + space_left - frag1bytes;
> > > +               xdr->end = p + min_t(int, space_left - frag1bytes,
> > > PAGE_SIZE);
> >
> > Since we know that frag1bytes <= nbytes (that is determined in
> > xdr_reserve_space()), isn't this effectively the same thing as changing
> > the condition to
> >
> >         if (space_left - frag1bytes >= PAGE_SIZE)
> >                 xdr->end = p + PAGE_SIZE;
> >         else
> >                 xdr->end = p + space_left - frag1bytes;
>
> I added some printk's without this patch, and I'm seeing space_left
> larger than PAGE_SIZE and frag1bytes set to 0 in that branch right
> before the crash. So the min_t() will choose the PAGE_SIZE option
> sometimes.

Actually, ignore me. I initially misread what Trond said.  After a
reread I saw he changed "space_left - nbytes" to "space_left -
frag1bytes" in the if condition. Trond's way fixes the crash for me,
too.

Anna
>
> Anna
>
> >
> > ?
> > >
> > >         xdr->buf->page_len += frag2bytes;
> > >         xdr->buf->len += nbytes;
> > >
> > >
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> >
> >
