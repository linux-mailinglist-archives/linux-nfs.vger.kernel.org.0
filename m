Return-Path: <linux-nfs+bounces-22531-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JKhYG+VNLGpwPAQAu9opvQ
	(envelope-from <linux-nfs+bounces-22531-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 20:20:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E70567B9F0
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 20:20:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VyTQO9M9;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22531-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22531-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B8B530494A7
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF7D396D1B;
	Fri, 12 Jun 2026 18:13:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C973932F4;
	Fri, 12 Jun 2026 18:13:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288015; cv=none; b=e7oMqL+O/+xg44oGNRAXLZdJ6sW6SXt4KMVZ55pKIp1HRn8ePOpXQGIYiP72uvmM/48oRz1L4v1gVNoDhCpWWuUMnBBiP0BNtChjFjfGeOb3we4Zjl19FMg4Ra2D3JxFMG+hZ5uApVAh3ndNmNOe6axDb81y5oqR4eyB5WEkKZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288015; c=relaxed/simple;
	bh=6HS+7EANeU0a/eliioo0haT4yj3auG54Dz5W4PkwUGo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NRZCWLl59jcoRqpRY2uipp6shGXhv4g8nNmfbNID1B8ztcZdCtt4N6GMGWvTSoAtgqVFCn2qxM73VlZ8dgDXrgdd3DvJaxTtdQ+eF/KYqmIxtTql600wJFRz65DGpXK4ytl28NMQU2KmQ5Ffr4SWB5gP1rIcYRi+DD/UzdKbYZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyTQO9M9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3607A1F00A3A;
	Fri, 12 Jun 2026 18:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781288014;
	bh=sLjsq1T3MX0IJn78wfDnVKzMzRWYjtJ3O4g0CyXp3bo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=VyTQO9M9kQi96pPAaSSFp6+iE2TJ/wcmdxNLupeFfWXBCIqhgxaSrgbSCL4v+rTEh
	 HfWw5thQJ5dA+AQdnpa8Lo5OUrMKIaC/UBDMvXM/dxaAflIEAIJjzeio2TRCruWBFC
	 KpatJH9FoM7dP0SQ0Af1e/74dl8tnTbRu9tpfTa0ZFPQuKfhvAlywuT6+VM9OKXLEx
	 wSkuizr2y+unWHN3DG9pmRRNHxYjk5V3lckLzi+KeJxUM7dxaMIwPvsQfullmPd1ow
	 bjDIuzE2/htluNmqtIn3JIc2gKK/ZRKre1OF1vWwRJFVWbN97mJG/9WdI1oA4cEEnr
	 lK6ZPU368PEpw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6CAF2F40077;
	Fri, 12 Jun 2026 14:13:33 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 12 Jun 2026 14:13:33 -0400
X-ME-Sender: <xms:TUwsapXlkFGzzfY6lEaaMT_LsRL-iZ-9l0fTqx9LoH-6SA2cYEb-5Q>
    <xme:TUwsakZy4J_AhqGRI35d8Yw4zaYevBGtAjdtUzXbxhkoFYvLdgpJGiE1w-i6NWuy2
    USsu15Vglo3EZ0WhsXZFczBqnSxE8iljUHOr4Ec1uhgkd0bV9806QwH>
X-ME-Proxy-Cause: dmFkZTF4J7sICs8xauyVV5LkjQqlaYA/u3rBeL3u9pdsp43DLSQUjIzfJTc5impUjq1pau
    mjYW9w1ajScS196LkNOiqsU71AnPyQFsM37wgc/Ad9+AVxPzEzlCvTWr7aAOwe8Qso/Kcj
    xsrQ6eV+Rf4C1/iKVl4vO4fW/myPvzVGwiZgKIuSzvDdGgZrfJmOAc/NEVQRVCFo9WlLtu
    BRR/VZqG8ve+7qvYq+RnAtv5cQA6kHswObv1CzJPwtgDB5GJTll9bDjmaKtLJFq077N16Z
    lQsfsslFC38bXA5xygpVgDziVa32xqf7wvS2PS6CQWQRidPvye2V7M/gq6jPvfQfKH/vfC
    ZJ2HvoQ+0mtUCSvV/yRnY+KJtq9eGu0yvuCbDA4bFyTe8/y15WTteKuzWOmmoAsWtoFM6u
    UuaWvxDGMxBqz2TnaBmBaNfCS7T3xwSTSS+E+yUvx6FtjK+fkuvFGX6lXmx2a+PZSbeIcq
    TPro/3AJFYPWrLai3DBMZsu9SEILUXDM7gdbALZg3SSSlRxSzlbi+unXLULxPJfTDA+jBe
    9WT9FOtiWC+/He6imKWqpzxVOmvYLRsEc/GDEeyTf3mDtdgGIxwW6GQGRN+FPrUKwGQ81D
    Kcgdi6Zhs8JAdSCMHUZknMskxgZctJs2wQYpwtKXWiM+PBw6NCPTYkDr/sng
X-ME-Proxy: <xmx:TUwsajNmSw2UIiv8cCjUhSujuyO0fqMuU1TbyfyFo7vkavojyseLrQ>
    <xmx:TUwsai0twlTEU3XkybD8OOsIYJppoy9j6FKiHiP_HL4h13AJ61QWoQ>
    <xmx:TUwsaq3yC2reB29YkiXFkITdK2cdVLir0oyrfCZYfaZ-d6c3sv8_MA>
    <xmx:TUwsao8QnXwtwjhvMrnEn0vaezmgIiLBvL3TfRVHcC1PE6qaD2Y3rg>
    <xmx:TUwsauZtqHo5XpXdyePAZapzGRSsNRM1wA6byr0th10tMpPzKHHQs3kn>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 42111780075; Fri, 12 Jun 2026 14:13:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Atlt45BGkTU7
Date: Fri, 12 Jun 2026 14:13:12 -0400
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
Message-Id: <8dc1a997-0152-4a28-a58a-0cb131d89779@app.fastmail.com>
In-Reply-To: <20260611-dir-deleg-v6-19-4c45080e5f3f@kernel.org>
References: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
 <20260611-dir-deleg-v6-19-4c45080e5f3f@kernel.org>
Subject: Re: [PATCH v6 19/20] nfsd: track requested dir attributes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.65 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22531-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,app.fastmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E70567B9F0



On Thu, Jun 11, 2026, at 1:50 PM, Jeff Layton wrote:
> Track the union of requested and supported dir attributes in the
> delegation. In a later patch this will be used to ensure that we
> only encode the attributes in that union when sending
> add/remove/rename updates.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c  |  9 ++++++---
>  fs/nfsd/nfs4state.c | 20 ++++++++++++++++----
>  fs/nfsd/state.h     |  2 ++
>  3 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index caec82e77081..9e86f5907f06 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2530,9 +2530,10 @@ nfsd4_verify(struct svc_rqst *rqstp, struct 
> nfsd4_compound_state *cstate,
>  	return status == nfserr_same ? nfs_ok : status;
>  }
> 
> -#define SUPPORTED_NOTIFY_MASK	(BIT(NOTIFY4_REMOVE_ENTRY) |	\
> -				 BIT(NOTIFY4_ADD_ENTRY) |	\
> -				 BIT(NOTIFY4_RENAME_ENTRY) |	\
> +#define SUPPORTED_NOTIFY_MASK	(BIT(NOTIFY4_CHANGE_DIR_ATTRS) |	\
> +				 BIT(NOTIFY4_REMOVE_ENTRY) |		\
> +				 BIT(NOTIFY4_ADD_ENTRY) |		\
> +				 BIT(NOTIFY4_RENAME_ENTRY) |		\
>  				 BIT(NOTIFY4_GFLAG_EXTEND))
> 
>  static __be32
> @@ -2579,6 +2580,8 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
>  	memcpy(&gdd->gddr_stateid, &dd->dl_stid.sc_stateid, 
> sizeof(gdd->gddr_stateid));
>  	gdd->gddr_child_attributes[0] = dd->dl_child_attrs[0];
>  	gdd->gddr_child_attributes[1] = dd->dl_child_attrs[1];
> +	gdd->gddr_dir_attributes[0] = dd->dl_dir_attrs[0];
> +	gdd->gddr_dir_attributes[1] = dd->dl_dir_attrs[1];
>  	nfs4_put_stid(&dd->dl_stid);
>  	return nfs_ok;
>  }
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 0e6e008c121e..12627afb604f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -9945,6 +9945,15 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst 
> *rqstp, struct dentry *dentry,
>  				 FATTR4_WORD1_TIME_MODIFY |	\
>  				 FATTR4_WORD1_TIME_CREATE)
> 
> +#define GDD_WORD0_DIR_ATTRS	(FATTR4_WORD0_CHANGE |		\
> +				 FATTR4_WORD0_SIZE)
> +
> +#define GDD_WORD1_DIR_ATTRS	(FATTR4_WORD1_NUMLINKS |	\
> +				 FATTR4_WORD1_SPACE_USED |	\
> +				 FATTR4_WORD1_TIME_ACCESS |	\
> +				 FATTR4_WORD1_TIME_METADATA |	\
> +				 FATTR4_WORD1_TIME_MODIFY)
> +
>  /**
>   * nfsd_get_dir_deleg - attempt to get a directory delegation
>   * @cstate: compound state
> @@ -10013,14 +10022,17 @@ nfsd_get_dir_deleg(struct 
> nfsd4_compound_state *cstate,
>  		dp->dl_stid.sc_export =
>  			exp_get(cstate->current_fh.fh_export);
> 
> -	dp->dl_child_attrs[0] = gdd->gdda_child_attributes[0] & GDD_WORD0_CHILD_ATTRS;
> -	dp->dl_child_attrs[1] = gdd->gdda_child_attributes[1] & GDD_WORD1_CHILD_ATTRS;
> -
>  	/*
>  	 * NB: gddr_notification[0] represents the notifications that
>  	 * will be granted to the client
>  	 */
> -	fl = nfs4_alloc_init_lease(dp, gdd->gddr_notification[0]);
> +	dp->dl_notify_mask = gdd->gddr_notification[0];
> +	dp->dl_child_attrs[0] = gdd->gdda_child_attributes[0] & GDD_WORD0_CHILD_ATTRS;
> +	dp->dl_child_attrs[1] = gdd->gdda_child_attributes[1] & GDD_WORD1_CHILD_ATTRS;
> +	dp->dl_dir_attrs[0] = gdd->gdda_dir_attributes[0] & GDD_WORD0_DIR_ATTRS;
> +	dp->dl_dir_attrs[1] = gdd->gdda_dir_attributes[1] & GDD_WORD1_DIR_ATTRS;
> +
> +	fl = nfs4_alloc_init_lease(dp, dp->dl_notify_mask);
>  	if (!fl)
>  		goto out_put_stid;
> 
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 0763893bfd48..17be4011740d 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -299,7 +299,9 @@ struct nfs4_delegation {
>  	struct timespec64	dl_ctime;
> 
>  	/* For dir delegations */
> +	uint32_t		dl_notify_mask;
>  	uint32_t		dl_child_attrs[2];
> +	uint32_t		dl_dir_attrs[2];

Nit: Maybe these should be u32. uint32_t is a user space type.


>  };
> 
>  static inline bool deleg_is_read(u32 dl_type)
>

Bisectability: After this patch is applied, a client that requests
NOTIFY4_CHANGE_DIR_ATTRS now gets that bit echoed in gddr_notification,
but the callback path still only maps/encodes add, remove, and rename
notifications (nfsd_notify_to_ignore(), nfsd_fsnotify_recalc_mask(),
and nfsd4_encode_notify_event() have no dir-attr case). That lets the
server grant a directory delegation while promising dir-attribute
CB_NOTIFYs it cannot send until the follow-up support lands, so this
bit should not be advertised in this patch.


-- 
Chuck Lever

