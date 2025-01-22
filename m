Return-Path: <linux-nfs+bounces-9459-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C660A18F43
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 11:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E13316884C
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 10:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B502017A5BD;
	Wed, 22 Jan 2025 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/77Yk4F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A65E16BE3A
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737540471; cv=none; b=FJqqa+MeLA/EshmyDrQUb5QlBkTvC44bp0DZZGkOhCDk1QC/fnTaQueWCtSAgvlAc+Y6rA57VyzRhFxmbokQZgZMjQriKncWmp6RdVKAQK+nCTMNBA4sIu3mzVJfEB+xCxgpHcb9r13Tc2tDd5TsTd2fKn7Vi5hVzwRKnjTFw0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737540471; c=relaxed/simple;
	bh=fOMhC0gzwpMGcrp4AW957K16Tx5y7mfY9/xeNQ3iyi0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sY3fzsLWsDw7wpzOYp12qEoq9Lb1jKV1fhXK+ArdyV9ymFoz+LWyZVHMXYFSoA8lQbx5bL3gV0ZlHTK1YKDIYpDO8uxmMd7VM2DiNtacnD8qIHmIeujMluGHOgy5URN25+r+lP+PVSxdw4gbBrPjpqJwENkQd3/QDcagaM+txQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/77Yk4F; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21634338cfdso156444125ad.2
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 02:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737540469; x=1738145269; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HaQ+uAG7KeZLBcyRI5KW5dqGdxqEwe6U44Bz89dto6Y=;
        b=Q/77Yk4Fxh6bHYZ3bMxWLrWXaDmFYvMrrBlunrTkFWsDu9YR93s8Cy7prqembZC1sV
         1dgUgXeUBul2tq0CmiTBi7V+3+qihbENnog7Hed8TGKP0+X4w8Xjj++0/AUPXKeEL2nR
         gDWc8M6O1fWQ/E/M9QsmU+JNXo/WQKT+5pGUjxxiAIllzhnoxdc4TaaqXWyGctHYgA1J
         6rAOlE/Hjn7vU7+zLP1+zsHKEa6j6KGtgbYeWw+XBBl2SGJ8wK5HObP6n8EDFw/Ojh3C
         vDOtgWy+KH8pLoriAuGSZ4rjAYAsFdrjsjN0X9FjTopcq14x2qP0BNiia3WZR5pb9xnG
         Aaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737540469; x=1738145269;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HaQ+uAG7KeZLBcyRI5KW5dqGdxqEwe6U44Bz89dto6Y=;
        b=lkgPO6IMZSKxnLrifT6VXvL0+q9F/3Ca8lMdT09TZmK6nJU7kUmSH1aqfMn6b8WeYK
         zX5vJnj/9ocJz2fq/f369W/4/9elgUoTjJ9l3btXHXkV6wpqdyzwLvsLdZeUPm7aO5ef
         X+CmbAtRHSHIO1VODEL0r8kaVmqhDOU7UEgpZJSnnYscMLA+iUmSYl5Olt9WACyswsqo
         4OuNCDj098XvgmvCEl76YzhXJccYrhy0J7nP3rTu7pSwNHn/lR5gZe+1LNRacvh5wju7
         7AHz+RIjG+ixIPnY3naH/Ism+LvdtkffBD3l0mnWq4N+xX26B+oZCWeyDEAgACYUrK2M
         AA2g==
X-Gm-Message-State: AOJu0YyI34Up5eDZQz63FiVthZhIgsp8xvmurRDT17GDSq1lQn2TRoou
	32PQr2mTp0mDDbbgvh4uwYUSU3ru5sR3rbzlBAPxxwcXaHPA0UxRSZtGE6l9YZe+spe4/pnIlsd
	p06wmZkPe2c00UJYaaC4rlPK3+rG0/B61
X-Gm-Gg: ASbGncsd4vXOdo3qZs7EZAIR7Dy6AjELDCDIkQMBNv25o9VwuICGp5xyllZNm0dJO/i
	P3ploKJ1X2ZBCFyFtl8VZ4vBfOFg2XsyV+tamxcr4TGvMGdlvGj4=
X-Google-Smtp-Source: AGHT+IFME4JvisyAR15vlaYUmOTDDaDdDburaShGrgCkSOk+Is6pS8eolM+NkHH4n8D17TIuOWRoEtzDTEQimV3mi+I=
X-Received: by 2002:a17:903:24d:b0:216:4cc0:aa4e with SMTP id
 d9443c01a7336-21c3578a2damr257914655ad.47.1737540469306; Wed, 22 Jan 2025
 02:07:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 22 Jan 2025 11:07:13 +0100
X-Gm-Features: AbW1kvYpaBLm1VEsmgm_wssjokpa1M98RXweNwcFYQ0BT_-wMOGbX5tZ5ow0wQI
Message-ID: <CALXu0UdddwbzGUUzKdbxpb-yC-FVMhbdcd-P+OLSDNvjZeByGw@mail.gmail.com>
Subject: Increase RPCSVC_MAXPAYLOAD to 8M?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good morning!

IMO it might be good to increase RPCSVC_MAXPAYLOAD to at least 8M,
giving the NFSv4.1 session mechanism some headroom for negotiation.
For over a decade the default value is 1M (1*1024*1024u), which IMO
causes problems with anything faster than 2500baseT.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

