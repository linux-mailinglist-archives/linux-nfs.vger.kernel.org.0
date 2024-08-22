Return-Path: <linux-nfs+bounces-5562-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C7995A89A
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 02:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4571F22652
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 00:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB35628EF;
	Thu, 22 Aug 2024 00:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TG6SlU4w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17123CB;
	Thu, 22 Aug 2024 00:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724285607; cv=none; b=lPnxMG6bf9UmRL3+vtybRb8gWvtCtN8/MJZMvdOathBRSbEnpImCPqgz9d0d0rhu9y0AD5l5emavlp6MwHUwjV4KzFW6UW4pmarxZmXG0K0TXujcTU+4ly+WW6LmbV1I+ZmBN55+4fpvZSUaah2CJ9wmYFhNXVkOCf1aau76cZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724285607; c=relaxed/simple;
	bh=s2mwO1OdtOj7IDXje9pSoeacZVHMD+zAoMZEH7vy/sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMSJtHINyDPubOJIYWQ53xRE8YLeFWN8+CR+H2c3HDQJ+0wwmEidRya5ml7cCgNqJK6HIFF//pWYKdhMHlbu7UB7Qa5PUDuHNJoTbAr8zwVkhPpzqVnqiLNrQl1yHf97ZbeG7V+rUb7p/Yporcn8qCD1WwgSuDiqabDo+5pjK6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TG6SlU4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4305AC32781;
	Thu, 22 Aug 2024 00:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724285607;
	bh=s2mwO1OdtOj7IDXje9pSoeacZVHMD+zAoMZEH7vy/sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TG6SlU4wrjB36Z5IoVn4tvk87MuttHjHhLaSEVUpj6HT9GZpWQsFpN+w6wNrhmD+X
	 giHlieSWflnkJsJEBx3qmGhd7nr7TeihrVNKfqwq19+BRdNuYWcgF86xMMrqejW188
	 Svqaio4/M/bI9lyJUofS/DHXKAYGpBcJ5G0cl5jo=
Date: Thu, 22 Aug 2024 08:11:16 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: cel@kernel.org
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org, pvorel@suse.cz,
	sherry.yang@oracle.com, calum.mackay@oracle.com, kernel-team@fb.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 5.15.y 00/18] Backport "make svc_stat per-net instead of
 global"
Message-ID: <2024082208-precinct-dander-ea81@gregkh>
References: <20240821145548.25700-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821145548.25700-1-cel@kernel.org>

On Wed, Aug 21, 2024 at 10:55:30AM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Following up on
> 
> https://lore.kernel.org/linux-nfs/d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com/
> 
> Here is a backport series targeting origin/linux-5.15.y that closes
> the information leak described in the above thread.

All now queued up, thanks!

greg k-h

