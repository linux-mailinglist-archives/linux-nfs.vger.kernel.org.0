Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195D9770536
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Aug 2023 17:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjHDPuF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Aug 2023 11:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjHDPuD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Aug 2023 11:50:03 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6757549CB
        for <linux-nfs@vger.kernel.org>; Fri,  4 Aug 2023 08:50:00 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-47ec8c9d7a0so913575e0c.3
        for <linux-nfs@vger.kernel.org>; Fri, 04 Aug 2023 08:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691164199; x=1691768999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6GtJle38GYNlw+gZNdG3pGleXzijHW2VDwwGhqBWf0=;
        b=AW5cXx0H8S0x5I+u2xfxfy1V7vR/jMhVl1HUEGEbVyMQepbBG7qwJSWaktQ6RUC0ry
         YWp/wcvzZRS0TmRJPYM7ge8Wunb/krBend8Sku8kZ9/XenVwDkKiznYril6qzO64JRls
         Q7dCK8fwLyw9HBdWcmAEtxT63VH6KCAnDDnSzC6QWOMes9rU+Bk9lh/QSwVUu/+Q9M3F
         yXe4ljZivaQrSG9TrCIM4df/WqKdrg0WjCIf3SXhO+Omc+9BDZvl7iaQ3gi46u/Wl8kv
         8M+yzJ6QwWSZYvFrole4BzasoQzljZn068wOxkBGwSzKUGLR070XifJVqziX33IlqbS0
         aaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691164199; x=1691768999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6GtJle38GYNlw+gZNdG3pGleXzijHW2VDwwGhqBWf0=;
        b=lGDEI8QQ+gd4Kzvsu0nXCklYRm8tMu1+02bBh/VTZ03PUo9Fr5ZcEetrARn0X3pxbz
         oXv/feyHL4f5lbDy98duJlZ17MRcU37OFt6lXJHFoFdzfBPEYU1qgv2g594+ilX+/fr4
         UsLskYO0poMBvmlfuuuLZeqV6ik5h1BahZFBJFRmjHHN8Jcj+qp0sJD42nOZGq08FF8F
         /HjDPXRQReL5MRP+yobQE+tl979p+gMf4YLGno8AuLpHV3M5vkEAAlwB8cgc1r2D1K0a
         qGi51BmZAyNZt1UIUk+ngWG71nj4OE6+CwmGsTr+8ck/2yrh/XYic+GDqTb03CHvkRUD
         y6oA==
X-Gm-Message-State: AOJu0Yw5eTsfng4VAvd+E2hE+nZqqQqkngYsRlWIYbJdX8dmp++ktD89
        aO1pUyLfFm++9ZAA7O1mtpDWrEg+Y+8FkVmjRgWmnQ==
X-Google-Smtp-Source: AGHT+IGtDHTDweDFtGPqweVEy6/Ojul8h7Go4cQI7kTAsF7TZW0t3PAPJCedcn9OpWUtmtIlxQmADQwpMGsPvotnBTs=
X-Received: by 2002:a1f:45d7:0:b0:487:1ae2:2ad7 with SMTP id
 s206-20020a1f45d7000000b004871ae22ad7mr1601447vka.3.1691164199316; Fri, 04
 Aug 2023 08:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230804012656.4091877-1-suhui@nfschina.com>
In-Reply-To: <20230804012656.4091877-1-suhui@nfschina.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 4 Aug 2023 08:49:48 -0700
Message-ID: <CAKwvOd=1pEE=pspfg7fcofYF5=eziFvcLJgC0_ohG7jq+rbVyg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: lockd: avoid possible wrong NULL parameter
To:     Su Hui <suhui@nfschina.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        nathan@kernel.org, trix@redhat.com, bfields@fieldses.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 3, 2023 at 6:28=E2=80=AFPM Su Hui <suhui@nfschina.com> wrote:
>
> clang's static analysis warning: fs/lockd/mon.c: line 293, column 2:
> Null pointer passed as 2nd argument to memory copy function.
>
> Assuming 'hostname' is NULL and calling 'nsm_create_handle()', this will
> pass NULL as 2nd argument to memory copy function 'memcpy()'. So return
> NULL if 'hostname' is invalid.
>
> Fixes: 77a3ef33e2de ("NSM: More clean up of nsm_get_handle()")
> Signed-off-by: Su Hui <suhui@nfschina.com>

Thanks for the patch! And thanks for checking clang static analysis reports=
!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> v2:
>  - move NULL check to the callee "nsm_create_handle()"
>  fs/lockd/mon.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/lockd/mon.c b/fs/lockd/mon.c
> index 1d9488cf0534..87a0f207df0b 100644
> --- a/fs/lockd/mon.c
> +++ b/fs/lockd/mon.c
> @@ -276,6 +276,9 @@ static struct nsm_handle *nsm_create_handle(const str=
uct sockaddr *sap,
>  {
>         struct nsm_handle *new;
>
> +       if (!hostname)
> +               return NULL;
> +
>         new =3D kzalloc(sizeof(*new) + hostname_len + 1, GFP_KERNEL);
>         if (unlikely(new =3D=3D NULL))
>                 return NULL;
> --
> 2.30.2
>


--=20
Thanks,
~Nick Desaulniers
