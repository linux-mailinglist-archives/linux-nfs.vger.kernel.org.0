Return-Path: <linux-nfs+bounces-3977-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A3B90C67B
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 12:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9219B1F225A4
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 10:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540A313A245;
	Tue, 18 Jun 2024 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRzao46R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7D18A94A;
	Tue, 18 Jun 2024 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697146; cv=none; b=GqSJle6CK8f5Tbdh7iKrqgHqLJ2AQ/+TLFtWeqzYxaniTO2XbZwEwn/SdLkClXO/EahtiKxhL6D1L2gp3V8sY3FRs4tt2BiqoKEx6rNbOGLFj/rtYmP1P/LJaXPrfkYFUgmDFbk1PPaL/lUep/RS8YA0u/Mk5SlVz42ukFhHZlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697146; c=relaxed/simple;
	bh=2VJI7TxrcO8SEx0hBSqqAZdmmQwcD4oEYQK80PeVewE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1IfWKtz5I6LGkyvPI6Df44ZgDRfAkxLZNeygJGIIRWaDVRqabcSORmpH0k27CkwWMeMEVM8L/GA1a1P71pqhvpWFf/6msw/gQuA13P5MSU1ZKpw561q3i4oSLzCdsMNQ462A1940I0SyzxpuIU5c394G9dUg0cbGNkuZ/iM4ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRzao46R; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00ba6so4395438a12.1;
        Tue, 18 Jun 2024 00:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718697143; x=1719301943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i47tTS0Smc0matXz2a2CmZqxpNwYuNp/v14r4hNAm5s=;
        b=WRzao46RZTccKKBLy02j5vQJzB2v3r4xfkxQIbIh9xJP41xVrhyLM9LHzB+Qxn1cvo
         Mfrk7gCaKEfd0GakjT0Eo109uq2tIRFlN9Ia0nyJvIlOBqeVyzfzR0LEE/aESHZBc3jt
         rdZf/TQMufTWQ4YSKu8SbShplSpgUWZiCdmWyLHKQ35AkU5Q04a5LqWPAt08cZbvjE03
         mS2jw54xRjiseifC7iVKXOhGsmi5mQ3TmoTaIlNkON41iblH+jKiAU72eg8VlmBqjxJn
         t6Eutpt6RTJMw1VwBuhaHzkUP1M5OmgiKjiNYC7HgV8ZfLPlegem8LtFZJ4WXZyqgdFd
         wc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718697143; x=1719301943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i47tTS0Smc0matXz2a2CmZqxpNwYuNp/v14r4hNAm5s=;
        b=uVwXdFoZRTnZDR3cfq+Q8MHcRM3FFiI0rUMSjuj02l82ZhSTPxyn/HPdrcLiTVw7bI
         lsV43FpuyOo6Co0v25uq3Ax+SIsmr06ds9WqA+M7mFhfwnpX0OvIXMVCSHtWJ2GzaZ4Q
         wZYP3Ut/vLPlc8zFX2l5lh4W6G89zWzb52dhH2ZSRT6JbpLYE1d0/KRQH6Shl9YehTs8
         cRcsg7i1lytD9YM0iZcGJMK3DJYeAQnq/xFsBXBQr9IdIU6q6qd5xIjgVxNhxNfT62AN
         QOiG6aEzkVShp5AoOVTrBVfZ3YZD/TESiyr4XLWkAWMe+49f6/MG4wOMm4esuVMsBFKV
         jixQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfoxpO9b+VG5FrSaGZ+6pAA2ks5GEMIdaUpdgBbLh1Lwt5dgiNAWH0+vo0+JT5QgMNZnHYe07q1275UOMxo6BWGaxTBeHj+9Kd7kuHD6w8W8A2FW+9+RKma9yG3FehDBlUC6vjbGS9eTz/leI/QklZeioIVEGWE+PmOP0bPQ==
X-Gm-Message-State: AOJu0YyVR7Oq8noryPhMk+iw98PEWqxDuMdWhJqbOD6mGYGme/wmQ+Mx
	RJrcCVrPVrEGRd6u3EUWBpGLa05/IVWi/vjNG4qQmc1KdNQbvkGsl6Ja51+4pFzSk9KnDecE1Rl
	Welxc2qD1ZSwX01zlsUxkZL3eFnU=
X-Google-Smtp-Source: AGHT+IEnQKM8yOKGghS2xqtPgQZXhwenYTCKKgD7oiMwYOJCjP6SOJqzyDq0LjJKLrFUeeMh93cjmacWSclnRt6Kqx4=
X-Received: by 2002:a50:d4d8:0:b0:57c:a478:2ff4 with SMTP id
 4fb4d7f45d1cf-57cbd681ae0mr9805343a12.11.1718697142667; Tue, 18 Jun 2024
 00:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618065647.21791-1-21cnbao@gmail.com>
In-Reply-To: <20240618065647.21791-1-21cnbao@gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Tue, 18 Jun 2024 09:52:11 +0200
Message-ID: <CANH4o6PSdvWMLwbzN7xmzSO=52qS7kYdP2rRu7xois6OL+=Mjg@mail.gmail.com>
Subject: Re: [PATCH v2] nfs: drop the incorrect assertion in nfs_swap_rw()
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	anna@kernel.org, chrisl@kernel.org, hanchuanhua@oppo.com, hch@lst.de, 
	jlayton@kernel.org, linux-cifs@vger.kernel.org, neilb@suse.de, 
	ryan.roberts@arm.com, sfrench@samba.org, stable@vger.kernel.org, 
	trondmy@kernel.org, v-songbaohua@oppo.com, ying.huang@intel.com, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 8:57=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Christoph Hellwig <hch@lst.de>
>
> Since commit 2282679fb20b ("mm: submit multipage write for SWP_FS_OPS
> swap-space"), we can plug multiple pages then unplug them all together.
> That means iov_iter_count(iter) could be way bigger than PAGE_SIZE, it
> actually equals the size of iov_iter_npages(iter, INT_MAX).
>
> Note this issue has nothing to do with large folios as we don't support
> THP_SWPOUT to non-block devices.
>
> Fixes: 2282679fb20b ("mm: submit multipage write for SWP_FS_OPS swap-spac=
e")
> Reported-by: Christoph Hellwig <hch@lst.de>
> Closes: https://lore.kernel.org/linux-mm/20240617053201.GA16852@lst.de/
> Cc: NeilBrown <neilb@suse.de>
> Cc: Anna Schumaker <anna@kernel.org>
> Cc: Steve French <sfrench@samba.org>
> Cc: Trond Myklebust <trondmy@kernel.org>
> Cc: Chuanhua Han <hanchuanhua@oppo.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: <stable@vger.kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Martin Wege <martin.l.wege@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [Barry: figure out the cause and correct the commit message]
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  fs/nfs/direct.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index bb2f583eb28b..90079ca134dd 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c

Please add a

Reviewed-by: Martin Wege <martin.l.wege@gmail.com>

Thanks,
Martin

