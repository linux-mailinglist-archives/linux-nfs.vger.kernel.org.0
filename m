Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE89675F24
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jan 2023 21:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjATUyh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Jan 2023 15:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjATUyg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Jan 2023 15:54:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0C54AA7F;
        Fri, 20 Jan 2023 12:54:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C372A62060;
        Fri, 20 Jan 2023 20:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88308C433EF;
        Fri, 20 Jan 2023 20:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674248074;
        bh=/vxzMc3pnw1lKVTUfCrVCZGqQ7pAoScnbYrmonrrXA8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KOQe+DgGwqbWKW3XmouWcQ8VZVGACK5qEwmd1CtwaqUUf9TOoSKIaaeQYfdfkL1v3
         B8mvi8/EdipeyXnOLx3d0dMgSQTmBKdqSEPaink6Q3OR0XbvuMesYXhUgb8Jnd24hA
         q+Lv/N96PyKRt3ACGF7KNBhDxnypTkAD4fpH5FaEHrIVM/vViVrMdo6LstPzPuLYW8
         ZGGs2f1MnFcy4Qj2Od9TBmiOqRbHbjjpU/I/olqXgFsq+RKz637+kI2/BNr3rnNtt5
         iR/itkAejyrck6pE8nw2Mh0nGOkEx1cqTzV9GtcD3QAYuSznVE9KJ7/P7pm+u987sV
         kZ6ef7BodNG+Q==
Message-ID: <d5dc64435fb82f17e79ae20a370e90914a291ea9.camel@kernel.org>
Subject: Re: [PATCH] nfsd: don't free files unconditionally in
 __nfsd_file_cache_purge
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Ruben Vestergaard <rubenv@drcmr.dk>,
        Torkil Svensgaard <torkil@drcmr.dk>,
        Shachar Kagan <skagan@nvidia.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 20 Jan 2023 15:54:32 -0500
In-Reply-To: <C04F7C2C-848A-47C5-9C4E-9B9E5E82BAFF@oracle.com>
References: <20230120195215.42243-1-jlayton@kernel.org>
         <C04F7C2C-848A-47C5-9C4E-9B9E5E82BAFF@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-01-20 at 20:21 +0000, Chuck Lever III wrote:
>=20
> > On Jan 20, 2023, at 2:52 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > nfsd_file_cache_purge is called when the server is shutting down, in
> > which case, tearing things down is generally fine, but it also gets
> > called when the exports cache is flushed.
>=20
> Yeah... cache flush is probably the case we've been missing.
>=20
>=20
> > Instead of walking the cache and freeing everything unconditionally,
> > handle it the same as when we have a notification of conflicting access=
.
> >=20
> > Fixes: ac3a2585f018 ("nfsd: rework refcounting in filecache")
> > Reported-by: Ruben Vestergaard <rubenv@drcmr.dk>
> > Reported-by: Torkil Svensgaard <torkil@drcmr.dk>
> > Reported-by: Shachar Kagan <skagan@nvidia.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/filecache.c | 61 +++++++++++++++++++++++++++------------------
> > 1 file changed, 37 insertions(+), 24 deletions(-)
> >=20
> > v2: use the same method to purge entries from the cache as we do when
> >    there is a notification of conflicting access.
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 58ac93e7e680..397ae212b98d 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -661,6 +661,40 @@ static struct shrinker	nfsd_file_shrinker =3D {
> > 	.seeks =3D 1,
> > };
> >=20
> > +/**
> > + * maybe_queue_nfsd_file - try to unhash and queue a nfsd_file to be f=
reed
> > + * @nf: nfsd_file to attempt to queue
> > + * @dispose: private list to queue successfully-put objects
> > + *
> > + * Unhash an nfsd_file, try to get a reference to it, and then put tha=
t
> > + * reference. If it's the last reference, queue it to the dispose list=
.
> > + *
> > + * The caller MUST hold the rcu_read_lock() !
>=20
> __nfsd_file_cache_purge() isn't holding rcu_read_lock(), it's
> holding the nfsd_mutex. Is this comment incorrect, or is it just
> too specific? Or did I miss something obvious?
>=20

It's implicitly taken by rhashtable_walk_start and released by
rhashtable_walk_stop.

FWIW, it'd be nice if there were a lockdep_assert_held equivalent for
the rcu_read_lock() here, but I didn't see one of those. There is a
rcu_read_lock_held(), but I didn't see a good way to get that to compile
out when lockdep was disabled.

>=20
> > + */
> > +static void
> > +maybe_queue_nfsd_file(struct nfsd_file *nf, struct list_head *dispose)
>=20
> I prefer the name nfsd_file_try_to_queue() or nfsd_file_try_to_dispose().
> nfsd_file_ should be the prefix where possible. Unless you're
> redriving, I can fix that.
>=20
>=20

Rename at will.

> > +{
> > +	int decrement =3D 1;
> > +
> > +	/* If we raced with someone else unhashing, ignore it */
> > +	if (!nfsd_file_unhash(nf))
> > +		return;
> > +
> > +	/* If we can't get a reference, ignore it */
> > +	if (!nfsd_file_get(nf))
> > +		return;
> > +
> > +	/* Extra decrement if we remove from the LRU */
> > +	if (nfsd_file_lru_remove(nf))
> > +		++decrement;
> > +
> > +	/* If refcount goes to 0, then put on the dispose list */
> > +	if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
> > +		list_add(&nf->nf_lru, dispose);
> > +		trace_nfsd_file_closing(nf);
> > +	}
> > +}
> > +
> > /**
> >  * nfsd_file_queue_for_close: try to close out any open nfsd_files for =
an inode
> >  * @inode:   inode on which to close out nfsd_files
> > @@ -688,30 +722,12 @@ nfsd_file_queue_for_close(struct inode *inode, st=
ruct list_head *dispose)
> >=20
> > 	rcu_read_lock();
> > 	do {
> > -		int decrement =3D 1;
> > -
> > 		nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
> > 				       nfsd_file_rhash_params);
> > 		if (!nf)
> > 			break;
> >=20
> > -		/* If we raced with someone else unhashing, ignore it */
> > -		if (!nfsd_file_unhash(nf))
> > -			continue;
> > -
> > -		/* If we can't get a reference, ignore it */
> > -		if (!nfsd_file_get(nf))
> > -			continue;
> > -
> > -		/* Extra decrement if we remove from the LRU */
> > -		if (nfsd_file_lru_remove(nf))
> > -			++decrement;
> > -
> > -		/* If refcount goes to 0, then put on the dispose list */
> > -		if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
> > -			list_add(&nf->nf_lru, dispose);
> > -			trace_nfsd_file_closing(nf);
> > -		}
> > +		maybe_queue_nfsd_file(nf, dispose);
> > 	} while (1);
> > 	rcu_read_unlock();
> > }
> > @@ -928,11 +944,8 @@ __nfsd_file_cache_purge(struct net *net)
> >=20
> > 		nf =3D rhashtable_walk_next(&iter);
> > 		while (!IS_ERR_OR_NULL(nf)) {
> > -			if (!net || nf->nf_net =3D=3D net) {
> > -				nfsd_file_unhash(nf);
> > -				nfsd_file_lru_remove(nf);
> > -				list_add(&nf->nf_lru, &dispose);
> > -			}
> > +			if (!net || nf->nf_net =3D=3D net)
> > +				maybe_queue_nfsd_file(nf, &dispose);
> > 			nf =3D rhashtable_walk_next(&iter);
> > 		}
> >=20
> > --=20
> > 2.39.0
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
