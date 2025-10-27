Return-Path: <linux-nfs+bounces-15669-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEF6C0E018
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A48400300
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C0829CB48;
	Mon, 27 Oct 2025 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5WZCB07"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38672264AD
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571552; cv=none; b=r3VMCAlf/mYZEgZU0EDf4c3f/Q6JZOm8mX8ZJIVeJNPAJ+LRR5+QWOy20JBz8dbK25D+63ev2iZqBzXGtZEhNizSOotM7XD7/JJkC2CTSRkWDI9Xrw5yRztqVID+kJP7HCfMf6+Jwacdphmt+g5TuK0VervawR9R8e8xnW4jfnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571552; c=relaxed/simple;
	bh=MJxIVqyABXEBO6zURfmsJW0BIzniuy6GFN4s5C/SszU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DeNZ5y/cF8tC/PLKHyvUfZkUdMHdnsvELqSMQFnx3nM8nGMYMtrPkslvv0hsho+aw2f2TsiucG4W/8y8HDl4heyxIMWAsA99/jBENoQFjD9em1bdnWCu56NDWLNrWatmGOJdrKDsmzXPjtXsu77+bEulh9MXXGgndzn/kA6BuYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5WZCB07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6684C113D0;
	Mon, 27 Oct 2025 13:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761571551;
	bh=MJxIVqyABXEBO6zURfmsJW0BIzniuy6GFN4s5C/SszU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a5WZCB07o4J+WOhrEmnqOheYpwXScyH+pkhetfxG0TGMTgX9ldK+E3tnq+bVNaa65
	 RT68i8immr3S5Hke6d1HjVdGH4d8EqjtX1rZF8C3Ljf8a2I7aWrzheelFcV2enUPCJ
	 1kSJn/s3qdYlhr2whuyUnIWRXf4iawojNGFGSkKXrMkKjZ+1pvJU1nwRC3vq29SzD+
	 Hf8ILovgFUOmBnfsydgNWRRUptWR7FjGcyM5R+cyn6ClEFVUqJMydkNZtKu991R7Li
	 bNFTfrCxUgHvmYmeDf+WPHVd0USUq3tv1saYN0jyOJ9L+i13qm5a9sSYK8ApqKlNPz
	 O7LqphZK8ZSSQ==
Message-ID: <8aab9213-b334-4c87-8fa4-efabb5daeeb3@kernel.org>
Date: Mon, 27 Oct 2025 09:25:49 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/14] NFSD: Remove alignment size checking
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Christoph Hellwig <hch@lst.de>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-9-cel@kernel.org> <aP8otlrPH3DerSR-@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aP8otlrPH3DerSR-@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 4:09 AM, Christoph Hellwig wrote:
> On Fri, Oct 24, 2025 at 10:43:00AM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> The current set of in-tree file systems do not support alignments
>> larger than a PAGE, so this check is unnecessary.
> 
> XFS does, although your won't find production hardware with > 4k
> blocks as far as I can tell.  The reason to drop this check was
> to not arbitrarily exclude them for no reason.

IIRC there is a reason: NFSD_IO_DIRECT writes won't be able to align
on larger than a page (for the memory buffers). But perhaps the
alignment constraint that was removed applied only to the file
offset.


-- 
Chuck Lever

