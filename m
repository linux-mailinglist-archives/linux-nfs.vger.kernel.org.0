Return-Path: <linux-nfs+bounces-2277-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA69879E4C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Mar 2024 23:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA271C21EF7
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Mar 2024 22:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5169B143C55;
	Tue, 12 Mar 2024 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIvi5YEg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D919144020
	for <linux-nfs@vger.kernel.org>; Tue, 12 Mar 2024 22:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281681; cv=none; b=oE+OgRuPSCG/A8yjnMeZ/n7kuw89OGBg1xo1e8WIvWyiiTQC/nzreFYuGA93xPAKz7XITCvvZbVxhae+xzVcVZ7yYhP/FmsfAx4/eX4yKSiiTlRiq6eJkmQSNXmYjwrJj6igE3/RzABCWQR7SffPRs6oMNiFYQBonHtBZVI4lWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281681; c=relaxed/simple;
	bh=K58GC9XcU30w4XIOK+qjLTcisDkrnH/vWg8x4gxjWTU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=N4dgNWimOo7JqtY5AMCFkbzsPIarglK3j3QzcdXvZCPQ74NwaaBYmOB7HXUNtIAUT5FPHiOaTN0lU3W2QiL2vd3Em/6lr+d8cNXV7/ltFPcTz+JWGsWUF2U9lWwMnYkHiCQ4Vb1nSgmbzQGq7aT32z50mplWYCdThdWdmoQJlvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIvi5YEg; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d094bc2244so92682621fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 12 Mar 2024 15:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710281677; x=1710886477; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GGCqf09SijMXJeBEYimA3YoUXOjg8/K2af30dxGqjZ8=;
        b=HIvi5YEgaCkWKPcNNyl8or/Pv1lHAnrdjPL2ZvBQTmGV3DONoVCJBPj8yf0DgUMVrH
         CvXCcYxmHZDgRpskplm9+nA4iLUlk2ijVk5PcMWfkTBEHUgU4aY/hU8OpU5L2D1XToTJ
         RFkr8mt5BNC7XfCVp681inqdC2VkxjcXmChZ1BjDuyal+aroBofHVD+l0WJFs/uM1hnw
         XOPu2LUXbAZHesA+ZG4XfhK5IEMByogT0wVxJInOIsiVPgSpa1wKwVo3xfQLd/fRs1pH
         dPl922rQzyAJrsBZy+sv9hIzv1ZMiEaYYSn/ldgZFcupoV3kK08NCbheeHFXRYPYmTQP
         QDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710281677; x=1710886477;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GGCqf09SijMXJeBEYimA3YoUXOjg8/K2af30dxGqjZ8=;
        b=o+gccuhSDMre9FKW4sohuCAZY3dt5cVkBvigyh2tODMWm8olucoLRl92ujnZRmLOSR
         1h0yB/jXcSf5BLafFCDx99t7mBZmRphNtKCTE9500gxk/5fhT/0M+IrHEcCruOBzuMl+
         CKlNzaATmYvT3int8HmsDjLc8d0pUhpgiH85skoxZ0HVdvw044cg/jDpzuuWPQ04rx1q
         kSoYjT4TERbZmT05w49EgHSQpnzVijIQAsvu5aETFEU2XDwCXi9Q4LTm2UtRs2fsYjw0
         A4okATTI5OcXfClHSyGuM0Vl/nnFbgVbYttQjqHHC85PlvAbK+omBFJNvTTAtIOsSh4j
         3BTg==
X-Gm-Message-State: AOJu0YwCvez+qanyoSQtNz/iVQUI5eBNukrqQV+R+MyrEVnMdDL0rGXz
	HikOvFTfkXx7MY46LnQ7niyJUHQ4XcbjHZ313NdIaxKRYxSbtUG4y6fxePd0cyPJQHIPwBhF8z9
	T6u7640OfJtZJmfLtvwA9PHI+KUbG0QIr
X-Google-Smtp-Source: AGHT+IHRVNGJA//0doZZucjv88rrliX9o5kvHre0Ykb9NZkCUUcdy2LU4GrUVU/SdL0n7qUro7+edJBE5M3kM6Tly4E=
X-Received: by 2002:a2e:9c09:0:b0:2d3:b502:3ff0 with SMTP id
 s9-20020a2e9c09000000b002d3b5023ff0mr2200188lji.0.1710281677353; Tue, 12 Mar
 2024 15:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Tue, 12 Mar 2024 23:14:11 +0100
Message-ID: <CAAvCNcDTkCfi_r7k5h7S3Vnb_FqtY+FFc8hNnEYTiUga-Sd2Uw@mail.gmail.com>
Subject: NFSv4.2 ACL inheritance, examples, and who does do it?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

1. Can someone give an example how NFSv4.2 ACL inheritance should
work, e.g. multiple usage examples, for inheriting user access bits
and multiple groups access bits set for a dir, and inherited by new
files and dirs.

2. Who does the inheriting for new files and new dirs - the NFSv4.2
server, or the NFSv4.2 client?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

