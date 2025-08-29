Return-Path: <linux-nfs+bounces-13956-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD063B3C2F3
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Aug 2025 21:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7AAA277E6
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Aug 2025 19:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1CC1C84C7;
	Fri, 29 Aug 2025 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6ZaEMTo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBCB233134
	for <linux-nfs@vger.kernel.org>; Fri, 29 Aug 2025 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756495297; cv=none; b=sxAJG5CUrohfXI6CuiaTBn/IqtMu1ivupn8qp8hUCIpLMuEeeXQ1jdCHs8UgmLACmD426kKeS0aGlKyWpPBW/RzY8PCYOqbFQoBwgw2HPaNDmGAcZ+kIQ40p5HkesE38Wjf+aHj7J20zRoYJEIRPKpqncJj0uPPaqfZ8FNsaIWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756495297; c=relaxed/simple;
	bh=/NTmSTZfPDXeUUDn1++L7fJ2AYXNgMPlQrCREKs1tk8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ARvhnFTYKyG77V85B2dqN59Cb/dA4vs2d172WGVvM8xUCW1OlMXSoA+UeAOnYymhGkvKF86eDCwpzw/mXjqobj+yZlwHa0LDnrk5G61wvGYNHAU6SrFxres886xFmRkEY9hlwyXIX3FxjcdPbq8Rh20ZBwr2bsVihipnsBFiAfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6ZaEMTo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2465cb0e81bso20226305ad.1
        for <linux-nfs@vger.kernel.org>; Fri, 29 Aug 2025 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756495295; x=1757100095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeRG2jIMaJlXqyftUQ7rgSf1NwIBJiuTH5C2Hy/JO+I=;
        b=I6ZaEMToRHnNeHpEyToqQAWzlmBGprq2KC/Gtio/9zQkwRvN6jWV+z9c1ME1qAHkoE
         TBP1xYYqQqHs//BeCNcJ5mAzsJBNDp0j1izErmX8hdc44rSa207KzrlKFT3JAigpyJ3Q
         T3KSNwCJn88QlbHzxHj05K9hEaFpltwcgBVa/tdBpwoJK8C82nBiMx7lEgMyVxtzOLq0
         e2maHbRYwkFT1GfvwVQz26OCFmoWUE0wFKeotqcyPIUtxZVSXf+XfuJrHmRt9Vq4dIOJ
         x81EPtIYwJb42e1fUbsTVGDHSCf6OH+r00ipOIa+dQmxVdXZIjNhKyFHe9Eiol6cjeSQ
         OoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756495295; x=1757100095;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UeRG2jIMaJlXqyftUQ7rgSf1NwIBJiuTH5C2Hy/JO+I=;
        b=vyV/1ceig5CcJOJR4mRDYu/Jest+AmAd3miynsXD4NYquUtwZWhhH4Yu0k3vjHg+cT
         bZtYlBFcwOZBGrnANH4nGRTmXnuQ7+y88c9uUFY9pWatsaeY47RLWPrf7rGhDNiFt+gP
         OrBucm20oT/eiKvJPo4q/P+nLlLbltG5IyrONXwFwfXCeduWTezyN7IrhsyDJlMuByAO
         2zWFFeZwUul4GcgAnyyr3FZS9f0uXOUk/Uh9P5VXzAK+vqZAcKmdBHL+2tNsj62mEstw
         xwW1lqmg03e9vrbkqTAAEdtSoZLIIV6AAb78XmgLtNLkjDHIKaYb+m0w+67nzdlZwnA/
         BLHg==
X-Gm-Message-State: AOJu0YynOHIh7TA5iD9iEYIZahiJkrTCN4z9uHoivqbgMyaJjMwQakkj
	ODRSnpOuVZ2lZebADZNYaItRUX2pFbptHlYfDz1WLKVgAmRbi9DVT7ad
X-Gm-Gg: ASbGncsAaFJ8Bu3EnLUnt5Yh1wUHD1bHDDX2za48uQ+IAgLW1SHUH5OYjGvdcfpmQZ5
	ESwWnO9KOk3xTxPZ9rhErX7ana2NZfYPcE2ihehw25psaKoXQwfHaJFPPSB+0T0bFsuSihX+HB3
	unP3g4K3dd+xiFfFVhpJ/QfaZ6CIhyW3daQHdsfzTdt/xKrFMltlvdihYSjZntHjSQSPLr6Qxd+
	r0e5yx7KwD+3phKm+q3WRlZ4+PHG7hI0sJgKpXQFbOHH+3OfXF1P3ZmTf1DeCAiwLZNZqcoGZju
	erzQCnyQVBzku556iEhaT2vWikGn944TnDzyXZQ2+w+bGno52BusQp5itfqslqpkHYnfo+7sBe+
	st8rbvMT8B1iIWEkx6WgqmgjND8JAajM+Upm43A==
X-Google-Smtp-Source: AGHT+IEEu2CEN+J8m7IRSaliLDM36gRBHZfQ6znuFzXbvXYw+WZbxK0fHdEyyzE6Wi9b2Bj9J/LY7g==
X-Received: by 2002:a17:902:ec81:b0:246:92f5:1c07 with SMTP id d9443c01a7336-24692f51fb7mr291003005ad.51.1756495294854;
        Fri, 29 Aug 2025 12:21:34 -0700 (PDT)
Received: from ?IPV6:2601:647:4d82:2ae4::d83? ([2601:647:4d82:2ae4::d83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490648d67dsm32322695ad.108.2025.08.29.12.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 12:21:34 -0700 (PDT)
Message-ID: <3e19b7e9-c3d2-43b5-96ea-c5cf7904e8a3@gmail.com>
Date: Fri, 29 Aug 2025 12:21:33 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org, scott.b.haiden@gmail.com
References: <cover.1756486626.git.trond.myklebust@hammerspace.com>
Subject: Re: [PATCH 0/4] More server capability fixes
Content-Language: en-US
From: Scott Haiden <scott.b.haiden@gmail.com>
In-Reply-To: <cover.1756486626.git.trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I just tested 6.16.4 without these changes, which gives the same error, 
and after applying them xattr works properly.

Thanks,
--Scott


