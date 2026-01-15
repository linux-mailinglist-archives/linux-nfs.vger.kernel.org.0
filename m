Return-Path: <linux-nfs+bounces-17957-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D082ED2811A
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 20:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 765EF301D5E6
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 19:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9529306B0A;
	Thu, 15 Jan 2026 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeYkh6LQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320483043CE
	for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505221; cv=none; b=NcQORR4tNiMMLAb22rIeKNEmqzu/4enO8D0P48iguoD2r9vU6MhmxJEUYfFm87SrVi/I26YHo64yIuEYcFtyDE5WVuGT+35HRKf/b3BmLZ5rj0YkaIrFFPx4XVMTGGcLRB7qaYPHyGgIi7zO+IPBWbx+7T54RVj3tFqdabgv0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505221; c=relaxed/simple;
	bh=UxolFbMwV2HRPaKQ37FO6EpPTEmN4gnY7UWNmQTK8QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7lPeq5LL7kfX+2cF4Vd8RMxq6qIKEhdxQcV5UEyzvYciDimfCwusxG1tamfMWe58qNyimXueNaDdC10QtQlGlKl+dIP/6duIysQ5b4N+Pn/MPsRzL54g3i32gUEL+aUdS4b11WFrxEtS5l0esOxoV7eIsGE0bsISyrdMT90yHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeYkh6LQ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-652fdd043f9so2506937a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 11:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768505203; x=1769110003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDUsn+SB7H7nYSne5YCtxozzRNZ3DAEsXPNjynL2NCs=;
        b=jeYkh6LQnrMNum47mNvGKoVjO/I9SkMrt7kbWqlPen2GXrVBsnc6hWeCGFjIMO1POA
         uouMQm1neKqzIvHhwNBO8yia6bx/AyD5Eufh+wojMWO30CXRGnlaGaeMpMLimS9Q4+3l
         AJ9Kt4y6yIGyAmKuYVLgHe9w92/h91g44hW5VVfG2RZigbV9CQnm92B2EVGb/fSOLa36
         Bc7kpb2pG/WV5PF36MB+t5omZvZbx+1weeW4WcgUU4Lf/XgiwZY/F/6/7va6ejnyT3l0
         SXEhI/dvmLZPz1AEBOSSpUF9OONSYeR/JisXcMTmjhE61tC/o5FTnV01RYtD2dy3wd08
         Tc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505203; x=1769110003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aDUsn+SB7H7nYSne5YCtxozzRNZ3DAEsXPNjynL2NCs=;
        b=H2EN/rptAlK0V8xytSf5fJ0MZVuESpYiKthj01TcNuZPPdqiG53TdTOSJMRlr6in0u
         P04dh+TcVoI2RU5HQ8Iuwa4prwldVq0d32ydK4fsJ98/iRNzQK51i2OebE9vVDAl1ULG
         q/5jwkdKOsee61GCl7tTaccc/H1U9NGamaifvc2UdKUAEJyWC0fKtMucYNDvTiZWkqet
         bLExhT9lY/ZjpVoosuIfh5om6g4Zi/NcITegMcU/3hzsURiprCd4KgmFBaVOqwdN1E9Q
         oxVSn2P/v+YtJj34sycad9ZZ150smQNXXusp4AU6m2S8Wb5449KvXGxDUb68ogkb67ll
         xKCg==
X-Forwarded-Encrypted: i=1; AJvYcCW4BCuumyXcRRGuQobp1fm44ldI1kTIqwzxc2Gaqqs71llEgnGMzX+lPGcNBZtmMPgpOYEzenI2MOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDZabUlZYZ3I5lSIYpvUQw8PDpXtO77oCMyC+u7S3vrYIgV4XU
	5gtKRjGUQ7h/820ynVDbE363iY8JE43QoELLb63Uy78cs222uIP/vt9aotC0dee0sseqkZVkd3c
	05wbGMm3EtgSdBKER8k2dE95qAZLS3Jo=
X-Gm-Gg: AY/fxX4L5c0NLsvDj58RujS8STcASVhCS/aSl6DD2niEQqJx7MNbZB2R1dY2RXsPQa5
	ejguCI8u/3TAtr8aTnz90KsjXRDBO35Tv3e6lNR8X34iH02TOPki9V0WwIEOZCI9EQTtmyzrG5Y
	EO2B4QVJVTBK8gkX07nlywG16Tel6pqgTYCUuoVUQf3uLMHvlw6WdBjnp/rBWbKlucFEZtd7FF8
	WIsRrezNMFgmw4shMGJaVrNhNW1haDyqjBipwl9gtwQ4HEXVLvc0CcY0bsyC/kkXlnmRPCab9dQ
	j4mhxgpWd+5hGmtgsmK4w779/dQhiA==
X-Received: by 2002:a05:6402:4402:b0:64b:4540:6edb with SMTP id
 4fb4d7f45d1cf-65452ad0f58mr442903a12.22.1768505202965; Thu, 15 Jan 2026
 11:26:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org> <20260115-exportfs-nfsd-v1-15-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-15-8e80160e3c0c@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 20:26:31 +0100
X-Gm-Features: AZwV_QgHlhd5AJtx9A_oESS7w6U6eCWyUuqrhH3MyU474xj2Kq62KuhGZ4o-aoc
Message-ID: <CAOQ4uxiTE+8r+F-e91cg9wZY-fjZfSHHOeLk3RWb+2JQQZvbvA@mail.gmail.com>
Subject: Re: [PATCH 15/29] smb/client: add EXPORT_OP_STABLE_HANDLES flag to
 export operations
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

On Thu, Jan 15, 2026 at 6:49=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Add the EXPORT_OP_STABLE_HANDLES flag to cifs export operations to indica=
te
> that this filesystem can be exported via NFS.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/smb/client/export.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/smb/client/export.c b/fs/smb/client/export.c
> index d606e8cbcb7db2b4026675bd9cbc264834687807..c1c23e21bfe610f1b5bf8d0ee=
a64ab49e2c6ee3a 100644
> --- a/fs/smb/client/export.c
> +++ b/fs/smb/client/export.c
> @@ -47,6 +47,7 @@ const struct export_operations cifs_export_ops =3D {
>   * Following export operations are mandatory for NFS export support:
>   *     .fh_to_dentry =3D
>   */
> +       .flags =3D EXPORT_OP_STABLE_HANDLES,

Kind of odd to have this here after the comment out of NFS export.
Maybe add it inside the comment...

Thanks,
Amir.

