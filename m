Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BC360D255
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 19:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiJYRSM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Oct 2022 13:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiJYRSM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Oct 2022 13:18:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6943159D7C
        for <linux-nfs@vger.kernel.org>; Tue, 25 Oct 2022 10:18:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8ACFB81DD6
        for <linux-nfs@vger.kernel.org>; Tue, 25 Oct 2022 17:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F245BC433C1;
        Tue, 25 Oct 2022 17:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666718288;
        bh=7SI3vXlBgGzuN0nCgxb3EjcBtkZq+sKp1i57A4WXs/g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cj+4xR4Xn73JK3T8sxp4vXuwfZnLFocXyDYL7EETKfw0NWE/vjmioZLNdrfrO/vtW
         62wnlRfBkZBOH35hhP7IdYqjsr3MMqGwSZ53VILmhTOe89eQaRXesUcWXCj/F2p6Gf
         efcrDHakk3tMnf7cLVEeqdQTOSnCZhlZXIkVumwyEgladuVVU9M6s/amynV6dH5OcI
         AqaEn7Uuxs/Sz/pJuLTHT+n93mrnbqhk32fJ+737Jnlc2CYRr8ZbzudVFJ45aErDyZ
         DLH8QwZamtHcTi6Iq8MWbUytE3fcrGrRKT4KR0pUt+mbKSWbYgCoz05axU/TGDma8n
         225hsx7+NNSQw==
Message-ID: <f1a68b015c51a411023be3d1f30516e1651a2083.camel@kernel.org>
Subject: Re: [PATCH v4 5/7] NFSD: Use rhashtable for managing nfs4_file
 objects
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 25 Oct 2022 13:18:06 -0400
In-Reply-To: <E948A44A-D36E-4591-ADD2-D3D8504FA2B3@oracle.com>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>
         <166612313084.1291.5764156173845222109.stgit@manet.1015granger.net>
         <166658201312.12462.15430126129561479021@noble.neil.brown.name>
         <51A1D02F-4BD7-4AA4-AB5A-6962D8708122@oracle.com>
         <166664893048.12462.2026765054120312799@noble.neil.brown.name>
         <E948A44A-D36E-4591-ADD2-D3D8504FA2B3@oracle.com>
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

On Mon, 2022-10-24 at 22:30 +0000, Chuck Lever III wrote:
>=20
> > On Oct 24, 2022, at 6:02 PM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Tue, 25 Oct 2022, Chuck Lever III wrote:
> > >=20
> > > > On Oct 23, 2022, at 11:26 PM, NeilBrown <neilb@suse.de> wrote:
> > > >=20
> > > > On Wed, 19 Oct 2022, Chuck Lever wrote:
> > > > > +/*
> > > > > + * The returned hash value is based solely on the address of an =
in-code
> > > > > + * inode, a pointer to a slab-allocated object. The entropy in s=
uch a
> > > > > + * pointer is concentrated in its middle bits.
> > > > > + */
> > > > > +static u32 nfs4_file_inode_hash(const struct inode *inode, u32 s=
eed)
> > > > > +{
> > > > > +	u32 k;
> > > > > +
> > > > > +	k =3D ((unsigned long)inode) >> L1_CACHE_SHIFT;
> > > > > +	return jhash2(&k, 1, seed);
> > > >=20
> > > > I still don't think this makes any sense at all.
> > > >=20
> > > >       return jhash2(&inode, sizeof(inode)/4, seed);
> > > >=20
> > > > uses all of the entropy, which is best for rhashtables.
> > >=20
> > > I don't really disagree, but the L1_CACHE_SHIFT was added at
> > > Al's behest. OK, I'll replace it.
> >=20
> > I think that was in a different context though.
> >=20
> > If you are using a simple fixed array of bucket-chains for a hash
> > table, then shifting down L1_CACHE_SHIFT and masking off the number of
> > bits to match the array size is a perfectly sensible hash function.  It
> > will occasionally produce longer chains, but no often.
> >=20
> > But rhashtables does something a bit different.  It mixes a seed into
> > the key as part of producing the hash, and assumes that if an
> > unfortunate distribution of keys results is a substantially non-uniform
> > distribution into buckets, then choosing a new random seed will
> > re-distribute the keys into buckets and will probably produce a more
> > uniform distribution.
> >=20
> > The purpose of this seed is (as I understand it) primarily focused on
> > network-faced hash tables where an attacker might be able to choose key=
s
> > that all hash to the same value.  The random seed will defeat the
> > attacker.
> >=20
> > When hashing inodes there is no opportunity for a deliberate attack, an=
d
> > we would probably be happy to not use a seed and accept the small
> > possibility of occasional long chains.  However the rhashtable code
> > doesn't offer us that option.  It insists on rehashing if any chain
> > exceeds 16.  So we need to provide a much entropy as we can, and mix th=
e
> > seed in as effectively as we can, to ensure that rehashing really works=
.
> >=20
> > > > > +static int nfs4_file_obj_cmpfn(struct rhashtable_compare_arg *ar=
g,
> > > > > +			       const void *ptr)
> > > > > +{
> > > > > +	const struct svc_fh *fhp =3D arg->key;
> > > > > +	const struct nfs4_file *fi =3D ptr;
> > > > > +
> > > > > +	return fh_match(&fi->fi_fhandle, &fhp->fh_handle) ? 0 : 1;
> > > > > +}
> > > >=20
> > > > This doesn't make sense.  Maybe the subtleties of rhl-tables are a =
bit
> > > > obscure.
> > > >=20
> > > > An rhltable is like an rhashtable except that insertion can never f=
ail.=20
> > > > Multiple entries with the same key can co-exist in a linked list.
> > > > Lookup does not return an entry but returns a linked list of entrie=
s.
> > > >=20
> > > > For the nfs4_file table this isn't really a good match (though I
> > > > previously thought it was).  Insertion must be able to fail if an e=
ntry
> > > > with the same filehandle exists.
> > >=20
> > > I think I've arrived at the same conclusion (about nfs4_file insertio=
n
> > > needing to fail for duplicate filehandles). That's more or less open-=
coded
> > > in my current revision of this work rather than relying on the behavi=
or
> > > of rhltable_insert().
> > >=20
> > >=20
> > > > One approach that might work would be to take the inode->i_lock aft=
er a
> > > > lookup fails then repeat the lookup and if it fails again, do the
> > > > insert.  This keeps the locking fine-grained but means we don't hav=
e to
> > > > depend on insert failing.
> > > >=20
> > > > So the hash and cmp functions would only look at the inode pointer.
> > > > If lookup returns something, we would walk the list calling fh_matc=
h()
> > > > to see if we have the right entry - all under RCU and using
> > > > refcount_inc_not_zero() when we find the matching filehandle.
> > >=20
> > > That's basically what's going on now. But I tried removing obj_cmpfn(=
)
> > > and the rhltable_init() failed outright, so it's still there like a
> > > vestigial organ.
> >=20
> > You need an obj_cmpfn if you have an obj_hashfn.  If you don't have
> > obj_hashfn and just provide hashfn and key_len, then you don't need the
> > cmpfn.
> >=20
> > If you have a cmpfn, just compare the inode (the same thing that you
> > hash) - don't compare the file handle.
> >=20
> > >=20
> > > If you now believe rhltable is not a good fit, I can revert all of th=
e
> > > rhltable changes and go back to rhashtable quite easily.
> >=20
> > I wasn't very clear, as I was still working out what I though.
> >=20
> > I think an rhashtable cannot work as you need two different keys, the
> > inode and the filehandle.
> >=20
> > I think rhltable can work but it needs help, particularly as it will
> > never fail an insertion.
> > The help we can provide is to take a lock, perform a lookup, then only
> > try to insert if the lookup failed (and we are still holding an
> > appropriate lock to stop another thread inserting).  Thus any time we
> > try an insert, we don't want it to fail.
> >=20
> > The lock I suggest is ->i_lock in the inode.
>=20
> I will give that a try next.
>=20
>=20
> > The rhltable should only consider the inode as a key, and should provid=
e
> > a linked list of nfs4_files with the same inode.
>=20
> The implementation I've arrived at is rhltable keyed on inode only.
> The bucket chains are searched with fh_match().
>=20
> I've gotten rid of all of the special obj_hash/cmp functions as a
> result of this simplification. If I've set up the rhashtable
> parameters correctly, the rhashtable code should use jhash/jhash2
> on the whole inode pointer by default.
>=20
>=20
> > We then code a linear search of this linked list (which is expected to
> > have one entry) to find if there is an entry with the required file
> > handle.
>=20
> I'm not sure about that expectation: multiple inode pointers could
> hash to the same bucket. Also, there are cases where multiple file
> handles refer to the same inode (the aliasing that a0ce48375a36
> ("nfsd: track filehandle aliasing in nfs4_files") tries to deal
> with).
>=20
> I will post what I have right now. It's not passing all tests due
> to very recent changes (and probably because of lack of insert
> serialization). We can pick up from there; I know I've likely missed
> some review comments still.
>=20
>=20

Thanks. I've started looking over this and some other changes, and found
at least a couple of problems with the existing code (not necessarily
due to your patches, fwiw):

1/ the nf_lru is the linkage to the LRU, but it's also used when we move
an object to a dispose list. I don't see anything that prevents you from
trying to add an entry back onto the LRU while it's still on a dispose
list (which could cause corruption). I think we need some clear rules
around how that field get used.

2/ nfsd_file_close_inode_sync can end up putting an nf onto the dispose
list without ensuring that nf_ref has gone to zero. I think there are
some situations where the file can end up being freed out from under a
valid reference due to that.

I'm working on some patches to clean this up along the lines of the
scheme Neil is advocating for. For now, I'm basing this on top of your
series.

> > An alternative is to not use a resizable table at all.  We could stick
> > with the table we currently have and make small changes.
> >=20
> > 1/ change the compare function to test the inode pointer first and only
> >   call fh_match when the inodes match.  This should make it much
> >   faster.
>=20
> I had the same thought, but this doesn't reduce the number of CPU
> cache misses I observed from long bucket chain walks. I'd prefer a
> solution that maintains small buckets.
>=20
>=20
> > 2/ Instead of using state_lock for locking, use a bit-spin-lock on the
> >   lsb of the bucket pointers in the array to lock each bucket.  This
> >   will substantially reduce locking conflicts.
> >=20
> > I don't see a big performance difference between this approach and the
> > rhltable approach.  It really depends which you would feel more
> > comfortable working with.  Would you rather work with common code which
> > isn't quite a perfect fit, or with private code that you have complete
> > control over?
>=20
> I think rhltable still has some legs, will keep chipping away at that.
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
