Return-Path: <linux-nfs+bounces-8933-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF1EA028F5
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 16:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D1C3A3FEF
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87351487F4;
	Mon,  6 Jan 2025 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="dQrTp4Je"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99748156238
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jan 2025 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176634; cv=none; b=hnK9QmAnSLziSr1XE/tFTPsxA4uCqI68u98/7wfj0fACsTCTj9ZRLoYizhcBcHZmgH2j5noYa4lhD4JxTmIcvsYluC6+J009yG23LcW7gBPnmsHillbbMydP11aV6+gJ/+HuUub4VJhlTJ5BIlnju0kwXDRsHl+d6J7MwDTpVyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176634; c=relaxed/simple;
	bh=OKsyOa5eww6QRp3P8n76rEEmB1EIGbIfZz0vFnk1nsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQ4qT3KiRzMeJl+DjSScipQbSo20M/qkjJsn0KT3d140r8cWOw45rgY4huJtteOt8sstYs1oDJ+6/cSfajFYHOa/pkKtA+NV2xoAlp4S/IjpLz1Cat/xja0xBJ+KxCIaP14DRuJyTehWodLjKXOV+IErwzmIFVEYjHXbE5kHTSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=dQrTp4Je; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3003e203acaso147410691fa.1
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2025 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1736176628; x=1736781428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKsyOa5eww6QRp3P8n76rEEmB1EIGbIfZz0vFnk1nsc=;
        b=dQrTp4Je/KNWybqRC6xU4A2puBvMy0pEycpJEo1ZC5iPoHspbpf53jQr2bo5wL40zg
         LUjQn2yxhmgCGXZGHpIOGOJppYp1GPZVNUjpEfkSO5vBr6N3l/R0GlxZLvI04vHceqF6
         pyAuLIbS/KMgTW2fG1vu9pA56dQNOitRIKZOhRCSEfJJlxBl090n52zlzTg/IiOXacPg
         YFOMWEkUoINNdJJ071BRzpAs3R1wr7HQGSfE2pbEf9oPd1rB/Wox2xccCmLMWOQdZGY4
         StxlWN/s9sg8lt/smwEcVCQG6yxjCIUlHWmcRnzqHblYI1vpIROvSPCLuWRdzp/v8MDv
         WJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736176628; x=1736781428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKsyOa5eww6QRp3P8n76rEEmB1EIGbIfZz0vFnk1nsc=;
        b=xQy2gGkhvjnJ3b1IWeVQFJ7+ntM5gLTsOjbJIyU31xIp7y4x7SPgftbWVFgYrG3iA8
         F1ZjjBnP8F8R/RqtURviTzcH19qRvic1XL4W3ZG+wJjrMTWl2OezOXVNQXMEhvhgta/r
         bb7yVZb603A7N+8R+HtKqIl8Sqs5rwGBMs5zS0RwREmf/f1WeIQ/sNhaiyLYRLFSPcU/
         YpGC5Q1X8VTU1axfnmexglq2RJ4sXjtoiEpTQhYdG6n9ryJaXgC7JXJManlWwrW3P9Xv
         glhlTioYbc24mZ/P/EKEVHjrGJbQFj5HWuHb37keKDw/qFOSjMoBAeI9UU2Cy6bPrs9s
         Fwow==
X-Gm-Message-State: AOJu0YxYkvscLsm/ELyExiy4Z4eYnM7i6A+v5SXzluO3CmClLCVq+pf3
	6tn4s8WiGEERRQPEqSaFmgQGYrf7iLGsjBsXwJmcMM7btpAaxskO9fvd8LwvS85+0HmGKMVybkc
	BOz9Ofr1sRarS/g7O/d2kcQRgrfM=
X-Gm-Gg: ASbGncvhwJeCyIAlIbacss3g/S0uoEeTSWzr9J6gkfVZuFQ33W2N+FG5BkzXCStzvEg
	2KOVHpwqNyIdM55RAoV4dn0Naq+z/4v5s+TXETPmEjmVcxZjLW1oVWmOvRc7Od/JIDRFjCyNU
X-Google-Smtp-Source: AGHT+IGrMmUzYYCZKIxjQcMOKqzj+rU6YIcsFLDKN06jaeXfnewTvC00WoWROMTcrdLNVFdCPBJXWtYkUhuGjGHLU4k=
X-Received: by 2002:a05:651c:b29:b0:300:2848:fc7f with SMTP id
 38308e7fff4ca-304685c196amr255146431fa.25.1736176627975; Mon, 06 Jan 2025
 07:17:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UcAfYN4z9Wmr0SA6DRUt7RmasN2qq9wSZTt50yBs4hP9A@mail.gmail.com>
In-Reply-To: <CALXu0UcAfYN4z9Wmr0SA6DRUt7RmasN2qq9wSZTt50yBs4hP9A@mail.gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 6 Jan 2025 10:16:56 -0500
X-Gm-Features: AbW1kvb-I1PPJpCIhCqMVe4pHpOgdDJVfb_Yk04pelagtRQGWIztgfdCTkwsCxE
Message-ID: <CAN-5tyGShshLaHS6gZtfwGHqhU8MOP52y_09pT9qCcGONWTLmQ@mail.gmail.com>
Subject: Re: cp(1) using NFS4.2 CLONE?
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 5, 2025 at 1:46=E2=80=AFAM Cedric Blancher
<cedric.blancher@gmail.com> wrote:
>
> Good morning!
>
> Can standard Linux cp(1) use NFS4.2 CLONE?

for intra-copy copy_file_range() the linux implementation will try
CLONE first and if not supported then will try COPY.

>
> Ced
> --
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur
>

