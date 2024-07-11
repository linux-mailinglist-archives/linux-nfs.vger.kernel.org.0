Return-Path: <linux-nfs+bounces-4796-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C28D092E446
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 12:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478AAB216BF
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 10:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892A61527A1;
	Thu, 11 Jul 2024 10:11:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46C514E2F1
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692677; cv=none; b=e3Z4NwOQd20dAXNzkFbz2NzhOvZAVrcRVA0bPSX1XhbrCcM31wRZmOZfIF/tfZn03EWUP/7ZtrLGbVhOe7O6kkzfWhdf28BhAXrxxqUUjiatJgJCBq976mGsbQs5huwAVyggCVcSUNK0KR+rBCHuNxCsIEdGDDVXmULcSs01WXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692677; c=relaxed/simple;
	bh=RNFZdcyCboRm7+e9Iwv8AoqZh62hZok+R2Fk2KG/qf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnfOmb/Kj0E9gIAA73cXf0hud8misTjmqhnAScIz/dxFyFFHDqOaBWJx9/mVST1svrOH/3AprDTRK+dIx3oJ93wHwo4+FiNZyNutEJ/8953JfFxeJkHQBj3AhWXo7XrVei/L36+HwJTXt9B/OJRP5+f/iUdzaCzTVfvmLv3ucrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42671c659e4so443995e9.3
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 03:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720692674; x=1721297474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/hPFhI1KddiGJt7tvOYZXrrD/wSJCIduHna/79+J9Mk=;
        b=ZXlD2DdPWmSdWkQWxkqrLjwu2aVGvwZQj20bt0EVUfFZ0a0/a/HSPvGfGo2YUTjIJQ
         hXvsd9lyV5/Q8L+3Rg7sjHOCbMDRjII1XY/4TdMAV7+osS9NQo3dXtNDf+14rKzOTHg3
         s17qS6T7fANOQ+XlDopASAgKJHW8FwWeNezv2AX6+1feUltjBakW1x7t5oqGVUaANXcB
         rK2a1+6P91LnzSrH5MrfJrT19RtCvYylsZDBeNX7HDTwUy04ZWDAyt1+PUB5pR67ZNyD
         DjHlhCmhu/5Rq6BsqH28XlMJW0kwzwm16twinbzomy/Rcy3ncEHRFAYvmWWLOtat/cvF
         aZEg==
X-Gm-Message-State: AOJu0YyT0U6M8huJW76pC2Y3l6/fvPORtwV3XBemnbBGKw7t+XHTGLus
	xJnixFV5kEEg0PcmJmcMX1jR9EG1soLG2JOo/GDmzoNbKqorANOj
X-Google-Smtp-Source: AGHT+IHv/kYPBDowvgDnGENyrGMbGkefq+F79D0rLaH1bWEXoNNHb3EdgvcpLF6bsDuD6oxP5OxiyQ==
X-Received: by 2002:a5d:6489:0:b0:366:eb60:bd12 with SMTP id ffacd0b85a97d-367f05a545dmr1261847f8f.3.1720692674037;
        Thu, 11 Jul 2024 03:11:14 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e17csm7420705f8f.7.2024.07.11.03.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 03:11:13 -0700 (PDT)
Message-ID: <a4811705-b72f-4a1a-9ea8-11435b002259@grimberg.me>
Date: Thu, 11 Jul 2024 13:11:11 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rpcrdma: improve handling of
 RDMA_CM_EVENT_ADDR_CHANGE
To: Dan Aloni <dan.aloni@vastdata.com>, chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org
References: <20240711095908.1604235-1-dan.aloni@vastdata.com>
 <20240711095908.1604235-2-dan.aloni@vastdata.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240711095908.1604235-2-dan.aloni@vastdata.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/07/2024 12:59, Dan Aloni wrote:
> It would be beneficial to implement handling similar to
> RDMA_CM_EVENT_DEVICE_REMOVAL in the case where RDMA_CM_EVENT_ADDR_CHANGE
> is issued for an unconnected CM.

I think Chuck has a pending series for handling device removals with a 
dedicated
ib_client. So one would have to rebase against the other...

See: 
https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.gittopic-device-removal

Other than that, looks good,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

