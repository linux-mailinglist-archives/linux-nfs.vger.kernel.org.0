Return-Path: <linux-nfs+bounces-3071-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2898B6B6B
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 09:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1311A1F20CE1
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 07:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3956C39877;
	Tue, 30 Apr 2024 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY3sEgpg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FF22C184;
	Tue, 30 Apr 2024 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462021; cv=none; b=n4eVtPmMjfMt+9bcPQ/lOg/AA5UxShbw2uQZJ5kzj+tmMrFjI8vnctYRSkQyWY0ULy79NkrYvzeC/OM1GeBAiqglK9fSvUo4Ap4cCNvevrP2ntEakwpVKl+qcrMV9PxjUFlRw8gMv0KwJvHCM6zRIBZLyu7LL373ZMRcuT5y09w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462021; c=relaxed/simple;
	bh=AU9VBPCyka6MfWLwdlmgIII5wkDhOdKQS5fOf/7G9o8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mdicxccjYD6Ol5st37gMHcK/cpSn1YGUppoiGoiUMDYmSHXPj33R0iG/9LWc5dJmESGZdO1S7mrWkaVzaNOLI10XTNu/yAZEfOV9RgmxAX04i9GSsmwiVFiDW0mQEfWLy37cIW2SRvnr13FiPg3X6YLLzyK+IXABX+jFF7keteE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DY3sEgpg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41a1d2a7b81so35996725e9.0;
        Tue, 30 Apr 2024 00:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714462018; x=1715066818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eZql9MFP/EeIBzT5IBmO3UFYk0DgE3ysNQKZ2l+KFMI=;
        b=DY3sEgpgH81BWxurBJZuR0T7hi5gfcePcBUFWztHmNLLxMj3K/eyyI9WYAoNyWjTrh
         NLiI44/dp4dBbmlAm/G3A3XflwIIrfdg5fFHyWNXuWkkI3iQI6aAhaNoPh0lif4awko2
         BtYvJkJNYkvFrV9YUYLZ2LNeZC/3v+hiootTAVpjYbhNuiJlc42kOVoCol7MOv5Splsn
         9XMXgep24YWAtocdhjPAH1rE9IGNz4Gh9dVTtVr4vEYOmfhBzS2pAe9TKIsT/SUJC1Br
         vUUsCiIW2dXz/OIxZO5rDlIidJ+/OUSfm4d1Uh6v79ZEjbZA3ZJf/+3LDClJH+Eq1lVM
         KZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714462018; x=1715066818;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZql9MFP/EeIBzT5IBmO3UFYk0DgE3ysNQKZ2l+KFMI=;
        b=I/4E67V/Merltrs/SVyG3g3hEASOQOCyFEyJzbDbO7E0PdBvDmJa4oKpfebDtAGjkA
         t2WR2O9QalyiKBCkBoNUG8Tzii/pjsaRRvm+3mq/bvce8awWmBNEWslBwcypCV3Tka6r
         wcqMf94bAi6eo/hqPeiQleXyVqyQk6QkYnD6ZltALhKFlBDxNrGVzZvYQJJZgbsc7Bei
         +31Hc/RKgABki8h9l9+tVbDMwGy3iYxDCLZh/wVYh8SklLwQYNwaYm/lj8vUnRd72icT
         1vdwizAZNIkoFXBqvZ2X/y6XJS3nmxhOS/q2xpdEvjEHpMwB9LC8OgwPW1m7GVOhgBCN
         6lvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgyYTXDWoNfTa6GA7B7YrXoiXgXGpe8+n8ZqGk/M7gfGOLb2tT4NbfDkTwvw9ppQzZ5gGVaaonWPB8aqo8YNejqfo/OANrBmz6nOMpA0xoSyooSP4G/Plp6eN8xiqheL8BCe5Hkw==
X-Gm-Message-State: AOJu0Ywk57GS9zt6gxM149FNFzeqHWAvdxBCjrsOEOFlB0d4L2+oSM5X
	3teRtfN3/wKmvN9T6S2IHpbpe0nGovXLNFgscpnEuhwF/9AjSpbu
X-Google-Smtp-Source: AGHT+IE9nskZxJbKioU9Oi5ATsIg2zI45SUo0Ms5aEEx5AKhNj/zx5S6nL5zrzuZs5Nn5QrWbXdTVA==
X-Received: by 2002:a05:600c:1c88:b0:419:e3b9:b384 with SMTP id k8-20020a05600c1c8800b00419e3b9b384mr1581428wms.11.1714462017725;
        Tue, 30 Apr 2024 00:26:57 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id d18-20020adffbd2000000b0034ca136f0e9sm8013889wrs.88.2024.04.30.00.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 00:26:57 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <efc4f895-3a45-4b44-a47d-532896526458@linux.dev>
Date: Tue, 30 Apr 2024 09:26:56 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] NFS: Fix another 'check_flush_dependency' splat
To: cel@kernel.org, linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>
References: <20240429152537.212958-6-cel@kernel.org>
Content-Language: en-US
In-Reply-To: <20240429152537.212958-6-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.04.24 17:25, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Avoid getting work queue splats in the system journal by moving
> client-side RPC/RDMA transport tear-down into a background process.
> 
> I've done some testing of this series, now looking for review
> comments.

How to make tests with nfs && rdma? Can you provide some steps or tools?
I am interested in nfs && rdma.

Thanks,
Zhu Yanjun

> 
> Chuck Lever (4):
>    xprtrdma: Remove temp allocation of rpcrdma_rep objects
>    xprtrdma: Clean up synopsis of frwr_mr_unmap()
>    xprtrdma: Delay releasing connection hardware resources
>    xprtrdma: Move MRs to struct rpcrdma_ep
> 
>   net/sunrpc/xprtrdma/frwr_ops.c  |  13 ++-
>   net/sunrpc/xprtrdma/rpc_rdma.c  |   3 +-
>   net/sunrpc/xprtrdma/transport.c |  20 +++-
>   net/sunrpc/xprtrdma/verbs.c     | 173 ++++++++++++++++----------------
>   net/sunrpc/xprtrdma/xprt_rdma.h |  21 ++--
>   5 files changed, 125 insertions(+), 105 deletions(-)
> 
> 
> base-commit: e67572cd2204894179d89bd7b984072f19313b03


