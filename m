Return-Path: <linux-nfs+bounces-962-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 195468258AF
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jan 2024 17:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC23028165D
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jan 2024 16:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607E831735;
	Fri,  5 Jan 2024 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrgPLz/Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE0931725
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jan 2024 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704473651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PhzA2YY8yOp82ONvXJmB9SyKiI5wrzdHbwkhehOuS70=;
	b=VrgPLz/Q7EZTP2CqOOFk55gckOCr6euHVYgJBTwuIiyFpyGHGupINZsz93hACtKNdaql0N
	wcomvjsn+H1EP0qdXZrfOER2kpm30R1yWlNOZSTtcJCWmJ/CAcKfKHHbZXmu4efuRlV2qD
	3kMl3CyOJ6kicvsJA9xEToAtwudWAzk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-uo3KQyjMM9yidJRi9aD99w-1; Fri, 05 Jan 2024 11:54:09 -0500
X-MC-Unique: uo3KQyjMM9yidJRi9aD99w-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7815b7f7a78so43750885a.0
        for <linux-nfs@vger.kernel.org>; Fri, 05 Jan 2024 08:54:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704473648; x=1705078448;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PhzA2YY8yOp82ONvXJmB9SyKiI5wrzdHbwkhehOuS70=;
        b=SU2RZZjMbLaeWFtXpqs1asQhoaiP4le0f3NJytE9t1CTf28A7Jb1jX2ALdZlGJPVNz
         z3CpstzhB6VIwTvqMWidzgBS9C1UPGzD7Ku8UZrsNQPQVL2rZX6NMsgswm9+ESvOgOz8
         9FaaKeCrfwlbXPH+ww6qWoL+xWXwHss1OseGii/vFfeCxQkT2ayh7DHW0pgB3OOWyC3X
         ESe3/NKQdfX8JKy7eE/DxJ5SkGE5jettF14U/AWB1aH2IhZzuLjIuHMvYFRzVHKJhRq0
         Gegz0XNdHi8yBwkMcXrvPhE36vpCyqovBovClzQOd/UYFbRkIZNGSD/VlotYCrY16py3
         FeDw==
X-Gm-Message-State: AOJu0YxgPXJs8cRaflFbW3ME0FE0QQdpaIP48/v2lTjFeApxRA11ipnj
	YH/+LJzUF+bynuDrMFo1kdjqWMIuoiTjkqLuihL93IGGHcwtYsXcqSRJZtgRLqoIRLEQfuDRCTH
	LV2UaJ7uXJrHRls/4up+oLmdrQWzV
X-Received: by 2002:a05:6214:c86:b0:67a:a601:ce4 with SMTP id r6-20020a0562140c8600b0067aa6010ce4mr4677087qvr.6.1704473648532;
        Fri, 05 Jan 2024 08:54:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb+/cCylMUlTT0pX/pCOcbBcRQlZUxmPuL15QpUn3yx/x6Yy7TUUP4614JkolvsBSHXjyVJQ==
X-Received: by 2002:a05:6214:c86:b0:67a:a601:ce4 with SMTP id r6-20020a0562140c8600b0067aa6010ce4mr4677073qvr.6.1704473648284;
        Fri, 05 Jan 2024 08:54:08 -0800 (PST)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b2-20020a0cfb42000000b0067f0d8cf418sm728002qvq.70.2024.01.05.08.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 08:54:07 -0800 (PST)
Message-ID: <24d87eae-97e3-4839-aaa7-e058a3f66af5@redhat.com>
Date: Fri, 5 Jan 2024 11:54:07 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] _rpc_dtablesize: decrease to fix excessive memory
 usage
Content-Language: en-US
To: Zhuohao Bai <wcwfta@gmail.com>
Cc: libtirpc-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 tanyuan@tinylab.org, forrestniu@foxmail.com, falcon@tinylab.org,
 zhuohao_bai@foxmail.com
References: <cover.1698751763.git.zhuohao_bai@foxmail.com>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <cover.1698751763.git.zhuohao_bai@foxmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/31/23 9:13 AM, Zhuohao Bai wrote:
> In the client code, the function _rpc_dtablesize() is used to determine the
> memory allocation for the __svc_xports array.
> 
> However, some operating systems (including the recent Manjaro OS) can have
> _SC_OPEN_MAX values as high as 1073741816, which can cause the __svc_xports
> array to become too large. This results in the process being killed.
> 
> There is a limit to the maximum number of files. To avoid this problem, a
> possible solution is to set the size to the lesser of 1024 and this value to
> ensure that the array space for open files is not too large, thus preventing
> the process from terminating.
> 
> Also discovered that some users have taken action on the issue. It is necessary
> to address this for all users. Ultimately, we determined that adjusting the
> size value of _rpc_dtablesize() and streamlining the existing user code would
> be the most effective solution.
> 
> 
> ---
> Changes in v1:
> Clean up the existing code in user
> 
> ---
> Links:
> RFC:https://lore.kernel.org/linux-nfs/tencent_E6816C9AF53E61BA5E0A313BBE5E1D19B00A@qq.com/T/#u
> 
> 
> Zhuohao Bai (2):
>    _rpc_dtablesize: Decrease the value of size.
>    _rpc_dtablesize: Cleaning up the existing code
> 
>   src/rpc_dtablesize.c | 2 ++
>   src/svc.c            | 2 --
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
Both Committed... (tag: libtirpc-1-3-5-rc2)

steved.


