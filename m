Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D65D4C3166
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 17:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiBXQc3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 11:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiBXQcZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 11:32:25 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D66E11D7BF
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 08:31:48 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so167081wmj.0
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 08:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WN4f2hH1ybEx+XDhPAJeCD41HbMfXw2pGJizsgIMI7c=;
        b=DmT7mqWvl3z1Y8R0U8e28FrvZEhqLQW/YwIXDte74GJvlOSwm27ps7W2ibq9vTV+sT
         P6IMNI/kemlttI+AU2PUwIpVNg0q6wFipa2rIodcx3kkevbTLXGKpyZfwdebdA/jcnos
         X8YWNSHn2KEn5AtkcZLW71tdsZJ5woLzsdvUc1CvnZWd2WHGlILYfltGeMTZysh2i9gZ
         /3zVQoO9OwSGNHzIE+VBsFyL23e344BoSN60PEQIuN9XP/94rNg8qSA4uxtodLryGVg6
         d5o5Nee2dnACtIGRIAfOBmIU+oPKDmbxcBiHuV9ATbYkeHJFqdfcc9jmfgomzG57pxZM
         guvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WN4f2hH1ybEx+XDhPAJeCD41HbMfXw2pGJizsgIMI7c=;
        b=Gf5tEmDm51htMZawBvfP5Nv+gOehI/eX2a9q82k93MsdqxDVRTgDc3JLS79sDIsjUr
         5iQF+94Si6ke/WsN8d2af7XCzIRYDuc0mzoqopQYiI4FppANdzMnS32NHwyJs4YwC2EA
         FIskergh0d4jX6V9NLTmtEYw7OF01PmxxhHgarq9vRvGTE2eF19noMvOqHRt8Lh2/ifK
         qWxS+ssOMKmobbICNMCwwXJjZf4YsMo2h6EjbobI8C5PtFhU2slPUhPZHeXnLtUCWi7x
         SFWqJtTmsI0nP1gQ2DsAJ9oWJ+nbrwIW3U6Fw3WaPadJH4BJDMeqTq6dt6iIuzl+tyTi
         LOtg==
X-Gm-Message-State: AOAM533qBAoJUdUb3K6VlZvG0gMz1448vKJ3ZvpP45v1b866ZspfDVJ/
        XSnNEOEfm6R8ULqKE3VCSjcZZYy/+1RKZwOR07UKaafqMYE=
X-Google-Smtp-Source: ABdhPJzD5pmflAVa2mWQR4vqbqw3ek0mYqkkLjuj7FYUtwsMAvYsNrlMqBTKlz86mqwKfeUfh8tXx6el+BHnOn6DTcI=
X-Received: by 2002:a7b:c742:0:b0:37b:dea5:3539 with SMTP id
 w2-20020a7bc742000000b0037bdea53539mr2989331wmk.38.1645719524405; Thu, 24 Feb
 2022 08:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20220223211305.296816-1-trondmy@kernel.org> <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org> <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org> <20220223211305.296816-6-trondmy@kernel.org>
 <20220223211305.296816-7-trondmy@kernel.org>
In-Reply-To: <20220223211305.296816-7-trondmy@kernel.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 24 Feb 2022 11:18:27 -0500
Message-ID: <CAFX2Jf=009PkXD0b9_NNyX1k60KJ1fz8WKswnd8iU8EFpmbROw@mail.gmail.com>
Subject: Re: [PATCH v7 06/21] NFS: If the cookie verifier changes, we must
 invalidate the page cache
To:     trondmy@kernel.org
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On Wed, Feb 23, 2022 at 7:48 PM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Ensure that if the cookie verifier changes when we use the zero-valued
> cookie, then we invalidate any cached pages.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/dir.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 5d9367d9b651..7932d474ce00 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -945,9 +945,14 @@ static int find_and_lock_cache_page(struct nfs_readd=
ir_descriptor *desc)
>                 /*
>                  * Set the cookie verifier if the page cache was empty
>                  */
> -               if (desc->page_index =3D=3D 0)
> +               if (desc->last_cookie =3D=3D 0 &&
> +                   memcmp(nfsi->cookieverf, verf, sizeof(nfsi->cookiever=
f))) {
>                         memcpy(nfsi->cookieverf, verf,
>                                sizeof(nfsi->cookieverf));
> +                       invalidate_inode_pages2_range(desc->file->f_mappi=
ng,
> +                                                     desc->page_index_ma=
x + 1,

I'm getting this when I try to compile this patch:

fs/nfs/dir.c: In function =E2=80=98find_and_lock_cache_page=E2=80=99:
fs/nfs/dir.c:953:61: error: =E2=80=98struct nfs_readdir_descriptor=E2=80=99=
 has no
member named =E2=80=98page_index_max=E2=80=99; did you mean =E2=80=98page_i=
ndex=E2=80=99?
  953 |
desc->page_index_max + 1,
      |
^~~~~~~~~~~~~~
      |                                                             page_in=
dex
make[2]: *** [scripts/Makefile.build:288: fs/nfs/dir.o] Error 1
make[1]: *** [scripts/Makefile.build:550: fs/nfs] Error 2
make: *** [Makefile:1831: fs] Error 2
make: *** Waiting for unfinished jobs....

It looks like the "page_index_max" field is added in patch 8.

Anna


Anna
> +                                                     -1);
> +               }
>         }
>         res =3D nfs_readdir_search_array(desc);
>         if (res =3D=3D 0)
> --
> 2.35.1
>
