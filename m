Return-Path: <linux-nfs+bounces-2135-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FD486DF95
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 11:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480821C20A82
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 10:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DA76AF86;
	Fri,  1 Mar 2024 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="qanMwY/F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031566AF85
	for <linux-nfs@vger.kernel.org>; Fri,  1 Mar 2024 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709290040; cv=none; b=RsKMVKxw0vIL4xIUBAdjsT4H8hMLUcW4TgMShYBka4U+c17vv1BRbT8eOCeK1Zv9Q9FOhcG2OlmzLCtwAOldAM4ize5WD8hNUDNtT0NnYinO66NU/P3YvuV5RnNqtLsbpHo91aLWhqomIKUj1jYCv4QRlR6cJUZb9BJ3DXBHqKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709290040; c=relaxed/simple;
	bh=lgjH0vybG+2dZIZTV+Z00tWWhM6L4Mi0RmCLNXz/+cM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fHUEwJrVXUaSn45XduViLG5Tv9y0c4DSGaBMzVYxUxhoPLzKUf/oUNT/uDkuJtLmcocnVLZjPlM+6PnMZnJBtZMuQrjj3muF2D1DqBYZ0AUU/1qE0X/tfn4an76tRa3lRKU8Lqud6AahtetjThGq4DSEbmAuE0mzdgEAU/UbB+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=qanMwY/F; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5131316693cso2448929e87.0
        for <linux-nfs@vger.kernel.org>; Fri, 01 Mar 2024 02:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1709290035; x=1709894835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CfJ2KS24rEdBsZqlOQ6DJ4IFgaHHDDyOXYJoRN5bBg0=;
        b=qanMwY/FEgZMGnWJ9OvXD4z3CwZV3lhopEKTMFy/e9AEIg3s5Qgl+NKItAH2tS2Hc9
         yl99fL+/tWHcyHmxOl+f35s3WkS1jWoaO/s3uK+Hh2PNeud1WEN9QHZmBcD01+hBjJxT
         X3EvhnW2g9KF0ae5f82WcB7plZGUoKT3G4u9FF0dptEnI+vx1tqgbVFzkVekk9VDp4n1
         7lfdBPmUQbg/DYdMxgTinz4ufoKd8RUu+pykO/LupKlloIEO8vswTK/pjTDpI/a4KvHS
         +jdciElMDTKHVKoPbQo7zjR3CaLSikoSVyZxIgnRzFtuKlDllyWKCPWtrBgbunMwWVTa
         fK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709290035; x=1709894835;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CfJ2KS24rEdBsZqlOQ6DJ4IFgaHHDDyOXYJoRN5bBg0=;
        b=AUMyLs3U3nNs5jDXcKVTtKkB+fd+lG8+HhDKLSvIYgHpswo2DSLo5B4ABOpA7+Jr/p
         iUqVdWoAhAv1vdUIr5nyPyC1v9SwqKLE2GZoXPLhjLdIaK5vUnRA0X1CEm6FhG0XeB+M
         8i004Ts9yBMQiZriLDAfSVZbso5cdf+FKsMrfvkrDqXsNvgmkYhseTIdAuYRhbIAv4PC
         Q9y0eA36fLBL5fjvz9zHjPbGq4seslq6jgJWdvgfNaOBOtqmAQrQBtjR1SPlBM6nq3ee
         yfMr6dQA+C4fEukJkZcR2GvUXH5FdeIsQzSIMhLukMsre+u8AXGAGomwcJknkLSDCuY0
         ifHw==
X-Gm-Message-State: AOJu0YxEq1DklPgw056XR0KeyYt+tDrsPDidpXWgR/0C3Op7W3StG3oD
	M6mJL2xIAj1KKcGtgAi5koVUNmJdtZdXMNIVzehTqF4gm8G7PJTzE70SBReFc9xVrYIWQfZnD0o
	O2yE/cyYauR9dNJu2cnuO6AxhveUI8kmtgkvZx5673gj0REQgTVSXBDdI8rI=
X-Google-Smtp-Source: AGHT+IEGwBC4rQTlZpTS8BUCycJ+ZxSl03QAMaxR8Hb8fLGMAks1M0ONW9UGU7JGCSOtM6+K1ijU2uaSw9N87cenrwI=
X-Received: by 2002:a19:ca43:0:b0:512:dc21:d89c with SMTP id
 h3-20020a19ca43000000b00512dc21d89cmr810971lfj.38.1709290034642; Fri, 01 Mar
 2024 02:47:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhitao Li <zhitao.li@smartx.com>
Date: Fri, 1 Mar 2024 18:47:01 +0800
Message-ID: <CAPKjjnqJZnZb3ja_HgzF7Qzxppnt5E5bsLgL5JzRjw0uDvvVTw@mail.gmail.com>
Subject: Problem: nfstest_cache acdirmin_data/acdirmax_data failures [nfstest] [NFS]
To: mora@netapp.com
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, mora,

I'm using NFSTest, which helps us a lot.

I met with failures when running nfstest_cache in cases
"acdirmin_data" and "acdirmax_data". The error message is as follows:
 FAIL: Directory listing should have not changed at t=0
 FAIL: Directory listing should have not changed just before acdirmin
 PASS: Directory listing should have changed just after acdirmin

My environment is as follows:
1. Linux kernel for NFS client: v6.7.0
2. NFSTest version: 3.2
3. Test command: nfstest_cache --client xxx --server xxx --export /ns1
--nfsversion=3 -m /mnt/test --datadir=data --runtest=acdirmin_data


Both above cases have the same pattern:
1. Client 1: List some directory.
2. Client 2: add new dentry by mkdir() to the directory
3. Client 1: List the directory.

The cases expect that Client 1 will use directory dentries cache in
Step 1, and will not see the new dentry created by Step 2.  After some
time, client 1 will sync with the NFS server, and see the new dentry.

However, in my environment, client 1 can see the new dentry at once
after client 2 mkdir().  It seems that  the NFS client can check if
the directory has changed and get the latest entries.


Could you give me some help?  BTW, is there any instructions I can
follow to make some contributions?

Looking forward to your early reply.

Best regards,
Zhitao Li.

