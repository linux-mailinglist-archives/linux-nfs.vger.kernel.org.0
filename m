Return-Path: <linux-nfs+bounces-21746-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHl0LXwlDmr26QUAu9opvQ
	(envelope-from <linux-nfs+bounces-21746-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 23:19:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E8B59AB59
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 23:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4982E327EEF7
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 19:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9333446BC;
	Wed, 20 May 2026 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPSMKDqJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCE83403E6
	for <linux-nfs@vger.kernel.org>; Wed, 20 May 2026 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305036; cv=none; b=TMg/hBKgEeS7fMm9REkrYGC2/ZcmGak1Ij2VUCk7VOadvg7byPw4IU+YcO/Y+kxiyHOeGTvkPoCY39n0eSokvhmnvpcYnzV48RZ3kaOF/k4FLralRYWSCMbikugJaW+CkedOpjmbwUnqDyqQC1KCsvFY02L149z13lCgcysewpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305036; c=relaxed/simple;
	bh=+CAQNHcaEPxwwG32Sqni1e01naye8S1R6a6pO/wAANU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=l+xqEVT2qFZAriSa8eoM0MV2qk58ZwDXEeTQK5Bx1Cj5Ee1eBA3dLF2H4IaTxyJ7r5SmWiJxfezyrGKMirbO8IU6jdK/slCx/ACuoi/EpYBp/9G3rWpR+0aT0lqwgpkig50YXQq7EhXlWro38GitWaGZ5Tqr+A9JaLkxp7pePR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPSMKDqJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FA21F00894;
	Wed, 20 May 2026 19:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779305034;
	bh=+CAQNHcaEPxwwG32Sqni1e01naye8S1R6a6pO/wAANU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=jPSMKDqJLQAkRi4tNJAcQo0WGHk/xHtSLSLCkn+khEjY/hVjDAeq81zYgESsa+b8s
	 1jV2RYY2kiEImPttWPlJaD9O4sAXSAJeXxJxBkn6wpJuTMTtmlBVY1uTIT/OHjxuPT
	 7QuN6nn5uI5aYMDbvccIaMa6FFirbKEz2shOy9xyVd6xmFBtm6pUjwKHTfKqHjxlJk
	 pxkox49qdjncsNi3RNICOcab6V75wImYTxeUH8pQr154NNvTppqKOEDiN2R4uto2+r
	 XCGVIX01wSulS9dvP6/SlaZ3hNFPI3SDey3LoA+PYggWcORpASRLdy/jQS2krY+TJL
	 cRHrGNc1xxLIA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7830EF40076;
	Wed, 20 May 2026 15:23:53 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Wed, 20 May 2026 15:23:53 -0400
X-ME-Sender: <xms:SQoOagsA1nrj4KMMkDVzQPgwJBZr5h6uv26iwcB1uvCxw4O8nCB9aQ>
    <xme:SQoOaoS62gDdBJWDAxgQenXZBi8IHZlLMRjxzB3h_CrMbOCgwespiK6zZOMUedbrA
    G0WKtHK0spTMvW6seY6ow87Qwv7B__nx3H6F7f1hq3xvTgyGzSBLonr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehnnhgr
    ucfutghhuhhmrghkvghrfdcuoegrnhhnrgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeduueevgeffledvledvieffheevvddvteeffeegfefhvddtueffgfetvefh
    veetleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhhnrgdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeijeejuddvtdej
    ledqfeefvddvfeegjeduqdgrnhhnrgeppehkvghrnhgvlhdrohhrghesnhhofihhvgihtg
    hrvggrmhgvrhihrdgtohhmpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegurg
    hvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohephhgvrhgsvghrthesghho
    nhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtthhopegvughumhgriigvthesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtoheptggvlheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SQoOajnOQGq3za0W7B8VLYZ-tfn3PT0VCm-fxOC2TK6xvzFxrjmljw>
    <xmx:SQoOarvbPH7g1q0iip1Rlmbv03DMOrQ6qaGnfDym6JXdLJjmCVOvkA>
    <xmx:SQoOaiPZA1tJmDnkQd1YlnSOjN1j8DDkwspVG-OIMJw-wL6viZrWLg>
    <xmx:SQoOas00AJgC2X7mwgOr2t8_Hl--JP9-qxuTrOoAT7kqLeTf2FgcCA>
    <xmx:SQoOakyQlmOLiw1hZbBdX2XdQVl9dAhFWgbS4UOiQuRTLfBA1AGf73M3>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 547C5B60071; Wed, 20 May 2026 15:23:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AV1e0z75Y96N
Date: Wed, 20 May 2026 15:22:58 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Herbert Xu" <herbert@gondor.apana.org.au>,
 "David Howells" <dhowells@redhat.com>, "Simo Sorce" <simo@redhat.com>
Message-Id: <6b3b43a7-5156-4d8c-8a0e-51c96d5c2a16@app.fastmail.com>
In-Reply-To: <0c5ff2b9-97b3-4e6d-a4ca-1e9634c38a66@app.fastmail.com>
References: <20260427-crypto-krb5-api-v1-0-1fc1253b64c0@oracle.com>
 <dbaa192b70fa67d51ab6a4294c045100efc65980.camel@kernel.org>
 <0c5ff2b9-97b3-4e6d-a4ca-1e9634c38a66@app.fastmail.com>
Subject: Re: [PATCH 00/18] Migrate rpcsec_gss_krb5 to the crypto/krb5 library
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21746-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,app.fastmail.com:mid,hammerspace.com:email];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C0E8B59AB59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Chuck,

On Wed, Apr 29, 2026, at 11:17 AM, Chuck Lever wrote:
> On Wed, Apr 29, 2026, at 2:39 AM, Jeff Layton wrote:
>> On Mon, 2026-04-27 at 09:50 -0400, Chuck Lever wrote:
>>> The rpcsec_gss_krb5 module carries its own Kerberos 5 crypto imple-
>>> mentation: key derivation, CBC-CTS encryption, HMAC checksumming,
>>> and the encrypt-then-MAC construction from RFC 8009. Keeping
>>> cryptographic code inside an RPC module means it receives review
>>> only from the SUNRPC maintainers, who lack deep crypto expertise.
>>> Vulnerabilities and algorithmic errors can persist unnoticed.
>>>=20
>>> Replacing the private SunRPC Kerberos implementation eliminates
>>> this duplicated audit surface. A single implementation of Kerberos
>>> 5 key derivation and authenticated encryption is easier to verify
>>> than two independent copies. New encryption types and hardware
>>> offload added to crypto/krb5 will automatically become available
>>> to SunRPC Kerberos consumers.
>>>=20
>>> The crypto/krb5 library handles enctype differences internally, so
>>> a single encrypt function and a single decrypt function serve all
>>> enctypes, eliminating the per-enctype dispatch table that previously
>>> existed in struct gss_krb5_enctype.
>>>=20
>>> RFC 4121 Section 4.2.4 requires MIC checksums to cover the message
>>> body followed by the GSS token header. The crypto/krb5 get_mic/
>>> verify_mic API hashes optional metadata before the scatterlist
>>> data, which is the wrong order for the GSS header. The header is
>>> therefore placed at the end of the scatterlist rather than passed
>>> as the metadata parameter, and a dedicated gss_krb5_mic_build_sg()
>>> helper constructs this three-section layout (checksum area, message
>>> body, token header) with proper sg_mark_end() termination.
>>>=20
>>> This implementation was available during the Spring 2026 NFS bake-
>>> a-thon, and received testing there.
>
>>
>> Love that diffstat. Nice work!=C2=A0
>>
>> One comment in general: Do you need to add Assisted-by: tags to any of
>> this? You can add this to the set:
>>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>
> Thanks, applied to nfsd-testing. An Acked-by: from one of the NFS
> client maintainers would be great too.

I finally had a chance to apply this and try it out. You can add my acke=
d-by:

Acked-by: Anna Schumaker <anna.schumaker@hammerspace.com>

>
>
> --=20
> Chuck Lever

