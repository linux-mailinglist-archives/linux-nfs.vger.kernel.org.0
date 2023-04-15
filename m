Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E88D6E3126
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Apr 2023 13:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDOLmY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Apr 2023 07:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOLmX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Apr 2023 07:42:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D5249EE
        for <linux-nfs@vger.kernel.org>; Sat, 15 Apr 2023 04:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F9D960905
        for <linux-nfs@vger.kernel.org>; Sat, 15 Apr 2023 11:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C2DC433EF;
        Sat, 15 Apr 2023 11:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681558941;
        bh=wI4H4Kk/IigGpqVNCe8P24rp11GMgD5MDFPWNCg+lVM=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=CC9Ta6MHkxcnCLBvcF4sYLe+dYKtNSrd8pyUSSsuDlQNVvRq9ql5rRCzr6IJIF6rd
         gUgtSvLwY1Hsl/podk1DbMIDFQ22rHNPAF58M34qE8uRm9+CHEwG9O77iS0XkTNQv8
         MEgkVqpX7rdtiAoHmyEa3j/xC4tc8gcYlRjb9XiFB6E4U0/tAB9lKWPNC7JhrDT+OP
         tQ1tCuNluJf+HV+juHQvOZ4DFG+TCXLQBtlJxmt3m+aHAp43+5SyNjgUeCpPWbr4/J
         uEkn/Drybu387V8OB/PAtjJ+uQWUCY2QZzDZPCrQyp017f9bw9IllrqXcvLQFcTk0P
         WlqiFduVxqQug==
Message-ID: <e8cbe0fb8292b872ce40b2471a8878478fb71530.camel@kernel.org>
Subject: Re: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
From:   Jeff Layton <jlayton@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Chuck Lever <chuck.lever@oracle.com>,
        Frank van der Linden <fllinden@amazon.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>
Date:   Sat, 15 Apr 2023 07:42:19 -0400
In-Reply-To: <72bf692e-bb6b-c1f2-d1ba-3205ab649b43@I-love.SAKURA.ne.jp>
References: <72bf692e-bb6b-c1f2-d1ba-3205ab649b43@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 2023-04-15 at 20:07 +0900, Tetsuo Handa wrote:
> Since GFP_KERNEL is GFP_NOFS | __GFP_FS, usage like GFP_KERNEL | GFP_NOFS
> does not make sense. Drop __GFP_FS flag in order to avoid deadlock.
>=20
> Fixes: 32119446bb65 ("nfsd: define xattr functions to call into their vfs=
 counterparts")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  fs/nfsd/vfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 5783209f17fc..109b31246666 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -2164,7 +2164,7 @@ nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, char *name,
>  		goto out;
>  	}
> =20
> -	buf =3D kvmalloc(len, GFP_KERNEL | GFP_NOFS);
> +	buf =3D kvmalloc(len, GFP_NOFS);
>  	if (buf =3D=3D NULL) {
>  		err =3D nfserr_jukebox;
>  		goto out;
> @@ -2230,7 +2230,7 @@ nfsd_listxattr(struct svc_rqst *rqstp, struct svc_f=
h *fhp, char **bufp,
>  	/*
>  	 * We're holding i_rwsem - use GFP_NOFS.
>  	 */
> -	buf =3D kvmalloc(len, GFP_KERNEL | GFP_NOFS);
> +	buf =3D kvmalloc(len, GFP_NOFS);
>  	if (buf =3D=3D NULL) {
>  		err =3D nfserr_jukebox;
>  		goto out;

I don't get it.

These are the NFS server handlers for the GETXATTR and LISTXATTR
operations. Basically the client is making a call to the server to fetch
or list xattrs. I don't really see a huge issue with them recursing into
reclaim. It's not like this code is in the writeback path.
--=20
Jeff Layton <jlayton@kernel.org>
