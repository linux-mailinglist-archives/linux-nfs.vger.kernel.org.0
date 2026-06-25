Return-Path: <linux-nfs+bounces-22838-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 74WQHH5TPWqH1QgAu9opvQ
	(envelope-from <linux-nfs+bounces-22838-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 18:12:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9146C75E0
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 18:12:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YwzrHTpa;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22838-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22838-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B56D23004C6B
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 16:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278E6288BA;
	Thu, 25 Jun 2026 16:10:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0EA3A0B13
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2026 16:09:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403801; cv=none; b=OGG+Jh0YatrQZjm1CoUxy/JmlW2GPc+IL9uH8Of4Q53RONvapdg/I5s6rpGI98gzaXXMCNRFW8gJ7c8kqpfBj1xDK08O4q3DQd+lzfRUB89Idq930mavI53yOc2qPyxK25k7EEbFX73QDbCwkHTDl1688fiMO9cLT7tiYO7+XJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403801; c=relaxed/simple;
	bh=O8cdYcwGPgNoYYGq1KrGJbYxcKrt8wXfjjZsY8Slimg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hlHZ0tbc5AHzeoeQ3TO8ScHf1/pFaNm3aJXvljV/PyoMBdJaNkoY2q5sTgfDwCaj0nyx7dW5tpu4Avql+0x+Fbdo7TmlR3/vwupRKkkTRFd+a07cWhqvVyWRdHDQhvl2MKmZZKFI7DiSZ19ls1dpCJaoocEPM6OGeBxempKcU1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwzrHTpa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691371F00A3A;
	Thu, 25 Jun 2026 16:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782403799;
	bh=MICoBL7Ow0IFraDx5h5csbQaXXlJDNzw5jbk+DeBsRI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=YwzrHTpaWe845kej4y3N+TZKcUgEUQR81wXKz88Tjuu/ILEtxQAl1rOhkwr1BpNSq
	 W/T8QDYM6Qq1e5pDbr6Ccodxnfzqrj/F8V/1cfJl4Tw1qrOA4mmSLquXqN1MUZHN0F
	 gJ6CExFRdDJhcT7XWSG9KCnlhSUUYjg2JE0VjJmQgZ45MRQ1nPHqcpgFzRVnCKyIXe
	 GXTJ8UVE7E8/k4B2v8lxi40m9p9e10JGp7j71dYQxDGf0zMPXb8NdQoQ8eGoztXpej
	 1EdbNmPw97pdqK0zUfLbm9AJsX9SdLsX9gZYUPd1wyWBA2TG5CGSKmfZcZg48JCdU7
	 VZ4QeKnf8yOHw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id A899FF40090;
	Thu, 25 Jun 2026 12:09:58 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 25 Jun 2026 12:09:58 -0400
X-ME-Sender: <xms:1lI9atPzV5FmsYjWbZjeobxvXnjLeSUz4ysyX2eGoqPWbftbPxcFTw>
    <xme:1lI9aqw2lYMU4TT-0jo63202rYeXSVA38IjNwIBUG8DgX0fKJNXpf7SkxNePLBPgj
    WFzN64Z5SMeD9EuX6Hbmi2pWIJuhYIDRez10h31eK9oOHysAVGc0Q>
X-ME-Proxy-Cause: dmFkZTEXrMi0dOAw3Y5DHSxgQHOz5FsGonpYlnkT+iz6XcX6Qq2A5Ql9LhI5IvnxF6olWK
    GXWHavYeGOcKw8XzmbFuFPBgzm7R9kLdibZAWUmSeJb88G1ghDBJlI2koDsuaSPR6iDRHr
    Age7YGfkl9YdJBh/G6WmUrSPP1GvlS7k1u3DXakfHS0edzRZf8rY7MODH2MAX4Rw4tKkva
    zz3j+CIUWmWqPW3JVnVPr8uiNAeWwvYtShthHKtY+YvKUWxSVPQ0vFZVzRIEWvoL+YG8VR
    D2EV2eRMin+rwaTTPaz/xz8n2qSqtv6LRS9WX4i23PLR7V63zGOtYmNKghrHqXOgTtMESZ
    X2npXZQt1x/Gw+mxcR3d8HQIJ7dNOeuGeqrWWTO8chZzGWZ4a4T3JWurL+eNMbwDQl7kPQ
    7cDSaVn4k5yG8Gg2ON4Knn1ZUzIheXxba5j8rBefdGhy1w2zqgkI1iMTerNuoQFeY2w402
    hJaGzJp6CkqU2IdL+dDXjyt30+0DAY1n6OMBGdx+W2rNHr9TQObgvzmk6GZTqPv7byFL/o
    8oRQ/WcMJJJItXw/JhaDdLpeXEoYwIzi1S78dEZNirXRwSxOXMVhpQUPylEjs8WoSZfgwn
    nNokPz6G2IwfuksVFW2c/bSgr2VXf7PZpY7CgL+keJxznhAI3QEvUoB4EU0A
X-ME-Proxy: <xmx:1lI9aouimS--ExxZ80k7qhGIgJRS7a_fWlNymBUtAKFYGmWQziRekg>
    <xmx:1lI9aogYDN-olzU0YVeqPzeQ3Yv7Ry5yNu98tiR_qKWtTpSE9Zvjtw>
    <xmx:1lI9auZ5rr9ZR22yiK66q80YS3MF3yXbflecbrDywMB8v1HmohrMyw>
    <xmx:1lI9anYC2Qu2lOh-oCQOLd3YgKvKeT4M5i-cgg2Oj7zqtA007pS_fA>
    <xmx:1lI9ajx5JDBiZGBQrglVEgdTgsI8Vj7n5QVL7XyQ26qFGVe__tdN5Lnt>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 83B4D780AB9; Thu, 25 Jun 2026 12:09:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZtupiH6svBZ
Date: Thu, 25 Jun 2026 12:09:38 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <ben.coddington@hammerspace.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neilb@ownmail.net>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: "Daire Byrne" <daire@dneg.com>, linux-nfs@vger.kernel.org
Message-Id: <538fd605-e7be-4450-ad3f-804fad6224eb@app.fastmail.com>
In-Reply-To: 
 <8b65b751a62984fa08797b18be7dfaf16bdb3721.1782314746.git.bcodding@hammerspace.com>
References: <cover.1782314746.git.bcodding@hammerspace.com>
 <8b65b751a62984fa08797b18be7dfaf16bdb3721.1782314746.git.bcodding@hammerspace.com>
Subject: Re: [PATCH RFC 2/3] SUNRPC: dispatch idle transports ahead of backlogged ones
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ben.coddington@hammerspace.com,m:jlayton@kernel.org,m:neilb@ownmail.net,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:daire@dneg.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[hammerspace.com,kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22838-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE9146C75E0

On Wed, Jun 24, 2026, at 1:04 PM, Benjamin Coddington wrote:
> A pool dispatches ready transports in FIFO order, so a connection that
> already has requests in flight sits in the same queue, on equal terms,
> as one that has been idle.  A client driving many concurrent requests
> therefore delays the next request of an interactive client whose
> previous reply has already completed: the interactive request waits
> behind the busy client's backlog even though servicing it costs a
> single round trip.

> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 63d1002e63e7..ec4c05094e9a 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -523,7 +523,10 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
> 
>  	percpu_counter_inc(&pool->sp_sockets_queued);
>  	xprt->xpt_qtime = ktime_get();
> -	lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts);
> +	if (atomic_read(&xprt->xpt_nr_rqsts))
> +		lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts);
> +	else
> +		lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts_hi);
> 
>  	svc_pool_wake_idle_thread(pool);
>  }

The classification is keyed on in-flight request count, but a deferred
close is enqueued the same way.  svc_xprt_deferred_close() sets
XPT_CLOSE and calls svc_xprt_enqueue() while the slot is still held;
svc_rdma_sendto() on a send error is one such path, and 
svc_check_conn_limits() is another.  svc_handle_xprt() reserves the
slot before calling recvfrom and releases it only after svc_process()
returns; recvfrom clears XPT_BUSY in between (svc_rdma_recvfrom ->
svc_xprt_received).  So the deferred close is enqueued with XPT_BUSY
clear and xpt_nr_rqsts != 0, and the close lands on sp_xprts.  Since
svc_xprt_dequeue() drains sp_xprts_hi first, the teardown waits behind
idle-flow traffic precisely when the server is busy and wants the
resources back.

Control work isn't request work, and svc_xprt_ready() already treats
XPT_CONN|XPT_CLOSE|XPT_HANDSHAKE as a class distinct from XPT_DATA.
Routing that class to the high-priority queue regardless of the request
count keeps the two consistent:

  if (xprt->xpt_flags & (BIT(XPT_CONN) | BIT(XPT_CLOSE) |
                       BIT(XPT_HANDSHAKE)) ||
      !atomic_read(&xprt->xpt_nr_rqsts)) 
        lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts_hi);
  else
        lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts);

The burst-allowance patch narrows this -- a close with credit left
rides sp_xprts_hi -- but a flow that has spent its budget still routes
its close to the bulk queue, so the gap remains for exactly the
backlogged connections most worth closing promptly.

You should also have a look at the pre-existing issue that sashiko
identified: it might be amplified by this patch, so we should
consider addressing that issue as a pre-requisite to this series.

https://sashiko.dev/#/patchset/cover.1782314746.git.bcodding@hammerspace.com?part=2


-- 
Chuck Lever

