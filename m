Return-Path: <linux-nfs+bounces-16198-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92579C4184F
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 21:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74206423773
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 20:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5C929E10B;
	Fri,  7 Nov 2025 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJgnS90J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89310257829
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546093; cv=none; b=STVZN0zWK+Hc39BBngWW8y2DObs54v+W9DwsEQbK9VNxREMvjW+veORG5dTA/1S+FqhFJ7tvVy9N3VN+xh0aKeH+u8v8sVkDIcA+/nG+PGFguOdVg+WCvFOBFXqBt6jkGRaNIaFYuzL7sp6UUTop3luFZz9Ei0pwvJyTPBnwJos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546093; c=relaxed/simple;
	bh=K4+z/goK0Z5198+0xxYwxqTSJQQWFDbjkZ4jOr1iK1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XS0lUGWYSm8EEvH2Y07TmhefZDqEZrNc/lJqaAO3kysW7Evx7LHz2WlGUFezykHwuJ0JXjBHOcEaytKkAp2qKlXNio4ZackjutruYNJ1w18I0AxRUBHo3nlAyoTZcEGp1H6OF9OyKXr6kptwDIWIZopHKa0bj9s2h2XMKAPCaKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJgnS90J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C39C4CEF5;
	Fri,  7 Nov 2025 20:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762546093;
	bh=K4+z/goK0Z5198+0xxYwxqTSJQQWFDbjkZ4jOr1iK1s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cJgnS90JM7CpuhC7wdtqPnDg4Do5zUxxcfdBxj4+LQ7d0kIwDg2UOqfmhC+pwH/Ma
	 uKpJlOkvDfE7YAYK07NmakffUiyfmPtpoUYOyb8pwITzF31WZ0nCJfWhPa3IPIM07a
	 p8mG6ORC/h+BSH4KW9VytL0t/t1ZK/2W3kt547dlV9ghme+sLmZJyyC40eMbBRLFYC
	 ddy54+4pKrBaDNvgQAaJGVLz6jZxXN+Jynl6xymwCzbuCCmvXCX271oE3bF7aAaSdC
	 KS1Q/FH4ZA3dQWfg54ITSdDpyH8xQUNiedj1PwNuPpNiUwmmSQxjt3ZzcBD3u2EaeZ
	 DieohJ6rSVF6w==
Message-ID: <fb0d6399-ea74-462a-982a-df232e3f4be9@kernel.org>
Date: Fri, 7 Nov 2025 15:08:11 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20251107153422.4373-1-cel@kernel.org>
 <20251107153422.4373-3-cel@kernel.org> <aQ4Sr5M9dk2jGS0D@infradead.org>
 <82be5f47-77df-423d-a4f3-17f83ddb6636@kernel.org>
 <aQ5Q99Kvw0ZE09Th@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aQ5Q99Kvw0ZE09Th@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/25 3:05 PM, Mike Snitzer wrote:
>> Agreed. The cover letter noted that this is still controversial.
> Only see this, must be missing what you're referring to:
> 
>   Changes since v9:
>   * Unaligned segments no longer use IOCB_DONTCACHE

From the v11 cover letter:

> One controversy remains: Whether to set DONTCACHE for the unaligned
> segments.


-- 
Chuck Lever

