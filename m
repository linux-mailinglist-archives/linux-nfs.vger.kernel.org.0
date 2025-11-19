Return-Path: <linux-nfs+bounces-16588-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBD4C71333
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 22:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id BA45528F5D
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 21:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4312E307AC8;
	Wed, 19 Nov 2025 21:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="cwSg3g90";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ClfvVd+Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C80372AA5
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763589351; cv=none; b=NekAmH4pbBARsxp+2o1YTpRFlecKCfvBTWuVmK9vXn4ZGwL86c/RuX+MkvOVOtYQufS73JB9jiCWZHUaxoa/DZcqJ+LkXhDOVhs63RuIJJBh665zr1AbiaaqQMwk2Dd5eFdAwHt2Co8DwFQ9NZbRyM9PxWGpxkFmESmCt7szddY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763589351; c=relaxed/simple;
	bh=F0hA3AMBMqVPpqZuZr7KBFpYVJ0mNiTAvGi+DIX42pg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=EL7Ib3jkTX9dxO5xPHCAO7Yy8GCzRrfVwoWWy/9b8NA2YvJcaXpa2yxTgSu3lIxz/etXnxUkl4ypYcpbR6fCGuCT6JhEv0FlUmdms0GFbY4Ux2jV4+bUB8I/L0zjN21ffHNOCyoNykK+OX6vrrXxgkm0BNEBAOSuAiQ9pxh/G+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=cwSg3g90; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ClfvVd+Z; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 971251400200;
	Wed, 19 Nov 2025 16:55:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 19 Nov 2025 16:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1763589348; x=1763675748; bh=mUkT7ZfVM+v+LB3DBjpZZb8/5uL/MBj89+3
	r8HyFNjQ=; b=cwSg3g90/X5AumKJcUSkVhk82K43U4WQpQpzNZh0mQ2eJgjQFUS
	fo0WufiOHOUiGnXy5qdSvwoURjCgtwFkz9FB6SC9ju+uQ8HsaiizqUFEEjknBDUN
	YXt0XRav0lWyC9xE5SeZIlP5DwpqvsVdEkcDHAY7SeBKDExkdkABN+kXFMZ0bWZM
	kokyqGIbw/pbkF5QlsKlY3EGwEscNCYMRqospx+JZXMlG9OoQIy7fJT5kB/9HsxY
	vWEMfMeeFIIz/mx0x4z51ZD/oxTP/wCtjNo/zyFbiV/OKI2rsbd1hknr7MsNxweg
	Vd8vAkawsiUEfPru/STFW8STJuZnDEhnndA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763589348; x=
	1763675748; bh=mUkT7ZfVM+v+LB3DBjpZZb8/5uL/MBj89+3r8HyFNjQ=; b=C
	lfvVd+ZusgwpVRPfbgpbHNZ2pFh1TmabEiejDUDbJPMsHcGx1RvCgbB/HWvNqEgA
	0+DPkAkoE8SQiszaux7qRiYPIB3Ww2G4geZCnw9q0532ZlydGAdVZcFEEqvgh+9o
	eA0OSFOe9zVFb/K4qivbTTva/lUW6a4HEg8l1AqNpVvkuq5SJvhaZfazjouIx8pG
	WEYn81Jn+JWa2RDOJ2+/0zOKzugyzzmNNIBO3KhZ4Ml6tbNocs4j7SC+nsWM4/Sy
	dmeivvphtdCKQDQ51xuDIs3L1FQlog+6uAHMMEL/XOvuOQs1qlzQu7ZCJy9YpvxF
	DA1U0DJBsgg8hF/8vayCg==
X-ME-Sender: <xms:5DweaT_Lscu3tmt-rvaoYDq_K8rEEvwiE_yfmJ4RkbwdsCZyxcG5pQ>
    <xme:5DweaTZl0254OD0tSbH4hSJuOPz4fDaeAkM8WyXildXNusmEnWBMh-9PHwGlBG8cd
    bkiOI6er9L5V7G5a7B1trj5jsLhk-VfDhIZpZGpBhtXzis_fA>
X-ME-Received: <xmr:5Dweaa32e4e77WxIg2bzcKIiYwM5FrWD0cZ44LpeiP6iVB7hK5Iv5mmU0InI_-c9AwtcTDJI3A9a8HnBrki1vh2z3WEW0e2zs8T2S2YdanWS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5DweaWbl0GAuUDe_D_kyHsmRH5qagJoEYrFrUwQwOkHTZobc-c7eXQ>
    <xmx:5DweaaIfiTv0FwLYOrAmhyE17Ap-A4eMJMwdEr7gLO25TiiIxeIsAg>
    <xmx:5DweadEiVsC6SkzA7B4e8FTzE2TW8zLVP3sQw-tEIN0fii7WmMb7tg>
    <xmx:5DweaZsPqawpeUR1oxNUlIkHgToOdnl_cG93Dnzgs4jRwM33R4qP9A>
    <xmx:5DweaReBcT6Ewr6uiVGkzNAxGvwEUOYdTpHiAFFS22ANn4vjpIJ_zLev>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 16:55:46 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 07/11] nfsd: simplify clearing of current-state-id
In-reply-to: <7c2e77a6-6ac1-4b32-a245-4a7a98f7e577@oracle.com>
References: <20251119033204.360415-1-neilb@ownmail.net>,
 <20251119033204.360415-8-neilb@ownmail.net>,
 <7c2e77a6-6ac1-4b32-a245-4a7a98f7e577@oracle.com>
Date: Thu, 20 Nov 2025 08:55:44 +1100
Message-id: <176358934480.634289.12895134302600589105@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 20 Nov 2025, Chuck Lever wrote:
> On 11/18/25 10:28 PM, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> > 
> > In NFSv4.1 the current and saved filehandle each have a corresponding
> > stateid.  RFC 8881 requires that in certain circumstances - particularly
> > when the current filehandle is changed - the current stateid should be
> > set to the anonymous stateid (all zeros).  It also requires that when a
> > request tries to use the current stateid, if that stateid is "special"
> > (which includes the anonymous stateid), then a BAD_STATEID error must
> > be produced.
> > 
> > Linux nfsd current implements these requirements using a flag to record
> > if the stateid (current or saved) is valid rather than actually storing
> > the anon stateid when invalid.  This has the same net effect.
> > 
> > The aim of this patch is to simplify this code and particularly to
> > remove the per-op OP_CLEAR_STATEID flag which is unnecessary.
> > 
> > The "is valid" flag is moved from 'struct nfsd4_compound_state' to
> > 'struct svc_fh' which already has a number of flags related to the
> > filehandle.  This flag will only ever be set for the v4 current_fh and
> > saved_fh and records if the corresponding stateid is valid.
> > 
> > fh_put() is changed to clear this flag.
> 
> I don't see a hunk in the patch that implements this.

Nor do I.  I don't see it in my "git reflog" either.
This is why I like the commit message to give plenty of detail, it
helps reviewers find my mistakes.

Thanks!
NeilBrown


