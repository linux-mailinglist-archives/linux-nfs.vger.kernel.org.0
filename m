Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC332B294F
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Nov 2020 00:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgKMXq6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 18:46:58 -0500
Received: from smtp-o-2.desy.de ([131.169.56.155]:38149 "EHLO smtp-o-2.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgKMXq5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 13 Nov 2020 18:46:57 -0500
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
        by smtp-o-2.desy.de (Postfix) with ESMTP id E6E31160FED
        for <linux-nfs@vger.kernel.org>; Sat, 14 Nov 2020 00:46:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de E6E31160FED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1605311212; bh=2CaMqp7tQtuUD1wB51bJVBy+M8xx3HXOqfzlbvT7TLg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=sgWlQ38qV8YlC3ZkwXImh4cO3jdz1pg9xx1i+fz38Bxw6hA114+zvTj49+giCww5b
         L2wiWPzz2FDVhWJQgG+LitmsV72rtR1IhcNWpem4FthgdtLYlEbq1psCjTouh0ZPDa
         jckrZghTrQDP+3Fu4ko20Dy79mbAoRlGbm0W0z3Q=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id E2FA91A00ED;
        Sat, 14 Nov 2020 00:46:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id AFCAF1001A7;
        Sat, 14 Nov 2020 00:46:52 +0100 (CET)
Date:   Sat, 14 Nov 2020 00:46:52 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     trondmy <trondmy@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1371149886.691555.1605311212511.JavaMail.zimbra@desy.de>
In-Reply-To: <d73c15ca631ad52f036bb8708ab15b89af432952.camel@hammerspace.com>
References: <20201110231906.863446-1-trondmy@kernel.org> <3a3696f03eef74ac4723fdc0d1297076a34aa8ae.camel@hammerspace.com> <1375056959.614278.1605271687151.JavaMail.zimbra@desy.de> <994125760.684644.1605303041944.JavaMail.zimbra@desy.de> <d73c15ca631ad52f036bb8708ab15b89af432952.camel@hammerspace.com>
Subject: Re: [PATCH v3 00/11] Add RDMA support to the pNFS file+flexfiles
 data channels
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF82 (Mac)/8.8.15_GA_3953)
Thread-Topic: Add RDMA support to the pNFS file+flexfiles data channels
Thread-Index: AQHWt7lTY9xR7iW33kG2X9IO1/hKs6nCBtsAFTVACHJOhL5PDfzm1vaA/xWRAGo=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



----- Original Message -----
> From: "trondmy" <trondmy@hammerspace.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Friday, 13 November, 2020 23:45:00
> Subject: Re: [PATCH v3 00/11] Add RDMA support to the pNFS file+flexfiles=
 data channels

> On Fri, 2020-11-13 at 22:30 +0100, Mkrtchyan, Tigran wrote:
>>=20
>> After more testing, it looks like that client doesn't like
>> notification bitmap:
>>=20
>>=20
>> [31576.789492] --> _nfs4_proc_getdeviceinfo
>> [31576.789503] --> nfs41_call_sync_prepare data->seq_server
>> 000000001d17c43e
>> [31576.789507] --> nfs4_alloc_slot used_slots=3D0000
>> highest_used=3D4294967295 max_slots=3D16
>> [31576.789510] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0
>> slotid=3D0
>> [31576.789527] encode_sequence:
>> sessionid=3D2910695007:150995712:0:16777216 seqid=3D92462 slotid=3D0
>> max_slotid=3D0 cache_this=3D0
>> [31576.789991] decode_getdeviceinfo: unsupported notification
>=20
> According to this, you appear to be returning a deviceinfo bitmap with
> at least one non-zero entry that is not in the first 32-bit word. We
> only ask for notifications for NOTIFY_DEVICEID4_CHANGE and
> NOTIFY_DEVICEID4_DELETE, so we only expect bitmap[0] to have non-zero
> entries.


according to packet capture only bitmap[0] has non zero bits set.
This is the reply of compound starting from nfs staus code, tag
length and so on.


0000   00 00 00 00 00 00 00 00 00 00 00 02 00 00 00 35
0010   00 00 00 00 5f ae 7d ad 00 03 00 09 00 00 00 00
0020   00 00 00 01 00 00 00 4c 00 00 00 00 00 00 00 0f
0030   00 00 00 0f 00 00 00 00 00 00 00 2f 00 00 00 00
0040   00 00 00 04 00 00 00 40 00 00 00 01 00 00 00 03
0050   74 63 70 00 00 00 00 16 31 33 31 2e 31 36 39 2e
0060   31 39 31 2e 31 34 33 2e 31 32 35 2e 34 39 00 00
0070   00 00 00 01 00 00 00 04 00 00 00 01 00 10 00 00
0080   00 10 00 00 00 00 00 01 00 00 00 02 00 00 00 06
0090   00 00 00 00


the last 12 bytes : bitmap size, bitmap[0], bitmap[1]


This part of code in the didn't change since 2010, and I
have no issues to use 5.8 kernel. I am pretty sure, that
tests with 5.9 did pass as expected. I will try to bisec it.

Tigran.

>=20
>> [31576.790003] --> nfs4_alloc_slot used_slots=3D0001 highest_used=3D0
>> max_slots=3D16
>> [31576.790007] <-- nfs4_alloc_slot used_slots=3D0003 highest_used=3D1
>> slotid=3D1
>> [31576.790010] nfs4_free_slot: slotid 1 highest_used_slotid 0
>> [31576.790013] nfs41_sequence_process: Error 0 free the slot
>> [31576.790017] nfs4_free_slot: slotid 0 highest_used_slotid
>> 4294967295
>> [31576.790030] <-- _nfs4_proc_getdeviceinfo status=3D-5
>> [31576.790034] nfs4_get_device_info getdevice info returns -5
>> [31576.790084] <-- nfs4_get_device_info d 0000000000000000
>>=20
>>=20
>> Tigran.
>>=20
>>=20
>> ----- Original Message -----
>> > From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
>> > To: "trondmy" <trondmy@hammerspace.com>
>> > Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
>> > Sent: Friday, 13 November, 2020 13:48:07
>> > Subject: Re: [PATCH v3 00/11] Add RDMA support to the pNFS
>> > file+flexfiles data channels
>>=20
>> > Hi Trond,
>> >=20
>> > whit this changes (3ee69a14f92d74ced2647140b3799511ba4f3fa5) I see
>> > an infinite
>> > loop
>> > of LAYOUTGET->GETDEVICEINFO->LAYOUTRETURN without any attempt to
>> > connect to a
>> > DS.
>> >=20
>> > This is how the response to LAYOUTGET looks like.
>> >=20
>> > Network File System, Ops(2): SEQUENCE GETDEVINFO
>> > =C2=A0=C2=A0 [Program Version: 4]
>> > =C2=A0=C2=A0 [V4 Procedure: COMPOUND (1)]
>> > =C2=A0=C2=A0 Status: NFS4_OK (0)
>> > =C2=A0=C2=A0 Tag: <EMPTY>
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length: 0
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contents: <EMPTY>
>> > =C2=A0=C2=A0 Operations (count: 2)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opcode: SEQUENCE (53)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opcode: GETDEVINFO (47)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Status: N=
FS4_OK (0)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 layout ty=
pe: LAYOUT4_FLEX_FILES (4)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r_netid: =
tcp
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 length: 3
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 contents: tcp
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 fill bytes: opaque data
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r_addr: 1=
31.169.191.143.125.49
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 length: 22
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 contents: 131.169.191.143.125.49
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 fill bytes: opaque data
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 version: =
4
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minorvers=
ion: 1
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_rsize=
: 1048576
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_wsize=
: 1048576
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tightly c=
oupled: Yes
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 notify_ma=
sk: 0x00000006 (Change, Delete)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 notify_type: Change (1)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 notify_type: Delete (2)
>> > =C2=A0=C2=A0 [Main Opcode: GETDEVINFO (47)]
>> >=20
>> >=20
>> >=20
>> > The MDS is mounted with IPv4. I can provide the full packet trace,
>> > if needed.
>> >=20
>> >=20
>> > Regards,
>> > =C2=A0 Tigran.
>> >=20
>> >=20
>> > ----- Original Message -----
>> > > From: "trondmy" <trondmy@hammerspace.com>
>> > > To: "linux-nfs" <linux-nfs@vger.kernel.org>
>> > > Sent: Wednesday, 11 November, 2020 00:42:31
>> > > Subject: Re: [PATCH v3 00/11] Add RDMA support to the pNFS
>> > > file+flexfiles data
>> > > channels
>> >=20
>> > > On Tue, 2020-11-10 at 18:18 -0500, trondmy@kernel.org=C2=A0wrote:
>> > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
>> > > >=20
>> > > > Add support for connecting to the pNFS files/flexfiles data
>> > > > servers
>> > > > through RDMA, assuming that the GETDEVICEINFO call advertises
>> > > > that
>> > > > support.
>> > > >=20
>> > > > v2: Fix layoutstats encoding for pNFS/flexfiles.
>> > > > v3: Move most of the netid handling into the SUNRPC and RDMA
>> > > > modules.
>> > > > =C2=A0=C2=A0=C2=A0 Fix up the mount code to benefit more from auto=
mated
>> > > > loading of
>> > > > =C2=A0=C2=A0=C2=A0 SUNRPC transport modules.
>> > > >=20
>> > >=20
>> > > Note that one cleanup that I did not perform, but which really
>> > > could be
>> > > useful should we want to add more transport mechanisms, is to
>> > > move the
>> > > code to parse stringified addresses (in particular IETF style
>> > > "universal addresses") into the transport modules so that the
>> > > actual
>> > > parsing of mount and pNFS transport info can be automatically
>> > > extended
>> > > when new transport modules are added.
>> > >=20
>> > > --
>> > > Trond Myklebust
>> > > Linux NFS client maintainer, Hammerspace
>> > > trond.myklebust@hammerspace.com
>=20
> --
> Trond Myklebust
> CTO, Hammerspace Inc
> 4984 El Camino Real, Suite 208
> Los Altos, CA 94022
>=20
> www.hammer.space
