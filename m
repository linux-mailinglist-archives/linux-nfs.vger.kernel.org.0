Return-Path: <linux-nfs+bounces-21392-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNC2E7r/+WkqFwMAu9opvQ
	(envelope-from <linux-nfs+bounces-21392-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 16:33:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EAA4CF7A2
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 16:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7F1530BD8C3
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2026 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73B8317170;
	Tue,  5 May 2026 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g29YKCzX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944132DCF57
	for <linux-nfs@vger.kernel.org>; Tue,  5 May 2026 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991185; cv=none; b=inWt9MaBjLlu9vYcAfwInMOG9Izai7ftf6IgL6Zqm5PlBWveiwFDwNMQVaN3XuBlHuucu4TIoB7Bubuk+RrSAOC0WD1C1UaE+P4sp9j9gqAuf5NXlQimfn9mRR1HscwWTBQFwbWujsR/tNNsODYNHl8U6IuO3pLA42dW8QuEK+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991185; c=relaxed/simple;
	bh=hHDxMDbcOICbeHkbMwDKtATlUWyCSh8XOo7Y4Zkjrbk=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TYp7zvdrzzYo5VrpjyVd70a4i7tSXV8sCbWQsqv9arFMO6afuxn0/GipyjNfYdUW+P1aDUvd0psy6IkX4d517U6JGasPga3hRE8Qb5NPAd883T5L8g8xiaUzxrYN3eszGFrMTcxEmmUTwqZwio+d66n6fcOkgq4YpMp9F/c6HYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g29YKCzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD70C2BCC7
	for <linux-nfs@vger.kernel.org>; Tue,  5 May 2026 14:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777991185;
	bh=hHDxMDbcOICbeHkbMwDKtATlUWyCSh8XOo7Y4Zkjrbk=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=g29YKCzX3O8v2KcTKx7gYsDF//l+eG8Amtu1MktEMhljXmV2U02ttFSBGR/tp6Kc6
	 +zvfV+qcLlNTsr5BuGT92FMKcUOXX0dbV8jh47wFeHNBqxCaE/O2wD+55Nz+gnX/ud
	 QWblRyxRfvViQWQfj+Od91zFXSO+kBIFYPaeDWVvzF2aqN7UkIZrRIC7flDDM7igLS
	 hyDqxrftl99bqzoSO+6TAfULrNiLd010IQL572nRFVoU4PyyhnuOeWLSf1meJFizLZ
	 2nqSEr0LUhp/r/KgNMaPs36TVFzpaB5nJ7/3opq+DRGJtjVH80FkbJEHnch5In3zd5
	 6xexTRw0jyQBg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 14957F40077;
	Tue,  5 May 2026 10:26:24 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 05 May 2026 10:26:24 -0400
X-ME-Sender: <xms:EP75aZh_vSuvFW2JhGUYx6Y_s8etGO3huA6ckV-4PpvMpefj4iYoGQ>
    <xme:EP75aY23ACwIRCfkQ1OGR7R4Gtm7UkmK2XWNNJxAKyAQrH7jYmUEyr5aZafVHb8KR
    I9X__QwIDppgfviMLcANqrN_ql_VUxBTEdDyNmMjAAX-E-k93PA-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdduleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epheehjeelgeffffeihfduudevudeghfehheefhffgueeluedufeetjeduhfdukeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgtphhtthhopegthhhutghkrdhlvg
    hvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehsthgvvhgvugesrhgvughhrght
    rdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:EP75acL3J9751oWBYgUlJw2Tt1HRBo4ogIX5A-43yKaX4m05rwctCQ>
    <xmx:EP75aZ_XlPsE0MIXF50McmovIL167sItAWqzs6P_GpyjjpWWeaQEoA>
    <xmx:EP75aXLe7S34yocR7wQO6MByP2-92heMj_itN7pYFGavOp0X9PpPPA>
    <xmx:EP75aWlw0H_i0tFzEUrMlo2XTWXnLSPtfPULZMpsyg3iSZraNTVvVw>
    <xmx:EP75aTNGdecvBu1qSheCacH3VyrGO1LOiFQIXV4eHriSs4zIo2UwZLhb>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EA832780075; Tue,  5 May 2026 10:26:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AS7wAvRKFMd7
Date: Tue, 05 May 2026 16:26:03 +0200
From: "Chuck Lever" <cel@kernel.org>
To: "Sagi Grimberg" <sagi@grimberg.me>,
 "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Steve Dickson" <steved@redhat.com>
Message-Id: <de87d03d-a58b-43c0-8be2-997e8180339a@app.fastmail.com>
In-Reply-To: <20260505142038.52921-1-sagi@grimberg.me>
References: <20260505142038.52921-1-sagi@grimberg.me>
Subject: Re: [PATCH] nfs.man: Document mtls mount parameters cert_serial and
 privkey_serial
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C9EAA4CF7A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21392-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On Tue, May 5, 2026, at 4:20 PM, Sagi Grimberg wrote:
> Two new mount params for x.509 certificate and private key pair used
> for mTLS authentication. These have been added a while ago, document
> them officially.

NAK

There is a very good reason they have not been added to nfs(5) already.
As I stated before, these are part of an internal kernel-user space API.
They are not intended to be user administrative controls.


-- 
Chuck Lever

