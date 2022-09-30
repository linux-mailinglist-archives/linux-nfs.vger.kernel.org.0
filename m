Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090E85F12EE
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Sep 2022 21:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiI3TnK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Sep 2022 15:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiI3TnE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Sep 2022 15:43:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DD01710F9
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 12:43:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 177C0B829E5
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 19:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC7EC433C1;
        Fri, 30 Sep 2022 19:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664566977;
        bh=t+lqYNSMGK5Kogb0/qZD9oelOXwWQW7CClUXG1BETqo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uzv9ciq4gMIcUrRkSWowqJsHJp+v46xT203VsQn1li9QN5Iv1hHOi6MgPI2VcLzP7
         /EF6l5+tbkoKo/H20/q/UTIJdCWaSAy6XyxPHbblmPhV5s6N1MoPtki7dxatwFT5x/
         /ULh4kchxWHHqILrox8HmF0ZTju0ed9RaBscmrQpgELlLtArOPqij5R3ng1WDU944Z
         xUbphMBdbqadVXG2wCiaAmOI7tC/AtUjFj5W56jZRF4EuaV5cFAt5EB5IyIvqTNXuP
         hWEuK5jyzqn0IgsXFB8PAJM03BGmTPREW3YEjvEQtdrcTs3wxe9YxwCCAN2CV07gTC
         4ohVcALhdBsnA==
Message-ID: <649ea8a13435734a54fc6755bd6599c2cacc3a53.camel@kernel.org>
Subject: Re: [PATCH 3/3] nfsd: fix nfsd_file_unhash_and_dispose
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Fri, 30 Sep 2022 15:42:56 -0400
In-Reply-To: <71D7277C-4E90-476F-A381-BD13E264BA63@oracle.com>
References: <20220930191550.172087-1-jlayton@kernel.org>
         <20220930191550.172087-4-jlayton@kernel.org>
         <71D7277C-4E90-476F-A381-BD13E264BA63@oracle.com>
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

On Fri, 2022-09-30 at 19:29 +0000, Chuck Lever III wrote:
>=20
> > On Sep 30, 2022, at 3:15 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > This function is called two reasons:
> >=20
> > We're either shutting down and purging the filecache, or we've gotten a
> > notification about a file delete, so we want to go ahead and unhash it
> > so that it'll get cleaned up when we close.
> >=20
> > We're either walking the hashtable or doing a lookup in it and we
> > don't take a reference in either case. What we want to do in both cases
> > is to try and unhash the object and put it on the dispose list if that
> > was successful. If it's no longer hashed, then we don't want to touch
> > it, with the assumption being that something else is already cleaning
> > up the sentinel reference.
> >=20
> > Instead of trying to selectively decrement the refcount in this
> > function, just unhash it, and if that was successful, move it to the
> > dispose list. Then, the disposal routine will just clean that up as
> > usual.
> >=20
> > Also, just make this a void function, drop the WARN_ON_ONCE, and the
> > comments about deadlocking since the nature of the purported deadlock
> > is no longer clear.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/filecache.c | 32 ++++++--------------------------
> > 1 file changed, 6 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 58f4d9267f4a..16bd71a3894e 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -408,19 +408,14 @@ nfsd_file_unhash(struct nfsd_file *nf)
> > /*
> >  * Return true if the file was unhashed.
> >  */
>=20
> If you're changing the function to return void, the above
> comment is now stale.
>=20
> > -static bool
> > +static void
> > nfsd_file_unhash_and_dispose(struct nfsd_file *nf, struct list_head *di=
spose)
> > {
> > 	trace_nfsd_file_unhash_and_dispose(nf);
> > -	if (!nfsd_file_unhash(nf))
> > -		return false;
> > -	/* keep final reference for nfsd_file_lru_dispose */
>=20
> This comment has been stale since nfsd_file_lru_dispose() was
> renamed or removed. The only trouble I have is there isn't a
> comment left that explains why we're not decrementing the hash
> table reference here. ("don't have to" is enough to say about
> it, but there should be something).
>=20
>=20

How about this?

+       if (nfsd_file_unhash(nf)) {
+               /*
+                * Unhashing was successful. Transfer it to the dispose lis=
t
+                * so that we can put the sentinel reference for it later.
+                */
+               nfsd_file_lru_remove(nf);
+               list_add(&nf->nf_lru, dispose);
+       }


In this case, we're basically transferring the sentinel reference to the
"dispose" list. Later, we'll call nfsd_file_dispose_list and drop it.

Now that we don't have such onerous spinlocking in this code, we might
be able to just put each reference as we go instead of deferring it to a
list and putting them all at the end. That's probably best done later in
a separate patch however.


> > -	if (refcount_dec_not_one(&nf->nf_ref))
> > -		return true;
> > -
> > -	nfsd_file_lru_remove(nf);
> > -	list_add(&nf->nf_lru, dispose);
> > -	return true;
> > +	if (nfsd_file_unhash(nf)) {
> > +		nfsd_file_lru_remove(nf);
> > +		list_add(&nf->nf_lru, dispose);
> > +	}
> > }
> >=20
> > static void
> > @@ -564,8 +559,6 @@ nfsd_file_dispose_list_delayed(struct list_head *di=
spose)
> >  * @lock: LRU list lock (unused)
> >  * @arg: dispose list
> >  *
> > - * Note this can deadlock with nfsd_file_cache_purge.
> > - *
> >  * Return values:
> >  *   %LRU_REMOVED: @item was removed from the LRU
> >  *   %LRU_ROTATE: @item is to be moved to the LRU tail
> > @@ -750,8 +743,6 @@ nfsd_file_close_inode(struct inode *inode)
> >  *
> >  * Walk the LRU list and close any entries that have not been used sinc=
e
> >  * the last scan.
> > - *
> > - * Note this can deadlock with nfsd_file_cache_purge.
> >  */
> > static void
> > nfsd_file_delayed_close(struct work_struct *work)
> > @@ -893,16 +884,12 @@ nfsd_file_cache_init(void)
> > 	goto out;
> > }
> >=20
> > -/*
> > - * Note this can deadlock with nfsd_file_lru_cb.
> > - */
> > static void
> > __nfsd_file_cache_purge(struct net *net)
> > {
> > 	struct rhashtable_iter iter;
> > 	struct nfsd_file *nf;
> > 	LIST_HEAD(dispose);
> > -	bool del;
> >=20
> > 	rhashtable_walk_enter(&nfsd_file_rhash_tbl, &iter);
> > 	do {
> > @@ -912,14 +899,7 @@ __nfsd_file_cache_purge(struct net *net)
> > 		while (!IS_ERR_OR_NULL(nf)) {
> > 			if (net && nf->nf_net !=3D net)
> > 				continue;
> > -			del =3D nfsd_file_unhash_and_dispose(nf, &dispose);
> > -
> > -			/*
> > -			 * Deadlock detected! Something marked this entry as
> > -			 * unhased, but hasn't removed it from the hash list.
> > -			 */
> > -			WARN_ON_ONCE(!del);
> > -
> > +			nfsd_file_unhash_and_dispose(nf, &dispose);
> > 			nf =3D rhashtable_walk_next(&iter);
> > 		}
> >=20
> > --=20
> > 2.37.3
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
