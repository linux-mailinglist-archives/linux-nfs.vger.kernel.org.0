Return-Path: <linux-nfs+bounces-9114-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C156EA09C0E
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 20:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8575E3A30A0
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 19:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ADC214A80;
	Fri, 10 Jan 2025 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOV47hiF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC92D212B10
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736538612; cv=none; b=bkdSWWnYURxu8cqJi08vzT35eOko6PHFlUcVfJ2dM2e155QsBKOQD5529ZRNBRyZa76TxG7GheUavYmn9k8A+GrQTOAPRB+G1nI2C3ClGjrOWheKuWfHt4cSkruJTGMjxs4ARtkmSZ4k2akkIIVUsDxiYFu/3ADlmrRGvmzh0Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736538612; c=relaxed/simple;
	bh=akmv6jG9evAnGYZtRTa43likBrMDC1+t2oVD11t0kxA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=tei+RUiP92q9F0WMUYKvAEsVp3YEld49+77Pn904TvgvU0T7HN4beDikkoQyMLhnwOxJ03lqX0mxshoylHUbszAf1olqvd5BCFO+hk6lm2YEQToMjm3Eu2UlJmvAiuJQqaxLMrmc96tZQQ1mTePDbaEkABUB5dt4Spv6P9o9XVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOV47hiF; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so3877161a12.1
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 11:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736538609; x=1737143409; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OpuVC9t9AIT5+ABqm8Haww++uTE5F3Hn/z4RUhKj5Mg=;
        b=GOV47hiF8mzhLEUulMYXbLTY/5doPDW7YFiqd1YInT+qWmLdIx56n04rfSkmVwGzdU
         WoleS1FMvs46v2Wdt38rOCfL/YDzvdyr4pBV2457+DFI1RSHYVrjpVXrWm+CoIKynjT2
         LnE0VQPY1WqvC3qvy6m92BvQ6bnXAu8m5yglUCp+wETFvPniQG3D+LM078KjaF7A2j5x
         vv2NhbSQREqZdfTZuStEIW2zALWoY2l78K3Sx2VNiNj+OYIKEkqStJcb228yWMHrXvY8
         dNlU8bkTEA4l3Q/EpbEH65iZit0eVQNeK/urrkhNmeuvz9WI3dwpQOZaq+aVxqJXJj+b
         gquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736538609; x=1737143409;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OpuVC9t9AIT5+ABqm8Haww++uTE5F3Hn/z4RUhKj5Mg=;
        b=L3IfqJVSPOYmQWE2SQArM9hqGWxHBnn5YeGCNu0G2KmyhMzDedp4ZwoHD7D6lYUjDm
         jiFhHDaxwd1MuwZvaWyFCT75DQe6/s4JnAJc3mwICPU7SS664dHoQTi8HPyXqEAHKCF5
         z/fegyrBP3AC9gUI50A+qj7Mc9PxHSEe86c5BvOCmN9Y9eoOgDIgNgeIv5p81rXjQvtA
         6LSD0rfmI2twbTxziZLXdBGpxucNfahH0gF0pIuhb+15/ozNQ2eo9llqNiYSi3JGuKhM
         Uwdnse6go0Zl+/dvT918nTTamrpdp572U5mfBdA5KDyhhnoPT5ATjImCwDLRwRvOVS8G
         abVw==
X-Gm-Message-State: AOJu0Yyv9XhzZ67zhnocFo81ccdbuiPZTgC5b8RJgcJOfx1czqVR3DDT
	NeVe72Npa0ZBEuuxtjywhSaD5naHYKhCpBHTvz7qT2zjN9ntRnvTn5MnfKWlICMnUiivu57Tulb
	DhmHdLA12Q4DtG9doD+ERP0UHFusQ6B2XboE=
X-Gm-Gg: ASbGncuGdJKHZA0U8XScWu+YK8ss+7e9MVVWoryHVSurWgIgil0+4/avEfWSnrmynfG
	FPePoKf9pA8//bnoy0sF/YP8lUjUKrUaWkXML4DuT2l4OwtAgmp3B
X-Google-Smtp-Source: AGHT+IHiF799rlPpFYGNIFnFSY6Cj9Tdee8li1DQlKoIAd3FGnuQbBj4LpEQuKhNPeEty+qKxvC0FC06aTzflnEt38E=
X-Received: by 2002:a05:6402:4305:b0:5d0:8889:de02 with SMTP id
 4fb4d7f45d1cf-5d972e4c4f8mr11117020a12.22.1736538609041; Fri, 10 Jan 2025
 11:50:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rik Theys <rik.theys@gmail.com>
Date: Fri, 10 Jan 2025 20:49:57 +0100
X-Gm-Features: AbW1kvYu8I2sYWF3Jw9TOV4XrGOdpt8SByeE0IPyLOiozfDteHKxfnXQeReApWY
Message-ID: <CAPwv0JnSQ=hsmUMy0VY-8k+dANBLNkJdFJ75q9EEE+Hj0XXB8A@mail.gmail.com>
Subject: nfsd4 laundromat_main hung tasks
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Our Rocky 9 NFS server running the upstream 6.11.11 kernel is starting
to log the following hung task messages:

INFO: task kworker/u194:11:1677933 blocked for more than 215285 seconds.
      Tainted: G        W   E      6.11.11-1.el9.esat.x86_64 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u194:11 state:D stack:0     pid:1677933 tgid:1677933
ppid:2      flags:0x00004000
Workqueue: nfsd4 laundromat_main [nfsd]
Call Trace:
 <TASK>
 __schedule+0x21c/0x5d0
 ? preempt_count_add+0x47/0xa0
 schedule+0x26/0xa0
 nfsd4_shutdown_callback+0xea/0x120 [nfsd]
 ? __pfx_var_wake_function+0x10/0x10
 __destroy_client+0x1f0/0x290 [nfsd]
 nfs4_process_client_reaplist+0xa1/0x110 [nfsd]
 nfs4_laundromat+0x126/0x7a0 [nfsd]
 ? _raw_spin_unlock_irqrestore+0x23/0x40
 laundromat_main+0x16/0x40 [nfsd]
 process_one_work+0x179/0x390
 worker_thread+0x239/0x340
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xdb/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2d/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

If I read this correctly, it seems to be blocked on a callback
operation during shutdown of a client connection?

Is this a known issue that may be fixed in the 6.12.x kernel? Could
the following commit be relevant?

8dd91e8d31febf4d9cca3ae1bb4771d33ae7ee5a    nfsd: fix race between
laundromat and free_stateid

If I increase the hung_task_warnings sysctl and wait a few minutes,
the hung task message appears again, so the issue is still present on
the system. How can I debug which client is causing this issue?

Is there any other information I can provide?

Could this be related to the following thread:
https://lore.kernel.org/linux-nfs/Z2vNQ6HXfG_LqBQc@eldamar.lan/T/#u ?

I don't know if this is relevant but I've noticed that some clients
have multiple entries in the /proc/fs/nfsd/clients directory, so I
assume these clients are not cleaned up correctly?

For example:

clientid: 0x6d077c99675df2b3
address: "10.87.29.32:864"
status: confirmed
seconds from last renew: 0
name: "Linux NFSv4.2 betelgeuse.esat.kuleuven.be"
minor version: 2
Implementation domain: "kernel.org"
Implementation name: "Linux 4.18.0-553.32.1.el8_10.x86_64 #1 SMP Wed
Dec 11 16:33:48 UTC 2024 x86_64"
Implementation time: [0, 0]
callback state: UP
callback address: 10.87.29.32:0
admin-revoked states: 0
***
clientid: 0x6d0596d0675df2b3
address: "10.87.29.32:864"
status: courtesy
seconds from last renew: 2288446
name: "Linux NFSv4.2 betelgeuse.esat.kuleuven.be"
minor version: 2
Implementation domain: "kernel.org"
Implementation name: "Linux 4.18.0-553.32.1.el8_10.x86_64 #1 SMP Wed
Dec 11 16:33:48 UTC 2024 x86_64"
Implementation time: [0, 0]
callback state: UP
callback address: 10.87.29.32:0
admin-revoked states: 0

The first one has status confirmed and the second one "courtesy" with
a high "seconds from last renew". The address and port matches for
both client entries and the callback state is both UP.

For another client, there's a different output:

clientid: 0x6d078a79675df2b3
address: "10.33.130.34:864"
status: unconfirmed
seconds from last renew: 158910
name: "Linux NFSv4.2 bujarski.esat.kuleuven.be"
minor version: 2
Implementation domain: "kernel.org"
Implementation name: "Linux 5.14.0-503.19.1.el9_5.x86_64 #1 SMP
PREEMPT_DYNAMIC Thu Dec 19 12:55:03 UTC 2024 x86_64"
Implementation time: [0, 0]
callback state: UNKNOWN
callback address: (einval)
admin-revoked states: 0
***
clientid: 0x6d078a7a675df2b3
address: "10.33.130.34:864"
status: confirmed
seconds from last renew: 2
name: "Linux NFSv4.2 bujarski.esat.kuleuven.be"
minor version: 2
Implementation domain: "kernel.org"
Implementation name: "Linux 5.14.0-503.19.1.el9_5.x86_64 #1 SMP
PREEMPT_DYNAMIC Thu Dec 19 12:55:03 UTC 2024 x86_64"
Implementation time: [0, 0]
callback state: UP
callback address: 10.33.130.34:0
admin-revoked states: 0


Here the first status is unconfirmed and the callback state is UNKNOWN.

The clients are Rocky 8, Rocky 9 and Fedora 41 clients.

Regards,

Rik

