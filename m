Return-Path: <linux-nfs+bounces-13132-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42215B08FA4
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 16:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA986A4281A
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 14:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F282F7CE6;
	Thu, 17 Jul 2025 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="JXA/MSdb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4A12F5C5E
	for <linux-nfs@vger.kernel.org>; Thu, 17 Jul 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763081; cv=none; b=fcoA98ijdjhjEIhhQ0qkE7e3B2WAQ/cHiX1JLtoguYkuNLBrOiozoL7MEJ/ocmrua/CqTAgm0k6Y54pV0ylvidE+zpMGswwg3Y7dJ9kvQH5O/UegqxVk/LDofRkgswn795kDwva2LCFDBNDpjHmiEQh3rfoobJqIMke4bm/2K/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763081; c=relaxed/simple;
	bh=GE1n+/kSK+dpUIQThISar6jqhKk3VdnAcuBzbe2VDO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hT/0X4XeGVCRvohAsOHO0K20XKmsIP00/7RcEHg4VSLfQoT98U6NYvBYQ+Dkxx5cGeR22CHXIFcJZ0wFLhTMnShtkDWo1j7UOe1DrfTNaa21J83bZ4Rakj9UDRc4iE1Wjv3gkMBgbviiEI7DJC3QqNFLkdUOfUb4h7jzvCnri/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=JXA/MSdb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so224760366b.1
        for <linux-nfs@vger.kernel.org>; Thu, 17 Jul 2025 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1752763078; x=1753367878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=io2lJX/oa1z8SJuaZ3dmMYnTVXy/+Dl0m9FIE91H+QU=;
        b=JXA/MSdbdN2je5UQydzbe7BvR2jlSaU50JSbtpzAWpbOosB9g5HPeNo0OxUrcj5zem
         BwcD1NlnWYYIo6pNQvHrrWvB2Zu0eVmRjnaRa4R7xN7XK9rdbf0QO3wbhTugMOsWMQQ4
         kpT3tTfLk/Hi6HDlw9Opw7fZgNPFXqA/PlUcAGPy0Fyw2hHRweGGda3FKpcGDjz4kzRU
         UtzcYG8/mS9wKDBbg1AkP/l8jnnj9mspRWS6Www6gVNjPws6GgzcIMdHbWBZ9Fz0nmyg
         IDqDhkCz8XcdSJI5fWNIHhNEHIl8XCzcSl1IxS64a1EBHBIl1v8XZirif8JBK6rV4uMM
         K89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752763078; x=1753367878;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=io2lJX/oa1z8SJuaZ3dmMYnTVXy/+Dl0m9FIE91H+QU=;
        b=a96PqqRLZMBVoNX5thOCtbfwS8ReftftuGiZmK0Tm16efy60Y+PCiOnQcsPkWBQpXN
         rrdtu2bjMnFcaT8e5TyIntTjY29vLxRzmkAxS5Oj1A4u6ZaKdck1ZaVpyNWnseJ/y+iU
         FmofecSeu3+7+C8YkQibFtubmj656HOqIPNyz+kpxwtkajmpnoRcl6345g1ZY8wCDU7x
         PJVpj9k8+/0lnLYCnqLq7I3kT787G+zXVB8S7E3AkZPH3Rh/GC8JihFbGPxriam9huTg
         +Dkyi0EYJy230Gs3sZrm/2R2mMEerBxvH517TJAhrqeFHXf6w10v/oYq8NnfBrfb9Uko
         tTww==
X-Gm-Message-State: AOJu0YxNhwc/CCA5EorprMzvD7IVqoeQKnWqsJtwYLWl6sqVkU6pxcdM
	yXBK4zlI2GhESLGBFrPrh7OXUdlIC6WuB/Kipiq6BSVk6Duz3wdYSokJeNRKZwozzxHsI/ralWV
	0kGv7pP9oSA==
X-Gm-Gg: ASbGncvHHtB48rFbs3QOpmq8+KwOLhRHRSA5sh8vaFZq4S8a9fy9331hi7h+GrkjzcV
	+l2+JDCoUWLGcZCiqsNtliP4d3LtKz1Gj1K2pkSRTdGlBFypRXQ4abPDmsd4xkx8vM8iOINh1ql
	4JebR2pdMPh1JpWnSff54Z7auUXsZciY5ESfiSLGEJrQdmq8xlygMiz915iTcSAQBcO9PikjjMp
	JG2lI2P+qphPeb+0h4e1K73QKhyFmhslc7XnmUjflq85catTdToN1KN9dyrl4rWMiq17V+LGOjX
	nnSL7uuMJFi6lrU0iQWFE5BtXbxQwv+IA7je5YaENS4o2X51Es1g26ooYUguxXqw0RrjmJnSLpB
	zFbLOBZ80t1s3dK+EE7j3DZydBZYRecOoHgCaJhlPPsrGtjVyexSrqpZRF1ES9T4=
X-Google-Smtp-Source: AGHT+IHkMMpZWrXlTn5tLDGFrF0noqWigBC5ZF7FZukM49V+Vh+b8g0b3fh7RHSLZKGGVJnH4Lu8IQ==
X-Received: by 2002:a17:907:9342:b0:ae7:73b6:19a5 with SMTP id a640c23a62f3a-aec65ce6ad9mr9065866b.10.1752763078082;
        Thu, 17 Jul 2025 07:37:58 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:5ccb:40e9:b7dc:5cf2? ([2001:67c:2fbc:1:5ccb:40e9:b7dc:5cf2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90a16sm1362411366b.24.2025.07.17.07.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 07:37:57 -0700 (PDT)
Message-ID: <bdcfa3cf-1e48-4680-a114-565704efe8e6@mandelbit.com>
Date: Thu, 17 Jul 2025 16:37:56 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pNFS: Fix uninited ptr access in ext_tree_encode_commit
To: Sergey Bashirov <sergeybashirov@gmail.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250717143522.59744-1-sergeybashirov@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Autocrypt: addr=antonio@mandelbit.com; keydata=
 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
Organization: Mandelbit SRL
In-Reply-To: <20250717143522.59744-1-sergeybashirov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/2025 16:34, Sergey Bashirov wrote:
> Current implementation of the function assumes that the provided buffer
> can always accommodate at least one encoded extent. This patch adds
> handling of all theoretically possible values of be_prev, so that
> ext_tree_encode_commit makes no assumptions about the provided buffer
> size, and static checks pass without warnings.
> 
> Fixes: d84c4754f874 ("pNFS: Fix extent encoding in block/scsi layout")
> Addresses-Coverity-ID: 1647611 ("Memory - illegal accesses  (UNINIT)")
> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>

Acked-by: Antonio Quartulli <antonio@mandelbit.com>

Thanks a lot!
Regards,


-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com


