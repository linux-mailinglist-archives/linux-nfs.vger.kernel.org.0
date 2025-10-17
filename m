Return-Path: <linux-nfs+bounces-15337-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDD1BE8D6A
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 15:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35FE95661EB
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 13:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8E43570CA;
	Fri, 17 Oct 2025 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ruuc4GAw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D7A3570C4
	for <linux-nfs@vger.kernel.org>; Fri, 17 Oct 2025 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707625; cv=none; b=gWMZDLdQk2DzcNHpEJdc9eUkpFGrD3z+KTNkqhLdIOVFdO1dphMF6nVrVXAFH9BPkQAv20/aAXqSYLy0m46eWUlO2z7tvesstZuZJf9E0sjyd5EaVEQaXjHaiFRn4Yo5WnkVRbn5vBzCcVW2K+fUlQ9lhouJnko5WD6wsDonh4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707625; c=relaxed/simple;
	bh=ck7Fz/ddG6W65aSodIrt7cbdwDG5hTHBkxRx5OJ+ok4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dl+F/wARrp2I1SPlsEsBMB2VqhYaIZkMKAumTx0Uk4yXJeZ98QuecysyTXyCjFoceccfXqIf0uqYbuXpFNuXrMWHUlZCcyoagZ/ChmJBbD0ENZ4BcKfaJZn2S9Eaqfq40diggxM9r90xyFfDPm8VjRumpEOy5kugSgWEJunPHqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ruuc4GAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D37C4CEE7;
	Fri, 17 Oct 2025 13:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760707625;
	bh=ck7Fz/ddG6W65aSodIrt7cbdwDG5hTHBkxRx5OJ+ok4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ruuc4GAwceqHDdI0IUbh7aAlkh90YPSOuPHi+N+/K6jzoGwqBjjbHpQttmy0Lgxjo
	 f3Cubd1BRHk0gziaq4wIkiCwA2paAHoSbvaQ6dtBsdEVy929RkCOA+RWrTA4bfzJuT
	 MieiuiHvbWvOjWMjHu/Shm/2F1+ttrXZnwb9TCR1SpdbwI5sHzEL2+8jeb7J1raFY2
	 vATNdLuAqVyWYtK2zIVlkdTMO0PTUcc0icc7BKqLbCZUN0yB1q+5Bj9l3yzIplc0e4
	 WS6wF+ENlznn2XC4vXpEMw/0mtnoj5/Ca7U2NxlByDBxUhyTQ+/JtZWTjD9PCVgSmX
	 xbARF0Zux/UhA==
Message-ID: <86a22a17-e12f-4f08-8d9d-89b1b97ae2af@kernel.org>
Date: Fri, 17 Oct 2025 09:27:03 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] NFSD: Enable return of an updated stable_how to NFS
 clients
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
References: <20251013190113.252097-1-cel@kernel.org>
 <aPHBLFrRXwPaasdb@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aPHBLFrRXwPaasdb@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 12:08 AM, Christoph Hellwig wrote:
> On Mon, Oct 13, 2025 at 03:01:13PM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> In a subsequent patch, nfsd_vfs_write() will promote an UNSTABLE
>> WRITE to be a FILE_SYNC WRITE. This indicates that the client does
>> not need a subsequent COMMIT operation, saving a round trip and
>> allowing the client to dispense with cached dirty data as soon as
>> it receives the server's WRITE response.
> 
> What's the subsequent patch doing?  Having the actual behavior change
> in the same series would really help to understand what is going on
> here.
The subsequent patch is:

  https://lore.kernel.org/linux-nfs/aPAci7O_XK1ljaum@kernel.org/

We haven't put the two together yet.


-- 
Chuck Lever

