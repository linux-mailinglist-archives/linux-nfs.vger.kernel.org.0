Return-Path: <linux-nfs+bounces-4882-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DB79309EC
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jul 2024 14:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABD41F21686
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jul 2024 12:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D580433CD;
	Sun, 14 Jul 2024 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8iJqaNe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F3451C21
	for <linux-nfs@vger.kernel.org>; Sun, 14 Jul 2024 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720960001; cv=none; b=uRBCTvNhkOKEQaSIgv+9WtDeiW6Y4QLkHufDqmFzCUG5PGvP+I2ptQptQy384Cwvx8gYPBtUK0+2B5bP7p2hCpqDxHh93IA1QpXY/q3MCkKm5vgUnLgadmu0+JzEkodkfB8IC8TSar4DeXcE0kfbmzzc+qiQBjuHaiVVTrCtC4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720960001; c=relaxed/simple;
	bh=0oMUAItfpCVCdiM8sgHroYM9MOrkuc5ezEOM70BbsfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U9usJssLfMS6+kpAc2d11mZGkCYpi14gW3wrsMFnhvwLi+SVONavbLyFnztiD8qk4KSDmiCuxTOp0ZP5McOxxlAghMlUirBHxTVt/uUsT60JebaA/M4eVu6/Ken07MZtJUu3FDlJC+eqYXWgnCGuEJhwONjzKUtDEXge9jBKrpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8iJqaNe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720959998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9c8DfEtAqX6ilwSS36VFH0oXV22QVzoHT9XOqLJDNW4=;
	b=N8iJqaNerXeGSm0erbRYzeMF69/XraycLPeRhd3dfLhhx77Km6hi8hto6Un58C9/HadeiT
	RgkpunjvA/Uhk+BWeZSxtajtUJ5lGMoGW0ZrafBGb8l1qHBXuCEIFVCbY5Mh6/wbRx3rM1
	vq/euay9kqaHZKosoh9/LkQJsRWfPaQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-g6ILR3JENrGVqxUfnE9GqA-1; Sun, 14 Jul 2024 08:26:36 -0400
X-MC-Unique: g6ILR3JENrGVqxUfnE9GqA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-447f84c361eso6599541cf.2
        for <linux-nfs@vger.kernel.org>; Sun, 14 Jul 2024 05:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720959995; x=1721564795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9c8DfEtAqX6ilwSS36VFH0oXV22QVzoHT9XOqLJDNW4=;
        b=gN608h3y8rNdU+e/RfvFlp2Rte5C/iDbI5XrqAghhxWhUMLhfuCVHZNQmYhudqCVQ9
         J6DYCmwDPdxSkHqz8d0sdxc4kh51veadY1T/I43lgstpsR1gh5A9n7VQe3sUpb0K9Wgr
         Tj9fYk1OUwYueFW7qyvE3X6Ff+AtvcF9e8VOCbuegscQQqNSgVv/M8f9azjq8w31h/W4
         OsWxYvUfW8/oRO5b2h6ezBs/Z2gQrJ1Mmdm+izhdQbT4sYZaQyCBSUs/bJMnYkt8753L
         BQgHbHOn3BqqXAJvZj0//KuPFNj+OM7yx4Xh6AqFWza2MkLgz6hAgH5GCMQgIQ6CVS71
         YVhw==
X-Forwarded-Encrypted: i=1; AJvYcCWhrpzBZ3IKFcC/W/N2l+mv3GNkrGPoAeQ1haInzDj6aPpddhAwgdOoqbmfIsgB/0BnyyIRDfmRpUVpQmBPI4q3+Q+qr8d2juvi
X-Gm-Message-State: AOJu0YwJg5r08Omsaj3lY5FOort5LEfa0rl3Isbhy8oXRC2ME/tV4lr6
	Q31rSl6aUgmu1A1y2SV6OCYOpss3M4u6ykJbM3uIG1Grt1q/wBrmaJEErplA9o9O2OLmaekchb/
	su01fUk96Z2R8kdO3Z4M3l8CTuk8gjPfeMZGwlEPMuc0RHy1Ga/kArqlAT5r4tc6HCQ==
X-Received: by 2002:a05:620a:12e9:b0:79f:726:e2d6 with SMTP id af79cd13be357-7a1471cb253mr813635485a.5.1720959995008;
        Sun, 14 Jul 2024 05:26:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQKOVCMQbxA5HTy8ADnIqAQ6FXwwuavnxm3MybvpIfX77Wc9kE9bvfvmB8jDrZ7Ls+tRsOQw==
X-Received: by 2002:a05:620a:12e9:b0:79f:726:e2d6 with SMTP id af79cd13be357-7a1471cb253mr813634285a.5.1720959994647;
        Sun, 14 Jul 2024 05:26:34 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.136.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160c65befsm117683885a.80.2024.07.14.05.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 05:26:34 -0700 (PDT)
Message-ID: <13e36fa8-cd17-4a83-a990-f87ecae845f8@redhat.com>
Date: Sun, 14 Jul 2024 08:26:32 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: is nfs-utils aware of cgroup memory limits?
To: Harald Dunkel <harri@afaics.de>, linux-nfs@vger.kernel.org
References: <8f4b1a41-0e35-43dc-a62b-1e9239df9b45@afaics.de>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <8f4b1a41-0e35-43dc-a62b-1e9239df9b45@afaics.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Sorry for the delay response.

On 7/7/24 2:25 AM, Harald Dunkel wrote:
> Hi folks,
> 
> I wonder if nfs-utils should be aware of the limits set using legacy or 
> unified
> cgroup?
Legacy...

> 
> Reason for asking is, I am running nfs exports in an LXC container (using
> legacy cgroup). Sometimes nfs gets stuck on the host, and one of the 
> symptoms
> are messages about out of memory inside the container.
> 
> "cgroup" cannot be found in the code or git log of nfs-utils 2.6.4.
I'm more than willing to make nfs-utils or a sub-package of nfs-utils
container friendly...

Would it make sense to have a server-only NFS package?
Would that help?

steved.


> 
> 
> Regards
> Harri
> 


