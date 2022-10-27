Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E93610604
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 00:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiJ0WzX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 18:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbiJ0WzW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 18:55:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEBC6C113
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 15:55:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E4D10219B9;
        Thu, 27 Oct 2022 22:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666911319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cW4o6DqIChSsjjhXEMnrFskC7Kt4dm+WxJzxe4Lzr3c=;
        b=BcJsAYMBiYKa3h3zi7mAsP9UVbj2uoDku/7YhY2Gq7SyoCif9TVu6D1JTdOlhXKrVkvU+s
        GPKuQ9nlixgufDR0qPToktu1/FB9KAsDNdO0t7EdG5wyd1DAa5l1bhYiKb6LIYisCgAZtB
        SYkDj+p4vNEknRWSB86fCBkxieS/Z90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666911319;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cW4o6DqIChSsjjhXEMnrFskC7Kt4dm+WxJzxe4Lzr3c=;
        b=hYDWLuhOOmGEsrxfrlFxavpT3JofgpPl3a4g1uW4nxeQ0EDsAzpXnNV4ZnpS4fEtGGHbbb
        t+IDlfN8Q9vJydCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B425A13357;
        Thu, 27 Oct 2022 22:55:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WrR1GlYMW2NkBQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 27 Oct 2022 22:55:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] nfsd: only keep unused entries on the LRU
In-reply-to: <dd3936feb109857040ad79e7da47d7b7e5732a41.camel@kernel.org>
References: <20221027215213.138304-1-jlayton@kernel.org>,
 <20221027215213.138304-3-jlayton@kernel.org>,
 <166690925944.13915.14734120966513564215@noble.neil.brown.name>,
 <dd3936feb109857040ad79e7da47d7b7e5732a41.camel@kernel.org>
Date:   Fri, 28 Oct 2022 09:55:15 +1100
Message-id: <166691131566.13915.14122113998554165159@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 28 Oct 2022, Jeff Layton wrote:
> On Fri, 2022-10-28 at 09:20 +1100, NeilBrown wrote:
> > On Fri, 28 Oct 2022, Jeff Layton wrote:
> > > Currently, nfsd_files live on the LRU once they are added until they are
> > > unhashed. There's no need to keep ones that are actively in use there.
> >=20
> > Is that true?
> > nfsd_file_do_acquire() calls nfsd_file_lru_remove()
> > Isn't that enough to keep the file off the lru while it is active?
> >=20
> > Thanks,
> > NeilBrown
> >=20
>=20
> After patch #1, it doesn't call that anymore. That's probably a (minor)
> regression then.

Yes, I eventually found that - thanks.

>=20
> After patch #1, the LRU holds a reference. If you successfully remove it
> from the LRU, you need to transfer or put that reference. Doing the LRU
> handling in the get and put routines seems more natural, I think.

Maybe.  But then you need a __get as well as a get.
Though it might seem asymmetric, I would prefer removing from the lru in
'acquire' and adding to the lru in put.

>=20
> Maybe I just need to squash this patch into #1?

Or do the "put" if lru_remove succeeds in the first patch.  Then revise
it all in the second.

Thanks,
NeilBrown


>=20
> >=20
> > >=20
> > > Before incrementing the refcount, do a lockless check for nf_lru being
> > > empty. If it's not then attempt to remove the entry from the LRU. If
> > > that's successful, claim the LRU reference and return it. If the removal
> > > fails (or if the list_head was empty), then just increment the counter
> > > as we normally would.
> > >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/filecache.c | 23 ++++++++++++++++++++---
> > >  1 file changed, 20 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index e63534f4b9f8..d2bbded805d4 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -420,14 +420,31 @@ nfsd_file_unhash(struct nfsd_file *nf)
> > >  	return false;
> > >  }
> > > =20
> > > -struct nfsd_file *
> > > -nfsd_file_get(struct nfsd_file *nf)
> > > +static struct nfsd_file *
> > > +__nfsd_file_get(struct nfsd_file *nf)
> > >  {
> > >  	if (likely(refcount_inc_not_zero(&nf->nf_ref)))
> > >  		return nf;
> > >  	return NULL;
> > >  }
> > > =20
> > > +struct nfsd_file *
> > > +nfsd_file_get(struct nfsd_file *nf)
> > > +{
> > > +	/*
> > > +	 * Do a lockless list_empty check first, before attempting to
> > > +	 * remove it, so we can avoid the spinlock when it's not on the
> > > +	 * list.
> > > +	 *
> > > +	 * If we successfully remove it from the LRU, then we can just
> > > +	 * claim the LRU reference and return it. Otherwise, we need to
> > > +	 * bump the counter the old-fashioned way.
> > > +	 */
> > > +	if (!list_empty(&nf->nf_lru) && nfsd_file_lru_remove(nf))
> > > +		return nf;
> > > +	return __nfsd_file_get(nf);
> > > +}
> > > +
> > >  /**
> > >   * nfsd_file_unhash_and_queue - unhash a file and queue it to the disp=
ose list
> > >   * @nf: nfsd_file to be unhashed and queued
> > > @@ -449,7 +466,7 @@ nfsd_file_unhash_and_queue(struct nfsd_file *nf, st=
ruct list_head *dispose)
> > >  		 * to take a reference. If that fails, just ignore
> > >  		 * the file altogether.
> > >  		 */
> > > -		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
> > > +		if (!nfsd_file_lru_remove(nf) && !__nfsd_file_get(nf))
> > >  			return false;
> > >  		list_add(&nf->nf_lru, dispose);
> > >  		return true;
> > > --=20
> > > 2.37.3
> > >=20
> > >=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
