Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ED161121F
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 15:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiJ1NBx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 09:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiJ1NBv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 09:01:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5F75FDD2
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 06:01:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6992062844
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 13:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D10AC433C1;
        Fri, 28 Oct 2022 13:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666962108;
        bh=gtLdtfk8X8Ts8aTOnA2TfG+8MKCo4F9YDnwuyjMTXMM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=U40QhOY/sBzAPL1L3gM+gn5SRlPzktq8CGg5lPT3yA1iQHT101Tr9OiucwO9yUCNK
         ofP9Uk2cmvp+LXflaqMsTnZORjwgZomh2ftGnx2q+zP1vJeyRBNXR9nYceQvYmslil
         mVCw9p5eIJaAkWuNHH2FQPIFXuc98AIvCvwtAj965u7vFofn6I4+PJedAb5DLGx0/X
         OiEempRBOcYt2TcO+/sti9pE5c7OuwjaME1HkD/ByyoeJZxb83xGx2gvmPsNIzHkyh
         H0BkrcOQoPmo4BuNh7GAZ/y0t9dqT1mfcvAW8g/uaAPpTKixCoDVmQYeEYQ1VNOZRz
         f/VWj4L5wozwQ==
Message-ID: <efe2a6483eee267a3ae55ec5b4f388a22194559e.camel@kernel.org>
Subject: Re: [PATCH v2 3/3] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Date:   Fri, 28 Oct 2022 09:01:47 -0400
In-Reply-To: <166690952613.13915.11556395606559286695@noble.neil.brown.name>
References: <20221027215213.138304-1-jlayton@kernel.org>
        , <20221027215213.138304-4-jlayton@kernel.org>
         <166690952613.13915.11556395606559286695@noble.neil.brown.name>
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

On Fri, 2022-10-28 at 09:25 +1100, NeilBrown wrote:
> On Fri, 28 Oct 2022, Jeff Layton wrote:
> > When a GC entry gets added to the LRU, kick off SYNC_NONE writeback
> > so that we can be ready to close it out when the time comes.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> This looks sensible.
> Reviewed-by: NeilBrown <neilb@suse.de>
>=20
> Thanks,
> NeilBrown
>=20
>=20
> > ---
> >  fs/nfsd/filecache.c | 37 +++++++++++++++++++++++++++++++------
> >  1 file changed, 31 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index d2bbded805d4..491d3d9a1870 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -316,7 +316,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, u=
nsigned int may)
> >  }
> > =20
> >  static void
> > -nfsd_file_flush(struct nfsd_file *nf)
> > +nfsd_file_fsync(struct nfsd_file *nf)
> >  {
> >  	struct file *file =3D nf->nf_file;
> > =20
> > @@ -327,6 +327,22 @@ nfsd_file_flush(struct nfsd_file *nf)
> >  		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> >  }
> > =20
> > +static void
> > +nfsd_file_flush(struct nfsd_file *nf)
> > +{
> > +	struct file *file =3D nf->nf_file;
> > +	unsigned long nrpages;
> > +
> > +	if (!file || !(file->f_mode & FMODE_WRITE))
> > +		return;
> > +
> > +	nrpages =3D file->f_mapping->nrpages;
> > +	if (nrpages) {
> >=20

I may change this to:

    if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {

I'm not sure here...Does nrpages count all of the pages in the mapping,
or just the dirty ones? I'm wondering if we're overcounting in
nfsd_file_pages_flushed?

> > +		this_cpu_add(nfsd_file_pages_flushed, nrpages);
> > +		filemap_flush(file->f_mapping);
> > +	}
> > +}
> > +
> >  static void
> >  nfsd_file_free(struct nfsd_file *nf)
> >  {
> > @@ -337,7 +353,7 @@ nfsd_file_free(struct nfsd_file *nf)
> >  	this_cpu_inc(nfsd_file_releases);
> >  	this_cpu_add(nfsd_file_total_age, age);
> > =20
> > -	nfsd_file_flush(nf);
> > +	nfsd_file_fsync(nf);
> > =20
> >  	if (nf->nf_mark)
> >  		nfsd_file_mark_put(nf->nf_mark);
> > @@ -500,12 +516,21 @@ nfsd_file_put(struct nfsd_file *nf)
> > =20
> >  	if (test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
> >  		/*
> > -		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
> > -		 * it to the LRU. If the add to the LRU fails, just put it as
> > -		 * usual.
> > +		 * If this is the last reference (nf_ref =3D=3D 1), then try
> > +		 * to transfer it to the LRU.
> > +		 */
> > +		if (refcount_dec_not_one(&nf->nf_ref))
> > +			return;
> > +
> > +		/*
> > +		 * If the add to the list succeeds, try to kick off SYNC_NONE
> > +		 * writeback. If the add fails, then just fall through to
> > +		 * decrement as usual.
> >  		 */
> > -		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
> > +		if (nfsd_file_lru_add(nf)) {
> > +			nfsd_file_flush(nf);
> >  			return;
> > +		}
> >  	}
> >  	__nfsd_file_put(nf);
> >  }
> > --=20
> > 2.37.3
> >=20
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
