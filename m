Return-Path: <linux-nfs+bounces-1066-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2F482C848
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 01:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C024D1C21D94
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 00:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911D3184F;
	Sat, 13 Jan 2024 00:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZlmvoHa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F1E1847
	for <linux-nfs@vger.kernel.org>; Sat, 13 Jan 2024 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eac018059so8739029e87.0
        for <linux-nfs@vger.kernel.org>; Fri, 12 Jan 2024 16:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705105211; x=1705710011; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xAGMJ2SLEbAfZ8sNjpkERVDHz6F2LWLc7dSHTrShFpc=;
        b=PZlmvoHa/pLnA3BE/jzgk6AEQeDfK3AnzQ0mrNT/+BN36Q3bbDIh1XX353z8qwr6hD
         5lfeul6OhyG90rHXViGktxWYJk2p8slytnaa0YK0kPoOhYS2OqLiGcK8Y1jq8iW1lIeE
         uY1JWQbyJsck/yKBYIbG26YCdsmWPWuFnT1bDGOuf3Cy8jiq88R432/zdNlSsEoC6JR4
         y0AW2lGfazxIDbivxG2UrREdLPY2zdHtbvfxsazEF8GcnELUEIbKWNoOlcDkg8fs1vcr
         KFNphlnHQu/nwRFI549rgG24RtM27el3yv4lUEgBLZsrEdgvaF8doBd+ndB1WsleUxsH
         sc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705105211; x=1705710011;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xAGMJ2SLEbAfZ8sNjpkERVDHz6F2LWLc7dSHTrShFpc=;
        b=uLYRRUfHv6ztMU3r0zteB4ZRr6oQVghPpY/aRjWvLzLh7JZGfkRTRWQoDiDbrkeVXl
         eGXzBaFq37k6raagVkFqw+MZ5OKd2uaK6EIRZHRNcd2ClSQ2Nj06A2YRROp42dpvW8Rz
         zO4QpZe43EdIShkp2yt+6h8vVsG25tOyCTAtn40DIqUhLtlE9vm2CHYAG7B0Vv2uiwFY
         c+Xq0BiZ6+8ftEjO/v3lnO4PyI2Bi4ZcLZbZKMqJlrYS3r9s+YkvfbYYFcTVGZnFhl6k
         k2qDOLDT5je5YfZn1r/8e/NgybU78ZV0hFqEtQe56NiK2F2QBaYz0WuBWGXThJwngQNr
         O5sw==
X-Gm-Message-State: AOJu0Yye3x0wZs+4i7KhRoOjq1ZvmHhfY/Z1NfNyczJFeSI+dYigksDs
	qohK0uq/ECL8VrlazdH94ncNdLa6SV/8jxiD6m9cdeDWmGwSyw==
X-Google-Smtp-Source: AGHT+IHCHDyExFdlQ3kFy6Vywi1FqghdHjAGFDrRHXyeVTp79f+d9Wcpp7szO8LMofnBNWwFkJJmDgssgL/55/Dw6gI=
X-Received: by 2002:a05:6512:3d18:b0:50e:abe1:1c3c with SMTP id
 d24-20020a0565123d1800b0050eabe11c3cmr1195136lfv.98.1705105211467; Fri, 12
 Jan 2024 16:20:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Sat, 13 Jan 2024 01:19:45 +0100
Message-ID: <CAAvCNcDtTNDRvUVjUy4BE7eBCgmkb6hfkq3P0jaGDC=OXg0=6g@mail.gmail.com>
Subject: Increasing NFSD_MAX_OPS_PER_COMPOUND to 96
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

We've been experiencing significant nfsd performance problems with a
customer who has a deeply nested filesystem hierarchy, lots of
subdirs, some of them 60-80 dirs deep (!!), which leads to an
exponentially slowdown with nfsd accesses.

Some of the issues have been addressed by implementing a better
directory walker via multiple dir fds and openat() (instead of just
cwd+open()), but the nfsd side still was a pretty dramatic issue,
until we bumped #define NFSD_MAX_OPS_PER_COMPOUND in
linux-6.7/fs/nfsd/nfsd.h from 50 to 96. After that the nfsd side
behaved MUCH more performant.

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

