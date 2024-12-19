Return-Path: <linux-nfs+bounces-8676-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 649649F86DA
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 22:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7E616C55B
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 21:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51801A7255;
	Thu, 19 Dec 2024 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="X9bmr8Ps"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80931A0AFE;
	Thu, 19 Dec 2024 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734643437; cv=none; b=Ln/q/NoPiKEMGjxMpHoMrOymUlKiW7B+l8xogDisUZaiow2OpVNnvcQMzJu19jt/NqgI8fptQOHoLLSwLBlK6TqYGyKiL4IB2God0N5F02+9dwykrBXggsDYsAS3GCM6T8nyo3VeCoo/uzu4WDm3QuPr6NdxXKQczfi7sXSNxOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734643437; c=relaxed/simple;
	bh=YSXUKNOxUKBTl2k+EmBkumZ4/p6wGaf9XAzIBBXEN3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBl1Bcgvb0ZUhRQrB87crKEWANnsPoILQwyvW8dxAGNjcxKWWTqqd1l1aPYoFJMjJ1FNuOSalqms7c5l42HDsTX2cH/LP7BfhKfeu8/19lytZHv3Nui7WOXnkKUagS3UhclUuPYTnYI+JJe2dDuxyA/z/1EzlD5fH5vDURyOMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=X9bmr8Ps; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso15008641fa.0;
        Thu, 19 Dec 2024 13:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1734643434; x=1735248234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bk7Q+5jZ8A5uMdCqUvX/qRfplqvehXAOIBRofIdZK+0=;
        b=X9bmr8PsBfvzXscqFlXTRcZxR8i2zxDJNiYFkUbRnGK9KzkbJl3x+gPHIsGuqj0mlm
         6KUry9avXXo8e1OI7LvlRYbhJHBzyid6L/UZBQBXWnAvJExeVFo4g9RTnfBoIH6eNp0G
         G7XlqBSvrg2mp4aE6gTLU6WQfOSpLs32PBAGnlxRpzqmuNeNTihO0NsXd1akwgLkgIyQ
         Od2utQMM5CyrJJhtphopNVuCb7OE5y7cNfqQKp5WlHsSIMsXjVkCM0JS21PoW+bEjPFr
         JZm0y/Jl/a3z5rzRPfB3SVcOdU3LMLxxj2w0vY0wfsrkgliwKEDyUnvUwPJwVqFPQpZV
         i2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734643434; x=1735248234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bk7Q+5jZ8A5uMdCqUvX/qRfplqvehXAOIBRofIdZK+0=;
        b=gmCp6j7iPw35axwaHki7SfFeR4xR1oPFVY+yfySEd/rKDisD6EW3cEWljL9qnmmDy+
         WFpwE7hfQ3/YhF596rzj+htnBN9aAaeFBC9nHQ8h+rlSzjnP/bJt4GFHEsTtCPaX+/sb
         IY+yD34tViBAEXgSrQshPE+fF5r5SUxcfCXk3La+LQE6PANvxsQT/+QCMNW6nT+n9spZ
         2fdWE7H6PNsIkMLlwNAyrlXluKESV2v5Z2tbW5V5nbz87WyENgrwDMD8q9ClfAicI7d5
         H8zNigNjjL439CrVHPFPScl/R0/lRLy7mN3ouw2sVtMGymE2jN2eWdWk0iYaESMFungw
         DhkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4T1tjNgWQIGByfPS5G0/awYMdffm4DuYDbH3wSC/qRl2uITB5k2Sw/u0QxZQbTqW1YgDkuJNhJ+P0@vger.kernel.org, AJvYcCV0AFHysYUEgw2txQcuhjxp7XM5bL4bea2dkjWJ6qgmGYBrZ+GylFN2Qj3LVwAGYhykIkIyZXZ5HHjVQXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+xOhItszdiiD42WGYPZ1QU5HwByqB5H5c88jpVs8ivraEOshm
	haWU0+cPMnZeTIoO5TcB60fEt0V9hCpoZrYwyImWby5Bm52CVaeIrEqQqyhDyrfBjE+gh3HEJuY
	FNm2DTmCAAm+eEGIqVMVIeeuuopg=
X-Gm-Gg: ASbGnctsOileLWR1QjIxijQCUWpbcuraIo9klu6LI+fpsE5IiOEb41a8R3fNqnh9A/p
	EjYINEO4PEyDcuWTEmgMJY6inpfC33L8BNF2EuZzZSpDMAn0fGiFAnHWA4iqG7CVdj5dg7ovz
X-Google-Smtp-Source: AGHT+IFQa+sRh59cAeO50PSlBjfA2kdZSyQWm5rkfzG+ALghVuX5oAqC9yqMNkHbz0IYFfEPT/sA0LnSQPoDgnh6k04=
X-Received: by 2002:a2e:be1a:0:b0:302:52a8:243 with SMTP id
 38308e7fff4ca-304685f56eamr1618921fa.30.1734643433560; Thu, 19 Dec 2024
 13:23:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826-nfsd-cb-v1-0-82d3a4e5913b@kernel.org> <20240826-nfsd-cb-v1-1-82d3a4e5913b@kernel.org>
In-Reply-To: <20240826-nfsd-cb-v1-1-82d3a4e5913b@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 19 Dec 2024 16:23:42 -0500
Message-ID: <CAN-5tyGWmAZ2ovmS4SqiEoZhokxOG+ERvOVFB6ziTqE-ahLFUg@mail.gmail.com>
Subject: Re: [PATCH 1/3] nfsd: add more info to WARN_ON_ONCE on failed callbacks
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 8:54=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Currently, you get the warning and stack trace, but nothing is printed
> about the relevant error codes. Add that in.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4callback.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index d756f443fc44..dee9477cc5b5 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1333,7 +1333,8 @@ static void nfsd4_cb_done(struct rpc_task *task, vo=
id *calldata)
>                 return;
>
>         if (cb->cb_status) {
> -               WARN_ON_ONCE(task->tk_status);
> +               WARN_ONCE(task->tk_status, "cb_status=3D%d tk_status=3D%d=
",
> +                         cb->cb_status, task->tk_status);

Can we add cb->cb_ops->opcode to that as well?

>                 task->tk_status =3D cb->cb_status;
>         }
>
>
> --
> 2.46.0
>
>

