Return-Path: <linux-nfs+bounces-22528-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j0S3OpZLLGroOwQAu9opvQ
	(envelope-from <linux-nfs+bounces-22528-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 20:10:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 638EB67B8D3
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 20:10:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=M70YIS7V;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22528-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22528-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4D5631661BA
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 18:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BD037BE72;
	Fri, 12 Jun 2026 18:06:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59F636AB4B;
	Fri, 12 Jun 2026 18:06:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287609; cv=none; b=qt3gy/97U6nRIkg2+XzJxe6LgKvz2LAGWtEx9edxFxJc9R2JxemTlOY52TUM/H2pDYXsGANX4szfWhsTc0YevJI1XH9T+5FJEHTf3e0vISCXbPbvN/dNkyG/jZh6ht7UqmmZkrzcXb+/Bmf5ZTY5gsd3pzn2ZSDBmh8QXDduZJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287609; c=relaxed/simple;
	bh=FQmoC/THZFYDinoISuSgMGxtC4zsYy3pSr7P1Tttr7M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=urzQT1y04coo6k9UzTZWAKwDyXm8W+cwVScr827n78Cbu/1Lwo8sdk2crsrKgJTumCDdItiqVvN2I6LEH9QJlX/vPd/v/G2Cq4F83aEMJ80ZyKw5A7sQiohLAWdZNXImIZ0nESHlgQXMqCXtoYgej7ywtzjRhjJQD7oS6VBXZp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M70YIS7V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194E51F00A3A;
	Fri, 12 Jun 2026 18:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781287607;
	bh=rmY1XRorY8tm5XzOd9JYKm0uRq7CNXbvzLRe3jdbwDg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=M70YIS7VJLEA2qltrMAK6gS5r16XEa6J89SNWFScureuKzVBwW+xAFVcufGQsWEoR
	 UH4lUVHP7kuJ/qb+15euCKAWktJYL47xvA0Ec26fDdlUxf+gZwcwP4hKq6iwgVAYDj
	 mbPH25KaOTmgpfJViJF+CrHX2sBnrkdNWgG0SQ/8t6SZ1X6Xn+pBwpicijMnbMpqjt
	 Kh7jIikUkWaRknb/lOqPDVNKv9zgRVJu6L1wQTPAFoefPwUibscNSmHesGdZv9LgHv
	 G/PWDsIzcgORzwvatSnze5Wuc3W4z7fO+TkGVDeysq6/etN6xZKZRqDRy1ACmEWaRf
	 wUrNadjDXwj9A==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4F23CF4007F;
	Fri, 12 Jun 2026 14:06:46 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 12 Jun 2026 14:06:46 -0400
X-ME-Sender: <xms:tkosaj6gSC-O3u79246MTJURyyIYFZRU6WsCSf_XlMoj_SqrFNWbYw>
    <xme:tkosajvCmrqtinfxXQv2YfmxpNAvTYltiq6BFYoCh9f2vZ24amKwG6ScId2McoGhP
    OviEFvI9EBIfHaXz-KRCz6-ExwTRcM29lE5RA6D_baS_wWlqkeWrcg>
X-ME-Proxy-Cause: dmFkZTGuG3AeyMng7EVTxNkDhwUN31636ADY31p/mQRJyX7o4zQekp8lH6WwjTx6lDnD+Z
    MTqLXMQnpZPmVLmnk4AdaHwpfT7LtZGmY5W3+f982Fe+z/7EQ8/5yRXiEzf8MCC0e+q1i5
    K8+aoFiKyIlnhk6ps34RLwmyopZmJuXaUH3gnyqrrtWnJTSRyyv+yZX35eZoYsFu4b6Q7F
    85MEHNo2v/w1VvHKPGIVPH9xgMOAsPi97JL44NTpYsLe0QG6azo/OKZzVfcaGla0kMy/Ia
    TfpY6z7maAU/nNyC71NfiHdvCkxOB9TK9rMuIMgxDpLg+LzkIh6l8s26eJHt31JfFNTNPZ
    1r2IZZRFTH8vKNk7rcDAqDFSyJRRXCNTDr3fvxdm5otCWTavIfuJw6CkbmzwpsvcZWLpfr
    gE/FD++SPZ9McuWpPyf+bvS83g4C94bxuTdhOu266V+muxKjt63z0XEJnf3hpFyDcJAWhX
    wK4XYADOJ+Y6DjKh1FKG0IflMAsKjjcBYkaCUAVr8g1NanSLkolwTtIWLhVRST0yq/JxZu
    gcye2PYG4wBh5XEkY8rkCVjWbJTcnwrM+yeu6/o1L/+ZpldlUfMU1bPFItriWxzfN/YyaK
    YCje6jUMNwTdg8IIqMl8iLeLaKuJ/+FNsfDsxFRaOJtb+r5mmJ45fG6S2C7g
X-ME-Proxy: <xmx:tkosanReRxK15jxEayC-y3bbcNemtYhuEuN9NflfQP6i6P1RtGCi9Q>
    <xmx:tkosatpGAQ_8M271MY5C_LhHWF6h3NEmBbTML8VbQlwPgf3VOTSqNQ>
    <xmx:tkosalZPdxlDog9OKLtWgrIKqs_V_dRYf3u1ix0f0z6BVdGEeWRTtg>
    <xmx:tkosaoRaX5yQjJL2nCh9aK59uP8ZiQQhGlOuzG3GMaH-fbWy6sFWsA>
    <xmx:tkosajcJsDKWk2pa6AYwbx8wB-YyxFKumoQEblIponfYRta-F_34Qgmv>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 29E53780070; Fri, 12 Jun 2026 14:06:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AUcBOYW56SA3
Date: Fri, 12 Jun 2026 14:06:24 -0400
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
Message-Id: <dfa17ce6-5ecb-46c5-b5ca-fe1149605a17@app.fastmail.com>
In-Reply-To: <20260611-dir-deleg-v6-16-4c45080e5f3f@kernel.org>
References: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
 <20260611-dir-deleg-v6-16-4c45080e5f3f@kernel.org>
Subject: Re: [PATCH v6 16/20] nfsd: add a fi_connectable flag to struct nfs4_file
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.65 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22528-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 638EB67B8D3



On Thu, Jun 11, 2026, at 1:50 PM, Jeff Layton wrote:
> When encoding a filehandle for a CB_NOTIFY, there is no svc_export
> available, but the server needs to know whether to encode a connectable
> filehandle. Add a flag to the nfs4_file that tells whether the
> svc_export under which a directory delegation was acquired has subtree
> checking enabled, in which case it needs connectable filehandles.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 1 +
>  fs/nfsd/state.h     | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 513cbc1a583f..aa99783ce901 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5231,6 +5231,7 @@ static void nfsd4_file_init(const struct svc_fh 
> *fh, struct nfs4_file *fp)
>  	memset(fp->fi_access, 0, sizeof(fp->fi_access));
>  	fp->fi_aliased = false;
>  	fp->fi_inode = d_inode(fh->fh_dentry);
> +	fp->fi_connectable = !(fh->fh_export->ex_flags & 
> NFSEXP_NOSUBTREECHECK);
>  #ifdef CONFIG_NFSD_PNFS
>  	INIT_LIST_HEAD(&fp->fi_lo_states);
>  	atomic_set(&fp->fi_lo_recalls, 0);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index f8457e0f2b57..d912e3d04dd7 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -761,6 +761,7 @@ struct nfs4_file {
>  	int			fi_delegees;
>  	struct knfsd_fh		fi_fhandle;
>  	bool			fi_had_conflict;
> +	bool			fi_connectable;
>  #ifdef CONFIG_NFSD_PNFS
>  	struct list_head	fi_lo_states;
>  	atomic_t		fi_lo_recalls;
>

When two clients use exports of the same directory root that
differ only in subtree_check/no_subtree_check, the root filehandle
is the same and nfsd4_file_hash_insert() can reuse the same
nfs4_file. This makes fi_connectable depend on whichever export
first initialized the shared object, so a later directory
delegation acquired under the other export can encode CB_NOTIFY
child filehandles with the wrong connectability.

Therefore, the delegation's sc_export is the per-export state to
derive connectability from, and the export is already available
via dp->dl_stid.sc_export.


-- 
Chuck Lever

