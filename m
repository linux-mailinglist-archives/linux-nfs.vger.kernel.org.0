Return-Path: <linux-nfs+bounces-11645-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE9EAB1EA6
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 23:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE84B1C04804
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AD720F07E;
	Fri,  9 May 2025 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6tLd+6d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16B65464E
	for <linux-nfs@vger.kernel.org>; Fri,  9 May 2025 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746824550; cv=none; b=hDKCS49BU1Teqc7MO8nmXfDRAfhW1GRLiyMwC40YSN1kl3X8S7WWZLPA7pVgXLOp1x1bHvX47wlW3CtD8evGUuXmi1mYL8I5VWx54z2l+0Alq5F0xOgXuo9PUSSt3rxkpYDSCElmy/sraLLMWbV3n6+ds4I8XOpSJY88Ue8mbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746824550; c=relaxed/simple;
	bh=isSQ404P7sF/BUPm7h/ogq+DBzEc7N5rFy9jn6IjGuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mA3bIR+9vRMOvzHpX2ND1yPeyl7z+K/IzVJ1hNlHpi5l60yc4sZk7uPD3QUbLuiq7ADGw2+Km6+R6VstvSdpIcfGChxxDJijU2qtSNErREBKFoNo4E5R9281/VO5rV3OBiOnvj1Y4DVUg7z80z4/4PlblAOefPLNxG7zATDUnpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6tLd+6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA1CC4CEE4;
	Fri,  9 May 2025 21:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746824550;
	bh=isSQ404P7sF/BUPm7h/ogq+DBzEc7N5rFy9jn6IjGuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K6tLd+6d4kg+nkUlhZYz9zkNT/L03Uvo+tJk1oCH46c40WvWaPs7vIyzNOVmyb0ii
	 IodFc4Karc/6atrYKq+5+oPC0/vNyk0XAHlmkkCCmEhjgOfgTQIlOjY15ToAiCddm0
	 lhNaLVOI9mNAYfTZsvHdExTog3Zk7BYBKRTYhhQYPXwDd4IBDkoOuFO7+kTygMNuqC
	 G3gYsfRpF+/Nd/fi3JCaWRoBSWgDdCyRZjdjHabVzETO2r0XqNsnGV8kL+xLIaj7qE
	 nTZ/CTl5mzvkFYU6A+NEyN3hU2zhQEUtYnLcQnjgvIW+Gi+kjmH5S5t88lPkoTGgb4
	 esH8iDLA/bKbw==
Date: Fri, 9 May 2025 17:02:29 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: [PATCH 0/6 v2] nfs_localio: fixes for races and errors from
 older compilers
Message-ID: <aB5tZY9ucJigXGFp@kernel.org>
References: <20250509004852.3272120-1-neil@brown.name>
 <f540ef6a-705a-4987-87b5-fd6753174289@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f540ef6a-705a-4987-87b5-fd6753174289@oracle.com>

On Fri, May 09, 2025 at 12:01:19PM -0400, Chuck Lever wrote:
> [ adding Paul McK ]
> 
> On 5/8/25 8:46 PM, NeilBrown wrote:
> > This is a revised version a the earlier series.  I've actually tested
> > this time and fixed a few issues including the one that Mike found.
> 
> As Mike mentioned in a previous thread, at this point, any fix for this
> issue will need to be applied to recent stable kernels as well. This
> series looks a bit too complicated for that.
> 
> I expect that other subsystems will encounter this issue eventually,
> so it would be beneficial to address the root cause. For that purpose, I
> think I like Vincent's proposal the best:
> 
> https://lore.kernel.org/linux-nfs/8c67a295-8caa-4e53-a764-f691657bbe62@wanadoo.fr/raw
> 
> None of this is to say that Neil's patches shouldn't be applied. But
> perhaps these are not a broad solution to the RCU compilation issue.

I agree with your suggested approach.  Hopefully Paul agrees and
Vincent can polish a patch for near-term inclusion.

It'll be at least a week before I can put adequate time to reviewing
and testing Neil's patchset.

Thanks,
Mike

