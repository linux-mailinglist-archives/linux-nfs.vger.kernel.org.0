Return-Path: <linux-nfs+bounces-12799-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1BEAE99C1
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Jun 2025 11:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB0D3B5B95
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Jun 2025 09:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6B315B971;
	Thu, 26 Jun 2025 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="aWOfqFcI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B3C3594E
	for <linux-nfs@vger.kernel.org>; Thu, 26 Jun 2025 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750929443; cv=none; b=aI1dkz50Db3sQ+xPoCmdSNgSo/I5cdvPLWlDBdsgCxv01U36qJFXQwX7TYaOKoFDOOWnxnbL2LAqwY42XoJIHB/HUyPxkNT2JVfe7wbDGiv73fC8AnwaWL2LMWQFKK6sg2mHHCa/YpO7Fi+iv3Dc44Z65ECo2LeRXIAaDhPsMAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750929443; c=relaxed/simple;
	bh=xINFRXFYidgR9Cc/u1RsqrYx4oxslKTf9aophd2LNEU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=VHInmiVuh4v73V04tfQoHJlhmeqflGSe3fWbeGe366qmdyrQKq7fpDjENsIDAbV46ImTTuW9/Sq0c6cW5ZUuLuAhK7Td6K3Jcs44PJvkAYkNwCBzMfMripPssk2O2dZqCjVQknp17RIfE2FFDwXPPVOncO5KIRUbLQCJcKfoxjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=aWOfqFcI; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 7170B13F648
	for <linux-nfs@vger.kernel.org>; Thu, 26 Jun 2025 11:17:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 7170B13F648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1750929439; bh=xINFRXFYidgR9Cc/u1RsqrYx4oxslKTf9aophd2LNEU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=aWOfqFcIMr7TJDgsloGJKQWn+N5uewtlQZZRYMKavDNeZSQLRErf3LWzhqHZia3SO
	 gL1RyC3w4iQxblb5+rgV0PcEXjjm23us3GA+8/aHf2RBhJvS3TyaX+TPAHu6G/nEas
	 +DsZw0G5RYt3Ch/nK3CxuVE/T27/4l8W7rklaHzY=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 67E6620040;
	Thu, 26 Jun 2025 11:17:19 +0200 (CEST)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [IPv6:2001:638:d:c303:acdc:1979:2:e7])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 5A67C40086;
	Thu, 26 Jun 2025 11:17:19 +0200 (CEST)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [IPv6:2001:638:700:1038::1:52])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id BC24310A3CC;
	Thu, 26 Jun 2025 11:17:18 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 94C0380046;
	Thu, 26 Jun 2025 11:17:18 +0200 (CEST)
Date: Thu, 26 Jun 2025 11:17:18 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>, Anna Schumaker <anna@kernel.org>
Message-ID: <1004506484.223854.1750929438192.JavaMail.zimbra@desy.de>
In-Reply-To: <e2a8b1e647e9d5f74e0ab5dd0924495625a02d3f.camel@kernel.org>
References: <20250609214303.816241-1-tigran.mkrtchyan@desy.de> <20250609214303.816241-2-tigran.mkrtchyan@desy.de> <1758012324.14467514.1750879171477.JavaMail.zimbra@desy.de> <e2a8b1e647e9d5f74e0ab5dd0924495625a02d3f.camel@kernel.org>
Subject: Re: [PATCH 1/1] pNFS/flexfiles: mark device unavailable on fatal
 connection error
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_223855_489562866.1750929438503"
X-Mailer: Zimbra 9.0.0_GA_4769 (ZimbraWebClient - FF140 (Linux)/9.0.0_GA_4769)
Thread-Topic: pNFS/flexfiles: mark device unavailable on fatal connection error
Thread-Index: +5zsxsDm5DFRQbYuW3E8V/h/BaF7Yw==

------=_Part_223855_489562866.1750929438503
Date: Thu, 26 Jun 2025 11:17:18 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>, Anna Schumaker <anna@kernel.org>
Message-ID: <1004506484.223854.1750929438192.JavaMail.zimbra@desy.de>
In-Reply-To: <e2a8b1e647e9d5f74e0ab5dd0924495625a02d3f.camel@kernel.org>
References: <20250609214303.816241-1-tigran.mkrtchyan@desy.de> <20250609214303.816241-2-tigran.mkrtchyan@desy.de> <1758012324.14467514.1750879171477.JavaMail.zimbra@desy.de> <e2a8b1e647e9d5f74e0ab5dd0924495625a02d3f.camel@kernel.org>
Subject: Re: [PATCH 1/1] pNFS/flexfiles: mark device unavailable on fatal
 connection error
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_GA_4769 (ZimbraWebClient - FF140 (Linux)/9.0.0_GA_4769)
Thread-Topic: pNFS/flexfiles: mark device unavailable on fatal connection error
Thread-Index: +5zsxsDm5DFRQbYuW3E8V/h/BaF7Yw==

I posted a different patch with the suggested approach.=20

Tigran.

----- Original Message -----
> From: "Trond Myklebust" <trondmy@kernel.org>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>, "linux-nfs" <linux-nfs=
@vger.kernel.org>
> Cc: "Anna Schumaker" <anna@kernel.org>
> Sent: Wednesday, 25 June, 2025 21:39:15
> Subject: Re: [PATCH 1/1] pNFS/flexfiles: mark device unavailable on fatal=
 connection error

> On Wed, 2025-06-25 at 21:19 +0200, Mkrtchyan, Tigran wrote:
>>=20
>> Hi Folks,
>>=20
>> Do you have any opinion on this one? Would you like me to address it
>> differently?
>>=20
>=20
> I don't think we should mark the device as being unavailable just
> because someone signalled the RPC task.
>=20
> It would be better to have nfs4_ff_layout_prepare_ds() return any fatal
> errors that it encounters using ERR_PTR(), so that the callers can
> handle them. Then maybe return ERR_PTR(-EAGAIN) for the case where we
> currently return NULL so that those callers don't have to use the hated
> IS_ERR_OR_NULL() test.
>=20
>> Tigran.
>>=20
>> ----- Original Message -----
>> > From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
>> > To: "linux-nfs" <linux-nfs@vger.kernel.org>
>> > Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker"
>> > <anna@kernel.org>, "Tigran Mkrtchyan"
>> > <tigran.mkrtchyan@desy.de>
>> > Sent: Monday, 9 June, 2025 23:43:03
>> > Subject: [PATCH 1/1] pNFS/flexfiles: mark device unavailable on
>> > fatal connection error
>>=20
>> > Fixes: 260f32adb88 ("pNFS/flexfiles: Check the result of
>> > nfs4_pnfs_ds_connect")
>> >=20
>> > When an applications get killed (SIGTERM/SIGINT) while pNFS client
>> > performs a
>> > connection
>> > to DS, client ends in an infinite loop of connect-disconnect. This
>> > source of the issue, it that
>> > flexfilelayoutdev#nfs4_ff_layout_prepare_ds gets an
>> > error
>> > on nfs4_pnfs_ds_connect with status ERESTARTSYS, which is set by
>> > rpc_signal_task, but
>> > the error is treated as transient, thus retried.
>> >=20
>> > The issue is reproducible with script as (there should be ~1000
>> > files in
>> > a directory, client should must not have any connections to DSes):
>> >=20
>> > ```
>> > echo 3 > /proc/sys/vm/drop_caches
>> >=20
>> > for i in *
>> > do
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 head -1 $i &
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PP=3D$!
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 10e-03
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kill -TERM $PP
>> > done
>> > ```
>> >=20
>> > Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
>> > ---
>> > fs/nfs/flexfilelayout/flexfilelayoutdev.c | 4 ++++
>> > 1 file changed, 4 insertions(+)
>> >=20
>> > diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
>> > b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
>> > index 4a304cf17c4b..0008a8180c9b 100644
>> > --- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
>> > +++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
>> > @@ -410,6 +410,10 @@ nfs4_ff_layout_prepare_ds(struct
>> > pnfs_layout_segment *lseg,
>> > =09=09=09mirror->mirror_ds->ds_versions[0].wsize =3D
>> > max_payload;
>> > =09=09goto out;
>> > =09}
>> > +=09/* There is a fatal error to connect to DS. Mark it
>> > unavailable to avoid
>> > infinite retry loop. */
>> > +=09if (nfs_error_is_fatal(status))
>> > +=09=09nfs4_mark_deviceid_unavailable(&mirror->mirror_ds-
>> > >id_node);
>> > +
>> > noconnect:
>> > =09ff_layout_track_ds_error(FF_LAYOUT_FROM_HDR(lseg-
>> > >pls_layout),
>> > =09=09=09=09 mirror, lseg->pls_range.offset,
>> > --
>> > 2.49.0
>=20
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com

------=_Part_223855_489562866.1750929438503
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
MBwGCSqGSIb3DQEJBTEPFw0yNTA2MjYwOTE3MThaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEINF2YwSgOn4I7N7W8TgUeGJJtBFO
GEUmRF4+twXOAtzmMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICAG+AJ2x1UPLTFhhZzjWPr5pF4PrcEDypxc2iF2J2
NSUz/fFDeeVnn4ZpG0FkWQYT1QO3rd8K6q+/d3KeCWm3b8TaL7linI6fsQHzS0X68xLJ6ZzN2hIN
D5WFzWTKUVyXpFMA3BER32tOAyAogGk0EUi0qIA1tvp2G5Ewn7JB7ygVJlxXjSI0rZbYc7yTWhYS
bpRz50h/C6VpNU7AVVTHf33zYmZCoWjoNh6cVflIMZ1seaPmRASmMsCIt/i0NKNzGG6twF+pbljw
ZQct7ppWuSaIL+90+E47G9MjUTpPVLehomZFyClJInRTo+jbHrP8QW+B6lQ+JffEgLVLoH3YSSMw
v3HjJlH6JZO1M8xW1lj1heJjdOeG/EuTuXhLG5vA9pKTELdc5jXW9jUo4aZOanH/kFrXgSgXDZdf
cwK0B60XMYNe8T662nKzPVCnEgSDCo2JyG5piYNQSNQtvWjTFXtiswYcWySWo0sRSVoFTgUii2/0
hnm7tSCueQfJu2WsERoale5vnjf56H65Yn4IApPhJ20Ze/ypCuwU8aIf0WjvbhR3JyDdeAPufPHN
AqlzfMpq2m+NyTmTcAs+9OrLpdaf399qWjIVtSjynsOyqjvZ8YQgH/62yaz0Zr5GdGXfD2gs62gl
SJzvTb7Bdl1oK8GuIluJBGroPTqLbTRWFhIPAAAAAAAA
------=_Part_223855_489562866.1750929438503--

