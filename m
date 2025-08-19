Return-Path: <linux-nfs+bounces-13771-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B61B2C831
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 17:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152851882CA7
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 15:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F60A274B3C;
	Tue, 19 Aug 2025 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CCEsgIa7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E29C27FB2D
	for <linux-nfs@vger.kernel.org>; Tue, 19 Aug 2025 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616294; cv=none; b=mHSRN3na2ReBFM3835oW3BphV/PHxrCS3r15hfRxiD3Q8JhU5gPoSV+LcoHBc7Voxw1H1eBZYUuaZU0xFggezUhXVayeRH7nM0CMEzzbozc1JjvalGueLBiRD8JOH+8lWrCyjNNU8qg/+cMX8EKsVraPgnTpLdcp3NrfkjV82b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616294; c=relaxed/simple;
	bh=QycJOek0v5nhJbP+MM3OL5pORRB5+KjDcuVnGbqGgEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oP0D4lPPmgrWckfdLjvmSe4uC7/n1HugZElqFk3O3SDD3zWcvURdRLz52JEojBkMLfAVdftswCLGTIZRcNlKrI0Bm+Lb+Ou6KsvsoZqT/mN1t/Ov50ejOb8SA59wYYgN/yxarcQ4F9GJc8HE8LwZ5u971NkvFR1AaU+KLtepEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CCEsgIa7; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3e571d40088so34932605ab.1
        for <linux-nfs@vger.kernel.org>; Tue, 19 Aug 2025 08:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755616290; x=1756221090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XJa+KTXC3mY3I1CFmfiLeW6ge9cWEkwQYxycSXbruFw=;
        b=CCEsgIa7xYOHvvlqiCVHe4ie/qZUUblJzn4Nn4zr3bH3GFuHl14BSH8r8ga/rpLdWY
         q+9cjg1h2aSWmnK4CDPyuhgk2wkY7ieSwu97m4qzPsgBicZVkwrRbzCaCzYYYEGJfzLY
         bZl8+bxAt/qLxqOADPEg8gJZf2nEB29m6nCr7Z00ty7EbEpSQjfGHxG5R8Oc+32sF1tF
         /IuUaeuRPP7IhkBc+vPbBR+hPPB+oGXsG85wQ6YXiud3Y8MKTuUV9P5SpdqIUNOKD8pb
         VI7Uw+eQxcjWL1lvRtp98o7hcBZwcaqzACXpjBMCXv+1Wzejtq9ohnbmg8LAaUK0AN08
         Lzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755616290; x=1756221090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJa+KTXC3mY3I1CFmfiLeW6ge9cWEkwQYxycSXbruFw=;
        b=LLAhpFiYcqrtfdyFie7OvSBf/cAVsp5TIv4Y4uaghEBf26gwBIWKUb+fR/Y0Isyac4
         N17dWc3Yvi4lpCzdzMjhxaSP9SX89YH9c1aaUjYU+Y25S+qRv6Cf+L+g23lkIGvd56qK
         YsHj1QBVyWWUaJjMt5tUADCrdd0NJYct5vLG7kq3yxYxUnvN7HU2BNeD/UcqVR8uE0a9
         fTjI6W8ZMVGh49KPzpCLRhc9vzRxnqIlmO2imoUGR1C5T0wfrH8g3eTCTllT3rf03HnI
         fQVFnuXjG8Gu93YlCBaGFNXZ0Rzed6/JTQHqEBYayRkvzz/QiyR3KIMN8hSoWM3pNaOj
         BvPA==
X-Forwarded-Encrypted: i=1; AJvYcCU3GfCIbLhBdCCVEI3xY0Uk43RKA58KVRBvQoXbBZ5sIXafkuwir8OIHrB0KadFUlhNBKJ7NvfefIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxziLAqoCCb4Gg5rfudAfRTPVP3KZ6tkj+hPQxXsp7Pz5IQFdUu
	AV3M59josPbk7bACEdCi04GCN41tIATnZAASZcsklZs6DrjUHdSFhTMQ2aoRaiGdESE=
X-Gm-Gg: ASbGncslj08vf/jCLzBmHHXoNwGdmjTgvLBah8QX5LVxIf++yxUaCQ6SGQNHoXXpY4L
	1BJaDTdCe9vyTN03MGKeckD3SbT8JkoQxN9OT2R/EpzdZdSaV251CV0O2oyxYsZDX8UGW6/IcD4
	PkYwo010q5x5o74NlcIg/skfWkhoyzptBXP4kdpIeTlRRCjKhU4Amh8R9xhd9e5L1oFJUP0GPsn
	vmvqx68N4xNbRPsJm7D+RcTt3bNFra6HNF0J3Yj3Pv1fQDz+TGunNCXEWz26sVxEJ1y/TYOq8Hx
	El3Fy1Y76o0bH8yKezPygIN2vgM3wKR9V/m1k6Uz0EuCktWY81yvdA+5MzPN+53KaR/kYl7nWt7
	6arH2OgWI1+/XezIVEvOSLV40n4XzyQ==
X-Google-Smtp-Source: AGHT+IFY0exKSpm0+f6H/wzlf9xavbPn8hy9QGoJ0cK7LCW8RzIzjH4Cjwh92XwtseArqsfz0PbY1w==
X-Received: by 2002:a05:6e02:1549:b0:3e5:262b:8303 with SMTP id e9e14a558f8ab-3e67665cad6mr49090925ab.20.1755616290212;
        Tue, 19 Aug 2025 08:11:30 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e58398cce3sm38224325ab.19.2025.08.19.08.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 08:11:29 -0700 (PDT)
Message-ID: <e914d653-a1b6-477d-8afa-0680a703d68f@kernel.dk>
Date: Tue, 19 Aug 2025 09:11:28 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET RFC 0/6] add support for name_to, open_by_handle_at(2)
 to io_uring
To: Thomas Bertschinger <tahbertschinger@gmail.com>,
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-nfs@vger.kernel.org
References: <20250814235431.995876-1-tahbertschinger@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250814235431.995876-1-tahbertschinger@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I'll take a look at this, but wanted to mention that I dabbled in this
too a while ago, here's what I had:

https://git.kernel.dk/cgit/linux/log/?h=io_uring-handle

Probably pretty incomplete, but I did try and handle some of the
cases that won't block to avoid spurious -EAGAIN and io-wq usage.

Anyway, take a look at that too, and I'll take a look at your probably
more complete set.

-- 
Jens Axboe


