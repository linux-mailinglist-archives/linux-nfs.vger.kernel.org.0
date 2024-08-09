Return-Path: <linux-nfs+bounces-5274-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACABA94D230
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Aug 2024 16:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B2E1F22986
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Aug 2024 14:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA91216D4E8;
	Fri,  9 Aug 2024 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjNFnjJd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B165195FEA
	for <linux-nfs@vger.kernel.org>; Fri,  9 Aug 2024 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213784; cv=none; b=uoEDCYfP687rRQ7+utf5CI1jkiWARHt70zyfH5YoCCZzO6iu0IxrT0BdSjYiqeQTyKHedf1yD27Dth5UQUrUNr/BmhxP1odeplJE5CVlShlft6QdHEH/2Ngs1ujpjVI/ybHitcXcqbo6URyxzHPoT7y/r6OxroW/5nJl1t6UcKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213784; c=relaxed/simple;
	bh=1pLbe1RFvYVsHYziI39xVYefbt3Vd/LNFmwcdF2LDe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2SISBgPajOevBINsBgtR7YdBVuyU0v3TnJHnodda0+hI/w8k9vmFfrExQwqzjeQwlRRJvcNSWtVs8EtZ7GD6DV3ObbKfMOOfFPmlyes/Pm5bmNqrdW3BH7e0IcUWaSoAa5taF5e0hVcKP0e4xEEk8H5v0+mR8i4QiAjIelx+pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjNFnjJd; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb6662ba3aso1499690a91.1
        for <linux-nfs@vger.kernel.org>; Fri, 09 Aug 2024 07:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723213782; x=1723818582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0sRCr7DSVWpd6wkR4IHonFH/aamS5mN8ysAXeuu2uE0=;
        b=QjNFnjJdnD0zObTHkikrWrUJVWFJJQCXSRtOo36eLuuxRvR7yBSbbZ2D1Fz5qkDpkq
         vWyrLpx781zHLpjN+k4VzB6Z3mCe5GkCapBMJvbSpxHV5oBEsodhx+QBMK0qg9pIau/O
         HPPYxZpYS/XI6hBBw7CdIstww0pr48wmqxKCaBuSTGMSm4DwIW6g7Geuj0f4UVNreDQ/
         JJFIzryKDk6KaxQ34oGVjlCjRis1gn/G8wTL6DE1R82RnrbRKHqn8wR0Anf1SPSWkgA4
         R/E5+eW5X5RCdvAgp78dLHi0nmL92WPFUYnuccV7eKqMiCajTDZNUp+GKNxmGN4qb6E4
         tqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723213782; x=1723818582;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0sRCr7DSVWpd6wkR4IHonFH/aamS5mN8ysAXeuu2uE0=;
        b=HZ3ocfgJ0/oledCj1KpIZzCkN8j86raymzoHHdaZiokrttn9A2DCpFx9lqQyTwZNZr
         qvIYefmASO3nnYdYV+j07LC4kDMgJhicO9YcK0UVisVTiwAdJF81xukJE++/6rWX9K+v
         Zx5OVGqXiD2IpbH9YHS9MYaK/PSt8Il9DlBOBIEd4GsIB/8KENhWiG+8CSvkXHqb16eZ
         /coIQCujy3R9bB5D8w7PIk83sn5jDBjp1jfzwKDr5k4/Qk+Kg+5INPE5NgAUWx8MdqFb
         bwzBK+UjUuktmaMyXn64UslS0Exgh1GgKU2ZMhMx8yUn7+vUgn8C6woNe4wJiPnNdVy+
         VKDw==
X-Gm-Message-State: AOJu0YxZ0M0/pK6WvO/hUJWDjCggHFXwbBjyoKbCcWyzvTS/tJlyEyL3
	RunRW+panhqPkkapH4hAG6qbXVA8cKgU/wzjbEbhhbBRdUutw/w7dBtJFg==
X-Google-Smtp-Source: AGHT+IHQos/Um9owM/JUpW6TNv1VzSYU7x77TsTZygEfKz6SvNF1+hj/rLI99Wp/Jp35AlI3n+cy0A==
X-Received: by 2002:a17:90b:1887:b0:2cf:dd3c:9b0d with SMTP id 98e67ed59e1d1-2d1c4b674cdmr8864835a91.2.1723213782547;
        Fri, 09 Aug 2024 07:29:42 -0700 (PDT)
Received: from [192.168.86.113] (syn-076-091-193-045.res.spectrum.com. [76.91.193.45])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3b1144bsm5348274a91.34.2024.08.09.07.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 07:29:42 -0700 (PDT)
Message-ID: <8db4923c-5272-4642-9684-9765022b778c@gmail.com>
Date: Fri, 9 Aug 2024 07:29:41 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFS client to pNFS DS
Content-Language: en-US
To: Anna Schumaker <schumaker.anna@gmail.com>,
 Olga Kornievskaia <aglo@umich.edu>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 Trond Myklebust <trondmy@hammerspace.com>
References: <c4f1d8bf-745b-4a98-9d38-2da4c355d691@gmail.com>
 <66be75a6-2d3f-4f5b-96da-327556170c4a@gmail.com>
 <e39131ce-1816-49e1-8319-820472892a38@gmail.com>
 <CAN-5tyEx=j2OiRZVd+18x-2Y36SGGsJxAVApudT+mWjiNGDyxA@mail.gmail.com>
 <CAFX2Jf=k0SC4iFzj+24HbR-4MPkk0bkGCvnnOiv0OYgqO4QOBw@mail.gmail.com>
From: marc eshel <eshel.marc@gmail.com>
In-Reply-To: <CAFX2Jf=k0SC4iFzj+24HbR-4MPkk0bkGCvnnOiv0OYgqO4QOBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for the replies, I am a little rusty with debugging NFS but this 
what I see when the NFS client tried to create a session with the DS.

Ganesha was configured for sec=sys and the client mount had the option 
sec=sys, I assume flavor 390004 means it was trying to use krb5i.

Jul 30 11:10:58 svl-marcrh-node-1 kernel: RPC:       Couldn't create
auth handle (flavor 390004)

Marc.

On 8/9/24 6:06 AM, Anna Schumaker wrote:
> On Thu, Aug 8, 2024 at 6:07 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>> On Mon, Aug 5, 2024 at 5:51 PM marc eshel <eshel.marc@gmail.com> wrote:
>>> Hi Trond,
>>>
>>> Will the Linux NFS client try to us krb5i regardless of the MDS
>>> configuration?
>>>
>>> Is there any option to avoid it?
>> I was under the impression the linux client has no way of choosing a
>> different auth_gss security flavor for the DS than the MDS. Meaning
> That's a good point, I completely missed that this is specifically for the DS.
>
>> that if mount command has say sec=krb5i then both MDS and DS
>> connections have to do krb5i and if say the DS isn't configured for
>> Kerberos, then IO would fallback to MDS. I no longer have a pnfs
> That's what I would expect, too.
>
>> server to verify whether or not what I say is true but that is what my
>> memory tells me is the case.
>>
>>
>>> Thanks, Marc.
>>>
>>> ul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node
>>> stripe count  1
>>> Jul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node
>>> ds_num 1
>>> Jul 30 11:10:58 svl-marcrh-node-1 kernel: RPC:       Couldn't create
>>> auth handle (flavor 390004)
>>>
>>>

