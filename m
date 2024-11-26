Return-Path: <linux-nfs+bounces-8218-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015AE9D8F9B
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2024 01:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86CC7B21ED3
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2024 00:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C772546B5;
	Tue, 26 Nov 2024 00:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/Uz0g2U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA4B2C95
	for <linux-nfs@vger.kernel.org>; Tue, 26 Nov 2024 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732582287; cv=none; b=hydqGNpnzolalSOI3cqX+dHUYnbAz90uxL5rR+fVgjiyF9WBII38pIAgyyKCMKN7ln31E+pz2sxP5fpPuwQTz2dju92eg38tjEuTC8y2ozlVaHV/8QHijzNAe0IOJu5+FO9CIV/E9K25UJD/24NCpqpDuRXVYdiiFYz8wNmRSPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732582287; c=relaxed/simple;
	bh=RhpfRjmHqZlemLzAcQjMr7IwdCVN3RNKrg6kWcUUvQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QX0KBe3atXHUvEufzAAiIqvAV55QtOqUM0WTrGMgzrZGCEqqXgUGl1SLB0WrSDolZw3zHKNXk81qTsf4q4UnJangLcK5Qi88Bqo+/jYjoQU5Gb05SfcEu23QTXsnbFA8S6xdgNn6uc5mDKwqXaz3LSink9uPeDzVXJTHGuGWMNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/Uz0g2U; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71d59d86ba7so415020a34.2
        for <linux-nfs@vger.kernel.org>; Mon, 25 Nov 2024 16:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732582285; x=1733187085; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhpfRjmHqZlemLzAcQjMr7IwdCVN3RNKrg6kWcUUvQM=;
        b=M/Uz0g2UAEYL70ievwxp8vzwelQqbFiBUTuc2az0PBFxo5JyLQnvjSBcMbT27uxJkm
         QNhjviWxDtRwf4D/5CXEQYNp+gudHGAFses26s6rL4UpkjNQgnq69+lAw4UhloQhvPR/
         uBqWnlrder9r5CXuctnreNFoa+qPqQ+3YLbFyQYE4woUqY8GfuTc+TeFJ6ZK6J2GlDwA
         pNaAf9z5FhyPxy28bjmkSrAR9KshFGVaRhuy5cRgG5TReDlUhu6aiMA+wkIqNwFSFYNM
         ZhoySrSFWE3WostKTb71j45YPrJlq9qDm61Ys2lphkWZxliE8OcvfsoTioGzFL14cn5F
         6ofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732582285; x=1733187085;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhpfRjmHqZlemLzAcQjMr7IwdCVN3RNKrg6kWcUUvQM=;
        b=tfwhBpzPILR+4nCbiykbGUmK4OPUcvVLQdWsxO24Iqi6FJdkfFcaAVaccQLwtKtQhF
         br9zvjV1wI1QXYFGLdENtXrR4/lb4ntoQwh+2AuBVlPR21kCmjr+kMhpHxdSSBvT652B
         x6S710MqROtf0DH8rWnxlekXoV/xqz12KUz/g6bM03qdIN/9zUGBEL1pM7xg5RESDQcn
         fHHBsQooZuU+yCFEjQmDSvTKRZyZJdeBxFymaPFasFXOoUhdispkKiUYI8jevLLOK25O
         Oj68Z0d7UstGnc09bFVihg7/pz3SwJGc5+MG80BM37s9Ue6ZqSFK6LsTJVZx+6fu8+6O
         MXog==
X-Gm-Message-State: AOJu0Yyx8kL9noTzK6x5L88yd32cAEG6IHVGN0xQQTrLn98L2GOnP2/7
	PXtLQdGgydmlSgwakpYKQsHpnksjBPan+vfVfhuSXiJXtzs20GvJACFqUNmSbACu+NOHOWMJp3C
	cfhpsSdHyeXETvhJ5XAjxCxXH0IEc1k4Z7RQ=
X-Gm-Gg: ASbGncuXIkHx3NEtocnbb+yBwWHDozwp+GsQBA+Nu2/FX9VmXiDUZHHsKS43+6QC0RF
	Gg317M7TsBAN7tPbKmFdRpxLp/fBprgC6
X-Google-Smtp-Source: AGHT+IGkVzWyfj/UEoRrGvhg3z7haiubbJyplips4mLWYvplUb7mlevZk6wTfgTsHu1aBgd0CnOVYngRjp/XXCUQPSk=
X-Received: by 2002:a05:6830:7301:b0:71d:5c89:e505 with SMTP id
 46e09a7af769-71d5c89e7d7mr520425a34.9.1732582285232; Mon, 25 Nov 2024
 16:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALWcw=GXke+r7OFM03vEfJUDuw=UVE2P5TSXt+_m+LP9XD_EEw@mail.gmail.com>
In-Reply-To: <CALWcw=GXke+r7OFM03vEfJUDuw=UVE2P5TSXt+_m+LP9XD_EEw@mail.gmail.com>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Tue, 26 Nov 2024 01:50:49 +0100
Message-ID: <CALWcw=Gyi_+JmuUWL3v494pb9GJizJWS0QbjMGKMdt3pBAX2fA@mail.gmail.com>
Subject: Re: iocharset= mount option for NFSv4 mount?
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 1:19=E2=80=AFAM Takeshi Nishimura
<takeshi.nishimura.linux@gmail.com> wrote:
>
> Dear list,
>
> I am investigating the options on how we can change the encoding for file=
 names. mount.cifs has iocharset=3D for that purpose.
>
> Does mount.nfs have a similar option?

It seems the option was renamed nls=3D a while ago, but does it work for
mount.nfs?
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Seems

