Return-Path: <linux-nfs+bounces-3974-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F231590C3F1
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 08:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8207328197B
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 06:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1691D4D8DC;
	Tue, 18 Jun 2024 06:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxQpx5Dz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7D1249EB;
	Tue, 18 Jun 2024 06:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693304; cv=none; b=VLAdwa1vWCOiTYepxVf/Qpn41euccygOn1NxqeafIY1sjP93eMgLkRnGK2Dz09Jsl7Q6frBdjj2vBl7ARcqd99Kqq+QpfhpfvuDHjYxGpbnkyZrjb9XdYCFrUmBUV6YP7dd10ugASA6FbU0ssXDStHudo+I5hK9lQz57hSyef8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693304; c=relaxed/simple;
	bh=PHEUOaTLYZXHgjafAqtlYegGb687i2ex6yCnCS+hu4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0pfZxHaLJtQ8KX78btdH4/skB4LUQj2vU2PeeRVhlksd+vagxX1adzfwL+7hBuNdgXveXdQS61TbjSTEXKjjqrUtNdv12Z0/nqLT56kpy8LhwYE92JM3D2j2uI/oiVp+/9zzDI6vpYTWnBjCf0MUK9NnLj2FyaFNbCqbJtxfak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxQpx5Dz; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111aeso2900028a12.0;
        Mon, 17 Jun 2024 23:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718693300; x=1719298100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcuffUyjO6jnAI0pZKnKzMQolyv0kYugYuGfIyb+RYw=;
        b=jxQpx5DzlALyDpUV5iBiK2IqaVrLtz5iV3jIpYuMpLij/NkVqMSJ4Q9AvvmM8akgGC
         XEXKaMSo2R8YQGy7Q8yLokJNn5d3eBTD5+qaViDsQ9OjwypVeq7l33QV0vSkz5Fa3CXe
         VURtJCuqxkmmbS5ukAyc62Y8K+7Kp2TK0cu1pvShj8zkjwL3eFZLVhlJyTWquv8pPHUI
         6g/JyfklV6hpaKoKrswh+N4vYWsDnpPmwl4nJG5C5WA/Fyq79v//mNCowYThwtDySmos
         affiWQp3lJnPurfMRyQYc0hmW4gO7YtWqycnisLi8bgP4KddknezfdLcABhLpfODB5EM
         Uzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718693300; x=1719298100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcuffUyjO6jnAI0pZKnKzMQolyv0kYugYuGfIyb+RYw=;
        b=BtXM2MbDVvKlPLanqtwipddJRjhJGLfy9NNlbHEkoh3W3r1hlZYR2kGKcLekr7Vuug
         3xgHlVJWVo1wknLZnYh4xcTslOzuxx7t1xGYiZEpQ/wK61bso5H+2g6DBQHErUF4H+mn
         T1xtKiJF7hcM/mxu8JOyEluY0+YBnIeXfRY5/uHlukfDWC0NIpUsGcX0RWGPMk+NceWD
         TajQ4B69YFZdwaNSU9nDeJN09t6D2yQRaFvvJudNJ/Gv/1ks25r5tQluClu38EX3hZVe
         DhHGwDJZBoRF2k60Bh0xFSx1lJh0U86FC2E/7nOiDbhAhXDjwpn1btH9GHIale9ZAZ/c
         CarA==
X-Forwarded-Encrypted: i=1; AJvYcCWQmbnpW+2S469JSkyIhPN3+v3Q2vgx7POigcS0oz9rnsCqRSlafP93Kt00LvSA0gRS3NFETmKPalZjEThmGw7L6cqq91wh1u8ehNWI7YQgOI7ETUy+uYNzaKcEewOFLiKb/pgEpA==
X-Gm-Message-State: AOJu0Yw4+j/X0TTkE5QC1BdYGmq9gZunRiIOutrMA9EDd7oDZAXnSbSP
	TZmp2dhqYQ6IJCaAO+/Bg9TQFtIYAiRvLIIPPj7QYsncVzPTOXXCgC4npFWutS/VSxwzyTkcXOm
	bZ7MFHmc/E3bagan4O8pwGbk+pdg=
X-Google-Smtp-Source: AGHT+IG3tCQ/UpmEL8sP1ekAmlSKs60xkIPHq+7vYPkLRCY4mNHwrFJcy3UFigaB4pdgY1eF1Lzo266QeaEkmHgQoiM=
X-Received: by 2002:a50:d792:0:b0:57c:70a6:baf with SMTP id
 4fb4d7f45d1cf-57cbd6a581cmr6795922a12.40.1718693300432; Mon, 17 Jun 2024
 23:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614100329.1203579-1-hch@lst.de> <20240614100329.1203579-2-hch@lst.de>
In-Reply-To: <20240614100329.1203579-2-hch@lst.de>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Tue, 18 Jun 2024 08:48:08 +0200
Message-ID: <CANH4o6N6o35a=3iY5dfTKe0UAD3w_GV3KofDecYLP-VAPh7-nQ@mail.gmail.com>
Subject: Re: [PATCH] nfs: fix nfs_swap_rw for large-folio swap
To: Christoph Hellwig <hch@lst.de>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Andrew Morton <akpm@linux-foundation.org>, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 12:38=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
>
> As of Linux 6.10-rc the MM can swap out larger than page size chunks.
> NFS has all code ready to handle this, but has a VM_BUG_ON that
> triggers when this happens.  Simply remove the VM_BUG_ON to fix this
> use case.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/nfs/direct.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index bb2f583eb28bf1..90079ca134dd3c 100644

+1 for the patch, and thank you for fixing NFS swap

Thanks,
Martin

