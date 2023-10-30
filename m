Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CF77DC1FB
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 22:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjJ3VeC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 17:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJ3VeB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 17:34:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748F09F;
        Mon, 30 Oct 2023 14:33:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F34E4218F2;
        Mon, 30 Oct 2023 21:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698701637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b7lSEG/712moXpupryJuVYCtv58RazdNCEsa1sLuvuw=;
        b=zsGpI+jvNAZtSOZhYPus4+hE2G2/1GlnKh88VYt4+O/HZb3y497mEqtJQMcYHoDTqogKwP
        eiFFC9LM14qhSN5fmUDIU1J6mwmex4gkFdmMnI4CWoQNI+TLlt/aFnK6J0Hz7Ybrz+Dq0z
        gNr8dKbcLJCZpMwTBy9oqT2VfKH6k/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698701637;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b7lSEG/712moXpupryJuVYCtv58RazdNCEsa1sLuvuw=;
        b=tCArXslRGuJNUOzlSCQ9nT+zM6AaLznm38LFjUN5lxjX+hcfbVbksteigmVDIWDv3JbWkW
        LOOurkQ53cQHtHCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64962138F8;
        Mon, 30 Oct 2023 21:33:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7K2mB0IhQGWrIwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 30 Oct 2023 21:33:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Zhi Li" <yieli@redhat.com>, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH RFC] nfsd: fix error handling in nfsd_svc
In-reply-to: <20231030-kdevops-v1-1-bae6baf62c69@kernel.org>
References: <20231030-kdevops-v1-1-bae6baf62c69@kernel.org>
Date:   Tue, 31 Oct 2023 08:33:50 +1100
Message-id: <169870163037.24305.14020614041859684912@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 31 Oct 2023, Jeff Layton wrote:
> Once we've set the nfsd_serv pointer in nfsd_svc, we still need to call
> nfsd_last_thread if the server fails to be started. Remove the special
> casing for nfsd_up_before case since shutting down the per-net stuff is
> also handled by nfsd_last_thread.
>=20
> Finally, add a new special case at the start and skip doing anything if
> the service already exists, 0 threads were requested and
> serv->sv_nrthreads is 0.

This is very similar to my=20
  Commit bf32075256e9 ("NFSD: simplify error paths in nfsd_svc()")

The main difference being that special case you mention.  I don't like
that bit.
If I run "rpc.nfsd 0" then I want the nfsd_svc to be destroyed, whether
there were threads running or not.

Is there a reason my patch isn't sufficient?

Thanks,
NeilBrown


>=20
> Fixes: 9f28a971ee9f ("nfsd: separate nfsd_last_thread() from nfsd_put()")
> Reported-by: Zhi Li <yieli@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Here's what I was thinking for a targeted patch for stable. Testing it
> now, but I won't have results until tomorrow.
> ---
>  fs/nfsd/nfssvc.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 3deef000afa9..187b68769815 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -787,7 +787,6 @@ int
>  nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
>  {
>  	int	error;
> -	bool	nfsd_up_before;
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>  	struct svc_serv *serv;
> =20
> @@ -797,8 +796,9 @@ nfsd_svc(int nrservs, struct net *net, const struct cre=
d *cred)
>  	nrservs =3D max(nrservs, 0);
>  	nrservs =3D min(nrservs, NFSD_MAXSERVS);
>  	error =3D 0;
> +	serv =3D nn->nfsd_serv;
> =20
> -	if (nrservs =3D=3D 0 && nn->nfsd_serv =3D=3D NULL)
> +	if (nrservs =3D=3D 0 && (serv =3D=3D NULL || serv->sv_nrthreads =3D=3D 0))
>  		goto out;
> =20
>  	strscpy(nn->nfsd_name, utsname()->nodename,
> @@ -808,22 +808,17 @@ nfsd_svc(int nrservs, struct net *net, const struct c=
red *cred)
>  	if (error)
>  		goto out;
> =20
> -	nfsd_up_before =3D nn->nfsd_net_up;
>  	serv =3D nn->nfsd_serv;
> =20
>  	error =3D nfsd_startup_net(net, cred);
>  	if (error)
>  		goto out_put;
>  	error =3D svc_set_num_threads(serv, NULL, nrservs);
> -	if (error)
> -		goto out_shutdown;
> -	error =3D serv->sv_nrthreads;
>  	if (error =3D=3D 0)
> -		nfsd_last_thread(net);
> -out_shutdown:
> -	if (error < 0 && !nfsd_up_before)
> -		nfsd_shutdown_net(net);
> +		error =3D serv->sv_nrthreads;
>  out_put:
> +	if (serv->sv_nrthreads =3D=3D 0)
> +		nfsd_last_thread(net);
>  	/* Threads now hold service active */
>  	if (xchg(&nn->keep_active, 0))
>  		svc_put(serv);
>=20
> ---
> base-commit: 31b5a36c4b88b44c91cdd523997b1e86fb47339d
> change-id: 20231030-kdevops-5f7366897ef4
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20

