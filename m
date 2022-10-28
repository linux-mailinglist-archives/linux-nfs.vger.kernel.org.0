Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15EB611B59
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 22:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJ1UE1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 16:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiJ1UE0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 16:04:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53983C4C06
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 13:04:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3DDA62A4C
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 20:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE25C433C1;
        Fri, 28 Oct 2022 20:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666987464;
        bh=PnxOJgVy7lSdCDYOe10bFRPKv8e/m6B9Vcor8b2k5j0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PnDE6PqVFLIi5u1dqkAJ+rZhjPvBU4tJis1A0BddwW5Q9P13TZNcV5AwIjyz5o751
         Fbk70SMtMoDd9W+83N+DEmrS7Pgk8hAOAZAaQTv6zleyasOrNLfNgwMmHVsAKF+2sv
         5iRC8Bzi+01YLB/TqDCIkYnwrWCAQE2vTzRi7pZkt8norVIQCi4godVntqFxYmEUcf
         hry6On6oQZDxUsZ6nMQwMA82IGSkM/QL8IVeVoKk7W4YaUjIGpdu8crMBwUWX+CGvb
         +PXlGphBYbUnowzbl6yoQoCL0puVzVfek2ND0II1Yncj4G/BGPyxjVN2er9sam5hxd
         Qr0nkdMkuZ0hg==
Message-ID: <e64b1d579f4846331fdedad9bcdfe5eb52a7105c.camel@kernel.org>
Subject: Re: [PATCH v3 3/4] nfsd: close race between unhashing and LRU
 addition
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Date:   Fri, 28 Oct 2022 16:04:22 -0400
In-Reply-To: <08778EE0-CBDC-467B-ACA6-9D8E6719E1BB@oracle.com>
References: <20221028185712.79863-1-jlayton@kernel.org>
         <20221028185712.79863-4-jlayton@kernel.org>
         <08778EE0-CBDC-467B-ACA6-9D8E6719E1BB@oracle.com>
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

On Fri, 2022-10-28 at 19:50 +0000, Chuck Lever III wrote:
>=20
> > On Oct 28, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > The list_lru_add and list_lru_del functions use list_empty checks to se=
e
> > whether the object is already on the LRU. That's fine in most cases, bu=
t
> > we occasionally repurpose nf_lru after unhashing. It's possible for an
> > LRU removal to remove it from a different list altogether if we lose a
> > race.
>=20
> I've never seen that happen. lru field re-use is actually used in other
> places in the kernel. Shouldn't we try to find and fix such races?
>=20
> Wasn't the idea to reduce the complexity of nfsd_file_put ?
>=20

It certainly seems theoretically possible here. Maybe those other places
have other ways to ensure that it doesn't occur. We are dealing with RCU
freed structures here, so we can't always rely on locks to keep things
nice and serialized.


FWIW, I left this as a separate patch just to illustrate the race and
fix, but we probably would want to squash this one into the first.

> > Add a new NFSD_FILE_LRU flag, which indicates that the object actually
> > resides on the LRU and not some other list. Use that when adding and
> > removing it from the LRU instead of just relying on list_empty checks.
> >=20
> > Add an extra HASHED check after adding the entry to the LRU. If it's no=
w
> > clear, just remove it from the LRU again and put the reference if that
> > remove is successful.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/filecache.c | 44 +++++++++++++++++++++++++++++---------------
> > fs/nfsd/filecache.h |  1 +
> > 2 files changed, 30 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index d928c5e38eeb..47cdc6129a7b 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -403,18 +403,22 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
> > static bool nfsd_file_lru_add(struct nfsd_file *nf)
> > {
> > 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> > -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
> > -		trace_nfsd_file_lru_add(nf);
> > -		return true;
> > +	if (!test_and_set_bit(NFSD_FILE_LRU, &nf->nf_flags)) {
> > +		if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
> > +			trace_nfsd_file_lru_add(nf);
> > +			return true;
> > +		}
> > 	}
> > 	return false;
> > }
> >=20
> > static bool nfsd_file_lru_remove(struct nfsd_file *nf)
> > {
> > -	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
> > -		trace_nfsd_file_lru_del(nf);
> > -		return true;
> > +	if (test_and_clear_bit(NFSD_FILE_LRU, &nf->nf_flags)) {
> > +		if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
> > +			trace_nfsd_file_lru_del(nf);
> > +			return true;
> > +		}
> > 	}
> > 	return false;
> > }
> > @@ -469,20 +473,30 @@ nfsd_file_put(struct nfsd_file *nf)
> > {
> > 	trace_nfsd_file_put(nf);
> >=20
> > -	/*
> > -	 * The HASHED check is racy. We may end up with the occasional
> > -	 * unhashed entry on the LRU, but they should get cleaned up
> > -	 * like any other.
> > -	 */
> > 	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
> > 	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> > 		/*
> > -		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
> > -		 * it to the LRU. If the add to the LRU fails, just put it as
> > -		 * usual.
> > +		 * If this is the last reference (nf_ref =3D=3D 1), then try to
> > +		 * transfer it to the LRU.
> > 		 */
> > -		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
> > +		if (refcount_dec_not_one(&nf->nf_ref))
> > 			return;
> > +
> > +		/* Try to add it to the LRU.  If that fails, decrement. */
> > +		if (nfsd_file_lru_add(nf)) {
> > +			/* If it's still hashed, we're done */
> > +			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
> > +				return;
> > +
> > +			/*
> > +			 * We're racing with unhashing, so try to remove it from
> > +			 * the LRU. If removal fails, then someone else already
> > +			 * has our reference and we're done. If it succeeds,
> > +			 * fall through to decrement.
> > +			 */
> > +			if (!nfsd_file_lru_remove(nf))
> > +				return;
> > +		}
> > 	}
> > 	if (refcount_dec_and_test(&nf->nf_ref))
> > 		nfsd_file_free(nf);
> > diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> > index b7efb2c3ddb1..e52ab7d5a44c 100644
> > --- a/fs/nfsd/filecache.h
> > +++ b/fs/nfsd/filecache.h
> > @@ -39,6 +39,7 @@ struct nfsd_file {
> > #define NFSD_FILE_PENDING	(1)
> > #define NFSD_FILE_REFERENCED	(2)
> > #define NFSD_FILE_GC		(3)
> > +#define NFSD_FILE_LRU		(4)	/* file is on LRU */
> > 	unsigned long		nf_flags;
> > 	struct inode		*nf_inode;	/* don't deref */
> > 	refcount_t		nf_ref;
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
