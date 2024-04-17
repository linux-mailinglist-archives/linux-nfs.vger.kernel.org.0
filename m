Return-Path: <linux-nfs+bounces-2865-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 147FB8A7BF9
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 07:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCD31C211B3
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 05:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234B552F8C;
	Wed, 17 Apr 2024 05:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yll7CNxs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FFE2D611;
	Wed, 17 Apr 2024 05:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713333419; cv=none; b=WS5vkpe+Ba63YbtUX5T1VvGy5ri0TLGnJYKXs7O/an/VnlSzB/ciSqOKqfpgOogayacLaGX23PKBUlb15vDrt+AwxpQZS2oKEvakyIccukMNaXXNEr4uzoIKjrBQWVRp92GH7NoNzgzNZ1zvH6m7atUKg2E+RngTxVEhbSmvVnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713333419; c=relaxed/simple;
	bh=murw89NTlRUoWg+QebxkAQSyy5ztlmOXL0l7t7nQnPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDG8ZzX7e4Dvm7RprQq3OHAyIto+ZRR3PTCiGJY4snsLmUu9wMmjIH7HIvvFedElu2/WfGqhfI7Hwgm68Fudk3veDGAR5K/8dZFY/NWNLExgqXBbxuQ2EZs1IAf4tCn664V1Qr9/KJuzPx5iaesDH5pijYsB15bvBhIP+C/aTZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yll7CNxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC27DC072AA;
	Wed, 17 Apr 2024 05:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713333418;
	bh=murw89NTlRUoWg+QebxkAQSyy5ztlmOXL0l7t7nQnPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yll7CNxs4hrGQUYeqsKPdYV2j/r+nSxkJR4xqa2m1MUvbumdw33NXtxNOexwcfdos
	 yk6kgzcJa+mEMIppiLj/a/6oo92FipzcK7qyITQlmJQdIfuTYyU/PBHUqBx/CI/7Ls
	 QH25oUtxGhECsXz9ASw29xphs7NWaCxnvlt8dOFg=
Date: Wed, 17 Apr 2024 07:56:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: cel@kernel.org
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] Revert 2267b2e84593bd3d61a1188e68fba06307fa9dab
Message-ID: <2024041727-refueling-sensually-0566@gregkh>
References: <20240416203337.10248-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416203337.10248-1-cel@kernel.org>

On Tue, Apr 16, 2024 at 04:33:37PM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> ltp test fcntl17 fails on v5.15.154. This was bisected to commit
> 2267b2e84593 ("lockd: introduce safe async lock op").

Your subject line is a big odd :(

> 
> Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---

So this is only 5.15, right?

thanks,

greg k-h

