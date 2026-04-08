Return-Path: <linux-nfs+bounces-20770-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAm1I9qj1mlUGwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20770-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 20:52:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBFC3C1CBB
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 20:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4191C31087DC
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 18:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C173D8906;
	Wed,  8 Apr 2026 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lj0YTCG3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24DB3D6CB9;
	Wed,  8 Apr 2026 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673265; cv=none; b=gejEnP6W2ZWbAc8PeDet7o5RYJhp/54gT7KAfOoEFtYirDflgfDVActjX8EvzsaGxLbiIMq5lGmFh+7SXAg2vbecLe1Q2O4Ve5Srq4eB0xQ35/VRyyJFmKsLB7abVQJdxS6kMl423JFjKdxZSh8fqVLP1wBez5eSfWHp7eKahqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673265; c=relaxed/simple;
	bh=I4u6+dMDZjz2zON2p+h0huowpaR5+d4uLStEtJs9Q7w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YzNGy4svHxXW3QTbFLxw4xcQJBzpe5e4xNbd5QIgHNLr0qzyMZit5LNjx5Na5xVOD9bhC6AJqVH1+FGPTOddOVOV9Yb8P88hJn8miwKUifzttxw8RL2Y2t8B2K2z3dkr+YfieIFIeiT4y4EQBNm8bRRDJDha/aeriHG/slYbWVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lj0YTCG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C634AC19421;
	Wed,  8 Apr 2026 18:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775673265;
	bh=I4u6+dMDZjz2zON2p+h0huowpaR5+d4uLStEtJs9Q7w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Lj0YTCG3BYBj0nqHt6ZCjmmgcyo+eWHux5VLPBZW+D9/BrciMPLNRSwD2QexZ1Heu
	 Xf/wfadMVF4FLG88L6ky1Xffe2Qkhl7CSod2Nor8Sd7dQDTnrckwj5NzG+Uupb4wXF
	 o2OQ7QMt5csOcVjzy7H5N9NzYLajyp8e9ay0QZzlOlWC7V+8mzEPz4EWWkOpptG30D
	 6toDSw242lU7/YxvoRgEei/jnErjdVOgOT5XjmSQyd9wtAPg/OPeel03S0rIOIoWAW
	 +yNmCCMIXJUZuLVgWaU7/ml7wQRPTjZAENxg2ZwnkY9D39CisiFFPo089XzaoWqDtr
	 6pFISp9QCCN0g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B204FF4006C;
	Wed,  8 Apr 2026 14:34:23 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 08 Apr 2026 14:34:23 -0400
X-ME-Sender: <xms:r5_WaTWJYu9x3MkegsZsi-na07_hYiwU0ZyfgqBeEh-8FGuf5tk-Yw>
    <xme:r5_WaWbdpMIBCtzX_AhShvS5Ni6y3mnV4vgFmao_HO5P6c_ruVOBM0A4vZDS2g4I5
    rXeXKYtW_1DDjJwaYrAgOaNCoYwscTB5um5rTfyIu1Y-qJ9ES4Tx_c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopedvgedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehmrghthhhivghurd
    guvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdprhgtphhtthhopegrlhgvgidr
    rghrihhnghesghhmrghilhdrtghomhdprhgtphhtthhopegrmhhirhejfehilhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhr
    tghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvg
    hrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:r5_WaeG1Q9v4HiyAccuef0GLt7dki2tAp2Z5rwH4L5Iwlcp6soXJwQ>
    <xmx:r5_WaRAyBY5FdB25G_F2QlE9gw9NGAT_4z24g94kfYWuB5NZt9JKdA>
    <xmx:r5_Wablh7yaztfGf-ocozil_smhj4FrcQcIuuXeRTwwpsJ_R7cgEcw>
    <xmx:r5_WaX7Hs4NJdk_dIo71nDYz1ALuZPUb18AwUSb1XMQqN8mqYdabOA>
    <xmx:r5_WaauBW8nHVi81VUBxfOrjR61gavNV_B1yP0Jo5ojs-JGlGNfQaHr7>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8310A780070; Wed,  8 Apr 2026 14:34:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvVyrhjrLPWN
Date: Wed, 08 Apr 2026 14:34:02 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>,
 NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>
Cc: "Calum Mackay" <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <f60c8d0f-45b6-4d4e-8944-dfd69f2cf9bf@app.fastmail.com>
In-Reply-To: <20260407-dir-deleg-v1-13-aaf68c478abd@kernel.org>
References: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
 <20260407-dir-deleg-v1-13-aaf68c478abd@kernel.org>
Subject: Re: [PATCH 13/24] nfsd: add notification handlers for dir events
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20770-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2DBFC3C1CBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Tue, Apr 7, 2026, at 9:21 AM, Jeff Layton wrote:
> Add the necessary parts to accept a fsnotify callback for directory
> change event and create a CB_NOTIFY request for it. When a dir nfsd_file
> is created set a handle_event callback to handle the notification.
>
> Use that to allocate a nfsd_notify_event object and then hand off a
> reference to each delegation's CB_NOTIFY. If anything fails along the
> way, recall any affected delegations.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b2b8c454fc0f..339c3d0bb575 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c

> @@ -9796,3 +9887,118 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state 
> *cstate,
>  	put_nfs4_file(fp);
>  	return ERR_PTR(status);
>  }
> +
> +static void
> +nfsd4_run_cb_notify(struct nfsd4_cb_notify *ncn)
> +{
> +	struct nfs4_delegation *dp = container_of(ncn, struct 
> nfs4_delegation, dl_cb_notify);
> +
> +	if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &ncn->ncn_cb.cb_flags))
> +		return;
> +
> +	if (!refcount_inc_not_zero(&dp->dl_stid.sc_count))
> +		clear_bit(NFSD4_CALLBACK_RUNNING, &ncn->ncn_cb.cb_flags);
> +	else
> +		nfsd4_run_cb(&ncn->ncn_cb);
> +}
> +
> +static struct nfsd_notify_event *
> +alloc_nfsd_notify_event(u32 mask, const struct qstr *q, struct dentry 
> *dentry)
> +{
> +	struct nfsd_notify_event *ne;
> +
> +	ne = kmalloc(sizeof(*ne) + q->len + 1, GFP_KERNEL);
> +	if (!ne)
> +		return NULL;
> +
> +	memcpy(&ne->ne_name, q->name, q->len);
> +	refcount_set(&ne->ne_ref, 1);
> +	ne->ne_mask = mask;
> +	ne->ne_name[q->len] = '\0';
> +	ne->ne_namelen = q->len;
> +	ne->ne_dentry = dget(dentry);
> +	return ne;
> +}
> +
> +static bool
> +should_notify_deleg(u32 mask, struct file_lease *fl)
> +{
> +	/* Only nfsd leases */
> +	if (fl->fl_lmops != &nfsd_lease_mng_ops)
> +		return false;
> +
> +	/* Skip if this event wasn't ignored by the lease */
> +	if ((mask & FS_DELETE) && !(fl->c.flc_flags & FL_IGN_DIR_DELETE))
> +		return false;
> +	if ((mask & FS_CREATE) && !(fl->c.flc_flags & FL_IGN_DIR_CREATE))
> +		return false;
> +	if ((mask & FS_RENAME) && !(fl->c.flc_flags & FL_IGN_DIR_RENAME))
> +		return false;
> +
> +	return true;
> +}

For a cross-directory rename, vfs_rename calls try_break_deleg(old_dir,
LEASE_BREAK_DIR_DELETE, ...). A delegation with FL_IGN_DIR_DELETE
(subscribed to NOTIFY4_REMOVE_ENTRY) suppresses the lease break, which
is correct.

But fsnotify delivers FS_RENAME on old_dir, not FS_DELETE. In
should_notify_deleg(), the check (mask & FS_RENAME) &&
!(fl->c.flc_flags & FL_IGN_DIR_RENAME) fails, because the delegation
has FL_IGN_DIR_DELETE but not FL_IGN_DIR_RENAME. No notification is
sent.

IIUC, a client subscribed to NOTIFY4_REMOVE_ENTRY for old_dir sees
neither a lease break nor a CB_NOTIFY when a child is renamed out of
the directory. Is that behavior correct?


> +
> +static void
> +nfsd_recall_all_dir_delegs(const struct inode *dir)
> +{
> +	struct file_lock_context *ctx = locks_inode_context(dir);
> +	struct file_lock_core *flc;
> +
> +	spin_lock(&ctx->flc_lock);
> +	list_for_each_entry(flc, &ctx->flc_lease, flc_list) {
> +		struct file_lease *fl = container_of(flc, struct file_lease, c);
> +
> +		if (fl->fl_lmops == &nfsd_lease_mng_ops)
> +			nfsd_break_deleg_cb(fl);
> +	}
> +	spin_unlock(&ctx->flc_lock);
> +}
> +
> +int
> +nfsd_handle_dir_event(u32 mask, const struct inode *dir, const void 
> *data,
> +		      int data_type, const struct qstr *name)
> +{
> +	struct dentry *dentry = fsnotify_data_dentry(data, data_type);
> +	struct file_lock_context *ctx;
> +	struct file_lock_core *flc;
> +	struct nfsd_notify_event *evt;
> +
> +	/* Don't do anything if this is not an expected event */
> +	if (!(mask & (FS_CREATE|FS_DELETE|FS_RENAME)))
> +		return 0;
> +
> +	ctx = locks_inode_context(dir);
> +	if (!ctx || list_empty(&ctx->flc_lease))
> +		return 0;
> +
> +	evt = alloc_nfsd_notify_event(mask, name, dentry);
> +	if (!evt) {
> +		nfsd_recall_all_dir_delegs(dir);
> +		return 0;
> +	}
> +
> +	spin_lock(&ctx->flc_lock);
> +	list_for_each_entry(flc, &ctx->flc_lease, flc_list) {
> +		struct file_lease *fl = container_of(flc, struct file_lease, c);
> +		struct nfs4_delegation *dp = flc->flc_owner;
> +		struct nfsd4_cb_notify *ncn = &dp->dl_cb_notify;
> +
> +		if (!should_notify_deleg(mask, fl))
> +			continue;
> +
> +		spin_lock(&ncn->ncn_lock);
> +		if (ncn->ncn_evt_cnt >= NOTIFY4_EVENT_QUEUE_SIZE) {
> +			/* We're generating notifications too fast. Recall. */
> +			spin_unlock(&ncn->ncn_lock);
> +			nfsd_break_deleg_cb(fl);
> +			continue;
> +		}
> +		ncn->ncn_evt[ncn->ncn_evt_cnt++] = nfsd_notify_event_get(evt);
> +		spin_unlock(&ncn->ncn_lock);
> +
> +		nfsd4_run_cb_notify(ncn);
> +	}
> +	spin_unlock(&ctx->flc_lock);
> +	nfsd_notify_event_put(evt);
> +	return 0;
> +}


-- 
Chuck Lever

