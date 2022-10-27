Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDF360F46D
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 12:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbiJ0KE7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 06:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbiJ0KE5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 06:04:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239379A285
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 03:04:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6CEC62245
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 10:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A495DC433D6;
        Thu, 27 Oct 2022 10:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666865096;
        bh=qDOuZuUCf7X6r8d6T8hqXoSNCIEmF6gkrnv0Sm+gQvA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dxmEd0tjRdMbBndPk1X/mQvFsMcErc7NVS1y98gmXTYDOHm63V3c6dPdXSmhzV4Ge
         cLlUN02abMcjCDlCTvqTkdNNJyS6B6rLSfJKPLSurCN7EuNeT2llwyZMWgXAmjJl7d
         fsoKx7QTfgAn4xJ753/odVRb36RgbVY5IgMllbedo4TdWUvDx3WzEBH09+bdXS0UKu
         aRFIsYNYAHsmWhjoOiNNHl/r1j4IFXi4RxiUYd9daLONSy0KEsNFlHu4OdKsdOukO8
         oefPUR9kCBXWI5zIgZuHFswz3ngN6EYYIJA0MZgw/cEY+CXaonPA+y/KwY+278PbBI
         S3XzaFyMz+rAA==
Message-ID: <dd646ae5dec333240ec3b003cd776e309d7464f4.camel@kernel.org>
Subject: Re: [PATCH 2/2] nfsd: rework refcounting in filecache
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Date:   Thu, 27 Oct 2022 06:04:54 -0400
In-Reply-To: <166682352064.7585.2289386406163662548@noble.neil.brown.name>
References: <20221026081539.219755-1-jlayton@kernel.org>
        , <20221026081539.219755-2-jlayton@kernel.org>
         <166682352064.7585.2289386406163662548@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-10-27 at 09:32 +1100, NeilBrown wrote:
> On Wed, 26 Oct 2022, Jeff Layton wrote:
> > The filecache refcounting is a bit non-standard for something searchabl=
e
> > by RCU, in that we maintain a sentinel reference while it's hashed.
> > This in turn requires that we have to do things differently in the "put=
"
> > depending on whether its hashed, etc.
> >=20
> > Another issue: nfsd_file_close_inode_sync can end up freeing an
> > nfsd_file while there are still outstanding references to it.
> >=20
> > Rework the code so that the refcount is what drives the lifecycle. When
> > the refcount goes to zero, then unhash and rcu free the object.
>=20
> I think the lru reference needs to be counted.  Otherwise the nfsd_file
> will be freed (and removed from the LRU) as soon as not active request
> is referencing it (in the NFSv3 case).  This makes the LRU ineffective.
>=20
> Looking more closely at the patch, it seems to sometimes treat the LRU
> reference as counted, but sometimes not.
>=20
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/filecache.c | 202 ++++++++++++++++++++------------------------
> >  1 file changed, 92 insertions(+), 110 deletions(-)
> >=20
> > This passes some basic smoke testing and I think closes a number of
> > races in this code. I also think the result is a bit simpler and easier
> > to follow now.
> >=20
> > I looked for some ways to break this up into multiple patches, but I
> > didn't find any. This changes the underlying rules of how the
> > refcounting works, and I didn't see a way to split that up and still
> > have it remain bisectable.
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 918d67cec1ad..6c2f4f2c56a6 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -1,7 +1,6 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> > - * Open file cache.
> > - *
> > - * (c) 2015 - Jeff Layton <jeff.layton@primarydata.com>
> > + * The NFSD open file cache.
> >   */
> > =20
> >  #include <linux/hash.h>
> > @@ -303,8 +302,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, u=
nsigned int may)
> >  		if (key->gc)
> >  			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
> >  		nf->nf_inode =3D key->inode;
> > -		/* nf_ref is pre-incremented for hash table */
> > -		refcount_set(&nf->nf_ref, 2);
> > +		refcount_set(&nf->nf_ref, 1);
> >  		nf->nf_may =3D key->need;
> >  		nf->nf_mark =3D NULL;
> >  	}
> > @@ -376,11 +374,15 @@ nfsd_file_flush(struct nfsd_file *nf)
> >  		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> >  }
> > =20
> > -static void nfsd_file_lru_add(struct nfsd_file *nf)
> > +static bool nfsd_file_lru_add(struct nfsd_file *nf)
> >  {
> >  	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> > -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
> > +	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags) &&
>=20
>=20

Yes, I think this is just wrong. We do need to be able to put hashed
entries on the LRU.

>=20
> > +	    list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
> >  		trace_nfsd_file_lru_add(nf);
> > +		return true;
> > +	}
> > +	return false;
> >  }
> > =20
> >  static void nfsd_file_lru_remove(struct nfsd_file *nf)
> > @@ -410,7 +412,7 @@ nfsd_file_unhash(struct nfsd_file *nf)
> >  	return false;
> >  }
> > =20
> > -static void
> > +static bool
> >  nfsd_file_unhash_and_dispose(struct nfsd_file *nf, struct list_head *d=
ispose)
> >  {
> >  	trace_nfsd_file_unhash_and_dispose(nf);
> > @@ -418,46 +420,48 @@ nfsd_file_unhash_and_dispose(struct nfsd_file *nf=
, struct list_head *dispose)
> >  		/* caller must call nfsd_file_dispose_list() later */
> >  		nfsd_file_lru_remove(nf);
> >  		list_add(&nf->nf_lru, dispose);
> > +		return true;
> >  	}
> > +	return false;
> >  }
> > =20
> > -static void
> > -nfsd_file_put_noref(struct nfsd_file *nf)
> > +static bool
> > +__nfsd_file_put(struct nfsd_file *nf)
> >  {
> > -	trace_nfsd_file_put(nf);
> > -
> > +	/* v4 case: don't wait for GC */
>=20
> This comment suggests this code is only for the v4 case ....
>=20
> >  	if (refcount_dec_and_test(&nf->nf_ref)) {
> > -		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
> > +		nfsd_file_unhash(nf);
> >  		nfsd_file_lru_remove(nf);
>=20
> but v4 doesn't use the lru, so this line is pointless.
> And if the LRU does hold a counted reference, nf cannot possibly be on
> the LRU at this point.
>=20
> In fact, this function can be called for the v3 case, so the comment is
> just misleading .... or maybe the code is poorly structured.
>=20

Ok. I'll clean up the comments. We have the "normal" refcount put
codepath, and the v2/3 one where we add it to the LRU if the reference
is the last one.

> >  		nfsd_file_free(nf);
> > +		return true;
> >  	}
> > +	return false;
> >  }
> > =20
> > -static void
> > -nfsd_file_unhash_and_put(struct nfsd_file *nf)
> > -{
> > -	if (nfsd_file_unhash(nf))
> > -		nfsd_file_put_noref(nf);
> > -}
> > -
> > +/**
> > + * nfsd_file_put - put the reference to a nfsd_file
> > + * @nf: nfsd_file of which to put the reference
> > + *
> > + * Put a reference to a nfsd_file. In the v4 case, we just put the
> > + * reference immediately. In the v2/3 case, if the reference would be
> > + * the last one, the put it on the LRU instead to be cleaned up later.
> > + */
> >  void
> >  nfsd_file_put(struct nfsd_file *nf)
> >  {
> > -	might_sleep();
> > -
> > -	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D 1)
> > -		nfsd_file_lru_add(nf);
> > -	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
> > -		nfsd_file_unhash_and_put(nf);
> > +	trace_nfsd_file_put(nf);
> > =20
> > -	if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0) {
> > -		nfsd_file_flush(nf);
> > -		nfsd_file_put_noref(nf);
> > -	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=
=3D 1) {
> > -		nfsd_file_put_noref(nf);
> > -		nfsd_file_schedule_laundrette();
> > -	} else
> > -		nfsd_file_put_noref(nf);
> > +	/* NFSv2/3 case */
> > +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
> > +		/*
> > +		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
> > +		 * it to the LRU. If the add to the LRU fails, just put it as
> > +		 * usual.
> > +		 */
> > +		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
> > +			return;
>=20
> This is one place that looks like you are refcounting entries on the lru.
> If this is the last reference and you can transfer it to use LRU, then
> you don't need to drop the reference.
>=20

This is the only call to nfsd_file_lru_add. We only put an entry on the
LRU if it was a "gc" entry and the reference was the last one.

> > +	}
> > +	__nfsd_file_put(nf);
> >  }
> > =20
>=20
> NeilBrown

--=20
Jeff Layton <jlayton@kernel.org>
