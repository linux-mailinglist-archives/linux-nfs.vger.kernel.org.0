Return-Path: <linux-nfs+bounces-8290-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE909DFCCC
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 10:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D462C281CEA
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 09:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA381FA153;
	Mon,  2 Dec 2024 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AtzZBQ/g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1E61D6DB5;
	Mon,  2 Dec 2024 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130551; cv=none; b=qrpLNK/LkUHdpzQeThoJN1TBDNlT70FE4D3E5SRE7ry55nGY5toVIlwmI8+dONhfo+NeuNsX1ynt9wlUU0Ow4bTTmxLpkbH5gtXdJVZTEuxy2D1C5T43w2EoXMOsu4p5Ov1mYWjeFttKMchF/ml5crldEHorxR/Z2hQHwwZhUVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130551; c=relaxed/simple;
	bh=OZqJuMJT2ta/OAJim7jJwToykr9kDXzIF7lzetZwk8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtbdw43fGy84vzaB9MV1KHoeyuQCg7N69jscO3wb3jyqTKMX9EH4/tsZpj7HWeLsYsXjDpMCwc+mLdnR2rQT6BDYyK1z8vVN6WI1wQD2x6Q/wB0tY1B137tVIOqF6/M93NrvFXQ4m7y55qZUhDAi4MsjH5+GD0VPxVBOyF4AqSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AtzZBQ/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E355DC4CED2;
	Mon,  2 Dec 2024 09:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733130551;
	bh=OZqJuMJT2ta/OAJim7jJwToykr9kDXzIF7lzetZwk8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AtzZBQ/g+iJlnPf4FKy0VQrm2sdjGOqXmAC7+JQWBShT3yW+cLQK90hmQ3c1h/AHk
	 l6d8giwL6zm6yxr4jqDMM2wcV7CIt1DwIUi4VD2seKETIrcvtVwKyUQRN95FZYmL+N
	 QbGcCwhwFXY6D0lLeShPYI2GadqVRNhGMjLfOz3s=
Date: Mon, 2 Dec 2024 10:09:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: cel@kernel.org
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 5.4] NFSD: Force all NFSv4.2 COPY requests to be
 synchronous
Message-ID: <2024120226-unearned-ragged-ab69@gregkh>
References: <20241120191315.6907-1-cel@kernel.org>
 <20241120191315.6907-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120191315.6907-2-cel@kernel.org>

On Wed, Nov 20, 2024 at 02:13:15PM -0500, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> [ Upstream commit 8d915bbf39266bb66082c1e4980e123883f19830 ]

What about kernel versions greater than 5.4?  Like 5.10, 5.15, 6.1, and
6.6 for this change?  Shouldn't it also be needed there?

thanks,

greg k-h

