Return-Path: <linux-nfs+bounces-6984-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A36997503
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 20:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56E20B22985
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 18:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF741E1044;
	Wed,  9 Oct 2024 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieHcrS7x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94941E103A;
	Wed,  9 Oct 2024 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499224; cv=none; b=MpyGaMG04C9YKAou2YwiHWsS4KennRAM12qFh+1KKTUksgvMDOdKwLL+uKVN8YC8NrUkc662doozWGUN0gQS+loHhaxLUF1HR0cuGLZECE++qgZBLRCPccPsbiu80swHR5fAClyDjD5/Q76azMn2KYeJBumXNRoy/JxSlsWFTFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499224; c=relaxed/simple;
	bh=z42z8W9U2YPx+YS8zEcj9apDQw0Bbu0JeksNvPD0c94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7ZeU0Pg2YPCC9qVwWZO3NtmqN12BepXH2CGJua/eRuU2rlvi3ibyG1v5h8EA2VqSFUVL5IowQoUxfuXE6natguybbotBUl3ujuSuIHwGIK1jqFPd3jMiLZW5c8G/HWAFQmV+DOnz34oMXr5zUphTP5XB8F3Fw7YxQ3c61j9jbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieHcrS7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5674C4CEC3;
	Wed,  9 Oct 2024 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728499223;
	bh=z42z8W9U2YPx+YS8zEcj9apDQw0Bbu0JeksNvPD0c94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ieHcrS7xQP7fwR6z4KI1cDFB8TLmJZZy4bTyNtwprvsa8KkLUnuAyMheQIx/gXDki
	 OOLjNH7IH7+0FSyF+nwh4KxmZWhgSfOix+lWRKM6cyYzoz2XWnd8jF4P4i/tyWHnh/
	 UCKqLUxFoLDDAmoekGZZ/61jw+ZCIFzH4/eDiLDhPou3cdCLXucuwMDmERYd8QNd+v
	 vfcy8GhIynZWizImTNtUVair7Xh5rigVYBp6b0P0/zJYLUPLFtZBlKnV6/wIQ7xn29
	 TS+DeW4KWLGDwT7SOVkk5MtCBoFSm1cDm/K6YraZafoRm6I58V10Fomxix2pe7YNFo
	 InNYXio5Crd5w==
From: cel@kernel.org
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] nfsd: fix possible badness in FREE_STATEID
Date: Wed,  9 Oct 2024 14:40:18 -0400
Message-ID: <172849919281.133418.5020480511074794369.b4-ty@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241004220403.50034-1-okorniev@redhat.com>
References: <20241004220403.50034-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 04 Oct 2024 18:04:03 -0400, Olga Kornievskaia wrote:                                              
> When multiple FREE_STATEIDs are sent for the same delegation stateid,
> it can lead to a possible either use-after-tree or counter refcount
> underflow errors.
> 
> In nfsd4_free_stateid() under the client lock we find a delegation
> stateid, however the code drops the lock before calling nfs4_put_stid(),
> that allows another FREE_STATE to find the stateid again. The first one
> will proceed to then free the stateid which leads to either
> use-after-free or decrementing already zerod counter.
> 
> [...]                                                                        

Applied to nfsd-fixes for v6.12, thanks!                                                                

[1/1] nfsd: fix possible badness in FREE_STATEID
      commit: c88c150a467fcb670a1608e2272beeee3e86df6e                                                                      

--                                                                              
Chuck Lever


