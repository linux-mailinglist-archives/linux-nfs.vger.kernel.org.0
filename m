Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6F260983E
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 04:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJXCeC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Oct 2022 22:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJXCeC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Oct 2022 22:34:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8372767153
        for <linux-nfs@vger.kernel.org>; Sun, 23 Oct 2022 19:34:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1E2FB1F893;
        Mon, 24 Oct 2022 02:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666578839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1gX1CO1l8IHaKGpy3azScCel6fMihiTrpDBzRp8RtMQ=;
        b=uMWSjIgwuJ238JMzpbqGQeDkwMVF1wNhFhqP6pHvAMDrfco6y3rUIztzuc08Khl7SrpfVl
        V/FWQRkVqz4SyVBf9IijAIps2MmYIHfwcUrzfI2KtygjBNqnJfFu+QtbdepZmspwGRChq9
        zRs6X6ml7TQ6w7U6ufSRPM24YKjnVDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666578839;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1gX1CO1l8IHaKGpy3azScCel6fMihiTrpDBzRp8RtMQ=;
        b=VR3wbmZiMC8Xlsdt5EeaavRcVYU8GUJta/U8IWrZZV/Vdl9QWu3eIgULQ83F1Xi3D/JFcR
        qvSQR4IXfOmvyTBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 339EB13357;
        Mon, 24 Oct 2022 02:33:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fImuNpX5VWOROAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Oct 2022 02:33:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 3/7] NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file
 garbage collection
In-reply-to: <166612311828.1291.6808456808715954510.stgit@manet.1015granger.net>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>,
 <166612311828.1291.6808456808715954510.stgit@manet.1015granger.net>
Date:   Mon, 24 Oct 2022 13:33:54 +1100
Message-id: <166657883468.12462.7206160925496863213@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 19 Oct 2022, Chuck Lever wrote:
> NFSv4 operations manage the lifetime of nfsd_file items they use by
> means of NFSv4 OPEN and CLOSE. Hence there's no need for them to be
> garbage collected.
>=20
> Introduce a mechanism to enable garbage collection for nfsd_file
> items used only by NFSv2/3 callers.
>=20
> Note that the change in nfsd_file_put() ensures that both CLOSE and
> DELEGRETURN will actually close out and free an nfsd_file on last
> reference of a non-garbage-collected file.
>=20
> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D394
> Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c |   61 +++++++++++++++++++++++++++++++++++++++++++++--=
----
>  fs/nfsd/filecache.h |    3 +++
>  fs/nfsd/nfs3proc.c  |    4 ++-
>  fs/nfsd/trace.h     |    3 ++-
>  fs/nfsd/vfs.c       |    4 ++-
>  5 files changed, 63 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index b7aa523c2010..87fce5c95726 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -63,6 +63,7 @@ struct nfsd_file_lookup_key {
>  	struct net			*net;
>  	const struct cred		*cred;
>  	unsigned char			need;
> +	unsigned char			gc:1;
>  	enum nfsd_file_lookup_type	type;
>  };
> =20
> @@ -162,6 +163,8 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_compar=
e_arg *arg,
>  			return 1;
>  		if (!nfsd_match_cred(nf->nf_cred, key->cred))
>  			return 1;
> +		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
> +			return 1;
>  		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0)
>  			return 1;
>  		break;
> @@ -297,6 +300,8 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsig=
ned int may)
>  		nf->nf_flags =3D 0;
>  		__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
>  		__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
> +		if (key->gc)
> +			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
>  		nf->nf_inode =3D key->inode;
>  		/* nf_ref is pre-incremented for hash table */
>  		refcount_set(&nf->nf_ref, 2);
> @@ -428,16 +433,27 @@ nfsd_file_put_noref(struct nfsd_file *nf)
>  	}
>  }
> =20
> +static void
> +nfsd_file_unhash_and_put(struct nfsd_file *nf)
> +{
> +	if (nfsd_file_unhash(nf))
> +		nfsd_file_put_noref(nf);
> +}
> +
>  void
>  nfsd_file_put(struct nfsd_file *nf)
>  {
>  	might_sleep();
> =20
> -	nfsd_file_lru_add(nf);
> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D 1)

Clearly this is a style choice on which sensible people might disagree,
but I much prefer to leave out the "=3D=3D 1" That is what most callers in
fs/nfsd/ do - only exceptions are here in filecache.c.
Even "!=3D 0" would be better than "=3D=3D 1".
I think test_bit() is declared as a bool, but it is hard to be certain.

> +		nfsd_file_lru_add(nf);
> +	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
> +		nfsd_file_unhash_and_put(nf);

Tests on the value of a refcount are almost always racy.
I suspect there is an implication that as NFSD_FILE_GC is not set, this
*must* be hashed which implies there is guaranteed to be a refcount from
the hashtable.  So this is really a test to see if the pre-biased
refcount is one.  The safe way to test if a refcount is 1 is dec_and_test.

i.e. linkage from the hash table should not count as a reference (in the
not-GC case).  Lookup in the hash table should fail if the found entry
cannot achieve an inc_not_zero.  When dec_and_test says the refcount is
zero, we remove from the hash table (certain that no new references will
be taken).


> +
>  	if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0) {
>  		nfsd_file_flush(nf);
>  		nfsd_file_put_noref(nf);

This seems weird.  If the file was unhashed above (because nf_ref was
2), it would now not be flushed.  Why don't we want it to be flushed in
that case?

> -	} else if (nf->nf_file) {
> +	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D 1)=
 {
>  		nfsd_file_put_noref(nf);
>  		nfsd_file_schedule_laundrette();
>  	} else
> @@ -1017,12 +1033,14 @@ nfsd_file_is_cached(struct inode *inode)
> =20
>  static __be32
>  nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		     unsigned int may_flags, struct nfsd_file **pnf, bool open)
> +		     unsigned int may_flags, struct nfsd_file **pnf,
> +		     bool open, int want_gc)

I too would prefer "bool" for all intstance of gc and want_gc.

NeilBrown
