Return-Path: <linux-nfs+bounces-3950-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C76690BFEB
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 01:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAAB71F22699
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 23:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75350194A52;
	Mon, 17 Jun 2024 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="TgWUEJsy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FD8288BD
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718668299; cv=none; b=V0TR/XFZPf76tVKjcUQYg0lHXxL9hS4mmJvHAul16LRekgk2d9MnlegrjUj5MVXNPtN91IZefktDSdQFgS6lDRJgxyV+u4+MPZPRLRTInkRmTnPH4ji+GW1qyJCgJwJeWSkB9bH4MG/g9V8bQjucdqvmF+LwhoxdJwvKMEg4Rak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718668299; c=relaxed/simple;
	bh=SiO1dj9Q/LbSRgTbtr2/yKAlCIILOMkcOq5xu5M6VhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPw5tftbOgOuwR7hjnyBctV4v8Ld4TD/V4FwyOdV1L1JiM8AJkPJJAAHj8P2mrQxCjDK4MvtKNguKMzZ3+fE5TsAv6Y8+sbgZlno9mpInsdzjssCMLr2YI9HMrbMPup0OPxU+9fLmhZU5DDlWZiXHnY6xndpYVYxt89BiQI/qVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=TgWUEJsy; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebd6ae2f56so5699621fa.0
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 16:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1718668295; x=1719273095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BnXLRsxYn/eyeGjmi03rqtmppxQ3C9Sp9TX69f5LC0=;
        b=TgWUEJsyVG3MKplpz73KTIgMCUtLrcT2GlXFiBOSZp2XwOED2KuSHDhjZEtr8K/dXO
         emlwIj6j1paJ51IWTaRucemOpg64K5ZhR+9Fez4U9BXXzQpZTlqZKzqN0HmkCdZfxBES
         Is7AzBU4DVTGlkfmJUQNt8LYI7NFB2MTYw8O0hb45YHpkegN1Pf6dHp6y4s6wbBJpEM7
         wdvR5QdfSnyaTbfttPqI7xhthaZqO2VXwudjOE9Cyj+ex/bZaf7I9/BROiudHYiNJnz3
         6sk/sxO7ieRCnUTXeilBCrCmARvmvweZCPO796jrOqQndntXA7r4QbGP7GAEku4nKwq7
         fkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718668295; x=1719273095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BnXLRsxYn/eyeGjmi03rqtmppxQ3C9Sp9TX69f5LC0=;
        b=SHInLtG+Kogt/9pun0EQWpHslZsWVXugpzg/bYDUbu03p7bhcN16FvuVv1CPQH/wdZ
         04DXIaHaYxhfbFWWxqYjm3fD8O6kwfiyGXdHNgimuKrdmvhJnKc1oROEccZGQTeYyxjx
         oyad4aIWm3llcsdBKDyy4CLQg8OTL5XzIvXXes5seDbn9wz5cGtmU8U0wMSuB5qM1Ey9
         SWUJO9ebL3a47oNxZzOfNKEOFBMtZFsGVjDVOKpyItQKqL60G1GW7uL20txFBYLAfyPp
         OcB0MU0vVqOJEjfCNJxdd7cwA4BtlT8EP4s20J2ZD0dBJ5f5bPAXymFK45CfDXeR3mGR
         xv5Q==
X-Gm-Message-State: AOJu0YzzvORB2E0OSxgdvM+07wTGm/RjpaE56qLUy3PAZzwF/MdjN+B0
	3tGQpLY41VUFs/grwTSSwciaXwquTycFXgAsQCTob+mIYM7sUsqsshlo//ih3vCALNzwgAo/rrY
	wPm4Z5eX0vFP7Bym56jBaGtNSano=
X-Google-Smtp-Source: AGHT+IEPh0o/GE119+p5BY5cruNZQ7w3b+cM+S9+NjV759uuTmLd/uruVDM3dxOkdPf5v6GdqR26JpfF06K6ZYOtN3U=
X-Received: by 2002:a2e:9345:0:b0:2ec:16c4:ead5 with SMTP id
 38308e7fff4ca-2ec16c4effcmr56133871fa.2.1718668295002; Mon, 17 Jun 2024
 16:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617012137.674046-1-trondmy@kernel.org>
In-Reply-To: <20240617012137.674046-1-trondmy@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 17 Jun 2024 19:51:23 -0400
Message-ID: <CAN-5tyGqYsLVHcyUD3XrkZ2HnL6f7b0eoGp_hXNPFHX0ysuxuQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] OPEN optimisations and Attribute delegations
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Trond,

Is it possible to share some numbers of some benchmarks that
demonstrate advantages of this patch series? like this many
getatts/other ops without patches and this many with?


On Sun, Jun 16, 2024 at 9:25=E2=80=AFPM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Now that https://datatracker.ietf.org/doc/draft-ietf-nfsv4-delstid/ is
> mostly done with the review process, it is time to look at pushing the
> client implementation that we've been working on upstream.
>
> The following patch series therefore adds support for the NFSv4.2
> extension to OP_OPEN to allow the client to request that the server
> return either an open stateid or a delegation instead of always sending
> the open stateid whether or not a delegation is returned.
> This allows us to optimise away CLOSE, and hence makes small or cached
> file access significantly more efficient.
>
> It also adds support for attribute delegations, which allow the client
> to manage the atime and mtime, and simply inform the server at file
> close time what the values should be. This means that most GETATTR
> operations to retrieve the atime/mtime values while the file is under
> I/O can be optimised away.
>
> Finally, we also add support for the detection mechanism that allows the
> client to determine whether or not the server supports the above
> functionality.
>
> v2:
>  - Fix issues when compiling without CONFIG_NFS_V4
>  - Update "NFSv4: Fix up delegated attributes in nfs_setattr" to fix
>    regressions pointed out by Anna Schumaker
>  - Squash commits "NFSv4: Ask for a delegation or an open stateid in
>    OPEN" and "Return the delegation when deleting the sillyrenamed file"
>    as suggested by Jeff Layton
>  - Add "NFSv4: Don't send delegation-related share access modes to
>    CLOSE"
>
> Lance Shelton (1):
>   Return the delegation when deleting sillyrenamed files
>
> Trond Myklebust (18):
>   NFSv4: Clean up open delegation return structure
>   NFSv4: Refactor nfs4_opendata_check_deleg()
>   NFSv4: Add new attribute delegation definitions
>   NFSv4: Plumb in XDR support for the new delegation-only setattr op
>   NFSv4: Add CB_GETATTR support for delegated attributes
>   NFSv4: Add a flags argument to the 'have_delegation' callback
>   NFSv4: Add support for delegated atime and mtime attributes
>   NFSv4: Add recovery of attribute delegations
>   NFSv4: Add a capability for delegated attributes
>   NFSv4: Enable attribute delegations
>   NFSv4: Delegreturn must set m/atime when they are delegated
>   NFSv4: Fix up delegated attributes in nfs_setattr
>   NFSv4: Don't request atime/mtime/size if they are delegated to us
>   NFSv4: Add support for the FATTR4_OPEN_ARGUMENTS attribute
>   NFSv4: Detect support for OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION
>   NFSv4: Add support for OPEN4_RESULT_NO_OPEN_STATEID
>   NFSv4: Ask for a delegation or an open stateid in OPEN
>   NFSv4: Don't send delegation-related share access modes to CLOSE
>
>  fs/nfs/callback.h         |   5 +-
>  fs/nfs/callback_proc.c    |  14 ++-
>  fs/nfs/callback_xdr.c     |  39 +++++-
>  fs/nfs/delegation.c       |  67 ++++++----
>  fs/nfs/delegation.h       |  45 ++++++-
>  fs/nfs/dir.c              |   2 +-
>  fs/nfs/file.c             |   4 +-
>  fs/nfs/inode.c            |  86 +++++++++++--
>  fs/nfs/nfs3proc.c         |  10 +-
>  fs/nfs/nfs4proc.c         | 248 ++++++++++++++++++++++++++++----------
>  fs/nfs/nfs4xdr.c          | 131 +++++++++++++++-----
>  fs/nfs/proc.c             |  10 +-
>  fs/nfs/read.c             |   3 +
>  fs/nfs/unlink.c           |   2 +
>  fs/nfs/write.c            |  11 +-
>  include/linux/nfs4.h      |  11 ++
>  include/linux/nfs_fs_sb.h |   2 +
>  include/linux/nfs_xdr.h   |  45 ++++++-
>  include/uapi/linux/nfs4.h |   4 +
>  19 files changed, 589 insertions(+), 150 deletions(-)
>
> --
> 2.45.2
>
>

