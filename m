Return-Path: <linux-nfs+bounces-13485-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F155FB1DBB7
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 18:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1631D7228A1
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 16:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C114E49641;
	Thu,  7 Aug 2025 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="bPvy1TkK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E07910957
	for <linux-nfs@vger.kernel.org>; Thu,  7 Aug 2025 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754584394; cv=none; b=HF8OT/HZUxDKAEzUmG7yIu8SKuypjw8L6XgXk++NkGrTDKhjW8Mry8mDCCYTMONkgSuU+JsolEjKawE0LZ1M+qNQDDM7OEkuNxaGR0ywHVGZKUhQ1b9B40jrG18GKJYOm9QrxHuBlhtNBz1LnJW0orSU+r7KZyc1hv/k1VApPRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754584394; c=relaxed/simple;
	bh=hVUAFq4x3DV3u0CRjbRvsxbp0pt7NfmU+SFE5FBpLGU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=iPvKmNBtQx59o7mdpHwzmZRzuMu1zyUmbJnnNhJCW86wifThOhCXnqaft5jMuej64M/zFKOA0iVq2jmD+8Ci4NSTVVnXBALDzCx5NcA9Q5fgIytsmiWrmgxL/0HUbseA304TYQ6G6CPr9TWzJ6d0jybnxjFBIufJt0AfZeATb/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=bPvy1TkK; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 09C1B13F647
	for <linux-nfs@vger.kernel.org>; Thu,  7 Aug 2025 18:33:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 09C1B13F647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1754584382; bh=kCzkkGknvm2/G3u++rXPXZiaQSZHYMZch88zvYMcBI4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=bPvy1TkK/sWIesAL6ldnXi35h3475i05v6yS76IKgjwx9D+/iYT2gwXNdhr4PYSn4
	 3V4m8TT8DQD2Ii39CE3yP2BkXCxKI28Gu9KuT/+6nbbFoQBidKf54/BOhQ5y0esYV8
	 NiKNkTKz4X9BHFnH8boO7kISAJ95pQSC83608eiU=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id E71C5120043;
	Thu,  7 Aug 2025 18:33:01 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [IPv6:2001:638:d:c301:acdc:1979:2:e7])
	by smtp-m-2.desy.de (Postfix) with ESMTP id D747916003F;
	Thu,  7 Aug 2025 18:33:01 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [131.169.56.83])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id 2076E3200AA;
	Thu,  7 Aug 2025 18:33:01 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 025F82004C;
	Thu,  7 Aug 2025 18:33:01 +0200 (CEST)
Date: Thu, 7 Aug 2025 18:33:00 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Haihua Yang <yanghh@gmail.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1473033738.919249.1754584380847.JavaMail.zimbra@desy.de>
In-Reply-To: <CALzt5Pk81rdgaBhk=s+cHEeSAP3rFrrsD3Q3Sx5rCsi_jkWuqQ@mail.gmail.com>
References: <CALzt5Pk81rdgaBhk=s+cHEeSAP3rFrrsD3Q3Sx5rCsi_jkWuqQ@mail.gmail.com>
Subject: Re: LAYOUTCOMMIT Failure After CB_LAYOUTRECALL in pNFS Filelayout
 Scenario
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_919250_1193571496.1754584380943"
X-Mailer: Zimbra 10.1.10_GA_4785 (ZimbraWebClient - FF141 (Linux)/10.1.10_GA_4785)
Thread-Topic: LAYOUTCOMMIT Failure After CB_LAYOUTRECALL in pNFS Filelayout Scenario
Thread-Index: b5FEJJ88OFXffBy0e4DJu3XTFXRTuA==

------=_Part_919250_1193571496.1754584380943
Date: Thu, 7 Aug 2025 18:33:00 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Haihua Yang <yanghh@gmail.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1473033738.919249.1754584380847.JavaMail.zimbra@desy.de>
In-Reply-To: <CALzt5Pk81rdgaBhk=s+cHEeSAP3rFrrsD3Q3Sx5rCsi_jkWuqQ@mail.gmail.com>
References: <CALzt5Pk81rdgaBhk=s+cHEeSAP3rFrrsD3Q3Sx5rCsi_jkWuqQ@mail.gmail.com>
Subject: Re: LAYOUTCOMMIT Failure After CB_LAYOUTRECALL in pNFS Filelayout
 Scenario
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 10.1.10_GA_4785 (ZimbraWebClient - FF141 (Linux)/10.1.10_GA_4785)
Thread-Topic: LAYOUTCOMMIT Failure After CB_LAYOUTRECALL in pNFS Filelayout Scenario
Thread-Index: b5FEJJ88OFXffBy0e4DJu3XTFXRTuA==



----- Original Message -----
> From: "Haihua Yang" <yanghh@gmail.com>
> To: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Thursday, 7 August, 2025 18:14:57
> Subject: LAYOUTCOMMIT Failure After CB_LAYOUTRECALL in pNFS Filelayout Sc=
enario

> I'm observing a consistent failure of LAYOUTCOMMIT when the NFS client
> accesses a pNFS share using filelayout. Below is the sequence of
> events:
>  1, The client opens a file for writing and successfully receives a
> layout (stateid with seqid =3D 1).
>  2, The client writes data to the data server (DS) successfully.
>  3, The NFS server sends a CB_LAYOUTRECALL (stateid with seqid =3D 2)
> due to some change on the server side.
>  4, The client sends a LAYOUTCOMMIT (still with seqid =3D 1), followed
> by a LAYOUTRETURN (with seqid =3D 2).
>  5, The server responds to LAYOUTCOMMIT with NFS4ERR_OLD_STATEID.
>  6, The server responds to LAYOUTRETURN with NFS4ERR_OK.
>  7, The client retries LAYOUTCOMMIT (still using seqid =3D 1).
>  8, The server replies with NFS4ERR_BAD_STATEID because the state was
> already removed when processing the LAYOUTRETURN.
>=20
> It seems there may be two issues with the Linux NFS client=E2=80=99s beha=
vior:
>  1, The client should not send LAYOUTRETURN before receiving a
> non-retryable response to LAYOUTCOMMIT.
>  2, After receiving a CB_LAYOUTRECALL, the client should not continue
> using the old seqid.

I think this question should go to NFSv4 IETF working group list.
Noetheless, rfc8881 says:

   For CB_LAYOUTRECALL arguments, the client MUST send a response to the re=
call before using the seqid.

So, it sounds, as long as the client hasn't responded to CB_LAYOUTRECALL, t=
he 'valid' seqid is 1. Thus,
LAYOUTCOMMIT seqid=3D1, LAYOUTRETURN seqid=3D2 looks correct.

See: https://datatracker.ietf.org/doc/html/rfc8881#layout_stateid

Best regards,
   Tigran.

>=20
> Would you consider this a bug in the client? Or is there something I
> may have misunderstood in the protocol behavior?
>=20
> Thanks,
> Haihua Yang

------=_Part_919250_1193571496.1754584380943
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
MBwGCSqGSIb3DQEJBTEPFw0yNTA4MDcxNjMzMDFaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIArS6nTnmMvzZTglqv1RCmtZSHQF
P3uRz45zt0VgpwU8MDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICAEW5TaaA8VHWdB7h/z33jDScUdBFpyr/oaqvlpv/
cWswI/nAhMrMy/sNDi5pY5OkSX9YlkPrV+1mvES4HBhG+U5x15ZvVnm2tt6kbg6AhflD9ds4sFWL
wmdkwSktqft8wnxJdrGxHZur2SEwwYyDcwyiYCCV7mRRXNWcF3iGyjumneIu1MP6QVyZY5PyvlnY
14N7mD0OwRiiFMOCWJvkPyHQR+FDH8CEybsupzUeILwKE2VNRqqsyMvqlg4FrMhXdoqp5tPHCO4C
aBdIcLcRMHiwDYrM+T5e4cyy+XO81FfgLPw4z2eBugKj7dqC3+uLHUzX3m785vvrp/zhDkZ432rS
boEcY1lOSbMhF27YmEnTZW9AeMtDUzxY62WfGavDi6NBDtczY+osDgKPI+1879N/7sXriNC6I60x
PiXP0OsJjnpFG1GbtvrUi9V9TP6ea5V+CaFhzBuowPScl+Uq62HZjwC6bShepMSeSpCJUWENNkNn
u7dIbNiGxk1ukVe4WPZsz9598D8ofCfdxbfa5Z4l1up0eE3QgL1cWKXhffkpz9RLccoMHUC8Omgn
ec1Uu2eZN6KViTKkFWbkgHFdbG/bMMKNLjh0TV4I2ygCrOIrJ9iosREq/nra8JGiOjdKhgMo1lUp
u7Wk6V+kdRwsfVZllqfniFUdkfOEvJIEG9xGAAAAAAAA
------=_Part_919250_1193571496.1754584380943--

