Return-Path: <linux-nfs+bounces-11039-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F21D8A80257
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 13:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DF43B5ADF
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 11:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3100E2192F2;
	Tue,  8 Apr 2025 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7/69ySm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5AF266583
	for <linux-nfs@vger.kernel.org>; Tue,  8 Apr 2025 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112455; cv=none; b=bhjwXFmTvLmgOKV1QYuOZHANGqHNmAI7BWsEfBDQDnoTZRUSsKou/yDrkYJd8n+lRzLTM9UPC/55hHlae5WE/V+DKMO6ppwmaaDDJr5aLjLzs2ixB2iE+/wi8iv3VtxfdujiV0SSDF1iCXSMQmWc9WWKyxTqqmBspBI1q57WzHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112455; c=relaxed/simple;
	bh=mTZH65Vgz0KQQNKF3TNEhP0Q1uIeuZqSkKI3FeI/9dA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=J72DUuqrCYkwkCBRj4kMhPxMnNk1fAwvxUG2yXZN+cEl4DyI7otSw/gLfJ7nvfkGxz4P9/QFyWfUhg6Hh4xoVsDsDpy4dZKWyRs6lsff8nxR1Rv7W+8IPxxUguRvceKf/rWIKiifRtW1cYnkTLIrZ10SGO8q9cnG3VkgpugzZm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7/69ySm; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2963dc379so901126666b.2
        for <linux-nfs@vger.kernel.org>; Tue, 08 Apr 2025 04:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744112452; x=1744717252; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZPCeUHNizqqz+cjrP6cHVpBjYVLMBj+WMxgMCZrnVZY=;
        b=M7/69ySm5mZg1FGvfo513lrACEhUAHC+qmZJ34E5XPBy7kVLe7Qmr2xuuW0rUrr1Lz
         IpBDSx4WaGQOY+TTM4z+XTwPEI+k0a6fyx1TMTp9wnDaXQiV/EYHLY0R1JAAJ5sdoXs2
         8E8mm1QxwZ3USz6ebGSGz2ZZt9kE4zL0Iu7U6dG4Deqy04+TEnZ43UFHT/QAG5BxtGBl
         FqUz87V93PsTGVbAZPGnD5v/mi5kX1CEdkrNTgVra2bY8xFfnBXqKZvUlKol0V1L6HVp
         07kGY/0r4TasKPQiDQ5vPkgXzFFKiAswTJJQbHCqT9qlrAB4YIYkwprdbKMGihbUocfZ
         9R/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744112452; x=1744717252;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZPCeUHNizqqz+cjrP6cHVpBjYVLMBj+WMxgMCZrnVZY=;
        b=MU/jrTxlwGxqikvLA4g5NtMO5xiiSubBB+Y7Zp652pGH3onjvOmAucL164nvnNUfWW
         Jvcu46PsPpte4P9+uJnxavavLwluMIoPUgrWsDCmJn7YRgoN9NUW1kttN1o9iFlv8s4b
         JcXW4NeQlYDWDppW+2UCVM7Ex3oUdiFJVV0VhFXzSkpGqz2VnLBpolHb4fd3RirvAYOs
         0lKypYP9eAWm5yX47JU4TM+je5Sv7T1oli/YRbzgEI1dL5VA+2Z9YaMRIBOU0FnAqvm2
         V/GkJDIXZ32JBkgvhMZkAYRpYJmKf5jNCPheUQgf9JlQ5LpYeQVEGoAVukbRKPttiJH3
         IpWg==
X-Gm-Message-State: AOJu0Yz/3SAVmdCHNXuZ+hkYMDvdLVoiKzwxBMgYqefgNsee3aBnFkhY
	pNdGkvFj2+OFsptRhF1RousUUFwkynz7Q1b5U8OYg/UMbbuiDUFgOrQp2QWEbPFi6o9SMHk4IhW
	37YNwbFqrn14T0l9kHkprQKD2FMLj7P/acUQ=
X-Gm-Gg: ASbGncu8Jr6g7vwB7gzGhUayfCcSDhzK49iGWSTpoKurZ9gADBKW4um1klSxJtiyejv
	nOgeJVKy0okSPBhiB0OwlCduOtZymBYBaQpZGcz+vYpwTGd3HHjI22VaJtoXspeEYVnGUAycCf1
	GCJnSRn8GfgE2Cj96VoqK7zCpS9mTGH4aL7m/YBCnpRCY=
X-Google-Smtp-Source: AGHT+IFes6PGGhzkWKHp4Q6yvTQkx29n5f6EGiXb4G+fp6AxOVwcFADibfETzTVfFmLDzHc+QlMWMWeTw+ZUJfcp9TA=
X-Received: by 2002:a17:906:f6d9:b0:ac7:ecfc:e5fa with SMTP id
 a640c23a62f3a-ac7ecfce6admr912227966b.54.1744112451613; Tue, 08 Apr 2025
 04:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rik Theys <rik.theys@gmail.com>
Date: Tue, 8 Apr 2025 13:40:39 +0200
X-Gm-Features: ATxdqUGusn0q6yIZDYEI7hN8RDElD79CNS20H6n7saME0rXtG4i01GQ7Wed75kI
Message-ID: <CAPwv0JkmdcyYNXVuOGxugHVQtdD+d4CrNuQ9wCv72mySQXHCfA@mail.gmail.com>
Subject: CB_GETATTR patches for 6.12.x stable series
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

We are running the 6.12.x  series and have been adding the following
patches to our build for about two months now. They don't seem to
cause an issue. I don't see them tagged as stable (yet). Would it be
possible to add them to the (6.12.x) stable series?

The first one is:

commit 1b3e26a5ccbfc2f85bda1930cc278e313165e353
NFSD: fix decoding in nfs4_xdr_dec_cb_getattr

And the second one seems to be a follow-up patch to that one:

commit 4990d098433db18c854e75fb0f90d941eb7d479e
NFSD: Fix CB_GETATTR status fix

Thanks.

Regards,
Rik

