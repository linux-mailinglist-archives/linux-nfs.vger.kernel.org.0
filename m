Return-Path: <linux-nfs+bounces-21989-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCCDOlD7FWovggcAu9opvQ
	(envelope-from <linux-nfs+bounces-21989-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 21:58:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B185DC2AC
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 21:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B1A23010530
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 19:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4B53B27C1;
	Tue, 26 May 2026 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPybllyt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B547F2D9787;
	Tue, 26 May 2026 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779825482; cv=none; b=gSky7Ue11rEO1O7oUZomagwOwqdBJlL4lqRNQPoOi77SgvZVf/SWK32Oml+pf4hMoq1YEjxdWen3kjryR4iXGsNnNs79pTqVYBvdqmOoQn4CL+wj2VPacWYm7qfw8NuIsy5uZgK93M68BWZJ4WsenN1XB2643jCGOUjF1a3ZNrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779825482; c=relaxed/simple;
	bh=osxI2trcJFudeTUPqpWIbudsHtCfXVAyeRZTKIDY2B8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oCCL4vN8Dc5jcGvqgm/4WpOGOsNHNoRZfeeKOVBzqrD4BWU9hDBTRolqTer2o1+pxD2aLV5kDUdRFojaUlRlF7WyR4yzE/O3CS/uAK/XOoq9OKUzHCYv1Ite0low6Woz2XQcDDRqHbsjgNB939VGkLipuKV1bsTfnMvjc7duOw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPybllyt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD8E1F000E9;
	Tue, 26 May 2026 19:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779825481;
	bh=67qyYwcHcM0+oSoipVhMKJQvRP46f8uWoJfiuM+1wxs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ZPybllytIcVtMq0YVWs+nNqSs1yEH5hEWOX68gnTHS3vrR9SOB73sWpVLwRHCfuc0
	 OGDGJAd98M9QYh4d9rQwaPWDNJ1qi0/EsbsNtVrqyIsn6qmN4GMJBsEqHfKsnAQ+Vi
	 WW010vroH7duEB2AKcLBo9URVhnAcEj+bjMUpu8uyIe7MFnXnkIU0HAdrRhBhlZrPW
	 2MgnILK7WzdqnP6yI8cHXY5YeJybsdXkcDEYcd0jbNCIYXIiSms3Ez9g6QHEFRqsV5
	 HJbah+fuQvttAcQASBSDZre1gRMSf+1ZhzIWsI2ESLD+hzv9/Ob/U1L7k2IUek4Wia
	 MgWa3Mqdv14Hg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 68D50F4007B;
	Tue, 26 May 2026 15:58:00 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Tue, 26 May 2026 15:58:00 -0400
X-ME-Sender: <xms:SPsVajwm7K5ELrMnXpZdvYPZpBz5w-tPhWQw-8GClWhu1g11kW-Wqg>
    <xme:SPsVamEDxcesPNOpwfl2eHiQ8papVe8po7eGRA2wmSmKwN0CHEQQdqiq4jy6Hpv9f
    BHHz-BEEV4QhTpyoAgeQuLXp2Jw2_yjtWiLhtvp_6NnxH4CGkV4fT0>
X-ME-Proxy-Cause: dmFkZTFae7avOup8DuVHF9O+YAhnbpFr087icaSm5489iB1uQSNtNiE/l3/+L02sYPuVgA
    b9+6gZeCy91UbGdeimLHFrDdx70eAuXjRoYjDLUHzclgl0SbU+71QNwZEQeZYF6FSOFDOj
    bRHZfdVF87yfzKuQQy2zZ2hVFmfXmBR8jWqZqlCUQLu3SRQ4i4WC5hZgkgwTmjCOnl19vf
    n15yaaVQem15WlJ4B2Rcd79ki3sHiq5o0nqhfXzpFgCMf4o8tf4DRxtfIFDi3mku3wiyPk
    F/S2rtufvHoFO+eYnFFFrb8/Xq6bNRLdNc6kh81/5RNLTQ3kKWznc6QydmlmWzYxcmaSl5
    iNOyCsEovAYoYdal6UUcKZ1cWb+CXz27dKlb+bLEfx/BKJUXFNSnW3bhdRK381JC1GlnDz
    XP9wpbXlD1Fm5cgMlBAH0tdU5C/QePhdE58ZIueD7L0MFQeKkbn1HkohCM1tW0drVPDMbG
    Y7ZuSjDDd/Vz0WfMMdlnTN0EbX6M9N2B08LAduRALKXc9UQ9YZyWn1W/fS/MYmL4bwAgI6
    7tsk4Q8lFby6V9MqGobmh1IqwKULScTXFfrGd4I4bClrEu5+r/84c4VX3g298L6YwL5RMI
    xB5XZts8neMXc32pQogBxGf2pmVomIP25vzG9MRiAxK/7XaaYOVLw4ULPY9w
X-ME-Proxy: <xmx:SPsVaia06ab-5t8rIoB5fXJvYxPZ0y00H_MCtBOqYG1PjmL6NHwpXg>
    <xmx:SPsVahNDlc148Is1cwyS7pt37za6RwuvPdxMSb6dPbB7wWkRrtgUYw>
    <xmx:SPsVaoXapbrqxFs2FpwMI0801xmOfA0kpYoYic7fFs2hAzN69t3MaA>
    <xmx:SPsVauLFO3btlv5dqWD_w3bwVEozkX0waAgAns-aHtDisqpiAoJpYw>
    <xmx:SPsVarrjHrpwpJgG5nlF8CobOJ24fHYrqIeAUsZDBts8CesQ0U7rPcuQ>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 45E73B6006E; Tue, 26 May 2026 15:58:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AaF86MUxFLqk
Date: Tue, 26 May 2026 15:57:31 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: "Michael Bommarito" <michael.bommarito@gmail.com>,
 "Trond Myklebust" <trondmy@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Tom Haynes" <Thomas.Haynes@primarydata.com>,
 "Peng Tao" <tao.peng@primarydata.com>, "Kees Cook" <kees@kernel.org>,
 "Mike Snitzer" <snitzer@kernel.org>,
 "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-Id: <727ea49a-ba0a-435a-b08c-da1d94abe931@app.fastmail.com>
In-Reply-To: <20260523014033.2459677-3-michael.bommarito@gmail.com>
References: <20260523014033.2459677-1-michael.bommarito@gmail.com>
 <20260523014033.2459677-3-michael.bommarito@gmail.com>
Subject: Re: [PATCH 2/2] NFSv4/flexfile,filelayout: bound multipath DS count in
 GETDEVICEINFO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21989-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F3B185DC2AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michael,

On Fri, May 22, 2026, at 9:40 PM, Michael Bommarito wrote:
> Both the flexfile and the (legacy) file pNFS layout drivers decode a
> multipath-DS count from a server-supplied GETDEVICEINFO body and then
> iterate it via nfs4_decode_mp_ds_addr() without any upper bound. The
> filelayout driver already caps the outer ds_num against
> NFS4_PNFS_MAX_MULTI_CNT (== 256) but applies no equivalent cap to the
> inner mp_count; the flexfile driver applies no cap on either.
>
> In addition, both inner loops ignore a NULL return from
> nfs4_decode_mp_ds_addr(), so once the on-wire data no longer matches
> a valid netaddr4 encoding the loop is free to consume the trailing
> bytes of the device_addr opaque as garbage netid + uaddr pairs. A
> malicious or compromised pNFS metadata server can therefore drive
> the inner loop indefinitely (up to 2^32 - 1 iterations) against a
> fixed-size 56-byte body, with each iteration triggering an
> allocation / kmemdup_nul cycle inside the decoder.
>
> Promote NFS4_PNFS_MAX_MULTI_CNT from the filelayout private header to
> include/linux/nfs4.h so both drivers (and any future pNFS layout
> driver that decodes a multipath address list) bound the wire-level
> field consistently. Apply the cap to the inner mp_count in both
> drivers, matching the existing ds_num check, and bail on the first
> NULL return so a server that lies about mp_count cannot quietly
> extend the loop into the trailing layout-body bytes. This is
> defense-in-depth on top of the companion patch which closes the
> NULL-deref in nfs4_decode_mp_ds_addr(); either patch alone closes
> the kernel-panic shape, both together close the latent
> unbounded-decode class.
>
> Cc: stable@vger.kernel.org
> Fixes: 35124a0994fc ("Cleanup XDR parsing for LAYOUTGET, GETDEVICEINFO")
> Fixes: d67ae825a59d ("pnfs/flexfiles: Add the FlexFile Layout Driver")
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  fs/nfs/filelayout/filelayout.h            |  2 +-
>  fs/nfs/filelayout/filelayoutdev.c         |  7 +++++--
>  fs/nfs/flexfilelayout/flexfilelayoutdev.c | 10 ++++++++--
>  include/linux/nfs4.h                      |  3 +++
>  4 files changed, 17 insertions(+), 5 deletions(-)
>
> With this patch alone the crafted GETDEVICEINFO at multipath_count >= 3
> is rejected at the bound check; malformed netaddr in the inner loop
> bails on the first NULL return.  Either this patch or the companion
> 1/2 closes the panic; both together close the unbounded-decode class.
>
> Baseline multipath_count = 1 mount + read completes normally.
>
>
> diff --git a/fs/nfs/filelayout/filelayout.h b/fs/nfs/filelayout/filelayout.h
> index c7bb5da93307d..03298f2e7cd69 100644
> --- a/fs/nfs/filelayout/filelayout.h
> +++ b/fs/nfs/filelayout/filelayout.h
> @@ -39,7 +39,7 @@
>   * RFC 5661 multipath_list4 structures.
>   */
>  #define NFS4_PNFS_MAX_STRIPE_CNT 4096
> -#define NFS4_PNFS_MAX_MULTI_CNT  256 /* 256 fit into a u8 stripe_index */
> +/* NFS4_PNFS_MAX_MULTI_CNT now in <linux/nfs4.h>; shared with flexfile. */

I don't think we need the comment saying that the value has moved.

> 
>  enum stripetype4 {
>  	STRIPE_SPARSE = 1,
> diff --git a/fs/nfs/filelayout/filelayoutdev.c 
> b/fs/nfs/filelayout/filelayoutdev.c
> index 7226989ee4d53..c58c786dcf011 100644
> --- a/fs/nfs/filelayout/filelayoutdev.c
> +++ b/fs/nfs/filelayout/filelayoutdev.c
> @@ -159,10 +159,13 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server 
> *server, struct pnfs_device *pdev,
>  			goto out_err_free_deviceid;
> 
>  		mp_count = be32_to_cpup(p); /* multipath count */
> +		if (mp_count > NFS4_PNFS_MAX_MULTI_CNT)
> +			goto out_err_free_deviceid;
>  		for (j = 0; j < mp_count; j++) {
>  			da = nfs4_decode_mp_ds_addr(net, &stream, gfp_flags);
> -			if (da)
> -				list_add_tail(&da->da_node, &dsaddrs);
> +			if (!da)
> +				break;
> +			list_add_tail(&da->da_node, &dsaddrs);
>  		}
>  		if (list_empty(&dsaddrs)) {
>  			dprintk("%s: no suitable DS addresses found\n",
> diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c 
> b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> index c40395ae08142..faed05cbe9f1c 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> @@ -78,12 +78,18 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server 
> *server, struct pnfs_device *pdev,
>  		goto out_err_drain_dsaddrs;
>  	mp_count = be32_to_cpup(p);
>  	dprintk("%s: multipath ds count %d\n", __func__, mp_count);
> +	if (mp_count > NFS4_PNFS_MAX_MULTI_CNT) {
> +		dprintk("%s: multipath count %u greater than supported maximum %d\n",
> +			__func__, mp_count, NFS4_PNFS_MAX_MULTI_CNT);
> +		goto out_err_drain_dsaddrs;
> +	}
> 
>  	for (i = 0; i < mp_count; i++) {
>  		/* multipath ds */
>  		da = nfs4_decode_mp_ds_addr(net, &stream, gfp_flags);
> -		if (da)
> -			list_add_tail(&da->da_node, &dsaddrs);
> +		if (!da)
> +			break;
> +		list_add_tail(&da->da_node, &dsaddrs);
>  	}
>  	if (list_empty(&dsaddrs)) {
>  		dprintk("%s: no suitable DS addresses found\n",
> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> index d87be1f25273a..bfc30baa8159a 100644
> --- a/include/linux/nfs4.h
> +++ b/include/linux/nfs4.h
> @@ -767,6 +767,9 @@ enum pnfs_block_extent_state {
>  	PNFS_BLOCK_NONE_DATA		= 3,
>  };
> 
> +/* Maximum NFSv4.1 pNFS multipath data-server address count */
> +#define NFS4_PNFS_MAX_MULTI_CNT		256

In the original location, this had a comment saying where the 256 came
from. Can you carry that over to here too, please?

Thanks,
Anna

> +
>  /* on the wire size of a block layout extent */
>  #define PNFS_BLOCK_EXTENT_SIZE \
>  	(7 * sizeof(__be32) + NFS4_DEVICEID4_SIZE)
> -- 
> 2.53.0

