Return-Path: <linux-nfs+bounces-11006-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8D2A7CA0B
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Apr 2025 18:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4115177334
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Apr 2025 16:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A00546447;
	Sat,  5 Apr 2025 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kogysCX1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A02E62A0
	for <linux-nfs@vger.kernel.org>; Sat,  5 Apr 2025 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743868907; cv=none; b=WJdycs5QoS8DfxFXcSCnTOKS4qY4vIysW/1rKYor3UNwJ2gtnCcIHQHg66KXZONZc5m4faSl5CMw06i3rnh5/sxHK4JZV5D6if1csyUeHWJqTlaZfyfemhjDJ9lNGm/tt2sOba86bCyL2MHJ6NrYDIzW0wbwZDOWC0cJ08KQ2Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743868907; c=relaxed/simple;
	bh=cxGK9uw6ETDAw+ta7S6aIz8E/91ziaXp7C802YNI85E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Qkoks6gluDLXNtkbWqORo4Jv2RxBuljM3LMMlgS9WQYGUGlTXcK4xgMoytOJJhZSAzd8Y44T8EPuplPZ/4t5hhsUFe3VbXigd8Ocs8CHXixKetrzhzdTT+ZS7Zso2xzf0bVtBADI73QPxPF9al+0KYjMhjZT5JbyrM26ImeQS/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kogysCX1; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6fd80f30ba5so21421187b3.3
        for <linux-nfs@vger.kernel.org>; Sat, 05 Apr 2025 09:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743868904; x=1744473704; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pP57VbULn5uOuMo3rpggyIg71D6KA0FsigGUEVVWpe0=;
        b=kogysCX1mVOBSaXixhV98KzhqdAFZYQxcPeLFTG3HvNhQ2f96aQVB3wQK2On9QWWi9
         YlUrpmKjK0SQ81TPrb7phffA4jTWiG3Xe2skqpfuLuJVGVNfb7nXk4Zy+yC0hNqWeFLP
         JXFAtmrZRxXHgw+AdxhJhHxZf8i1ltXNdf9sEfZ+owSstRig5y6lXn4V41Cl5h+cOxPX
         YSE+mrcdEdgGmqELKm1Glfdjf9O/YsbDfaCxnCPm/wvHrKY3Twg28BVHiJbsF/cifE3V
         lw21miux2YDuFKQnu1zsUxJr0w9ik7LoWC1kO47hipf0EUoSdEG9+MRotQoEi0fQnTjr
         DdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743868904; x=1744473704;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pP57VbULn5uOuMo3rpggyIg71D6KA0FsigGUEVVWpe0=;
        b=KUiQ9jAsgMCvFW1z3PfwA5DOK3y6dxu0OEiKpdZ+zWoLQTqh50IZuMUMBpwS9lXzDA
         7Fi3nhMIODKT3qACn2xCf/Z8Ac6KCN+ESFCSiARbYPfPRiWeRMf9dfd+T6wovRZd0uSI
         r6bObDbaffmo1WqLa3asKl4fY4ZgrWwTnqm5hgxbwpZcUtEyqF1TZHHBvi+FI+NJh0eA
         dBEZXXGXFehc9Jw5hnD42KwWN7i5ebBmktUkwTpKdquU5wnjIroLkIUT9RiA0mSCJ4Zw
         6VnZRXRPj/hGy5ZfT2FF+JNJ39Jl+WjeC1IyRALQc0qwzBuy1hmndAMSacyhQnmsUtE/
         xatA==
X-Gm-Message-State: AOJu0Yy6+94yTgV+6eP1MwHqd6A9n/UY1uyXKEDXE4ptLCIDSjAixlwm
	4VgFP6HymOqdEi47rArjZQu7oSkj4plmdohXgdl0e1Pay37Y7/hLWTEL8sBVLm0xnosjhkk9r1r
	uADAtrXnnGKRhvO+SxxmYXfkCFHW0tpDY
X-Gm-Gg: ASbGncsU4pxkgbuH5h7TPHTWy+fRuQ2MP01LcbGDpvd5koWg38dAdQYTDg6jJrqDHFz
	m9Grr0MJtiT6374PW9WRjYdGhCz2N83F1OS6E/cDGYOUz6vOcDr8ATsKjhQ1GRweeQIHjsjVGGF
	Z8ZBD83n1XpMIcK6Wh13MeiZ6SPvc=
X-Google-Smtp-Source: AGHT+IF4tF2Gy3OsEAJw2oAVM1ewGpp3it+VR5owLlecT+IH06meYQqpSWNjzuJvFHKsbgOLVKva55nhTaATY8iJ/oQ=
X-Received: by 2002:a05:690c:968f:b0:6f6:d0a8:8d65 with SMTP id
 00721157ae682-703e3311da6mr109154547b3.28.1743868904158; Sat, 05 Apr 2025
 09:01:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Sat, 5 Apr 2025 19:01:33 +0300
X-Gm-Features: ATxdqUE67pRJZgut6UOXN2pCEIu6ZYwDA_mm6DSBXQ9_pMCeIdK1P3czdLRyQhw
Message-ID: <CAAiJnjonH=+ah+f-NdWpAgZZ3mcFwGJdfLFnqydzOzG2bt_7cA@mail.gmail.com>
Subject: NFS client read bandwidth is not scaling up with nconnect value
 higher 4+
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

There is the file I can locally read in one thread ~55 GB/s,

[root@localhost anton]# fio --name=test --rw=read --bs=128k
--filename=/mnt/testfile --direct=1 --numjobs=1 --iodepth=64 --exitall
--group_reporting --ioengine=io_uring --runtime=30 --time_based
test: (g=0): rw=read, bs=(R) 128KiB-128KiB, (W) 128KiB-128KiB, (T)
128KiB-128KiB, ioengine=io_uring, iodepth=64
fio-3.39-31-gc283
Starting 1 process
Jobs: 1 (f=1): [R(1)][100.0%][r=51.6GiB/s][r=422k IOPS][eta 00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=19114: Sat Apr  5 18:52:55 2025
  read: IOPS=423k, BW=51.7GiB/s (55.5GB/s)(1551GiB/30001msec)

I exported the file to the NFS client (hw exactly the same as NFS
server), which is directly connected using 200 Gbps ConnectX-7 and 2m
DAC cable.

Without nconnect option, reading in exactly the same way as locally I got 4GB/s
With nconnect=2, 8GB/s
With nconnect=4, 15GB/s
With nconnect=6, 15.5 GB/s
With nconnect=8, 15.8 GB/s

Why it doesn't scales up to 23-24 GB/s with increasing number of nconnect=4+ ?

