Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669867B7E48
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 13:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjJDLgI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Oct 2023 07:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjJDLgI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Oct 2023 07:36:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080F5A7;
        Wed,  4 Oct 2023 04:36:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F8FC433C8;
        Wed,  4 Oct 2023 11:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696419364;
        bh=mcWA0wViupJvIASfSKZEGUIK3vbJV++064Yp6OBrzsA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cRYgICXeevgKm9jj+UhMkn7tXMCth5y3alN4A5PmHhV/8c/U4MHKo9axgNKiO3n/f
         XYOu5Ypezy9VHQv1eDage3UZq6hS8NCHq+GvwRJIvLboaNrZWy/3/k47khLaq7JrHy
         ljrj1LdoBUy+7pLphrTWG9V9D/jvaR4T7Fnl3LakhPns0xuHeuhl/BFM+moXCXZB/e
         fekNjEht0RZDmgake1QeNixISHiO0c6ie/16S1RRgrVNA/exwg9Fmz3tl8tXyXtc9l
         0X01FXWCQk6RjnfvIC3WB5AWWkQEhqkeRVJwJYKLuVo3dq+txzY7Hr2R+YBjRfx/NR
         WBmXzuQD/xTMw==
Message-ID: <29443ef6dc000b058a49d560759e25a430f6d82d.camel@kernel.org>
Subject: Re: [PATCH] nfs/super: check NFS_CAP_ACLS instead of the NFS version
From:   Jeff Layton <jlayton@kernel.org>
To:     Max Kellermann <max.kellermann@ionos.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     "J . Bruce Fields" <bfields@redhat.com>, stable@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Date:   Wed, 04 Oct 2023 07:36:02 -0400
In-Reply-To: <20230919081844.1096767-1-max.kellermann@ionos.com>
References: <20230919081844.1096767-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-09-19 at 10:18 +0200, Max Kellermann wrote:
> This sets SB_POSIXACL only if ACL support is really enabled, instead
> of always setting SB_POSIXACL if the NFS protocol version
> theoretically supports ACL.
>=20
> The code comment says "We will [apply the umask] ourselves", but that
> happens in posix_acl_create() only if the kernel has POSIX ACL
> support.  Without it, posix_acl_create() is an empty dummy function.
>=20
> So let's not pretend we will apply the umask if we can already know
> that we will never.
>=20
> This fixes a problem where the umask is always ignored in the NFS
> client when compiled without CONFIG_FS_POSIX_ACL.  This is a 4 year
> old regression caused by commit 013cdf1088d723 which itself was not
> completely wrong, but failed to consider all the side effects by
> misdesigned VFS code.
>=20

A little more than 4 years now!

> Reviewed-by: J. Bruce Fields <bfields@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/nfs/super.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 0d6473cb00cb..051986b422b0 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -1064,14 +1064,19 @@ static void nfs_fill_super(struct super_block *sb=
, struct nfs_fs_context *ctx)
>  		 * The VFS shouldn't apply the umask to mode bits.
>  		 * We will do so ourselves when necessary.
>  		 */
> -		sb->s_flags |=3D SB_POSIXACL;
> +		if (NFS_SB(sb)->caps & NFS_CAP_ACLS) {
> +			sb->s_flags |=3D SB_POSIXACL;
> +		}
> +

nit: curly braces aren't needed here

>  		sb->s_time_gran =3D 1;
>  		sb->s_time_min =3D 0;
>  		sb->s_time_max =3D U32_MAX;
>  		sb->s_export_op =3D &nfs_export_ops;
>  		break;
>  	case 4:
> -		sb->s_flags |=3D SB_POSIXACL;
> +		if (NFS_SB(sb)->caps & NFS_CAP_ACLS) {
> +			sb->s_flags |=3D SB_POSIXACL;
> +		}
>  		sb->s_time_gran =3D 1;
>  		sb->s_time_min =3D S64_MIN;
>  		sb->s_time_max =3D S64_MAX;


(cc'ing Christian)

This patch may have a minor conflict with this patch:

https://lore.kernel.org/linux-nfs/20230911-acl-fix-v3-1-b25315333f6c@kernel=
.org/

...but it seems like the right thing to do if POSIX ACLs are compiled
out.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
