Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77D37CDFE3
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Oct 2023 16:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbjJROcp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Oct 2023 10:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345620AbjJROcc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Oct 2023 10:32:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A8B6A4C
        for <linux-nfs@vger.kernel.org>; Wed, 18 Oct 2023 07:18:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0BFC433C7;
        Wed, 18 Oct 2023 14:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638685;
        bh=UB2hb8s5CEd3FPPIfnwCMCcqL6WX+kKb6T2In5KzbfY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=in80ri9duSGMlOA42NDLRVWiGWKWI1hoLO2QmWeLNj/jIvZ5lbrv7jmTfP8Tk0kUG
         CwyLBHEsmB0SnfD64r+zGIXAQEsWHt9urtYBoihNMBmXRr06JDIMwAamTYPY7pv3Qc
         j8f8LcsHfksAouIIB2JvIKMPcCbYlfbBmLeGHjYg5RXUya+NryZIgaqU47jcC1zeYB
         Qd8AHBA8jZ9xqsRty0odusQRmgQqrtn6E6QMkByNKd0cfq77ebbAjNCxMcmQK8n8m6
         f9BNAD0kvuvQ4mzv14BErDYZoId3MS+LG2EQG1rQeUZJBuycxbde5648nmzT1qYscI
         uuuT4mW2XNY+w==
Message-ID: <4106d2d1f94dcc992d6bd9b4d478f9a5588c6403.camel@kernel.org>
Subject: Re: [PATCH 4/5] exportfs: define FILEID_INO64_GEN* file handle types
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 18 Oct 2023 10:18:03 -0400
In-Reply-To: <20231018100000.2453965-5-amir73il@gmail.com>
References: <20231018100000.2453965-1-amir73il@gmail.com>
         <20231018100000.2453965-5-amir73il@gmail.com>
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

On Wed, 2023-10-18 at 12:59 +0300, Amir Goldstein wrote:
> Similar to the common FILEID_INO32* file handle types, define common
> FILEID_INO64* file handle types.
>=20
> The type values of FILEID_INO64_GEN and FILEID_INO64_GEN_PARENT are the
> values returned by fuse and xfs for 64bit ino encoded file handle types.
>=20
> Note that these type value are filesystem specific and they do not define
> a universal file handle format, for example:
> fuse encodes FILEID_INO64_GEN as [ino-hi32,ino-lo32,gen] and xfs encodes
> FILEID_INO64_GEN as [hostr-order-ino64,gen] (a.k.a xfs_fid64).
>=20
> The FILEID_INO64_GEN fhandle type is going to be used for file ids for
> fanotify from filesystems that do not support NFS export.
>=20
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/fuse/inode.c          |  7 ++++---
>  include/linux/exportfs.h | 11 +++++++++++
>  2 files changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 2e4eb7cf26fb..e63f966698a5 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1002,7 +1002,7 @@ static int fuse_encode_fh(struct inode *inode, u32 =
*fh, int *max_len,
>  	}
> =20
>  	*max_len =3D len;
> -	return parent ? 0x82 : 0x81;
> +	return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
>  }
> =20
>  static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
> @@ -1010,7 +1010,8 @@ static struct dentry *fuse_fh_to_dentry(struct supe=
r_block *sb,
>  {
>  	struct fuse_inode_handle handle;
> =20
> -	if ((fh_type !=3D 0x81 && fh_type !=3D 0x82) || fh_len < 3)
> +	if ((fh_type !=3D FILEID_INO64_GEN &&
> +	     fh_type !=3D FILEID_INO64_GEN_PARENT) || fh_len < 3)
>  		return NULL;
> =20
>  	handle.nodeid =3D (u64) fid->raw[0] << 32;
> @@ -1024,7 +1025,7 @@ static struct dentry *fuse_fh_to_parent(struct supe=
r_block *sb,
>  {
>  	struct fuse_inode_handle parent;
> =20
> -	if (fh_type !=3D 0x82 || fh_len < 6)
> +	if (fh_type !=3D FILEID_INO64_GEN_PARENT || fh_len < 6)
>  		return NULL;
> =20
>  	parent.nodeid =3D (u64) fid->raw[3] << 32;
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 6b6e01321405..21eeb9f6bdbd 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -98,6 +98,17 @@ enum fid_type {
>  	 */
>  	FILEID_FAT_WITH_PARENT =3D 0x72,
> =20
> +	/*
> +	 * 64 bit inode number, 32 bit generation number.
> +	 */
> +	FILEID_INO64_GEN =3D 0x81,
> +
> +	/*
> +	 * 64 bit inode number, 32 bit generation number,
> +	 * 64 bit parent inode number, 32 bit parent generation.
> +	 */
> +	FILEID_INO64_GEN_PARENT =3D 0x82,
> +
>  	/*
>  	 * 128 bit child FID (struct lu_fid)
>  	 * 128 bit parent FID (struct lu_fid)

Reviewed-by: Jeff Layton <jlayton@kernel.org>
