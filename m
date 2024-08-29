Return-Path: <linux-nfs+bounces-5945-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15F0964597
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 14:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E13B21A90
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 12:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5267D194137;
	Thu, 29 Aug 2024 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj4FuTWK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B430018E021
	for <linux-nfs@vger.kernel.org>; Thu, 29 Aug 2024 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936137; cv=none; b=dWAvlaxcXM+qg6Zye/tjR2GkuZtNF+r2OamLt0mEh2/PXX21OueSstptQVw/2jGoUIJSQZE96MRUVdAiBk3kac2pRljBB20b0515s4g7y4c8lyLv21IJEcdPXD1M1fjqQxyIBHoWPuQiS8ODVp76OjaED0iyYyBbrJo7gozpRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936137; c=relaxed/simple;
	bh=ha/pnp/S6mDTDbA7P2bkoV2oG65rG6WFYc7amEYc7ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpDIlPXKHPoM8LwLjAXlvDnXibo0POQ1Zg5xzWIpbfPOwPGeC1Tmo5AkUmvFDWkESdZnAs+0Z0e41ZHhz2mg8dePmY7ejujqb/ynruXKWDOk8zRmaRc3B5wgrDt89tmqWU4+RZTDxJHeVbrTNTNMkvQahEKONQuf2v8AaQXwTHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tj4FuTWK; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6bf90d52e79so3673786d6.3
        for <linux-nfs@vger.kernel.org>; Thu, 29 Aug 2024 05:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724936134; x=1725540934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjLya3FBADkBiVLvBI+fAieJllJJw2pltbhOjsjZXzg=;
        b=Tj4FuTWKVdd42oC6WIgl0Etij0Si0vwrzy8VooGa343wFZ/jHitkRma2dE3/U7WYUA
         WfJoYAeC5N8XpxpD2qE/6mBdCRpDbTqXEbugVKJQdiQ8QtD+SiTP0BCtS6CPaBem/L9P
         WOhSag+cWhRqY9BklJACO3BziBtZ2kQkgz7GnkUNMFbdqEiSOEApRKO3kH84SHwdSupN
         idlrfpdGFSKXO/rYklSRa8b69tvOllSOasL8GXwSP8eD9U28G1Y4qhyRw1cV9bXaGGi1
         8X903z66nXE3YAlWOKkxvYevn+zY5Fb1AshJ2lMEPFRZMUTIWUnnd6JEVakq7UcZ0sAJ
         EoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724936134; x=1725540934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjLya3FBADkBiVLvBI+fAieJllJJw2pltbhOjsjZXzg=;
        b=kIe5DaNgbUJ3ZwU3u3kj6/rgICdg34CLD8+5FYGs07ghEvjwfEme6FgKJgkw+FQOWH
         bvg9sAlhDlpXyvOgOp5Zn7v48AQuO055m9Oxr9/O6jMkrOPaEBP+/Wi7S+jrddHP0aiu
         QGEjOPVNjWx4mNMrV/c7ZyQ8qloq8p9F209aO27vGDtNidiZUjX3WmdUBjYprMx0wPd/
         IS5zMOEZBKdgU9rZkQGqM9XmWzaj7gyzr6t4mcfXm17fhy3RUNIBSvfcWVmea0jZ01sn
         1XHpjHF+8IEN/iyGRdby/1zgQjLGGjSn6TGTtijF+HWu/CggTzrmWaN5tOR/KeH9nhOc
         ngOA==
X-Forwarded-Encrypted: i=1; AJvYcCX3oASL56NqpEIWqvYLA+bI5fzwb3weQ29PcHi+BMXadydYaxSS7fVM1qIMI/u72UcbURQCxRCakek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw/CugBIertiaL7trGGJihRPHAWIW0vZpfaEgunjISOui8d7j5
	g2imMYh3EQQ/CLVU1J2+J5CLgdbhEHy57rXUIMEJsnZ1Zwmnl1OyqGeR2ufhQCyaOvj7a0QMlh2
	KSXhParPtHjRBWtbwy67jkCaxs88=
X-Google-Smtp-Source: AGHT+IGeDEP7C+qkZWhql4AgndDl1IEwOham3tFfA/5KH2Mz8FY78HMZP7KUqt2UVGRbPVIjU0P134WsrkpUae0wsTA=
X-Received: by 2002:a05:6214:460f:b0:6bf:7a04:f23e with SMTP id
 6a1803df08f44-6c33e61736bmr36408916d6.23.1724936134314; Thu, 29 Aug 2024
 05:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829091340.2043-1-laoar.shao@gmail.com> <D27B60B1-E44E-4A89-BB2E-EF01526CB432@redhat.com>
In-Reply-To: <D27B60B1-E44E-4A89-BB2E-EF01526CB432@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 29 Aug 2024 20:54:55 +0800
Message-ID: <CALOAHbDuThEW=osQudcxGQtFQqePaHzbG3MJyzGi=fLGbUqmKg@mail.gmail.com>
Subject: Re: [RFC PATCH] NFS: Fix missing files in `ls` command output
To: Benjamin Coddington <bcodding@redhat.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 8:44=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 29 Aug 2024, at 5:13, Yafang Shao wrote:
>
> > In our production environment, we noticed that some files are missing w=
hen
> > running the ls command in an NFS directory. However, we can still
> > successfully cd into the missing directories. This issue can be illustr=
ated
> > as follows:
> >
> >   $ cd nfs
> >   $ ls
> >   a b c e f            <<<< 'd' is missing
> >   $ cd d               <<<< success
> >
> > I verified the issue with the latest upstream kernel, and it still
> > persists. Further analysis reveals that files go missing when the dtsiz=
e is
> > expanded. The default dtsize was reduced from 1MB to 4KB in commit
> > 580f236737d1 ("NFS: Adjust the amount of readahead performed by NFS rea=
ddir").
> > After restoring the default size to 1MB, the issue disappears. I also t=
ried
> > setting the default size to 8KB, and the issue similarly disappears.
> >
> > Upon further analysis, it appears that there is a bad entry being decod=
ed
> > in nfs_readdir_entry_decode(). When a bad entry is encountered, the
> > decoding process breaks without handling the error. We should revert th=
e
> > bad entry in such cases. After implementing this change, the issue is
> > resolved.
>
> It seems like you're trying to handle a server bug of some sort.  Have yo=
u
> been able to look at a wire capture to determine why there's a bad entry?

I've used tcpdump to analyze the packets but didn't find anything
suspicious. Do you have any suggestions?

Interestingly, when we increase the dtsize, the issue goes away. This
suggests that the problem might not be with the server itself, but
rather with the NFS readdir operation. The change in dtsize is as
follows,

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 56a8aee..39847e1 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -81,7 +81,7 @@
        ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
        if (ctx !=3D NULL) {
                ctx->attr_gencount =3D nfsi->attr_gencount;
-               ctx->dtsize =3D NFS_INIT_DTSIZE;
+               ctx->dtsize =3D 2 * NFS_INIT_DTSIZE; // 8K
                spin_lock(&dir->i_lock);
                if (list_empty(&nfsi->open_files) &&
                    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))



--
Regards
Yafang

