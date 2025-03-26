Return-Path: <linux-nfs+bounces-10882-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC70A70DDD
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 01:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85483A6A88
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 00:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC93AA55;
	Wed, 26 Mar 2025 00:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI7Neqr9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371CFA32
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 00:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742947351; cv=none; b=uOaBOn36z1pASCojUKh25syIa9ojFRA2UMVodTRa2BVGJjwfcvOdfGr+e3hDRnb2CEB72IH21FzwSL+8C0YgyPDHEiUFV/08OWwQp6lFNTcTiaZDeOAYycPPauSSy1sV5byQ/Bpsty+q0hEEN4cVwVFgYY4et4/t4LkR+xpBxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742947351; c=relaxed/simple;
	bh=Furj8Wv9Fny4JCiu99KSJ0RvsDabxWpiJ7qPTsdt2XY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvIXZCzo1MZp+fYJM4iV/TomiIpaIadtZQ7cANbFeHGeWkaMZBKnsf2/iaKuaDumn1adgBSFEYPKhORIS9XR9dbSjaA5yMnuhE8pu6si29M5CzxxYAt7ycoqV9Fq1ttuyWkWjMYQZr/G3oYTtTQLSMbrDd/mjl7FBWWJC0SNSko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI7Neqr9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso11293229a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 17:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742947348; x=1743552148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Furj8Wv9Fny4JCiu99KSJ0RvsDabxWpiJ7qPTsdt2XY=;
        b=SI7Neqr9ouBgt17GI291+lmo/vx++PobUasdeYmNAe+qU5x6csIqI9D5btD6bCthi+
         Bww5tTmKAFD7iN9Nzm08KsBnMvEwxRjAuk+Nc8ai9vnE9tYmpwr1MLpcdrpCdYuTtoIP
         Q9hw2R++AgQeOHF6eK0NulsGP/NTvQSqogSxLun8jBqSZ1e/evh7W1YS9vl4VE4X6ccE
         kRarprpjebZ65GNZx4dq7fRiqP1Wmdg8SYPg6FCkC4z4q6aYKmtLT3DgKeo2dxiTjbNL
         x5xgVtIZk6KQVdVM/M7U3piF6AD4juwuGrWfdicteQaphp8XvFKYBFCUQupAYaA2NaBs
         QrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742947348; x=1743552148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Furj8Wv9Fny4JCiu99KSJ0RvsDabxWpiJ7qPTsdt2XY=;
        b=ed6l6//VTYIyGotSbXC4NTHoEdGwG0V+hy7f7ElWnAB/rtxT+g0XRqbA09wOfw7UGW
         EFOmvaT27C+6yrYSrgBHfdPqfDeueQGq7j0cr7Vx8hPwPC0OJg0V8ElgCWJX5akiOv6V
         VTfLMn41VDEPNRP01pGqQe/mw4/3pG0VoB2CPLOaulibSC/He0THgjLxJ8Sdx2ZvgBS+
         QRGIaIFoJpDzpc41m4+hZ+6/agWp0GiVgmDf9n32hVFikn3yyy2kRhwU2SMKEVCvzEiJ
         /+5C2TJWx7BZ62l8AD2XMmQFb6AVt7z2xIuZrh/5nFdf5ynLES/Cbyd2Zin3MWQkDRFU
         9NRg==
X-Gm-Message-State: AOJu0YyeE0g0+FRj7fcUhM0CIjoLneDfVYdH0/AB4+hc6SHx89/Ut21a
	KsvfZjJllGUCszYcuJaJzayx4fhyRJEx6vJFs3XobAGH6ifczW9FwuTYeSMpjheUvr/8X6ryKS8
	A9BQpUIKaolXg5xrWmCNUZDe+lA==
X-Gm-Gg: ASbGncumyj21DgfFSWxkLDcDMPsOkpQdwCLSwd8PMxkcL07dQWuRPAW03vAepTPXn+q
	ZUcR9WAcvHzPmHAlp0CZXhPiwwcMsh3dVjvLiHJHmq/2rib/ecYxNYAEYMJLk9c3IobbFCgVSr2
	820mE3szD2P9zXjg8dkztMvYSkscHwJm9+ERWMAf8/HCygX1W3QlEIU8aypQ==
X-Google-Smtp-Source: AGHT+IFwx9B/lz76jg9cegvbXCdybEaN4XmMjOdprdA+8p5OTdowPIcnqSKvKGPSg8QDV7abhAoD0wbPOSUqH3slGwE=
X-Received: by 2002:a05:6402:510b:b0:5e6:13bf:2c7c with SMTP id
 4fb4d7f45d1cf-5ebcd429dccmr17503594a12.9.1742947348241; Tue, 25 Mar 2025
 17:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPJSo4UW_vRbDgAyp5zdapxODvwrpJidZ55+MS+vfWv3cJdJ4w@mail.gmail.com>
In-Reply-To: <CAPJSo4UW_vRbDgAyp5zdapxODvwrpJidZ55+MS+vfWv3cJdJ4w@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 25 Mar 2025 17:02:17 -0700
X-Gm-Features: AQ5f1JoBkGDxhWgLE4dBDFa2zrpj-xY-X6Zf3Btfh_z9C3FZlKp6yrkjsGc9198
Message-ID: <CAM5tNy6tqPJv2Q-LccKyAabdarZjMojb2MfobF_HM+ZX7WOuvQ@mail.gmail.com>
Subject: Re: Lookup all file names for a hardlink via NFSv4?
To: Lionel Cons <lionelcons1972@gmail.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 12:09=E2=80=AFPM Lionel Cons <lionelcons1972@gmail.=
com> wrote:
>
> CAUTION: This email originated from outside of the University of Guelph. =
Do not click links or open attachments unless you recognize the sender and =
know the content is safe. If in doubt, forward suspicious emails to IThelp@=
uoguelph.ca.
>
>
> What would be - using only the NFSv4 protocol level - the most
> efficient way to lookup all file names which are hardlinks to the same
> file?
Not exactly efficient, but doing lots of READDIR operations asking for
the type and fileid attributes. You have to start at the root of the file s=
ystem
and read all directories until you find them all. (You'll need type to idea=
ntify
subdirectories and fileid to identify if the link applies to the given file=
.)

Also, there is no way to guarantee that LINK or REMOVE operations will
not be done by other clients to change the links while doing the above.
(Really no different than any POSIX file system.)

rick
ps: At least that is the only way I know of doing it.


>
> Lionel
>

