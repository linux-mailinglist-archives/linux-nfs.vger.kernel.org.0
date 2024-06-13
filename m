Return-Path: <linux-nfs+bounces-3750-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC189906865
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 11:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482922844D7
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 09:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1680113D8A6;
	Thu, 13 Jun 2024 09:19:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661CC13D26B
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270343; cv=none; b=uHuMliE+nkA48UEpZafqWzIRsjuVwy3sKqP9JV0597YWNEtwwSbLQqm2InP6Z4LSDEQSe83M55c1thvkpIqk1cIb6cnUsZ7DNG+z4jDCkF5rLHWCBFBteZ0S6tQNuyzHcWTaDRDS/+KgbqFbI2ArLcZIIg5PoVhpsDllCdKZnkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270343; c=relaxed/simple;
	bh=sY+rV5gM0DvrpbhxJfj6lSbu5/W9HLT+PWNGVs20Bdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+N6CDsU9CBPY1nr1f/TIZ54whAt7Nw+l0/L3QIy1Ay2iosm3Qoawsjxaheeuco6wJuCDLrdUgShcp/gLFEnB8ckeI9fhtUmZhcMRPyudCVnety5jmMkmBgER5fP7iW2dxcqudL99FgNW1lwgr8hESYpeiXpH8J0QB/+WQStaEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35f23f3da48so92856f8f.3
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 02:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718270340; x=1718875140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2l4H9/0TIhbVDIyz7qFryNEMUcK85C7IqEThXzsBJ4=;
        b=EQrbI8BrsT292bf3xUatAgbIdQz6lXc7YOiONwD6ELOoMqbocx3yegp7k8fMItejoV
         rYOGIMLkyITI2ACnf13HIAQ0bIE6tMJYUSB/W6xlhlzRW/+m6yigHhmIaR9hxEmn1aym
         konZ2Bf6KMWkX2hcmVurL3dVZBg3dP67+zSWFsgo08hi4FRxuZL1vcncP7VFuo1pHaMP
         2ZzN/pDnB+13pSeE1KwNZJwcgVEFA+13A+5K0vo/y3h8eewW1cnFUHSFY/O08YtBPtCc
         ALRXEXvkCFYQd1KkcIzPf4ir4nunChRrCiLr1FDFoXGEYAItn6viapE3OJ9ibjGP7F+D
         lzAA==
X-Gm-Message-State: AOJu0YyFwnPB4LBvIp7idWDGFt+7TX/MN5/Vn2sz1ntqv1vZs+ZKsdzW
	ghJgai+6gCcw8oL+iq+KQ7OFb/cIgsr/F8KoEVcSFBmqj0TnJ47q
X-Google-Smtp-Source: AGHT+IEqh0EuPNkmztGv3Jo3v2oq+8dLqHwqMw+ALoAyK6vP5V8Utu87W7gPEK6BAAoUEyDGifVIQQ==
X-Received: by 2002:a5d:64cf:0:b0:35f:247e:fbcb with SMTP id ffacd0b85a97d-35fe88eb393mr3206569f8f.2.1718270339506;
        Thu, 13 Jun 2024 02:18:59 -0700 (PDT)
Received: from [10.100.102.74] (46-117-188-129.bb.netvision.net.il. [46.117.188.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075114dcfsm1102326f8f.114.2024.06.13.02.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 02:18:59 -0700 (PDT)
Message-ID: <6db728ea-8dc0-4d38-89e2-6ad7df537baf@grimberg.me>
Date: Thu, 13 Jun 2024 12:18:57 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nfs: Block on write congestion
To: Jan Kara <jack@suse.cz>, Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>
References: <20240612153022.25454-1-jack@suse.cz>
 <20240613082821.849-3-jack@suse.cz>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240613082821.849-3-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2024 11:28, Jan Kara wrote:
> Commit 6df25e58532b ("nfs: remove reliance on bdi congestion")
> introduced NFS-private solution for limiting number of writes
> outstanding against a particular server. Unlike previous bdi congestion
> this algorithm actually works and limits number of outstanding writeback
> pages to nfs_congestion_kb which scales with amount of client's memory
> and is capped at 256 MB. As a result some workloads such as random
> buffered writes over NFS got slower (from ~170 MB/s to ~126 MB/s). The
> fio command to reproduce is:
>
> fio --direct=0 --ioengine=sync --thread --invalidate=1 --group_reporting=1
>    --runtime=300 --fallocate=posix --ramp_time=10 --new_group --rw=randwrite
>    --size=64256m --numjobs=4 --bs=4k --fsync_on_close=1 --end_fsync=1
>
> This happens because the client sends ~256 MB worth of dirty pages to
> the server and any further background writeback request is ignored until
> the number of writeback pages gets below the threshold of 192 MB. By the
> time this happens and clients decides to trigger another round of
> writeback, the server often has no pages to write and the disk is idle.
>
> To fix this problem and make the client react faster to eased congestion
> of the server by blocking waiting for congestion to resolve instead of
> aborting writeback. This improves the random 4k buffered write
> throughput to 184 MB/s.

Nice,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

