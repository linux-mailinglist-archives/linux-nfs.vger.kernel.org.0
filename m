Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F7561059E
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 00:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJ0WVK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 18:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbiJ0WVJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 18:21:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2C44B999
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 15:21:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D58F8219E7;
        Thu, 27 Oct 2022 22:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666909263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1vdTYkjv6Clxmumq0ET+0JE+ZtRgyvNmop9nwwRsXgc=;
        b=kFsfuMM72unwbskzbHN0bR6j/WBDLg50aGHmDXd7OqT54m0qxXQKisRXF/IcAyEKuLKGBm
        4m5WhnsIjkijA46yr5veMqk0sedpfUTBZoddVEJteHiQZFxr+ZqbSqkpSXs70xYcP7jGup
        mCDFSMtH8bypXdYhV7OsFTazv22MUAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666909263;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1vdTYkjv6Clxmumq0ET+0JE+ZtRgyvNmop9nwwRsXgc=;
        b=bCypKDz7TST5F4ncn7IHjxkdz31sA+vLir8q2XT8DT13pUmyTTbOhZSVxDexyWRckdNrwI
        2BmqW84BezKzCCAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC164134CA;
        Thu, 27 Oct 2022 22:21:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lHv9GE4EW2PsdQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 27 Oct 2022 22:21:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] nfsd: only keep unused entries on the LRU
In-reply-to: <20221027215213.138304-3-jlayton@kernel.org>
References: <20221027215213.138304-1-jlayton@kernel.org>,
 <20221027215213.138304-3-jlayton@kernel.org>
Date:   Fri, 28 Oct 2022 09:20:59 +1100
Message-id: <166690925944.13915.14734120966513564215@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 28 Oct 2022, Jeff Layton wrote:
> Currently, nfsd_files live on the LRU once they are added until they are
> unhashed. There's no need to keep ones that are actively in use there.

Is that true?
nfsd_file_do_acquire() calls nfsd_file_lru_remove()
Isn't that enough to keep the file off the lru while it is active?

Thanks,
NeilBrown


>=20
> Before incrementing the refcount, do a lockless check for nf_lru being
> empty. If it's not then attempt to remove the entry from the LRU. If
> that's successful, claim the LRU reference and return it. If the removal
> fails (or if the list_head was empty), then just increment the counter
> as we normally would.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/filecache.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index e63534f4b9f8..d2bbded805d4 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -420,14 +420,31 @@ nfsd_file_unhash(struct nfsd_file *nf)
>  	return false;
>  }
> =20
> -struct nfsd_file *
> -nfsd_file_get(struct nfsd_file *nf)
> +static struct nfsd_file *
> +__nfsd_file_get(struct nfsd_file *nf)
>  {
>  	if (likely(refcount_inc_not_zero(&nf->nf_ref)))
>  		return nf;
>  	return NULL;
>  }
> =20
> +struct nfsd_file *
> +nfsd_file_get(struct nfsd_file *nf)
> +{
> +	/*
> +	 * Do a lockless list_empty check first, before attempting to
> +	 * remove it, so we can avoid the spinlock when it's not on the
> +	 * list.
> +	 *
> +	 * If we successfully remove it from the LRU, then we can just
> +	 * claim the LRU reference and return it. Otherwise, we need to
> +	 * bump the counter the old-fashioned way.
> +	 */
> +	if (!list_empty(&nf->nf_lru) && nfsd_file_lru_remove(nf))
> +		return nf;
> +	return __nfsd_file_get(nf);
> +}
> +
>  /**
>   * nfsd_file_unhash_and_queue - unhash a file and queue it to the dispose =
list
>   * @nf: nfsd_file to be unhashed and queued
> @@ -449,7 +466,7 @@ nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct=
 list_head *dispose)
>  		 * to take a reference. If that fails, just ignore
>  		 * the file altogether.
>  		 */
> -		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
> +		if (!nfsd_file_lru_remove(nf) && !__nfsd_file_get(nf))
>  			return false;
>  		list_add(&nf->nf_lru, dispose);
>  		return true;
> --=20
> 2.37.3
>=20
>=20
