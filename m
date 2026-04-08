Return-Path: <linux-nfs+bounces-20752-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLzcKXdh1mmDEwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20752-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 16:08:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DD93BD6BC
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 16:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10D983058B8E
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 14:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7AC2F3C10;
	Wed,  8 Apr 2026 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4qc0Qgy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD17A27FD6D
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775657136; cv=none; b=jFdxbaUN1p7521u4WhKGzUAriGpQgocF42/VbDodgqvVWbLeAd306xOR0qZF9M7lcElkEdSIMquLoSLzXO03bNxZ/SZgr+8fapfQy7zpYbSoJ4OHCQ3PgSdUspJWu4hztUd59btk/jX7yn6RxZRZqpfLU42lzcBp4hRQF7/LvKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775657136; c=relaxed/simple;
	bh=H4+DfwWrB2Fe9/yA54MxbiZ+xRm5gUywDx/Dahx0Lac=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IlVzYqLloQf5p5w58nRa3J1IF9INDpIp2tf/Zi4pcDycAJGge6h/XhJRhGq/HydX2isOKPl7sWAojOLBWZuQiTW4X53AXO8R7IelNo5aLWz3w42jZrnEQjanvSyXHX5P1mFd6yd3PAzAwcaVA9yV0+o4IB40mufIJb1BKdnvjas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4qc0Qgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA4EC19424;
	Wed,  8 Apr 2026 14:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775657136;
	bh=H4+DfwWrB2Fe9/yA54MxbiZ+xRm5gUywDx/Dahx0Lac=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=c4qc0QgyqLafIyvXxAnhH/r5pVH3FSEBXsEjhnGlOEWk1oURN8D0zQ69MAXbE4nkk
	 1cEV+GF3sbIvD6OY+x82Pnhf92l1VxG7gxSG0Thkazt6t2y1MUZplwTSIE8/OY7LSG
	 rw5S2Q5+6r/e3aiwMjTTB2z/QZZ0IyTjYMiXki0Eaw6xS4qFr4w0HlVhzUg2/Z/nkk
	 V49cjoArTXlYiVM/U2grcDHo9LJbar/Qs2BYYhJ1WXETH8dlCq+cGLXnfpgC+2NfBj
	 VoWrZb8Qq0Yx21Rjsx8GSDOeLIecrDuN+owJiAXvtrfcTOd+zN8wQ41itVnxxkNvA5
	 IiaFy5JwwG0fw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 92DC3F4006B;
	Wed,  8 Apr 2026 10:05:35 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 08 Apr 2026 10:05:35 -0400
X-ME-Sender: <xms:r2DWaT7zh1wUnmnp681NmeR04GnCASI8nlUuMy45EhcjSiQkhOeNMg>
    <xme:r2DWaTsZI2dzQIRlTy5I6XfjtKkTUxGSfTEJycS2V3ZDj8DjDA9sJSy12Vlj9-V_O
    nMSQHIVOqcKYh0ytNa-U9wCD3dwrxaaKrhv-eCeml9ZPC7Gizmakqk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffteduheevtdeuveelkeeiheekffduueehvdefuedtudffiefggefhjeejiedtnecu
    ffhomhgrihhnpegtohgprhgvfhgvrhhrihhnghgpshgvshhsihhonhhiugdruggrthgrne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgt
    khhlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelle
    elheelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgr
    ihhlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehnvghilhgssegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhn
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtg
    homhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgt
    phhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomh
    esthgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:r2DWaZweCMt8pFxrsH8_c1uo-hFJYZV2BTxPncz44imdheMV57W5NQ>
    <xmx:r2DWaZ-edMxGQmUvhPlqwJ2TwxNFrvxMQV5lWNVUC-hzmRopYzY59g>
    <xmx:r2DWaRg4czizjas01U5Vz_dv9DAHZ7cl_cUMNaeZLwI5Ax6gwqQjDw>
    <xmx:r2DWaQHS4WVgDUSspKGnDlB74s_lvAkkjjSeTqQwO-HHlaoWWpNqMg>
    <xmx:r2DWaQ-smS4YuvSTYX1XFFiAmnPykX1RufhX8suPu7-H-zVTQgXwejF5>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6DD5D780075; Wed,  8 Apr 2026 10:05:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AivWeyeosOBN
Date: Wed, 08 Apr 2026 10:05:15 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Olga Kornievskaia" <okorniev@redhat.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, neilb@brown.name,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Message-Id: <937c9434-07b1-408a-95e1-a5db7962c504@app.fastmail.com>
In-Reply-To: <20260407235038.55749-4-okorniev@redhat.com>
References: <20260407235038.55749-1-okorniev@redhat.com>
 <20260407235038.55749-4-okorniev@redhat.com>
Subject: Re: [PATCH 3/3] nfsd: update mtime/ctime on asynchronous COPY with delegated
 attributes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20752-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 23DD93BD6BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Tue, Apr 7, 2026, at 7:50 PM, Olga Kornievskaia wrote:
> Asynchronous COPY should update destination file's mtime/ctime upon
> completion of copy work (not COPY compound processing).
>
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/nfs4proc.c | 21 ++++++++++++++++++++-
>  fs/nfsd/xdr4.h     |  1 +
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 04d8d0d1ca7d..d858a5b58a24 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c

> @@ -2134,6 +2134,16 @@ static int nfsd4_do_async_copy(void *data)
>  	nfsd4_send_cb_offload(copy);
>  	atomic_dec(&copy->cp_nn->pending_async_copies);
> +	/* choosing to check for existence of set dentry pointer to indicate
> +	 * that we need to update the attributes and do a dput because the
> +	 * file flag could be cleared by a DELEGRETURN and then we'd lose
> +	 * that copy was started with file opened with NOCMTIME and we gotten
> +	 * a reference on the dentry.
> +	 */

Nit: "we gotten" might instead be "we had gotten" or "we got".
And let's stick with "/*" on a separate line to introduce
comment blocks in NFSD.


> +	if (copy->d_dst) {
> +		nfsd_update_cmtime_attr(copy->d_dst);
> +		dput(copy->d_dst);
> +	}

Jeff earlier suggested that the timestamp update should happen
before sending CB_OFFLOAD, so that a client issuing GETATTR in
response to the callback sees the updated timestamps. Should
nfsd_update_cmtime_attr be moved above nfsd4_send_cb_offload?


> @@ -2193,6 +2203,11 @@ nfsd4_copy(struct svc_rqst *rqstp, struct 
> nfsd4_compound_state *cstate,
>  		memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
>  			sizeof(result->cb_stateid));
>  		dup_copy_fields(copy, async_copy);
> +		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
> +			       FMODE_NOCMTIME) != 0) {
> +			async_copy->d_dst = cstate->current_fh.fh_dentry;
> +			dget(cstate->current_fh.fh_dentry);
> +		}
>  		memcpy(async_copy->cp_cb_offload.co_referring_sessionid.data,
>  		       cstate->session->se_sessionid.data,
>  		       NFS4_MAX_SESSIONID_LEN);

The error path checks FMODE_NOCMTIME to decide whether to dput,
but three gotos reach out_dec_async_copy_err before the dget:

nfsd4_copy() {
    ...
    if (atomic_inc_return(...) > sp_nrthreads)
        goto out_dec_async_copy_err;    /* before dget */
    async_copy->cp_src = kmalloc_obj(...);
    if (!async_copy->cp_src)
        goto out_dec_async_copy_err;    /* before dget */
    if (!nfs4_init_copy_state(nn, copy))
        goto out_dec_async_copy_err;    /* before dget */
    ...
    dget(cstate->current_fh.fh_dentry); /* dget is here */
    ...
    if (IS_ERR(async_copy->copy_task))
        goto out_dec_async_copy_err;    /* after dget */
}

If FMODE_NOCMTIME happens to be set when one of the early gotos
fires, this calls dput without a matching dget, resulting in a
dentry refcount underflow.

Additionally, the comment in nfsd4_do_async_copy explains that
FMODE_NOCMTIME can be cleared by a concurrent DELEGRETURN, which
is why the thread checks copy->d_dst instead. The same reasoning
applies here: a concurrent DELEGRETURN between the dget and a
kthread_create failure would cause the error path to skip the
dput, leaking the dentry reference.

Would it be simpler to check async_copy->d_dst here instead of
re-reading FMODE_NOCMTIME? That field is NULL before the dget
and non-NULL after, which handles both cases correctly:

    if (async_copy->d_dst)
        dput(async_copy->d_dst);


-- 
Chuck Lever

