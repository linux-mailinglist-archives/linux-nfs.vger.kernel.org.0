Return-Path: <linux-nfs+bounces-8168-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95239D4463
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 00:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C664B24A88
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 23:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4AF1C304F;
	Wed, 20 Nov 2024 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7TyH4Cm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE4727447
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 23:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732144737; cv=none; b=WhnbdJRLllp6d9Vs2b4n/z6NDQ0zw61Dg3rXfqExzLaKyStjeLVr82m52P/q8N6ua7RGdVCvrHbm+N54Vouy7G3WZ2c9IE0wjWYA/GMu2pzo7jS000O59B8UnANd+OkIsWhgvBCuZGA0EdhbtUZvHlyQVM0s2a09FOVN/gs7eRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732144737; c=relaxed/simple;
	bh=bivmfpS8Cg5z3U+Z0LQltGaj/qZSqMcKs1Bhp1Nu5fI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ObQwysqGhOG+2b2U1qQbtzHxKyEoj5Ii6Hb4X4IJ4mWON17Nxdg99VhNx9KvA79eWcrNGf9PzjZh+wdoUV/V7Tu5nN0vBi8MVh0ssAWG4Y1oRm/DyR8ygVIt4ayXOo5kWNzdSbMIXaEFN3UGuTI0yjeKJMiTcnKbCE67yVYvVjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7TyH4Cm; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e601b6a33aso249364b6e.0
        for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 15:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732144735; x=1732749535; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W2Vow3MMqNnx3kypCC8Uiau1FuJyAasLyx2kjniL95Y=;
        b=O7TyH4CmWJo/Ivawc+hl/Hn3A115rRH9IraLZHRWQSOeWwWRYILcTyqfU7jx9QpWzf
         DzYSEBnbQ7bmn4PWLwXDwyTiu0Qply9c+KjyUkeciRMt+ca3Y3O9EMPySA94zH3LeEeN
         0R5YkH3TcFecVdVzgukhFrbgf7HbrOcTX8tgY601W4jpJPocskUV8DmZZJBdQe/luwFp
         2sLBbFgxJZCvIxErSJ6bG0eyULhKIaer1MAmhjyVzMyRx+pZsTeMgEcABmhMjGQfeR/2
         xJ/6oelbBvyfkcQZGFKifAQ34RedR5I0K57v/SDlJWCFyDlnRvZ1Z2k7I8zM4hEnZKpA
         6sGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732144735; x=1732749535;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W2Vow3MMqNnx3kypCC8Uiau1FuJyAasLyx2kjniL95Y=;
        b=V4bAgc+p37/xUIamP8aBo8PPPSZsP3xIanN8AzC03QCTFOn6FXSxn2/YGBY/EeN0bv
         nMbObJo+5WM9m88IZB7FvdeZB3H9HSRiDcacKa51ooYVWZR5NqnTIZZi6Oy8V1pEp3d5
         QRJn63Gd2jd8y9DFWg1neDkkTvBZiG5cfLbHxhQ2jPp25mNm4J/go8WLU3eJHTftf8Fm
         h1ttbZ1JPqbfJ8eL8yqIQWwcx/gM8PHs+1gIubRrbAdepkUEkXWeLiVIZDsthBtTKCZx
         8rEcewzs4hrvIwIKQjxwLHSjfQlfjmPu1/SzUK5nee/ozI8+ilFjxumlnf0+fE2HuU2q
         /h7A==
X-Gm-Message-State: AOJu0YyCENOmv/ea4OUN3PRo3wA5DFUoBFdTADJq5vGPuaGLUOB03cOq
	P6M9tImgfuEROu5QvGX4YsB+jJjbzXf0lH6fXCS5155y2ArvCgjsTgHmVIWDEvlvBmT14xDFkfb
	IFZuAWOKLtDzn3J9Y46B/E21OnzVsQw==
X-Google-Smtp-Source: AGHT+IFPp2niZTGpFKDrNsS7CI+ap+ZWijvSAa7tsQf23IyXH70abibRkZtQqq/cbVV6ywd7OGcKdOiVdovpm0P4dOg=
X-Received: by 2002:a05:6808:158c:b0:3e6:2408:6117 with SMTP id
 5614622812f47-3e7eb6d1494mr4926802b6e.13.1732144735198; Wed, 20 Nov 2024
 15:18:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Thu, 21 Nov 2024 00:18:19 +0100
Message-ID: <CAAvCNcDv9sts+bueJg0iTMjwTHrA8B2HDr4GRDpcOfFyrU=F9Q@mail.gmail.com>
Subject: NFSD server side COPY with sparse files?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

What will a NFSD server side COPY do with sparse files? Are holes preserved?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

