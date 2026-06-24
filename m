Return-Path: <linux-nfs+bounces-22821-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eMAODnc+PGqRlggAu9opvQ
	(envelope-from <linux-nfs+bounces-22821-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 22:30:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D1F6C1337
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 22:30:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DKvCvoJJ;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22821-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22821-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1D343020675
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 20:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1545D3876C9;
	Wed, 24 Jun 2026 20:30:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6C62F8EBA
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 20:30:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782333044; cv=none; b=J2N3kYflvjWOa5mF10Bo2qQSu/oOQvm29L7f5N0Amc2h84n0rvqBO6HDNdV5HHUU/ay5kQRe6Ax1kY9hkFWP9c93gv2J4AUeHrE/1Z9iHxcgavqhEfpwPQEKc5LVNDZvfWOnmeHITzTFFkXW4GaI+1G2awHd/XKopNmy2GFnur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782333044; c=relaxed/simple;
	bh=nQpzQLYBLv9t6mS6/0iTEb18eSgueAtMxdV7M1GBG1I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZghtFc1otswn8xWmGs4tFcDIpO54DXPVrIajnDnpPCxYTggFDWJ9JS51DJ7Nn26BC2ugYZKwpRw9KYRJU0UN5HGd7DgcFiCkIAIuA+yQdZXXEpjp1ExUCOdsJHB2dDtKuiQJXZunbhnYmZCYMsM49CIu2gi/Mcf6vKKnEhT2BpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKvCvoJJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A0B1F000E9;
	Wed, 24 Jun 2026 20:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782333042;
	bh=heP5qJ5wzmuw2IZmJUdK5zcZJP1ASJP7NaWR8fDLJzI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=DKvCvoJJuZGHoHlJVLVdJrg8ykFq+Kb9RTmxZhkAu385d5qwg906upE1HyiJFfZ23
	 n7sh9JWhgVY9LQzcqW4SNid3Csqn8tysRZtrEGY4x4WQxN85xuAEbUdp97mpyjAnxI
	 gmeLMuLyyafXmnGLk17FD7XDDDm1tYH3KOWX9PGcOELqvjdm3jOpwLmwOCd5y/JPWs
	 GOE3s4/k9osOoP+tYwGDqZW8PwRnZUIHV4UIjiEqysH2w3BN7qR1Uj318riFjL45JH
	 ntBYKnLqrgzVkT6IT1DCFS0Uongr0S5VLoR1Kn4jOeRJIjoILO3Cq0Xzv2QMzJKIUv
	 zD+Tjad1krOpQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id A2F16F4009B;
	Wed, 24 Jun 2026 16:30:41 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Wed, 24 Jun 2026 16:30:41 -0400
X-ME-Sender: <xms:cT48ao-1UCdRI55g-scF6_uTXpfhQweRwrqR5oQbVQC2WEuD4q_lwg>
    <xme:cT48arib3n1MiLKqjXSHmW15CLzUUQSIT4uL4kSSrLwwptVwS5fflsipEGky65C04
    R2tgWzSQj6nPgTvVGObcjBOWWHhtRBldhydBHg6p_KihpjZqoFF78M>
X-ME-Proxy-Cause: dmFkZTE/iaghgTK5RNJOyIDzpy4Oq6ndHzehsArangesQ5ktd3lRrBwllBXXwktA0LSRaB
    sOnrjHlbnKMraq3Krptt3HO780t8GoDkCfkzOYYmCSVP4zvAwfKFnHUTqECBn30p1c9ScP
    irYja/zeioLvpv75qJ/SRIcyDHQDGrDCEnDK+U/UUojbfXaUAlJfAlcDDa6CcIDfAG6fa+
    nxDUxyoj5z3hRyqnWBVOLME4IzcmAPFoZTV5oB3A9fI+bcw6UgutN7Q3tBf+If/JGIaf6g
    yK4CJ/j+VntYiIEZP3Zm+b6CUSexcZwutxS+bu/OIo3GzlPXWrNiDfKfg2uHYwvduJ+DIb
    7mbY7vu0PMX3/LqzdEoqB1/5W6uCEaHGZZ0ZJbM2tUfAHTyAou+bUz6glBJyO+z7/lc6zp
    7Mz9IpDm5KOA4uKs4LNdFcKkj43nqdMSGAqV9jwLFKNMtfQ+KI19RC9CvcnJqzY60Vhwzn
    7/kDytfX73iZh/EkSR45ohnAj28W/b3R1ZjjcT2Emra5E27SmRikwo7zLYTLW5ENceuasY
    93wOsbszRUz0C+AtyJHXeUszCpMWquVwkDEUBygIwJKpq1xrZLiU/KXVaTPx1hkOlELXze
    S6iwmUUL7vTazs1iG1Dh9gHacsD6Wc+hN1K5fHwpqlGHgFOsFuaqF7NAiFlw
X-ME-Proxy: <xmx:cT48ai7CQigeGebkMDfPD8QRZWs1ZXyw7RoSbspD7cvBJ4TJsTR4Iw>
    <xmx:cT48ajqFFO78aOMCPPzgDqBZDQY1VlGZoG9z2ZSQf82oe4zwABLytA>
    <xmx:cT48akhRSFbA6nBAoi0_fRUIn5hXP2CtuflnC5F-Zs2zu_VabgFLZQ>
    <xmx:cT48atLMwh5GWuBpMC1z6T9ESGYEidLvhzBIvUzUlCWPaJDFa1d78Q>
    <xmx:cT48akDrYHgSUjvSUPTPBp_PRUYL9JxjrL9U-E7BydqHvir4BwhDv3Ty>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8572BB6006E; Wed, 24 Jun 2026 16:30:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWFffJWTuPv-
Date: Wed, 24 Jun 2026 16:30:20 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: "Benjamin Coddington" <ben.coddington@hammerspace.com>,
 "Trond Myklebust" <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Message-Id: <8874c1b4-87e7-45a5-9b95-59ae1a2fdf88@app.fastmail.com>
In-Reply-To: 
 <fd8dbaed67881b7813ab9e77bbacc71a30d6de4b.1782329389.git.bcodding@hammerspace.com>
References: <cover.1782329389.git.bcodding@hammerspace.com>
 <fd8dbaed67881b7813ab9e77bbacc71a30d6de4b.1782329389.git.bcodding@hammerspace.com>
Subject: Re: [PATCH 1/3] pNFS: report clora_changed in the cb_layoutrecall_file
 tracepoint
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22821-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ben.coddington@hammerspace.com,m:trondmy@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,app.fastmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8D1F6C1337

Hi Ben,

On Wed, Jun 24, 2026, at 3:50 PM, Benjamin Coddington wrote:
> A CB_LAYOUTRECALL carries the clora_changed flag (RFC 8881, Section
> 20.3.3), which tells the client whether the server is changing the
> layout (and therefore whether the client should flush modified data to
> the storage devices before returning, or stop writing to them and go
> through the metadata server). The client decodes this into
> cbl_layoutchanged, but it is otherwise invisible.
>
> Give nfs4_cb_layoutrecall_file its own event definition and report
> clora_changed, so the intent of a recall can be observed in a trace.
>
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  fs/nfs/callback_proc.c |  2 +-
>  fs/nfs/nfs4trace.h     | 55 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
> index 4ea9221ded42..021572312b0e 100644
> --- a/fs/nfs/callback_proc.c
> +++ b/fs/nfs/callback_proc.c
> @@ -316,7 +316,7 @@ static u32 initiate_file_draining(struct nfs_client *clp,
>  	nfs_iput_and_deactive(ino);
>  out_noput:
>  	trace_nfs4_cb_layoutrecall_file(clp, &args->cbl_fh, ino,
> -			&args->cbl_stateid, -rv);
> +			&args->cbl_stateid, args->cbl_layoutchanged, -rv);
>  	return rv;
>  }
> 
> diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
> index c939533b9881..18a5708c17fc 100644
> --- a/fs/nfs/nfs4trace.h
> +++ b/fs/nfs/nfs4trace.h
> @@ -1515,7 +1515,60 @@ DECLARE_EVENT_CLASS(nfs4_inode_stateid_callback_event,
>  			), \
>  			TP_ARGS(clp, fhandle, inode, stateid, error))
>  DEFINE_NFS4_INODE_STATEID_CALLBACK_EVENT(nfs4_cb_recall);
> -DEFINE_NFS4_INODE_STATEID_CALLBACK_EVENT(nfs4_cb_layoutrecall_file);
> +
> +TRACE_EVENT(nfs4_cb_layoutrecall_file,
> +		TP_PROTO(
> +			const struct nfs_client *clp,
> +			const struct nfs_fh *fhandle,
> +			const struct inode *inode,
> +			const nfs4_stateid *stateid,
> +			unsigned int changed,
> +			int error
> +		),
> +
> +		TP_ARGS(clp, fhandle, inode, stateid, changed, error),
> +
> +		TP_STRUCT__entry(
> +			__field(unsigned long, error)
> +			__field(dev_t, dev)
> +			__field(u32, fhandle)
> +			__field(u64, fileid)
> +			__string(dstaddr, clp ? clp->cl_hostname : "unknown")
> +			__field(int, stateid_seq)
> +			__field(u32, stateid_hash)
> +			__field(unsigned int, changed)
> +		),
> +
> +		TP_fast_assign(
> +			__entry->error = error < 0 ? -error : 0;
> +			__entry->fhandle = nfs_fhandle_hash(fhandle);
> +			if (!IS_ERR_OR_NULL(inode)) {
> +				__entry->fileid = NFS_FILEID(inode);

Note that Jeff had some patches that went into 7.2 to store the nfs fileid
directly in the inode. The NFS_FILEID() macro has been removed, and you should
use inode->i_ino instead.

Thanks,
Anna

> +				__entry->dev = inode->i_sb->s_dev;
> +			} else {
> +				__entry->fileid = 0;
> +				__entry->dev = 0;
> +			}
> +			__assign_str(dstaddr);
> +			__entry->stateid_seq =
> +				be32_to_cpu(stateid->seqid);
> +			__entry->stateid_hash =
> +				nfs_stateid_hash(stateid);
> +			__entry->changed = changed;
> +		),
> +
> +		TP_printk(
> +			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> +			"stateid=%d:0x%08x dstaddr=%s clora_changed=%u",
> +			-__entry->error,
> +			show_nfs4_status(__entry->error),
> +			MAJOR(__entry->dev), MINOR(__entry->dev),
> +			(unsigned long long)__entry->fileid,
> +			__entry->fhandle,
> +			__entry->stateid_seq, __entry->stateid_hash,
> +			__get_str(dstaddr), __entry->changed
> +		)
> +);
> 
>  #define show_stateid_type(type) \
>  	__print_symbolic(type, \
> -- 
> 2.53.0

