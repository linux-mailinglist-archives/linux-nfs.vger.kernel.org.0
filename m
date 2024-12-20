Return-Path: <linux-nfs+bounces-8685-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B5C9F9461
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 15:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44ADF7A44BD
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 14:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B92216386;
	Fri, 20 Dec 2024 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/Kh+Dzg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AB78632B
	for <linux-nfs@vger.kernel.org>; Fri, 20 Dec 2024 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705129; cv=none; b=VavodCGDfozbjngO38EFSCEYjkjLolFJ6sXNOpkfR4k5S51re5t9BP5T7uqiIdzPYzh9q0dveAqqinGHGprJoBWMQuJ/qa5Hdmq+qT31VhHCh1ylbN/2Mu4MS224aN6rcGylLkigMg572zUxkVyeb6YYXi4o4wimvPT7XwRzGzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705129; c=relaxed/simple;
	bh=nsKnoGuxMcvQO/egpBgFZevVBwUakaGAR4AQbN6fNAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JlbPwQzD6VKBvqE0rQgzYXAyp2pNeqh0cLaepepXZbmlzao5L2sLFyNKyjEGLtuAkA3gNZVOk61G4iaUCfydwR9ZHM03l1Ww7J8JXvvwTZpAJYyE2mm9tjgfwY0+fjGhb+izBzKqDvATVq3CzUrAxXS5hLVPGPrQ9sQqsgUz3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/Kh+Dzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48569C4CED3;
	Fri, 20 Dec 2024 14:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734705128;
	bh=nsKnoGuxMcvQO/egpBgFZevVBwUakaGAR4AQbN6fNAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/Kh+DzgcTS+81Y2ReYt22rXFS03gmwVB9UNsoAH/1mM4FtftfH5j98aevbS9Y8VM
	 iE3W2uciuh3OdzUfFgEFAXNnz9tDUmq20jJI9tr1bpXsuK7EVOZ+CWZng/++qI+KxX
	 TDAFqbvUfrGp1/0Ii9kozB7wMcmnCqkQq8cG9PyPHdgHUazxDDpB25DqDiVnnSEsDm
	 wL1wrzB2BFz1VvOUviw2wgh1+ek7EiS5IyXMwbPu9H4HGhn8ycOLZOnR4zaKZDcVTj
	 Yly+yhpI4uhMnJlgYW/lD9KH7uAGxy2y167jY4OSAclCAZhE5SN6lyCc+hgkfvfwUz
	 nZgwSgBWWrQmw==
From: cel@kernel.org
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: add cb opcode to WARN_ONCE on failed callback
Date: Fri, 20 Dec 2024 09:32:03 -0500
Message-ID: <173470507264.15853.9642271702676750060.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241219215748.13006-1-okorniev@redhat.com>
References: <20241219215748.13006-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 19 Dec 2024 16:57:48 -0500, Olga Kornievskaia wrote:
> It helps to know what kind of callback happened that triggered the
> WARN_ONCE in nfsd4_cb_done() function in diagnosing what can set
> an uncommon state where both cb_status and tk_status are set at
> the same time.
> 
> 

Applied to nfsd-testing for v6.14, thanks!

[1/1] NFSD: add cb opcode to WARN_ONCE on failed callback
      commit: a3f44affa23bf2aeccb1eb82492d38f3ad2cade3

--
Chuck Lever


