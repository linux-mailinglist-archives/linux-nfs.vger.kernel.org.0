Return-Path: <linux-nfs+bounces-5419-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD179552FD
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2024 00:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E404284383
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 22:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E5513D51B;
	Fri, 16 Aug 2024 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PbbBwFHg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23EF12BF25;
	Fri, 16 Aug 2024 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845697; cv=none; b=kLscyCHBjz8mZprLtRqRRLO1vz/zqGIo2w8MSU0USeq1bCZFxDNEUY+HcQh/5ndSl13wYMhVEd/YkS2GUSV1gG7AFRmwi++DYHnnvEn/PontI5cAb+39NDtJy1dK7UTGdU/tbCaA/AUlsoAW91LwZ+g91YqeqBblnbic4/fgLI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845697; c=relaxed/simple;
	bh=0HzA09g6sncaVFLN1ygOc655jpNPyx52cqfYOEjeFVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0xpc6x8EaInp0HJxJFmVnAR98i2UjOGIBm3EMZj5xvn4Kpz4HdCnpxHUCQfIcAbKdFoUexwN1X2yTpYFGN3npc1JyUzosi+I0PDo7W+V6FFdmFC1KqMJkqLl27S71/CF/1cYmKaSy9gIBSbLU1BjxECftXa4VHm40bGGRXR7I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PbbBwFHg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=BkwwjSarLNtVM9B4pKtnQmkM8GKaYSD8cPtcvq8Zki4=; b=Pb
	bBwFHgYCKHqAX6mRwOHPTGJWps+Cn82FX5I/w8cmN0nRLtej1YdfWw2fksk7lFBPS7kf8SJxTafTZ
	4cVUOPXB1bgxktKIA/lytLcqP/AJW73ovbLviDeh+3HwUCVlWuNqgebqRoe1Xkg+CqmXupx8i8rle
	arm2wRhyMSCFCwk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sf50J-004y4d-Nv; Sat, 17 Aug 2024 00:01:03 +0200
Date: Sat, 17 Aug 2024 00:01:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: kunwu.chan@linux.dev
Cc: trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com,
	jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
	Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] SUNRPC: Fix -Wformat-truncation warning
Message-ID: <a957b7bb-e5c2-480f-8f5c-2fa40637d8ba@lunn.ch>
References: <20240814093853.48657-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814093853.48657-1-kunwu.chan@linux.dev>

On Wed, Aug 14, 2024 at 05:38:53PM +0800, kunwu.chan@linux.dev wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
> 
> Increase size of the servername array to avoid truncated output warning.
> 
> net/sunrpc/clnt.c:582:75: error：‘%s’ directive output may be truncated
> writing up to 107 bytes into a region of size 48
> [-Werror=format-truncation=]
>   582 |                   snprintf(servername, sizeof(servername), "%s",
>       |                                                             ^~
> 
> net/sunrpc/clnt.c:582:33: note:‘snprintf’ output
> between 1 and 108 bytes into a destination of size 48
>   582 |                     snprintf(servername, sizeof(servername), "%s",
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   583 |                                          sun->sun_path);

I think this has come up before, but i could be mis-remembering.
Please could you do a search for the discussion. The fact it is not
solved suggests to me it is not so simple to fix. Maybe there is some
protocol implications here.

       Andrew

