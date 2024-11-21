Return-Path: <linux-nfs+bounces-8173-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332E19D4565
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 02:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 408D3B226FA
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 01:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A706817741;
	Thu, 21 Nov 2024 01:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1GWEk3Z7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA772309AD;
	Thu, 21 Nov 2024 01:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732153700; cv=none; b=TnYrIgJaKdy1tn5yk9hdhaXcYU/PcCVQwAkqj8Biik62RNJouqXIIYEnf943cqzxoyPfTG7o+oNm2NtrUC316+6hqchkq157rDECETLSrqAJDEW+Qmloslc6JhRN3oppTE8bcgPywzVclLVZCHmF1YVjW+GF+7TecVqVYPYcJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732153700; c=relaxed/simple;
	bh=/NiGC0pM0GnbcX3aXE/03y8LXrUjsH0UVdHveZAmi+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyFwUeftxm7oL1VtSBBMgMVbWzEneUDuiIvestdaNLQAG2OPaa6UA1nXtQnZt8SM1291VNuvNUIwGK2MhOvZKx9bfIq1yKxb0KsT5+ai2hpcSshwvDWvSvgKP0/IIUdeQ8/b04Sd3ulxZbngx/6q9NKTCGcUSwn8jD8i6V0/hfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1GWEk3Z7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB64FC4CEDB;
	Thu, 21 Nov 2024 01:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732153700;
	bh=/NiGC0pM0GnbcX3aXE/03y8LXrUjsH0UVdHveZAmi+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1GWEk3Z7McrlrpARMd4aehvrMYL/JU1WMp9ZGzfIZRWcWISIeJeYKdF9ZLgoQlMWl
	 J+28v5YxFxConA/Mw888tKT0UACWwO6nDYdpbR0HclcGmB8l2LePg1S/pvuFcvu9+b
	 jf670m+5di2y91Ic6KhznwsmPPXA81VDERRFdcns=
Date: Thu, 21 Nov 2024 02:47:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Commit b1a28f2eb9ea ("NFS: nfs_async_write_reschedule_io must
 not recurse into the writeback code")
Message-ID: <2024112146-tiptoeing-available-c5fe@gregkh>
References: <d561b5f86b69970e9029697124a9581e075e2d0b.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d561b5f86b69970e9029697124a9581e075e2d0b.camel@hammerspace.com>

On Thu, Nov 21, 2024 at 12:42:02AM +0000, Trond Myklebust wrote:
> Hi,
> 
> Can we please push commit b1a28f2eb9ea ("NFS:
> nfs_async_write_reschedule_io must not recurse into the writeback
> code") into stable kernel 5.15.x?
> 
> The bug addressed by this patch is being seen to cause lockups on some
> production systems running kernels based on Linux 5.15.167.

Now queued up, thanks.

greg k-h

