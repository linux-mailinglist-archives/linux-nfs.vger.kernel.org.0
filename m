Return-Path: <linux-nfs+bounces-15998-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8052DC312D1
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 14:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C414A4299BF
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 13:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6782FB601;
	Tue,  4 Nov 2025 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhQ5blmH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3102FB0BA
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261853; cv=none; b=m1UDU5havSVem1YH1s7ZoT5hM48j9iGaa2BpjPQo+9AjNvFvCSJ8ryWc4B3BJ1vdr8AgNM58CgeJ5OMAPhRlwMlogr5v1GJVc10y2soYozxvxZ33FgmUO+kbQO2Q4qQ9OpFNiAk4BZlnUfX30h1Q24LSy2aJJBWOOOox9fBpgI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261853; c=relaxed/simple;
	bh=dUxxAO0QHnrbZ3YDn9edxM2rCRLNWgzc41n+qTO+Omg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kCOR97Rm7JdJPaXfU1gsEN3GYDSj6DJKBf2TA3EjhHiQDms57hDUPVDsK6oiA4ddyzGFQZv2FV+mrb3lW/GuViBUUS5OY/aHNy2wgRwXi3lt5sr1bb5oyGLccctLu87je2FXdzor5Wc7iyluk9RG59lkFBndVXpVwrXXpm+MI+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhQ5blmH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7260fc0f1aso5370666b.3
        for <linux-nfs@vger.kernel.org>; Tue, 04 Nov 2025 05:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762261850; x=1762866650; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZXFcDmYNHJqtBXd/NuqfPykMueHMHq35KEgQDymwqfM=;
        b=lhQ5blmHboP7QeBP2SnewwmMbre5nx3Pw3fr0BeOvWURZAy6iTc8ybUkzSSPYvQxZM
         Vyq9XdmROGJKlXxcplKYt6Nfo2dzKrFtOqbdQWdzpuLPPOLZJvvtXjDBhh8oYt0kqzHD
         +Yku64b+F8llXivPqRL5F/bWFc6rAQt6rTDZCxSg/uClmeGqI9Wr4cQnkvQgTke7Cg+6
         YdYJxPs92zXHSVvOEs/cyhLcPBJLKgiivD+VzqS31eYvm0zLxxRwIczFDVg+RQsHy+Sn
         0PFKnblXsB5t50cOsTstb5323LAlSYeeJKSBi4fvOdIvvDyF1Yv28BeRciQJJCVmA1WN
         U24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762261850; x=1762866650;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZXFcDmYNHJqtBXd/NuqfPykMueHMHq35KEgQDymwqfM=;
        b=XKmdYcUO0zv7Fj3hjUfqunkMV3vI/oPORqgzP7isUMDef1RxIQrVaZVyDWxtjNjPSU
         TqUdQQGF5tskI6ll1uoev8sFiRswjQCTQpJDAKD9R62Qep7WiuMF/3IgazWJfBQitioy
         MjmGs40by2yhFZuXQ7YPtwi36VoD8rkOUplywrUKqfgiC4pvsUV81gR63PWD4GAljWVK
         ftUywfI/6bMacuUFJS+vgjD3DgNHo6WQVg0gPsNVpTNs/cn7WK+/tMDGXf2GjiTDbR10
         HsL8mmAopXRWp859iWrwer+rk732Y/A+utXzk8DLEhgWgAbAH09oA+vmrcwUnl/K5qog
         NDQw==
X-Forwarded-Encrypted: i=1; AJvYcCU9eN0ehO05T6aw4knCI5v3Clh9vNqHJi/WTX+P4tQcyjMZZ0zfGREDLJHqZq3wKmMsNC2705yHcho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzmIgamNXCrC8LE+diyd80MSC5LV6dayS8AemcgvV7+py/JZob
	ig/e4Mmiy6pnl8QqwPskz9ctERWUebjT9gd4anz4V2NYuQ5lfMcoTWGC5BUX8O0s+rp4DyPFkI7
	wFcYRz9HmNJQyMAHgJsQSooJNMTw/KBU=
X-Gm-Gg: ASbGncsJ4RcVGvpHX8kVzL0hFOrnYS3w5/TDs2g6QqkYAdn/5eqBcKeMtPcOmmwFRSI
	ICNFf0lzeFaNHASAvqF3tmeeYLXA6E+MEdpk3rTB1vv8I2P8t3gXXbXXc5bSVflKg7ot7v6Ymke
	ml9RxrD3VKNpbwMLSjJk7ZjmS3jgcvVGEtvnc10hvD3BU17izK79zxbIjDu6VmXtfwTicnU5OU8
	DKQEIdzOKp6FYPFnRk9Z5HtXO6bHyg+7Z9iKpu6rTJS/KLp3LiVREzHLClWETTm+Ly+EIat
X-Google-Smtp-Source: AGHT+IFPpjou2I9ZXhfJ/t0a0U/cQf7iTzVFddHwEAupEHT51/VutkE118c+AeuKHj727Dpbkkc9rI8zkTsLccWk/+g=
X-Received: by 2002:a17:906:9c83:b0:b41:c892:2c70 with SMTP id
 a640c23a62f3a-b707073270emr1521809866b.49.1762261849729; Tue, 04 Nov 2025
 05:10:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Tue, 4 Nov 2025 15:10:39 +0200
X-Gm-Features: AWmQ_bmk7aHXHdoHbssIYaJdyqSlInLd6vt3MqCxcbxD6E0383bKyicrzi3jRCE
Message-ID: <CAAiJnjrMTT=ay-npg7VEb+ViKSSHVdi18GzEWEjpQgCR7KCcdg@mail.gmail.com>
Subject: [PATCH v2] svcrdma: Increase the server's default RPC/RDMA credit grant
To: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

I compiled kernel 6.18-rc4 with the patch for both NFS server and client.

I don't see bandwidth GB/s improvements performing sequential reads
from a single NFS client with a single fio job.

[root@memverge3 anton]# numactl --cpunodebind=1 fio --name=test
--rw=read --bs=1024k --filename=/mnt1/testfile --numjobs=1
--iodepth=64 --exitall --group_reporting --ioengine=io_uring
--runtime=20 --time_based --direct=1
test: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T)
1024KiB-1024KiB, ioengine=io_uring, iodepth=64
fio-3.41-39-g9f87c
Starting 1 process
Jobs: 1 (f=1): [R(1)][100.0%][r=18.1GiB/s][r=18.5k IOPS][eta 00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=24639: Tue Nov  4 14:56:29 2025
  read: IOPS=18.7k, BW=18.3GiB/s (19.6GB/s)(366GiB/20004msec)
    slat (nsec): min=200, max=33701, avg=668.32, stdev=247.49
    clat (usec): min=1143, max=7054, avg=3415.93, stdev=173.65
     lat (usec): min=1143, max=7055, avg=3416.60, stdev=173.66

The same GB/s as without applying the patch.

[root@memverge3 anton]# mount -v|grep mnt1
1.1.1.4:/mnt on /mnt1 type nfs
(rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=rdma,nconnect=8,port=20049,timeo=600,retrans=2,sec=sys,mountaddr=1.1.1.4,mountvers=3,mountproto=tcp,local_lock=none,addr=1.1.1.4)
[root@memverge3 anton]#

All I need is to apply the patch, compile and boot kernel, or I missed
something ?

Anton

