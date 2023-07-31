Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4218B76A3EC
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Aug 2023 00:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjGaWLd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 18:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjGaWLb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 18:11:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A210D173B;
        Mon, 31 Jul 2023 15:11:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 143DD21FE4;
        Mon, 31 Jul 2023 22:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690841484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bw+Jr2yeF1CiIVeGOjntXCYonV3uJi6Y2bNB1cSheIA=;
        b=WnnRtBMu5Z6V92niNpUnues7Ixn2rT3cd3H3KnZE7ot3/Gpjck32OpMdSgf22FkO5pI8mK
        2Qa2q5zOGsiFtBkl+U6VrTHBz0Nm8g7llIlzd+nNj70ZoFFvJ1OcOOLmO7OM4VLcEdQpxV
        EN9MFD+uYVs3pzulfNN4bVgglC+KAXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690841484;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bw+Jr2yeF1CiIVeGOjntXCYonV3uJi6Y2bNB1cSheIA=;
        b=dpUkTvS1IVr2KTByRL7YF+YpZRJTxDSi3K/DSRdodAPX2XjUUemun3y0Dl59STIrkWayOf
        DjryFbdCioRV94DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 912F2133F7;
        Mon, 31 Jul 2023 22:11:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6wAlEYkxyGRsIwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jul 2023 22:11:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH RFC] nfsd: don't hand out write delegations on O_WRONLY opens
In-reply-to: <20230731-wdeleg-v1-1-f8fe1ce11b36@kernel.org>
References: <20230731-wdeleg-v1-1-f8fe1ce11b36@kernel.org>
Date:   Tue, 01 Aug 2023 08:11:18 +1000
Message-id: <169084147821.32308.9286837678268595107@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 01 Aug 2023, Jeff Layton wrote:
> I noticed that xfstests generic/001 was failing against linux-next nfsd.
>=20
> The client would request a OPEN4_SHARE_ACCESS_WRITE open, and the server
> would hand out a write delegation. The client would then try to use that
> write delegation as the source stateid in a COPY or CLONE operation, and
> the server would respond with NFS4ERR_STALE.
>=20
> The problem is that the struct file associated with the delegation does
> not necessarily have read permissions. It's handing out a write
> delegation on what is effectively an O_WRONLY open. RFC 8881 states:
>=20
>  "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
>   own, all opens."
>=20
> Given that the client didn't request any read permissions, and that nfsd
> didn't check for any, it seems wrong to give out a write delegation.
>=20
> Don't hand out a delegation if the client didn't request
> OPEN4_SHARE_ACCESS_BOTH.
>=20
> This fixes xfstest generic/001.
>=20
> Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D412
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ef7118ebee00..9f1c90afed72 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5462,6 +5462,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct n=
fs4_ol_stateid *stp,
>  		return ERR_PTR(-EAGAIN);
> =20
>  	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> +		if (!(open->op_share_access & NFS4_SHARE_ACCESS_READ))
> +			return ERR_PTR(-EBADF);
<bikeshed>
The actual error code returned by nfs4_set_delegation() is ignored -
only the fact of an error is relevant.
Given that, how did you choose -EBADF.  nfsd doesn't use file
descriptors, and doesn't use EBADF anywhere else.
Given that you have just tested access, EACCES might be justifiable.
But I would prefer if nfs4_set_delegation() returns NULL if it could not
find or create a delegation, without bothering with giving a reason.
</bikeshed>

Reviewed-by: NeilBrown <neilb@suse.de>

NeilBrown

>  		nf =3D find_writeable_file(fp);
>  		dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
>  	} else {
>=20
> ---
> base-commit: ec89391563792edd11d138a853901bce76d11f44
> change-id: 20230731-wdeleg-bbdb6b25a3c6
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20

