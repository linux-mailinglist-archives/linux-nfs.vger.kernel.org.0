Return-Path: <linux-nfs+bounces-20668-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPlbEAay02mukQcAu9opvQ
	(envelope-from <linux-nfs+bounces-20668-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 15:15:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7A63A378C
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 15:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA7563001BE5
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2026 13:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCDE372B39;
	Mon,  6 Apr 2026 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ix+rwtot"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1D372690
	for <linux-nfs@vger.kernel.org>; Mon,  6 Apr 2026 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775481342; cv=none; b=qergvI1d5tnThbV2fa938lGAGzhQRtmJhx0eefbEE9XavyVVz3RBT9EJpmccNEGxnMvWJ8JjNGuFFQcDL1dfxG2L29PbQrMvdMmdCbUEia+Cqae6Dy02glYqNI9b4qskMWL8JBV+vWf29lzeSHqmWH4StLqg/QX6agVose/DvUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775481342; c=relaxed/simple;
	bh=O8r+gdMvEmXGRVCfpewzlKoGPKh/RAKBZK0r10CEwHs=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=toJoCeEB2q256LIOoUY76DZHxqKHvRyvgAtpeJ3sxZDxJXrH4Cspu5E0O0iAGsKOUMuxeihgVrTn2CdQODP14+foYLuvJbcS1xi0M0SEzGszXMs2BPji9jIOwUEZ3LeWkLK+CnKGJv+/ElJZSpU0rGSRg44xZ7fzxRtbSOd4vCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ix+rwtot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE56C4CEF7
	for <linux-nfs@vger.kernel.org>; Mon,  6 Apr 2026 13:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775481342;
	bh=O8r+gdMvEmXGRVCfpewzlKoGPKh/RAKBZK0r10CEwHs=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=Ix+rwtotkY0mnFjLbe4h+I9hNEXgbJGg4oii/wDDdx3FMCA3zQnq6jyLMzgY8EShI
	 CsOIZ6tfcDzRnykHlZOggz/jNLSoKD2t3iW5nG+niwnSFOOgI4nBQ6IktWjQ2BMwUQ
	 b3NabcouqmqX7MBprejPvXUsfkblDeprq+hHcaU0BzfwkMoSJ3F/NZONVYdlujHSSE
	 XwkohGiBAd1D+FO0d2lJKlxyNpzAXCujQvhEA/sEL96x931ELwUP817uPJsOjSMs7c
	 9zhwtLgB/pbExtpPg9YOadanHFQeyLbcTAfT44emiFl4kq5EhKlMNXuMhmuTG842o2
	 pTqGKwHtlxcKw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2732CF4006A;
	Mon,  6 Apr 2026 09:15:41 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 06 Apr 2026 09:15:41 -0400
X-ME-Sender: <xms:_bHTaXRSVud3YiybcYos4XJwxm5FcFP6hGRCtmABTlZyFkWFIAdLRQ>
    <xme:_bHTaTknVIRNISkC2A9beCXFbZEOD0w71s74GqNufsJjcnJlXKfoXMN71nc7Xw4fA
    CiK20MmUf7BNlJt5Sf37TVh5AX37xQhs_4hURbhzYIWW4dQKRKIS1v3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddujeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgtkhcu
    nfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ehgfdvteffudfgvddtteeiieduffeuhfelueffvdegudeuheffffevjeetuefhudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklh
    gvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleelleeh
    ledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohephhhirhhohihsrghtohesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqd
    hnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_bHTaZ8-akF0QDPqUJiDFH67GWj9ZRR9QcQreDI0kG3fvOFuZd77-g>
    <xmx:_bHTabrM7RJPTFdNT1JEAPb1cbeeklaOMoEmhq_LUrZauTHAc-m8KA>
    <xmx:_bHTaenEbaZcJvGeEMb3H-L2g8dyvkSvngVi1gXA1HPs8EmLDKZk6w>
    <xmx:_bHTaaIYCq7ZGuNlwIor1KHRrmNU-GQUy5oGw8a43wAHRld8rTHg-w>
    <xmx:_bHTaby7Wjm4oB4z-Mwp3RS_8XcYYyhtR98odg-5ac7i2oAQqChsMgVA>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 05921780075; Mon,  6 Apr 2026 09:15:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AeISDIvKj2js
Date: Mon, 06 Apr 2026 09:15:19 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Hiroyuki Sato" <hiroysato@gmail.com>, nfs <linux-nfs@vger.kernel.org>
Message-Id: <d259c550-4cf3-425d-8485-86c126c1d256@app.fastmail.com>
In-Reply-To: 
 <CA+Tq-RouZ784rWHjwSz6GoJc4f5f66A2mr2-PdyFJ2bK2Y20wA@mail.gmail.com>
References: 
 <CA+Tq-RqDP_BAroLX6wVrNY1BMwC9BOZ-UorLje=TXBdEOj8hjQ@mail.gmail.com>
 <CA+Tq-RouZ784rWHjwSz6GoJc4f5f66A2mr2-PdyFJ2bK2Y20wA@mail.gmail.com>
Subject: Re: [Q] NFSD: COMPOUND reply tag padding not zeroed? (e.g. \xff\xff)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-20668-lists,linux-nfs=lfdr.de];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,app.fastmail.com:mid];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DB7A63A378C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Mon, Apr 6, 2026, at 12:22 AM, Hiroyuki Sato wrote:
> Helo,
>
> I can reproduce the same behavior on Linux 7.0-rc7 as well.
> (591cd656a1bf5ea94a222af5ef2ee76df029c1d2)
> The COMPOUND reply tag padding sometimes contains non-zero bytes
> (e.g. 0x69, 0xff) instead of zero, which appears to be the same
> issue as previously reported.
>
> Would a change like the following make sense here?
> It seems to zero-fill the XDR padding explicitly for the reply tag.
>
> With this change applied, the padding appears to be zeroed
> consistently in my testing.
>
> Best regards,
>
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 9d2349131..b33e031bf 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -6377,16 +6377,18 @@ nfs4svc_encode_compoundres(struct svc_rqst
> *rqstp, struct xdr_stream *xdr)
>  {
>         struct nfsd4_compoundres *resp =3D rqstp->rq_resp;
>         __be32 *p;
> +       size_t padded_len;
>
>         /*
>          * Send buffer space for the following items is reserved
>          * at the top of nfsd4_proc_compound().
>          */
>         p =3D resp->statusp;
> +       padded_len =3D XDR_QUADLEN(resp->taglen) * XDR_UNIT;
>
>         *p++ =3D resp->cstate.status;
>         *p++ =3D htonl(resp->taglen);
> -       memcpy(p, resp->tag, resp->taglen);
> +       memcpy_and_pad(p, padded_len, resp->tag, resp->taglen, 0);
>         p +=3D XDR_QUADLEN(resp->taglen);
>         *p++ =3D htonl(resp->opcnt);
>
> 2026=E5=B9=B44=E6=9C=885=E6=97=A5(=E6=97=A5) 13:17 Hiroyuki Sato <hiro=
ysato@gmail.com>:
>>
>> Hello,
>>
>> 1. Observed behavior
>>
>> * When sending a COMPOUND request with the tag "create_session" (14 b=
ytes),
>>   the reply is expected to include XDR padding to a 4-byte boundary,
>>   i.e. "create_session" + "\x00\x00".
>> * On 5.14.0-611.45.1.el9_7.x86_64 (AlmaLinux 9), the padding bytes
>>   are sometimes observed to be non-zero (e.g. "\xff\xff").
>> * From inspection of recent upstream code, nfs4svc_encode_compoundres=
()
>>   also appears not to explicitly zero-fill the padding.
>>
>> 2. Questions
>>
>> * Is this understanding correct?
>> * If so, is this a known issue or something that should be fixed?

I think the rules are:

1. The sender SHOULD clear the bytes in an XDR pad but doesn't have to
2. The receiver MUST ignore the bytes in an XDR pad

Feel free to clean up your fix and send it as a contribution with
a full patch description (Signed-off-by, Fixes tags, etc etc).


--=20
Chuck Lever

