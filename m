Return-Path: <linux-nfs+bounces-7118-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1025F99BBCF
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Oct 2024 22:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237B91C20C92
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Oct 2024 20:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8A714F9E2;
	Sun, 13 Oct 2024 20:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="siip4Rmw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567DC147C9B
	for <linux-nfs@vger.kernel.org>; Sun, 13 Oct 2024 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728852815; cv=none; b=lqNnekgBtf+Rl9uAztW8GOvtOliDCUviIfu/UcaQBgVfZKgIxm/BgY8h7Sabmu6dCekfMwcDAV3zEacX5f3BlWHif7jrg3rsaoY7+NR5eEQWb1qpG3IlG0HECyF6G1C4m+zdRTm7t2GJ3/r3T/jiBV4FRQoB4QhfF4Pt6PueM4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728852815; c=relaxed/simple;
	bh=2IcaxRsCZu1Weo0t3+AVfcXRdGrBjE6IgF1kYYjiVfU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EdNhHZCBgheMvRTJDSUFCKbaWH1qlDLT98vS9M08nkOKcfr3m4hY4HCZ0hrRhx00JvaCjBs/ljuXAUl5s39dL1jU2R1viLCxKekIlhtqpY5qgCdPk8QFS07FQ2cMyxuNBiRqUgqPNCkmxSo4p1f2McFcNS9PNlsUMTbKgi+bvn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=siip4Rmw; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e5130832aso644431b3a.0
        for <linux-nfs@vger.kernel.org>; Sun, 13 Oct 2024 13:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728852813; x=1729457613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tW/oVLxMGVp293pF30Jw4BkfUNSmxaGcYjy7Hqe9zSo=;
        b=siip4RmwMjZU+1aLa2isf62iO/PUxAwUMitbswzRhZl2Wm7XYbwBvEh6ghMlcy6HX0
         p+CHV9a4l3LBJGOOL0WnlPho23AAtQnHgS2Egs/1i4dhSOLSR4lTYtnxZdh/f1gACW0C
         ted3/v4g17PBHA23o1DTxlg6pv4wVCpE4LyBiV1Z6YxKet6/UjfejzmomLunSs/tu24d
         mnPJXlbSM7njM2Kc2kACuGTkhqiXK2bkGXZq3XtcBho3son8FAGEAL1Qa595sI2FcFBw
         xwRDsZlaG63VF2oSnxMzM9arpzlFZzSf0qVTcb7f20qTdWlqtdburfnUf8zM2iXINQ4Q
         Ieew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728852813; x=1729457613;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tW/oVLxMGVp293pF30Jw4BkfUNSmxaGcYjy7Hqe9zSo=;
        b=oN2T8qNkhmPICgUbeqwLi3roH95Ai5+42dq0o1vJkFuiRhESE9IJi5rNpaC/rS+qVe
         utu7vX7skvKwnzx7BzIYVMdAHuF2KV5btyNtcqtIcWU+AigTqDX3byTeiTCBx4BpPrrd
         S/bX4KMMCaQUJLmJdHSMgpADyFfBbdvjTv158VMRfMu0mxv4BOnoATSfccYiIMX6r0Yu
         jYsVQQvD+GpVkAP9rJCriylYhdkRWleXmOq+juFPROL7/idiAGrL4vstYsmLTR4UOC1d
         IuA/n3+c5e44CV0doNP8X843j4CsGf+RVru7mjlrpLxZw5VhyYw8u5D80Cc0WafjuB3j
         ApZg==
X-Gm-Message-State: AOJu0YwJByJ8bIL9PSpD2S/qff+/DXmNT8B3JBeSklredoNOPMpGNI3b
	I6L1OFaTKr9hv9GImYama/vUCcQXrcrErgZFFNXvsQaipCwpNi3ibEAqmESD/WI=
X-Google-Smtp-Source: AGHT+IGeHW/T1utnJaL2THMthWNT/SlEE9KTreIWsQr33pvF5db22afBNXHDL1azWfd6tDGW/vbLCA==
X-Received: by 2002:a05:6a00:1391:b0:71e:ba5:820e with SMTP id d2e1a72fcca58-71e4c1dcd95mr9404250b3a.27.1728852812746;
        Sun, 13 Oct 2024 13:53:32 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e48bcfe81sm3815287b3a.66.2024.10.13.13.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 13:53:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-nfs@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, vbabka@suse.cz, paulmck@kernel.org, 
 Tom Talpey <tom@talpey.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Olga Kornievskaia <okorniev@redhat.com>, Neil Brown <neilb@suse.de>, 
 linux-can@vger.kernel.org, bridge@lists.linux.dev, 
 b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, 
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org, ecryptfs@vger.kernel.org, 
 linux-block@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
In-Reply-To: <20241013201704.49576-1-Julia.Lawall@inria.fr>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
Subject: Re: (subset) [PATCH 00/17] replace call_rcu by kfree_rcu for
 simple kmem_cache_free callback
Message-Id: <172885281086.338120.2063739137198887833.b4-ty@kernel.dk>
Date: Sun, 13 Oct 2024 14:53:30 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sun, 13 Oct 2024 22:16:47 +0200, Julia Lawall wrote:
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.
> 
> The changes were done using the following Coccinelle semantic patch.
> This semantic patch is designed to ignore cases where the callback
> function is used in another way.
> 
> [...]

Applied, thanks!

[09/17] block: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
        commit: 7a9b197adbafa9d6d1a79a0633607b78b1adef82

Best regards,
-- 
Jens Axboe




