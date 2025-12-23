Return-Path: <linux-nfs+bounces-17278-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBB7CD82B9
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 06:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10FAF3024D46
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 05:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D242F5328;
	Tue, 23 Dec 2025 05:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxX3T1Ps"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF3F2517B9
	for <linux-nfs@vger.kernel.org>; Tue, 23 Dec 2025 05:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468155; cv=none; b=SNjdcOJNm2MLyeNe9O6HJ7lN5kLAjsTkWdhLdLHD2qRffZYX28qwVyiVcYiJQ4D7YmCyONf54+TNwZcvHBc3f/H9wmeDjlLrkM5mPBlQa59CvPo5OAWwnOXtltjE2B8dXST+nL3Jp6tJq7nxuaQg9FQ5CPiqp1qThdnRSCxS9ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468155; c=relaxed/simple;
	bh=g9Bt2s+UFC+DeXi/131tDLXltXct0EalOx5ApUtrNkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8EvXVQ/reXmZ7s0qaC+sTohXAUgJbSdlkwI+133PFPQ/JZmokP1I8lEvbyuqAiskMNB7yZAU7LxKjPqpJCPJ8fkly6B4N4QNXCnVRUWb1ctBU7ox7Tg0e7+i4uPnM/0HZubBq0xf5HajaUVxFnl7bFNHPkQE3FL9ezYc2PExvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxX3T1Ps; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-11beb0a7bd6so7845099c88.1
        for <linux-nfs@vger.kernel.org>; Mon, 22 Dec 2025 21:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468152; x=1767072952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1VDWjicrLkuqVcwGv9d1sh+ocm1fa0mGizT1YHR+Z6c=;
        b=LxX3T1PsbL7A9toWeCRP1ZiEISt/so3/Ge3jUHQW4vV4bDI+CFNh2mgvpyMRmaKHoT
         /MVJPZzIUDwB/OoYv1aOhJKvrOm2AivnEB8xW6vyl+8+1t7pR6MlWzwtRfU/GfflqC6K
         3JQu8w0MC9/CxAeX4efBrU98BIUAeM6jx8wPEXyWQR3NDflVWRIrWEIxqQR4++JYkCHY
         bFEz1B+WB9h9jFH2Xqa8kzgS5ZTgD86P5uMkVxwxMjciEze4VsRaDj13pFlXKT13kVUf
         kH4LjKRVTROQaXbg91AnL4dtGRfgA1kC1ZeJH3Do0F3CuIrtVgeWGDs/NQy0SWkny28V
         x0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468152; x=1767072952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VDWjicrLkuqVcwGv9d1sh+ocm1fa0mGizT1YHR+Z6c=;
        b=dC+LkxCo8EofqCPJcJw9n4xekhgZ3sVGVmM8eWxBjr4/Nq5gfUM6np4Hws0BsMDYq1
         i6cgBFuPR3caRx9ssMK2beeWcEcEb2WKlQO5F6wtxIAtL54XyAzBGUyCiX1LRQlyuGok
         fhyNF4VV3HO6sAV9Kr5mbAI7TQh0+bz8PXhCnuwi8CXdvCZcrUPQ8uGWYKlRHrgbdX/f
         +u2ID0nBc7JpIJ3x3anDAtdkBgH1humSFVO6R/YlR9MlkKod+j5GbquSNjtZ/fpNn9Qo
         +W9DpOy8NPAKh5j+myjBFtSb8qofWE71ixNclYb0Z4PC2+JYidiALTMDoiFH2WjgNWHW
         3SGw==
X-Forwarded-Encrypted: i=1; AJvYcCXjYrQ3oLddZeWR0+FMHVOgVVQL3UVJObK+4uxVSFhwcimbeRHRNGon2lxuvfqDgrfDCtU8imeOr1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv6TBQ2kdH8uQ1TyCFrV7uBzdDRzn4cKyKi5n+xpF0HY+NCL15
	CKkGak/QjAy1QmN3rP9lgkY1wXO0Q0l2nAifC6UftSwG4Qz1CH7QS7y4
X-Gm-Gg: AY/fxX6EuDWiyokvTkUyz36dpTK+Igbixarus6kLIrNbfa9AKzmR7cnT/ONEX5VEK4O
	D5L09+RLTJ8bmzkrt3YWd9BnqReiBcr/J3fd+avSSL8DHQmM7hn+LsghBWw3jYpPZP1jwydpdgW
	falWuuabcjBIYMBvxA/8Dttk37vu77LKo4efU1x19JgOMuD96DFsQsZRLnHwQkHS34dlzX+0SbO
	RdGKR8B+8CYgLN2tU9YI0Baa0xrab2zOS0KJg/W6OTvhU+0049GachEBWeHZKymyhXCmOjWt3Nq
	+h+7w3AB2uhwxifxca878hA+42ffKzHdus7wb47Uc0EpgqzDS7lGpH2EUCkt4vcmL3HWBNoLo2x
	RtZeTRb36gm6FHeZ8uP9M4psYPms5F/4VhhqWIReSy4NhRVvWsSykDSQ0wu5c9da8vrR19p8SE1
	qHYBZOFVCac88T7xF+pztKWq9xtFQSL2mLH7yPpALXLLcmsDukW+rXPOIpFftFNIxs
X-Google-Smtp-Source: AGHT+IFgD3SNwd/4TCZfokt7AW5oqjEJYNTcZgO21z1zxvgYYO/3rgL7QNl7uSOUpz7Nh4qCGFV22A==
X-Received: by 2002:a05:7022:eacd:b0:11a:4ffb:984f with SMTP id a92af1059eb24-12171a85250mr15323051c88.11.1766468151780;
        Mon, 22 Dec 2025 21:35:51 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121725548b5sm54725089c88.17.2025.12.22.21.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:35:51 -0800 (PST)
Message-ID: <6f297260-3c99-4330-92ab-deeb1fc5d8f7@gmail.com>
Date: Mon, 22 Dec 2025 21:35:50 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] fs: delay the actual timestamp updates in
 inode_update_timestamps
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>, Carlos Maiolino <cem@kernel.org>,
 Stefan Roesch <shr@fb.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
 io-uring@vger.kernel.org, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251223003756.409543-1-hch@lst.de>
 <20251223003756.409543-5-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Perform the actual updates of the inode timestamp at the very end of
> inode_update_timestamps after finishing all checks.  This prepares for
> adding non-blocking timestamp updates where we might bail out instead of
> performing this updates if the update would block.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



