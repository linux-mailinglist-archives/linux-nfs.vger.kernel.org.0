Return-Path: <linux-nfs+bounces-21274-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLKOGEAj8mlmoQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21274-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 17:26:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88535496D65
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 17:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 131CA3047919
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 15:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427E5378819;
	Wed, 29 Apr 2026 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPSneN/B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAFB3783D4
	for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2026 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475901; cv=none; b=q2efK/bBw0ZJydBVLAJ2dBhb8tNxuZYyJfhPMrdOLLL2ME4ru/pn9jcl4WhLLMP2yjqbsSzHZZFF5ct6KgWFKlfJfalNtRUIaOHfpE85issndatP+bibfqc0zlATG05vXNuxbR8/1GRNK+X2yRuahvAFSsf96NnuyKjaroJe9Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475901; c=relaxed/simple;
	bh=h0Koc3DMkH5zuBD2mgruwskA9s2gm0IgTT9rYzHY+Tk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RcnSUTRKs13Sp2DoaByCfYERYd1tZtMiyVHeqDGNA44/+uCEoJrVPXnyyatIJyUKr3qTK6GkDo9wwM1Dz2f426N9MqHt918rzPYxcECqXslYGT2SqxlKFItfH1SR7s9fr220tzXCzUCaU6kIGhf9RUu7jv2sNqbf4m33HCouH2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPSneN/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00A0C19425;
	Wed, 29 Apr 2026 15:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777475901;
	bh=h0Koc3DMkH5zuBD2mgruwskA9s2gm0IgTT9rYzHY+Tk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=PPSneN/B+EzpzvRVOXZj1IkCpHE6iJkJDO5If2ocSunhQh93naAL6TxM5jNodGRjy
	 H4jD/5zvnC4PrhUd9ZXhEuqyvebm5yQaTpfdizGsAJLDocwsuESF62bUdWedxESu4a
	 Yg4kirqFE8Kg9YGgmim1Y1RyE4WtKXoVAs4Z1rfSxTwYsfAtCpTbTvIkdClOm73UtY
	 KALp5onRpUFY7phC3jbs6M/0d004eML1UaxpHyfBJpRuPbfqYoEGw0zsUyR6T231AU
	 fReUS/qDDDO+8ulVOrITVnXdwh5ljZlzuHtkQ7uPtLYEVDIBoo3N9yPp7KKHCrv4qp
	 RVYURZfrjSPrA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C3CD5F40070;
	Wed, 29 Apr 2026 11:18:19 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 29 Apr 2026 11:18:19 -0400
X-ME-Sender: <xms:OyHyafbZGCspSuG0zoXHcr-sqlJCyIba3dEMIwgTokBbAj4qHJ-Ubw>
    <xme:OyHyaZOlvst9wDsuWPDO-Y7ovkwslQEbZnE_386RgknaYl2g0gr8w9fUgwGRdtwkG
    ise8HzB8v8Wn-PfVzKTFHJg746gnhA3-HQXmTZ43WGkKtu8aXryino>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekgeejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgffhgeeutdeiieevuefgvedtjeefudekvefggefguefgtefgledtteeuleelleetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegurghvvghmsegurg
    hvvghmlhhofhhtrdhnvghtpdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgr
    phgrnhgrrdhorhhgrdgruhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrd
    gtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehh
    ohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepthhrohhnughmhieskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:OyHyaWxTG0H8ndP_Ip4DU8nsxU5Io_R03CCVwfJysvMpoi_sR6CwAg>
    <xmx:OyHyaXJk91G48Jz5vlosQ1d-ya9s2kLfLGXMtMVoFTtpkgUYpDodGw>
    <xmx:OyHyaQ55-NIzWk5ZqXtdpYfSZAAMhEtBC4b4aTlB2n7t5WNE0QB6zw>
    <xmx:OyHyadxteam5wOluyi3N3HvOA9F0_D-LSu48dSeRVL8UCxCDc9eSEg>
    <xmx:OyHyaa9VS1mECn1wyDzyBRSwh25gxXSlVjEvVqyr6ERQ4gemJuAvMY90>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 98405780075; Wed, 29 Apr 2026 11:18:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9zl7fUjdiig
Date: Wed, 29 Apr 2026 11:17:59 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Herbert Xu" <herbert@gondor.apana.org.au>,
 "David Howells" <dhowells@redhat.com>, "Simo Sorce" <simo@redhat.com>
Message-Id: <0c5ff2b9-97b3-4e6d-a4ca-1e9634c38a66@app.fastmail.com>
In-Reply-To: <dbaa192b70fa67d51ab6a4294c045100efc65980.camel@kernel.org>
References: <20260427-crypto-krb5-api-v1-0-1fc1253b64c0@oracle.com>
 <dbaa192b70fa67d51ab6a4294c045100efc65980.camel@kernel.org>
Subject: Re: [PATCH 00/18] Migrate rpcsec_gss_krb5 to the crypto/krb5 library
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 88535496D65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21274-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Wed, Apr 29, 2026, at 2:39 AM, Jeff Layton wrote:
> On Mon, 2026-04-27 at 09:50 -0400, Chuck Lever wrote:
>> The rpcsec_gss_krb5 module carries its own Kerberos 5 crypto imple-
>> mentation: key derivation, CBC-CTS encryption, HMAC checksumming,
>> and the encrypt-then-MAC construction from RFC 8009. Keeping
>> cryptographic code inside an RPC module means it receives review
>> only from the SUNRPC maintainers, who lack deep crypto expertise.
>> Vulnerabilities and algorithmic errors can persist unnoticed.
>>=20
>> Replacing the private SunRPC Kerberos implementation eliminates
>> this duplicated audit surface. A single implementation of Kerberos
>> 5 key derivation and authenticated encryption is easier to verify
>> than two independent copies. New encryption types and hardware
>> offload added to crypto/krb5 will automatically become available
>> to SunRPC Kerberos consumers.
>>=20
>> The crypto/krb5 library handles enctype differences internally, so
>> a single encrypt function and a single decrypt function serve all
>> enctypes, eliminating the per-enctype dispatch table that previously
>> existed in struct gss_krb5_enctype.
>>=20
>> RFC 4121 Section 4.2.4 requires MIC checksums to cover the message
>> body followed by the GSS token header. The crypto/krb5 get_mic/
>> verify_mic API hashes optional metadata before the scatterlist
>> data, which is the wrong order for the GSS header. The header is
>> therefore placed at the end of the scatterlist rather than passed
>> as the metadata parameter, and a dedicated gss_krb5_mic_build_sg()
>> helper constructs this three-section layout (checksum area, message
>> body, token header) with proper sg_mark_end() termination.
>>=20
>> This implementation was available during the Spring 2026 NFS bake-
>> a-thon, and received testing there.

>
> Love that diffstat. Nice work!=C2=A0
>
> One comment in general: Do you need to add Assisted-by: tags to any of
> this? You can add this to the set:
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks, applied to nfsd-testing. An Acked-by: from one of the NFS
client maintainers would be great too.


--=20
Chuck Lever

