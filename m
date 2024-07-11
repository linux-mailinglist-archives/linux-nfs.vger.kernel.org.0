Return-Path: <linux-nfs+bounces-4795-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DA292E42E
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 12:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B580D289279
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4F0157E93;
	Thu, 11 Jul 2024 10:08:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B085CDE9
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692487; cv=none; b=oyFUaoCnaDm2TJpLkgxRFaLjhSuI1+o3+KjbTRHW1xjX+ASfAS68pS7nHus1Vma2ZQaMOX0363Ok3o259GJo99bIVmAhHgPjTaNPfwPbXms89nwktTMdWm/URbJcXq4/o0VpnA8Olb67Qypiej4OoJUhiCHHa0t868MZxLmYfUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692487; c=relaxed/simple;
	bh=8w1kIjq/QH8NCq7TyMS6VWRcdT0AfDYZnIW/iWkVqIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5nDZzSG+yMtZyLtaH6lZFBAX1qIhFCwbvRiKa4rbzbzqtZXVEIoC+xGEr4kxeCKLwHQ4CphP72b471+/mPALoi19sBO7TncD7gEKjQfEmyPDoy5wb/cnRWl/CVpg+SVJmRz1GbAxHnSE37+SxPNhVGO/+Y1+1xbf2sNaVrjzeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-426ff626778so442625e9.2
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 03:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720692483; x=1721297283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOw1xL4XHhTZlrF1GwZqKhS0+zZtzEZWgnsFa3Dxk8A=;
        b=iVrWN4u+feoJi2WFz7MwwLuH/Xez2OJdo2yOPpbpqikDh0x2/gw7fMYVr7FOIZ5QEV
         tQAGIBgKOKo5OjMc8bXBhghMmvMVx1JRLaMe7odAY4PJ6vS/38T4RNWFKb0/vvh+GzUP
         rcG+MlEikzWjmaEV5jvITCnqsDQbMp1zy+JeKFKWY1kOKOpOq/mgJoP37AI3+WCLXiRG
         BJkFkGGqKg3UEl+ROtDuRFrn0X4oir2vghZnpk7S8Gu2YfU/9PQ0BuNky3XFbkZTIZ78
         X9i8m3cg06dE7nfdIO6LqGuUpdxUqjqdcRMvmuVDTX2Na5VA30Bj7EBlPjLRwERGPbwX
         HV1g==
X-Gm-Message-State: AOJu0YzAHEhoEzyMqE571fMusYpEBrCO0aIiNPVYeCJJ76e9ephY31Ul
	4CD6zBCXgAaimzozeQCTkr+Zw57VawI/C8IEPZJgRxUrgvxwJ6bv/K+hEDJT
X-Google-Smtp-Source: AGHT+IGuPvHCMs+K3/55L/UK6KSkArcQn5LQ8YEbpgGOCPevANue7PjUSDSy0cDBPjOG/JHPSIc5FQ==
X-Received: by 2002:a05:600c:1c96:b0:426:6ecc:e5c4 with SMTP id 5b1f17b1804b1-42798364b42mr12345285e9.4.1720692483379;
        Thu, 11 Jul 2024 03:08:03 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e02esm7354939f8f.3.2024.07.11.03.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 03:08:02 -0700 (PDT)
Message-ID: <11b327b2-4953-448d-9807-f22434cf0070@grimberg.me>
Date: Thu, 11 Jul 2024 13:08:01 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rpcrdma: fix handling for RDMA_CM_EVENT_DISCONNECTED
 due to address change
To: Dan Aloni <dan.aloni@vastdata.com>, chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org
References: <20240711095908.1604235-1-dan.aloni@vastdata.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240711095908.1604235-1-dan.aloni@vastdata.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/07/2024 12:59, Dan Aloni wrote:
> We observed a scenario in IB bonding where RDMA_CM_EVENT_ADDR_CHANGE is
> followed by RDMA_CM_EVENT_DISCONNECTED on a connected endpoint. This
> sequence causes a negative reference splat and subsequent tear-down
> issues due to a duplication in the disconnection path.
>
> This fix aligns with the approach taken in a previous change
> 4836da219781 ("rpcrdma: fix handling for RDMA_CM_EVENT_DEVICE_REMOVAL"),
> addressing a similar issue.

I think a code comment will help here. This whole handler is not very 
intuitive (but
that may be a result of the rdma_cm state machine, the picture in other 
ulps do not
look materially different).

