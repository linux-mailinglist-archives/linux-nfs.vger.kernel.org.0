Return-Path: <linux-nfs+bounces-22378-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jSx4ILf/JmqypQIAu9opvQ
	(envelope-from <linux-nfs+bounces-22378-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 19:45:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFACF6595D4
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 19:45:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RgXNoqsD;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22378-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22378-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 457963144503
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2026 16:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C3533F8D6;
	Mon,  8 Jun 2026 16:38:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4570B1F30BB
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jun 2026 16:38:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936703; cv=none; b=dCTpY4B3Lb376nVPWAxCWRm9uO/Sh+46ba24msceFQvR4xOH4ltbz0+vAUlXKWWFyEvIswjLdnOVFIc3HDspnyoVY1zKUgL2aFLnm9/9kFp2vjgsopmBWdGf+/A6S6i/SISHKR7bZg6UV8yhWQZqNUr1axuPV4ywcSR0Qus1j8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936703; c=relaxed/simple;
	bh=68Ua5aftnpYw2s8iYVKoh7zjJ4nuubOeKwnXwWp1V5c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IWKn/aQCU7ZNtdpI7Zy+IuMZj57G2nspi9ALlHF02ILr92anAgJqZIK4NIcMV2ETKRB9FryUA3dY1LGSBa+rh4l/EJpu9Ptlzuz4QvKqDCp8zVmcANxLrUuE77pkxvlcolskk41hoLvC7oeEuiNan4d36oc0vDNSG/c7ohvlW2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgXNoqsD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17281F00898;
	Mon,  8 Jun 2026 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780936702;
	bh=GSwgGeH6TxyeEQgR3LUoyNcVVTWqxDnyDpwJCBs9GSo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=RgXNoqsDZAtpIA4icpjS0oJELnQg34N4B/nJXP6OdCttL+yeoqgYPWs99FItzgmyc
	 QddSnlC36pQxRmNn9u6ZynhxPyZ8AyJMb8grvHc9uJIxs2T2fJZ4EsTnAPcKpLw6xQ
	 N6kzkftVRsQxXzY3lbk8qUdUbMTonjkwobASD9cXqmKhQj/jLGTILNwzTssWJl598D
	 Tut+jKuSfPM9DB8kUMUiHbnsFb4kNkaIjtBxgaXNMOeu8Nh01HenqRZzZwoyZzOOmY
	 W/Pr1pU1uizN20CqveN+W+Otju74eE6DzL4Uq6lu30B7A7Rt5w7V9waSaxnG8qZcFj
	 SKnlFbWx3szEQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0F618F4006F;
	Mon,  8 Jun 2026 12:38:20 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 08 Jun 2026 12:38:21 -0400
X-ME-Sender: <xms:_O8majsnqYLmFg0Zk9nLOj1XaRLMYGSh0IUsrfzf1VXLaZ1YzT_EKQ>
    <xme:_O8mavSJN8sQW0bPV2OXITjvXgH8EaKrnJROa9imMb5KXvx3CpGHevotp5vV90Zr2
    B-QWrcsmzcXHA4siH6y7ucWAiTlsCCFHMliDCkisuQmc3BTW6sXKEQ>
X-ME-Proxy-Cause: dmFkZTE51jedbWaf8ybRMjvuCqwLbr2xgNrSotfCRimdFLaYAsCd2Nn7d9sdyam+UKClkJ
    raE5lxHeKJg4fNcvLkH4IkN2WDNp29VKEo3Rezc3MmBVNjBhYQk7OpzulBbE01nbBYMBZK
    6SCJu1yMM9nPIfl15ANdNQfseLpAFQRUzp5+RQc1+mg9vlpfBABgn9mcoPmQJV5h/iFUi4
    2UvaO2amPNwVzFIwP24C9tiNUcn1sWLgGmNI9lC7dOO+ypyvn5Yj8OpuhkNHBsM3YdbwOj
    nj+7/NXT75khoDtvSagwgEHcBRRHdUXyMs2DHZg/LWYu4++x41WS0wf5UGjG5FdXZ+ptD5
    j8rHqS3Ld8qAOT4wJ6ferK2DBAKMzJwZK59n15VbzVR75iS0kAOSrmdMii9PqrJSDGM4IC
    jjWzDU90eYGxEEGCiU2oy4IN416N75ddVZudp6kGPKbNekmsIw3xGZqR+GKj8+gtGIIoHM
    ipR2SYh3465WKJh71xXm/pNRKtm4IGZtrlKZOGpdbua/bkpVySUVXVQrvEorUVMuwRvX+j
    ZQkICYUpqtLqw2zbeZuhiIUsHerxFfnJluElLkPjthnNo9wc8tosZVmF8aYB3BQ/5rJtKD
    cskFmP0m8B+yJ9612cg+iTYjbuqC174Xrbqb8JrIZvK3BXFSm6tGCa++7Otw
X-ME-Proxy: <xmx:_O8malXmybksvd78ajqRgz5x8FHGFQeZQtD91w72m5jCs8rozp3VXA>
    <xmx:_O8masoGn0wjuTllXSWdxnQSnACBvut8rxZ1RfVL6VbCI7175eey_w>
    <xmx:_O8mapGB0fc7CurPa96kT34-OrVkIXcPfFOTwQCRDEDFx68R-RZ3aQ>
    <xmx:_O8mauskV7hJ_P_b-K49u4O1DUPoNchhGS60c_Ea5JDFAlQNVvpFNw>
    <xmx:_O8masTnoxmN5yE1PyWG46rQOuqpAIpqmO5VpqVCLmLs7i70j6Lpsy1_>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C1EA4780077; Mon,  8 Jun 2026 12:38:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AK594_Pyz8Yk
Date: Mon, 08 Jun 2026 12:38:00 -0400
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
Message-Id: <e0e995e9-8272-44f6-b2e0-9e61ed0eef3b@app.fastmail.com>
In-Reply-To: <20260522-dir-deleg-v5-5-542cddfad576@kernel.org>
References: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
 <20260522-dir-deleg-v5-5-542cddfad576@kernel.org>
Subject: Re: [PATCH v5 05/21] nfsd: update the fsnotify mark when setting or removing a
 dir delegation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22378-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,app.fastmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.cz:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFACF6595D4



On Fri, May 22, 2026, at 3:42 PM, Jeff Layton wrote:
> Add a new helper function that will update the mask on the nfsd_file's
> fsnotify_mark to be a union of all current directory delegations on an
> inode. Call that when directory delegations are added or removed.

This commit message repeats what the diff below says. Can it instead
explain why this change is necessary?


> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 2a34ba457b74..efbc99f0a965 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1246,6 +1246,38 @@ static void 
> nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct f
>  	nfsd_update_cmtime_attr(f, ATTR_ATIME);
>  }
> 
> +static void nfsd_fsnotify_recalc_mask(struct nfsd_file *nf)

Since nfsd_fsnotify_recalc_mask() takes a single struct nfsd_file
as an argument, should this function reside in fs/nfsd/filecache.c
instead? The question might reflect my misunderstanding of the
new function's purpose.


> +{
> +	struct inode *inode = file_inode(nf->nf_file);
> +	u32 lease_mask, set = 0, clear = 0;
> +	struct fsnotify_mark *mark;
> +
> +	/* This is only needed when adding or removing dir delegs */
> +	if (!S_ISDIR(inode->i_mode) || !nf->nf_mark)
> +		return;
> +
> +	/* Set up notifications for any ignored delegation events */
> +	lease_mask = inode_lease_ignore_mask(inode);
> +	mark = &nf->nf_mark->nfm_mark;
> +
> +	if (lease_mask & FL_IGN_DIR_CREATE)
> +		set |= FS_CREATE | FS_MOVED_TO;
> +	else
> +		clear |= FS_CREATE | FS_MOVED_TO;
> +
> +	if (lease_mask & FL_IGN_DIR_DELETE)
> +		set |= FS_DELETE | FS_MOVED_FROM;
> +	else
> +		clear |= FS_DELETE | FS_MOVED_FROM;
> +
> +	if (lease_mask & FL_IGN_DIR_RENAME)
> +		set |= FS_RENAME;
> +	else
> +		clear |= FS_RENAME;
> +
> +	fsnotify_modify_mark_mask(mark, set, clear);
> +}
> +
>  static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
>  {
>  	struct nfs4_file *fp = dp->dl_stid.sc_file;
> @@ -1255,6 +1287,7 @@ static void nfs4_unlock_deleg_lease(struct 
> nfs4_delegation *dp)
> 
>  	nfsd4_finalize_deleg_timestamps(dp, nf->nf_file);
>  	kernel_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
> +	nfsd_fsnotify_recalc_mask(nf);
>  	put_deleg_file(fp);
>  }
> 

I added the following edit to this patch>

@@ -9597,8 +9629,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
  * @nf: nfsd_file opened on the directory
  *
  * Given a GET_DIR_DELEGATION request @gdd, attempt to acquire a delegation
- * on the directory to which @nf refers. Note that this does not set up any
- * sort of async notifications for the delegation.
+ * on the directory to which @nf refers.
  */
 struct nfs4_delegation *
 nfsd_get_dir_deleg

The patch makes the above kerneldoc note ("does not set up any sort of async
notifications") logically obsolete.


> @@ -9682,6 +9715,7 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
> 
>  	if (!status) {
>  		put_nfs4_file(fp);
> +		nfsd_fsnotify_recalc_mask(nf);
>  		return dp;
>  	}
> 
>
> -- 
> 2.54.0

-- 
Chuck Lever

