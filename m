Return-Path: <linux-nfs+bounces-8906-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 744B5A010BD
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jan 2025 00:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF663A3885
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 23:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6151C07EA;
	Fri,  3 Jan 2025 23:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVuomsnP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915931BD9D3
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jan 2025 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735945702; cv=none; b=XEL6Q2k75NV16lEbXqdm7PHFQDlSAlPNQZPnbH0fNHeNjwPOg4oGCrOEq/klScIniS4rl4eewIgW80F7TAdJifWUs08mhS1K/GLuTgxPHVi9C1/ROnmFzifTHfXDwQrVDfwIvLh0eRSYXtCtEd0+2JqXE8e6c5ajM6SXFL7AzFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735945702; c=relaxed/simple;
	bh=7e4jr+gtBGSE6G0Y8LVDHDZx5L6g11303QGz+zi/UMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=no2DfuGUwK6Lvad2J/uVYJ90Jce9Oq/taq0cN7PrP+Repp7SQQbfrg0wko2aR5kzz5ZQCSgX2ahDUiWA+QNEVcBm3mxnVaRlHKIpX3oE4jHPdiDuR4K3keMB3tgbH2Az5t5lpOCoZjCc+mAuw2iTcmZTeG/lEEkqIZPunXxuP5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVuomsnP; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso21950635a12.2
        for <linux-nfs@vger.kernel.org>; Fri, 03 Jan 2025 15:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735945698; x=1736550498; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAG0pP8PQ/VWm6iC9KmHpHWeJpRqrB3mF+t5reItp9Y=;
        b=mVuomsnPO9C0KMCMSczJJDRnZDe41SoLFTa/bKuWwv67lufB/XpNdO4DBl2OfDY0Dh
         vxjVuQ3kW/IohkaGep9dG4r0D/IguzwI27sUGT0k33uMXbCi7u7UThrYwxQp5LU5SDey
         zYK+QWMNruCiqN8IDj/jXftHbjsBnuF6VgRQ8WTOOCna1d0TvJ0b2B30aAo04Wpv2gCp
         hYmLagiFMe4r0JxW4th4VnlfLI3KCpWKCZAZkw2XRarfZuXGfP2P1Lg8umzaU/o0A29H
         XLGE4WR4eyMUTEQdfZL2rgTod042BAVPnaO02ew1yYJWNkl0KE7hqLcyCEReuOPvfzsl
         mgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735945698; x=1736550498;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAG0pP8PQ/VWm6iC9KmHpHWeJpRqrB3mF+t5reItp9Y=;
        b=v44hqGRlNnBuBc5ccZ36QSO6axYMqaQu4j+moMK8Wv8OuTxviEBLUNLNpPUB0naA+E
         ocTGw82G2txXS39kDt6b0/9ezKQlxgruA0FT9/z+N4u/ZjGz7CAWTe+/kDlS1lvsVyet
         bsypoEsgx8+GbmyEmT8GOXtzMlia/TzdzAsygBSZm+3PPU6uYWbmWi8QT5Uf7ypomrAD
         fiU0cbsnU188wi7btuzh8VzT+S3SqJBgE1yelbKM+J1JvivJyPPMam695QZARqpRM2R7
         YsQc9z/UICu4qtScJUM9eDMrYvpXA5HeiaeoNZxvw98EGKjS1e2cbE+M6iDoop20P1pF
         TvoA==
X-Gm-Message-State: AOJu0YxkiyP+Ik/W5llLC2pDjbzsh5StdnD7/0ncQhLcFQ4E3xhY6k6g
	LTfukDiSkyv95Byafb6imElXzcz/ZTpLJ+EeSv5Rv6csnG/GLw9eNnGCT+BFeoEtaPPBJqV3XdJ
	xWFFngpmf4NW7IJQLiRST5vryjUH0pg==
X-Gm-Gg: ASbGncsCyRnwhanufm/A44gmq5u0dvothhBq7tU9Ey3Fc2qs0Nser3XN9X5Ap27g/5X
	L2ELg3fUUBqHJXe794vKUUqYtxlLbxrGtCED0DW8=
X-Google-Smtp-Source: AGHT+IEhoXENbF/USFzLYHNFc7dDXA4GxKMaRcwV1b5k24NASKSV+D7Os+Uq3j0JgU+GYPxQ5cjRjISoGe/54/Zln3w=
X-Received: by 2002:a05:6402:2692:b0:5d0:cfdd:2ac1 with SMTP id
 4fb4d7f45d1cf-5d81ddd67b2mr42331142a12.6.1735945698257; Fri, 03 Jan 2025
 15:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALWcw=HDd06aQi5TXZjVgYDD7+fiheErCqDt2_6cd_c5iieCZw@mail.gmail.com>
 <5A440646-9BA0-4EE1-9AF3-D9C7DDAA1DA4@redhat.com>
In-Reply-To: <5A440646-9BA0-4EE1-9AF3-D9C7DDAA1DA4@redhat.com>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Sat, 4 Jan 2025 00:07:42 +0100
Message-ID: <CALWcw=Fh+YsQ94tG62qTU4Lv2367YajzvmgAjTfdJcbTr=hE2A@mail.gmail.com>
Subject: Re: Linux NFSv4.1/4.2 client source code structure?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 4:38=E2=80=AFPM Benjamin Coddington <bcodding@redhat=
.com> wrote:
>
> On 26 Dec 2024, at 19:45, Takeshi Nishimura wrote:
>
> > Dear list,
> >
> > Is there a document which explains the structure of the Linux
> > NFSv4.1/4.2 client source code?
>
> No, I don't believe there is any such document.
>
> > And where can I find the code which negotiates between NFSv4.1 and
> > NFSv4.2 versions, and a potential NFSv4.3?
>
> For the client, that code is in the nfs-utils tree in the mount.nfs binar=
y,
> source in utils/mount/stropts.c - look for "nfs_autonegotiate()".  If the
> mount command does not specify exactly the minor version, then a mount is
> tried with decreasing minor versions.

So mount.nfs adds vers=3D4.2, if that fails it retries with vers=3D4.1, ver=
s=3D4.0?

Where in the kernel is the minor version from the parsed vers=3D4.2 option =
used?
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>

