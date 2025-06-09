Return-Path: <linux-nfs+bounces-12200-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEEFAD18E5
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 09:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8337A275B
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 07:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9997280CC8;
	Mon,  9 Jun 2025 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc7J+JPJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADCD258CC9;
	Mon,  9 Jun 2025 07:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749453192; cv=none; b=nZ2ghDgTX0uU6u5FpoJci89Qf6NNldCxOAEn5QBsfMCe375357YOzzPYsTxybC8d+xh3IzRts7njl0KV+ZkANHRcdNz+05JQ4fozoGMyg8pATkl3/duFzt34Ea+UhRSfYmdCXOpLPs++CUd/WgofKNBk8aecffJ//X5jalJUFlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749453192; c=relaxed/simple;
	bh=fi1paGJdgHDlXNfaHrXiU9rQB8m/XbjUbFl5aP8Odrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GCLX1C6+9UsV/m8+zHKFjDHP/nff8G9batk3MPSu2zcL6W7mq0Oz2I4thYg68YpWAvO4BNCmpdZhyKhudDdwVQpPdG5rWhZwnVxIWPvTjB2mroyKJbaS0yeFNwgQvt94zjsPNzDb0J07u/vuYesstl8NSrCQHKBwrESqsQTRlHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc7J+JPJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad89333d603so687064966b.2;
        Mon, 09 Jun 2025 00:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749453189; x=1750057989; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWarZ9ZMdObeBZ49vJa9NkdLfUndOrCRlVd7nNHjgkE=;
        b=Gc7J+JPJ0QYKGWzw5CnBxLtQ3Ny99HJDBYiD0/1ClSRT471uw5AAsh52CqCrlKPfdg
         fLNEk/2YunlRwDjrls35Y0gsHnsSqIvBB4ZSL/6EalmLCN5iGGLUvRUdCMVsGh4rB+SV
         57CEEHj/DFGnlE+DmFeegUQW46QDxHHCSUWkqAf+az2DdqwLe71KyjANmggNnOeMViB7
         hKPK8ZPXsKzENzkCPC2thjdm9s5JVtYVUVLRm2Nb/ohwRMXkEMlxdGVQQk1yyD9dne75
         GnRdFcZyR4hkAv/wwYVawcXE4M+taYOm1YEEgZ+6XAUEYrQ+MtGCKZazee8BIxAgPund
         z+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749453189; x=1750057989;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWarZ9ZMdObeBZ49vJa9NkdLfUndOrCRlVd7nNHjgkE=;
        b=SEVtBkd4lm0jzvbkF8Mh5Rxr9sNwiGMwJ0dYHmZSsm2Xbay07JGK8P6QyKmuE60ouE
         91s3kacLtUf5RuFtANX0BT7IK32prSW5A5DwOo++ioKBRz7ka9ckUg6X56fFDhnDvw6n
         AOofakoAUyudSCYTl9foqAvRPNaOENmXl5llcADyAesZLjt8Us/ChduSCom4J+3bTOTV
         PGwlSVitJPzmrN1JlAjDWyUpDQlH1BU7ooPxD7Gl7JNNCvecdV1TyBY5pQzAOsmV9+p2
         ccjcr58/tXpJPQpWROgjYHos/SbC02VP3Qumslo53N+0nPWNkWrFF1GKf1NlfPgBlqgY
         3UOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzgnnxhG+4KQJ6Uybaj2kZIzyk8UJ9o4yRjz8cPOTc1pnY3TUzsm+asbQOApm/giaTRggMtQPN@vger.kernel.org, AJvYcCXkgkTIDsUpMl80TpVBFcfRmSOo2fu/p6fzT3Mr+5jMrLAED0iKA2NwnqoLBkgt3BWEv3ThyLNosls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUxmdRACc09d/purt+i7jjg9QJRIlrU6bCMtUlLO5N53UJ3HN3
	gIrI7luFIsrD55alFpkM6kdQmgKbz9x3VDZa5ySy3lOg4IlkRTmvtj+vXIZpHfnS0kdLZanraSk
	wAb18pXLBxzwbAqs/yZxL8zdpigQbnIpRJA==
X-Gm-Gg: ASbGncvM2Uyqe5c98O/ZaBbN7CcL9W64eLeg2bsF+bLxA+YhSEbu1K2a4jTCQujF8db
	nu1keNTV/MfOb8j0yaHs30II0rg4NKuA46ByySE0/y/DyLF0SgouzytBnDzOoOubbYVE/d7rYaR
	QH4IdBlggJBgaLq46TNo2bwhz+6Ihr+l2FV9O0mEnqa9li0Nwx5gJqwA==
X-Google-Smtp-Source: AGHT+IEJH7AWdzIKuU271At2s5quZavoLb/6M5/tI0nZJPjOLf79/ZHTdUAAH5cMVXTU8slyGRg5Del9trG3mu3ak64=
X-Received: by 2002:a17:907:9694:b0:ad8:a9fc:8146 with SMTP id
 a640c23a62f3a-ade1a9e82c8mr951947166b.44.1749453188693; Mon, 09 Jun 2025
 00:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606154350.548104-1-sashal@kernel.org> <20250606154350.548104-3-sashal@kernel.org>
In-Reply-To: <20250606154350.548104-3-sashal@kernel.org>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Mon, 9 Jun 2025 09:12:00 +0200
X-Gm-Features: AX0GCFsxY7OzBcgpJK9l9zP2o22SfTR5S4GY1r-zW8DY02hwxwakmpIBcXS9kdc
Message-ID: <CAPJSo4XSoTNVvH8MpZWD4W50u=U4bw6YBCnNeiJZpe2LT-YNYg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.1 3/9] NFSv4: Always set NLINK even if the
 server doesn't support it
To: patches@lists.linux.dev, stable@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Jun 2025 at 17:48, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Han Young <hanyang.tony@bytedance.com>
>
> [ Upstream commit 3a3065352f73381d3a1aa0ccab44aec3a5a9b365 ]
>
> fattr4_numlinks is a recommended attribute, so the client should emulate
> it even if the server doesn't support it. In decode_attr_nlink function
> in nfs4xdr.c, nlink is initialized to 1. However, this default value
> isn't set to the inode due to the check in nfs_fhget.
>
> So if the server doesn't support numlinks, inode's nlink will be zero,
> the mount will fail with error "Stale file handle". Set the nlink to 1
> if the server doesn't support it.
>
> Signed-off-by: Han Young <hanyang.tony@bytedance.com>
> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>
> Based on my analysis of the commit and the kernel source code, here is
> my determination: **YES** This commit should be backported to stable
> kernel trees. Here's my extensive analysis: ## Critical Bug Fix Analysis
> ### 1. **Root Cause Understanding** The commit addresses a critical
> issue where NFSv4 mounts fail with "Stale file handle" errors when the
> server doesn't support the `fattr4_numlinks` (NLINK) attribute. Looking
> at the code: - In `/home/sasha/linux/fs/nfs/nfs4xdr.c:3969`, the
> `decode_attr_nlink` function initializes `*nlink =3D 1` as a default -
> However, in `/home/sasha/linux/fs/nfs/inode.c:556-559`, the current
> logic only sets the inode's nlink if `fattr->valid &
> NFS_ATTR_FATTR_NLINK` is true - When the server doesn't support
> numlinks, the `fattr->valid` flag isn't set, so the inode's nlink
> remains 0 (from initial inode allocation) ### 2. **Impact of Zero
> nlink** From `/home/sasha/linux/fs/nfs/dir.c:1578-1582`, I can see the
> critical check: ```c if (inode->i_nlink > 0 || (inode->i_nlink =3D=3D 0 &=
&
> test_bit(NFS_INO_PRESERVE_UNLINKED, &NFS_I(inode)->flags))) return 0;
> else return -ESTALE; ``` When `i_nlink =3D=3D 0` and the
> `NFS_INO_PRESERVE_UNLINKED` flag isn't set, NFS returns `-ESTALE`,
> causing "Stale file handle" errors and mount failures. ### 3. **Backport
> Suitability Criteria** **=E2=9C=85 Fixes important user-affecting bug**: =
Mount
> failures prevent basic filesystem functionality **=E2=9C=85 Small and con=
tained
> fix**: The change adds only 2 lines: ```c else if (fattr_supported &
> NFS_ATTR_FATTR_NLINK) nfs_set_cache_invalid(inode,
> NFS_INO_INVALID_NLINK); +else + set_nlink(inode, 1); ``` **=E2=9C=85 Mini=
mal
> regression risk**: Setting nlink=3D1 as fallback is safe and follows the
> NFSv4 spec (fattr4_numlinks is a "recommended" attribute, so emulation
> is appropriate) **=E2=9C=85 No architectural changes**: This is a targete=
d fix
> within existing error handling logic **=E2=9C=85 Follows stable tree rule=
s**:
> It's an important bugfix with minimal risk ### 4. **Comparison with
> Similar Commits** Unlike the provided similar commits that were marked
> "NO" (which involved more complex nlink management, cache invalidation
> changes, or feature additions), this commit: - Fixes a fundamental
> compatibility issue - Prevents complete mount failures - Is minimal and
> defensive - Addresses server interoperability problems ### 5. **Server
> Compatibility** This fix ensures NFSv4 clients remain functional with
> servers that don't fully implement all recommended attributes, which is
> critical for real-world deployments where server implementations vary.
> The commit directly prevents mount failures that would otherwise require
> server-side fixes or workarounds, making it essential for stable kernel
> trees where users expect reliable NFS functionality.
>
>  fs/nfs/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index f2e66b946f4b4..e774cfc85eeed 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -555,6 +555,8 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, =
struct nfs_fattr *fattr)
>                         set_nlink(inode, fattr->nlink);
>                 else if (fattr_supported & NFS_ATTR_FATTR_NLINK)
>                         nfs_set_cache_invalid(inode, NFS_INO_INVALID_NLIN=
K);
> +               else
> +                       set_nlink(inode, 1);
>                 if (fattr->valid & NFS_ATTR_FATTR_OWNER)
>                         inode->i_uid =3D fattr->uid;
>                 else if (fattr_supported & NFS_ATTR_FATTR_OWNER)

How can an application then test whether a filesystem supports hard
links, or not?

Lionel

