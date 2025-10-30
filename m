Return-Path: <linux-nfs+bounces-15795-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A9AC20920
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 15:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33E964ECE20
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 14:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B1C2528FD;
	Thu, 30 Oct 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mNgymogr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F11B155333
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834004; cv=none; b=YCXiJabcp8/r2CxYS+krsviMB8yKNKII4BQttqE4Nvf+nqgDbxcoycq4RyEXDFSTUoHMZzs3XLSTwYC47h5yuWeeTEx1A7t3ZzD/ljmOHDWwSCKG7Km3JOfWvZET+k+AaOhPDtOPIxTZnnC9UQZ7M/30NfzG9OSd1dpLYOBG+A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834004; c=relaxed/simple;
	bh=qwV1RgI9tKoklEK1sHAnrj2rBcMdPpHCvORgg1HPnfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozM5BOOGpUCgBM9EHgOzje8DHea8xMNVm7X4Sol6JovyhNyLT0GHNdkA4rblabJV0V+NJOhty8L6Xya7/cDMsNSd02oyK97KD4ou1JJp3JtAliFSq7CPjjTWNhJUgWmHxTsMLFZMIpJ8DSQMKz39HhNI6HbLhCrVFQ32wHs6Uv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mNgymogr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Rh1Vw8b1EEQgjFtCxyZte6ZUcQD1gvysAqkXO104GP0=; b=mNgymogrAMX2n7gQVOkIk8cLSA
	vdYkuncvTzH4s9UFv7QVVEhmu+Lzwr1bXxl9xmRJDMDeYftyggBj7k2vyQSMLjVi/nLOz26fBQB81
	xDRqUNOcqXLuTq9zedGL2CHhmbfiH1QMtYccfT0MiDf3tz9YGFR0cROPwn1Qe/EtPIznX5n1ferFe
	YH/yB9y7S4jNPUSDbultKH+CwhGPg9B77z/6s2dhifRU5zr8gOY8tlM/iHiGrEea1XwVntbmhJNLr
	AufKwkv/YsqeSCgxOWOZU5rG091+/GSXqSF2KqhQP5bJs4xOv9XIfrpl2KgwmbOfPsdhfarMEfmHS
	rY9PbeAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vETVS-00000004IBl-0xrq;
	Thu, 30 Oct 2025 14:20:02 +0000
Date: Thu, 30 Oct 2025 07:20:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH] NFSD: Add a "file_sync" export option
Message-ID: <aQN0Er33HIVmhBWh@infradead.org>
References: <20251030125638.128306-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030125638.128306-1-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 30, 2025 at 08:56:38AM -0400, Chuck Lever wrote:
>    Either the underlying persistent storage is faster than most any
>    network fabric (eg, NVMe); or the network connection to the
>    client is very high latency (eg, a WAN link).

NVMe really is an interface and not a description of performance
characteristics.  Nevertheless none of the NVMe implementations I
know have lower roundtrip latency than modern local networks.

> This patch is a year old, so won't apply to current kernels. But
> the idea is similar to Mike's suggestion that NFSD_IO_DIRECT
> should promote all NFS WRITEs to durable writes, but is much
> simpler in execution. Any interest in revisiting this approach?

This is a much better approach than overloading direct I/O with
these semantics.  I'd still love to see actual use cases for which
we see benefits before merging it.

