Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31526F605A
	for <lists+linux-nfs@lfdr.de>; Wed,  3 May 2023 22:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjECU54 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 May 2023 16:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjECU5z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 May 2023 16:57:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AF086B5;
        Wed,  3 May 2023 13:57:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12DA162E3B;
        Wed,  3 May 2023 20:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68998C4339C;
        Wed,  3 May 2023 20:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683147464;
        bh=2Tklkxb7+0AbB8c6bE+Zu5v3vOR5AXdMaXYWbvxNZnU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nYlbsCiGdF7WuLY7pnGiGflNoisUgtkiL53V51nZHPf1iinM08/qHgHsdzgyB4LXB
         KV0kTugldouSTV7Yui57n75ME6RihiBhfE/YpYxBmGdb7lR51KOK1zvLqPokc+fBN7
         f68WhjvU+a4GhJYYWSBY2xHKDZjDJPIimgUSH3oyX1taE7Kz7otMJZCGYJjbwioFdm
         Zsu5S7wzT+diBetB0GUGu0EYDIC/CcYtBGSkEdD+yKelW6JS/g8oWhkgmw10dK26e5
         GnU31ETayAlYm3oVJcJDH9ytqvbDVuROJ0bTks5sT/W8Vf454y5MuyAOKdEAvUF825
         0s/vv7AWgITeg==
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-3ef32014101so56783331cf.3;
        Wed, 03 May 2023 13:57:44 -0700 (PDT)
X-Gm-Message-State: AC+VfDyKuY8TD0cV9iFn6nk/eFuodC0/CmBck4meFxcEd91O7O78ICrQ
        HS09KvEIwD4GlFQ8SToRuam2998WYhu3rQz5Qhg=
X-Google-Smtp-Source: ACHHUZ6XUsvSSdLizy6KjZ+QipXVxLlBugqUCNKsNLylTfUGXZprh2SOLh/fhWvHiGBopRwsnyt9qIvI51WUfP73d14=
X-Received: by 2002:a05:622a:15c4:b0:3f2:1d7d:6851 with SMTP id
 d4-20020a05622a15c400b003f21d7d6851mr2511848qty.16.1683147463535; Wed, 03 May
 2023 13:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230503172411.3356-1-fmdefrancesco@gmail.com>
In-Reply-To: <20230503172411.3356-1-fmdefrancesco@gmail.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Wed, 3 May 2023 16:57:27 -0400
X-Gmail-Original-Message-ID: <CAFX2Jfmz9pqPUyqr6Dy-ELu+1SGaKmpk4hNkN+LoK4xNFM1XHA@mail.gmail.com>
Message-ID: <CAFX2Jfmz9pqPUyqr6Dy-ELu+1SGaKmpk4hNkN+LoK4xNFM1XHA@mail.gmail.com>
Subject: Re: [PATCH] NFS: Convert kmap_atomic() to kmap_local_folio()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 3, 2023 at 1:24=E2=80=AFPM Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> kmap_atomic() is deprecated in favor of kmap_local_{folio,page}().
>
> Therefore, replace kmap_atomic() with kmap_local_folio() in
> nfs_readdir_folio_array_append().
>
> kmap_atomic() disables page-faults and preemption (the latter only for
> !PREEMPT_RT kernels), However, the code within the mapping/un-mapping in
> nfs_readdir_folio_array_append() does not depend on the above-mentioned
> side effects.
>
> Therefore, a mere replacement of the old API with the new one is all that
> is required (i.e., there is no need to explicitly add any calls to
> pagefault_disable() and/or preempt_disable()).
>
> Tested with (x)fstests in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel
> with HIGHMEM64GB enabled.

Thanks Fabio! Looks like I missed this when I wrote: ec108d3cc766
("NFS: Convert readdir page array functions to use a folio")

I have it applied now.

Anna

>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>
> "./check -nfs -g quick", with or without this patch, always fails the
> same 12 tests of 559: generic/053 generic/099 generic/105 generic/193
> generic/294 generic/318 generic/319 generic/444 generic/465 generic/528
> generic/529 generic/531.
>
> Therefore, I think I can say that this patch does not introduce any
> regressions.
>
>  fs/nfs/dir.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 8257de6dba45..8fa8ae49d6cd 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -317,7 +317,7 @@ static int nfs_readdir_folio_array_append(struct foli=
o *folio,
>
>         name =3D nfs_readdir_copy_name(entry->name, entry->len);
>
> -       array =3D kmap_atomic(folio_page(folio, 0));
> +       array =3D kmap_local_folio(folio, 0);
>         if (!name)
>                 goto out;
>         ret =3D nfs_readdir_array_can_expand(array);
> @@ -340,7 +340,7 @@ static int nfs_readdir_folio_array_append(struct foli=
o *folio,
>                 nfs_readdir_array_set_eof(array);
>  out:
>         *cookie =3D array->last_cookie;
> -       kunmap_atomic(array);
> +       kunmap_local(array);
>         return ret;
>  }
>
> --
> 2.40.0
>
