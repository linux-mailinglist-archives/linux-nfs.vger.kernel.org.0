Return-Path: <linux-nfs+bounces-15806-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66058C21E36
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 20:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0060D3B3815
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 19:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0777C329C64;
	Thu, 30 Oct 2025 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzMPLsa/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D563168E0
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851587; cv=none; b=Q5qTIG852KSKVbpOdCf2TbdlqtUhMHmPhb+vuDz6Htzh0porw5cNI0TzrzpIP+VLIKm1/MP/kIyce1F+8V2+/IQ/VVR2TtgBPjy+G0FS62ep9rmrp70t+b4g4FfbpR9Imtr4dxQx2dyXqfQQf3d8BocUBS5O/7ZcHmc+TbG3Dxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851587; c=relaxed/simple;
	bh=FHLgqGqki9yDnCNETn3rssRbEKF4yca2TaCVz/QNXLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/HvypqqJoqyNnxujg4wRGHtQSqmvRNBDYWzwmKnZnHxPXrAaJy/c+KYDGPNH3pf0PqE68Zcbr9fsWQYnElBDSn6OiiHlY+XnD5B9M2gcdW1W0hiKKc678UK7C9OBkVjxuJadPGuOtzxhzE3x3OGLKr8d6SRzDQCHb5p4eiHP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzMPLsa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18010C4CEF1;
	Thu, 30 Oct 2025 19:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761851587;
	bh=FHLgqGqki9yDnCNETn3rssRbEKF4yca2TaCVz/QNXLE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZzMPLsa/wQjLhH+qB0KiaToNTbgR3NS98joA4BOzf8qW9YIX708ufCaI+JycDhLby
	 OlfG1etzzABlWxDboGKxEDNJz6Hq+HupK4pHVcGKoQeO/26HdjRNZq0mE2Opti8fkN
	 SbgXSml5EENfFPxKsnwi+ZbuR4ZtW5YAJS7EBp9n/rSTReo+JWQgN3AXBwtsUKCAO+
	 g89M9hCt0HECV9K2rYH4dgN9eTbyGEM6xTDxvMNOmtvSY/qu2wt+DOmpbUZiOlyeCD
	 /W3NzVTMihs3UxDywrGFveSGc7/cH9hrVJfmsr3/4BXu/uR35ycPzrtGGNGvRI/n1+
	 KSGGa4hVhVEjw==
Message-ID: <e86505aa-04d4-49eb-942e-994320d6be1a@kernel.org>
Date: Thu, 30 Oct 2025 15:13:05 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] NFSD: Add a "file_sync" export option
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20251030125638.128306-1-cel@kernel.org>
 <aQN0Er33HIVmhBWh@infradead.org> <aQOFLMJzUZuwj_K7@kernel.org>
 <d046ee5e-4944-43aa-b859-21d85eb55dd6@kernel.org>
 <aQOTA76KRGMyVR75@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aQOTA76KRGMyVR75@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 12:32 PM, Mike Snitzer wrote:
> On Thu, Oct 30, 2025 at 11:47:15AM -0400, Chuck Lever wrote:

>> But, in the bigger picture, I think comparison between this approach
>> and NFSD_IO_DIRECT might be illustrative.
> 
> Sure, I'm very interested in the data myself.  A patch to easily
> enable control is all I'm after. So given what you said above, I'll
> actually just run with introducing 2 new variants of NFSD_IO_DIRECT
> for now, so like I mentioned in my previous reply to hch:
> 
> NFSD_IO_DIRECT_DATA_SYNC
> NFSD_IO_DIRECT_FILE_SYNC
> 
> Because it sounds like it is only in the context of NFSD_IO_DIRECT
> where there is any doubt about whether using NFS_FILE_SYNC helpful.

I'm not sure where you're getting that. FILE_SYNC is interesting for all
the IO modes, and I'd really like to see specifically the comparison of
NFSD_IO_BUFFERED with "file_sync" and NFSD_IO_DIRECT with and without
"file_sync".


> So it bounds the supportability exposure, and makes it clear these
> knobs are for experimental purposes relative to NFS_IO mode controls.


-- 
Chuck Lever

