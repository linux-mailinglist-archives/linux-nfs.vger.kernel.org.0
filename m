Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 201CE5E183
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2019 11:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfGCJ4t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Jul 2019 05:56:49 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:34979 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbfGCJ4t (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 3 Jul 2019 05:56:49 -0400
Received: from rabammel.molgen.mpg.de (rabammel.molgen.mpg.de [141.14.30.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 744E42067CFCB;
        Wed,  3 Jul 2019 11:56:45 +0200 (CEST)
Subject: Re: Regression caused by commit c54f24e3 (nfsd: fix
 performance-limiting session calculation)
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Chris Tracy <ctracy@engr.scu.edu>, linux-nfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, it+linux-nfs@molgen.mpg.de
References: <20190702165107.93C8A2067CFDD@mx.molgen.mpg.de>
 <8c3e0249-b17f-4bd2-4a46-afd4d35f4763@molgen.mpg.de>
 <0b5fdd56-d570-c787-cd56-7e6d0ba65225@molgen.mpg.de>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <860b4d19-49bd-5d76-aa06-c2d9aeffb452@molgen.mpg.de>
Date:   Wed, 3 Jul 2019 11:56:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0b5fdd56-d570-c787-cd56-7e6d0ba65225@molgen.mpg.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000501020301080409040501"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms000501020301080409040501
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear Bruce,


On 7/2/19 11:59 PM, Paul Menzel wrote:

> Could it be that commit c54f24e3 (nfsd: fix performance-limiting
> session calculation) causes a regression on big memory machines (1
> TB)?
>=20
>> From c54f24e338ed2a35218f117a4a1afb5f9e2b4e64 Mon Sep 17 00:00:00 2001=

>> From: "J. Bruce Fields" <bfields@redhat.com>
>> Date: Thu, 21 Feb 2019 10:47:00 -0500
>> Subject: [PATCH] nfsd: fix performance-limiting session calculation
>>
>> We're unintentionally limiting the number of slots per nfsv4.1 session=

>> to 10.=C2=A0 Often more than 10 simultaneous RPCs are needed for the b=
est
>> performance.
>>
>> This calculation was meant to prevent any one client from using up mor=
e
>> than a third of the limit we set for total memory use across all clien=
ts
>> and sessions.=C2=A0 Instead, it's limiting the client to a third of th=
e
>> maximum for a single session.
>>
>> Fix this.
>>
>> Reported-by: Chris Tracy <ctracy@engr.scu.edu>
>> Cc: stable@vger.kernel.org
>> Fixes: de766e570413 "nfsd: give out fewer session slots as limit appro=
aches"
>> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>> ---
>> =C2=A0fs/nfsd/nfs4state.c | 8 ++++----
>> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index fb3c9844c82a..6a45fb00c5fc 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1544,16 +1544,16 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_chan=
nel_attrs *ca)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0 u32 slotsize =3D slot_bytes(ca);
>> =C2=A0=C2=A0=C2=A0=C2=A0 u32 num =3D ca->maxreqs;
>> -=C2=A0=C2=A0=C2=A0 int avail;
>> +=C2=A0=C2=A0=C2=A0 unsigned long avail, total_avail;
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&nfsd_drc_lock);
>> -=C2=A0=C2=A0=C2=A0 avail =3D min((unsigned long)NFSD_MAX_MEM_PER_SESS=
ION,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf=
sd_drc_max_mem - nfsd_drc_mem_used);
>> +=C2=A0=C2=A0=C2=A0 total_avail =3D nfsd_drc_max_mem - nfsd_drc_mem_us=
ed;
>> +=C2=A0=C2=A0=C2=A0 avail =3D min((unsigned long)NFSD_MAX_MEM_PER_SESS=
ION, total_avail);
>> =C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Never use more than a third of the re=
maining memory,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * unless it's the only way to give this=
 client a slot:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 avail =3D clamp_t(int, avail, slotsize, avail/3);
>> +=C2=A0=C2=A0=C2=A0 avail =3D clamp_t(int, avail, slotsize, total_avai=
l/3);
>> =C2=A0=C2=A0=C2=A0=C2=A0 num =3D min_t(int, num, avail / slotsize);
>> =C2=A0=C2=A0=C2=A0=C2=A0 nfsd_drc_mem_used +=3D num * slotsize;
>> =C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&nfsd_drc_lock);
>=20
> Booting a 80 threads, 1 TB server with Linux 4.19.56 and Linux
> 5.2-rc7 causes connections problems for the clients. The problems do
> not happen on servers with just 96 GB memory for example. Bisecting
> points to the two commits below (and I can only continue tomorrow).
>=20
> c54f24e338ed2a35218f117a4a1afb5f9e2b4e64 (nfsd: fix performance-limitin=
g session calculation)
> 8127d82705998568b52ac724e28e00941538083d (NFS: Don't recoalesce on erro=
r in nfs_pageio_complete_mirror())
>=20
> If you have things I could do to verify this besides reverting it
> tomorrow, please tell. It=E2=80=99d be great if it could be fixed befor=
e Linux
> 5.2 is released.

Reverting the suspected commit c54f24e3 indeed fixes the regression.
Please tell me how to continue. Should the commit be reverted or can
a fix be made shortly?

On a running system, `rpcdebug -m nfsd -s all` and
`rpcdebug -m rpc -s all` do not give a lot of information, as the
interesting values are set during module initialization.


Kind regards,

Paul


[  765.444765] svc: socket 0000000093976859 TCP (listen) state change 10
[  765.444784] svc: socket 0000000015376384 TCP (listen) state change 1
[  765.444869] svc: tcp_accept 000000002ad76b70 sock 000000005eae2611
[  765.444879] nfsd: connect from 141.14.17.51, port=3D785
[  765.444881] svc: svc_setup_socket 000000003fe99ad1
[  765.444883] setting up TCP socket for reading
[  765.444885] svc: svc_setup_socket created 000000006952397a (inet 00000=
00015376384), listen 0 close 0
[  765.444901] svc: server 00000000aad03597 waiting for data (to =3D 3600=
000)
[  765.444904] svc: server 00000000aad03597, pool 0, transport 0000000069=
52397a, inuse=3D2
[  765.444907] svc: tcp_recv 000000006952397a data 1 conn 0 close 0
[  765.444912] svc: socket 000000006952397a recvfrom(000000005fae69c4, 4)=
 =3D 4
[  765.444913] svc: TCP record, 40 bytes
[  765.444919] svc: socket 000000006952397a recvfrom(00000000bce6ffde, 40=
96) =3D 40
[  765.444920] svc: TCP final record (40 bytes)
[  765.444926] svc: svc_authenticate (0)
[  765.444930] svc: calling dispatcher
[  765.444931] nfsd_dispatch: vers 4 proc 0
[  765.444954] svc: socket 000000006952397a sendto([000000005133ae9c 28..=
=2E ], 28) =3D 28 (addr 141.14.17.51, port=3D785)
[  765.444963] svc: server 00000000aad03597 waiting for data (to =3D 3600=
000)
[  765.444967] svc: tcp_accept 000000002ad76b70 sock 000000005eae2611
[  765.444975] svc: server 00000000aad03597 waiting for data (to =3D 3600=
000)
[  765.444980] svc: server 00000000be144e7a, pool 0, transport 0000000069=
52397a, inuse=3D2
[  765.444983] svc: tcp_recv 000000006952397a data 1 conn 0 close 0
[  765.444988] svc: socket 000000006952397a recvfrom(000000005fae69c4, 4)=
 =3D -11
[  765.444989] RPC: TCP recv_record got -11
[  765.444990] RPC: TCP recvfrom got EAGAIN
[  765.444993] svc: server 00000000be144e7a waiting for data (to =3D 3600=
000)
[  765.445020] svc: server 000000002b852bb6 waiting for data (to =3D 3600=
000)
[  765.445023] svc: server 0000000011abceff waiting for data (to =3D 3600=
000)
[  765.445177] svc: socket 000000006952397a(inet 0000000015376384), busy=3D=
0
[  765.445401] svc: server 00000000aad03597, pool 0, transport 0000000069=
52397a, inuse=3D2
[  765.445411] svc: tcp_recv 000000006952397a data 1 conn 0 close 0
[  765.445414] svc: socket 000000006952397a recvfrom(000000005fae69c4, 4)=
 =3D 4
[  765.445415] svc: TCP record, 252 bytes
[  765.445418] svc: socket 000000006952397a recvfrom(00000000bce6ffde, 40=
96) =3D 252
[  765.445419] svc: TCP final record (252 bytes)
[  765.445427] svc: svc_authenticate (1)
[  765.445431] svc: calling dispatcher
[  765.445432] nfsd_dispatch: vers 4 proc 1
[  765.445436] nfsd4_exchange_id rqstp=3D00000000aad03597 exid=3D00000000=
0472f450 clname.len=3D32 clname.data=3D00000000ed18490f ip_addr=3D141.14.=
17.51 flags 101, spa_how 0
[  765.445442] renewing client (clientid 5d1c72c1/ed57da3d)
[  765.445443] nfsd4_exchange_id seqid 0 flags 10001
[  765.445444] nfsv4 compound returned 0
[  765.445458] svc: socket 000000006952397a sendto([00000000d62d9bb6 136.=
=2E. ], 136) =3D 136 (addr 141.14.17.51, port=3D785)
[  765.445460] svc: server 00000000aad03597 waiting for data (to =3D 3600=
000)
[  765.445462] svc: server 000000002b852bb6, pool 0, transport 0000000069=
52397a, inuse=3D2
[  765.445464] svc: tcp_recv 000000006952397a data 1 conn 0 close 0
[  765.445467] svc: socket 000000006952397a recvfrom(000000005fae69c4, 4)=
 =3D -11
[  765.445472] RPC: TCP recv_record got -11
[  765.445473] RPC: TCP recvfrom got EAGAIN
[  765.445475] svc: server 000000002b852bb6 waiting for data (to =3D 3600=
000)
[  765.445682] svc: socket 000000006952397a(inet 0000000015376384), busy=3D=
0
[  765.445760] svc: server 00000000aad03597, pool 0, transport 0000000069=
52397a, inuse=3D2
[  765.445762] svc: tcp_recv 000000006952397a data 1 conn 0 close 0
[  765.445765] svc: socket 000000006952397a recvfrom(000000005fae69c4, 4)=
 =3D 4
[  765.445769] svc: TCP record, 252 bytes
[  765.445773] svc: socket 000000006952397a recvfrom(00000000bce6ffde, 40=
96) =3D 252
[  765.445774] svc: TCP final record (252 bytes)
[  765.445779] svc: svc_authenticate (1)
[  765.445784] svc: calling dispatcher
[  765.445785] nfsd_dispatch: vers 4 proc 1
[  765.445789] nfsd4_exchange_id rqstp=3D00000000aad03597 exid=3D00000000=
0472f450 clname.len=3D32 clname.data=3D00000000ed18490f ip_addr=3D141.14.=
17.51 flags 101, spa_how 0
[  765.445795] renewing client (clientid 5d1c72c1/ed57da3e)
[  765.445795] nfsd4_exchange_id seqid 0 flags 10001
[  765.445854] svc: server 000000002b852bb6, pool 0, transport 0000000069=
52397a, inuse=3D3
[  765.445855] svc: tcp_recv 000000006952397a data 1 conn 0 close 0
[  765.445859] svc: socket 000000006952397a recvfrom(000000005fae69c4, 4)=
 =3D -11
[  765.445860] RPC: TCP recv_record got -11
[  765.445860] RPC: TCP recvfrom got EAGAIN
[  765.445862] svc: server 000000002b852bb6 waiting for data (to =3D 3600=
000)
[  765.445995] nfsv4 compound returned 0
[  765.446013] svc: socket 000000006952397a sendto([000000006f8e68ac 136.=
=2E. ], 136) =3D 136 (addr 141.14.17.51, port=3D785)
[  765.446020] svc: server 00000000aad03597 waiting for data (to =3D 3600=
000)
[  765.446178] svc: socket 000000006952397a(inet 0000000015376384), busy=3D=
0
[  765.446193] svc: server 00000000aad03597, pool 0, transport 0000000069=
52397a, inuse=3D2
[  765.446198] svc: tcp_recv 000000006952397a data 1 conn 0 close 0
[  765.446200] svc: socket 000000006952397a recvfrom(000000005fae69c4, 4)=
 =3D 4
[  765.446201] svc: TCP record, 220 bytes
[  765.446205] svc: socket 000000006952397a recvfrom(00000000bce6ffde, 40=
96) =3D 220
[  765.446222] svc: TCP final record (220 bytes)
[  765.446226] svc: svc_authenticate (1)
[  765.446229] svc: calling dispatcher
[  765.446230] nfsd_dispatch: vers 4 proc 1
[  765.446233] nfsv4 compound returned 10008
[  765.446243] svc: socket 000000006952397a sendto([00000000dda22c57 48..=
=2E ], 48) =3D 48 (addr 141.14.17.51, port=3D785)
[  765.446244] svc: server 00000000aad03597 waiting for data (to =3D 3600=
000)
[  765.446250] svc: server 00000000aad03597, pool 0, transport 0000000069=
52397a, inuse=3D2
[  765.446251] svc: tcp_recv 000000006952397a data 1 conn 0 close 0
[  765.446253] svc: socket 000000006952397a recvfrom(000000005fae69c4, 4)=
 =3D -11
[  765.446253] RPC: TCP recv_record got -11
[  765.446254] RPC: TCP recvfrom got EAGAIN
[  765.446257] svc: server 00000000aad03597 waiting for data (to =3D 3600=
000)
[  765.446397] svc: server 000000002b852bb6 waiting for data (to =3D 3600=
000)
[  766.500412] svc: socket 000000006952397a(inet 0000000015376384), busy=3D=
0
[  766.500445] svc: server 00000000aad03597, pool 0, transport 0000000069=
52397a, inuse=3D2
[  766.500448] svc: tcp_recv 000000006952397a data 1 conn 0 close 0
[  766.500452] svc: socket 000000006952397a recvfrom(000000005fae69c4, 4)=
 =3D 4
[  766.500454] svc: TCP record, 220 bytes
[  766.500459] svc: socket 000000006952397a recvfrom(00000000bce6ffde, 40=
96) =3D 220
[  766.500461] svc: TCP final record (220 bytes)
[  766.500467] svc: svc_authenticate (1)
[  766.500472] svc: calling dispatcher
[  766.500474] nfsd_dispatch: vers 4 proc 1
[  766.500480] nfsv4 compound returned 10008
[  766.500498] svc: socket 000000006952397a sendto([000000006f8e68ac 48..=
=2E ], 48) =3D 48 (addr 141.14.17.51, port=3D785)
[  766.500505] svc: server 00000000aad03597 waiting for data (to =3D 3600=
000)
[  766.500509] svc: server 00000000aad03597, pool 0, transport 0000000069=
52397a, inuse=3D2
[  766.500512] svc: tcp_recv 000000006952397a data 1 conn 0 close 0
[  766.500515] svc: socket 000000006952397a recvfrom(000000005fae69c4, 4)=
 =3D -11
[  766.500516] RPC: TCP recv_record got -11
[  766.500517] RPC: TCP recvfrom got EAGAIN
[  766.500519] svc: server 00000000aad03597 waiting for data (to =3D 3600=
000)
[  766.500546] svc: server 000000002b852bb6 waiting for data (to =3D 3600=
000)
[  767.524372] svc: socket 000000006952397a(inet 0000000015376384), busy=3D=
0
[  767.524405] svc: server 00000000aad03597, pool 0, transport 0000000069=
52397a, inuse=3D2
[  767.524408] svc: tcp_recv 000000006952397a data 1 conn 0 close 0
[  767.524413] svc: socket 000000006952397a recvfrom(000000005fae69c4, 4)=
 =3D 4
[  767.524415] svc: TCP record, 220 bytes
[  767.524420] svc: socket 000000006952397a recvfrom(00000000bce6ffde, 40=
96) =3D 220
[  767.524422] svc: TCP final record (220 bytes)
[  767.524428] svc: svc_authenticate (1)
[  767.524434] svc: calling dispatcher
[  767.524435] nfsd_dispatch: vers 4 proc 1
[  767.524441] nfsv4 compound returned 10008
[  767.524448] svc: server 000000002b852bb6, pool 0, transport 0000000069=
52397a, inuse=3D3
[  767.524451] svc: tcp_recv 000000006952397a data 1 conn 0 close 0
[  767.524470] svc: socket 000000006952397a sendto([00000000dda22c57 48..=
=2E ], 48) =3D 48 (addr 141.14.17.51, port=3D785)
[  767.524474] svc: socket 000000006952397a recvfrom(000000005fae69c4, 4)=
 =3D -11
[  767.524476] svc: server 00000000aad03597 waiting for data (to =3D 3600=
000)
[  767.524477] RPC: TCP recv_record got -11
[  767.524478] RPC: TCP recvfrom got EAGAIN
[  767.524482] svc: server 000000002b852bb6 waiting for data (to =3D 3600=
000)
[  768.548339] svc: socket 000000006952397a(inet 0000000015376384), busy=3D=
0
[  768.548372] svc: server 00000000aad03597, pool 0, transport 0000000069=
52397a, inuse=3D2
[  768.548375] svc: tcp_recv 000000006952397a data 1 conn 0 close 0
[  768.548379] svc: socket 000000006952397a recvfrom(000000005fae69c4, 4)=
 =3D 4
[  768.548381] svc: TCP record, 220 bytes
[  768.548386] svc: socket 000000006952397a recvfrom(00000000bce6ffde, 40=
96) =3D 220
[  768.548387] svc: TCP final record (220 bytes)
[  768.548394] svc: svc_authenticate (1)
[  768.548400] svc: calling dispatcher
[  768.548401] nfsd_dispatch: vers 4 proc 1
[  768.548407] nfsv4 compound returned 10008
[  768.548425] svc: socket 000000006952397a sendto([000000006f8e68ac 48..=
=2E ], 48) =3D 48 (addr 141.14.17.51, port=3D785)
[  768.548432] svc: server 00000000aad03597 waiting for data (to =3D 3600=
000)
[  768.548436] svc: server 00000000aad03597, pool 0, transport 0000000069=
52397a, inuse=3D2
[  768.548439] svc: tcp_recv 000000006952397a data 1 conn 0 close 0
[  768.548442] svc: socket 000000006952397a recvfrom(000000005fae69c4, 4)=
 =3D -11
[  768.548443] RPC: TCP recv_record got -11
[  768.548444] RPC: TCP recvfrom got EAGAIN
[  768.548446] svc: server 00000000aad03597 waiting for data (to =3D 3600=
000)
[  768.548477] svc: server 000000002b852bb6 waiting for data (to =3D 3600=
000)


--------------ms000501020301080409040501
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EFowggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWNMIIEdaADAgECAgwcOtRQhH7u81j4jncwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjExMDMxNTI0
NDhaFw0zMTAyMjIyMzU5NTlaMGoxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAP
BgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEVMBMG
A1UEAwwMTVBHIENBIC0gRzAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnhx4
59Lh4WqgOs/Md04XxU2yFtfM15ZuJV0PZP7BmqSJKLLPyqmOrADfNdJ5PIGBto2JBhtRRBHd
G0GROOvTRHjzOga95WOTeura79T21FWwwAwa29OFnD3ZplQs6HgdwQrZWNi1WHNJxn/4mA19
rNEBUc5urSIpZPvZi5XmlF3v3JHOlx3KWV7mUteB4pwEEfGTg4npPAJbp2o7arxQdoIq+Pu2
OsvqhD7Rk4QeaX+EM1QS4lqd1otW4hE70h/ODPy1xffgbZiuotWQLC6nIwa65Qv6byqlIX0q
Zuu99Vsu+r3sWYsL5SBkgecNI7fMJ5tfHrjoxfrKl/ErTAt8GQIDAQABo4ICBTCCAgEwEgYD
VR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDANBgsrBgEEAYGt
IYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBTEiKUH7rh7qgwTv9opdGNSG0lwFjAf
BgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGEMECgPqA8hjpo
dHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1
Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcwAYYnaHR0cDov
L29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAChj5odHRwOi8v
Y2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1j
YS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBABLpeD5FygzqOjj+
/lAOy20UQOGWlx0RMuPcI4nuyFT8SGmK9lD7QCg/HoaJlfU/r78ex+SEide326evlFAoJXIF
jVyzNltDhpMKrPIDuh2N12zyn1EtagqPL6hu4pVRzcBpl/F2HCvtmMx5K4WN1L1fmHWLcSap
dhXLvAZ9RG/B3rqyULLSNN8xHXYXpmtvG0VGJAndZ+lj+BH7uvd3nHWnXEHC2q7iQlDUqg0a
wIqWJgdLlx1Q8Dg/sodv0m+LN0kOzGvVDRCmowBdWGhhusD+duKV66pBl+qhC+4LipariWaM
qK5ppMQROATjYeNRvwI+nDcEXr2vDaKmdbxgDVwwggWvMIIEl6ADAgECAgweKlJIhfynPMVG
/KIwDQYJKoZIhvcNAQELBQAwajELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8G
A1UEBwwITXVlbmNoZW4xIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MRUwEwYD
VQQDDAxNUEcgQ0EgLSBHMDIwHhcNMTcxMTE0MTEzNDE2WhcNMjAxMTEzMTEzNDE2WjCBizEL
MAkGA1UEBhMCREUxIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MTQwMgYDVQQL
DCtNYXgtUGxhbmNrLUluc3RpdHV0IGZ1ZXIgbW9sZWt1bGFyZSBHZW5ldGlrMQ4wDAYDVQQL
DAVNUElNRzEUMBIGA1UEAwwLUGF1bCBNZW56ZWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDIh/UR/AX/YQ48VWWDMLTYtXjYJyhRHMc81ZHMMoaoG66lWB9MtKRTnB5lovLZ
enTIUyPsCrMhTqV9CWzDf6v9gOTWVxHEYqrUwK5H1gx4XoK81nfV8oGV4EKuVmmikTXiztGz
peyDmOY8o/EFNWP7YuRkY/lPQJQBeBHYq9AYIgX4StuXu83nusq4MDydygVOeZC15ts0tv3/
6WmibmZd1OZRqxDOkoBbY3Djx6lERohs3IKS6RKiI7e90rCSy9rtidJBOvaQS9wvtOSKPx0a
+2pAgJEVzZFjOAfBcXydXtqXhcpOi2VCyl+7+LnnTz016JJLsCBuWEcB3kP9nJYNAgMBAAGj
ggIxMIICLTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFHM0Mc3XjMLlhWpp4JufRELL4A/qMB8GA1UdIwQYMBaA
FMSIpQfuuHuqDBO/2il0Y1IbSXAWMCAGA1UdEQQZMBeBFXBtZW56ZWxAbW9sZ2VuLm1wZy5k
ZTB9BgNVHR8EdjB0MDigNqA0hjJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL21wZy1nMi1jYS9w
dWIvY3JsL2NhY3JsLmNybDA4oDagNIYyaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzIt
Y2EvcHViL2NybC9jYWNybC5jcmwwgc0GCCsGAQUFBwEBBIHAMIG9MDMGCCsGAQUFBzABhido
dHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwQgYIKwYBBQUHMAKGNmh0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBC
BggrBgEFBQcwAoY2aHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzItY2EvcHViL2NhY2Vy
dC9jYWNlcnQuY3J0MEAGA1UdIAQ5MDcwDwYNKwYBBAGBrSGCLAEBBDARBg8rBgEEAYGtIYIs
AQEEAwYwEQYPKwYBBAGBrSGCLAIBBAMGMA0GCSqGSIb3DQEBCwUAA4IBAQCQs6bUDROpFO2F
Qz2FMgrdb39VEo8P3DhmpqkaIMC5ZurGbbAL/tAR6lpe4af682nEOJ7VW86ilsIJgm1j0ueY
aOuL8jrN4X7IF/8KdZnnNnImW3QVni6TCcc+7+ggci9JHtt0IDCj5vPJBpP/dKXLCN4M+exl
GXYpfHgxh8gclJPY1rquhQrihCzHfKB01w9h9tWZDVMtSoy9EUJFhCXw7mYUsvBeJwZesN2B
fndPkrXx6XWDdU3S1LyKgHlLIFtarLFm2Hb5zAUR33h+26cN6ohcGqGEEzgIG8tXS8gztEaj
1s2RyzmKd4SXTkKR3GhkZNVWy+gM68J7jP6zzN+cMYIDmjCCA5YCAQEwejBqMQswCQYDVQQG
EwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4
LVBsYW5jay1HZXNlbGxzY2hhZnQxFTATBgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzF
RvyiMA0GCWCGSAFlAwQCAQUAoIIB8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0xOTA3MDMwOTU2NDVaMC8GCSqGSIb3DQEJBDEiBCB5ZHkWkthIDBoZ7pON
E9IfTX9lnlWpsGU1zl/ahfSvljBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBAAGk
YJVXI5dAAc3jrUuxhajhr0V9LQccgHSDNOcjAoXNnoq72lNV7gUcMRkV1U2V5d8JQvgZq4ZF
mLu+lShu+fZkVYFxsRiXXzgms5XLn8vhHR5i/ikP2EloVen/YGajov3h3GXUveOAl/zijmOT
Cp2oGOqTkpttcZjwlHRD270kxMkT4JCSKqo/zVZEjFYjZPT4c+U9mamG1FcZlaVT1N1+u0Zd
5XgzgVByBLXJKztrV5/sw49N9T7ZVf/1EXXZZN/vqIZtJOO6azXNqhXCbhNO8rDXPwrz979D
BHBSA9oMHZLlJWZXPN+JdQOVDJ9n1ass1gE/NPK0ixZ6c+3RPj0AAAAAAAA=
--------------ms000501020301080409040501--
