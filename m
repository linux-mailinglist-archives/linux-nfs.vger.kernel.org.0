Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9432A5311FF
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 18:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbiEWNk6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 09:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbiEWNky (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 09:40:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25ED52E7E
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 06:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AAD1B80DA0
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 13:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90928C385AA;
        Mon, 23 May 2022 13:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653313249;
        bh=PZygM5XbDX+uHNlJZNeMfD3GW2GqvkJcTMLRuJsjvL4=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=ZlwAjHwqD2XwPmXWy9N/3okh8P5/ej1QJwq/6UPkZIoKImjHmpd9xGW720y84LSYI
         C0nq6F2jRNDPU4nLHy89+s21vVGIj3t0DeUkpZYgiRY2WiDOPMlxK7zfD6Gl13BYlV
         k0+Z+fMs1yxeiifRKlBIInkPw8SIm13P1Xa3TvvxWSkjl59b5gi5kX/WEpDW+n11In
         IbVV1tOKs2A3Yzv7Ww9XAPBjIKzbQKvVutCn1EJKiPf/sjeFrK1RbnbDAhlBweMj9v
         MK+yLbvC737HtlL4tu3685QKEDpeTtSKzb7q5aFj3VGUUL50ufGRhZxqztxb8QJ3Kx
         oalLmRoTiRDrg==
Message-ID: <fe3f9ece807e1433631ee3e0bd6b78238305cb87.camel@kernel.org>
Subject: Re: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Mon, 23 May 2022 09:40:48 -0400
In-Reply-To: <165323344948.2381.7808135229977810927.stgit@bazille.1015granger.net>
References: <165323344948.2381.7808135229977810927.stgit@bazille.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2022-05-22 at 11:38 -0400, Chuck Lever wrote:
> nfsd4_release_lockowner() holds clp->cl_lock when it calls
> check_for_locks(). However, check_for_locks() calls nfsd_file_get()
> / nfsd_file_put() to access the backing inode's flc_posix list, and
> nfsd_file_put() can sleep if the inode was recently removed.
>=20

It might be good to add a might_sleep() to nfsd_file_put?

> Let's instead rely on the stateowner's reference count to gate
> whether the release is permitted. This should be a reliable
> indication of locks-in-use since file lock operations and
> ->lm_get_owner take appropriate references, which are released
> appropriately when file locks are removed.
>=20
> Reported-by: Dai Ngo <dai.ngo@oracle.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Cc: stable@vger.kernel.org
> ---
>  fs/nfsd/nfs4state.c |    9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> This might be a naive approach, but let's start with it.
>=20
> This passes light testing, but it's not clear how much our existing
> fleet of tests exercises this area. I've locally built a couple of
> pynfs tests (one is based on the one Dai posted last week) and they
> pass too.
>=20
> I don't believe that FREE_STATEID needs the same simplification.
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a280256cbb03..b77894e668a4 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7559,12 +7559,9 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
> =20
>  		/* see if there are still any locks associated with it */
>  		lo =3D lockowner(sop);
> -		list_for_each_entry(stp, &sop->so_stateids, st_perstateowner) {
> -			if (check_for_locks(stp->st_stid.sc_file, lo)) {
> -				status =3D nfserr_locks_held;
> -				spin_unlock(&clp->cl_lock);
> -				return status;
> -			}
> +		if (atomic_read(&sop->so_count) > 1) {
> +			spin_unlock(&clp->cl_lock);
> +			return nfserr_locks_held;
>  		}
> =20
>  		nfs4_get_stateowner(sop);
>=20
>=20

lm_get_owner is called from locks_copy_conflock, so if someone else
happens to be doing a LOCKT or F_GETLK call at the same time that
RELEASE_LOCKOWNER gets called, then this may end up returning an error
inappropriately. My guess is that that would be pretty hard to hit the
timing right, but not impossible.

What we may want to do is have the kernel do this check and only if it
comes back >1 do the actual check for locks. That won't fix the original
problem though.

In other places in nfsd, we've plumbed in a dispose_list head and
deferred the sleeping functions until the spinlock can be dropped. I
haven't looked closely at whether that's possible here, but it may be a
more reliable approach.
--=20
Jeff Layton <jlayton@kernel.org>
