Return-Path: <linux-nfs+bounces-10207-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B72A3DDF8
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 16:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8464319C47B6
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD841D54CF;
	Thu, 20 Feb 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vDhtkZkC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0A21D5CF5;
	Thu, 20 Feb 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064223; cv=none; b=e9Z9SZ6iK1zG9LYZC/vLZuSSpAZJWT4dCpxSfsWaP8eTbgREp2nOkLPRombLxKlOyRPtYzdXo7qaoi2Ib1BC2+BzGEwXXRndkPO2BtHr/x13TAGEAuNSlZVE2mYX7e6m3kb+ejv4F4W8R6vp/DDQG4+0VjBGVdHf92UJkkHpMpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064223; c=relaxed/simple;
	bh=sUDbrXGBYsw+XenGslrGS2PO/Lmr2+Q+DVVbF8cnyrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jK/ZLBXRJWaUitsNuNK3G4X1lKQyLfCPnqV/r+DSvNeDD4bNC7qCFRLsAn0tsRWnWJyd7dAW/1beZeQROrsNL+B5wQ/dyjA6PU2SNGXDNSLUPDOqXIeYcRWW+EAPTYkkRaTSZio/7Y2QiuMgkMBkkNCLVp9hTJhuWJ5Hue5WU7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vDhtkZkC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78BFC4CED1;
	Thu, 20 Feb 2025 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740064223;
	bh=sUDbrXGBYsw+XenGslrGS2PO/Lmr2+Q+DVVbF8cnyrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vDhtkZkCOEs4sBFWmws20R/QQgL4NenYuKAGJlJ9DWclITVNv0wRC6xg6Hb+v8FYv
	 aCypdQ0XaMJgMGi+3etgVF16cj4Mx6VT2hY23qEfaKfFawPyvjfrXFHm/83W/8KOrv
	 pU5FPyPl9+j+g8Xcrc90Xd+C2i7LFe7ZT+bGHjNM=
Date: Thu, 20 Feb 2025 16:10:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] fs/netfs/read_collect: add to next->prev_donated
Message-ID: <2025022005-doily-tiara-b2b9@gregkh>
References: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
 <20250210191118.3444416-1-max.kellermann@ionos.com>
 <3978045.1739537266@warthog.procyon.org.uk>
 <CAKPOu+8cD=HkoNYYknivDJnb6Pfxv+KF28SBUDEqha4NE5sxhg@mail.gmail.com>
 <2025022051-rockband-hydroxide-7471@gregkh>
 <CAKPOu+_WsE_HZ_u_sbP8aPnCXknU51fM9t_L-g+xmNVwWGDHVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+_WsE_HZ_u_sbP8aPnCXknU51fM9t_L-g+xmNVwWGDHVg@mail.gmail.com>

On Thu, Feb 20, 2025 at 04:00:49PM +0100, Max Kellermann wrote:
> On Thu, Feb 20, 2025 at 3:17 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > It wasn't sent to me or to the stable list, so how could have I seen it?
> 
> Oh, of course, I forgot to add stable. How shall we proceed? Do you
> want me to resend to you with David's Signed-off-by?

Please do, and cc: stable.

thanks,

greg k-h

