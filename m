Return-Path: <linux-nfs+bounces-13133-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE913B08FBE
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 16:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370DE1C42544
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 14:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E210B2F7D0C;
	Thu, 17 Jul 2025 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JGtShvcW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A17F2F7CFF
	for <linux-nfs@vger.kernel.org>; Thu, 17 Jul 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763386; cv=none; b=HrE597NPquht+yjYdTI5JvWvFVFRf/gxTa6AD/Hvm2oCTaXfYp8LoVPSrdXKlYG2y/FhvHgQJUJhqeSiOb5zFZCcHBZ6YEhpS8HBUO/L0EzcZ8tRjwLaTFb9WPIN6XdYEy7joAB/MkyWJvxiOfk9ZF2PwSxpzQR/i3/5AZCp0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763386; c=relaxed/simple;
	bh=TUvCGY8B4YTvR/P9Ogy3oBePGHFOB4QpVyXuiTt1/vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHYIOPRoxubqfh1mykkPuls5YJIgLWYc6rk5S3pujGxXiI8MPTDAECSt3emlj71MDP2tHxANWkLj3aVnJJST41FlKisozHj9MuDzOe2j9znZpqXFdRxGLc8eE5HtIe7Q/ZKg9xfoSeyC/Q/S+/Y86yv91wEQ91ulmuhDZmh27AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JGtShvcW; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-73e586fcc28so1220104a34.0
        for <linux-nfs@vger.kernel.org>; Thu, 17 Jul 2025 07:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752763384; x=1753368184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N78W/BgXf1tgHbV1NKXMAh6lES1lL9j7RfFG1d9Frx8=;
        b=JGtShvcWLtdPiXcyX9BUB5PA/USt/WPS2bg1k3NRZkeWlkw9B96BOClNVL/bUhItv9
         4ct51ygsUhl3DZTGhkjX9UzjCsbzKdqoHpuqwyVGQv6Xq4UnzRxbBVhNNMmzUyp0rftg
         RIfNDDh4hmPf9J8+Og9PDVLwc1qVx6ez67zYkUZwZIP9xsdooGT7YYCjDzNf0MEPPoMu
         06/5gSkfjXf6QZzw2s1t/kpoSg8D9UTLkPpsO4UnXQeGGE3PLzuknKPdaiZIRr6/ZRaH
         ZL+GXyAqxJOeElBXSkiQVNPGunaI/4wf0t9ApzdkaiuOn60TK7TuPbmtCTvsyc2xAtp6
         dc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752763384; x=1753368184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N78W/BgXf1tgHbV1NKXMAh6lES1lL9j7RfFG1d9Frx8=;
        b=rv6MmveRma/1GV1KzdC9N84xF/gijL2FXxCZO0lw+mi9O6tP95SakvTJ/+LwsPUiUL
         vsO1njaLZk74LHMJwKXkfrX8gAN9zL8Wi+u1ukP9ToNjNsJ0rcYjhj4VELX7zDtcYzMR
         sNfQJxjDSB5PAaPqaUa6kciE1g6RZVL2uEzuESLJgxyQPA33AlI8tMaz6Uux8pkqMU2r
         P1APwg70FCbyjn2Gm2a0/WItPwwRf+8OwSvfFHYhW6g8/J+TVADbTBCKh4ZO26YItPif
         PHdrbCg3sginScCzwb9vFF1pLBVOQpKePV+IxztpJ5QrrDDYwBuuQxeV9lX6CLHsxV3f
         uCfg==
X-Forwarded-Encrypted: i=1; AJvYcCWqJ/xGRyc6Zo0HlG2CKv9lGbK7chrMjS5LIaafE3ijh/7yKVhskcGXT6tl7zPMuJGF6N1w9g3w0AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBSBSPBxX25OPbfQ90GXve6IUcdiGlyV0Tac8D/WfOsZ09eiOS
	kD6bKDX7g70PanuTA4cgD4PFxrpbLfagn5Dvowc3Ud0EUgW4MYQC0EKKAege/VSgThY4DsFVtM1
	UOrXu
X-Gm-Gg: ASbGnctq/n5uDTlRZyTqvVztkyR3NaHszNvp6BfuOkt3zERQktWeNQZNqTvzRJisXzt
	Ux5/Qub/h5bCYPQgUC9sktvzYbrz9KWcF5c1mPxy1kCTUeX51hf0gcwoKdpFul71ZDe/PrZC1wZ
	VpMsyJi6+rwNOgnOg+wh5QD+Eq/y0NA/i/fxF8L2TXr9e8Izn+AvOXg9tINxUvRFpnr+TZSmekA
	BjXR+yry5Tk6+Z8d8ci71oPxROh2losN6UOztyq/g8/XySSdgUpZ4m6paI0G8takvPr8YjJWwyz
	kopkakwc410H7YMDytiTWYfvE3JXdY14MbtQ+iSFKN/EFt5zmB/QMCZgvr7K1EZP3A2uOrojlNU
	0XlTQVQJPMypkNfBzXh1uMF1+68O7
X-Google-Smtp-Source: AGHT+IGQ+TSDCCeabKnTN9pyedrIO5RV7K7MPGMUZ9ECCW5ZPF3U2n6/pVX95Wy4kGkp6UMhuZSeXA==
X-Received: by 2002:a05:6830:270a:b0:73a:84e2:117f with SMTP id 46e09a7af769-73e734a9263mr2519166a34.9.1752763384241;
        Thu, 17 Jul 2025 07:43:04 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:2c38:70d4:43e:b901])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e7bb81791sm282702a34.20.2025.07.17.07.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:43:03 -0700 (PDT)
Date: Thu, 17 Jul 2025 17:43:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pNFS: Fix uninited ptr access in ext_tree_encode_commit
Message-ID: <2bb8edfa-e2f3-41dc-96ae-b75b5ba22060@suswa.mountain>
References: <20250717143522.59744-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717143522.59744-1-sergeybashirov@gmail.com>

On Thu, Jul 17, 2025 at 05:34:04PM +0300, Sergey Bashirov wrote:
> Current implementation of the function assumes that the provided buffer
> can always accommodate at least one encoded extent. This patch adds
> handling of all theoretically possible values of be_prev, so that
> ext_tree_encode_commit makes no assumptions about the provided buffer
> size, and static checks pass without warnings.
> 
> Fixes: d84c4754f874 ("pNFS: Fix extent encoding in block/scsi layout")
> Addresses-Coverity-ID: 1647611 ("Memory - illegal accesses  (UNINIT)")
> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
> ---

Generally, we wouldn't put a Fixes tag here because it's just silencing
a false positive.  But also putting a Fixes tag is fine.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


