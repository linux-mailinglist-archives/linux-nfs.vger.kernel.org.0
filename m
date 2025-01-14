Return-Path: <linux-nfs+bounces-9209-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6691A112B8
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 22:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D3727A1561
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 21:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1421C5D4B;
	Tue, 14 Jan 2025 21:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9cFdqpK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270B8493
	for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2025 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736888963; cv=none; b=Jt+w8UBKWPIsnjq15og5YTMVBNC6a1/K546uY50JQ2/Ly54jFoGXHf9GIbuufyNf/EGODpb/BLMmpajoip38JVeykQVZUVMKuwx1x9YGClnKoAKblePW4UmHfoGMwMMMCdnqQXVePY1McwD8P7HBzogRVPCSVyEHt7xpWVZ/wvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736888963; c=relaxed/simple;
	bh=IAXU8PbBvnneFrmKVzO9TGmdlDylAwxwZcHQFcdTcUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVyj8LlEMDsfuputCN5ewqvOHHC+310MITt2Sh+86B+yhlLvP89OEix1NurPxit2RWNND60xfq86N9RvXZE1H7Ew/wZBgNgdVl1j9JEu+VNz46/Mjz3E+zirIOscuyJ9kN4R/ZnIh+V0KV6MKuYeBkYWjjmPFB1QYmItFG//oUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9cFdqpK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736888958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UVLqEteIhNv8N38qOWlRaSwpueL6D7hYp+uEtC4Atpg=;
	b=a9cFdqpKfjBspBIpybg7q0AttS6mp1sBz6h0GS2i+7DMehN//wjHXmH5n911u3iu72ddU5
	x84XoDfpckV3oic4skKJrG1xjcwwdNczjvy8rwGY48yX55HcGRC7kf/CXxJy/lMQBvs1pV
	CZ57qOjxQEtsw1z/hWj8btaarxF8Yvw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-foA5MAlQOaWeanoDkUTvbg-1; Tue,
 14 Jan 2025 16:09:15 -0500
X-MC-Unique: foA5MAlQOaWeanoDkUTvbg-1
X-Mimecast-MFC-AGG-ID: foA5MAlQOaWeanoDkUTvbg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B4F2193E889;
	Tue, 14 Jan 2025 21:09:07 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.152])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DF9730001BE;
	Tue, 14 Jan 2025 21:09:07 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id CE67D2EAA44; Tue, 14 Jan 2025 16:09:05 -0500 (EST)
Date: Tue, 14 Jan 2025 16:09:05 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Steve Dickson <steved@redhat.com>, Yongcheng Yang <yoyang@redhat.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] nfsdctl: add support for new lockd configuration
 interface
Message-ID: <Z4bScYOgDwbpyXjt@aion>
References: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, 10 Jan 2025, Jeff Layton wrote:

> v2 is just a small update to fix the problems that Scott spotted.
> 
> This patch series adds support for the new lockd configuration interface
> that should fix this RH bug:
> 
>     https://issues.redhat.com/browse/RHEL-71698
> 
> There are some other improvements here too, notably a switch to xlog.
> Only lightly tested, but seems to do the right thing.
> 
> Port handling with lockd still needs more work. Currently that is
> usually configured by rpc.statd. I think we need to convert it to
> use netlink to configure the ports as well, when it's able.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I think the read_nfsd_conf call should be moved out of autostart_func
and into main (right before the command-line options are parsed).  Right
now if you enable debugging in nfs.conf, you get the "configuring
listeners" and "nfsdctl exiting" messages, but not the "nfsdctl started"
message.  It's not a big deal though and could be done if additional
debug logging is added in the future.

Reviewed-by: Scott Mayhew <smayhew@redhat.com>

> ---
> Changes in v2:
> - properly regenerate manpages
> - fix up bogus merge conflict
> - add D_GENERAL xlog messages when nfsdctl starts and exits
> - Link to v1: https://lore.kernel.org/r/20250109-lockd-nl-v1-0-108548ab0b6b@kernel.org
> 
> ---
> Jeff Layton (3):
>       nfsdctl: convert to xlog()
>       nfsdctl: fix the --version option
>       nfsdctl: add necessary bits to configure lockd
> 
>  configure.ac                  |   4 +
>  utils/nfsdctl/lockd_netlink.h |  29 ++++
>  utils/nfsdctl/nfsdctl.8       |  15 +-
>  utils/nfsdctl/nfsdctl.adoc    |   8 +
>  utils/nfsdctl/nfsdctl.c       | 331 ++++++++++++++++++++++++++++++++++--------
>  5 files changed, 321 insertions(+), 66 deletions(-)
> ---
> base-commit: 65f4cc3a6ce1472ee4092c4bbf4b19beb0a8217b
> change-id: 20250109-lockd-nl-6272fa9e8a5d
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 


