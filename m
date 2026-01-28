Return-Path: <linux-nfs+bounces-18564-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAxPJ2T/eWm71QEAu9opvQ
	(envelope-from <linux-nfs+bounces-18564-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 13:21:56 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CB3A1245
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 13:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9687E30668B2
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 12:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEF42D9787;
	Wed, 28 Jan 2026 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1gnAvhm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE59A29992A;
	Wed, 28 Jan 2026 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769602743; cv=none; b=rKmM3t9yM7imyxysAz3geWuMx+YFWLkAWNsW+TE0o9O6STA2/c0mt1Lip+DV7z6oe3xM0lC92rDX9Jrst3bdsyGcpacPmEDGqBkV3QUEq4FCs7mqD9aWOngHqViHdBySqZZuiqis/EuPFXB5uACyaaGx96mNavq0OSrAyI9z0oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769602743; c=relaxed/simple;
	bh=IFWBxhKoTmPQ8RDTQi/dRri3f191zGwMNlxoXnHsDZ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=luMehvwf1tFft/ry/XrRrlr3NVVFH1WbqJ/S5KltXMcw1JWW0G1ECjkQdDw8gKOEnBKavWGWdM9Z1O2uNTCamyaiAxG3uJO2A7aXAwVKoEvswUpBL5cpFkqCRDP/Y1urcc08Tkx0sEJWBLHRQekJTFT3b36l0L/xCbCyRSjlpv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1gnAvhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7FEC16AAE;
	Wed, 28 Jan 2026 12:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769602742;
	bh=IFWBxhKoTmPQ8RDTQi/dRri3f191zGwMNlxoXnHsDZ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d1gnAvhmYC50gQ6rPNszcE7YN4PAKNESIjD43VXZdsGkbQVJ/8Zqz6fMKfk4DFIoG
	 RE0dSaKC89zEjkNS/0U+uRNZA4wmYUBHx5KuIWUafBS7pBCrroUgem/zQlPLDEb8aw
	 DFuMexeKXUj9DNeB5mWA7VyHLXaHX6c6QIuo9sEBLrc1djFf9Cxj7s3+wr/01yU17+
	 M3DpbSjGj+1/EyaBp2+WZGN137/l1QVYfa2TbT0ZBUfzZfnYERlu/0zef16eWCuRsz
	 yEwv+gqZ/IHMEYC8mvbfCkkwRifqxmO+6fNdR+XdOIJnIh5Ls6hDwCdlrxZcPORjIU
	 E4n4NNZ5Nc6vw==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20260128005400.25147-1-cel@kernel.org>
References: <20260128005400.25147-1-cel@kernel.org>
Subject: Re: [PATCH v5 0/5] Add a bio_vec based API to core/rw.c
Message-Id: <176960273949.35487.9902637864188191212.b4-ty@kernel.org>
Date: Wed, 28 Jan 2026 07:18:59 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18564-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4CB3A1245
X-Rspamd-Action: no action


On Tue, 27 Jan 2026 19:53:55 -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> This series introduces a bio_vec based API for RDMA read and write
> operations in the RDMA core, eliminating unnecessary scatterlist
> conversions for callers that already work with bvecs.
> 
> Current users of rdma_rw_ctx_init() must convert their native data
> structures into scatterlists. For subsystems like svcrdma that
> maintain data in bvec format, this conversion adds overhead both in
> CPU cycles and memory footprint. The new API accepts bvec arrays
> directly.
> 
> [...]

Applied, thanks!

[1/5] RDMA/core: add bio_vec based RDMA read/write API
      https://git.kernel.org/rdma/rdma/c/5e541553588d49
[2/5] RDMA/core: use IOVA-based DMA mapping for bvec RDMA operations
      https://git.kernel.org/rdma/rdma/c/853e892076ba56
[3/5] RDMA/core: add MR support for bvec-based RDMA operations
      https://git.kernel.org/rdma/rdma/c/bea28ac14cab25
[4/5] RDMA/core: add rdma_rw_max_sge() helper for SQ sizing
      https://git.kernel.org/rdma/rdma/c/afcae7d7b8a278
[5/5] svcrdma: use bvec-based RDMA read/write API
      https://git.kernel.org/rdma/rdma/c/5ee62b4a911375

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


