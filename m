Return-Path: <linux-nfs+bounces-17497-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5484CF909C
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 16:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 727913008190
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CCC33F8A0;
	Tue,  6 Jan 2026 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC8TfJXD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F22E33F39B
	for <linux-nfs@vger.kernel.org>; Tue,  6 Jan 2026 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713043; cv=none; b=erS+ewSIzWXQH87NF6fEntZXgNlf0Ni1NERqXqMj1zmG6TvWomjWf8V8RqjHq3cC8uqa+Xrhl0aulBNEqkc6dJkdXY05vYAN1gHuAKTOFcuM0cN8mYOZov+E36H9ylYQMr1I24tBwhmZZHERAjIq7QfwnoTw0Az2Btk+vy/3ia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713043; c=relaxed/simple;
	bh=joogkLajDl5lPj2MPSts99l4gkwg5PMOk/7aQxb6T/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4LyQ6Sj5y6PRU99rb62tAwvI614N8bjO81cuOt9TQfz2O1qVuXPyUM9g4MbG5bswgG+lEUSBEGSb2/VoOvnIMOa7p0eMSbyEB4Pq2fY86s87p1et0UAYIbyNt7445B+ettO3fVZuBUCnQdwqlq8NAvEyThTmiZRr4Glerje0HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC8TfJXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C361C19424;
	Tue,  6 Jan 2026 15:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767713042;
	bh=joogkLajDl5lPj2MPSts99l4gkwg5PMOk/7aQxb6T/8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BC8TfJXDofcWSuHwNt/Fto6moziy0J94jiX91iX+X2d4zQhJwRtWq/JIjpjvc/Crc
	 VwaYMnmc1Sa2VO18xSxSY4eaByDiu/4O6Qon75GsvKxNXqDDgKwXOLX/TeoBHSm3BF
	 Ih4wqOy9LQmHzKwr58hn8nvz0yPMF3v7FVJfGX2uXOAJgOcqHard2MWKR65ESlH3zV
	 CSKRAZQi5ievo4Jfymd9qUgnEQ6+KeR87DpK3aSx0ZM1Y+qFH/nEXGA81hKF8m9CVY
	 wOcWQYKeCzj832s2UrZHdTaFqzsfjYSPiEdrUM7sHeFQmtRgzFejw0Y9NfVtxzbFMl
	 0G3GXfH0m6/kQ==
Message-ID: <99cd6e95-821d-4a9e-8a34-135260716200@kernel.org>
Date: Tue, 6 Jan 2026 10:24:01 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] fs: add pin_insert_group() for superblock-only
 pins
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@ownmail.net>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20251230141838.2547848-1-cel@kernel.org>
 <20251230141838.2547848-4-cel@kernel.org>
 <0ba142a609b8ce5462b0ec4658886624ae3dcf0b.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <0ba142a609b8ce5462b0ec4658886624ae3dcf0b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/26 10:22 AM, Jeff Layton wrote:
> Having nfsd as another user of the fs_pin infrastructure seems like a
> reasonable thing to do, but I wonder if the VFS maintainers might
> rather we use something different here (notifiers maybe?). I'd loop
> them and fsdevel in on the next posting.

Agreed.


-- 
Chuck Lever

