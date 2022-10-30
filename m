Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11C5612CFD
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Oct 2022 22:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJ3Vaf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Oct 2022 17:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJ3Vae (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Oct 2022 17:30:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0065A476
        for <linux-nfs@vger.kernel.org>; Sun, 30 Oct 2022 14:30:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4BDC220BCD;
        Sun, 30 Oct 2022 21:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667165401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GupDI+LJIte5j2XCDi52xlbNVSwRc3erK3qJarXu4tk=;
        b=slpMhKDwFN7D4v9W8oINSTqCR1aXETiX44d3I31z0TcxPaq3kGLLONW+9mKpwjsQikSJcS
        5bo0cjvqlttFG3Cqgr3MqIJks8Dn7dYM3H9SzPA3cDYncZnGlE2k3DIWVfSlFisFqratad
        RopGbyt5E9XHCWNU7GBPDmlz0xV9pxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667165401;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GupDI+LJIte5j2XCDi52xlbNVSwRc3erK3qJarXu4tk=;
        b=fqW14jqRn144Zexb/beo1ylLhaWTrZsUqDISK/Zh+XdvVC51XRqp7WECcyXrkUwOaqSdwH
        LdgtRhyIvpbOpeCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BEA3E13A37;
        Sun, 30 Oct 2022 21:29:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XDknHNfsXmMQOAAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 30 Oct 2022 21:29:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] nfsd: rework refcounting in filecache
In-reply-to: <166699528220.13915.13614496483708690068@noble.neil.brown.name>
References: <20221027215213.138304-1-jlayton@kernel.org>,
 <20221027215213.138304-2-jlayton@kernel.org>,
 <166691108885.13915.13997292493521001238@noble.neil.brown.name>,
 <e164a83246e311ffb5b22944d6fccd110c1494e2.camel@kernel.org>,
 <166699528220.13915.13614496483708690068@noble.neil.brown.name>
Date:   Mon, 31 Oct 2022 08:29:56 +1100
Message-id: <166716539608.13915.15238052137096510804@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 29 Oct 2022, NeilBrown wrote:
> On Fri, 28 Oct 2022, Jeff Layton wrote:
> > On Fri, 2022-10-28 at 09:51 +1100, NeilBrown wrote:
> > > On Fri, 28 Oct 2022, Jeff Layton wrote:
> > > > The filecache refcounting is a bit non-standard for something searcha=
ble
> > > > by RCU, in that we maintain a sentinel reference while it's hashed. T=
his
> > > > in turn requires that we have to do things differently in the "put"
> > > > depending on whether its hashed, which we believe to have led to race=
s.
> > > >=20
> > > > There are other problems in here too. nfsd_file_close_inode_sync can =
end
> > > > up freeing an nfsd_file while there are still outstanding references =
to
> > > > it, and the handling
> > >=20
> > > -EINTR ??? (you got interrupted and didn't finish the sentence?)
> > >=20
> >=20
> > Yes, I meant to go back and flesh that out, and forgot before posting.
> >=20
> > > >=20
> > > > Rework the code so that the refcount is what drives the lifecycle. Wh=
en
> > > > the refcount goes to zero, then unhash and rcu free the object.
> > > >=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  fs/nfsd/filecache.c | 291 +++++++++++++++++++++---------------------=
--
> > > >  fs/nfsd/trace.h     |   5 +-
> > > >  2 files changed, 144 insertions(+), 152 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > index 98c6b5f51bc8..e63534f4b9f8 100644
> > > > --- a/fs/nfsd/filecache.c
> > > > +++ b/fs/nfsd/filecache.c
> > > > @@ -1,6 +1,12 @@
> > > >  // SPDX-License-Identifier: GPL-2.0
> > > >  /*
> > > >   * The NFSD open file cache.
> > > > + *
> > > > + * Each nfsd_file is created in response to client activity -- eithe=
r regular
> > > > + * file I/O for v2/v3, or opening a file for v4. Files opened via v4=
 are
> > > > + * cleaned up as soon as their refcount goes to 0.  Entries for v2/v=
3 are
> > > > + * flagged with NFSD_FILE_GC. On their last put, they are added to t=
he LRU for
> > > > + * eventual disposal if they aren't used again within a short time p=
eriod.
> > > >   */
> > > > =20
> > > >  #include <linux/hash.h>
> > > > @@ -302,31 +308,43 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *ke=
y, unsigned int may)
> > > >  		if (key->gc)
> > > >  			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
> > > >  		nf->nf_inode =3D key->inode;
> > > > -		/* nf_ref is pre-incremented for hash table */
> > > > -		refcount_set(&nf->nf_ref, 2);
> > > > +		refcount_set(&nf->nf_ref, 1);
> > > >  		nf->nf_may =3D key->need;
> > > >  		nf->nf_mark =3D NULL;
> > > >  	}
> > > >  	return nf;
> > > >  }
> > > > =20
> > > > -static bool
> > > > +static void
> > > > +nfsd_file_flush(struct nfsd_file *nf)
> > > > +{
> > > > +	struct file *file =3D nf->nf_file;
> > > > +
> > > > +	if (!file || !(file->f_mode & FMODE_WRITE))
> > > > +		return;
> > > > +	this_cpu_add(nfsd_file_pages_flushed, file->f_mapping->nrpages);
> > > > +	if (vfs_fsync(file, 1) !=3D 0)
> > > > +		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> > > > +}
> > > > +
> > > > +static void
> > > >  nfsd_file_free(struct nfsd_file *nf)
> > > >  {
> > > >  	s64 age =3D ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
> > > > -	bool flush =3D false;
> > > > +
> > > > +	trace_nfsd_file_free(nf);
> > > > =20
> > > >  	this_cpu_inc(nfsd_file_releases);
> > > >  	this_cpu_add(nfsd_file_total_age, age);
> > > > =20
> > > > -	trace_nfsd_file_put_final(nf);
> > > > +	nfsd_file_flush(nf);
> > > > +
> > > >  	if (nf->nf_mark)
> > > >  		nfsd_file_mark_put(nf->nf_mark);
> > > >  	if (nf->nf_file) {
> > > >  		get_file(nf->nf_file);
> > > >  		filp_close(nf->nf_file, NULL);
> > > >  		fput(nf->nf_file);
> > > > -		flush =3D true;
> > > >  	}
> > > > =20
> > > >  	/*
> > > > @@ -334,10 +352,9 @@ nfsd_file_free(struct nfsd_file *nf)
> > > >  	 * WARN and leak it to preserve system stability.
> > > >  	 */
> > > >  	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
> > > > -		return flush;
> > > > +		return;
> > > > =20
> > > >  	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
> > > > -	return flush;
> > > >  }
> > > > =20
> > > >  static bool
> > > > @@ -363,29 +380,23 @@ nfsd_file_check_write_error(struct nfsd_file *n=
f)
> > > >  	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_e=
rr));
> > > >  }
> > > > =20
> > > > -static void
> > > > -nfsd_file_flush(struct nfsd_file *nf)
> > > > -{
> > > > -	struct file *file =3D nf->nf_file;
> > > > -
> > > > -	if (!file || !(file->f_mode & FMODE_WRITE))
> > > > -		return;
> > > > -	this_cpu_add(nfsd_file_pages_flushed, file->f_mapping->nrpages);
> > > > -	if (vfs_fsync(file, 1) !=3D 0)
> > > > -		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> > > > -}
> > > > -
> > > > -static void nfsd_file_lru_add(struct nfsd_file *nf)
> > > > +static bool nfsd_file_lru_add(struct nfsd_file *nf)
> > > >  {
> > > >  	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> > > > -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
> > > > +	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
> > > >  		trace_nfsd_file_lru_add(nf);
> > > > +		return true;
> > > > +	}
> > > > +	return false;
> > > >  }
> > > > =20
> > > > -static void nfsd_file_lru_remove(struct nfsd_file *nf)
> > > > +static bool nfsd_file_lru_remove(struct nfsd_file *nf)
> > > >  {
> > > > -	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru))
> > > > +	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
> > > >  		trace_nfsd_file_lru_del(nf);
> > > > +		return true;
> > > > +	}
> > > > +	return false;
> > > >  }
> > > > =20
> > > >  static void
> > > > @@ -409,94 +420,89 @@ nfsd_file_unhash(struct nfsd_file *nf)
> > > >  	return false;
> > > >  }
> > > > =20
> > > > -static void
> > > > -nfsd_file_unhash_and_dispose(struct nfsd_file *nf, struct list_head =
*dispose)
> > > > +struct nfsd_file *
> > > > +nfsd_file_get(struct nfsd_file *nf)
> > > >  {
> > > > -	trace_nfsd_file_unhash_and_dispose(nf);
> > > > +	if (likely(refcount_inc_not_zero(&nf->nf_ref)))
> > > > +		return nf;
> > > > +	return NULL;
> > > > +}
> > > > +
> > > > +/**
> > > > + * nfsd_file_unhash_and_queue - unhash a file and queue it to the di=
spose list
> > > > + * @nf: nfsd_file to be unhashed and queued
> > > > + * @dispose: list to which it should be queued
> > > > + *
> > > > + * Attempt to unhash a nfsd_file and queue it to the given list. Eac=
h file
> > > > + * will have a reference held on behalf of the list. That reference =
may come
> > > > + * from the LRU, or we may need to take one. If we can't get a refer=
ence,
> > > > + * ignore it altogether.
> > > > + */
> > > > +static bool
> > > > +nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *d=
ispose)
> > > > +{
> > > > +	trace_nfsd_file_unhash_and_queue(nf);
> > > >  	if (nfsd_file_unhash(nf)) {
> > > > -		/* caller must call nfsd_file_dispose_list() later */
> > > > -		nfsd_file_lru_remove(nf);
> > > > +		/*
> > > > +		 * If we remove it from the LRU, then just use that
> > > > +		 * reference for the dispose list. Otherwise, we need
> > > > +		 * to take a reference. If that fails, just ignore
> > > > +		 * the file altogether.
> > > > +		 */
> > > > +		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
> > > > +			return false;
> > > >  		list_add(&nf->nf_lru, dispose);
> > > > +		return true;
> > > >  	}
> > > > +	return false;
> > > >  }
> > > > =20
> > > > -static void
> > > > -nfsd_file_put_noref(struct nfsd_file *nf)
> > > > +static bool
> > > > +__nfsd_file_put(struct nfsd_file *nf)
> > >=20
> > > The return value of this function is never tested.
> > > Maybe it should return void.
> > >=20
> > > Further, I don't think this is a useful abstraction.
> > > I would rather move the refcount_dec_and_test to the caller, and move
> > > the lru_remove and unash into nfsd_file_free.
> > >=20
> >=20
> > Ok, sounds reasonable.
> >=20
> > > >  {
> > > > -	trace_nfsd_file_put(nf);
> > > > -
> > > >  	if (refcount_dec_and_test(&nf->nf_ref)) {
> > > > -		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
> > > > -		nfsd_file_lru_remove(nf);
> > > > +		nfsd_file_unhash(nf);
> > > >  		nfsd_file_free(nf);
> > > > +		return true;
> > > >  	}
> > > > +	return false;
> > > >  }
> > > > =20
> > > > -static void
> > > > -nfsd_file_unhash_and_put(struct nfsd_file *nf)
> > > > -{
> > > > -	if (nfsd_file_unhash(nf))
> > > > -		nfsd_file_put_noref(nf);
> > > > -}
> > > > -
> > > > +/**
> > > > + * nfsd_file_put - put the reference to a nfsd_file
> > > > + * @nf: nfsd_file of which to put the reference
> > > > + *
> > > > + * Put a reference to a nfsd_file. In the v4 case, we just put the
> > > > + * reference immediately. In the v2/3 case, if the reference would be
> > > > + * the last one, the put it on the LRU instead to be cleaned up late=
r.
> > > > + */
> > > >  void
> > > >  nfsd_file_put(struct nfsd_file *nf)
> > > >  {
> > > > -	might_sleep();
> > > > -
> > > > -	if (test_bit(NFSD_FILE_GC, &nf->nf_flags))
> > > > -		nfsd_file_lru_add(nf);
> > > > -	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
> > > > -		nfsd_file_unhash_and_put(nf);
> > > > -
> > > > -	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> > > > -		nfsd_file_flush(nf);
> > > > -		nfsd_file_put_noref(nf);
> > > > -	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
> > > > -		nfsd_file_put_noref(nf);
> > > > -		nfsd_file_schedule_laundrette();
> > > > -	} else
> > > > -		nfsd_file_put_noref(nf);
> > > > -}
> > > > -
> > > > -struct nfsd_file *
> > > > -nfsd_file_get(struct nfsd_file *nf)
> > > > -{
> > > > -	if (likely(refcount_inc_not_zero(&nf->nf_ref)))
> > > > -		return nf;
> > > > -	return NULL;
> > > > -}
> > > > -
> > > > -static void
> > > > -nfsd_file_dispose_list(struct list_head *dispose)
> > > > -{
> > > > -	struct nfsd_file *nf;
> > > > +	trace_nfsd_file_put(nf);
> > > > =20
> > > > -	while(!list_empty(dispose)) {
> > > > -		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> > > > -		list_del_init(&nf->nf_lru);
> > > > -		nfsd_file_flush(nf);
> > > > -		nfsd_file_put_noref(nf);
> > > > +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
> > >=20
> > > I would prefer this included a test on NFSD_FILE_HASHED as well so that
> > > if the file isn't hashed, we don't consider it for the lru.
> > > This would me we can simple called nfsd_file_put() for things on the
> > > dispose list, rather then needing __nfsd_file_put()
> > >=20
> >=20
> > I had an incorrectly reversed test for that in the previous version in
> > nfsd_file_lru_add and you mentioned that it was racy. Why would that not
> > be the case here?
>=20
> It accept there is an apparent hypocrisy there :-)
> This proposed test isn't racy because of the intent.
> The intent isn't to ensure unhashed files never go onto the lru.
> The intent is to ensure that if I unhash a file and then call put(),
> then the file won't be put on the LRU.
>=20
> Any code that calls nfsd_file_unhash() will either hold a reference, or
> has just dropped the last reference.  In either case it can be certain
> that no other thread will drop the last reference, so no other thread
> can cause the file to be added to the lru.

This last bit is wrong.  The logic would only hold if the test on HASHED
was performed after refcount_dec_and_test has succeeded.  As we test
before I think it still could race.

I don't think that race is important though.  Maybe something will get
added to the lru after it has been unhashed.  But any code that wants it
unhashed and gone from the lru will explicitly do that and it will
succeed.
In the worst case, an unhashed file will remain on the lru for a while,
then get discarded.

Thanks,
NeilBrown


>=20
> So in actual fact it is not racy - I was wrong before.
>=20
> >=20
> > > > +		/*
> > > > +		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
> > > > +		 * it to the LRU. If the add to the LRU fails, just put it as
> > > > +		 * usual.
> > > > +		 */
> > > > +		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
> > > > +			return;
> > > >  	}
> > > > +	__nfsd_file_put(nf);
> > >=20
> > > As suggested above, this would become
> > >    if (refcount_dec_and_test(&nf->nf_ref))
> > > 	nfsd_file_free(nf);
> > >=20
> >=20
> > Ok.
> >=20
> > > >  }
> > > > =20
> > > >  static void
> > > > -nfsd_file_dispose_list_sync(struct list_head *dispose)
> > > > +nfsd_file_dispose_list(struct list_head *dispose)
> > > >  {
> > > > -	bool flush =3D false;
> > > >  	struct nfsd_file *nf;
> > > > =20
> > > >  	while(!list_empty(dispose)) {
> > > >  		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> > > >  		list_del_init(&nf->nf_lru);
> > > > -		nfsd_file_flush(nf);
> > > > -		if (!refcount_dec_and_test(&nf->nf_ref))
> > > > -			continue;
> > > > -		if (nfsd_file_free(nf))
> > > > -			flush =3D true;
> > > > +		nfsd_file_free(nf);
> > > >  	}
> > > > -	if (flush)
> > > > -		flush_delayed_fput();
> > > >  }
> > > > =20
> > > >  static void
> > > > @@ -566,21 +572,8 @@ nfsd_file_lru_cb(struct list_head *item, struct =
list_lru_one *lru,
> > > >  	struct list_head *head =3D arg;
> > > >  	struct nfsd_file *nf =3D list_entry(item, struct nfsd_file, nf_lru);
> > > > =20
> > > > -	/*
> > > > -	 * Do a lockless refcount check. The hashtable holds one reference,=
 so
> > > > -	 * we look to see if anything else has a reference, or if any have
> > > > -	 * been put since the shrinker last ran. Those don't get unhashed a=
nd
> > > > -	 * released.
> > > > -	 *
> > > > -	 * Note that in the put path, we set the flag and then decrement the
> > > > -	 * counter. Here we check the counter and then test and clear the f=
lag.
> > > > -	 * That order is deliberate to ensure that we can do this locklessl=
y.
> > > > -	 */
> > > > -	if (refcount_read(&nf->nf_ref) > 1) {
> > > > -		list_lru_isolate(lru, &nf->nf_lru);
> > > > -		trace_nfsd_file_gc_in_use(nf);
> > > > -		return LRU_REMOVED;
> > > > -	}
> > > > +	/* We should only be dealing with v2/3 entries here */
> > > > +	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
> > > > =20
> > > >  	/*
> > > >  	 * Don't throw out files that are still undergoing I/O or
> > > > @@ -591,40 +584,30 @@ nfsd_file_lru_cb(struct list_head *item, struct=
 list_lru_one *lru,
> > > >  		return LRU_SKIP;
> > > >  	}
> > > > =20
> > > > +	/* If it was recently added to the list, skip it */
> > > >  	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
> > > >  		trace_nfsd_file_gc_referenced(nf);
> > > >  		return LRU_ROTATE;
> > > >  	}
> > > > =20
> > > > -	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> > > > -		trace_nfsd_file_gc_hashed(nf);
> > > > -		return LRU_SKIP;
> > > > +	/*
> > > > +	 * Put the reference held on behalf of the LRU. If it wasn't the la=
st
> > > > +	 * one, then just remove it from the LRU and ignore it.
> > > > +	 */
> > > > +	if (!refcount_dec_and_test(&nf->nf_ref)) {
> > > > +		trace_nfsd_file_gc_in_use(nf);
> > > > +		list_lru_isolate(lru, &nf->nf_lru);
> > > > +		return LRU_REMOVED;
> > > >  	}
> > > > =20
> > > > +	/* Refcount went to zero. Unhash it and queue it to the dispose lis=
t */
> > > > +	nfsd_file_unhash(nf);
> > > >  	list_lru_isolate_move(lru, &nf->nf_lru, head);
> > > >  	this_cpu_inc(nfsd_file_evictions);
> > > >  	trace_nfsd_file_gc_disposed(nf);
> > > >  	return LRU_REMOVED;
> > > >  }
> > > > =20
> > > > -/*
> > > > - * Unhash items on @dispose immediately, then queue them on the
> > > > - * disposal workqueue to finish releasing them in the background.
> > > > - *
> > > > - * cel: Note that between the time list_lru_shrink_walk runs and
> > > > - * now, these items are in the hash table but marked unhashed.
> > > > - * Why release these outside of lru_cb ? There's no lock ordering
> > > > - * problem since lru_cb currently takes no lock.
> > > > - */
> > > > -static void nfsd_file_gc_dispose_list(struct list_head *dispose)
> > > > -{
> > > > -	struct nfsd_file *nf;
> > > > -
> > > > -	list_for_each_entry(nf, dispose, nf_lru)
> > > > -		nfsd_file_hash_remove(nf);
> > > > -	nfsd_file_dispose_list_delayed(dispose);
> > > > -}
> > > > -
> > > >  static void
> > > >  nfsd_file_gc(void)
> > > >  {
> > > > @@ -634,7 +617,7 @@ nfsd_file_gc(void)
> > > >  	ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> > > >  			    &dispose, list_lru_count(&nfsd_file_lru));
> > > >  	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> > > > -	nfsd_file_gc_dispose_list(&dispose);
> > > > +	nfsd_file_dispose_list_delayed(&dispose);
> > > >  }
> > > > =20
> > > >  static void
> > > > @@ -659,7 +642,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shr=
ink_control *sc)
> > > >  	ret =3D list_lru_shrink_walk(&nfsd_file_lru, sc,
> > > >  				   nfsd_file_lru_cb, &dispose);
> > > >  	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru=
));
> > > > -	nfsd_file_gc_dispose_list(&dispose);
> > > > +	nfsd_file_dispose_list_delayed(&dispose);
> > > >  	return ret;
> > > >  }
> > > > =20
> > > > @@ -670,8 +653,11 @@ static struct shrinker	nfsd_file_shrinker =3D {
> > > >  };
> > > > =20
> > > >  /*
> > > > - * Find all cache items across all net namespaces that match @inode =
and
> > > > - * move them to @dispose. The lookup is atomic wrt nfsd_file_acquire=
().
> > > > + * Find all cache items across all net namespaces that match @inode,=
 unhash
> > > > + * them, take references and then put them on @dispose if that was s=
uccessful.
> > > > + *
> > > > + * The nfsd_file objects on the list will be unhashed, and each will=
 have a
> > > > + * reference taken.
> > > >   */
> > > >  static unsigned int
> > > >  __nfsd_file_close_inode(struct inode *inode, struct list_head *dispo=
se)
> > > > @@ -689,52 +675,58 @@ __nfsd_file_close_inode(struct inode *inode, st=
ruct list_head *dispose)
> > > >  				       nfsd_file_rhash_params);
> > > >  		if (!nf)
> > > >  			break;
> > > > -		nfsd_file_unhash_and_dispose(nf, dispose);
> > > > -		count++;
> > > > +
> > > > +		if (nfsd_file_unhash_and_queue(nf, dispose))
> > > > +			count++;
> > > >  	} while (1);
> > > >  	rcu_read_unlock();
> > > >  	return count;
> > > >  }
> > > > =20
> > > >  /**
> > > > - * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
> > > > + * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
> > > >   * @inode: inode of the file to attempt to remove
> > > >   *
> > > > - * Unhash and put, then flush and fput all cache items associated wi=
th @inode.
> > > > + * Unhash and put all cache item associated with @inode.
> > > >   */
> > > > -void
> > > > -nfsd_file_close_inode_sync(struct inode *inode)
> > > > +static unsigned int
> > > > +nfsd_file_close_inode(struct inode *inode)
> > > >  {
> > > > -	LIST_HEAD(dispose);
> > > > +	struct nfsd_file *nf;
> > > >  	unsigned int count;
> > > > +	LIST_HEAD(dispose);
> > > > =20
> > > >  	count =3D __nfsd_file_close_inode(inode, &dispose);
> > > > -	trace_nfsd_file_close_inode_sync(inode, count);
> > > > -	nfsd_file_dispose_list_sync(&dispose);
> > > > +	trace_nfsd_file_close_inode(inode, count);
> > > > +	if (count) {
> > > > +		while(!list_empty(&dispose)) {
> > > > +			nf =3D list_first_entry(&dispose, struct nfsd_file, nf_lru);
> > > > +			list_del_init(&nf->nf_lru);
> > > > +			trace_nfsd_file_closing(nf);
> > > > +			__nfsd_file_put(nf);
> > >=20
> > > If nfsd_file_put() didn't add unhashed files to the lru, this can be
> > > nfsd_file_put().=20
> > >=20
> > > > +		}
> > > > +	}
> > > > +	return count;
> > > >  }
> > > > =20
> > > >  /**
> > > > - * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
> > > > + * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
> > > >   * @inode: inode of the file to attempt to remove
> > > >   *
> > > > - * Unhash and put all cache item associated with @inode.
> > > > + * Unhash and put, then flush and fput all cache items associated wi=
th @inode.
> > > >   */
> > > > -static void
> > > > -nfsd_file_close_inode(struct inode *inode)
> > > > +void
> > > > +nfsd_file_close_inode_sync(struct inode *inode)
> > > >  {
> > > > -	LIST_HEAD(dispose);
> > > > -	unsigned int count;
> > > > -
> > > > -	count =3D __nfsd_file_close_inode(inode, &dispose);
> > > > -	trace_nfsd_file_close_inode(inode, count);
> > > > -	nfsd_file_dispose_list_delayed(&dispose);
> > > > +	if (nfsd_file_close_inode(inode))
> > > > +		flush_delayed_fput();
> > > >  }
> > > > =20
> > > >  /**
> > > >   * nfsd_file_delayed_close - close unused nfsd_files
> > > >   * @work: dummy
> > > >   *
> > > > - * Walk the LRU list and close any entries that have not been used s=
ince
> > > > + * Walk the LRU list and destroy any entries that have not been used=
 since
> > > >   * the last scan.
> > > >   */
> > > >  static void
> > > > @@ -892,7 +884,7 @@ __nfsd_file_cache_purge(struct net *net)
> > > >  		while (!IS_ERR_OR_NULL(nf)) {
> > > >  			if (net && nf->nf_net !=3D net)
> > > >  				continue;
> > > > -			nfsd_file_unhash_and_dispose(nf, &dispose);
> > > > +			nfsd_file_unhash_and_queue(nf, &dispose);
> > > >  			nf =3D rhashtable_walk_next(&iter);
> > > >  		}
> > > > =20
> > > > @@ -1093,11 +1085,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, =
struct svc_fh *fhp,
> > > >  			goto out;
> > > >  		}
> > > >  		open_retry =3D false;
> > > > -		nfsd_file_put_noref(nf);
> > > > +		__nfsd_file_put(nf);
> > >=20
> > > This nf is not hashed, and I think it has no other reference.  So we
> > > could use nfsd_file_free() - but nfsd_file_put() would be just as good
> > > and safer.
> > >=20
> > > >  		goto retry;
> > > >  	}
> > > > =20
> > > > -	nfsd_file_lru_remove(nf);
> > >=20
> > > Hmmm...  why not remove from the lru.  I guess this justifies patch 2/3,
> > > but it might be cleaner to make this
> > >=20
> > >   if (nfsd_file_lru_remove(nf))
> > >         nffsd_file_put(nf);
> > > ??
> > >=20
> >=20
> > Removing from the LRU means putting a reference now. The last "put" of a
> > nfsd_file can be rather expensive (you might need to flush data, and
> > issue a close()).
>=20
> True, but irrelevant.  nfsd_file_do_acquire() already holds a reference.
> If it succeeds at removing from the LRU, it now holds 2 references.  If
> it puts one, then it won't be that last "put", and so will be cheap.
>=20
> I don't object to the way you have don't it - if ! lru_remove then get -
> but it isn't necessary.  You can just to the get - then if lru_remove,
> do a put.
>=20
> >=20
> > In this particular codepath, that's not so much a danger, but avoiding
> > excess "put" calls is still a good thing to do. That's the main reason
> > I've tried to "transfer" references to and from the LRU where possible.
> >=20
> > > >  	this_cpu_inc(nfsd_file_cache_hits);
> > > > =20
> > > >  	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), =
may_flags));
> > > > @@ -1107,7 +1098,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
> > > >  			this_cpu_inc(nfsd_file_acquisitions);
> > > >  		*pnf =3D nf;
> > > >  	} else {
> > > > -		nfsd_file_put(nf);
> > > > +		__nfsd_file_put(nf);
> > >=20
> > > I don't see the justification for this change.
> > > If status =3D=3D nfserr_jukebox, then it is OK.
> > > If status is whatever we might get from break_lease(), then it seems
> > > wrong.=20
> > > If we modify nfsd_file_put() as I suggest, it will handle both cases.
> > >=20
> > >=20
> >=20
> > The justification is that when we're dealing with an error from an open,
> > we don't want to put the nfsd_file onto the LRU. So, a direct call to
> > __nfsd_file_put is what's needed here.
>=20
> Maybe... I guess my concern arises from the fact that I'm unclear on how
> break_lease() might fail.  If it is a transitory failure then dropping
> from the lru doesn't seem appropriate.  Maybe I should refresh my
> understanding of break_lease() failure modes.
>=20
> >=20
> > I'll plan to open-code those like you suggest in the next iteration.
> >=20
> > > >  		nf =3D NULL;
> > > >  	}
> > > > =20
> > > > @@ -1134,7 +1125,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
> > > >  	 * then unhash.
> > > >  	 */
> > > >  	if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
> > > > -		nfsd_file_unhash_and_put(nf);
> > > > +		nfsd_file_unhash(nf);
> > > >  	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
> > > >  	smp_mb__after_atomic();
> > > >  	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
> > > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > > index b09ab4f92d43..a44ded06af87 100644
> > > > --- a/fs/nfsd/trace.h
> > > > +++ b/fs/nfsd/trace.h
> > > > @@ -903,10 +903,11 @@ DEFINE_EVENT(nfsd_file_class, name, \
> > > >  	TP_PROTO(struct nfsd_file *nf), \
> > > >  	TP_ARGS(nf))
> > > > =20
> > > > -DEFINE_NFSD_FILE_EVENT(nfsd_file_put_final);
> > > > +DEFINE_NFSD_FILE_EVENT(nfsd_file_free);
> > > >  DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
> > > >  DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
> > > > -DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_dispose);
> > > > +DEFINE_NFSD_FILE_EVENT(nfsd_file_closing);
> > > > +DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_queue);
> > > > =20
> > > >  TRACE_EVENT(nfsd_file_alloc,
> > > >  	TP_PROTO(
> > > > --=20
> > > > 2.37.3
> > > >=20
> > > >=20
> > >=20
> > > Thanks,
> > > NeilBrown
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20
> Thanks a lot,
> I quite like your latest version.
>=20
> NeilBrown
>=20
