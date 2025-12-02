Return-Path: <linux-nfs+bounces-16853-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AC4C9CA5B
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Dec 2025 19:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 652BA3495FA
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Dec 2025 18:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1502D4B71;
	Tue,  2 Dec 2025 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRCOKJPY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC52C21E6;
	Tue,  2 Dec 2025 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764700196; cv=none; b=o2Yn1nbQi8zg4yhObSbpGfR1usm5SuIqHrmOlawSfofbf3LX8aj0SvMJf25Jo3Mm68oRV1S1Um4OQrFCXsX3UWKC4t3Ik0gNT28zwH9yLuFUY2W28PYz8fGPJeraNM+Qxjua6EBKsk72bLcdhk2E4AiLTmMGpUDMxdKUFnU2ffw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764700196; c=relaxed/simple;
	bh=b91d4Sj/zOc1Uxp75EeHjQ7LhV7sLgUQXLlKeqKkWUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgExw+3uHtrB9KDLmUUQYgGHyJVUT6wVahKjPDVqwWnr/bfhZVGkSySTQUihyzeH2Hsev2bW1qAXOnKqOWNUykHc3OEhT0LDT6iDP964dxWHbl7DY2y2hDD1+0/mRhTvewVR4iph8oOkMPMDoMYI20QGN6Ah84f+VB4FkgQaRbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRCOKJPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A682C4CEF1;
	Tue,  2 Dec 2025 18:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764700195;
	bh=b91d4Sj/zOc1Uxp75EeHjQ7LhV7sLgUQXLlKeqKkWUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kRCOKJPYoXWImxAR5irj7Clj8Kvh3CWOdd6PImAWYa3CFDuymiOwXHPeAtGsfktua
	 z+F2UPfiLp45Um4B3mOfOcFPeahev9+K0fzS5ihAOq0d93bNVbsSDiHU981ZXcSbwZ
	 QcX7AeCh5PTu4nbFucW72OPaXMiWJJfsuaSJhC/nKgbOfzqInX404Lu4/ctGC+lPN4
	 /vNgggKoMznnyn9Q0D/XPEMbMbLCUuZ3Tyir8Rnd0Czc2ZwBPvZPmm9qhdWtJKHj9z
	 C+b6PDHpCdQUAFRpaZkC4Bp9Xhvi5HMDXihv0aakP8RRXtlHmj18GgxXCW7jRNGj6x
	 MJsQks5kmrmaQ==
Date: Tue, 2 Dec 2025 10:29:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, hare@suse.de, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v6 1/5] net/handshake: Store the key serial number on
 completion
Message-ID: <20251202102954.048fb6e5@kernel.org>
In-Reply-To: <20251202013429.1199659-2-alistair.francis@wdc.com>
References: <20251202013429.1199659-1-alistair.francis@wdc.com>
	<20251202013429.1199659-2-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Dec 2025 11:34:25 +1000 alistair23@gmail.com wrote:
>  net/handshake/genl.c                       |  5 +++--
>  net/handshake/tlshd.c                      | 15 +++++++++++++--

We don't process -next patches during the merge window in networking.
If someone thinks this is urgent do what you gotta do, otherwise please
repost this once merge window is over.

