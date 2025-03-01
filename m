Return-Path: <linux-nfs+bounces-10397-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6A6A4AD2F
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 18:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB763AE8F5
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 17:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A153B1DF985;
	Sat,  1 Mar 2025 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXMEyzj6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BFC8F7D;
	Sat,  1 Mar 2025 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740851485; cv=none; b=J+LJD1VW0qDs5RU2pG2WyAUylBjPe40CqKSmIWX7+jSSKn5r/MPG3CUR9tadAxVTZOQt3Ygjm44mQIXnv9LF1wb0wnCc8oAdKsiINQexyc/OcB/XEQ/Q5tzrb7SSOq/3LSaZtPnq0TiMkfJM3M+q7+8Qih3yJc8WIF8k2llR30Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740851485; c=relaxed/simple;
	bh=2i3x9epA1D/2NaH6/1PZKzalbeifBD7Hd3d25GLxbq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4QfQiiEGihrsYTI2p7cbVapegNmTm17l4oBTO1gAMUVim0DDT25cHws4h0wVtmLWfLFc4yELrUHu0uhGTGO3kIvKf6FPoF3RYShYkCEAHwL119yVwY71TerGzzsPbN9v+YKIAoV+JUMSr0oR2lGXjue5C91fcqiUE1pMnxj3R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXMEyzj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A742C4CEDD;
	Sat,  1 Mar 2025 17:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740851484;
	bh=2i3x9epA1D/2NaH6/1PZKzalbeifBD7Hd3d25GLxbq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KXMEyzj6/0hdBTRfEU/90hrvZmdCoGagZz6ImVxjAUaB2YZx6xN3EPwmBryyzypGc
	 5nTaOIgX2h64BXIlZgXidDIpOWCSfFiNnNmKGmk0QK5NNcg1HiOyVRzAycDSXv448H
	 MmK0w7uD63ooH1KheqyU6vOJ3GyS8qB2mj8ebJVRqeQzOB6okEzTq/3q+WpnYdC/3Q
	 eAuT4SLJL1eYYdOZ6DgV2BaPbHIOovHym+dKbEPTtR3gEOHBLc/XJYqH/kGOLQlyVk
	 Z/Dk3d1R+qHxQceRaLDhyepERgBdMsI2ypynubrh8Ti+umMsxPGtOnyDCEXPBzied0
	 B6z9upLeWlUWQ==
From: cel@kernel.org
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	NeilBrown <neilb@suse.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Arnd Bergmann <arnd@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Simon Horman <horms@kernel.org>,
	Yang Erkun <yangerkun@huawei.com>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] sunrpc: suppress warnings for unused procfs functions
Date: Sat,  1 Mar 2025 12:51:20 -0500
Message-ID: <174085145847.10954.136116488472523421.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250225145234.1097985-1-arnd@kernel.org>
References: <20250225145234.1097985-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 25 Feb 2025 15:52:21 +0100, Arnd Bergmann wrote:
> There is a warning about unused variables when building with W=1 and no procfs:
> 
> net/sunrpc/cache.c:1660:30: error: 'cache_flush_proc_ops' defined but not used [-Werror=unused-const-variable=]
>  1660 | static const struct proc_ops cache_flush_proc_ops = {
>       |                              ^~~~~~~~~~~~~~~~~~~~
> net/sunrpc/cache.c:1622:30: error: 'content_proc_ops' defined but not used [-Werror=unused-const-variable=]
>  1622 | static const struct proc_ops content_proc_ops = {
>       |                              ^~~~~~~~~~~~~~~~
> net/sunrpc/cache.c:1598:30: error: 'cache_channel_proc_ops' defined but not used [-Werror=unused-const-variable=]
>  1598 | static const struct proc_ops cache_channel_proc_ops = {
>       |                              ^~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] sunrpc: suppress warnings for unused procfs functions
      commit: 707f5c1dc5320be41b05d75624fa6423e058f4a8

--
Chuck Lever


