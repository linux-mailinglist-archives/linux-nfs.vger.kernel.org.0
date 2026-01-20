Return-Path: <linux-nfs+bounces-18151-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD66D3C047
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 08:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7B6A404195
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 07:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6496E3803D1;
	Tue, 20 Jan 2026 07:07:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965B389E07
	for <linux-nfs@vger.kernel.org>; Tue, 20 Jan 2026 07:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892859; cv=none; b=slmZDdvz6S+aKak6U+KfLip56tBmQgkoJbACQzpcksgd2z4sbWviZMbeNOdkWALWeweoUzB7GIIXGGLUP9XQ1ml26vMkBwAGOpx2T26dc4Y2+gkDUpOGDFGmklNCOcBLlou+I0wEjYYEHnUksqBpUhdi3xJbZP2ojTQZkOWcSYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892859; c=relaxed/simple;
	bh=/xWsbB+2U9XOBsHt9jvYTa2iZa0efPYuhvHAgEudLLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRXU7JH5X2DeQXbXd4WDhwCbgn1wxkr704TRdxToPLyLV7ixKeOI8UsfhXnQdWC8fVYVEaqWmpOVyNbRnooGE3mEQn9+B0YSUpZIq6Agoox/f8vyHsWBS4kLIDJW0LdxkUHQnxzGfWG6YTjyAwk4RiWeXdI9JtlmNmfdcK7oruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 94DC0227AAF; Tue, 20 Jan 2026 08:07:26 +0100 (CET)
Date: Tue, 20 Jan 2026 08:07:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v7] NFSD: Track SCSI Persistent Registration Fencing
 per Client with xarray
Message-ID: <20260120070725.GA5001@lst.de>
References: <20260119154126.121360-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119154126.121360-1-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

This looks good, or rather much better than before, thanks!


