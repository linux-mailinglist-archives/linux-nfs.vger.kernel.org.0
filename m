Return-Path: <linux-nfs+bounces-22532-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hY29Bh5QLGrqPAQAu9opvQ
	(envelope-from <linux-nfs+bounces-22532-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 20:29:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2746267BB3B
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 20:29:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=D2MpcEm6;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22532-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22532-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34603330AEAD
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 18:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9072D1E8826;
	Fri, 12 Jun 2026 18:22:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DBD37416F
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jun 2026 18:22:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288541; cv=none; b=eatKBk+/C3qnkZw+zMGLs0pNJUHFSiATNGJPhVfHoIxucvCuJD4E3v+9ZQ+zmHDmIG3iw5W50kvDMP2mQhPiRfh3pY1C9YY1/QsyTn+uyrHhLfNJqPQxun6DB6oVDXSRX0EiIjHEk/XttvVqBxyl5mLpwlqaupFx+yJeDvxCxa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288541; c=relaxed/simple;
	bh=uwc+qYiADfuRg4QfSfsS70fZvz4xK19iK7df/xd2r3U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LR8ayobkJhDN8DqQemWVxdduJgGK4nkHsiH5WGHf4MROFOSLkk4uOVcqw0sV4uEI0knuwaTLBjpnDJECL2IfDbRZ7TUt06bJkPHvKcGnUEVp16t9SFcsVEvXY++cq5ZdVub+2DvMC0YBxRLROc0dpAgJ1H+g9Fe1d90k2HOr0n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2MpcEm6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C32F1F000E9;
	Fri, 12 Jun 2026 18:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781288540;
	bh=HIBSmSvqbKTSUBF2JO/8v/1H5k5VRiD5yTRontKQgB8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=D2MpcEm6JyyFXVYJf0obkrJx0BqM4wys4Rh88TooU4C3TuppFNWcrBzahRxkA4EeU
	 tsCmVAeSlgHsg06h6I2nvXIxqzFbJOU3ucKL7vJm1YcFzp5MOyxalAT8AsDEPoqaxn
	 gSMnwRT+o2hlTquAqXu5xcGv7PSZ+oJIrFEiuq+IJGMUmdgjVSec9S/jABHPIFDU6y
	 Brwe+WYdtGqcooVMuFTBzs9rFQdn9kx2iK/lNQiodVT6qYYxCbcTwfm0duhPY1PRob
	 fVQptcXnv42Es8qxvXmwXGWMX1W3ds4rcyOT+YptMdka+2zt4PXleDjRAzB6QclVir
	 HklhMThfKgb4Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8E06FF40069;
	Fri, 12 Jun 2026 14:22:18 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 12 Jun 2026 14:22:18 -0400
X-ME-Sender: <xms:Wk4saoLFTimBXTV6GJE6Kacb0fzKkQhha5J5Y5cIQgny7pYjfVBYUw>
    <xme:Wk4sai-4YwdemTsxokaAWZcovd3F0NGp-qE5wxhz0A37WbGFsaf8S1rP_tJNLilaq
    7EMj3ukRZ9P52cUDVNUvoHXPOtJbXU4UQqSGJOuPCuX2Xaoh0yhDIdV>
X-ME-Proxy-Cause: dmFkZTFe1ktk+gd6CAS175n8g4eJWchAhxRzO5LWhNwIPGOg2LFqvRctb0d26B6oN4H2Nl
    reJqNrzhu2cHbLa4kaSll6wK4GshQ7W7bCZQsGcvbyL3vJw2YgtLpL1BlGDVYUKwjtE3Bl
    wHix5HzEe+JjRiKajdjsDXE9xcMn4GDE9OiSrZxPzusIzKcWUSX7zzjcNN241Pf+fmEBjG
    oK8hAyjob6YX8iT7PK7JIOnhOi1z9sna13C/sam4deo4y5h60mWtqplIY0G/vDJ6n+/wJk
    RvDyERd07f+zQEQ2dmiko/KRmrqU/nfnwFi0Uhwafe5ZWUKDDfETe+i1ByLI/RFK3mVynH
    yhfd02VqOEBXW5a1HzTY0eCkX3VsvBM/mQDAz82/fvEB8VtB7tNdw5z+buSMfqqNfLeytL
    Dv9IemAY9E9iOfDE2c0jrwye9zDf4ztuyNy3q8eM9F6A90didclg4fw4TmKLKdQNdHTmrN
    2KxIy9OplggsGI3dqCkXMVrevnEKCI4WP8DvbqBz0wvjO3yeU66okyjHDuad/BgU0JWuRv
    E6BkNWjYvVT4yJYMc4zupCri8r3cP75pN3hH8I9rKxle/b7IBdq0WY92Q2wYAc7q2V8SMU
    qEL2Xejm9PLQd7fVX81DHT4mT+LN8ROpReoDk5ax0a+Ia3JutBFuoTOrWRog
X-ME-Proxy: <xmx:Wk4saq7uPbTcmyD_JfFchTs6Cnq49Xnz55ChJcYjROReTXQee4iF8g>
    <xmx:Wk4sapo8g4J8DU_IBCgQ9lXuxAALINLOeUrp7OzCbEjVyrxXc8auSA>
    <xmx:Wk4sanh4TsCurJh-vwDJguiJvkYNEb2rHhdw5wSDbAXWqriXk52zKg>
    <xmx:Wk4sahsCWYk2dFTnNshKjIvWT25Zbq4E8oG_4vjCnbOEp_Cjqntn8Q>
    <xmx:Wk4sao0RISFrR489t4IZZwS3GJPcKOtMdMKLMXyF8wI_zaXxpSrO6uvA>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 65758780077; Fri, 12 Jun 2026 14:22:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMbFGisdB0jJ
Date: Fri, 12 Jun 2026 14:21:58 -0400
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
Message-Id: <0a0bfce8-c35e-4c96-8f7b-65267fd96a61@app.fastmail.com>
In-Reply-To: <20260611-dir-deleg-v6-20-4c45080e5f3f@kernel.org>
References: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
 <20260611-dir-deleg-v6-20-4c45080e5f3f@kernel.org>
Subject: Re: [PATCH v6 20/20] nfsd: add support to CB_NOTIFY for dir attribute changes
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
	TAGGED_FROM(0.00)[bounces-22532-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,app.fastmail.com:mid];
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
X-Rspamd-Queue-Id: 2746267BB3B



On Thu, Jun 11, 2026, at 1:50 PM, Jeff Layton wrote:
> If the client requested dir attribute change notifications, send those
> alongside any set of add/remove/rename events. Note that the server will
> still recall the delegation on a SETATTR, so these are only sent for
> changes to child dirents.
>
> The child filehandle returned in these notifications is composed by
> setup_notify_fhandle() without going through fh_compose(), so it does
> not get a MAC appended. On exports configured with NFSEXP_SIGN_FH the
> client would then get back an unsigned filehandle that fh_verify()
> rejects as stale. Pass the delegation's export down to
> setup_notify_fhandle() and append the MAC with fh_append_mac() when the
> export requires signed filehandles; if signing fails, drop the
> filehandle attribute rather than handing out an unusable one.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 25 ++++++++++++++++--
>  fs/nfsd/nfs4xdr.c   | 73 +++++++++++++++++++++++++++++++++++++++++++++--------
>  fs/nfsd/xdr4.h      |  2 ++
>  3 files changed, 88 insertions(+), 12 deletions(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 12627afb604f..e394278fb92e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3503,10 +3503,15 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
>  	struct nfsd_notify_event *events[NOTIFY4_EVENT_QUEUE_SIZE];
>  	struct xdr_buf xdr = { .buflen = PAGE_SIZE * NOTIFY4_PAGE_ARRAY_SIZE,
>  			       .pages  = ncn->ncn_pages };
> +	int limit = NOTIFY4_EVENT_QUEUE_SIZE;

When a client requests NOTIFY4_CHANGE_DIR_ATTRS, the CB_NOTIFY event
queue can fill to NOTIFY4_EVENT_QUEUE_SIZE (3) events while the consumer
only accepts 2 (it reserves a slot for the dir-attr-change entry). The
resulting overflow path in nfsd4_cb_notify_prepare() recalls the
delegation without draining the queue, and nfsd4_cb_notify_release()
then requeues the same callback indefinitely.


>  	struct xdr_stream stream;
>  	struct nfsd_file *nf;
> -	int count, i;
>  	bool error = false;
> +	int count, i;
> +
> +	/* Save a slot for dir attr update if requested */
> +	if (dp->dl_notify_mask & BIT(NOTIFY4_CHANGE_DIR_ATTRS))
> +		--limit;
> 
>  	xdr_init_encode_pages(&stream, &xdr);
> 
> @@ -3520,7 +3525,7 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
>  	}
> 
>  	/* we can't keep up! */
> -	if (count > NOTIFY4_EVENT_QUEUE_SIZE) {
> +	if (count > limit) {
>  		spin_unlock(&ncn->ncn_lock);
>  		goto out_recall;
>  	}
> @@ -3567,6 +3572,22 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback 
> *cb)
>  		nfsd_notify_event_put(nne);
>  	}
>  	if (!error) {
> +		if (dp->dl_notify_mask & BIT(NOTIFY4_CHANGE_DIR_ATTRS)) {
> +			u32 *maskp = (u32 *)xdr_reserve_space(&stream, sizeof(*maskp));
> +
> +			if (maskp) {
> +				u8 *p = nfsd4_encode_dir_attr_change(&stream, dp, nf);
> +
> +				if (p) {
> +					*maskp = BIT(NOTIFY4_CHANGE_DIR_ATTRS);
> +					ncn->ncn_nf[count].notify_mask.count = 1;
> +					ncn->ncn_nf[count].notify_mask.element = maskp;
> +					ncn->ncn_nf[count].notify_vals.data = p;
> +					ncn->ncn_nf[count].notify_vals.len = (u8 *)stream.p - p;
> +					++count;
> +				}
> +			}
> +		}

Nit:

When xdr_reserve_space() for maskp succeeds but nfsd4_encode_dir_attr_change()
returns NULL, the 4-byte reservation is never rolled back and *maskp is never
written, yet the function still takes the success path (return true). Unlike
the child-event loop, this branch does not escalate to error = true.

This is probably benign only because nfs4_xdr_enc_cb_notify re-encodes from
the ncn_nf[] array (and count was not incremented), so the garbage hole is
never transmitted.


>  		ncn->ncn_nf_cnt = count;
>  		nfsd_file_put(nf);
>  		return true;
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 1e3c360c06cd..7dd8476028d6 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4199,7 +4199,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, 
> struct xdr_stream *xdr,
> 
>  static bool
>  setup_notify_fhandle(struct dentry *dentry, struct nfs4_file *fi,
> -		     struct nfsd_file *nf, struct nfsd4_fattr_args *args)
> +		     struct nfsd_file *nf, struct svc_export *exp,
> +		     struct nfsd4_fattr_args *args)
>  {
>  	int fileid_type, fsid_len, maxsize, flags = 0;
>  	struct knfsd_fh *fhp = &args->fhandle;

The function dereferences the new exp parameter unconditionally.

The argument is dp->dl_stid.sc_export, read unlocked at
nfs4xdr.c:4297 and handed down. An in-flight CB_NOTIFY callback holds a
sc_count reference but NOT an export reference. drop_stid_export() can
run concurrently (admin revoke / unexport), NULL sc_export, and drop what
may be the last export reference, freeing the svc_export while the
callback dereferences it.


> @@ -4227,6 +4228,17 @@ setup_notify_fhandle(struct dentry *dentry, 
> struct nfs4_file *fi,
> 
>  	fhp->fh_fileid_type = fileid_type;
>  	fhp->fh_size += maxsize * 4;
> +
> +	/*
> +	 * fh_compose() appends a MAC to filehandles on signed exports; this
> +	 * hand-rolled filehandle must do the same or the client will get back
> +	 * an unsigned filehandle that fh_verify() later rejects as stale.
> +	 * If we can't sign it, don't hand it out at all.
> +	 */
> +	if (exp && (exp->ex_flags & NFSEXP_SIGN_FH))
> +		if (!fh_append_mac(fhp, NFS4_FHSIZE, exp->cd->net))
> +			return false;
> +
>  	return true;
>  }
> 
> @@ -4240,11 +4252,11 @@ nfsd4_setup_notify_entry4(struct notify_entry4 
> *ne, struct xdr_stream *xdr,
>  			  struct nfsd_file *nf, char *name, u32 namelen)
>  {
>  	struct nfs4_file *fi = dp->dl_stid.sc_file;
> -	struct path path =  { .mnt = nf->nf_file->f_path.mnt,
> -			      .dentry = dentry };
> +	struct path path = nf->nf_file->f_path;
>  	struct nfsd4_fattr_args args = { };
>  	uint32_t *attrmask;
>  	__be32 status;
> +	bool parent;
>  	int ret;
> 
>  	/* Reserve space for attrmask */
> @@ -4256,6 +4268,9 @@ nfsd4_setup_notify_entry4(struct notify_entry4 
> *ne, struct xdr_stream *xdr,
>  	ne->ne_file.len = namelen;
>  	ne->ne_attrs.attrmask.element = attrmask;
> 
> +	parent = (dentry == path.dentry);
> +	path.dentry = dentry;
> +
>  	/* FIXME: d_find_alias for inode ? */
>  	if (!path.dentry || !d_inode(path.dentry))
>  		goto noattrs;
> @@ -4271,15 +4286,21 @@ nfsd4_setup_notify_entry4(struct notify_entry4 
> *ne, struct xdr_stream *xdr,
> 
>  	args.change_attr = nfsd4_change_attribute(&args.stat);
> 
> -	attrmask[0] = dp->dl_child_attrs[0];
> -	attrmask[1] = dp->dl_child_attrs[1];
> -	attrmask[2] = 0;
> +	if (parent) {
> +		attrmask[0] = dp->dl_dir_attrs[0];
> +		attrmask[1] = dp->dl_dir_attrs[1];
> +	} else {
> +		attrmask[0] = dp->dl_child_attrs[0];
> +		attrmask[1] = dp->dl_child_attrs[1];
> 
> -	if (!setup_notify_fhandle(dentry, fi, nf, &args))
> -		attrmask[0] &= ~FATTR4_WORD0_FILEHANDLE;
> +		if (!setup_notify_fhandle(dentry, fi, nf,
> +					  dp->dl_stid.sc_export, &args))
> +			attrmask[0] &= ~FATTR4_WORD0_FILEHANDLE;
> 
> -	if (!(args.stat.result_mask & STATX_BTIME))
> -		attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
> +		if (!(args.stat.result_mask & STATX_BTIME))
> +			attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
> +	}
> +	attrmask[2] = 0;
> 
>  	ne->ne_attrs.attrmask.count = 2;
>  	ne->ne_attrs.attr_vals.data = (u8 *)xdr->p;
> @@ -4392,6 +4413,38 @@ u8 *nfsd4_encode_notify_event(struct xdr_stream 
> *xdr, struct nfsd_notify_event *
>  	return NULL;
>  }
> 
> +/**
> + * nfsd4_encode_dir_attr_change
> + * @xdr: stream to which to encode the fattr4
> + * @dp: delegation where the event occurred
> + * @nf: nfsd_file opened on the directory
> + *
> + * Encode a dir attr change event.
> + */
> +u8 *nfsd4_encode_dir_attr_change(struct xdr_stream *xdr, struct 
> nfs4_delegation *dp,
> +				 struct nfsd_file *nf)
> +{
> +	struct dentry *dentry = nf->nf_file->f_path.dentry;
> +	struct notify_attr4 na = { };
> +	bool ret;
> +	u8 *p = NULL;
> +
> +	if (!(dp->dl_notify_mask & BIT(NOTIFY4_CHANGE_DIR_ATTRS)))
> +		return NULL;

It looks like this if() re-checks dl_notify_mask even though its
sole caller already gated on the identical check.

nfsd4_encode_notify_event() does not repeat its caller's check.
The guard is unreachable from current callers.


> +
> +	/* RFC 8881 s10.4.3: ne_file must be a zero-length string for dir 
> attrs */
> +	ret = nfsd4_setup_notify_entry4(&na.na_changed_entry, xdr,
> +					dentry, dp, nf, "", 0);
> +
> +	/* Don't bother with the event if we're not encoding attrs */
> +	if (ret && na.na_changed_entry.ne_attrs.attr_vals.len) {
> +		p = (u8 *)xdr->p;
> +		if (!xdrgen_encode_notify_attr4(xdr, &na))
> +			p = NULL;
> +	}
> +	return p;
> +}
> +
>  static void svcxdr_init_encode_from_buffer(struct xdr_stream *xdr,
>  				struct xdr_buf *buf, __be32 *p, int bytes)
>  {
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 62ac790428be..805c7122eb93 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -973,6 +973,8 @@ __be32 nfsd4_encode_fattr_to_buf(__be32 **p, int 
> words,
>  u8 *nfsd4_encode_notify_event(struct xdr_stream *xdr, struct 
> nfsd_notify_event *nne,
>  			      struct nfs4_delegation *dd, struct nfsd_file *nf,
>  			      u32 *notify_mask);
> +u8 *nfsd4_encode_dir_attr_change(struct xdr_stream *xdr, struct 
> nfs4_delegation *dp,
> +				 struct nfsd_file *nf);
>  extern __be32 nfsd4_setclientid(struct svc_rqst *rqstp,
>  		struct nfsd4_compound_state *, union nfsd4_op_u *u);
>  extern __be32 nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
>
> -- 
> 2.54.0

-- 
Chuck Lever

