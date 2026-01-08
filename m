Return-Path: <linux-nfs+bounces-17596-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF478D043A8
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 17:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDF1E322158A
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3660356A3E;
	Thu,  8 Jan 2026 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="5AXtnIcc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E1D356A0A
	for <linux-nfs@vger.kernel.org>; Thu,  8 Jan 2026 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864243; cv=none; b=iJ54TgFvKj82notQl/yuds51JIiAxJHK8B7qPvyx8UKxyI2iZCt2MP3gIhWMy5N8KJHdRVx2OFy5frX1UKoCT//E/HV3PbDnTAwz72g0Lzip5wSLvRdRrGUIDo+yBC+piP8mv6nGr+SDISmCHDsUgSWSTj7GvHh17RWE2hmIH5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864243; c=relaxed/simple;
	bh=N1DbcXVoCSOfDiRDdxwq/LUPeYJLYtd9Q9oy61R9tD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgXlE2C+mNijG+NfRdU2cgvFJMIegq3elTMKwll/pJNoOLacSa3NW0bykILak7q5WVRPgaKw7QGeiulX+m9dsJB53PbQP1m7id4e8uAWvmt1epADaBt5nAL5Y9DdgpNDeqIlasRlS3hgPiXcBqD+QiKFDFo2eoAtyXkKE52ThDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=5AXtnIcc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=VxH6mUAeWsmiP1kru/VpJ9UMRDoniw5pqc3eLXlwxis=; b=5AXtnIccDs9Vws/QgK2XBpBW1o
	qHZS6ywIyhlVrDryxDDZ9ZzsD/RSbqgmdwJpbOF6ic8yoax3YxsSOnLnEUfOn87/OG1u30fxjn5Re
	J6FGx6Z0sSOr0ha1s09ZIFXBBRRqYqJIqWkd6pgzFVLwdmkfso0uzKKIbBdM4Lx/WNbBskFK2MwpP
	4zEzx3q05WXuirRWuUEzjA3w7iuq3sHAfoldyeVkk6NuTAma7kODBHiloiwmOSaDnP6OjGaEnMIAQ
	jNJaz8975kzXjtaQKFjofH92v3HUmecGcS5BH+zaGG4NJDrtlclCsRybkZMs8gUq0sOBgQmG5EcHr
	0L9JTjig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdmFH-0000000GRVc-09iD;
	Thu, 08 Jan 2026 09:23:55 +0000
Date: Thu, 8 Jan 2026 01:23:55 -0800
From: "hch@infradead.ori" <hch@infradead.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: "hch@infradead.ori" <hch@infradead.org>,
	"anna@kernel.org" <anna@kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Fix directory delegation verifier checks
Message-ID: <aV93q3w00seoH5xC@infradead.org>
References: <20251219201344.380279-1-anna@kernel.org>
 <aUnHnlnDtwMJGP3u@infradead.org>
 <aUnq_d93Wo9e-oUD@infradead.org>
 <53d40f4781783f9b79196bb30975b788be8bb969.camel@hammerspace.com>
 <aVyp3SIddHB5sMhp@infradead.org>
 <1df4bb7ff3e6fd607c1811d75fcd6dcb860e320e.camel@kernel.org>
 <aV3ttYmT2vAtPDws@infradead.org>
 <d8ddd23a18985ae360855931f185d0e24c466310.camel@kernel.org>
 <aV58KBha24bpbLUf@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aV58KBha24bpbLUf@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 07, 2026 at 07:30:48AM -0800, hch@infradead.ori wrote:
> On Wed, Jan 07, 2026 at 10:07:55AM -0500, Trond Myklebust wrote:
> > Thanks for doing all this testing, Christoph. I really appreciate it.
> > The previous patch was incomplete. This is incremental to yesterday's
> > patch, but I'll squash them together in the testing branch, since
> > they're both about blocking state recovery in the non-regular file
> > case.
> 
> This fixes generic/633.  I've kicked off a full xfstests run and will
> report back.

xfstests survives without crashing.  However since 6.19-rc a bunch of
timestamp related tests keep faіling.


