Return-Path: <linux-nfs+bounces-10085-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3E4A341E3
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 15:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DF23AB6DA
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740E728135A;
	Thu, 13 Feb 2025 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntcq9c5c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D164281353;
	Thu, 13 Feb 2025 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456651; cv=none; b=NyR0UnA+ONoq1dlt/clZ0oM2L/bAZ+w/xZGdq4hRWWVWzxTnOnyNQIv4THxIljZecnrgKOZulGaSN0g45FIh6+OP531qQG13mKTYT3QoVF2FCv/K6DhG7Y6GbeZe6/+LNNXy5FozIQvx0568amA89xhqIk3nVwD5WhD9o+Wq1Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456651; c=relaxed/simple;
	bh=+1rtQPfsXWN3Ym0adKRmQ//eGkVZxZCCJ+inpIIZ8vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+pGQGNPaBC6m0mGeCEeWF4tIiWjmnFYl4zt7zS9of+or6zgpZZtiefkFWiPcCZPcSMqr0wRAUM2BYs6vur3YZIwi87dhyu4cd59ahFNBJ5qqZiA9ljaZdUQQOo7iUP8biweJuOdkZGork+YsLcDBf7I4H+FnCodVBmFnyDh+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntcq9c5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2BAC4CED1;
	Thu, 13 Feb 2025 14:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739456650;
	bh=+1rtQPfsXWN3Ym0adKRmQ//eGkVZxZCCJ+inpIIZ8vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntcq9c5ciHJRPXf9NYf+uqib6gI8ImleDSNooU8N0+/MmYk0eBaY6sA7LarEgEPWX
	 /iS7fXZ58YGAB1Uw2qadQd0x/jMPIiP+DMlqppdxv9KnIa8m8P7VWxiCAPf61F0/Gs
	 acQvNcR5OpJrxbI3Zn4rY+f8X9Tvqob9n1947AmiFcBUoKqJVenLNqYc6TP35gtILk
	 UQjcEhN+eOofNYLv1xuAUf1vM5kayHGp1llRDhA1On1THd/uADf/qy7V5pb24DJoAl
	 xYDwgxMiSo2w23QM9iFtKE/wySN5s1VqLc7CM3AO88C8xsiwZQUXXeeND5cCz8HiCm
	 vWP0KaOA8uzXQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: allow SC_STATUS_FREEABLE when searching via nfs4_lookup_stateid()
Date: Thu, 13 Feb 2025 09:24:06 -0500
Message-ID: <173945662302.137717.18205262588339447988.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250213-nfsd-fixes-v2-1-55290c765a82@kernel.org>
References: <20250213-nfsd-fixes-v2-1-55290c765a82@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 13 Feb 2025 09:08:29 -0500, Jeff Layton wrote:
> The pynfs DELEG8 test fails when run against nfsd. It acquires a
> delegation and then lets the lease time out. It then tries to use the
> deleg stateid and expects to see NFS4ERR_DELEG_REVOKED, but it gets
> bad NFS4ERR_BAD_STATEID instead.
> 
> When a delegation is revoked, it's initially marked with
> SC_STATUS_REVOKED, or SC_STATUS_ADMIN_REVOKED and later, it's marked
> with the SC_STATUS_FREEABLE flag, which denotes that it is waiting for
> s FREE_STATEID call.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: allow SC_STATUS_FREEABLE when searching via nfs4_lookup_stateid()
      commit: 4581224dcd0f1a9cc7e1994de3ea451c7d080f47

--
Chuck Lever


