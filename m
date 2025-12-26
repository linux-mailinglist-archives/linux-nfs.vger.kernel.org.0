Return-Path: <linux-nfs+bounces-17311-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE2ACDF1E9
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 00:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B45B13000B4F
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Dec 2025 23:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187A418E1F;
	Fri, 26 Dec 2025 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="KjPKd08N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KpfSIksF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D65414A8B
	for <linux-nfs@vger.kernel.org>; Fri, 26 Dec 2025 23:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766792698; cv=none; b=R7frYZiF7a2Nf7CnInKcFZglijz7tuIgOp8IEuzdurngr+vHHK21iQRN1jlS3MWNmW6OLF6TZFfjx0Tx5O2vvWEv2sfA2k1QKLSGS9DrgRaEi2WdU3fIdvv8At1goloAzKxrIatmMX9TadleFi5AF2ADJ4nS9oNYqwRFA2sgtPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766792698; c=relaxed/simple;
	bh=1s6x8kuwV2HHet2kl0TydpnjAV2+meg/fWKHN/jReGA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Kzwno+IBG9vs1u8/mkwEoX3/z38KibSJKXiomQ6TjpPuGJd/nyurvVR/XsX7bQ+TOzrXJ135GYwVs58y51408EJXsQO+mU/rO/KJnlqIrdXz/9kRBbydTBGEjdg3VMkwaJzI26QbRkkHHC1MAf9kD+NaFQCGTslOmmzEGBCj7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=KjPKd08N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KpfSIksF; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 66F351D00065;
	Fri, 26 Dec 2025 18:44:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 26 Dec 2025 18:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1766792694; x=1766879094; bh=e1CzwFA+CBYTY+96YU+5y00PCuvYHtaVuA3
	mCtgWAgA=; b=KjPKd08NmD+Eh6DgbZMMwT660pA2pPqgoRY0+/Bq3728G5Y/Tjh
	UuDKwqvpmQqByhZ9ZKxyELdBULoMlFwICyx5LVtX0GNsK/NFaslFC8aROqHdg+07
	Sbvd/i0AEboEX0K6WAyfGtFEVPhmSdoJ8SonP14QCselyoPsv8FG0PMZJeV2Ie7h
	bjmWcwOj1aioh5wR1oz9SXUWgu1oRmbfhD/6AikmJeD9RD6jxJWNbvybCx155rdt
	v3K3apqkWM2Df288RRDribpfcZXBPZWr8ti4KQXsM/YfDGfNDi1Z9UQCBHgDzy+R
	eTVSvGuRPAddpI+7tjdeLUzP3M1Kv+3MTbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766792694; x=
	1766879094; bh=e1CzwFA+CBYTY+96YU+5y00PCuvYHtaVuA3mCtgWAgA=; b=K
	pfSIksFWdUEeFQWTIklhFWK7IruUKu/LoVbiFjaWGn19ymgoF+YEsGdhKbbHDlc6
	0uP2fj8NdiIOcTC8799r+fYO0AAVGHmblsMLPXkCIHgOr3FgmJhqM3IyAHmq5OzU
	jajpSprHpysM8iYdrSKrPgSBEcaNo1toYQeE/qrF71LJ8hFkerSZ7ZFkCs1olbuh
	g06/0W9xclN/djncID3Ain1ezIGFZ5sPUm6AR6zJawQhg6LLG/Zs8Tz99iwGLWKe
	QcdLdckojAXNKimKJRrTnV9cHGzW2aLgqDlTTiAfujW7Y7mIN21GnycFaCH35FFh
	s5uvzmBFDF+KMJLc17HUA==
X-ME-Sender: <xms:9h1PaZcf-ExNXYKXA1oKLxh7_J_eCb6P3trCJCC5PunLQFFNTiTahw>
    <xme:9h1PaZchCcIeRJUPIVWLbn2y8GpffJKKOLi79DXXlWxXjmMB_4zTp2z7wyfQmNcVr
    EJ7_PAAp_ILYjR2rZvHAM73hAd9ukTyNwUqH6qZV7TsQrTF6Q>
X-ME-Received: <xmr:9h1PaUzTiKagtT_q6k3y4sEDMNyuw4TksvjyW__N2ufaYujcZ8GBu71qoSF_XRJopVBr4yd4GKLlNoepyA3abEPtZvYNEEbrXvLhYY35xVS6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeileekudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:9h1PaY-t1xb4sDd0F6Leo2lvRyFQGMhaxkoNG71v0SBDAV6G1OkARg>
    <xmx:9h1PaUg0TMnn1OttCbbDrwdc7TWnEyaJSqRPFzTAgLO5Gm9Q4TUtRw>
    <xmx:9h1PaXFSGCEo6Q_PxuhyRevGv8VCTI5fvYmiLdbRzM1JQgYlC85KRA>
    <xmx:9h1Pab_7cmOwO6wYEg2jmdmCAqQu06hzQkDfudNo0inkxC75dHTjLw>
    <xmx:9h1PaRLKwJYd4gZc3RJF2KFdBnQDA8hSlDQDXhF20z0CrE2YapiYMt7d>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Dec 2025 18:44:51 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject:
 Re: [PATCH 3/3] xdrgen: Add enum value validation to generated decoders
In-reply-to: <20251226151935.441045-4-cel@kernel.org>
References: <20251226151935.441045-1-cel@kernel.org>,
 <20251226151935.441045-4-cel@kernel.org>
Date: Sat, 27 Dec 2025 10:44:49 +1100
Message-id: <176679268968.16766.17613591475642801974@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 27 Dec 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> XDR enum decoders generated by xdrgen do not verify that incoming
> values are valid members of the enum. Incoming out-of-range values
> from malicious or buggy peers propagate through the system
> unchecked.
> 
> Add validation logic to generated enum decoders using a switch
> statement that explicitly lists valid enumerator values. The
> compiler optimizes this to a simple range check when enum values
> are dense (contiguous), while correctly rejecting invalid values
> for sparse enums with gaps in their value ranges.
> 
> The --no-enum-validation option on the source subcommand disables
> this validation when not needed.
> 
> The minimum and maximum fields in _XdrEnum, which were previously
> unused placeholders for a range-based validation approach, have
> been removed since the switch-based validation handles both dense
> and sparse enums correctly.

This patch doesn't only update the code generation in xdrgen, it also
runs xdrgen and updates the nfs4xdr_gen.[ch] files.  This results in
changes to those files which I wasn't expecting to see based on the
above - specifically the removal of semicolons, presumably due to a
recent fix to xdrgen.

I wonder if updates to generated files should also be separate patches?
Or at least the commit message could mention that xdrgen was not only
changed, but it was run as well?

In any case the changes look good and valuable.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown

