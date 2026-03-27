Return-Path: <linux-nfs+bounces-20467-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFI5MISqxmk4NQUAu9opvQ
	(envelope-from <linux-nfs+bounces-20467-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 17:04:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF6E3471C5
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 17:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB30B3033D0A
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139E133F582;
	Fri, 27 Mar 2026 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFt4c9/7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C10334C2B
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627394; cv=none; b=CE8x3DPXIH8QgjaxZjHShowXWmlwZtunNLT5w8pcYqscLaa8X4wEK8mhHZc4ZgV6bagVM2YZxAj5KKdaE0TukO/p48OUYtjzz/w0L3W+g8Alu2YMZTUZqIbv3ONsLFQ3X8uCNbaJqj7dgihEt6Zti3yU0v0jIq8RuEClnfpEdd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627394; c=relaxed/simple;
	bh=4MuvB9E1ADBQail6RE76yGkGwgUHq+uxRkip9sL1rF8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=op0Ehk+k9OAI/pgx8SwMGYENSLdWHNG7lnNFcsNPKXkiZZOM6wPOyx0SdjtpdDzuo3GD9vdgGS58dnz+5m4/fWc+GFgOIxKoUXY7nIEIJoA2O6UbqZ+Jwd7g8VFTpTibDrZZMDHL5qBYTKnqfT0xH1AxprFjwLMvstyM98ENsYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFt4c9/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580D8C2BC87;
	Fri, 27 Mar 2026 16:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774627393;
	bh=4MuvB9E1ADBQail6RE76yGkGwgUHq+uxRkip9sL1rF8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=cFt4c9/7j4JijVAu/8U0WjHxmJJBfRFl+N9P8Fuc8PwUdYV6r0w7v+RaqTMsv4CA2
	 DX6k+YmOI4zxp3906ypJX3iQobUnUsohlcL4WD/Wpf3xMA7dnucaz1PM1J0qX0N4AH
	 M1H65DfT10hVhnEDSGqj3riWHFzcSr/8QMKcBHgEGm17NPHncgJc6nelLo8aZgC/xr
	 9KmxykXf8E1OKXmpWsIhgzHwEFr1oT8tRgmNsc4kqGcp2bTBQbgIMcUPxO3Vp73yW4
	 AYmZsGeqb97Mh2L3up/nBP2hgci3SEFnvmedqR7NVaKzIiSaETurEgu4qqEYNQvJvT
	 CZFjxSsXnzbBQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5FFDFF4006E;
	Fri, 27 Mar 2026 12:03:12 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 27 Mar 2026 12:03:12 -0400
X-ME-Sender: <xms:QKrGaf2DtmA5vuxVtjmgyMKHQovA-sCPfpszA3hj0iNdgCtqJLiadQ>
    <xme:QKrGaY5UFhcmVccCrlqhl3iWVLmIWhjTOs1UuT16hwTjJY9HIp2cnAXaITDZm41tB
    jYN943yubWISuFeD8qAlnXorF8Ky7sdM36g0o0uF3-tSgSdNrefkyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtgho
    mhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtph
    htthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhes
    thgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QKrGaaWZM0KRqAkq5mDM-KvTwQLNosSQKJ8kphxcVN7qo0I05Gjylg>
    <xmx:QKrGaSmn1ib5pqtGM4tz6SPnMbJpZ2AP3cGzPhQFfn9zjXKfidUZew>
    <xmx:QKrGaQlTI45z4f2lJfqqg0XnLZ4wRGXJqV1HI16IcAMqxxoyrOzXDA>
    <xmx:QKrGaSZRpM6Ye2owsBRPmtwsk9Ag60ak-kDE0mPut67hl8nhboF6gw>
    <xmx:QKrGaSSGBOclwDyWKMZan9D3gaYaNwvUVDoBgkNUKB-5TG14Gd5FR_i9>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2694E780075; Fri, 27 Mar 2026 12:03:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aql3KRXDeodw
Date: Fri, 27 Mar 2026 12:02:51 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <aea09aa4-283e-4610-ba90-f015e66d5070@app.fastmail.com>
In-Reply-To: <c0bb07884841f1d9a7fedf1b92e7e4bca61a9d64.camel@kernel.org>
References: <20260326-umount-kills-nfsv4-state-v5-0-d2ce071b3570@oracle.com>
 <20260326-umount-kills-nfsv4-state-v5-2-d2ce071b3570@oracle.com>
 <b7cbff660e5222d3c2b9c48d6040f73132f5f312.camel@kernel.org>
 <d22d6a1b-13c7-4b02-bf82-d1d701e912c2@app.fastmail.com>
 <c0bb07884841f1d9a7fedf1b92e7e4bca61a9d64.camel@kernel.org>
Subject: Re: [PATCH v5 2/7] NFSD: Add NFSD_CMD_UNLOCK_IP netlink command
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20467-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2AF6E3471C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Fri, Mar 27, 2026, at 11:52 AM, Jeff Layton wrote:
> On Fri, 2026-03-27 at 11:19 -0400, Chuck Lever wrote:
>> 
>> On Fri, Mar 27, 2026, at 8:06 AM, Jeff Layton wrote:
>> > On Thu, 2026-03-26 at 13:55 -0400, Chuck Lever wrote:
>> 
>> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>> > > index 988a79ec4a79..e1e89d52e6de 100644
>> > > --- a/fs/nfsd/nfsctl.c
>> > > +++ b/fs/nfsd/nfsctl.c
>> 
>> > > @@ -2200,6 +2200,44 @@ int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info)
>> > >  	return err;
>> > >  }
>> > >  
>> > > +/**
>> > > + * nfsd_nl_unlock_ip_doit - release NLM locks held by an IP address
>> > > + * @skb: reply buffer
>> > > + * @info: netlink metadata and command arguments
>> > > + *
>> > > + * Return: 0 on success or a negative errno.
>> > > + */
>> > > +int nfsd_nl_unlock_ip_doit(struct sk_buff *skb, struct genl_info *info)
>> > > +{
>> > > +	struct sockaddr *sap;
>> > > +
>> > > +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_UNLOCK_IP_ADDRESS))
>> > > +		return -EINVAL;
>> > > +	sap = nla_data(info->attrs[NFSD_A_UNLOCK_IP_ADDRESS]);
>> > > +	switch (sap->sa_family) {
>> > > +	case AF_INET:
>> > > +		if (nla_len(info->attrs[NFSD_A_UNLOCK_IP_ADDRESS]) <
>> > > +		    sizeof(struct sockaddr_in))
>> > > +			return -EINVAL;
>> > > +		break;
>> > > +	case AF_INET6:
>> > > +		if (nla_len(info->attrs[NFSD_A_UNLOCK_IP_ADDRESS]) <
>> > > +		    sizeof(struct sockaddr_in6))
>> > > +			return -EINVAL;
>> > > +		break;
>> > > +	default:
>> > > +		return -EAFNOSUPPORT;
>> > > +	}
>> > > +	/*
>> > > +	 * nlmsvc_unlock_all_by_ip() releases matching locks
>> > > +	 * across all network namespaces because lockd operates
>> > > +	 * a single global instance.
>> > > +	 */
>> > > +	trace_nfsd_ctl_unlock_ip(genl_info_net(info), sap,
>> > > +				 svc_addr_len(sap));
>> > 
>> > All of the tracepoints get passed svc_addr_len(sap) for the length. Any
>> > reason not to just determine the length inside the tracepoint, so you
>> > don't need to calc the length unless it's enabled?
>> 
>> Unless I'm mistaken, the trace_nfsd_ctl_unlock_ip() call site
>> expands to a static branch that skips everything, including
>> argument evaluation, when the tracepoint is disabled. The
>> svc_addr_len() call, being part of the argument list, is
>> already behind that branch.
>> 
>
> It's a minor thing, but fewer arguments to a tracepoint is nicer, IMO.

The TP_STRUCT__entry( ) macro needs the length value up front
to size the ring buffer entry. This is the cleanest way to do it.


>> 
>> > > +	return nlmsvc_unlock_all_by_ip(sap);
>> > > +}
>> > > +
>> > >  /**
>> > >   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>> > >   * @net: a freshly-created network namespace
>> 
>
> -- 
> Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever

