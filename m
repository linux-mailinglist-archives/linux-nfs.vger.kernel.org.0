Return-Path: <linux-nfs+bounces-17021-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FE3CB18FB
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 02:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC3E0306BE63
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 01:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29572249E5;
	Wed, 10 Dec 2025 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="x9Y7yBio";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U1W/cIGk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD83820A5EA
	for <linux-nfs@vger.kernel.org>; Wed, 10 Dec 2025 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765328488; cv=none; b=mpiTRY6g8atbpYgTlp5v12GsULQux5AYnAcWeD07NYes+8vG7diSp9hNfJx+OToSZNc0gsMsPGrzbV1E7z6SgradtRerBF+8T8iqm6u4OChVvRVhHk2ggTSIzJ6rIfgSpPcWPK41vbVgPfUT2+4Pz62rvBJegNNVOmrvBtz6rNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765328488; c=relaxed/simple;
	bh=yE2ti7rEBK2BGag5J41fl/i+35FtFHjK6OErAYwq+ig=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=VJiqEZ6gECSibwClq43PCnqa9MAcDVWgcBYvJYOwGD+EdOgkW7a+Wx+mfkPxdm+kvtTxbQZvNQwZuvwkBeKhrsx0EeWziAcF6sZBNg1aLp9EJWxkLbTIgbGFQVuO0Bhiz10mRfAH+tjiez8UBIIwjbuTOf2g1DlfKelg2yliTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=x9Y7yBio; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U1W/cIGk; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 706D57A011B;
	Tue,  9 Dec 2025 20:01:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 09 Dec 2025 20:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1765328484; x=1765414884; bh=MrdHKyLERKRcyPfFlQtdLewCEtlwtHHHdyI
	7k/XYxbQ=; b=x9Y7yBio9rWhJJLkdKharoe0VhyKGmaHYCmpyD1JmkPM88HbqMk
	Ujxiuw5j9LPcyf270s1ZU2H2br2hWuMkJSMDaoHj7oOPQFiNqusWtJVQfXzIVexj
	/W4vOP09KlLdiruNxYEFgXanib0hD1HDHh+WZh8z5SUp72MXwhkZjDUMl4WTBadv
	7pZLWO+XYk56mv6ZWs+pGiOctLH0iScrIaW+2ANiK/dU5WFYxJQ4dtiVNb9An2Mr
	vSKWsG+19B/lR2HRylaKu0QWb98kyh8ICFT4/cEKPwPP3Ium1RxkROsdCPNSoacE
	sSgKizdhoXptaZgmS72vZsRe2CKjI5rMrMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765328484; x=
	1765414884; bh=MrdHKyLERKRcyPfFlQtdLewCEtlwtHHHdyI7k/XYxbQ=; b=U
	1W/cIGkJLBZ6tyRVpCU+ViHAw+8Wm02mNvHxTYYgFxgFyXqrkpkyU67K6I7VFihR
	nXZR+XiAtVbmPAXInCTbt8mxlJeQD9h4wOZB2PpQMZZAIBbZIjZKNqZzkSZ11HrF
	+EZcyK1POtCzbcWo4/wg+6WiECF0TsubW2wtxakGRM3ZHq8xYHwkAfU6kLDEK9NS
	HBITvobaLTn4wYf56aJNi3KVczyyOHWj4b0/Khb44bovHzu6U3AC4yXyIpE3G9iR
	ecGk6E5ny11Ip7eV9ryHprydkDXyxCLVTjyiTZp4aTZ/f3XsXkCIjoHz04Il5V/U
	K4yDjd+TuTm50MAwPYmzg==
X-ME-Sender: <xms:ZMY4ae19IRK9MLmhBlkFqM5vXZ7FJhz_TyVMvkNm16wfiKeLsZzHeg>
    <xme:ZMY4aTWQr2r1IvYlwjl4GY2wSlo-ZnnhXzvh6KROro5bzFznXPZ6n6h43mj2yT5zQ
    Ew-LwdYXNLTAUNEKxoILg2rbaL2k70GQGsZV2tukchA5k5ARYU>
X-ME-Received: <xmr:ZMY4aZLgb_rCz7n-LNgm0o2l45ZnHEvMhjatmtD7__fO9ZllkdzW_n0EFbOOb1OoKceoR2_5P916iRnhIZQFqWgESnUEPTs6kdOm9sAdXFIe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvuddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthejredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duteefhfduveehvdefueefvdffkeevkefgtdefgffgkeehjeeghfetiefhgffgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvg
    hlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZMY4aV04rVaCIKIQVrp4mDwh0sP7_BPTnQWllHE5MHnY8FJpiXjN3g>
    <xmx:ZMY4af5h1WsixIrbt__BTDlPibKcSij8Pmwvugl3Yarl9pQ1_OxUaw>
    <xmx:ZMY4ae9MWozKVoyuf4vMU4og31VI4dtpojC49S0Cuhw4XgTdNtsU5A>
    <xmx:ZMY4aWXXv4UsVOK-j_Mzw-RXE4hKdOJkEcPP9qrvM_HmyUqfRuHUVw>
    <xmx:ZMY4aTBq6hiVjoMEVhw9juBsNSna-e5t7LGBlBhBcbcYjmi25N6BaaWk>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 20:01:21 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <cel@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH 0/2] Address minor issues with status codes
In-reply-to: <45662e818b57ef1e65156a76736a49a0609517fa.camel@kernel.org>
References: <20251210002850.318350-1-cel@kernel.org>,
 <45662e818b57ef1e65156a76736a49a0609517fa.camel@kernel.org>
Date: Wed, 10 Dec 2025 12:01:15 +1100
Message-id: <176532847537.16766.17141101695422327144@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 10 Dec 2025, Jeff Layton wrote:
> On Tue, 2025-12-09 at 19:28 -0500, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Here are two examples of minor bugs I found when comparing NFSD's
> > human-generated status code definitions with equivalent xdrgen-
> > generated headers.
> > 
> > Chuck Lever (2):
> >   NFSD: Remove NFSERR_EAGAIN
> >   NFS: NFSERR_INVAL is not defined by NFSv2
> > 
> >  fs/nfs_common/common.c   | 1 -
> >  fs/nfsd/nfs4proc.c       | 2 +-
> >  fs/nfsd/nfsd.h           | 1 -
> >  fs/nfsd/nfsproc.c        | 2 +-
> >  include/trace/misc/nfs.h | 2 --
> >  include/uapi/linux/nfs.h | 3 +--
> >  6 files changed, 3 insertions(+), 8 deletions(-)
> 
> These both look fine to me.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> 
Agreed.

Reviewed-by: NeilBrown <neil@brown.name>

I cannot easily find a path that would lead to NFSv2 being presented
with nfserr_symlink or nfserr_wrong_type, so that change probably isn't
visible.  I might have missed something though.

Thanks,
NeilBrown
 

