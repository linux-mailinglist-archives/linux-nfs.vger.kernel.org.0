Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57CB74B8D6
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jul 2023 23:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjGGVuk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Jul 2023 17:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGGVui (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Jul 2023 17:50:38 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5E112A
        for <linux-nfs@vger.kernel.org>; Fri,  7 Jul 2023 14:50:35 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-635857af3beso14201076d6.0
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jul 2023 14:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688766634; x=1691358634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoLevPobh7UXy5Nn5YH78W9QxOTU70GaTZt5uBUlM0A=;
        b=l7nzQ6ic8JvejRrTXeSP9pxsZ4sZpYgEseqeeNmP9tOIRZNTCYJOGUj3u6v5xmSkKd
         OsGDSBLhMCQCLTDROiZOQPSY4n3XvefXTb8Zu3G6/DKWn449TmE86ze0rC9zM0hq/t31
         W184sHYkrvflPMo7snf9U29pvGHJZG3E9J66dE3tnh4VgWlH6fT1cWJBoqz2VLzpBBuY
         r+lZmj1ies7BcP3uSA6UegEarirOuydiO6La9+kxtMfMMXAsUY03/e6ZKuY6Wgmmq22C
         b8N5z2jOmAGYsC9KQjpfqsh1MiRObcU//UJbLJ0KeKi4ZI2Z1bbDwf1hDh9JlRpZ5He7
         Y1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688766634; x=1691358634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoLevPobh7UXy5Nn5YH78W9QxOTU70GaTZt5uBUlM0A=;
        b=kYcglLtLJkSkuj1tpossEfhCQyLenaLxPrORQEDVt7t14k3xZJ4gYgqXy9VZ9o4eWl
         jPsGRtCXo3d5Uj6FHA6kMyiKE8/C5EIeB3/3MD9ycIAG7hi+iFzRQHiVR54pJgHZg/0s
         HuGlrG9sUVzFsc8rWD8cOL925h3sdI1C4rBG7hYF8aben/KIhEUbSkb81lSoRoNIU/f6
         A22QQnurOrLBf59ltiCOebAXVSbLSsW7Vu7fhL/6aN2pqtYJ7PAr7gz9VO9xlq/QTG1i
         jIY/3dNO2cYBjT0qesKzY/0HhUC/6IrL42mb9iHGAbR3MLlCnE/NX9n9YYzYecdRw3bg
         l+yg==
X-Gm-Message-State: ABy/qLa2wecHLKJP+ik00Bo7QNQOkaMWWzE5ZgXj7AeR9EFpNfLzt097
        XXcVnp9srpbwREP76ELgq4wU8EsReEjYiRv7YUPWlQ==
X-Google-Smtp-Source: APBJJlGlQcMZJ3Ushv3xcZlmwD9Pa978expjejTPgbABddwl3wCKInGfLZ2iqBhhPxZWR1b1uxBwbCLiukFcHrak5qI=
X-Received: by 2002:a0c:e54d:0:b0:634:7c34:6c96 with SMTP id
 n13-20020a0ce54d000000b006347c346c96mr5045432qvm.7.1688766633968; Fri, 07 Jul
 2023 14:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230703113737.694995-1-arnd@kernel.org> <6b963674-fc5a-4abb-8678-a82d35a3f3fd@kadam.mountain>
In-Reply-To: <6b963674-fc5a-4abb-8678-a82d35a3f3fd@kadam.mountain>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Jul 2023 14:50:23 -0700
Message-ID: <CAKwvOdmedTDChYYSgdC0LQGOdrzm1ua--kUcz-KGXi4TnxcvUg@mail.gmail.com>
Subject: Re: [PATCH] sunrpc: avoid constant-out-of-range warning with clang
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Dan Carpenter <error27@gmail.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 3, 2023 at 5:42=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> On Mon, Jul 03, 2023 at 01:37:22PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The overflow check in xdr_stream_decode_uint32_array() was added for
> > 32-bit systems, but on 64-bit builds it causes a build warning when
> > building with clang and W=3D1:
> >
> > In file included from init/do_mounts.c:22:
> > include/linux/sunrpc/xdr.h:778:10: error: result of comparison of const=
ant 4611686018427387903 with expression of type '__u32' (aka 'unsigned int'=
) is always false [-Werror,-Wtautological-constant-out-of-range-compare]
> >   778 |         if (len > SIZE_MAX / sizeof(*p))
> >
> > Shut up the warning with a type cast.
> >
> > Fixes: 23a9dbbe0faf1 ("NFSD: prevent integer overflow on 32 bit systems=
")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  include/linux/sunrpc/xdr.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> > index f89ec4b5ea169..6736121ee6a03 100644
> > --- a/include/linux/sunrpc/xdr.h
> > +++ b/include/linux/sunrpc/xdr.h
> > @@ -775,7 +775,7 @@ xdr_stream_decode_uint32_array(struct xdr_stream *x=
dr,
> >
> >       if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
> >               return -EBADMSG;
> > -     if (len > SIZE_MAX / sizeof(*p))
> > +     if ((size_t)len > SIZE_MAX / sizeof(*p))
> >               return -EBADMSG;
> >       p =3D xdr_inline_decode(xdr, len * sizeof(*p));
>
> I sent a patch for this last week that takes a different approach.
>
> https://lore.kernel.org/all/2390fdc8-13fa-4456-ab67-44f0744db412@moroto.m=
ountain/
>
> I probably should have used a Fixes tag just for informational purposes.

I have a slight preference for retaining the existing error handling
here, but am happy to have 2 fixes in hand rather than 0; thank you
both for your time looking at this.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> regards,
> dan carpenter
>


--=20
Thanks,
~Nick Desaulniers
