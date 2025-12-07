Return-Path: <linux-nfs+bounces-16980-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C92CAAFDD
	for <lists+linux-nfs@lfdr.de>; Sun, 07 Dec 2025 01:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B82A73006997
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Dec 2025 00:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316DC207DF7;
	Sun,  7 Dec 2025 00:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FNL9dHU7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17B71F4C96;
	Sun,  7 Dec 2025 00:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765068160; cv=none; b=nyCI0OpRE77FP2ZIcKVOsLYio2Ri3SBjpJX+xNuSjjyEU39jxsVvwzhg+Yhip78bkrsbiT/WgchTh0xtG4m31UgLQUBuAZby3zHqSrfdv2ky6LOW4lspQC1putSU7XeYH1qQvBXY/XKhE34gtCPD6nwr3r35gZVr9VnDDgUEi88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765068160; c=relaxed/simple;
	bh=zokG3fNMW9+yM6XpKQJUKRogjW0knJVaGlMLalJclyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXAuGTG/E9+yoIuq7XPocjfCNHaZ7iSPgVwHi7aAptexk40Ujprm3xsSAKAksYvRgd6ZQ3B/WlC/AZbVfHQ2EX/oj1YjKQ5rSIPF1eMe8fMSfZhbsw2E9TqUymbUrhgs631jN9KrdcFzUMbllNf8f/Atpwh3zJOWAdRmg5EY0YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FNL9dHU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A3CC4CEF5;
	Sun,  7 Dec 2025 00:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765068159;
	bh=zokG3fNMW9+yM6XpKQJUKRogjW0knJVaGlMLalJclyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FNL9dHU7cut4vM0XomRyBY7qumyuTbUwYdD5rZVfhE/UZd4GfG/QamruwAtGTF7tS
	 UU0wTiS7btbdBwqSWZ+5cyn1Fr4lynMlYelHVPxn77qx+6X//9mAH0NyE9ghPiu6ng
	 okpopCPf3sasG/PPdQzjJfW+b0yNlvQs5tVUEEms=
Date: Sun, 7 Dec 2025 09:42:37 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: stable@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	Zorro Lang <zlang@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfs/localio: fix regression due to out-of-order
 __put_cred
Message-ID: <2025120753-cycling-shifty-4967@gregkh>
References: <30a4385509b4daa55512058c02685314adda85d7.1765066510.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a4385509b4daa55512058c02685314adda85d7.1765066510.git.trond.myklebust@hammerspace.com>

On Sat, Dec 06, 2025 at 07:24:14PM -0500, Trond Myklebust wrote:
> From: Mike Snitzer <snitzer@kernel.org>
> 
> commit 3af870aedbff10bfed220e280b57a405e972229f upstream.
> 
> Commit f2060bdc21d7 ("nfs/localio: add refcounting for each iocb IO
> associated with NFS pgio header") inadvertantly reintroduced the same
> potential for __put_cred() triggering BUG_ON(cred == current->cred)
> that commit 992203a1fba5 ("nfs/localio: restore creds before releasing
> pageio data") fixed.
> 
> Fix this by saving and restoring the cred around each {read,write}_iter
> call within the respective for loop of nfs_local_call_{read,write}.
> 
> Reported-by: Zorro Lang <zlang@redhat.com>
> Fixes: f2060bdc21d7 ("nfs/localio: add refcounting for each iocb IO associated with NFS pgio header")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---

What kernel is this for, just 6.18.y?  And why was the changelog
rewritten/formatted from the original?

thanks,

greg k-h

