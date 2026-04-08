Return-Path: <linux-nfs+bounces-20746-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIEKDDlf1mkfEwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20746-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 15:59:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 866873BD4A3
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 15:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E83DE3008759
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 13:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7199F2F39B4;
	Wed,  8 Apr 2026 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9xkdrbi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF891A4F3C
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775656472; cv=none; b=Z8N3yLm38sgb4SBeIsqjpksb4X8UKUqwSDs3HGudgIKIzY3vw7LLqU3omhTv9Tr8OCp98hAgZAD/h84k6RtvW4dHsIrx5H0wh5rubImR6nnXTkJWBofh/iZ2Yu3DhuclTZgPbL5l8tjseksYRfx81tbI3UsqY+txyl/vRwP6//k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775656472; c=relaxed/simple;
	bh=4Mq+p6as9shLvQdyE6E6hhkkneZ032yWKSdsk4LE3mU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ICbT0DEnRmyAJkDzv2AP/zn6uC9C4cJErVJQbazlwsuTkWR7kTL5RbPjvlw4Tod0wFsPP2vbv/ooZ4urV5OyuzJx6c0/FczBIP1F7zJdAvo+TLBIFLHZsxzkJzzm5PgWCPnkMC9Qu7f6BsS/1nRmeQaFya8WpePFSzmyYDI8LBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9xkdrbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9F1C19421;
	Wed,  8 Apr 2026 13:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775656471;
	bh=4Mq+p6as9shLvQdyE6E6hhkkneZ032yWKSdsk4LE3mU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=M9xkdrbiXfMPm0bU4FG9cNMB/k/98yEAArI9CcNSurqB227LNB6BNRYMLXKj5xvvH
	 AgAKdc/6PXqaulE1+ZLegS/ppus2h+0uXD8hyIROGMT2c/gjWxpYUYROkuvdRqOSNW
	 FiuxD6lQP2vYFrgkIt3f5DjKcijiBkdt0C12Y9BLdEsiJSsC/wlQcblqfh3tZLTGSh
	 rm1wrj1MP9ge7LUyzqHcASZMrtXRZOFm/gjCdztJcltJVdUxwTAjFD2sMtqRL1ible
	 lG3bBqibTeRUKeOcNjmsmgj9FmzGH8O7yEXhJ685lag4+hN4SEXJXr7OSf1Ynrszb+
	 w+0rDjY9VxDTw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id AE13AF4006D;
	Wed,  8 Apr 2026 09:54:30 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 08 Apr 2026 09:54:30 -0400
X-ME-Sender: <xms:Fl7WadlXlPKUHyLKTphb-tO2DdvimlswcbeTGe9vvTebOT7pNz4gug>
    <xme:Fl7WaToxsZV4DdZtkgYBAT22dZE7kMkS6e1irKTJjRHvyz8KfhPtkOaCz4N4XH59r
    PTGk9w5hZ8i4SLOnzCgyVRnuqZuBR2KCFXzfZd5zxmY217gc1Q8Tlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhgssegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtgho
    mhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtph
    htthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhes
    thgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Fl7WaT95rnohktibFbITc4-NDgXO95XIRFcwNbeBIuLXr3X83nBVIQ>
    <xmx:Fl7WaQao-_Ouvyj_QBiIhLxt-qzLSk3zVuJFJXcu9XOUTpQwEQ3Khw>
    <xmx:Fl7WafPCWFxWBUCbN12iZzMpVdM0Kx8oAOrk7up5BxOU55JlY5bT2g>
    <xmx:Fl7WaUCzQtWgV--KfFmFGlNKR20wIQgJ1e6zn-ePDrFLy-g1LDlfdw>
    <xmx:Fl7WaeItTO30KT423gfqjyzXpzoM3Td2KNMUxegU9vJR8_ZB33fj5Tli>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8E93B780070; Wed,  8 Apr 2026 09:54:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2ZwlfHVDfig
Date: Wed, 08 Apr 2026 09:54:10 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Olga Kornievskaia" <okorniev@redhat.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, neilb@brown.name,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Message-Id: <c79b8e38-cc5c-436f-8145-2213dc1256c0@app.fastmail.com>
In-Reply-To: <20260407235038.55749-3-okorniev@redhat.com>
References: <20260407235038.55749-1-okorniev@redhat.com>
 <20260407235038.55749-3-okorniev@redhat.com>
Subject: Re: [PATCH 2/3] nfsd: update mtime/ctime on synchronous COPY with delegated
 attributes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20746-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 866873BD4A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Tue, Apr 7, 2026, at 7:50 PM, Olga Kornievskaia wrote:
> COPY should update destination file's mtime/ctime upon completion.
>
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>

Should 2/3 also carry a Fixes: tag?


> ---
>  fs/nfsd/nfs4proc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index fb891e35ebe9..04d8d0d1ca7d 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2211,6 +2211,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct 
> nfsd4_compound_state *cstate,
>  	} else {
>  		status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
>  				       copy->nf_dst->nf_file, true);
> +		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
> +			       FMODE_NOCMTIME) != 0)
> +			nfsd_update_cmtime_attr(cstate->current_fh.fh_dentry);
>  	}
>  out:
>  	trace_nfsd_copy_done(copy, status);
> -- 
> 2.52.0

-- 
Chuck Lever

