Return-Path: <linux-nfs+bounces-11212-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D32A96F14
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Apr 2025 16:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3B73BED89
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Apr 2025 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F61728C5B9;
	Tue, 22 Apr 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5LovPsE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B29A28A407
	for <linux-nfs@vger.kernel.org>; Tue, 22 Apr 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332798; cv=none; b=VnYHceLjdrm0egwwsVvOtpKVgArb0gnQCzR5qDa8TQBgjFHK+3VXzoDEuny7P6/vlWXp5Fq/w3VzjIIYpRHjcJACMYJo7IckAI5lRkqBX9TtUQGr46D0n9fgTvAOwHLTdnKn0t7ubxjByi1CKIw3QDcgkJDFI2P1TLDHqL9DjvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332798; c=relaxed/simple;
	bh=abntxDrGduMa7dqRgY8vS1T+eOB4CpNviGmnZdKVL0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zr/5Dril/iNt/LpOompybPiVvbcBtvU0EU/GtnGQuDuJYMokcITBq53E8cWJunZM2S3YvUBFqslKsLcfAuYvUOmakeNS5aK+JTXlOmTLKBdC2/WaPwWK+RRYwuEYS06Xi0DtSYOk1iB7tr8yFCI90eel+rRooF6JDz4016Tr9mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5LovPsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4937C4CEE9;
	Tue, 22 Apr 2025 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745332797;
	bh=abntxDrGduMa7dqRgY8vS1T+eOB4CpNviGmnZdKVL0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5LovPsEFhKygMnzvQweNbVjQJeAjrmxv9ok9tNSf8P1Fx44d3c7mqVqmtxenSMT3
	 YF7Hjqz4govuD9YaD+dhwwRnBJmOFgyUT0f93F7SqYwZxr/7An2ZRCOfo1S3npAYfP
	 U+m5t9tVr+ZqwJSG3XsLw6XGy90AbCsXB/z6bBk+CsWqXLX4ntLjq/7KTpqLW7U8vO
	 70bYi4/eurR27Ln1u0uqHbwa9Ry0LbvPIh6rDlpaGsFTv25ZRSe1LOSISdEQPhmg0g
	 RU279sCPxdGnxnYjPN3te1iFAK7IZaovHGeiNEfjj36hSYXEBPX+sZfFPffNiitXNJ
	 S2ftlFPDJWrGQ==
Date: Tue, 22 Apr 2025 10:39:56 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: Re: NFS/localio: Fix a race in nfs_local_open_fh()
Message-ID: <aAeqPJpdVR4uHM0l@kernel.org>
References: <3d2d3ade569302f7d52307d71e0fe1c46fc95f32.1745261446.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d2d3ade569302f7d52307d71e0fe1c46fc95f32.1745261446.git.trond.myklebust@hammerspace.com>

On Mon, Apr 21, 2025 at 02:52:42PM -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Once the clp->cl_uuid.lock has been dropped, another CPU could come in
> and free the struct nfsd_file that was just added. To prevent that from
> happening, take the RCU read lock before dropping the spin lock.
> 
> Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

