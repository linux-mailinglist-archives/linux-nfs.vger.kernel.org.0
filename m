Return-Path: <linux-nfs+bounces-5192-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B06C7940E51
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2024 11:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69079286643
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2024 09:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5BD194C86;
	Tue, 30 Jul 2024 09:53:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABB6194C78;
	Tue, 30 Jul 2024 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333198; cv=none; b=TRTbpt1X9L//FovYEoHTrgtBqAl8oj4E/jy2QmDrDdEOXvypE0MtTYms8SlwAG4PCcwMsQE+IP/wE3BY0QxTjyRBiVHNSoZcBMOZ901Axbhxn6Dd5s1G9n7mnKL1IjUROr/6izlmVMN+zQpXtRG+FhzLUVLiLWOiDlMqx2C8Hlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333198; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GmhjAdhLsP2Lwk7lFqBt/+GwEAhjbqS6cwsdFpn05pj6b1QcrHDR+67N6IHGOnPCqj5LNfpyu0cUz/oGT+IJHZvJdls5GdDOyyEX2N4YPf9Tl78/3ShBVuDLW0qf2+R5AJQwVSUOonW2Cpqv6wE8Go9oAMtCDnyUyiIe94kCW2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4280ac10b7cso506685e9.3;
        Tue, 30 Jul 2024 02:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722333195; x=1722937995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=FHjpB3uJcUO4mlf+jIsXk/Y7BSkL1HzdZYmawL4lz9LN4euWEbc1YSEWLqLozMNsi9
         qqsolBuDl9sZoZf6Rrs2q9eYHxv4o1T9T2GozeHTvwoZmaanjWeHcJij8+od6ED9MfgO
         HsNlGR7oGSC9OpxyL/wi5UBpUapKyn9dwhNNf5rzply48VJB2cnTuPN9Iy81aW2WIpR/
         kJuww3btEiVMNEGtZup8PwxrObh4+xhaPVaaRGDfgZkcdnS6Nr67XOiAgjtaGSWhQa+h
         8jvJBCEg1gxeGCDZUTVcMfdtT100yoOhwN7+O8nvssfylq1Dmp8qHs7a+MeI+a14vGVi
         OGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVljkHnBbXPiM7pDFVNfaeLCU2D5K4wbPs+tZS88wTgK6RGl9xAI7BYe7pLeQBLrP+jEvFv29CKswQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJDoB2kRnG35aCSrkPXSgyQjr1y4608IRjsFE9zJvkdJE0fr8g
	ia78mbaNYJ4knlPFSKBhH473YP0wA/0VVD7QcYBO0OxxSvStGNE4hrOH3g==
X-Google-Smtp-Source: AGHT+IHuGlZeF848OSae2YeQ5EGMts48qZxhNu+xx7PBOp70Uj061GlfcKfdKbZXFMYoOJdYG9WLNg==
X-Received: by 2002:a05:600c:1c2a:b0:427:f1a9:cb06 with SMTP id 5b1f17b1804b1-428053c9004mr75819685e9.0.1722333195122;
        Tue, 30 Jul 2024 02:53:15 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428089c28f0sm193299255e9.28.2024.07.30.02.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 02:53:14 -0700 (PDT)
Message-ID: <2ede2b62-cecc-4bcc-8cc3-5e84528e8405@grimberg.me>
Date: Tue, 30 Jul 2024 12:53:13 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] svcrdma: Handle device removal outside of the CM event
 handler
To: cel@kernel.org, linux-nfs@vger.kernel.org
Cc: linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20240729205232.54932-1-cel@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240729205232.54932-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

