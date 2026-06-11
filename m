Return-Path: <linux-nfs+bounces-22469-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l+aTOB/rKmqTzQMAu9opvQ
	(envelope-from <linux-nfs+bounces-22469-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 19:06:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4830E673D81
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 19:06:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="bLS/pLBl";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22469-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22469-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 126743197567
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B9340F8CC;
	Thu, 11 Jun 2026 16:58:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C92404BCF
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jun 2026 16:58:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197108; cv=none; b=eza2iaUN1mz6T5uVuW5F99xZFPsUciRmL6UEGWw+/T6JI3AtGfN/3VSHj9fa4x/Cs5CeMaOFzKP5CTKy6GOheShgdC/vyiE+NExbdI/s6GHAG9RKdgthVBEbvYF7STKygG8oYCQ2t7+BvYI/gM4MMGIEKVho+pxu9p/J2Y0/s1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197108; c=relaxed/simple;
	bh=57+UDOrzT8ZASxWKfVUIIokgiWK5dApBMzotKdE4uVk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pnWFI8wa4QY+OTcFCwW/DfOj47h2g4JpSPJ/cV3ZJ1KnxDhWSFGyjSn0pS7JXHmYtAwBXcfWgLheJamsK4uxrq69NVPiDe/hjXA5aQ66CxGR10MYvXO9LSfG2DU1DDi2plFP0CQgdnf3PpuuzFZgUgacXEu2mK8D0X23pXZ9NPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLS/pLBl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E1C1F00893;
	Thu, 11 Jun 2026 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781197107;
	bh=SMecyiIwUmEwbbX7B4SKzwEk6ometKCg+r0kQDGKiFk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=bLS/pLBlUP4DJ02FLife1qKXq28mBqlr2o97IhkKAVPRUKVwHNyBs/tcKfv6oOw3W
	 9TPHXLIdO7g9CIoQ0V8vCdqy5fxBFqCsS5X8UudeFf57oK9caudLhg1BHm6y5+6rba
	 RfLIEwqpf8opBPGN5na4W5vAxFpsDGmRH7DUu8PIJ9CtlgDTGJykdCHGSNhmBZvKXq
	 j2SKM6Zj02/Zb5E9zRBC2LDI0qn7Ck9vjz1avr4fhonVhccyWrAl30TOt+RviYlJzI
	 rmDbPPhlB2hyWkrUZT32vYcqvuFEwqvTHYsmGWcVfqmdfQJRqpFbsf0W4YERJKE4cq
	 6Vq/5hNQuwwsw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 344EEF40068;
	Thu, 11 Jun 2026 12:58:26 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 11 Jun 2026 12:58:26 -0400
X-ME-Sender: <xms:Mukqaqv6NV5k4HtmmsMSiLTp4M9SoegyQ0fiimuRI0i-ApfUJHjnTA>
    <xme:MukqaqQwZNfC9Ag8kxCps1YJdiQn9pJE_ImX-GoGw58ZIzJlVgGYkxPPDB2Muczt-
    wu9XedES3d7eCn7N4KZUFjMQ7qH_IS09TDDcPnogQVDKN24skDNhiFy>
X-ME-Proxy-Cause: dmFkZTEX617BxPthPnkuLI1Y59v4aE3u3tx3f3ZB0RUoxX083b1qRXFI5gOCRSlwGKKuYn
    COVUDxdziiv8ZY6TlS1xQ35vg1442e7hEbldSK8WacPXQ9cL9/lU/YEiFNL2l4YYa3buQZ
    y4S0f6bDxO9AqeCNtKeiKrLqhjs9c/rmfdZMm9W4vy7+V6ghmvYteBiOgnSehUVYJ7tRXm
    QEzvd2sKGUPmN55pHojPbaonBOQ1aQh9xpJIhftbxLkk98/bAATC2o7BEC/LE+/WZq2uAp
    wlsCnGlhiMIuXiRHWqrImNb53pxHvYZytH9qMK3ZNRVnR5r1HvT77wnfSGn7njgP9BUstT
    vZDSsykE1tWYeHBFAN1HF+pP/m9mdyL/cJUcusQ4xGixVntXWrUbfYDvmwXDgFllTpUL4h
    BYBPcBzrWAvW1v1ErxzcBf1t28VCLpH6xofWhN1dCOERR4VVpstdUxx7FW85jzpqL7D/GV
    ExTIHfZ4N+IEkH62V7KJOqcI+eSYsIe1ljsYXbM1c4AZcYNtOCR0vGn/N5jeRCT4RHqCIS
    gYIeg8icHA8s8ff3LeaonzDmMGwfPrS8fz+1LO1Lz+5Eu4gpI3ANg6BbhnGjjO0mBFZ5/A
    6r2xqwxkq2Zdc+gwGi0ACD5CRAAWERuuS9MTGpBLOuWONLhkJuahslFARhuw
X-ME-Proxy: <xmx:MukqapZicAg5ATbPPajA9wTkbYxg7zxj3ldl0ZE3_gm_Yr_C-4wx4Q>
    <xmx:MukqauUGj65VwmL78s5yNEQq6Ijk1nvQc2OLtBJ0Z368YOKOvCsgJQ>
    <xmx:Mukqajgr-q2IgGq5hr2t2gLe5lnmJ5kSzlHi77V3BoYqwB96mdBtQQ>
    <xmx:MukqakWikNthglUAGzuB-6B-Ys8pqhkTfIyT9VKb5Is1vMNCp7ofew>
    <xmx:MukqaiPIj7cT2uuvKn4StvzSCJzQ2G5FvKmyaVg7xoOak6T69nQPguDA>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 14DFB780075; Thu, 11 Jun 2026 12:58:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9GoOGXi325c
Date: Thu, 11 Jun 2026 12:58:05 -0400
From: "Chuck Lever" <cel@kernel.org>
To: robbieko <robbieko@synology.com>
Cc: linux-nfs@vger.kernel.org
Message-Id: <5e5dd51f-68a7-45bf-b9c7-e056c45c86b2@app.fastmail.com>
In-Reply-To: <20260611040946.3507020-1-robbieko@synology.com>
References: <20260611040946.3507020-1-robbieko@synology.com>
Subject: Re: [PATCH] nfsd: reject out-of-range nseconds in NFSv3 nfstime3 decode
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
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS(0.00)[m:robbieko@synology.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22469-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,synology.com:email,app.fastmail.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4830E673D81


On Thu, Jun 11, 2026, at 12:09 AM, robbieko wrote:
> From: Robbie Ko <robbieko@synology.com>
>
> The NFSv3 nfstime3 decoder svcxdr_decode_nfstime3() accepts the 32-bit
> nseconds field from the wire without validating its range. RFC 1813
> does not constrain the value, but a tv_nsec >= NSEC_PER_SEC is not a
> valid timespec64. The NFSv4 decoder nfsd4_decode_nfstime4() already
> rejects such values with NFS4ERR_INVAL; NFSv3 had no equivalent check.
>
> A malicious or buggy client can therefore send a SETATTR carrying an
> out-of-range nseconds (up to 4294967295). The value flows through
> nfsd_setattr() -> notify_change() -> timestamp_truncate(), which does
> not clamp tv_nsec to < NSEC_PER_SEC when the filesystem supports
> nanosecond granularity (s_time_gran == 1). The inode atime/mtime
> setters store it verbatim (only ctime is normalized via
> inode_set_ctime_to_ts()).
>
> The un-normalized value then corrupts on-disk metadata: ext4's
> ext4_encode_extra_time() shifts tv_nsec left by EXT4_EPOCH_BITS, which
> overflows the 32-bit extra field and clobbers the seconds-epoch bits,
> so the stored seconds (year) are wrong on read-back. XFS with bigtime
> mis-stores the timestamp for the same reason. This is silent, with no
> WARN_ON anywhere in the path to catch it.
>
> Validate the decoded nseconds in svcxdr_decode_nfstime3() and fail the
> XDR decode if it is out of range, mirroring the NFSv4 behavior.
>
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>  fs/nfsd/nfs3xdr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index 2ff9a991a8fb..59e82ce03c20 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -64,6 +64,8 @@ svcxdr_decode_nfstime3(struct xdr_stream *xdr, struct 
> timespec64 *timep)
>  		return false;
>  	timep->tv_sec = be32_to_cpup(p++);
>  	timep->tv_nsec = be32_to_cpup(p);
> +	if (timep->tv_nsec >= (u32)1000000000)
> +		return false;
> 
>  	return true;
>  }

I agree this issue needs to be addressed, but I have a reservation
about how the request is rejected.

Returning false from svcxdr_decode_nfstime3() turns into SVC_GARBAGE,
so the client gets an RPC-level GARBAGE_ARGS. But an nseconds of
4294967295 is perfectly well-formed XDR: it decodes cleanly into a
valid uint32. Nothing about the request failed to parse. GARBAGE_ARGS
tells the client "I could not decode your arguments," which is not
what happened -- we decoded them fine and are rejecting the value.

RFC 1813 supports a different response here. It places no range
constraint on nfstime3.nseconds, and the SETATTR ERRORS list includes
NFS3ERR_INVAL. The IMPLEMENTATION notes describe NFS3ERR_INVAL as the
error for a value the server "can not store ... in its own
representation" -- an out-of-range nanoseconds is exactly that class
of problem. So the RFC-aligned status is NFS3ERR_INVAL, returned from
the SETATTR proc, not GARBAGE_ARGS from the XDR layer.

That is also what NFSv4 actually does. nfsd4_decode_nfstime4() returns
nfserr_inval, which becomes the SETATTR operation's status -- an
INVAL the client maps to EINVAL. The v3 patch returns GARBAGE_ARGS,
which maps to EIO. So the two paths produce different errors on the
wire, and the commit message's claim that this "mirrors the NFSv4
behavior" is not accurate. I'd ask that the message be reworded to say
the value is well-formed XDR but not a valid timespec64, rather than
framing it as an XDR failure or a 1:1 match with v4.

One more wrinkle: svcxdr_decode_nfstime3() is also used to decode
sattrguard3.obj_ctime. The guard is a comparison value, not a value
to be stored; RFC 1813 says a guard that does not match the object's
ctime yields NFS3ERR_NOT_SYNC. An out-of-range guard ctime simply
never matches, so the protocol-correct outcome there is NOT_SYNC.
Rejecting it at decode converts a legitimate stale-guard case into
"your RPC is garbage."

So let's rework this fix to handle the range check in the proc
functions and return appropriate NFSv3 protocol status codes rather
than rejecting the RPC Call outright.


-- 
Chuck Lever

