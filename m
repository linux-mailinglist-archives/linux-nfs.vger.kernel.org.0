Return-Path: <linux-nfs+bounces-13879-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D137B32DD9
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Aug 2025 09:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250E5243F87
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Aug 2025 07:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00293139D;
	Sun, 24 Aug 2025 07:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f83nu7Zj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE9E393DD1
	for <linux-nfs@vger.kernel.org>; Sun, 24 Aug 2025 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756018835; cv=none; b=bZe2yWYabNmmQUBiemAez2k2xg/4DyXaPMcmZoZNMnBNv7ZED2VYu2fXhMZBKjsTVt0mfx3UnsNftrZJM+iqDrrj4OPOSehWtkfmibaj5sMpegpaQdtYTaBxziYoCK1zWQw7MdHMFxZ+WycfRctfCUi5I1yt/nZaCNuJyGU8sAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756018835; c=relaxed/simple;
	bh=2GmU/KlxYX2McM5N28OewFrFd/WVHamULCAMG+c98uA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GwbTrJXH/A6eY5ZZi1wm3nk3CeS3y3OkyWYMk//YzEvHOuh7WTsjbe+EEwC/065acWR0hpB+dKhk5yYLCsfeQFsiYY3ddqaWBt/8JVt41eRQ3qy1gj0XkbLLGmsTGOaFT4eSX8Ji5Nxt+aNEjGvJmnJHawAuno+rfEKFezxqzBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f83nu7Zj; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so3015170b3a.1
        for <linux-nfs@vger.kernel.org>; Sun, 24 Aug 2025 00:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756018834; x=1756623634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVSAOc7b+CqMH5ivd4IYPbqUUBU/mR4+p2CH+fQ8H6w=;
        b=f83nu7Zjioengp/KulvXhB0jVcPtqzdhErcH2x4WYQykFrbqXwDDohYgf/7NgTah3W
         MhiMSApdqU/lhKsrrb+ms/L3KBC8FJ42Cb3mAj2TiCJm61ygvtDXs0sqxRzWhp5d7YRT
         AhfQhu6OjcXLshj+ZEphzlCTIxibsJbxCyuRucLvWBEvNqQH/u7MpKIya2/VAHWI7Oqt
         j2amF0S8hWwXOWS4Bu/CoRat8QdQJudbHKL2U1KYllxaLMXbfro24SGIMeecDAsj3VUN
         dRWS7tuf5EQwmINPKkDCF5rnjC8C1QYcsxMtNh1Si0TPo6EIsG10GQW3KYFxtZVkUBwl
         LbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756018834; x=1756623634;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVSAOc7b+CqMH5ivd4IYPbqUUBU/mR4+p2CH+fQ8H6w=;
        b=Ryfi97plHfDQdLxYK2q+Qt0BWtCKbKGvMARmOoYQY65bxTycm5zscHEbFpmYuZ/lfE
         YLv6yHqZ8BRBvUZ5Eqnt7tLLLZF3omgG+VDV8GlLbZWHE+3nE2Nzsqxt/SVx96qiYYvj
         BRdUymL/Fgo2lqduc+lVSwF5sub9fMb/1D5vFrnUxq6xqfJn/FYj99hsNSrYbFBcg3eB
         +PzNetDekjgYvbivHfLur978+XLPrkBFTLVMaC1SUbRgXYFS4kNOBcsI/eftNuD0m4oo
         8R5M20U+JB3Yo1dANxrUYnY9h14rvqpsHWsB4sVAQaBGtsxE5nfqEJOu3NcHiNqeGtlK
         D/wg==
X-Gm-Message-State: AOJu0Yx6psabc6tXBEQmMY16roxOPxPiTXNgx3WNhsMGJ47tScO7xIf6
	aE3zK8BaczhEDnklE5V0Q2YWtWLXf4W4trisM02GUJ20j19FeHHyVJuPwIorp6W6
X-Gm-Gg: ASbGncsy+J6UatVMQlsLztyzvb6GUf3RVxBhdvl+bi95hZYSOm50YU7KajBAWlJNToG
	cGzvQj2z5enTwSJtc760bmYl79q+RGqaqE38hQJTTi3JTPwrUHa+jpQgcrMVCFixXa0CTZWNo/Y
	LF1mR/DXh18Efprq846oD1/2+ZphBMkrbMTwYMRvMlVG4/+I8ud1BjbvP6c5iYJTTo0PiLq1isr
	Qy9o0zc5tKUNsPUbtGzx2HpGLkSIBiaXV7lZVhKkIvBWpEsvzRvTu95cOFPJ0fcSX+J8X+Lsl2g
	1HGHArZMVg5UUvzBleQ6hplO2vG3B6UA+aTrfw/YEhIW6PbzKSyV+5+rlO6bRfX5XX7nk8ZYSKM
	dwiL6aVbEWqSMXdyAobf0wv9IztxZKbQuXtyV2w==
X-Google-Smtp-Source: AGHT+IHUOOktiWLn/8Napx57n0YgsWSPkPv6SiavdDo0yal46Ul6A2JP++wO8jnrk5QxO/P7/j9F0g==
X-Received: by 2002:a05:6a00:3a0b:b0:76e:7ab9:a239 with SMTP id d2e1a72fcca58-76ea311ed45mr14824669b3a.16.1756018833725;
        Sun, 24 Aug 2025 00:00:33 -0700 (PDT)
Received: from ?IPV6:2601:647:4d82:2ae4::d83? ([2601:647:4d82:2ae4::d83])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b0f73sm4103362b3a.60.2025.08.24.00.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 00:00:33 -0700 (PDT)
Message-ID: <7a71069c-da16-4c9e-8afa-225211bdea60@gmail.com>
Date: Sun, 24 Aug 2025 00:00:32 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <cover.1754270543.git.trond.myklebust@hammerspace.com>
Subject: Re: [PATCH 0/2] Fixes for the NFS automounter
Content-Language: en-US
From: Scott Haiden <scott.b.haiden@gmail.com>
In-Reply-To: <cover.1754270543.git.trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I think this patch 
(https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=b01f21cacde9f2878492cf318fee61bf4ccad323) 
might have broken the getxattr system call over NFS.

On v6.16.1, I was able to call `getxattr` on files in an NFS 4.2 mount, 
but with this patch, running the same command I get:

     $ cd /path/to/nfs4.2/mount
     $ getfattr -n user.hash.sha512 'S01E01 - Kassa.mkv'
     S01E01 - Kassa.mkv: user.hash.sha512: Operation not supported

Without this patch, it just returns the xattr with no problem.

Am I missing a mount option? Or, is it possible this commit introduced a 
bug?

I ran a git bisect between v6.16.1 and v6.16.2 and it pointed to this 
patch's backport to the stable tree.

Thanks,
--Scott


