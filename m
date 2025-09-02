Return-Path: <linux-nfs+bounces-13985-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3B5B40E9D
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 22:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E12A5E1A3D
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 20:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028E72E7F0E;
	Tue,  2 Sep 2025 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outspiration-net.20230601.gappssmtp.com header.i=@outspiration-net.20230601.gappssmtp.com header.b="2L/D45aw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379022E7F17
	for <linux-nfs@vger.kernel.org>; Tue,  2 Sep 2025 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845757; cv=none; b=YcPH2AvtLNrLVtDdKhbA+G5kXiw6a2NMNrH0H3zCV8ZVYPO+HPg6xBzR0fNnfILi99Sx7QFxhbwtngRJLpcuXL193JzkPqmihZ3zztKOf+XIM6uk+jwIT0/lIbdxbrn5LgogKuhcTIPFI81oPFs4aS5AtxQMkVIaO++s3yDC6QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845757; c=relaxed/simple;
	bh=pg4byqyO/wN/DkeJTUxtbkKpoY9bpefUVgcVgJtMFG4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nUil9mOz7QaGRl4v9IKcIWpuWf4OvSYXV2zJEvIh/Mvowi/WU5DP5i3vlQXtd2i6fJHR+786Epj8EqGSDMIqYyRoD/tvwFMk6s6NEUM6TZd+X1CONPN1d5ooeXon2Hz67pixNH7esaHPqYhI3VgJIET8noZF3WNjfoPFaPuLasQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outspiration.net; spf=pass smtp.mailfrom=outspiration.net; dkim=pass (2048-bit key) header.d=outspiration-net.20230601.gappssmtp.com header.i=@outspiration-net.20230601.gappssmtp.com header.b=2L/D45aw; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outspiration.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outspiration.net
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-329b760080fso1982797a91.1
        for <linux-nfs@vger.kernel.org>; Tue, 02 Sep 2025 13:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outspiration-net.20230601.gappssmtp.com; s=20230601; t=1756845755; x=1757450555; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pg4byqyO/wN/DkeJTUxtbkKpoY9bpefUVgcVgJtMFG4=;
        b=2L/D45awClKXXI/iF7CHPZ7NfFqxr4SUyvyuP7c9W1ZqHeQZllo9jNQNKoRnLqaxnJ
         TIJZbaiWMfpi+gd6PC5cZjqYIVU5YcoP7yudACmlczhKNSaCcwp0EPL8xxR1qENaGoMc
         YtL27tJhbo8W11OMUXsJy8bOscOX9iYRiZa0odeoIi5qi90EOEz2zz/iOrw5foXFIuBe
         DRgzdwlEAnVscsZj5+uyq/0LslQDAF90wVVwjAg+unau3mFx+D+1LLdjwAYUTAMv0x5z
         eu9vVjp1DbXTTBxjAyS4VN3wy2d9y3mxquytr9lhFQeiU7moEMI8l5/jfCbTvOwomn7e
         sjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756845755; x=1757450555;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pg4byqyO/wN/DkeJTUxtbkKpoY9bpefUVgcVgJtMFG4=;
        b=eA9rYq4n3K4PEgtGbBGqZubtWvXSGiswldhh6TKqHPAQQmI3xXJ5sTOfxEEm4jVfuw
         QrurDB8qZwlJYpA3twG0mw1o7mwU/tg9pcgYh2BoSrMJ3ePfqDDmPT9gt7P0oAXuuEED
         MgiekvlBjS4WeE3SYEFNOaA5mpsJR8nJMJ32PWbGAIbYoF0kGDaMcvwsDBXPzXJV5Vgp
         n43C297QLs9IXNrvV8Wm0HlcqjkRNAcokV/Cw/LtSR/TTz9kudIPrUXWSkThCmS0zMM6
         sbtlHgteMFNmkIMbdI7I1ddVTCTPl3CpuqAghzASsQXLm157BPkcZtY8gbD3vuoD1ovR
         Ehug==
X-Gm-Message-State: AOJu0YwnCoMzokkXeIMymCuInXYI7xDU23Q8gREaXNnHNhvDOw7qs/UO
	dgM/IWHZIbDISttfcAr+UXMIFU+F1vT8JqK7CXXd5jCdUvgthhifDVz9+IglGE8WOI8AWbOCVxe
	DLj6C3JzEcUicBheAZI+3Roar2HJo9xZ0sKpb0JJTtPV5MmHTeuwP
X-Gm-Gg: ASbGnctzruUQyqaTLf7J3p1jC/QLOB12bXyMqxtNvujfXvWog9W0iy3zC/dUVhfixbu
	u8Kd4izwnAQalrqkJ6dc1MjbcSrc/pRaJoqYakR5xwf1azRobh36N/tCm+FXVyfo6iCC5ZLcrtn
	cosuT0o6KSnWQzsh1sx0aYGwwYlnVGKMCrbt35WyVJONpVRaIVEBKlPxY1v3ddyCGwBVmTT2qvH
	nz7twe75FZmR2SZ/G/bpw==
X-Google-Smtp-Source: AGHT+IGWIiXulhoO9VROlHT6KGYQAyKu9TGQsRPz/3b1l9Ajlk+CZijvH4i/8nY/p2D5DUsSL6UJ+kh5fETtNTB2xrA=
X-Received: by 2002:a17:90b:41:b0:329:e708:1f40 with SMTP id
 98e67ed59e1d1-329e7082b73mr4103195a91.14.1756845755061; Tue, 02 Sep 2025
 13:42:35 -0700 (PDT)
Received: from 766367193577 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Sep 2025 13:42:34 -0700
Received: from 766367193577 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Sep 2025 13:42:34 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Julia Mitchell <julia@outspiration.net>
Date: Tue, 2 Sep 2025 13:42:34 -0700
X-Gm-Features: Ac12FXxCf0009aBS1LmwCFj4aV5TxaMA8Nfix8XdR0Qfpp00ospLsFzgMUbprH4
Message-ID: <CA+Dj4=bdoPYm4OTBUqYVR1v+LzS2O8KhC9QD660PXzW6J14+HQ@mail.gmail.com>
Subject: Revisiting Our Wellness Article Proposal
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm circling back to see if you're interested in an article focused on
combating obesity through wellness habits. Please let me know if you'd
like to proceed, and I'll get started right away.

Best,
Julia Mitchell ~ outspiration.net

