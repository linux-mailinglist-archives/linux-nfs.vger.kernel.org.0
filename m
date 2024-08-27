Return-Path: <linux-nfs+bounces-5802-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2042F960AE4
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 14:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB301F23DA7
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7D41BD020;
	Tue, 27 Aug 2024 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MfaTv4/3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EA51BC090;
	Tue, 27 Aug 2024 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762847; cv=none; b=n6ulEHiiI1ymMsmqzOmnrlkXmd4cn/X3aFA7F5d3WeJDhCgkrrUPLlJClQue4bcRMLW23Abrr5Vu90BO5xzbTkUgYLefzx+lsGhCA69WOM0sDLzfc9Hm0x9mpt7RXTKWJ21RAkbIH5DgsRaIMnLg6+IMgmn7FMyd/SPN188CHpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762847; c=relaxed/simple;
	bh=8HVc4ERPRmWDR0Sw9NQwrTA1wuIyeAHMUzUV4DjZ9+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1wBefb4rgaOZRay2y2xDTe6A3rgAdou7V0h1mmkVobRRfLYFFtDb6dwToR/hORE9tesktmV7GnwhoD3AarhDdtoLaszvT2yY0OzVhuKiTjXZ8T1HCoc/POCAZlj4aDViSgxHswMVws8+47gJj1ZwU+Tr6AoV2991fWcsK8i+Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MfaTv4/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD0EC61041;
	Tue, 27 Aug 2024 12:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724762847;
	bh=8HVc4ERPRmWDR0Sw9NQwrTA1wuIyeAHMUzUV4DjZ9+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MfaTv4/3myQh3ZVySu6b4QeO9es9JL2psb1FRvwMmBlX0njJk+BlyCUK7Uci5rrA8
	 FbooEwK5SpYkJf1iMNS6sTGj72J9ywae6K+WfPIYDkPk6UUUVKpvZWJHQh9hIGrVN4
	 BGCyb4OC17O8dh+195aWnIKK8LVfpbrVzWCCxCek=
Date: Tue, 27 Aug 2024 14:47:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: cel@kernel.org
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org,
	lilingfeng3@huawei.com, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 6.1.y 0/7] NFSD updates for LTS 6.1.y
Message-ID: <2024082716-maternity-blabber-56d8@gregkh>
References: <20240826150703.13987-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826150703.13987-1-cel@kernel.org>

On Mon, Aug 26, 2024 at 11:06:56AM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Address an NFSD crasher that was noted here:
> 
> https://lore.kernel.org/linux-nfs/65ee9c0d-e89e-b3e5-f542-103a0ee4745c@huaweicloud.com/
> 
> To apply the fix cleanly, backport a few NFSD patches into v6.1.y
> that have been in the other LTS kernels for a while.

Now queued up, thanks.

greg k-h

