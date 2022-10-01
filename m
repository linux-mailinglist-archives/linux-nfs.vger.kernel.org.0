Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F855F1B9C
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Oct 2022 11:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJAJzP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Oct 2022 05:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiJAJzO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Oct 2022 05:55:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3963F1E0
        for <linux-nfs@vger.kernel.org>; Sat,  1 Oct 2022 02:55:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E80DB60C08
        for <linux-nfs@vger.kernel.org>; Sat,  1 Oct 2022 09:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E009CC433D6;
        Sat,  1 Oct 2022 09:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664618111;
        bh=8EFVeNSQ4CVE+C3q/LTwY+gSdPfjEWBoIkfy02Cb7Xs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PaDvnmKqGeSg66CAKolqSKJp5vOhIKzpU2H4Bry3CHyBdXBzZZm7BeoOkW2SE9WRn
         wu06rQw4YZj/i9KasUauTdWn/NTx6y8fDAJ0ainuuWukzm56YR0FdDmGshN0wNyWn1
         yKyZ7SV+QB7JXuw+QUoTfGVdp3Whhe6rs6nxgEQNR7mEBgw8YORDsfqNHOPPkVkYoj
         huhmpi3MYd8dqD7rGybsMj0Cyvi8b01eV1WPcLKXSsZPPckgQrZnATuYNFADpx2Dsn
         Gu2rQM/OyG7FPcJcRkYoOUgpsqLcSh9hcGMMkBUl0Uuutd6hMiOp6MdeRIQrQNzH3O
         TKgwFO7TNkFeQ==
Message-ID: <ce698a4d057b596adeac2108d1b543172f3ed936.camel@kernel.org>
Subject: Re: [PATCH 2/3] nfsd: fix potential race in nfsd_file_close
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Date:   Sat, 01 Oct 2022 05:55:09 -0400
In-Reply-To: <166460061835.17572.12490851025838613566@noble.neil.brown.name>
References: <20220930191550.172087-1-jlayton@kernel.org>
        , <20220930191550.172087-3-jlayton@kernel.org>
         <166460061835.17572.12490851025838613566@noble.neil.brown.name>
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

On Sat, 2022-10-01 at 15:03 +1000, NeilBrown wrote:
> On Sat, 01 Oct 2022, Jeff Layton wrote:
> > Once we call nfsd_file_put, there is no guarantee that "nf" can still b=
e
> > safely accessed. That may have been the last reference.
> >=20
> > Change the code to instead check for whether nf_ref is 2 and then unhas=
h
> > it and put the reference if we're successful.
> >=20
> > We might occasionally race with another lookup and end up unhashing it
> > when it probably shouldn't have been, but that should hopefully be rare
> > and will just result in the competing lookup having to create a new
> > nfsd_file.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/filecache.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 6237715bd23e..58f4d9267f4a 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -461,12 +461,14 @@ nfsd_file_put(struct nfsd_file *nf)
> >   */
> >  void nfsd_file_close(struct nfsd_file *nf)
> >  {
> > -	nfsd_file_put(nf);
> > -	if (refcount_dec_if_one(&nf->nf_ref)) {
> > -		nfsd_file_unhash(nf);
> > -		nfsd_file_lru_remove(nf);
> > -		nfsd_file_free(nf);
> > +	/* One for the reference being put, and one for the hash */
> > +	if (refcount_read(&nf->nf_ref) =3D=3D 2) {
> > +		if (nfsd_file_unhash(nf))
> > +			nfsd_file_put_noref(nf);
> >  	}
> > +	/* put the ref for the stateid */
> > +	nfsd_file_put(nf);
> > +
>=20
> This looks racy. What if a get happens after the read and before the unha=
sh?
>=20

It depends on whether the "getter" sees the HASHED flag or not in
nfsd_file_do_acquire.

If HASHED is still set, then it'll get a reference to the old soon to be
unhashed nfsd_file. If it's no longer HASHED in nfsd_file_do_acquire, it
will fall into the "Did construction of this file fail?" case, and
either retry the lookup or return nfserr_jukebox.

Either is an acceptable outcome since this should presumably be a rare
occurrence.

> If we unhash the nfsd_file at last close, why does the hash table hold a
> counted reference at all?
> When it is hashed, set the NFSD_FILE_HASHED flag.  On last-put, if that
> flag is set, unhash it.
> If you want to unhash it earlier, test/clear the flag and delete from
> rhashtable.
>=20

That's not the way the refcounting works today and I don't see a clear
benefit to making that change. If you want to propose patches to rework
it, I'd be happy to review them though.

>=20
>=20
> >  }
> > =20
> >  struct nfsd_file *
> > --=20
> > 2.37.3
> >=20
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
