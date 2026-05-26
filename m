Return-Path: <linux-nfs+bounces-21992-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLXmBjEWFmq7hQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21992-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 23:52:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BA25DCE94
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 23:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7333302D126
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 21:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AB82609E3;
	Tue, 26 May 2026 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="TJ3im2D4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DVAV+jPD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9773B4E9D
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832336; cv=none; b=iG94keQn5aNUc+F+RBtvC+STbm+VPYg6lsOCGaHOEA2yP3XsnW5lxwC7qVwi1BJzinoASO03sGdC8IRAbrOVII4bl5aYJ3OaIMlRexUUAG0OPgV0cd3b/g9ugC6E6t2+iaVDnDxzycfO1mvYIOHLHLuJeBqgSnuoB8AcbN97v70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832336; c=relaxed/simple;
	bh=Zud9qLxZk08v18eBZ6nxp/LA3FSP9b341blp4k8U5jE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LxlHzvJ9DwjAF7IXG1sal4ByJ38KlgJI/5cQGVOd1zLK/ZAxGvZxLUSbU3t6yl1Dkzq4giNw0DRiDaOU8/H4MXCuAWAwHkTGXC00ITra5DegaSh/PSaBrfKCTCWNO1j/v5kwU70aUdut1eE7TEsdlb9HhjzvUsoR7AaTB2H3r/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=TJ3im2D4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DVAV+jPD; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id CDD67EC01EA;
	Tue, 26 May 2026 17:52:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 26 May 2026 17:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1779832333; x=1779918733; bh=kDRLUY6ueao9inLqUfJoJF1mGaGC8jrmXh/
	75u0Q1d0=; b=TJ3im2D4XMfe9IJJ8YFeBbcAS/gPKJVZ3YuC1L5Rmo75ZsQ9UIH
	MBSVyV8wCfX4N2iZQGI/PKlP7xb9r6nUQWAfEb7A1oR5yDxyTSaIU6bxS89hqJBy
	NRB6yyYmfH2eKMELIL28zNvcvIv+CPl7qlaS8W4zmtI1eSX5GBmN4ODWUTNm/KH1
	7pSiKfBY6Mso4Ng1FW6cM5T7SdRtOGNXMyVlq4mlRpIfgtPmqriEgqkEIKivbOcy
	1zPRnJ+9G7jvvagXWl9bavTfDaKYXhXSJboJu0UBdZxQdNuGeZNS6kNgI4+GMng+
	nU3R1hXh6GXOUUIeZwRuaUNYur+x43ZVgsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779832333; x=
	1779918733; bh=kDRLUY6ueao9inLqUfJoJF1mGaGC8jrmXh/75u0Q1d0=; b=D
	VAV+jPDcjYYeyjyqtIabH0st/NHMr328pUo48NE4+xWOoCIj2R6aGEZshRonmw1M
	TwlM+/G+1sNB8Eoygb2Ag5M5ELSH9TRnzqr0lte+VHIt7WmRUl8eNuiW18vXatM5
	95BvXYs4+OVxnvH95D6ZzlWNAWBGNJmkR+CnbJEMdy/t+F4rqX4HWum6TgRZIV6n
	Vq86GmSaoJjLLy67xdNNvEIByxcYr3ny/ukxh6MRYhneJzhvHGtm76OgSaiMrqqA
	gmcQruYv7iY4uedIcMaJ/XnRp/qGBn6AO39Wa7iOge3PploHf1I60JYNmxQp0kzQ
	7c41X4bBklEw81hVx1HMA==
X-ME-Sender: <xms:DRYWaj3TU2PxGbeg8Lc9wC-nmO_kNrxgeLu--ktaDgLS9Ar-lIXULg>
    <xme:DRYWapF_5J8585---qSxqCMgA1eXPbuhPwgToF5wKdAvatgTpFpLtK0-aevaYm6Fg
    R4SUR-DCvjCBJKj_SdnPRDmpuw1rd29hxiNaAeppilQ9rnpEw>
X-ME-Received: <xmr:DRYWao6kfCR7sCLp-da1ScPpI3D-mkx02OQDjDFBdPRyUXWWCGDgeipnE0W3zfgBo7MyBAaQ2nZjXLvtFUzDTEWTtD4Tglw>
X-ME-Proxy-Cause: dmFkZTGle8Mdmvjg4uoUp4qhFARewTUlZJoLj2ZOVXEOMVP2VMVd8E7uww85dXVRA/h+U0
    bL4VDxpYBP1Hc7RQ8rj6K0ma92qWOTiQZqlmh/T8lOFn0y7JGBw364KbQyiui3fAgF8fhA
    WY9tK+/fPTyhI+/ZDV8+s2mfTx12G0gL+X5THCK6MdAce00iElWtcPCfNY/wVegISPGNYg
    /hDr1K5PlArwuQxH6bsCFAgmar0nHZn7XYDC8XKZtcF6e2Lbw0iEZYxRj3ff7680gY4eQz
    Za61cNYdCiT4RN7ifRF7LOIgWlBxa5CkXZhXpAqWy9jZ/qtvuiwCeDGlFdQl/erGWfuAFd
    kXNaIupl7BNAfk032FhxSh8itlX6RViGEW7CsgqClsslKFvK0Yd8lNTsCJIxHSem/849EQ
    MJbxSsiDIyJYBU32rOiibbWIgyDjgg1CNOQvftYMrbaEWD7x30FPdMeR5W3XElW+hlRrW3
    MU5itF4kTb7mPX50cZM3dcuiOiRoDsllsfjcjQ6fcvNJOuCMuVq05C7DqxqYZw5PcXHvCJ
    Ym7kVMnWd1pr/TddwtSMhbXkmfR32ZzzbCu6FjOn6l0v8MKPBiFs4lcJcsjSzwFMl7lWWM
    9L5mjRtLHiyqR+U12LoZZAN2ZUcrTyMtI14YEZsUOqS05LRAqb5CkNAaTEBg
X-ME-Proxy: <xmx:DRYWanuy8TQ_aAgbiHTd0Sk2mgUWZM5g-msWuUh5srX_TaLL9X823g>
    <xmx:DRYWah626JEFDVdQOeIsha0O9bbb7dBWlc012qj7tBreYmUH4BBchA>
    <xmx:DRYWaqXM8mlF_DAk7LxdZMMxqwTcactABqC2tBSpGFruZDKaz65kOA>
    <xmx:DRYWar9zRIYzm4hxj-GVIRjQQZqUXzUx1WDlO_9Z4KcxKM8j2RuHDw>
    <xmx:DRYWan04cH863adY0ZbowjV9FcGyIDXTy5pFDmIkkWV6q7DpBoMugMZk>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 17:52:11 -0400 (EDT)
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
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Benjamin Coddington" <bcodding@hammerspace.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 02/] nfsd: fix minor issues with atomic_create() use in
 dentry_create()
In-reply-to: <40cb481d-105b-408d-969c-9aed9199708c@app.fastmail.com>
References: <20260526053004.4014491-1-neilb@ownmail.net>
  <40cb481d-105b-408d-969c-9aed9199708c@app.fastmail.com>
Date: Wed, 27 May 2026 07:52:08 +1000
Message-id: <177983232870.3379282.1364318067313942375@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21992-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ownmail.net:dkim,messagingengine.com:dkim,noble.neil.brown.name:mid]
X-Rspamd-Queue-Id: 16BA25DCE94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026, Chuck Lever wrote:
>=20
> On Tue, May 26, 2026, at 1:27 AM, NeilBrown wrote:
> > https://sashiko.dev/#/patchset/177969022571.3379282.16448744624428323496@=
noble.neil.brown.name?part=3D1
> >
> >  reported a couple of edge-case problems with the use of atomic_open()
> >  in dentry_create(), called from nfsd4_create_file.
> >
> >  These patches attempt to address those issues.
> >
> > NeilBrown
> >
> >
> >  [PATCH 1/2] nfsd: fix possible fh_compose of wrong dentry in
> >  [PATCH 2/2] nfsd: ensure nfsd_file_to_acquire() does not use a
>=20
> Hi Neil -
>=20
> These do not apply to nfsd-testing. Where should I apply them?

I created them against nfsd-next, but I just tried applying them ti
nfsd-testing with "patch -p1".
The first works perfectly.  The second works with
   Hunk #1 succeeded at 1181 (offset -46 lines).

Is that what you mean by "does not apply" ??

Thanks,
NeilBrown

