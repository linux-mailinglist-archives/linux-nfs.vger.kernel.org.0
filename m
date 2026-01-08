Return-Path: <linux-nfs+bounces-17672-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BEDD06772
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 23:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D132D30313C6
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 22:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D82D3382E3;
	Thu,  8 Jan 2026 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP1UdLXw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DE9337BA6
	for <linux-nfs@vger.kernel.org>; Thu,  8 Jan 2026 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767912445; cv=none; b=cUZxIvNLQvjrzjbxIti+GVGaI0xStBzLH7ivjeLZt20tZMTVEd/s0rdDOEIggoQVhYy/leXkdoluj3QkWQEanHKT8dp1MQcPwzNn9jizQ2dGd1rDQtdQjP+DZvToLMADlXYC5rgSMPaItlip2QJaXth5nECWMdr1EimXHU8Sj0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767912445; c=relaxed/simple;
	bh=bpLucB2OVlqnpdSgR5fVsT/9lEifzVxq4+Kg3z371KE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHmQoBYO3Lqh4AU5CB6ELHrmoewShoxkJQVY/8lp02OPCrimo/4aKJiwjL2RRkEOzgVnEwYl8mBKYect95vqW+PFW5L/oOaJkYO041O2TCjpTBdqi8gJNvgv65moF+xYDqmOy3vWcAMS2ZolkZmILbesTYQIgw/Jj5sV4IWkPSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MP1UdLXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F3BC4AF0B
	for <linux-nfs@vger.kernel.org>; Thu,  8 Jan 2026 22:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767912445;
	bh=bpLucB2OVlqnpdSgR5fVsT/9lEifzVxq4+Kg3z371KE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MP1UdLXwQQbLrM6Komf71g93oG5NAi4MgNEJp0IP2YLRqIxJYJEGKSbAKijNJe9WZ
	 IbUC0JnTxU/qLQDrG9kXDCvY/KfYmyL9GeyIJOjmaIXspIW/o7k0iV2tHUENwHwzPN
	 NRrOCqXk3gvMQBQtrS8mLLm7F848JGTBwVsTZR7pNtTBS5B7CMXyINqvgK5RPJnSVz
	 GFki95hPNr007fQyijDV9keWL9jmHoR0/VagscyvPOtaB/xyBqxK7+PfgbDbJ04Oo3
	 g/Nr4lG2JxkvUJ/Yl7c9tXjsXlYGom8FgLY4xtR/3QMt2w1rVNsE6ddiVElPTlDjdW
	 FO9Lh8Le3/Afg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b8123c333so5988314a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 08 Jan 2026 14:47:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmZYFbIVJYJhRTFHsYPWPaRgg3ACWrT6g17aJXZ8tJ9pN0ULLiPo7ia2Hw9GyoTkqEmDzbWr6qcrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9DJBmXbXrztlvYFQD8gMr51x8FJh4PQZbOO/RvwCA/zfP7nCg
	NSt5nsoWxFHHGnKS/iiYKQkjmtxtTxd0Q8FKSzlcv5qrFBMcGVvldCO81+Y0I2vv58cQ76Xhw5K
	w0rBIndu+mSx0Igb8LGKKduPwZJfjbxM=
X-Google-Smtp-Source: AGHT+IHRRvrZk+LJHsAd5/mP4TyTtkU5XrZgqXx3MfUuP0vWFtvlehE6tE5BFAh0/XFz8o1ILqvfmo203M6g5zkxlKk=
X-Received: by 2002:a17:907:c1e:b0:b72:c261:3ad2 with SMTP id
 a640c23a62f3a-b84451dab67mr854015966b.50.1767912442100; Thu, 08 Jan 2026
 14:47:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org> <20260108-setlease-6-20-v1-7-ea4dec9b67fa@kernel.org>
In-Reply-To: <20260108-setlease-6-20-v1-7-ea4dec9b67fa@kernel.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 9 Jan 2026 07:47:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-JTE+233AwpvrXTsbfrbY+U_pvyUTQQSwz0mXh43jt=A@mail.gmail.com>
X-Gm-Features: AQt7F2q41Fu16p_9dWtEjvrFao8uwKCSAe9mKCbLxMeS3Ih2bsPKkzatUTosKic
Message-ID: <CAKYAXd-JTE+233AwpvrXTsbfrbY+U_pvyUTQQSwz0mXh43jt=A@mail.gmail.com>
Subject: Re: [PATCH 07/24] exfat: add setlease file operation
To: Jeff Layton <jlayton@kernel.org>
Cc: Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
	Anders Larsen <al@alarsen.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Carlos Maiolino <cem@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	gfs2@lists.linux.dev, linux-doc@vger.kernel.org, v9fs@lists.linux.dev, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 2:14=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> Add the setlease file_operation to exfat_file_operations and
> exfat_dir_operations, pointing to generic_setlease.  A future patch
> will change the default behavior to reject lease attempts with -EINVAL
> when there is no setlease file operation defined. Add generic_setlease
> to retain the ability to set leases on this filesystem.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

