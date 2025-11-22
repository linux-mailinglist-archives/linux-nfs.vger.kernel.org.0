Return-Path: <linux-nfs+bounces-16671-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DDEC7D3FD
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 17:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43C93A8BF3
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 16:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBD023D7EC;
	Sat, 22 Nov 2025 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sflK/jyY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A03594F
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763828974; cv=none; b=ManAdWgfKsYHm+JmVFkY5P89UjcpikEMggw80hfxHmF23HpbXssA0yqM22i+md0gsQ0YOawn5jw9p1GwgYlOhIuW/OTsEfiKVmeNYWDwu87G2brOblMiiAgNhZzvuYT4F67AfzPxGNzn+wr95KzMtjr044m/BZVn1miyAi4VKGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763828974; c=relaxed/simple;
	bh=4m8wzGKtqLrYfflkp7IiOqV6I43p+rqppMSDxnEcyVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7wBJ8vmMKepPigWHz91is0/7tXk3SsnUo7tsNkYkbjinSyKPg9/BLhhtN3QpkN/sJtSMLDJp/Uj+uUD5ksP/gpuzIlyJYNrW7lTd3iVS0fT6P6h2y0il6WIRAev/cDMpCBUbiHkDCH4vNuUsouDYm6zeXOC6hRYR/bDFxpLzEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sflK/jyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502CFC4CEF5;
	Sat, 22 Nov 2025 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763828973;
	bh=4m8wzGKtqLrYfflkp7IiOqV6I43p+rqppMSDxnEcyVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sflK/jyYzx0E4zfZEPU0SNQzyWl1GpOq33hdlqByL8TDfpTE167mbAAegf3DVU3N2
	 suAg+/tNFbSznER4+3aeJdOOj+TwYqdjy7rpCUD4pdbg9hCNOpyRCmUTT43qN5oelR
	 sqRundpriM8rtpuuugJNNwqEMo7d9SKWgSSAdOvQyS3iSWq7WxNN3meQB/evVWrnX2
	 vt6dubvvGr8+ug6cqb1YwmzSMzWeU+/xTFD5QBjXw8TPDMMi00BnW0iP013t0I1HTA
	 1AAkZHmL8Hz31xiZTWFs7lihKrd22l+TjqzRlBAA+DdFhMREBw3WFeeYrtTg1kyxzh
	 viD6dytD4ZGcw==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@ownmail.net>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] lockd/locks: address issues with vfs_test_lock()
Date: Sat, 22 Nov 2025 11:29:28 -0500
Message-ID: <176382896113.67647.10608468951193584953.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251122010253.3445570-1-neilb@ownmail.net>
References: <20251122010253.3445570-1-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Sat, 22 Nov 2025 12:00:35 +1100, NeilBrown wrote:
> v2 contains fixes to problem found by Chuck (thanks) and also improves
> the documentation for vfs_test_lock().
> 
> Documentation says that it returns 0 or -ERRNO, but one caller check for
> a FILE_LOCK_DEFERRED which is neither of those.  So I address that in
> the second patch.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/2] lockd: fix vfs_test_lock() calls
      commit: bc99611cfa1b1cf67a17718feca65e43eeed3118
[2/2] locks: ensure vfs_test_lock() never returns FILE_LOCK_DEFERRED
      commit: 569ad3b4cf6ae8d71bf73ad13079e7b88d26b339

--
Chuck Lever


