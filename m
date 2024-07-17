Return-Path: <linux-nfs+bounces-4974-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3CC93419A
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2024 19:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB98F28249F
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2024 17:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C21180A6C;
	Wed, 17 Jul 2024 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgMAgEfH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141C741C63
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jul 2024 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721238316; cv=none; b=BXaxRNDTC4vm/vzsss4HRZGmv9xFB/OJ31NVy+XN+JpSUF00Xh36lRXg6elMUw7YzDtBx9OtadZWfRdMaTiUJU+OnM9AQR4gf/ZBLShihlEe2HryA+K2uTF8DARdkYDVzH3+unX01PLGrhFRnFpQhbv2oBlDZnu7j9CTNecw6ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721238316; c=relaxed/simple;
	bh=XfsRPwiUE3Ni0q9Orl+sgrhNGedeSvBMcwXACAtBw4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eoXBbetulIXQebNVQf+ojv93H6ABiMA0vRFFHzeMlnRW9vVc//Ywh+8LTQRgE+bc1LA8kzy+mbEXFwuzpcypsf8LHd3PwsiH0FLiC+aK07XAYLm4VJl8QFPG9+dRJ0oZPfJShwrSfuXtcOfDZUoa7xVXBTYuLNJZly0r0Xbcujo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgMAgEfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEDCC4AF0C
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jul 2024 17:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721238315;
	bh=XfsRPwiUE3Ni0q9Orl+sgrhNGedeSvBMcwXACAtBw4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dgMAgEfHNBd6LDlFEZqetNEy4oAmXbhjcAtfAoN3PRqS9lNaEwZzbTS8vlHXcQ7nE
	 KDM9y2wML0jFsVcq7Mo5u2fDldHwY5xeavMY+H0K48e2gCH7/sw54e9Hb5+Fom6+t5
	 GJuzgAXZ5JxQOCeIVHLlg38Yfonm110UOi7AGCY2obTUJwNHgt0RZLRDJgjZnXVQ0A
	 DvSmJers//VF6W0zz5I36ozh4ukvmdj/6rdlb5Twwtx9A/aOTYmYhJxZyIb0/Hzj9q
	 LMImEo3w61R910WShElpkpnVMzVGKKK/Kz2XmWurLogRx6pLFHFe2zpZynL0yO1pJ7
	 jzeximhmPrLBA==
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44caaf77c7eso36350741cf.3
        for <linux-nfs@vger.kernel.org>; Wed, 17 Jul 2024 10:45:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYXLpoSgFkTpaiW4AJKrdHf47jLcCD/Q1cqj0a3ScgL48xpqprOF9Ymp+vT/gnby3PnMuu2Ff63hWgzD/yYUU8QQj20fw+tROF
X-Gm-Message-State: AOJu0YyJne/tdfslGw1QqlZUCUhwSUUusLHwlA0ckCfMSmCqiMv3Iu8i
	UYr1EX/PxjhmbF8mU2Zhtx8SLpJLIj3MKyW/16puhVyPomk1wbsCcF5u9u3hr463PtAD30Tqw8K
	EGrZNq0+AWkcR8IuzrykY46wxobg=
X-Google-Smtp-Source: AGHT+IFPzV2a4hJg9OaMgsMfgD7FoTlX98gQbRS/jzd2XnbQV9qwOowAerQ914kmlekuS/433q9NoyA7JFvtCJJ9Gos=
X-Received: by 2002:a05:622a:1104:b0:447:e4dd:ca7f with SMTP id
 d75a77b69052e-44f8694363cmr25638551cf.57.1721238313479; Wed, 17 Jul 2024
 10:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617073525.10666-1-jack@suse.cz> <20240717155808.hemnfxyrbfwu6euo@quack3>
In-Reply-To: <20240717155808.hemnfxyrbfwu6euo@quack3>
From: Anna Schumaker <anna@kernel.org>
Date: Wed, 17 Jul 2024 13:44:57 -0400
X-Gmail-Original-Message-ID: <CAFX2JfkGU21cDZ81GeajCZu6LaAZXK7+xMU55Q2dWjLOVG4-bA@mail.gmail.com>
Message-ID: <CAFX2JfkGU21cDZ81GeajCZu6LaAZXK7+xMU55Q2dWjLOVG4-bA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 0/3] nfs: Improve throughput for random buffered writes
To: Jan Kara <jack@suse.cz>
Cc: Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org, 
	Sagi Grimberg <sagi@grimberg.me>, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On Wed, Jul 17, 2024 at 11:58=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> Ping? I don't see these patches being in NFS git tree. Did they fall
> through the cracks?
>

I have these patches in my tree starting with this commit:
http://git.linux-nfs.org/?p=3Danna/linux-nfs.git;a=3Dcommit;h=3D37d4159dd25=
ade59ce0fecc75984240e5f7abc14

I hope this helps!
Anna

>                                                                 Honza
>
> On Mon 01-07-24 12:50:45, Jan Kara wrote:
> > [Resending because of messed up mailing list address]
> >
> > Hello,
> >
> > this is second revision of my patch series improving NFS throughput for
> > buffered writes.
> >
> > Changes since v1:
> > * Added Reviewed-by tags
> > * Made sleep waiting for congestion to resolve killable
> >
> > Original cover letter below:
> >
> > I was thinking how to best address the performance regression coming fr=
om
> > NFS write congestion. After considering various options and concerns ra=
ised
> > in the previous discussion, I've got an idea for a simple option that c=
ould
> > help to keep the server more busy - just mimick what block devices do a=
nd
> > block the flush worker waiting for congestion to resolve instead of abo=
rting
> > the writeback. And it actually helps enough that I don't think more com=
plex
> > solutions are warranted at this point.
> >
> > This patch series has two preparatory cleanups and then a patch impleme=
nting
> > this idea.
> >
> >                                                               Honza
> >
> > Previous versions:
> > Link: http://lore.kernel.org/r/20240612153022.25454-1-jack@suse.cz # v1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>

