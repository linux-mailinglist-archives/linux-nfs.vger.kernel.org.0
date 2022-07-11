Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EC2570A07
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 20:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiGKSg4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 14:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiGKSgz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 14:36:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971ED5FAF9
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 11:36:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 295AE61502
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 18:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EB3C34115;
        Mon, 11 Jul 2022 18:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657564612;
        bh=4edvnMtVk3QBa8TySw2kNqkOSMq1ohv1OhZiSxfCgS4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Uf0UZZD+nHBeDRiypw5GhTDC0d3tPHDQwz6EC64HWILwa/nx1+qg1C/rBbWT3LHIo
         Oi29oaY6zfBzW141FeetHn7lIXJlIUB5lAoYX7uuYcp71iRmAhkXtpIYkGwuw/Re89
         JM9f/3x2ALa5j5oVB4+0GlNQxQpVAzds10lYCGjyxrtdf5wehsNo1RsoR6vhwnWtz8
         H1YpcBoJ54wvxFkjOqX9qIGJ3fZ9RDnq/bQ2lhrarCBSrDfDMo4Tf7AjLj4Wfsdtrw
         TAysopfgnovtZUlC5/wZ6nOsnrXBUV1Ruas2/oFaK3yuSMHqInfG1Me8OHnc7FAb2A
         wNixZg0RreWwA==
Message-ID: <60ea4a58791290d479024baab54d384a49181ede.camel@kernel.org>
Subject: Re: [PATCH 1/2] lockd: set fl_owner when unlocking files
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        anna@kernel.org, "J . Bruce Fields" <bfields@fieldses.org>
Date:   Mon, 11 Jul 2022 14:36:50 -0400
In-Reply-To: <20220711183014.15161-2-jlayton@kernel.org>
References: <20220711183014.15161-1-jlayton@kernel.org>
         <20220711183014.15161-2-jlayton@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-07-11 at 14:30 -0400, Jeff Layton wrote:
> Unlocking a POSIX inode with vfs_lock_file only works if the owner
> matches. Ensure we set it in the request.
>=20

Oof, that description makes no sense. How about:

"Unlocking a POSIX lock on an inode with vfs_lock_file..."

> Cc: J. Bruce Fields <bfields@fieldses.org>
> Fixes: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/lockd/svcsubs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> index 0a22a2faf552..b2f277727469 100644
> --- a/fs/lockd/svcsubs.c
> +++ b/fs/lockd/svcsubs.c
> @@ -176,7 +176,7 @@ nlm_delete_file(struct nlm_file *file)
>  	}
>  }
> =20
> -static int nlm_unlock_files(struct nlm_file *file)
> +static int nlm_unlock_files(struct nlm_file *file, fl_owner_t owner)
>  {
>  	struct file_lock lock;
> =20
> @@ -184,6 +184,7 @@ static int nlm_unlock_files(struct nlm_file *file)
>  	lock.fl_type  =3D F_UNLCK;
>  	lock.fl_start =3D 0;
>  	lock.fl_end   =3D OFFSET_MAX;
> +	lock.fl_owner =3D owner;
>  	if (file->f_file[O_RDONLY] &&
>  	    vfs_lock_file(file->f_file[O_RDONLY], F_SETLK, &lock, NULL))
>  		goto out_err;
> @@ -225,7 +226,7 @@ nlm_traverse_locks(struct nlm_host *host, struct nlm_=
file *file,
>  		if (match(lockhost, host)) {
> =20
>  			spin_unlock(&flctx->flc_lock);
> -			if (nlm_unlock_files(file))
> +			if (nlm_unlock_files(file, fl->fl_owner))
>  				return 1;
>  			goto again;
>  		}

--=20
Jeff Layton <jlayton@kernel.org>
