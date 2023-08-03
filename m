Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F9076F02D
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Aug 2023 18:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjHCQ6I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Aug 2023 12:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbjHCQ5c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Aug 2023 12:57:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4D346B0;
        Thu,  3 Aug 2023 09:56:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2262961E5A;
        Thu,  3 Aug 2023 16:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034BDC433C7;
        Thu,  3 Aug 2023 16:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691081816;
        bh=fx8WknJyDBVEgJv4NSl2bGwv0NUpl9D+DCz9SJGxGfY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lPWwi0K5zRv8DmFUo52FMpfa4fBoMQk1vZz2JRMuTbWEpre2JfWUABPdS2Yj7mv38
         wXSbG+Flk5O53O7uW9/qco48Ib4MYe1J+G0TKHWaOwU0sKgIdrhLR3fSjPNJTrfQVO
         N1D9CDZeiw3V7G1HLp/qYIWL77vs8BVUUKn4SRkBZYTl6KNYswW+Ny8MAM/KdaMPJy
         ukFrx7sb56zXI73nOwLJ5AR1wtt4+yNF1xDgwQlhAcmFcxHtZgokPAr4d/pR7QMwS8
         Mse6CBIHRbo83rzgPO1jcNL9gk5vcfWm6XOvByZjZvKstplt9QBbrXDXa/HPQGfz42
         /rnwSchaQM/NQ==
Message-ID: <222fa7b5df94a6e0898612ec62d2e6d2f4163cb8.camel@kernel.org>
Subject: Re: [PATCH] fs: lockd: avoid possible wrong NULL parameter
From:   Jeff Layton <jlayton@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Su Hui <suhui@nfschina.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>, chuck.lever@oracle.com,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, trond.myklebust@hammerspace.com, anna@kernel.org,
        nathan@kernel.org, trix@redhat.com, bfields@fieldses.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Date:   Thu, 03 Aug 2023 12:56:53 -0400
In-Reply-To: <CAKwvOd=BJy==Ly80zLvW=RiEO=F5KeztVet7CuKT0FjvQtoSbw@mail.gmail.com>
References: <CAKwvOdnRwmxGuEidZ=OWxSX60D6ry0Rb__DjSayga6um35Jsrg@mail.gmail.com>
         <5066885c-3ac9-adbd-6852-eba89657470c@nfschina.com>
         <CAKwvOd=BJy==Ly80zLvW=RiEO=F5KeztVet7CuKT0FjvQtoSbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-08-03 at 09:38 -0700, Nick Desaulniers wrote:
> On Wed, Aug 2, 2023 at 9:11=E2=80=AFPM Su Hui <suhui@nfschina.com> wrote:
> >=20
> > On 2023/8/3 05:40, Nick Desaulniers wrote:
> >=20
> > On Wed, Aug 2, 2023 at 3:25=E2=80=AFAM Dan Carpenter <dan.carpenter@lin=
aro.org> wrote:
> >=20
> >=20
> > I noticed that the function in question already has a guard:
> > 322   if (hostname && memchr(hostname, '/', hostname_len) !=3D NULL) {
> >=20
> > Which implies that hostname COULD be NULL.
> >=20
> > Should this perhaps simply be rewritten as:
> >=20
> > if (!hostname)
> >   return NULL;
> > if (memchr(...) !=3D NULL)
> >   ...
> >=20
> > Rather than bury yet another guard for the same check further down in
> > the function? Check once and bail early.
> >=20
> > Hi, Nick Desaulnier,
> >=20
> > This may disrupt the logic of this function. So maybe the past one is b=
etter.
> >=20
> > 322         if (!hostname)
> > 323                 return NULL;
> >                     ^^^^^^^^^^^^
> > If we return in this place.
> >=20
> > 324         if (memchr(hostname, '/', hostname_len) !=3D NULL) {
> > 325                 if (printk_ratelimit()) {
> > 326                         printk(KERN_WARNING "Invalid hostname \"%.*=
s\" "
> > 327                                             "in NFS lock request\n"=
,
> > 328                                 (int)hostname_len, hostname);
> > 329                 }
> > 330                 return NULL;
> > 331         }
> > 332
> > 333 retry:
> > 334         spin_lock(&nsm_lock);
> > 335
> > 336         if (nsm_use_hostnames && hostname !=3D NULL)
> > 337                 cached =3D nsm_lookup_hostname(&ln->nsm_handles,
> > 338                                         hostname, hostname_len);
> > 339         else
> > 340                 cached =3D nsm_lookup_addr(&ln->nsm_handles, sap);
> >                              ^^^^^^^^^^^^^^^
> > This case will be broken when hostname is NULL.
>=20
> Ah, you're right; I agree.
>=20
> What are your thoughts then about moving the "is hostname NULL" check
> to nsm_create_handle() then?
>=20
> Perhaps nsm_create_handle() should check that immediately and return
> NULL, or simply skip the memcpy if hostname is NULL?
>=20
> It seems perhaps best to localize this to the callee rather than the
> caller. While there is only one caller today, should another arise
> someday, they may make the same mistake.
>=20
> I don't feel strongly either way, and am happy to sign off on either
> approach; just triple checking we've considered a few different cases.
>=20

I think that sounds like the best fix here. Just have nsm_create_handle
return NULL immediately if hostname is NULL.

> >=20
> > 341
> > 342         if (cached !=3D NULL) {
> > 343                 refcount_inc(&cached->sm_count);
> > 344                 spin_unlock(&nsm_lock);
> > 345                 kfree(new);
> > 346                 dprintk("lockd: found nsm_handle for %s (%s), "
> > 347                                 "cnt %d\n", cached->sm_name,
> > 348                                 cached->sm_addrbuf,
> > 349                                 refcount_read(&cached->sm_count));
> > 350                 return cached;
> > 351         }
> >=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
