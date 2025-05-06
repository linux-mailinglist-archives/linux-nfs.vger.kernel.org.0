Return-Path: <linux-nfs+bounces-11498-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9495AAC6FA
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC671C20898
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 13:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906AA280333;
	Tue,  6 May 2025 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIf0qtDt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9E280317;
	Tue,  6 May 2025 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539529; cv=none; b=uXTPuDI3LD2BKfO0UQyodlmLR86LARUALjDg0lfcJQTnF4lofiE14pK8TvwfCb+zaK7rVX+Gs5nmnVg0/nS2JIIiRhMQgOxMqa/zBRONmo5nsCaiJO+0TqEMZNKsDr7xlVZeb6aH3wG2sdNZ5BJY+xWXX5ogWtyeBJ7xURklRW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539529; c=relaxed/simple;
	bh=nlsKABu2vTPnjQMNLRh/41qwAN0csc2tVbntKpQacV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1DiyEc6kGX+sQGlAJAMkFgIvrNEFlIfP/1t3Qy4mIFiyqOgtiWoUlIMghVgEUmRm+5jN3gCRXWt+Wj4hTMw262oEEVN0vTGClBiAf/O3e9guF+mvtdSSRgMtqRnbiI3jyAajA4jExrDjMPfHkd8vqbP4fsgpr4CrER5GQx8tP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIf0qtDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B40C4CEE4;
	Tue,  6 May 2025 13:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746539528;
	bh=nlsKABu2vTPnjQMNLRh/41qwAN0csc2tVbntKpQacV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RIf0qtDtL9dZpktgn6xaowOzyx8LB9jqUdKcuOgSi89tqlIcY0lKNMqULNsXb17Fg
	 dd+DiR30mVqSOHdnTU8wGBA1u4qx+tgywnGUjIYUq2LqCXfUJTd7V4MhcGGjvWimfw
	 iY59RWyZQ1bpF5kbnguF/cr1dQyTY46keVB9eUr/o1sQsQrp6JUruFP3D1F3IJTB5+
	 ZzW8URE2XKyo62CgNkHHcKK/yQflCj1tMc+kJvDmZEtiSTbTzy+o3HMo3Nt/UaRt8G
	 u+VUiO33lRraRzBIgvBGwdmWkUJq9fhNTbE8bAmtGCCKEjxmYIDaEXcnUI2ZZaF4FR
	 t7924iB9gSqog==
Message-ID: <390ac9ce-d32d-4534-a406-52288f79ab0c@kernel.org>
Date: Tue, 6 May 2025 09:52:06 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/14] SUNRPC: Bump the maximum payload size for the
 server
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-15-cel@kernel.org> <aBoP249KZ5G9hU81@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aBoP249KZ5G9hU81@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 9:34 AM, Christoph Hellwig wrote:
> On Mon, Apr 28, 2025 at 03:37:02PM -0400, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Increase the maximum server-side RPC payload to 4MB. The default
>> remains at 1MB.
>>
>> To adjust the operational maximum, shut down the NFS server. Then
>> echo a new value into:
>>
>>   /proc/fs/nfsd/max_block_size
>>
>> And restart the NFS server.
> 
> Are you going to wire this up to a config file in nfs-utils that
> gets set before the daemon starts?

That's up to SteveD -- it might be added to /etc/nfs.conf.


> Because otherwise this is a pretty horrible user interface.

This is an API that has existed forever.

I don't even like that this maximum can be tuned. After a period of
experimentation, I was going to set the default to a higher value and
be done with it, because I can't think of a reason why it needs to be
shifted up or down after that.


-- 
Chuck Lever

