Return-Path: <linux-nfs+bounces-15965-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C849C2E1EC
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 22:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03681895CFB
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 21:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA669142E83;
	Mon,  3 Nov 2025 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYwsdba8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E391DFF7
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204531; cv=none; b=f2aFFrX38jIq+qEMiFM/35fLnUPlvQucnz4dfYpk91NzZoHYKWa/wFjuRqvkHWbCBv7Mqt6p2bK9Qm62JLZTUkgGuUIcUrU0Fcr6n6cwh4JJzXJxeg7dGihM8qFi0cz4FzoIzla+vFjv5J7bEIw7FGbaA0n2ndShihDI28osF+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204531; c=relaxed/simple;
	bh=U0t0CXbxYbxYqhfYRK2jACv8YBGEiTyoc/vIHN1I7q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rhfw+gpxt6DTEyoBn6xx71z4S+wF86ASyRIlZHBRd/lMFXtlzJsQgL3DvFSDKFALISIpnqnn3B/E5yx9GHLkZ6IpxOnq4s/VRmIt7nmzNd1dLuHQ4msV9h2lhrLF6N6q/tGpxbsDxTux7B01awh4XwX4JpXmirnkc1gmmGBgtCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYwsdba8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273E7C4CEF8;
	Mon,  3 Nov 2025 21:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762204531;
	bh=U0t0CXbxYbxYqhfYRK2jACv8YBGEiTyoc/vIHN1I7q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kYwsdba8Ri0/s4QYsSO7NnQIf0USBOwZXnfEgamcEz34qHng4uqvxYaaHoPae8/Gn
	 DnIzktVsvD5hUOlJkzP1SNnodZJSjrhM4e0msfq/afSDgGyz5trzC5XTDeEfLzm3SF
	 ERXTociN1+bjykSG0l/zARGqcj/JgNncklQ7U4Q1vt0+15yO3PJga+Rh8BoAhgyK7H
	 Awb6cFFL3pu7VdyfGVnIqohj7ygv4ALXwRI/0IK3w2T7+GOsYWLc3tSgM5MU6sKyfp
	 kLchzqg6lt76CzwuUl++j1cPnUeebSuwFkbVGAyroJ2ByCsLUCNyCZME8YiFuv6qce
	 j2FOFOu4zG3CQ==
Date: Mon, 3 Nov 2025 16:15:30 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v9 11/12] NFSD: Refactor nfsd_vfs_write
Message-ID: <aQkbcq4Mwc1B3K-S@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>
 <20251103165351.10261-12-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103165351.10261-12-cel@kernel.org>

On Mon, Nov 03, 2025 at 11:53:50AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> There is now only one caller of nfsd_buffered_write(), so it can
> be folded back into nfsd_vfs_write().
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

