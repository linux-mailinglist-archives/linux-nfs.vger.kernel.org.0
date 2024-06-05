Return-Path: <linux-nfs+bounces-3562-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A348FC6DC
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 10:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E040AB212B8
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 08:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D187049647;
	Wed,  5 Jun 2024 08:45:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F954964A
	for <linux-nfs@vger.kernel.org>; Wed,  5 Jun 2024 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577104; cv=none; b=H5mGy0iLU1DsyniF6XRCveag616j+UqFWyb4XBbnzIbficMKtXjH7VvqwbU+merWH7a2PgQUn2X2Q7/3UgccjzvYggCmXLozdw1r36vpHW/o+H1yf09KXgU7fEitzyBTSyN1VuTaPyg9ddGzPA5ibIBNO2Fnn4022GEd6KRKvzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577104; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erLYLRurHJKyanne2xGwi44yTnGPMbmJXxbl2obV/RA1sEFWPVFSnlotbom35uNi5pmDvP8qDTHxIJogYV0vc8J41iOKHSBiSHPMhl4AI/ewqoOkITTSXC5GysnLGzp4X9w8vy2aMjm7TSX50bzdyOWMryZhSouH/sgBCYD3OYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42111cf2706so6681025e9.0
        for <linux-nfs@vger.kernel.org>; Wed, 05 Jun 2024 01:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717577102; x=1718181902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=p9DC4ahQBua9gRwBEV42XyNpYMgwaTIT3B1BAa7RJrp2xCY2XoWxxYkpXEZTlo8oM+
         i5w3+Y0dF3Kot5BtRAo81HtU7g3ilxiixjlBnWm0TsvFKphFS7z9cfm1Y4IkhcjtaE7O
         GDcZqsutiN5H/rZjjp1N0fp2zhTQwdD2U15eXcbfF/pzUj3QV4kyVtbsUg/C1s5oOxd4
         3xbbWk0v+XTV0LbGn05vyD1irhP2YsQS1/NMDZrVRTFmOgOPQ9x8boNlxx+TrMILprpI
         aeZwrO0Zz+EuU3vIwEwKPzUeSVqONOalV3qrkW86/hBCZq/PT3pt8IVYfsTxucz7jTlX
         TcVw==
X-Gm-Message-State: AOJu0Yxg0D5Acvyn79CLpYAABXKKB2Jcr7CjL2JcmH6h+k/i0MGpkGF1
	C3FFpMaYGrwNQ1xPUJZ29MRYl0kqSTWtu2FkSYvwSDnidkranLUF
X-Google-Smtp-Source: AGHT+IHeK56elHLJDzqcc63j4Yp2EUWeMqgDhtMuSwTBlT5Sf68s/E++1yjOObwXHBOnaPgk/M69zw==
X-Received: by 2002:a05:600c:35ca:b0:421:54d0:5129 with SMTP id 5b1f17b1804b1-4215635324dmr12870235e9.3.1717577101583;
        Wed, 05 Jun 2024 01:45:01 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158102a9csm12505635e9.14.2024.06.05.01.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 01:45:01 -0700 (PDT)
Message-ID: <f4cc0a6c-39ba-4d1b-a306-6dacc6511ecc@grimberg.me>
Date: Wed, 5 Jun 2024 11:45:00 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] xprtrdma: Clean up synopsis of frwr_mr_unmap()
To: cel@kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20240604194522.10390-6-cel@kernel.org>
 <20240604194522.10390-9-cel@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240604194522.10390-9-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


