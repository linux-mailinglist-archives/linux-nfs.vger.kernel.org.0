Return-Path: <linux-nfs+bounces-7858-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ADD9C418E
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 16:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B797E28104E
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 15:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0321745016;
	Mon, 11 Nov 2024 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYH7JGdf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B2438F83
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337751; cv=none; b=cnmbdOpwnik87DCwd6Dd+t4nRSBSV5yaD17jMeyR7iOxi8MZZnW3DJyC7ECWSuq+JjVoNiHo3Mfqj9PIUZwwUqMfBkrr1agw9OI403jt038E7KYJqeGWMuHuMhX8A2p0sZhmv2DSufBcIwAt8MRH8qKobgKYF+hL6nb6AyqYrcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337751; c=relaxed/simple;
	bh=L3ftoP5cMg3Uh0SNwfh86vUVgtHWT3e/vmuXbl0tmhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEZkLeVoN4LlZGL5p5dSWO39/dgf6lZFA1VSdyfHg2vqKz6NkuDVrauJ92E3HOWK2axHah5X2Vcvy8F3ibE/uqPl3igT6BkEI3rPIfqxyPtvA2ZPd3+nhCxavAhNrtxM1yI3mGEDTJpDcFBQNoDt+TZ3vshuDZfBG/1PA09XIvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYH7JGdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C73C4CECF;
	Mon, 11 Nov 2024 15:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731337751;
	bh=L3ftoP5cMg3Uh0SNwfh86vUVgtHWT3e/vmuXbl0tmhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYH7JGdf7+WBHQVh3tQtPHq0oTOiApytNfZhYJYW1ojLooEave6HpI0XJQaRzzCBO
	 IznpE6fwp1QO7fKEfUWJxyTP+QsPaVJv1UVh7EKPnlmsAYEVMBI8PuU/uKEHJdMX4r
	 OFQyGgsn6LABSw48A/lXFlR6pEMWwhpBgIsy/CMWir21skF5bp34Rj6hSYA2cjnoUW
	 KWGgGHXQikWY579RLl3Y5Haa8Zl2QpxrclEmZ6OGDqRRwAxgylcX542KWv66dhxRku
	 nuEtr6tRRNRNDLsfO6/1eqsShQeYV9LSaUh1vJTtfs5inlVlagMfl/JgKG9WoMnWyk
	 dkdawjDMRzaZw==
Date: Mon, 11 Nov 2024 10:09:10 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [for-6.13 PATCH 05/19] nfs/localio: remove extra indirect nfs_to
 call to check {read,write}_iter
Message-ID: <ZzIeFtt60egY1Svo@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>
 <20241108234002.16392-6-snitzer@kernel.org>
 <173128801252.1734440.2215679616952985988@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173128801252.1734440.2215679616952985988@noble.neil.brown.name>

On Mon, Nov 11, 2024 at 12:20:12PM +1100, NeilBrown wrote:
> On Sat, 09 Nov 2024, Mike Snitzer wrote:
> > Push the read_iter and write_iter availability checks down to
> > nfs_do_local_read and nfs_do_local_write respectively.
> > 
> > This eliminates a redundant nfs_to->nfsd_file_file() call.
> 
> Do it?

It does.. it is harder to see just from looking at the patch.

> The patch removes 2 of these calls and add 2 of these calls.  So it
> isn't clear what is being eliminated.
> 
> Maybe it is a good thing to do, but it isn't obvious to me why.

nfs_local_doio() is common to both read and write, and both
nfs_do_local_read() and nfs_do_local_write() already call
nfs_to->nfsd_file_file(). This patch simply pushes nfs_local_doio()'s
nfs_to->nfsd_file_file() call down to nfs_do_local_{read,write} (or
put differently: moves their respective calls earlier) to kill 2 birds
with 1 stone.  Hence it eliminates an extra call to
nfs_to->nfsd_file_file() in both read and write paths.

Mike

