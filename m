Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23875F19E2
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Oct 2022 06:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJAEpE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Oct 2022 00:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJAEpC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Oct 2022 00:45:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8822B63A
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 21:44:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E2D631F892;
        Sat,  1 Oct 2022 04:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664599496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3G+a07EAqu6SiU85l8fAD7nyUc3XRqVHf+iDEqvp3Q=;
        b=Jd5inrjUijcRADO+L5Ct/ntcE1B4ZZTA4vtt+uxHyfcAfukvjsT7FyP+rdJDXlbYqziAa8
        Bo8sDUQ3HWoEPInJMU9DHGE0yNIuMouFmVx8ms+jR94bRw7Cnn/3VEklI7o+0mYOd+GY4Y
        J7j3PnOKMf9Oywn1CsSmlWfsqWOc+xk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664599496;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3G+a07EAqu6SiU85l8fAD7nyUc3XRqVHf+iDEqvp3Q=;
        b=/+VqhOGLdeEkI/V3VHWwgYrvrHrvIS02Me7oZGfLCn7CTYD2VTLe7PPSSVeczsQSvyIkoF
        LPMvhq2xQMiYfMBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA717133E5;
        Sat,  1 Oct 2022 04:44:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s4uBHMfFN2N4bgAAMHmgww
        (envelope-from <neilb@suse.de>); Sat, 01 Oct 2022 04:44:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] nfsd: nfsd_do_file_acquire should hold rcu_read_lock
 while getting refs
In-reply-to: <20220930191550.172087-2-jlayton@kernel.org>
References: <20220930191550.172087-1-jlayton@kernel.org>,
 <20220930191550.172087-2-jlayton@kernel.org>
Date:   Sat, 01 Oct 2022 14:44:50 +1000
Message-id: <166459949085.17572.9387753773056673569@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 01 Oct 2022, Jeff Layton wrote:
> nfsd_file is RCU-freed, so it's possible that one could be found that's
> in the process of being freed and the memory recycled. Ensure we hold
> the rcu_read_lock while attempting to get a reference on the object.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/filecache.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index d5c57360b418..6237715bd23e 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1077,10 +1077,12 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> =20
>  retry:
>  	/* Avoid allocation if the item is already in cache */
> +	rcu_read_lock();
>  	nf =3D rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
>  				    nfsd_file_rhash_params);
>  	if (nf)
>  		nf =3D nfsd_file_get(nf);
> +	rcu_read_unlock();

Looks good.

>  	if (nf)
>  		goto wait_for_construction;
> =20
> @@ -1090,16 +1092,21 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
>  		goto out_status;
>  	}
> =20
> +	rcu_read_lock();
>  	nf =3D rhashtable_lookup_get_insert_key(&nfsd_file_rhash_tbl,
>  					      &key, &new->nf_rhash,
>  					      nfsd_file_rhash_params);
>  	if (!nf) {
> +		rcu_read_unlock();
>  		nf =3D new;
>  		goto open_file;
>  	}
> -	if (IS_ERR(nf))
> +	if (IS_ERR(nf)) {
> +		rcu_read_unlock();
>  		goto insert_err;
> +	}
>  	nf =3D nfsd_file_get(nf);
> +	rcu_read_unlock();

Ugh.
Could we make this:
   rcu_read_lock()
   nf =3D r_l_g_i_k()
   if (!IS_ERR_OR_NULL(nf))
        nf =3D nfsd_file_get(nf);
   rcu_read_unlock()
   ...
??

NeilBrown

>  	if (nf =3D=3D NULL) {
>  		nf =3D new;
>  		goto open_file;
> --=20
> 2.37.3
>=20
>=20
