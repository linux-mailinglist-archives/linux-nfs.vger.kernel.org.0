Return-Path: <linux-nfs+bounces-7742-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072D39C1340
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 01:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5D31C21070
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 00:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F1D629;
	Fri,  8 Nov 2024 00:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIqtgQ/8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34483FE4
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 00:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731026281; cv=none; b=AGKQNjxuWd/G8bzL7rSNDR8kV4a+tNXrSM08YFqlVhFEIi4XroKKypmlYgVbgXoaxiWMGKVCvb6g20P0oHIZUVmMQdj1y2wgKL8stLxX5qYk3UI8LdazdameufhAwaPwxF+2jSJm8bAvjatrv7VNOKaM61dUkR60HzZW7gieJE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731026281; c=relaxed/simple;
	bh=KTIK6roR1hKzFpePXQDEd+c8zohTAeQ2c8IY5NWjgGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tz0BDp7ZnrucGicyOdDKsofmKzR/aCNx0LZEN6xhG+S4G+Sb3mtHokF9lPy2qDjfmHaVir+/w/sm5qQCzRhnEu/uG+1s6U6nKY5ra/qwK+u4bgvg39h4SHj0ZAZTPug38E8b6eCDiMH8ymVys6gQN6eY8k9Hw9yEqj5t5qYq7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIqtgQ/8; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb5014de17so1089881fa.2
        for <linux-nfs@vger.kernel.org>; Thu, 07 Nov 2024 16:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731026278; x=1731631078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abGzyG+ABLvWKTaKXQehy75I1W88fxA4aavmRROZua0=;
        b=UIqtgQ/8BdKcTAS8oz+HUzCeEFoO3AdLl5MZ8FpC4NNllF8IDc9BzhuhfU8WdFaK32
         VsHCPuNtREvRf92ztL/88+4+6wDIQ/58KawRIstR7+gzSt9nL7ycW1AilYeO9RHf46J6
         LQxCzDr3MKhnOPRdNoC5THilSyOcRaiTDxDFidfXCrdXE/mCZ0HplcJe1JlX9sOMPs6X
         HaUqSQ+OzoGEm2t3R2Nl7Nkc5ZJLFD4RxokxQpD8FTWwI+QtcnjQhGf3AljRgwdSWuQc
         eDvp5+ACMYHpvcvyYbwdzErxleqcY97KhV7uIVexF4g7d5BAtt/kqImFWeEnwCY0ZBiY
         X9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731026278; x=1731631078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abGzyG+ABLvWKTaKXQehy75I1W88fxA4aavmRROZua0=;
        b=MOafB6lxvuSN3tnjbEvGZJ1KN5jjfGhxu5x6TIpN2lEdKU5xBW4XHmHDZ5sjTzwv2Y
         rOZCWS+87Gz8y6RT4bvh6rIFj0lm2AZJ1n/vl7y6A7aIAt7UgV0p5oyoxXsQ1nF9qYLJ
         2KLQMOAdHRRBJdP49Iy+V3k43G2xRc336i7kgdh87+kuwhsyBvqonMaS+iOAjsXaBVee
         a6+IfXWZrxMMrDRYo7vhPbfcy8vW3Ud2M1WAJ/8f2n6ro2s5j5mxl3d04Ox6N5KEAN9b
         +E9MxNtnFTvQ2Sfm3Xd25wQDyuYVzMGZGQJq4uTvb0smhF/UYBBDl6D4belEZmwm9FZ0
         dsZg==
X-Gm-Message-State: AOJu0Yxtv7Igg8StGFiYFRmpNRQcYgE5pW3aHBivsZKk8BzBOeeX3LFp
	LIyJLFXjj+hwpVaRj2cVAOXIdduZdLKKk5Mt4KE6WTtwKE6raDhOtgJYDob787WJcST7SI7j/zp
	zEEbBCcOZWrrBZkOLwniw5pkhhbFqqM05
X-Google-Smtp-Source: AGHT+IFLRshXCuS/9SwsMZkCopcEVTVQLBuSblv70j8c7x7iEb+vqnDEVUsqP1gaOD5+uH4ZLWOZIgA3ok/JPK9H/MA=
X-Received: by 2002:a05:6512:a8e:b0:539:fbba:db79 with SMTP id
 2adb3069b0e04-53d862b0609mr116940e87.9.1731026277582; Thu, 07 Nov 2024
 16:37:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830032747.1082484-1-zhaoyang.huang@unisoc.com>
 <CAGWkznH5WhRXyJbRfV69jQsXy+-q5DeJ9fuDaK54ViU1XAd-Tg@mail.gmail.com> <72bfa6ec4e21bd35fa1229b6299cd070537148dc.camel@hammerspace.com>
In-Reply-To: <72bfa6ec4e21bd35fa1229b6299cd070537148dc.camel@hammerspace.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 8 Nov 2024 08:37:46 +0800
Message-ID: <CAGWkznH9Yoj1pP_s46mKY8Uv1iXsAX=rm18fQSZsY1dwjxP5dA@mail.gmail.com>
Subject: Please drop '03e02b94171b1985dd0aa184296fe94425b855a3' fs: nfs: fix
 missing refcnt by replacing folio_set_private by folio_attach_private
To: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anna and Trond,
Please drop '03e02b94171b1985dd0aa184296fe94425b855a3' fs: nfs: fix
missing refcnt by replacing folio_set_private by folio_attach_private
since it is wrong as Trond has explained. Thank you!

On Tue, Sep 3, 2024 at 2:00=E2=80=AFAM Trond Myklebust <trondmy@hammerspace=
.com> wrote:
>
> On Mon, 2024-09-02 at 10:42 +0800, Zhaoyang Huang wrote:
> > Hi Trond,
> > I am not sure if 'trondmy@kernel.org' is still available or if you
> > are
> > too busy to respond. Try these two addresses.
> >
>
> I believe that I already answered this on the list. The refcount that
> this change adds is redundant because the struct nfs_page already holds
> its own refcount to the same folio.
>
> Thanks!
>
> > ---------- Forwarded message ---------
> > From: zhaoyang.huang <zhaoyang.huang@unisoc.com>
> > Date: Fri, Aug 30, 2024 at 11:28=E2=80=AFAM
> > Subject: [PATCH 1/1] fs: nfs: fix missing refcnt by replacing
> > folio_set_private by folio_attach_private
> > To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
> > <anna@kernel.org>, Christoph Hellwig <hch@infradead.org>,
> > <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Zhaoyang
> > Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
> >
> >
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > This patch is inspired by a code review of fs codes which aims at
> > folio's extra refcnt that could introduce unwanted behavious when
> > judging refcnt, such as[1].That is, the folio passed to
> > mapping_evict_folio carries the refcnts from find_lock_entries,
> > page_cache, corresponding to PTEs and folio's private if has.
> > However,
> > current code doesn't take the refcnt for folio's private which could
> > have mapping_evict_folio miss the one to only PTE and lead to
> > call filemap_release_folio wrongly.
> >
> > [1]
> > long mapping_evict_folio(struct address_space *mapping, struct folio
> > *folio)
> > {
> > ...
> > //current code will misjudge here if there is one pte on the folio
> > which
> > is be deemed as the one as folio's private
> >         if (folio_ref_count(folio) >
> >                         folio_nr_pages(folio) +
> > folio_has_private(folio) + 1)
> >                 return 0;
> >         if (!filemap_release_folio(folio, 0))
> >                 return 0;
> >
> >         return remove_mapping(mapping, folio);
> > }
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  fs/nfs/write.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > index d074d0ceb4f0..80c6ded5f74c 100644
> > --- a/fs/nfs/write.c
> > +++ b/fs/nfs/write.c
> > @@ -772,8 +772,7 @@ static void nfs_inode_add_request(struct nfs_page
> > *req)
> >         nfs_lock_request(req);
> >         spin_lock(&mapping->i_private_lock);
> >         set_bit(PG_MAPPED, &req->wb_flags);
> > -       folio_set_private(folio);
> > -       folio->private =3D req;
> > +       folio_attach_private(folio, req);
> >         spin_unlock(&mapping->i_private_lock);
> >         atomic_long_inc(&nfsi->nrequests);
> >         /* this a head request for a page group - mark it as having
> > an
> > @@ -797,8 +796,7 @@ static void nfs_inode_remove_request(struct
> > nfs_page *req)
> >
> >                 spin_lock(&mapping->i_private_lock);
> >                 if (likely(folio)) {
> > -                       folio->private =3D NULL;
> > -                       folio_clear_private(folio);
> > +                       folio_detach_private(folio);
> >                         clear_bit(PG_MAPPED, &req->wb_head-
> > >wb_flags);
> >                 }
> >                 spin_unlock(&mapping->i_private_lock);
> > --
> > 2.25.1
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

