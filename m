Return-Path: <linux-nfs+bounces-21345-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3XtoNbtq9WkWLAIAu9opvQ
	(envelope-from <linux-nfs+bounces-21345-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 05:08:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF744B0BF1
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 05:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2D393006B57
	for <lists+linux-nfs@lfdr.de>; Sat,  2 May 2026 03:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E5C2882B7;
	Sat,  2 May 2026 03:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJqBkoC0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF11DD525
	for <linux-nfs@vger.kernel.org>; Sat,  2 May 2026 03:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777691319; cv=none; b=rKcGO2Rt6fyOqpUB7FB08BuXuifVjSqYtwfBYHrNP6mwd5G0BA4WW7VVjSCvXZnKxNQYUglqZxZdUWiJLu+0DMfZDiF90iSuK4FS5NEf19JEki0scXS6CAF13kkSCrO9Mt9xvtu3XxesMWB9wES60WKgMw4WQ7Rir5ySWr3ZJ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777691319; c=relaxed/simple;
	bh=sFyrLC9upT0uJJdxa+5HzcrCgFXbBVeGIvPFfFdxypc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XYBXxxTcECIIGZSnz//I4+OpURMK3y6mOubqTg6QvLt+IAKbeOZBVJmCdc2FFDLaVugk54tZ3TvjrALo8+e4/mVBSF8nP9MDQJkxIdVT2oi/XtxvuFcv/ICTMgFTORG55kvvSA0PQw9XqxsGVm6n7JrfuKnxHRe78CVwVKmWoUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJqBkoC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCE2C2BCB4;
	Sat,  2 May 2026 03:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777691319;
	bh=sFyrLC9upT0uJJdxa+5HzcrCgFXbBVeGIvPFfFdxypc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fJqBkoC0ndlpbtg+JF4MbJdw4W1RfoJ1DtFmLtR9HyX0u6RwuP8q787tziZdVIaER
	 xjSyOk6QC4BBbV61sV1y+EnPefALBldU/6ibHEfiWCtbxdVi0Om1kPjFuKz+yJAhN7
	 N9Oh18aDZG1uf+KyZXrhiV/tS1m66eLsOiD0P1VJCPc9fYc9clYmYQRX37yOVNfc2a
	 92nWrnRS9/DeBkA1MWK9WzGr1or7LWL6KBoiw2h1Oeg0flJoZWmAX89Eh+hf1D2yR2
	 rxHN+g6FmwHndsLBQwA/A/cGfejk1ERaEDrW8Rh3aX4HhJbOYhjW0mpKj6LhCKHrnU
	 ubbFjQGZt2FvA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 09971F4006C;
	Fri,  1 May 2026 23:08:38 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 01 May 2026 23:08:38 -0400
X-ME-Sender: <xms:tWr1aX4L3PicQwoZYbyUe-2RLzJ8GsIstLtFYmw5Likm3siT6oiYPQ>
    <xme:tWr1aXvsul8-9jVQ3mEvNV7Wip1h48KSrXq2eSFlz-T2pxChDEI-VTUf4n0Yah5PN
    xjUR1W4uAwMkGea4xI__u3HBn9A-eSIfcOZg_lLqUHrVmJeskZ5ito>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeludeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgffhgeeutdeiieevuefgvedtjeefudekvefggefguefgtefgledtteeuleelleetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgtphhtthhopehkvghrnhgvlhdqth
    hlshdqhhgrnhgushhhrghkvgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthho
    pegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehsmhgrhi
    hhvgifsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:tWr1adHttIMD6zoUP30sRf_rxl6_UQFmErVThEth1b3C-FDwbVlm3Q>
    <xmx:tWr1abRhWyCjjVw68B_jybBi7c1qOHh7HYZ8toNNS4bC5I1qF-mG_Q>
    <xmx:tWr1aauZ2WCtPOfipMazocNsJaCuN0jNtrdzAV-rIj8Gk57uqfwP1w>
    <xmx:tWr1aTJRy6df7lO6EJ0zdqEbjXnK_KyhzDmvkH0hkKuU2NXr7imNaQ>
    <xmx:tWr1afnYX5sfkVZrISTUiV8zbqRlbZ0bgvQUiMYEJoR6h2FTLnGDERFN>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CCD52780070; Fri,  1 May 2026 23:08:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ak5ktnwSWV1c
Date: Fri, 01 May 2026 23:08:15 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Scott Mayhew" <smayhew@redhat.com>
Cc: "Sagi Grimberg" <sagi@grimberg.me>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 kernel-tls-handshake@lists.linux.dev
Message-Id: <7c6516be-adb9-4d0d-ba7c-fa107fd4a865@app.fastmail.com>
In-Reply-To: <afUKzeUYPhb97DX4@aion>
References: <fd4aaf4e-b1b7-4ca2-bc93-955c31fab317@grimberg.me>
 <92a53963-1e4b-42eb-af81-6be9f63f9e43@app.fastmail.com>
 <afUKzeUYPhb97DX4@aion>
Subject: Re: Breakage in ktls-utils with nfs keyring?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6DF744B0BF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21345-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]



On Fri, May 1, 2026, at 4:19 PM, Scott Mayhew wrote:
> On Thu, 30 Apr 2026, Chuck Lever wrote:
>
>> Cc'ing the ktls-utils development list.
>>=20
>> On Thu, Apr 30, 2026, at 9:32 AM, Sagi Grimberg wrote:
>> > Hey Chuck,
>> >
>> > Upstream ktls-utils fails passing client certificate and private ke=
y=20
>> > using the .nfs keyring.
>> > Bisecting leads commit facd084e43fc ("tlshd: Client-side dual=20
>> > certificate support").
>> >
>> > I manually apply this (probably wrong) change and keyring works:
>> > --
>> > diff --git a/src/tlshd/client.c b/src/tlshd/client.c
>> > index 2664ffb..a946797 100644
>> > --- a/src/tlshd/client.c
>> > +++ b/src/tlshd/client.c
>> > @@ -327,7 +327,7 @@ tlshd_x509_retrieve_key_cb(gnutls_session_t ses=
sion,
>> >  =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> >  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tlshd_log_=
debug("%s: Selecting x509.certificate from=20
>> > conf file", __func__);
>> >  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *pcert_len=
gth =3D tlshd_certs_len;
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*pcert =3D =
tlshd_certs + tlshd_pq_certs_len;
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*pcert =3D =
tlshd_certs;
>> >  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *privkey =3D=
 tlshd_privkey;
>> >  =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> >  =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> > --
>> >
>> > But, I have a feeling its not the correct change...
>>=20
>>=20
>> Scott, can you triage this?
>
> So when I added the dual certificate support, I didn't touch any of the
> keyring code.  Frankly, I'm not entirely sure what is the right way to
> set it up and the docs are pretty much nonexistent.  As far as I can
> tell:
>
> - you need to load nfs.ko first so that the .nfs keyring gets created
>   via nfs_init_keyring()
> - you need to restart tlshd so that it links the .nfs keyring into its
>   session keyring (I tried loading nfs.ko at boot via modules-load.d,
>   but tlshd still reported an error saying it couldn't find the .nfs
>   keyring)
> - you need to convert the cert and key to DER format
> - you need to add the cert and key to the .nfs keyring, e.g.
>
>   keyctl padd user "nfs_cert" %:.nfs < smayhew-rawhide.crt.der
>   keyctl padd user "nfs_key" %:.nfs < smayhew-rawhide.key.der
>
> - then you mount w/ '-o xprtsec=3Dmtls,cert_serial=3D...,privkey_seria=
l=3D...'
>
> Is that somewhat accurate?  Is there a better way to do it?  It seems
> like a lot more work than just using the config file.

It is more work because keyring support for the NFS consumers is still
aspirational/experimental.

I've pushed your patch to a "fixes" branch for folks to try out. I'm not
sure yet whether we want a 1.4.1 release with this fix, since keyring
support for NFS is "not finished".


> At any rate, I was able to reproduce the reported bug and the patch I
> just sent fixes it, but I think we probably want to make dual
> certificate support work with keyrings too.

Yes, and clearly there are some questions to be answered.


--=20
Chuck Lever

