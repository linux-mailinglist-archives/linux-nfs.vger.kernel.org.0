Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B4B65EEBF
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 15:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjAEO3n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 09:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjAEO3n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 09:29:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCA511C
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 06:29:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CD99B81AD2
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 14:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18DBC433EF;
        Thu,  5 Jan 2023 14:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672928979;
        bh=xlxHI3WwchrHQY2X3lq5lgHJHTuF5SjrbR3wID4Gq98=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hjy/shyxY2Kvns6AIiKb2h1CAbilnHDe8Ze/R0CvDeZR/YhjGN+/xKqe5eW0ieTqI
         5gJl99e2dhHbdwOeYPHYABHGr/WHw0go3WvcnFfvlHr7fJ4sLfQOLy1HmqdlMJeJPm
         rRW5wbnWTsi8UJolb0O9bF/Ox8wlfP6YgrvwSJ++GPiD6stobvpgbfeQdNSPtvXRj7
         MLe4pa/tJeoPKhhldNRx0Ey1BsIfEkYnSYLwP9XNa/XgPBnp4CbkhCIvTqC9RlsPlA
         BcrE6CuTvt2qj41M20nVyKqw3mfcUWqn0ckqWjffRnjWx1Ds57Wwo5pawWgdmWO3u7
         JgPUVEABtSG4A==
Message-ID: <cba5f0b6f13a314d78f7c767d47a7b6fac7e5ebc.camel@kernel.org>
Subject: Re: [PATCH 2/4] nfsd: NFSD_FILE_KEY_INODE only needs to find GC'ed
 entries
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 05 Jan 2023 09:29:37 -0500
In-Reply-To: <22E267B9-BA8C-46BA-A76E-A7A72FA5D9B3@oracle.com>
References: <20230105121512.21484-1-jlayton@kernel.org>
         <20230105121512.21484-3-jlayton@kernel.org>
         <22E267B9-BA8C-46BA-A76E-A7A72FA5D9B3@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-01-05 at 14:18 +0000, Chuck Lever III wrote:
> Hi Jeff-
>=20
>=20
> > On Jan 5, 2023, at 7:15 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > Since v4 files are expected to be long-lived, there's little value in
> > closing them out of the cache when there is conflicting access.
>=20
> Seems like targeting long-lived nfsd_file items could actually
> be a hazardous behavior. Are you sure it's safe to leave it in
> stable kernels?
>=20

Basically it just means we end up doing more opens than are needed in
this situation.

The notifiers just unnecessarily unhash a nfsd_file in this case, even
though it doesn't have any chance of freeing it until the client issues
a CLOSE, due to the persistent references held by the stateids.

So, this really is just an optimization and not a "real bug".

>=20
> > Rename NFSD_FILE_KEY_INODE to NFSD_FILE_KEY_INODE_GC,
>=20
> I'd prefer to keep the name as it is. It's for searching for
> inodes, and adding the ".gc =3D true" to the search criteria is
> enough to show what you are looking for.
>=20

Ok.

>=20
> > and change the
> > comparator to also match the gc value in the key. Change both of the
> > current users of that key to set the gc value in the key to "true".
> >=20
> > Also, test_bit returns bool, AFAICT, so I think we're ok to drop the
> > !! from the condition later in the comparator.
>=20
> And I'd prefer that you leave this clean up for another patch.
>=20

Ok, I'll drop that hunk.

>=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/filecache.c | 14 +++++++++-----
> > 1 file changed, 9 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 9fff1fa09d08..a67b22579c6e 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -78,7 +78,7 @@ static struct rhashtable		nfsd_file_rhash_tbl
> > 						____cacheline_aligned_in_smp;
> >=20
> > enum nfsd_file_lookup_type {
> > -	NFSD_FILE_KEY_INODE,
> > +	NFSD_FILE_KEY_INODE_GC,
> > 	NFSD_FILE_KEY_FULL,
> > };
> >=20
> > @@ -174,7 +174,9 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_co=
mpare_arg *arg,
> > 	const struct nfsd_file *nf =3D ptr;
> >=20
> > 	switch (key->type) {
> > -	case NFSD_FILE_KEY_INODE:
> > +	case NFSD_FILE_KEY_INODE_GC:
> > +		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
> > +			return 1;
> > 		if (nf->nf_inode !=3D key->inode)
> > 			return 1;
> > 		break;
> > @@ -187,7 +189,7 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_co=
mpare_arg *arg,
> > 			return 1;
> > 		if (!nfsd_match_cred(nf->nf_cred, key->cred))
> > 			return 1;
> > -		if (!!test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
> > +		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
> > 			return 1;
> > 		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0)
> > 			return 1;
> > @@ -681,8 +683,9 @@ static void
> > nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispos=
e)
> > {
> > 	struct nfsd_file_lookup_key key =3D {
> > -		.type	=3D NFSD_FILE_KEY_INODE,
> > +		.type	=3D NFSD_FILE_KEY_INODE_GC,
> > 		.inode	=3D inode,
> > +		.gc	=3D true,
> > 	};
> > 	struct nfsd_file *nf;
> >=20
> > @@ -1057,8 +1060,9 @@ bool
> > nfsd_file_is_cached(struct inode *inode)
> > {
> > 	struct nfsd_file_lookup_key key =3D {
> > -		.type	=3D NFSD_FILE_KEY_INODE,
> > +		.type	=3D NFSD_FILE_KEY_INODE_GC,
> > 		.inode	=3D inode,
> > +		.gc	=3D true,
> > 	};
> > 	bool ret =3D false;
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
