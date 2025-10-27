Return-Path: <linux-nfs+bounces-15682-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B9AC0E4A8
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D6D634E60F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD402BEC34;
	Mon, 27 Oct 2025 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rE4yz62N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9911758B
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574291; cv=none; b=LpXmIL4ewnNz17HB/n2QMvoMSpPy+m5tLK77UdEPaaKInANy4oWGortX05DWE8x0m/wB4JxsV7B3f7vkFRQjxG1pkYgqe3nrifT0ri5QLPgfvU2qimY9PqbHpDmaqa9saTlWefaPN0cCEPBKD0G9NrR03AUwY0+HOny1Oaobd+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574291; c=relaxed/simple;
	bh=0WWlHP23FTOvR4Ri+tl+r2mMEh6xzT+PZ9v8qluTzx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/rSbKOHNwGr8LnT+uUDPXhfMUKdXMhICpbPdpupu0SlZRDVASA56FaYVQgYe3ylS1pXyy75/4ylkr/Cfr2JrjNIC6z5nK13bKEq0sL6g0MK5q66WvWnjWWaFtbiGRJzsX9cHXhBDhQFgWJdSxKOsPOJzTeb10Ww71cUowTDZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rE4yz62N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2F0C4CEFF;
	Mon, 27 Oct 2025 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761574290;
	bh=0WWlHP23FTOvR4Ri+tl+r2mMEh6xzT+PZ9v8qluTzx4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rE4yz62NDP0uPcC7P4KLjnaY3bkskcKNHBA0rJENtpXM6omf/u3jiafLIIYfDSM06
	 Rm+fbD/tCxeq6xSs0iWL8JAgochfO6jSc4Im+smmuUELBulMx8hPTogEZJw8kO8hJt
	 hXXp1lu1uzOfD9TSDZ119ykZjxZjLEjz106kY6D+oENhvKfYUaQYJd8S+Cku64p3Wn
	 PKDZaj+Fe4jalnn7PpiNBS1K5EIZsHM1UZFgUJohvb48kDHEvHU1fLVJA9sqI2HPRN
	 lwZ6ymp+QXvf3NuEVlh+3baFCNXzE0DbKnGF+J6bZlCmJQocl1B8ql31Z5vj9fAoo4
	 ne90mPV63kmkw==
Message-ID: <07d26450-5a88-41f8-aa5a-32e9d850a2e2@kernel.org>
Date: Mon, 27 Oct 2025 10:11:28 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
To: Christoph Hellwig <hch@infradead.org>
Cc: Mike Snitzer <snitzer@kernel.org>, NeilBrown <neil@brown.name>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-15-cel@kernel.org> <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aP8pfpm6jb-Hj92B@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aP8pfpm6jb-Hj92B@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 4:12 AM, Christoph Hellwig wrote:
> On Fri, Oct 24, 2025 at 03:34:00PM -0400, Chuck Lever wrote:
>> If (IOCB_DIRECT | IOCB_DSYNC | IOCB_SYNC) /is/ correct for all file
>> systems, then it needs an explanatory code comment, which I'm not yet
>> qualified to write. I don't see any textual material in previous
>> incarnations of this code that might help get me started.
> 
> IOCB_SYNC always needs IOCB_DSYNC as I explained three times now,
> including a detailed analsys of all users (We really need to rename
> IOCB_SYNC to __IOCB_SYNC to match __O_SYNC to make this more obvious
> I guess..)  I still don't understand why we need sync behavior and
> forced stable writes at all, though.
> 

Well the relationship between IOCB_SYNC and IOCB_DSYNC is absent
from the iocb_flags() helper, which you referred to in email a few
days ago.

What would be best, IMHO, would be actual API documentation, since
there are too many subtleties to expect adequate documentation from
smart source code alone. Hence my hew and cry for some text I can
stick in a comment.


-- 
Chuck Lever

