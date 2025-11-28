Return-Path: <linux-nfs+bounces-16776-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A34CC917B2
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 10:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140C03A320F
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 09:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220F83043DD;
	Fri, 28 Nov 2025 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCR8XIRs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC5C3043AF
	for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764322758; cv=none; b=b+qx7MjS4SiLTmZ6sQuNyExph6vJR2Z6uBP9iwJuL/ZfnIImGc6zPx9B1kWz8OTW/yDNM3BT/41KIwLNbncNReqGYCHuQrDUvrQbaNR3ekouiOkxLkbVfRyy9cjYvsaHKOD7zr8K3LvnuUlnh6lE7teL6OFlOyNxdJMmHhXWoT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764322758; c=relaxed/simple;
	bh=QGoe7bpvwUBKyllHXXABcQQNb69PB1NPTOvQmcnF1MI=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=kjTEZ4YTAXycUba2gHaNmfMwY1853WwBgI5rdDzYcV04fSegEB+WbQhX/qGJkW2oK+yK+50HZvkxaRbwp2UaksKAhD1aO1X6Q0ZKUEelfRqcZ5xICuJj2XRh+vzY0cPtuPhTEHTKA5PyuUnWbRXxprmusCj1yKBlQa24r4iJLq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCR8XIRs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso15294605e9.0
        for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 01:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764322754; x=1764927554; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiHDSmiCQI5WB1h3LtbG1fS0Nof7JDbbB+a7weTj31M=;
        b=jCR8XIRsqLSZqiZlIMYkW1DWBRCrdTmRuNWZYYT3+YjJ/4g34+lBRqP6jaEIV/khLm
         K59iIdVdgYp7VQo1hBSnIsU8wNOtmZCnUGX77kcwZm6HaQZgMh9IKo3aGikD+xwxsy/J
         KYOGcUwdMJBo5aedjPmg3E33XjAO+aFE3rsxYeGGdf8epECRCpIMCJ9DSXeVv/WTM/tu
         KxismLmLiSiCmIe+aYLkBCsRF/vE015SDDNq8co/VcLmN+F3aDDmVJcqR0tPqj6UYd7o
         +K6q1t/EaYhIs1Ir6IXTVIyDEe5Cksb2Ta7Po7vbJ5ZiZyGqFPcE+5SycmspKhKmhC3T
         g32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764322754; x=1764927554;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qiHDSmiCQI5WB1h3LtbG1fS0Nof7JDbbB+a7weTj31M=;
        b=TB61RxuOEIQFG2cWlSHe67QyGXwBtm2I3c5c3gOhoDzG2n458s6tzq5l8n+N4wqkId
         xeLa+19ocEXiNJc2LgFKwNtx2+xHRumwJDtfBGc5v4+WkDVRpy+QG2CyAuCmwLOuB3eu
         /Tr7l3R4jn57WK7jG2eYe5Lx+kr2tBsLAxUVy4eTPPB1hEYL2ZZaUyqmtIeSAVOsBKt/
         ieKpc7bou+fNXlk4WulaV8NJtw23aRejXekcXsyNo2Q1vGt3Lyz5RGYA4DYYiJQuwBlW
         BiWpB5oe+8zdmwgMUYBFq+O6E77AiyF1/2iaxdB4nQhI9eYFSY5d93a83vyBU7YbE2vw
         iMFQ==
X-Gm-Message-State: AOJu0YxXln8cJ6V4defooSf7zWtXDNT+rcrqWXpB+dE0guiiEPTVYJWE
	ZqGUmsYFukN0e0fmjx6wejOQmTnhaoj7SmbS7PSc4wqxSOfisbpjxWrbqJaQIw==
X-Gm-Gg: ASbGncsVQwu8UCNkp1fxNOqgVITOaUxtVO0CX/pYuvXyFmsEI9ANegLHz1yrZbQS+hO
	ehqNDtwmDb0DV2e44p9/JqNO929MKDluINBhVTX3DXdwaCaH1snuRFXhAMGwZ6Lra6BwTww9vdr
	dWDTbYmRlvliT0aPTDIbnXLMbj5jHRYGFjc4SFzAh8HvBXeiBePsNDuAhB651IdL3mo/1wk3jW6
	hASHnE9O+Qz2CZe1q32HFkHwlKM/JBYbIjXNtoj3xBiAlC/+NRfO2GdmX0BOIFwcB2pCbBozmuL
	lviWK4n5onEImlJ2xg/6fnzymwCb//mezRFi+YWY4+U+To5pbAq/zondba1Ygp3JmGbmAEuac2e
	yiFZ9dxRM5OnGMWJTYj20LRCTwny6JVGu4M2L+/72o6m6qac/mi655AEesho0/xPR9sLPMB/ybu
	sw9Cd7rpe6GB8BVPhYAJKYJzL1bg==
X-Google-Smtp-Source: AGHT+IGQR6v/iE8tZgZ0+8p4YY4VhqqaStXr2vqgzLISA6s+6CfqJQoW+SZ7hPEOc7xqzw2Pj0wF3g==
X-Received: by 2002:a05:600c:6d52:b0:475:dadd:c474 with SMTP id 5b1f17b1804b1-477b9ee479dmr192597785e9.10.1764322754243;
        Fri, 28 Nov 2025 01:39:14 -0800 (PST)
Received: from [10.161.254.11] (srv1-dide.ioa.sch.gr. [81.186.20.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791164ceecsm77069255e9.14.2025.11.28.01.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 01:39:13 -0800 (PST)
Message-ID: <cbd4d74d-21c4-42d6-9442-276fd98313ee@gmail.com>
Date: Fri, 28 Nov 2025 11:39:12 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, el-GR
From: Alkis Georgopoulos <alkisg@gmail.com>
To: linux-nfs@vger.kernel.org
Subject: NFS EACCES regression since 6.15.4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, up to the 6.15.2 mainline kernel, these commands correctly returned 
EROFS (Read-only file system):

/usr/lib/klibc/bin/nfsmount -o ro 192.168.67.1:/srv/ltsp /mnt
true <>/mnt/some-existing-file
bash: /mnt/some-existing-file: Read-only file system

Strace says the respective call and result is:
openat(AT_FDCWD, "/mnt/some-existing-file", O_RDWR|O_CREAT, 0666) = -1 
EROFS (Read-only file system)

Since 6.15.4 mainline kernel, they started incorrectly returning EACCES 
instead:

bash: /mnt/some-existing-file: Permission denied
openat(AT_FDCWD, "/mnt/some-existing-file", O_RDWR|O_CREAT, 0666) = -1 
EACCES (Permission denied)

This breaks for example the klibc losetup command, which in turn breaks 
e.g. netbooting in certain cases:

/usr/lib/klibc/bin/losetup -f /mnt/some-existing-file
Permission denied

Looking at https://kernel.ubuntu.com/mainline/v6.15.4/CHANGES, I wonder 
if it's related to this change:
nfs: clear SB_RDONLY before getting superblock

Thank you,
Alkis Georgopoulos


