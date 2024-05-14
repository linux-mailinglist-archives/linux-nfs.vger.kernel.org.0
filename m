Return-Path: <linux-nfs+bounces-3256-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0FE8C5D0B
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2024 23:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780E41C20C3D
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2024 21:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AED181BAE;
	Tue, 14 May 2024 21:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Krb9lkCp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8523C181BA3
	for <linux-nfs@vger.kernel.org>; Tue, 14 May 2024 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715723882; cv=none; b=VDcdJYmjTh/OcF5lfvRiP3DzPMKL/BbhxA38H/D6SvxCyOiIZb4HXSiikMqnm5RkF1/KYghlrLIYct0+PANr9ln9tdoZhOyKujrQ1dsHW3rbW+yvXDSu+HhgGo0vgPCPdZ0JqQxJ+ngki1z2JmPupUd+wC73qZ8bZclAjkvPJVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715723882; c=relaxed/simple;
	bh=6msAy8CwyV61fp7k0gRI/voIflw12Dpw2HD23Dq0zu8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sQN+cOsYzTcRSNkjRr6LzWJfGoT9qW60nilrvp22/eUzFNtBWSHCtOVvsbyPoEvt8daPxzJH2w6iXybpEVlQ0Jp4ZNkmoz01SVj6CHkq29+z0xtBUH0YCBwGhWuMGYWAaJ3tC7K6fVhoSy0l03gSbiuu6tJTaRiuyPGI+gKV6Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Krb9lkCp; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e564cad1f1so55038091fa.0
        for <linux-nfs@vger.kernel.org>; Tue, 14 May 2024 14:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715723878; x=1716328678; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n8sOFzKThRrQ9Iq3INUvkhuQEyRslaBNqHfiHXphdjc=;
        b=Krb9lkCpq1wPVo5JGnsgM7J2V9TxUNRUd7+sN5+/mfsPxlVaJGJd1yGVhpp3nLizOf
         eeR1+6bqTQMniqF5LAyHKoRm+y7cTtqgVJ5B8Azl1d0f5i0zJGGlw5jGm/gUy/JbW21E
         YymA7s+iMgmDggama+4h+dcvIz98Zvl6sCsFrrz0i3tYr6c77GilVG32omYtVfULguAe
         n25E7cKzl8+6UmpqD2/g7EdFiIfAHbIBfzDZtMO/4/HxyHfUCbNK3pNM4gbEq9HFquyC
         bVYmy+j1u5qV1FaQuw8PbolEzkPMXVNIafKdKT9k6UsENWg7vyi8sKoqJjXT6y2DbK7c
         MzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715723878; x=1716328678;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8sOFzKThRrQ9Iq3INUvkhuQEyRslaBNqHfiHXphdjc=;
        b=BqIjHKGTMsJ1EhR2nuZu7iah/eoniVssKZAaw0Lf1bdZ8sH+oZaLXSmzQPM0bYa+Mn
         i15Q/tHlkVbyfUTZXo6W+fo1wUYSUDqKNAVDcKXt8SdiRYGPKJH/JmVma751idCCfC93
         kvh4nfjzTtIfGjY03P+5PaV8f8jNKMl5zxc8ikR1RrHUQAx08DiUcw45b0UiXg+LM3mI
         j8gbYyL/sK02qvm05dv+aliw/IY5hNyzyfPzLed9jdmYTomeKZ86OUrxgZWPBOUc7TeK
         0kUyL0Fe/Ljw/OK8/j9SFuCtTFmrBsNvMZnZgKTIeeStnUj5/M/ZR4nwDIUH3e2tRDwG
         KDgw==
X-Gm-Message-State: AOJu0Yx0JBP+3aMc/8zND3TiGzyCCwtIlj3SN2oQIiuM/c9/6Qeaxnmn
	C7eKuGFLm0cFuvl1aC9PcAT5ltnYgS537H5QgvpLLmMw2ZlFx9lLHf5FmzP4348hEB+CMQ97PhB
	2BqeJC1ZIOQYAlFFhvH+SP2K1IL7VkA==
X-Google-Smtp-Source: AGHT+IGl77yn46G8qF5EKPT5vRroP8mI09i9Kr2nU67V3zVWe7mD6Av6hfC0YIWUJ8wvRkZ8bd6KLW3TLaKg/Cq6Cp4=
X-Received: by 2002:a2e:93d7:0:b0:2e1:f38c:bd63 with SMTP id
 38308e7fff4ca-2e51fd46252mr88860931fa.15.1715723878352; Tue, 14 May 2024
 14:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Tue, 14 May 2024 23:57:32 +0200
Message-ID: <CAAvCNcCTWbU-ejURuUC0_xhcoU3GF+2jX28rV4+2cKgfO5Lqxg@mail.gmail.com>
Subject: RFC2224 support in Linux /sbin/mount.nfs4?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

Solaris, Windows and libnfs NFSv4 clients support RFC2224 URLs, which
provide platform-independent paths where resources can be mounted
from, i.e. nfs://myhost//dir1/dir2

Could Linux /sbin/mount.nfs4 support this too, please?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

