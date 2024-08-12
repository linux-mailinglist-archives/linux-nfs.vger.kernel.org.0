Return-Path: <linux-nfs+bounces-5312-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C735B94EBDE
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 13:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD7B280C50
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 11:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58E9175D29;
	Mon, 12 Aug 2024 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RosAhIHU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C24D130495;
	Mon, 12 Aug 2024 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462448; cv=none; b=QB0WcnwVW03iuhe0zSAWIw95aDXAErD2V3xhHkW6YhWkBucKj+TuqzeMFS1b9JRpX3/Lyc52HJNluR7W63d4hiPriSg/1eGrkdRt8Vfvade3pfr2vU1qZejNFlxxH4ezJi3O3l20ep8vVEFEAAcuNpwXutzwE0rMmkaLNzo0oY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462448; c=relaxed/simple;
	bh=YzQWNzHUVtjC21KaSPNPbzz4LWAtZQNSwkGgV6/baAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7BJc75CulJow74nqnty22t6u98G6NMYur1TUYCaRemIS+Kkdh4vtCwkUOv4YV9EW370O6pOr+E+MegcYmQyhj62Km81AnjTVHdoLX6bvCx9tgZVd0zMz3/PSBP01Hp9qoqsvTD2JcQWWLWZfqnCBAiLzLU4Mh6crk5336wJ228=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RosAhIHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE775C32782;
	Mon, 12 Aug 2024 11:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723462448;
	bh=YzQWNzHUVtjC21KaSPNPbzz4LWAtZQNSwkGgV6/baAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RosAhIHUx1Pks6DTw1MepkHhqrlPL6GP8VQLHR8Jr0exiAr00Md92alPX588lSG/c
	 vKLa9Q1kaqoodWvZSnM354Wdxkj/P0rwPko27sWgExaJJWwbSsNr56ewRGS+hSMCLb
	 D5hSItTm82L/PLyTMnTdqQ4/x0dOIEABfQmnK8vJyXvUyFxy4w2qwEhCF4Th8i2A/t
	 gIJab1CvS0RQ2z2Zi+1//ieU6SLXYeUsJ2Yu8bZo+EgT4XIFFVA+UNx07WVYJfQrga
	 LtJtdpfn4CrHyTA7DXib9+q73GjItKmDyYDhn885qzT4bzDNn9O9hq7DNR8fHtZ9UK
	 t/2elZRb6qaGA==
Date: Mon, 12 Aug 2024 07:34:06 -0400
From: Sasha Levin <sashal@kernel.org>
To: cel@kernel.org
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org, pvorel@suse.cz,
	sherry.yang@oracle.com, calum.mackay@oracle.com, kernel-team@fb.com,
	ltp@lists.linux.it, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 6.1.y 00/18] Backport "make svc_stat per-net instead of
 global"
Message-ID: <ZrnzLoZ8Tj9GhRSO@sashalap>
References: <20240810200009.9882-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240810200009.9882-1-cel@kernel.org>

On Sat, Aug 10, 2024 at 03:59:51PM -0400, cel@kernel.org wrote:
>From: Chuck Lever <chuck.lever@oracle.com>
>
>Following up on
>
>https://lore.kernel.org/linux-nfs/d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com/
>
>Here is a backport series targeting origin/linux-6.1.y that closes
>the information leak described in the above thread.
>
>I started with v6.1.y because that is the most recent LTS kernel
>and thus the closest to upstream. I plan to look at 5.15 and 5.10
>LTS too if this series is applied to v6.1.y.

6.6 would be the most recent LTS, and we would need to have this series
on top of 6.6 first before we can backport it to older trees :)

-- 
Thanks,
Sasha

