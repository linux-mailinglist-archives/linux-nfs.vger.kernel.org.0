Return-Path: <linux-nfs+bounces-2878-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 377138A8476
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 15:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6838F1C219F1
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A26A13FD9A;
	Wed, 17 Apr 2024 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0kNLeAxX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7C213F00A;
	Wed, 17 Apr 2024 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360313; cv=none; b=UG52xev0sPBcAC08aP7ZKlN3tsqs/RfP/dB55A+owgxwyvKjLiTH64hT469q/kFYyF84x+T9PKQSivEvsfrcNfX5ekISnwLoGvIlge2eruRE4CInM6MCn7UQ0jSK+u7a/UJojIqvcyfLjVl2fdGW8K0zAAl4X80zz6SmwHnEfpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360313; c=relaxed/simple;
	bh=8bqkE0g7ZjbpUsQZ9D9S1dwIKAFyl5WZ/m4Ic5pqksk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZDvDykPELMuf8wXrc5GzHh1aqmbJ2cKkY3ridwny/wA6SFM/LYkcShQ1P39w+dYdGqqaYRtmp8qrKP1LFRPSdrybZ8C6iPkyetE7xmRNfiX8MdpE3SGX7i9y8zAyI86vavXz9EX4opsor/7EqJ5p74d9MxFORFJoMJ5RQMMAVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0kNLeAxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0041BC4AF07;
	Wed, 17 Apr 2024 13:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713360312;
	bh=8bqkE0g7ZjbpUsQZ9D9S1dwIKAFyl5WZ/m4Ic5pqksk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0kNLeAxX0Q0O1h4Wq+jxWE/nEdKuB32pGl+uIKjBYEXwtliTuAec8ZmTfdeaFQdBt
	 SIhznfwZPELTOwtgH/mbyDYX00oCClBwRDEYh8WumKkLljgDF1KrBF9tgr2Kh/dE8l
	 mwn9+zWKbRh/DK83juikJYqIU95gEfpKYezm2Z9k=
Date: Wed, 17 Apr 2024 15:25:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: cel@kernel.org, stable@vger.kernel.org, linux-nfs@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] Revert 2267b2e84593bd3d61a1188e68fba06307fa9dab
Message-ID: <2024041745-stagnate-bloating-87e0@gregkh>
References: <20240416203337.10248-1-cel@kernel.org>
 <2024041727-refueling-sensually-0566@gregkh>
 <Zh/LyjplA5coHKqJ@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh/LyjplA5coHKqJ@tissot.1015granger.net>

On Wed, Apr 17, 2024 at 09:16:58AM -0400, Chuck Lever wrote:
> On Wed, Apr 17, 2024 at 07:56:53AM +0200, Greg KH wrote:
> > On Tue, Apr 16, 2024 at 04:33:37PM -0400, cel@kernel.org wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > > 
> > > ltp test fcntl17 fails on v5.15.154. This was bisected to commit
> > > 2267b2e84593 ("lockd: introduce safe async lock op").
> > 
> > Your subject line is a big odd :(
> 
> I used the style we normally use for revert patches for Linus'
> kernel. Let me know what needs to be improved.

That's not normal, this is what that would normally look like:
~/linux/stable/scratch (s-515) $ git revert 2267b2e84593bd3d61a1188e68fba06307fa9dab
Auto-merging fs/nfsd/nfs4state.c
[s-515 5bd6c14e1a72] Revert "lockd: introduce safe async lock op"
 4 files changed, 6 insertions(+), 29 deletions(-)

Subject lines don't have a huge hash in it.

Anyway, I can fix this up, no worries, but I don't know how you created
this to get that subject line.

thanks,

greg k-h

