Return-Path: <linux-nfs+bounces-14576-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 220A9B86699
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 20:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC05542CEC
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 18:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB6C2C08A2;
	Thu, 18 Sep 2025 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTSql7aZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299E627AC3D
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758220061; cv=none; b=IMTMOxtXPbFHgTTJUadIuxSCUkjaT+QThOzpWDgSSaSS9pvEZfleiPirwD06Ai19T3sOSAo1bUSz0qzU40o4rTujmNfyWA6QefZGYDhgE6hEJGFMGRKvzOC3rHxrEotpxku8x42ldrj1317gT+c9CFqTF2mjPbynSKs73Z67Uoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758220061; c=relaxed/simple;
	bh=tx5GqYtMycwZQT+7xetGJ4h7cusHRwMNIOYE5H6bUeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExRaeVMRr/JMFwU/pUGmPyKw+rhzkmyh8YTtDS9T0Uze2u1Nd9cbqfX15WIGB8IVHYrGb6oF6e8EgFNHG2tqlPdH8f3pyKnEe+gkqvU9WfKHaQLrg06wfBWMe0VsjRpWqEBuMdZprNOZl30i9UiQz70JArMs4vNosFQEq1IpQVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTSql7aZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201D8C4CEE7;
	Thu, 18 Sep 2025 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758220060;
	bh=tx5GqYtMycwZQT+7xetGJ4h7cusHRwMNIOYE5H6bUeQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lTSql7aZjqlzCv/PPgubTRwk/zMZxvxuWnTRDOwQ54pvKT3ZvBSVW8PgFVGFIbofg
	 FBVxt4oPHN/8HvAa4YTuhPYs2lIwam/sWZ3UFuFlxZhBTXzPDQehGqU+Wk7vFr4u84
	 f3ndXm7cTyhEYUfgGgPGtAb01hbW33479bLp6pnuw+emXUBaZtFZGzzImFR68PTonQ
	 NKixBSvdPuzjYWy6suT+3YuHW9Zirvr9YohzKE6RuP0b/J+wP/KBLSi7p8i+J7Uqru
	 jsMYa94njbh+BdOjCFZE+FM7tDq4V/GhxG3Mv4CT7sYf3dhxScGPg5aJ6oVOOQogbD
	 sPTzc3EIiwXHA==
Message-ID: <1f530bb2-3813-4f8f-a326-d6ae6dc2466a@kernel.org>
Date: Thu, 18 Sep 2025 11:27:37 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] NFSD: Implement NFSD_IO_DIRECT for NFS READ
To: Mike Snitzer <snitzer@kernel.org>
Cc: neil@brown.name, jlayton@kernel.org, okorniev@redhat.com,
 dai.ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org
References: <175811882632.19474.8126763744508709520.stgit@91.116.238.104.host.secureserver.net>
 <175811952039.19474.5813875056701985362.stgit@91.116.238.104.host.secureserver.net>
 <aMwzU50fiZSN00JP@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aMwzU50fiZSN00JP@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 9:29 AM, Mike Snitzer wrote:
>> +	/* Read a properly-aligned region of bytes into rq_bvec */
>> +	dio_start = round_down(offset, nf->nf_dio_read_offset_align);
>> +	dio_end = round_up(offset + *count, nf->nf_dio_read_offset_align);
>> +
>> +	kiocb.ki_pos = dio_start;
>> +
>> +	v = 0;
>> +	total = *count;
> Hi Chuck,
> 
> Looks like you introduced a copy-n-paste bug when updating
> nfsd_direct_read's while loop to follow nfsd_iter_read's lead.
> 
> Should be:
> 	total = dio_end - dio_start;
> 
> [NOTE: this was the reason I saw a crash with my incremental patch
> that handled 'base', see:
> https://lore.kernel.org/linux-nfs/aMwcUdWdey69k2iK@kernel.org/
> ]

Indeed. Fixed in my tree, I will push it in a moment.

I'm traveling this week, so I don't have an opportunity to do more
than compile-test these before posting/pushing.


-- 
Chuck Lever

