Return-Path: <linux-nfs+bounces-953-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E9D825133
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jan 2024 10:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6FB1F22C16
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jan 2024 09:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E3D249F3;
	Fri,  5 Jan 2024 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xwOOP7fu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92CB241F1;
	Fri,  5 Jan 2024 09:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCECBC433C7;
	Fri,  5 Jan 2024 09:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704448313;
	bh=zObzgg5xDJEKxicGf3Aen7ihBLVfTRp4ARHI1eYeTGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xwOOP7fuywfd1ANXwChAgafiVt6B0zrHR1/0aqaK1ovDh1Lkg+16fd1QnPwt+Ekjo
	 VwYsj48E0GWH2S/Dd0Xadf0ObUYNutn2N41IwLEZDwGEK0/yflNVJbjQVsAx5ELjVP
	 yWGogO+2utQetgOGuziLE8oCjcMl/bCYbI0tfZhg=
Date: Fri, 5 Jan 2024 10:51:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeffrey E Altman <jaltman@auristor.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Markus Suvanto <markus.suvanto@gmail.com>,
	Wang Lei <wang840925@gmail.com>, Jeff Layton <jlayton@redhat.com>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	keyrings@vger.kernel.org, netdev@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 067/156] keys, dns: Allow key types (eg. DNS) to be
 reclaimed immediately on expiry
Message-ID: <2024010526-catalyst-flame-2e33@gregkh>
References: <20231230115812.333117904@linuxfoundation.org>
 <20231230115814.539935693@linuxfoundation.org>
 <cd1d6f0d-a05b-412c-882a-e62ee9e67b85@auristor.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd1d6f0d-a05b-412c-882a-e62ee9e67b85@auristor.com>

On Thu, Jan 04, 2024 at 09:13:34PM -0500, Jeffrey E Altman wrote:
> On 12/30/2023 6:58 AM, Greg Kroah-Hartman wrote:
> > 6.6-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: David Howells <dhowells@redhat.com>
> > 
> > [ Upstream commit 39299bdd2546688d92ed9db4948f6219ca1b9542 ]
> Greg,
> 
> Upstream commit 39299bdd2546688d92ed9db4948f6219ca1b9542 ("keys, dns: Allow
> key types (eg. DNS) to be reclaimed immediately on expiry") was subsequently
> fixed by
> 
>   commit 1997b3cb4217b09e49659b634c94da47f0340409
>   Author: Edward Adam Davis <eadavis@qq.com>
>   Date:   Sun Dec 24 00:02:49 2023 +0000
> 
>     keys, dns: Fix missing size check of V1 server-list header
> 
>   Fixes: b946001d3bb1 ("keys, dns: Allow key types (eg. DNS) to be reclaimed
> immediately on expiry")
> 
> If it is not too late, would it be possible to apply 1997b3cb421 to the
> branches b946001d3bb1 was cherry-picked to before release?
> I believe the complete set of branches are
> 
>   linux-6.6.y, linux-6.1.y, linux-5.15.y, linux-5.10.y, linux-5.0.y

The stable trees were already released with this change in it, so I'll
queue this up for the next round, thanks.

greg k-h

