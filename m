Return-Path: <linux-nfs+bounces-9491-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51370A199F8
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 21:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9803D166203
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 20:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74A514A09E;
	Wed, 22 Jan 2025 20:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQnWYAQA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30EC42065
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 20:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737578720; cv=none; b=hBZi+e7hM8we9tExffT/DNYIAOyGTthtBqXB5v2mLjNC1FY+CcodYXENrb+XCKRGxZdY+3DrFAhDWacLIl8294IDBbOOXMsT+vFDMUIoQDdg1jm9lF/Zqx4RUgana3pwKWEIft9iPA2VIdVgfISXjvMHeMPGlw7MFynRuEppVS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737578720; c=relaxed/simple;
	bh=J/HPjivvts52OiQqjRHHTMdSq1kYkX6aHziYtdwnK0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsyhEY4WeD6yx+Pu4abWzZeO2eS0QlZUF8lYXHieIqMPzrYE4cyNutaCDtB2rRZ9JP3ZKVpFakpKr7WMCbni47g2nE1EbyDTPpSaUUskYxuAmGZguN1ugMEKDl7NdDkmU8jraYuJxTM6wAmbbYbTPCrq6tbU1ER8XgK+ykBqJKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQnWYAQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3058AC4CED2;
	Wed, 22 Jan 2025 20:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737578720;
	bh=J/HPjivvts52OiQqjRHHTMdSq1kYkX6aHziYtdwnK0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BQnWYAQAxgHsBR/B5YdQ1Yxgt75N60USQti6MUDd5Q1iNXhxfTBrQ34aF0a9I2y8h
	 ysvZcXQ/f4Xa4d2OEJQuejc4eaB7/2cRZgKEdwWRAcqn4nEbzvu34XSuKxBCW7/UCU
	 o+mLJdaDCSMZOKGoKhfh38CPbfYotbvg0PGIYR9Sgv+vQ4BpP/UypB/o2lr6GQ6DQZ
	 Jmos9AuOLlfG5V8aghIkDGtpykfGxEioj/CwR+TxqoS4aMQRtsoYGUt6oO110cgmIh
	 h2t5sSSfGNZO3+LKbbYw4dpxygCnqkQRwfNZuLnFlvxJc4tX8b9TUbudMroyD1wv3f
	 m20N0K2nm+oQg==
Date: Wed, 22 Jan 2025 15:45:19 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 04/11] nfs: combine NFS_LAYOUT_RETURN and
 NFS_LAYOUT_RETURN_LOCK
Message-ID: <Z5FY36JV1n9qgGMP@kernel.org>
References: <20241206021830.3526922-1-neilb@suse.de>
 <20241206021830.3526922-5-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206021830.3526922-5-neilb@suse.de>

On Fri, Dec 06, 2024 at 01:15:30PM +1100, NeilBrown wrote:
> The flags NFS_LAYOUT_RETURN and NFS_LAYOUT_RETURN_LOCK are effectively
> identical.
> The only time either are cleared is in pnfs_clear_layoutreturn_waitbit(),
> and there both are cleared.
> The only time NFS_LAYOUT_RETURN is set is in pnfs_prepare_layoutreturn()
> immediately after NFS_LAYOUT_RETURN_LOCK was set.
> The only other time that NFS_LAYOUT_RETURN_LOCK is set is in
> pnfs_mark_layout_stateid_invalid() if NFS_LAYOUT_RETURN was set but
> NFS_LAYOUT_RETURN_LOCK was not set - but that is an impossible
> combination given that else where the flags are set or cleared together.
> 
> So we only need one of these flags.  This patch discards
> NFS_LAYOUT_RETURN_LOCK and does the test_and_set needed for exclusion with
> NFS_LAYOUT_RETURN.
> 
> Also the wake_up_bit in pnfs_clear_layoutreturn_waitbit() is changed to
> clear_and_wake_up_bit() which includes all needed barriers internally.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

I appreciate that you've done a general audit of the NFS code and
looked to improve / optimize the wake_up_bit() callers, etc.  But how
did you test this specific patch's changes to the pnfs code?

Reason I ask is if you look at the commit that introduced
NFS_LAYOUT_RETURN_LOCK way back when:
6604b203fb63 pNFS: On error, do not send LAYOUTGET until the LAYOUTRETURN has completed

You'll see that, with your patch, you've seem to have now reverted the
code back to before stable@ commit 6604b203fb63 was applied.

Now there may be merit to doing that due to other changes in the pnfs
code that didn't exist back then but... your changes look suspicious
given the evolution of this code.

Mike

