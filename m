Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890636105E5
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 00:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiJ0Wr1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 18:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiJ0Wr0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 18:47:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919BA72B41
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 15:47:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 123236256D
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 22:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0803BC433D6;
        Thu, 27 Oct 2022 22:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666910843;
        bh=uQIQgL/i/o3SU4H6HigdxeGh3ROWVFf5pWPuUAUnA50=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VwanglB1Ql30202W3HMCJoPUqiMqZMwJS4N2J2VrlI3wrTcG/+QgDEiUeagvErTQ3
         cfw0/97ltP7ETljnqcYYxoDWf6UxdJ1SWipJ+lCHvNdeXPAeJN3LTVECcQx6Bkagqg
         Cgb72K5+pPPrMqwukUivHztngmzxMpqjVtCrMNgKvUKFeVP5LwJDMAs6Qvmz/8KNwn
         kPxx+RRvBzFqwdwWx+/OLxR94IkMIliaN5PFku9CH54Loq+KvosKYoW4FnKWpPSVXt
         oMva5SvRIhK/+Zkf2R/2bb+Bb7yhWhPACgyvc9sCxhQsIhO5AGQh7SvLYJ8XVetBFp
         w0pkHq58jBdJw==
Message-ID: <dd3936feb109857040ad79e7da47d7b7e5732a41.camel@kernel.org>
Subject: Re: [PATCH v2 2/3] nfsd: only keep unused entries on the LRU
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Date:   Thu, 27 Oct 2022 18:47:21 -0400
In-Reply-To: <166690925944.13915.14734120966513564215@noble.neil.brown.name>
References: <20221027215213.138304-1-jlayton@kernel.org>
        , <20221027215213.138304-3-jlayton@kernel.org>
         <166690925944.13915.14734120966513564215@noble.neil.brown.name>
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

On Fri, 2022-10-28 at 09:20 +1100, NeilBrown wrote:
> On Fri, 28 Oct 2022, Jeff Layton wrote:
> > Currently, nfsd_files live on the LRU once they are added until they ar=
e
> > unhashed. There's no need to keep ones that are actively in use there.
>=20
> Is that true?
> nfsd_file_do_acquire() calls nfsd_file_lru_remove()
> Isn't that enough to keep the file off the lru while it is active?
>=20
> Thanks,
> NeilBrown
>=20

After patch #1, it doesn't call that anymore. That's probably a (minor)
regression then.

After patch #1, the LRU holds a reference. If you successfully remove it
from the LRU, you need to transfer or put that reference. Doing the LRU
handling in the get and put routines seems more natural, I think.

Maybe I just need to squash this patch into #1?

>=20
> >=20
> > Before incrementing the refcount, do a lockless check for nf_lru being
> > empty. If it's not then attempt to remove the entry from the LRU. If
> > that's successful, claim the LRU reference and return it. If the remova=
l
> > fails (or if the list_head was empty), then just increment the counter
> > as we normally would.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/filecache.c | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index e63534f4b9f8..d2bbded805d4 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -420,14 +420,31 @@ nfsd_file_unhash(struct nfsd_file *nf)
> >  	return false;
> >  }
> > =20
> > -struct nfsd_file *
> > -nfsd_file_get(struct nfsd_file *nf)
> > +static struct nfsd_file *
> > +__nfsd_file_get(struct nfsd_file *nf)
> >  {
> >  	if (likely(refcount_inc_not_zero(&nf->nf_ref)))
> >  		return nf;
> >  	return NULL;
> >  }
> > =20
> > +struct nfsd_file *
> > +nfsd_file_get(struct nfsd_file *nf)
> > +{
> > +	/*
> > +	 * Do a lockless list_empty check first, before attempting to
> > +	 * remove it, so we can avoid the spinlock when it's not on the
> > +	 * list.
> > +	 *
> > +	 * If we successfully remove it from the LRU, then we can just
> > +	 * claim the LRU reference and return it. Otherwise, we need to
> > +	 * bump the counter the old-fashioned way.
> > +	 */
> > +	if (!list_empty(&nf->nf_lru) && nfsd_file_lru_remove(nf))
> > +		return nf;
> > +	return __nfsd_file_get(nf);
> > +}
> > +
> >  /**
> >   * nfsd_file_unhash_and_queue - unhash a file and queue it to the disp=
ose list
> >   * @nf: nfsd_file to be unhashed and queued
> > @@ -449,7 +466,7 @@ nfsd_file_unhash_and_queue(struct nfsd_file *nf, st=
ruct list_head *dispose)
> >  		 * to take a reference. If that fails, just ignore
> >  		 * the file altogether.
> >  		 */
> > -		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
> > +		if (!nfsd_file_lru_remove(nf) && !__nfsd_file_get(nf))
> >  			return false;
> >  		list_add(&nf->nf_lru, dispose);
> >  		return true;
> > --=20
> > 2.37.3
> >=20
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
