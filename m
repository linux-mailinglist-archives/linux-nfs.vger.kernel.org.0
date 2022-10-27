Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC64D6105BB
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 00:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbiJ0WZg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 18:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbiJ0WZf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 18:25:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F1E3F1CB
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 15:25:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0A43E219FE;
        Thu, 27 Oct 2022 22:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666909532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wx+iGUCuq/hx8v7JRR/WZtlWREvOjx4t/rOz+YnpAkk=;
        b=iStl85aePsuxr20N/gtQ50QBPCXJ2sPQhRMw7XI0kQoTTLaTnLSmGzln/VI4NA+1xW2+Dq
        jGrGCE309+6V4Np9dRmhWnqknt1k6CqKpC2VBYQjuB5sGFeO1rhcW75DtmeNHDaE93Y8oN
        T4xDk+xfwYimyb3I/VAhRgkW4BGXYmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666909532;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wx+iGUCuq/hx8v7JRR/WZtlWREvOjx4t/rOz+YnpAkk=;
        b=3xS2Ln4lETj0MVzlCpUpjpjhCZOrH/s8DyLxBHBcakqlnLJfxvtCkrnK9qv/OCd0vCYqvO
        iz2/pk57yNLQ4NCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42493134CA;
        Thu, 27 Oct 2022 22:25:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gWDNOlkFW2OadwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 27 Oct 2022 22:25:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
In-reply-to: <20221027215213.138304-4-jlayton@kernel.org>
References: <20221027215213.138304-1-jlayton@kernel.org>,
 <20221027215213.138304-4-jlayton@kernel.org>
Date:   Fri, 28 Oct 2022 09:25:26 +1100
Message-id: <166690952613.13915.11556395606559286695@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 28 Oct 2022, Jeff Layton wrote:
> When a GC entry gets added to the LRU, kick off SYNC_NONE writeback
> so that we can be ready to close it out when the time comes.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

This looks sensible.
Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


> ---
>  fs/nfsd/filecache.c | 37 +++++++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index d2bbded805d4..491d3d9a1870 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -316,7 +316,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsig=
ned int may)
>  }
> =20
>  static void
> -nfsd_file_flush(struct nfsd_file *nf)
> +nfsd_file_fsync(struct nfsd_file *nf)
>  {
>  	struct file *file =3D nf->nf_file;
> =20
> @@ -327,6 +327,22 @@ nfsd_file_flush(struct nfsd_file *nf)
>  		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
>  }
> =20
> +static void
> +nfsd_file_flush(struct nfsd_file *nf)
> +{
> +	struct file *file =3D nf->nf_file;
> +	unsigned long nrpages;
> +
> +	if (!file || !(file->f_mode & FMODE_WRITE))
> +		return;
> +
> +	nrpages =3D file->f_mapping->nrpages;
> +	if (nrpages) {
> +		this_cpu_add(nfsd_file_pages_flushed, nrpages);
> +		filemap_flush(file->f_mapping);
> +	}
> +}
> +
>  static void
>  nfsd_file_free(struct nfsd_file *nf)
>  {
> @@ -337,7 +353,7 @@ nfsd_file_free(struct nfsd_file *nf)
>  	this_cpu_inc(nfsd_file_releases);
>  	this_cpu_add(nfsd_file_total_age, age);
> =20
> -	nfsd_file_flush(nf);
> +	nfsd_file_fsync(nf);
> =20
>  	if (nf->nf_mark)
>  		nfsd_file_mark_put(nf->nf_mark);
> @@ -500,12 +516,21 @@ nfsd_file_put(struct nfsd_file *nf)
> =20
>  	if (test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
>  		/*
> -		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
> -		 * it to the LRU. If the add to the LRU fails, just put it as
> -		 * usual.
> +		 * If this is the last reference (nf_ref =3D=3D 1), then try
> +		 * to transfer it to the LRU.
> +		 */
> +		if (refcount_dec_not_one(&nf->nf_ref))
> +			return;
> +
> +		/*
> +		 * If the add to the list succeeds, try to kick off SYNC_NONE
> +		 * writeback. If the add fails, then just fall through to
> +		 * decrement as usual.
>  		 */
> -		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
> +		if (nfsd_file_lru_add(nf)) {
> +			nfsd_file_flush(nf);
>  			return;
> +		}
>  	}
>  	__nfsd_file_put(nf);
>  }
> --=20
> 2.37.3
>=20
>=20
