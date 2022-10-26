Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A595F60EB99
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 00:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJZWcN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Oct 2022 18:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiJZWcN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Oct 2022 18:32:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E805D11F4B9
        for <linux-nfs@vger.kernel.org>; Wed, 26 Oct 2022 15:32:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6994F22014;
        Wed, 26 Oct 2022 22:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666823530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V0Wfg63vK4X/COYrC/Y2FVeyUssFvR1qJgFivnciyMM=;
        b=GvpVsCZGNvurbBfDoXPM62CPw2ROD1cBs8dTegRbU2nXXatqwAu4wRg5VfrMlk9bDx+jN4
        JonLiJtEnfMJIbrdrniQ6yJc04LiPRGfakCr62S7WWXYYun6yWubWewUIoOl2dzZQPxJZm
        XC0qYw+0ffC/65glZJBMBDLUq2cDdMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666823530;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V0Wfg63vK4X/COYrC/Y2FVeyUssFvR1qJgFivnciyMM=;
        b=ySLG71o/l4F7DlebY9aixz90K0C5xbvAd1SFrIegrnXNz2gxd6aVvncpMKi0kuSSR+2PYC
        xr8N8Njl3gulA9BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31A3313A77;
        Wed, 26 Oct 2022 22:32:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Lm3iNWi1WWPoWwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 26 Oct 2022 22:32:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] nfsd: rework refcounting in filecache
In-reply-to: <20221026081539.219755-2-jlayton@kernel.org>
References: <20221026081539.219755-1-jlayton@kernel.org>,
 <20221026081539.219755-2-jlayton@kernel.org>
Date:   Thu, 27 Oct 2022 09:32:00 +1100
Message-id: <166682352064.7585.2289386406163662548@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 26 Oct 2022, Jeff Layton wrote:
> The filecache refcounting is a bit non-standard for something searchable
> by RCU, in that we maintain a sentinel reference while it's hashed.
> This in turn requires that we have to do things differently in the "put"
> depending on whether its hashed, etc.
>=20
> Another issue: nfsd_file_close_inode_sync can end up freeing an
> nfsd_file while there are still outstanding references to it.
>=20
> Rework the code so that the refcount is what drives the lifecycle. When
> the refcount goes to zero, then unhash and rcu free the object.

I think the lru reference needs to be counted.  Otherwise the nfsd_file
will be freed (and removed from the LRU) as soon as not active request
is referencing it (in the NFSv3 case).  This makes the LRU ineffective.

Looking more closely at the patch, it seems to sometimes treat the LRU
reference as counted, but sometimes not.

>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/filecache.c | 202 ++++++++++++++++++++------------------------
>  1 file changed, 92 insertions(+), 110 deletions(-)
>=20
> This passes some basic smoke testing and I think closes a number of
> races in this code. I also think the result is a bit simpler and easier
> to follow now.
>=20
> I looked for some ways to break this up into multiple patches, but I
> didn't find any. This changes the underlying rules of how the
> refcounting works, and I didn't see a way to split that up and still
> have it remain bisectable.
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 918d67cec1ad..6c2f4f2c56a6 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1,7 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> - * Open file cache.
> - *
> - * (c) 2015 - Jeff Layton <jeff.layton@primarydata.com>
> + * The NFSD open file cache.
>   */
> =20
>  #include <linux/hash.h>
> @@ -303,8 +302,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsig=
ned int may)
>  		if (key->gc)
>  			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
>  		nf->nf_inode =3D key->inode;
> -		/* nf_ref is pre-incremented for hash table */
> -		refcount_set(&nf->nf_ref, 2);
> +		refcount_set(&nf->nf_ref, 1);
>  		nf->nf_may =3D key->need;
>  		nf->nf_mark =3D NULL;
>  	}
> @@ -376,11 +374,15 @@ nfsd_file_flush(struct nfsd_file *nf)
>  		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
>  }
> =20
> -static void nfsd_file_lru_add(struct nfsd_file *nf)
> +static bool nfsd_file_lru_add(struct nfsd_file *nf)
>  {
>  	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
> +	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags) &&

Not only is this test inverted (as you already noted) but it is racy.
The file could get unhashed immediately after the test.  That possibly
gets handled somewhere.  If not it should be.  If so, this test isn't
really needed.

> +	    list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
>  		trace_nfsd_file_lru_add(nf);
> +		return true;
> +	}
> +	return false;
>  }
> =20
>  static void nfsd_file_lru_remove(struct nfsd_file *nf)
> @@ -410,7 +412,7 @@ nfsd_file_unhash(struct nfsd_file *nf)
>  	return false;
>  }
> =20
> -static void
> +static bool
>  nfsd_file_unhash_and_dispose(struct nfsd_file *nf, struct list_head *dispo=
se)
>  {
>  	trace_nfsd_file_unhash_and_dispose(nf);
> @@ -418,46 +420,48 @@ nfsd_file_unhash_and_dispose(struct nfsd_file *nf, st=
ruct list_head *dispose)
>  		/* caller must call nfsd_file_dispose_list() later */
>  		nfsd_file_lru_remove(nf);
>  		list_add(&nf->nf_lru, dispose);
> +		return true;
>  	}
> +	return false;
>  }
> =20
> -static void
> -nfsd_file_put_noref(struct nfsd_file *nf)
> +static bool
> +__nfsd_file_put(struct nfsd_file *nf)
>  {
> -	trace_nfsd_file_put(nf);
> -
> +	/* v4 case: don't wait for GC */

This comment suggests this code is only for the v4 case ....

>  	if (refcount_dec_and_test(&nf->nf_ref)) {
> -		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
> +		nfsd_file_unhash(nf);
>  		nfsd_file_lru_remove(nf);

but v4 doesn't use the lru, so this line is pointless.
And if the LRU does hold a counted reference, nf cannot possibly be on
the LRU at this point.

In fact, this function can be called for the v3 case, so the comment is
just misleading .... or maybe the code is poorly structured.

>  		nfsd_file_free(nf);
> +		return true;
>  	}
> +	return false;
>  }
> =20
> -static void
> -nfsd_file_unhash_and_put(struct nfsd_file *nf)
> -{
> -	if (nfsd_file_unhash(nf))
> -		nfsd_file_put_noref(nf);
> -}
> -
> +/**
> + * nfsd_file_put - put the reference to a nfsd_file
> + * @nf: nfsd_file of which to put the reference
> + *
> + * Put a reference to a nfsd_file. In the v4 case, we just put the
> + * reference immediately. In the v2/3 case, if the reference would be
> + * the last one, the put it on the LRU instead to be cleaned up later.
> + */
>  void
>  nfsd_file_put(struct nfsd_file *nf)
>  {
> -	might_sleep();
> -
> -	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D 1)
> -		nfsd_file_lru_add(nf);
> -	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
> -		nfsd_file_unhash_and_put(nf);
> +	trace_nfsd_file_put(nf);
> =20
> -	if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0) {
> -		nfsd_file_flush(nf);
> -		nfsd_file_put_noref(nf);
> -	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D 1)=
 {
> -		nfsd_file_put_noref(nf);
> -		nfsd_file_schedule_laundrette();
> -	} else
> -		nfsd_file_put_noref(nf);
> +	/* NFSv2/3 case */
> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
> +		/*
> +		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
> +		 * it to the LRU. If the add to the LRU fails, just put it as
> +		 * usual.
> +		 */
> +		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
> +			return;

This is one place that looks like you are refcounting entries on the lru.
If this is the last reference and you can transfer it to use LRU, then
you don't need to drop the reference.

> +	}
> +	__nfsd_file_put(nf);
>  }
> =20

NeilBrown
