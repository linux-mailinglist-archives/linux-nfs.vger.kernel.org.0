Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CFA7CDFBD
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Oct 2023 16:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344873AbjJRO2q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Oct 2023 10:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345009AbjJRO2p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Oct 2023 10:28:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9057A10D
        for <linux-nfs@vger.kernel.org>; Wed, 18 Oct 2023 07:28:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9878DC433C7;
        Wed, 18 Oct 2023 14:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697639323;
        bh=oYhl9MfxU1VJMaMsInexscT/Bcqx780AEyZ+o5KwS/Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kEfeWy9U5mN0z1ZyUah0lyeWWShMGUaqSPgYY8Y0RfpPO5nsbSSv9OVL/jW6k5i0O
         yAFJ4B8v1CYRJsI3rdnyDzK7Pc28SvDc/qe8agHlNJDQetecX5rGr13hbZ36wEG7hu
         GFq1Y0A8i8u7LneGUZ+NOW/isCE4vby4XvLk7eXvjUeeb9n2bI/T9QrxRDWWP/E55H
         UG4//uIWYLkMBKofHhuz1XY4qnNvAHAb4J+n9ytJRJUJj/6fJBEhl9Bho2JvxvfbNa
         ESVq3v9FAxe9gaMH6Q6TfltZb5XU5rkfdTAv2+QRDsCEeLhcMw3h3qjijukRCqqQ7+
         hDh1jx22EtfIA==
Message-ID: <f4f27df2a26605a01b2e7f62a8ec6d946695e1d6.camel@kernel.org>
Subject: Re: [PATCH 5/5] exportfs: support encoding non-decodeable file
 handles by default
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 18 Oct 2023 10:28:41 -0400
In-Reply-To: <20231018100000.2453965-6-amir73il@gmail.com>
References: <20231018100000.2453965-1-amir73il@gmail.com>
         <20231018100000.2453965-6-amir73il@gmail.com>
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

On Wed, 2023-10-18 at 13:00 +0300, Amir Goldstein wrote:
> AT_HANDLE_FID was added as an API for name_to_handle_at() that request
> the encoding of a file id, which is not intended to be decoded.
>=20
> This file id is used by fanotify to describe objects in events.
>=20
> So far, overlayfs is the only filesystem that supports encoding
> non-decodeable file ids, by providing export_operations with an
> ->encode_fh() method and without a ->decode_fh() method.
>=20
> Add support for encoding non-decodeable file ids to all the filesystems
> that do not provide export_operations, by encoding a file id of type
> FILEID_INO64_GEN from { i_ino, i_generation }.
>=20
> A filesystem may that does not support NFS export, can opt-out of
> encoding non-decodeable file ids for fanotify by defining an empty
> export_operations struct (i.e. with a NULL ->encode_fh() method).
>=20
> This allows the use of fanotify events with file ids on filesystems
> like 9p which do not support NFS export to bring fanotify in feature
> parity with inotify on those filesystems.
>=20
> Note that fanotify also requires that the filesystems report a non-null
> fsid.  Currently, many simple filesystems that have support for inotify
> (e.g. debugfs, tracefs, sysfs) report a null fsid, so can still not be
> used with fanotify in file id reporting mode.
>=20
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/exportfs/expfs.c      | 30 +++++++++++++++++++++++++++---
>  include/linux/exportfs.h | 10 +++++++---
>  2 files changed, 34 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 30da4539e257..34e7d835d4ef 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -383,6 +383,30 @@ int generic_encode_ino32_fh(struct inode *inode, __u=
32 *fh, int *max_len,
>  }
>  EXPORT_SYMBOL_GPL(generic_encode_ino32_fh);
> =20
> +/**
> + * exportfs_encode_ino64_fid - encode non-decodeable 64bit ino file id
> + * @inode:   the object to encode
> + * @fid:     where to store the file handle fragment
> + * @max_len: maximum length to store there
> + *
> + * This generic function is used to encode a non-decodeable file id for
> + * fanotify for filesystems that do not support NFS export.
> + */
> +static int exportfs_encode_ino64_fid(struct inode *inode, struct fid *fi=
d,
> +				     int *max_len)
> +{
> +	if (*max_len < 3) {
> +		*max_len =3D 3;
> +		return FILEID_INVALID;
> +	}
> +
> +	fid->i64.ino =3D inode->i_ino;
> +	fid->i64.gen =3D inode->i_generation;

Note that i_ino is unsigned long and so is a 32-bit value on 32-bit
arches. If the backend storage uses 64-bit inodes, then we usually end
up hashing them down to 32-bits first. e.g. see nfs_fattr_to_ino_t().
ceph has some similar code.

The upshot is that if you're relying on i_ino, the value can change
between different arches, even when they are dealing with the same
backend filesystem.

Since this is expected to be used by filesystems that don't set up
export operations, then that may just be something they have to deal
with. I'm not sure what else you can use in lieu of i_ino in this case.

> +	*max_len =3D 3;
> +
> +	return FILEID_INO64_GEN;
> +}
> +
>  /**
>   * exportfs_encode_inode_fh - encode a file handle from inode
>   * @inode:   the object to encode
> @@ -401,10 +425,10 @@ int exportfs_encode_inode_fh(struct inode *inode, s=
truct fid *fid,
>  	if (!exportfs_can_encode_fh(nop, flags))
>  		return -EOPNOTSUPP;
> =20
> -	if (nop && nop->encode_fh)
> -		return nop->encode_fh(inode, fid->raw, max_len, parent);
> +	if (!nop && (flags & EXPORT_FH_FID))
> +		return exportfs_encode_ino64_fid(inode, fid, max_len);
> =20
> -	return -EOPNOTSUPP;
> +	return nop->encode_fh(inode, fid->raw, max_len, parent);
>  }
>  EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);
> =20
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 21eeb9f6bdbd..6688e457da64 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -134,7 +134,11 @@ struct fid {
>  			u32 parent_ino;
>  			u32 parent_gen;
>  		} i32;
> - 		struct {
> +		struct {
> +			u64 ino;
> +			u32 gen;
> +		} __packed i64;
> +		struct {
>   			u32 block;
>   			u16 partref;
>   			u16 parent_partref;
> @@ -246,7 +250,7 @@ extern int exportfs_encode_fh(struct dentry *dentry, =
struct fid *fid,
> =20
>  static inline bool exportfs_can_encode_fid(const struct export_operation=
s *nop)
>  {
> -	return nop && nop->encode_fh;
> +	return !nop || nop->encode_fh;
>  }
> =20
>  static inline bool exportfs_can_decode_fh(const struct export_operations=
 *nop)
> @@ -259,7 +263,7 @@ static inline bool exportfs_can_encode_fh(const struc=
t export_operations *nop,
>  {
>  	/*
>  	 * If a non-decodeable file handle was requested, we only need to make
> -	 * sure that filesystem can encode file handles.
> +	 * sure that filesystem did not opt-out of encoding fid.
>  	 */
>  	if (fh_flags & EXPORT_FH_FID)
>  		return exportfs_can_encode_fid(nop);

--=20
Jeff Layton <jlayton@kernel.org>
