Return-Path: <linux-nfs+bounces-4831-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2488D92ED6D
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 19:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED3C28345D
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 17:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDF916D4E8;
	Thu, 11 Jul 2024 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nV9EEKVc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07C450FA;
	Thu, 11 Jul 2024 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717546; cv=none; b=C44D2LDztawTE7X3hMxl3WZdvKBq8a5wnWblyJtu72aOoC+4PfBcqriF0FxHn9kdAd+3I7AfsBGLLkNml/ItNoUlnVaIX90Sxc40agehlDQbu20/C9gJg8nFBKK/fh5j47W1bB3bzPvKFmziayqyn+zcrwON+BOcxoV/xwMO8tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717546; c=relaxed/simple;
	bh=zirD51PSiEvEJN4GnLz46WQQHxQFe6ThDzNZ3IeuwV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/hF+YIB7x2dCpqi+vqtIkPj2ylTGzueUQq2uIX4bFkj8eWN5bZtB6KwmKZogGQkyBYZpodasYIFRIxG8VM64lqHSOoyOikH5PRXq3i1l4Q2HIzLg9eu2ydXskhh5Fi8aol8Bu1mi3kg6gbCwmRaKUzFxbAE2bQBlgC7nPZdFnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nV9EEKVc; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-643f3130ed1so10456757b3.2;
        Thu, 11 Jul 2024 10:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720717544; x=1721322344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7BOUH+Frg8/o22BzECLe2KrvGshFw+RFE2s5ErKK6c=;
        b=nV9EEKVcl+pVdfm/5orF+pFSjK9V5tCdiGTvuLgmpAAFtG5d6vyGLkfX2l+t/omyAK
         aLmlWXGvhwqHNTddKKbE31z6EPzNgDvvkGW/D9bJfArSc/b7uX1SnFF2BUXsBy8bvdVm
         saeZruRiapl8uNxgT5mHlRl7SQPt43ouBTSt8f0nf5LdDY4oeYFTzvzkzf/V18LaA1Kh
         9qIHvGJTKYBhrq6nKOWj1Xcp7J7B2hDxNE3s9wd5gG8pfMGBZ04zSkzOhNHi9QY2I+Wt
         B/wU+yywE2iALLq57m1CZPly8FyQ2dUyxrI3q8L7LMshwsWMm3+R7TV6zr/CKMi/PKNs
         KhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720717544; x=1721322344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7BOUH+Frg8/o22BzECLe2KrvGshFw+RFE2s5ErKK6c=;
        b=G8DAG6HVE4DekmF5jhdOarz9qH0Gas8ETOkNZkS3jj/gYa4NflLhWroqB1aYZckT9R
         m3uz1RD7YGQ0A3QLzruwVUoWDhMh+BpV5b7AUykrg0wBCynnWA2aMMYhqBx6uiP9aSt9
         DMZB8To1eayXRwaOd7zXYUy2Vqx13ARcNj739aL+Lr0musIKn17Tl9Z8L8EA6MIkKntl
         tzULNgu2oZ+tRU32u7qB0x8Ug8rTH7mdPbdVIlmZgLaHVYgLFGyKEwTwWX/TQ+ps/SZ9
         3VREDbLLJxmVcUwWelwKPWj8bSDz1YP7B5HAdVIBI5FZUGj7ioUxhSYGrX8NmKRIBrIf
         3LVA==
X-Forwarded-Encrypted: i=1; AJvYcCWQhrBveLeXJj4ByCk0Og8V3PrnRQaNMaxnL4uGhNby8G4P5UK/FAcvcbDzUFpRDPb4JAWUZIXcrXVLm32LLiWUqa2Fu/AgsIV1tWTxC13eNyZ0w9R0qHBewWOCQRyOjmFpz5hknwcj
X-Gm-Message-State: AOJu0YwLk1m/rmpPI52ApJhodISCWyJJFdcuODzfAsguAUFyDbdy6JBP
	Y/bZX1N//SG58D/8T5+kdOqpIaNaE+4idGxdWiuh1tblcpaQJxAPOLF/ofpDgzXtqOEVummiQF4
	YI6YyIIyH9DUCARWSZhQe95Ltzg0=
X-Google-Smtp-Source: AGHT+IGuASaOvUD1rcYMSp2/a1PpVttmq/tgjh0wRfwM2GDkFLUWeCKjo4e9ytlLCGb2+dTrfLq22lKr5Cq7/TFZTlg=
X-Received: by 2002:a0d:ee84:0:b0:64b:1f4e:409f with SMTP id
 00721157ae682-658f08cc3fdmr93728917b3.49.1720717544293; Thu, 11 Jul 2024
 10:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710-nfsd-next-v1-0-21fca616ac53@kernel.org> <20240710-nfsd-next-v1-1-21fca616ac53@kernel.org>
In-Reply-To: <20240710-nfsd-next-v1-1-21fca616ac53@kernel.org>
From: Youzhong Yang <youzhong@gmail.com>
Date: Thu, 11 Jul 2024 13:05:33 -0400
Message-ID: <CADpNCvYknMBXf+V=vBLkjOMhTFRN-3o2R9A2c5J4POuaD49kMw@mail.gmail.com>
Subject: Re: [PATCH 1/3] nfsd: fix refcount leak when failing to hash nfsd_file
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Shouldn't we have fh_put(fhp) before 'retry'?

On Wed, Jul 10, 2024 at 9:06=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> At this point, we have a new nf that we couldn't properly insert into
> the hashtable. Just free it before retrying, since it was never hashed.
>
> Fixes: c6593366c0bf ("nfsd: don't kill nfsd_files because of lease break =
error")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/filecache.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index f84913691b78..4fb5e8546831 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1038,8 +1038,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
>         if (likely(ret =3D=3D 0))
>                 goto open_file;
>
> -       if (ret =3D=3D -EEXIST)
> +       if (ret =3D=3D -EEXIST) {
> +               nfsd_file_free(nf);
>                 goto retry;
> +       }
>         trace_nfsd_file_insert_err(rqstp, inode, may_flags, ret);
>         status =3D nfserr_jukebox;
>         goto construction_err;
>
> --
> 2.45.2
>

