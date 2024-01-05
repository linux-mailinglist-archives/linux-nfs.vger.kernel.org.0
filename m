Return-Path: <linux-nfs+bounces-950-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B97824CCC
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jan 2024 03:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A092DB2285E
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jan 2024 02:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CB41FC8;
	Fri,  5 Jan 2024 02:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="Iio819W8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.ad.secure-endpoints.com [208.125.0.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB224A0E
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jan 2024 02:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
	d=auristor.com; s=MDaemon; r=y; t=1704420833; x=1705025633;
	i=jaltman@auristor.com; q=dns/txt; h=Message-ID:Date:
	MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	References:From:Organization:In-Reply-To:Content-Type; bh=EyY5K4
	3ZxbeNKLS77u/lbdVvK03ncy5VeZcZKlUqzlw=; b=Iio819W8SDlb1fKZScE3CG
	wLWw7JrFHkPyt4iV1bwxx9V45TdAu8H/fLmqG1brawwksXm/4iq3JrZKnFt3Q2EN
	XuWLeJdtRzNPoyck9umiw3DkA57nddAVxku5F+2O1jXqrkXHZgi24UgUOC6jh1pn
	EoVsSl672UaGpXAbMmWY8=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Thu, 04 Jan 2024 21:13:53 -0500
Received: from [IPV6:2603:7000:73c:c800:199f:1b35:3bd5:843e] by auristor.com (IPv6:2001:470:1f07:f77:28d9:68fb:855d:c2a5) (MDaemon PRO v23.5.2a) 
	with ESMTPSA id md5001003770368.msg; Thu, 04 Jan 2024 21:13:52 -0500
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Thu, 04 Jan 2024 21:13:52 -0500
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:c800:199f:1b35:3bd5:843e
X-MDHelo: [IPV6:2603:7000:73c:c800:199f:1b35:3bd5:843e]
X-MDArrival-Date: Thu, 04 Jan 2024 21:13:52 -0500
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1734dd26fb=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-nfs@vger.kernel.org
Message-ID: <cd1d6f0d-a05b-412c-882a-e62ee9e67b85@auristor.com>
Date: Thu, 4 Jan 2024 21:13:34 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 067/156] keys, dns: Allow key types (eg. DNS) to be
 reclaimed immediately on expiry
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, David Howells <dhowells@redhat.com>,
 Markus Suvanto <markus.suvanto@gmail.com>, Wang Lei <wang840925@gmail.com>,
 Jeff Layton <jlayton@redhat.com>, Steve French <smfrench@gmail.com>,
 Marc Dionne <marc.dionne@auristor.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 keyrings@vger.kernel.org, netdev@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
References: <20231230115812.333117904@linuxfoundation.org>
 <20231230115814.539935693@linuxfoundation.org>
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
In-Reply-To: <20231230115814.539935693@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms040802090304090309010709"
X-MDCFSigsAdded: auristor.com

This is a cryptographically signed message in MIME format.

--------------ms040802090304090309010709
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/30/2023 6:58 AM, Greg Kroah-Hartman wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: David Howells <dhowells@redhat.com>
>
> [ Upstream commit 39299bdd2546688d92ed9db4948f6219ca1b9542 ]
Greg,

Upstream commit 39299bdd2546688d92ed9db4948f6219ca1b9542 ("keys, dns: 
Allow key types (eg. DNS) to be reclaimed immediately on expiry") was 
subsequently fixed by

   commit 1997b3cb4217b09e49659b634c94da47f0340409
   Author: Edward Adam Davis <eadavis@qq.com>
   Date:   Sun Dec 24 00:02:49 2023 +0000

     keys, dns: Fix missing size check of V1 server-list header

   Fixes: b946001d3bb1 ("keys, dns: Allow key types (eg. DNS) to be 
reclaimed immediately on expiry")

If it is not too late, would it be possible to apply 1997b3cb421 to the 
branches b946001d3bb1 was cherry-picked to before release?
I believe the complete set of branches are

   linux-6.6.y, linux-6.1.y, linux-5.15.y, linux-5.10.y, linux-5.0.y

Thank you.

Jeffrey Altman


--------------ms040802090304090309010709
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DHEwggXSMIIEuqADAgECAhBAAYJpmi/rPn/F0fJyDlzMMA0GCSqGSIb3DQEBCwUAMDoxCzAJ
BgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEz
MB4XDTIyMDgwNDE2MDQ0OFoXDTI1MTAzMTE2MDM0OFowcDEvMC0GCgmSJomT8ixkAQETH0Ew
MTQxMEQwMDAwMDE4MjY5OUEyRkQyMDAwMjMzQ0QxGTAXBgNVBAMTEEplZmZyZXkgRSBBbHRt
YW4xFTATBgNVBAoTDEF1cmlTdG9yIEluYzELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCkC7PKBBZnQqDKPtZPMLAy77zo2DPvwtGnd1hNjPvbXrpGxUb3
xHZRtv179LHKAOcsY2jIctzieMxf82OMyhpBziMPsFAG/ukihBMFj3/xEeZVso3K27pSAyyN
fO/wJ0rX7G+ges22Dd7goZul8rPaTJBIxbZDuaykJMGpNq4PQ8VPcnYZx+6b+nJwJJoJ46kI
EEfNh3UKvB/vM0qtxS690iAdgmQIhTl+qfXq4IxWB6b+3NeQxgR6KLU4P7v88/tvJTpxIKkg
9xj89ruzeThyRFd2DSe3vfdnq9+g4qJSHRXyTft6W3Lkp7UWTM4kMqOcc4VSRdufVKBQNXjG
IcnhAgMBAAGjggKcMIICmDAOBgNVHQ8BAf8EBAMCBPAwgYQGCCsGAQUFBwEBBHgwdjAwBggr
BgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVudHJ1c3QuY29tMEIGCCsGAQUF
BzAChjZodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2NlcnRzL3RydXN0aWRjYWEx
My5wN2MwHwYDVR0jBBgwFoAULbfeG1l+KpguzeHUG+PFEBJe6RQwCQYDVR0TBAIwADCCASsG
A1UdIASCASIwggEeMIIBGgYLYIZIAYb5LwAGAgEwggEJMEoGCCsGAQUFBwIBFj5odHRwczov
L3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRpZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRt
bDCBugYIKwYBBQUHAgIwga0MgapUaGlzIFRydXN0SUQgQ2VydGlmaWNhdGUgaGFzIGJlZW4g
aXNzdWVkIGluIGFjY29yZGFuY2Ugd2l0aCBJZGVuVHJ1c3QncyBUcnVzdElEIENlcnRpZmlj
YXRlIFBvbGljeSBmb3VuZCBhdCBodHRwczovL3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRp
ZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRtbDBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8v
dmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2NybC90cnVzdGlkY2FhMTMuY3JsMB8GA1UdEQQY
MBaBFGphbHRtYW5AYXVyaXN0b3IuY29tMB0GA1UdDgQWBBQB+nzqgljLocLTsiUn2yWqEc2s
gjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAJwV
eycprp8Ox1npiTyfwc5QaVaqtoe8Dcg2JXZc0h4DmYGW2rRLHp8YL43snEV93rPJVk6B2v4c
WLeQfaMrnyNeEuvHx/2CT44cdLtaEk5zyqo3GYJYlLcRVz6EcSGHv1qPXgDT0xB/25etwGYq
utYF4Chkxu4KzIpq90eDMw5ajkexw+8ARQz4N5+d6NRbmMCovd7wTGi8th/BZvz8hgKUiUJo
Qle4wDxrdXdnIhCP7g87InXKefWgZBF4VX21t2+hkc04qrhIJlHrocPG9mRSnnk2WpsY0MXt
a8ivbVKtfpY7uSNDZSKTDi1izEFH5oeQdYRkgIGb319a7FjslV8wggaXMIIEf6ADAgECAhBA
AXA7OrqBjMk8rp4OuNQSMA0GCSqGSIb3DQEBCwUAMEoxCzAJBgNVBAYTAlVTMRIwEAYDVQQK
EwlJZGVuVHJ1c3QxJzAlBgNVBAMTHklkZW5UcnVzdCBDb21tZXJjaWFsIFJvb3QgQ0EgMTAe
Fw0yMDAyMTIyMTA3NDlaFw0zMDAyMTIyMTA3NDlaMDoxCzAJBgNVBAYTAlVTMRIwEAYDVQQK
EwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEzMIIBIjANBgkqhkiG9w0BAQEF
AAOCAQ8AMIIBCgKCAQEAu6sUO01SDD99PM+QdZkNxKxJNt0NgQE+Zt6ixaNP0JKSjTd+SG5L
wqxBWjnOgI/3dlwgtSNeN77AgSs+rA4bK4GJ75cUZZANUXRKw/et8pf9Qn6iqgB63OdHxBN/
15KbM3HR+PyiHXQoUVIevCKW8nnlWnnZabT1FejOhRRKVUg5HACGOTfnCOONrlxlg+m1Vjgn
o1uNqNuLM/jkD1z6phNZ/G9IfZGI0ppHX5AA/bViWceX248VmefNhSR14ADZJtlAAWOi2un0
3bqrBPHA9nDyXxI8rgWLfUP5rDy8jx2hEItg95+ORF5wfkGUq787HBjspE86CcaduLka/Bk2
VwIDAQABo4IChzCCAoMwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwgYkG
CCsGAQUFBwEBBH0wezAwBggrBgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVu
dHJ1c3QuY29tMEcGCCsGAQUFBzAChjtodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29t
L3Jvb3RzL2NvbW1lcmNpYWxyb290Y2ExLnA3YzAfBgNVHSMEGDAWgBTtRBnA0/AGi+6ke75C
5yZUyI42djCCASQGA1UdIASCARswggEXMIIBEwYEVR0gADCCAQkwSgYIKwYBBQUHAgEWPmh0
dHBzOi8vc2VjdXJlLmlkZW50cnVzdC5jb20vY2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRl
eC5odG1sMIG6BggrBgEFBQcCAjCBrQyBqlRoaXMgVHJ1c3RJRCBDZXJ0aWZpY2F0ZSBoYXMg
YmVlbiBpc3N1ZWQgaW4gYWNjb3JkYW5jZSB3aXRoIElkZW5UcnVzdCdzIFRydXN0SUQgQ2Vy
dGlmaWNhdGUgUG9saWN5IGZvdW5kIGF0IGh0dHBzOi8vc2VjdXJlLmlkZW50cnVzdC5jb20v
Y2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRleC5odG1sMEoGA1UdHwRDMEEwP6A9oDuGOWh0
dHA6Ly92YWxpZGF0aW9uLmlkZW50cnVzdC5jb20vY3JsL2NvbW1lcmNpYWxyb290Y2ExLmNy
bDAdBgNVHQ4EFgQULbfeG1l+KpguzeHUG+PFEBJe6RQwHQYDVR0lBBYwFAYIKwYBBQUHAwIG
CCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4ICAQB/7BKcygLX6Nl4a03cDHt7TLdPxCzFvDF2
bkVYCFTRX47UfeomF1gBPFDee3H/IPlLRmuTPoNt0qjdpfQzmDWN95jUXLdLPRToNxyaoB5s
0hOhcV6H08u3FHACBif55i0DTDzVSaBv0AZ9h1XeuGx4Fih1Vm3Xxz24GBqqVudvPRLyMJ7u
6hvBqTIKJ53uCs3dyQLZT9DXnp+kJv8y7ZSAY+QVrI/dysT8avtn8d7k7azNBkfnbRq+0e88
QoBnel6u+fpwbd5NLRHywXeH+phbzULCa+bLPRMqJaW2lbhvSWrMHRDy3/d8HvgnLCBFK2s4
Spns4YCN4xVcbqlGWzgolHCKUH39vpcsDo1ymZFrJ8QR6ihIn8FmJ5oKwAnnd/G6ADXFC9bu
db9+532phSAXOZrrecIQn+vtP366PC+aClAPsIIDJDsotS5z4X2JUFsNIuEgXGqhiKE7SuZb
rFG9sdcLprSlJN7TsRDc0W2b9nqwD+rj/5MN0C+eKwha+8ydv0+qzTyxPP90KRgaegGowC4d
UsZyTk2n4Z3MuAHX5nAZL/Vh/SyDj/ajorV44yqZBzQ3ChKhXbfUSwe2xMmygA2Z5DRwMRJn
p/BscizYdNk2WXJMTnH+wVLN8sLEwEtQR4eTLoFmQvrK2AMBS9kW5sBkMzINt/ZbbcZ3F+eA
MDGCAxQwggMQAgEBME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUG
A1UEAxMOVHJ1c3RJRCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwDQYJYIZIAWUDBAIBBQCg
ggGXMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDEwNTAy
MTMzNFowLwYJKoZIhvcNAQkEMSIEIFFTReKUjre1AmcsxXuYiHHnOg0SiXa/XVXzMyuFOmFu
MF0GCSsGAQQBgjcQBDFQME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEX
MBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwXwYLKoZIhvcNAQkQ
AgsxUKBOMDoxCzAJBgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRy
dXN0SUQgQ0EgQTEzAhBAAYJpmi/rPn/F0fJyDlzMMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZI
hvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEAie9f
MBHbfCX2VV6HqWhxJtXwZw70QhmnxCw0YwWiyIb2E+geXGkS17f/+JKS0ZMI8g/RcuZdRaTT
h07tdcRLyWt1zSktWBkEmgXik3nZYt1yIGOryH5JbswUzwVJHnvdMhiz2luDkElm04bCrUz/
fabOqJA/x2Q5mzgbQYeE8eYhk8o6Tsx6KsMfXtjIWwIOk4k+8rwpaytX2yZpWi1orymKhYRr
PdQJEQ8FdEeG8QdTS+JGLMLInRBP+gBIgtgiT8KNXzgiQYKtC9m3nISp3O8pA63SluCx7Ey+
MCrD0B3fTrjEPbrSuAv20wxDzQHE+XriIZ5uV4NcgQG3BT4zGQAAAAAAAA==
--------------ms040802090304090309010709--


