Return-Path: <linux-nfs+bounces-12303-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FE7AD5550
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 14:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EBE71E00F4
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 12:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767A623AB86;
	Wed, 11 Jun 2025 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rvtliu8l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967E41DA3D
	for <linux-nfs@vger.kernel.org>; Wed, 11 Jun 2025 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644379; cv=none; b=bDzXLue7SnjOE/qa1rFF3wz3URf3BdL9ksrHCvHwH441+kjR9MmDSsOcNIH7XqR8B0SO8VkXSfSDKGHM4OWnkHVn6yvTjj1tUDNBJx5jdJNDXDBTFDrwe3K3mc3aQxbNk1Jj5vH3ebYIqSMN5SHfOKRu1Y2c12/ZzU+VKo98BBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644379; c=relaxed/simple;
	bh=Rtq3U+6yp3TOvu69twQ4KjDOi+TlLudxAXzjsjKypbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3jjh+kvUh1Q1H6ODv6vg+Bab6b2ileCkxqkEaoe4aM3XjcK71csj7pwUzBUSB8Jx6dZ2KqPW58PxpNfYVLVXWHMxb8h3MKgsDdi5RoXTFocqeHLdmIj30aLyXiRSz8pVNGkv2C4H1UEKcxIfwzCbVUAfc+hQt6CieejB6UmBgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rvtliu8l; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553246e975fso7693711e87.0
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jun 2025 05:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749644372; x=1750249172; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4AZ6j0NMkDbuUzKLMepLi9BIBn7jGzM58By2gSjPRM=;
        b=Rvtliu8lwPyV8ZqAons70Lf3vLPjhxNCf3sleTW/kBGBrJlzm3c7X7Y4WErF2xQ2rm
         kLWzyTHilpe780u4MJ4TGsFLnDU+rRLBABrraw0XHHDAKcyp+JzKqHszq9uFybBwP8mZ
         IAtJMI9cKY4Bgwrt7AMGJHIsbOc765wVla3uP+kx4QqDPTqKmUWsSL86JEPwqYJvUijd
         p0qU8sft2AlXcjpYKb1wKL/Aa96igg3qYi07uEf+FuIClVIQM8ZDDIBlAM1GNFlySpKR
         QHa+Gmatfrb+tsKa3CE7Lp/zTccYw2pPR1KdqQJOtJDH7xM+o3hXe+N3aIBFo1VMXB8r
         mrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749644372; x=1750249172;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4AZ6j0NMkDbuUzKLMepLi9BIBn7jGzM58By2gSjPRM=;
        b=l4D0t8btzdmSgrOjaTeLiHZ8KKV160Z6TuloNw1/dkLMJMlW2mYlmoQf9EYN3hbKNw
         iCLRc8akfVKpW/YwT3F2gKTIAg5XDrRiIbxbSHD4Ba7rtls8ytExcDiGDqkvs62QenFl
         qGwM5oLX1dyIzJyZuYWs8jsiqhvWPXzgWO4C/0OQDybhPk/7+TfIG7+fRIg9Zv6X5lX1
         oz1xzPMnRm0kXAOfyQvZB1gQURvl92GpktdNBG1x/jJsmPCWTtvYRsCyhG6Ibb0f/5fG
         dQP8eLqVEIfR15LqnnOyq19EN1WogX/65dfNCVj12cftVGIKeiZJq/x0d+q4u1H9PjRT
         kgNA==
X-Forwarded-Encrypted: i=1; AJvYcCXxASbKp7RC9WneqF6hYAhkG8apTSXnyX3R8o4wyQxGPoDarTed1T49gw5KFxfDThJiUzrAc6pok6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJymHSeCObYSg/e+CyLx+Vwc2IZjR1Ms/OnUQGDqy5sA7KR824
	q5hp9q6PgQrWkvmsVwVHP6kRb6Dsa0Q/qheHpSc7jmzEEGYYtGF2Ut6Y
X-Gm-Gg: ASbGncvfKkC7ex/64lZlHuCyhOW4+lOQxXvEmlZkI+moICiTF1+a0RCkxV4EitfKiC0
	0f+Oviw1ObIKpgGZF8xXniGH37X7LtyDU5gEiKJt7Qjg207wdiXR0K8NKwG7ZkNcvR2lehiBtM3
	+NW5Cfo7YVZyl6mfvpZGvtJ0Yy8wPXhO5yZj+adQyJmPpoQnp9eySMrOvZITTVnPAsONcy9Ol9q
	sHpYVz5P/5JvLw4hEBC6XRjmrzaBCKuwRm7YD3QWlizWzN9qO8eZJtOrPeAR0JY0QxFzGo0Gtt5
	EbpaLz3jSd8I6UttSIGuew9TlB7js5tuj3BP9ln6RiomT+nBB0kD3g7IS1VQF5EMHBqq0xWoKsi
	P894g88ZWK99ywl9fmBmalyEA
X-Google-Smtp-Source: AGHT+IEBPWrWyZTJ0AaE6X2HuzlzGLroqIJ/tlXWq+i5h6Ps7mPIos09Ey3sq/Pv0UvawSiCWIHyzw==
X-Received: by 2002:a05:6512:3996:b0:553:518d:8494 with SMTP id 2adb3069b0e04-5539d553262mr721655e87.54.1749644372227;
        Wed, 11 Jun 2025 05:19:32 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.66.227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55367731a71sm1938555e87.234.2025.06.11.05.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 05:19:31 -0700 (PDT)
Date: Wed, 11 Jun 2025 15:19:29 +0300
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, 
	"J . Bruce Fields" <bfields@fieldses.org>, Konstantin Evtushenko <koevtushenko@yandex.com>, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Implement large extent array support in pNFS
Message-ID: <tt5y3k7rnnrwwbejkkjubfat334syb2rrdm5rchdui3nwd5dmc@kc3l7wygg6rd>
References: <20250604130809.52931-1-sergeybashirov@gmail.com>
 <aEBeJ2FoSmLvZlSc@infradead.org>
 <uegslxlqscbgc2hkktaavrc5fjoj5chlmfdxhltgv5idzazm3h@irvki3iijaw4>
 <aEfE-r2dkuDRUKsq@infradead.org>
 <75iqhi3to6gohuo2o4h3cewslcjzsfyrl7l7x2x3qyiaaecjci@uwoeqjubvqft>
 <aEkoTdJttLesPv6M@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <aEkoTdJttLesPv6M@infradead.org>
User-Agent: NeoMutt/20231103

On Tue, Jun 10, 2025 at 11:55:09PM -0700, Christoph Hellwig wrote:
> On Tue, Jun 10, 2025 at 06:24:03PM +0300, Sergey Bashirov wrote:
> > the client code also has problems with the block extent array. Currently
> > the client tries to pack all the block extents it needs to commit into
> > one RPC. And if there are too many of them, you will see
> > "RPC: fragment too large" error on the server side. That's why
> > we set rsize and wsize to 1M for now.
>
> We'll really need to fix the client to split when going over the maximum
> compoung size.

Yes, working on patches to send for review.

> > Another problem is that when the
> > extent array does not fit into a single memory page, the client code
> > discards the first page of encoded extents while reallocating a larger
> > buffer to continue layout commit encoding. So even with this patch you
> > may still notice that some files are not written correctly. But at least
> > the server shouldn't send the badxdr error on a well-formed layout commit.
>
> Eww, we'll need to fix that as well.  Would be good to have a reproducer
> for that case as well.

Will prepare and send patches too. The reproducer should be the same
as I send for the server. Just try to check what FIO has written with
the additional option --verify=crc32c.

> > Thanks for the advice! Yes, we have had issues with XFS corruption
> > especially when multiple clients were writing to the same file in
> > parallel. Spent some time debugging layout recalls and client fencing
> > to figure out what happened.
>
> Normal operation should not cause that, what did you see there?

I think, this is not an NFS implementation issue, but rather a question
of how to properly implement the client fencing. In a distributed
storage system, there is a delay between the time NFS server requests
a blocking of writes to a shared volume for a particular client and the
time that blocking takes effect. If we choose an optimistic approach and
assume that fencing is done by simply sending a request (without waiting
for actual processing by the underlying storage system), then we might
end up in the following situation.

Let's think of layoutget as a byte range locking mechanism in terms of
writing to a single file from multiple clients. First of all, a client
writing without O_DIRECT through the page cache will delay processing
of the layout recall for too long if its user-space application really
writes a lot. As a consequences we observe significant performance
degradation, and sometimes the server decides that the client is not
responding at all and tries to fence it to allow the second client to
get the lock. At this moment we still have the first client writing, and
the server releasing the xfs_lease associated with the layout of the
first client. And if we are really unlucky, XFS might reallocate extents,
so the first client will be writing outside the file. And if we are
really, really unlucky, XFS might put some metadata there as well.

--
Sergey Bashirov

