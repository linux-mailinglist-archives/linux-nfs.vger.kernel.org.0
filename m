Return-Path: <linux-nfs+bounces-17102-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F97CBEA09
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 16:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A245C304BD92
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 15:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD9128B3E2;
	Mon, 15 Dec 2025 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHK82hrd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98590257828
	for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765811704; cv=none; b=mat0ht/VCqo4Y1oCYEbgY+tNADnhnxl8hrAYVtClL8I29k3xpVoRpjhluMG/kQbmDN2NKusMPCH2/bKfVhRgk2rIpPPj84+GDO/2/lI0B8UKIZl1dM7V6sR9zFISQM6Yf22REu/h780Rlpdq5B52WkNAAOB5ySc7J3B593EeKJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765811704; c=relaxed/simple;
	bh=ZWfMwWYJOLFFqKHFRpjT9FRS7CY0RRqmhhmXluo1oL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5S6yt5JmvgmuOfjJdxY/Btmtlq3q3ZB6aJsq5A0mBtAp+RvhborLn9hMjgR4hn9XCyUD0zDlEqJTI2b45RnDfZV9Dx8HK1m4gHjQ0yClmrLXPbmGKXgqrbYaeutEp5kkIO7rw4uJoI1wGpX3O7BN+QZNISENrxew3Pkv+gHcHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHK82hrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8E5C4CEF5;
	Mon, 15 Dec 2025 15:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765811704;
	bh=ZWfMwWYJOLFFqKHFRpjT9FRS7CY0RRqmhhmXluo1oL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QHK82hrdvPo8b+waulup626QSLaupfHhdf+LXq3rfP3VoK4me4cyiNqztI4vL1jBm
	 pkyM5USraDufO6OW+skk6fZ+DHcOsIj3T+bdCKJ+H8RdPVGuDTfe/yrryC1NL6VsgT
	 qsQeBAuj3tST9/wT519tENyvVWX+jnwEkcaomsV4rpdS0aoUAPN6Mo9rY2BitVUtix
	 iJdCo7vv3Zj2EwwjwUGGiSyvxVrI8VPL/RmVEz5XcOXtmwtbLP9Ubbh+uQ3+htFmmp
	 F/M3YzNLLyaNM5QjCx/WjH3kCXnq6MaVzG4XXZFoCduPvmisuEeMF0866APfGCJznQ
	 iXymz8NbnT0pQ==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	NeilBrown <neilb@ownmail.net>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: use correct loop termination in nfsd4_revoke_states()
Date: Mon, 15 Dec 2025 10:15:00 -0500
Message-ID: <176581169263.825293.1473149530691064759.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <176574644820.16766.17101861601059612460@noble.neil.brown.name>
References: <176574644820.16766.17101861601059612460@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 15 Dec 2025 08:07:28 +1100, NeilBrown wrote:
> The loop in nfsd4_revoke_states() stops one too early because
> the end value given is CLIENT_HASH_MASK where it should be
> CLIENT_HASH_SIZE.
> 
> This means that an admin request to drop all locks for a filesystem will
> miss locks held by clients which hash to the maximum possible hash value.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: use correct loop termination in nfsd4_revoke_states()
      commit: 07b54d4d7f3f9ccf008ffd095eab71eb86bd4b86

--
Chuck Lever


