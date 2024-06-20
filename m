Return-Path: <linux-nfs+bounces-4120-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CCF90FC0D
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 06:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA3D284B07
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 04:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0E718EBF;
	Thu, 20 Jun 2024 04:52:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2667011CA1
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 04:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718859168; cv=none; b=W33Aly/V9s0/YkTeHCzN/qod+eXfoCZ0bj6WnBWwk2fd0vzs+LApAa5yTX6fdABty87mYCYX+qsKKW3zIQV0L5F8+np/o2BaYaKM4XAWPDAmwf6+hoFn1bltpuy1dPB9OTzfe3Jcigq9rlilZa4fTl8svTinR3AlhZclPD58ui0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718859168; c=relaxed/simple;
	bh=GaHm6Z/gVHW4wUE/5ZMWkWUjRpEVpJ6JBBI3Hu7Ewlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPlyq5v1VOYWkab/nW6KL3OurshHikFCOjWS2bmnabuIJVWBA5WqQxnMnPKGipM5iJLnU0eaJE4PHibgeFRx5nhHC0p8lZae8UWRkVOrXjJChuj6fHrCpWh4/aAjyjJgte5NPXdKjmY2rhoJS2jSKBjaGa6ddP2oXo5wnTY0nFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7FB2368BEB; Thu, 20 Jun 2024 06:52:43 +0200 (CEST)
Date: Thu, 20 Jun 2024 06:52:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 1/4] nfs/blocklayout: SCSI layout trace points for
 reservation key reg/unreg
Message-ID: <20240620045243.GD19613@lst.de>
References: <20240619173929.177818-6-cel@kernel.org> <20240619173929.177818-7-cel@kernel.org> <20240620045046.GC19613@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620045046.GC19613@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 20, 2024 at 06:50:46AM +0200, Christoph Hellwig wrote:
> This is weird.  The trace points for nfsd really should be in
> fs/nfsd/trace.h and not in fs/nfs/ as that would then pull in
> the client code into the server.

Sorry.  This is of course client code and I just did not have
enough coffee yet.

