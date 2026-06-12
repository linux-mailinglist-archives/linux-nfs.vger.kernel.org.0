Return-Path: <linux-nfs+bounces-22530-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sC25In5NLGpSPAQAu9opvQ
	(envelope-from <linux-nfs+bounces-22530-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 20:18:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E26A567B9B6
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 20:18:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jP7XMQB9;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22530-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22530-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C46DA34EF43A
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 18:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7A039E197;
	Fri, 12 Jun 2026 18:10:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823CA39BFE7
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jun 2026 18:10:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287834; cv=none; b=HvObckQuh3kQOYNawdwhiTcvZxpviocRFgtWywcNVEA2cvCrXqge8NzYYjHhXAUp8H52KNhnzG37mgvs97ia9QL0Qc20SjqsKvAZY7kuSDzeFhZ/6yzVbF3m24F7ga1RD6lxVaGtrCMAzaErByUsRldX+HqA8jXqJHZhX4yT1YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287834; c=relaxed/simple;
	bh=3yFnwMC32Z5jyWcJZAjtYrhykHvXJQGOtQPM6dCaFbM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TOwnkD0d2h5Hk7+1oSXR5jX/0kNyPc1f7SIZ1RpileJJneQzj3EKEwUDv1jkoy6bECBbpUTZrqVeGWRlu7orqALed27Pd2pnOmBpkUjt+iwNE4qESJeSnB3FEWTTMTw31GzWof8BrktYl2J3vi8MALWTnyRygGSKvPP/00YsB48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jP7XMQB9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51911F00A3F;
	Fri, 12 Jun 2026 18:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781287831;
	bh=pXlN2dwvUYuAFXUrDgwWa88UfmiLVbWP5iDvMfwH4ao=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=jP7XMQB9PfXXr6dVAJqpYLzUg63E/etwUYjAwL8Nczb8cydUlExX6hwVXKB3PgY9J
	 P2BPWGLf0AjSVDB7WiIR/IkAGuKz2xYQSpX9NLTTPHKJEPtFkUf/VwhgXuSvFWojn4
	 8xdl8hniC7v3OxaT8AYzaZKp7jZbTOI2eUBWa1kWPiBee5bGpnLNvP2cJ1hszS6T2x
	 /HL4HTbjgdWgIsKmAgPSC5jFMu9CcaHIj+LVlYZxc0weDL0L0X3z2/OHIYGoTwUtVq
	 9Mqr5w0uDkfXtMMDlfwq4TT8H/UmN+bbWhIFNXRZiCK86skGFHzdg0b7PFSY9t7+ML
	 folhnnhgA4bHw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id F1E84F4006B;
	Fri, 12 Jun 2026 14:10:29 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 12 Jun 2026 14:10:30 -0400
X-ME-Sender: <xms:lUssar6dVy5VNSBHpzcnV4WOoqyOHdOxAK5OiSB1RCQ0ED_4FSVRhA>
    <xme:lUssaruxvX2yEhsnX5Yk4n2iXiuMgnlofG6IwQLvL7jb2R3QupKSyQ7AW_KRhEBZn
    j_YL2ODUgu934krqabK-7SB3Lc3bZORR7UB_2g_Y3xh0WVlOTaI5IY>
X-ME-Proxy-Cause: dmFkZTE36XOAKZ3IPV+E+P3VLGiz/dTOrRn7qcybwjXT5k2joTGhjQG2rxY5yO0GzyiY/Q
    nhDEoiX4xW4RIlh0lElDQVp8ZnFQtbGkvs4vYVRyYKkUVnpnmn7qRO2yVfVmk3lRcBTe7Q
    SNwRWduyxJrtO/f+EEyjJfUFs/5rmteilZMpbAKRquZn6JUayytPpl3tGR5dSruatc/Kil
    TvqCV8KbjIF8loKZaG7ImcfIDRQ/OeblAbxYr3jfhPxqMWnN2bEsAzVf5PS360LiOoIk8p
    ya/XvojjwcFi5vlSROwRpTmDxnTR7DdPaykhtvzyopIHO1gml9aRZodzumDAGuqs02AhWo
    jLdwbQdF/cTT01mlvw12DzhzZN0lAkumhDfQFJIQhYguo9n46e18iAosFqydL61TMcEICc
    gGfLf1HrL174CZxPPDjorG1/P1qz2fqBKa3cvQ/pYwmOA4+PZJDa4g72AvbTBh+PX2H6bE
    DIDS1+3c/zVN4jZfkjh4hWdnsGCJ/kKn6CzwbJoFOmkSp0/H+fpb+kVZYBUwmjDwvgRm47
    mR3OdpNFFmbluBZ050MQ8s9uyVl6iuFuHgpAMOZvhVkNaujUe1rQEjTXV9L/3MK7XePn9g
    y5ms1lS901EKDhzbNaSwu+ZlfhPDTDV41vga0YX0JRXRmGJ7wRrSDp8RPAJQ
X-ME-Proxy: <xmx:lUssavS_GsUkRf3sR1vnzeoqQRmL91DzJoY7NKGB-zX5juSZ4l0VDg>
    <xmx:lUssalrKmv6vYG3bOx8m-O9vZvrAtadQCZwUxv8qD5owGvvzPdu74g>
    <xmx:lUssatZM-UPJK6HGWmFrzKSTNmjNnAC-xC6PNzBGN7wvYKnPgI-q-g>
    <xmx:lUssagRKeTEEoIUymC8h0Wciz4EzKbgoQxUGnwsFde_DkZTrX2D97w>
    <xmx:lUssarcC6MXj0JIbk5CdRcIEcwRh1sbl3Q98j1nCBxifKlrAafZ0TTWM>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C8494780070; Fri, 12 Jun 2026 14:10:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARlt4z4nIfLw
Date: Fri, 12 Jun 2026 14:10:09 -0400
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
Message-Id: <450e3437-13db-4898-b90d-49e8116acf4e@app.fastmail.com>
In-Reply-To: <20260611-dir-deleg-v6-18-4c45080e5f3f@kernel.org>
References: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
 <20260611-dir-deleg-v6-18-4c45080e5f3f@kernel.org>
Subject: Re: [PATCH v6 18/20] nfsd: properly track requested child attributes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.65 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22530-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,app.fastmail.com:mid];
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
X-Rspamd-Queue-Id: E26A567B9B6



On Thu, Jun 11, 2026, at 1:50 PM, Jeff Layton wrote:
> Track the union of requested and supported child attributes in the
> delegation, and only encode the attributes in that union when sending
> add/remove/rename updates.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c  |  2 ++
>  fs/nfsd/nfs4state.c | 18 ++++++++++++++++++
>  fs/nfsd/nfs4xdr.c   | 15 ++++++---------
>  fs/nfsd/state.h     |  3 +++
>  4 files changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 29f7339dc220..caec82e77081 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2577,6 +2577,8 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
> 
>  	gdd->gddrnf_status = GDD4_OK;
>  	memcpy(&gdd->gddr_stateid, &dd->dl_stid.sc_stateid, 
> sizeof(gdd->gddr_stateid));
> +	gdd->gddr_child_attributes[0] = dd->dl_child_attrs[0];
> +	gdd->gddr_child_attributes[1] = dd->dl_child_attrs[1];
>  	nfs4_put_stid(&dd->dl_stid);
>  	return nfs_ok;
>  }
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index aa99783ce901..0e6e008c121e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -9930,6 +9930,21 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst 
> *rqstp, struct dentry *dentry,
>  	return status;
>  }
> 
> +#define GDD_WORD0_CHILD_ATTRS	(FATTR4_WORD0_TYPE |		\
> +				 FATTR4_WORD0_CHANGE |		\
> +				 FATTR4_WORD0_SIZE |		\
> +				 FATTR4_WORD0_FILEID |		\
> +				 FATTR4_WORD0_FILEHANDLE)
> +
> +#define GDD_WORD1_CHILD_ATTRS	(FATTR4_WORD1_MODE |		\
> +				 FATTR4_WORD1_NUMLINKS |	\
> +				 FATTR4_WORD1_RAWDEV |		\
> +				 FATTR4_WORD1_SPACE_USED |	\
> +				 FATTR4_WORD1_TIME_ACCESS |	\
> +				 FATTR4_WORD1_TIME_METADATA |	\
> +				 FATTR4_WORD1_TIME_MODIFY |	\
> +				 FATTR4_WORD1_TIME_CREATE)
> +
>  /**
>   * nfsd_get_dir_deleg - attempt to get a directory delegation
>   * @cstate: compound state
> @@ -9998,6 +10013,9 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
>  		dp->dl_stid.sc_export =
>  			exp_get(cstate->current_fh.fh_export);
> 
> +	dp->dl_child_attrs[0] = gdd->gdda_child_attributes[0] & 
> GDD_WORD0_CHILD_ATTRS;
> +	dp->dl_child_attrs[1] = gdd->gdda_child_attributes[1] & 
> GDD_WORD1_CHILD_ATTRS;
> +
>  	/*
>  	 * NB: gddr_notification[0] represents the notifications that
>  	 * will be granted to the client
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 15ccd54ffdb6..1e3c360c06cd 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4271,18 +4271,15 @@ nfsd4_setup_notify_entry4(struct notify_entry4 
> *ne, struct xdr_stream *xdr,
> 
>  	args.change_attr = nfsd4_change_attribute(&args.stat);
> 
> -	attrmask[0] = FATTR4_WORD0_TYPE | FATTR4_WORD0_CHANGE |
> -		      FATTR4_WORD0_SIZE | FATTR4_WORD0_FILEID;
> -	attrmask[1] = FATTR4_WORD1_MODE | FATTR4_WORD1_NUMLINKS | 
> FATTR4_WORD1_RAWDEV |
> -		      FATTR4_WORD1_SPACE_USED | FATTR4_WORD1_TIME_ACCESS |
> -		      FATTR4_WORD1_TIME_METADATA | FATTR4_WORD1_TIME_MODIFY;
> +	attrmask[0] = dp->dl_child_attrs[0];
> +	attrmask[1] = dp->dl_child_attrs[1];
>  	attrmask[2] = 0;
> 
> -	if (setup_notify_fhandle(dentry, fi, nf, &args))
> -		attrmask[0] |= FATTR4_WORD0_FILEHANDLE;
> +	if (!setup_notify_fhandle(dentry, fi, nf, &args))
> +		attrmask[0] &= ~FATTR4_WORD0_FILEHANDLE;
> 
> -	if (args.stat.result_mask & STATX_BTIME)
> -		attrmask[1] |= FATTR4_WORD1_TIME_CREATE;
> +	if (!(args.stat.result_mask & STATX_BTIME))
> +		attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
> 
>  	ne->ne_attrs.attrmask.count = 2;
>  	ne->ne_attrs.attr_vals.data = (u8 *)xdr->p;
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index d912e3d04dd7..0763893bfd48 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -297,6 +297,9 @@ struct nfs4_delegation {
>  	struct timespec64	dl_atime;
>  	struct timespec64	dl_mtime;
>  	struct timespec64	dl_ctime;
> +
> +	/* For dir delegations */
> +	uint32_t		dl_child_attrs[2];
>  };
> 
>  static inline bool deleg_is_read(u32 dl_type)
>

When a client requests any supported child attribute in word 1, this can
make gddr_child_attributes[1] non-zero, so nfsd4_encode_bitmap4() emits a
two-word bitmap. nfsd4_get_dir_delegation_rsize() still budgets only the
old one-word child-attribute bitmap before executing this non-idempotent
op, so a compound near the reply/slot limit can grant a directory
delegation and then fail encoding with NFS4ERR_RESOURCE/REP_TOO_BIG,
leaving the client without the returned stateid.


-- 
Chuck Lever

