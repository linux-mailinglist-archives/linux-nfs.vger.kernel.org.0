Return-Path: <linux-nfs+bounces-13946-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A13B3B1C5
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Aug 2025 05:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9271C803AB
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Aug 2025 03:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409775CDF1;
	Fri, 29 Aug 2025 03:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI/ZV+vF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C956127735
	for <linux-nfs@vger.kernel.org>; Fri, 29 Aug 2025 03:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756439208; cv=none; b=gZaquJG6PFuD4lqbE+nlsKLgHaeoIUXw8WHfbqFouwHUC6L5M+QycP6ScyxWnsRak2BZcMw5RXpK1TAH0trW7Em0Qv62SLcFtmYOE54mvFVZUa6GNM+6cjWR7ANuSRYjFo9Mn1ARznbMS9Z8wL1A6atf0EKWWtFp7DClXFfBCkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756439208; c=relaxed/simple;
	bh=iZZ11+NKgEtPfxeEMQDe8i+pxcQTi3eeL9/IVDbS4AU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=TJ1qNutAObSlXkcOLGl3zbEVgIHkBJUq5iajGwwbz465+NyO4OB+2nUx3O7qZFLwSmBQZB6cbZUiOzjAAiUmmKS+033iGLOefr4qWgr3EMy6BKpDL7kKR3dwmpXyxqunIobiky/HmgrdWuCMqZb9im18ypARPAjN5yh167FjrlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jI/ZV+vF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7721b8214d4so1344031b3a.2
        for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 20:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756439206; x=1757044006; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0I7UfUgI24jDQzi04Iat8akQdI4ESG0uW5z5Z2tptU=;
        b=jI/ZV+vFGgXJmxMK8qCRAvP9iwhirTm3QePJDVy2t6rHauB6i8Hgjgc2W2gOsb52Wt
         huadjvenBeQxCQULF3KkHrJ0UuK00qtQXALjhRTCSPsOUFb5MCfJl8acQlbP9hKHXBMy
         1S0wYmi8KRY//1BPalDCEWSoZRj27HQpppZT1Bw/yFsve3wu+JZdM5p+DNPbPYULY67i
         eRe+VMEcfk9pMDpkcdYAzkmC851Ysudp8ua6TBg7RZ/C0XzlEIhnVRBsrT2EnjZock8S
         zwtl1ehyjM8Vc6HoFIMH3Ibj1hjynM+Vrl+EVpDs6xwYe10LvgbPCxvMGio0tobjAaAp
         JMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756439206; x=1757044006;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X0I7UfUgI24jDQzi04Iat8akQdI4ESG0uW5z5Z2tptU=;
        b=GZoLSWnSTq1hI5UvBib6xhX3YHOlWbFKBtCn7wxrXU59r3beE0wwj5XGCW6sg5Lewk
         V6yIatgfvPdDJzM7wf5mbMAp+OdGeV85NeKc+qHeOoSTHV8VSzVMZXZho6KpjGQYHvhl
         zdjJG2r4mjAHmUhnq+fkLeGJHfnrSh6fXePKE9i4TaS7CsaLSkuec031lGsTSgKSaIux
         yvYZyZx3FA00jkVtXKACDVhl8Q75nF+tdalgBDxB6ZIuVOqxVtLpQ764VWXygu08P4Uv
         A/dm9Decb3gJp75qE8pWTz293kMTOd/AwLu1kLXhccd7Tb/rbQBgFyPTac1irL2bJ9Nn
         HXPQ==
X-Gm-Message-State: AOJu0YyAY67/CTdrzJNGc4fs0rfSiJBwN8Py/QB1h2OVd4Q6PqTshjvY
	FMQ51pYVAjGzLxHRWadL9A41xE9fP9oTmKNl0DIOmhtpA8LklA8TPjATjsg59Q==
X-Gm-Gg: ASbGncs+oXf6oJ1uLqtoWkoaVSip71dlCpF2eXM3IR6BWNr26Rs7e1FRVKd6tztLixT
	BoBJ1WXgSzr2pAtHAf8cuMzb78J/ti3waQy1rv7NZfLx+8ATHiToIc/s1rq5tJRv0CF05l70fHR
	bqqnPPyf4XfcNAmEnfnD2afT6FYBL4rkw/6ogLuh3oaEn7OGbDEi7re8sAIzv5it3L7mW6A2y7w
	50xGWf4Ho4UpYGLJKa3qnNz9+W/0sD5+j9qTb8ijtlPfYV/jC0HTtPsa0cxhIgXg4cZJ/V6qqYr
	V3yeeRKnprUmREQXcorDzKm2307mVGhBoA/BwMzOiK1RRyqAr01RgZJfKmKduZ6PiRhrpeH3VxO
	zIS97zijQqOhTZ9y4VuO6UwaLBORUzx4QePUsTa66yStvEUHf
X-Google-Smtp-Source: AGHT+IGKsXVd2xhLm57Kl0UovFf2gJTEMzj04J18ZRTugkqIZsxHoNHbuF+GhZAQIBdHyGLmsj635g==
X-Received: by 2002:a05:6a20:4c11:b0:243:a769:4864 with SMTP id adf61e73a8af0-243a76949fcmr7764379637.10.1756439206102;
        Thu, 28 Aug 2025 20:46:46 -0700 (PDT)
Received: from ?IPV6:2601:647:4d82:2ae4::d83? ([2601:647:4d82:2ae4::d83])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd366f95asm852681a12.51.2025.08.28.20.46.45
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 20:46:45 -0700 (PDT)
Message-ID: <528e7a88-9c63-43d4-8c67-50a36ceda8a7@gmail.com>
Date: Thu, 28 Aug 2025 20:46:45 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-nfs@vger.kernel.org
Content-Language: en-US
From: Scott Haiden <scott.b.haiden@gmail.com>
Subject: [REGRESSION]: NFS 4.2 reports "Operation Not Supported" on getxattr
 calls
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,
Between version v6.16.1 and v6.16.2 on the stable tree, NFS client 
started reporting operation not supported when I issue getxattr calls. I 
simply see:     $ strace -e getxattr getfattr -n user.hash.sha512 
'S01E01 - Kassa.mkv'     getxattr("S01E01 - Kassa.mkv", 
"user.hash.sha512", NULL, 0) = -1 EOPNOTSUPP (Operation not supported)   
   S01E01 - Kassa.mkv: user.hash.sha512: Operation not supported     +++ 
exited with 1 +++
Before this issue cropped up, it simply returned the xattr as expected.

I did a git bisect between those two changes on the stable tree, and
found that the backport of this change 
(https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=b01f21cacde9f2878492cf318fee61bf4ccad323 
<https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=b01f21cacde9f2878492cf318fee61bf4ccad323>)
onto the stable tree is what caused it to start happening. The 6.12
longterm repo is also affected.
I built mainline 6.17-rc3 and it was still facing the issue as of last 
night, but if I patch a reverse diff of that change on then getxattr 
calls work again.
Please let me know if there's more information I should provide, or if
I'm just doing something wrong.
Thanks,
--Scott


