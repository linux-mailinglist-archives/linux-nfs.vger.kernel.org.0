Return-Path: <linux-nfs+bounces-8217-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2A29D8E95
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Nov 2024 23:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15AEF282407
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Nov 2024 22:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602FF1CD210;
	Mon, 25 Nov 2024 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+grX5aI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B3F1CD1ED;
	Mon, 25 Nov 2024 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732574098; cv=none; b=Z4yLPZR7cBPbr7bqUyY81WJxgQUiSUnFAVFxtqkQUotWK+WNkZkQo/7Bh+LaeF3NLr1dVRss3KNWHWA5ehW1V/MBlspR8hDcFylwiw3ThK0qukMGqcL+LP0/u5TNH373q62UJ5MrdkhnYa1xjI1iWdIq+HHXkQ8nFXZBJIqs4mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732574098; c=relaxed/simple;
	bh=FiSm9WBCzxkq0A/hq9Ci1EsLOI4cPirhbpTA0DEwLWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6Naw2fBpLQO3IVjnNuJsHe5dljS5tKU7HDRMbBkxbt4f+eYe/Fiwsic6NEEpLEyG1B1TeF9vDcFl8Zb/jj7E4cAOqTY38+KP1KenCQSKp4LD1Nc3EYKF/tpMqAJoxj+8w4TJv04b7sRcXSs8MhpbOIL53/d65WiS38Z9fqe/Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+grX5aI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41A5C4CED3;
	Mon, 25 Nov 2024 22:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732574097;
	bh=FiSm9WBCzxkq0A/hq9Ci1EsLOI4cPirhbpTA0DEwLWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k+grX5aIWjli7FbPdzcFfAmtxHt91rqk301PetereRimqqv2G4kJ8yNRcG2aQ8GyQ
	 rqqu4JlllaNMnrejyaD1106xnV5uNVUf7lzBYQJsEBUyvzuIH6/5/nPnDAv5Y1Ou4t
	 ITfVvvhDLBvMMeRMYNXgopPnIZaShcFNJhYap8Z80itUTIegaPP0YhCKjcKuCkxcQ2
	 9/ayolNjivEZiGXyPxUu1c+u999A4d+KiurKAUuzn4t/VBaOy7jhKLjX9nA5kSZIiI
	 2H8Il+RWhKMPsL0VrfcYOaZp0igKdmGGdXHwO6M604Siwz585eGA8eT5Vih2mjodaN
	 3+WPZOlUnNJZw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa55171d73cso256314266b.0;
        Mon, 25 Nov 2024 14:34:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfCe0Ydo6QG1jvb4onZEz+qYoWpUMTHVcFNRPusFGW7HK9wqvzoLPa+eUwZXUWje3DEw2N7FCZYS0A@vger.kernel.org, AJvYcCWC4XfXcaXvbNOD0nWeTxBE8NouRVANvmQTQt84PGYB+lhdyaZLch+XREUsxXH3Trg1rESsdi4+xSEK8iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPYo8aQ7Mka35UVBkuutxgYTrQTmYlK1qVJ6rKStVKWyuYKnun
	bczB7CBy1mJEEIXARnMpjosIxRbh0tAmYoSlomgAteIeYMmwG2qFkfL7hvdoYTlfQlxqwVmP2o6
	Ncn0NNVr4FmeFTuzv6wn7jNxfg04=
X-Google-Smtp-Source: AGHT+IEUOH03m8h9V7j3CooRTEb+zPHZIGEPbyjCO9OPXDEU9jw3coAf0/zDkf43Dm7AUniHLyvpASwc9yKZ0TCHcx8=
X-Received: by 2002:a17:907:c992:b0:aa5:3663:64c5 with SMTP id
 a640c23a62f3a-aa5648b831emr98944766b.22.1732574096589; Mon, 25 Nov 2024
 14:34:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114044738.1582373-1-lilingfeng3@huawei.com>
In-Reply-To: <20241114044738.1582373-1-lilingfeng3@huawei.com>
From: Anna Schumaker <anna@kernel.org>
Date: Mon, 25 Nov 2024 17:34:39 -0500
X-Gmail-Original-Message-ID: <CAFX2Jfk=FUNYecYT15_FQSKv6ajcWuM-724hUeryTJc7auhCHg@mail.gmail.com>
Message-ID: <CAFX2Jfk=FUNYecYT15_FQSKv6ajcWuM-724hUeryTJc7auhCHg@mail.gmail.com>
Subject: Re: [PATCH] nfs: pass flags to second superblock
To: Li Lingfeng <lilingfeng3@huawei.com>
Cc: trondmy@kernel.org, trond.myklebust@hammerspace.com, jlayton@kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com, lilingfeng@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Li,

On Wed, Nov 13, 2024 at 11:33=E2=80=AFPM Li Lingfeng <lilingfeng3@huawei.co=
m> wrote:
>
> During the process of mounting an NFSv4 client, two superblocks will be
> created in sequence. The first superblock corresponds to the root
> directory exported by the server, and the second superblock corresponds t=
o
> the directory that will be actually mounted. The first superblock will
> eventually be destroyed.
> The flag passed from user mode will only be passed to the first
> superblock, resulting in the actual used superblock not carrying the flag
> passed from user mode(fs_context_for_submount() will set sb_flags as 0).
>
> Since the superblock of NFS does not carry the ro tag, the file system
> status displayed by /proc/self/mountstats shows that NFS is always in the
> rw state, which may mislead users.
>
> Pass sb_flags of the fc which carry flags passed by user to second
> superblock to fix it.
>
> Fixes: 281cad46b34d ("NFS: Create a submount rpc_op")
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>  fs/nfs/nfs4super.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
> index b29a26923ce0..9a3b73a33fbf 100644
> --- a/fs/nfs/nfs4super.c
> +++ b/fs/nfs/nfs4super.c
> @@ -233,6 +233,7 @@ static int do_nfs4_mount(struct nfs_server *server,
>         if (IS_ERR(dentry))
>                 return PTR_ERR(dentry);
>
> +       dentry->d_sb->s_flags =3D fc->sb_flags;

I'm seeing a handful of new xfstests failures that I bisected to this
patch: generic/157, generic/184, generic/306, generic/564, and
generic/598.

I'm seeing this on NFS v4.1 and v4.2, and it looks like each one of
these failures is due to a new -EIO error being generated. Any
thoughts about what could be causing this?

Thanks,
Anna


>         fc->root =3D dentry;
>         return 0;
>  }
> --
> 2.31.1
>

