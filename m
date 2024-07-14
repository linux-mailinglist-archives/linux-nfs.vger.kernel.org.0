Return-Path: <linux-nfs+bounces-4885-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DFE930A10
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jul 2024 15:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C18D3B212B9
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jul 2024 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5DD26AE6;
	Sun, 14 Jul 2024 13:29:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D7A8528F
	for <linux-nfs@vger.kernel.org>; Sun, 14 Jul 2024 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720963744; cv=none; b=n0nHaDyxVIJiXNOjut0JRuqg2xzyVf2OVmLQKq/4N/KDp1lN2YuKluXPWh4i8lb835EBi3UarJR2H+kJkCtV50qq/bfttihDLeMGgZlfjN3jUdx6Fquj/0usm7lnrfse6V9ac2EPL3rWN3oEh8Lq76EdABSCe5fC/+WCj2NYmCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720963744; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLkzm6m0WeAE/tC9rGDadyDI6Cz7Wm1j/IxbH66GhPDKOqjerdWfrSIpduoqr10OCJPQl6viaKy9ZP2mWF2vaUqkJXdBqMIOrboAq7L6YN1EfLq5o/oUxlgXfSYl4tVicgZhYeam99jRCwbTjoyB1QNrcSlTNJ4PpmdZC7I05yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3678c388f92so292058f8f.2
        for <linux-nfs@vger.kernel.org>; Sun, 14 Jul 2024 06:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720963741; x=1721568541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=qYt8Y/z4HP3fgJ6vgoU5TQQaWtyC15YYWUQSWJuop8RBjtdrQWRv+Djp4Uz4udDx2e
         OmzD3CccTqX8RKVWDqaPnOn80Iq8Bxt0AnYwjlDjIPk5hGUriLQSPucwtFnG1HP47Fnl
         2rkNXToPIzAqx3N39w6lCznvzWNGdsl3DHmFS7rB4lb5jdkdW6/hmnSaxJ7KmD8dDK45
         FKmXU18shfnBT14i3N+yRW/gDeasfO9U/ziYYykMsGqnhu92VdKfRuWOizQlUfL8ltmb
         ty4X0FEFijUpr670t8HLu+4bSAZ2xEuGxS/3fW14TeMTrJEHIPM2MN8V7B27H72LAMp9
         fHEg==
X-Forwarded-Encrypted: i=1; AJvYcCV9SifA0oZ7viffB+3Mvgb3QtC4iArVUgqcaTO2nPuxsP74DP4aXqlIVgHXUl4kZN7FCYdKwLyNmdqg9larTI14yJNSUPLOTj2z
X-Gm-Message-State: AOJu0Yx3sdJq6TyliC9YpCS2T5tiLNoAQ7x8GYm+ESgAGm+Nt13DvUqP
	fPXz7mJLKegykXstLUsNOXDTjsZnMH7BDqJa6yqL38wUjX12YQNP3b9sGv+/
X-Google-Smtp-Source: AGHT+IHqnZM58MCjKil4yuccrkFOR8vc9t41GLjlt1ajhGSqsdmSdCg0pjsRl1hU1NiPLQW4AZ6vpw==
X-Received: by 2002:a05:600c:470f:b0:425:6962:4253 with SMTP id 5b1f17b1804b1-426709faff4mr100683975e9.4.1720963741482;
        Sun, 14 Jul 2024 06:29:01 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f25abf0sm86965635e9.14.2024.07.14.06.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 06:29:01 -0700 (PDT)
Message-ID: <c22b8889-22d2-4ec6-8419-3c88c90e1a22@grimberg.me>
Date: Sun, 14 Jul 2024 16:29:00 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nfs: split nfs_read_folio
To: Christoph Hellwig <hch@lst.de>, trondmy@kernel.org, anna@kernel.org
Cc: chuck.lever@oracle.com, linux-nfs@vger.kernel.org
References: <20240711071703.65793-1-hch@lst.de>
 <20240711071703.65793-2-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240711071703.65793-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

