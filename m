Return-Path: <linux-nfs+bounces-17956-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DF0D280F1
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 20:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CFCB306B077
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 19:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C871A2F659F;
	Thu, 15 Jan 2026 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+d8bhIL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C722248AF
	for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505013; cv=none; b=PtNZQCdyuvBJy9BWea0hHPsvHDgpAqAfpSHfm3++KjApFz1nbbkq6F1kVY6BKyVG+Ra9SVkObl8U9ndeQtaqs5yGQV2OKK4hS0uneuQUxJuoIE1kwdcVDF937hFrhZPOXu2WcjD7Cqd4ZM+vjff8fqmlf5FdEDFIqWnKlxWEYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505013; c=relaxed/simple;
	bh=K7EKeFZcYOwWj32Ok6OEcoTNGvsHPX2vPwhKzUVyoug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R03LYhjyTnYxUbnAY8t4frXG1u2dOlDJ10UtXgN+JgSlupDSwrPK+KXaWjAa4D3EWBpTjYKCvtDd6VuC6JCjkMkacQp1+terAwRo3MtjAJPFm43NgTu31ZnNZ6hOH8mbAXdViNzA4ZAAZkRP87OGpE0ncY7exvrgA/J5VO9oCDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+d8bhIL; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso2620564a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 11:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768505009; x=1769109809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HpNW/ml4xLa7Q+ZYoOd6NCigBelaQL2RtJ0aaDh9mI=;
        b=J+d8bhILA0dbk7t5hkmNO1mcsMKdM8fhTW1Ocr1dvZWCSsmJa7JumfRtv6adpfFHqm
         6EoeiPfosiEqcgJDEF8iRVcBmEzKJZYKHGka5fPFFnEO5DjlmHHCyplVtllcdEWKxVPS
         7f9HnOwO44sfz33ApLvvdQDuS2o1nPotoefgiAzWSyyvN8Mnw9E8397Y9GkYVtAcH5mK
         BTLEixHMcFNcxaRv9OxW2AqX58uGVSpZwSaeQhuPKJdv4mvEVz+EwSWYEdRXMZd2+jiL
         xAd7jVwMUpQ2rqFOyA1wKHBUdFrHiwAMCQeemIRpz7T0KnCZsKby8mDjZ1PerF/UP56G
         g4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505009; x=1769109809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1HpNW/ml4xLa7Q+ZYoOd6NCigBelaQL2RtJ0aaDh9mI=;
        b=V/qxjzC9X+NGLfAxC1azoWcJ+DgJi4JkFUPi5Ud1nu7O+JA8MdvS1qtJhRZF7gKWsa
         HU5s+effADstiM8WTLd8Dk/61355hVWw8OWZlXfCoCdTWR/X4hEoJjYmHOr13XopBK17
         KfIQ1vImxGGMyuJJQ/LNfxC+HEuEnEwQOOVxM6ppbHVyAK048ubIDmteY3SiHVz3ID6p
         xFo3Or1pBxDvq8bzZ7D0gck3bx51IyqLJ9DNdoJk902o4M3cywR/UCpdgfk0CLnWvPID
         eHEbMl2urWHamay4kQWhzm3ObK9CdlJTbQi3hE9bk1zqLlZoO2VuJA1QyY+apw0LJdhz
         BKTw==
X-Forwarded-Encrypted: i=1; AJvYcCWSdqUDR6BVGW90tc7E24D/GOD9cUmNzZrNuveTnTn5Lh0MS34ztX3xf+4CxtQy9BX9nAgynegZYyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5KGcBShLyLi9tKin1kG2O1/zduks1kHxhkumIcj1NZSPGSDHi
	Y7CYb6mJK5R90kiyXB/HOhrFDhr4xgSt/zM8u3FXrt6lPyLU/f6SuN9t5xdanJx/ZKxTV4RQCnR
	Xo/Fh1Vcwl7y0xZrnNl9Tk7eoe8vRLX8=
X-Gm-Gg: AY/fxX5D56xHNzHZd5oGrd3a9sTwQGNHUcSyFN7LyMNAhhJzKyHwe0SoUB8XBXpHuuM
	T0N8vr+G6s4nu0JtcRWaLmdGS/qlP0V2KTVhdEZb7v4vqWtkpx+yZiv5nZtEuiLWjuqGkGqIfJq
	+0SlEaFiVapqXDFT5lNJe2ZC6NOHEZLAth0j8WX2tQCPGUjN4hRptARM4+O18JvL1YwwgDbdcdf
	dnGb8H4NQvJjAmbwV+thzdaDqJ2et372NH3W81WzPh6A/MCJxJ8MwTG48Ij5vwz1Y24upfyw+mk
	v2PfyKgvRK3esNLyym0wkuJAW2vTLg==
X-Received: by 2002:a17:907:3e97:b0:b73:7c3e:e17c with SMTP id
 a640c23a62f3a-b879327e30bmr63085666b.44.1768505008810; Thu, 15 Jan 2026
 11:23:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org> <20260115-exportfs-nfsd-v1-29-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-29-8e80160e3c0c@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 20:23:17 +0100
X-Gm-Features: AZwV_Qj21qC7f0_83CWGwxMbCuhLisWPoHuSIOsZGqfnrVByhBJVGvUqJqXdQ-8
Message-ID: <CAOQ4uxg304=s1Uoeayy3rm1e154Nf7ScOgseJHThw4uQjKwk0A@mail.gmail.com>
Subject: Re: [PATCH 29/29] nfsd: only allow filesystems that set EXPORT_OP_STABLE_HANDLES
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

On Thu, Jan 15, 2026 at 6:51=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Some filesystems have grown export operations in order to provide
> filehandles for local usage. Some of these filesystems are unsuitable
> for use with nfsd, since their filehandles are not persistent across
> reboots.
>
> In __fh_verify, check whether EXPORT_OP_STABLE_HANDLES is set
> and return nfserr_stale if it isn't.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfsfh.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index ed85dd43da18e6d4c4667ff14dc035f2eacff1d6..da9d5fb2e6613c2707195da2e=
8678b3fcb3d444d 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -334,6 +334,10 @@ __fh_verify(struct svc_rqst *rqstp,
>         dentry =3D fhp->fh_dentry;
>         exp =3D fhp->fh_export;
>
> +       error =3D nfserr_stale;
> +       if (!(dentry->d_sb->s_export_op->flags & EXPORT_OP_STABLE_HANDLES=
))
> +               goto out;
> +
>         trace_nfsd_fh_verify(rqstp, fhp, type, access);
>

IDGI. Don't you want  to deny the export of those fs in check_export()?
By the same logic that check_export() checks for can_decode_fh()
not for can_encode_fh().

Thanks,
Amir.

