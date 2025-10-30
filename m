Return-Path: <linux-nfs+bounces-15802-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FE3C21370
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 17:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91AE84058C4
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA572DEA8C;
	Thu, 30 Oct 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNXQGoF/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA752DCBE3
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841925; cv=none; b=LQyPzI1V3EJ/CIYFgDe18n11obg9gm5tdQ0e4p7rtycQOLTqJdcwBFoPmjuf9osG6i2c7A1jbyE0xg7hBZHMakkXup8ZozwJ5rHErHJgtHMDqHM4NfDtqLzxBM05Ar1H9eW9Ipg5JyT9j5EkUDKgfgwUOZOtWyRYW0DShus213k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841925; c=relaxed/simple;
	bh=DV85ka+3pI6N5aTEEHuMW66Xms8Re9O58qLCltxUZHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axuhQUy9KGYTJi/Co9gn3mRSfwX92FE5vDHptHceQ3twXTugNQ+6iR/Ec4bj+c5sykir1ZapQmbVfSe+uUx9iA8Q/WcbSOO/DNGzCDKUw0BtjT7tqz/FU6M4cSQXJnn9+LrrgRRuRe53h9OBp6aPBKIFfRp3wF0XOUxwndNw43A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNXQGoF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68712C116B1;
	Thu, 30 Oct 2025 16:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761841924;
	bh=DV85ka+3pI6N5aTEEHuMW66Xms8Re9O58qLCltxUZHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CNXQGoF/y6Y3EG4WaJnaPJahO/0BAJjYSlgzwinpMzjSg8cH39W+DlPSxk9Mprv1t
	 aB32oWDShWjxtj3hWbQM/sq1qs7GojtP7fnKz7juR4st0+TBo9Kx3iXjVHot31raaY
	 AKDeq8QzDJ6KatlF3NgY0uuuwTg0Pw6SsMmcDC10VxamCpBCJGSoGndwT21VylGav5
	 a8ypqKXxBSt3jYjoaA3d9M0IGn9+jRcqFfKxw5zKiK7YYgDW5djdNV6UkDd97ieyWg
	 QCcrUk81IDp/jyQEwkGoMQMu6WRAxKsuOv145rfKYaVbORQ0TOG1PnjzTdYYuRHgPS
	 Zmz7ZBSSBg+Hw==
Date: Thu, 30 Oct 2025 12:32:03 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH] NFSD: Add a "file_sync" export option
Message-ID: <aQOTA76KRGMyVR75@kernel.org>
References: <20251030125638.128306-1-cel@kernel.org>
 <aQN0Er33HIVmhBWh@infradead.org>
 <aQOFLMJzUZuwj_K7@kernel.org>
 <d046ee5e-4944-43aa-b859-21d85eb55dd6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d046ee5e-4944-43aa-b859-21d85eb55dd6@kernel.org>

On Thu, Oct 30, 2025 at 11:47:15AM -0400, Chuck Lever wrote:
> On 10/30/25 11:33 AM, Mike Snitzer wrote:
> >>> This patch is a year old, so won't apply to current kernels. But
> >>> the idea is similar to Mike's suggestion that NFSD_IO_DIRECT
> >>> should promote all NFS WRITEs to durable writes, but is much
> >>> simpler in execution. Any interest in revisiting this approach?
> >> This is a much better approach than overloading direct I/O with
> >> these semantics.  I'd still love to see actual use cases for which
> >> we see benefits before merging it.
> 
> And the reason it hasn't been merged yet is because I couldn't find any
> such workloads. Even tmpfs was a little slower without the COMMITs,
> to my surprise.
> 
> 
> > Yes.  Also thinking that a "data_sync" export option would be
> > appropriate too (that way to have the ability to try all stable_how
> > variants).  Chuck?  If something like that sounds OK in theory I can
> > rebase your patch (still attributed to you) and then create a separate
> > to add "data_sync" and then work to get the permutations tested.
> 
> If you want to experiment, feel free.
> 
> As always, I'm not enthusiastic about exposing a bunch of tuning knobs
> like this without a clear understanding of how it benefits users and
> what documentation might look like explaining how to use it. So for the
> moment, this patch is, as labeled in the Subject: field, an RFC, and not
> a firm/official proposal for an API change. (Note that IIRC, adding the
> new export option was an idea we had /before/ we had
> /sys/kernel/debug/nfsd available to us).
> 
> Or to put it differently, just because I proposed this patch does not
> mean it's automatically "Chuck approved". I'm interested in experimental
> results first. I'm thinking you have access to big iron on which to try
> it.
> 
> But, in the bigger picture, I think comparison between this approach
> and NFSD_IO_DIRECT might be illustrative.

Sure, I'm very interested in the data myself.  A patch to easily
enable control is all I'm after. So given what you said above, I'll
actually just run with introducing 2 new variants of NFSD_IO_DIRECT
for now, so like I mentioned in my previous reply to hch:

NFSD_IO_DIRECT_DATA_SYNC
NFSD_IO_DIRECT_FILE_SYNC

Because it sounds like it is only in the context of NFSD_IO_DIRECT
where there is any doubt about whether using NFS_FILE_SYNC helpful.
So it bounds the supportability exposure, and makes it clear these
knobs are for experimental purposes relative to NFS_IO mode controls.

