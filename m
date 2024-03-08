Return-Path: <linux-nfs+bounces-2239-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2CF875C34
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Mar 2024 03:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24871B21265
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Mar 2024 02:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A4722638;
	Fri,  8 Mar 2024 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6dAnG5b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F60963C1
	for <linux-nfs@vger.kernel.org>; Fri,  8 Mar 2024 02:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709863403; cv=none; b=l2LoBoQs/MQDkH4SkKWPzFnzix5gcbiJw1b865XCv3od0vq+U683af2W+ACAP4TXuKvwVyjoST+cGVQeDbWse2LJs1XGqKPYlgVDbWgnLxDcxzlBpl+k4kgUdYwomrV/kTi0Rk1gcq6W8D8UcV4Vz9CaJLSaJRCJFy0rOFLodcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709863403; c=relaxed/simple;
	bh=2CIQDglniWXQzl2elcQq5O4pNCWFbdrNEouTgMA8Kf8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XcrLUwFhUzTzR4LiSaLQhBNKOTuccle78PF5d97PYR/ConcUKKqaAhu9FefdKwEQVn13NitWmc21mxSe5pbfDi7xQZ3M9DLTXkpF5ivCk9eNFT6bmyyzjJJ6xOQ7AEumCbTqZYSd8UyCZ8J4vemxd1tTOGdnxaeAxhaGYtGnzHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6dAnG5b; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d220e39907so22157391fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 07 Mar 2024 18:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709863400; x=1710468200; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=38rM7KdqBKjm9hyyA7LQfni4ynFU45Q7NaUG16scUF0=;
        b=h6dAnG5bY+OijjQg7quLmdF1xkaaY1u7mOIrWcbyMeBBVnP13cBZVSoOGYVzSWf729
         oqUOVujqEA4Z34AuIRMxjJ4aCrw16gLD837iIjdp5nC+BJM1cpr4JrC1LwevhTWq2S1G
         3XKf16G6LbnN45xv9kI5y7SsP5b/Gt82qP2N1ra01o6hJF8ufSg9CJF7XMHyRBK9z/SI
         B+1D6k8vHK1h7hUfpSRmzkBBK1ZZBSFz8SrFqgnCCU5YcW1OxySFZUNKwGtBUHXSIsXE
         IGrdnmLlEDwau8Yz7DFB/6M9VG5qDdeQojbdGUO5/BSriPFDid3Q9etuifr9agRlYWLT
         z77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709863400; x=1710468200;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=38rM7KdqBKjm9hyyA7LQfni4ynFU45Q7NaUG16scUF0=;
        b=DjozdJz2MRLKH+n4MDWNNNDAPNW1TaTpwIc4+yqjQZvkCgds+1UxPl6xW+kcVsEQrW
         5ukWBuBjP6Wl0R4qham/i3/qLgSKZNns5hELCcI0tml1YMQCrdU+bZ0k5enQ2kXGofyG
         NtCAT6jDwab4nPjcIf48C/YjLZFZfMSSJP8nqmpmJkNG1WkMy9NctpLt0+8vylxFpyAm
         5lO9Ku2B5KSt8zfwWELTvX6iqqphd/vpgGtgE9EyXffIEUxkym8b6npW9Sg5mSQaQFuS
         Cem3mC+cItzhj0jb6r4IkTw82e2DpqmJHG1onDdgu4dG1KsiTHNBjtps+OL301M1R951
         lsSQ==
X-Gm-Message-State: AOJu0Yy5pGLapwQyaN/kz9mIs0GNepveHcumOYWZHkVgzLgkF7QkRDQ7
	dVHq/VM/ga3Se2/5dOJys07mpuyNjpx2VN3KmoqM13yCPzfWJoTqWww9yzXDxF9IY9jOOAMME1o
	6F+t26PtZlWe3YJG6FjFU3FLgGsBD2zs+aRQ=
X-Google-Smtp-Source: AGHT+IFjv5qnc/rl4Pb0himIL5xy99Ktr4ETJ7zB7gF57trbml2Wyt/PYl82NcHvsQZXOlGPkO47RU3+6JYh3n3Vx1s=
X-Received: by 2002:a2e:3613:0:b0:2d4:e03:b52c with SMTP id
 d19-20020a2e3613000000b002d40e03b52cmr2219210lja.50.1709863399752; Thu, 07
 Mar 2024 18:03:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Fri, 8 Mar 2024 03:02:53 +0100
Message-ID: <CAAvCNcBbaj8CPoH+xYWtebscJEJ=YeByGpnwYJOaXqr1xk+B2A@mail.gmail.com>
Subject: Running nfsd as SCHED_FIXED, SCHED_RR?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

As part of an experiment to reduce NFSv4 server latency we want to run
nfsd with SCHED_FIXED and SCHED_RR. While Debian has a "nice" value in
/etc/default/nfs-kernel-server, there are no controls for the
scheduler class or IO scheduler class

Is it actually possible to put all nfsd threads into the SCHED_FIXED
or SCHED_RR scheduler classes? Can I use ionice for nfsd?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

