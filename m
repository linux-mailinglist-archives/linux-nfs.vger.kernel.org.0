Return-Path: <linux-nfs+bounces-1200-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE97831BA3
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jan 2024 15:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8CA288FFC
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jan 2024 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC7C28DB3;
	Thu, 18 Jan 2024 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrjJo217"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BF228DA9
	for <linux-nfs@vger.kernel.org>; Thu, 18 Jan 2024 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588751; cv=none; b=dpPtq1Rn07AYjXncKq4NgJGw2d3xXohEnS/YoEz48+XIpEXdHGwSTOsrc7k4+Bwk8LPxGoWySX1MUvO99W4W6RvesUaOtq3kOC0KaCJjUO6fIS9vCOYVcCcjYJvT9YJk9W/fcUlLuXTllB9io1RI9DZWdxj7vGQ2hNWe9fHphWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588751; c=relaxed/simple;
	bh=3fFSVJI7CfF0c/07e1AA93Tp4Hd+Mez9yppOmPdTuGQ=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=mW4WclDNuKjT/gTLOb/kljOc9b97q7AF+odh3KxFtiW2ZSLk6GJu18GYiCTHu6/9JtwuASoxtqhEpLwTqyH7YEsAJcbTazViAyNtroeZ9hzgygtqVyXYVIHKktYgCgXlIxkspx58tAFM3yfKn+eddZlJwplmy1NOicVWgwwWY5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrjJo217; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99122C433C7;
	Thu, 18 Jan 2024 14:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705588750;
	bh=3fFSVJI7CfF0c/07e1AA93Tp4Hd+Mez9yppOmPdTuGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MrjJo217bVbdg/T/2y0Dh7dBaJYXc4CISFEC9c/FCef8owtQygfEmzNDBtXtB6ooy
	 OdIwWX4ja3TnZUfI3TCqdMYTnR6D3s9BB+mvHINDXo9usYvknrIged7BIMOHqQ5iwf
	 1arUBt+1RdG+eDSR+s2gqY3dEholHvBbpf64R2wyLqbEOwZCUDC2GiCmSchiXUVoR7
	 xM87xmEuTIZBEvVXzhJwiXiBQIhP8HqGZPJK6pCb1wvKfMGThxCGZ/aHctuRKPEH9Q
	 cc7RZb4Cv+8DJc3QNBUxultkWNFUKsBL84SpDuBfxkxtQKpob6vEEfWAGrn++LGo2W
	 QP3+iX3NDDdaA==
Date: Thu, 18 Jan 2024 15:39:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Jorge.Mora@netapp.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] nfstest_posix: add check for EINVAL when open(2)
 called with O_DIRECTORY|O_CREAT
Message-ID: <20240118-karierte-dortig-ee53d1a49abc@brauner>
References: <1705514501-2098-1-git-send-email-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1705514501-2098-1-git-send-email-dai.ngo@oracle.com>

On Wed, Jan 17, 2024 at 10:01:41AM -0800, Dai Ngo wrote:
> The 'open' tests of nfstest_posix failed with 6.7 kernel with these errors:
> 
> FAIL: open - opening existent file should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)
> FAIL: open - opening symbolic link should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)
> 
> These tests failed due to the commit 43b450632676 that fixes problems
> with VFS API:
> 
> 43b450632676: open: return EINVAL for O_DIRECTORY | O_CREAT
> 
> This patch fixes the problem by adding a check for EINVAL when the
> open(2) was called with O_DIRECTORY | O_CREAT.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---

Thank you!

