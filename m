Return-Path: <linux-nfs+bounces-8446-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F47D9E8E4F
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 10:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1D61619B9
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 09:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6379215F4F;
	Mon,  9 Dec 2024 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R+uLKNq/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A83721571D;
	Mon,  9 Dec 2024 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734805; cv=none; b=YaAZ0//fPugYBIszJM8JOdzJo2ucDgxKbZLZJwbQdd+QSsymTjUlxz3Yl6bJo50wl+Z3ey5cmTXeRwFiEykSJFC0zIoWdfCjemSY7PdWsjFjIAKH6/xG0ZPSXrduj5ShNXFO9Ua2LUP8cDnDzHTHV0Zgn8d4FYIWHuB/5+lJb7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734805; c=relaxed/simple;
	bh=E6ZtWVDhitPPAQ9jqunFiB45JPxi93MR1uzqM7bmqO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSLs9Apqv6dhMGZXNyIOJTRVLXo2VJqOrTLaWzie5QNNJVb5HEEXTXE/yy58tuEK97al/dFRlQEMN/WYWYGM/VkZp2AmL4jo4bky5ystqIUk+z3DqHyY9Udezyvu1meRB8WtTpInohznpJR5pLoK2qwnFg8Hka9J+6kqv3p3kEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R+uLKNq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7413CC4CED1;
	Mon,  9 Dec 2024 09:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733734805;
	bh=E6ZtWVDhitPPAQ9jqunFiB45JPxi93MR1uzqM7bmqO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+uLKNq//NiEv+CfRwJTGYnbJgVqoXX9ysz31pYIpMLZeh66Cg6vVY0EIwLKOpx2j
	 bA19JecjrbvdqxM6CNudUlTXW1mHWs3D4Y3uClBipdpfWRVG7Nzkg/EVdcRFejYZJD
	 zKqofcoGzOBzgajVRDC2rlXiOT+7A+8QTkP1FK2M=
Date: Mon, 9 Dec 2024 10:00:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: chenxiaosong@chenxiaosong.com
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, huhai@kylinos.cn,
	chenxiaosong@kylinos.cn
Subject: Re: [PATCH 4.19] NFS: fix null-ptr-deref in nfs_inode_add_request()
Message-ID: <2024120919-reporter-spiny-b67d@gregkh>
References: <20241209085410.601489-1-chenxiaosong@chenxiaosong.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209085410.601489-1-chenxiaosong@chenxiaosong.com>

On Mon, Dec 09, 2024 at 08:54:10AM +0000, chenxiaosong@chenxiaosong.com wrote:
> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
> 
> There is panic as follows:

4.19.y is now end-of-life, so there is nothing we can do with this,
sorry.

Also, we don't apply patches that are not already accepted in Linus's
tree.  If this is still an issue there, please submit it properly for
that tree first.

thanks,

greg k-h

