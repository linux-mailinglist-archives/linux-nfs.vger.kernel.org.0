Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A3D5F1DBC
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Oct 2022 18:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJAQk3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Oct 2022 12:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJAQkV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Oct 2022 12:40:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A89D2B63B
        for <linux-nfs@vger.kernel.org>; Sat,  1 Oct 2022 09:40:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76472B8074E
        for <linux-nfs@vger.kernel.org>; Sat,  1 Oct 2022 16:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D73C433C1;
        Sat,  1 Oct 2022 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664642407;
        bh=387GQrCD0ln4HRZuzt6VwPKn3vL53vnfKQlSs+3cDq4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qviyN4Hmd5yJex8GjOGVkGG44u/ZRpoc4DMATkY/m0/G2qlvm00QwgKJSw6XGBcIC
         voLviGC/xw89Qvs/m9wk/JBRjaBbXsuB8Y2LtTOhXCt6Ie/yhF2+3+Duwa83cgX5F7
         a3OcVWW6iCsTuIJ+FBWjNY6fD9fwNXU3COR8vl91iId9TCJbmR6mJIZr74FTNa3yf/
         XRh2ktV1+kADxDX1JK0/e2lZdtHbUE2HoLmKuGaUuR7zThZY6b+qdQ9amPko0Ld9sE
         LB0Q7Rx1Rpr3ICkbStg7xNOjHCM5cwDqsqzcjx4pYStyVSiSyysQd9fhDMKIDAbHwt
         5yQyS1psWlCUg==
Message-ID: <00076e31d59e95f97dc6d049aea9b2f41e54be54.camel@kernel.org>
Subject: Re: [PATCH v2] nfsd: nfsd_do_file_acquire should hold rcu_read_lock
 while getting refs
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Date:   Sat, 01 Oct 2022 12:40:05 -0400
In-Reply-To: <CD650F11-FFCE-46A3-90B8-45C742D8B670@oracle.com>
References: <20221001095918.7546-1-jlayton@kernel.org>
         <CD650F11-FFCE-46A3-90B8-45C742D8B670@oracle.com>
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

On Sat, 2022-10-01 at 15:33 +0000, Chuck Lever III wrote:
> Hi Jeff-
>=20
> > On Oct 1, 2022, at 5:59 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > nfsd_file is RCU-freed, so it's possible that one could be found that's
> > in the process of being freed and the memory recycled. Ensure we hold
> > the rcu_read_lock while attempting to get a reference on the object.
>=20
> I'm OK with entertaining clean-up patches in this code, but I
> am skeptical that this patch addresses the concern enumerated
> in bug #394. As you've pointed out to me before, the "UAF on
> DELEGRETURN crashes" appeared well before v5.19, which is the
> kernel release where this bit of code was introduced.
>=20

Yeah, there may be more than one bug here. In any case, these patches
should close potential races, so I think we ought to take them.

>=20
> > Cc: NeilBrown <neilb@suse.de>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/filecache.c | 14 ++++++++------
> > 1 file changed, 8 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index d5c57360b418..f4f75ae2e4ea 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -1077,10 +1077,12 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
> >=20
> > retry:
> > 	/* Avoid allocation if the item is already in cache */
> > +	rcu_read_lock();
> > 	nf =3D rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
> > 				    nfsd_file_rhash_params);
> > 	if (nf)
> > 		nf =3D nfsd_file_get(nf);
> > +	rcu_read_unlock();
>=20
> Again:
>=20
>  657 static inline void *rhashtable_lookup_fast(
>  658         struct rhashtable *ht, const void *key,
>  659         const struct rhashtable_params params)
>  660 {
>  661         void *obj;
>  662=20
>  663         rcu_read_lock();
>  664         obj =3D rhashtable_lookup(ht, key, params);
>  665         rcu_read_unlock();
>  666=20
>  667         return obj;
>  668 }
>=20
> Since rhashtable_lookup() itself is a public API, please
> just call that in nfsd_file_do_acquire() after explicitly
> taking the RCU read lock.
>=20
>=20

Understood. Sorry I missed your point. I'll fix that up.

> > 	if (nf)
> > 		goto wait_for_construction;
> >=20
> > @@ -1090,21 +1092,21 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
> > 		goto out_status;
> > 	}
> >=20
> > +	rcu_read_lock();
> > 	nf =3D rhashtable_lookup_get_insert_key(&nfsd_file_rhash_tbl,
> > 					      &key, &new->nf_rhash,
> > 					      nfsd_file_rhash_params);
> > +	if (!IS_ERR_OR_NULL(nf)) {
> > +		nf =3D nfsd_file_get(nf);
>=20
> Note that nfsd_file_get() can still return NULL.
>=20

True, and that would leak. Good catch.

>=20
> > +		nfsd_file_slab_free(&new->nf_rcu);
>=20
> Why is the slab_free call now inside the RCU critical section?
> Granted this should be a rare case, but this adds unnecessary
> latency while the read lock is held.
>=20

Fair point.

>=20
> > +	}
> > +	rcu_read_unlock();
>=20
> Is there a problem replacing rhashtable_lookup_get_insert_key()
> with rhashtable_lookup_insert_key() and just retrying the normal
> lookup if insertion returns EEXIST? That way, an nfsd_file_get()
> is necessary only at the rhashtable_lookup() call site above.
>=20
>=20

I like this idea, and it allows for a rather nice cleanup of the code.
I'll send a v3 set after I've had a chance to do some testing.

> > 	if (!nf) {
> > 		nf =3D new;
>=20
> @new was just released above, so won't this set @nf to point
> to freed memory in some cases?
>=20
>=20
> > 		goto open_file;
> > 	}
> > 	if (IS_ERR(nf))
> > 		goto insert_err;
> > -	nf =3D nfsd_file_get(nf);
> > -	if (nf =3D=3D NULL) {
> > -		nf =3D new;
> > -		goto open_file;
> > -	}
> > -	nfsd_file_slab_free(&new->nf_rcu);
> >=20
> > wait_for_construction:
> > 	wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
> > --=20
> > 2.37.3
>=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
