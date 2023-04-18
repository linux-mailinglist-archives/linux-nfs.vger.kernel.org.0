Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565266E6DC4
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Apr 2023 22:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjDRU6d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Apr 2023 16:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDRU6c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Apr 2023 16:58:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD2D40FA
        for <linux-nfs@vger.kernel.org>; Tue, 18 Apr 2023 13:58:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14B8063218
        for <linux-nfs@vger.kernel.org>; Tue, 18 Apr 2023 20:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1214DC433EF;
        Tue, 18 Apr 2023 20:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681851510;
        bh=kTW6qH3LfeNthGNM5SF7dxAsX454yaFXPL2XOxiQ/Kk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cPagfBWND9O5xeW++Mi0Qy3hwpyLfhzPlpXr/u0IB59XnXR03rpoZBbfILM7+e+Ay
         lnSBhSQj+XA/t0DAPlivJxkjUaE+i+Y21ruI43dNGvmGy7cA4OxPqBgj6qzz3FquJc
         kpYSzVW/a8GOtwZa0AMGAGd+ivs5zbtLgjwrCCQnKeK87rUKCMXCv6z0AhmZnhtQMl
         dqEUtcXkLS8EwWOm2UhApXFREdo9L0DqcgLhbTJUKKbztwb/iADzKTSihqeJ5JQR5U
         B261YrOD/aevi9tEiCXNW38qtXBeWLBYtpRnHoUejtGETDpASDiusAnTUbR9nmi42d
         Eg2ajztzucMvQ==
Message-ID: <017f0bc7049f3320ddc298cdcc510abb2e3b2fa9.camel@kernel.org>
Subject: Re: [PATCH] NFSD: Fix problem of COMMIT and NFS4ERR_DELAY in
 infinite loop
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 18 Apr 2023 16:58:28 -0400
In-Reply-To: <1681849891-29377-1-git-send-email-dai.ngo@oracle.com>
References: <1681849891-29377-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-04-18 at 13:31 -0700, Dai Ngo wrote:
> The following request sequence to the same file causes the NFS client and
> server to get into an infinite loop with COMMIT and NFS4ERR_DELAY:
>=20
> OPEN
> REMOVE
> WRITE
> COMMIT
>=20
> Problem reported test recall11, recall12, recall14, recall20, recall22,
> recall40, recall42, recall48, recall50 of nfstest suite.
>=20
> This patch restores the handling of race condition in nfsd_file_do_acquir=
e
> with unlink to that prior of the regression.
>=20
> Fixes: ac3a2585f018 ("nfsd: rework refcounting in filecache")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/filecache.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 6e8712bd7c99..63f7d9f4ea99 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1170,9 +1170,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
>  	 * If construction failed, or we raced with a call to unlink()
>  	 * then unhash.
>  	 */
> -	if (status =3D=3D nfs_ok && key.inode->i_nlink =3D=3D 0)
> -		status =3D nfserr_jukebox;
> -	if (status !=3D nfs_ok)
> +	if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
>  		nfsd_file_unhash(nf);
>  	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
>  	smp_mb__after_atomic();

It took me a min of staring at it, but I think you're right. If the link
count goes to 0, we still want to allow access to it, but we want to
unhash it to make sure that it gets cleaned up ASAP.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
