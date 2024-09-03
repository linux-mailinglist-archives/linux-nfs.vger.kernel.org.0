Return-Path: <linux-nfs+bounces-6173-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C95F296A856
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2024 22:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0838E1C20896
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2024 20:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D6F1DC744;
	Tue,  3 Sep 2024 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVfEnwas"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC301DC732
	for <linux-nfs@vger.kernel.org>; Tue,  3 Sep 2024 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395551; cv=none; b=hAAmzzHdaXqjt+GtmpeP0LZstgbuCjH9+IzsKLcJQiOzUw/V4/oU1uGnz2VUjsED2fS1h+e2JANC72K/ntmAbjthrRuNWF5AiOs3ZbU9OFkB/9NZl3NunItJymX41yw2Ug/Gb1t3yY2Z6mlzBz7iP7yV0/uljCbXnCbyoMlIM04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395551; c=relaxed/simple;
	bh=q15csQxfWKOVS4VhlJ9grPjwtqHRpBh3AYhtgWPvRt8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qx+UH96mVWbnVqQEbkjnfglwyyKTLSFanjR98R4IQSCJJUFDv3g3t3sNonYA5B0OL0mFuSzmh2K4XkeulmCBNln8KyA2MwbgHKENSXS0/M7i9UASxcFeBB1rMehc9Zmpfy18V31XTFUMMgVu1x0vYuS+vjkmcJCsD8bRBvxPkB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVfEnwas; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2068acc8b98so434975ad.3
        for <linux-nfs@vger.kernel.org>; Tue, 03 Sep 2024 13:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725395549; x=1726000349; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q15csQxfWKOVS4VhlJ9grPjwtqHRpBh3AYhtgWPvRt8=;
        b=BVfEnwas9VbfGAtgM7LiLq0nHtkkAPkk1wf2I95ENRlUXZ5ITEVf2nBcSKfqya8sxu
         KNc4kyUZg1MySeuodkkcw055+7lRii6wa81RcjKqs0EuYVJMZhTHOScFJBqVXEDpgK3Y
         DcpS46eg328LRBw4RoP1ukpCP9hnsgdoN1rhwAOYkJj2UoY9qVq3f+zJibvHKQmIOj75
         TUhKG29pWtaDRcJ6b8BLDxgJ8tuFmMnJLSctmmkmtk7dv2effpy8ksE2E5AirX2yB/5M
         darRQpZGRKXtx2bs0sVF9BQuZ1OaNdHV83t6C9+CzglY4rkhvgiNOjshvuvmkvLeMyxZ
         SjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725395549; x=1726000349;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q15csQxfWKOVS4VhlJ9grPjwtqHRpBh3AYhtgWPvRt8=;
        b=hnNwCgpEZ41aJrKlzgl/KZzQWGBmkB1iWV96tnweNGL82tkSoL8DPEQPw2VJ9pJE5c
         tgBj46e/ulqbeG+3VYMutcdzTLe6i4z4il3iEDBvMc5hNrw/opTgXYxBd6AYVb8Na5Nq
         NDdVVno+nKwnvpS4pSCEK8xprrhPeGhTFCVScRyppbXac3vOlJd40Wu2L1x9Fn2b32GD
         Wdz8MLptioOaDi/2dXXcM67PiynS7gTot7g22roLG2hYlqB8bu3ft8d3BQesva/CKPm9
         dUbjod++GLs1xM3yS3PQTFW5RMh+R46yvzDWuPoGtYLAU1ON1wzzvaNEbblYP+9trb3M
         HPtw==
X-Gm-Message-State: AOJu0YyYLYsFKTMHUiR8CJaXcnubShN52hwQ/1JBQYAxaMmG4gPyIXX0
	KK95b/iTnY6/WXzNeA1MhaLdu/CnzLoAFWzEO7a4+mTsO5GnUySIlyITa6DTsw6DRfxeFl0DZfm
	rXIKbCwIyqHyILU9FqorTZ+xk0Cn5uwo=
X-Google-Smtp-Source: AGHT+IFBWRQkrPfzZgaoZ7o+7WQ3EeJIPMsfCNh7TNnRPp074G/chq3bre3RqTX67XDWkuSGLkaL+U0aL41+ALqv1GQ=
X-Received: by 2002:a17:903:2285:b0:205:4e4a:72c6 with SMTP id
 d9443c01a7336-2054e4a79bdmr108923115ad.5.1725395548859; Tue, 03 Sep 2024
 13:32:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 3 Sep 2024 13:32:18 -0700
Message-ID: <CAM5tNy7SQuiAb7ieDsJ2vNGb5mw=zvMYaeu+Q14cJf-YZgrD_g@mail.gmail.com>
Subject: How big can an array be on a kernel stack?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Subject line says it all. As a newbie to the Linux
kernel, I am wondering if an array of 70 pointers
is too big for the kernel stack?
(I assumed it is and kmalloc_array()d it, but thought
I'd check.)

Thanks for any comments, rick

