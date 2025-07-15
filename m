Return-Path: <linux-nfs+bounces-13084-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F83B06346
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 17:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9647B580478
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662B924BCE8;
	Tue, 15 Jul 2025 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPdYnF28"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C76124BBEE;
	Tue, 15 Jul 2025 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594127; cv=none; b=CtSbOgpZ2GTv5j6IZVANTJoffhr+rctP+J4pCmScgrUt2IckNh+wXc5c+7D9NcAV+4Lv8Ra+bsXvF1Y53l+9ejYim8bIcpRdUTY2bKoslnlFVUeBppGyLJ4pEo+FsHXsF8JvNcD8oFklXDJH/I8nMQ/Sd8yuwGBEr4Tl3uqDiH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594127; c=relaxed/simple;
	bh=O1UOoJ+tzoKilI/5jYHc0jZ6oLA/FPdKRt9ZFslCUyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXtoYvO1B2ts2MCCim6asVh11o/jX8TbFPTpfUXfn/c24LDGDVz+cLms3lErRrKimt0YxwoKl15IMSR2x5LAYI3wyEWrHR0592+2MdevGNUVFL87I8bZ+m6+IuICs8XGrBnyeS6QR6aysgOTR5iBhB/B2h/Ba/KWEnEDLBHOI8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPdYnF28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CE3C4CEE3;
	Tue, 15 Jul 2025 15:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752594126;
	bh=O1UOoJ+tzoKilI/5jYHc0jZ6oLA/FPdKRt9ZFslCUyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OPdYnF282B/V5SzanElp7l/d1ERww8bIJHR0EnAnuXEZwA9gq/gyNMKkTkv6pMj3Q
	 auLfYtLQRd9j+8i0drZ1cip2l+NSyxRgEIWnGEYptjO/Ls/PhuQe8jJzbVWnSd4ibY
	 eXOFL+1RVCDKbIcS4ElaXyBv4WXsV1G/TLq71CQ613RgmOwEQNYYLYovh0zL3t+bXl
	 IhKwMnIyXtVg2U/zWMVaXLx32KxCRT6q2F1r/5gEJnPGk0XrwA5SESdV9EUj4WxDEy
	 TiB/tl0RiEDrM3C2AhwUFycZfNbi0gwIuOP7xvR0njFzSph6tAw08HS4ClqUQTWtLV
	 cj6URTjddE0VA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: don't set the ctime on delegated atime updates
Date: Tue, 15 Jul 2025 11:42:02 -0400
Message-ID: <175259401527.1095462.15384402941904177297.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250715-tsfix-v1-1-da21665d4626@kernel.org>
References: <20250715-tsfix-v1-1-da21665d4626@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 15 Jul 2025 07:34:10 -0400, Jeff Layton wrote:
> Clients will typically precede a DELEGRETURN for a delegation with
> delegated timestamp with a SETATTR to set the timestamps on the server
> to match what the client has.
> 
> knfsd implements this by using the nfsd_setattr() infrastructure, which
> will set ATTR_CTIME on any update that goes to notify_change(). This is
> problematic as it means that the client will get a spurious ctime
> updates when updating the atime.
> 
> [...]

Applied to nfsd-testing, thanks!

Because this patch touches generic attribute handling, I'm targeting
it for v6.18.

[1/1] nfsd: don't set the ctime on delegated atime updates
      commit: aaf2b07a551950a6e4deab07f6cf73c4a6592a35

--
Chuck Lever


