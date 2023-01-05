Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6C265F777
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jan 2023 00:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbjAEXFm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 18:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjAEXFl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 18:05:41 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18878671A9
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 15:05:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F7F83401E;
        Thu,  5 Jan 2023 23:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1672959939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wE2E5RH/T3EMWD0ZHpEYlSYcSLqg6q6BDhyxhuyWCwU=;
        b=KMXzg0FPsbRIfmxsY88ePCGB0TTp0xbUzR820aZBSKCJbq4vgeKBKYnxL4c1tpphJhQZBY
        9v6cW9T7+58tXaOv63gnfPCnmuPZzU0QYByBSHRLWeEt99Wpd7pPPJw1cOzXwwuPueJxXN
        LbxhT1Iyju5MvK+IBMzSBPRteNxXn4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1672959939;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wE2E5RH/T3EMWD0ZHpEYlSYcSLqg6q6BDhyxhuyWCwU=;
        b=kEQCIBldJIVIpOR3BDZs2DIiExRaCh2ykVut63q4UgVEdGWAV2vM3H199yYMIthJrmyHGZ
        mMWsEuNYNRO6lYBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C61C2138DF;
        Thu,  5 Jan 2023 23:05:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N5cnHsFXt2OYawAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 05 Jan 2023 23:05:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix potential race in nfs4_find_file
In-reply-to: <20230105121823.21935-1-jlayton@kernel.org>
References: <20230105121823.21935-1-jlayton@kernel.org>
Date:   Fri, 06 Jan 2023 10:05:31 +1100
Message-id: <167295993121.13974.8791979932693514625@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 05 Jan 2023, Jeff Layton wrote:
> Even though there is a WARN_ON_ONCE check, it seems possible for
> nfs4_find_file to race with the destruction of an fi_deleg_file while
> trying to take a reference to it.
>=20
> put_deleg_file is done while holding the fi_lock. Take and hold it
> when dealing with the fi_deleg_file in nfs4_find_file.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b68238024e49..3df3ae84bd07 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6417,23 +6417,27 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *c=
state,
>  static struct nfsd_file *
>  nfs4_find_file(struct nfs4_stid *s, int flags)
>  {
> +	struct nfsd_file *ret =3D NULL;
> +
>  	if (!s)
>  		return NULL;
> =20
>  	switch (s->sc_type) {
>  	case NFS4_DELEG_STID:
> -		if (WARN_ON_ONCE(!s->sc_file->fi_deleg_file))
> -			return NULL;
> -		return nfsd_file_get(s->sc_file->fi_deleg_file);
> +		spin_lock(&s->sc_file->fi_lock);
> +		if (!WARN_ON_ONCE(!s->sc_file->fi_deleg_file))
> +			ret =3D nfsd_file_get(s->sc_file->fi_deleg_file);
> +		spin_unlock(&s->sc_file->fi_lock);
> +		break;

As an nfsd_file is freed with rcu, we don't need the spinlock.

 rcu_read_lock()
 ret =3D rcu_dereference(s->sc_file->fi_deleg_file);
 if (ret)
	ret =3D nfsd_file_get(ret);
 rcu_read_unlock();

You could even put the NULL test in nfsd_file_get() and have:

 rcu_read_lock()l;
 ret =3D nfsd_file_get(rcu_dereference(s->sc_file->fi_deleg_file));
 rcu_read_unlock();

but that might not be a win.

I agree with Chuck that the WARNing isn't helpful.

NeilBrown


>  	case NFS4_OPEN_STID:
>  	case NFS4_LOCK_STID:
>  		if (flags & RD_STATE)
> -			return find_readable_file(s->sc_file);
> +			ret =3D find_readable_file(s->sc_file);
>  		else
> -			return find_writeable_file(s->sc_file);
> +			ret =3D find_writeable_file(s->sc_file);
>  	}
> =20
> -	return NULL;
> +	return ret;
>  }
> =20
>  static __be32
> --=20
> 2.39.0
>=20
>=20
