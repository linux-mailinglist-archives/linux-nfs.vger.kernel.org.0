Return-Path: <linux-nfs+bounces-22822-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r6BqDQpAPGq8lggAu9opvQ
	(envelope-from <linux-nfs+bounces-22822-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 22:37:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 154076C1367
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 22:37:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iBXHS151;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22822-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22822-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E626630091FD
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 20:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB951381AE2;
	Wed, 24 Jun 2026 20:37:24 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A087837472F
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 20:37:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782333444; cv=none; b=N+oWQkH3KkufL1rKhkn99pBNJjWRdlsUIlUe+Efypum1fBAvXy5XRdD6BqpOAfevyvhutl9ciFt1Jdxt0XJPLuUSJGHIEM9QiUS9k7UMgr/QX6obMjXDVT7c0atdkdJqTki3Y53WmzMKPH4/csz7WXNQQ7KxCmsRU/8VzGnU96I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782333444; c=relaxed/simple;
	bh=o7/ebTDgZCTUyEV1W8o2nf6uMFjP2eaaI1Ym8+wE+h0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Gb2gkZHbIB7ALP4u8J+kzGJ5vuEfHES6dlQygFUWhNY7U7Q1d3QcrXCA4p34ZtZvF8QV8BueINKH63PXArc4vEmkoSWk22SQzO7HukM1vK8ELkhqf0KyNtokC7wHQR+h8YKnn0xAIa/HEjTGrEJGooBJutFbDWbfiQ9uKERI8cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBXHS151; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7DD1F000E9;
	Wed, 24 Jun 2026 20:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782333443;
	bh=PY9rXad+KMeP0Mdjp6vCGsFBEbMdgfnJb+wh40Xg+FQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=iBXHS151S35iUfHuFgFLwIz+nj5W76sZQy3Gn9D7/fEz5PZZdzuQ21+8BeCdlVNh/
	 X+ZrGy5GrvQSGAVtQNPoIbZ2BgNXIaa6d268PTi2hfKv/Q7FlEbtBok8QbLrPknoXn
	 osC0c3gsWK8MT9pDB6AEE/alq5aAKbW7HevHNUFBqSquH71p6fFUdjJX1yr6XBjlnt
	 GIcNEqH1CwGjzMEYiIE6/EHEHNYtNPOpV5VFEC+Hlw/6kp6pqBuH/B7IbBQsK6aVVW
	 DdALSfiFvdn/Xl7fRE0JsAKc9V8U510PIdzveFyQZwXerxFWRwh1FSm7UEzo+3JPTd
	 xO/35N7BWem6A==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7C946F40083;
	Wed, 24 Jun 2026 16:37:22 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Wed, 24 Jun 2026 16:37:22 -0400
X-ME-Sender: <xms:AkA8ag2oAQuVrx2KqZfGCSkW5dxwhMHFtENCJi75ApA8YeOhGqVZmA>
    <xme:AkA8al4POzoPoF7dSEnZVJKPjm5dQyGzuuTs6QPB3TROu0vVZQxr-Ofdl1-Vd1SKV
    7f0O6hI0fdaETP7fK011MR1BNNOBFFoK8W3sZH4RJ6qZN89IEyM6o0>
X-ME-Proxy-Cause: dmFkZTF79wokI3yKecpCxPXjufSi2VFS17gOXByPBJasDTZMAXwPAxCYucTIjrkcl0xdv7
    rqkD8IkTAtGRbgqzKsaqhxerLJMgHZY+DO7uGA6wTgN/0QjFSG+9udLB4pSUjSLXj/AtBE
    DcG1XrmnBWf61B6yalVeQB7VHbLtC89JmcN8pgaHh52Qi/DO/4OOAwfxFuN+nDp4x7v0ge
    9nTGIdwiR45pq+zEg8WDMKkf5+TdSoNXw6ERqzRK9ox9Lw5BGn/kmwPAqZDs/3of8icIik
    IoNabGZj0WIgIZSJ4+HT59GcOEmfj40Bmbwve2ydWz+1w0yeQS2lbgo4S7Zch52FiAt8iu
    5Ts6FtzctqTE/XLOjMPqdE8XzxSZkj2ZyeNSuj8i4nVIHKmGUItXE2AROtSafJY4IhVNHj
    VzLTjL6SCn5Fg5rYdee1knprzQBCUHx7eRLBHJhMQyfg7mZISY5KpEH7+wdr4r9w8o2kiH
    34/xwNvxEAbZy5juJDPIMGHZlHQfcaU6EG+7QYp6qxbecTrjh8X571kfU8OzODjlvjs7pp
    WMr2nskBgBCZ7A98DZggMYwBSC1YN0LDi4NxNpNq8bYPB9Q5zF7HonN8D8wLHO+S/i82LT
    M6GfVZkYxkjiSe3oZ/fitfIHZV306HL0pJkY6GrxtehQ9Y2OdoWSsjVEarXg
X-ME-Proxy: <xmx:AkA8ajyQdeDZshdT_WVKewzWE5jHCUAjnTmZ8vE-E5-yxGbNhR3WhA>
    <xmx:AkA8ajDVvhl4Xz-J7uJD5eIIalLPk_y8JwzwM_rX__oFvOcCrwSQJw>
    <xmx:AkA8agZha_yp1hGdAvCQClT9vdFI9tqDZqx0XJHTtm2GeHBPnbd25w>
    <xmx:AkA8arg0_aIiehzAfxc0GnFWnI0Au2kTAko52-0RscnWmUv83jdCXA>
    <xmx:AkA8ai7Mn3qCWNZheqNt6eZBVr55MnhmNecyKE8XF3sDEWBmsAx027o5>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5CDEAB6006E; Wed, 24 Jun 2026 16:37:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AgPE9NtUd4Lc
Date: Wed, 24 Jun 2026 16:37:02 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: "Benjamin Coddington" <ben.coddington@hammerspace.com>,
 "Trond Myklebust" <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Message-Id: <71b36f0e-169e-40fc-b1d6-3eb39e87d79b@app.fastmail.com>
In-Reply-To: 
 <4429120164c368c8e0c45e1ec9145b6b8177b7d3.1782329389.git.bcodding@hammerspace.com>
References: <cover.1782329389.git.bcodding@hammerspace.com>
 <4429120164c368c8e0c45e1ec9145b6b8177b7d3.1782329389.git.bcodding@hammerspace.com>
Subject: Re: [PATCH 2/3] pNFS: honor clora_changed when recalling a layout
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22822-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ben.coddington@hammerspace.com,m:trondmy@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,hammerspace.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 154076C1367

Hi Ben,

On Wed, Jun 24, 2026, at 3:50 PM, Benjamin Coddington wrote:
> When the metadata server recalls a layout with clora_changed FALSE, the
> layout is not changing and the client may complete its modified writes to
> the storage devices before returning the layout (RFC 8881, Section
> 20.3.3).  Only when clora_changed is TRUE -- the server is restriping, or
> a storage device has failed -- should the client stop writing to the
> storage devices and redirect through the metadata server.
>
> Since commit b739a5bd9d9f ("NFSv4/flexfiles: Cancel I/O if the layout is
> recalled or revoked") the client cancels in-flight I/O on every recall,
> regardless of clora_changed.  For an unchanged recall this abandons
> writes whose data may already have reached the storage device; such a
> write can then land after the LAYOUTRETURN, which the server sees as a
> write without a layout.
>
> Pass the recall's clora_changed value through
> pnfs_mark_matching_lsegs_return() and only cancel in-flight I/O when the
> layout is actually changing.  When it is not, the existing deferred
> return path waits for the in-flight writes to drain before sending the
> LAYOUTRETURN.  Other callers, which are tearing down or returning the
> layout for their own reasons, continue to cancel as before.
>
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  fs/nfs/callback_proc.c |  3 ++-
>  fs/nfs/pnfs.c          | 21 ++++++++++++---------
>  fs/nfs/pnfs.h          |  2 +-
>  3 files changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
> index 021572312b0e..7725daed2697 100644
> --- a/fs/nfs/callback_proc.c
> +++ b/fs/nfs/callback_proc.c
> @@ -290,7 +290,8 @@ static u32 initiate_file_draining(struct nfs_client 
> *clp,
>  	pnfs_set_layout_stateid(lo, &args->cbl_stateid, NULL, true);
>  	switch (pnfs_mark_matching_lsegs_return(lo, &free_me_list,
>  				&args->cbl_range,
> -				be32_to_cpu(args->cbl_stateid.seqid))) {
> +				be32_to_cpu(args->cbl_stateid.seqid),
> +				args->cbl_layoutchanged)) {
>  	case 0:
>  	case -EBUSY:
>  		/* There are layout segments that need to be returned */
> diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> index 743467e9ba20..614e1b28bec0 100644
> --- a/fs/nfs/pnfs.c
> +++ b/fs/nfs/pnfs.c
> @@ -432,7 +432,8 @@ bool nfs4_layout_refresh_old_stateid(nfs4_stateid 
> *dst,
>  			goto out;
>  		}
>  		/* Try to update the seqid to the most recent */
> -		err = pnfs_mark_matching_lsegs_return(lo, &head, &range, 0);
> +		err = pnfs_mark_matching_lsegs_return(lo, &head, &range, 0,
> +						      true);
>  		if (err != -EBUSY) {
>  			dst->seqid = lo->plh_stateid.seqid;
>  			*dst_range = range;
> @@ -486,7 +487,7 @@ static int pnfs_mark_layout_stateid_return(struct 
> pnfs_layout_hdr *lo,
>  		.length = NFS4_MAX_UINT64,
>  	};
> 
> -	return pnfs_mark_matching_lsegs_return(lo, lseg_list, &range, seq);
> +	return pnfs_mark_matching_lsegs_return(lo, lseg_list, &range, seq, true);
>  }
> 
>  static int
> @@ -524,7 +525,7 @@ pnfs_layout_io_set_failed(struct pnfs_layout_hdr 
> *lo, u32 iomode)
> 
>  	spin_lock(&inode->i_lock);
>  	pnfs_layout_set_fail_bit(lo, pnfs_iomode_to_fail_bit(iomode));
> -	pnfs_mark_matching_lsegs_return(lo, &head, &range, 0);
> +	pnfs_mark_matching_lsegs_return(lo, &head, &range, 0, true);
>  	spin_unlock(&inode->i_lock);
>  	pnfs_free_lseg_list(&head);
>  	dprintk("%s Setting layout IOMODE_%s fail bit\n", __func__,
> @@ -1461,7 +1462,7 @@ _pnfs_return_layout(struct inode *ino)
>  	}
>  	valid_layout = pnfs_layout_is_valid(lo);
>  	pnfs_clear_layoutcommit(ino, &tmp_list);
> -	pnfs_mark_matching_lsegs_return(lo, &tmp_list, &range, 0);
> +	pnfs_mark_matching_lsegs_return(lo, &tmp_list, &range, 0, true);
> 
>  	if (NFS_SERVER(ino)->pnfs_curr_ld->return_range)
>  		NFS_SERVER(ino)->pnfs_curr_ld->return_range(lo, &range);
> @@ -2621,7 +2622,7 @@ pnfs_layout_process(struct nfs4_layoutget *lgp)
>  			.iomode = IOMODE_ANY,
>  			.length = NFS4_MAX_UINT64,
>  		};
> -		pnfs_mark_matching_lsegs_return(lo, &free_me, &range, 0);
> +		pnfs_mark_matching_lsegs_return(lo, &free_me, &range, 0, true);
>  		goto out_forget;
>  	} else {
>  		/* We have a completely new layout */
> @@ -2666,7 +2667,7 @@ int
>  pnfs_mark_matching_lsegs_return(struct pnfs_layout_hdr *lo,
>  				struct list_head *tmp_list,
>  				const struct pnfs_layout_range *return_range,
> -				u32 seq)
> +				u32 seq, bool cancel_io)

Can you also add a description for the new "cancel_io" parameter to the
documentation right above this function?

Thanks,
Anna

>  {
>  	struct pnfs_layout_segment *lseg, *next;
>  	struct nfs_server *server = NFS_SERVER(lo->plh_inode);
> @@ -2692,7 +2693,8 @@ pnfs_mark_matching_lsegs_return(struct 
> pnfs_layout_hdr *lo,
>  				continue;
>  			remaining++;
>  			set_bit(NFS_LSEG_LAYOUTRETURN, &lseg->pls_flags);
> -			pnfs_lseg_cancel_io(server, lseg);
> +			if (cancel_io)
> +				pnfs_lseg_cancel_io(server, lseg);
>  		}
> 
>  	if (remaining) {
> @@ -2727,7 +2729,8 @@ pnfs_mark_layout_for_return(struct inode *inode,
>  	 * segments at hand when sending layoutreturn. See pnfs_put_lseg()
>  	 * for how it works.
>  	 */
> -	if (pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs, range, 
> 0) != -EBUSY) {
> +	if (pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs, range, 
> 0,
> +					    true) != -EBUSY) {
>  		const struct cred *cred;
>  		nfs4_stateid stateid;
>  		enum pnfs_iomode iomode;
> @@ -2842,7 +2845,7 @@ static int 
> pnfs_layout_return_unused_byserver(struct nfs_server *server,
>  		pnfs_get_layout_hdr(lo);
>  		pnfs_set_plh_return_info(lo, range->iomode, 0);
>  		if (pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs,
> -						    range, 0) != 0 ||
> +						    range, 0, true) != 0 ||
>  		    !pnfs_prepare_layoutreturn(lo, &stateid, &cred, &iomode)) {
>  			spin_unlock(&inode->i_lock);
>  			rcu_read_unlock();
> diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
> index eb39859c216c..673c2b244978 100644
> --- a/fs/nfs/pnfs.h
> +++ b/fs/nfs/pnfs.h
> @@ -300,7 +300,7 @@ int pnfs_mark_matching_lsegs_invalid(struct 
> pnfs_layout_hdr *lo,
>  int pnfs_mark_matching_lsegs_return(struct pnfs_layout_hdr *lo,
>  				struct list_head *tmp_list,
>  				const struct pnfs_layout_range *recall_range,
> -				u32 seq);
> +				u32 seq, bool cancel_io);
>  int pnfs_mark_layout_stateid_invalid(struct pnfs_layout_hdr *lo,
>  		struct list_head *lseg_list);
>  bool pnfs_roc(struct inode *ino, struct nfs4_layoutreturn_args *args,
> -- 
> 2.53.0

