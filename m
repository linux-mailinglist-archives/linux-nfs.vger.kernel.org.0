Return-Path: <linux-nfs+bounces-8663-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DCC9F74A1
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 07:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD37169C4A
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 06:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9181F868D;
	Thu, 19 Dec 2024 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mkh+Wuhi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5556478F4C
	for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2024 06:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734589652; cv=none; b=E23l2AvhgaO7Ej1zLIN1ZtQ2iYC9CsKf2PyrnvvWZ6VI0C6ZX1SVwHzekbQ97kiLC3XNs2d2b2dAbo69YJHU02rmDE/1dr7JzSgFtNnTGwiSkbRj9Y/v3nbOLVbovfiZIYA6Wk3hGG1J4Mn5vUtjRGE3fmlRdwRwaKvAVCrhf6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734589652; c=relaxed/simple;
	bh=JFP5u889PgmBqxR53F2PsGp1GnTxlcCjS/V0dTVR05A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IlWhW+WqPTmXJ+YX2hwb8ONgSPeLFG+9qiAcGFcFbGR7XIGBjgtzZkstZWHz+ulsgPc/zorXkvY0qV64TUQU3GmNziNjbLTWZ7xn1eshTYkBNsV8U3LK04b6lVWP9wPX5q+ieJMrGkJki/xr7capD81gWqtwrg13G5eVC6963yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mkh+Wuhi; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3011c7b39c7so5564231fa.1
        for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2024 22:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734589648; x=1735194448; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JFP5u889PgmBqxR53F2PsGp1GnTxlcCjS/V0dTVR05A=;
        b=Mkh+Wuhip8gKO0/MuNhlhQh5Wm4ta+IniwzePwyDnkSiqJm71miEa5HT1jOwQqFsX2
         4Kw9vy+NEuW7OJs4i1BtgAD9i4VYt22Lj0ire/PCZapzhkzzgrocjJ5aFNhiSzjawGI3
         EotwtZY7NpU3ynzmQjyteXEzHJryg5zi6U649Se7AiIsx3YAeG/Fpf3AOcQqoIsvbr5c
         h6nnbjzX3rpgFSgMvemUZmTxl4AzKp593BCbD9yFQHba6EY6hlMA+4XVg27RMA/qrEZU
         txh6CJcZwttZMhUk7ohwhz8NofG/wqo68VKkR16suJnlPhBVX6tpf1u3/xcQRekF0FkO
         I7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734589648; x=1735194448;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JFP5u889PgmBqxR53F2PsGp1GnTxlcCjS/V0dTVR05A=;
        b=FH9+hlWyhV3qqN3s2NHejsqGaz0yZWi3c84gKhdJrxoBfsgOS6hSAB4fC1Z2T1gHlk
         EFdGnmsMw+TmdS862q3tKjdiFpweaqF38XI20HglBKcBEeu7NWbLKAiPfijxG2kPIkRU
         8mYGTGkgx/aAEojaNgzvtKRFwe/beYnCbJ5z/1gbJZN6oPdLxmaJQBj8dssMNDPDHFNy
         ywoXismgFTOJrcoVZuQljnc7p+i1tjnM6FlY/YcqCGtBWLYCcYR5PEnHlyWIdkEOEiHD
         AYXgtgNLckKNGu09HzpZqEfX8kN9VaINKHXvCGaLaOyig1rJaR+bHC5ai2U6rMQUtNTi
         d9dg==
X-Gm-Message-State: AOJu0YxjtQRWytZ6wJ+7CAKwDA30Pt+TRAaSteeNJZ7S+euy3O18Jguz
	kvecEhpv2RwSxkz+CobZbTXwvHVfneOl/8nQDC5bRhjO6HJ0XMWDIX1TEF62WZJdIKE1pHhWvx+
	b7PvVWSktirljdVtd7m6QVRMUh/QcDuJa
X-Gm-Gg: ASbGncu/JiMDM8OTEGXqspk2tww0L/byGwzTcQAxAjnq0RaRgwbjVMoQH/NHmOWr80m
	Tj0GIlAL5gmwDMMzPa8ZFTc84NkafFsg9c0o7yw==
X-Google-Smtp-Source: AGHT+IGuCAep2aRjso7EKbBRMV2O4nkEswXFP+ikCP1IKLBmtt70EqmdruBGJdqH2SmhLAxntNFFI7VKsJzw/sORZz0=
X-Received: by 2002:a05:6512:b03:b0:540:2567:469b with SMTP id
 2adb3069b0e04-541e67473a7mr2210060e87.16.1734589648082; Wed, 18 Dec 2024
 22:27:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aleksandr Beliaev <trap000d@gmail.com>
Date: Thu, 19 Dec 2024 19:27:17 +1300
Message-ID: <CACbgpGO9N7W_ZKmpjorkn+h8a0DBLPn5U_vp3s61AzfCwomo_A@mail.gmail.com>
Subject: Recent version of nfs-utils/nfsidmap has issue with static
 translation method
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi there,
I'm an Arch Linux user.

Few days ago after the recent update of nfs-utils/nfsidmap to version
2.8.2 there was an issue.
In short, if the 'static' translation method is enabled in
/etc/idmapd.conf, then nfsidmap won't work at all. You can find all
details in bug report I submitted to Arch repo here:
https://gitlab.archlinux.org/archlinux/packaging/packages/nfs-utils/-/issues/2

They suggested it's an upstream bug and asked if I could submit it to
upstream developers. So I'm doing it according to your official Wiki:
https://linux-nfs.org/wiki/index.php/Reporting_bugs

The best regards,

