Return-Path: <linux-nfs+bounces-4115-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E41CB90FADA
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 03:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59F01C217FB
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 01:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFA2803;
	Thu, 20 Jun 2024 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JcKq7Qtu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3826101C8;
	Thu, 20 Jun 2024 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718846632; cv=none; b=cm2xsk9QLozFyuXwQYFWudgRBHTvxzrhX3RUA3OzDxSPgXYdooLymo0PTXqJb9UOmwq0UuZERANZBNeLcZRNHylfnS+a5TrkbK+oBi8WHgXQI2xfi3OO2y8DitJpuWlJVr7Fg/mvJi4ykIZK1PMei5iO4IOfXIr0vfA6/pg8zhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718846632; c=relaxed/simple;
	bh=I2+H9RSi53aNG43jfhOmbWXcdLE370Sdc8IQ93AUBhk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=i6z3Cs7MZ4WWbrbV0t4CRT/4fSCEvFzuSdpBdDiNzvMFHQGpZglqlzqqZy2WnLcY2X1JdCNgVYiWWUrVrqxz/BbQGF+qvlE8rGtDgcZBQQvb3LKn9Lt43eKBAMpJUSkiNQrqi9BInRAUubU6cdXNWGmpU8aFTLOSqcNBgm2/ATM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JcKq7Qtu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6E1C2BBFC;
	Thu, 20 Jun 2024 01:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718846632;
	bh=I2+H9RSi53aNG43jfhOmbWXcdLE370Sdc8IQ93AUBhk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JcKq7Qtu3bV2PLRwqibK8oOy9arbeMc5+LKGL1FWktuN4ZbTOFrN0xn8uizpU1+Ma
	 u2yFb36Q/KDd3jMktC5TCBGrfp7ZmOi2t39uLiH/ERqjShI4PDvUytkQS9P5cU03lH
	 zNgmZXwnGFpPJeFGMQywI75k0bAB4wet+tHK4/jY=
Date: Wed, 19 Jun 2024 18:23:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Steve French <smfrench@gmail.com>, linux-cifs@vger.kernel.org,
 linux-mm@kvack.org, sfrench@samba.org, anna@kernel.org, chrisl@kernel.org,
 hanchuanhua@oppo.com, hch@lst.de, jlayton@kernel.org,
 linux-nfs@vger.kernel.org, neilb@suse.de, ryan.roberts@arm.com,
 stable@vger.kernel.org, trondmy@kernel.org, v-songbaohua@oppo.com,
 ying.huang@intel.com, Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg
 <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom
 Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>
Subject: Re: [PATCH v2] cifs: drop the incorrect assertion in cifs_swap_rw()
Message-Id: <20240619182350.f4969d6dbb8549d309a5ae92@linux-foundation.org>
In-Reply-To: <CAGsJ_4x9A5jHPOPiPhsznsCBnj_T-XRk8YNs86i11P9rmrPG1w@mail.gmail.com>
References: <20240618072258.33128-1-21cnbao@gmail.com>
	<CAH2r5mtRHf3bQh=aeVddFykMX_MokqujMyLn3W-4wXo1MO5=iw@mail.gmail.com>
	<CAGsJ_4x9A5jHPOPiPhsznsCBnj_T-XRk8YNs86i11P9rmrPG1w@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 19 Jun 2024 16:44:15 +1200 Barry Song <21cnbao@gmail.com> wrote:

> On Wed, Jun 19, 2024 at 3:48 PM Steve French <smfrench@gmail.com> wrote:
> >
> > tentatively merged into cifs-2.6.git for-next pending testing and any additional review
> 
> Steve, Thanks! I guess you missed an email from mm-commits.
> 
> A couple of hours ago, this was pulled into mm-hotfixes-unstable, likely
> for the same purpose. Will this cause any conflicts when both changes hit
> linux-next?
> 
> https://lore.kernel.org/mm-commits/20240618195943.EC07BC3277B@smtp.kernel.org/
> 
> Will we just keep one?

Either is OK, but I suggest a 6.10-rcX merge while retaining the cc:stable.

