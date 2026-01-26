Return-Path: <linux-nfs+bounces-18491-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LtgJxe6d2lGkgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18491-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:01:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4041C8C4AD
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7251930058F1
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 19:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A7A20B810;
	Mon, 26 Jan 2026 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXHtuceF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529921F30AD;
	Mon, 26 Jan 2026 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769454101; cv=none; b=ItOlXb7x6cK30ClUWH5vYh1Pgb20Ctl6fHMKdueISD+oJaKZBUT3AQaPQEOg1XodWmJISvMYn+5YrkNO7Dw2s7hBgQU9PW2FcRFZluSYIGjseOjifuO8GqhtY+dWiG3XdAHTg/HzS+aedJdhV0MV/Mg5vSMt2KxWUpBD8frPbEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769454101; c=relaxed/simple;
	bh=l93hlbEyLc+w9+V7vcsTvvUPIRFqS0itMLiaYqMaNFY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hPxbekMyfz8JCgIVXWqdALSBTNEiSNCDEwIshFZYtHFWmvxO+9H4QidWr6+/TlBzB6FDb7eiEz7jQgHh8UHmI/yquL6uorurRu8Nxkofy3BODxj3bv0eyHUNk5Uqel3bijSADlSZhULoNJ6HHlI411a/+G610USkSqzRgthXhpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXHtuceF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999A0C116C6;
	Mon, 26 Jan 2026 19:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769454101;
	bh=l93hlbEyLc+w9+V7vcsTvvUPIRFqS0itMLiaYqMaNFY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pXHtuceF8rrbD3JUjmXCAzZzpCxqmPanXzVO9Hx1/ElROCQrkESEeXrtCy57JHMk4
	 KVbYGsVBx3RUQ3VYfCn2B2cdf9Uevw42IDK4DrBpy+JdddIBefLBFhTSjnk/08qbSc
	 HHQ3MRPHXBDniRi8pzmaFdABzJc+MQZ16i9hALh6DJ95F9Y43mrgT07J71LqaSWYKa
	 pA+L3UNHtBEvu25PQgCM+u82WUO1rPwwnZ3bb8ATssGoMTXh7dxHRphBBySzGlEHS0
	 F040kLmb3iEU/mtAET3KK/qjziUwPNGJM5TXHXQ1+wT4fJ2a9kBjjHD4nG1Ozzs+b9
	 GWR/1xMSU+oxw==
Message-ID: <19540d70aaa8d92a65625f1a4530824d92f6ba44.camel@kernel.org>
Subject: Re: [PATCH] sunrpc/xs_read_stream: fix dead loop when
 xs_read_discard
From: Trond Myklebust <trondmy@kernel.org>
To: "jack.zhou" <jack.wemmick@foxmail.com>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, "jack.zhou"
	 <jacketzc@outlook.com>
Date: Mon, 26 Jan 2026 14:01:39 -0500
In-Reply-To: <tencent_DBA407008574A1E4BF7F27AD38AD4D13730A@qq.com>
References: <tencent_DBA407008574A1E4BF7F27AD38AD4D13730A@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18491-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[foxmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email,hammerspace.com:email]
X-Rspamd-Queue-Id: 4041C8C4AD
X-Rspamd-Action: no action

On Mon, 2026-01-26 at 14:25 +0800, jack.zhou wrote:
> From: "jack.zhou" <jacketzc@outlook.com>
>=20
> Hi maintainers,
>=20
> This bug was discovered during following scenario:
>=20
> 1. Using NFS client with TCP mode
> 2. RPC_REPLY process
>=20
>=20
> Let's first review the normal process:
>=20
> 1. The `xs_read_stream` function is located within the for loop of
> the `xs_stream_data_receive` function. The condition for exiting is
> that the return value ret of the `xs_read_stream` method is < 0.
> 2. When entering the function `xs_read_stream`, since `transport-
> >recv.len` =3D=3D 0, `xs_read_stream_header` will be called first. Based
> on `transport->recv.calldir`, it decides whether to execute
> `RPC_CALL` or `RPC_REPLY`;(and also sets the value of `transport-
> >recv.len`)
> 3. Since it is executing `RPC_REPLY`, the return value of the
> function `xs_read_stream_reply` is provided by tcp.c's `tcp_recvmsg`,
> indicating the size of the copied skb, and this value is > 0.
> 4. Since it is a normal process, it will reach the end of the
> function and return, which is:=20
> ```
> transport->recv.offset =3D 0;
> transport->recv.len =3D 0;
> return read;
> ```
> 5. The returned 'read' is the return value of the function
> 'xs_read_stream_reply' in the RPC_REPLY process. Since this value is
> > 0, the `xs_stream_data_receive` function's for loop cannot be
> exited.
> 6. After re-entering the xs_read_stream function, since transport-
> >recv.len =3D=3D 0, xs_read_stream_header will still be called.
> 7. Since the skb is empty, tcp.c's `tcp_recvmsg` will return a value
> < 0, usually -EAGAIN (-11).
> 8. Since the return value of xs_read_stream_header is < 0, the goto
> out_err statement will be executed.
> 9. The for loop of the xs_stream_data_receive function will be
> exited.
> 10. The next time xs_stream_data_receive is entered, the above steps
> will be repeated.
>=20
>=20
> Now we are encountering an abnormal process:
>=20
>=20
> 1. For some reason, skb is contaminated, and `transport-
> >recv.calldir` parses out an incorrect value, so `msg.msg_flags |=3D
> MSG_TRUNC`;(and also sets the value of transport->recv.len)
> 2. The `if (transport->recv.offset < transport->recv.len) {}`
> condition will be executed
> 3. The return value of function `xs_read_discard` is > 0, so when
> returning to the upstream `xs_stream_data_receive` function, the for
> loop cannot be exited
> 4. When entering xs_read_stream again, since transport->recv.len !=3D
> 0, `xs_read_stream_header` will no longer be executed, which means
> `transport->recv.calldir` cannot be correctly set anymore
> 5. This is fatal for all subsequent RPC Replies because `transport-
> >recv.calldir` cannot be correctly set anymore, so they will all go
> to `xs_read_discard`
> 6. At the same time, since transport->recv.len has not been reset to
> 0, this loop will become an infinite loop
>=20
> Therefore, my approach is:
>=20
> After reaching the point of `xs_read_discard` due to an abnormal
> situation, the value of `transport->recv.len` will be reset in the
> same way as a normal return, in order to prevent a deadlock from
> occurring.
>=20
> The modification has been tested and passed in version 5.10.160.
>=20
>=20
>=20
> ---
> =C2=A0net/sunrpc/xprtsock.c | 14 +++++++++++---
> =C2=A01 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 2e1fe6013361..91d1b992eb7f 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -695,6 +695,13 @@ xs_read_stream_reply(struct sock_xprt
> *transport, struct msghdr *msg, int flags)
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> +static void
> +xs_stream_reset_recv(struct sock_xprt *transport)
> +{
> +	transport->recv.offset =3D 0;
> +	transport->recv.len =3D 0;
> +}
> +
> =C2=A0static ssize_t
> =C2=A0xs_read_stream(struct sock_xprt *transport, int flags)
> =C2=A0{
> @@ -740,8 +747,10 @@ xs_read_stream(struct sock_xprt *transport, int
> flags)
> =C2=A0		msg.msg_flags =3D 0;
> =C2=A0		ret =3D xs_read_discard(transport->sock, &msg, flags,
> =C2=A0				transport->recv.len - transport-
> >recv.offset);
> -		if (ret <=3D 0)
> +		if (ret <=3D 0) {
> +			xs_stream_reset_recv(transport);
> =C2=A0			goto out_err;
> +		}
> =C2=A0		transport->recv.offset +=3D ret;
> =C2=A0		read +=3D ret;
> =C2=A0		if (transport->recv.offset !=3D transport->recv.len)
> @@ -751,8 +760,7 @@ xs_read_stream(struct sock_xprt *transport, int
> flags)
> =C2=A0		trace_xs_stream_read_request(transport);
> =C2=A0		transport->recv.copied =3D 0;
> =C2=A0	}
> -	transport->recv.offset =3D 0;
> -	transport->recv.len =3D 0;
> +	xs_stream_reset_recv(transport);
> =C2=A0	return read;
> =C2=A0out_err:
> =C2=A0	return ret !=3D 0 ? ret : -ESHUTDOWN;

NACK.

If we're in the xs_read_discard() case, then that's because we're out
of receive buffer space, and so we've given up reading the remainder of
the message into that receive buffer. However we still have to read to
the end of that message before we get to the next message in the TCP
stream. The only thing that can prevent that is if someone breaks the
connection, and in that case the client already takes care of resetting
the message state as part of reconnecting.

With this change, then as soon as there is no more buffered data to
read from the socket and it returns EAGAIN, you will reset the message
parameters. The result is that the next call to xs_read_stream() will
just leave us reading random data from the middle of the message as if
it were a new message header.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

