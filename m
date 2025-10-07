Return-Path: <linux-nfs+bounces-15020-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86717BC1B62
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 16:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402723B1971
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 14:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13120189BB0;
	Tue,  7 Oct 2025 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmqaz70q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2404170A11
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759847058; cv=none; b=T7o7OubRC8VVgPLXfm41Auk8nmmxwnGu7XweH6sdaxZkWZxBhc0nZ89mEgUZzp9oL1sQzQEFAKKUSpKO7fIFzScLE7EtRT40CazGXmW8amZJfBWWkb0hEQCA2SB3D2WVkssrDpgWBnlKMESZqPrKvMUlXilSdsWIGJegq4tjEH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759847058; c=relaxed/simple;
	bh=sdF2zFL+N1RGQcmM1ZtWW0fySNUcc7ehJK1wD4y5Hhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivFJEEhjxKx5s2kK4wHfHNU+9ooJTGqU4hvpflAe9es2fwghoDA8pfVAR9vCSi0/GI/WigCcqiwC/bPdQNeqwtpf/kdi0pXM7MdW/v2erDA6KukKlCYOkmnRNLgZOumvBUoH5EhChVVCX0AkQCkwRdBrWLvSYk4F8C1d+Hv1yrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmqaz70q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77854C4CEF1;
	Tue,  7 Oct 2025 14:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759847057;
	bh=sdF2zFL+N1RGQcmM1ZtWW0fySNUcc7ehJK1wD4y5Hhk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rmqaz70q86hC8FDBfCfKkCpe+/f4V6mBctgXiHtQWF4iM6XVbEcFhBsbxYEfET22T
	 16Iya58q7PRFno1YaFLyWjHXZ1SG0UY0zRNR/D1ZaXX8rDlQWbM6CgVTRweJsnJH5y
	 wDJAIJ3L9gYWlNe5bDBCfQTrjG6TVh70HnIdnZCoP1C5GIEV9dpuK7PMCZ+F+TBP6J
	 Pi7/YDKnORDaB+Alvsb8zugLlyx/u0IcLAmn+bIJqjjzcx6YwrJbWlZjx4ZESebPyw
	 0TtB882I4UHcG6Gm2RrAC32o8r0G+9nLPO4d6KKOn2fh4dw1DfU1CzydiRZO9AOdm9
	 wbbwZROfvDm6Q==
Message-ID: <e44aab7c-db22-4ee8-95a6-2dde4d45667f@kernel.org>
Date: Tue, 7 Oct 2025 10:24:14 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] NFSD: Skip close replay processing if XDR encoding
 fails
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 rtm@csail.mit.edu
References: <20251006184502.1414-1-cel@kernel.org>
 <20251006184502.1414-3-cel@kernel.org>
 <175c75397d06b7c92ae0b9fc2dbb31af5f26bc02.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <175c75397d06b7c92ae0b9fc2dbb31af5f26bc02.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/25 10:18 AM, Jeff Layton wrote:
> On Mon, 2025-10-06 at 14:45 -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> The close replay logic added by commit 9411b1d4c7df ("nfsd4: cleanup
>> handling of nfsv4.0 closed stateid's") cannot be done if encoding
>> failed due to a short send buffer; there's no guarantee that the
>> operation encoder has actually encoded the data that is being copied
>> to the replay cache.
>>
>> I think there are deeper problems here. Is stateid sequencing
>> screwed up if XDR encoding fails?
>>
> 
> I would imagine so?  We will have certainly morphed the stateids in the
> server, but aren't sending the updated info in the reply, right? That
> seems like we'll end up in state recovery.

Fair enough. But it feels to me like a layering violation to manage
stateid accounting in the server's XDR layer.


>> Does NFSv4.1+ even need to care
>> about this?
>>
> 
> The stateid confusion? Is there anything we can do about that for
> either protocol?

I'm wondering if the stateid accounting is also needed by NFSv4.1.
I saw that OPEN_CONFIRM was included in the set of operations that
participate in this bit of magic, and wondered if this is something
that only NFSv4.0 needs to do. But the magic is in the generic NFSv4
processing path, so I guess I should assume that yes, NFSv4.1 needs
this as well.


-- 
Chuck Lever

