Return-Path: <linux-nfs+bounces-7749-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92869C1F0B
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 15:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879291F2413A
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEC61F12EE;
	Fri,  8 Nov 2024 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ipp-cas-cz.20230601.gappssmtp.com header.i=@ipp-cas-cz.20230601.gappssmtp.com header.b="QCku9CL5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852881E1312
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731075571; cv=none; b=ggsoxy9mz2KFMdpH/rtc1GXu7q4DcdEDVP//I/+08XNKl5tDtZ3/7r3qzuNir6hmvmAzyKqHIRU2XXkLAyCJYo84H2QlmIfhhRx5GR4fUFj7i8I4JEOI3VbEMgIRaZVNjO8/DOz5rejWYQ9HKIej9+B5PxBI4AoUQsghBHecrKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731075571; c=relaxed/simple;
	bh=ZOBBKhCAgQfZypE9Qev019A6ejzlc5LfsY+ZQZYp/tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=p9f5wItULxj8V3/4aML2RfOKfZBZ4RsD+DzFDPVbnMmSBu11H/jQaPNDX8enfztE23Wqol+gcUqOHkCBmWYcprhvV+BQAjng8dFDp+yomnzZnD2csUwRAi2uxKP6bSnQwnoe2/Zx2yI9XAAwDNQGiFE4aBj5Ctug8iz5bKTQijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ipp.cas.cz; spf=pass smtp.mailfrom=ipp.cas.cz; dkim=pass (2048-bit key) header.d=ipp-cas-cz.20230601.gappssmtp.com header.i=@ipp-cas-cz.20230601.gappssmtp.com header.b=QCku9CL5; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ipp.cas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ipp.cas.cz
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a6bcbd23c9so7923885ab.3
        for <linux-nfs@vger.kernel.org>; Fri, 08 Nov 2024 06:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ipp-cas-cz.20230601.gappssmtp.com; s=20230601; t=1731075567; x=1731680367; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+evRfRsjvv1GQoQC/uvCokIwFNB2EPVrtC3/4qmwMQQ=;
        b=QCku9CL56znxzAlLq1b140XmoOuceASPqe/fspXMqMUi2GHfFsuzvcIo6lXoM3kYDN
         2frTEX8Ms9LsinzP5QiW5FozkqDL/0FKOMV6pLWufY5zkeA/JQXNEqm2ZzpzyzJQHqcS
         /4Hjm6OICGTxVKm/Vbaw1g7kxI1wVfjKhh8RCPqepqBx9o4jVNnzllarB3e8IqMD1nV8
         CkBAWBq9e3naRdzOoTwbVyyEk2/S7Al8nLer8qsjc21jMNsoZ6UtHN9mx8F4JDSOIJxA
         /UsRP4T5s0odSQD/h3l7ADDC3B9xj62pXemfG8qC6P/Q0K0PTXI3DSwqWQW9IylgUYMN
         jDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731075567; x=1731680367;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+evRfRsjvv1GQoQC/uvCokIwFNB2EPVrtC3/4qmwMQQ=;
        b=jOwdUdnoKyHQDcANRaM+WrdtCcrXSGogBVDzJEDYwBw8C3B5hsggU6lHsiERm9L+Mf
         v+/ZnEJbmDRQZMuVpboUHdRpJ6wpwHuMqsLsYdvXW5Y6wdBXiJV69wmMdmrRTxWdfmJd
         zOplzuP9Da5TzxfqKKownRKqpybtk8qK0/tYrq0AhjO85o+bVcr+A6rTMQUcFPsBvObQ
         T5Ye7DAPzvbyGQNS4HWParuQhHN4lCKu7rDkFchYjculo1S3WDgobumx7vyaWO8R/cJG
         bT7C9uFcqigbavUMlFB+AGZFWv6gSq/8808elYFrLtcRPIudvSD672XMNYE48DicsTn1
         b9Rw==
X-Gm-Message-State: AOJu0Yw6Z4apIM9ehqQYWkMrOihxGCyCwvSBgjiajSQefBsEBARYUKwB
	4ISzHgm7RUarN/GeHH8AOidRgeRNMkUv0zhiTMU1D6itjYDSpxLglnwK0ZKxsePZX5b9HYvsNJL
	pg2yp0CYtzidu2m7BFzOJusm1+k5ofgnZm7mxwCUaK8Nd1GfHJag=
X-Google-Smtp-Source: AGHT+IG1GQXgs+LseVUg2Ld5IxEmXCRojKJXiFg9009wVgz0mAD0EA+rw1fLSwP9yf98v1e/3harXC55KaVapksFXnc=
X-Received: by 2002:a92:d8c8:0:b0:3a4:e99a:cffc with SMTP id
 e9e14a558f8ab-3a6f1a481a8mr31441805ab.20.1731075567402; Fri, 08 Nov 2024
 06:19:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMRTLeLopcFCVUE0-PLf7i066JF4oY4dcN+6hp5WwQi9P06khw@mail.gmail.com>
In-Reply-To: <CAMRTLeLopcFCVUE0-PLf7i066JF4oY4dcN+6hp5WwQi9P06khw@mail.gmail.com>
From: David Komanek <komanek@ipp.cas.cz>
Date: Fri, 8 Nov 2024 15:19:15 +0100
Message-ID: <CAMRTLeLRnEzYV=OQT3np49R4rA1-sXWzGrxxc4UX3muHiu3jmg@mail.gmail.com>
Subject: question to bug 93891 - NFS access not revoked on kdestroy
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear all,

I am encountering problems which seems to be the description of bug
93891 - NFS access not revoked on kdestroy,
https://bugzilla.kernel.org/show_bug.cgi?id=93891

Data shared over NFS in kerberos security mode are still accessible
after kdestroy is issued or kerberos ticket expires. Only
unmount+mount or server client reboot are working, which is not an
option in our environment (tons of shares, people sharing computers
etc.). Strangely, the bug seems to be very old and important, so I
would suppose it is already resolved and there is some configuration
option to solve this, which I am missing.

Host servers are Proxmox (equals roughly to Debian 12 for now, but
they have its own kernel versions) and Ubuntu 22/24 LTS, clients are
mostly Ubuntu 20/22/24 LTS, but tested also on Fedora 40, all have the
same problem. It makes no difference if I use gssproxy or the more
traditional way of kerberos support in NFS, if the kerberos cache is
in KCM or in files on disk, still the same.

Is there any recommendation how to overcome this ?

Thank you for any advice.

Sincerely,

  David Komanek

