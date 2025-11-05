Return-Path: <linux-nfs+bounces-16046-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6F2C35CE8
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 14:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3B4D4E4AF1
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 13:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4F92BEC42;
	Wed,  5 Nov 2025 13:21:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF7731C56A
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348903; cv=none; b=pzZqmU/pTqTsOMEduylVmWHuLy0F4IrguyJ1VX8jjNd21+jcvqVMDo6UBDWFXzME2hyYZD2kwdpuNq9xduOMx2u5J+ExXMIv9AQPncIUb0o6oS3QPqbEly9E9EqVgjg1vDPMq6AhBWKPvz+PdbyVbNu8I/eHUlZeJ0sXQWGpEa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348903; c=relaxed/simple;
	bh=IzJ1TmLrqOVNucWqWsOFR5wiuIJEHUBywVhcf6NOATM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsF+6YxFIjeE2HINgd2+FfwRxBAsscZwv6+py38h/A03AQMp5pvVDzRt/a8fQl7zlzUy8VsqLZaXVNQlr4SBofAYsAErr5v3i9NItqhWnDIfIgK/awKEOjvNxtGU+4dylJtCym61huwM0x2mvfaAKFxFvgmJngOTUZ+lGGuKWL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B8327227AAA; Wed,  5 Nov 2025 14:21:37 +0100 (CET)
Date: Wed, 5 Nov 2025 14:21:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
	okorniev@redhat.com, tom@talpey.com, hch@lst.de,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] NFSD: Fix problem with nfsd4_scsi_fence_client
 using the wrong reservation type
Message-ID: <20251105132137.GA19612@lst.de>
References: <20251104173103.2893787-1-dai.ngo@oracle.com> <20251104173103.2893787-2-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104173103.2893787-2-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Maybe reword the title as:

NFSD: use correcvt reservation type in nfsd4_scsi_fence_client

The fact that it wasn't correct before pretty much implies that there
was a problem :)

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

