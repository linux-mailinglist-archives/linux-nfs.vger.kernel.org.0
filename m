Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95C760B551
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 20:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJXSVE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 14:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiJXSUl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 14:20:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894A32892D4
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 10:01:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D383C611DE
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 16:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC172C433C1;
        Mon, 24 Oct 2022 16:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666630668;
        bh=tMLx2ghURjVpSRRmmIl7TeLn4//QuMdeI5jFZAA6Vvw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ouh0lbgeWFtneicQ5M49BjQ9A7a0uyqKc2W3n0I6Bj9yzntIbsBHbDxjthNGFgChv
         JvSwlqMs0XBIpS5CcP0RL/QzdHqnORXxabh0oqjWopeuBTu8ZIZienkdQoVOIEBQmQ
         DLRXlowiI71w+dWR4w9PWD7+OINvzOkUwdTD9Mvj/km8ESFDJwCwt8Z0tst/MkQAF+
         hj4t13PcNaFMyjUypwRcTRJLkVAl2xn4TNRA45wuA5E+yS+PdYbAuHBjBdD/gfzSN1
         bMQedlxt5Ki+EPQigLUSjqv+hjKKek4ZUefSKdk+kfm8fq7MS8WjKHGCACARxk5W3l
         U6PF2JVs8uC7g==
Message-ID: <3d86628c75009a4feb3d20804e6f190dee8b83a3.camel@kernel.org>
Subject: Re: [PATCH v4 3/7] NFSD: Add an NFSD_FILE_GC flag to enable
 nfsd_file garbage collection
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 24 Oct 2022 12:57:46 -0400
In-Reply-To: <166657883468.12462.7206160925496863213@noble.neil.brown.name>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>
        , <166612311828.1291.6808456808715954510.stgit@manet.1015granger.net>
         <166657883468.12462.7206160925496863213@noble.neil.brown.name>
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

On Mon, 2022-10-24 at 13:33 +1100, NeilBrown wrote:
> On Wed, 19 Oct 2022, Chuck Lever wrote:
> > NFSv4 operations manage the lifetime of nfsd_file items they use by
> > means of NFSv4 OPEN and CLOSE. Hence there's no need for them to be
> > garbage collected.
> >=20
> > Introduce a mechanism to enable garbage collection for nfsd_file
> > items used only by NFSv2/3 callers.
> >=20
> > Note that the change in nfsd_file_put() ensures that both CLOSE and
> > DELEGRETURN will actually close out and free an nfsd_file on last
> > reference of a non-garbage-collected file.
> >=20
> > Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D394
> > Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Tested-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/filecache.c |   61 +++++++++++++++++++++++++++++++++++++++++++=
++------
> >  fs/nfsd/filecache.h |    3 +++
> >  fs/nfsd/nfs3proc.c  |    4 ++-
> >  fs/nfsd/trace.h     |    3 ++-
> >  fs/nfsd/vfs.c       |    4 ++-
> >  5 files changed, 63 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index b7aa523c2010..87fce5c95726 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -63,6 +63,7 @@ struct nfsd_file_lookup_key {
> >  	struct net			*net;
> >  	const struct cred		*cred;
> >  	unsigned char			need;
> > +	unsigned char			gc:1;
> >  	enum nfsd_file_lookup_type	type;
> >  };
> > =20
> > @@ -162,6 +163,8 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_co=
mpare_arg *arg,
> >  			return 1;
> >  		if (!nfsd_match_cred(nf->nf_cred, key->cred))
> >  			return 1;
> > +		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
> > +			return 1;
> >  		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0)
> >  			return 1;
> >  		break;
> > @@ -297,6 +300,8 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, u=
nsigned int may)
> >  		nf->nf_flags =3D 0;
> >  		__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
> >  		__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
> > +		if (key->gc)
> > +			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
> >  		nf->nf_inode =3D key->inode;
> >  		/* nf_ref is pre-incremented for hash table */
> >  		refcount_set(&nf->nf_ref, 2);
> > @@ -428,16 +433,27 @@ nfsd_file_put_noref(struct nfsd_file *nf)
> >  	}
> >  }
> > =20
> > +static void
> > +nfsd_file_unhash_and_put(struct nfsd_file *nf)
> > +{
> > +	if (nfsd_file_unhash(nf))
> > +		nfsd_file_put_noref(nf);
> > +}
> > +
> >  void
> >  nfsd_file_put(struct nfsd_file *nf)
> >  {
> >  	might_sleep();
> > =20
> > -	nfsd_file_lru_add(nf);
> > +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D 1)
>=20
> Clearly this is a style choice on which sensible people might disagree,
> but I much prefer to leave out the "=3D=3D 1" That is what most callers i=
n
> fs/nfsd/ do - only exceptions are here in filecache.c.
> Even "!=3D 0" would be better than "=3D=3D 1".
> I think test_bit() is declared as a bool, but it is hard to be certain.
>=20
> > +		nfsd_file_lru_add(nf);
> > +	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
> > +		nfsd_file_unhash_and_put(nf);
>=20
> Tests on the value of a refcount are almost always racy.

Agreed, and there's a clear race above, now that I look more closely. If
nf_ref is 3 and two puts are racing then neither of them will call
nfsd_file_unhash_and_put. We really should be letting the outcome of the
decrement drive things (like you say below).

> I suspect there is an implication that as NFSD_FILE_GC is not set, this
> *must* be hashed which implies there is guaranteed to be a refcount from
> the hashtable.  So this is really a test to see if the pre-biased
> refcount is one.  The safe way to test if a refcount is 1 is dec_and_test=
.
>=20
> i.e. linkage from the hash table should not count as a reference (in the
> not-GC case).  Lookup in the hash table should fail if the found entry
> cannot achieve an inc_not_zero.  When dec_and_test says the refcount is
> zero, we remove from the hash table (certain that no new references will
> be taken).
>=20

This does seem a more sensible approach. That would go a long way toward
simplifying nfsd_file_put.

>=20
> > +
> >  	if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0) {
> >  		nfsd_file_flush(nf);
> >  		nfsd_file_put_noref(nf);
>=20
> This seems weird.  If the file was unhashed above (because nf_ref was
> 2), it would now not be flushed.  Why don't we want it to be flushed in
> that case?
>
> > -	} else if (nf->nf_file) {
> > +	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=
=3D 1) {
> >  		nfsd_file_put_noref(nf);
> >  		nfsd_file_schedule_laundrette();
> >  	} else
> > @@ -1017,12 +1033,14 @@ nfsd_file_is_cached(struct inode *inode)
> > =20
> >  static __be32
> >  nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > -		     unsigned int may_flags, struct nfsd_file **pnf, bool open)
> > +		     unsigned int may_flags, struct nfsd_file **pnf,
> > +		     bool open, int want_gc)
>=20
> I too would prefer "bool" for all intstance of gc and want_gc.
>=20
> NeilBrown

--=20
Jeff Layton <jlayton@kernel.org>
