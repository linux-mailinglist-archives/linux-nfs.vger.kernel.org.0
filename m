Return-Path: <linux-nfs+bounces-15967-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C161C2E208
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 22:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9283B394E
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 21:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BE92C327C;
	Mon,  3 Nov 2025 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAjMynA8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D76F2C3262
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204630; cv=none; b=WyrVPuVudSKkiNCZHd97GbtjfHTG6DnjP5wOICNBJjZAn77AHlqrYsTCajFi/1gIVhNxrcKrDvvENuTHAGTQchbGK0Y1VwwgRUivChIp7fIAcdrAdAbssnKc+CFY8HTjF6yzWHc/Gq/4W+wdGGBwHLl06sh+HPXlESujRz1HjdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204630; c=relaxed/simple;
	bh=loE7vYjEQwD6sZn8EycJSKMQXYwxZKdCEulcZx67BYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILUhftM4xLgtg5IWM1aGbn2j1jRRk5v1Jk8iG52r40LlBUMLvVm62bbvVEVpKrtvnTsMPh2CYODopoPZeiz902WzdWJ9bYEUHYubrvt5cuwS2VNpW73XUYYiKwtDXiGgDs+/7gY71usREpEoBewe7goiO0GNxMUZxn3ITzoxCCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAjMynA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08E2C4CEE7;
	Mon,  3 Nov 2025 21:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762204629;
	bh=loE7vYjEQwD6sZn8EycJSKMQXYwxZKdCEulcZx67BYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jAjMynA8iLW1+M/SUGsUM0bWZEmjpQ18NnexP1yYrZFZJK5KfQFmrP5gXn/F3Qdat
	 StI/LGY6d8BlN43030VY+oFi1P+LXhR43J7ihvVJNyIj8uganUceQ6rNMxZQmWeAM1
	 xEjkfHje8vZibDjppwt5AMto2iEHIPMdStLfRkNQp6hIhw7xFO1GlKdmKCzpr0yApr
	 26xThSOS1/9gGQj9i6YYpI93nYLehkiUM8S9LylEfyRg/jDoyhqRgiMrBQaLy3uXcD
	 AqrnYL7SVH8hGGoGl2z2hRLJA3Vy7ojRLUC1o/uQZbthqvk2IcODd5M8DQNZczrE22
	 aDtkPbDCOsznw==
Date: Mon, 3 Nov 2025 16:17:08 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v9 04/12] NFSD: Remove specific error handling
Message-ID: <aQkb1P0PNgwqIWIU@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>
 <20251103165351.10261-5-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103165351.10261-5-cel@kernel.org>

On Mon, Nov 03, 2025 at 11:53:43AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> 1. Christoph notes that ENOTBLK is not supposed to leak out of file
>    systems, so it's unlikely or impossible to see that error code
>    here.
> 
> 2. There are several ways to get EINVAL on a write. The least likely
>    of those is a dio alignment problem. The warning here would be
>    misleading in those more common cases.
> 
> It's unlikely that an administrator can do anything about either
> of these cases, should they appear on a production system.
> 
> The trace_nfsd_write_done event will record these errnos when they
> occur.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

