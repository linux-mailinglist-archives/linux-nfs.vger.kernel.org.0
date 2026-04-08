Return-Path: <linux-nfs+bounces-20783-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK4fMu/g1mmsJQgAu9opvQ
	(envelope-from <linux-nfs+bounces-20783-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 01:12:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3120B3C4B4E
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 01:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05C53301A3BE
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 23:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657F731ED7C;
	Wed,  8 Apr 2026 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXp4MWwf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420862F7478
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689698; cv=none; b=qixSQm9WX5JaT57I2DHZv/le+st+hUIdoywYpGyp7+0A9bBe4qQgdQBeh5NH75HBs8zt4KVnCTgGhQJSuKfJskmXEsOAvgqdH1xIGQVTOPe61zazkH/oC/s4dH4qvSV0zbHXW1JuvNlBUvzkiu43tQwNQlyJLgYyUN1xz2jcIg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689698; c=relaxed/simple;
	bh=FzCbXlfW4M7GrMxgJBuAMnmF6bn6UVoU89RWdQYME/E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=L0gFTld+ghqE4VJUqqhdqXal9R5AU/08bfhzxhwowbUMQImlNm0VZl+CQjUIRtbuaw6+Bs/Cp45ei1pH8v6axMY99zeV0/q8Z9zq3O8g7pmC9XU/4gS/1nEb9Gs06OnT0JBxwa/XBYxt/khIN8lP108SWOz9L0wA/qQjdQn9NV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXp4MWwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A841C19424;
	Wed,  8 Apr 2026 23:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775689697;
	bh=FzCbXlfW4M7GrMxgJBuAMnmF6bn6UVoU89RWdQYME/E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VXp4MWwfvaCLZBaleSPOqz9cv1JmiivJfoxzzSNr8XwJYS1ixvYOvQHgbQ0p23e+m
	 sFLdQeoQdXcVV5IE6OvJ/4nYRtpqj3C+BIlcab5OtbYyh9liKw3o5z3hPpxuP02UTw
	 f1G7fvj4hI+dASVl8wVQlM4zIbKqmt++MHbS9lJq21LBvHwc8GMwn032d9eEPXxRen
	 rKFdmjqvT3fjDdAYNEasdMS1Xm6UIanrTBWEA+hzWpP0MYaIO7iV3QHICoj2RXK0Hk
	 fayhr9qVg6Hs0Z16WDiYsZSV+PrROrC/8iRdmQ/LNQAhORxE/BqLztkcJ8LjkTlFSI
	 9H9UghdyuYV0g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 83B31F4006E;
	Wed,  8 Apr 2026 19:08:16 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 08 Apr 2026 19:08:16 -0400
X-ME-Sender: <xms:4N_WaSPoKYZ5yC-bBN6UXju8qiePz1T-Ye6Rd8DDI9f7l-xRW-VykA>
    <xme:4N_WabwcOvxOWa_JD801BbdaE8aLx7s4Kx6_BtODO-1rXIRQqUAwgVEG6lFThDxPb
    1CrOUN3MqMuYAKaqMeztN2D1vJ_03JA1X0R9bnrI9-ckoDSBU4pLME>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhgssegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtgho
    mhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtph
    htthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhes
    thgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4N_WaXlBWhHDHfOKBswIbzk1Zd8Mrf_RUrjGRQuzyvhXZVf75A7KFA>
    <xmx:4N_WabgEfFLlikhEcdZa7bFKOm6dDF4_PCiSiwDHBgiuZ1HBihWg8Q>
    <xmx:4N_Wab0mYLz2xTH4wW6YJh35e1wSk-nOhSTZvCemf2qAYNFq3US1Jw>
    <xmx:4N_WaUKsR4aD5r0HHH6fBvVP2zVowRCCW7XM2_hPTEl8UnheebFV7A>
    <xmx:4N_Wabz_-Q0dGd79jNV5OHZWfDa1F6ArOFHleC1xy-ZGTJowicCkmbo1>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5DFDB780070; Wed,  8 Apr 2026 19:08:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A8_VXQxMyoAw
Date: Wed, 08 Apr 2026 19:07:56 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Olga Kornievskaia" <okorniev@redhat.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, neilb@brown.name,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Message-Id: <a8ca4c64-af78-42c5-9a59-78dd27b8d022@app.fastmail.com>
In-Reply-To: <20260408190008.85082-2-okorniev@redhat.com>
References: <20260408190008.85082-1-okorniev@redhat.com>
 <20260408190008.85082-2-okorniev@redhat.com>
Subject: Re: [PATCH v2 1/3] nfsd: update mtime/ctime on CLONE in presense of delegated
 attributes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-20783-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3120B3C4B4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, Apr 8, 2026, at 3:00 PM, Olga Kornievskaia wrote:
> When delegated attributes are given on open, the file is opened with
> NOCMTIME and modifying operations do not update mtime/ctime as to not get
> out-of-sync with the client's delegated view. However, for CLONE operation,
> the server should update its view of mtime/ctime and reflect that in any
> GETATTR queries.
>
> Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding 
> WRITE_ATTRS delegation")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>

 b/fs/nfsd/nfs4proc.c
> index 99b44b6ec056..1272f2eb5ff4 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1396,6 +1396,17 @@ nfsd4_verify_copy(struct svc_rqst *rqstp, struct 
> nfsd4_compound_state *cstate,
>  	goto out;
>  }
> 
> +static void nfsd_update_cmtime_attr(struct dentry *dentry)
> +{
> +	struct iattr attr = {
> +		.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_DELEG,
> +	};
> +
> +	inode_lock(d_inode(dentry));
> +	notify_change(&nop_mnt_idmap, dentry, &attr, NULL);
> +	inode_unlock(d_inode(dentry));
> +}

nfsd4_finalize_deleg_timestamps() invokes the same call and logs
failures. notify_change() can fail through security_inode_setattr()
or the filesystem's ->setattr method. Is it worth logging the
failure (or adding a trace point)? (I don't really know, just
asking here).


-- 
Chuck Lever

