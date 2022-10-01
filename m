Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F16A5F1B91
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Oct 2022 11:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJAJru (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Oct 2022 05:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJAJrq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Oct 2022 05:47:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F7ACEEBC
        for <linux-nfs@vger.kernel.org>; Sat,  1 Oct 2022 02:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FEB4B80DC6
        for <linux-nfs@vger.kernel.org>; Sat,  1 Oct 2022 09:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D76C433C1;
        Sat,  1 Oct 2022 09:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664617662;
        bh=r0hi8qSZdu50V/YjUUAwyu/FwOWBmvYox4v9k7gdwYI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OxwP+gJYaj9tCeij2x2sURkgU+ZcPTz7KBG93AkIn2+tHVpoHQVeTzC7T48q5nA6C
         U1PmvwWHdXXOty/1uKXpunOAJ/4GAH6c6qwdUEK7hHnNGwxrv7ra4kRF7GLKQhAbBg
         xL/hWyro3XwYUT69VuzQ4k2xsGGA6u/OqPpVyH9NuO+HAdP2QHl02ofpKFZt0LbszT
         eyhAjAudksrJrlF39OlHfnrcm8YOk6ZRSiOjl60ACFrS1g8mJJK4fgw2koxaRDptxw
         OCAY0MSFzuIhs9MGqfTtwgvv71Q3thbiz+gXF9xjcXymFEQoDv+ps97QRMHSrbePLM
         SQzoMePhpM9Fg==
Message-ID: <63286cf2604c30671e9cc2b73467f28e9dd96064.camel@kernel.org>
Subject: Re: [PATCH 1/3] nfsd: nfsd_do_file_acquire should hold
 rcu_read_lock while getting refs
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Date:   Sat, 01 Oct 2022 05:47:40 -0400
In-Reply-To: <166459949085.17572.9387753773056673569@noble.neil.brown.name>
References: <20220930191550.172087-1-jlayton@kernel.org>
        , <20220930191550.172087-2-jlayton@kernel.org>
         <166459949085.17572.9387753773056673569@noble.neil.brown.name>
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

On Sat, 2022-10-01 at 14:44 +1000, NeilBrown wrote:
> On Sat, 01 Oct 2022, Jeff Layton wrote:
> > nfsd_file is RCU-freed, so it's possible that one could be found that's
> > in the process of being freed and the memory recycled. Ensure we hold
> > the rcu_read_lock while attempting to get a reference on the object.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/filecache.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index d5c57360b418..6237715bd23e 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -1077,10 +1077,12 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
> > =20
> >  retry:
> >  	/* Avoid allocation if the item is already in cache */
> > +	rcu_read_lock();
> >  	nf =3D rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
> >  				    nfsd_file_rhash_params);
> >  	if (nf)
> >  		nf =3D nfsd_file_get(nf);
> > +	rcu_read_unlock();
>=20
> Looks good.
>=20
> >  	if (nf)
> >  		goto wait_for_construction;
> > =20
> > @@ -1090,16 +1092,21 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
> >  		goto out_status;
> >  	}
> > =20
> > +	rcu_read_lock();
> >  	nf =3D rhashtable_lookup_get_insert_key(&nfsd_file_rhash_tbl,
> >  					      &key, &new->nf_rhash,
> >  					      nfsd_file_rhash_params);
> >  	if (!nf) {
> > +		rcu_read_unlock();
> >  		nf =3D new;
> >  		goto open_file;
> >  	}
> > -	if (IS_ERR(nf))
> > +	if (IS_ERR(nf)) {
> > +		rcu_read_unlock();
> >  		goto insert_err;
> > +	}
> >  	nf =3D nfsd_file_get(nf);
> > +	rcu_read_unlock();
>=20
> Ugh.
> Could we make this:
>    rcu_read_lock()
>    nf =3D r_l_g_i_k()
>    if (!IS_ERR_OR_NULL(nf))
>         nf =3D nfsd_file_get(nf);
>    rcu_read_unlock()
>    ...
> ??
>=20
> NeilBrown
>=20

Good point. I'll resend a v2 here.

> >  	if (nf =3D=3D NULL) {
> >  		nf =3D new;
> >  		goto open_file;
> > --=20
> > 2.37.3
> >=20
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
