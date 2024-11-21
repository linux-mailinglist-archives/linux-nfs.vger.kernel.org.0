Return-Path: <linux-nfs+bounces-8172-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB6C9D4551
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 02:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F56D282765
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 01:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894692F3B;
	Thu, 21 Nov 2024 01:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOWf0w/1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E074619A
	for <linux-nfs@vger.kernel.org>; Thu, 21 Nov 2024 01:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732153059; cv=none; b=VrsbtFRYhd0tcBDmjzeFpHlA2DRl+Q9F+turi0PmIa8SOyYSScn6K7EUh4pd4d47kXVdsRi6ebKXKuv8b9H90PWLhvnFA1yshwEEQOPnqLiejPCiNxorNXmH3g8om72001CJWLLj8eAWXEIbNMq9nP7TqaduhvIwWrOMIZoZIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732153059; c=relaxed/simple;
	bh=F1KFpIVqPO6x8d/ad1aJeVKk1mVmE/nefIip2XizM2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cg+1FfxwEfqA9/D23i8xtOLAVt3AwgnQWbHNx0KmfvITa6O9wMbE6Dm++ihiI+sPGs9XJvrJJXJjQ6lF9/UI+vvxZ+se+CE8m3cavmPHwhjJPEbz5zeZ0L3ryJCaOF1YHnkbUJggiBKGiVK9c31H474CjBi9jcidyqToDbHR2/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOWf0w/1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so484976a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 17:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732153056; x=1732757856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1KFpIVqPO6x8d/ad1aJeVKk1mVmE/nefIip2XizM2I=;
        b=XOWf0w/1aXC48hNyhd1slKvnuWsKoCT65b6vu/ylYEcZy81PY44n8KjCOS4ZV50K1P
         cg3bUSggpePw2QiyHGdEEWXRqCUcQ3VfhiI3nymtTdy8wbSxsKpbrB6vuG0+DHRbcFX1
         RE78Kv/3giPU7Wrz63ggc7SjWAemFz39gnCCJj6Wr6ywOTWpl31fH+7/pENFSMvDGXmQ
         dNnMQNuK4g4ktcDbHM3YZSFpx5f10Zzi8RENfkA56husD8I0MKpGqqLym+kkzl7PUdgq
         fOo6kNCjpuVh71bJFMHRlBI6j6maRil2xdHhVLKw3NcrzFMAQvjGoSWsRaRL3xunWP0N
         av3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732153056; x=1732757856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1KFpIVqPO6x8d/ad1aJeVKk1mVmE/nefIip2XizM2I=;
        b=c55+xwIQTDZY2ynAmVC5vVrO3TwZTTy6hOEJ98UakV8/GhZ/utFojf0lRfVKFP/TdS
         8bvmwW+qgdfMd0UKmvK3dbQQYzdCoDRARBZyGn/6u9nIY7VxMlJ7Tu8g08BsUuNVwQd9
         6ON9/IkF0zT0Pw4vH0IW+WICiBupvVW/X+NPJ1LMIEWZiKbiVe6eC78J1qWZBKre5W2r
         VxtDLHYTY6AnkPocp2QvVUHEtykE24rL1yocskqrnP4VjeC6yRP4qouSp408x0qxfxIm
         noztMzDiuroVLsDixYAc1qnA5wFAX2WB1aM4zALi/qlkeoamOZlqjz83SZqjO6Q+r6Ib
         yw6g==
X-Gm-Message-State: AOJu0YwhPlSoGj444Pb5ZMuUg7baMWr2A0ljAeMl3ofq/Bra6oO+CUub
	QQXuJRxtkLP4kw+xhxcvj63QYzSYPy++m8jqLwxxcKR/uQqsTQE5KryblNMT4JAmu8HFP3JmGms
	Lj7UFMfo0sUYis71SN48uMJm901cRsNk=
X-Google-Smtp-Source: AGHT+IG7ufDFTitFwdpUBkdzFuYYNyPMCsFUZtnWHB3FhCiPNz8GBRoSw76yIkPZlYtIrsbROdvkpLviWD1RmwCcXOc=
X-Received: by 2002:a17:906:6a23:b0:a9e:ec6c:9c4f with SMTP id
 a640c23a62f3a-aa4dd552d3dmr458891566b.21.1732153055762; Wed, 20 Nov 2024
 17:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcDm_Nbx2xSC6ev-hy6mJaztb9=SUOPb3n=KpXqyzvkFMw@mail.gmail.com>
In-Reply-To: <CAAvCNcDm_Nbx2xSC6ev-hy6mJaztb9=SUOPb3n=KpXqyzvkFMw@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Wed, 20 Nov 2024 17:37:22 -0800
Message-ID: <CAM5tNy4zRExxVYCnCurx1bmDBx=VWhNAL10Zem=N4_4LY_6N+w@mail.gmail.com>
Subject: Re: NFSv4.2 client: Just using ls(1), find(1) to detect sparse files?
To: Dan Shelton <dan.f.shelton@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 3:34=E2=80=AFPM Dan Shelton <dan.f.shelton@gmail.co=
m> wrote:
>
> Hello!
>
> Is it possible to detect sparse files on a NFSV4.2 filesystem by just
> using ls -l -s, or other options of ls(1) or find(1)?
Maybe for file systems that do not do compression.
However, there is no way for an NFS client to know if a file system
is doing compression.

At least that is my opinion, rick

>
> The goal is to find sparse files without opening each file.
>
> Dan
> --
> Dan Shelton - Cluster Specialist Win/Lin/Bsd
>

