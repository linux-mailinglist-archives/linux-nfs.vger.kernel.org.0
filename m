Return-Path: <linux-nfs+bounces-16775-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EAEC91549
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 09:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E1434E1376
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 08:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE232FD665;
	Fri, 28 Nov 2025 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mk7LILrl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D8F2FD1B3
	for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764320301; cv=none; b=EekV1CMjT2a4PovLylK7axc9mIKxd4hIaS7TT1dxI1mtmoH79JcGmDcp/x9EzknH8QM81j5oeTZvjBOlWErDq/l/zFQpnbf8xb6x21pGA5nHfBT0xO2jqgAbWyIBQFbKcdf0cjoCulbGzKf1aP7dLRn6rqrFmfhVooOmkdU+7H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764320301; c=relaxed/simple;
	bh=el8JAeMwalE6lx4OJppOT6BuKprXIN24uH37W/Ltf/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=lLetR7NRB8qEF8ZrMz5r33Ew1l8WpivvhjQ+l7/g2Sb0180GcpoMcpbccup6Vgr7gcJEJ1tugp3eCUvPDhJTumYGRibbZxnd9LBVPObOHgGmkmKmVHaUxY48LUhauTKsXzzjxdTX32UK1YSlyuPyDB5MdEeeyHf4vhECmj8Bqyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mk7LILrl; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59584301f0cso191923e87.0
        for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 00:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764320297; x=1764925097; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=el8JAeMwalE6lx4OJppOT6BuKprXIN24uH37W/Ltf/4=;
        b=mk7LILrlF4+bDmmQ5xByFttroXhMmzWz7l4rbDPc9Tyikny5PFw2TkjWnxvva283Ri
         Rt/FO9Nr80SX0XeMULMFe+PqFNBi0JhTnvkmkkUK1+cwz54onsVaayytPG3+hcvMijgL
         QPffw1Qpct1GIL0kjLAcBigL/B+Hbx5z5V2nPobdEbrfFOsPJ2i9bJv+KyY/sdOz0csW
         d7XfDm45eRD8UcNO9VoCzP+9HmKC0vwqPIO7QSEcJOLBRPITAxA7v+4m/B71DmVBKWOn
         mz5ALkJIVm47HcwfctXQ0JUXRze8zcPHKuzkf8+E6j28RF500Mze3ycCH28iOcv7E3dh
         90yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764320297; x=1764925097;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=el8JAeMwalE6lx4OJppOT6BuKprXIN24uH37W/Ltf/4=;
        b=iUdnqpcyVP/YDe0EONmj60en5/rLsyf/qgm9tcQEoYVoW2FOK+zWoo5xpvVVW4BLUI
         cxJiiMcwnaV/lVfujOeepmOICgm4fMuT4xMzqUW9Yt03AEL9DKCNR32uLL/xT1PzieSH
         c7Wos7ZY20FQvQiPFMk7887AKWMkqpqGfmC82hHGsBJk/72xnIQjGHCDn5XaUxpr2zmj
         YfPDKr3DddBvw67s4agbfx+uPcRMzM3Q6rkTtsTi3IfZhmBFvpr7QZkk4JLoWx79r3mk
         8+eqbNQo9gYJq8L5jxU1ZctwKucILJUFHS0m5a1RgJzpgq/GOKH8TrMHQPWZmJQCVdAX
         ajcw==
X-Gm-Message-State: AOJu0Yw81SGuObDxgPiThVrVe3ippXICF0EHfCnSzkPKgXcgcZpcomeP
	bD7z9kp3UMZSqh+LfAMn3v6RyjpPUGlB4BIIBlqw5WXiqiF6BIQZy1zCZWYuiqSABsCnRor4qMk
	yY89lgOqgV86r99jkuzlvNmtK47OAPR5Edg==
X-Gm-Gg: ASbGncsbEovtXURCjulhVSQ5YxLCHg3UC3W+2JNvqa0X2g1iRByBxMzvPq2uC5AuGZN
	/UV8I8qi4zyWYyYdEmBYvWPCznQieZkmSnf+QDqKiHUI7N/cXEDIvWcs7kFjJ5uEeLq/9pt7LL7
	nKPUTbCKcb4wLAsCe5LMiIVCUMTXUvLJfEBC4MPA/SIBtcsHi19OqFbdQGS83esn0IYfNhp+rdm
	iTZlxgpkV/c2rAXH7rpc21JRrCKx4WQZjXiQ9qpw2K9PQKUa7PRceXMA351X/Go15WKcQ==
X-Google-Smtp-Source: AGHT+IGyKVdnBQUIjR7BzvGHtQCqSbE43KR80CDNbA/f+EO7Q6t3FJ5vP++AJdbCFo4825NEPvBi1aUoJGG0CfBBk7Y=
X-Received: by 2002:a05:6512:238c:b0:595:7e2d:986a with SMTP id
 2adb3069b0e04-596b505c940mr4978318e87.24.1764320296987; Fri, 28 Nov 2025
 00:58:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_780E66F24A209F467917744D@qq.com> <5e1b3d07-fd80-47d0-bbf8-726d1f01ba54@app.fastmail.com>
In-Reply-To: <5e1b3d07-fd80-47d0-bbf8-726d1f01ba54@app.fastmail.com>
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Fri, 28 Nov 2025 09:57:40 +0100
X-Gm-Features: AWmQ_bn_GuQQ3tmCUToj_N9ffy9Qxg3-B7W6vx-0VQUiW5wLV8-8XRFi7ULWlPI
Message-ID: <CAHnbEGLi--K9R_JHhROR4YfY4gbD3NmyO3MwX2xrdX8fxxAAdA@mail.gmail.com>
Subject: LAYOUT4_NFSV4_1_FILES supported? Re: Can the PNFS blocklayout of the
 Linux nfsd server be used in a production environment?
To: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 5:41=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On Wed, Nov 26, 2025, at 9:14 PM, Zhou Jifeng wrote:
> > Hello everyone, I learned through ChatGPT that the PNFS blocklayout of =
Linux
> > nfsd cannot be used for production environment deployment. However, I s=
aw
> > a technical sharing conference video on YouTube titled "SNIA SDC 2024 -=
 The
> > Linux NFS Server in 2024" where it was mentioned that the PNFS blocklay=
out
> > of nfsd has been fully maintained, which is contrary to the result give=
n by
> > ChatGPT.
> >
> > My question is: Can the PNFS blocklayout of nfsd be used for
> > production environment deployment? If yes, from which kernel version ca=
n it
> > be used in the production environment?
>
> Responding as the presenter of the SNIA SDC talk:
>
> There's a difference between "maintained" and "can be deployed in a
> production environment". "Maintained" means there are developers
> who are active and can help with bugs and new features. "Production
> ready" means you can trust it with significant workloads.
>
> The pNFS block layout type has several subtypes. Pure block, iSCSI,
> SCSI, and NVMe.

What about the LAYOUT4_NFSV4_1_FILES layout type? Is that still supported?

Sebi
--=20
Sebastian Feld - IT security consultant

