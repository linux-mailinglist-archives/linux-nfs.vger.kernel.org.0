Return-Path: <linux-nfs+bounces-4977-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922B29344F3
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2024 00:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB2CB20FAA
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2024 22:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882BC249F9;
	Wed, 17 Jul 2024 22:56:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED6139AEB
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jul 2024 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721256977; cv=none; b=cweTxtn1puJ+ufJs8XG+9FJc7gyXJj4OmQx+Tuw27r5+BKKs62a+G99MffwP7I3rlu3/uIZDywKxfYbTXJM8w/bHELkIumrsRsrtTT42Z8UqmZGg4V052HXWb8ju8ZXJ0sPLqzCq8dFRIbYfRiRvpLWuR/P0MzgGecFnOXA8QhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721256977; c=relaxed/simple;
	bh=wvT5/768P1lS1k+mNKzETjxQp/pZxBKlmaXdpXJ5TtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkX1A6h0QYSpQKkPjg1FKcKPlmIwRPwB/U9Yu948goJEnMaB0pJnuuV/L8EevrJmj/ywqjb4j4BfCzBlKigRsixnV/97r4A86GlQZSx3Ibr+3Me1L1ePJbu8FZS7yUZHK/Pbvqfzh+5bAJGGooHZ4i/Uz1t8P8T+MynRceDlb1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-36830a54b34so3214f8f.0
        for <linux-nfs@vger.kernel.org>; Wed, 17 Jul 2024 15:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721256974; x=1721861774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wvT5/768P1lS1k+mNKzETjxQp/pZxBKlmaXdpXJ5TtQ=;
        b=LoIiJ63lB2qTHu1X+sI71o2vJecnNVZrkiLrUCRQ+MC0TqGOQ0Qqmz3AQu3I9nZdY+
         U/4Yr7jzWZoayalyYyPL1tXF+TeY8ER3pdOffaESBsCA9aM/UsjgTcmTav1DkwqtInum
         xMOafuEFr90w7Yc/uyZV30nuc0on2W1aroJFQhjfUw2nGwo+6NqufoXusfhhGy9Ru82s
         WEkW5avWA9rLUfCKjjf5HkbIH/aDzH4bGAlQHQf7gAhMlY7gfhp86WKQiD3ggKPldqF4
         HYgpPQySxbNt4DLHcIokD+eCBo5InYSQ+gSj9NJiFsC/dnNCtiO2H2hpt5A9h43FBkHz
         T15g==
X-Forwarded-Encrypted: i=1; AJvYcCVnA/cSRkyRs7t4EvSniR7mkhc6rhe9/GQHaH/dZC/uU/Nwcp47a80XMu03Cgg58gVEZbA5XllVnK1sJgBElYHmebjV5vumCMaT
X-Gm-Message-State: AOJu0YzFLDP5kOpj7gH9gi79VztOskzKF36qy3BgSkhb9iJS2nG/zqvE
	bLiVr9GNip/e32evN+j9kZO4Zaj/VGdGKwKXotiyCnQdpP2JVmjN
X-Google-Smtp-Source: AGHT+IFVJ6hJWwAJD3NJaF26coAQFC4DbiouZrkWgOOPHR5pn6z1bTBGN6YDVupKhrS3V92DhRn0pQ==
X-Received: by 2002:a05:6000:1847:b0:367:9495:9016 with SMTP id ffacd0b85a97d-368316fb6camr1426398f8f.6.1721256974067;
        Wed, 17 Jul 2024 15:56:14 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77ec9dbsm12868785e9.27.2024.07.17.15.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 15:56:13 -0700 (PDT)
Message-ID: <a8d6d640-ab58-498d-9b28-427014ca9b5b@grimberg.me>
Date: Thu, 18 Jul 2024 01:56:12 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20240706224207.927978-1-sagi@grimberg.me>
 <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
 <9156BC30-78C3-4854-8BC3-510E586B4613@oracle.com>
 <3b4ec3b0-5359-4f95-81a3-1d558756bddd@oracle.com>
 <5a071e49-f214-41d3-b29f-aa1860b12455@grimberg.me>
 <e23bb0d4-7f83-45fd-8df1-b127e1f749db@oracle.com>
 <9b9430e9-845b-4e21-b021-cfc387cbd01e@grimberg.me>
 <53440FD0-58F1-4B92-BCC3-20CB91BB529C@oracle.com>
 <500c22cd-b88c-48e6-8cb4-732f66f8e913@grimberg.me>
 <9DB557C4-60D9-4148-9017-AEE32792BA0A@oracle.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <9DB557C4-60D9-4148-9017-AEE32792BA0A@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/07/2024 17:45, Chuck Lever III wrote:
>
>> On Jul 10, 2024, at 3:11 AM, Sagi Grimberg <sagi@grimberg.me> wrote:
>>
>>
>>> Yes, as an NFSD co-maintainer, I would like to see the
>>> READ stateid issue addressed. We just got distracted
>>> by other things in the meantime.
>> OK, so reading the correspondence from the last time, it seems that
>> the breakage was the usage of anon stateid on a read. The spec says that
>> the client should use a stateid associated with a open/deleg to avoid
>> self-recall, but allowed to use the anon stateid.
>>
>> I think that Dai's patch is a good starting point but needs to add handling of
>> the anon stateid case. The server should check if the client holds a delegation,
>> if so simply allow, if another client holds a deleg, it should recall?
> For an anon stateid, NFSD might just always recall if
> there is a delegation on that file. The use of anon is
> kind of a legacy behavior, IIUC, so no need to go to a
> lot of trouble to make it optimal.
>
> (This is my starting position; I'm open to be convinced
> NFSD should take more pain for this use case).

Hey Chuck, didn't forget about this.

I'll look into this when I find some time (which I lack these days).

