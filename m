Return-Path: <linux-nfs+bounces-22027-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMpyDtdFF2qS/QcAu9opvQ
	(envelope-from <linux-nfs+bounces-22027-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 21:28:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 847DA5E97D6
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 21:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA73A3005D3B
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 19:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0A2376466;
	Wed, 27 May 2026 19:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbLQ9aBa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9572375ADC
	for <linux-nfs@vger.kernel.org>; Wed, 27 May 2026 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909971; cv=none; b=sgkTIQa1XhT2HT20E9vG0ScwCZzeGH43nncWc6sJu1E+K9Bkk1mfEb5GXu7+Eq0AsObmZQCZ6ash68cjVU1qpq/biqxHa/NZAuJ2aqRgoxdtRXFTDrqY3gsevcdXrzAVtelzirJF+Ii7znCHHK2tjdIEH1HLb1ZmMy9h6xK4ESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909971; c=relaxed/simple;
	bh=WDZS5UnGrEJUj/7Ht+Vz3YuTTMhk2Ro1qZmxxwiXh2s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WqKsYpNSWSRo5IjhFFgeeMCEO6WaXHJ+b7NpxeH95D6GVpua7CP9Ime3nTQ+DJj8AgXOiGxyM/oJOL+zOKV9iTUAqZJTpJjFe6+14hVxw5dp2N9Oz1SbtB4jjBxzi/IqLY+KBvpJHMslaQk3zjb2ujviTMtEKnRpr3pV7g/rSNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbLQ9aBa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5FC1F000E9;
	Wed, 27 May 2026 19:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779909970;
	bh=GStlpz81fuwKJk85n1vttEJF92yIM0G7XJlH4OpYs8U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=KbLQ9aBa+6E75zrUe5d8qo+nlgvdYdIhmB97JstAWYQNAKSf0o3H1IkHM5WZQA1bn
	 w/R64YfspOzo6uiUBes5Bz3WjtxBQpMxnEX0WnEJoVz12b8BLdrV9hgRFoI0UtZtv3
	 rkECc/ub4nDkElHogGnsGa6ifL8KKR7SxHfJKwYrBovSelGDlvbVc0fjZeFFhpJMCm
	 faATLspdKkkVfM8DHMkMXnWSNkwcOSq7wDiCjQ6KrL01uxc9rEYig0uSty4n9MxaKO
	 dVka/T5QxE8u2LNWisGrbhf+C9bL9xowTspnrvp1lLkLM2uKvHHRp5wdNutbQes5h4
	 AbKX5BscZJQGQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 61336F4008A;
	Wed, 27 May 2026 15:26:09 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 27 May 2026 15:26:09 -0400
X-ME-Sender: <xms:UUUXao9k3krEnjXW4osYt5FFNWF0BwkutakMGIQVvkfbJ-MZmZ4Z3Q>
    <xme:UUUXargebECtqfWvc1MJBNe635c7xt_YOr612HVhOjme7r9THhLiDgWuSBFSLCqW8
    Clfyvip2TvTNfI3ojNXtCW3mkFvwCWDM2bIe0pFQBkjUzrCBTXdnZU>
X-ME-Proxy-Cause: dmFkZTFt4jWhzBb1wXizu/jGNsi+uCMPn0mAJIyRpePRQviw8pC/s4hvYTK+ABslYQ/WSj
    HdehJhmTgN5lriK9sLnJQkFXi7DZK114exnwxa65GNPYEEcwVpHY99Pe8M/fp8/aKe1NOI
    C0jQhM93M0mBlgvJ/Jq/aU3yfmEiqT2Okl5UF09NrLCN5nGE8CaWhcHjfLLSnxpLnxBEj/
    tjckir0DOMBycnDJ9q+9Rl0CnCHTL8rZPP3Id0sT6VjcwiKyoaZdU1MBGfw+TRYdCyYVzQ
    ntVgVgJhQamo0LIww/BrWKz58IjV6Ni/ak/xG/8qxX0RV5sIiqAJHBxJ1QiZi+NM9iVLHf
    XmGfytjlohIZGfKcYg6GnvHmFomCrH4u/latWVQ0/H25glFemVbYnrvYuhlZ9bRBageQeJ
    lJvpmoJkJUXc1DQ/zofsjMcpYGSRAHZ7E+g25enERSuSSYc6bVx2OMtKAYvmGn2nSB/0TD
    Kk3ZZziajN22uRAn+QF419DUWfUYYdURAo9USTEPs45z8FXZK6tWFotvEOHEW5fFHB4vHR
    pITN4SNTzo0XYVwf9y1Qr1iVsATUDgelA9zjIf0v5PJiVZXK6D2EpRdJ5N0CjZkhrWvApI
    oI+KmGn7NDV0kx1mzazUK35Kfq7AOi+1bvEtMnTMVGSWzlSMf8/II3SHapDw
X-ME-Proxy: <xmx:UUUXarNnz2RRcVbZZjBtlRBPZ6eYHAdmSIkB-PVrc8AR9dKHmHLkxQ>
    <xmx:UUUXamavHygnIUUv1jUqRRUEtwMNzmnUkqHMr-qyk6U-i4K-HFfncQ>
    <xmx:UUUXaq9OInx_yNMUorI0glX2KNfl2R82oZmhHZdBrv-pB0MOyZDZpg>
    <xmx:UUUXanShbHB-WsS7Jp3M9uVJ7UqVoHljBPex0L5kMN9_otNdGpE29Q>
    <xmx:UUUXakcv5VlKDZr2WDzfR1IOLJM5b2_WOCsBDnhOzyu5uHwDh4CAk2jb>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3B4C2780070; Wed, 27 May 2026 15:26:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARr5XTyvjWRZ
Date: Wed, 27 May 2026 15:25:39 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Sasha Levin" <sashal@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <e73a448b-5117-4dc6-b05d-7c9e95fa0734@app.fastmail.com>
In-Reply-To: <20260527-pnfs-fixes-v1-1-784f39dc1eca@kernel.org>
References: <20260527-pnfs-fixes-v1-1-784f39dc1eca@kernel.org>
Subject: Re: [PATCH] nfsd: fix XDR padding calculation in ff_encode_getdeviceinfo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22027-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 847DA5E97D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Wed, May 27, 2026, at 2:30 PM, Jeff Layton wrote:
> nfsd4_ff_encode_getdeviceinfo() computes the da_addr_body reservation
> as 16 + netid_len + addr_len, but the subsequent xdr_encode_opaque()
> calls emit 8 + round_up(netid_len, 4) + round_up(addr_len, 4) bytes.
> The mismatch means the declared da_addr_body length exceeds the actual
> encoded data by 2-8 bytes on every flexfile GETDEVICEINFO reply,
> leaking stale reply-page content to the client and mis-aligning the
> subsequent version list decode.
>
> Use xdr_align_size() for each string length to match what
> xdr_encode_opaque() actually writes.
>
> Fixes: efcae97fa425 ("NFSD: da_addr_body field missing in some 
> GETDEVICEINFO replies")
> Assisted-by: kres:claude-opus-4-6
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/flexfilelayoutxdr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/flexfilelayoutxdr.c b/fs/nfsd/flexfilelayoutxdr.c
> index f9f7e38cba13..7f357dbd1bb1 100644
> --- a/fs/nfsd/flexfilelayoutxdr.c
> +++ b/fs/nfsd/flexfilelayoutxdr.c
> @@ -94,7 +94,8 @@ nfsd4_ff_encode_getdeviceinfo(struct xdr_stream *xdr,
>  	}
> 
>  	/* len + padding for two strings */
> -	addr_len = 16 + da->netaddr.netid_len + da->netaddr.addr_len;
> +	addr_len = 8 + xdr_align_size(da->netaddr.netid_len) +
> +		   xdr_align_size(da->netaddr.addr_len);
>  	ver_len = 20;
> 
>  	len = 4 + ver_len + 4 + addr_len;
>
> ---
> base-commit: b69fc3eaa867d0caa904634ea7a1b4569411b163
> change-id: 20260527-pnfs-fixes-23451bb03d57
>
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>

Fixes tag might/should be 9b9960a0ca47 ? LLM reviews vary on this.

nfsd4_ff_encode_layoutget at fs/nfsd/flexfilelayoutxdr.c:40-41 has the
same unaligned pattern for UID/GID strings: 8 + uid.len + 8 + gid.len.
Do you intend to address that calculation as well?

My preference here is to convert to xdrgen instead, but that's a much
bigger and less back-portable change.


-- 
Chuck Lever

