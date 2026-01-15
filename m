Return-Path: <linux-nfs+bounces-17952-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 683ECD280B7
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 20:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC108309E8B2
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 18:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E753D1CC2;
	Thu, 15 Jan 2026 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSUUWslM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D823C1FF1
	for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768503272; cv=none; b=SnFdXhir0ib0lBhrmuNesm7TpIoO/dNAWiIa9jjPv7Dzzb7itv3wegffY4nMOqqy6ECNcQ9QaiMX5fefCHat5guxxs7f8G0UUx5c31KpUwwNcIqe+tZ7KoKL0GgH+AdtNADadpIcyQjoJlx3w8G0Z7q60hra/Ye9oAYX4dDCsOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768503272; c=relaxed/simple;
	bh=AgB8BlDrSqCt2vWmdgQdkVNbgorviCbIMxtlMVxqyDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vh3gw2nhLp9pWMt5mDqgvC5bRApsl7ajSCCIIBb6d7Aih00Wwd8lIBdXZpn1S4lJ7FfvJOrF8eMFLrH9grrpOJkSQeLQo2L2OKgBW+chOLG2qxCFRJRBzATZrZNtLzwKRwq6jUMs8fzJ8WD6ctpEqaYNwFkf8DBiCtLEaHXMNHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSUUWslM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so770024f8f.2
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 10:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768503269; x=1769108069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/pIR9g5xBWqOZmQj/jDCO8xKQONNisoQQHHakrcMdk=;
        b=MSUUWslM7So/8e5qCKM9JU2cE4putYAvpi8UdtuonqryPMUNC+1PUocWSNmRX6iGft
         Llsnn4u2ChuSQFRjdQYh1n4dcKLsda/c9h8OBQlFkmYO6AbGHtLLYM0SAWhirNpaoF4n
         lakVf7f1knSaC/T5LidHJsjH0TVakBR0PiniEdlaUsoRuFln+7VFqUwQfgRz0i4x4AvS
         ZYRXMKaX2NnbWxFRzsRhO2KaJ3DxCOuFwkiLa7v70xNShq3EGNuiEqzLBa7apuvs8Ev8
         8lR89uWCNysQXzJycZ3fgJA46czSOxtOhpmR8aUQ39pBmNkdExztbB4bfrrOFL9eSKRt
         1A2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768503269; x=1769108069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R/pIR9g5xBWqOZmQj/jDCO8xKQONNisoQQHHakrcMdk=;
        b=T6mvDpgGmhJOCVLNR9ckiQbLLeZSThyJeFbxbNKr1x46HCJxXZyQe4AsgPfAjkM3lt
         0I7kHs2FP7TsFAud50WhRTWEN3y1AsVNYKx5dD6JgjUugPmkYv/S/H3pTs8AKDwJHtZt
         /yaQsSyPHagekZqdXedR5viPNkRLBs6b7tvzuHmK9XF0OLCdNq/mWIhgFtS0WwW7SbXp
         lsSSInr9pFQoZGiepY/IIYBu3ZMY1RVEaq4u8n6HZvR66YG28sUOraO+xqLfN527rXJN
         fJIY/1DRjrHvXBUSw+ffwykehx/Tq4kU5cxzbE8nv+pAgv1GxXfj7gx13OazTHTQ1ebB
         5rLw==
X-Forwarded-Encrypted: i=1; AJvYcCVjHXG+Kp66553UzadSwR5QdyJmKgWUTKV6KdNlke7xne7486GK3M58XweOgGO+z7PTfkuBtXgG7KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHb18hlTH499+WGubNhiUHhbsPbB+9Vf0J5O3dBpyk4Vi1JZhg
	oZkCZ3z2NQfFoXNJ09A9mniIHJSqMYtiEThHqrjxV69Zp0eQFqwIarSiLrk7l8T7NkM2YHZ0DVY
	X6t5EMIcsq40QukOg54h0Gha6f+DBgZo=
X-Gm-Gg: AY/fxX468Ua8L3TapiKlwvvl9YAwUATTH9DZUYv/3pUddMREk6AXr1rP+mlKeHZj6FU
	4/ZLI/quTOAz/j642lrE3/ITn+l4IFvzicHyg3empIaQzP2Ee8wBREk3foIy/9p2ui0pYfzAeT8
	CFUsO8ezwtth46KvqeXssmDGnLNEdW7+IlJ1o3ijGKCm295l8yX9PNGgly37mr4sFhcTCEI7ueR
	CB3wC+2gFE9QuFAiFfq9718kutn4RkIKbB+eXk09OXcIRnqYTFesjsoqVI+e2zUPvMPwQeYLjDH
	RiAQYAORzLDBkOD62AmwfAfbGvV2Hw==
X-Received: by 2002:a05:6000:2313:b0:432:5c43:76 with SMTP id
 ffacd0b85a97d-43569bc17ebmr434376f8f.39.1768503268480; Thu, 15 Jan 2026
 10:54:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org> <20260115-exportfs-nfsd-v1-26-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-26-8e80160e3c0c@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 19:54:17 +0100
X-Gm-Features: AZwV_QgNgqINU2MW0ct-_EKOImgQ1uAwJfq7nKBHPoIgHpyzlMCSNbXGV-6zTEg
Message-ID: <CAOQ4uxh4VaVL9PD7-_Op9Xs-z5Qrx8g6x2x5FccujQX-Cw9RqQ@mail.gmail.com>
Subject: Re: [PATCH 26/29] fuse: add EXPORT_OP_STABLE_HANDLES flag to export operations
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
	Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org, 
	devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 6:50=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Add the EXPORT_OP_STABLE_HANDLES flag to fuse export operations to indica=
te
> that this filesystem can be exported via NFS.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/fuse/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 819e50d666224a6201cfc7f450e0bd37bfe32810..1652a98db639fd75e8201b681=
a29c68b4eab093c 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1208,6 +1208,7 @@ static struct dentry *fuse_get_parent(struct dentry=
 *child)
>  /* only for fid encoding; no support for file handle */
>  static const struct export_operations fuse_export_fid_operations =3D {
>         .encode_fh      =3D fuse_encode_fh,
> +       .flags          =3D EXPORT_OP_STABLE_HANDLES,
>  };

These are used when the server declares FUSE_NO_EXPORT_SUPPORT
so do not opt in for NFS export.

The sad thing w.r.t FUSE is that in most likelihood server does not provide
persistent handles also when it does not declare FUSE_NO_EXPORT_SUPPORT
but we are stuck with that.

Thanks,
Amir.

