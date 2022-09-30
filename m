Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBB05F1443
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Sep 2022 22:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiI3U6q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Sep 2022 16:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiI3U6k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Sep 2022 16:58:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394263EA49
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 13:58:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAFB9B82A30
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 20:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD57C433C1;
        Fri, 30 Sep 2022 20:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664571513;
        bh=aUOZaQq9YDCAcYUVzSs3KzGkeAQNgcwU+IuEymQOob4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bPwgQiolX16NV0QD2O+ZMyVedw+CknvdR83UsO6fsQvTWH3fGz9gRINqEaLog/1DX
         3acYRRosHIHt4mlbnh1EQfoRLVbFavf2Bv+1ttVgD+LEKO0lGv9QU/FE9qe/8wmf33
         xzqyUL4V1PBUZ9580eR8ivCaWf6eaqkDVvASdByzQfNUkEMR3vAV3yHfJpAvaoR/kf
         KuwzADWXh3ZX2TU2ROISIJ9aLCAppq3pfdoCqSNpVBHujdUWROHsLvMag/cedOCncm
         dgcj7GvHId4X2FLSsVRdKsi+g6SqfuT/VquICvxTQd9l659Dz+0TnImEAA/2vWeL68
         SWVnax6d5pQeg==
Message-ID: <225eb68c838607125ba82e605b7e02b7100d4cf6.camel@kernel.org>
Subject: Re: [PATCH 2/3] nfsd: fix potential race in nfsd_file_close
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 30 Sep 2022 16:58:32 -0400
In-Reply-To: <20220930191550.172087-3-jlayton@kernel.org>
References: <20220930191550.172087-1-jlayton@kernel.org>
         <20220930191550.172087-3-jlayton@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-09-30 at 15:15 -0400, Jeff Layton wrote:
> Once we call nfsd_file_put, there is no guarantee that "nf" can still be
> safely accessed. That may have been the last reference.
>=20
> Change the code to instead check for whether nf_ref is 2 and then unhash
> it and put the reference if we're successful.
>=20
> We might occasionally race with another lookup and end up unhashing it
> when it probably shouldn't have been, but that should hopefully be rare
> and will just result in the competing lookup having to create a new
> nfsd_file.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/filecache.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 6237715bd23e..58f4d9267f4a 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -461,12 +461,14 @@ nfsd_file_put(struct nfsd_file *nf)
>   */
>  void nfsd_file_close(struct nfsd_file *nf)
>  {
> -	nfsd_file_put(nf);
> -	if (refcount_dec_if_one(&nf->nf_ref)) {
> -		nfsd_file_unhash(nf);
> -		nfsd_file_lru_remove(nf);
> -		nfsd_file_free(nf);
> +	/* One for the reference being put, and one for the hash */
> +	if (refcount_read(&nf->nf_ref) =3D=3D 2) {
> +		if (nfsd_file_unhash(nf))
> +			nfsd_file_put_noref(nf);
>  	}
> +	/* put the ref for the stateid */
> +	nfsd_file_put(nf);
> +

Chuck if you're ok with this one, can you fix the stray newline above?

>  }
> =20
>  struct nfsd_file *


Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
