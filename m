Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37F475D0AE
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 19:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjGUR3C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 13:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGUR3B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 13:29:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6573588;
        Fri, 21 Jul 2023 10:28:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC5BA61D4E;
        Fri, 21 Jul 2023 17:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA0AC433CA;
        Fri, 21 Jul 2023 17:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689960534;
        bh=84jCfZT2r4jooZTwz3FGXNUNGGcDlHqeZoXLxklnp6M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ef5nDrJrcgwFCIMpE41AaU/BP23efqIrQyd1kgruowInlrOlp1FRydF26U1bvrOux
         uhUNN9e+ICRpj7GKEXEH3qqmnOl7D2P2FTaoz5e6wdLC3vaGXcoMH/f+HLodYLqYX/
         GNVqVNuOvHqhsMK76lnZLy7MbCG9AnoMhlOfCz4hNrcXRqbt8TXzc5HlKmCCMCk8fQ
         uD/7hCMNC9O5bSvhP4aMuf1b89KgvXMPkMFRKapPPrvUz3Cvppc5FMxcafvdgUIpf2
         +IZbmtLIiDYjAmVGrk8GMf5DBsfMx+DDhc26m1QhtjMADTTSloSqKGrFmTy6esvUas
         yDjZ1jktjQofQ==
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-403470df1d0so16103131cf.0;
        Fri, 21 Jul 2023 10:28:54 -0700 (PDT)
X-Gm-Message-State: ABy/qLZgugN5jsf3FTluYAxJ9xb9NCHgmzdXRrs6oktLEKH9aOXE65Uf
        wIalhpVM0o20+HVt7fI+DtXl/EB49V3Qr5Afcfo=
X-Google-Smtp-Source: APBJJlFDdeg+vQAolLbGsNYVX9X6JREEDQgc6jKYJP5FIsWmDkXs5yw/ZTbEA6lNvBFR3fQAZd57evwuxQIT0Oej18A=
X-Received: by 2002:a05:622a:19a6:b0:405:4df2:72fe with SMTP id
 u38-20020a05622a19a600b004054df272femr642277qtc.30.1689960533310; Fri, 21 Jul
 2023 10:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <e655db6f-471b-4184-8907-0551e909acbb@moroto.mountain>
In-Reply-To: <e655db6f-471b-4184-8907-0551e909acbb@moroto.mountain>
From:   Anna Schumaker <anna@kernel.org>
Date:   Fri, 21 Jul 2023 13:28:37 -0400
X-Gmail-Original-Message-ID: <CAFX2JfmdpaRWbBypM+Xd4omd86mAbMNQ79+=xAtJXNjip95Sag@mail.gmail.com>
Message-ID: <CAFX2JfmdpaRWbBypM+Xd4omd86mAbMNQ79+=xAtJXNjip95Sag@mail.gmail.com>
Subject: Re: [PATCH] nfs/blocklayout: Use the passed in gfp flags
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Jens Axboe <axboe@kernel.dk>, Jack Wang <jinpu.wang@ionos.com>,
        Dave Chinner <dchinner@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dan,

On Fri, Jul 21, 2023 at 10:58=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> This allocation should use the passed in GFP_ flags instead of
> GFP_KERNEL.  All the callers that I reviewed passed GFP_KERNEL as the
> allocation flags so this might not affect runtime, but it's still worth
> cleaning up.

If all the callers are passing GFP_KERNEL anyway, then can we instead
remove the gfp_mask argument from these functions?

Anna

>
> Fixes: 5c83746a0cf2 ("pnfs/blocklayout: in-kernel GETDEVICEINFO XDR parsi=
ng")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  fs/nfs/blocklayout/dev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
> index 70f5563a8e81..65cbb5607a5f 100644
> --- a/fs/nfs/blocklayout/dev.c
> +++ b/fs/nfs/blocklayout/dev.c
> @@ -404,7 +404,7 @@ bl_parse_concat(struct nfs_server *server, struct pnf=
s_block_dev *d,
>         int ret, i;
>
>         d->children =3D kcalloc(v->concat.volumes_count,
> -                       sizeof(struct pnfs_block_dev), GFP_KERNEL);
> +                       sizeof(struct pnfs_block_dev), gfp_mask);
>         if (!d->children)
>                 return -ENOMEM;
>
> @@ -433,7 +433,7 @@ bl_parse_stripe(struct nfs_server *server, struct pnf=
s_block_dev *d,
>         int ret, i;
>
>         d->children =3D kcalloc(v->stripe.volumes_count,
> -                       sizeof(struct pnfs_block_dev), GFP_KERNEL);
> +                       sizeof(struct pnfs_block_dev), gfp_mask);
>         if (!d->children)
>                 return -ENOMEM;
>
> --
> 2.39.2
>
