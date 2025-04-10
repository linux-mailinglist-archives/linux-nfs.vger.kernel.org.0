Return-Path: <linux-nfs+bounces-11085-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7A9A8466F
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 16:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB12B4E0A39
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 14:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C262836B1;
	Thu, 10 Apr 2025 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ey5ZlfSD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84E8204697
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295387; cv=none; b=OjbiAtFdCJPqeOXvlzCeehrmZEkDKgXmo2uGk8z1NRx5vfIZnMkEcIWBHvMKgV1OJi/MCU8PMFuX7rJLwk8kntrs453lc/xji2e7o7VNJ3Z9T3u9n1bAcRdvW6x1ToFg1ONk14LZwSvkJm8y0SMEpcyOmft7PraeBzm/N42BTy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295387; c=relaxed/simple;
	bh=5yK36dNOS1L2w/tNsMmnBotBGFOHWf1u+k1dCh3Y23E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JM0oFrN7tkE5qaGBgRxbdSK/9+K94Ceoo/KDoXs3rhqiuaiV2S1I+hJIGxzk6gTo4asm0xz5P0Ml3JJ1nCS3nhESUM1w8x+akyk/8Y6jmoUm1gFMuf13bGj9aHbTVGw77Ku84QILYF96AWXvXrIPYa3Ug1CsPmqPzBYOkcsG3gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ey5ZlfSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9337C4CEDD;
	Thu, 10 Apr 2025 14:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744295386;
	bh=5yK36dNOS1L2w/tNsMmnBotBGFOHWf1u+k1dCh3Y23E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ey5ZlfSDnhq5PptUzvQbIhM5/wIu0pQ0YOERpLLieXB0KCvdrhbs5YL0DJF9CIWNV
	 tc4427YO8Ya3GVXzEcPnJIgP6z27eousUVgHfLRmDkFfGBrPX0IjosztsZFtM19Qny
	 NpYwMTr8OuUoNJOgGnudVZECRztoGSy5CeY7v0XWsqKIsshOodej+2+UbD2HMtiMbN
	 CiUKCDkX/W1ILwoUKt0IghD595vsxKLO3vKvrGhzbdXPphZFYV+DPZvW8oKojPhQ0y
	 ggIOGkag71shN2A+/hbZz/6WJT90C5pJWT5hpGDo0b0gFXFM+erYwyc/l9iVnj18SI
	 v1Hbo35yrbRZg==
From: cel@kernel.org
To: Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: nfsd4_spo_must_allow() must check this is a v4 compound request
Date: Thu, 10 Apr 2025 10:29:41 -0400
Message-ID: <174429535730.22687.11355511149178297924.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <174312035952.9342.9287917468081272195@noble.neil.brown.name>
References: <174312035952.9342.9287917468081272195@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 28 Mar 2025 11:05:59 +1100, NeilBrown wrote:
> If the request being processed is not a v4 compound request, then
> examining the cstate can have undefined results.
> 
> This patch adds a check that the rpc procedure being execute
> (rq_procinfo) is the NFSPROC4_COMPOUND procedure.
> 
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: nfsd4_spo_must_allow() must check this is a v4 compound request
      commit: 2abb04fa48e2469247d2e3e05df8df9edd1fe402

--
Chuck Lever


