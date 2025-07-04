Return-Path: <linux-nfs+bounces-12894-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446E4AF8F02
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 11:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 412807B6E98
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD1D28A712;
	Fri,  4 Jul 2025 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="TlIKkaBh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F646288526
	for <linux-nfs@vger.kernel.org>; Fri,  4 Jul 2025 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621165; cv=none; b=AoO7AeqoUpPVTggMXI1KNn+pfohS6ZYMl+5c2kwvfOZym2bKVsPrgkJBC+KkUVUYoJ2unOyP4FLSTJAYk3Xlv1d+FttFCeeqfOaV+ti2FuqBHeelgzyOaIpRFxrGm/64lq7c6crtgwv/qR4GgdJBGxAJ7KVqToP2B+AErgKKCgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621165; c=relaxed/simple;
	bh=g7WNuFsW4HX+Y62JMCnI5GFU1JTRWaAFBK2wvM9qbLI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=SjRy7Z6w4KOpZIHiJtgHGRDceRVL2PN0tsgAD0ZKXAHlBfQCfk9djrjbfiF6ojvYeh+ewuBV/DdnO/RbB6JazB0VhbAetN8bVCVWRvp5bROaYYjFuRllpR6qesPZZbBERZAGuaeeXGx2atPAoeQeUpkN22tmyJb5rSu07YIdMVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=TlIKkaBh; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 3958513F647
	for <linux-nfs@vger.kernel.org>; Fri,  4 Jul 2025 11:25:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 3958513F647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1751621154; bh=KRhEwiP3OL4n3oPfptcigE0qPJr/ryP4UZXiQlHZhXA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=TlIKkaBhXhVgTqwORSYxxF1EWxZki1Xd0vu8gm3v0rLF7UOd71LJ8Ll4INite+CDg
	 wK3wobCs7NmppYEKSp7kubD2TDOXyEaIaB197CjlouNi6LF2zOFek90RGVpF8m7wNv
	 zKf4ZpcoPIjcL4t+m7Mj5YcSKpoow8PzTAyYnel0=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 2D09D120043;
	Fri,  4 Jul 2025 11:25:54 +0200 (CEST)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [194.95.239.47])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 2195840044;
	Fri,  4 Jul 2025 11:25:54 +0200 (CEST)
Received: from smtp-intra-3.desy.de (smtp-intra-3.desy.de [131.169.56.69])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id 6BD9410A3CC;
	Fri,  4 Jul 2025 11:25:53 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-3.desy.de (Postfix) with ESMTP id 3E86D1A0041;
	Fri,  4 Jul 2025 11:25:53 +0200 (CEST)
Date: Fri, 4 Jul 2025 11:25:53 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Message-ID: <196858680.698109.1751621153162.JavaMail.zimbra@desy.de>
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
	boundary="----=_Part_698110_1859153259.1751621153195"
X-Mailer: Zimbra 10.1.8_GA_4773 (ZimbraWebClient - FF140 (Linux)/10.1.9_GA_4780)
Thread-Topic: pNFS/flexfiles: don't attempt pnfs on fatal DS errors
Thread-Index: J23tbr2FnR4un0Td5X+I+mvoloXPsA==

------=_Part_698110_1859153259.1751621153195
Date: Fri, 4 Jul 2025 11:25:53 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Message-ID: <196858680.698109.1751621153162.JavaMail.zimbra@desy.de>
In-Reply-To: <20250627071751.189663-1-tigran.mkrtchyan@desy.de>
References: <20250627071751.189663-1-tigran.mkrtchyan@desy.de>
Subject: Re: [PATCH v3] pNFS/flexfiles: don't attempt pnfs on fatal DS
 errors
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.1.8_GA_4773 (ZimbraWebClient - FF140 (Linux)/10.1.9_GA_4780)
Thread-Topic: pNFS/flexfiles: don't attempt pnfs on fatal DS errors
Thread-Index: J23tbr2FnR4un0Td5X+I+mvoloXPsA==


Dear fellows,

Any comments on this?

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

------=_Part_698110_1859153259.1751621153195
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
MBwGCSqGSIb3DQEJBTEPFw0yNTA3MDQwOTI1NTNaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIMq82pyVnSuiJJEkaOceyJGu3FGX
zxXBNqNnonlrMC8SMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICAIrTK9skSa9hDGrct9ocHfVhUWxLILaywc668sns
VNU653dp+mlQcm6Sc30MoPGkSN4CpGbAbqI7KnKH89qQh74Xh3eWZLnisKUevH32tqmsP//x8IIa
VIxJDv4Ig7XB8aYkxwL6+DQ0XDsdtjyuHD5eKhXACYoiSX2iaIjD5MoBl3IuNK7bj4T5X7gWfIjM
4c9sxTAUWOf/FLWuYOT96wFbodTMHE7C7Sop07B4mUlSkLEP6qBUscl38iSRCO962qFOc1t59zLI
cMVDiKQ5Fahg2Bbqcyeqa0Ecky+qEBP/toRRTS2DtJyWi/aJQ1d3b95io87yIgrcnM6mUnErMIHJ
VysUT5yLeX1hDzfRxyxWX1S2ODONuZYxBIc1DZDpCscHM8zdCyGjBFXe7v4KjB7mtkkndUX3AmkQ
tPOuPt+40nDYarPtENCElewho2z4bhV+E17HBZg2yJogAQLknDYHRZh1zI9DZ/+rB0cSZ0L6pM9m
qGeaRxCzfWtVRljWpgmhs6TFFx8QokZPApVdPJKsR/vIqTDudE9v4EjsjLfIIun924zKGrSmPz/7
oliCAhGh7V4RZ+iNNNvv5uee4C8nB61nZRTarzoOrfOz8GWkCdGmql+4ub0L3YXssYwSQpc7ehav
vlusCzZ9F5eJkEUNYcVVYCvmI3Vnh1PkF9SDAAAAAAAA
------=_Part_698110_1859153259.1751621153195--

