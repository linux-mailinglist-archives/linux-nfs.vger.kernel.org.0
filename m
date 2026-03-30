Return-Path: <linux-nfs+bounces-20514-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBxxGOtkymn27gUAu9opvQ
	(envelope-from <linux-nfs+bounces-20514-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 13:56:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B819B35AAD2
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 13:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C67E304E81A
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 11:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BF13C873A;
	Mon, 30 Mar 2026 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWLn5mqD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B5A379EE6;
	Mon, 30 Mar 2026 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871377; cv=none; b=IcruMOABh0hFFR9nR9GMBFYEjrtaZRKaG9AA+Dnpcd5jv/YcgWCE5t3lBEIgKuW+PzQXdHFXChau9nkECAcWZpmtd7FR9+BdXzvURRwU7DtSWvK9sI4WRaIUGDeTxroI62SKaDZ+MgrkTioFVvZeDSiqP9WekYBh8Pc8Eeuerdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871377; c=relaxed/simple;
	bh=/8WzswybKla9aLTsAZPQ/I93opQJFj7woUIQNX4rlpI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C7ejJviRi3qcIiynly0wn6LpmnUGd3PMaDw5+Uz8JKxhlANvNrYUUxYy5BO23im14gp2xeE5yCoLrCb8g5IMAk5itzRqg/7SWZyyGZwZVOCbNasYqK9k3F3aSV6N/Jjp+Yi2iAMjGw3Yr2IqpSwFkQVqDH8IdTcsJUXZlhSWpWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWLn5mqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F62DC4CEF7;
	Mon, 30 Mar 2026 11:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774871376;
	bh=/8WzswybKla9aLTsAZPQ/I93opQJFj7woUIQNX4rlpI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gWLn5mqD/OB+8BsLDh9e/U72uQ5iaiB/ju4vZskS50/JsoRf9Qb9knx5C4t3lZK1+
	 C4Dpj8SCDUZL4BtSlTfBJddA+2Y7wf/009mSjRbPjvyf03Ha3eMf1d64HWyVVE0Hn2
	 x5FkCcgL4cIRdU3kh79GnKZ0veSKzx4bIRll7whh9IRYlM+UmSU/E9BGaXeHTL/RJ0
	 eKgKoHoclmRX1f3dzLFldl5dY9bLQw1R3qH+uYs1peVCEzHc7wiwoy5b6UPX+N0T1b
	 9GiMiTRU8TnUps1FDOTh7QIF2qcIQmb4adgX5FHkjAtagsNzcXVkJJYX8+Zp37mpsg
	 qlG9T0+4S1y0w==
Message-ID: <e526fbdb450a593b575355c1c9ae21f286427275.camel@kernel.org>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
From: Jeff Layton <jlayton@kernel.org>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev,
 linux-nfs@vger.kernel.org, 	linux-cifs@vger.kernel.org,
 v9fs@lists.linux.dev, 	linux-kselftest@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, 	jack@suse.cz,
 chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
 deller@gmx.de, 	davem@davemloft.net, andreas@gaisler.com,
 idryomov@gmail.com, amarkuze@redhat.com, 	slava@dubeyko.com,
 agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com,
 shuah@kernel.org, 	miklos@szeredi.hu, hansg@kernel.org
Date: Mon, 30 Mar 2026 07:49:30 -0400
In-Reply-To: <20260328172314.45807-2-dorjoychy111@gmail.com>
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
	 <20260328172314.45807-2-dorjoychy111@gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20514-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,HansenPartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uapi-group.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B819B35AAD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 2026-03-28 at 23:22 +0600, Dorjoy Chowdhury wrote:
> This flag indicates the path should be opened if it's a regular file.
> This is useful to write secure programs that want to avoid being
> tricked into opening device nodes with special semantics while thinking
> they operate on regular files. This is a requested feature from the
> uapi-group[1].
>=20
> A corresponding error code EFTYPE has been introduced. For example, if
> openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> like FreeBSD, macOS.
>=20
> When used in combination with O_CREAT, either the regular file is
> created, or if the path already exists, it is opened if it's a regular
> file. Otherwise, -EFTYPE is returned.
>=20
> When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is returned
> as it doesn't make sense to open a path that is both a directory and a
> regular file.
>=20
> [1]: https://uapi-group.org/kernel-features/#ability-to-only-open-regular=
-files
>=20
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---
>  arch/alpha/include/uapi/asm/errno.h        |  2 ++
>  arch/alpha/include/uapi/asm/fcntl.h        |  1 +
>  arch/mips/include/uapi/asm/errno.h         |  2 ++
>  arch/parisc/include/uapi/asm/errno.h       |  2 ++
>  arch/parisc/include/uapi/asm/fcntl.h       |  1 +
>  arch/sparc/include/uapi/asm/errno.h        |  2 ++
>  arch/sparc/include/uapi/asm/fcntl.h        |  1 +
>  fs/ceph/file.c                             |  4 ++++
>  fs/fcntl.c                                 |  4 ++--
>  fs/gfs2/inode.c                            |  6 ++++++
>  fs/namei.c                                 |  4 ++++
>  fs/nfs/dir.c                               |  4 ++++
>  fs/open.c                                  |  8 +++++---
>  fs/smb/client/dir.c                        | 14 +++++++++++++-
>  include/linux/fcntl.h                      |  2 ++
>  include/uapi/asm-generic/errno.h           |  2 ++
>  include/uapi/asm-generic/fcntl.h           |  4 ++++
>  tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
>  tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
>  tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
>  tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
>  tools/include/uapi/asm-generic/errno.h     |  2 ++
>  22 files changed, 67 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/include/uap=
i/asm/errno.h
> index 6791f6508632..1a99f38813c7 100644
> --- a/arch/alpha/include/uapi/asm/errno.h
> +++ b/arch/alpha/include/uapi/asm/errno.h
> @@ -127,4 +127,6 @@
> =20
>  #define EHWPOISON	139	/* Memory page has hardware error */
> =20
> +#define EFTYPE		140	/* Wrong file type for the intended operation */
> +
>  #endif
> diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/uap=
i/asm/fcntl.h
> index 50bdc8e8a271..fe488bf7c18e 100644
> --- a/arch/alpha/include/uapi/asm/fcntl.h
> +++ b/arch/alpha/include/uapi/asm/fcntl.h
> @@ -34,6 +34,7 @@
> =20
>  #define O_PATH		040000000
>  #define __O_TMPFILE	0100000000
> +#define OPENAT2_REGULAR	0200000000
> =20
>  #define F_GETLK		7
>  #define F_SETLK		8
> diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include/uapi/=
asm/errno.h
> index c01ed91b1ef4..1835a50b69ce 100644
> --- a/arch/mips/include/uapi/asm/errno.h
> +++ b/arch/mips/include/uapi/asm/errno.h
> @@ -126,6 +126,8 @@
> =20
>  #define EHWPOISON	168	/* Memory page has hardware error */
> =20
> +#define EFTYPE		169	/* Wrong file type for the intended operation */
> +
>  #define EDQUOT		1133	/* Quota exceeded */
> =20
> =20
> diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include/u=
api/asm/errno.h
> index 8cbc07c1903e..93194fbb0a80 100644
> --- a/arch/parisc/include/uapi/asm/errno.h
> +++ b/arch/parisc/include/uapi/asm/errno.h
> @@ -124,4 +124,6 @@
> =20
>  #define EHWPOISON	257	/* Memory page has hardware error */
> =20
> +#define EFTYPE		258	/* Wrong file type for the intended operation */
> +
>  #endif
> diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include/u=
api/asm/fcntl.h
> index 03dee816cb13..d46812f2f0f4 100644
> --- a/arch/parisc/include/uapi/asm/fcntl.h
> +++ b/arch/parisc/include/uapi/asm/fcntl.h
> @@ -19,6 +19,7 @@
> =20
>  #define O_PATH		020000000
>  #define __O_TMPFILE	040000000
> +#define OPENAT2_REGULAR	0100000000
> =20
>  #define F_GETLK64	8
>  #define F_SETLK64	9
> diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include/uap=
i/asm/errno.h
> index 4a41e7835fd5..71940ec9130b 100644
> --- a/arch/sparc/include/uapi/asm/errno.h
> +++ b/arch/sparc/include/uapi/asm/errno.h
> @@ -117,4 +117,6 @@
> =20
>  #define EHWPOISON	135	/* Memory page has hardware error */
> =20
> +#define EFTYPE		136	/* Wrong file type for the intended operation */
> +
>  #endif
> diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uap=
i/asm/fcntl.h
> index 67dae75e5274..bb6e9fa94bc9 100644
> --- a/arch/sparc/include/uapi/asm/fcntl.h
> +++ b/arch/sparc/include/uapi/asm/fcntl.h
> @@ -37,6 +37,7 @@
> =20
>  #define O_PATH		0x1000000
>  #define __O_TMPFILE	0x2000000
> +#define OPENAT2_REGULAR	0x4000000
> =20
>  #define F_GETOWN	5	/*  for sockets. */
>  #define F_SETOWN	6	/*  for sockets. */
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 66bbf6d517a9..6d8d4c7765e6 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -977,6 +977,10 @@ int ceph_atomic_open(struct inode *dir, struct dentr=
y *dentry,
>  			ceph_init_inode_acls(newino, &as_ctx);
>  			file->f_mode |=3D FMODE_CREATED;
>  		}
> +		if ((flags & OPENAT2_REGULAR) && !d_is_reg(dentry)) {
> +			err =3D -EFTYPE;
> +			goto out_req;
> +		}

^^^
This doesn't look quite right. Here's a larger chunk of the code:

-------------------------8<--------------------------
        if (d_in_lookup(dentry)) {                                         =
                        =20
                dn =3D ceph_finish_lookup(req, dentry, err);               =
                          =20
                if (IS_ERR(dn))                                            =
                        =20
                        err =3D PTR_ERR(dn);                               =
                          =20
        } else {                                                           =
                        =20
                /* we were given a hashed negative dentry */               =
                        =20
                dn =3D NULL;                                               =
                          =20
        }                                                                  =
                        =20
        if (err)                                                           =
                        =20
                goto out_req;                                              =
                        =20
        if (dn || d_really_is_negative(dentry) || d_is_symlink(dentry)) {  =
                        =20
                /* make vfs retry on splice, ENOENT, or symlink */         =
                        =20
                doutc(cl, "finish_no_open on dn %p\n", dn);                =
                        =20
                err =3D finish_no_open(file, dn);                          =
                          =20
        } else {                                                           =
                        =20
                if (IS_ENCRYPTED(dir) &&                                   =
                        =20
                    !fscrypt_has_permitted_context(dir, d_inode(dentry))) {=
                        =20
                        pr_warn_client(cl,                                 =
                        =20
                                "Inconsistent encryption context (parent %l=
lx:%llx child %llx:%llx)\n",
                                ceph_vinop(dir), ceph_vinop(d_inode(dentry)=
));                     =20
                        goto out_req;                                      =
                        =20
                }                                                          =
                        =20
                                                                           =
                        =20
                doutc(cl, "finish_open on dn %p\n", dn);                   =
                        =20
                if (req->r_op =3D=3D CEPH_MDS_OP_CREATE && req->r_reply_inf=
o.has_create_ino) {         =20
                        struct inode *newino =3D d_inode(dentry);          =
                          =20
                                                                           =
                        =20
                        cache_file_layout(dir, newino);                    =
                        =20
                        ceph_init_inode_acls(newino, &as_ctx);             =
                        =20
                        file->f_mode |=3D FMODE_CREATED;                   =
                          =20
                }                                                          =
                        =20
                err =3D finish_open(file, dentry, ceph_open);              =
                          =20
        }                                                                  =
                        =20
-------------------------8<--------------------------

It looks like this won't handle it correctly if the pathwalk terminates
on a symlink (re: d_is_symlink() case). You should either set up a test
ceph cluster on your own, or reach out to the ceph community and ask
them to test this.

>  		err =3D finish_open(file, dentry, ceph_open);
>  	}
>  out_req:
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index beab8080badf..240bb511557a 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -1169,9 +1169,9 @@ static int __init fcntl_init(void)
>  	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
>  	 * is defined as O_NONBLOCK on some platforms and not on others.
>  	 */
> -	BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=3D
> +	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
>  		HWEIGHT32(
> -			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
> +			(VALID_OPENAT2_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
>  			__FMODE_EXEC));
> =20
>  	fasync_cache =3D kmem_cache_create("fasync_cache",
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 8344040ecaf7..4604e2e8a9cc 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -738,6 +738,12 @@ static int gfs2_create_inode(struct inode *dir, stru=
ct dentry *dentry,
>  	inode =3D gfs2_dir_search(dir, &dentry->d_name, !S_ISREG(mode) || excl)=
;
>  	error =3D PTR_ERR(inode);
>  	if (!IS_ERR(inode)) {
> +		if (file && (file->f_flags & OPENAT2_REGULAR) && !S_ISREG(inode->i_mod=
e)) {

Isn't OPENAT2_REGULAR getting masked off in ->f_flags now?

JFYI: it's quite simple to set up a single-node gfs2 fs to test this.

> +			iput(inode);
> +			inode =3D NULL;
> +			error =3D -EFTYPE;
> +			goto fail_gunlock;
> +		}
>  		if (S_ISDIR(inode->i_mode)) {
>  			iput(inode);
>  			inode =3D NULL;
> diff --git a/fs/namei.c b/fs/namei.c
> index 2113958c3b7a..e557c538c238 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4679,6 +4679,10 @@ static int do_open(struct nameidata *nd,
>  		if (unlikely(error))
>  			return error;
>  	}
> +
> +	if ((open_flag & OPENAT2_REGULAR) && !d_is_reg(nd->path.dentry))
> +		return -EFTYPE;
> +
>  	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
>  		return -ENOTDIR;
> =20
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index ddc3789363a5..bfe9470327c8 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2195,6 +2195,10 @@ int nfs_atomic_open(struct inode *dir, struct dent=
ry *dentry,
>  			break;
>  		case -EISDIR:
>  		case -ENOTDIR:
> +			if (open_flags & OPENAT2_REGULAR) {
> +				err =3D -EFTYPE;
> +				break;
> +			}
>  			goto no_open;
>  		case -ELOOP:
>  			if (!(open_flags & O_NOFOLLOW))
> diff --git a/fs/open.c b/fs/open.c
> index 681d405bc61e..a6f445f72181 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -960,7 +960,7 @@ static int do_dentry_open(struct file *f,
>  	if (f->f_mapping->a_ops && f->f_mapping->a_ops->direct_IO)
>  		f->f_mode |=3D FMODE_CAN_ODIRECT;
> =20
> -	f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
> +	f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | OPENAT2_REGUL=
AR);
>  	f->f_iocb_flags =3D iocb_flags(f);
> =20
>  	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
> @@ -1183,7 +1183,7 @@ inline int build_open_flags(const struct open_how *=
how, struct open_flags *op)
>  	int lookup_flags =3D 0;
>  	int acc_mode =3D ACC_MODE(flags);
> =20
> -	BUILD_BUG_ON_MSG(upper_32_bits(VALID_OPEN_FLAGS),
> +	BUILD_BUG_ON_MSG(upper_32_bits(VALID_OPENAT2_FLAGS),
>  			 "struct open_flags doesn't yet handle flags > 32 bits");
> =20
>  	/*
> @@ -1196,7 +1196,7 @@ inline int build_open_flags(const struct open_how *=
how, struct open_flags *op)
>  	 * values before calling build_open_flags(), but openat2(2) checks all
>  	 * of its arguments.
>  	 */
> -	if (flags & ~VALID_OPEN_FLAGS)
> +	if (flags & ~VALID_OPENAT2_FLAGS)
>  		return -EINVAL;
>  	if (how->resolve & ~VALID_RESOLVE_FLAGS)
>  		return -EINVAL;
> @@ -1235,6 +1235,8 @@ inline int build_open_flags(const struct open_how *=
how, struct open_flags *op)
>  			return -EINVAL;
>  		if (!(acc_mode & MAY_WRITE))
>  			return -EINVAL;
> +	} else if ((flags & O_DIRECTORY) && (flags & OPENAT2_REGULAR)) {
> +		return -EINVAL;
>  	}
>  	if (flags & O_PATH) {
>  		/* O_PATH only permits certain other flags to be set. */
> diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
> index 953f1fee8cb8..355681ebacf1 100644
> --- a/fs/smb/client/dir.c
> +++ b/fs/smb/client/dir.c
> @@ -222,6 +222,13 @@ static int cifs_do_create(struct inode *inode, struc=
t dentry *direntry, unsigned
>  				goto cifs_create_get_file_info;
>  			}
> =20
> +			if ((oflags & OPENAT2_REGULAR) && !S_ISREG(newinode->i_mode)) {
> +				CIFSSMBClose(xid, tcon, fid->netfid);
> +				iput(newinode);
> +				rc =3D -EFTYPE;
> +				goto out;
> +			}
> +
>  			if (S_ISDIR(newinode->i_mode)) {
>  				CIFSSMBClose(xid, tcon, fid->netfid);
>  				iput(newinode);
> @@ -436,11 +443,16 @@ static int cifs_do_create(struct inode *inode, stru=
ct dentry *direntry, unsigned
>  		goto out_err;
>  	}
> =20
> -	if (newinode)
> +	if (newinode) {
> +		if ((oflags & OPENAT2_REGULAR) && !S_ISREG(newinode->i_mode)) {
> +			rc =3D -EFTYPE;
> +			goto out_err;
> +		}
>  		if (S_ISDIR(newinode->i_mode)) {
>  			rc =3D -EISDIR;
>  			goto out_err;
>  		}
> +	}
> =20
>  	d_drop(direntry);
>  	d_add(direntry, newinode);
> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index a332e79b3207..a80026718217 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -12,6 +12,8 @@
>  	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
>  	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> =20
> +#define VALID_OPENAT2_FLAGS (VALID_OPEN_FLAGS | OPENAT2_REGULAR)
> +
>  /* List of all valid flags for the how->resolve argument: */
>  #define VALID_RESOLVE_FLAGS \
>  	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
> diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/=
errno.h
> index 92e7ae493ee3..bd78e69e0a43 100644
> --- a/include/uapi/asm-generic/errno.h
> +++ b/include/uapi/asm-generic/errno.h
> @@ -122,4 +122,6 @@
> =20
>  #define EHWPOISON	133	/* Memory page has hardware error */
> =20
> +#define EFTYPE		134	/* Wrong file type for the intended operation */
> +
>  #endif
> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/=
fcntl.h
> index 613475285643..b2c2ddd0edc0 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -88,6 +88,10 @@
>  #define __O_TMPFILE	020000000
>  #endif
> =20
> +#ifndef OPENAT2_REGULAR
> +#define OPENAT2_REGULAR	040000000
> +#endif
> +
>  /* a horrid kludge trying to make sure that this will fail on old kernel=
s */
>  #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
> =20
> diff --git a/tools/arch/alpha/include/uapi/asm/errno.h b/tools/arch/alpha=
/include/uapi/asm/errno.h
> index 6791f6508632..1a99f38813c7 100644
> --- a/tools/arch/alpha/include/uapi/asm/errno.h
> +++ b/tools/arch/alpha/include/uapi/asm/errno.h
> @@ -127,4 +127,6 @@
> =20
>  #define EHWPOISON	139	/* Memory page has hardware error */
> =20
> +#define EFTYPE		140	/* Wrong file type for the intended operation */
> +
>  #endif
> diff --git a/tools/arch/mips/include/uapi/asm/errno.h b/tools/arch/mips/i=
nclude/uapi/asm/errno.h
> index c01ed91b1ef4..1835a50b69ce 100644
> --- a/tools/arch/mips/include/uapi/asm/errno.h
> +++ b/tools/arch/mips/include/uapi/asm/errno.h
> @@ -126,6 +126,8 @@
> =20
>  #define EHWPOISON	168	/* Memory page has hardware error */
> =20
> +#define EFTYPE		169	/* Wrong file type for the intended operation */
> +
>  #define EDQUOT		1133	/* Quota exceeded */
> =20
> =20
> diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arch/pari=
sc/include/uapi/asm/errno.h
> index 8cbc07c1903e..93194fbb0a80 100644
> --- a/tools/arch/parisc/include/uapi/asm/errno.h
> +++ b/tools/arch/parisc/include/uapi/asm/errno.h
> @@ -124,4 +124,6 @@
> =20
>  #define EHWPOISON	257	/* Memory page has hardware error */
> =20
> +#define EFTYPE		258	/* Wrong file type for the intended operation */
> +
>  #endif
> diff --git a/tools/arch/sparc/include/uapi/asm/errno.h b/tools/arch/sparc=
/include/uapi/asm/errno.h
> index 4a41e7835fd5..71940ec9130b 100644
> --- a/tools/arch/sparc/include/uapi/asm/errno.h
> +++ b/tools/arch/sparc/include/uapi/asm/errno.h
> @@ -117,4 +117,6 @@
> =20
>  #define EHWPOISON	135	/* Memory page has hardware error */
> =20
> +#define EFTYPE		136	/* Wrong file type for the intended operation */
> +
>  #endif
> diff --git a/tools/include/uapi/asm-generic/errno.h b/tools/include/uapi/=
asm-generic/errno.h
> index 92e7ae493ee3..bd78e69e0a43 100644
> --- a/tools/include/uapi/asm-generic/errno.h
> +++ b/tools/include/uapi/asm-generic/errno.h
> @@ -122,4 +122,6 @@
> =20
>  #define EHWPOISON	133	/* Memory page has hardware error */
> =20
> +#define EFTYPE		134	/* Wrong file type for the intended operation */
> +
>  #endif

--=20
Jeff Layton <jlayton@kernel.org>

