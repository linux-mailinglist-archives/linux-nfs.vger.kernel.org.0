Return-Path: <linux-nfs+bounces-20744-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMQgDKFe1mkhEwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20744-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 15:56:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A189A3BD42C
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 15:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9528D302614C
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 13:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2852D7DC6;
	Wed,  8 Apr 2026 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqjImHZs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E12F3C3E
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775656416; cv=none; b=g71A54+INNhyoaKCr4tzVZLULe4jPDbrBVe8AKU49j8bBkAWqPN9/PeZ7PSsEFOn8fikPeBaHIhg3rnYoSpZO55tc5yH0U1y3qKsKXkq3/YqczZDk036y0WRs21qsYrkRrTdmDMPOiKMVENiyB/F6L7fY6Iu2qplfIvLg/OY54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775656416; c=relaxed/simple;
	bh=rmKHoZShQl5f/YMBpBS98MDWiEkC8VcvLT3seCGstnc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kBc1O9Qg0Gv5zhvJwXJc67MqeFxNYhCQ/oH1uVj0hWaAAOSUESUF9DlSI/cvn89ux3BMDwIDa0+6BGbLVlXbuERpkgv4MigmbfDTlAIEQEcqL0Ftax26S5GMCD2J06HpCXQ1X6yuoPkkMloykKbJ/Y0ex7z1YVtTI3YpPBGFs6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqjImHZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5799AC19421;
	Wed,  8 Apr 2026 13:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775656415;
	bh=rmKHoZShQl5f/YMBpBS98MDWiEkC8VcvLT3seCGstnc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=bqjImHZswMmSmP/EYngjrGTLnSMvinhrYpaIBX5YrK8A5ujliac6HU+zvaq8Pj9mP
	 FY1jnTPreDWaqwQM6WpBmF+g64iEUjnS+I+uJnMH2/OUry51V9yyBHa2zNXKJVQzr8
	 a8T+XqXkS4tdo57oKnpi50+FMnshJTrcgM6DU+xweCAJL0V5lusjvKkdq6GVZZLNWH
	 OQrZdhLbNo4qw2JZaR5KeAEd6ahcJZyKuliIjNaRzFUxnPKslNEtyvNQBv/+t9D9sc
	 zr/XAs7+QUz9MFoI88g9Gef0MJ6kNEgDCIlbj7i0Y7m6nF+076P02pyO+HQsSbkUy+
	 UKPyg64f1a+yA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6ABD6F4006D;
	Wed,  8 Apr 2026 09:53:34 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 08 Apr 2026 09:53:34 -0400
X-ME-Sender: <xms:3l3WaZFZMMM02I0nT_iGGB6jUKjJyIFmHaFBOaB4toPJfd2OsDTy0A>
    <xme:3l3WaZI8SbfnuEmiyWeDyk9bBDJXz9sBw5yi5EI9ZnnnOX4-dN_dTNI1RKnE8dm-2
    WLyjF75hRpAWY9qKis7bxl6nqFP46qCsU9dYrgR04ary0DilgSy1OI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhgssegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtgho
    mhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtph
    htthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhes
    thgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3l3WaTeQifcLJuwsSpf3WZmxUG6_4Ougdep0UIV5tmnyLYJTrxOOMQ>
    <xmx:3l3WaZ4_hzDxVOgxJ0d9EsVFHk27VIli0eUZdC_IBUXoZNizJf7wow>
    <xmx:3l3WaaveGh5aC67szIKOOTD0hBEZdObPlB_K3Ot8axqaH3hlT8Hfdg>
    <xmx:3l3WaZjQb9f0Rd-dDMI1qZHKlVGmjSss-nsRfZYve-vvkodJleBKiA>
    <xmx:3l3WaVq8_r8SAoCeW58xR8L7-4mC00M5p3c1pukjkUALlhcT4SD5GKM4>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2AECA780070; Wed,  8 Apr 2026 09:53:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AcsP-Plei2ic
Date: Wed, 08 Apr 2026 09:53:13 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Olga Kornievskaia" <okorniev@redhat.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, neilb@brown.name,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Message-Id: <9a8cdd25-a3e6-4e4c-bfb3-bd8a7f90b077@app.fastmail.com>
In-Reply-To: <20260407235038.55749-2-okorniev@redhat.com>
References: <20260407235038.55749-1-okorniev@redhat.com>
 <20260407235038.55749-2-okorniev@redhat.com>
Subject: Re: [PATCH 1/3] nfsd: update mtime/ctime on CLONE in presense of delegated
 attributes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20744-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A189A3BD42C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, Apr 7, 2026, at 7:50 PM, Olga Kornievskaia wrote:
> When delegated attributes are given on open the file is opened with NOCMTIME
> and modifying operations do not update mtime/ctime as to not get out-of-sync
> with the client's delegated view. However, for CLONE operation, the server
> should update its view of mtime/ctime and reflect that in any GETATTR queries.
>
> Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding 
> WRITE_ATTRS delegation")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/nfs4proc.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 99b44b6ec056..fb891e35ebe9 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1396,6 +1396,17 @@ nfsd4_verify_copy(struct svc_rqst *rqstp, struct 
> nfsd4_compound_state *cstate,
>  	goto out;
>  }
> 
> +static void nfsd_update_cmtime_attr(struct dentry *dentry)
> +{
> +	struct iattr attr = {
> +		.ia_valid = ATTR_CTIME | ATTR_MTIME,
> +	};
> +
> +	inode_lock(d_inode(dentry));
> +	notify_change(&nop_mnt_idmap, dentry, &attr, NULL);
> +	inode_unlock(d_inode(dentry));
> +}

I think there is an active delegation here. Without ATTR_DELEG,
notify_change() calls try_break_deleg(), which will return
-EWOULDBLOCK, causing the setattr to be silently skipped.
Wouldn't it also initiate a CB_RECALL as well?


> @@ -1413,6 +1424,9 @@ nfsd4_clone(struct svc_rqst *rqstp, struct 
> nfsd4_compound_state *cstate,
>  			dst, clone->cl_dst_pos, clone->cl_count,
>  			EX_ISSYNC(cstate->current_fh.fh_export));
> 
> +	if ((READ_ONCE(dst->nf_file->f_mode) & FMODE_NOCMTIME) != 0)
> +		nfsd_update_cmtime_attr(cstate->current_fh.fh_dentry);
> +
>  	nfsd_file_put(dst);
>  	nfsd_file_put(src);
>  out:

Should this check whether nfsd4_clone_file_range() succeeded before
updating timestamps?  If the clone fails, the file content is not
modified, so a timestamp update would be incorrect.


-- 
Chuck Lever

