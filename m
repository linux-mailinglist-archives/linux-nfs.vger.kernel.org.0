Return-Path: <linux-nfs+bounces-21944-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BIoLQxvFWojVAcAu9opvQ
	(envelope-from <linux-nfs+bounces-21944-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 11:59:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5491B5D3D76
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 11:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4C9A301066C
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 09:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FEE3CFF67;
	Tue, 26 May 2026 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njhfWZRX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149A3D9684;
	Tue, 26 May 2026 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789555; cv=none; b=E88tg1Zj8Qzg3CGMlnK5uY1hv+SyOlybhzpf5kgsM7ezZmSqgrfnvkCGCZf5buS7obhI54JTyeCxSObzr6r6nGbgH/e/4koNuiUgXd9PorqVDieoU5eewtMNFF9YYpq/WaNulobS+/3XeuddObTYUCKJ0zkxEO1C+n7xCyLW4XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789555; c=relaxed/simple;
	bh=Zw1TSSK6g04CBf2TGQwjnWLwuDpehO8X1fD61DHbPOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV5c8xi9XJcX9NYD6psZ1NOeYyEaiB3EqPBOR36UVBz0qBkgnmfYzBAH9FBw1g2alBAo+ErEa4uwbenhN87hMZNHc0D1VsG+09uBzMJzbOMrFmscZGDMje8y+K5hFrPrdzxS+z52GE+1P3eflSvFu5vwsbdBEj//fYMt0McFscE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njhfWZRX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07DC1F000E9;
	Tue, 26 May 2026 09:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779789554;
	bh=ZO3jtRwjNzTBIPLXstW+scdVYEtP74LhQLhGQHd+Xf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=njhfWZRXyBPXi50Q8ofxeg1y0jt6sv+/inC6lXvLZJj/dEJ+P4t3K8XBDMLsDxxYX
	 KFNYISM+XavX4XLzM477G55cBfDzeGl5tVRVALQrDZVLOIqa8qqeQIFca/YKMs+jgJ
	 n+X/jsdz0G7n87o8rRq1M4nNCFDKYp9LIY77DApbrVvmMtlYScC08xnQ+q67yCQTDc
	 xCwHJkbGNUTZDA3eaZeqvlAIK2eRmSe988nEEENzoFOaA1MApZIUvZwBCuniZ/AYzJ
	 LsgV0YxHFZ46+HkTsc5W+XManJ1qmOUtlSU7FnbSt3KfHMO/PyETugaPnMFob6mgU3
	 DVL688YbyTnBg==
Date: Tue, 26 May 2026 11:59:10 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] xfs: fix use of uninitialized imap in
 xfs_fs_map_blocks error path
Message-ID: <ahVu58wxfoAbL2oS@nidhogg.toxiclabs.cc>
References: <20260520003503.2399326-1-dai.ngo@oracle.com>
 <20260520003503.2399326-2-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520003503.2399326-2-dai.ngo@oracle.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21944-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: 5491B5D3D76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 05:32:58PM -0700, Dai Ngo wrote:
> xfs_fs_map_blocks() acquires the data map lock and then calls
> xfs_bmapi_read(). If xfs_bmapi_read() fails, the function currently
> still falls through to xfs_bmbt_to_iomap(), which consumes an
> uninitialized imap record and may return invalid data to the caller.
> 
> Fix this by releasing the data map lock and returning immediately when
> xfs_bmapi_read() reports an error. This prevents xfs_bmbt_to_iomap()
> from being called with an uninitialized xfs_bmbt_irec.
> 
> Fixes: 527851124d10f ("xfs: implement pNFS export operations")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

>  fs/xfs/xfs_pnfs.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
> index 221e55887a2a..b792e066b403 100644
> --- a/fs/xfs/xfs_pnfs.c
> +++ b/fs/xfs/xfs_pnfs.c
> @@ -174,12 +174,15 @@ xfs_fs_map_blocks(
>  	lock_flags = xfs_ilock_data_map_shared(ip);
>  	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb,
>  				&imap, &nimaps, bmapi_flags);
> +	if (error) {
> +		xfs_iunlock(ip, lock_flags);
> +		goto out_unlock;
> +	}
>  	seq = xfs_iomap_inode_sequence(ip, 0);
>  
>  	ASSERT(!nimaps || imap.br_startblock != DELAYSTARTBLOCK);
>  
> -	if (!error && write &&
> -	    (!nimaps || imap.br_startblock == HOLESTARTBLOCK)) {
> +	if (write && (!nimaps || imap.br_startblock == HOLESTARTBLOCK)) {
>  		if (offset + length > XFS_ISIZE(ip))
>  			end_fsb = xfs_iomap_eof_align_last_fsb(ip, end_fsb);
>  		else if (nimaps && imap.br_startblock == HOLESTARTBLOCK)
> -- 
> 2.47.3
> 
> 

