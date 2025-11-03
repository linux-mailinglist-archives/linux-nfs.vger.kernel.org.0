Return-Path: <linux-nfs+bounces-15968-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB470C2E21D
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 22:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000613B9607
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 21:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C022D061C;
	Mon,  3 Nov 2025 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epzZBdlw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE9C2D0607
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204750; cv=none; b=GEGf6Uo3Y4T7nRQjtEHIxFRwE9btIp9PneETVLbYJzcwxHXLWhXHiyHQG/infrnlrqWTwbBEw6jzHtvHwcGe7rjPuWgtqMU5KrN2livXkcONrS3ju/aEVcP+i7HSic3JLGY4YAa63ZEig9OtMw4mWnI5X4DjEYVXyQKEZG8Pj+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204750; c=relaxed/simple;
	bh=LukNrj+Lul08K2GPsc9FhbYeLRJ6Nts+ha0wN9CUmJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coslw1c+GSAKu5IVdJS13R+5ccNEunJF6dmN98f1mmam4b7sbegc5y/LLvSVEsnIZzKatNRHPo37Tjo4jmY1qLKb3Nqv5pcIRJd/MPd78CnPC2VjJQISSyDdO9to/OxVw2cdTRLVaAgNvocuXPuBpGKlAKO4lzPwLJYWcacQdio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epzZBdlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB39C4CEE7;
	Mon,  3 Nov 2025 21:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762204749;
	bh=LukNrj+Lul08K2GPsc9FhbYeLRJ6Nts+ha0wN9CUmJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epzZBdlwh7/XK0wbvKOiX4mzd5IJx0wGpGoz7gow5CWqYlGd1S5tPLzH5Ypmu3Wny
	 wkp0JYWMYs4uO2C9uvlcogICguYwVEwF9RlUfNwz6PP43JLIQpZ6gxUDrQnH8tsL0C
	 xd0goxa8LK9RnBg0r0ft2a5fIQRr1HXx3XNauGwceSU1nEmrgH/j0rX93sqIEEpMrs
	 RfCaI0l0imT19LVVhEgicQKXKCUskgT61yAmg4lHY5xjPsuXUx7nckpNFotmDtKZAB
	 X8TF2UbtRZP59lzMbvAQUJlGwWYL9XUYQHyTOyGKOhSSVpvWvNyWshm7fjZvZfTpqE
	 H6PcRt/+JGhQA==
Date: Mon, 3 Nov 2025 16:19:08 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v9 09/12] NFSD: Combine direct I/O feasibility check with
 iterator setup
Message-ID: <aQkcTKm6phW4V_ci@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>
 <20251103165351.10261-10-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103165351.10261-10-cel@kernel.org>

On Mon, Nov 03, 2025 at 11:53:48AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> When direct I/O is not feasible (due to missing alignment info,
> too-small writes, or no alignment possible), pack the entire
> write payload into a single non-DIO segment and follow the usual
> direct write I/O path.
> 
> This simplifies nfsd_direct_write() by eliminating the fallback path
> and the separate nfsd_buffered_write() call - all writes now go
> through nfsd_issue_write_dio() which handles both DIO and buffered
> segments.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

