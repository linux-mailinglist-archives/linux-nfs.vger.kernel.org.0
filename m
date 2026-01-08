Return-Path: <linux-nfs+bounces-17599-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3ACD0302A
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 14:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C559530074B4
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FCE48709C;
	Thu,  8 Jan 2026 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SNjb1E8i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE83F48706B;
	Thu,  8 Jan 2026 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767870208; cv=none; b=oDuB6FX+B2YM0VB8G5hon3aPuGDXRgVx7/hrUKN0uano30tz53bukZV7/4JMc6kDq1B+UkUsXjKufWvkdojP3EBUSGSy7BsVYdPLlsCoMHKkiV16giIhCWWvOB85yLFgSWANuHTwjS6NIzl4YSBsnd/ANZiVhxJhzkCgwomPnH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767870208; c=relaxed/simple;
	bh=rqzETUbD7ysEXZoY6JGtOLcYN6py/e4yeShXFBNHpKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3VICt0aogDeT4r4umyIuiBtF1EYc8nZWwaGLbyp4YCj56wTlQ9nchrvY1UguMxQ4LhALnzJq66Agiw21to7mm7Fi9L0ul730xYA9PzZeCqF7wOnK3A/AqIyPehmDyxMTXMHJ+pXbGaINZ63fz4XyJSCXXnCTkudGOIosvXTsAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SNjb1E8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8904C116C6;
	Thu,  8 Jan 2026 11:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767870206;
	bh=rqzETUbD7ysEXZoY6JGtOLcYN6py/e4yeShXFBNHpKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNjb1E8iEzPRFTo6pXEScPFwTOD01i7m2fs106YuhUlEeULzdnAV+vVa595cE8aBs
	 2aoMTkhuIhU8sj+mBe8zXYDml9Uuti1YHIdjvQqAt2LNakxuNXE0on0IHA6B34WvkG
	 8W3Esagb+HgTYZ4ZmW+7th0HR9OJvlkNsadYO+cs=
Date: Thu, 8 Jan 2026 12:03:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chuck Lever <cel@kernel.org>
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 6.6.y 1/4] nfsd: convert to new timestamp accessors
Message-ID: <2026010808-subwoofer-diabetic-e54e@gregkh>
References: <20260103193854.2954342-1-cel@kernel.org>
 <20260103193854.2954342-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260103193854.2954342-2-cel@kernel.org>

On Sat, Jan 03, 2026 at 02:38:51PM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> [ Upstream commit 335a7be84b526861f3deb4fdd5d5c2a48cf1feef ]

I don't see this git id anywhere in Linus's tree, are you sure it is
correct?

thanks,

greg k-h

