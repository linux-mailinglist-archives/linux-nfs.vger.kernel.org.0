Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74136E80CC
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Apr 2023 20:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjDSSDI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Apr 2023 14:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjDSSDH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Apr 2023 14:03:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15A53588
        for <linux-nfs@vger.kernel.org>; Wed, 19 Apr 2023 11:03:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C1236370F
        for <linux-nfs@vger.kernel.org>; Wed, 19 Apr 2023 18:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1E2C433D2;
        Wed, 19 Apr 2023 18:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681927382;
        bh=thr7Casj4Q2pm2u2X0HUNDMk6W2LWPyeHEda5t2j3wU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dvzvgrwZqMxKOWXjgcGJJhVnD16npHQMF4KF+PQDUNBlaWjkGoa0Xs0xQekL3TprQ
         o8VDYUk3le+DkdwlrWYyRXRI9m9ChocBygI+8Oa+OyQdoDCbDP1EEtyCgXhf+wH9RL
         cAfs1DEqyZ+BEvGwPrl/22VB6z5RKtl69CiBPARZ2IQsJzUorKPL2e4YfkxJoBW+GF
         fC/gGUz04n1sXqscunBKqrGU5KKHoyxYdJPTeUqriLNDo7hWnVMMxLdl4g1QNmeJVt
         c/8EgjRfA766E7wu7KnVGYdJ/ImoJgQ9YwIcufOtugGJ2j7XIdnnmVtrRv6HtIWM/n
         qM4bXchkec6CQ==
Message-ID: <b3de8618e1b8d5c06fc1c14cfb4ab687ca63714f.camel@kernel.org>
Subject: Re: [PATCH v2] NFSD: Fix problem of COMMIT and NFS4ERR_DELAY in
 infinite loop
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 19 Apr 2023 14:03:00 -0400
In-Reply-To: <1681926798-13866-1-git-send-email-dai.ngo@oracle.com>
References: <1681926798-13866-1-git-send-email-dai.ngo@oracle.com>
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

On Wed, 2023-04-19 at 10:53 -0700, Dai Ngo wrote:
> The following request sequence to the same file causes the NFS client and
> server getting into an infinite loop with COMMIT and NFS4ERR_DELAY:
>=20
> OPEN
> REMOVE
> WRITE
> COMMIT
>=20
> Problem reported by recall11, recall12, recall14, recall20, recall22,
> recall40, recall42, recall48, recall50 of nfstest suite.
>=20
> This patch restores the handling of race condition in nfsd_file_do_acquir=
e
> with unlink to that prior of the regression.
>=20
> Fixes: ac3a2585f018 ("nfsd: rework refcounting in filecache")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/filecache.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> V2: rebase with nfsd-next
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index f40d8f3b35a4..ee9c923192e0 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1099,8 +1099,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
>  	 * then unhash.
>  	 */
>  	if (status !=3D nfs_ok || inode->i_nlink =3D=3D 0)
> -		status =3D nfserr_jukebox;
> -	if (status !=3D nfs_ok)
>  		nfsd_file_unhash(nf);
>  	clear_and_wake_up_bit(NFSD_FILE_PENDING, &nf->nf_flags);
>  	if (status =3D=3D nfs_ok)

Reviewed-by: Jeff Layton <jlayton@kernel.org>
