Return-Path: <linux-nfs+bounces-14900-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3B9BB338C
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Oct 2025 10:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF1984E2C44
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Oct 2025 08:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F672F83BA;
	Thu,  2 Oct 2025 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4xpWykh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6A12EFDA2
	for <linux-nfs@vger.kernel.org>; Thu,  2 Oct 2025 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759393396; cv=none; b=WtZFwdoLV4T8s226WFS16CxdE8FuBu9UlVPhoId7WUcTHJ1+N8VDoWQRHsBpcC4lR8P48x0IzW1Xyykcywt2SVTxNoUktDil4hgVYFiq/SE9Ee4ExLrl1V+ynTp+3jFkcVZAb/SZbo5YLKXb7sWLP8XrdcAZamrQov+ObmV/4t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759393396; c=relaxed/simple;
	bh=xXT0z7SSQidRbmGjzrWDwZ14mtPuhLuv1xTyrlCxQ4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=KLvRfRPosh3NPnyCG/NSyupmujSv4C96fKZG8rC4rabCYQ1Em4IocOJDMqb1e4rxCOTnLLkacDb4H3sv8jWMvvybMdyUbvnDchghwenBfUeKRaXBDdGnRJQC/qD5izGUsbKxm/vauKvupPubDLfsVaFYGW/HYryz+lwsd8z48jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4xpWykh; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-637dbabdb32so1266698a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 02 Oct 2025 01:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759393393; x=1759998193; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXT0z7SSQidRbmGjzrWDwZ14mtPuhLuv1xTyrlCxQ4k=;
        b=e4xpWykhKe4KSRyDFBJ0aLyOgqzJkWhFyIBU7PFmMcKK3zYwegYNmmcutEOfYPxRAm
         j7jEOUZ3EGLjqJ2gvGb74BNb9D1TAWiBeLxfuMIYq0yCWD+dYpDxq7YSabzuSXRyobYv
         N3qIQ5oVYQzWvG18kULHucaGrRjuwp2nlL0NbnETpxihMpAIA6yDFpbpsdx5Jp+GacWt
         RC338i3jmlx4i8Zc1xNvkv7j+j9rwnzwRlNlgw7EtWTphtqVf0AZ5Zp3oTYArw/SZ5jN
         9mNt70aTPJBbns3hMgQLtFp18UM2YCusetHFCoLto4j4XVxaYcgOLRCNc/cNri0oOEtQ
         DItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759393393; x=1759998193;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXT0z7SSQidRbmGjzrWDwZ14mtPuhLuv1xTyrlCxQ4k=;
        b=iISOwoZrXWQi/k48A6fxL/2b4+sXlZAqqLG+MrRBPT3eU52QXSr23ODx1VDZu/gbz8
         Nai2/inXKDMcX9M4xp1PClmLDhqzpcDq1nKEklmmxwdDHw1b+a0vzmpO1QN5xg4jYbTp
         YHchtW04CMA562i+MEKXEJQT2D0DYbYTp/b8v0Y8SKzlIZW4ZEEqcENI+xTabnxFAuoN
         DWMvu7zGnkaX1DhcUjVO5Cf5gGiNuSXbpwR7lroZhv2P6UW6avG2t+IxwfD2KmAy14Bs
         T1yq25tybFUtALPD7TEGmAI9VQx7C+DmcXqtbv5x8wH+w6gVdvMkneH1KmG0BRK34kNu
         do2Q==
X-Gm-Message-State: AOJu0Yz9hnwT0Gi7uCkt1bZYqBJjIM2EIDQQMZWVD7C6Ou767+d7vCyZ
	7+et28AZTE9WfQOgFDhFUSjMnsbQGNPu/flOdEt2jbOusfLTleJkiet41wvPW0pH5kJqsQ29YCA
	TQZpvk5l/VsD+59Ae2inNznXUcqlVzkuFWw==
X-Gm-Gg: ASbGncsPe5Z/bNxAP+Mo234gh66aVeVYoCgDJqquqSvHQudmoo/+qlV7XDTYBQjcH0P
	5Cljrcmjhp1LB3QwtC7VjrheLWrVcv/z6vyT4b7n+/87bjuBcWC/krrS5FndSuW3ISFHVzMef4A
	1iWmjniTMIrfPPpcu+kZ8ZoLHMdoZBJhe/bcuCvJuKCBZ+M+eK7BjlQfTpZFVQ8iDhEDDgVuz0V
	cH46U0rPcj+R1C9ffjQ0QFYkSGmc9XFRb4Ef+rS7A==
X-Google-Smtp-Source: AGHT+IFiqN91NyAfqY7rQoSaCkNv0Oj5elbZ0AnKIl39yjPGwWttDgBzTy7nIqHnyDA62lgCkYbYtxIoiV0dCsXECPU=
X-Received: by 2002:a05:6402:5212:b0:634:cd66:9cdd with SMTP id
 4fb4d7f45d1cf-63678bb89c2mr7512858a12.10.1759393393214; Thu, 02 Oct 2025
 01:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1759357733-64526-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1759357733-64526-1-git-send-email-dai.ngo@oracle.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Thu, 2 Oct 2025 10:22:36 +0200
X-Gm-Features: AS18NWCvWGoJ_hCMIjkl4cc9Ow7qsZtEKO0wXeY-0itgsHz05W55PH6XN-P3YoI
Message-ID: <CA+1jF5rAMkb44Pu8XGDnu9WUE54sHVf5TurMsQXfrUrmu0Ojjw@mail.gmail.com>
Subject: READ_PLUS broken in Linux 6.12, worked in Linux 5.10! Re: [PATCH 1/1]
 DIO: add NFSv4.2 READ_PLUS support for nfstest_dio
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 12:29=E2=80=AFAM Dai Ngo <dai.ngo@oracle.com> wrote:
>
> From: Oracle Public Cloud User <opc@dngo-nfstest-client.allregionaliads.o=
sdevelopmeniad.oraclevcn.com>
>
> Check for nfs_version >=3D 4.2 and use READ_PLUS instead of READ.

FYI READ_PLUS is **BROKEN** for sparse files. It was working in Linux
5.10, but as soon as we switched to Linux 6.12 it reported only data
and no holes in sparse files. We're back to Linux 5.10 and cannot
upgrade because of this.

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

