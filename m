Return-Path: <linux-nfs+bounces-22382-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2JH9MGgmJ2qdsgIAu9opvQ
	(envelope-from <linux-nfs+bounces-22382-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 22:30:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2133665A719
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 22:30:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=E+43Rb23;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22382-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22382-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CD2C30EDB38
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2026 20:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037653EB81D;
	Mon,  8 Jun 2026 20:18:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF3B394E8A
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jun 2026 20:18:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949929; cv=none; b=l8YM6TEwY9lRkXw5kWv7XRTGoGFWv5aXIBVe1f3j9kcxM2fspJdY+BycdrsaECZJYweXRXNxWa3+XbWVCfWx3T9kaQvYYzLOoNzO23PI6RWx+aW6pjVs8VPglm784ivITTWtajnBTVRdj1v92ka9MrK5D8ALfd1YE2fNacrbQ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949929; c=relaxed/simple;
	bh=zkCy7ZbUyKxmWX9iJHWq8kboagFoaOWaihLlM2Uy8Y0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=F5DHlqsWUhRxQyamB167xRmvDR6yJGGGgI7gAAfqfaTtn2Pj9ErwcH9UcmqSA6ygDoyWr6nNz3pigIoeC7LD5fbVh7aEPlVLHNN+sRE6rnmAK5Gz1bQGUljsVVE4TNPlNuA5R5dahQIK2hDR8HsP71IDVgu00GUAnx8aIlr2YL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+43Rb23; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444811F00893;
	Mon,  8 Jun 2026 20:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949928;
	bh=9JIpOL9jynq221RYhFtl6wvHMOB90agMSVGCmlflxck=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=E+43Rb23F/TeC2jS3QxM7i2QCwsebeUDB1s2JyRSFaNcpQO3OBvhUGWl+MlHLiGAj
	 MaBgcwEhD/tKDpn7wcIeemxbr3hN+BBOUhB00A4gUGPxLKtSZaPqsR0+kCa/CpGVYt
	 bK2qd5JTWLoG6MEC9hVlp/5WWMm9ULOuXU/cdeBOVknvpJRgQ93dTqWRwTCd4XkjyK
	 U1rZo+QyyH+QLK9UWetdsnJ/AGj/ArK0VSwwwiWxYiFhDgtqTs9/vqmyfgFgo14GCc
	 UFxWsxkhQVHBNBPlDTlUNKDfJf3FE0goV65AadHi8OqDWXvsK0iS7jY4oAhYsasQ6y
	 u7XDh7dFbmOQg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6CC50F4007D;
	Mon,  8 Jun 2026 16:18:47 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 08 Jun 2026 16:18:47 -0400
X-ME-Sender: <xms:pyMnasY5iEExsI72rC30IBqZzj1-PSGA95daF3sYSLShWGkrDoCa7g>
    <xme:pyMnaiNR_xy1yOl9eOPMnTzbAarjS91DFVvWIMAXE9P2s80zcnFVk8kFxeSSh7183
    GRU06qIr07r1F8F8fBtMTgSxr1veFz4e3NoUvUHQrn9iLQIT_5LFnaM>
X-ME-Proxy-Cause: dmFkZTGHPggZzlgsaUEswWux71So2C9txG/i+VzijxF0YhQPto13bxlbgvh4lqSDPpawDs
    slVRfhYQxnQZXIO1gUSEimRMHsQuiPX7kLiLB7r+e6oYegUDEU5U6A6UGLISUe/k0KzZGm
    OGh67TR+rBBdkvtZS8HsSmOeYWvMjDibtpP/uAm94vJddG+DW7Ig6JbcWi5RVtb44io76D
    aivdj1pWbR0ectF4azQB1cnYpS2ZszGFWtcy46brsz49ltyGFftFU0lMP9WN0LuST0lfvN
    A9GulhN9VXqssV10xVP3Mv82foMEYvWBectQ/XPSYc3LSreBypsmSXoAJqASLZKidlGmK2
    h3xMt+KuiLCktmOSfTZO7q7GZRigFCZM+7cVICDP85KdCEroTYNc3z8HmfNhj05PFulqpO
    EuV2lTSnSVqzB3sRyyBt9cteIJsaoLpWuhKp2/5UmK8Z0j3x3CCtiMtWZXKRwNV3PtXu4Q
    3cOz2s0H1QRuP+lqTDC7sqp5BpjaY6tPGzfycnlbZV77Gtzjzd2FEHVNs0h2Uy/5QD55Xw
    uiDPdj0KuHhgQJFqEig9JhKASOFWABOR+Jg0GJh0T/dFEiFIL9jgACNf9mr7VcW2FZFm+n
    lTraLT3DyFYhd3XpfRiDHM+50rb0w2QqDtxfPbocxy+aI1Hjr4CxJu5+A0AQ
X-ME-Proxy: <xmx:pyMnapAcL1Mdh5uFHt2_p4LROnLLgFDbfgtDnMWvrFOavnxrctUN_A>
    <xmx:pyMnaukf1LP6VAEPCyhsrOXIL3B3wa0zSP0ilpClPRs8bH89bLsC_A>
    <xmx:pyMnasQNk6g6zvUtJg6MFRntrjZJ-zuZoL366_VFqKSwgzPFs5U5vw>
    <xmx:pyMnaqKouVd66QndLsye5jMchF2lEy8M9vkzcIBVpCoegb8qOqnwcw>
    <xmx:pyMnaq9moJfAc8rBqO5CE3Yw0c5r4O_kJJiWoZvVn2YRv90eQn1eb34V>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4436C780070; Mon,  8 Jun 2026 16:18:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aa4qv74Ug3eB
Date: Mon, 08 Jun 2026 16:18:26 -0400
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
Message-Id: <566fd48c-bf10-4974-9ee4-1afc30b7a69c@app.fastmail.com>
In-Reply-To: <20260522-dir-deleg-v5-9-542cddfad576@kernel.org>
References: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
 <20260522-dir-deleg-v5-9-542cddfad576@kernel.org>
Subject: Re: [PATCH v5 09/21] nfsd: add data structures for handling CB_NOTIFY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22382-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2133665A719



On Fri, May 22, 2026, at 3:42 PM, Jeff Layton wrote:
> Add the data structures, allocation helpers, and callback operations
> needed for directory delegation CB_NOTIFY support:

> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 9c6e2e7abc82..505fabf8f1bf 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -197,6 +197,44 @@ struct nfs4_cb_fattr {
>  #define NOTIFY4_EVENT_QUEUE_SIZE	3
>  #define NOTIFY4_PAGE_ARRAY_SIZE		1
> 
> +struct nfsd_notify_event {
> +	refcount_t	ne_ref;		// refcount
> +	u32		ne_mask;	// FS_* mask from fsnotify callback
> +	struct dentry	*ne_dentry;	// dentry reference to target
> +	u32		ne_namelen;	// length of ne_name
> +	char		ne_name[];	// name of dentry being changed

Nit: checkpatch doesn't like the C++ comment style.


> +};
> +
> +static inline struct nfsd_notify_event *nfsd_notify_event_get(struct 
> nfsd_notify_event *ne)
> +{
> +	refcount_inc(&ne->ne_ref);
> +	return ne;
> +}
> +
> +static inline void nfsd_notify_event_put(struct nfsd_notify_event *ne)
> +{
> +	if (refcount_dec_and_test(&ne->ne_ref)) {
> +		dput(ne->ne_dentry);
> +		kfree(ne);
> +	}
> +}
> +
> +/*
> + * Represents a directory delegation. The callback is for handling 
> CB_NOTIFYs.
> + * As notifications from fsnotify come in, allocate a new event, take 
> the ncn_lock,
> + * and add it to the ncn_evt queue. The CB_NOTIFY prepare handler will 
> take the
> + * lock, clean out the list and process it.
> + */
> +struct nfsd4_cb_notify {
> +	spinlock_t			ncn_lock;	// protects the evt queue and count
> +	int				ncn_evt_cnt;	// count of events in ncn_evt
> +	int				ncn_nf_cnt;	// count of valid entries in ncn_nf
> +	struct nfsd_notify_event	*ncn_evt[NOTIFY4_EVENT_QUEUE_SIZE]; // list 
> of events
> +	struct page			*ncn_pages[NOTIFY4_PAGE_ARRAY_SIZE]; // for encoding
> +	struct notify4			*ncn_nf;	// array of notify4's to be sent
> +	struct nfsd4_callback		ncn_cb;		// notify4 callback
> +};

Ditto.


-- 
Chuck Lever

