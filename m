Return-Path: <linux-nfs+bounces-4810-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41D492E83D
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 14:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF6D1F257C2
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 12:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E4215279A;
	Thu, 11 Jul 2024 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="RKMoT6U3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B8314532D
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720700774; cv=none; b=lPbaaTOnpNds7ezSCHTXS4g3nvJb6qI1NsNGm5gMzqWObRb6qSO/VypsZ1kXFgtBxKxw4PPYSirXuDLKayGRlA/Hp3XuHn8nU+HJIe4fNfJv6rP3hMigPbX+icVA/URwWxWOu8P0WnEmPqLiUk743Y2afHsyXxnjM74fSxmTLiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720700774; c=relaxed/simple;
	bh=xqBRf1MqIbcNkhfJ9d/Lqxlb3zqRR1KamCZKr2HQ1+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YA9MbFN9BjJAV5UbKQ2fnaTLnvf/2zXv4ubFFkdQBfLmhxVdGIENrCyE0cp9yP/qS9dTOD8MnZsIvM9wSoAcUbHghJJp/WmdkGHhuOTr1u8e5tw873dq1/1w7XiKhlAjzFPSn1kKSYFflV9YC3m19jzv7KI4FW/Apv/3BdhVwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=RKMoT6U3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266f344091so6795615e9.0
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 05:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1720700770; x=1721305570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2Eu+1tIrcqP9l98HgiMS21yPuFxdhMkVUzzdNluv+I=;
        b=RKMoT6U3n8vnwp+92a8BNJOZkqjPIGPqV5hLtMU7ogtuwNZCJEsk04d49xwVZUor6a
         vNyccDX5pMTn0NsryAioHE0y68WfsFpyUw3KscAdyDED2j+TX5DGS8Xpq1VzgyLREMRi
         AgTsUaxMdObhTml3XSEL7PrVz5lKdFLkYTboO8Wa8Yhf1nh6Dzwab+477XuD4jTjRK+a
         KtKHrgKYWsCxYrOQcmAmC3h4cOS0UAix9ozyRS+AEorabrlFxBpDgV/QbOv3OF/9k8Ow
         C7ECTrQIK+XCOG3oq9Lw95zTdkWXx7qza6j1W8LafGysCWYXmKFjeOwuBUFDDrx9K6Q5
         GLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720700770; x=1721305570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2Eu+1tIrcqP9l98HgiMS21yPuFxdhMkVUzzdNluv+I=;
        b=EuUvI2dLVfETaoXTTaEqhvRyaO1bQKVWJjp8KbW4hPZnogQb826JM7mxCjSH1OlEJq
         Ss5LCqt2Hk+wrrtPWILDg3GC/BA7BtskNvAVKH14Ma6H1bQ3ZLjm8D0fc7PkjR/2lWgo
         OYWtxSe741KTtt/HPpYqN1YiDV57pQnBVraDblADFtGh78scGn6M7l7/AEoAXkiVZj17
         cUFiSwpDVcBaGqISm34nQ5HnlzCev0ox6qtWVt0sBQ+h27xWqIGS6g1UCWY+ZNITdn6+
         AfiJW8a15HgY6T2xuInvhOMirXKk7mGK+8J8+hZ5/l1avLjeAVH9c/gbnC1gvxd+zFgb
         gsfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2pq+9K/AAk0tnTybgW7xGCQo4egdKW5c/T4uekfLE+xL7XJuPnJwH7nrgtbJUWkXjBTZi8ICnDW2cmnaNU1VkvV+WAB8CEb/6
X-Gm-Message-State: AOJu0YwxI5NavGAd/eMe1SYCMEpd0xXx+nBnixNdWdCvK/VNh7StTAUW
	uBpk0tEicoaiVqQ/oxMgvi69zWEmMjZjQQdF7CzDvoqxExM8D7MetR6pHTb+jjE=
X-Google-Smtp-Source: AGHT+IEoH5WHNVSj/ZGmkY066xfs0t5cGTvEHlgpctmL2QfSKiDy1waSbK+bVZBHyTk46jC+Scm6Tw==
X-Received: by 2002:a5d:47a9:0:b0:365:32e0:f757 with SMTP id ffacd0b85a97d-367cead5db7mr7032671f8f.50.1720700770339;
        Thu, 11 Jul 2024 05:26:10 -0700 (PDT)
Received: from gmail.com ([176.230.79.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e046sm7698432f8f.5.2024.07.11.05.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 05:26:09 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:26:07 +0300
From: Dan Aloni <dan.aloni@vastdata.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] rpcrdma: improve handling of
 RDMA_CM_EVENT_ADDR_CHANGE
Message-ID: <20240711122607.4kjooqqjzweqwwxv@gmail.com>
References: <20240711095908.1604235-1-dan.aloni@vastdata.com>
 <20240711095908.1604235-2-dan.aloni@vastdata.com>
 <a4811705-b72f-4a1a-9ea8-11435b002259@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4811705-b72f-4a1a-9ea8-11435b002259@grimberg.me>

On 2024-07-11 13:11:11, Sagi Grimberg wrote:
> 
> 
> On 11/07/2024 12:59, Dan Aloni wrote:
> > It would be beneficial to implement handling similar to
> > RDMA_CM_EVENT_DEVICE_REMOVAL in the case where RDMA_CM_EVENT_ADDR_CHANGE
> > is issued for an unconnected CM.
> 
> I think Chuck has a pending series for handling device removals with a
> dedicated
> ib_client. So one would have to rebase against the other...
> 
> See: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.gittopic-device-removal
> 
> Other than that, looks good,
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

I ran some testing with `device-removal` branch (merge fe4cef916d91
v6.10-rc7), and found that the `RDMA_CM_EVENT_ADDR_CHANGE` fix is still
required and independent of the branch's content.

And for the second patch I sent, which fixes only a theoretical issue, I
think we need the `case RDMA_CM_EVENT_ADDR_CHANGE:` branch to implement
the same logic like the removed `case RDMA_CM_EVENT_DEVICE_REMOVAL:`
branch.

-- 
Dan Aloni

