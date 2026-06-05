Return-Path: <linux-nfs+bounces-22298-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 51O8CWsuImpATgEAu9opvQ
	(envelope-from <linux-nfs+bounces-22298-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 04:03:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8ED644940
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 04:03:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GfrCVpxI;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22298-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22298-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CA5630A9B0E
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 02:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41703B583B;
	Fri,  5 Jun 2026 02:00:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954DB3C2BA8
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jun 2026 01:59:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780624807; cv=none; b=F3YXIOtozKe7FeASh6lPx4XgSp1kO2B2SjYg7T9+RMTv4wUU7Pv/Ik7oET+apqA9giKQhdTy5LOngOOXtHGkCpbKIGVE/zgdciluCnbQOdKk2/txj0+JxOQkm5RBeReT6xOKAPPWz32Is+rs8cZWh5jnSnXhRvu8IWRdnnXMSY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780624807; c=relaxed/simple;
	bh=OVKwNU4kZ+6+0bQ8yKqrSwveUf9e9kp0A80/m/RFJSE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NNE+FXY4/6fqVl/paiHDWCDL0LUhS31x4ZUHY/NuMs9Go3CTVf0bmfXv3FBvPaZg3mLvmH2mBun1PHg7oY/CbIGy6UAfbrxgONhDOKFtB82Y7ChtqLMMLhTlMT0RTLLNLpoY9vtJcdTJrqT+57O2ZlvEhlAwju2cCc6SHHedtbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfrCVpxI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03311F00899;
	Fri,  5 Jun 2026 01:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780624799;
	bh=1u4XI2kN8Y7dbVpFh33B77zSDYH9okNaOq36Bcvy3SE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=GfrCVpxICnmaH8sVAIE+s4V4iE7LSQWLOs5JO6Mdf1JBu9zN14xm1tX6+M6d7nYk5
	 Mm6PlKPkujQ6itwkHl6aATn5WBvfa5+PCzJ/in9ZVrjMk8gtE4LdxE9u2dDkV4aQEM
	 SWEy0ETq/Yj+TxlogirXuPnFe8xSIcTP7rK5OMHTLMHWHFJjFNnwJ3rWaZ/HwXlnka
	 3fiCdJ88eOwLC6O15T0MvheuzBpWoAGkchz4YIef7lMGslIEAW4tRD2h7nAW/dtJiT
	 LAzaIIiLZMxnREzQJk4Jtsjg2mRs6KQ/eFkpVgNCFGfKQvf1I1zxm2JkgsZJPXhV/G
	 7bRpLSCTJU7Dw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D3326F40084;
	Thu,  4 Jun 2026 21:59:57 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 04 Jun 2026 21:59:57 -0400
X-ME-Sender: <xms:nS0ianHyFq8WSKEVkuLwQrKleQZqrDWjDzKqwXm6YgTXrKcHKtBtKw>
    <xme:nS0iavKTUYQ4e9vIBs1gOzIBNaVKj6vq_EglhOoz7ZHyZ18CBgAd9MzwSfpN5_57w
    nPlCpqCtjf38JtTv61g_GFYPdgLAHS2IRNZuvMenVnMnOHuJLTH5vkp>
X-ME-Proxy-Cause: dmFkZTEdHTb7Q43xmskkWXu7iyzmNPjz8cwV1Q/+tFV4vWvwIUWTAY5pmLXA6YENynUK7U
    I6Q65wNU2hn+zzxS4zJFT2E/oXx3mEc3lAFRImR+ew28S2dVH2GNhUajLI2YcLK2Tt89Ym
    aqEcrrNlLr5ihrXetoREcd3IpThC7i16vF2uj4UddATUzt3GenWRFAHe9saRyCrdOVdoNx
    nmUKl+f/AVZLWg+fQNGCs7Ehc35KJRwjSJUmRMA22T9T61e+HiSyYozdQMLAHqCbZhFUgv
    xsOrShPAHxjV27VbBIAXxmlffSDV5PxlFGzlsmm+8ex4SITlCbnyebWl+rB05xGKLJ2TbS
    iyE3nJ98ItveZV8C0QtwycPpAzlRoT1urn4Cj9atQNFJiujjf9lz+Zxy22Ewadyog2FhuP
    fWPl5z1SjVoMAS8NzoQG/Ag7eqmlD2xKiba/SspnTo9zlIeg4DfX/OVyIfBgAjsODE1Vqg
    tzimFlw6kfqqLjaDpS8LsfC+il9B7MacXonSgXhOBDtstkXNvNC5l5vhVkXMiv2+FJ+Nwa
    ID8fNXmV+cHruItnR/87k7ksLsQPD541MudIwoUONOXv/DFb+GlXzyOC5D1hCdefH8rqgS
    XCBRIzxpEkHW+Lv/E4V6l8OggKdyP0FjTE1H4EXntQlmyAaql9KQSB9v6rfg
X-ME-Proxy: <xmx:nS0iajymlADIYfhqr5sW9YmFqgFvtDnV39ucy-pQhpmIEUEX1Tiq_w>
    <xmx:nS0iapg1bXbgn578KAXxxvQkHJyKLx9cVFEgigcNIZKkB34Rd6uhIQ>
    <xmx:nS0iamqlFLo8cApRjtzViPlmYHXs7A1Pmc3ubvMBNXszyPHpX4KZMg>
    <xmx:nS0iagh9BCjGUTecsQ4hLKyCqUOXIXh4s2VTFDjZEWnJRKti_CmHmQ>
    <xmx:nS0iaoOHaRVt2imN8Fz1J0wWMjHa_TrdOx9JhVgcME0VXvN6YMKXd3be>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AFAAA780075; Thu,  4 Jun 2026 21:59:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhWl9GhwlQso
Date: Thu, 04 Jun 2026 18:59:36 -0700
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>, "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jeff Layton" <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, "Jori Koolstra" <jkoolstra@xs4all.nl>,
 "Benjamin Coddington" <ben.coddington@hammerspace.com>,
 "Mateusz Guzik" <mjguzik@gmail.com>
Message-Id: <2f5da5fd-442f-4889-af15-58f9b5d68d71@app.fastmail.com>
In-Reply-To: <20260601070042.249432-18-neilb@ownmail.net>
References: <20260601070042.249432-1-neilb@ownmail.net>
 <20260601070042.249432-18-neilb@ownmail.net>
Subject: Re: [PATCH 17/18] nfsd: use vfs_lookup_open() for non-creating open requests
 too.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-22298-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,xs4all.nl,hammerspace.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:jlayton@kernel.org,m:jack@suse.cz,m:linux-fsdevel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jkoolstra@xs4all.nl,m:ben.coddington@hammerspace.com,m:mjguzik@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A8ED644940



On Sun, May 31, 2026, at 11:38 PM, NeilBrown wrote:

> @@ -429,45 +438,35 @@ do_open_lookup(struct svc_rqst *rqstp, struct 
> nfsd4_compound_state *cstate, stru
>  	fh_init(*resfh, NFS4_FHSIZE);
>  	open->op_truncate = false;
> 
> -	status = fh_fill_pre_attrs(current_fh);
> -	if (status)
> -		goto out;
> -	if (open->op_create) {
> -		/* FIXME: check session persistence and pnfs flags.
> -		 * The nfsv4.1 spec requires the following semantics:
> -		 *
> -		 * Persistent   | pNFS   | Server REQUIRED | Client Allowed
> -		 * Reply Cache  | server |                 |
> -		 * -------------+--------+-----------------+--------------------
> -		 * no           | no     | EXCLUSIVE4_1    | EXCLUSIVE4_1
> -		 *              |        |                 | (SHOULD)
> -		 *              |        | and EXCLUSIVE4  | or EXCLUSIVE4
> -		 *              |        |                 | (SHOULD NOT)
> -		 * no           | yes    | EXCLUSIVE4_1    | EXCLUSIVE4_1
> -		 * yes          | no     | GUARDED4        | GUARDED4
> -		 * yes          | yes    | GUARDED4        | GUARDED4
> -		 */
> +	/* FIXME: check session persistence and pnfs flags.
> +	 * The nfsv4.1 spec requires the following semantics:
> +	 *
> +	 * Persistent   | pNFS   | Server REQUIRED | Client Allowed
> +	 * Reply Cache  | server |                 |
> +	 * -------------+--------+-----------------+--------------------
> +	 * no           | no     | EXCLUSIVE4_1    | EXCLUSIVE4_1
> +	 *              |        |                 | (SHOULD)
> +	 *              |        | and EXCLUSIVE4  | or EXCLUSIVE4
> +	 *              |        |                 | (SHOULD NOT)
> +	 * no           | yes    | EXCLUSIVE4_1    | EXCLUSIVE4_1
> +	 * yes          | no     | GUARDED4        | GUARDED4
> +	 * yes          | yes    | GUARDED4        | GUARDED4
> +	 */
> 
> -		current->fs->umask = open->op_umask;
> -		status = nfsd4_create_file(rqstp, current_fh, *resfh, open);
> -		current->fs->umask = 0;
> +	current->fs->umask = open->op_umask;
> +	status = nfsd4_open_file(rqstp, current_fh, *resfh, open);
> +	current->fs->umask = 0;
> +
> +	/*
> +	 * Following rfc 3530 14.2.16, and rfc 5661 18.16.4
> +	 * use the returned bitmask to indicate which attributes
> +	 * we used to store the verifier:
> +	 */
> +	if (open->op_create && status == 0 &&
> +	    nfsd4_create_is_exclusive(open->op_createmode))
> +		open->op_bmval[1] |= (FATTR4_WORD1_TIME_ACCESS |
> +				      FATTR4_WORD1_TIME_MODIFY);
> 
> -		/*
> -		 * Following rfc 3530 14.2.16, and rfc 5661 18.16.4
> -		 * use the returned bitmask to indicate which attributes
> -		 * we used to store the verifier:
> -		 */
> -		if (nfsd4_create_is_exclusive(open->op_createmode) && status == 0)
> -			open->op_bmval[1] |= (FATTR4_WORD1_TIME_ACCESS |
> -						FATTR4_WORD1_TIME_MODIFY);
> -	} else {
> -		status = nfsd_lookup(rqstp, current_fh,
> -				     open->op_fname, open->op_fnamelen, *resfh);
> -		/* NFSv4 protocol requires change attributes even though
> -		 * no change happened.
> -		 */
> -		fh_fill_post_noop(current_fh);
> -	}
>  	if (status)
>  		goto out;
>  	status = nfsd_check_obj_isreg(*resfh, cstate->minorversion);

Logic bug: Pre-series, the non-create case takes do_open_lookup()'s
else branch and succeeds; post-series, do_open_lookup() calls
nfsd4_open_file() unconditionally. Every CLAIM_NULL open of an
existing file fails with NFS4ERR_EXIST.


-- 
Chuck Lever

