Return-Path: <linux-nfs+bounces-5309-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C8094E97E
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 11:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 980A0B22A82
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 09:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EB816D9B4;
	Mon, 12 Aug 2024 09:13:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305EF16D4E9;
	Mon, 12 Aug 2024 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454037; cv=none; b=CvP0qzJRmPx9MPm19nK3enE1DoDnVdIi/XVT+Ao4brtRPfub09/l8WYqDIU/aMJFwYwSt6WGAkw3wo0m5aJBUZKGv337JB39q61UxV/tYuTGN7F3P78eU24ZKneGgyFd6NnB/khGEVju61WwjjgJjYDmDfY+P0O6/WbqHFeqJ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454037; c=relaxed/simple;
	bh=kGVM0R3MSfaQvPyDEpPR3xekX2J3ZsY/4TtRQY7lmgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlZqQ3TO8kavOnTiZDWbPYOKQwG4vPX/MUGobBFC57WKf/MvM0vXhxYK1GZi1d5aUHsFBF7kDY/uXDb7xAqxolHAJPYLeiBJ/ohyPcQI6m0F97UcvOoxEinqnQ5GSjgq4zEVUm1CrUDNINDTR9thdcjt/uz96c6J202o+DMlsuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ef302f5dbbso3353051fa.2;
        Mon, 12 Aug 2024 02:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723454034; x=1724058834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGVM0R3MSfaQvPyDEpPR3xekX2J3ZsY/4TtRQY7lmgQ=;
        b=eDqGVFLzWQwQu2LFfLiElLVGvZjxfSH34DCnhPTErIYFuwS5k/NlXEnhOhyvvsntOm
         Y7tXusajepMJvanLY7yx8BF58pY/gmtRORpugtp97TKfhgX/0RK9eh9Xn/Q3M9RzFc66
         Jl/S+e4ZY+UJhU8p+SspkJE5PEhfin60G+Szo4KTMvYRBsgK4e+ZXUVMGO89W92MJsNe
         RCTfums+PQTLIdO5pPe/VSSYU8dFkDzq0MI4pgAQk6yail9HFg4PQYAH7q2UXy/gJRaZ
         Gfs3OSvCGZmX47BT2X/Vmfk1LI79jDVB1mr0pXsciydeJRvjPQZaJEdQ8v4oIUsatAs9
         Z5jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg17E/Ee+6oWcYla430LE3rpSu4AARGgvlaywwGdy+U3ddZsh4yToEP5tQkcP1fkA+UtnGDUnaWwe+qBUpUJDMRyYdze+hpTafTKvLwcFiP6u/askLA8e0Gaf+i3QTJgWTAnQFgGMs+RmlobUZfnOqNmbV8mdGlnrLqwqOusS9
X-Gm-Message-State: AOJu0YwXrJR2eAh9HI1EpNJW87KnV+kOULvL/IwqzynoD08nRPXYqzT/
	e++CQdSccL+2pPvefE0DeGIu2oJ6RmsUKHwRB8znIjzoI+IDX1wf
X-Google-Smtp-Source: AGHT+IFRxvHIfMILpxaS5we6c7ycl5+/GgPt+eEKN/RHRY3BKOm+fjwMG5FpnZabhCamATDvqYu2Gw==
X-Received: by 2002:a05:651c:b29:b0:2ef:307d:17 with SMTP id 38308e7fff4ca-2f1a6cfc5b6mr33905021fa.1.1723454033887;
        Mon, 12 Aug 2024 02:13:53 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c74ffb1esm94373275e9.5.2024.08.12.02.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 02:13:53 -0700 (PDT)
Message-ID: <06a66824-cc2e-4f6d-8776-c2bd415c06f9@grimberg.me>
Date: Mon, 12 Aug 2024 12:13:51 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] NFS patch breaks TLS device-offloaded TX zerocopy
To: Christoph Hellwig <hch@lst.de>, Tariq Toukan <ttoukan.linux@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Anna Schumaker <Anna.Schumaker@Netapp.com>,
 Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
 Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxim Mikityanskiy <maxtram95@gmail.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Networking <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
References: <aeea3ae5-5c0b-48fa-942b-4d17acfd8cba@gmail.com>
 <77fb3db5-7a59-4879-b9c2-d3408fcf67e8@grimberg.me>
 <4f42fac4-2a4e-426a-be86-1f4bb79987b4@gmail.com>
 <3e08421f-91ac-4bd1-9886-3d5ecf9afa04@grimberg.me>
 <8683155c-79ad-4090-9aff-fc8d765b096b@gmail.com>
 <20240812090215.GA5497@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240812090215.GA5497@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 12/08/2024 12:02, Christoph Hellwig wrote:
> On Tue, Aug 06, 2024 at 01:07:47PM +0300, Tariq Toukan wrote:
>> Adding Maxim Mikityanskiy, he might have some insights.
> I think the important part to find out is if the in-kernel TLS API
> has a limitation to PAGE_SIZE buffer segments, or not.

I don't see why it should. Also note that sw tls does not suffer from
this. Maybe Jakub can add more light here in case something was missed?

