Return-Path: <linux-nfs+bounces-18138-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2196ED3B25D
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 17:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C27430DA29E
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 16:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43589395252;
	Mon, 19 Jan 2026 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab0Y4kSR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C09E39341F
	for <linux-nfs@vger.kernel.org>; Mon, 19 Jan 2026 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840894; cv=pass; b=VlVaidqay4yZT7+Nuew+FOvL0mV0U6D4RGWP9qVND/zeZ+D0NHem+Npm5ELf+YYP8psOL5iEscVPAP09Zqoj2/Vub3MSsHmbRAdpwDon2EyMdCnsHfrXzNLH/d3Mh5n0KvRrnWh0llzbVsCDBnVwune1bcoyg6sav6CNGTJTkjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840894; c=relaxed/simple;
	bh=uciaFAPM3zh+7wmp1MXpjWZDIMz+W0jcWQemczxhFSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8HdThGpg98XeVaGCKq8JN0rdmqc432+oKoz6X09INMsoxqCgNBOPmpL29kmd1//CUIVspG/lPfGc1wIrTgBmXz3eAzzEcgGDT9k8KGUM9+dt/KT6CnRhKy69HHX8hswumsaFuTuby3zvAVX0kBvp+H8cA9UtU5Eb5Uk6ydKsu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ab0Y4kSR; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so7728201a12.3
        for <linux-nfs@vger.kernel.org>; Mon, 19 Jan 2026 08:41:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768840890; cv=none;
        d=google.com; s=arc-20240605;
        b=RHeaukKUkwPHBUmVSHZLwZ49SbOZXRSg8aWqaQ26k1X5nELQdQyXZmMgat9HZWMqvW
         /9LYH1Phc+HR4IlFcjW/Vy1n1y5i/HhkRDYBz5QkJi8dvPmLjCrm7O6sW3eck8+2UOa3
         ZNddt9dBeuUmlSxbwZZVQw8/UJrM4fVk2tgZ2pMZfPMJPVXlr2Xzvl4vuioxQErzR6uV
         5sSzYd3BSxIIHkrDDHgduTpuFP1HSYkNlHcWwg+8XHT+40rpyHsHrz5oyh6AhkYcF6c8
         +McjGwk1jH4IKMeZG1H9Na1Bm9eV937/C9FCWWxZAD37gUyThuQLrxX8yCpHz45QAOeO
         FnMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fTdB35vgqJbH8V4J4HP1Mukd5M1Q72aH7//uMfZpgyU=;
        fh=4IXGUnyo0/W5etLupEYLyo42W/G1jdTBJFQBDZkEqWk=;
        b=FGVaRIFHtN4fMm21xqab4SOe2hulCnGrlCkjvQUb+89ZTtcqS5lHGby0z9wMwBcc8t
         6w+mpDtAOr48PuczJNFvuQogJj9K/WCRL/6MlCHmwCNERU/TlEhxtR0t+WUkDWGs/PmL
         UwKssAOE48vVP7X71i77/s4UmmrKehoDLENO8VQQliwC3+DNcfj2CBT1QBlUX7Pfogy4
         INrVq/RxCz2+xxxMohP89cMjSPQ5oj2ZIEX7YZ3FStYyr5MFsiurSnmEivfsxw7ebxnj
         FUQyMDF+4dKXmC2iSwNgxHoNBUFQvFy2I/V1/1jmviP9qqkg45M5FRrKdz+JRBMzabjG
         94oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768840890; x=1769445690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTdB35vgqJbH8V4J4HP1Mukd5M1Q72aH7//uMfZpgyU=;
        b=Ab0Y4kSRdlCDzFDISOShNcLZDpfAcCeDBRvMi0cjAWQkJV+oRiv0css6DqzbACQwRd
         3QH58xRjysSJXrwo/vyJS8BI3icg0//tqdqdc7tdiv0yFt43YGaicJoMqT2HZQSi9Tpr
         +VgpXStxruBBNuK7BmmBKfEut7fdMIdnpIuMMw2Bn/Ut4URgpmZVrd1NymgfXN5lVOwO
         DVfA7kE+ws0cPJd5q5GhICiAzb/7Zow85cmGC243uE1K9bifhPWgCHaw3G++YZlJLqE9
         RXh4skbTnrcnUvc0HPuosOna55LWooi6u7kaX2u0TWmoyvYXWC5OTuYpfSVeYrwK5b9F
         rzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768840890; x=1769445690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fTdB35vgqJbH8V4J4HP1Mukd5M1Q72aH7//uMfZpgyU=;
        b=XOitbWnd5h0TXgP2z4HmSZ0a9UjcsmChnwBkL7MGzQJeRPjXyXU15gAdiErjWWDXbq
         Jl3Y9gx+STPHj1sM9UdgrnQjMsFF341VxJSbj7HHVAV3W0ui4KYKnARrSRt0ehW7d5Pd
         L5hQvJFPhPnOvYGEgHTlg45J/mSvmqbr7vhT8iMR8RUuFstJs5wxn0T77xKGbmpDfdOT
         /f1ZBqOOOmLBzoZptdPHJHKU8v1zRJl6XTXAFT6NIETnGIoOip0Jn4i1jJ3ogs1S7bkR
         2SaDf6rd3Ghsaj8rZ28ImH0keNbr0bczIwk37/l8WSm4g99Ww7d7vPxG3ahvPH59qNBx
         9z5g==
X-Forwarded-Encrypted: i=1; AJvYcCXTKtMjNKP93TDR1SaLM0ElRToZADOcLKwrerxHjGOVsIkOQhmBH2OSgNN1j8kh2Jzdl3aVaZ0lQHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz160VyAdvoiVPGKayJMT0UQUTnxS4Fc8InZlbN4+/2Xr8ryuJ0
	GTSMmdVKZgkHcGS8e3jkcaz3qPIyfr4TDBnziSLCdYgSUCOiYu1WYJRehxDZjvlxYM7o4WPecVh
	CG9RXFA/jHun346PclSez/kAz/3w1lYc=
X-Gm-Gg: AZuq6aKFzIxfZ5zQ9gF41K44myrNL7v+3+o+CP8IeOb3MC8HRobTy8W89QRInbJzF5q
	92CGgZHIZBZda9O8JrrvedrOK/J0gmF5ZAhAFSITckWR4kzGPXVw8Vj/HOOZhnMrTeolrZTYErd
	Yzy0DcDi+c+jMZgRbjNESRlKJ1nSVVwTKyltQSsFx++b+O51d/p6mehU4X3ZhNsvBcXTUpszswv
	JI2kPCeTIZoqfw0x6yvD8iwRDmnLwABfmJ/805sd5SJkdgApSSn5WHXwlB+yXm6A/uHiT5Z2frt
	v3eLsRRPbpFJOb/gN//UJV53dwydWQ==
X-Received: by 2002:a05:6402:518b:b0:64e:f6e1:e517 with SMTP id
 4fb4d7f45d1cf-65452cd98e9mr9387079a12.32.1768840889299; Mon, 19 Jan 2026
 08:41:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org> <20260119-exportfs-nfsd-v2-2-d93368f903bd@kernel.org>
In-Reply-To: <20260119-exportfs-nfsd-v2-2-d93368f903bd@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 19 Jan 2026 17:41:16 +0100
X-Gm-Features: AZwV_QgHvJ6NvIXON-eIYvnT5PkMvN0FHfW-0LujoZ3K-fhpCrZ1N6375iX4_4Y
Message-ID: <CAOQ4uxjX8EcG5XssJ91u8Kn0gY9Rb0qCwnte_7j6Q6knvZ1shw@mail.gmail.com>
Subject: Re: [PATCH v2 02/31] exportfs: add new EXPORT_OP_STABLE_HANDLES flag
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Carlos Maiolino <cem@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
	Andreas Gruenbacher <agruenba@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Laight <david.laight.linux@gmail.com>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
	ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 5:27=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> At one time, nfsd could take the presence of struct export_operations to
> be an indicator that a filesystem was exportable via NFS. Since then, a
> lot of filesystems have grown export operations in order to provide
> filehandle support. Some of those (e.g. kernfs, pidfs, and nsfs) are not
> suitable for export via NFS since they lack filehandles that are
> stable across reboot.
>
> Add a new EXPORT_OP_STABLE_HANDLES flag that indicates that the
> filesystem supports perisistent filehandles,

persistent still here?
"...are stable across the lifetime of a file"?

> a requirement for nfs
> export. While in there, switch to the BIT() macro for defining these
> flags.

Maybe you want to move that cleanup to patch 1 along with the
export.rst sync? not a must.

>
> For now, the flag is not checked anywhere. That will come later after
> we've added it to the existing filesystems that need to remain
> exportable.
>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/filesystems/nfs/exporting.rst |  7 +++++++
>  include/linux/exportfs.h                    | 16 +++++++++-------
>  2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/=
filesystems/nfs/exporting.rst
> index 0583a0516b1e3a3e6a10af95ff88506cf02f7df4..0c29ee44e3484cef84d2d3d47=
819acf172d275a3 100644
> --- a/Documentation/filesystems/nfs/exporting.rst
> +++ b/Documentation/filesystems/nfs/exporting.rst
> @@ -244,3 +244,10 @@ following flags are defined:
>      nfsd. A case in point is reexport of NFS itself, which can't be done
>      safely without coordinating the grace period handling. Other cluster=
ed
>      and networked filesystems can be problematic here as well.
> +
> +  EXPORT_OP_STABLE_HANDLES - This filesystem provides filehandles that a=
re
> +    stable across the lifetime of a file. This is a hard requirement for=
 export
> +    via nfsd. Any filesystem that is eligible to be exported via nfsd mu=
st
> +    indicate this guarantee by setting this flag. Most disk-based filesy=
stems
> +    can do this naturally. Pseudofilesystems that are for local reportin=
g and
> +    control (e.g. kernfs, pidfs, nsfs) usually can't support this.
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index f0cf2714ec52dd942b8f1c455a25702bd7e412b3..c4e0f083290e7e341342cf0b4=
5b58fddda3af65e 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -3,6 +3,7 @@
>  #define LINUX_EXPORTFS_H 1
>
>  #include <linux/types.h>
> +#include <linux/bits.h>
>  #include <linux/path.h>
>
>  struct dentry;
> @@ -277,15 +278,16 @@ struct export_operations {
>                              int nr_iomaps, struct iattr *iattr);
>         int (*permission)(struct handle_to_path_ctx *ctx, unsigned int of=
lags);
>         struct file * (*open)(const struct path *path, unsigned int oflag=
s);
> -#define        EXPORT_OP_NOWCC                 (0x1) /* don't collect v3=
 wcc data */
> -#define        EXPORT_OP_NOSUBTREECHK          (0x2) /* no subtree check=
ing */
> -#define        EXPORT_OP_CLOSE_BEFORE_UNLINK   (0x4) /* close files befo=
re unlink */
> -#define EXPORT_OP_REMOTE_FS            (0x8) /* Filesystem is remote */
> -#define EXPORT_OP_NOATOMIC_ATTR                (0x10) /* Filesystem cann=
ot supply
> +#define EXPORT_OP_NOWCC                        BIT(0) /* don't collect v=
3 wcc data */
> +#define EXPORT_OP_NOSUBTREECHK         BIT(1) /* no subtree checking */
> +#define EXPORT_OP_CLOSE_BEFORE_UNLINK  BIT(2) /* close files before unli=
nk */
> +#define EXPORT_OP_REMOTE_FS            BIT(3) /* Filesystem is remote */
> +#define EXPORT_OP_NOATOMIC_ATTR                BIT(4) /* Filesystem cann=
ot supply
>                                                   atomic attribute update=
s
>                                                 */
> -#define EXPORT_OP_FLUSH_ON_CLOSE       (0x20) /* fs flushes file data on=
 close */
> -#define EXPORT_OP_NOLOCKS              (0x40) /* no file locking support=
 */
> +#define EXPORT_OP_FLUSH_ON_CLOSE       BIT(5) /* fs flushes file data on=
 close */
> +#define EXPORT_OP_NOLOCKS              BIT(6) /* no file locking support=
 */
> +#define EXPORT_OP_STABLE_HANDLES       BIT(7) /* fhs are stable across r=
eboot */
>         unsigned long   flags;
>  };
>
>
> --
> 2.52.0
>

