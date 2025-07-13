Return-Path: <linux-nfs+bounces-13008-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B1CB03246
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Jul 2025 19:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25983B947C
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Jul 2025 17:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9D2278142;
	Sun, 13 Jul 2025 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="GmKEl8QY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41DA233701
	for <linux-nfs@vger.kernel.org>; Sun, 13 Jul 2025 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752427388; cv=none; b=j5guBvv8EP3rP0PUcbannI9l42wPQGro/+O4JtHfR0v6G42wW58RX58+btWewvygt2cSmFb6v+6IkZ6o5uSepotci/wJhRweDricizp6VQ0gmJNiCNAuIfk6QaQdJ/to4Or+ajKhLmocj/RuADLS12dBOIoRyigIsLMHV9KyCAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752427388; c=relaxed/simple;
	bh=mZHODRK9wm7pxpS0ft4Rg198Uk/Ub6z+h29ArCM0CW4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=FpnvWg7mDF1RKcnz8mx4/AfaNGs2S2PgKsDTGYasK8aXbP0IVMetv02iQwI3LKUovFDsd1PUFM91rkeAaODf+LtOyrGt5M9M1rPvpI2OkMExjWiM6TkrB21PwwJDkTPPLrw7nVoXUdRVl/V099W8VbAo99AiOushscjH8twDpLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=GmKEl8QY; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [IPv6:2001:638:700:1038::1:9b])
	by smtp-o-3.desy.de (Postfix) with ESMTP id A21DF11F7EC
	for <linux-nfs@vger.kernel.org>; Sun, 13 Jul 2025 19:13:36 +0200 (CEST)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 703A813F648
	for <linux-nfs@vger.kernel.org>; Sun, 13 Jul 2025 19:13:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 703A813F648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1752426809; bh=AJtxeUMjzFcKsQTgTDA+iDhWpDRSfCnefYwMtkYp9rk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=GmKEl8QYLHq8xDvvnRO8hpsArZ6QK1FU40JLlwgEc8QOkd9Fv8aYiJxmKq9QrJ7Ve
	 W3rbTTI+oZHMShg4yOdltcehkcX49L2hekzhoBQZ2gY3rCT869LsVMMAs6VUf2xDxp
	 At7xapCQQLFqotrl4r87ECQWZ183cG2NILL33aYo=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 6407120040;
	Sun, 13 Jul 2025 19:13:29 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [194.95.233.47])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 5913740044;
	Sun, 13 Jul 2025 19:13:29 +0200 (CEST)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id 4D6153200B5;
	Sun, 13 Jul 2025 19:13:28 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 1A89080046;
	Sun, 13 Jul 2025 19:13:28 +0200 (CEST)
Date: Sun, 13 Jul 2025 19:13:27 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <879679680.4126718.1752426807985.JavaMail.zimbra@desy.de>
In-Reply-To: <20250627071751.189663-1-tigran.mkrtchyan@desy.de>
References: <20250627071751.189663-1-tigran.mkrtchyan@desy.de>
Subject: Re: [PATCH v3] pNFS/flexfiles: don't attempt pnfs on fatal DS
 errors
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_4126719_253852368.1752426808021"
X-Mailer: Zimbra 10.1.8_GA_4773 (ZimbraWebClient - FF140 (Linux)/10.1.9_GA_4780)
Thread-Topic: pNFS/flexfiles: don't attempt pnfs on fatal DS errors
Thread-Index: T3/l+QR9AuiWl/F8rKmowKSfj54V3A==

------=_Part_4126719_253852368.1752426808021
Date: Sun, 13 Jul 2025 19:13:27 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <879679680.4126718.1752426807985.JavaMail.zimbra@desy.de>
In-Reply-To: <20250627071751.189663-1-tigran.mkrtchyan@desy.de>
References: <20250627071751.189663-1-tigran.mkrtchyan@desy.de>
Subject: Re: [PATCH v3] pNFS/flexfiles: don't attempt pnfs on fatal DS
 errors
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.1.8_GA_4773 (ZimbraWebClient - FF140 (Linux)/10.1.9_GA_4780)
Thread-Topic: pNFS/flexfiles: don't attempt pnfs on fatal DS errors
Thread-Index: T3/l+QR9AuiWl/F8rKmowKSfj54V3A==


Hi Anna, hi Trond,

Any chance we get this in? Or there any suggestions how to address the issue differently?

Thanks,
   Tigran.


----- Original Message -----
> From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> To: "linux-nfs" <linux-nfs@vger.kernel.org>
> Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>, "Tigran Mkrtchyan"
> <tigran.mkrtchyan@desy.de>
> Sent: Friday, 27 June, 2025 09:17:51
> Subject: [PATCH v3] pNFS/flexfiles: don't attempt pnfs on fatal DS errors

> Fixes: 260f32adb88 ("pNFS/flexfiles: Check the result of nfs4_pnfs_ds_connect")
> 
> When an applications get killed (SIGTERM/SIGINT) while pNFS client performs a
> connection
> to DS, client ends in an infinite loop of connect-disconnect. This
> source of the issue, it that flexfilelayoutdev#nfs4_ff_layout_prepare_ds gets an
> error
> on nfs4_pnfs_ds_connect with status ERESTARTSYS, which is set by
> rpc_signal_task, but
> the error is treated as transient, thus retried.
> 
> The issue is reproducible with Ctrl+C the following script(there should be ~1000
> files in
> a directory, client should must not have any connections to DSes):
> 
> ```
> echo 3 > /proc/sys/vm/drop_caches
> 
> for i in *
> do
>   head -1 $i
> done
> ```
> 
> The change aims to propagate the nfs4_ff_layout_prepare_ds error state
> to the caller that can decide whatever this is a retryable error or not.
> 
> Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
> ---
> fs/nfs/flexfilelayout/flexfilelayout.c    | 26 ++++++++++++++---------
> fs/nfs/flexfilelayout/flexfilelayoutdev.c |  6 +++---
> 2 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c
> b/fs/nfs/flexfilelayout/flexfilelayout.c
> index 708cbfbccea5..a67001b4dbdf 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> @@ -762,14 +762,14 @@ ff_layout_choose_ds_for_read(struct pnfs_layout_segment
> *lseg,
> {
> 	struct nfs4_ff_layout_segment *fls = FF_LAYOUT_LSEG(lseg);
> 	struct nfs4_ff_layout_mirror *mirror;
> -	struct nfs4_pnfs_ds *ds;
> +	struct nfs4_pnfs_ds *ds = ERR_PTR(-EAGAIN);
> 	u32 idx;
> 
> 	/* mirrors are initially sorted by efficiency */
> 	for (idx = start_idx; idx < fls->mirror_array_cnt; idx++) {
> 		mirror = FF_LAYOUT_COMP(lseg, idx);
> 		ds = nfs4_ff_layout_prepare_ds(lseg, mirror, false);
> -		if (!ds)
> +		if (IS_ERR(ds))
> 			continue;
> 
> 		if (check_device &&
> @@ -777,10 +777,10 @@ ff_layout_choose_ds_for_read(struct pnfs_layout_segment
> *lseg,
> 			continue;
> 
> 		*best_idx = idx;
> -		return ds;
> +		break;
> 	}
> 
> -	return NULL;
> +	return ds;
> }
> 
> static struct nfs4_pnfs_ds *
> @@ -942,7 +942,7 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
> 	for (i = 0; i < pgio->pg_mirror_count; i++) {
> 		mirror = FF_LAYOUT_COMP(pgio->pg_lseg, i);
> 		ds = nfs4_ff_layout_prepare_ds(pgio->pg_lseg, mirror, true);
> -		if (!ds) {
> +		if (IS_ERR(ds)) {
> 			if (!ff_layout_no_fallback_to_mds(pgio->pg_lseg))
> 				goto out_mds;
> 			pnfs_generic_pg_cleanup(pgio);
> @@ -1808,6 +1808,7 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
> 	u32 idx = hdr->pgio_mirror_idx;
> 	int vers;
> 	struct nfs_fh *fh;
> +	bool ds_fatal_error = false;
> 
> 	dprintk("--> %s ino %lu pgbase %u req %zu@%llu\n",
> 		__func__, hdr->inode->i_ino,
> @@ -1815,8 +1816,10 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
> 
> 	mirror = FF_LAYOUT_COMP(lseg, idx);
> 	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, false);
> -	if (!ds)
> +	if (IS_ERR(ds)) {
> +		ds_fatal_error = nfs_error_is_fatal(PTR_ERR(ds));
> 		goto out_failed;
> +	}
> 
> 	ds_clnt = nfs4_ff_find_or_create_ds_client(mirror, ds->ds_clp,
> 						   hdr->inode);
> @@ -1864,7 +1867,7 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
> 	return PNFS_ATTEMPTED;
> 
> out_failed:
> -	if (ff_layout_avoid_mds_available_ds(lseg))
> +	if (ff_layout_avoid_mds_available_ds(lseg) && !ds_fatal_error)
> 		return PNFS_TRY_AGAIN;
> 	trace_pnfs_mds_fallback_read_pagelist(hdr->inode,
> 			hdr->args.offset, hdr->args.count,
> @@ -1886,11 +1889,14 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr,
> int sync)
> 	int vers;
> 	struct nfs_fh *fh;
> 	u32 idx = hdr->pgio_mirror_idx;
> +	bool ds_fatal_error = false;
> 
> 	mirror = FF_LAYOUT_COMP(lseg, idx);
> 	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, true);
> -	if (!ds)
> +	if (IS_ERR(ds)) {
> +		ds_fatal_error = nfs_error_is_fatal(PTR_ERR(ds));
> 		goto out_failed;
> +	}
> 
> 	ds_clnt = nfs4_ff_find_or_create_ds_client(mirror, ds->ds_clp,
> 						   hdr->inode);
> @@ -1941,7 +1947,7 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int
> sync)
> 	return PNFS_ATTEMPTED;
> 
> out_failed:
> -	if (ff_layout_avoid_mds_available_ds(lseg))
> +	if (ff_layout_avoid_mds_available_ds(lseg) && !ds_fatal_error)
> 		return PNFS_TRY_AGAIN;
> 	trace_pnfs_mds_fallback_write_pagelist(hdr->inode,
> 			hdr->args.offset, hdr->args.count,
> @@ -1984,7 +1990,7 @@ static int ff_layout_initiate_commit(struct
> nfs_commit_data *data, int how)
> 	idx = calc_ds_index_from_commit(lseg, data->ds_commit_index);
> 	mirror = FF_LAYOUT_COMP(lseg, idx);
> 	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, true);
> -	if (!ds)
> +	if (IS_ERR(ds))
> 		goto out_err;
> 
> 	ds_clnt = nfs4_ff_find_or_create_ds_client(mirror, ds->ds_clp,
> diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> index 4a304cf17c4b..ef535baeefb6 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> @@ -370,11 +370,11 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment
> *lseg,
> 			  struct nfs4_ff_layout_mirror *mirror,
> 			  bool fail_return)
> {
> -	struct nfs4_pnfs_ds *ds = NULL;
> +	struct nfs4_pnfs_ds *ds;
> 	struct inode *ino = lseg->pls_layout->plh_inode;
> 	struct nfs_server *s = NFS_SERVER(ino);
> 	unsigned int max_payload;
> -	int status;
> +	int status = -EAGAIN;
> 
> 	if (!ff_layout_init_mirror_ds(lseg->pls_layout, mirror))
> 		goto noconnect;
> @@ -418,7 +418,7 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
> 	ff_layout_send_layouterror(lseg);
> 	if (fail_return || !ff_layout_has_available_ds(lseg))
> 		pnfs_error_mark_layout_for_return(ino, lseg);
> -	ds = NULL;
> +	ds = ERR_PTR(status);
> out:
> 	return ds;
> }
> --
> 2.50.0

------=_Part_4126719_253852368.1752426808021
Content-Type: application/pkcs7-signature; name=smime.p7s; smime-type=signed-data
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCAMIIH
XzCCBUegAwIBAgIQGrSZ0tLzGu9JoeeaXGroSzANBgkqhkiG9w0BAQwFADBVMQswCQYDVQQGEwJO
TDEZMBcGA1UEChMQR0VBTlQgVmVyZW5pZ2luZzErMCkGA1UEAxMiR0VBTlQgVENTIEF1dGhlbnRp
Y2F0aW9uIFJTQSBDQSA0QjAeFw0yNDEyMDQwOTQzMjZaFw0yNjAxMDMwOTQzMjZaMIGpMRMwEQYK
CZImiZPyLGQBGRMDb3JnMRYwFAYKCZImiZPyLGQBGRMGdGVyZW5hMRMwEQYKCZImiZPyLGQBGRMD
dGNzMQswCQYDVQQGEwJERTEuMCwGA1UEChMlRGV1dHNjaGVzIEVsZWt0cm9uZW4tU3luY2hyb3Ry
b24gREVTWTEoMCYGA1UEAwwfVGlncmFuIE1rcnRjaHlhbiB0aWdyYW5AZGVzeS5kZTCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBAKZ1aJleygPW8bRzYJ3VfXwfY2TxAF0QUuTk/6Bqu8Bi
UQjIgmBQ1hCzz8DVdJ8saw7p5/c1JDmVHqm2DJPwXLROKACiDdSHPf+N8PFZvxHxOqFNPeO/oJhO
jHXG1c/tL8ElfiUlMtEZYtoS60/VUz3A/4FIWP2A5s/UIOSZyCcKz3AUcAanHGEJVS8oWKQj7pNX
yjojvX4aPHzsKP+c+c/5wq08/aziRXLCekhKk+VdS8lhlS/3AL1G0VSWKj5/pOpz4ozmv44GEw9z
FAsPWuTcLXqCX993BOoWAyQDcygAsb0nQQMzx+4wlSGsI31/gKOE5ZOJ3SErWDswgzxWm8Xht/Kl
ymDHPXi8P0ohQjJrQRpJXVwD/tXDwSSbWP9jnVbtqpvLLBkNrSy6elW19nkE1ObpSPcn+be5hs1P
59Y+GPudytAQ3MOoFoNd7kxpVQoM6cdQjRHdyIDbavZrdxr33s7uqSbcI/PE8W5M0iPNnd4ip4kH
UIOdpsjk7b7kEdO4Jf9dDrz/fduAEaW+AUTfb+G42LiftUBXkANa50nOseW3tocadYOTySufN9or
IwvcQ/1uemVd83On7k8bWevfU159x28aidxv8liqJXrrT28tp/QxtGtDXjo9jdkWi/5d/9XfqQgN
IT7KH42fc3ZlaL3pLuJwEQWVtFnWUTRJAgMBAAGjggHUMIIB0DAfBgNVHSMEGDAWgBQQMuoC4vzP
6lYlVIfDmPXog9bFJDAOBgNVHQ8BAf8EBAMCBaAwCQYDVR0TBAIwADAdBgNVHSUEFjAUBggrBgEF
BQcDAgYIKwYBBQUHAwQwRQYDVR0gBD4wPDAMBgoqhkiG90wFAgIFMA0GCyqGSIb3TAUCAwMDMA0G
CyqGSIb3TAUCAwECMA4GDCsGAQQBgcRaAgMCAjBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8vY3Js
LmVudGVycHJpc2Uuc2VjdGlnby5jb20vR0VBTlRUQ1NBdXRoZW50aWNhdGlvblJTQUNBNEIuY3Js
MIGRBggrBgEFBQcBAQSBhDCBgTBPBggrBgEFBQcwAoZDaHR0cDovL2NydC5lbnRlcnByaXNlLnNl
Y3RpZ28uY29tL0dFQU5UVENTQXV0aGVudGljYXRpb25SU0FDQTRCLmNydDAuBggrBgEFBQcwAYYi
aHR0cDovL29jc3AuZW50ZXJwcmlzZS5zZWN0aWdvLmNvbTAjBgNVHREEHDAagRh0aWdyYW4ubWty
dGNoeWFuQGRlc3kuZGUwHQYDVR0OBBYEFMmhx6vILo+tVVV6rojJTwL+t2eGMA0GCSqGSIb3DQEB
DAUAA4ICAQARKKJEO1G3lIe+AA+E3pl5mNYs/+XgswX1316JYDRzBnfVweMR6IaOT7yrP+Mwhx3v
yiM8VeSVFtfyLlV6FaHAxNFo5Z19L++g/FWWAg0Wz13aFaEm0+KEp8RkB/Mh3EbSukZxUqmWCgrx
zmx+I5zlX8pLxNgrxcc1WW5l7Y7y2sci++W6wE/L7rgMuznqiBLw/qwnkXAeQrw2PIllAGwRqrwa
37kPa+naT1P0HskuBFHQSmMihB5HQl6+2Rs9M5RMW3/IlUQAqkhZQGBXmiWDivjPFKXJQnCmhQmh
76sOcSOScfzYI5xOD+ZGdBRRufkUxaXJ2G//IgkK2R8mqrFEXxBFaBMc0uMBJHKNv+FO7H6VPOe9
BD9FwfLiqWvGwKJrF11Bk/QSfWh+zCJ8JHPAi6irwQO4Xf+0xhPsxb+jBfKK3I84YMf6zsDkdDzH
lkNPhDh4xhYhEAk+L228pjTEmnbb2QVv52grZ0dbITuN+Hz2ypvLfaS8p06lrht45COlkmuIUVqp
bsc3kRt610qwXSjYcc8zeCQI0Rqnnq+0UN5T0KU7JSzUho6vaTSUG57uc7b3DkIW2Z9VpXX5xKb/
vfl++jC5JzKrbCeS+QOStpXwwaH62IUHwdfWfkvpzb8EFALEmCvu8nlT9NaqYlB/xogMH6oHBm+Y
nxmRQxWROAAAMYIDZTCCA2ECAQEwaTBVMQswCQYDVQQGEwJOTDEZMBcGA1UEChMQR0VBTlQgVmVy
ZW5pZ2luZzErMCkGA1UEAxMiR0VBTlQgVENTIEF1dGhlbnRpY2F0aW9uIFJTQSBDQSA0QgIQGrSZ
0tLzGu9JoeeaXGroSzANBglghkgBZQMEAgEFAKCBzjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yNTA3MTMxNzEzMjhaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIIzCkAeGPU1uXPLMMWEm/N2OdA/X
jlpe0r8yd9EnqsRwMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICAGLHEHcsLTjEshJLciRAPvI55iyp4ybcKypQCiGJ
cjjsMsSK2T5+7hdxX0R7OvKVlem74Ja1nnXjSqY8ElfwSP/ZfAYzc53FrhUlPvefsbyyPA06IFFo
bwUU3Vavs68LngSSzKUIoOJ0OeX6QxWh3Gn2fkkQkDHHvT0Lv1bz+yiILjfhRFphM2Rq1+hgUJOw
VUzKMXlbLJEYjSVLn3v/YUHFUHryiV5it4qAlErMdZr4pscdyK6T08w+TA+1iAtE8Zu8Z/sE33eN
Wb8Kbd/UFBPQmj7yBb1N3h8REIh8bsZdlpFEDBRP4O5TJEjUTaYbpf1CqfhLRantuogtHQuoz2Q+
0YHteb+vicevj+pgwyzVz5NUTPqJBw3oLYwP21YQ7rKMONFKLTJZoD5gIEJbCW4tk+IhzZSIoWeO
T9y1vYtqEiNwKd8oUZ76TQVg3ETF0VM5KNE72SjmSHlLKbacyB8BedhNAdgHroyvaMqbcOIH7yvx
0HLdE/r1o0fjEdJhv4x2znh5KTcDVNnbdHN7y27r2+mloSjralXZj7ea8EwNJ45feTo02tVXeMm1
53UyzqjWghrON2SBQEEFNmKMJ3MhX3jmxsbzQV4Lw6flCNogwCKrf6IUhSzPq5RvaHwp9hLGK8yu
AokMoAdf2RnnK9dcvaOyZyjlL1YHslp3tXLdAAAAAAAA
------=_Part_4126719_253852368.1752426808021--

