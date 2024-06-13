Return-Path: <linux-nfs+bounces-3749-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F3490684D
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 11:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D0528441E
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 09:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0F213698F;
	Thu, 13 Jun 2024 09:17:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F4229AB
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270252; cv=none; b=es3beYsavFsUIA4JzX8ddiL9GeiIWdhRHmcpK7P/SQDOMDI4FI4NuN0KPmXr4c/OBqeC8/ztTKUWyWgWri5fd7TUq2vhxMnipVRsRVE1g/w5WOYM2w0eZ4I+1d/uUv09BqfjVh9wZkarCo4d1VZ3TpYcOHqVkJAjtGf5jaILLck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270252; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kmgk3+dsnvh0VyLaMq++fuy/pmwQHGrS2ZmlxWWAiPBqEXCCpmDGkJgh6BS+naC2O/rSzC4LLV0c2SEq+0WLHSkKveT3VhogbYU2lkhta2OfRXWGAmMCIN7d9hdCfVE8Atq3aNdiQCQDAKzwc60sWXVRtRLZOffyY0ooX/I2zBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35f18e66530so81073f8f.1
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 02:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718270249; x=1718875049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=L7gmEcFN7hlwZbMProYJ9DmmaZBM3uAVhFpW1aSfD+ZNX27DaiYm5iabw+u8dG8u2m
         Fw+7ZyU4ah962ndv0iAdI1ZgZMGY+cEbw1Z734vcpX4iZK1V5Q7B1nTO7xGrOiDthAM0
         yi50YIOh/njt2bYORG0Qt4fQ76w75nD6vVZgFWBUpuOQlvWLBM1LocBsk8B635TaQddG
         S8Jgjr2Y6l0RA3E3a9ciagruSTF/B3L9wWj/ZDlssbtBbjk/kMwbtdLSgUyeQlujfa+y
         cmt/KF2bV6ZB8iRg2KF99VIatySWS4FUrZ1TthjVRyQJqQpAnkyVAinO/vb8kcPRCaKR
         hOFg==
X-Gm-Message-State: AOJu0YyQMejppquo18uFElO3eRwmORs1dqJaXmzqz5BChui+R/2FL9Z7
	giZtVa2lPbzvE+xp4M+nURge3p2DSmN+x6RKtblnn732NG3W9GKM
X-Google-Smtp-Source: AGHT+IGTOYL9B1VLzfrcMwrSpz7znZ8Y01L4MwYXA9/kvDNvgwUlhqiR21NacOuhD8NqSlzXfTQQJg==
X-Received: by 2002:a5d:47a6:0:b0:35f:29c8:5142 with SMTP id ffacd0b85a97d-35fe8913ad2mr3254821f8f.5.1718270248987;
        Thu, 13 Jun 2024 02:17:28 -0700 (PDT)
Received: from [10.100.102.74] (46-117-188-129.bb.netvision.net.il. [46.117.188.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104a0fsm1095959f8f.96.2024.06.13.02.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 02:17:28 -0700 (PDT)
Message-ID: <6872a555-627f-407b-a0fd-9526600caf69@grimberg.me>
Date: Thu, 13 Jun 2024 12:17:27 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nfs: Properly initialize server->writeback
To: Jan Kara <jack@suse.cz>, Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>
References: <20240612153022.25454-1-jack@suse.cz>
 <20240613082821.849-2-jack@suse.cz>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240613082821.849-2-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

