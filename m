Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F3431ECC5
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Feb 2021 18:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBRRBc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Feb 2021 12:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbhBRN3W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Feb 2021 08:29:22 -0500
Received: from btbn.de (btbn.de [IPv6:2a01:4f8:162:63a9::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A367C061786;
        Thu, 18 Feb 2021 05:28:32 -0800 (PST)
Received: from [IPv6:2001:16b8:64c0:e200:8477:785d:a559:f590] (200116b864c0e2008477785da559f590.dip.versatel-1u1.de [IPv6:2001:16b8:64c0:e200:8477:785d:a559:f590])
        by btbn.de (Postfix) with ESMTPSA id A6F4F232304;
        Thu, 18 Feb 2021 14:28:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothenpieler.org;
        s=mail; t=1613654910;
        bh=wCE2mJK9i2kFyz6QsiB7qfjzNzlJOgbkpJ+ljH8F+hA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=pqCbp70Zfyg57FFsJ4P0vf9f5V0hd43TkWdaEsDl4oEHbTf20dz3Jcc+n2LKoFCTL
         B0H7A1uUjPKlCZX9KOENEXwRuiGywXnm3sEOMQG28wU+7FtSv/0khgm0vGEI2VXS3c
         jnLEBUPEPJW78R5ubHaNBvUFJnP546fp9HqTsFoZAaLUGhzAnLNx3ag+jENHx6zXQB
         VqU8lRys9wp31xq3S65UN7qepDdSHkDKY/ZbMbV7SAob4Xn4+bG5sr2Ruhy/6Y6zU4
         /n+Apo7UmX1n6n0iIJvNdbuz3b4lvkaK6ew+2rhjXQFgMEV95XvqvKheLTnUNEtyIc
         1RGmM+37u+9lA==
Subject: Re: copy_file_range() infinitely hangs on NFSv4.2 over RDMA
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <57f67888-160f-891c-6217-69e174d7e42b@rothenpieler.org>
 <CAN-5tyE4OyNOZRXGnyONcdGsHaRAF39LSE5416Kj964m-+_C2A@mail.gmail.com>
 <81cb9aef-c10d-f11c-42c0-5144ee2608bc@rothenpieler.org>
 <0e49471c-e640-a331-c7b4-4e0a49a7a967@rothenpieler.org>
 <CAN-5tyG9Ly9tqKxguFNhg_PGXCxE2=Zn6LQPLY59twdVkD3Auw@mail.gmail.com>
 <51a8caa7-52c2-8155-10a7-1e8d21866924@rothenpieler.org>
 <CAN-5tyFT4+kkqk6E0Jxe-vMYm7q5mHyTeq0Ht7AEYasA30ZaGw@mail.gmail.com>
From:   Timo Rothenpieler <timo@rothenpieler.org>
Message-ID: <3f946e6b-6872-641c-8828-35ddd5c8fed0@rothenpieler.org>
Date:   Thu, 18 Feb 2021 14:28:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAN-5tyFT4+kkqk6E0Jxe-vMYm7q5mHyTeq0Ht7AEYasA30ZaGw@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms010405070802040104060008"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms010405070802040104060008
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.02.2021 04:52, Olga Kornievskaia wrote:
> On Wed, Feb 17, 2021 at 8:12 PM Timo Rothenpieler <timo@rothenpieler.or=
g> wrote:
>>
>> On 17.02.2021 23:37, Olga Kornievskaia wrote:
>>> On Tue, Feb 16, 2021 at 5:27 PM Timo Rothenpieler <timo@rothenpieler.=
org> wrote:
>>>>
>>>> On 16.02.2021 21:37, Timo Rothenpieler wrote:
>>>>> I can't get a network (I assume just TCP/20049 is fine, and not als=
o
>>>>> some RDMA trace?) right now, but I will once a user has finished th=
eir
>>>>> work on the machine.
>>>>
>>>> There wasn't any TCP traffic to dump on the NFSoRDMA Port, probably
>>>> because everything is handled via RDMA/IB.
>>>
>>> Yeah, I'm not sure if tcpdump can snoop on the IB traffic. I know tha=
t
>>> upstream tcpdump can snoop on RDMA mellanox card (but I only know
>>> about the Roce mode).
>>
>> I managed to get https://github.com/Mellanox/ibdump working. Attached =
is
>> what it records when I run the xfs_io copy_range command that gets
>> stuck(sniffer.pcap).
>> Additionally, I rebooted the client machine, and captured the traffic
>> when it does a then successful copy during the first few minutes of
>> uptime(sniffer2.pcap).
>>
>> Both those commands were run on a the same 500M file.
>>
>>>> But I recorded a trace log of rpcrdma and sunrpc observing the situa=
tion.
>>>>
>>>> To me it looks like the COPY task (task:15886@7) completes successfu=
lly?
>>>> The compressed trace.dat is attached.
>>>
>>> I'm having a hard time reproducing the problem. But I only tried
>>> "xfs", "btrfs", "ext4" (first two send a CLONE since the file system
>>> supports it), the last one exercises a copy. In all my tries your
>>
>> I can also reproduce this on a test NFS share from an ext4 filesystem.=

>> Have not tested xfs yet.
>>
>>> xfs_io commands succeed. The differences between our environments are=

>>> (1) ZFS vs (xfs, etc) and (2) IB vs RoCE. Question is: does any
>>> copy_file_range work over RDMA/IB. One thing to try a synchronous
>>
>> It works, on any size of file, when the client machine is freshly boot=
ed
>> (within its first 10~30 minutes of uptime).
>=20
> Reboot of the client or the server machine?

Just the client. The server is in production use, so I can't freely=20
reboot it without organizing a maintenance window a couple days ahead.

>>> copy: create a small file 10bytes and do a copy. Is this the case
>>> where we have copy and the callback racing, so instead do a really
>>> large copy: create a >=3D1GB file and do a copy. that will be an asyn=
c
>>> copy but will not have a racy condition. Can you try those 2 examples=

>>> for me?
>>
>> I have observed in the past, that the xfs_io copy is more likely to
>> succeed the smaller the file is, though I did not make out a definite
>> pattern.
>=20
> That's because small files are done with a synchronous copy. Your
> network captures (while not fully decodable by wireshark because the
> trace lacks the connection establishment needed for the wireshark to
> parse the RDMA replies) the fact that no callback is sent from the
> server and thus the client is stuck waiting for it. So the focus
> should be on the server piece as to why it's not sending it. There are
> some error conditions on the server that if that happens, it will not
> be able to send a callback. What springs to mind looking thru the code
> is that somehow the server thinks there is no callback channel.  Can
> you turn on nfsd tracepoints please? I wonder if we can see something
> of interest there.

On the server I guess?
I'll have to figure out a way to do that while it's not in active use.
Otherwise the trace log will be enormous and contain a lot of noise from =

the general system use.

I'll report back once I got a trace log.

> The logic for determining whether the copy is sent sync or async
> depends on server's rsize, if a file smaller than 2 RPC payloads, it's
> sent synchronously.



--------------ms010405070802040104060008
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjEwMjE4MTMyODI5WjAvBgkqhkiG9w0BCQQx
IgQgPQsZsDzuiQE58lKQTZCtqD9+0Pag8NYDcwWz/dWuDXQwbAYJKoZIhvcNAQkPMV8wXTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAN
BggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBpwYJKwYBBAGCNxAEMYGZ
MIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQUG9udGUg
U2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhAI/yx7V5dPIG8WuMetnzcsMIGpBgsqhkiG
9w0BCRACCzGBmaCBljCBgTELMAkGA1UEBhMCSVQxEDAOBgNVBAgMB0JlcmdhbW8xGTAXBgNV
BAcMEFBvbnRlIFNhbiBQaWV0cm8xFzAVBgNVBAoMDkFjdGFsaXMgUy5wLkEuMSwwKgYDVQQD
DCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBHMwIQCP8se1eXTyBvFrjHrZ83
LDANBgkqhkiG9w0BAQEFAASCAQCgo/GT6m08x9uIGZQuBfvYZP4vGmypAoS/i7WRIt3CGkbz
2I+8jYa5+Qc98Mn9qihAwFJ98S9GGPeyRbEfiFmL++XUuiJ61xQ28gKg0mYM+JwAs1Fb3XzW
Uzs8BsS5JeOIu8XERo+D497+Hnh98H5ClGGTS/7RoSVYh/OuF4P2DXhoVCU0ELGWxN3Xwims
xWTfOAvsYc+7hYihmsUw5oOGhEtOqFCUB8MbOv8hvFFbuRsR+v2hu8FDxGnirYpz7BGkIL9e
p8G5neBv7mAlWjJU26sX7XtwVI62FZ3N8X5MsOXFpI0s0yp+ypxD3dNXIn+gGhyTllP2jP9z
fc0zDSvDAAAAAAAA
--------------ms010405070802040104060008--
