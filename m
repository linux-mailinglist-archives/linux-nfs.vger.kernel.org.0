Return-Path: <linux-nfs+bounces-17621-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF71D04527
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 17:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE95A309121A
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 16:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A8A2BB1D;
	Thu,  8 Jan 2026 16:15:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6C026B777
	for <linux-nfs@vger.kernel.org>; Thu,  8 Jan 2026 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888904; cv=none; b=dlk0Rx2TQo2HOMmCpvj/W+Xk6T4jY8guaSkLl4c2P8ia2qHF27Cf26vCkJFGa5kArnAV+gZsYZu/Lo2RKO+FysQNwsTzH6/ytiTYsgsJqufUOSYyARiiJdt4+Ko2T/SoO9uGl+Bmpn8OHt8hNvdl97EThIzo+QZxnYqw1C+9p9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888904; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YB40b9b4dltl48+uGkf+jGRKZlk6fC/KZZ+zTgDZklp52FJ3W8PEY0NLwlJkPfSL7EnlR4Xntxia4y2ZbKUK7SJCXZ2WsYaD8oEZ5wWdjN9ChTv9g4P+Y/OezX/pEVXW15RtgmSDKhGdOwkpNLjXpZ8Zp2Of+YvhVydNubefXh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 718D867373; Thu,  8 Jan 2026 17:14:59 +0100 (CET)
Date: Thu, 8 Jan 2026 17:14:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v6] NFSD: Track SCSI Persistent Registration Fencing
 per Client with xarray
Message-ID: <20260108161459.GA10979@lst.de>
References: <20260108144421.3955020-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108144421.3955020-1-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


