Return-Path: <linux-nfs+bounces-6512-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F263897A504
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 17:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AEE91C2186F
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 15:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFF315852F;
	Mon, 16 Sep 2024 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjcdVq4f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FA7155CBA
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726499664; cv=none; b=Tbw2Wr0/VkIXXcOe5Q6g9xlFcn30uSnDkYpTzS9lcboeGZZWhHuWI8elNsVQHmVK2zttOnaBmyME1pTM2+QBW3dufsw30AJIRHUmB9UFdbXYTT6RKO3I12GHrLC+2NYzYmWhsZSEOFsZMpgcsVbseZwM14pqvTiO/DTE9SpsYRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726499664; c=relaxed/simple;
	bh=MNPa/nra4xltq5ilgrLpTIhW6TE5b8ddugSCAeqVmYk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BvnykadSGg6n+UwkEVHxDrqLn+XVP+h/s3E8sh48AhrrBbR5MGwaM5TE26BHqyNucIpW+gTnqoDyQ2TZI8xVq15SWio4+3IkkJnFZzUqC8DrDd1eMpepS3Ixt3m+VHrOrLRmHHsz0CLpGAvgi8bnkhrxojHj6uvnusNaIjuN6rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CjcdVq4f; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5365b6bd901so5109582e87.2
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726499661; x=1727104461; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3OsAXTXOvZFK/Kljg8OzHVc5yBHojHdqEWoO5Ysa4qY=;
        b=CjcdVq4fCKX9SnL1Fc4e5//pBPIj5qZWm7cJhDYiESriFaOtU+CpUnzLsWicR50tVs
         JhAPA05WmWybU31meXeYjm5k6ZYxUymry4RHT+BYaRg3wdSwAr4RuTcfUnQ1G0Esvxg5
         nbh1UTcbWXUYJre4FTm/rE8DXaeHPRYXz0Bxgcl8HQ27tHHcBvu/7eQEWGFin16j/ScL
         y9cGg0Hzr3FfLooUwEh/HG9lVxR9TfmV1NeGAr/XjavRvHjskN7Z4YVMjYAbCnDkuaXY
         liJ0FCXGnS1gPxt+BUMSnKwRihN6IzYrkVB2U4qS8WmM/VoU93ddyUY9E2u541RrMX+O
         fQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726499661; x=1727104461;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OsAXTXOvZFK/Kljg8OzHVc5yBHojHdqEWoO5Ysa4qY=;
        b=m/+7ZCUE8PbNkzaAmMNTdGrRGS9ewT+RfvW5Yh65D5o2QT0s4oS9q71p2Cby+c33a1
         WUZY2SmH+EUdnWRAiQJU/s8FsVuTZqyiBNzKJFJXzp3o8sR+oRD8+8B4GKCRIdWoh80X
         MypWm/R/YZzIoq5h8Tk+tU8sGrv3qTBYVlKvHH1J8ezEK20mgfGzGV1BGzzZd3c2rQLp
         XwIcXZD15+YmOykHNs4NkiEykzlpnkn112+4JkH1sztXwB/QJNWANYELDpKiKR/FPk5E
         f/tw8YFyyQ+6MsYEdYog64nmobdkP+SmrbF24w1gQbRbx99nVAdF2fRaC1SrhzKr58kO
         jwgw==
X-Forwarded-Encrypted: i=1; AJvYcCXGhhYOCDE3aj7HUUcpB0/ML7NbmYA2vqrhVBmFbenZYR9ODZfPuWmgKwEm3D6yFp6rtc0TK5QU2C4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ON2z5O6csz9Yn6Ns7U6DQBSfvKiZYnU4qQIYQgvpjz8zcJC9
	p1QfHaE5R4hxyn2ewph08ZO+JrFV4iDlJhLmt0nVRqNqDOqH6xE4C28ygvV0W74=
X-Google-Smtp-Source: AGHT+IHIZXxEIzCYwbLCzOTPPzjeLXzlFrRve1oqay800OYWVBqf3F+U2I/9rmXJlaoNgnkyGoPWdg==
X-Received: by 2002:a05:6512:3990:b0:533:3223:df91 with SMTP id 2adb3069b0e04-53678fbab40mr8213405e87.24.1726499660625;
        Mon, 16 Sep 2024 08:14:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f386dsm329089566b.49.2024.09.16.08.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 08:14:19 -0700 (PDT)
Date: Mon, 16 Sep 2024 18:14:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] nfsd: prevent integer overflow in decode_cb_compound4res()
Message-ID: <65cdbbab-7dca-4a73-af07-29863ab8f526@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If "length" is >= U32_MAX - 3 then the "length + 4" addition can result
in an integer overflow.  The impact of this bug is not totally clear to
me, but it's safer to not allow the integer overflow.

There is also some math in xdr_inline_decode() which could overflow, so
really it's ">= U32_MAX - 7" which is problematic.  Let's just check
against INT_MAX and make it easy.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/nfsd/nfs4callback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 43b8320c8255..12b44c9246d1 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -317,6 +317,8 @@ static int decode_cb_compound4res(struct xdr_stream *xdr,
 	hdr->status = be32_to_cpup(p++);
 	/* Ignore the tag */
 	length = be32_to_cpup(p++);
+	if (unlikely(length > INT_MAX))
+		goto out_overflow;
 	p = xdr_inline_decode(xdr, length + 4);
 	if (unlikely(p == NULL))
 		goto out_overflow;
-- 
2.45.2


