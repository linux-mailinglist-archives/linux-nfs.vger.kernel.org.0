Return-Path: <linux-nfs+bounces-8934-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5032AA02954
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 16:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B383A4CA2
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 15:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD5E8634A;
	Mon,  6 Jan 2025 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="CS7tmysY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00239146D6B
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jan 2025 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176916; cv=none; b=Lr/13m5gqCivw9qUynQnXCxBNsaedus0fOL1ORLVH7tQmNjM7q0GD+BXA/ASXLFzb6r+dwVP9XX4WGWECkien1C0AuoM1+ysMvUVPX9YfITldLwukI5XEKU0w4Ps1f1ocvbruSarbLsF6YWCW1DZWXN8RGRFKnjJCS4qMLk/esE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176916; c=relaxed/simple;
	bh=XKL+MBnG5+oiljLSOU+x+nOG/gR1ZAoIG1X83T1HLHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flcDFcfpMA3oa629fOJjPSRD9LduIyTkVj+9KBTI2tLqYxXThxj9qPYhWEbwXekwAplcd7naQQdNOVnj+Bo3oUi4awYqIIffzYqHd4RFE5pdUB2LP93DvolqqWwmN06GtBack4nEIWxepYHALIR14CuSG8GYAX7os6AjM34jxLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=CS7tmysY; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30167f4c1e3so84986811fa.3
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2025 07:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1736176913; x=1736781713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKL+MBnG5+oiljLSOU+x+nOG/gR1ZAoIG1X83T1HLHQ=;
        b=CS7tmysYGowkduT+r4pMWDvhJFXt86PiSm58F0HfN1aAKfI68A9AvPVIbDBZW4pWaI
         FFzMsiVX1gF/L0N/ZQuLsFMykZoDQJZzX9s5ze3jQR2PhmQUbyvi+rYTHJIxM0orlrc4
         HSTazEpeWvvsmh+bJXjfHfYqYyHG6FYRhGdYuGrgHeJ2/sWh30jGqQcpSY0zmdkVJITn
         GQUNYeSpUYo7ug91PKElDPjXbgBSOtRl2g+axO7FwBr3Tclc4W/3QjtLH1zdmvA5VOun
         Gm60Fl8kPL4zyUrkV1rmadT4vLraxJ47WZh8UZjV0Y0e7XPoqPM/rszqkwhtqDLYkQDs
         aTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736176913; x=1736781713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKL+MBnG5+oiljLSOU+x+nOG/gR1ZAoIG1X83T1HLHQ=;
        b=mHH2SzHgTYByXcXZYsrkoogOKglMsTwbL6TiXV91pqmvy+Ku/GjuuPp6BxZqZ6YGbq
         uehfTd4mSRz87j4tzuvXDBAt0M1+WEDujpfy2oPgFUf+Pgn8jINWq2jxb2zlr6CfK7+l
         lTjOaEBI3o6wPi5hdkvXjy6pGrYLlQF/CIRjUNBDLmAfOAsc9sBCrzaiaPZCoJ6WLnJW
         lVnelCaEb4uy34pXXgmxuDEXkyggufO/XILlwRbjntd5wJUn1d/pPdoEdPHH3vKJBTlj
         cHmueDkJrLXqZBvVh7TAJlkZqkd7tisS0wr4BsHp6m9Xma1d2ZxowW+2jbTimF743m8f
         MnPQ==
X-Gm-Message-State: AOJu0YxOI0A+LUatzaQAY5ZHZ8bypAP5PDmMbY/HzG1vBGcYgZvS1Ef9
	moz6snByEO7KRMhSlpp6dmZeH09+ZWCeKAb8biBje6Mk8x8VirS8h0XBt5N7IMGOxnt2Qen9bM+
	vSSj5BVumn/jBd2NDnqGYoSyE6t0=
X-Gm-Gg: ASbGncsKB2Fij0YB73C7uxB/rwh2cOwVoZ1rDxtV2S7Op/rVNgpByJqrQ0xPWLwd49A
	gnh/iQbWJ71u5EjZcBL2iKy/M0445vTVEdZiTq07LiK8f1lEIPBNb0/swv45FRdu5Ur62OFtd
X-Google-Smtp-Source: AGHT+IHUiWP4RjTS9yrZ9yOl2Ex/TMjzd+TwPBLwEJtMDJ00v/AutwO2IGhCb9pZchYEGPHEMMqDgAChg8qWPszyfTA=
X-Received: by 2002:a2e:a78a:0:b0:300:1aa5:4938 with SMTP id
 38308e7fff4ca-30468547b78mr155789261fa.18.1736176912801; Mon, 06 Jan 2025
 07:21:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0Ucd6UQTCn_SZz_kutWwc=OUd6faHMjLx4Kj=Cmhjvs9pw@mail.gmail.com>
In-Reply-To: <CALXu0Ucd6UQTCn_SZz_kutWwc=OUd6faHMjLx4Kj=Cmhjvs9pw@mail.gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 6 Jan 2025 10:21:41 -0500
X-Gm-Features: AbW1kvbtyi58nY6y_BheE7aAkDpB9ywsjaf7jX3-4NL-r9IwXChn-LB_djFyosA
Message-ID: <CAN-5tyHR_cfyVFmrj_m0i-2K-z_=SDGCpaYGEQZWEGw7CBWoUw@mail.gmail.com>
Subject: Re: NFS4.2 CLONE copy blocks into the same file?
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 5, 2025 at 1:46=E2=80=AFAM Cedric Blancher
<cedric.blancher@gmail.com> wrote:
>
> Good morning!
>
> Can Linux nfsd NFS4.2 CLONE copy blocks within the same file?

Linux server calls into the exported filesystem for support of
clone/copy functionality (thru the same copy_file_range() VFS
functionality).

>
> Ced
> --
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur
>

