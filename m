Return-Path: <linux-nfs+bounces-19082-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kjMYKV84mmlDZwMAu9opvQ
	(envelope-from <linux-nfs+bounces-19082-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 23:57:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AE216E2C1
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 23:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98BB9301751E
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 22:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27E215624B;
	Sat, 21 Feb 2026 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="MeR1leu9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eaDhoQUG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9F13959D
	for <linux-nfs@vger.kernel.org>; Sat, 21 Feb 2026 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771714650; cv=none; b=G1GyQpUBr+7cwIB0mCxnWhUGl4FwhhBrky05/DxFq7iBFlWRV463C46Nzn2yjJabr2T8DkFFA0H5O2o23j+hu+INS+nGX4URVkWT/4aQeD86Nf67ADAiypqG2LPSUe2R0aYv9fPLL6gEbK04yr/e5o+8+kCKj3XqXALoQKNn1uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771714650; c=relaxed/simple;
	bh=JUQWBnreL7R6xktDWTmARVKVrgsSh/3W19ke4Pd2bPo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=gjDYYig63wwziTQ8eYp8tm3w18pu+fatcKa6hVecMMyElZK4nCdco9jYoKvOpb1W7il54i153mr1j2s6MYJJK5v+D3jh1dOuKo4nLyYDAY/sPi/rINruZzsFKVBQJ/KHG/nSmfDL8MsmA76UbZthVwGnTbaRH5bgxjpjEO+FJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=MeR1leu9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eaDhoQUG; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B002B7A007B;
	Sat, 21 Feb 2026 17:57:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 21 Feb 2026 17:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1771714648; x=1771801048; bh=5RSnk/BU5w0IEgfQd2csm4TNcQftOJDs7Gn
	Lc2FUnn4=; b=MeR1leu9DMbSs+3X0NYl37k16jKKjNUYDelPCCMW7EZqD9pMafY
	RVYTO6BvbyjaPN5/gfObJEm4XFgPpX3DKTJHbYN4CbJx+PKJ812P2PVWlxz+NiAc
	shS9W2ITNmlDYUPG+JGHUH1EkmdIt+jncHNWS64wPLOvhEYZzjq5Yas7CsV+neMf
	F9ZwZ2z8xM9+5BGNi7GrTsFRP+8vanEbtVWUfskSrT8UyB2TYYvoPKbgvzdZVDUx
	S+ed4/Inw/3rZ2/Bzieu59RKpNb/uzES+i1ilX3yUhilmMXA8H+O4WGJ90p/liiY
	7JXh7noVh6BJhx45Et2gf1jtRnox3/B5TPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771714648; x=
	1771801048; bh=5RSnk/BU5w0IEgfQd2csm4TNcQftOJDs7GnLc2FUnn4=; b=e
	aDhoQUGttcGDEC6zPdQ3QSPSjbuzaLpRG+KJBGVtqEY9SAUcQGc3hOPh/bDTjBTQ
	engAOfd/BZn2P74bYTtx9wDhm3nOVKJsyiab2Om1NSfcudhLanLAx50JXJjBlW5D
	Ws3Ks4AuT+bSVfmDxOepoN65o/Bup/OtSIOqNoBYYSJXHs6p2SGUtnn5RutGG1pG
	kGC+TBR+0xlqoXnhumArCEbX5ke5G+pAhuaMtp0ZdrwUgtp2oAFi+mFWz6/wUP4w
	2qqcdziXW/Brx4iicJwoD6hZVahAaIEwEP5wjh6jU8GKZLXRD7LC5+VH9TGRODO2
	l3MLK14A5b25zDSPPrtWQ==
X-ME-Sender: <xms:WDiaaVx9-iBOm1hG3mtVkwVzHdHiEkJFRq4WFgPpwoo3fLekZDDAtg>
    <xme:WDiaafQlAeUNcY-tBny8N0I0cbQJ3hSOfXtGQ6W9TpVeORTtJmcUqUqz63uLyasfv
    g2JNKSy4P7viw6lSW868-eFXBajl2pnHBLEfnlm6ekDIPdjBw>
X-ME-Received: <xmr:WDiaaV_vxEam9kpyYGYwG4kpLk7LT55ZdS9tjJ9R6mO9iWauBOr_spAJV3hwvvMCSwjtVWt10eRTaYt0jz002fKDoLXMGUusNhFvJrx6QA3r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfedvieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    hnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhesthgrlhhp
    vgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopegthhhu
    tghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehmihhsrghnjhhumh
    eslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WDiaaVtDNf_et1qbKVaLjXkgZMk7SMMXuVKlppgtL6eYchm0t12wEA>
    <xmx:WDiaaVPA2AiuTPayWpjtGg7xZ0xGcIyvhBFPO4hI4qLaIg4lkIuuEQ>
    <xmx:WDiaaahVTPogw_Pu47csgzHycKmqEyMbbZFT3V0q1d1xXsIosr_qtA>
    <xmx:WDiaaX49c1WS7R9SmdAUjtq1m0fiJfxPFtzyizOvwD8S8eZWeffUFw>
    <xmx:WDiaaa6AkBPeOY_snJgxmTDTjb_AAc5O6sNF1VVBCjk7CcTbv7Y6e6ZU>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Feb 2026 17:57:25 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: misanjum@linux.ibm.com, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 0/2] Address UAF in sunrpc cache show callbacks
In-reply-to: <20260219215017.1769-1-cel@kernel.org>
References: <20260219215017.1769-1-cel@kernel.org>
Date: Sun, 22 Feb 2026 09:57:23 +1100
Message-id: <177171464397.8396.10030110076107851635@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19082-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,ownmail.net:dkim,oracle.com:email,noble.neil.brown.name:mid,messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07AE216E2C1
X-Rspamd-Action: no action

On Fri, 20 Feb 2026, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Attempt to address three crashes reported here:
>=20
> https://lore.kernel.org/linux-nfs/dcd371d3a95815a84ba7de52cef447b8@linux.ib=
m.com/
>=20
> These are compile-tested and regression-tested, but as I do not have
> a PowerPC system handy, I will need someone who has one to test
> whether they actually address the crashes.
>=20
> Chuck Lever (2):
>   NFSD: Defer sub-object cleanup in export put callbacks
>   NFSD: Hold net reference for the lifetime of /proc/fs/nfs/exports fd

Nice.  I particularly liked the thorough commit descriptions!

Reviewed-by: NeilBrown <neil@brown.name>


>=20
>  fs/nfsd/export.c | 63 +++++++++++++++++++++++++++++++++++++++++-------
>  fs/nfsd/export.h |  7 ++++--
>  fs/nfsd/nfsctl.c | 22 ++++++++++++++---
>  3 files changed, 78 insertions(+), 14 deletions(-)
>=20
> --=20
> 2.53.0
>=20
>=20


