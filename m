Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30102B26C8
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 22:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgKMVax (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 16:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgKMVar (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 16:30:47 -0500
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [IPv6:2001:638:700:1038::1:9a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2C8C08E9AA
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 13:30:46 -0800 (PST)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
        by smtp-o-1.desy.de (Postfix) with ESMTP id C4B69E0844
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 22:30:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de C4B69E0844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1605303042; bh=knUOoEFyNsrSo0KZCAT/vWSAtTrJ3pQ3unJ/BxLFzLw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=vQ9w8zOZPIhYC+jf84uVuQgJ3bGN7HoUAXgDvyENI+vI7n2EbPgDirqz7q2xcG9vI
         hv0IxrhLbZ60WdIvtXFeW9CD8UcdLSUBD3vO3JGJ/RezUV70sXzarC1DCjQdCjL1hJ
         w44DF5qAy2bDSXHAN0SFee0RINoJJKAsck47sXhY=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id C022C1201E1;
        Fri, 13 Nov 2020 22:30:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id 940661001A7;
        Fri, 13 Nov 2020 22:30:42 +0100 (CET)
Date:   Fri, 13 Nov 2020 22:30:41 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     trondmy <trondmy@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <994125760.684644.1605303041944.JavaMail.zimbra@desy.de>
In-Reply-To: <1375056959.614278.1605271687151.JavaMail.zimbra@desy.de>
References: <20201110231906.863446-1-trondmy@kernel.org> <3a3696f03eef74ac4723fdc0d1297076a34aa8ae.camel@hammerspace.com> <1375056959.614278.1605271687151.JavaMail.zimbra@desy.de>
Subject: Re: [PATCH v3 00/11] Add RDMA support to the pNFS file+flexfiles
 data channels
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF82 (Mac)/8.8.15_GA_3953)
Thread-Topic: Add RDMA support to the pNFS file+flexfiles data channels
Thread-Index: AQHWt7lTY9xR7iW33kG2X9IO1/hKs6nCBtsAFTVACHJOhL5PDQ==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


After more testing, it looks like that client doesn't like
notification bitmap:


[31576.789492] --> _nfs4_proc_getdeviceinfo
[31576.789503] --> nfs41_call_sync_prepare data->seq_server 000000001d17c43=
e
[31576.789507] --> nfs4_alloc_slot used_slots=3D0000 highest_used=3D4294967=
295 max_slots=3D16
[31576.789510] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 sloti=
d=3D0
[31576.789527] encode_sequence: sessionid=3D2910695007:150995712:0:16777216=
 seqid=3D92462 slotid=3D0 max_slotid=3D0 cache_this=3D0
[31576.789991] decode_getdeviceinfo: unsupported notification
[31576.790003] --> nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 max_s=
lots=3D16
[31576.790007] <-- nfs4_alloc_slot used_slots=3D0003 highest_used=3D1 sloti=
d=3D1
[31576.790010] nfs4_free_slot: slotid 1 highest_used_slotid 0
[31576.790013] nfs41_sequence_process: Error 0 free the slot
[31576.790017] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[31576.790030] <-- _nfs4_proc_getdeviceinfo status=3D-5
[31576.790034] nfs4_get_device_info getdevice info returns -5
[31576.790084] <-- nfs4_get_device_info d 0000000000000000


Tigran.


----- Original Message -----
> From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> To: "trondmy" <trondmy@hammerspace.com>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Friday, 13 November, 2020 13:48:07
> Subject: Re: [PATCH v3 00/11] Add RDMA support to the pNFS file+flexfiles=
 data channels

> Hi Trond,
>=20
> whit this changes (3ee69a14f92d74ced2647140b3799511ba4f3fa5) I see an inf=
inite
> loop
> of LAYOUTGET->GETDEVICEINFO->LAYOUTRETURN without any attempt to connect =
to a
> DS.
>=20
> This is how the response to LAYOUTGET looks like.
>=20
> Network File System, Ops(2): SEQUENCE GETDEVINFO
>    [Program Version: 4]
>    [V4 Procedure: COMPOUND (1)]
>    Status: NFS4_OK (0)
>    Tag: <EMPTY>
>        length: 0
>        contents: <EMPTY>
>    Operations (count: 2)
>        Opcode: SEQUENCE (53)
>        Opcode: GETDEVINFO (47)
>            Status: NFS4_OK (0)
>            layout type: LAYOUT4_FLEX_FILES (4)
>            r_netid: tcp
>                length: 3
>                contents: tcp
>                fill bytes: opaque data
>            r_addr: 131.169.191.143.125.49
>                length: 22
>                contents: 131.169.191.143.125.49
>                fill bytes: opaque data
>            version: 4
>            minorversion: 1
>            max_rsize: 1048576
>            max_wsize: 1048576
>            tightly coupled: Yes
>            notify_mask: 0x00000006 (Change, Delete)
>                notify_type: Change (1)
>                notify_type: Delete (2)
>    [Main Opcode: GETDEVINFO (47)]
>=20
>=20
>=20
> The MDS is mounted with IPv4. I can provide the full packet trace, if nee=
ded.
>=20
>=20
> Regards,
>   Tigran.
>=20
>=20
> ----- Original Message -----
>> From: "trondmy" <trondmy@hammerspace.com>
>> To: "linux-nfs" <linux-nfs@vger.kernel.org>
>> Sent: Wednesday, 11 November, 2020 00:42:31
>> Subject: Re: [PATCH v3 00/11] Add RDMA support to the pNFS file+flexfile=
s data
>> channels
>=20
>> On Tue, 2020-11-10 at 18:18 -0500, trondmy@kernel.org wrote:
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>=20
>>> Add support for connecting to the pNFS files/flexfiles data servers
>>> through RDMA, assuming that the GETDEVICEINFO call advertises that
>>> support.
>>>=20
>>> v2: Fix layoutstats encoding for pNFS/flexfiles.
>>> v3: Move most of the netid handling into the SUNRPC and RDMA modules.
>>> =C2=A0=C2=A0=C2=A0 Fix up the mount code to benefit more from automated=
 loading of
>>> =C2=A0=C2=A0=C2=A0 SUNRPC transport modules.
>>>=20
>>=20
>> Note that one cleanup that I did not perform, but which really could be
>> useful should we want to add more transport mechanisms, is to move the
>> code to parse stringified addresses (in particular IETF style
>> "universal addresses") into the transport modules so that the actual
>> parsing of mount and pNFS transport info can be automatically extended
>> when new transport modules are added.
>>=20
>> --
>> Trond Myklebust
>> Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
