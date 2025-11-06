Return-Path: <linux-nfs+bounces-16137-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E486CC3C839
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 17:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B3485029A3
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C233491DE;
	Thu,  6 Nov 2025 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rM75byoG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837CD2253EC
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446628; cv=none; b=srC3iB8GaMVf5xbz3fCUMyRe3FcbTBBsHHWmtWVpBVb5UfGJn88tnq1QQMbP3pV/MN7FPB9JTgkzINWQrcNdtgpw9PV5MlLYmx82robrpcbAM7C5W0GGRJ3JngW4JemqZGugx/5hG1PnpyIPO1oPQymuSIBQfg+kGQCTntDlPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446628; c=relaxed/simple;
	bh=xVfPQ4RI3zVVsRrmGXA+bvyAwdktjvLB+m4+ZLkfCPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXBb3jjXzZkQHWnEqiSIpwj+Ns+gI49/GkwqRX30YhAo89N9FkzLl8m1GXS42YB3SH5hWpyBjGpJ20WoMOGSFmO2Ra11jrbfJsTJohSPmf3Yz99mul2c+ianju6p320zrzJRZX5bCBwCVCgueg2ejdsUTm0LbvuCP5WLCdefyxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rM75byoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423DBC4CEF7;
	Thu,  6 Nov 2025 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762446628;
	bh=xVfPQ4RI3zVVsRrmGXA+bvyAwdktjvLB+m4+ZLkfCPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rM75byoGxZUyesmlgqhMTghixF8DFgvotNEMCuh+pECDm48AFhkMGc/ldQA89x7Ua
	 +gP3cOAT321xVeZBnlj0dB0l1QD8oX+W0CpVe0PSqck1cET0JChStAw94nUdXBRk7n
	 mMjuj0JRhkASjAEafTi0yET+Icmcr4MYxB7+L41icq1lwZ9Z6VF7OQeMZZ8O/1EOdl
	 BpZb5UW7NmXX0JMJK4qKHjvHUj/+JZmQu+l729710d85FvhKxbB8K7n5vkvgwblJGy
	 X3jdBR8kfBAwgAFO7kTANfR+q4IkvPqhLva9HuYPTMD0agWe/q+cg5qCKHqDI69yIJ
	 sD4ti27rMuKXQ==
Message-ID: <95a20f81-b648-4adb-b791-46899652d521@kernel.org>
Date: Thu, 6 Nov 2025 11:30:26 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/5] NFSD: Enable return of an updated stable_how to
 NFS clients
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20251105192806.77093-1-cel@kernel.org>
 <20251105192806.77093-4-cel@kernel.org> <aQyde06-9qKs6o9O@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aQyde06-9qKs6o9O@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 8:07 AM, Christoph Hellwig wrote:
> I don't think we need this any more with the current version, or am I
> missing something?
> 

Correct, the updated version of 4/5 does not need this change.

I left it in because I agree with Neil's observation that it's a good
change to have anyway. However, the usual practice is to omit changes
that are not directly related to a series, so I will drop this one for
the next revision.

Let's keep a pin in it, though. It might be needed in the future.


-- 
Chuck Lever

