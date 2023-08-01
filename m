Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE73C76C065
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 00:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjHAW00 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Aug 2023 18:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjHAW00 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Aug 2023 18:26:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DE5DB;
        Tue,  1 Aug 2023 15:26:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A9A0121C60;
        Tue,  1 Aug 2023 22:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690928783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZH0zV7JWqxbRXabHD+MaIlEMkZb5/+ZTK7J6riVexzo=;
        b=jAq35j/9/oekk478Dl2rL9hKt5uzrb3gNFqajWWMczs/3Xpw5qqonMpzpYvcgqQ/nt3Wzl
        aQ+I+2y0aHb0k5IlDCImneFJUSrpMFBmXYS2weXpuf3idzgrfiHzyo3LBClbCqpAI7FvsA
        nOfmbqxm3jCM5kzkqMXH8skUBU7E/hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690928783;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZH0zV7JWqxbRXabHD+MaIlEMkZb5/+ZTK7J6riVexzo=;
        b=VQqVznfsq7X0J9uBGyfLwZBO2cAV9dK4PK9/cl5b0kvkz0DlSrxDjBH1zFwIEwpPIGmTxQ
        YpdJUI1cXth36FDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D567139BD;
        Tue,  1 Aug 2023 22:26:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t5lRNIyGyWS3PQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 01 Aug 2023 22:26:20 +0000
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
Subject: Re: [PATCH v2] nfsd: don't hand out write delegations on O_WRONLY opens
In-reply-to: <20230801-wdeleg-v2-1-20c14252bab4@kernel.org>
References: <20230801-wdeleg-v2-1-20c14252bab4@kernel.org>
Date:   Wed, 02 Aug 2023 08:26:15 +1000
Message-id: <169092877531.32308.10105992729094485900@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
> Only hand out a write delegation if we have a O_RDWR descriptor
> available. If it fails to find an appropriate write descriptor, go
> ahead and try for a read delegation if NFS4_SHARE_ACCESS_READ was
> requested.
>=20
> This fixes xfstest generic/001.
>=20
> Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D412
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v2:
> - Rework the logic when finding struct file for the delegation. The
>   earlier patch might still have attached a O_WRONLY file to the deleg
>   in some cases, and could still have handed out a write delegation on
>   an O_WRONLY OPEN request in some cases.
> ---
>  fs/nfsd/nfs4state.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ef7118ebee00..e79d82fd05e7 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5449,7 +5449,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct n=
fs4_ol_stateid *stp,
>  	struct nfs4_file *fp =3D stp->st_stid.sc_file;
>  	struct nfs4_clnt_odstate *odstate =3D stp->st_clnt_odstate;
>  	struct nfs4_delegation *dp;
> -	struct nfsd_file *nf;
> +	struct nfsd_file *nf =3D NULL;
>  	struct file_lock *fl;
>  	u32 dl_type;
> =20
> @@ -5461,21 +5461,28 @@ nfs4_set_delegation(struct nfsd4_open *open, struct=
 nfs4_ol_stateid *stp,
>  	if (fp->fi_had_conflict)
>  		return ERR_PTR(-EAGAIN);
> =20
> -	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> -		nf =3D find_writeable_file(fp);
> +	/*
> +	 * Try for a write delegation first. We need an O_RDWR file
> +	 * since a write delegation allows the client to perform any open
> +	 * from its cache.
> +	 */
> +	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=3D NFS4_SHARE_AC=
CESS_BOTH) {
> +		nf =3D nfsd_file_get(fp->fi_fds[O_RDWR]);

This doesn't take fp->fi_lock before accessing ->fi_fds[], while the
find_readable_file() call below does.  This inconsistency suggests a
bug?

Maybe the provided API is awkward.  Should we have=20
find_suitable_file() and find_suitable_file_locked()
that gets passed an nfs4_file and an O_MODE?
It tries the given mode, then O_RDWR

NeilBrown


>  		dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> -	} else {
> +	}
> +
> +	/*
> +	 * If the file is being opened O_RDONLY or we couldn't get a O_RDWR
> +	 * file for some reason, then try for a read deleg instead.
> +	 */
> +	if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
>  		nf =3D find_readable_file(fp);
>  		dl_type =3D NFS4_OPEN_DELEGATE_READ;
>  	}
> -	if (!nf) {
> -		/*
> -		 * We probably could attempt another open and get a read
> -		 * delegation, but for now, don't bother until the
> -		 * client actually sends us one.
> -		 */
> +
> +	if (!nf)
>  		return ERR_PTR(-EAGAIN);
> -	}
> +
>  	spin_lock(&state_lock);
>  	spin_lock(&fp->fi_lock);
>  	if (nfs4_delegation_exists(clp, fp))
>=20
> ---
> base-commit: a734662572708cf062e974f659ae50c24fc1ad17
> change-id: 20230731-wdeleg-bbdb6b25a3c6
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20

