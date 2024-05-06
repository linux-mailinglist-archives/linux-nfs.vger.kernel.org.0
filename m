Return-Path: <linux-nfs+bounces-3169-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334208BD111
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 17:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25262834B5
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 15:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B292615383A;
	Mon,  6 May 2024 15:09:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF09F15359F
	for <linux-nfs@vger.kernel.org>; Mon,  6 May 2024 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715008197; cv=none; b=Tc8GHXv0w5ak4e6sJ1TSxMJpjho6Ge5jh1apkIQd5W2OeqXc+ZoBeN33eml3A7D6qp4jCwiI30OYjt2fnhic/OiiWrR9WXqw17X4aUOH2GYkc4RLMKVP9iqBG0uh0ENVvm/LBfWzwk4O/blnH7bI5ebFBPcuOj+hmX1xhdWVVdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715008197; c=relaxed/simple;
	bh=G+aJA5tsL09tVDaFvKtVUUUxKn4Vrzc5FrSF1Wc6qGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alB3fPm9PP0AAQLzZtxigQ9yIlBMz1DOqdqgV/r7vD0sqg/3MIKjfB++6KvVmAsFQlPBA9Sq2YYGIJxDig6emqPLnE+yWNjDAAXi/s0ptgpFNmG7jTByFsEVtSbP2NK3dOpbZeGwq8D9S5D8ZKXC24ikyBLwYjNDMib9FNKc4ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41c26dcc3ecso2821615e9.2
        for <linux-nfs@vger.kernel.org>; Mon, 06 May 2024 08:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715008194; x=1715612994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btVm2PMmI9i2swb4+MIPwGQwWs5KmLyFW0t0rAs/Pac=;
        b=AOSiEdiUtLx0ePzozyj0O9i22drcz2Wlpjg6gO9qfbGnrkUejtkvJTdVAUbIlhy/8n
         HB70mYWNJRtpsPodHii1xVG5bApZcXc24MJDmEFoLvJSCGnrhttXSNK8/sSKVsUG5ziY
         Y1Qs3ZXHdXLtdU3KaV0WllcgcwJL8iFcpZs0Kvfl4W4HYWk4feiZFpV5DKPeRJOriurS
         fl10hPOrZF9SqKdAiBah7pG2hp9uOH8WVoXArzer5wg8PnnvMJsdIpoQJ+rEUXZMbeDk
         cc3zFZ/sFkWte22ltMY8Ph3DiZJjSnTsJSTDBplJ47TwsgpmFr2LB+qzsvlwIVWND1i5
         fxmw==
X-Gm-Message-State: AOJu0YwZRzOY7iv/m7I8QxBlJK5MOlyiF4mdh6WLkB4EVqKof5WKPeKD
	SP4rorDcgvmL2BFZg6DwJLiZtMqIwcsPXMqN0pIJQauIgFNvHfo2
X-Google-Smtp-Source: AGHT+IEAvUxYNmeMbPf2wVyHQncnzwNgAteHInSBOnAu5zOF3mGPvS6Q9Z//wh1b2Xnq87qKB6TONw==
X-Received: by 2002:a05:6000:a83:b0:34d:756d:e43f with SMTP id dh3-20020a0560000a8300b0034d756de43fmr7387381wrb.7.1715008194094;
        Mon, 06 May 2024 08:09:54 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id c10-20020adfef4a000000b0034a3a0a753asm10835971wrp.100.2024.05.06.08.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 08:09:53 -0700 (PDT)
Message-ID: <be4563e5-caa6-4085-98a9-a86e24c99186@grimberg.me>
Date: Mon, 6 May 2024 18:09:51 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rpcrdma: fix handling for RDMA_CM_EVENT_DEVICE_REMOVAL
To: Dan Aloni <dan.aloni@vastdata.com>, chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org, Sagi Grimberg <sagi.grimberg@vastdata.com>
References: <20240506093759.2934591-1-dan.aloni@vastdata.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240506093759.2934591-1-dan.aloni@vastdata.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/05/2024 12:37, Dan Aloni wrote:
> Under the scenario of IB device bonding, when bringing down one of the
> ports, or all ports, we saw xprtrdma entering a non-recoverable state
> where it is not even possible to complete the disconnect and shut it
> down the mount, requiring a reboot. Following debug, we saw that
> transport connect never ended after receiving the
> RDMA_CM_EVENT_DEVICE_REMOVAL callback.
>
> The DEVICE_REMOVAL callback is irrespective of whether the CM_ID is
> connected, and ESTABLISHED may not have happened. So need to work with
> each of these states accordingly.
>
> Fixes: 2acc5cae2923 ('xprtrdma: Prevent dereferencing r_xprt->rx_ep after it is freed')

Is this actually the offending commit ?

commit bebd031866ca ("xprtrdma: Support unplugging an HCA from under an 
NFS mount")
is the one assuming DEVICE_REMOVAL triggers a disconnect not accounting 
that the
cm_id may not be ESTABLISHED (where we need to wake the connect waiter?

Question though, in DEVICE_REMOVAL the device is going away as soon as the
cm handler callback returns. Shouldn't nfs release all the device 
resources (related to this
cm_id)? afaict it was changed in:
e28ce90083f0 ("xprtrdma: kmalloc rpcrdma_ep separate from rpcrdma_xprt")

The patch itself looks reasonable (although I do think that the rdma 
stack expects the
ulp to have the rdma resources released when the callback returns).

FWIW in nvme we avoided the problem altogether by registering an 
ib_client that is
called on .remove() and its a separate context that doesn't have all the 
intricacies with
rdma_cm...

