Return-Path: <linux-nfs+bounces-20636-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIq7C03kz2kS1gYAu9opvQ
	(envelope-from <linux-nfs+bounces-20636-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 18:01:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D323960B0
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 18:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECF22300462A
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2026 16:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CDB3612E2;
	Fri,  3 Apr 2026 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/NfTQCY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2B133C19E
	for <linux-nfs@vger.kernel.org>; Fri,  3 Apr 2026 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232071; cv=none; b=Z5cH79Jki5udafZihOU5mtca2XanYFCWVXgtiGeU/08Hyy1hlKMq4sRux9r+JkFkzzdCLEESt6+QCohqZUfvzZjWlyJH41dwgWXBklu1uFOXnRKRceNTE0RHuQex/Zv+Adfn6SGYD8ktWkbfmlPH1vGVohF+ec07zQgUoh/VdG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232071; c=relaxed/simple;
	bh=QEpy5VaipHHWYNFKig/5uzaKl5BHe9nATmCxa9VjB0M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=F9dm0x5aYlaI086fMP9Vv5JGCWsVumO34uqM4pm4TwuASgcKepudMX0ZDXxHg75mzI30+/qoN8NZtkPMWlnAPVlCEhIjbgV3Ho7Py33kg0GxyZxP+vAtp4HCpVsU5i4OCafCrdll0snw9Ej9KnvADVpvNHiHr2Np6Ai47e7HFWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/NfTQCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1645EC4AF0B;
	Fri,  3 Apr 2026 16:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775232071;
	bh=QEpy5VaipHHWYNFKig/5uzaKl5BHe9nATmCxa9VjB0M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=J/NfTQCYBoPpFTaVGkc2CJPOfEJTezi4w1RFUNgBun0gIWPXvVxyKsaInQ6kdawo2
	 sKq/rZOVkkj1C2FfWj1CqW/XYVc35pLXD0vsbs/A/oF95kJZ42H+B5MxXjV2z6KKhc
	 A2QOHPrTXaxUCo9/0DTgQ6hHHg0jSD1HNraDvGd7jOrao84WJA8MpO0FEDHXWqZupK
	 FU+FpwjZzPv/A+aXm8rnmNpKX2HigSH+t6d/oESTIiSIGx+7F6lGdLqs09m+pEFQ61
	 ONraUyzhOpi352ju3rhju5Szsf5F6M0MBl93RTiJZ/KjHHT5DiwmdsQKgho8+m/ojC
	 uKX9D95+97geQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 10A7AF4006B;
	Fri,  3 Apr 2026 12:01:10 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 03 Apr 2026 12:01:10 -0400
X-ME-Sender: <xms:ReTPaS7QB6pjqP8jy1z4gKP2nWrXePBligqb6skWxM3ZHmo776xXog>
    <xme:ReTPaWvLUxQV_MKnfadu7QQnLhFJafGN2CGyvhKofeJ6Zt1Ff0nvgKAA_cKNMFKPR
    ejrIgsEbSvi2ou4vA6vD5Cuih6dB9zpYqR0cQicJ-ewNMFLa6dD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgtkhcu
    nfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklh
    gvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleelleeh
    ledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvihhlsgessghrohifnhdrnhgrmhgvpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpth
    htohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmseht
    rghlphgvhidrtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:ReTPaQxKdGe8k1iCYTb9GF0jAJTcYt-d45SYv15FKvQi4Y-6O8Dzgg>
    <xmx:RuTPaU-9ycDyfZ5OgK9hIJe2yvgHaqHn0pbitfDi4MDKsuzZlpIKBA>
    <xmx:RuTPaQhpg6QW21ZnuZRLjuZN5xyDk_FoYqA6Z21kN3hcDNkKjWLrOQ>
    <xmx:RuTPaTFI_jHuZPn5vB56zK5McADQhbZnmvGqyLhN3bL4IawxJ9mYBA>
    <xmx:RuTPaX8eJz0vZP5BJFwty8Hu5IB25lTLtLjYTQ9Za-f7Kk2Rk3_pa2Wk>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DEA57780070; Fri,  3 Apr 2026 12:01:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-ZK6EzxzYDs
Date: Fri, 03 Apr 2026 12:00:49 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Olga Kornievskaia" <okorniev@redhat.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, neilb@brown.name,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Message-Id: <71e5cffb-c136-4208-83a4-d01f8b43d802@app.fastmail.com>
In-Reply-To: <20260403152055.70311-1-okorniev@redhat.com>
References: <20260403152055.70311-1-okorniev@redhat.com>
Subject: Re: [PATCH 1/1] nfsd: fix GET_DIR_DELEGATION when VFS leases are disabled
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20636-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 11D323960B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, Apr 3, 2026, at 11:20 AM, Olga Kornievskaia wrote:
> When leases are disabled on the server, running xfstest generic/309 leads
> to an error because GET_DIR_DELEGATION returns EINVAL.
>
> nfsd_get_dir_deleg() can fail in several ways: like memory allocation and
> unable to get a lease because either leases are disable or it's already
> held. Currently only the condition "already held" is translated to
> returning directory-delegation-is-unavailable error. However, other failure
> conditions are likely temporary and thus should result in the same kind
> of error.

This is a bit misleading. -EINVAL from disabled leases is a permanent
condition, not temporary, in the sense that retrying the request is
going to get the same error until the server administrator modifies
the server configuration to enable leases again. (I think if
CONFIG_FILE_LOCKING is disabled, it becomes even more of a permanent
situation).

However, since directory delegations are advisory, IMO GDD4_UNAVAIL is
an appropriate response for both temporary and permanent inability to
grant a directory delegation. 


> Fixes: 8b99f6a8c116 ("nfsd: wire up GET_DIR_DELEGATION handling")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>
> ---
> Notes:
> I'm unsure if kernel_setlease() can return some other error that shouldnt
> be converted to GDD4_UNAVAIL. Alternatively, I propose to recognize ENOMEM,
> EINVAL and EAGAIN as errors to translate to GDD4_UNAVAIL.
> ---
>  fs/nfsd/nfs4proc.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 6880c5c520e7..99b44b6ec056 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2535,10 +2535,6 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
>  	dd = nfsd_get_dir_deleg(cstate, gdd, nf);
>  	nfsd_file_put(nf);
>  	if (IS_ERR(dd)) {
> -		int err = PTR_ERR(dd);
> -
> -		if (err != -EAGAIN)
> -			return nfserrno(err);
>  		gdd->gddrnf_status = GDD4_UNAVAIL;
>  		return nfs_ok;
>  	}
> -- 
> 2.52.0

-- 
Chuck Lever

