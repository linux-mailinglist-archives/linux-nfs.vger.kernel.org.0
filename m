Return-Path: <linux-nfs+bounces-17392-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7DECED39D
	for <lists+linux-nfs@lfdr.de>; Thu, 01 Jan 2026 18:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A22683006621
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Jan 2026 17:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ECA21B9E2;
	Thu,  1 Jan 2026 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHAYrsNt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491EC212554
	for <linux-nfs@vger.kernel.org>; Thu,  1 Jan 2026 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767288268; cv=none; b=jw/nOkb6LCMh/zB3cKI3I87s0778WeeETWtO8ZtcLY+HG+tgISVCkpBSV2t61oK/HrIadE7l23cEK+ah4kg71DKRT3HmkG7z25uAvPAio+I2Nu+OcGfvWzTmsnArOlojSueLa9perZP24ADIT8UqjvMDv2yAo0BKEu/BUSpqPD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767288268; c=relaxed/simple;
	bh=UsY1v9zg9dopwxFTR1rJStwgW2FLHMtiy9XJjstJIoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Fb+of+EGK0fMjHcEUqCwIMe/mBAaaevYjinLoKlwqDyMUrJO6vfNJRMY6ZL/hzLgm9USa+m31tqFf5c/f0usCzzpFpbi7+GV/YyOQP94pjb4xHP2oWex0XajI3IFUnKq/RdfvqAYSUoqjpvrygsBf5GT4gFSuzpaVSb1/MRMnPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHAYrsNt; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64b4b35c812so15933284a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 01 Jan 2026 09:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767288265; x=1767893065; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsY1v9zg9dopwxFTR1rJStwgW2FLHMtiy9XJjstJIoU=;
        b=hHAYrsNtgwo2ozazCH0qFsQ7u+3383wzJeY4Me0rTeuPYocQCDzoiZfyxSLFEkwPdS
         DLERt38VsOfTsqSc67xLcjhgzofAGj72SCXRZwNo/x1KWu0RcZkyigk+jlklBKz4djn8
         2cVFc+xJl4sa/dtTgGTcECLiwT42aPwVAOMKXNLb7K6Yq7x/WMn5J1Nig/Fr1uEMADj8
         D+Vt6o+3gXt3T63HvNYn974NnsX5cPSMBXSZj3oyTK08yO7dc08GJw4PJcq/eK5evgvL
         5pBZsSmq/A3vgXVFQwQvgnb+IFLnHQL1CPJoxlbJE9yw3ZUh9jM5OfEVsgl9MV6lYCMD
         Ry2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767288265; x=1767893065;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UsY1v9zg9dopwxFTR1rJStwgW2FLHMtiy9XJjstJIoU=;
        b=o1p5ZRwXxntGT/qM6go+mXvKzHgXG14ow6DYlmhD9Ilf2nFX5LhY0PTIyCAD7bUvm2
         ntfjSagoRHazhdh6IapoJzjUdMgdabdV6DFDIV/OKWhwaLCuuhJlyMQbw6/qB+oBb1Ej
         njvdiJdqREaiUFpMY+C/5EuNWgbLRmbfj0qKvTbuupRfAFsKKetpNkZr5hhB1bFlZbOe
         vOYCxCKfIZ2NwFFXLdDeIP2BReLtxKKcbhvPtadFwgSgH3E8/FQ//7IpvBG7whyeBKZw
         G1yVXFwBz0NXuY8cM2988RxXInTFtPx8uzglpYLZZGVlwasGkmBSrMpcVkCXwDKEArbO
         kkRw==
X-Gm-Message-State: AOJu0Yz0GpF6I+OY/TKjBq+xMreF6XCHH/9tEKuc9gjeGKilOtn7lQRG
	cLx0FKjpJEFsElDFEwHO7DIn6GW9KuY/4rnjxLSS6+h86bz65HrxQ1nVLOHHPkPFn51nLiZQRNl
	nGtlZ2ceMvbx36+RuAdaipXscwK8TA7lm1K0=
X-Gm-Gg: AY/fxX7BTdenmm0MIwkFKF8f52AazCvyMFANdnuuUWCENGq/17GRYRlQXlf27pP6hOn
	gl5wDAYemwnaK/HHdEGvBGFIRy3tfPd2RqQKErvLBRjNV46iHoVjEqO7RQWUW0uEKcY1GPhpbGp
	Bc4klCVXHLvBO0xCAAJtBA5EEWcvbeIw6UuLDJ36ze/IFOj+yM2EbXbotjQluFRDjWg8asxqFHE
	z87PADkyI3nwsakPYOWSCpiFC0cRiCJLhlLnoyyZkpEXU2AuMnrxLcR642s0ZVx80sBdJMajNZ2
	Ga+iULkY+mnRnS72vhhWBotBB4k=
X-Google-Smtp-Source: AGHT+IFjePC2OpPSqc3Tbi30YvKhrVgu+RslkFxhMvlPhqQtU1e+1YZuW5PD3hVxKUqk7R7vQoTwAIuC0SrDw28WYqc=
X-Received: by 2002:a17:907:3ea1:b0:b76:74b6:da75 with SMTP id
 a640c23a62f3a-b805ab8bb56mr3714404466b.38.1767288265381; Thu, 01 Jan 2026
 09:24:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy7QEoa1iE6Cu6Q-aOSzEodQoHF9z2AUwdq7sSnUS5XamA@mail.gmail.com>
In-Reply-To: <CAM5tNy7QEoa1iE6Cu6Q-aOSzEodQoHF9z2AUwdq7sSnUS5XamA@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 1 Jan 2026 09:24:13 -0800
X-Gm-Features: AQt7F2oACs5LsTqHDqcSWCIvd3yI1yYUMo60kz6SnLmzrQmWtAeNlZcBl7yexdU
Message-ID: <CAM5tNy64UfdrE9qEmdkpxG3VE+XMCET=jxhrA3ktNmFsrnRA9g@mail.gmail.com>
Subject: Re: RFC: No NFS_CAP_xxx bits left, what do I do?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 8:48=E2=80=AFAM Rick Macklem <rick.macklem@gmail.com=
> wrote:
>
> Hi,
>
> I'm trying to clean up the client side of the NFSv4.2
> patches that implement the POSIX draft ACL extension.
>
> I need to set a "server->caps" bit to indicate that the
> NFS server supports POSIX draft ACLs.
> (There is currently NFS_CAP_ACLS, but it is set when
> the server supports NFSv4 ACLs.)
>
> The problem is that it looks like all the bits are used,
> when I look at nfs_fs_sb.h.
>
> What do you suggest I do?
Oh. I forgot to ask if the simple answer of bumping the
"caps" field of "struct nfs_server" to 64bits is ok to do?

>
> Thanks for any comments, rick

