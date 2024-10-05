Return-Path: <linux-nfs+bounces-6881-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA6699179A
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 17:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422D21C20F6F
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF841531F9;
	Sat,  5 Oct 2024 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElYXOfgr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B6114884C;
	Sat,  5 Oct 2024 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728140929; cv=none; b=j4T/QtdxAkYCX3XgziyFzXne3zzh/Bc88pxYDFdLE32tQ56Hmo/QQT/XWgdmH+fKjTZrO2Fqyk2S4MZfvgCBTH3yTTSvkdqoQBWP1ywrTAAS2MHI6O3nKAY4IXLhfawZg+wTeDshZ0tSIi6AznK9c9uT3P55H7lPX7mLDU7IOdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728140929; c=relaxed/simple;
	bh=E4uQ+8xg2fDuhvDY1lNy61I2IQNsZqy83YAmr7/dcVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHXsPtF9kmvGDFisKU44VeKv88R8i+xjqwqA/9XejndRLTb6e8LGJI2KNcrvn5cee2QdFB0nm5D0ILDc6YImeuKr4/w3qE0GYZxs9QUmMtqXEPTZheBk0BurFjGSWILiWCxv2m3t7dyyRU7H+qmbfaIKwvD7TMSKLRgeaOn0kvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElYXOfgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA21C4CEC2;
	Sat,  5 Oct 2024 15:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728140929;
	bh=E4uQ+8xg2fDuhvDY1lNy61I2IQNsZqy83YAmr7/dcVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElYXOfgrBteuBWDwnDaCEY2S8LyYSb1J0xBYkyaFe0PKqCW5X+Y7nE+fJF8KIS4FI
	 NGrGrhHYEfvMNFoE9ujJnQVKT0Nc9Ojbpd3ud+o2LMzyeJY+lbNJ0sf5J6oAQivtjU
	 1B5MPaVURKBeT/7y2rSbaOoutJzrqJ6bEJctHAYwFrNQhApVSbMaEHm7xVUNHOMSmp
	 ZYX3Mws0WTTmS3tzhJGWF6hZFKfJQU+74ApoXkt+bofljheTmQ2mflrSl9RgzNJiRn
	 vuGUm/9H2P+EG7q9DPi1wVmI9RdUJ1G/+ttZ250zdLhLoUWivd3Aa1YfDFPpdF9zc+
	 uuxh2a4Y7Z2jA==
Received: by pali.im (Postfix)
	id 2447D648; Sat,  5 Oct 2024 17:08:43 +0200 (CEST)
Date: Sat, 5 Oct 2024 17:08:43 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Add support for mapping sticky bit into NFS4 ACL
Message-ID: <20241005150843.4ac6nugo7yusz2m6@pali>
References: <20240912221523.23648-1-pali@kernel.org>
 <Zumizr3WnA+XY9ge@tissot.1015granger.net>
 <20240917161050.6g2zpzjqkroddi22@pali>
 <Zu3K34MHFUYNaRfu@tissot.1015granger.net>
 <20240920192941.l2fomgmdfpwq7x6p@pali>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920192941.l2fomgmdfpwq7x6p@pali>
User-Agent: NeoMutt/20180716

Hello Chuck, have you done more research on this as mentioned?

I think that this is really useful for non-POSIX clients as NFS4 ACLs
are not-POSIX; knfsd is already translating POSIX ACLs to non-POSIX
NFS4 ACLs, and this is just an improvement to covert also the
POSIX-sticky-bit in non-POSIX NFS4 ACL.

Also another improvement is that this change allows to modify all parts
of POSIX access mode (sticky bit, base mode permissions r/w/x and POSIX
ACL) via NFS4 ACL structure. So non-POSIX NFS4 client would be able to
add or remove directory sticky bit via NFS4 ACL editor.

Of course, nothing from this is required by RFC8881 specification, but
specification also does not disallow this for NFS4 servers. It is
improvement for non-POSIX clients. POSIX clients would of course not use
it.

