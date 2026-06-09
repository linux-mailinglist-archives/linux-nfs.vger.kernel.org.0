Return-Path: <linux-nfs+bounces-22405-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zRKGMgpOKGqjBwMAu9opvQ
	(envelope-from <linux-nfs+bounces-22405-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:31:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40538662FAE
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:31:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=desy.de header.s=default header.b=VEfrUS7M;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22405-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22405-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=desy.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02C38300A62D
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 17:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7497835E931;
	Tue,  9 Jun 2026 17:23:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B2D301708
	for <linux-nfs@vger.kernel.org>; Tue,  9 Jun 2026 17:23:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025829; cv=none; b=SMU/Ct7t6PJduXPrgIYMAwNfL5VXTKHtVilXEJ6GoJQYgjLpDICaRiGuo7dDluB7Q40WRIfTzOg0L2GrOomLN4om6vRlITv1bBWt5s6MsYmYaK/cmR2/m81JDEwQ3JJRE7zgQi9vbnT453Imp1oKI1Xrg9a/58i/O0x4ht0QiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025829; c=relaxed/simple;
	bh=5ecud2qwj0vq9CqL/AWrfjoYnk1AjmENRFn+lw7rPoI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bZ9q2PnSJlBXV7g04PTZlzp4Yfm1wCD943tUqgP0ZQd19grEhNsHIHsLrGDag/6xW434MOFXXXhlF88TmQ+7x34RQDsEMT7b9jHnodB+hlTPCU9c2a4LyPGGOTJNm9AEfE5pg+VXgbzBGpnMcosQPIOY57FC9Kxa89XGVmQnjOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=VEfrUS7M; arc=none smtp.client-ip=131.169.56.156
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	by smtp-o-3.desy.de (Postfix) with ESMTP id 5044411F876
	for <linux-nfs@vger.kernel.org>; Tue,  9 Jun 2026 19:14:12 +0200 (CEST)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
	by smtp-o-1.desy.de (Postfix) with ESMTP id BB65711F746
	for <linux-nfs@vger.kernel.org>; Tue,  9 Jun 2026 19:14:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de BB65711F746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1781025243; bh=p+TLAIfVKWlzq1ybNQKlpI9m9chgCYXxYjjgVz/zOxg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VEfrUS7MXB6DfbI4Iz58rMrWQR41u6uxmuaiBHhqWEZ1tRw+PGsoc3DVEYgBUcQYF
	 amfcufAJ0UZdri9hnnhAmbbhWUWUsz5ewU1BXxio+BVWhYbO0WqUMEA+s2d9M4gdyD
	 Axb+U55bM/3KALOv3cyOHOCVtef7bLPjSACaJLlY=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id AFE8A12012E;
	Tue,  9 Jun 2026 19:14:03 +0200 (CEST)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [IPv6:2001:638:d:c303:acdc:1979:2:e7])
	by smtp-m-2.desy.de (Postfix) with ESMTP id A0F23160044;
	Tue,  9 Jun 2026 19:14:03 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id DA823100034;
	Tue, 09 Jun 2026 19:14:02 +0200 (CEST)
Received: from z-mbx-3.desy.de (z-mbx-3.desy.de [131.169.55.141])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 95D972004F;
	Tue,  9 Jun 2026 19:14:02 +0200 (CEST)
Date: Tue, 9 Jun 2026 19:14:02 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1103477872.3950199.1781025242395.JavaMail.zimbra@desy.de>
In-Reply-To: <20260604202403.20856-2-snitzer@kernel.org>
References: <20260604202403.20856-1-snitzer@kernel.org> <20260604202403.20856-2-snitzer@kernel.org>
Subject: Re: [PATCH 1/2] NFSv4/flexfiles: honor FF_FLAGS_NO_IO_THRU_MDS on
 fatal DS connect errors
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_3950200_1646942997.1781025242431"
X-Mailer: Zimbra 10.1.17_GA_4874 (ZimbraWebClient - FF151 (Linux)/10.1.17_GA_4873)
Thread-Topic: NFSv4/flexfiles: honor FF_FLAGS_NO_IO_THRU_MDS on fatal DS connect errors
Thread-Index: oRWK2QyeRcqwSXw6EwmzoUo1ORxaCA==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[desy.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[desy.de:s=default];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22405-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:snitzer@kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tigran.mkrtchyan@desy.de,linux-nfs@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,desy.de:dkim,desy.de:mid,desy.de:from_mime];
	RCPT_COUNT_THREE(0.00)[4];
	HAS_ATTACHMENT(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tigran.mkrtchyan@desy.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[desy.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40538662FAE

------=_Part_3950200_1646942997.1781025242431
Date: Tue, 9 Jun 2026 19:14:02 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1103477872.3950199.1781025242395.JavaMail.zimbra@desy.de>
In-Reply-To: <20260604202403.20856-2-snitzer@kernel.org>
References: <20260604202403.20856-1-snitzer@kernel.org> <20260604202403.20856-2-snitzer@kernel.org>
Subject: Re: [PATCH 1/2] NFSv4/flexfiles: honor FF_FLAGS_NO_IO_THRU_MDS on
 fatal DS connect errors
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 10.1.17_GA_4874 (ZimbraWebClient - FF151 (Linux)/10.1.17_GA_4873)
Thread-Topic: NFSv4/flexfiles: honor FF_FLAGS_NO_IO_THRU_MDS on fatal DS connect errors
Thread-Index: oRWK2QyeRcqwSXw6EwmzoUo1ORxaCA==


Just to hand up. I built the proposed patches on top of 7.1.0-rc6 and
ran a bunch of tests against the dCache NFS server with flexfile layout
with tightly coupled NFSv4.1 DSes.

No smoking guns detected.

Thanks, Mile.

Best,
  Tigran.



----- Original Message -----
> From: "Mike Snitzer" <snitzer@kernel.org>
> To: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel=
.org>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Thursday, 4 June, 2026 22:24:02
> Subject: [PATCH 1/2] NFSv4/flexfiles: honor FF_FLAGS_NO_IO_THRU_MDS on fa=
tal DS connect errors

> Commit f06bedfa62d5 ("pNFS/flexfiles: don't attempt pnfs on fatal DS
> errors") teaches ff_layout_{read,write}_pagelist() to return
> PNFS_NOT_ATTEMPTED when nfs4_ff_layout_prepare_ds() fails with a
> nfs_error_is_fatal() errno (e.g. -ETIMEDOUT from a SOFTCONN connect
> deadline, -ENOMEM, -ERESTARTSYS), so that the client gives up instead
> of spinning.  pnfs_do_{read,write}() then dispatches the I/O through
> pnfs_{read,write}_through_mds() =E2=86=92 nfs_pageio_reset_{read,write}_m=
ds().
>=20
> That fallback is unconditional and silently violates FF_FLAGS_NO_IO_THRU_=
MDS:
> when the layout segment carries the flag (typically single-mirror
> appliance layouts where MDS I/O is explicitly forbidden), the
> out_failed: path's \`&& !ds_fatal_error\` clause overrides the flag's
> short-circuit through ff_layout_avoid_mds_available_ds() and routes
> the I/O to the MDS file handle anyway.
>=20
> This is reachable in practice during a data-server restart: SOFTCONN
> exhaustion produces -ETIMEDOUT, which is fatal per nfs_error_is_fatal(),
> which triggers PNFS_NOT_ATTEMPTED, which silently goes to MDS.
>=20
> Preserve the upstream "don't spin on fatal errors" intent for layouts
> that permit MDS fallback.  For layouts with FF_FLAGS_NO_IO_THRU_MDS
> set, mark the layout for return and request PNFS_TRY_AGAIN instead;
> if the server cannot supply a usable layout the failure now surfaces
> cleanly via pnfs_update_layout(), rather than via silent MDS I/O that
> contradicts the flag.
>=20
> Fixes: f06bedfa62d5 ("pNFS/flexfiles: don't attempt pnfs on fatal DS erro=
rs")
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
> fs/nfs/flexfilelayout/flexfilelayout.c | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
>=20
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c
> b/fs/nfs/flexfilelayout/flexfilelayout.c
> index 4d142f1fdf61a..38bcd260e0a91 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> @@ -2204,6 +2204,14 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hd=
r)
> out_failed:
> =09if (ff_layout_avoid_mds_available_ds(lseg) && !ds_fatal_error)
> =09=09return PNFS_TRY_AGAIN;
> +=09if (ff_layout_no_fallback_to_mds(lseg)) {
> +=09=09/*
> +=09=09 * FF_FLAGS_NO_IO_THRU_MDS: force fresh LAYOUTGET,
> +=09=09 * never fall through to MDS I/O.
> +=09=09 */
> +=09=09pnfs_error_mark_layout_for_return(hdr->inode, lseg);
> +=09=09return PNFS_TRY_AGAIN;
> +=09}
> =09trace_pnfs_mds_fallback_read_pagelist(hdr->inode,
> =09=09=09hdr->args.offset, hdr->args.count,
> =09=09=09IOMODE_READ, NFS_I(hdr->inode)->layout, lseg);
> @@ -2289,6 +2297,14 @@ ff_layout_write_pagelist(struct nfs_pgio_header *h=
dr, int
> sync)
> out_failed:
> =09if (ff_layout_avoid_mds_available_ds(lseg) && !ds_fatal_error)
> =09=09return PNFS_TRY_AGAIN;
> +=09if (ff_layout_no_fallback_to_mds(lseg)) {
> +=09=09/*
> +=09=09 * FF_FLAGS_NO_IO_THRU_MDS: force fresh LAYOUTGET,
> +=09=09 * never fall through to MDS I/O.
> +=09=09 */
> +=09=09pnfs_error_mark_layout_for_return(hdr->inode, lseg);
> +=09=09return PNFS_TRY_AGAIN;
> +=09}
> =09trace_pnfs_mds_fallback_write_pagelist(hdr->inode,
> =09=09=09hdr->args.offset, hdr->args.count,
> =09=09=09IOMODE_RW, NFS_I(hdr->inode)->layout, lseg);
> --
> 2.44.0

------=_Part_3950200_1646942997.1781025242431
Content-Type: application/pkcs7-signature; name=smime.p7s; smime-type=signed-data
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCAMIIF
2zCCBEOgAwIBAgIQBBL/+bEcDC3Q01JGn3M5ITANBgkqhkiG9w0BAQsFADBUMQswCQYDVQQGEwJO
TDEZMBcGA1UECgwQR0VBTlQgVmVyZW5pZ2luZzEqMCgGA1UEAwwhR0VBTlQgVENTIEF1dGhlbnRp
Y2F0aW9uIFJTQSBDQSA1MB4XDTI1MTIxMjE0MDk0MloXDTI3MDExMTE0MDk0MVowgakxEzARBgoJ
kiaJk/IsZAEZFgNvcmcxFjAUBgoJkiaJk/IsZAEZFgZ0ZXJlbmExEzARBgoJkiaJk/IsZAEZFgN0
Y3MxCzAJBgNVBAYTAkRFMS4wLAYDVQQKDCVEZXV0c2NoZXMgRWxla3Ryb25lbi1TeW5jaHJvdHJv
biBERVNZMSgwJgYDVQQDDB9UaWdyYW4gTWtydGNoeWFuIHRpZ3JhbkBkZXN5LmRlMIIBojANBgkq
hkiG9w0BAQEFAAOCAY8AMIIBigKCAYEArfnI6mD8MyGhRXT544OuIOATR0q0ViKjZWMjNO0PYJ7b
WrA2ahLCMyOw18kaAhArvmyhASlCZGHAeHjMPQAcRWoBQyLXkbusXBqxPQbApGXcXERNGXja00Xk
MrZCGe198EcRgn52hDbmcOhQPlyY/fKp3ukpPDLyQEeZFDDz4KeKFrZ6Qc3ps/yZqjQ2bXY8l93W
G+0DVbP6e2AM0DW4fWDYoafLvnMyl2J5yhYjYXtFkcV7iiDUuQH/lZvYvRQTzlir0jczribIPpss
zxcctqleZRX646qBT+lI0nP+EgdGPCXNteJGbwGHw7DQqXDk+0AIYShiiTMayRODX65uCwRG9iO5
mtibWMeFTzGOy8HG09PFlc8VG8+2pZtIYLPIof65dykviDm0vI0A36iaw7gI5RRy1K6dGpJscKU2
V5d+LlhVu5qjBayUfJQhy4jykZplaeXvQThZ9rg9ngz+FwlEz7tlM5U1hepzD7s1snyVaOGtRiQt
yWSUKcMB0DPJAgMBAAGjggFRMIIBTTAfBgNVHSMEGDAWgBSDrT4rvBOJjYgJHL8g3F+4MVXq8TBX
BggrBgEFBQcBAQRLMEkwRwYIKwYBBQUHMAKGO2h0dHA6Ly9jcnQuZ2VhbnQtcHJ2LmhhcmljYS5n
ci9HRUFOVC1UQ1MtQ2xpZW50LUF1dGgtUjUuY2VyMDUGA1UdIAQuMCwwDAYKKoZIhvdMBQICBTAN
BgsqhkiG90wFAgMDAzANBgsqhkiG90wFAgMBAjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUH
AwQwTAYDVR0fBEUwQzBBoD+gPYY7aHR0cDovL2NybC5nZWFudC1wcnYuaGFyaWNhLmdyL0dFQU5U
LVRDUy1DbGllbnQtQXV0aC1SNS5jcmwwHQYDVR0OBBYEFDxIMH6YFtPoOHuwqAzVWAjUq9klMA4G
A1UdDwEB/wQEAwIFoDANBgkqhkiG9w0BAQsFAAOCAYEAM3+V2E77QHQaDQSi0RRpdct0OrebGrBQ
1UZHmxhwyy1LaTERW/8J70lDP9FxYJlk77whB853mwW/LukNXzRNW/mgpuIlVQH+uooys5NbIgl2
zVuIhQ/7CWO3xYbKyxk8pUwvk43qR/hVprL0djOGm9Wr31AmryK9KMXpod95pv3hydpAPZi+4Kux
GtsmX69ggbcB518och4jij+KCtGCaFHjLbek40VYwAjIRSfwpVTKgFefkTEo+/G9KiJiT3p8Z/RL
6VDc+pB+GFNAW/+Z6nAkRWJKZFrVAEFqX2by2v+CTu9oLPUKiRTCEuSXCqwsMO40qzYT8Tjp9+sq
KfeGDPzRxd/J4G6JSsLpRrCesQnKRTwqEF6yUfvNyrqKe9fImt/UriOFjXcdPqAkhFWIr0d/fZQp
1upqYQ1PnuyfdOU4Ct6NN9PGopyB4i+iKWaECe4W4iPZsF+qWUmynQpbAwDu/UvBN3U4wdrDdeO6
XZ3HQ0q/aG67FOeLCkhOgnvqAAAxggLkMIIC4AIBATBoMFQxCzAJBgNVBAYTAk5MMRkwFwYDVQQK
DBBHRUFOVCBWZXJlbmlnaW5nMSowKAYDVQQDDCFHRUFOVCBUQ1MgQXV0aGVudGljYXRpb24gUlNB
IENBIDUCEAQS//mxHAwt0NNSRp9zOSEwDQYJYIZIAWUDBAIBBQCggc4wGAYJKoZIhvcNAQkDMQsG
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwNjA5MTcxNDAyWjAtBgkqhkiG9w0BCTQxIDAe
MA0GCWCGSAFlAwQCAQUAoQ0GCSqGSIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCB3NTwOpIXE2jZo
09Snl92bPTX7gP2BP2tkpq1ic9h8ozA0BgkqhkiG9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqG
SIb3DQMCAgIAgDAHBgUrDgMCBzANBgkqhkiG9w0BAQsFAASCAYAPYkV3MyC2+wcRLpC/H7wvzBhm
r3gzzjYmtB3RdluoHVcFMuVWao0i2CzWWocjFPF0mMJqdt1QRYMVYtPTG2CYuA4yUyzQIuapiiJV
pdNADWo9wRm75ODkvaNEnjOG+VLV8JOe/C/PLrh9p8CrMVsJRVLEHL2/UXbQKabZqh1EnHtBMsK4
o8L8jeM13wik5OwDhzIQj6OVnnAB6St5A6oW7TPsXDMf/Kx4JrTzHSjZWXlHexKxzSsxuIL/7i4L
mK0AkDOSLV7g4wUoR6VwOToxsxAX5xL2LehdWl8OUdE4WwsLSl8n2WK3pQmY+GglHwpKupTrVmrs
olgzaeotAXSXC3LxbPVt4LJHYhdszCMLE3fBgR0Ogg7xLrxHdzxuymSwtZ9q1OLALqsZS/PTRjoI
PpCKxAOwPyn0m5sPtsU7FbUtyHFqwRJvfjjq7GYjVonIs17T1mUnb9Nleslo9teEFU6OXV0vhOPU
3rXvFVv5q89+B358zNR3fStaufAAnhkAAAAAAAA=
------=_Part_3950200_1646942997.1781025242431--

