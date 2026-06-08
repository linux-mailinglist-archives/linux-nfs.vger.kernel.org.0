Return-Path: <linux-nfs+bounces-22379-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yGjSHQ/1JmoAowIAu9opvQ
	(envelope-from <linux-nfs+bounces-22379-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 18:59:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17433659050
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 18:59:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eHN8r6c9;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22379-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22379-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB705302D192
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2026 16:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81443D4130;
	Mon,  8 Jun 2026 16:53:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEFF3D3324;
	Mon,  8 Jun 2026 16:53:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937591; cv=none; b=DE00JDnr69VCnQsQYXQtTflEsavcU57+Hl7AWmQyz6pwVLM269gMsxfYQ6KtZJCOUL/hbnqBwQQa3moWBCKb1Y2+2s3VwuPHRGy6ACbxDTwyfdieFf/ufaJQEvcmHZT/DBYEY0aOy3lOcfcYMB3b32ENMJiWWEkIr4vipzKjGaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937591; c=relaxed/simple;
	bh=lajAjpnnoujYGkUPN8vIDBCKOYpPLEXuGU9S7aZdnkU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qk74jKKZbHDRu75Eq37u/fUyzuCrhM5Smakfg1eRlo6iIIrhCvn30xBzurURDruQuSm+8krWo3mRpp7eVZKHcdZ0JdiIvIWjlwFBkl8mwwDsfOZpGR0BY3P5WKiHQseYaY52WGnjNGiJIeXWJP5TN07IxWJmku8V4C/VYJ3IvOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHN8r6c9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D053D1F00893;
	Mon,  8 Jun 2026 16:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780937590;
	bh=X2ZgdLij1/sVQajgSfKAIK8jhMPGr2TnsrqDbVGe1AU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=eHN8r6c92FN+3+E4fVx9L1226GabKJOtDq/FZ31NPua1kkYkxsUC7nLJEUsAUCmDi
	 AfhXgE6UxrRCkP5+LTncog+fYvoCpmKb6zNerrM86G/At3/FyO9yIAFCg4jCJ9LmDH
	 tjkfulGD3dw7a/ZZ4GXgz9mgR495iAsyNTlNCX2Phlch50m/mBl9PtbaB0vf73xwpr
	 5L1M5S2mcC0V+q0XAtteIG5/lVazAZ0iSBjrZjGzPNV4Ray3bzFjUucknLqh6cfgC4
	 g6WAvuthzLhF6whuXvxfK6WiRExO8t6Mmt3S0/9Moo4MBLu8QCoIwFmrWxQe43kroI
	 pe9WVNb5Tj3zw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 18775F40081;
	Mon,  8 Jun 2026 12:53:09 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 08 Jun 2026 12:53:09 -0400
X-ME-Sender: <xms:dPMmatYYHy_4_R4edDVYbAk43sU8VCccd_X9aGxybfHJqcFPKLyciA>
    <xme:dPMmavOqZFXe7BcrJ-5qSqN5OWREJMCO4fXoZ9pRHL-4r4dUb5IbIILCc0f8I5q-y
    b4uA4aPIt9gD7zrAL9873KnGwYWy8e-mGabmz1yOQP0kYVZOG5FQpw>
X-ME-Proxy-Cause: dmFkZTGuxUbHR9LzJEIvgkv9xchPjz+OlD15rjaP2w0bLL4J77GqY2ESJeRrWXx0A0nch2
    PIo1PGxqNiZJPC/JlWtE8oDvDWg4NU57KWF3X7eX2VmCRWjl/T5TXDZ2c6SPAD8bDn7nDd
    QBbWOKV+yTqQP1IAkIAy8mDbds0+TDVEGj5S0pZSZlXfiflBlxOGd2uyUirVO9UlAxRE0v
    dVOzwGguqZjpNQw+UGwasOWYV/mXVKpvDBGXbf7SRvB33iEMTYiWflQEXxFhauRfLwtfib
    fc6X9qI02sjmlEoUrU9/WnvXhrWPdEdCBcdgxcw2Nmqq7A67R8qr/BShIqosGunxES0+Gi
    /nxWwA0fp+91HS7QQ5VS3YU1Gz9dkFn+j1Ky3R6RfcxzbRpxA1wQdRORLQw7RhPuuuDF9/
    Pxz2yf6s+8yY5uKu0FTziFlMhBWZxClcRq8xlSsmUV5dyefIvqfQVmsCV4TSaiHBmEX9k+
    fx7L2hWjYcALjYr2u7HfW1kEENcD+Q/w1i+ih3AV+QPQjTsLnp7m9K96FOGi8IytVBux5B
    3RkoqFMbvbxOTyLWJgTIFgY1oXO47R8d6lDyU0O7P6SMf/avHEjCl3MWyl6QkjxFlSGmoh
    J6wly4+IBNy3gMM7dVEhwciBD2Mwczk3vEIS48jUMmxXzeByx7SmimMwMfpg
X-ME-Proxy: <xmx:dfMmaqD8F0IlWddjftN9iA9QwM4V3a6obQ4-qmyADJWbQF07VEb5EA>
    <xmx:dfMmarnmCRWwa-I7S8hDulv58UxeaDurKUuOS4BdfPJOT6GCAzLOUw>
    <xmx:dfMmalSU1wRzlDefhDGsttq5Eo55lUXR-0u3In9A_sSXl8V6S41WEg>
    <xmx:dfMmavJTjB5hFwlvf-uch9P4oSJvRxLnHwx3ZRDNbt0vv88YC0Rpwg>
    <xmx:dfMmar83_dKTr7m41yzmhrupKZYFumyDUIPNwqaRhmdhef_dCEQJyhC8>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DDA6F780070; Mon,  8 Jun 2026 12:53:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_rAEqOGWjyN
Date: Mon, 08 Jun 2026 12:52:48 -0400
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
Message-Id: <35918046-66e3-4361-adc3-bce328ce9821@app.fastmail.com>
In-Reply-To: <20260522-dir-deleg-v5-7-542cddfad576@kernel.org>
References: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
 <20260522-dir-deleg-v5-7-542cddfad576@kernel.org>
Subject: Re: [PATCH v5 07/21] nfsd: add callback encoding and decoding linkages for
 CB_NOTIFY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22379-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17433659050



On Fri, May 22, 2026, at 3:42 PM, Jeff Layton wrote:
> Add routines for encoding and decoding CB_NOTIFY messages. These call
> into the code generated by xdrgen to do the actual encoding and
> decoding.

The commit message needs to explain that the encoder is not yet functional.
Something like: "The encoder is a stub; payload encoding (stateid, fh, and
cna_changes) is deferred."


> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 25bbf5b8814d..ea3e7deb06fa 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -865,6 +865,51 @@ static void encode_stateowner(struct xdr_stream 
> *xdr, struct nfs4_stateowner *so
>  	xdr_encode_opaque(p, so->so_owner.data, so->so_owner.len);
>  }
> 
> +static void nfs4_xdr_enc_cb_notify(struct rpc_rqst *req,
> +				   struct xdr_stream *xdr,
> +				   const void *data)
> +{
> +	const struct nfsd4_callback *cb = data;
> +	struct nfs4_cb_compound_hdr hdr = {
> +		.ident = 0,
> +		.minorversion = cb->cb_clp->cl_minorversion,
> +	};
> +	struct CB_NOTIFY4args args = { };
> +
> +	WARN_ON_ONCE(hdr.minorversion == 0);
> +
> +	encode_cb_compound4args(xdr, &hdr);
> +	encode_cb_sequence4args(xdr, cb, &hdr);
> +
> +	/*
> +	 * FIXME: get stateid and fh from delegation. Inline the cna_changes
> +	 * buffer, and zero it.
> +	 */
> +	WARN_ON_ONCE(!xdrgen_encode_CB_NOTIFY4args(xdr, &args));
> +
> +	hdr.nops++;
> +	encode_cb_nops(&hdr);
> +}

There are a number of problems with this, but since there are no
callers yet, we can let some of those issues stand.

What is problematic in the longer-term is that this is a client-side
encoder (since this is the server's NFSv4 callback client).

xdrgen_encode_CB_NOTIFY4args() is an argument encoder, which is
client-side functionality, but it resides in fs/nfsd/nfs4xdr_gen.c,
which is server-side. Let's not mix these purposes.

I replaced the comment and WARN_ON with this:

+       xdr_stream_encode_u32(xdr, OP_CB_NOTIFY);
+
+       /* FIXME: encode stateid, fh, and cna_changes from delegation */

You can use xdrgen functions for individual data items, but for
full argument and response structures, only server-side is supported
at the moment. In the later patch that completes this code, I'll cover
the other fields, which can be a mix of open code and xdrgen.


> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index e1c40f8b5d01..790282781243 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -190,6 +190,13 @@ struct nfs4_cb_fattr {
>  	u64 ncf_cur_fsize;
>  };
> 
> +/*
> + * FIXME: the current backchannel encoder can't handle a send buffer longer
> + *        than a single page (see bc_alloc/bc_free).
> + */

Nit: The allocator function name is bc_malloc


-- 
Chuck Lever

