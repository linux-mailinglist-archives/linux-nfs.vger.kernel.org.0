Return-Path: <linux-nfs+bounces-12134-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 919BCACF200
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 16:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5F1167B5C
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 14:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ABB148830;
	Thu,  5 Jun 2025 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dE5XK5CS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446F525634;
	Thu,  5 Jun 2025 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749133951; cv=none; b=rKfwgjlV80kzaa1emHhaqhnRqcO8MdTm4fiCzt04rPwHHHfl5HfZ+DIEaXeInJR16A1qNL0+JKw5AH9uM576FL45IjD3eJwcddaQA1/JRVvPEUjWafqsg5e78eNUPWqlA9KCbwHFv1C2Lal39d/HAvoucQxoTuD7xxYfA/Kv4d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749133951; c=relaxed/simple;
	bh=8PSsu/WN203voDL6PXdKIXz/ix7ldykimbPQthxlAl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tAyUjyAwBS4LhBC8wjXLD6XuzE9gg/Ps2jT9vF2nkBDa+fftSX+acdOl6+TuPQdDZhWhG9TOD9+Iw0JNRgRE37zX2iuoQlsUa/Zxn2P19K3JoaK94OeauomD/MBGSYoUptBbLnDHhP7urqqGHB3SOa7ZPY515ALklOG/p9HJujc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dE5XK5CS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C24C4CEE7;
	Thu,  5 Jun 2025 14:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749133950;
	bh=8PSsu/WN203voDL6PXdKIXz/ix7ldykimbPQthxlAl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dE5XK5CSLCYcYb+k/un0WEgcXwUxBbDevyW5jQGKalwwRojopdLgRySNfRfq3SVZv
	 qr8o5Tnl94YWLZO2SBwhQMt52u15DyEQCyq4scPsQg3V4uz5ly9mY0KiWg22jAa6YS
	 Ak7x3jO/2bQHGgG/NF+8GE9LL/1ikM4Ep3LI4MYXUOnbhCY4q8coLbIgZ4GmtBnwpH
	 tOJG/g9+3kjanY6ZvShbJLjbP+l8eRuSVX5DRG77CUwC7l3TFFwdDPHGWpuZ9FYV+E
	 zC9qb8THQn5Jpr6H7AWyOHIEi5ywRwPnNjpq0y8/khY65Beh4d4SurVDKA0DEAx1lN
	 R1fbTpGm4qnqA==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	Su Hui <suhui@nfschina.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: Change the type of ek_fsidtype from int to u8 and use kstrtou8
Date: Thu,  5 Jun 2025 10:32:25 -0400
Message-ID: <174913391593.1334788.12573328900273242267.b4-ty@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604034725.450911-1-suhui@nfschina.com>
References: <20250604034725.450911-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 04 Jun 2025 11:47:26 +0800, Su Hui wrote:
> The valid values for ek_fsidtype are actually 0-7 so it's better to
> change the type to u8. Also using kstrtou8() to relpace simple_strtoul(),
> kstrtou8() is safer and more suitable for u8.
> 
> 

Applied to nfsd-testing, thanks!

[1/1] nfsd: Change the type of ek_fsidtype from int to u8 and use kstrtou8
      commit: 6d347df2660c6521c665b19f80b25e20363a660e

--
Chuck Lever


