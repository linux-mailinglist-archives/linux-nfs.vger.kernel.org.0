Return-Path: <linux-nfs+bounces-15820-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 163FFC22B8E
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 00:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB51A4E1D09
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 23:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C512DF153;
	Thu, 30 Oct 2025 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="er7xO1+c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C065624169D
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761867598; cv=none; b=Iapaj1h2K8AOja8a6ecL9QUP8X018yw++3GPokUbSk22+LQVdlh+q1BN2SYDGbaLqKTcpiPxQzfQM8hcUak8ZlpxX/kDgcyPCpC9GPDZHgz6O0Dw3eDFoURsz7SfnYyDDM05ypwyPlG59iPOi1jPPszpocCE0gYcExNHcUO+fEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761867598; c=relaxed/simple;
	bh=+PP0xz2gh6H5h6uRwr8000Xldty0jSdkhs5rP+cfEA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqSMXQE+ViOGKgN2B2t3Chbv8S/PlRtBVCprPXaWHJZsTOl+qWAavkSjM4hyayfF4cJMj+pehRHS7j9hRKQVhNqiQVTLSjjxdl+Jl9ZdLn3TZAsDY6x/gTns0kNZRpPEC3o+KSZdQWnsfwzBqafUn94PwUNeryLNWw3VNkCe4fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=er7xO1+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAF0C4CEF1;
	Thu, 30 Oct 2025 23:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761867598;
	bh=+PP0xz2gh6H5h6uRwr8000Xldty0jSdkhs5rP+cfEA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=er7xO1+cYM4a3fSCde2CacUpPjRjSbYoqrANo5vcyGh1xOKMHabCX2gMGa8Jf4hT/
	 5dCZu+ZYTGFMIhTWuPsEWBA+hVeZHVFCzl73jwS3SMD1qHzVOvPDXfeQ/6ncB2Xz0N
	 Fuibto5ITQCeI00gVLhOT+51ESvYNM411ubf7bDgi6AaFjWXKUNYyzsCNQoC3AhVea
	 rNH85Po1IX874o+UEeAvEEoo5bj9728mU/mYCo35qKhl85eRt19JXARPAA41+jDN3s
	 6X7Ffjz9sPxvPqSKoPjq2zwOLKHQHTNRyNor1sEvDmSO+oQxP6uI+cA066wnYf+0Ou
	 JdO50f8qUNhWg==
Date: Thu, 30 Oct 2025 19:39:56 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH] NFSD: Add a "file_sync" export option
Message-ID: <aQP3TCtxGX9bkpGV@kernel.org>
References: <20251030125638.128306-1-cel@kernel.org>
 <aQN0Er33HIVmhBWh@infradead.org>
 <aQOFLMJzUZuwj_K7@kernel.org>
 <d046ee5e-4944-43aa-b859-21d85eb55dd6@kernel.org>
 <aQOTA76KRGMyVR75@kernel.org>
 <e86505aa-04d4-49eb-942e-994320d6be1a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e86505aa-04d4-49eb-942e-994320d6be1a@kernel.org>

On Thu, Oct 30, 2025 at 03:13:05PM -0400, Chuck Lever wrote:
> On 10/30/25 12:32 PM, Mike Snitzer wrote:
> > On Thu, Oct 30, 2025 at 11:47:15AM -0400, Chuck Lever wrote:
> 
> >> But, in the bigger picture, I think comparison between this approach
> >> and NFSD_IO_DIRECT might be illustrative.
> > 
> > Sure, I'm very interested in the data myself.  A patch to easily
> > enable control is all I'm after. So given what you said above, I'll
> > actually just run with introducing 2 new variants of NFSD_IO_DIRECT
> > for now, so like I mentioned in my previous reply to hch:
> > 
> > NFSD_IO_DIRECT_DATA_SYNC
> > NFSD_IO_DIRECT_FILE_SYNC
> > 
> > Because it sounds like it is only in the context of NFSD_IO_DIRECT
> > where there is any doubt about whether using NFS_FILE_SYNC helpful.
> 
> I'm not sure where you're getting that. FILE_SYNC is interesting for all
> the IO modes, and I'd really like to see specifically the comparison of
> NFSD_IO_BUFFERED with "file_sync" and NFSD_IO_DIRECT with and without
> "file_sync".

I wasn't talking about file_sync being useful or not in general.  I
meant based on what you said with file_sync uniformly hurting
performance (even with tmpfs) that it wouldn't be a question for IO
modes other than NFSD_IO_DIRECT.

Anyway, I can change to implementing the control in terms of an export
option.

Mike

