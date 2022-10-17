Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CFE601671
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 20:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJQSiJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 14:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJQSiI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 14:38:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA8E72B71
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 11:38:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85A57B819BA
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 18:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05183C433D6;
        Mon, 17 Oct 2022 18:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666031884;
        bh=QvBD6/CZbG5bCs9gq4+HXzhnkWz1j/4fsF+JjJPIdbM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oVwUVoru4ABZ+s7vFlyPw9JrxoTzyjBdJixY+D5X79HDs0EGoKFSMSdzMoaBCMYyh
         CWJoqp3UcS5shx/y1Jx0EHAkI31qdgliM+eW9ZOLZZQBqmO4lW+uoHSXroo7uQGExs
         Vrm+guXxRp4ZWruPFfHQxOJQlpuLFNK4wrx1WaVzfWICrqXvcqF8hx1BV5+3wZ3PGh
         lLDZ62jCHShglyOSxY73EGHQjWurWVE/CNob7NPnZRGDYYBB7ZjdN2pR5/DGqOCjVM
         tKx46gOWVgCTLzcRWvWf1uSFlkLzJU6HcdjMSmM3+ps9T9bmGnRHnPWKs6pV0LE8En
         kvxWmEydWK6zw==
Message-ID: <617d0c073b8a8c2d8b44ec71238c4f101727ea7c.camel@kernel.org>
Subject: Re: [PATCH] nfsd: allow disabling NFSv2 at compile time
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 17 Oct 2022 14:38:02 -0400
In-Reply-To: <20221017165353.462811-1-jlayton@kernel.org>
References: <20221017165353.462811-1-jlayton@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-10-17 at 12:53 -0400, Jeff Layton wrote:
> rpc.nfsd stopped supporting NFSv2 a year ago, take the next logical
> step toward deprecating it and allow NFSv2 to be compiled out.
>=20
> We have long-term goal to deprecate NFSv2 in modern kernels. As a step
> toward that, allow disabling NFSv2 serving altogether at compile time.
> Add a new CONFIG_NFSD_V2 option, that can be turned off and rework the
> CONFIG_NFSD_V?_ACL option dependencies.
>=20
> Fix the "versions" file to properly reject versions that aren't compiled
> in, and change the description of CONFIG_NFSD to state that the always-on
> version is 3 now instead of 2.
>=20
> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/Kconfig   | 12 ++++++---
>  fs/nfsd/Makefile  |  5 ++--
>  fs/nfsd/export.c  | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfsctl.c  |  4 +++
>  fs/nfsd/nfsd.h    |  3 +--
>  fs/nfsd/nfsproc.c | 62 -----------------------------------------------
>  fs/nfsd/nfssvc.c  |  6 +++++
>  7 files changed, 83 insertions(+), 70 deletions(-)
>=20
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index f6a2fd3015e7..c3c43b5e3892 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -8,6 +8,7 @@ config NFSD
>  	select SUNRPC
>  	select EXPORTFS
>  	select NFS_ACL_SUPPORT if NFSD_V2_ACL
> +	select NFS_ACL_SUPPORT if NFSD_V3_ACL
>  	depends on MULTIUSER
>  	help
>  	  Choose Y here if you want to allow other computers to access
> @@ -26,19 +27,22 @@ config NFSD
> =20
>  	  Below you can choose which versions of the NFS protocol are
>  	  available to clients mounting the NFS server on this system.
> -	  Support for NFS version 2 (RFC 1094) is always available when
> +	  Support for NFS version 3 (RFC 1813) is always available when
>  	  CONFIG_NFSD is selected.
> =20
>  	  If unsure, say N.
> =20
> -config NFSD_V2_ACL
> -	bool
> +config NFSD_V2
> +	bool "NFS server support for NFS version 2"
>  	depends on NFSD
> =20
> +config NFSD_V2_ACL
> +	bool "NFS server support for the NFSv2 ACL protocol extension"
> +	depends on NFSD_V2
> +
>  config NFSD_V3_ACL
>  	bool "NFS server support for the NFSv3 ACL protocol extension"
>  	depends on NFSD
> -	select NFSD_V2_ACL
>  	help
>  	  Solaris NFS servers support an auxiliary NFSv3 ACL protocol that
>  	  never became an official part of the NFS version 3 protocol.
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index 805c06d5f1b4..6fffc8f03f74 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -10,9 +10,10 @@ obj-$(CONFIG_NFSD)	+=3D nfsd.o
>  # this one should be compiled first, as the tracing macros can easily bl=
ow up
>  nfsd-y			+=3D trace.o
> =20
> -nfsd-y 			+=3D nfssvc.o nfsctl.o nfsproc.o nfsfh.o vfs.o \
> -			   export.o auth.o lockd.o nfscache.o nfsxdr.o \
> +nfsd-y 			+=3D nfssvc.o nfsctl.o nfsfh.o vfs.o \
> +			   export.o auth.o lockd.o nfscache.o \
>  			   stats.o filecache.o nfs3proc.o nfs3xdr.o
> +nfsd-$(CONFIG_NFSD_V2) +=3D nfsproc.o nfsxdr.o
>  nfsd-$(CONFIG_NFSD_V2_ACL) +=3D nfs2acl.o
>  nfsd-$(CONFIG_NFSD_V3_ACL) +=3D nfs3acl.o
>  nfsd-$(CONFIG_NFSD_V4)	+=3D nfs4proc.o nfs4xdr.o nfs4state.o nfs4idmap.o=
 \
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 668c7527b17e..20ba051f89a2 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1183,6 +1183,67 @@ exp_pseudoroot(struct svc_rqst *rqstp, struct svc_=
fh *fhp)
>  	return rv;
>  }
> =20
> +/*
> + * Map errnos to NFS errnos.
> + */
> +__be32
> +nfserrno (int errno)
> +{
> +	static struct {
> +		__be32	nfserr;
> +		int	syserr;
> +	} nfs_errtbl[] =3D {
> +		{ nfs_ok, 0 },
> +		{ nfserr_perm, -EPERM },
> +		{ nfserr_noent, -ENOENT },
> +		{ nfserr_io, -EIO },
> +		{ nfserr_nxio, -ENXIO },
> +		{ nfserr_fbig, -E2BIG },
> +		{ nfserr_stale, -EBADF },
> +		{ nfserr_acces, -EACCES },
> +		{ nfserr_exist, -EEXIST },
> +		{ nfserr_xdev, -EXDEV },
> +		{ nfserr_mlink, -EMLINK },
> +		{ nfserr_nodev, -ENODEV },
> +		{ nfserr_notdir, -ENOTDIR },
> +		{ nfserr_isdir, -EISDIR },
> +		{ nfserr_inval, -EINVAL },
> +		{ nfserr_fbig, -EFBIG },
> +		{ nfserr_nospc, -ENOSPC },
> +		{ nfserr_rofs, -EROFS },
> +		{ nfserr_mlink, -EMLINK },
> +		{ nfserr_nametoolong, -ENAMETOOLONG },
> +		{ nfserr_notempty, -ENOTEMPTY },
> +#ifdef EDQUOT
> +		{ nfserr_dquot, -EDQUOT },
> +#endif
> +		{ nfserr_stale, -ESTALE },
> +		{ nfserr_jukebox, -ETIMEDOUT },
> +		{ nfserr_jukebox, -ERESTARTSYS },
> +		{ nfserr_jukebox, -EAGAIN },
> +		{ nfserr_jukebox, -EWOULDBLOCK },
> +		{ nfserr_jukebox, -ENOMEM },
> +		{ nfserr_io, -ETXTBSY },
> +		{ nfserr_notsupp, -EOPNOTSUPP },
> +		{ nfserr_toosmall, -ETOOSMALL },
> +		{ nfserr_serverfault, -ESERVERFAULT },
> +		{ nfserr_serverfault, -ENFILE },
> +		{ nfserr_io, -EREMOTEIO },
> +		{ nfserr_stale, -EOPENSTALE },
> +		{ nfserr_io, -EUCLEAN },
> +		{ nfserr_perm, -ENOKEY },
> +		{ nfserr_no_grace, -ENOGRACE},
> +	};
> +	int	i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(nfs_errtbl); i++) {
> +		if (nfs_errtbl[i].syserr =3D=3D errno)
> +			return nfs_errtbl[i].nfserr;
> +	}
> +	WARN_ONCE(1, "nfsd: non-standard errno: %d\n", errno);
> +	return nfserr_io;
> +}
> +
>  static struct flags {
>  	int flag;
>  	char *name[2];
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index dc74a947a440..02ed0babd98c 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -581,10 +581,13 @@ static ssize_t __write_versions(struct file *file, =
char *buf, size_t size)
> =20
>  			cmd =3D sign =3D=3D '-' ? NFSD_CLEAR : NFSD_SET;
>  			switch(num) {
> +#ifdef CONFIG_NFSD_V2
>  			case 2:
> +#endif
>  			case 3:
>  				nfsd_vers(nn, num, cmd);
>  				break;
> +#ifdef CONFIG_NFSD_V4
>  			case 4:
>  				if (*minorp =3D=3D '.') {
>  					if (nfsd_minorversion(nn, minor, cmd) < 0)
> @@ -600,6 +603,7 @@ static ssize_t __write_versions(struct file *file, ch=
ar *buf, size_t size)
>  						minor++;
>  				}
>  				break;
> +#endif
>  			default:
>  				return -EINVAL;
>  			}

I think the above hunks are going to turn out to be problematic.
rpc.nfsd still tries to write a string like this:

     rpc.nfsd: Writing version string to kernel: -2 +3 +4 +4.1 +4.2

...and that will get back an -EINVAL now. I'll drop this hunk and send a
v2 after I re-test it.

Cheers,

> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 09726c5b9a31..93b42ef9ed91 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -64,8 +64,7 @@ struct readdir_cd {
> =20
> =20
>  extern struct svc_program	nfsd_program;
> -extern const struct svc_version	nfsd_version2, nfsd_version3,
> -				nfsd_version4;
> +extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_versi=
on4;
>  extern struct mutex		nfsd_mutex;
>  extern spinlock_t		nfsd_drc_lock;
>  extern unsigned long		nfsd_drc_max_mem;
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 82b3ddeacc33..52fc222c34f2 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -848,65 +848,3 @@ const struct svc_version nfsd_version2 =3D {
>  	.vs_dispatch	=3D nfsd_dispatch,
>  	.vs_xdrsize	=3D NFS2_SVC_XDRSIZE,
>  };
> -
> -/*
> - * Map errnos to NFS errnos.
> - */
> -__be32
> -nfserrno (int errno)
> -{
> -	static struct {
> -		__be32	nfserr;
> -		int	syserr;
> -	} nfs_errtbl[] =3D {
> -		{ nfs_ok, 0 },
> -		{ nfserr_perm, -EPERM },
> -		{ nfserr_noent, -ENOENT },
> -		{ nfserr_io, -EIO },
> -		{ nfserr_nxio, -ENXIO },
> -		{ nfserr_fbig, -E2BIG },
> -		{ nfserr_stale, -EBADF },
> -		{ nfserr_acces, -EACCES },
> -		{ nfserr_exist, -EEXIST },
> -		{ nfserr_xdev, -EXDEV },
> -		{ nfserr_mlink, -EMLINK },
> -		{ nfserr_nodev, -ENODEV },
> -		{ nfserr_notdir, -ENOTDIR },
> -		{ nfserr_isdir, -EISDIR },
> -		{ nfserr_inval, -EINVAL },
> -		{ nfserr_fbig, -EFBIG },
> -		{ nfserr_nospc, -ENOSPC },
> -		{ nfserr_rofs, -EROFS },
> -		{ nfserr_mlink, -EMLINK },
> -		{ nfserr_nametoolong, -ENAMETOOLONG },
> -		{ nfserr_notempty, -ENOTEMPTY },
> -#ifdef EDQUOT
> -		{ nfserr_dquot, -EDQUOT },
> -#endif
> -		{ nfserr_stale, -ESTALE },
> -		{ nfserr_jukebox, -ETIMEDOUT },
> -		{ nfserr_jukebox, -ERESTARTSYS },
> -		{ nfserr_jukebox, -EAGAIN },
> -		{ nfserr_jukebox, -EWOULDBLOCK },
> -		{ nfserr_jukebox, -ENOMEM },
> -		{ nfserr_io, -ETXTBSY },
> -		{ nfserr_notsupp, -EOPNOTSUPP },
> -		{ nfserr_toosmall, -ETOOSMALL },
> -		{ nfserr_serverfault, -ESERVERFAULT },
> -		{ nfserr_serverfault, -ENFILE },
> -		{ nfserr_io, -EREMOTEIO },
> -		{ nfserr_stale, -EOPENSTALE },
> -		{ nfserr_io, -EUCLEAN },
> -		{ nfserr_perm, -ENOKEY },
> -		{ nfserr_no_grace, -ENOGRACE},
> -	};
> -	int	i;
> -
> -	for (i =3D 0; i < ARRAY_SIZE(nfs_errtbl); i++) {
> -		if (nfs_errtbl[i].syserr =3D=3D errno)
> -			return nfs_errtbl[i].nfserr;
> -	}
> -	WARN_ONCE(1, "nfsd: non-standard errno: %d\n", errno);
> -	return nfserr_io;
> -}
> -
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index bfbd9f672f59..62e473b0ca52 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -91,8 +91,12 @@ unsigned long	nfsd_drc_mem_used;
>  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
>  static struct svc_stat	nfsd_acl_svcstats;
>  static const struct svc_version *nfsd_acl_version[] =3D {
> +# if defined(CONFIG_NFSD_V2_ACL)
>  	[2] =3D &nfsd_acl_version2,
> +# endif
> +# if defined(CONFIG_NFSD_V3_ACL)
>  	[3] =3D &nfsd_acl_version3,
> +# endif
>  };
> =20
>  #define NFSD_ACL_MINVERS            2
> @@ -116,7 +120,9 @@ static struct svc_stat	nfsd_acl_svcstats =3D {
>  #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
> =20
>  static const struct svc_version *nfsd_version[] =3D {
> +#if defined(CONFIG_NFSD_V2)
>  	[2] =3D &nfsd_version2,
> +#endif
>  	[3] =3D &nfsd_version3,
>  #if defined(CONFIG_NFSD_V4)
>  	[4] =3D &nfsd_version4,

--=20
Jeff Layton <jlayton@kernel.org>
