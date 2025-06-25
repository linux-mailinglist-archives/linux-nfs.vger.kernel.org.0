Return-Path: <linux-nfs+bounces-12790-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF32AAE8E6E
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 21:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C1B162B74
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 19:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71783275B04;
	Wed, 25 Jun 2025 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="gmnN5mTC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B11158218
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 19:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879177; cv=none; b=bmPI8j3T1mGTjJRcT3aiziFsqlvEh9+TNH9L8EAJQEZDKqE0H2b+u8XqlPbu7bwANC+m9/aMt0fRADFqtlM8I3KX+pBg0Ut5KLIfQzbCekCWgMhHbIhHtDdEagCHpwdAKhm2T7YrAhQDNTtlCc+TzGh4QU2VtatEeF5cZpC4nPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879177; c=relaxed/simple;
	bh=p8wqdiHEdinvW+R/oGDVcmnQBXCnzxVyDyEgavNj1B8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qgMtZLck8l36SYe3SkwvuHcAnatgKTFprKg8Zj6rYQl/4YQ2ZulivlvclzryX2lViBfHGZATDTYrIAO8uJYvp6o1mzMjQy6zeDxyRWad8SHdBXrqXiqNiGq94hReNQ63USg/vJkVnurHxP3ED+77XkLQDIX0JzU/BIjhGhNbl7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=gmnN5mTC; arc=none smtp.client-ip=131.169.56.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 8FB9611F746
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 21:19:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 8FB9611F746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1750879172; bh=JoPit0RLRpLtH+U5fvw6n6NVHxB3EPwWZsyxhl4t6lA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gmnN5mTCZ1CycJ9G2ZeFYlriFc6vcCn+sojv6bId1gfyOPMcEUAl2NODUPZnaNmfW
	 3LY1QOM23BedxH7IsZx2Sxi1gBQyODNQ4vIEaDMpFrqlHgKbGKh3p7NhIgAaOZBj4n
	 mYfUbFgSd7WWz6K/jk2KXxK0IgN8o/xjc8uNrI7Y=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 831ED20040;
	Wed, 25 Jun 2025 21:19:32 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [194.95.233.47])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 7852C40044;
	Wed, 25 Jun 2025 21:19:32 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id CFD8A320090;
	Wed, 25 Jun 2025 21:19:31 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 8AC3920044;
	Wed, 25 Jun 2025 21:19:31 +0200 (CEST)
Date: Wed, 25 Jun 2025 21:19:31 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Message-ID: <1758012324.14467514.1750879171477.JavaMail.zimbra@desy.de>
In-Reply-To: <20250609214303.816241-2-tigran.mkrtchyan@desy.de>
References: <20250609214303.816241-1-tigran.mkrtchyan@desy.de> <20250609214303.816241-2-tigran.mkrtchyan@desy.de>
Subject: Re: [PATCH 1/1] pNFS/flexfiles: mark device unavailable on fatal
 connection error
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_14467515_207929431.1750879171495"
X-Mailer: Zimbra 9.0.0_GA_4769 (ZimbraWebClient - FF140 (Linux)/9.0.0_GA_4769)
Thread-Topic: pNFS/flexfiles: mark device unavailable on fatal connection error
Thread-Index: terUNc8zNdMcuQpztHdRByULGFvemg==

------=_Part_14467515_207929431.1750879171495
Date: Wed, 25 Jun 2025 21:19:31 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Message-ID: <1758012324.14467514.1750879171477.JavaMail.zimbra@desy.de>
In-Reply-To: <20250609214303.816241-2-tigran.mkrtchyan@desy.de>
References: <20250609214303.816241-1-tigran.mkrtchyan@desy.de> <20250609214303.816241-2-tigran.mkrtchyan@desy.de>
Subject: Re: [PATCH 1/1] pNFS/flexfiles: mark device unavailable on fatal
 connection error
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4769 (ZimbraWebClient - FF140 (Linux)/9.0.0_GA_4769)
Thread-Topic: pNFS/flexfiles: mark device unavailable on fatal connection error
Thread-Index: terUNc8zNdMcuQpztHdRByULGFvemg==


Hi Folks,

Do you have any opinion on this one? Would you like me to address it differently?

Tigran. 

----- Original Message -----
> From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> To: "linux-nfs" <linux-nfs@vger.kernel.org>
> Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>, "Tigran Mkrtchyan"
> <tigran.mkrtchyan@desy.de>
> Sent: Monday, 9 June, 2025 23:43:03
> Subject: [PATCH 1/1] pNFS/flexfiles: mark device unavailable on fatal connection error

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
> The issue is reproducible with script as (there should be ~1000 files in
> a directory, client should must not have any connections to DSes):
> 
> ```
> echo 3 > /proc/sys/vm/drop_caches
> 
> for i in *
> do
>        head -1 $i &
>        PP=$!
>        sleep 10e-03
>        kill -TERM $PP
> done
> ```
> 
> Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
> ---
> fs/nfs/flexfilelayout/flexfilelayoutdev.c | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> index 4a304cf17c4b..0008a8180c9b 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> @@ -410,6 +410,10 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
> 			mirror->mirror_ds->ds_versions[0].wsize = max_payload;
> 		goto out;
> 	}
> +	/* There is a fatal error to connect to DS. Mark it unavailable to avoid
> infinite retry loop. */
> +	if (nfs_error_is_fatal(status))
> +		nfs4_mark_deviceid_unavailable(&mirror->mirror_ds->id_node);
> +
> noconnect:
> 	ff_layout_track_ds_error(FF_LAYOUT_FROM_HDR(lseg->pls_layout),
> 				 mirror, lseg->pls_range.offset,
> --
> 2.49.0

------=_Part_14467515_207929431.1750879171495
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
MBwGCSqGSIb3DQEJBTEPFw0yNTA2MjUxOTE5MzFaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEII7f61a7pMHaPpGgVkk9C8P3b+yS
vs2uAgurS4nnz+GEMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICAJsIVdGVc5syitF+IEzVjvew2VpanBA6TwI1KtYD
stFjw+teW4LiRu8Eqt/mzlXO/EQpsjz77gg6AUxSMgrAN207foqY4IXSjRxT0+HJObU3/MDdTER7
qz4VtnuoLLcvRW+RtK+HrtthjGnmfkFLycS2qdWX+szpnM/rFKAh59A+kiHOcj5FncGb05mrSTrL
o7fTAkxzxJLF+AQxOwnFL3dCue05vfAh5PooJR2S8asU3556OC5AnTnWKOIiAHDJ14mj8E6/WPuM
KEXbcZo+FKcgJVmG/freg6AtHUGQPHKZB5oktCOPNVtZqnIzFrqJNzY7H9YJSh7zqoeaO/3aDeuz
QSJmd4LeSfJajff0D81POnlYQSSRiD1xhxjv8MDNIPFT1o7opI6pU0SMycePONLVQgHdB43DUzwV
a+/PTDZC3YfXIFP10vtoan223iT/8JICTQKRNDC7KwXFc5TW3cmEr/3FhzssC27vLww4s6IC7kpx
i9E9SuxCDckgrQqXRSV5RLiO+++Kfe5vMAV3SmdOJaIYET06z3eKmnydGXk0LAmb3nMPCc0xOQfw
HWfSu9c36Fg8QkaXzMMLSuNDUVAkAssJFlD16bAnkWLiNvTonSb3W7KOzeEa4gR+zO0TlucRs6wt
H/W+P1+YpPdxHprHnzGm7Z9jy1ymC45fd9t/AAAAAAAA
------=_Part_14467515_207929431.1750879171495--

