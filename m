Return-Path: <linux-nfs+bounces-1513-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4AE83E8E7
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jan 2024 02:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0086283053
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jan 2024 01:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767414699;
	Sat, 27 Jan 2024 01:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ss8sHz2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA34680;
	Sat, 27 Jan 2024 01:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706318231; cv=none; b=lB2GNxsufIsnLJFJyal/N6GYv3509mUKmN4+HninLevVGWr6/p+fh6Wy/gWFNEXuSgr5DHbh6tSRr4o0thnJ6N0ft9tsmwUqhbhh+Nd0D4YBpMutcYvROElNNUVd2ns3H0GauFhjyGKQsrhSNo0XDOt7NjNM8KTW59wx5z55X1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706318231; c=relaxed/simple;
	bh=zjCnpt51WDkADcUT3k5z+BKjrsFNhHl47g4q1k+GSDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGofuLFOVbstGV+U61rdT49m+GHtEuBWtA0nTMrK4wUpEGis4WwHmvaTBtqmzA1rnHyH1gU9BiTIJt1YrKxK252kiNyWCg5X335lCDjkSKVvgKA8sNvN1eOD/ETgFxliqLuEq0lrKGAi1Zfs7PcZBxk4Vu57TavgacdRehQiXY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ss8sHz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC09CC43390;
	Sat, 27 Jan 2024 01:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706318230;
	bh=zjCnpt51WDkADcUT3k5z+BKjrsFNhHl47g4q1k+GSDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1ss8sHz2SyqJK9M3Ulue6riqVQ3+6BwX+1CGlFnKUd4Ky5UcdNBeAofB4D5iD6aZq
	 GHlMd1x0lX8VemKlRIhRiVxZN3Mx6QRxX+nZL+8de5I+nAAn5afTKGJ58V0gbOuHQi
	 NYBWhXF821a5XhoXVdD5rHeW+j5IGZUedOFZx15U=
Date: Fri, 26 Jan 2024 16:47:04 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Mahmoud Adam <mngyadam@amazon.com>
Cc: viro@zeniv.linux.org.uk, xuyang2018.jy@fujitsu.com,
	stable@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 5.4 0/2] backport add and use mode_strip_sgid in vfs_*()
 helpers
Message-ID: <2024012658-winnings-armrest-a88f@gregkh>
References: <20240124130025.2292-1-mngyadam@amazon.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124130025.2292-1-mngyadam@amazon.com>

On Wed, Jan 24, 2024 at 02:00:24PM +0100, Mahmoud Adam wrote:
> These patches are a follow up fixes for CVE-2021-4037 &
> CVE-2018-13405, LTP test creat09.c & openat04.c reproduces the
> privilege escalation in v5.4, the two patches solves this and they are
> already backported to the other stable kernels.

Now queued up, thanks.

greg k-h

