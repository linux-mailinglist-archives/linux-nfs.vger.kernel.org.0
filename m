Return-Path: <linux-nfs+bounces-16885-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADF4CA1500
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 20:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07A7F30021DB
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 19:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51FA331A7D;
	Wed,  3 Dec 2025 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJN3n/Dk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D469331A75;
	Wed,  3 Dec 2025 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764789371; cv=none; b=LCZ+UuhR7EV3bV4r0YYQyVSr4QEpgXjVpnWq+GOeBax4GWbe7QHxJwQ0HJFdKY9Pm1dK5RIa9XDAzdGUuFYtjpQ2d8e/tnbj2uPeuJYEc3+EKHu79Flhx72Y70dLvF9noSJ6NBHUQMume9lnWxPe16bYBSaj6xBeQ+srvQbAVr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764789371; c=relaxed/simple;
	bh=9e59MW9S11Nfs/CE4U+8GTpWjKK5jVq+TY9ow39Y/28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbtKV/jYbaba/dLJgIE3H25IMhc0E91hq9XsGZnLDxhqxVBXtbCRBHS1a9HJY/4tysYN7ADSa/T3DVw0Ga4tkDwZD/trpUM/7xBnqhRCZ4YHSDwJSWBCifwN5egz3AzYxqOypCru1HOa1we1lQjiCygkUOAE5ZykZs1XDT05Ths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJN3n/Dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF4AC4CEF5;
	Wed,  3 Dec 2025 19:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764789371;
	bh=9e59MW9S11Nfs/CE4U+8GTpWjKK5jVq+TY9ow39Y/28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJN3n/DkDZE1OU2tPIJu3QS1PTjELUcP0B0QKomAai6E4IB3JvOn1Yxr+trIk+Myp
	 pRPKn7ILh953xipgDIjaEU9Zm5Nmm2mI+lOYopEszfQTqDF/ZG/1F0oSfLTzX9j4gz
	 V/GTkwAPzU6nIfSE/oVgbvslBqIUaN2fSyNkWnb+2BZfd5MfgG5gZFC2xVcsEvUwN+
	 NsvqsziBhiftpHSWFFHNeUc/l177LEyQfdqIpllyxLZjXWewcgUgRaTwOC7een9IRh
	 p/p9c+IwO7Q11kf9mjKA+1NmXTl2w/rCgFoCddHh0UK2aOLAfE6+MdhQq9GLtSM0tv
	 TpVxsu3Hca+sg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] nfsd: delegated timestamp fix
Date: Wed,  3 Dec 2025 14:16:07 -0500
Message-ID: <176478935627.10261.18139696156673858570.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203-nfsd-7-0-v1-0-653271980d7e@kernel.org>
References: <20251203-nfsd-7-0-v1-0-653271980d7e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 03 Dec 2025 10:52:14 -0500, Jeff Layton wrote:
> The first patch fixes a bug I found with delegated timestamps, and the
> second makes the warning message that prompted the fix more distinct.
> 
> This is probably fine to wait until v7.0, but I think it's safe to take
> them sooner since it is a bugfix.
> 
> 
> [...]

Applied to nfsd-testing, thanks!

[1/2] nfsd: use ATTR_DELEG in nfsd4_finalize_deleg_timestamps()
      commit: f0cba9453ad1a29679bd3d872aee5dd691b84d1d
[2/2] nfsd: prefix notification in nfsd4_finalize_deleg_timestamps() with "nfsd: "
      commit: 1f0bbd7fd62f1f00ecf0df3dc53083d2205d994d

--
Chuck Lever


