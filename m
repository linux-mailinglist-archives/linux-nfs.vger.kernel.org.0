Return-Path: <linux-nfs+bounces-15182-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 568CFBD35C0
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 16:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AFA84E3BC7
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 14:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6656F25782D;
	Mon, 13 Oct 2025 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjFswW5i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FB82550AD;
	Mon, 13 Oct 2025 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364692; cv=none; b=ixJOSoGpcJRiZCvodKIITg2EsQS8z1wdKvdTGWXf9Wq0WrzWp1DxtjD0uKfnhd0jkAADxoMS8wN2FTpzgqV7eMrSnJFMnOLhgbEgU6L4eLKpLy1Ha5UTmXIo7WXmXUiFLD7M3VPhS61wJKWmB4IuSt1zwKuOVxKg4cBl4ZG4CXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364692; c=relaxed/simple;
	bh=nxQ28tCoDAYVRM2u6jhum88s35Y1NEBWirMRCb2KdBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIsMfJjtuA5Dos85gk/EscZyvc6kjJDoEQh0qrUfbieUofOMj31/KiOw9VcgzAJkVLvwOWkk5RKQ5sXiPv+IwjZirWM2rOmTjDG0j6svzJtnlLIEfLpngCm3p0xUE8sF2XPeNgZQupP5KjDJTxhNm7hoo4492XFt18A9V5sSrto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjFswW5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C356BC4CEE7;
	Mon, 13 Oct 2025 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760364692;
	bh=nxQ28tCoDAYVRM2u6jhum88s35Y1NEBWirMRCb2KdBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gjFswW5iWMuaXuXNZSwepvx/Tw05c2TF+RzCLdKG+l2r+f6NIgeS2+0Oq7wYZseYL
	 2hQW0KFTo4yftt6kVXXDzCSD3FuiyaSo/A52seiWVp0dCV9dLOHFAmiTP++k7QNoXr
	 mQSmyXSZbeh2E6RgAIrLEsBl4PXcqJgpFMnKmLqR+LcyXmDqcV0qeWu/LspgR+EeZa
	 LVI4HReEGGNJVpZlGi5clsFqQbaUfZynZm33G58s8oCiAq1THwWniLjiy/+bEGXW10
	 0llZ76JDjUcwmk6t4bAO72LbVJfE+yrvraylezYdQZdZUTJ4jvr2OANMT1jWW676k0
	 fCbkTvaNAKXLw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Brandon Adams <brandona@meta.com>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] sunrpc: allocate a separate bvec array for socket sends
Date: Mon, 13 Oct 2025 10:11:27 -0400
Message-ID: <176036467863.12780.18195275495464376664.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013-rq_bvec-v7-1-c032241efd89@kernel.org>
References: <20251013-rq_bvec-v7-1-c032241efd89@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 13 Oct 2025 09:54:53 -0400, Jeff Layton wrote:
> svc_tcp_sendmsg() calls xdr_buf_to_bvec() with the second slot of
> rq_bvec as the start, but doesn't reduce the array length by one, which
> could lead to an array overrun. Also, rq_bvec is always rq_maxpages in
> length, which can be too short in some cases, since the TCP record
> marker consumes a slot.
> 
> Fix both problems by adding a separate bvec array to the svc_sock that
> is specifically for sending. For TCP, make this array one slot longer
> than rq_maxpages, to account for the record marker. For UDP, only
> allocate as large an array as we need since it's limited to 64k of
> payload.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] sunrpc: allocate a separate bvec array for socket sends
      commit: fcf522297252d21db162e141d49b2bb4f1c2b0c4

--
Chuck Lever <chuck.lever@oracle.com>

