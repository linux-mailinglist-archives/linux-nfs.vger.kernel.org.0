Return-Path: <linux-nfs+bounces-22525-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1vitLUBHLGr+OgQAu9opvQ
	(envelope-from <linux-nfs+bounces-22525-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 19:52:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CD967B748
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 19:52:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=S4odbrLc;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22525-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22525-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B26D304B561
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 17:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D821B375AD0;
	Fri, 12 Jun 2026 17:51:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C4F3655F9
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jun 2026 17:51:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781286706; cv=none; b=myrumLONcCdUC7nuvNVJWXoo0Yz7HlbjwrDu8tMUPJPVVE6uiWTYm2mzveDC0JP6JOYSrhqDOkf3i1CVlfZIwpIlQicMES+e4zDqq9ctTz9dghG13roUZJCU+8cBzU9ZhhF74p7qwJmU6y/PI35F7Qk3lOoQ7BOAfzRAb8lFzIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781286706; c=relaxed/simple;
	bh=56Ivha6xKFQ4VCMPv3kiCPG/CApgmuASriV7K82gRoc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VouEv6sEUevigMd9PSkb4FR4LnzFV2Ib7SwSnKO8/a9OXai6XB5ZioUk8xvIbFw3kJ6tEehlHN/XfYU6Z7kyC6GhbkG2IwwQPF0v/g4+Gh8CdVT6TB8uRM5b93dGTUGMGQo+UDPmr2Fx4wxjofR1YVvMABMkr2MQFoggJrA33y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4odbrLc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E531F00A3D;
	Fri, 12 Jun 2026 17:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781286704;
	bh=Q/9iUeEM2UpFf/86WWBloKEZXHGVhwttRlCQuzlZ5Ok=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=S4odbrLc26oeLyRs7t74pRqXzocdSCAEoQ+wSC+pmj9N5IcClemxvOavBqS5CtocE
	 ftOrbCnHK7fjGvobylmvUR3RcXKqvQLwTRt4uaijIXqtJcJ/KsIxlbOUARIhlJZwd+
	 VaL4UiMEjDYriNC1RtiN0JhRCJwMF9XWEwgTxJ1d43KLyhd6bR9bkVUAZuaxXGiwVe
	 KdHoIefzJaP5Ee4OyN4SqV2iTyVqtUou5z1Jmfc08sLZKIMjwZxZ/mVCQr1EsYK4aQ
	 wVHnWfJztPTIAVTVZ0kmmUwZ8RA31WvfmX3CIjSOSvdyNg77MiYxRj9tT147jm23O8
	 cP0R3DP8rq8uA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E13FAF40074;
	Fri, 12 Jun 2026 13:51:42 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 12 Jun 2026 13:51:42 -0400
X-ME-Sender: <xms:LkcsampZbsE8djkJP2h1lwByf5GRs5c5juQxy9hlbTvmn09BKLH0ww>
    <xme:LkcsavchmLWpJUWzn4J6KM0LiyDhcSp1YyVOO_vErcVGLivDMmGenEdA03EpfawBX
    PtSj47QEN_UdBEdOdStMo2q_IIEziaC86BpY_RFHLBN2E4Yg3AoqeaT>
X-ME-Proxy-Cause: dmFkZTF4dxDvwsonL4JVAx5hoEMaw5DXSAzJLG/s/8RSaT1MGvkn04K97aWX0zvht5wokp
    z9DCWcc53ckBYUC2uxjOuSYa+pU60G0XVTbpKUTdKv4SihmvRFSYQXEMYtW9bApE7ZPLz+
    dM7WFpB3WK0pS6i0tbbXIcgY8XOpMqlVDCeLNkPuewnClEAQk+vPMZ5I/MwXomyWpZRJLP
    VhjUE5/ilpqL7X8i8hUqr9qP1YYPhqg0x3KrNI0Xfdrk+GlC8alkLnxIrdE5cf0ZHldEKy
    VzOjxveHtaZEnhuzzWAKfscRWh1DwnNNnCpqrtN0XNtTdjRRA0sh0g8wdNf6YfXdmZPGS1
    hug16szM/AkJxZMOBDUAj8MY/E9qPIMwTi+B6nFCKbdHV3KDZ6zPigw/dfXMlCqh73rAvU
    /JXXFJ8kfItFbC9W3Fgca8jRID2uKrauAvQipiR4MMuVwR46tZgPqw+892t01bQ4Vs8SCS
    0rEcY3xxfav0hff+8+mc5VmfvcYDssitkouwCYkwvhZC9logumym81mBSlwojDGfvvf/dP
    nm8Xh7o5I9hITyug2AL3mWwekU9k2nT+GCKJeiTkfdIumU4SnYj+Xrd/wOOiQqvQEMtT1Z
    UCllrYESWacOLfwVwlcLumxIJE/FTE+HuJuCcIUn1ULAg43O3qXtAKr3yvMQ
X-ME-Proxy: <xmx:LkcsasAI6_F4hiBcJCcwAIREijRUOVK7-SwhMnRIJ65zcRSN-EzKow>
    <xmx:LkcsajYRwThhZbjOi21_D3u79Hfpbtmt5_bMd8xlXyDk8fjTtqDfnw>
    <xmx:LkcsaoIgv4Rf9SvvBvrxe75quivKdU2uPNPlC8ONoYrNBTaqCk-w1g>
    <xmx:LkcsakDycMw7M9e7uTjERKgMyxvDEknPeqlTAEmG8DLFhhiCY9KdDg>
    <xmx:LkcsakOM0GFZ2Th_rPl6IHbrhECv0iwe5M2aZMQ6Nd44l25sWGzPReL6>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B4E2B780070; Fri, 12 Jun 2026 13:51:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYZVHXguuuu-
Date: Fri, 12 Jun 2026 13:51:22 -0400
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
Message-Id: <b94c3e40-0520-4e83-9b4f-53a9325cecfe@app.fastmail.com>
In-Reply-To: <20260611-dir-deleg-v6-10-4c45080e5f3f@kernel.org>
References: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
 <20260611-dir-deleg-v6-10-4c45080e5f3f@kernel.org>
Subject: Re: [PATCH v6 10/20] nfsd: add notification handlers for dir events
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.65 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22525-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,app.fastmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cna_fh.data:url];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32CD967B748


On Thu, Jun 11, 2026, at 1:50 PM, Jeff Layton wrote:
> Add the necessary parts to accept a fsnotify callback for directory
> change event and create a CB_NOTIFY request for it. When a dir nfsd_file
> is created set a handle_event callback to handle the notification.
>
> Use that to allocate a nfsd_notify_event object and then hand off a
> reference to each delegation's CB_NOTIFY. If anything fails along the
> way, recall any affected delegations.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index ca4dd2f969eb..59378751d596 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c

> @@ -904,13 +908,45 @@ static void nfs4_xdr_enc_cb_notify(struct rpc_rqst *req,
>  	encode_cb_sequence4args(xdr, cb, &hdr);
> 
>  	/*
> -	 * FIXME: get stateid and fh from delegation. Inline the cna_changes
> -	 * buffer, and zero it.
> +	 * nfsd4_cb_notify_prepare() sized the payload against a single page,
> +	 * but did not account for the compound, sequence, stateid, and
> +	 * filehandle encoded here. If the variable-length encode overflows the
> +	 * backchannel send buffer, roll back to before the operation so that a
> +	 * truncated CB_NOTIFY is never placed on the wire.
>  	 */
> -	xdrgen_encode_CB_NOTIFY4args(xdr, &args);
> +	start = xdr_stream_pos(xdr);
> +
> +	p = xdr_reserve_space(xdr, 4);
> +	if (!p)
> +		goto out_err;
> +	*p = cpu_to_be32(OP_CB_NOTIFY);

Please use xdr_stream_encode_u32 for this purpose.


> +
> +	args.cna_stateid.seqid = dp->dl_stid.sc_stateid.si_generation;
> +	memcpy(&args.cna_stateid.other, &dp->dl_stid.sc_stateid.si_opaque,
> +	       ARRAY_SIZE(args.cna_stateid.other));
> +	args.cna_fh.len = dp->dl_stid.sc_file->fi_fhandle.fh_size;
> +	args.cna_fh.data = dp->dl_stid.sc_file->fi_fhandle.fh_raw;
> +	args.cna_changes.count = ncn->ncn_nf_cnt;
> +	args.cna_changes.element = ncn->ncn_nf;
> +	if (!xdrgen_encode_CB_NOTIFY4args(xdr, &args))
> +		goto out_err;
> 
>  	hdr.nops++;
>  	encode_cb_nops(&hdr);
> +	return;
> +
> +out_err:
> +	/*
> +	 * Drop the CB_NOTIFY op and emit a valid CB_SEQUENCE-only compound so
> +	 * the client still advances its slot. Flag the failure so the done
> +	 * handler recalls the delegation and the missed notification is not
> +	 * silently lost. The flag is written here in the transmit path and read
> +	 * in the done handler; the two are serialized phases of the same
> +	 * rpc_task, so no additional barrier is needed.
> +	 */
> +	ncn->ncn_encode_err = true;

This flag is zeroed only once, at allocation time in alloc_init_dir_deleg().
It is never cleared in nfsd4_cb_notify_prepare().

Since nfsd4_cb_notify_release() can requeue the callback (via
nfsd4_run_cb_notify) when events arrive while a callback is in flight,
->prepare may encode cleanly and return true, but nfsd4_cb_notify_done()
still observes the stale ncn_encode_err == true and calls
nfsd_break_one_deleg() -- discarding a good notification and recalling
the delegation unnecessarily.


> +	xdr_truncate_encode(xdr, start);
> +	encode_cb_nops(&hdr);
>  }
> 
>  static int nfs4_xdr_dec_cb_notify(struct rpc_rqst *rqstp,

> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 0a15d7f3b543..513cbc1a583f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c

> @@ -3471,19 +3472,146 @@ nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
>  	nfs4_put_stid(&dp->dl_stid);
>  }
> 
> +static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
> +{
> +	bool queued;
> +
> +	if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &dp->dl_recall.cb_flags))
> +		return;
> +
> +	/*
> +	 * We're assuming the state code never drops its reference
> +	 * without first removing the lease.  Since we're in this lease
> +	 * callback (and since the lease code is serialized by the
> +	 * flc_lock) we know the server hasn't removed the lease yet, and
> +	 * we know it's safe to take a reference.
> +	 */
> +	refcount_inc(&dp->dl_stid.sc_count);
> +	queued = nfsd4_run_cb(&dp->dl_recall);
> +	WARN_ON_ONCE(!queued);
> +	if (!queued) {
> +		refcount_dec(&dp->dl_stid.sc_count);
> +		clear_bit(NFSD4_CALLBACK_RUNNING, &dp->dl_recall.cb_flags);
> +	}
> +}

nfsd_break_one_deleg() does an unconditional
refcount_inc(&dp->dl_stid.sc_count), and its comment justifies this
with "the lease code is serialized by the flc_lock." That invariant
holds when called from nfsd_break_deleg_cb() under flc_lock, but
nfsd4_cb_notify_prepare() runs on a workqueue WITHOUT flc_lock. Its
out_recall: path calls nfsd_break_one_deleg(dp)
directly. The delegation can be concurrently destroyed with sc_count
already at zero, making this an inc-from-zero.

The dispatch path nfsd4_run_cb_notify already does this correctly with
refcount_inc_not_zero. The out_recall path needs the same guard (skip
the recall / bail if the refcount is already zero).

I notice that the last unapplied patch ("nfsd: add
support to CB_NOTIFY for dir attribute changes") rewrites the guard
"if (count > NOTIFY4_EVENT_QUEUE_SIZE)" into "if (count > limit)" with
limit = NOTIFY4_EVENT_QUEUE_SIZE - 1 when NOTIFY4_CHANGE_DIR_ATTRS is
requested. That turns the previously-dead overflow branch into a live,
routine path to out_recall, which adds another normal-operation route
into this unlocked recall.


-- 
Chuck Lever

