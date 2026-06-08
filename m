Return-Path: <linux-nfs+bounces-22384-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wlGPDJcrJ2qUswIAu9opvQ
	(envelope-from <linux-nfs+bounces-22384-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 22:52:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C27D165A8B8
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 22:52:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AMswiLxO;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22384-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22384-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1615301254A
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2026 20:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A604D39B48F;
	Mon,  8 Jun 2026 20:52:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFCA223328;
	Mon,  8 Jun 2026 20:52:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951956; cv=none; b=bxfVNFoCnAjMAdJ5pwhri5VXZQgecueAqzyiPeFH/Y96cWm3JGyKA7vue20QbUcP/o1ZX7gHU6py8+4i9hikTEoLAvaeeAZd6DCS99XJNH6JqewdfzKcqjBU2oHrh0oKSniK1H+ChpBZcRIC0d4UdSvAvTFE4jyfLisQCfJYFD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951956; c=relaxed/simple;
	bh=7AQJgwuCOtpyf2wp8xnP2NfKnPK3qGH5lUH5SaEzyWA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dDbm9VpnHVIhwShIDAKvhhiZC1Um0fl90bhEk18TyhYbLpU1EzRrleVRV6VbXEM7MsYKfAt/R58s9PADVTk2XNi4erFtDseEvzrxUW+vdTp66YxVhTi9jpFPl2HED63HoHdqq5f49uwo+yaIEoWYHOL6Rg5BwPzovtiPoFhxCnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMswiLxO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925221F00899;
	Mon,  8 Jun 2026 20:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780951955;
	bh=3+fvK8yYxol+0X1JKSuaTouiFfE+wJ2Iic9GGDxU8ns=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=AMswiLxOecnSkDMwzH/YCd5bK3b+4vE12r1EivWhG7N2NVM/OIpfYT11D3TAZBfxd
	 FoJqfLq8Di8BqBNqg72Dgqx13IuvA3ODukkcIAhQT8DIsWtPMqfJbTZ2KRpjCCIaml
	 iKUH+LLMvOeN8rLt4o7j9eemERYE65V99n4dPgkbYLqS1UkWD27kzuqxTWlgrw719R
	 vrLL0N7r5gPW3zGEoxd0tN5yFhzehtJyBPBgdOYBwzeqvlppKgLIt4k4z/GMj5a7UI
	 LssKs4yQiNu0mrIrNb2Xhx0G6KNChgl8rK+shSfZ52MaVfHZI6xb4yOAUkwitontka
	 ZfVutr2YtKYVQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C20E9F40077;
	Mon,  8 Jun 2026 16:52:33 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 08 Jun 2026 16:52:33 -0400
X-ME-Sender: <xms:kSsnamErNj2qtO9vgo4ei9DEQbT5BSBZFrZHofKN3XWCca-ZAH6HJg>
    <xme:kSsnaiJyBLJqN_ZEvkg8vUbci82QjWu3FxqTFey6QmniB908RbGkPPiLu_kgMgqwl
    kD00OpU_DcsCCJU_xieSalvTwIwlprkHJPJ4GteGCUj7pG9vGffLXE>
X-ME-Proxy-Cause: dmFkZTE53NSH2Ai9dcnnD064uA8AGJ5CyOsUmbT6fIvUVVT//4JaS6V7ZGp0w7sfDPnR2c
    j5gk+JvfMCPj5DAzhsnwH92+o8VJt89yZkwoamQ0DlpltNT7p1rWofwCWQVNySWbUtdohA
    /WVVyd+Ac6j21n48AN1P+gUXJSjcEnF1vOSfVjd8x5vfPY4SLjRdV34hv6lDnBV9Q3hiV8
    G9X8oAQEnaIsiHuRov9Lyv5zfTIAQAsEmefCQZKPus/F1McMLxE05xJAHRkTFYIgl6Z/tc
    ElmY/TVLBxVZuggmEyjZp79/0OKSamXULncfHhsjimPVqiOfRWa2QFU6o+qKs6hknryOTX
    WEThxWn7sTgWromsTPN6lWA9mcIjlbO0qb5VFAWJzdG6+7Pl1hvbdb2ZnGEPjVXCzpRmOl
    i+pi3mxa0Qa1wMkl39uHgvtzmUd5um9XXiCrY3enc7SQHq47eb9pfshhPxOeDWSt3URJkQ
    jRfLv1C7y4pNHqiN30CJjM3GWgAeuWnfZnxnclMyQ0NZGiM0d8pgIgfZkzI19ss1GwlRDT
    02BoJ/MTKRqMvdWYbjp4q15m+xoEDryi2/rD+XH72CaNvwyL5flcaxiP8P7dsJngWZLUG/
    k0UsZy4MjxUF0N3r1bJGqeRye04GPUQs1Wbfv4QOV50fR8nLBsQTHmPuQ0RQ
X-ME-Proxy: <xmx:kSsnatsyNdbPy4BH219RP5AvW4POIYuMNAXtYMQ6Y59Q6cc3GPVagg>
    <xmx:kSsnatj_lowNmNGcO-5M-bcGreE7Yh7x2gsODNy6nU8XhJ5jhhpVKw>
    <xmx:kSsnaocgEbu3Nfd-2aiHA4eBvTjdAYh77ubHCNE-UxeSP-O_GYeCeQ>
    <xmx:kSsnaqnXBuKrUXAbzyLx9vYUIU_bnL-5X-CaDfkUKG0l3C-V8emYCQ>
    <xmx:kSsnaqq2MT-PS3OR1KghRjOmoi0J0RAXIyAOrEIX_yIAp0LmkzjzeazU>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 98568780070; Mon,  8 Jun 2026 16:52:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AQ9KwGDGHELs
Date: Mon, 08 Jun 2026 16:52:12 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
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
Message-Id: <efdade0b-38f2-4e5e-b6dc-567d9eea97a9@app.fastmail.com>
In-Reply-To: <20260522-dir-deleg-v5-10-542cddfad576@kernel.org>
References: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
 <20260522-dir-deleg-v5-10-542cddfad576@kernel.org>
Subject: Re: [PATCH v5 10/21] nfsd: add notification handlers for dir events
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22384-lists,linux-nfs=lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C27D165A8B8



On Fri, May 22, 2026, at 3:42 PM, Jeff Layton wrote:
> Add the necessary parts to accept a fsnotify callback for directory
> change event and create a CB_NOTIFY request for it. When a dir nfsd_file
> is created set a handle_event callback to handle the notification.

> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index e17488a911f7..31df04675713 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4172,6 +4172,127 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, 
> struct xdr_stream *xdr,
>  	goto out;
>  }
> 
> +static bool
> +nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream 
> *xdr,
> +			  struct dentry *dentry, struct nfs4_delegation *dp,
> +			  struct nfsd_file *nf, char *name, u32 namelen)
> +{
> +	uint32_t *attrmask;
> +
> +	/* Reserve space for attrmask */
> +	attrmask = xdr_reserve_space(xdr, 3 * sizeof(uint32_t));
> +	if (!attrmask)
> +		return false;
> +
> +	ne->ne_file.data = name;
> +	ne->ne_file.len = namelen;
> +	ne->ne_attrs.attrmask.element = attrmask;
> +
> +	attrmask[0] = 0;
> +	attrmask[1] = 0;
> +	attrmask[2] = 0;
> +	ne->ne_attrs.attr_vals.data = NULL;
> +	ne->ne_attrs.attr_vals.len = 0;
> +	ne->ne_attrs.attrmask.count = 1;
> +	return true;
> +}
> +
> +/**
> + * nfsd4_encode_notify_event - encode a notify
> + * @xdr: stream to which to encode the fattr4
> + * @nne: nfsd_notify_event to encode
> + * @dp: delegation where the event occurred
> + * @nf: nfsd_file on which event occurred
> + * @notify_mask: pointer to word where notification mask should be set
> + *
> + * Encode @nne into @xdr. Returns a pointer to the start of the event, 
> or NULL if
> + * the event couldn't be encoded. The appropriate bit in the 
> notify_mask will also
> + * be set on success.
> + */
> +u8 *nfsd4_encode_notify_event(struct xdr_stream *xdr, struct 
> nfsd_notify_event *nne,
> +			      struct nfs4_delegation *dp, struct nfsd_file *nf,
> +			      u32 *notify_mask)
> +{
> +	u8 *p = NULL;
> +
> +	*notify_mask = 0;
> +
> +	if (nne->ne_mask & FS_DELETE) {
> +		struct notify_remove4 nr = { };
> +
> +		if (!nfsd4_setup_notify_entry4(&nr.nrm_old_entry, xdr, 
> nne->ne_dentry, dp,
> +					       nf, nne->ne_name, nne->ne_namelen))
> +			goto out_err;
> +		p = (u8 *)xdr->p;
> +		if (!xdrgen_encode_notify_remove4(xdr, &nr))
> +			goto out_err;
> +		*notify_mask |= BIT(NOTIFY4_REMOVE_ENTRY);
> +	} else if (nne->ne_mask & FS_CREATE) {
> +		struct notify_add4 na = { };
> +		struct notify_remove4 old = { };
> +
> +		if (!nfsd4_setup_notify_entry4(&na.nad_new_entry, xdr, 
> nne->ne_dentry, dp,
> +					       nf, nne->ne_name, nne->ne_namelen))
> +			goto out_err;
> +
> +		/* If a file was overwritten, report it in nad_old_entry */
> +		if (nne->ne_target) {
> +			if (!nfsd4_setup_notify_entry4(&old.nrm_old_entry, xdr,
> +						       NULL, dp, nf,
> +						       nne->ne_name, nne->ne_namelen))
> +				goto out_err;
> +			na.nad_old_entry.count = 1;
> +			na.nad_old_entry.element = &old;
> +		}
> +
> +		p = (u8 *)xdr->p;
> +		if (!xdrgen_encode_notify_add4(xdr, &na))
> +			goto out_err;
> +
> +		*notify_mask |= BIT(NOTIFY4_ADD_ENTRY);
> +	} else if (nne->ne_mask & FS_RENAME) {
> +		struct notify_rename4 nr = { };
> +		struct notify_remove4 old = { };
> +		struct name_snapshot n;
> +		bool ret;
> +
> +		/* Don't send any attributes in the old_entry since they're the same 
> in new */
> +		if (!nfsd4_setup_notify_entry4(&nr.nrn_old_entry.nrm_old_entry, xdr,
> +					       NULL, dp, nf, nne->ne_name,
> +					       nne->ne_namelen))
> +			goto out_err;
> +
> +		take_dentry_name_snapshot(&n, nne->ne_dentry);
> +		ret = nfsd4_setup_notify_entry4(&nr.nrn_new_entry.nad_new_entry, xdr,
> +					       nne->ne_dentry, dp, nf, (char *)n.name.name,
> +					       n.name.len);

Now once I got all of the previous edits in place, all three LLM
reviewers identified an issue here that might require a significant
rewrite. This is why I stopped the minor editing here and decided
it was time for you to consider restructuring (or not). I haven't
looked at patches 11-21.

  I think the new name here has a time-of-use problem.
  
  nrn_old_entry uses nne->ne_name, which alloc_nfsd_notify_event() copied
  when fsnotify delivered the rename.  nrn_new_entry instead reads the
  live dentry via take_dentry_name_snapshot() at callback-prepare time,
  which can run long after the event was queued.

  CB_NOTIFY is asynchronous: nfsd_handle_dir_event() queues the event on
  ncn_evt[] and nothing holds ne_dentry stable until the work runs.
  d_move() reuses the same dentry and rewrites d_name in place, so a
  second rename of the entry before the queued callback encodes leaves
  the dget'd ne_dentry carrying the later name.  An A->B event then
  encodes as A->C, and a client holding the directory delegation applies
  the wrong old->new mapping to its cache.  The old name is immune
  because it was snapshotted up front; only the new name is read late.

  The new name is available at notification time -- fsnotify_move() passes
  &moved->d_name as new_name, and ne_dentry is that moved dentry -- so
  alloc_nfsd_notify_event() can snapshot it alongside the old name.

What I haven't assessed is whether the suggested restructuring is
now vulnerable to misbehavior during memory exhaustion.


> +
> +		/* If a file was overwritten, report it in nad_old_entry */
> +		if (ret && nne->ne_target) {
> +			ret = nfsd4_setup_notify_entry4(&old.nrm_old_entry, xdr,
> +							NULL, dp, nf,
> +							(char *)n.name.name, n.name.len);
> +			if (ret) {
> +				nr.nrn_new_entry.nad_old_entry.count = 1;
> +				nr.nrn_new_entry.nad_old_entry.element = &old;
> +			}
> +		}
> +
> +		if (ret) {
> +			p = (u8 *)xdr->p;
> +			ret = xdrgen_encode_notify_rename4(xdr, &nr);
> +		}
> +		release_dentry_name_snapshot(&n);
> +		if (!ret)
> +			goto out_err;
> +		*notify_mask |= BIT(NOTIFY4_RENAME_ENTRY);
> +	}
> +	return p;
> +out_err:
> +	pr_warn("nfsd: unable to marshal notify_rename4 to xdr stream\n");
> +	return NULL;
> +}
> +
>  static void svcxdr_init_encode_from_buffer(struct xdr_stream *xdr,
>  				struct xdr_buf *buf, __be32 *p, int bytes)
>  {


-- 
Chuck Lever

