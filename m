Return-Path: <linux-nfs+bounces-4984-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC62493521C
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2024 21:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BFD7B20E95
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2024 19:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA88145348;
	Thu, 18 Jul 2024 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8Bs7j/o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381E313AA26
	for <linux-nfs@vger.kernel.org>; Thu, 18 Jul 2024 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721330820; cv=none; b=sQVfpZpbiYpH1b28c77vUBypIN+jy2s7rdKk9wadUr7VFCE6mIlhOTQQQxO6RfFySLzfiMiJptqmKShhKxONxP0ZhYcRE9/c45ZDidiQhOvZvhCiUTKq9hbgP1MM/4zuTsaR+T3aZ429jJYmxOS4Yc8jEE0BXPcdaRHnNEiH+p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721330820; c=relaxed/simple;
	bh=U2Mo9ns/vZeI0qrEhBNbIzl6KlEftYZM4ldijquJNtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Roz85j2aYReokdQEAS+YJNABUzp8LCWn29FkisrQw8ZZyvmPMt/miyo5wkRT0vfEk00iXDEqt0m/wX6unwp7vlPMNO3PYu3YAYqQeeGjypKJ9B+J8M5wd99DH2nrWpoMl2kfkRi7Sh/uZ5572E2ZrG7gIc+MkECNFWw6m+P/v9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8Bs7j/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7650C4AF0E
	for <linux-nfs@vger.kernel.org>; Thu, 18 Jul 2024 19:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721330819;
	bh=U2Mo9ns/vZeI0qrEhBNbIzl6KlEftYZM4ldijquJNtw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J8Bs7j/ofMC2q4oybIvkXI+JsJB5ryu0bggLlIKz151uyzfdd+KPKFaPjOvY+jZtC
	 5naSXcILiNSrMPPlatxfcIpFh+AAtfJatmx9+K0cPOBQ224NuTDRyN2VcTH57mLLcH
	 9xiWISSb3dq6k2ErJFV27LB9NckzysLNwPu7LIJ8eJc1xefLxGriQv7vCb6qfCiruy
	 IGmTQy+xahO8uVbq0Gu2jf8kRdb9N2S5rSlvWgEPZPvxIpVBokXeuWRZaC8XMyRAm0
	 q928TCfRNu2oyDeLbNFVIbMBsvE0pQ5UkFeSg9vgHbUZgPyYe9ELaCOaZCG0k+rb/L
	 uZuYtDxFMJ3Yg==
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-447d6edc6b1so3665841cf.0
        for <linux-nfs@vger.kernel.org>; Thu, 18 Jul 2024 12:26:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfC1C+BXmM3JaLQs6RwSs7LyaWTm824B+/rH+wzZZveoLDuHQ09Fw3FQDJTQDkicqsC1xPJR6IIL/755dgQTQhvfG3z4enr9sV
X-Gm-Message-State: AOJu0YwMDyDOeM2cpfJH1eBP9rdAgLoBNIhV86mOOWObNXDAn/E8KmcJ
	4puFAW9oWFhsW2RizRo6Q+Rt5ZY7PefwRz0Elk3sm7qXRyxlVq0xvArkLaEj+XC38rzNBRb+OLS
	KSDNmTifyWHbYjMbfWkPCv7J4gyE=
X-Google-Smtp-Source: AGHT+IH29XJ4g5YiCpxBnfhtvh0MaQFfPG44Plve2R70oa1SxGSVipOZ05lIrCT9QkFXZX1PLyMT09OuZY8AsSQpAPg=
X-Received: by 2002:a05:622a:1a17:b0:447:f259:2956 with SMTP id
 d75a77b69052e-44f96af1906mr16927261cf.59.1721330818862; Thu, 18 Jul 2024
 12:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617073525.10666-1-jack@suse.cz> <20240717155808.hemnfxyrbfwu6euo@quack3>
 <CAFX2JfkGU21cDZ81GeajCZu6LaAZXK7+xMU55Q2dWjLOVG4-bA@mail.gmail.com> <20240718094747.labht76fwq6a4bi6@quack3>
In-Reply-To: <20240718094747.labht76fwq6a4bi6@quack3>
From: Anna Schumaker <anna@kernel.org>
Date: Thu, 18 Jul 2024 15:26:42 -0400
X-Gmail-Original-Message-ID: <CAFX2JfmdvnDzCEY97B4J2-p4NBErYtu=csV5Jk7B4p5uDEYWkQ@mail.gmail.com>
Message-ID: <CAFX2JfmdvnDzCEY97B4J2-p4NBErYtu=csV5Jk7B4p5uDEYWkQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 0/3] nfs: Improve throughput for random buffered writes
To: Jan Kara <jack@suse.cz>
Cc: Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org, 
	Sagi Grimberg <sagi@grimberg.me>, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 5:47=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> Hi Anna!
>
> On Wed 17-07-24 13:44:57, Anna Schumaker wrote:
> > On Wed, Jul 17, 2024 at 11:58=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Ping? I don't see these patches being in NFS git tree. Did they fall
> > > through the cracks?
> >
> > I have these patches in my tree starting with this commit:
> > http://git.linux-nfs.org/?p=3Danna/linux-nfs.git;a=3Dcommit;h=3D37d4159=
dd25ade59ce0fecc75984240e5f7abc14
>
> Aha, great! I was checking the tree mentioned in MAINTAINERS file which i=
s
> Trond's one and because it seemed fairly active it didn't occur to me you
> are maintaining your tree as well. Thanks for the link!

And this is the first time I've thought about adding my tree to the
MAINTAINERS file. I should probably do that to avoid confusion in the
future!

>
> One more question: Do you plan to push these changes for 6.11 or 6.12?

They'll be in my pull request for 6.11 that I hope to have out in the
next hour or so.

Anna

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

