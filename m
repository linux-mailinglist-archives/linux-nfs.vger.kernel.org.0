Return-Path: <linux-nfs+bounces-22073-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JCdJEK4GWpByggAu9opvQ
	(envelope-from <linux-nfs+bounces-22073-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 18:01:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1285760539C
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 18:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3307C329FC3F
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 15:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351CC3469F6;
	Fri, 29 May 2026 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYUPZlpI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ACE1632DD
	for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067644; cv=none; b=BFl8i+cBwD7U+LWqhLkVvbltorxKoQKnjo8r6kSUt9gfCzQCSNEQ1u2KG5OwEP7O0petRIMJnUGJlobUGlXGntWy8IJ0ITfbsck8hxz81bOzKE6+liLJXvBT75HjrLwbxTKf1QZ7SqFlo94skxSFRNcJpjNH/KC8U1Gak+MoX4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067644; c=relaxed/simple;
	bh=xm3uzLzTHIsWlWGVZMC/Zn5GOJss95FZWF9qcJkjaTU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Lhu4iZGu89FF6Vrf29FsG8BfmLbyZG9YVC4bKGGmDAdJsA2+hLgeLWayd1nxCtW9Cyny4aw8GSz2txVcCZ3yqRL9+ks1rnp8MqPALlSyxBlU4Hq/32547LSKao50TmdmDlnGw56br0iDaPpAIXIFFAfAb5k3cjMGgaKtLqZEqEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYUPZlpI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85211F00899;
	Fri, 29 May 2026 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780067642;
	bh=rmbInpTHoxWcyeN2jF2ydLe+bj6fIz3X6ZMFNZ36dhc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=hYUPZlpI6M6sTo92OGFpWGckeGTzxyHUKlRMk2Mca4GMvyTGWor9kJieL+AZ1M2f3
	 +lRXQF5Wo1PFBR7T3P/Ez8G5Rm+NxHjjma6hB6zJ5YmCVfFIVzia0HsmiALxQfjy24
	 TfldRPH3A0CnGHfjtODsZjVmP5tGpVJik8meum6qUhr7C+nKBvHtvYLLroiqDxyg2o
	 GQ215Q+qqxUIVvIZGUN4NJtXBVYRAizSf7cQrlABI5+jVDuDG1Upx3VlcF2tIwvSEw
	 zQ1fJN2FXmOvq5Z/P/MnKMwEW18nYukv0dj/IiNG7q/llwv6d0pn0Klgf2h7JQcXzG
	 gMCJZNgkfi9TA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D62DFF40069;
	Fri, 29 May 2026 11:14:00 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 29 May 2026 11:14:00 -0400
X-ME-Sender: <xms:OK0Zai_Sn02pFDdu-wH58O-DEnrXOyfWw6o86QSfC0SgaZxhrDGBXw>
    <xme:OK0ZatiLxQR_V03-Wvbi0UeUTO33IT_O5nFVZE_6kmuFySaNUISZ26zcCU_hssuIQ
    MjuAsibSIWS9nVcPprkoJb6yJmnHjE06fNJhqhar8HKglVS8OtCu_gU>
X-ME-Proxy-Cause: dmFkZTGIhbG8ytRH55ulyof1/yvjyVF1ypclBuxBUZsiY3ZfghhWlx2E0j6B81EakZ4tHr
    bInhlt4fUpo7lqab5vCQ0wJE12pnaInpJSAjlsz9XEjWltVvleZPgYhaTShmTlGRHVNEDa
    UgxTcl/W3mHl/Xi+cuIF43dPQQtHISdDex+sVQYQbova0wirb5wdm1qg76VGdWoo204zhO
    ExV3cmZgfqtOJid5iCCpEn+xlTcgYqfBI+D51h0yybSGzD+TEHCNW/tYFelHFLOLV8g0yR
    de/qvxH8qsHUwRt65pkWEj4iTf/1iC1WO+tmnHii+Kd5dWgOR5zn436ghgKnuJwevRsHFB
    6jUbB/6Dcqw7dCdwYlBd/TY8H1N6mIPY4KAXeD+qcgVGEGPQUZO+hlO7O0BI5XvfUBu9Fz
    PnkSzT9foABG/GQGCO3q0ZTSKOrN13eJrMUAXJtu+vlZcMBwwU8MTC/I3clC9slr3tyynP
    Zu/gs/o+wwy78KuxbROLu0h/25ZPvsnB4ZmprmojpAtaE72fJBSOI2/o0HHjFwj2yf4840
    DupcCdgoifNo7Lrey1DN9z1DwbxYMILUhIpVoqtEOsQXYEsWVMVHBNAVeukCY6aDHVeryV
    k/sbou3/R5Q87yVXwHowEKij1J8lIHH3x49yD8xjf2ReBjJuDBGwlsm0XRAw
X-ME-Proxy: <xmx:OK0Zam73tceBnINR68qQ6RWxYuW5NBpOP5TYmo8H_xmFG8cr6P07FQ>
    <xmx:OK0ZavVRlh2RUhsKYjIX1vl0uKp0jWo36OnaJKsognsoci90kRMb9g>
    <xmx:OK0ZamgIqj7khYqsc9aY0h3w-Nzo30UMRlPkcAGqhGODFhfE4KGOsA>
    <xmx:OK0Zand3fZXXbaYTJhWi0Ur_V5aR5LernVB7v1XhcfpOGwIabPt7sQ>
    <xmx:OK0Zat03WBSADPfJe5-IOW26iYY7OX73Et3qZAOzJdGgIWZUpcDAVRoG>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ABA547800B3; Fri, 29 May 2026 11:14:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AOq5sQ_Qug2N
Date: Fri, 29 May 2026 11:13:40 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
 "Scott Mayhew" <smayhew@redhat.com>,
 "Trond Myklebust" <Trond.Myklebust@netapp.com>,
 "Andreas Gruenbacher" <agruen@suse.de>, "Mike Snitzer" <snitzer@kernel.org>,
 "Rick Macklem" <rmacklem@uoguelph.ca>
Cc: "Chris Mason" <clm@meta.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <fc8740de-d9bd-4686-a30e-e0a6c1b7f351@app.fastmail.com>
In-Reply-To: <20260528-nfsd-fixes-v1-2-e78708eff77d@kernel.org>
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
 <20260528-nfsd-fixes-v1-2-e78708eff77d@kernel.org>
Subject: Re: [PATCH 02/10] nfsd: drain callbacks and clear cl_cb_session
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22073-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1285760539C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Thu, May 28, 2026, at 5:55 PM, Jeff Layton wrote:
> From: Chris Mason <clm@meta.com>
>
> After a DESTROY_SESSION the per-session teardown path can free a
> session while rpciod still holds an inflight callback rpc_task that
> dereferences clp->cl_cb_session.  nfsd4_probe_callback_sync() flushes
> cl_callback_wq, but once nfsd4_run_cb_work() has called
> rpc_call_async() the rpc_task lives on rpciod; flushing the workqueue
> does not wait for it.  After the flush returns,
> nfsd4_destroy_session() proceeds through nfsd4_put_session_locked()
> and free_session() kfree()s the slab while rpciod's
> nfsd4_cb_sequence_done(), grab_slot(), and nfsd41_cb_release_slot()
> are still dereferencing cb->cb_clp->cl_cb_session.
>
>     destroy path                       rpciod
>     ------------                       ------
>     unhash_session(ses)
>     nfsd4_probe_callback_sync(clp)
>       flush_workqueue(cl_callback_wq)
>       /* returns; rpc_task still live */
>     nfsd4_put_session_locked(ses)
>     free_session(ses) -> kfree(ses)
>                                        nfsd4_cb_sequence_done()
>                                          reads cb_clp->cl_cb_session
>                                          /* freed slab */
>
> A second window exists in nfsd4_process_cb_update().  When
> __nfsd4_find_backchannel() returns NULL because unhash_session() has
> already removed the destroyed session from cl_sessions,
> setup_callback_client() takes the v4.1 early return
>
>     if (!conn->cb_xprt || !ses)
>             return -EINVAL;
>
> so clp->cl_cb_session = ses never fires and the field retains a
> pointer to the about-to-be-freed session.  Symmetrically, if a later
> probe finds a different session's backchannel conn and that
> setup_callback_client() call fails, the error tail must still scrub
> any previously published cl_cb_session.
>
> Fix by mirroring the two-stage drain that nfsd4_shutdown_callback()
> already performs: call nfsd41_cb_inflight_wait_complete() in
> nfsd4_probe_callback_sync() after flush_workqueue() so rpciod-side
> nfsd41_cb_inflight_end() decrements are observed before the caller
> releases the final session reference.  The two direct callers,
> nfsd4_destroy_session() and nfsd4_init_conn() (itself invoked from
> nfsd4_create_session() and nfsd4_bind_conn_to_session()), run in
> sleepable process context and tolerate the wait_var_event() sleep:
>
>     nfsd4_destroy_session() (fs/nfsd/nfs4state.c):
>       unhash_session(ses);
>       spin_unlock(&nn->client_lock);   /* spinlock dropped */
>       nfsd4_probe_callback_sync(ses->se_client);
>
>     nfsd4_init_conn() (fs/nfsd/nfs4state.c):
>       acquires no locks in its body; calls nfsd4_hash_conn(),
>       nfsd4_register_conn(), then nfsd4_probe_callback_sync() --
>       entirely in sleepable process context.
>
> Also clear clp->cl_cb_session unconditionally on the
> nfsd4_process_cb_update() error return so every
> setup_callback_client() failure -- whether c is NULL or points at a
> different session whose probe failed -- leaves the field NULL rather
> than pointing at a session that may subsequently be freed.
>
> Fixes: dcbeaa68dbbd ("nfsd4: allow backchannel recovery")
> Assisted-by: kres:claude-opus-4-7
> Signed-off-by: Chris Mason <clm@meta.com>
> ---
>  fs/nfsd/nfs4callback.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 1964a213f80e..1cf6b6100357 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1205,9 +1205,8 @@ static int setup_callback_client(struct 
> nfs4_client *clp, struct nfs4_cb_conn *c
>  	} else {
>  		if (!conn->cb_xprt || !ses)
>  			return -EINVAL;
> -		clp->cl_cb_session = ses;
>  		args.bc_xprt = conn->cb_xprt;
> -		args.prognumber = clp->cl_cb_session->se_cb_prog;
> +		args.prognumber = ses->se_cb_prog;
>  		args.protocol = conn->cb_xprt->xpt_class->xcl_ident |
>  				XPRT_TRANSPORT_BC;
>  		args.authflavor = ses->se_cb_sec.flavor;
> @@ -1225,8 +1224,10 @@ static int setup_callback_client(struct 
> nfs4_client *clp, struct nfs4_cb_conn *c
>  		return -ENOMEM;
>  	}
> 
> -	if (clp->cl_minorversion != 0)
> +	if (clp->cl_minorversion != 0) {
>  		clp->cl_cb_conn.cb_xprt = conn->cb_xprt;
> +		clp->cl_cb_session = ses;
> +	}
>  	clp->cl_cb_client = client;
>  	clp->cl_cb_cred = cred;
>  	rcu_read_lock();
> @@ -1299,6 +1300,7 @@ void nfsd4_probe_callback_sync(struct nfs4_client *clp)
>  {
>  	nfsd4_probe_callback(clp);
>  	flush_workqueue(clp->cl_callback_wq);
> +	nfsd41_cb_inflight_wait_complete(clp);
>  }
> 
>  void nfsd4_change_callback(struct nfs4_client *clp, struct 
> nfs4_cb_conn *conn)
> @@ -1679,7 +1681,17 @@ static struct nfsd4_conn * 
> __nfsd4_find_backchannel(struct nfs4_client *clp)
>   * Note there isn't a lot of locking in this code; instead we depend on
>   * the fact that it is run from clp->cl_callback_wq, which won't run 
> two
>   * work items at once.  So, for example, clp->cl_callback_wq handles 
> all
> - * access of cl_cb_client and all calls to rpc_create or 
> rpc_shutdown_client.
> + * access of cl_cb_client and cl_cb_session, and all calls to 
> rpc_create
> + * or rpc_shutdown_client.
> + *
> + * rpciod-side readers of cl_cb_session (encode_cb_sequence4args(),
> + * nfsd4_cb_sequence_done(), the cb-slot helpers, and the cb_sequence
> + * tracepoints) run outside cl_callback_wq.  The
> + * nfsd41_cb_inflight_wait_complete() drain in 
> nfsd4_probe_callback_sync()
> + * waits until cl_cb_inflight reaches zero before the caller proceeds 
> with
> + * session teardown; any rpc_task that reads cl_cb_session must hold an
> + * inflight pin (via nfsd41_cb_inflight_begin) for this fence to be
> + * effective.
>   */
>  static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
>  {
> @@ -1731,6 +1743,7 @@ static void nfsd4_process_cb_update(struct 
> nfsd4_callback *cb)
>  		nfsd4_mark_cb_down(clp);
>  		if (c)
>  			svc_xprt_put(c->cn_xprt);
> +		clp->cl_cb_session = NULL;
>  		return;
>  	}
>  }
>
> -- 
> 2.54.0

Several NFSD callback done handlers retry indefinitely on
NFS4ERR_DELAY via rpc_delay(), so a client that keeps
replying DELAY leaves this per-client counter nonzero and
blocks the foreground CREATE/BIND/DESTROY_SESSION request
even though the callback no longer references the session
being torn down.

Although partly due to the way callbacks are structured
currently, this patch potentially introduces a client-
controlled DoS vector.


-- 
Chuck Lever

