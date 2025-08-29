Return-Path: <linux-nfs+bounces-13947-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CE7B3B1D0
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Aug 2025 05:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E601B244F0
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Aug 2025 03:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EA51F3D58;
	Fri, 29 Aug 2025 03:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFTbWl9e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35B419C540
	for <linux-nfs@vger.kernel.org>; Fri, 29 Aug 2025 03:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756439964; cv=none; b=hxsVmDaXJzpT+g+xLii+2oV/4QXBS5PAiGkfx30DRPlJQMG2Aj4P2FNGgLqIICGTel/N5l9HfeOsaMf7DlmcUAOeaGulbEsFqPKQQ+v6CR4yg3tghlA90gNCB50hSLl94Ql83T7j0kXojkNlek7K5cuQekTirHP5bv+2LTt5SMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756439964; c=relaxed/simple;
	bh=vpnvhdVbbSC9lsM7MZQocwnOAy8IBt5dwXboBfpTmTM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=VWQafx5I7/giExbLu44zFuZiqoS16MfdZvB1bkSZLTSHY4tw0zBraJoi21AYu9BlSPGAhVVExgGBUgnONLWBJTrC3OinLP8GCBJLkyHUdPkJjbtbMSc32UGaPnkdOJIDy0yfM6aA9NxRPXZJ+bK2IPnHRoiGKwMw/ysm32NB6L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFTbWl9e; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32326e20aadso1815593a91.2
        for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 20:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756439962; x=1757044762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIMHdYjwdLL+/WyVNTbuT3fcoy31239i87NlSEgq9+I=;
        b=aFTbWl9ezdTMQ6UOUvh+CPkaRl5DnLvuTd0UVyzQkNqvHpkS8ntwYw2k5Ef20xOEYT
         2wqJJITDPj/cTZvuRFoHqv54btT1h/8LuH2aDK1CxdYGR0p42pxhaujzoyNqhRka6gin
         WX89+n34ZcxqORFjxRogBoYq0sXVUomI1pKbiZ3c+yvBMfZrm4IzdhkV/XrQTpt8PZbj
         J82p35g8QuUPVSD82/a8RnDRlU11LLriZ9155gFkoYIrwYML5t7IFdkTzi38iUOm0lUD
         qtf1grQha90wuZGWu4A4GCy2gS7EmR+QARxdWzHeTTt4QRIVTngR2H/W8httTNrGmk2j
         wvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756439962; x=1757044762;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIMHdYjwdLL+/WyVNTbuT3fcoy31239i87NlSEgq9+I=;
        b=GAYYzYAI4iaWBrsdqd1ycqZh72GEWhrVUz/e2X9l2x8+lhTHwrT3+nF1az3Z7ExhoH
         3zelH7CSy5qGF8L4bEBdNd6KLP9nRL9UMFHxTMqadMyn1LQDNSkRRYTP9xItqLMOnZ4m
         7zyh59A8gkcp/wqE/e2l0j9E5Np22Gh4uWd3Xv+3sP5384eFLO6HfVBlsLgKqSoo8lyp
         kWLon2pADhM5DzeCPgviQHpevUBrqYup17xu/GLbfq/yrRM5KVzuan8TDM2pm/Gobcvo
         c4AMc6Fm4dHP6HWM7biJwMYkaJTb4kYp0QqsIXeGTaTMZApLgQdByTrzOBC4MSlYQBhJ
         zq2Q==
X-Gm-Message-State: AOJu0YwJ/2UTHsI13J3KvQ/fiUL4pLWpYvTT++ba/VSVN1gXG8p/L/lQ
	lweaJCtz6+drW108vpjx7flUfbXMHDgWgbpsOElCBdDvv1Dt6H4R6Z60F8Q3PA==
X-Gm-Gg: ASbGncuZft3uC72jBoaXsTRwD7etBiI3kk9ikS4V35CIly3Aenr5YIo65ldtktvlq2w
	K4ma6EDIw25w3K/Q2fRXP+1bTYyWGRSDOHiZQI31rS7oP7U7RH07uYBPwVCuj5a8y9hoygXAsxg
	MVyHfzCH/v8nvwzFvkMCwvshrM+PcyoBZ0Zj278zKfr0zGS5Kt7dViMjHx6xelMVLEvy8tEDVGS
	PhIVfZJvHfTg2xFOWG818D6WLCss28+H1UpMxxzAX45f1T91z3I6zPmFL0RWyQ0fAeGLspKRo2l
	YdQZEN795KDvOQlISrZQZKzFhT1uHEKrASb3t0mMorZENvLcEUu7jnJWm0g5yvX3ilJBWBiVoTT
	2VADXIieypIziRDOY1x45REifOoxFbgRDb0Q/Qw==
X-Google-Smtp-Source: AGHT+IG/a7+CRwHScFYlCdmkhe3HojydQmkO6aHxe9VTmkh9O2g6xpi77d1gG1cOA0v9C2yleqRmyw==
X-Received: by 2002:a17:90b:37d0:b0:325:6d98:dfc with SMTP id 98e67ed59e1d1-3256d98121dmr25458031a91.14.1756439961799;
        Thu, 28 Aug 2025 20:59:21 -0700 (PDT)
Received: from ?IPV6:2601:647:4d82:2ae4::d83? ([2601:647:4d82:2ae4::d83])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da8e7170sm1241342a91.14.2025.08.28.20.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 20:59:21 -0700 (PDT)
Message-ID: <09073fa7-770b-44c7-8d44-d6a886b2e88d@gmail.com>
Date: Thu, 28 Aug 2025 20:59:20 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: scott.b.haiden@gmail.com
Cc: linux-nfs@vger.kernel.org
References: <528e7a88-9c63-43d4-8c67-50a36ceda8a7@gmail.com>
Subject: Re: [REGRESSION]: NFS 4.2 reports "Operation Not Supported" on
 getxattr calls
Content-Language: en-US
From: Scott Haiden <scott.b.haiden@gmail.com>
In-Reply-To: <528e7a88-9c63-43d4-8c67-50a36ceda8a7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

That got mangled by my mail client, I'll try (one time) to redo it with 
formatting intact, sorry for the mixup, hopefully this doesn't also get 
mangled:

Hello,

Between version v6.16.1 and v6.16.2 on the stable tree, NFS client 
started reporting operation not supported when I issue getxattr calls. I 
simply see:

     $ strace -e getxattr getfattr -n user.hash.sha512 'S01E01 - Kassa.mkv'
     getxattr("S01E01 - Kassa.mkv", "user.hash.sha512", NULL, 0) = -1 
EOPNOTSUPP (Operation not supported)
     S01E01 - Kassa.mkv: user.hash.sha512: Operation not supported
     +++ exited with 1 +++

Before this issue cropped up, it simply returned the xattr as expected.

I did a git bisect between those two changes on the stable tree, and 
found that the backport of this change 
(https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=b01f21cacde9f2878492cf318fee61bf4ccad323 ) 
onto the stable tree is what caused it to start happening. The 6.12 
longterm repo is also affected.

I built mainline 6.17-rc3 and it was still facing the issue as of last 
night, but if I patch a reverse diff of that change on then getxattr 
calls work again.

Please let me know if there's more information I should provide, or if 
I'm just doing something wrong.

Thanks,
--Scott



