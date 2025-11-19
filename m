Return-Path: <linux-nfs+bounces-16555-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8403DC6F9F4
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 16:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 928FC2E25B
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 15:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F41E29D26D;
	Wed, 19 Nov 2025 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4l76oOa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6226129A32D;
	Wed, 19 Nov 2025 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763565697; cv=none; b=lV+i8xYQwdd7kE4U7Pa1zL+MpU1lm113dDC4UGBIVgpc1nLgapdSAjW5W/TMFCTdpnSc3cFj0JcPCgRUEynirm1WsAXow0vJYJqe6UxNe4/8qrqj1ie/UOedMMSj3+JlwUZuUONQ0ffgB/XAq02vbONEi71slEn1kTBpvsTO67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763565697; c=relaxed/simple;
	bh=3+NqSm1P7TykuAZsliBKZbOhIlbyqfnwK+XVCQ5wHUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLBWo78PvUi19AEbg0m9wMNeO2e1Ds/ks5jQOzIegE/g5QorMNsuzhgNcrh/2NdwKiKQgLPBiY8F3aasyCvw1ypgPVfnS2YsbhTi+Zgb9zf0Xfc0psM8RzsKLOIS1UhlHMWgbLnVsXbz0B4Xujc2zPZnNwYvJZTnsYGu5BOT1iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4l76oOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB93EC4CEF5;
	Wed, 19 Nov 2025 15:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763565696;
	bh=3+NqSm1P7TykuAZsliBKZbOhIlbyqfnwK+XVCQ5wHUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4l76oOafcM8SQPXk0Ck907CLBSlyyXaRLBPvPgltv3HGXqsWPQ6UA+hQbQhTUTXs
	 bRBlFdq7IFtsRczk00AYsGy9zUlpP8subXEpOHfcTRI4d9vCzIRpxQt4xN9P8y0Pnx
	 v0mHbOroEQ1b3Lrc9WLj3xhxgW47+MqJxD7+8w3w5uC3PYS6u8dlsBM3guLOjVIRtm
	 JNkIy4LkbU6UJwu1/3cKqxizeClkxlUps0rqzhXpbcXGdTZbnUTLNKLV1KQOQ/l2K5
	 PUtzoRpRi2auuo6ZsbjromNeqcswbHPAeCzsr3cYR4HDzhERIyxIzP8Y1focqqvlO5
	 fvUi8lFVcERyQ==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	Khushal Chitturi <kc9282016@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xdrgen: improve error reporting for invalid void declarations
Date: Wed, 19 Nov 2025 10:21:31 -0500
Message-ID: <176356568185.9271.3824647645038642441.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118195258.6497-1-kc9282016@gmail.com>
References: <20251118195258.6497-1-kc9282016@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 19 Nov 2025 01:22:58 +0530, Khushal Chitturi wrote:
> RFC 4506 defines void as a zero-length type that may appear only as
> union arms or as program argument/result types. It cannot be declared
> with an identifier, so constructs like "typedef void temp;" are not
> valid XDR.
> 
> Previously, xdrgen raised a NotImplementedError when it encountered a
> void declaration in a typedef. Which was misleading, as the problem is an
> invalid RPC specification rather than missing functionality in xdrgen.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] xdrgen: improve error reporting for invalid void declarations
      commit: d0e9690abe3cd818dcf2c9ea5c04f79221789429

--
Chuck Lever


