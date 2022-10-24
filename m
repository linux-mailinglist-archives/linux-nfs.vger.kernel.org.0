Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7A160C005
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 02:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiJYArn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 20:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiJYArS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 20:47:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74898167F4A
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 16:22:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0C86221F61;
        Mon, 24 Oct 2022 23:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666653733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C3DI3I7MRSsun7n8UjSanRuhKPKItHEv5RCFWnPq3RE=;
        b=KdiVCX9/l6igCZ6ujs2hj41L44MQBoIVL2VC164m3hiHybiTj40mCvnk32QbLO85MiRurq
        /LaaJKHf7/dTL3j/SZdK0RT2XJ3/XKJNwQZVBR3cp03+gNSTsSkjlPZq+oM/GdjVrf3A2M
        G1k0UmCofF3mYQM5fmm3x72Ki41Pp80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666653733;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C3DI3I7MRSsun7n8UjSanRuhKPKItHEv5RCFWnPq3RE=;
        b=BkWhfemcQr0xCOJRqcA7CHUfK/i5JJ8HfgeFyGffZZnTnCBMSO5l4Nw1VxV+iF6ePblaRT
        q9AoOPk4/rtnBuDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17E7513357;
        Mon, 24 Oct 2022 23:22:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P98XLyMeV2MSIQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Oct 2022 23:22:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 11/13] NFSD: Refactor find_file()
In-reply-to: <166665108230.50761.12047289373435044414.stgit@klimt.1015granger.net>
References: <166664935937.50761.7812494396457965637.stgit@klimt.1015granger.net>,
 <166665108230.50761.12047289373435044414.stgit@klimt.1015granger.net>
Date:   Tue, 25 Oct 2022 10:22:08 +1100
Message-id: <166665372875.12462.10025398454549096651@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Oct 2022, Chuck Lever wrote:
> find_file() is now the only caller of find_file_locked(), so just
> fold these two together.
>=20
> Name nfs4_file-related helpers consistently. There are already
> nfs4_file_yada functions, so let's go with the same convention used
> by put_nfs4_file(): find_nfs4_file().
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4state.c |   35 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 529995a9e916..abed795bb4ec 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4666,31 +4666,23 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struct=
 net *net)
>  		nfs4_put_stid(&last->st_stid);
>  }
> =20
> -/* search file_hashtbl[] for file */
> -static struct nfs4_file *
> -find_file_locked(const struct svc_fh *fh, unsigned int hashval)
> +static noinline_for_stack struct nfs4_file *
> +find_nfs4_file(const struct svc_fh *fhp)
>  {
> -	struct nfs4_file *fp;
> +	unsigned int hashval =3D file_hashval(fhp);
> +	struct nfs4_file *fi =3D NULL;
> =20
> -	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
> -				lockdep_is_held(&state_lock)) {
> -		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
> -			if (refcount_inc_not_zero(&fp->fi_ref))
> -				return fp;
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(fi, &file_hashtbl[hashval], fi_hash,
> +				 lockdep_is_held(&state_lock)) {
> +		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
> +			if (!refcount_inc_not_zero(&fi->fi_ref))
> +				fi =3D NULL;

This looks .... imperfect to me.
If the refcount_inc_not_zero fails, it means we haven't found what we
are looking for, so why break out of the loop?
I guess we can *know* that if some other thread has deleted the entry
and some third thread has added a new entry then the new entry will be
early in the list so it doesn't hurt to stop now.  But it seems
unnecessary.
I would write this.

		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle) &&
		    refcount_inc_not_zero(&fi->fi_ref))
			break;


> +			break;
>  		}
>  	}
..
>  	rcu_read_unlock();
..
> +	return fi;

This assumes that when the loop completes normally, the loop variable is
NULL.  That is the case for this particular for_each loop, but isn't for
some others.  There was a recent spate of patches for for_each loops
that made the wrong assumption so I feel a bit wary.
At most I might suggest a comment ... but that probably wouldn't help at
all..  So it is probably fine as it is.

So I'd like to see the loop simplified to remove the assignment=20
(fi =3D NULL), but either way

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown
