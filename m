Return-Path: <linux-nfs+bounces-954-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E1E825175
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jan 2024 11:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7171F23A35
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jan 2024 10:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A23D24B33;
	Fri,  5 Jan 2024 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sCPY23v5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167B424B2F;
	Fri,  5 Jan 2024 10:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CFEC433C8;
	Fri,  5 Jan 2024 10:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704449219;
	bh=Exy/fCfgWx2532qZ1vXYkjfLM2k7/JjLhx9Pk8pooss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sCPY23v50V2ll1z90icCOZpj4qdgoNJ3e9JEJNMtB2grMqRnAVcKBIcRZC7C0/hFt
	 rOGRJWf+vMQbIij+5Syis7i+svqiVMboeSNjz0eRDvEZfgbAM3792ROS3uIaj0YeND
	 sit07u3Dx2XIo4EzK+VdNzjZGNAArCVciPyjOiEs=
Date: Fri, 5 Jan 2024 11:06:57 +0100
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
Message-ID: <2024010556-tradition-reappoint-95a4@gregkh>
References: <20231230115812.333117904@linuxfoundation.org>
 <20231230115814.539935693@linuxfoundation.org>
 <cd1d6f0d-a05b-412c-882a-e62ee9e67b85@auristor.com>
 <2024010526-catalyst-flame-2e33@gregkh>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024010526-catalyst-flame-2e33@gregkh>

On Fri, Jan 05, 2024 at 10:51:50AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 04, 2024 at 09:13:34PM -0500, Jeffrey E Altman wrote:
> > On 12/30/2023 6:58 AM, Greg Kroah-Hartman wrote:
> > > 6.6-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: David Howells <dhowells@redhat.com>
> > > 
> > > [ Upstream commit 39299bdd2546688d92ed9db4948f6219ca1b9542 ]
> > Greg,
> > 
> > Upstream commit 39299bdd2546688d92ed9db4948f6219ca1b9542 ("keys, dns: Allow
> > key types (eg. DNS) to be reclaimed immediately on expiry") was subsequently
> > fixed by
> > 
> >   commit 1997b3cb4217b09e49659b634c94da47f0340409
> >   Author: Edward Adam Davis <eadavis@qq.com>
> >   Date:   Sun Dec 24 00:02:49 2023 +0000
> > 
> >     keys, dns: Fix missing size check of V1 server-list header
> > 
> >   Fixes: b946001d3bb1 ("keys, dns: Allow key types (eg. DNS) to be reclaimed
> > immediately on expiry")
> > 
> > If it is not too late, would it be possible to apply 1997b3cb421 to the
> > branches b946001d3bb1 was cherry-picked to before release?
> > I believe the complete set of branches are
> > 
> >   linux-6.6.y, linux-6.1.y, linux-5.15.y, linux-5.10.y, linux-5.0.y
> 
> The stable trees were already released with this change in it, so I'll
> queue this up for the next round, thanks.

Ah, I see what happened, that line:
	Fixes: b946001d3bb1 ("keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry")
refers to a commit that is not in Linus's tree, and isn't the sha1 that
you are pointing at here either.

So I'll go add this manually, but this is why our checking scripts
missed this, please be more careful about using the proper SHA1 values
in commits.  Using invalid ones is almost worse than not using them at
allm as it gives you the false sense that the markings are correct.

thanks,

greg k-h

