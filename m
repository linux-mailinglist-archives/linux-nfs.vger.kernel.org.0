Return-Path: <linux-nfs+bounces-15278-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F62BE1168
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 02:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09875825DC
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 00:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160D335962;
	Thu, 16 Oct 2025 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="br7bploB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XJZvjoHr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B157F1C69D
	for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760574009; cv=none; b=X2AMYYeooDZ6ItWW8JC/xoXa8KMAdBrCgMzJR+QoSy3yQAtzLwPwmqx5kZqVcsWF1iJbgyEHLPwXOPz12sTVMffXyZYOAb1Rjbo0iql2/SZjhRwFvDGLcjjPSZE1A4ZgeSAfOQmbRMzrshOG00/qVlkdv4ljuobFw3M3zMIkF8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760574009; c=relaxed/simple;
	bh=ZI6/16EljdB03zsXK6AuC4OyesbQtRG/C/QK8LVIHzk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=bnOcntitjh6JeeSX1OhNbOlGgzrtZ6yf4T3bEkunCvpscRYDJaq5R9hSwBdziGgMzObKsD3QEFGr5B6lwyOciLnC8rN2m+3JEe3zsnwHUpoEML0/o+cdD9Xz5Ic3OXnmjtYUmP1RyNKKpRROZY+1BpCAOOBQ2heBPA6beFjX9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=br7bploB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XJZvjoHr; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AD24C7A0126;
	Wed, 15 Oct 2025 20:20:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 15 Oct 2025 20:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760574005; x=1760660405; bh=yZO/IISzhO2XG2i6ct4jw+NYPI8vXe7xdId
	QWDfMFgQ=; b=br7bploBZo13CvJWuMxTOzLR//2M2K8ljO8dlDlvOuv4H96ByWX
	IjrqX+M7BwBEbqHJDVhDFFYN9SUVnea3vrGr+ahaNdLi56YDiZzWLcTx+nXpRg9V
	DN9yCax473gAIGiXzCXUdMD5lhZ732XAlyb1jv2iJRLrQFACO4xJB4uGJjoFGqiG
	bd8tH+9ijYApy9KaBTbMM8VzCyGjHTrEgsxz32NW526ispYQ+1qipPaHy9S8DNkg
	hU+NQ6J3Oz/OqqRvVOgMU1HQ9WTol2RQpD7n2Eb4cOv6FczIk/MrmMvlaEKXloGv
	pP6lfsgO4jvaNyUJH8QZZZjRLldg+4Ce7zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760574005; x=
	1760660405; bh=yZO/IISzhO2XG2i6ct4jw+NYPI8vXe7xdIdQWDfMFgQ=; b=X
	JZvjoHr5r4jcICLIp52hO6Y1ycpQIym64g+Ort0oNZ46gVE0qQcD/YJM3sD4zi2b
	dVLwlN3dqPk+Vn0HamqjyWC39fTpsdlCC3spmcVOKN98LXciP/D1vbUiqmINqRY5
	p9/DnJVFc5ibvb1/TX+o5vG+umAwgfOuV4BptEa/GTunSwTTEJ0bgl3FV14G7ivs
	V4Ca0f+TuAGXYZWJM+8KI6p/yATG/ndlLjpt2VAsu9ashD1v4B77CvhZVZ+KgMt4
	dg6c4qWOKfYUyRJf5Vz1bcUWAEYrKZPd8MAZcaoS4ZYoTnhhuVjUaNxOyhS7ZI/B
	es5iIHE9Gi2IOMtb4M3ng==
X-ME-Sender: <xms:NTrwaBx2Op1kCsxFZHReHOGE7K7pwFcCJbYTTE0yi_fXc03tMDunuA>
    <xme:NTrwaE-zQpmBB5Olwydmr4xWR21L4nBdjB6S9hUiCuM45oUDslpeja67UlOvOF3pd
    zhr6hMbT5l3JIFuQO80juZ7ejpw-i6FQlsfkVYe8Ler6GLUOQ>
X-ME-Received: <xmr:NTrwaFKtFkYRdIO8ryRGAAUKDYdz_QLN6O0UV5uZD8r3Nyof3ul7pSIEVjBRxGFmjqKIZy8B7PN-MT8vDSziDn59Sk9mIFrm7GGIm3LQPL83>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtkeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epieekudethffgtdejudffieetvedtudffvdegveffvddtfeevveetveetgeduueffnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    hnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhesthgrlhhp
    vgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthho
    pegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NTrwaKfn5P5Dz9S7prqKPEQO74xkLb9ckjT8VZ97QXeCZ-PB1j0lyA>
    <xmx:NTrwaE97APbn6YVhhLINQkWtJaZj0346Qn-RMhdfK4S7JuWhAv7Oyg>
    <xmx:NTrwaHqZAevM9aEt5XXlkgTMewU62T3tTdvXVcBGazy7D_ZpTa4wZg>
    <xmx:NTrwaJBrEtZdwpk9MiYf5FQyw_wY1OlF4w6DQvhsSDe-f8eJBWNAPw>
    <xmx:NTrwaDSCbALPn27EIh_aNndNmGXN4RE1kPKXkjhm4abuj-cW5q9Mrvhe>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 20:20:03 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Olga Kornievskaia" <okorniev@redhat.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nfsd: ensure SEQUENCE replay sends a valid reply.
In-reply-to:
 <CACSpFtC7CZGZ1ezGqKmg_7qkffqr5EaZTqfk390WkatBt4Va+w@mail.gmail.com>
References: <20251014233659.1980566-1-neilb@ownmail.net>,
 <20251014233659.1980566-2-neilb@ownmail.net>,
 <176052583604.1793333.11667202487074445027@noble.neil.brown.name>,
 <a2ecf4da-8b28-4902-906e-773346e8c283@oracle.com>,
 <CACSpFtC7CZGZ1ezGqKmg_7qkffqr5EaZTqfk390WkatBt4Va+w@mail.gmail.com>
Date: Thu, 16 Oct 2025 11:19:58 +1100
Message-id: <176057399817.1793333.2292345386923906210@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 16 Oct 2025, Olga Kornievskaia wrote:
> 
> 
> On Wed, Oct 15, 2025 at 12:02 PM Chuck Lever <chuck.lever@oracle.com>
> wrote:
> 
>     On 10/15/25 6:57 AM, NeilBrown wrote:
>     > On Wed, 15 Oct 2025, NeilBrown wrote:
>     >> From: NeilBrown <neil@brown.name>
>     >>
>     >> nfsd4_enc_sequence_replay() uses nfsd4_encode_operation() to
>     encode a
>     >> new SEQUENCE reply when replaying a request from the slot cache
>     - only
>     >> ops after the SEQUENCE are replayed from the cache in ->sl_data.
>     >>
>     >> However it does this in nfsd4_replay_cache_entry() which is
>     called
>     >> *before* nfsd4_sequence() has filled in reply fields.
>     >>
>     >> This means that in the replayed SEQUENCE reply:
>     >>  maxslots will be whatever the client sent
>     >>  target_maxslots will be -1 (assuming init to zero, and
>     >>       nfsd4_encode_sequence() subtracts 1)
>     >>  status_flags will be zero
>     >>
>     >> The incorrect maxslots value, in particular, can cause the
>     client to
>     >> think the slot table has been reduced in size so it can discard
>     its
>     >> knowledge of current sequence number of the later slots, though
>     the
>     >> server has not discarded those slots.  When the client later
>     wants to
>     >> use a later slot, it can get NFS4ERR_SEQ_MISORDERED from the
>     server.
>     >>
>     >> This patch moves the setup of the reply into a new helper
>     function and
>     >> call it *before* nfsd4_replay_cache_entry() is called.  Only one
>     of the
>     >> updated fields was used after this point - maxslots.  So the
>     >> nfsd4_sequence struct has been extended to have separate
>     maxslots for
>     >> the request and the response.
>     >>
>     >> Closes: https://lore.kernel.org/linux-nfs/
>     20251010194449.10281-1-okorniev@redhat.com/
> 
> 
> Is it just me or is this link broken?
>  

When I created the link and tested it, after the Anubis dance it told me
"service temporarily unavailable" or similar.  When I refreshed it
worked.
So it might not just be you.

> 
>    
>     >> Reported-and-tested-by: Olga Kornievskaia <okorniev@redhat.com>
>    
>     Very tiny nit, on behalf of scripts that might complain:
>    
>     Reported-by: Olga Kornievskaia <okorniev@redhat.com>
>     Closes:
>     https://lore.kernel.org/linux-nfs/
>     20251010194449.10281-1-okorniev@redhat.com/
>     Tested-by: Olga Kornievskaia <okorniev@redhat.com>

I wasn't aware that Report-and-tested-by was no longer wanted (but golly
- is it really that hard to parse?  Do we aim to make life easier for
humans or for tools?).  I see maintainer-tip.rst got that advice 4
years ago.

I'll bow to the needs of the mindless tools.

Thanks,
NeilBrown

