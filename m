Return-Path: <linux-nfs+bounces-18139-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E9DD3B30E
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 18:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BE9930847C2
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 16:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC243A4F40;
	Mon, 19 Jan 2026 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jk+foR3Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CFA3A35C7
	for <linux-nfs@vger.kernel.org>; Mon, 19 Jan 2026 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840993; cv=none; b=WjTu+9mzQciUew2Vj7aLcxmscTBXTB6NU8APAkJjtMbgz2k9KShzYSHXGHj6uU42Z4tw+MPpE+pLECbm02+4sis0bF9XtDv0q4VmKSPhU7rubMBA/U99MZCeIvCjLc+5qi6aUz++g+l4/OfLeeGlPYfc8fqyWdrfyhMn7w73YiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840993; c=relaxed/simple;
	bh=vfqhKWwiRrrnfWX4CrdJmI0n1g3fK/4yGHAQKrOzOrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2y/sduuBYfeOGm8FYKrnA+q4y8kdREBNNNGZ6rR0yKWr8QmyI1GhAUSpYeBsILJwsGezlqAlJRqoBKdfJQPYEoFxfOJ9ZpxvnzmiduZFLRbdE7/OvhYTgccs8Szrm6Mh5rM2SDBrPd+GbJq0ZiQ08TwTTXFm+eitwomZ6Y41cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jk+foR3Y; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-653781de668so6489510a12.2
        for <linux-nfs@vger.kernel.org>; Mon, 19 Jan 2026 08:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768840987; x=1769445787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP488vxzDs37SDvqB3SvtrET0fHZKVUQCP8+UqFkiUw=;
        b=Jk+foR3Y1NyYtu656bCn/sfEHgBt409+gCsXCs/0LgaZFGGwg8DXPQrt9bRa+w85ZO
         7GAONGC9gQZalHggLbpBLn648PK0NMNfnCUa3VAb5DgBjer+MHLLOXY0NfL9j5bLzwgO
         25Tr+eMpP07UuyrNoXeZ2KzBCRNzYtk87vifNwyoAYTJ11vF5HmFCwW9CzIqapg4rrsM
         stIWgt1eQ8hCiTLmpqOSk5MQF1Zj4X3TYgueWu4EwFEwvZEsVIqaBr7etT03WJajjXGO
         wcAv+wQmKEhMJ7mzsh+FvfF5aFDUoQCDacxCMGDN9eQcnBQogCEHWoSenfGpJx1OAZm3
         MQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768840987; x=1769445787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OP488vxzDs37SDvqB3SvtrET0fHZKVUQCP8+UqFkiUw=;
        b=vm2ZZCAVrCuqCMS5w55XQqwiaijb1eNQUK+AAm3giUwcY79QCsb0MjpCDFPY0Tnwsq
         n+jXo2WA0kp/1KVvG/S7M9aDKgIaW5vYZZoabKrxRmNhJghGWbpQ/if64LkA9gfDOyGB
         9eQwUKelh0zdpiUYa4fIWa9knXvn2AcrJNt3G2mveNvvQ1/0RnKqOGXi3SpSIl/DIa2y
         B1NewscEcn7RXMry7BuDHbmGjWWDQS4MoUyqEYgn0vVeRy/u8MGrdcGFE9djiKHk/Ytv
         DmUKiXK4DrieQm1nJBFxuja34bzRyzeF4ASz90pw1rKdfChjudUOoLLidbmjw6YdYNLH
         iySQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYAe1lAS77Efgi8WMW8zQmxsLEQIOIstXFdAHuomjaMuyDt3f2hRp6Lf7OEkccz8yfB1gX+3dFPKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgBumrFqSSu+/X7jCg2ZcxxbRJSIvmUKV9zyfZXCR9tSTBYitO
	ZWsQbZWmXq0IzZrD/RJNDpFjmItNlZchb1qm2I6gaL1DFPGPSga0rnGt/hGtU02pXrdWEoL23/U
	gi6PFgA1/qx4MrYfV4FiEAIsbytkanB4=
X-Gm-Gg: AZuq6aLkoKEr7hXtImQr+8CjkzIfW7RyaNC6bqqA56lfAchW9CO72W3o+/5cWExxZm+
	3xsx+sAzRiPjYdIb1tx6XN+MNEnHfhJ5Z1EoSikZWHYVki5Hq0qqbCWqKuDSqbp/9mFNFbdR9PG
	0y3oLri8atkwk31gytIFeju0h6fnyH/0ohMI2ESKS6Xx+yiezT2YVSf5uv+MTm06ueyj3Kh4dVn
	XZwWWJHFVdnv/SYj8bv4RVRxnU683U/v8rwNsTzH8RyFLDICa6hTklBeGV/gQw7HYm2cgwGnfak
	vPTYwjNsiDm+c3bTfP7gQxmo6V7Jzg==
X-Received: by 2002:a05:6402:4304:b0:649:b200:afe9 with SMTP id
 4fb4d7f45d1cf-65452cca909mr8384256a12.27.1768840987066; Mon, 19 Jan 2026
 08:43:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org> <20260119-exportfs-nfsd-v2-17-d93368f903bd@kernel.org>
In-Reply-To: <20260119-exportfs-nfsd-v2-17-d93368f903bd@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 19 Jan 2026 17:42:54 +0100
X-Gm-Features: AZwV_QiQ9eetgKyRnXUMiKJDXK2vIOYhTLzpDlKP7IN3cG_hSRVA59Z6sNZRsnw
Message-ID: <CAOQ4uxgXovX-rPuAE55D8x4jbNOQdAKJH3O5gpHJDMsT7kNGgw@mail.gmail.com>
Subject: Re: [PATCH v2 17/31] ovl: add EXPORT_OP_STABLE_HANDLES flag to export operations
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

On Mon, Jan 19, 2026 at 5:29=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Add the EXPORT_OP_STABLE_HANDLES flag to overlayfs export operations to
> indicate that this filesystem can be exported via NFS.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/export.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index 83f80fdb156749e65a4ea0ab708cbff338dacdad..18c6aee9dd23bb450dadbe8ee=
f9360ea268241ff 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -865,6 +865,7 @@ const struct export_operations ovl_export_operations =
=3D {
>         .fh_to_parent   =3D ovl_fh_to_parent,
>         .get_name       =3D ovl_get_name,
>         .get_parent     =3D ovl_get_parent,
> +       .flags          =3D EXPORT_OP_STABLE_HANDLES,
>  };
>
>  /* encode_fh() encodes non-decodable file handles with nfs_export=3Doff =
*/
>
> --
> 2.52.0
>

