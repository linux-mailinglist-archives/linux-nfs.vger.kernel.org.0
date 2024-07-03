Return-Path: <linux-nfs+bounces-4580-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D88D92520F
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 06:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BF81F26F33
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 04:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF8E5B1E8;
	Wed,  3 Jul 2024 04:20:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A0F4965D
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 04:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719980417; cv=none; b=f0Dutu004fiFFRZXJX/4yeL+3CMkpfFWrzy0C+FxqSJ0ohrnG0GSC88Ililx6dnHWSRJMbH8ny9RV8NdWm2dGJzBM7LoqFr/osDl5/9SJnPM9LhkHRvd3qXvFJ7UQGDgAWEsdwaHSR0K5HDRPP/3YEltyepWzPOGFBTFMHX+tlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719980417; c=relaxed/simple;
	bh=m5wRI2gUyO4G2dDhxWhZ+C65ydxw11ONnojVHS3OmsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZC/8d2GcSgumaZ2qjh49lVccCL/bbX7hGPw/J1eRy6KEGKFH81/J9lDGWtmAhPG+Ji7q3UAqxVeBxKt9ysXRFDgQv18a7nHKPTzITtRrRMC/J7Ahjwycqxm6HP+u1gkvBop8k68GQXV3a4me7NZL+wIoqSbWVTr0btVIRViQDZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 97EF1227A87; Wed,  3 Jul 2024 06:20:12 +0200 (CEST)
Date: Wed, 3 Jul 2024 06:20:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 4/7] nfs: fold nfs_folio_find_and_lock_request into
 nfs_lock_and_join_requests
Message-ID: <20240703042012.GB24050@lst.de>
References: <20240701052707.1246254-1-hch@lst.de> <20240701052707.1246254-5-hch@lst.de> <60f735e9-b1c9-499e-9282-5172643f19ae@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f735e9-b1c9-499e-9282-5172643f19ae@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 02, 2024 at 10:57:36AM +0300, Sagi Grimberg wrote:
>> +	nfs_init_cinfo_from_inode(&cinfo, inode);
>
> Any reason why nfs_init_cinfo_from_inode() changed location?

I moved it early enough toward where it is being used to better reason
about the code.  But as a nice little advantage that also means it is
only called when actually needed now.


