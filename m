Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B8F61F125
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 11:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiKGKsz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Nov 2022 05:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiKGKsx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Nov 2022 05:48:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711E617E33
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 02:48:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E607B80FA0
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 10:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE7AC433C1;
        Mon,  7 Nov 2022 10:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667818129;
        bh=NknCIrtoDkoOC2R2T/tAEcab3fc+R+WjT7QYJu9e1ss=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Kj8Yvu8Qt5VYxxXsjrgfLtsh3rfJEzj92irh6UoguYFAEUm+ISveARLOohSQxai2z
         /9uaU2whil++8VVlmlM5BxNh5/LqcmZJZwHXI1JlrOhh3A710MDSXwsrLtUYUEQ/h0
         hXiKEPmELXW4Akjbh24fVlMpvKRNp/mIFvoEIqau9z1D1vfgiNVEloP/m+pEPyYmu8
         1m7DLvhFpp4yPPwgIaWdSGqwnBnZ+o86BEQAkuJxATHspP0DwY+NVlSpH3PS6IrCQS
         ProU5cNWJKxgnAuBtaGIrmesriZB056Y969NNaFYE0fjMhs+/IJW6jgCJMq3bg9bPm
         5ndAb6CAKoxeg==
Message-ID: <2b5cffddf1d4d5791758e267b7184f0263519335.camel@kernel.org>
Subject: Re: [PATCH] lockd: set other missing fields when unlocking files
From:   Jeff Layton <jlayton@kernel.org>
To:     trondmy@kernel.org, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 07 Nov 2022 05:48:47 -0500
In-Reply-To: <20221106190239.404803-1-trondmy@kernel.org>
References: <20221106190239.404803-1-trondmy@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2022-11-06 at 14:02 -0500, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> vfs_lock_file() expects the struct file_lock to be fully initialised by
> the caller. Re-exported NFSv3 has been seen to Oops if the fl_file field
> is NULL.
>=20
> Fixes: aec158242b87 ("lockd: set fl_owner when unlocking files")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/lockd/svcsubs.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> index e1c4617de771..3515f17eaf3f 100644
> --- a/fs/lockd/svcsubs.c
> +++ b/fs/lockd/svcsubs.c
> @@ -176,7 +176,7 @@ nlm_delete_file(struct nlm_file *file)
>  	}
>  }
> =20
> -static int nlm_unlock_files(struct nlm_file *file, fl_owner_t owner)
> +static int nlm_unlock_files(struct nlm_file *file, const struct file_loc=
k *fl)
>  {
>  	struct file_lock lock;
> =20
> @@ -184,12 +184,15 @@ static int nlm_unlock_files(struct nlm_file *file, =
fl_owner_t owner)
>  	lock.fl_type  =3D F_UNLCK;
>  	lock.fl_start =3D 0;
>  	lock.fl_end   =3D OFFSET_MAX;
> -	lock.fl_owner =3D owner;
> -	if (file->f_file[O_RDONLY] &&
> -	    vfs_lock_file(file->f_file[O_RDONLY], F_SETLK, &lock, NULL))
> +	lock.fl_owner =3D fl->fl_owner;
> +	lock.fl_pid   =3D fl->fl_pid;
> +	lock.fl_flags =3D FL_POSIX;
> +
> +	lock.fl_file =3D file->f_file[O_RDONLY];
> +	if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NULL))
>  		goto out_err;
> -	if (file->f_file[O_WRONLY] &&
> -	    vfs_lock_file(file->f_file[O_WRONLY], F_SETLK, &lock, NULL))
> +	lock.fl_file =3D file->f_file[O_WRONLY];
> +	if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NULL))
>  		goto out_err;
>  	return 0;
>  out_err:
> @@ -226,7 +229,7 @@ nlm_traverse_locks(struct nlm_host *host, struct nlm_=
file *file,
>  		if (match(lockhost, host)) {
> =20
>  			spin_unlock(&flctx->flc_lock);
> -			if (nlm_unlock_files(file, fl->fl_owner))
> +			if (nlm_unlock_files(file, fl))
>  				return 1;
>  			goto again;
>  		}

Good catch.

I wonder if we ought to roll an initializer function for file_locks to
make it harder for callers to miss setting some fields like this? One
idea: we could change vfs_lock_file to *not* take a file argument, and
insist that the caller fill out fl_file when calling it? That would make
it harder to screw this up.

In any case, let's take this patch in the interim while we consider
whether and how to clean this up.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
