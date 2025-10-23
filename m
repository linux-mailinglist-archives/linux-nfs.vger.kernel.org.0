Return-Path: <linux-nfs+bounces-15557-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7FEBFEDB4
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 03:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0B744E77A0
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 01:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62794C85;
	Thu, 23 Oct 2025 01:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D+vpVHtO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8671D2F42
	for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 01:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761183309; cv=none; b=Ol0kMJdb6AxmYs0U/sVl+4beXcs0asPxTEbkTayFDUq6foEi/eT6ZgN9LTci+jqO8XcwTbqNA/x/1QKK/lVG8cHy4U0PYtSbrnr7o7cgMsSOf96j1LLoKJ+Xca4HRF6Gbo0D5ZwF4x7qvx21SQTuHXHc80/MKLhtH8lYA3ucfug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761183309; c=relaxed/simple;
	bh=UliQeU7ADJZ0T4heCcW3UFjf09ZGZKTQYPq2dS65w7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZlimJmi3p3afdGU6W5QClzc7/pUhYXvxt8q6HtJk/LynIcU8Msboq6JHAVhftoBUG4UYELfbR3j8JZUCuLcSWqoFy2NDgquKthO5D4L3fTof7IyuUpcpSq5QrF2wEDtNXgBeuTax6RhMNsQLZhgLkaV0M7uUlouQYlYcIrBgIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D+vpVHtO; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f7d685d6-fd1a-4de5-ab55-da01ee4a18ca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761183294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8M2621n27/ekFNZHN/+RLt0wU0H18xOlFXGSJsZgBU=;
	b=D+vpVHtOWYWYbEj1lvsMrAQBrhqJmfOWjQHLFmjZwaPgaOHog8Ho75gc9fdwAjQCRjWj3N
	X2gouqOXFe8NRUoT9S3egEOZQ69SAEzMxxMMP3s3ov/tnJmr/3qKmwbiWcnCNE5SeoP5rM
	mvfxz9Py52vOcaoO7BOD+PAFq0NrExQ=
Date: Thu, 23 Oct 2025 09:34:05 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Where can I find nfs-utils?
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com,
 trondmy@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <39c67bcd-5369-44e7-9c7e-e9702ff95d53@linux.dev>
 <f2b76db28f459720ccbb7fb584e530b31485de3f.camel@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <f2b76db28f459720ccbb7fb584e530b31485de3f.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Thanks for your reply.

On 10/22/25 6:16 PM, Jeff Layton wrote:
> On Wed, 2025-10-22 at 15:51 +0800, ChenXiaoSong wrote:
>> Greetings,
>>
>> Previously, the nfs-utils repository could be found at
>> https://web.git.kernel.org/ , but it can no longer be found there. Where
>> can I find the nfs-utils repository now?
> 
> The canonical repo is here:
> 
> http://git.linux-nfs.org/?p=steved/nfs-utils.git
> 
> Cheers,

-- 
Thanks,
ChenXiaoSong.


