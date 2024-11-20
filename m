Return-Path: <linux-nfs+bounces-8169-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EA79D4493
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 00:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFAD62832F8
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 23:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E661197A68;
	Wed, 20 Nov 2024 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZflk9w7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA25213BAF1
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732145690; cv=none; b=Yi/QheSE3q/QgHX8BHytuV5vjCwE7XuAg/FM0Aqowbm1HuzeaGMEV7FPQyJ2lYo82CS6rnMh9V9Ec2zJDOzc+s26QSBxu0xUeLV/E/dbVuQIZUQoOA9BSMHBZ043msn4RcXfUKu+kZYE/74JkUjo4fkYlSL3fAqgtRkYFCt6xdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732145690; c=relaxed/simple;
	bh=90OO0roAq1vSKDIou5DJAW6i1mX1sVXgL72EFojSkfA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kBqC+AnGl1MDQueb/SVTZ3oDDaVbBWsQwunGFvEz65HIzFHIV2SCBmQ41A71IS9FONvXNSxsaBuEpvewnZT4QLLvV8HkkCaM1i0PoOBns7R32H8u5bTh+ozNOo/mpFkpq3sDkS8ypOYSfjxo8GimPihuRC8FKcemqtOmerOsgDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZflk9w7; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e5fa17a79dso236026b6e.1
        for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 15:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732145687; x=1732750487; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e88PnxIjnvAMjYS7C909Z2P1bWhFo8k2X+rqxAuGSJc=;
        b=cZflk9w72fOtvWE1pMtPSpJfoGu9SHpRsp/+/+zrswvZq8JRKdbauaIRlzQa5ojM49
         Rxg27Ygy/cmfvOTnQe3HnBWO89p0ObYL+pnmZGWk7e2I0XWm2HY4W1QOWXqi6T9ieH1q
         xNZnIBCdiGJjJZVhsbYy72nYU+HGJMN0CiPEUy+H8ZKXh0fklw1FBtpXuvXeapQBNY2U
         DZl/uqrfkGbJbc7v0S6wDwMu1n8oKnXS5KlbFOl3lI2EUDyUboJIJpbaCdgguOgMZxyX
         DCNvoNPsE3DTOcTmXGb75YH8hATfVU4TGqvnWb8zV+S3ZEE2weDMzr362XYbpq/xaF0j
         kj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732145687; x=1732750487;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e88PnxIjnvAMjYS7C909Z2P1bWhFo8k2X+rqxAuGSJc=;
        b=bKgOfMJIP1jsnRu1sIQjXX1ab9aMh8beq9nw2vPwnFTD3WYAuOeYOUVzis0SUEGAS/
         limJMyg7G/irjs8VDuf11oxUihkBiqXZCgSDa7j46erMD6YrhBBX3Hu+LI2RaCCyG3KO
         zwjLIAb31aj6mi26Prp6Xa/5xWLqSiUfNy0HPqjaXKVulR0PblNozzZsQswcBR/9oa3Z
         ZjIg1UAxqe4qx5jl357vjPAFNHt1RHCTM2itCwK8CygJ6yyvGXWP96YzIbekYZ/8o9Zc
         oWNc3n3Mtg6st+FIlLt2cG2KmJO6GiqX3KUKsUJwdl1yTiv2sHnmw4S1wYoXgD4vMOop
         HLgg==
X-Gm-Message-State: AOJu0Yw5Ku001oN0qcXQYzidtXVXwZGSTdYnpe3abbF+ZZ3o771OigHv
	onv5j2TpUIIHX0ELHt0gyCGEln13qBOpbOC2838klAB7b8kts1mosDccD8wla3VND7yRnMcJes7
	J4CvcsgsZx2gNrry9kAmeZ5N6G1JL4w==
X-Google-Smtp-Source: AGHT+IEGwKaytFnETfFo4b7EDJqrAyUnONrL2z3NsMvhkGFLRmYCsLRffX4JW6hVBbPqliYL61JTvg9itHs7MF706Rc=
X-Received: by 2002:a05:6808:244e:b0:3e5:f534:ddc4 with SMTP id
 5614622812f47-3e7eb71f764mr5024582b6e.13.1732145687627; Wed, 20 Nov 2024
 15:34:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Thu, 21 Nov 2024 00:34:11 +0100
Message-ID: <CAAvCNcDm_Nbx2xSC6ev-hy6mJaztb9=SUOPb3n=KpXqyzvkFMw@mail.gmail.com>
Subject: NFSv4.2 client: Just using ls(1), find(1) to detect sparse files?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

Is it possible to detect sparse files on a NFSV4.2 filesystem by just
using ls -l -s, or other options of ls(1) or find(1)?

The goal is to find sparse files without opening each file.

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

