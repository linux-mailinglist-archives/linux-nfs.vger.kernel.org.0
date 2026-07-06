Return-Path: <linux-nfs+bounces-23126-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7+ISKM46TGr3hwEAu9opvQ
	(envelope-from <linux-nfs+bounces-23126-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 01:31:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFA471650B
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 01:31:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=iKzzBdF6;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="e igTpDc";
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23126-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23126-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 500C03037BB6
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 23:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01FF422559;
	Mon,  6 Jul 2026 23:30:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FED93F889E
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2026 23:30:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783380603; cv=none; b=FqwZ/WaoFiqWCHRQ41mra5NLGHS/xL4PdTuPMG6+cS7NYTQVyk1wvcjozGxUsugqDhxe7OXOQnecOznk3w+GtDTY0oIR3YYs0o2ZjT2SzAn7ZOHwAh94M9x/oxYh2JqvVi2kZqwYitLeyi4aayQpudtP5GU5uTomvS/7EttGlKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783380603; c=relaxed/simple;
	bh=uCcc78rzoGkRK52bLYGJSv+oCE9PJ0a43OoZFGdPt1Y=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=SZR7O7hTGe++5+vXJ3IAeCHEdGm/mfRLqPz+hxcOQUSOngi/keuNvlYfbyItaw2bDqCxusBDn056y0QmNt9gfxihWvvskHgDcW86b+E1ollCU6qnGuxOEGXVRMP8O9ZAhGswZd1X3YlewGpZRr6YcX9W4ObF7KaUbCPg1ZrgyoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=iKzzBdF6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eigTpDcE; arc=none smtp.client-ip=103.168.172.147
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 957C0EC0232;
	Mon,  6 Jul 2026 19:30:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 06 Jul 2026 19:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783380601; x=1783467001; bh=VD3ZB2Z1V1FVrhGH7RLZ3f2bWNjU93PH2pP
	c2MK8dg8=; b=iKzzBdF6nRmTsHiKQ/zcGiWgjoMK4enPHs5UI/T0tzWiQv1Wuus
	rwYtm9rMA9GU4+NytNqvpb1dP10Ji7G6gLgcFyrrY8tN4oQkFiRuTGuyG5nuYxxy
	PLKQBmHCKOGx043JAUkPQ2X5H6AsS+jcg7/dCdvT+rtZzALShC0ykZVGDPTqwDc0
	A6TQTgl8r0FIvX1+MH9a6DtE7WbYbytPvFMpjWy98mCIgYivjgLcG3yY9NCZMmKl
	h6kqiGbE9t/GblXxkBLHfcCa5orlkFjmFprh9/DXhGt2YUJFTUZqQ7EF1EfqD9ly
	Io/9ecaahhIgHKq9BmeGsqEvU8YXucREu0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783380601; x=
	1783467001; bh=VD3ZB2Z1V1FVrhGH7RLZ3f2bWNjU93PH2pPc2MK8dg8=; b=e
	igTpDcEJLfhpKPdAQQO6bZU5YQs+th0Us9+2v8w0/kKhjZ56E1IzOFHfbOif81qi
	yRSaOl0KrEo+caLhSCuBsXEuZ1NbQM+QcrmWPDpWgLfOA2fV7mDv+9S90FT6Q4ng
	1slUu1ICGLJM36UwpF6Iecxe81XjHtFvj3IkvM+cdwu10oaRzM23Hpe8BUxkCjDD
	WqZT+MgsYRR5Kj9NRrFGIoGsESgaRVeEDeTAGhDUXgW7Drd/X0ifN4oRX/NVbHtO
	tAtNKkl22QdGUhlKMudns6awU9TtRF1VL/JiZSPTG2zv2ALjbbz57WYnKf5U8c+M
	nWDmvqK5cX0dEc1Ury3LQ==
X-ME-Sender: <xms:eTpMav6N6qjXsBKycWeN5EMgrF_OLXZnH7aaT6hXUtjNMfMoLGH_CA>
    <xme:eTpMaonqCclCj2DWeA2oUvxa4ei6Vp6dapDhd7y4WNsB5LYeW9E4UHcoEQNGK31c6
    hkEZSGXHFWnn5--wsO6TSW0Dvvgp5sAX-IFvh20w0sj7zufBg>
X-ME-Received: <xmr:eTpMagRN_85fqNck2QABc_D3P9fVDBop5ru2FEAuphPTZHiAZuE2x2kOFYS2SvMnOoLrsmlgG9_F5qWIZqfBFH2tE9dbTdA>
X-ME-Proxy-Cause: dmFkZTE3P7kCw0ubw1PF8CMlGxNXQ+eiJydmPKKX1SPSTosI5fDN84JdGGp9May30JjwbZ
    jqwo0xdy40NuA8YEOI7x37pCpJcrY3tBImm0w08NCx7fWis6YsQiBM2u7GDuwD9G+7AUVR
    0KA9wJJw+ots9vc7HkELJBvh7XD/cVM63DoTRlFpWdcTKxjsB0CXsB3NNJEgVRZgxf1uuB
    B6F4D6LQnuaycwcAajp3+NZHOpE5Kf+lahWCKQIQwfmlJAN9YMUk9EFEQja2kv97jBEHhY
    eNIUCwQb7el5RSzmX+r+4frw3dUiBuHtsupMWsxd7H9KrWPOnL4ZCzPWBmsNhNo5cRi9ml
    PDWDi5iIlhgayTW4VyCmQVsTPVHH/DqLpPEzq35wUzSmXVGHXK5KeTmob3xGjYpXqVIR+I
    k/j56ZvIsEpoEOUJuA3f3lGaCMVBmKAfp99ll37C4HYRhyPIITDzgSXFvmb626YNsBA+m3
    R9c7kiO7SfHSDAJx6rBGSZEaigvogUHEhaDwnpNuDDiGFGEiCov+93VqeqLE1SzIRKo+T3
    n20jZVU0RuejkuV8UhSp2Yq18kljAruY01YKaM2pKKiZj1RgWmR9ga+eV/JLUSXSXThV14
    yCceB1i7A3LscMSbhiRZa3cRJLe8RXxp56+YY/wG/+6JQei+IriUuz4kDtZw
X-ME-Proxy: <xmx:eTpManHSgt3KcM4PnfZGMUbmLdmuZantWnyuRN_psbYt5cw_3kmn9Q>
    <xmx:eTpMalHvZj5KpzzH3tn0wvXYcKLbLFGQe6-kz49r5lgsBV-MkLjKdw>
    <xmx:eTpMalTKsnjsO49Sea60yei48OeXHtxuoTHeB_npjGZXsLb8aCY2gw>
    <xmx:eTpMamIUYHG0Zm9omzTdFXiCrXVVETTtzYYJvxWPLkGATguToP5Utg>
    <xmx:eTpMapaIEvn5VAM2kVfDV3Qiq4HauCABu3KWRdaLqqS2FK_0iZu9-2wO>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 19:29:59 -0400 (EDT)
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
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 13/14] nfsd: separate out VFS-specific from from
 nfsd4_create_file()
In-reply-to: <6f9f29157871d413bcef1531653b2d6811d8aa02.camel@kernel.org>
References: <20260705222032.1240057-1-neilb@ownmail.net>
  <20260705222032.1240057-14-neilb@ownmail.net>
  <6f9f29157871d413bcef1531653b2d6811d8aa02.camel@kernel.org>
Date: Tue, 07 Jul 2026 09:29:57 +1000
Message-id: <178338059716.27465.16799060247419032525@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23126-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:chuck.lever@oracle.com,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,noble.neil.brown.name:mid,messagingengine.com:dkim,brown.name:replyto];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAFA471650B

On Tue, 07 Jul 2026, Jeff Layton wrote:
> 
> My Claude spotted this:
> 
> Should this compare against nfserr_noent rather than NFSERR_NOENT?
> 
> status is __be32, and it is assigned from nfserrno(-ENOENT), which returns
> nfserr_noent.
> 

Thanks Claude :-)

NeilBrown

