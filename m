Return-Path: <linux-nfs+bounces-20535-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BCYGP2Rymma+AUAu9opvQ
	(envelope-from <linux-nfs+bounces-20535-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 17:08:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC9935D79F
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 17:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BDA13009F3B
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D78133A039;
	Mon, 30 Mar 2026 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYDwOvcm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A509339853
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883184; cv=none; b=p6/p68K7tFDg6Y6lB7W3p8xygLv0aH0nvhb3jIbi2LsmGOLJmuDx34W9GWPMHYa5nUsGrUJ4FAZyIWRzbpNIxi13P+qPhd6+aRqgMNfMaxhg+CrvkYCeomXQL47JU5o8/Cc1IwE4pBtzyAt7m/hPHER+nko8DHh6/oT4Nd92vlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883184; c=relaxed/simple;
	bh=WJQY/cz5da5jdaKfU86BrzyDzlyoOdSFs71R+LszYIM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=l3xf0ki5/YER9BaFb5S0NE8JZSX6fViy+QyiVyK/SjntrDRwNe3kchJksa/a3+L1/bybWesGXQfxdG68jeUPqCey9OKJhlev7OipAIzjCoSyxUhoGaswSovVIDVZ6+I1kJuU8Vo21VpvclNE8/ijEmxMRW6e80yF+Uy0hWgX4F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYDwOvcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19DAC4CEF7;
	Mon, 30 Mar 2026 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774883184;
	bh=WJQY/cz5da5jdaKfU86BrzyDzlyoOdSFs71R+LszYIM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=mYDwOvcm2Z6RJye/HQ7u9QYy7Mqb48tf7wJNJ6Ku+EM+e+RKBLNWRwlMx+CYIHQX4
	 SVqzdFbgLs2rNoe2A04as6Bq13l0o+IL/I895yTP4l4wQixJYs1woZVpLJcuwgMnVR
	 DARSVYYhIHchRVu5OJjmwBnf0pCMYPBZVFqOGDKoVnsIQoqqHoGBIFTSZ0X6CSbOSs
	 Fh+OxH3R/+5QxzF9ePLyPo0EiAEZl9T8jona9Lmi4IuyGV56Mj+qsKXrLYPVWXBVbW
	 II2yWKyg2qjLYY8NX3iY0+vd+OL7xYE7Mls9zNiiIZmmH8U1sw3oDXL3Q1PQcqQVjC
	 aSuKaEowsLRSg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C8D37F4007A;
	Mon, 30 Mar 2026 11:06:22 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 30 Mar 2026 11:06:22 -0400
X-ME-Sender: <xms:bpHKaTIffUf9wIRMOUtjIPs0axI55P1TLToH02MnQ1ZFqH5_pJ0cjA>
    <xme:bpHKaR8I9NNWpFNGvxP0uSaDAVdbGRZD3-X9Z_Yv8WoEei9xOSfBfD0JkKE1Z2sgW
    oaksjQ0gGEe0d8TYLa1Cqfx-yamXnxv6Yqo_bnjrV-frIny_xp5sgd->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepuggrvhgvmhesug
    grvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhorhhm
    sheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeht
    rhhonhgumhihsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bpHKaVLQX_X_6CMfx-ayuWO0J1-puXwyei48L95GjLVzF8WbW6bFvA>
    <xmx:bpHKadcoD2QSfeJyPt09wl8YezxicPP2ScfMtW_IGcJ0SXbB4fXa9w>
    <xmx:bpHKafUvTwvsI9TBZDEPXcfY9xMZ_icl9gV2tUrRTkr2AiEUJ4Xa2Q>
    <xmx:bpHKaThI7uqYrQTo-rhlp5ODW3mMm5fKVrMb3IJq_0ldKOI5hMzA-Q>
    <xmx:bpHKaRis2ALOkYa-k1648tBHbqcTP0vSiACwFjcz_d6bsvbVOWIt5_5C>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9BB17780070; Mon, 30 Mar 2026 11:06:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AN4VOCyftktg
Date: Mon, 30 Mar 2026 11:06:01 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Donald Hunter" <donald.hunter@gmail.com>
Cc: "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <9354ec13-4a7c-4ea9-af8e-f3a0a83721d6@app.fastmail.com>
In-Reply-To: <aacc794e20096cf9b3bfca9ce4d2f43698742a1d.camel@kernel.org>
References: <20260325-exportd-netlink-v2-0-067df016ea95@kernel.org>
 <20260325-exportd-netlink-v2-10-067df016ea95@kernel.org>
 <30ff0483-ec38-40b3-811b-6cd66febe1b1@app.fastmail.com>
 <aacc794e20096cf9b3bfca9ce4d2f43698742a1d.camel@kernel.org>
Subject: Re: [PATCH v2 10/13] nfsd: add netlink upcall for the svc_export cache
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20535-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,app.fastmail.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.942];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5CC9935D79F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Mon, Mar 30, 2026, at 10:49 AM, Jeff Layton wrote:
> On Mon, 2026-03-30 at 10:22 -0400, Chuck Lever wrote:
>> > 
>> > +  -
>> > +    name: svc-export-req
>> > +    attributes:
>> > +      -
>> > +        name: seqno
>> > +        type: u64
>> > +      -
>> > +        name: client
>> > +        type: string
>> > +      -
>> > +        name: path
>> > +        type: string
>> 
>> Is the svc-export-req attribute set used for anything?
>> 
>> 
>
> No, good catch.
>
> That's a holdover from an earlier version that had a separate attribute
> set for the up and downcalls. It's not needed in the latest version.
>
> It should be fine to remove it and regenerate the headers. The result
> builds fine without it. I've pushed a fixed patch to the 'exportd-nl'
> branch in my tree. You can fix it up or I can resend if you prefer.

Thanks for jumping on that. Let's wait to see if there are other review
comments.


-- 
Chuck Lever

