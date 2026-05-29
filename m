Return-Path: <linux-nfs+bounces-22088-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GqLITzcGWo4zggAu9opvQ
	(envelope-from <linux-nfs+bounces-22088-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 20:34:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 74545607456
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 20:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82BBD3009E09
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 18:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4F341B372;
	Fri, 29 May 2026 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bedf1ycB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84EE37AA9E
	for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079667; cv=none; b=WImXnXZ7GeaJ7v51khutY/q2o8ozj9AJNIg04SeftUk9zo2mgSIf+wvTSRb8coxzUTEAZa8OMmiBlSSMMMqMqFA7ulpUH79lKU5oGHSuwftbDl8Lkuk2eAdCXp2Lu16XMi/GVfRfVrww+4yfqtEsXFdJVuLARwQhY5S3DUF0iPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079667; c=relaxed/simple;
	bh=KbHoLveowwf+1NxmUSe4UYBqr3idwsGM4LtO0lEfSiw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=V9cog742mWzUdKuVh4qY5I8P2mYi/8Z2BIUoLgi0tJYJBbru0ADRCNw32WSCKfsIUyN+Y9R8PJU9Jg1JTQ081KD7KIxdqayyTB0ABil8cQU5asoIGtDfGRxmHntlHiMvYh6ncg/eX2OoaoY4ov1KP+3X4zmEHOZVu33CZ8c0Ouo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bedf1ycB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4491F00899;
	Fri, 29 May 2026 18:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780079665;
	bh=kuTbRfgNrMlZgbYU9dBbZrffr/0cctT/0s2NKHlgaII=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=bedf1ycBYUG3/w4shvFQKzfYD/cEfkQYOXgl4+3XryMOxiGpjCLNMJoGfEYCSyRwb
	 wlNkLxsBcF1uhjDuZvR7v9GwjaZy/l6zJvPxDdfK2ImWMKunTS5bfO2rwCRQi70AN9
	 IHpEGT+sx0B2kAMObtt5WFG1Os8uQesgWn1RDuJKst+MLBkZkFAJr/UYqpS1U1sI6E
	 6C8VDDUez5Hf+cgOjLR10gdIbYwwS48LJKQM7KGXnWmlq3K3NzkTyOe7w54H38X/2/
	 4o2C6b55tO/x396wd2CeVoz1Y2hkLagkqoauxvChWE3bwSVTkdPAIJXXdcmBxg6P7o
	 288m9kx3o8iNQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id DF1BCF40087;
	Fri, 29 May 2026 14:34:23 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 29 May 2026 14:34:23 -0400
X-ME-Sender: <xms:L9wZanA8An81BGgOigo2xizLEbWTdCZKVlGCVsXcqJ6RIQH1lNIOSA>
    <xme:L9wZaoUvD8lZQ88V_zvBQ0EOPQxyWD-O_zHqQwUK5Wx6TN0k87gnNJQSs-pBCB9qn
    Qt5tszohkIm_-olT0P_b7FoqnBviTZeH_vWa-re2hB0__D76LtrxC8>
X-ME-Proxy-Cause: dmFkZTEAgCnk7vcEzRqzr0vvPXMv3A2EKzDB6MAziFYbTJZCQU8QBHPXxtEdrVVxTA/Z5H
    dHlcE6dRmtkBka2A5C8mGPFj1DmVNEJ7nPynAmggq15SjcQwpd9Cw2SXajfe2MS32pB9vb
    hZ10a3JjByFkljnLnWRolxVvJvJ6KN0pY2Sdgdz0nMnPSl6Xv6Hi06eJ54Iq5HZ1lwFZrx
    FfIFHwKYicpl/iA79j2mGkzXRM3cCOImTF5iMCHto8JYqFu5Z7mY4/m5vVcZIw8W0o0UN3
    S3DUBkVT7+n428n8Kyvl1Iux6Bz575N8IUqTPp/q2J5PLfNZP5qR32A4HIJvpZwFVgn2Rg
    rXDFno9YZvbvA9c1nhat3jpZuS4cmWeQUOCLlPjspRPf6dxU4G8hrmJnOUUpdQf0hbWCJk
    iDNAZ3HviyFVbEuBunK6XfM5Uqv+164UiWj1fLNblkfM5a/E0juOW/kWR0vzoDn3FnGhLe
    2NsSv3FmanM1fNcOl6E3b9cOp4V8GM+50UhMdf+EEjjfnDux32McTQ0/PvqBYWdwSutZrt
    u6WIsMh92ppEBPgbUxP4awWAopeK8qXW0K1whK981IW2XsZBMyZLYZGhCCHrkniOA3arE4
    wwpKEhsGyMpW4hCHai5wNTNnjSfWUaiAGNEAhXpkGurHS1LglkSZMIHr3WEw
X-ME-Proxy: <xmx:L9wZai-_4utgqAqwdIiZExOFhUCi1xCqkcDkrB_AxNwDhcgmTHRXCA>
    <xmx:L9wZaiLFCkQ1xF74w4fEm0GDfJ2GlSdvWh0lLHOqv0vu6ic3gwaqYQ>
    <xmx:L9wZapGANXErnL0ADEyRT6b-sTpNkyxRxwwjSxeOfKMJh5eP-Yb1zg>
    <xmx:L9wZaux2oLxZlU82pPHF7WiOZSBnQFXXwMjd_HM3-h-oBlOhzNEDzQ>
    <xmx:L9wZaq4aniUjOorMon-5jaHcBE9mC_-lhYOmKCcMLYK2ieACPGASahkU>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B6262780091; Fri, 29 May 2026 14:34:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A3qS0pEwTgdN
Date: Fri, 29 May 2026 14:34:02 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
 "Scott Mayhew" <smayhew@redhat.com>, "Andreas Gruenbacher" <agruen@suse.de>,
 "Mike Snitzer" <snitzer@kernel.org>, "Rick Macklem" <rmacklem@uoguelph.ca>,
 "Trond Myklebust" <trondmy@kernel.org>
Cc: "Chris Mason" <clm@meta.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <d1d41aef-0add-44d6-ac53-b78334b885a3@app.fastmail.com>
In-Reply-To: <20260528-nfsd-fixes-v1-9-e78708eff77d@kernel.org>
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
 <20260528-nfsd-fixes-v1-9-e78708eff77d@kernel.org>
Subject: Re: [PATCH 09/10] nfsd: cap decoded POSIX ACL count to bound sort cost
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22088-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,app.fastmail.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 74545607456
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ replaced broken email address for Trond ]

On Thu, May 28, 2026, at 5:55 PM, Jeff Layton wrote:

> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index c6c50c376b23..5469c6c207ba 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -448,6 +448,8 @@ nfsd4_decode_posixacl(struct nfsd4_compoundargs 
> *argp, struct posix_acl **acl)
> 
>  	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
>  		return nfserr_bad_xdr;
> +	if (count > NFS_ACL_MAX_ENTRIES)
> +		return nfserr_resource;

nfserr_resource is consistent with other fattr4 decoders, but
does not make sense here, IMO. A better choice is nfserr_inval.

Rick, any opinion?


>  	*acl = posix_acl_alloc(count, GFP_KERNEL);
>  	if (*acl == NULL)
>
> -- 
> 2.54.0

-- 
Chuck Lever

