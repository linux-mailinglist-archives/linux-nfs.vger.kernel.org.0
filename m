Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3D0326479
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Feb 2021 16:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhBZPEe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Feb 2021 10:04:34 -0500
Received: from btbn.de ([5.9.118.179]:41120 "EHLO btbn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230042AbhBZPEc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 26 Feb 2021 10:04:32 -0500
Received: from [IPv6:2001:16b8:64c0:6700:50d3:5f50:f141:161] (200116b864c0670050d35f50f1410161.dip.versatel-1u1.de [IPv6:2001:16b8:64c0:6700:50d3:5f50:f141:161])
        by btbn.de (Postfix) with ESMTPSA id B1B3625EA8D;
        Fri, 26 Feb 2021 16:03:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothenpieler.org;
        s=mail; t=1614351828;
        bh=c30HSZJschWPSlpWwlIXJRzxEJlkwoEp2JzTZidoWRk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MlQh8/ocq183ogh1pxnesAlZL6A9mZxITtDfH5C06bOOPIbktITCOikozLVTAq+B4
         er8yHRhhD1Cy5wl8RKSNxvsBevwnAuTgHnNincCg38+6mShRrnJTw8Hf6lTbtPgaAj
         yB0xbCDHbLIwjhPBINCWvrcxkHpBc679o0l90pSu48Qxo9DHLF3/hAH4WNA393Cx7+
         iI/NRDaaaev/iPZpJbxr7lfXXmXUUTlQVbK3HpH+CkI9HcIIT0POFW3tDzIrBGkpIi
         z/cxwqsiKk2qhJvPLAihDxZIRYHlaoed0M7QVcoJv9WOz6Z9Wx7v/R74q35+x4qJYH
         3TMc7B4OMVTcA==
Subject: Re: NFS Caching broken in 4.19.37
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "940821@bugs.debian.org" <940821@bugs.debian.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
References: <5022bdc4-9f3e-9756-cbca-ada37f88ecc7@cambridgegreys.com>
 <YDFrN0rZAJBbouly@eldamar.lan>
 <af5cebbd-74c9-9345-9fe8-253fb96033f6@cambridgegreys.com>
 <BEBA9809-373A-4172-B4AD-E19D82E56DB1@oracle.com>
 <YDIkH6yVgLoALT6x@eldamar.lan>
 <9305dc03-5557-5e18-e5c9-aaf886a03fff@cambridgegreys.com>
 <20210221143712.GA15975@fieldses.org>
 <f0edfaf5-457d-2334-ee4f-a6bf9d13917b@cambridgegreys.com>
From:   Timo Rothenpieler <timo@rothenpieler.org>
Message-ID: <1b701f2b-d185-dd30-0aca-ba6d280221d5@rothenpieler.org>
Date:   Fri, 26 Feb 2021 16:03:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <f0edfaf5-457d-2334-ee4f-a6bf9d13917b@cambridgegreys.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050206020807030402020003"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050206020807030402020003
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

I think I can reproduce this, or something that at least looks very=20
similar to this, on 5.10. Namely on 5.10.17 (On both Client and Server).

We are running slurm, and since a while now (coincides with updating=20
from 5.4 to 5.10, but a whole bunch of other stuff was updated at the=20
same time, so it took me a while to correlate this) the logs it writes=20
have been truncated, but only while they're being observed on the=20
client, using tail -f or something like that.

Looks like this then:

On Server:
> store01 /srv/export/home/users/timo/TestRun # ls -l slurm-41101.out
> -rw-r--r-- 1 timo timo 1931 Feb 26 15:46 slurm-41101.out
> store01 /srv/export/home/users/timo/TestRun # wc -l slurm-41101.out
> 61 slurm-41101.out

On Client:
> timo@login01 ~/TestRun $ ls -l slurm-41101.out
> -rw-r--r-- 1 timo timo 1931 Feb 26 15:46 slurm-41101.out
> timo@login01 ~/TestRun $ wc -l slurm-41101.out
> 24 slurm-41101.out

See https://gist.github.com/BtbN/b9eb4fc08ccc53bb20087bce0bf9f826 for=20
the respective file-contents.

If I run the same test job, wait until its done, and then look at its=20
slurm.out file, it matches between NFS Client and Server.
If I tail -f the slurm.out on an NFS client, the file stops getting=20
updated on the client, but keeps getting more logs written to it on the=20
NFS server.

The slurm.out file is being written to by another NFS client, which is=20
running on one of the compute nodes of the system. It's being reads from =

a login node.



Timo


On 21.02.2021 16:53, Anton Ivanov wrote:
> Client side. This seems to be an entirely client side issue.
>=20
> A variety of kernels on the clients starting from 4.9 and up to 5.10=20
> using 4.19 servers. I have observed it on a 4.9 client versus 4.9 serve=
r=20
> earlier.
>=20
> 4.9 fails, 4.19 fails, 5.2 fails, 5.4 fails, 5.10 works.
>=20
> At present the server is at 4.19.67 in all tests.
>=20
> Linux jain 4.19.0-6-amd64 #1 SMP Debian 4.19.67-2+deb10u2 (2019-11-11) =

> x86_64 GNU/Linux
>=20
> I can set-up a couple of alternative servers during the week, but so fa=
r=20
> everything is pointing towards a client fs cache issue, not a server on=
e.
>=20
> Brgds,
>=20



--------------ms050206020807030402020003
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
LnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczMIIC
IjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA7eaHlqHBpLbtwkJV9z8PDyJgXxPgpkOI
hkmReRwbLxpQD9xGAe72ujqGzFFh78QPgAhxKVqtGHzYeq0VJVCzhnCKRBbVX+JwIhL3ULYh
UAZrViUp952qDB6qTL5sGeJS9F69VPSR5k6pFNw7mHDTTt0voWFg2aVkG3khomzVXoieJGOi
Q4dH76paCtQbLkt59joAKz2BnwGLQ4wr09nfumJt5AKx2YxHK2XgSPslVZ4z8G00gimsfA7U
tjT/wiekY6Z0b7ksLrEcvODncHQe9VSrNRA149SE3AlkWaZM/joVei/GYfj9K5jkiReinR4m
qM353FEceLOeBhSTURpMdQ5wsXLi9DSTGBuNv4aw2Dozb/qBlkhGTvwk92mi0jAecE22Sn3A
9UfrU2p1w/uRs+TIteQ0xO0B/J2mY2caqocsS9SsriIGlQ8b0LT0o6Ob07KGtPa5/lIvMmx5
72Dv2v+vDiECByxm1Hdgjp8JtE4mdyYP6GBscJyT71NZw1zXHnFkyCbxReag9qaSR9x4CVVX
j1BDmNROCqd5NAfIXUXYTFeZ/jukQigkxXGWhEhfLBC4Ha6pwizz9fq1+wwPKcWaF9P/SZOu
BDrG30MiyCZa66G9mEtF5ZLuh4rGfKqxy4Z5Mxecuzt+MZmrSKfKGeXOeED/iuX5Z02M1o7i
MS8CAwEAAaOCAfQwggHwMA8GA1UdEwEB/wQFMAMBAf8wHwYDVR0jBBgwFoAUUtiIOsifeGbt
ifN7OHCUyQICNtAwQQYIKwYBBQUHAQEENTAzMDEGCCsGAQUFBzABhiVodHRwOi8vb2NzcDA1
LmFjdGFsaXMuaXQvVkEvQVVUSC1ST09UMEUGA1UdIAQ+MDwwOgYEVR0gADAyMDAGCCsGAQUF
BwIBFiRodHRwczovL3d3dy5hY3RhbGlzLml0L2FyZWEtZG93bmxvYWQwHQYDVR0lBBYwFAYI
KwYBBQUHAwIGCCsGAQUFBwMEMIHjBgNVHR8EgdswgdgwgZaggZOggZCGgY1sZGFwOi8vbGRh
cDA1LmFjdGFsaXMuaXQvY24lM2RBY3RhbGlzJTIwQXV0aGVudGljYXRpb24lMjBSb290JTIw
Q0EsbyUzZEFjdGFsaXMlMjBTLnAuQS4lMmYwMzM1ODUyMDk2NyxjJTNkSVQ/Y2VydGlmaWNh
dGVSZXZvY2F0aW9uTGlzdDtiaW5hcnkwPaA7oDmGN2h0dHA6Ly9jcmwwNS5hY3RhbGlzLml0
L1JlcG9zaXRvcnkvQVVUSC1ST09UL2dldExhc3RDUkwwHQYDVR0OBBYEFL6XqaqEv4C/EFN9
CTL54S4yG893MA4GA1UdDwEB/wQEAwIBBjANBgkqhkiG9w0BAQsFAAOCAgEAJpvnG1kNdLMS
A+nnVfeEgIXNQsM7YRxXx6bmEt9IIrFlH1qYKeNw4NV8xtop91Rle168wghmYeCTP10FqfuK
MZsleNkI8/b3PBkZLIKOl9p2Dmz2Gc0I3WvcMbAgd/IuBtx998PJX/bBb5dMZuGV2drNmxfz
3ar6ytGYLxedfjKCD55Yv8CQcN6e9sW5OUm9TJ3kjt7Wdvd1hcw5s+7bhlND38rWFJBuzump
5xqm1NSOggOkFSlKnhSz6HUjgwBaid6Ypig9L1/TLrkmtEIpx+wpIj7WTA9JqcMMyLJ0rN6j
jpetLSGUDk3NCOpQntSy4a8+0O+SepzS/Tec1cGdSN6Ni2/A7ewQNd1Rbmb2SM2qVBlfN0e6
ZklWo9QYpNZyf0d/d3upsKabE9eNCg1S4eDnp8sJqdlaQQ7hI/UYCAgDtLIm7/J9+/S2zuwE
WtJMPcvaYIBczdjwF9uW+8NJ/Zu/JKb98971uua7OsJexPFRBzX7/PnJ2/NXcTdwudShJc/p
d9c3IRU7qw+RxRKchIczv3zEuQJMHkSSM8KM8TbOzi/0v0lU6SSyS9bpGdZZxx19Hd8Qs0cv
+R6nyt7ohttizwefkYzQ6GzwIwM9gSjH5Bf/r9Kc5/JqqpKKUGicxAGy2zKYEGB0Qo761Mcc
IyclBW9mfuNFDbTBeDEyu80xggPzMIID7wIBATCBljCBgTELMAkGA1UEBhMCSVQxEDAOBgNV
BAgMB0JlcmdhbW8xGTAXBgNVBAcMEFBvbnRlIFNhbiBQaWV0cm8xFzAVBgNVBAoMDkFjdGFs
aXMgUy5wLkEuMSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBH
MwIQCP8se1eXTyBvFrjHrZ83LDANBglghkgBZQMEAgEFAKCCAi0wGAYJKoZIhvcNAQkDMQsG
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjEwMjI2MTUwMzQ2WjAvBgkqhkiG9w0BCQQx
IgQguq9c27oQJweY3lR8gZbjy5cGNtTTgN/QwEUmuBplubcwbAYJKoZIhvcNAQkPMV8wXTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAN
BggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBpwYJKwYBBAGCNxAEMYGZ
MIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQUG9udGUg
U2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhAI/yx7V5dPIG8WuMetnzcsMIGpBgsqhkiG
9w0BCRACCzGBmaCBljCBgTELMAkGA1UEBhMCSVQxEDAOBgNVBAgMB0JlcmdhbW8xGTAXBgNV
BAcMEFBvbnRlIFNhbiBQaWV0cm8xFzAVBgNVBAoMDkFjdGFsaXMgUy5wLkEuMSwwKgYDVQQD
DCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBHMwIQCP8se1eXTyBvFrjHrZ83
LDANBgkqhkiG9w0BAQEFAASCAQAnM5zTplSrYLBf4xb7+nRkuwAaahJssIkWz0F+BWVNdFzU
PQVyNz5FEd2vtST1LbP6kxK0NaAbDNY5O7UIBDVUGkeRwuP2QHyeOw5MWyujfoqigq9e6/AL
NVWoL/G7h45Knubgs0sIqjsnx5U7KJHd/OVRUKriTulerFxOquUMjYQNIPoBu4eVnuptLoFq
XUS0ikEvYIroJ8JJY6yJloAkdSpekfZDMBqGiEj2IqxL3yN98C2A038oarSiy/4xiCIs9947
dJNVn43xy7wMh73fS/DtCUdynG7yA6DG8z5gq79/BOzLKJDI9wQ/nVBJB7d2gJTokyMFckan
6Q1XtTJxAAAAAAAA
--------------ms050206020807030402020003--
