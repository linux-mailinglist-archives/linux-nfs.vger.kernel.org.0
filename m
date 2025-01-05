Return-Path: <linux-nfs+bounces-8915-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D521FA01852
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jan 2025 07:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7AF1883A9E
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jan 2025 06:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68FD13A250;
	Sun,  5 Jan 2025 06:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+sbtU1q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EC6487BE
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jan 2025 06:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736059558; cv=none; b=pDSZ5JfeX5CDHUD4ElD3uffgup2EAFYRuZgo4Xr2MHPlfYtHy6FqFMO32LQigP42Q5qrcJcxbZRaIOZFoplKIZCjrgwPRf8rtgeoHKu/tnhb3Wa8M5nnn2qZVeUwJROCSJ0hX+CnmK/yy1RJaiWYnTYbOXMaNXqvwxDRKgNPsME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736059558; c=relaxed/simple;
	bh=b5aaZ27/olVn9BL8/CoV0pC8QyR+y17L/VnUpdu+SzE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=R0WrDLW9Z7afQthJpGeT0Z/keA83RD7wG7uyefW+EIo35QVQ8b9I5j97+4vw87mq8nJl1//4qVBIShNy0AsHK53XboPkjb0YnjSkXBUzHU91mzNBRbQJEMs+OZJBqnzC12u2e4lBT1NKu7ZTLlg7T/gtXFzdnWwRofRF668FP7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+sbtU1q; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so23291349a12.1
        for <linux-nfs@vger.kernel.org>; Sat, 04 Jan 2025 22:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736059554; x=1736664354; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DUUtOkWOLe/POzx+232Ws3Ya43WBjZb0SaOG617uJuw=;
        b=b+sbtU1qjdliRAmQzD//rkQF4WCk++kjIREzeXVh4yPV40H58VC6pO0rnh6cVoW+0O
         R/5SsR5m1k1wiMu0H8PZGlcltmWTujWm8JVxgcH4Y76/LMFHj/5yyc673Xixe9m+0TIh
         WaV3NebDYmciPgAPmJ38y6NVz2NdT9orE+MSsb7OevO2L/wsMn2gdbwpzAANV5BA+0fs
         CEeJwFycyihopJ5NFo1kWJZVlLzYsfF4cPSZHgIP3M8nVPPtzrHflONB+zlX0SzisOei
         EiqhkURxK3rHJ6dYW6Qp05Td9/JyAEOV8TcBfNwmNqwVfetuRO7tafi16MRLp8KnTzLb
         oZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736059554; x=1736664354;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUUtOkWOLe/POzx+232Ws3Ya43WBjZb0SaOG617uJuw=;
        b=rNrTKmkNuS0fifjzi42CDCBBjbGBRT17PbRfG7er5zkxFTX11gzyO0CqV3PFxmkdsk
         qU+ir+QIdY6PDHofdprHYRfr6TTmbkxeMuwIke4wddMqTq7uUqfBSrbuoh2gNlzyrkQl
         DDSuKRqpIDk97mLyoH4eQw1s0/jogZSzDhGiBqFrwvK2jyJ+Jdvowo5g78Ea7mkMO31z
         7NZpFoEe639fJyobU4IMCSfderpkZnZXIKF42EwTrAB76JmBWZPsynw3K/kvCOCcEm01
         IHs4+EGo6svSlyrWN9BelmalLG0HWEtfh7FAoO55hZsXqFAuyHBqcI+Gq8ITsBmBScJq
         A6DQ==
X-Gm-Message-State: AOJu0YwgmAI+WffP+skoOxD5ec/eW3FgG6rNAzSOxASQ5ec+4SqJGLCq
	p6IyfhSPrL8BlUi1MZhS/W86uEk9Z9zEUQ51ipzQbVFZQ3Z+D4NZdsl3HV0X1Qon8Z4sDmMKuQw
	yxAZyV+vn8ac73TjbW0GB2HV5Zd8hLA==
X-Gm-Gg: ASbGnctY5Z5+h/2mFypB3ZD+pmBqaPKW6AG82JTbSUpjp/xig/jqt3dKcvghgBFVXg/
	wcuLJGbH6nNOeFkEVHX0PbY9REIX2+zu/e4ez0w==
X-Google-Smtp-Source: AGHT+IH0Atq0e5SItYydhPsL+RLtbht5JxSDM9yPcfp86EYwmr7q34anGHOSDLzuAnDgASPRLvLccIA8L0qbL/T0M8Q=
X-Received: by 2002:a05:6402:27d2:b0:5d2:723c:a577 with SMTP id
 4fb4d7f45d1cf-5d81ddc0843mr45880954a12.14.1736059554002; Sat, 04 Jan 2025
 22:45:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Sun, 5 Jan 2025 07:44:00 +0100
Message-ID: <CALXu0UcAfYN4z9Wmr0SA6DRUt7RmasN2qq9wSZTt50yBs4hP9A@mail.gmail.com>
Subject: cp(1) using NFS4.2 CLONE?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good morning!

Can standard Linux cp(1) use NFS4.2 CLONE?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

