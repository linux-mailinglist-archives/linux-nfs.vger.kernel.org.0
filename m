Return-Path: <linux-nfs+bounces-12444-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 733B4AD91D3
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 17:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12F23A4915
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CC41E990E;
	Fri, 13 Jun 2025 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5p5AMjD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFEC1C5F2C;
	Fri, 13 Jun 2025 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829722; cv=none; b=XlFStpTlcWzqpNO5hH2pdWmFSJ1zBIs8IuR79wbsTRJ5QsdNAtluDuTYdjGQ1Se6RBbwTBtpuHdlSEUm/pefYJm4kn2hfOvi1hvyrytbWYV4gZ6GCl33pba6gpUEAtzQOUDHIG+rbXtoSSl83DLQneqAtZGQrdf9yW6B7f4EBgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829722; c=relaxed/simple;
	bh=hkm3AyV/bcFbIYbpvXd3dbrxJh4JjZw7m+IKeqSb7hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XM8azywhhXD0ANuUmXgVvkGK2oG0Ezbg265QrP2kPSeTYlE6SYMQ0Moeek6xH4uxpg3OfwT/JCfaxAFXIM0Su5p9+GEJTWe1Y8haPHIyj1dqI5PpcgE1gUZdBl5hgefB6tGpB/XBd1tujaEv0Nn5dG3gv/Qt6kPpFnSKcqS9pyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5p5AMjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528A5C4CEE3;
	Fri, 13 Jun 2025 15:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749829722;
	bh=hkm3AyV/bcFbIYbpvXd3dbrxJh4JjZw7m+IKeqSb7hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5p5AMjD++z1Z48mHmLVbVIJGVvninvDjrnCKo9leVgyl+h0C0iOVbtxNYhr96dow
	 v/SKDoljRhuyBe6mmKk9sTXdIBzUw49NsEO99dHyY1zJCuVnTRt1bRinF9mTgCKfRd
	 Tq7L+2838pNRyFKwUYK8ECXEOhWYnvznKZaXTS49cJU/q/V3husnA5XAlZWnybj/6/
	 5J/MhxQ2bewm/mtyOHFjvLQSIbvuySHewHVmeKd74xNoZkEJfcX6ipP7qH7d29YMyt
	 bjHby4f5lFYvQn1FVrf/t6XyRZgJDM/AW23dAPBXL0goF5CUTvXgeOWPzaZWsqweY7
	 QoazALVIOT8Sg==
From: Chuck Lever <cel@kernel.org>
To: Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH v3] nfsd: Use correct error code when decoding extents
Date: Fri, 13 Jun 2025 11:48:38 -0400
Message-ID: <174982965908.544557.2417180115604364588.b4-ty@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612214303.35782-1-sergeybashirov@gmail.com>
References: <20250612214303.35782-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 13 Jun 2025 00:42:49 +0300, Sergey Bashirov wrote:
> Update error codes in decoding functions of block and scsi layout
> drivers to match the core nfsd code. NFS4ERR_EINVAL means that the
> server was able to decode the request, but the decoded values are
> invalid. Use NFS4ERR_BADXDR instead to indicate a decoding error.
> And ENOMEM is changed to nfs code NFS4ERR_DELAY.
> 
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: Use correct error code when decoding extents
      commit: 9558037b8e9d90f099f1c6387151ad3282c28b66

--
Chuck Lever


