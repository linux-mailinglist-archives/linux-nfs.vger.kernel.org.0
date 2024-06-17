Return-Path: <linux-nfs+bounces-3949-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8A390BFD0
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 01:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275A81F2249A
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 23:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051821991CA;
	Mon, 17 Jun 2024 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk3PbbKu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7431DDDA6;
	Mon, 17 Jun 2024 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718667421; cv=none; b=Ph+uYrlAbvqt4bfT98c77VcebroETYZETAcGRXiJJzSJy7UatwDjpNSAUDvHu5CYPPYzk5BXOUPqhalEW2anVXOusvnCnWjqnPipzfzakoba/gexxW2eHxyb6n5voWu7wSKzMe1a9sqniEEDX86xDcugW3QrxLB3FTywkI48tNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718667421; c=relaxed/simple;
	bh=cBMKhntrxyiT3QXPz2UWMM5TU5Q2sO/KcUE+fC1NuGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stm8jAfJye+kp9S5Net4Qp0h1tHISblCa99C4MkVNRv+HtuJxEJPzgN1kEhOKsQiL1qQKm2ybA68mlD8En6UU82hP6rXM+XjTqoU4Bymnnzxkc504bYBK3JJ1A2AQSrlEiPh+f5BcKDjHTwfeJTQ6oDaLqkEfeTosWDp05ygr80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk3PbbKu; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-80b8689775fso1648617241.1;
        Mon, 17 Jun 2024 16:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718667419; x=1719272219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nhizp+dF8ZrSnke5zqlKT0QIEG/gsRHpPFFjzvmIY04=;
        b=Gk3PbbKuK56UDYfwXSrfiO7uXEfjv5YpQbt1E84ecAW8g6Ka71cDKepe3AIz5Z7j+g
         0q2VK8zPO289DQXOb7PXpOlhsrrptsh4fyjPnHiuqZ5cKkcMS8ZSHIdKAd8vPcomTv97
         rC7PI0yt9X4fg8/YKpWFYtmHoW4eRDbIASsi4slMljDfmUhpPk+TBrB37OCbHpok50GZ
         23kVi2jWx/jWWfNEj2JtIdC/lZr5GYF1jk8N/3K3aW0B4P01MmBa9EhoJB2UO2AGzkdX
         yRIesqZiMBtMpNYcN8Cws19arg22X7CJZ9J7QoIWLSSHbZ1vVRS76XEx2PYy+7CTeUYp
         QH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718667419; x=1719272219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nhizp+dF8ZrSnke5zqlKT0QIEG/gsRHpPFFjzvmIY04=;
        b=C9N90z2gBKB4+Egi9BjpEtr+eaCtCEteBnmfynPSbM4T0q9AfgZTjoPNcKD4KHtdxr
         nk17YJIwzmMxvwzHioapmV2PGkQYny8CrHC0eRkMWL967pVtV3dHHjgcixXLv99br7Df
         AcmGAGsbA3iPTwfAP2lDBjb/6gTHw5DDVJm2kr65heHnKqNMQjpYxz26b/9KiBuNszyQ
         FqPdblzZhJC46KqptgcneHMTtWKI46ykVqVnbKM2wDZteNI0k65Kb6sBniq+oi0mGsJ6
         RMe6DNUi2e4cC/nTiug0lPcixz3KI3ZpQtLiZrDcuH0git2DTwYtU7EXRWauN0xGvnek
         7cOg==
X-Forwarded-Encrypted: i=1; AJvYcCUGADKakCKqRRV5E/jcU1ad++LhonHb1RWMXfSKaYB0ZLG/nEDzavOSSCWfMFIGjVltA7FOOUvaW/K014Y3CKnnyJJFAQYO+uDt13f2j5G6gx/HKmL08On3WdLavVMNthVYbWiBZf5Mg7QFzp1rZ03/r2xhbxnIgj0a8ydQMA==
X-Gm-Message-State: AOJu0YxXxnt9KWcn0lUCCjuPH0tmpiUe7CXdVkRert0Zf4ZSHB97LLr5
	HTFz5NiwWznrpfDdWDtELrv22yOPDrfQ9OW89V6T7GCuScKDSKjgb7esx33wrpNEmyu0w0g0aJD
	vgPJcmOr9OMJQOrvCJWMt0yc+daA=
X-Google-Smtp-Source: AGHT+IFCS2bVgLk/ekfAlsUvwV4e8SIR8lXBrgMBaenoAYKDucebqzO1jk380x7p4Elm+ckdtYWRm9uFHquEVPeH258=
X-Received: by 2002:a05:6102:5893:b0:48d:8199:cc9d with SMTP id
 ada2fe7eead31-48dae3cc51dmr11582455137.27.1718667419275; Mon, 17 Jun 2024
 16:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617220135.43563-1-21cnbao@gmail.com> <ZnDEIV3zG2hyunoa@casper.infradead.org>
In-Reply-To: <ZnDEIV3zG2hyunoa@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 18 Jun 2024 11:36:47 +1200
Message-ID: <CAGsJ_4w2MQ_Cg2Mmf+_B-TLptK_fqR3q=zE+GgXxA999ifimWw@mail.gmail.com>
Subject: Re: [PATCH] nfs: fix the incorrect assertion in nfs_swap_rw()
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, sfrench@samba.org, 
	Barry Song <v-songbaohua@oppo.com>, Christoph Hellwig <hch@lst.de>, NeilBrown <neilb@suse.de>, 
	Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Chuanhua Han <hanchuanhua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Jeff Layton <jlayton@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 11:17=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Tue, Jun 18, 2024 at 10:01:35AM +1200, Barry Song wrote:
> > +++ b/fs/nfs/direct.c
> > @@ -141,7 +141,7 @@ int nfs_swap_rw(struct kiocb *iocb, struct iov_iter=
 *iter)
> >  {
> >       ssize_t ret;
> >
> > -     VM_BUG_ON(iov_iter_count(iter) !=3D PAGE_SIZE);
> > +     VM_WARN_ON(iov_iter_count(iter) !=3D iov_iter_npages(iter, INT_MA=
X) * PAGE_SIZE);
>
> Why not just delete the assertion like Christoph did?

I'm fine with either option. While maintaining this, my thought at the
time was that I might
want to reassess this assertion once mTHP swapout is supported on
swapfiles later.

