Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8393D72C628
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 15:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjFLNjd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 09:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjFLNjd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 09:39:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8F5E9;
        Mon, 12 Jun 2023 06:39:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC37A61EBE;
        Mon, 12 Jun 2023 13:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DD3C433D2;
        Mon, 12 Jun 2023 13:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686577171;
        bh=wEoJQ3A+BRKgwTVRAcz29FSzdwNTmkYdgc6OOibuFIo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hNAMNIRWAtXV7FbehAhFmf2nIiBM9pGzCsUrAK2pYe2N3xSHZfp7Sf4OagNOKYBz+
         NRV2jU50l1MVQr/Lj7P/MotUTzl9Exo24X+xn0a090EQ3tuO60kKgCoZdPME9YReB4
         N8snrmeLmKogHqFrhjINaP3TMxwGsjMpvibfpVkRvBye437M7Zc7rYwDHumvIaEnU8
         4XJWu+9vDi+JfZ//FtLKCbPevJt22j1p/u9x+N4rWLKkGIdeW/7t6SGO7e4M37qXG3
         cqRoWtKFOgy4fHYswDO49CcXMPeqkH0UxQJJfv6DR6+ePtH06IgvJmY5RHRnio7vHp
         nrQy+1YmbHilA==
Message-ID: <5cc527156b186ec0f57ebd82874cc6eda2866c92.camel@kernel.org>
Subject: Re: [PATCH] nfs: don't report STATX_BTIME in ->getattr
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, NeilBrown <neilb@suse.de>
Cc:     stable@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Boyang Xue <bxue@redhat.com>
Date:   Mon, 12 Jun 2023 09:39:29 -0400
In-Reply-To: <20230612133404.181166-1-jlayton@kernel.org>
References: <20230612133404.181166-1-jlayton@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-06-12 at 09:34 -0400, Jeff Layton wrote:
> NFS doesn't properly support reporting the btime in getattr (yet), but
> 61a968b4f05e mistakenly added it to the request_mask. This causes statx
> for STATX_BTIME to report a zeroed out btime instead of properly
> clearing the flag.
>=20
> Cc: stable@vger.kernel.org # v6.3+
> Fixes: 61a968b4f05e ("nfs: report the inode version in getattr if request=
ed")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>


Trond/Anna,

If this patch looks OK, could you also add these tags to the commit log?

    Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2214134
    Reported-by: Boyang Xue <bxue@redhat.com>

I forgot to tack them on before sending.

Thanks!

> ---
>  fs/nfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index bc4cac08bb24..9b51ffd7281d 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -846,7 +846,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct=
 path *path,
> =20
>  	request_mask &=3D STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_UID |
>  			STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTIME |
> -			STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_BTIME |
> +			STATX_INO | STATX_SIZE | STATX_BLOCKS |
>  			STATX_CHANGE_COOKIE;
> =20
>  	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
--=20
Jeff Layton <jlayton@kernel.org>
