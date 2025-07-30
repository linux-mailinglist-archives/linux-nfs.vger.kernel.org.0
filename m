Return-Path: <linux-nfs+bounces-13316-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5083AB1621A
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jul 2025 15:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC0E37B4892
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jul 2025 13:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B942D94A1;
	Wed, 30 Jul 2025 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCnRjt9W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE762D9482;
	Wed, 30 Jul 2025 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883859; cv=none; b=BLt5CzW4M79de08QFco0p2K42OdEVZhwJUGsTpcYqE2JwYVq/FhYh9aUjj7FFncDEJwAqvp/FSUwqgP6B7EAOSkxvbw1LPp9GiONZed2Arv4RWgCiz8Yi9+wjvJhj/kRMFy/hZygJ9pQGyYCivyqO5r2gkEnaO8hcMBnDU09Nic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883859; c=relaxed/simple;
	bh=1LsoPXULwa19yD1hsUghgaJhhSgb4fsudezH6xVcUl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aqxd60Q3DefsT9Q3kIhiEF3loIIhx73zJpLRoQ80aogAXhpB4FyqHF+hkTFePRj1PT7b5yHNhPQMPs+w+rfrCqHioYc2XKNWXBwM8OqNU6IY1/0ylESM0oyvmAhSERKwnwdynrFKdzCiOuQAKBuI0Mc0pM2hGkK/L0XkKKryFmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCnRjt9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD3AC4CEE3;
	Wed, 30 Jul 2025 13:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753883858;
	bh=1LsoPXULwa19yD1hsUghgaJhhSgb4fsudezH6xVcUl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jCnRjt9WICdEy7fOXeBxQVXQHO1t+Q8YpV0bD55UmFW7rYn3oRY3UJQwJ8wxHjrmO
	 w8i9u0wQKazmW5Ff0rOvXA0RZrCfoKXju9uGk11n8NCsbaqnEUUVN5/LW17ngrGKGh
	 LAnA4P6/lhP2tT3oO97sxJYU3pXPXDN37GYe8r62VoHjq0pK+4YKCQWMe5XH1HT2Yr
	 6eCdTH+3hpP6TlGTzknX8JkWxIYLQA9FHyKaSnhrlTYZs1CPZxjEQg6rOzU3l3O/gf
	 V07LCKRCFyN3p9s7S0ddf+rqQW1pvvHBDJ04nJXF0ZDAjaAQ497Bm0sfmDhCDnQ+yc
	 LQsgDlqtHo3Gg==
From: Chuck Lever <cel@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	Colin Ian King <colin.i.king@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] lockd: Remove space before newline
Date: Wed, 30 Jul 2025 09:57:34 -0400
Message-ID: <175388383179.79309.545309960517317887.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250729130709.1932507-1-colin.i.king@gmail.com>
References: <20250729130709.1932507-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 29 Jul 2025 14:07:09 +0100, Colin Ian King wrote:
> There is an extraneous space before a newline in a dprintk message.
> Remove the space.
> 
> 

Applied to nfsd-testing, thanks!

[1/1] lockd: Remove space before newline
      commit: fbdcd36f30cbf78f39c731a30337251d9f1e91a3

--
Chuck Lever


