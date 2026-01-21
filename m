Return-Path: <linux-nfs+bounces-18273-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK61K6NVcWkNEwAAu9opvQ
	(envelope-from <linux-nfs+bounces-18273-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 23:39:31 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9825EF2F
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 23:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5B6F6231A2
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 22:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD17D441035;
	Wed, 21 Jan 2026 22:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="H7w9ZHMi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="giMVijL4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E7D449EA1
	for <linux-nfs@vger.kernel.org>; Wed, 21 Jan 2026 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769035072; cv=none; b=csjIWNyX8CkelEcuuqOhnNW8bP4slZflrv9YM7GwrhUL2Ic7SKCBI9FurdTn+KoY9YWTlQPuicjigXSINSiZbiorhaKQvfF4WZvSqyZzvk2l+hHHq+pWaIAucHqYxHu6xxwLvpM4GzLR3QHZDDUT+xqQN2bxxL37jEE8BSXif6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769035072; c=relaxed/simple;
	bh=hrhInEO11vbLMyGSEYfNYSVcxFhbNZnCa7f4SwUdGTA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=HM10iE/RtmKWSNG8dYjP6mjK2FJ0uL4p9bLtPY20PSRAuTYPkcDUIMtcpif4uZIc1Yq+17EQVLqK0QPOAZ1iyWWrderyhoWjr1nO0hTC1c6Hk+cPETmi1L3XIns7Gql3maI5CgkGBRpGbbUl5V++tAjVJ2mzP4l32vhnAiokCVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=H7w9ZHMi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=giMVijL4; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5F0AE1D00030;
	Wed, 21 Jan 2026 17:37:48 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 21 Jan 2026 17:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1769035068; x=1769121468; bh=qifGQTigjplo6KHwJO32t93dC1VH4Hqhqmr
	gIbxj6U8=; b=H7w9ZHMiBlcNEoN9Llr3emiGl0R5Qal8mGSH6tZfjL4ov0/+Mgo
	XFhqErur8r0TWPRI5i3XkZAtg0clV6xOQ2epXJNQSAA/lMGApmz+1NncYhMPR/7O
	/Dz4WSNVlzN8EyUhJ1+OQ2MxwiioI1jWhVH4lp3lgJ611YNrP2AUSTcktk+/qPtL
	PUpJmi6T8eK5femw3I23ThqAAQ29m+0UaBbwd/quCXxRiTfHkxLUFfz06WWV4d/Y
	4wxT5JZLxXZqBsNN2fy0BKhzdwNxGP7QrcognfxdK0XA2SNk1RPap9yod5UM5j2Q
	p0o1glMnUzCB9gnnQRxfUWB7kWU5FmCizcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769035068; x=
	1769121468; bh=qifGQTigjplo6KHwJO32t93dC1VH4HqhqmrgIbxj6U8=; b=g
	iMVijL4Nr/DKOV3DyGKnxAfSB1dsiemfIZz5d6fJTlvYFmT4yE2XSFl3Wa2e39J9
	A76JuLqyFbspsZEqjDE/YBBotmoMi/7lO5gvmeQrj9iZ/hofjCgc/BgoxyBd9+o/
	BcT3wHdNa7dFjULCtUAeVUyINjLVyI8N/zGZFdOzQaPk/aq+KtCMR1pjWv+UOp3E
	06hhvOBUyECvXT6LZ3nkT+A9pja+JRpKPFAJ+lyG4uFm7woWkt97f10euuFTZ+eV
	LZqh3QnAQDTAu2y7RnryvBQDWzUYh0nr4dJLPTeVJTF62ZNs/RK3gNQ74WTAfhKR
	rL2I7ex4G8Gvg0epJjUnw==
X-ME-Sender: <xms:O1VxaVff5hJGqhhRb3XhYmBCnUTQCLPkB1Wdvg3Gf2g76MUT9nRPzw>
    <xme:O1VxaaEoVuokexPa0CzEVCQO5tpVUzl4b00Vg1-M79MjXFuZ8XLEuBY-k-53Y0dMl
    pNJv0Wf6Qb2XKHjYtmZyFhu4Hyax9K7HjSKskPxyUr8Tfq7oA>
X-ME-Received: <xmr:O1VxaW2FruSPbZ-SDsFSr-ytRY_2zNi1S3GdnftRkyj7WQYIbVsE9S8-WiqUQrm1V6mCY5p8g3oUkhjDZkFL1IIIYO2LZgBisyQxRWR_M9qo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeghedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsthgvvhgvugesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghh
    uhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggtohguughinhhgsehhrghmmhgvrhhs
    phgrtggvrdgtohhm
X-ME-Proxy: <xmx:O1VxaannSzY9FeGKj4S2CmhgKbOljsrAujlJOB5PNrnjOfu4C_wRPQ>
    <xmx:O1Vxae81VaModX_sHhcRcPNaDuWZJkC0-0Qpvis8xysJ_kYGbyBj2Q>
    <xmx:O1VxaXoKDRhtTF6AX5V2MOwR-QvcmUAcpSYCXuc0x78Q__ixTptbSw>
    <xmx:O1VxaflZqL8bV063CNQFC5lwnbE4pC8KenjxbalEDUt4d5q5aHRbiA>
    <xmx:PFVxackThP34poh_NUsxTqPRfZWK4h7E4c7O6HqYMqDp3aJ-8S3N2CaI>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 17:37:46 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Steve Dickson" <steved@redhat.com>
Cc: "Benjamin Coddington" <bcodding@hammerspace.com>,
 linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v1 1/2] nfsdctl/rpc.nfsd: Add support for passing
 encrypted filehandle key
In-reply-to: <f2c8d058-7a9b-49ab-bc69-c2b7c58f4b89@redhat.com>
References: <cover.1768586942.git.bcodding@hammerspace.com>, =?utf-8?q?=3C90?=
 =?utf-8?q?fad47b2b34117ae30373569a5e5a87ef63cec7=2E1768586942=2Egit=2Ebcodd?=
 =?utf-8?q?ing=40hammerspace=2Ecom=3E=2C?=
 <176868679725.16766.14739276568986177664@noble.neil.brown.name>,
 <8328B53F-21DE-4237-AF79-5DE88D53D8B9@hammerspace.com>,
 <176877755694.16766.8795981876133751749@noble.neil.brown.name>,
 <f2c8d058-7a9b-49ab-bc69-c2b7c58f4b89@redhat.com>
Date: Thu, 22 Jan 2026 09:37:42 +1100
Message-id: <176903506227.16766.5961817427243568368@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[ownmail.net,none];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	TAGGED_FROM(0.00)[bounces-18273-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,messagingengine.com:dkim,ownmail.net:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Queue-Id: DD9825EF2F
X-Rspamd-Action: no action

On Thu, 22 Jan 2026, Steve Dickson wrote:
> Hello,
>=20
> On 1/18/26 6:05 PM, NeilBrown wrote:
> > On Mon, 19 Jan 2026, Benjamin Coddington wrote:
> >> On 17 Jan 2026, at 16:53, NeilBrown wrote:
> >>
> >>> On Sat, 17 Jan 2026, Benjamin Coddington wrote:
> >>>> If fh-key-file=3D<path> is set in nfs.conf, the "nfsdctl autostart" co=
mmand
> >>>
> >>> ... is set in THE NFSD SECTION OF nfs.conf
> >>>
> >>>
> >>>> will hash the contents of the file with libuuid's uuid_generate_sha1 a=
nd
> >>>> send the first 16 bytes into the kernel via NFSD_CMD_FH_KEY_SET.
> >>>
> >>> This patch adds no code that uses uuid_generate_sha1(), and doesn't
> >>> provide any code for hash_fh_key_file()...
> >>
> >> I forgot to add the hash function after moving it into libnfs to make it
> >> available to both rpc.nfsd and nfsdctl -- here it is, will fix on v2:
> >>
> >> diff --git a/support/nfs/fh_key_file.c b/support/nfs/fh_key_file.c
> >> new file mode 100644
> >> index 000000000000..350d36bf8649
> >> --- /dev/null
> >> +++ b/support/nfs/fh_key_file.c
> >> @@ -0,0 +1,83 @@
> >> +/*
> >> + * Copyright (c) 2025 Benjamin Coddington <bcodding@hammerspace.com>
> >> + * All rights reserved.
> >> + *
> >> + * Redistribution and use in source and binary forms, with or without
> >> + * modification, are permitted provided that the following conditions
> >> + * are met:
> >> + * 1. Redistributions of source code must retain the above copyright
> >> + *    notice, this list of conditions and the following disclaimer.
> >> + * 2. Redistributions in binary form must reproduce the above copyright
> >> + *    notice, this list of conditions and the following disclaimer in t=
he
> >> + *    documentation and/or other materials provided with the distributi=
on.
> >> + *
> >> + * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
> >> + * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRA=
NTIES
> >> + * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIM=
ED.
> >> + * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> >> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,=
 BUT
> >> + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF=
 USE,
> >> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> >> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> >> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE US=
E OF
> >> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> >> + */
> >=20
> > I wonder if it is time to stop putting this boilerplate in nfs-utils and
> > start using SPDX like the kernel does.
> Would there be legal ramifications to do this?

Maybe.  Certainly it should be done with care.

As a first step we could consider requiring the SPDX line rather than
the verbose license text for new contributions.

>=20
> I remember a time when our legal department was
> not happy with the copyright verbiage we were using.

I suspect it is the legal deparments job to not be happy :-)

> >
> >> +
> >> +#include <sys/types.h>
> >> +#include <unistd.h>
> >> +#include <errno.h>
> >> +#include <uuid/uuid.h>
> >> +
> >> +#include "nfslib.h"
> >> +
> >> +#define HASH_BLOCKSIZE  256
> >> +int hash_fh_key_file(const char *fh_key_file, uuid_t uuid)
> >> +{
> >> +	const char seed_s[] =3D "8fc57f1b-1a6f-482f-af92-d2e007c1ae58";
> >> +	FILE *sfile =3D NULL;
> >> +	char *buf =3D malloc(HASH_BLOCKSIZE);
> >=20
> > Can this be
> >     char buf[HASH_BLOCKSIZE];
> > ??
> Isn't better to keep things off the stack? But is only
> 256... so it is probably not that big of a deal.

In the kernel, 256 bytes on the stack should raise questions.  In user
space I wouldn't blink below 1MB if the code made sense otherwise.

NeilBrown

