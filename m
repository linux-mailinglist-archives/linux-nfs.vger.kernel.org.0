Return-Path: <linux-nfs+bounces-2031-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A2085BF39
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 15:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710A21F23118
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 14:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB87271B55;
	Tue, 20 Feb 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zvQm0T0J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B471B3F;
	Tue, 20 Feb 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441066; cv=none; b=dPm0QnXwsE1Zw76xZc66ru8mI2Wo9dtW9zngRlIKCPa5DKf4opKYQNLFmQ60IVLyJx9iuAow433LHoRe4VE0JGZxV8g37pAmuGHxi2aAJynSmKUeDGc9fCwblYH90eKHcamZ15H2RsvKuVHk6eb5h+UTAhz39A5NMxC4G49ws1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441066; c=relaxed/simple;
	bh=bDE/5GUQAKkM+KJKawR3GrKSi0WUOOgAzwIOXZgidak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxMd3FwzQuzO2soufvvQt49CD+d8XfvkMj265sYU1tTzbgL6y/nhnxrw49sHp8YQGVK6mr8lAraiUpnrNwMCLHHEImhG6nQjpozh5sLxDctu0TM7O3bf3N/5JA13E1IQGHGYbKg4h4++PYa5DsSuhpR04aZluE8urI2x+J1ZqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zvQm0T0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9181C433F1;
	Tue, 20 Feb 2024 14:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708441066;
	bh=bDE/5GUQAKkM+KJKawR3GrKSi0WUOOgAzwIOXZgidak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zvQm0T0JmVblfIBEC3t7iBo/LsMI0MaB1MzeK6fSZFdRNYsgJNmx7gGR0cUGU34FG
	 VmTGmr+LPdOTJ8u0EVUiGBFS8f/rBYgLWjfqFjcxT52qwKPUuvq9VDY/4vqwv4Fqax
	 8cIS5MjiDP1VSt3/APtmXMOijCV4VC6FvPf/Gn7Q=
Date: Tue, 20 Feb 2024 15:57:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@redhat.com>
Subject: Re: [GIT PULL] NFSD fixes for v6.1.y
Message-ID: <2024022007-atypical-postnasal-37d3@gregkh>
References: <ZdS8TXWl3QKf0qdk@manet.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdS8TXWl3QKf0qdk@manet.1015granger.net>

On Tue, Feb 20, 2024 at 09:50:53AM -0500, Chuck Lever wrote:
> The following changes since commit 8b4118fabd6eb75fed19483b04dab3a036886489:
> 
>   Linux 6.1.78 (2024-02-16 19:06:32 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git nfsd-6.1.y
> 
> for you to fetch changes up to d432d1006b60bd6b5c38974727bdce78f449eeea:
> 
>   nfsd: don't take fi_lock in nfsd_break_deleg_cb() (2024-02-16 13:58:29 -0500)
> 
> ----------------------------------------------------------------
> NeilBrown (2):
>       nfsd: fix RELEASE_LOCKOWNER
>       nfsd: don't take fi_lock in nfsd_break_deleg_cb()

A pull request for just 2 patches?  Ok, I'll go dig them out of here,
but next time, a mbox or just sending them as patches works too, no need
to go through the trouble of this.

thanks,

greg k-h

