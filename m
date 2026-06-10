Return-Path: <linux-nfs+bounces-22439-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CojWKVKEKWrUYQMAu9opvQ
	(envelope-from <linux-nfs+bounces-22439-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 17:35:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B4966ADB1
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 17:35:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EQiazv+j;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22439-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22439-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BA1732197C7
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 15:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAE341360E;
	Wed, 10 Jun 2026 15:26:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8453B47E2;
	Wed, 10 Jun 2026 15:26:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105168; cv=none; b=hbRJ95KiYQJ3LTko1hi53TqJAVHXyupYbikzmTfFbkkuvnMo9XSQpsLrf3IbcmdrzxY3q/FKiiKp9ShnmDuaGWXzp0461mhQ24Ez/P9M9+hauYtBUfkP6ZLwf5PDHZ0vMDHI4XYc/zWeZ2/Vn785n5HMgsfkX1JIsi69ZZP+KmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105168; c=relaxed/simple;
	bh=XYE43jedO99U/9UZ4yIg0PvwTphpo5eYKkKCaoLimEg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sPQhnocjwrsKnFFpM8monpv+ofkts4UW8bEuzOjUKG9KN1DZ147G14Z9bvQuhepBLedbbLZm0FE8cZAslCIi5gwyyPm58UNZBl97marxAtDCd0JgqV/6OjK7HM6RkNe+nD4FYYonyGNdgnUKpR55YlOfkbDB1QKWPDVF1aLG5Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQiazv+j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A8C1F00898;
	Wed, 10 Jun 2026 15:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781105167;
	bh=fojQvqRhsIMk9RGcicJgWobOh6PSD9E+2nHDEUeE7zM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=EQiazv+jGFVErafjyCOe5J9ecZx7VKvTbeDl9JeJuyhKAVYBJFtXXmI0aieUev8p1
	 quezg3xOQDQNN/rr4hBg4P0OrRQpb6R8DDHS3/xcy3A842/XRfjUHmSnyo+AShzuIm
	 4WeeFJvKSBeS3SJFmJXGvnbS1HZWzxzQFuiT9pEP2yrREhGEgQbCO5G9wKtI8Chy9M
	 TcxZiVwE7emWz7xnBfwT3PiG/KXjdorEa7xZg2tpx24PgvM+kF4zDld1Pfzt9jZdNv
	 SxfItZojgXSkJ/ytcsHG0fOWDDoSW8C3MNtyOVmD0I8lcUwrL/7WG2sH4u+GweCiTf
	 SsgmudN58G+aA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 26D63F40078;
	Wed, 10 Jun 2026 11:26:06 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 10 Jun 2026 11:26:06 -0400
X-ME-Sender: <xms:DoIpaqGHkG3_Prpfu9rAVjJ6UVKnq4W0rNF-A4eB7YM0Gpr3zPzOEQ>
    <xme:DoIpamI5XwJ-tUiEInvn2lT3B_dD03ylOerW_Zy5e-pUYesQJ_D4so_KtScMYKU1d
    JChzOFGV95qb04Ray5wMvHTRXt6p8KKNFFoYqvb8osNTykzzH3ZN7E>
X-ME-Proxy-Cause: dmFkZTFhWG9tmdDkGAbH08WGb79b3YME31/d6ZwDdI6XHOsGQHsv5O9aY/PwN2tP+zieuL
    w3PXaIx7NRrPz5uQNpMEF52sMJ/IYEA04zCpI4spQiPcss2O2Svw5Pq5p0iMtPH3iJzdax
    ll9h3kHtzVvqoCi6p923yXU5BNVfUYXa5u4isXOS3jrDD1ZpW3sfojNLVILbHbaOgbp3Oj
    /YQjButYUj/RCQ0Z1kGO9Hy+TtwR0s+o0c88Y4rNWD8A+gbwWJBWEKYWu3dZurURxeXfm9
    zlOB+6LthZSTdie3oQVqgvTF34supb6QcO+Nl1fM2cq3OTTwwvlXkd+Y7lwLS9J8noBLgM
    RR8r831C0fcQHXN/5vtY8eIEWn9oYeirTUs0VxqZWZ/nLc0imHEXS8rBAPO9TrTI1W45JH
    vIThAGWe5HzYgJ6sactN94Ll4SqLx8GgtoXmv++ErtOg2iVJ+jwarh3zIF8IAkg9JV26RX
    JZdGvqs/w8NIvuWL3MxyLqr2+LZKK3Gt9VjOq7INYccxr9N2sgpHmZEk4t3W6SXdG5i3Be
    kfSIXwAw4HHatakdXW1A3sJ2pQ458lMFVFUkiSi60LwSSO0/FtyiGptyYoSBqQluRtQrD1
    SlskUrAkCsudrOvHtyLsrkCFgF7fvaNHizDcz/RUIh1zb93QG9U85BDCXs0A
X-ME-Proxy: <xmx:DoIpahuTpbD50zmJyP3PMJ8WO-1RRudgHh3Nie_qE99CWDhX-ZPatg>
    <xmx:DoIpahh76b-GGALioRu9QGHdyVTgmepDmb0wLrW7DZuKefELJQPLRw>
    <xmx:DoIpasca687s-_zorlI6vpNIKfQco95ygdRSZtt3j1RX1TX7Ki0HIA>
    <xmx:DoIpaunkq1-KdA3bb2NEMO7cXUr0C2kyYcMLRo9_C6EplxkD9pYN2Q>
    <xmx:DoIpauraX7_Kr0OSrQMyRRLbSymuk-K_I-6FjU34BX5rbCjC1pkplOTN>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EA817780075; Wed, 10 Jun 2026 11:26:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_rAEqOGWjyN
Date: Wed, 10 Jun 2026 11:25:45 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>,
 "Calum Mackay" <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <5610f997-bc3f-4c20-b3ee-7567dfd3fe4a@app.fastmail.com>
In-Reply-To: <fc7d4edb03fbb359746d75942cc4867c280f8c39.camel@kernel.org>
References: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
 <20260522-dir-deleg-v5-7-542cddfad576@kernel.org>
 <35918046-66e3-4361-adc3-bce328ce9821@app.fastmail.com>
 <fc7d4edb03fbb359746d75942cc4867c280f8c39.camel@kernel.org>
Subject: Re: [PATCH v5 07/21] nfsd: add callback encoding and decoding linkages for
 CB_NOTIFY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.65 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22439-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18B4966ADB1



On Wed, Jun 10, 2026, at 11:19 AM, Jeff Layton wrote:
> On Mon, 2026-06-08 at 12:52 -0400, Chuck Lever wrote:

>> > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>> > index 25bbf5b8814d..ea3e7deb06fa 100644
>> > --- a/fs/nfsd/nfs4callback.c
>> > +++ b/fs/nfsd/nfs4callback.c
>> > @@ -865,6 +865,51 @@ static void encode_stateowner(struct xdr_stream 
>> > *xdr, struct nfs4_stateowner *so
>> >  	xdr_encode_opaque(p, so->so_owner.data, so->so_owner.len);
>> >  }
>> > 
>> > +static void nfs4_xdr_enc_cb_notify(struct rpc_rqst *req,
>> > +				   struct xdr_stream *xdr,
>> > +				   const void *data)
>> > +{
>> > +	const struct nfsd4_callback *cb = data;
>> > +	struct nfs4_cb_compound_hdr hdr = {
>> > +		.ident = 0,
>> > +		.minorversion = cb->cb_clp->cl_minorversion,
>> > +	};
>> > +	struct CB_NOTIFY4args args = { };
>> > +
>> > +	WARN_ON_ONCE(hdr.minorversion == 0);
>> > +
>> > +	encode_cb_compound4args(xdr, &hdr);
>> > +	encode_cb_sequence4args(xdr, cb, &hdr);
>> > +
>> > +	/*
>> > +	 * FIXME: get stateid and fh from delegation. Inline the cna_changes
>> > +	 * buffer, and zero it.
>> > +	 */
>> > +	WARN_ON_ONCE(!xdrgen_encode_CB_NOTIFY4args(xdr, &args));
>> > +
>> > +	hdr.nops++;
>> > +	encode_cb_nops(&hdr);
>> > +}
>> 
>> There are a number of problems with this, but since there are no
>> callers yet, we can let some of those issues stand.
>> 
>> What is problematic in the longer-term is that this is a client-side
>> encoder (since this is the server's NFSv4 callback client).
>> 
>> xdrgen_encode_CB_NOTIFY4args() is an argument encoder, which is
>> client-side functionality, but it resides in fs/nfsd/nfs4xdr_gen.c,
>> which is server-side. Let's not mix these purposes.
>> 
>> I replaced the comment and WARN_ON with this:
>> 
>> +       xdr_stream_encode_u32(xdr, OP_CB_NOTIFY);
>> +
>> +       /* FIXME: encode stateid, fh, and cna_changes from delegation */
>> 
>> You can use xdrgen functions for individual data items, but for
>> full argument and response structures, only server-side is supported
>> at the moment. In the later patch that completes this code, I'll cover
>> the other fields, which can be a mix of open code and xdrgen.
>> 
>
> The full argument encoder and decoder works just fine. When you say
> "supported" what do you mean, specifically?

"encode argument" is a client-side mechanism

"decode argument" is a server-side mechanism

"encode result" is a server-side mechanism

"decode result" is a client-side mechanism

The reason that matters is that the client-side and server-side
XDR implementation for the top level arguments and results (not
the individual data items) in the kernel have different calling
conventions -- eg, server side wants to see a struct svc_rqst *


> I'd really rather not go back to open-coding the encoders and decoders,
> particularly since CB_NOTIFY has one of the most complex argument
> structures in the protocol.

Go look at how I implemented this in the subsequent patch. You can
use the xdrgen notify4 encoder, that's where all the complexity is.

-- 
Chuck Lever

