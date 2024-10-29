Return-Path: <linux-nfs+bounces-7553-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B24DF9B4E97
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 16:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FDD281A60
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 15:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749F8191F7C;
	Tue, 29 Oct 2024 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hcl-software-com.20230601.gappssmtp.com header.i=@hcl-software-com.20230601.gappssmtp.com header.b="xJYY4qdh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8BE1917F9
	for <linux-nfs@vger.kernel.org>; Tue, 29 Oct 2024 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217265; cv=none; b=HPwAWB0UzPiTPY1VGuomn8O6LpqxyLBg3kge3GdodFb84HRkObOuBeUw5gLoUm8gUMbOpIw5MiDJ6d70dLk3B0omYq5s9AtQiP+tLOpHZq6lzNLl0coISV9RIR4ic7QLCudpyk+2tj0KgoMG4FzwvPtkCgCG+QDuW0moD8SG5bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217265; c=relaxed/simple;
	bh=jEmLcNIABlpVp6T6lDmxM8zBJGAT7qIcFzxJ794ZzEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Eiw6oLQwRFduxEWcbl0JxGJGlRW/dSIuGOdlWiB+ucs5/kRWi8hK/8fJtZkIxTKj8HOmNZVhzC197OkdredIWzVbTXN8JabDY/ZdM9aCV3Vh9fmBoKzP98F9AFY/o7h3b/eb562qLrVcf26CrJZ14yvFV1YbiD4GJaS+iQ0tsLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hcl-software.com; spf=pass smtp.mailfrom=hcl-software.com; dkim=pass (2048-bit key) header.d=hcl-software-com.20230601.gappssmtp.com header.i=@hcl-software-com.20230601.gappssmtp.com header.b=xJYY4qdh; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hcl-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hcl-software.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460ad98b043so47462141cf.1
        for <linux-nfs@vger.kernel.org>; Tue, 29 Oct 2024 08:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hcl-software-com.20230601.gappssmtp.com; s=20230601; t=1730217262; x=1730822062; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHhAnkxPtw0ipD2OA6f4pYL7eToq+x8dsxrMcEWsI2M=;
        b=xJYY4qdhCbvaaBduSGZW8kd4NhJQN1SQ9UOquZzQlkKNzX/A6dYp4pNTgUmqvg6UxM
         fNSUvapzbka09oZstxrQtWkAw6zyof00TRQbzecGFeXM42WHRVNvx2H3NWwdG6DR6xp3
         7qoipK6aKO7iYVwYoYM0ZA9HjEIJbh55C8IwPAxUi0yBtzLx/yeiNGa7h6pZdxcEGMfP
         HWeqSqZyy64ji10kixmuiVfznUOMrrUgIuiDRLBBFSNXvEaD1gMDfEYzlhXANfurtAgK
         NNE459V2cHRtpTB/nNEBit/qOegJJMo3kdiNrK/3P+Obe1nP98RsOgZiaSvjpqzobE2a
         0YGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730217262; x=1730822062;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHhAnkxPtw0ipD2OA6f4pYL7eToq+x8dsxrMcEWsI2M=;
        b=vQdMaRByw0zs2BNpGWLxDHesYMPN8DoA9a/RX+wyDzj40RluDkmoNQbYG1UxutfFtI
         duI4FV0AvkzcBJFZRM4F3L3C+14Q8FwU+KgVQ42GXKoOulGjbE1B2HaJZW6s1rmaPyZy
         KlVryLJ3hv3/UHcGM8n+bp6EP6c36/8rgxUW/6YmEsjO/CKAnr3Tr2uEiChRdQiZi/gJ
         0dZuBLrLSgSNrnfzZBMWbz9qolPWvXkvTJgHNc2hhQTrrqd2z3MKvfEdaX56sZWyCYWi
         VDluAZg18Ij3ZtZvctVVkgXoE6TJa8sG2KWUkmiEUJaXLIvpD5Yj8TXJzsVSeQwkkJXM
         X45A==
X-Forwarded-Encrypted: i=1; AJvYcCVePB9rbrtbZHpSiuBSDj2F/PQMqNooA4kxQRFUcinR1onsyZuD/NmhU4irdnRPH7rbZEbBdil6B1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8/gzPawuI50gw0k3Ud86Nd5H1LbUquYyRX9+vov6ftt0G/EvI
	ab2n5gOPEuHlvkoKSGyl/8tgrlHRYmcfyoSnA913NsG/Y9b88H1KCkB6anGOvZkH1TetRhv8hwI
	UcZIn4L9oQd4vsKrDHCqBs6Ta7s3Ovh/DnJyxugoDI6M8y2X+eqg=
X-Google-Smtp-Source: AGHT+IGkORhrBUVTn/PibRv7zHGedUBtOn4MU52GQao2BP/OW+SUfgqWNzF0pEYkxt3pdWXFoHvo568WkZ9kWkZ8hbc=
X-Received: by 2002:ac8:7f06:0:b0:461:6478:eea2 with SMTP id
 d75a77b69052e-461684915eemr31039791cf.28.1730217261899; Tue, 29 Oct 2024
 08:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023152940.63479-1-snitzer@kernel.org> <20241023155846.63621-1-snitzer@kernel.org>
 <CANH4o6Pi13aEtQW5-vmuJiuCNzx6tjn1+v=pLUpVMuffX-WkPA@mail.gmail.com> <7FB2B261-48F9-4DA0-B4B5-E8E30EC31CD9@oracle.com>
In-Reply-To: <7FB2B261-48F9-4DA0-B4B5-E8E30EC31CD9@oracle.com>
From: Brian Cowan <brian.cowan@hcl-software.com>
Date: Tue, 29 Oct 2024 11:54:10 -0400
Message-ID: <CAGOwBeX7xw7cPRXGO5RmLQUgzOjqr-7Bh4EhV=hONpXCAqsX-g@mail.gmail.com>
Subject: Re: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4 reexport
To: Chuck Lever III <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Honestly, I don't know the usecase for re-exporting another server's
NFS export in the first place. Is this someone trying to share NFS
through a firewall? I've seen people share remote NFS exports via
Samba in an attempt to avoid paying their NAS vendor for SMB support.
(I think it's "standard equipment" now, but 10+ years ago? Not
always...) But re-exporting another server's NFS exports? Haven't seen
anyone do that in a while.

Using "only local locks for reexport" would mean that -- in cases
where different clients access the underlying export directly and
others access the re-export -- you would have 2 different sources of
"truth" with respect to locks... I have supported multiple tools that
used file or byte-range record locks in my career... And this could
easily royally hork any shared databases...

Regards,

Brian Cowan

Regards,

Brian Cowan

ClearCase/VersionVault SWAT



Mob: +1 (978) 907-2334



hcltechsw.com



On Tue, Oct 29, 2024 at 10:11=E2=80=AFAM Chuck Lever III <chuck.lever@oracl=
e.com> wrote:
>
>
>
> > On Oct 29, 2024, at 9:57=E2=80=AFAM, Martin Wege <martin.l.wege@gmail.c=
om> wrote:
> >
> > On Wed, Oct 23, 2024 at 5:58=E2=80=AFPM Mike Snitzer <snitzer@kernel.or=
g> wrote:
> >>
> >> We do not and cannot support file locking with NFS reexport over
> >> NFSv4.x for the same reason we don't do it for NFSv3: NFS reexport
> >> server reboot cannot allow clients to recover locks because the source
> >> NFS server has not rebooted, and so it is not in grace.  Since the
> >> source NFS server is not in grace, it cannot offer any guarantees that
> >> the file won't have been changed between the locks getting lost and
> >> any attempt to recover/reclaim them.  The same applies to delegations
> >> and any associated locks, so disallow them too.
> >>
> >> Add EXPORT_OP_NOLOCKSUPPORT and exportfs_lock_op_is_unsupported(), set
> >> EXPORT_OP_NOLOCKSUPPORT in nfs_export_ops and check for it in
> >> nfsd4_lock(), nfsd4_locku() and nfs4_set_delegation().  Clients are
> >> not allowed to get file locks or delegations from a reexport server,
> >> any attempts will fail with operation not supported.
> >
> > Are you aware that this virtually castrates NFSv4 reexport to a point
> > that it is no longer usable in real life?
>
> "virtually castrates" is pretty nebulous. Please provide a
> detailed (and less hostile) account of an existing application
> that works today that no longer works when this patch is
> applied. Only then can we count this as a regression report.
>
>
> > If you really want this,
> > then the only way forward is to disable and remove NFS reexport
> > support completely.
>
> "No locking" is already the way NFSv3 re-export works.
>
> At the moment I cannot remember why we chose not to go with
> the "only local locking for re-export" design instead.
>
>
> --
> Chuck Lever
>
>

