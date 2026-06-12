Return-Path: <linux-nfs+bounces-22526-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SOf7Oa1ILGo7OwQAu9opvQ
	(envelope-from <linux-nfs+bounces-22526-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 19:58:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 533FD67B79B
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 19:58:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=P9sCRa1d;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22526-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22526-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0518A311A7C1
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 17:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBE837416F;
	Fri, 12 Jun 2026 17:57:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE2E36C592;
	Fri, 12 Jun 2026 17:57:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287069; cv=none; b=BaoIg1A8f5rDyW7/ilavYILLGrJsFwvJlM2PK8X1NC9qG9ISrQHe6kL/ekH/x+iG9UDSndr4LDA+BqjDwvIhAFkY0jl3jr6KQRr8c2F53z0zFoFWjH8hzTDmU0iqzmLlIwGRyZn7tgD6UPAOVzDFvwaUTpxsQujDCSaOP/Xu6YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287069; c=relaxed/simple;
	bh=qrUU/I/MhpwU2lCjSSmWYQDGD/pC3gZqQF1rOtHSFsU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=W18Z+NdVxpGKsW1Jntx53NMastlDvBYsBT4JcFFsKCneGVrrl3YwViP27hbd1imAPq2K/0wKDZNtyR4o2NepiIwDqWrkzH3T7NTyYv3k39bWoLM2LpwtOI+VKKwza0/k3tloyRBksYsLkxqjdyE1zD/77dkagK/2Rqm+rFChVho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9sCRa1d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB741F00A3E;
	Fri, 12 Jun 2026 17:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781287068;
	bh=qKnmY94ujBnVl8xEP0bE4WWiBkQvevQ2ZRGhSM+2r0U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=P9sCRa1dD8D0yEYkqhJC9YwX8RCtzV20dR3LeW1St+Kejq9w5u3NBPLWH+8Dtuv7N
	 q6VovVUncCYVsoPsrYF5IC2NsREg0TECYBj8TjsUOm1w39+lNBqVtYybbLFWPSsoZE
	 hBy8Le5T5uYZcAn6/Ukhtv5ci/HI3Nd1Mpk2NTbx4fMP+H0VLvjGF74TckoIGFCDRR
	 R1pHxDzA/nlTybwGcgzQ7bJ4aMIdoGtOXAedJQNOhdW7cCznWWKkZC/uG1wW/pYCbH
	 X+yLP2DPpeP9IBBolmRrgqtPHHvBiziFN9LlR5UZmQ8/G3/Xl7wkcbk2nbL/Mnm82t
	 MVyTtcSyeSLXQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 98EC6F40068;
	Fri, 12 Jun 2026 13:57:46 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 12 Jun 2026 13:57:46 -0400
X-ME-Sender: <xms:mkgsaoBrqJCVxAfelLY6WlfBBcakASHPJO_5TKXAWj35k8G-_hi0MQ>
    <xme:mkgsalWZ2d2jzdldJLU1Hi59IKlNmURTURWq1v8zgkPWxas2FQ1dqSs2xzWN9zoIb
    P6rt57uEjUWqZf1-U9I-UwGi_fEFvPWZim6BzupAk44fwhUWoUPOcSe>
X-ME-Proxy-Cause: dmFkZTFjhsR4D7eKIbH5F7KG4gFCzzMXBG+6vWiNR8RCCciXzIdB0iYrNrtbPAAw3gED1O
    ki4/jGbxobZu0jlK+o9n0hLjRt53QEVNvSl6NOd5GeRbSZQ6SpvUnpFVJ+D1/0ZITLg1My
    qD8Ufs/dZKoELWqiS1JWDcWVrk6vkyGOBVTngQwHVMGnNjr2yTX12mw+hCAmMVSVFJtuV6
    bMPYkZgszBkoVGxvqE8Z07VX4HvVyFTEwIJsMN31UvXy2mzI19ikRnPz2zqh2jtLiECqhg
    ZA+x9RPDastAOTAXj5wJhdSZAbw/wBp/uJBImNj8ugXRihM7V4OE3+KdPirA3R6hsFxTqA
    jSr8O6LNVSPVPHo0VpqP6LaISjfwsvLcUIZOrSUWiJw7B7GIE9b+gBNyuRtztS5+gfTFzE
    84ArQIj/5ua/lpyAr9mKBwz7NSXgUSAL2og545qH42SQi2PjdfbVklGoqtInrLEzksnbxu
    IqD6xmo3LbQqvlcK7xYgcQqDWRUTh2LiWPsKvulthZKu8HCbq46stuaIxCm43fhNnLERcy
    C15+BWPGG7ZHw5NJbgYvzKFNg+mRAzeECiVwyBpSbcOjcA1SAOqmZ1dTnJDlmwvlxYmN6H
    LpJBvoeOt0ca2dyg7Q8yjkfB1LFcv8kEDzJon3xrqVg9bhwZgwchCPc00irw
X-ME-Proxy: <xmx:mkgsama3n1BjTPHMGH_DspEnQmL6WFBZAtEJQ39mhbkOmqeY4ganCQ>
    <xmx:mkgsauSRoNU9A1l7q2SKgGabryNpsg8axOUehdQ2V4PUS48cnft-zQ>
    <xmx:mkgsapg-7aGHr0E12Pc1Oey6d2VE88NSRvG689UvRio5bHOy4Cu_RQ>
    <xmx:mkgsap6FY3gvnkRsuIKSxZowVBnbhSZyXt6SppLIPbVb3-ww0K-Wng>
    <xmx:mkgsakm_J-ejhsk4Z839oT8sBxgchmlG56cxssUs8jLf54JjtjvObVR8>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7408F780070; Fri, 12 Jun 2026 13:57:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqANW_W8EHC7
Date: Fri, 12 Jun 2026 13:57:26 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
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
Message-Id: <b43a8d34-52b9-418c-8df0-76bd1c3553cd@app.fastmail.com>
In-Reply-To: <20260611-dir-deleg-v6-11-4c45080e5f3f@kernel.org>
References: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
 <20260611-dir-deleg-v6-11-4c45080e5f3f@kernel.org>
Subject: Re: [PATCH v6 11/20] nfsd: apply the notify mask to the delegation when
 requested
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.65 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22526-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,app.fastmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 533FD67B79B



On Thu, Jun 11, 2026, at 1:50 PM, Jeff Layton wrote:
> If the client requests a directory delegation with notifications
> enabled, set the appropriate return mask in gddr_notification[0]. This
> will ensure the lease acquisition sets the appropriate ignore mask.
>
> If the client doesn't set NOTIFY4_GFLAG_EXTEND, then don't offer any
> notifications, as nfsd won't provide directory offset information, and
> "classic" notifications require them.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 0c37d7c6d28c..29f7339dc220 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2530,12 +2530,18 @@ nfsd4_verify(struct svc_rqst *rqstp, struct 
> nfsd4_compound_state *cstate,
>  	return status == nfserr_same ? nfs_ok : status;
>  }
> 
> +#define SUPPORTED_NOTIFY_MASK	(BIT(NOTIFY4_REMOVE_ENTRY) |	\
> +				 BIT(NOTIFY4_ADD_ENTRY) |	\
> +				 BIT(NOTIFY4_RENAME_ENTRY) |	\
> +				 BIT(NOTIFY4_GFLAG_EXTEND))
> +
>  static __be32
>  nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
>  			 struct nfsd4_compound_state *cstate,
>  			 union nfsd4_op_u *u)
>  {
>  	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
> +	u32 requested = gdd->gdda_notification_types[0];
>  	struct nfs4_delegation *dd;
>  	struct nfsd_file *nf;
>  	__be32 status;
> @@ -2544,6 +2550,12 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
>  	if (status != nfs_ok)
>  		return status;
> 
> +	/* No notifications if you don't set NOTIFY4_GFLAG_EXTEND! */
> +	if (!(requested & BIT(NOTIFY4_GFLAG_EXTEND)))
> +		requested = 0;
> +
> +	gdd->gddr_notification[0] = requested & SUPPORTED_NOTIFY_MASK;
> +
>  	/*
>  	 * RFC 8881, section 18.39.3 says:
>  	 *
>

When a client requests NOTIFY4_GFLAG_EXTEND | NOTIFY4_CFLAG_ORDER
plus ADD/REMOVE/RENAME, the assignment still grants the content
notification bits because it only requires GFLAG_EXTEND. The rest
of NFSD's CB_NOTIFY encoder does not store that order-aware request
and emits zero/absent cookie and previous-entry information, which
is only safe for order-unaware clients.

An order-aware client can then keep an ordered directory cache from
unusable notifications instead of having the delegation recalled.

The bis draft requires order info for order-aware clients, or recall:

   - 27.4.5 (REMOVE): "If the client is order-aware, the server will send
     the cookie value as part of this."
   - 16.2.13: order-aware == NOTIFY4_CFLAG_ORDER set OR NOTIFY4_GFLAG_EXTEND
     reset.
   - 16.2.11.3: "If the client is concerned with entry order and these
     notifications ... cannot be sent for any other reason, then the
     delegation is recalled."

This patch's own first rule (drop everything when GFLAG_EXTEND is
reset) is exactly the order-aware -> no-notifications principle
for legacy RFC8881 clients. It misses the parallel case:
GFLAG_EXTEND set PLUS CFLAG_ORDER set is also order-aware.

This finding is latent when this patch is first applied, but the
NFSD's negotiation is incorrect for any future order-aware client.

I don't see this issue addressed by a subsequent patch in this
series.


-- 
Chuck Lever

