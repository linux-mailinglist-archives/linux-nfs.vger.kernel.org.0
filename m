Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7225D2B1B50
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 13:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgKMMsK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 07:48:10 -0500
Received: from smtp-o-2.desy.de ([131.169.56.155]:48904 "EHLO smtp-o-2.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbgKMMsJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 13 Nov 2020 07:48:09 -0500
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
        by smtp-o-2.desy.de (Postfix) with ESMTP id 83D5D160E32
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 13:48:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 83D5D160E32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1605271687; bh=M1+egJWJ5zMCiQlEu1s8nFMM6JKaesEEmWfGgNBV1Kc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=bmxeE8EzYuTYAXe8RMjO9D5NjykbA4y7zU9676VBB1SqDL9FHhImc6OtgVjOH+nlw
         vXuiYWZ4TkDvG6hCCahqlOhUZL0CWNV5YqM5r14OwgUHpWIaTgRk+o4/Lnqu0hbcqa
         J1a1AW/3cGLPZUBzB2nZWdNcYC1xbOmP7VcaFnoY=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id 7F1071A00AC;
        Fri, 13 Nov 2020 13:48:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id 5977980067;
        Fri, 13 Nov 2020 13:48:07 +0100 (CET)
Date:   Fri, 13 Nov 2020 13:48:07 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     trondmy <trondmy@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1375056959.614278.1605271687151.JavaMail.zimbra@desy.de>
In-Reply-To: <3a3696f03eef74ac4723fdc0d1297076a34aa8ae.camel@hammerspace.com>
References: <20201110231906.863446-1-trondmy@kernel.org> <3a3696f03eef74ac4723fdc0d1297076a34aa8ae.camel@hammerspace.com>
Subject: Re: [PATCH v3 00/11] Add RDMA support to the pNFS file+flexfiles
 data channels
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF82 (Mac)/8.8.15_GA_3953)
Thread-Topic: Add RDMA support to the pNFS file+flexfiles data channels
Thread-Index: AQHWt7lTY9xR7iW33kG2X9IO1/hKs6nCBtsAFTVACHI=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



Hi Trond,

whit this changes (3ee69a14f92d74ced2647140b3799511ba4f3fa5) I see an infin=
ite loop
of LAYOUTGET->GETDEVICEINFO->LAYOUTRETURN without any attempt to connect to=
 a DS.

This is how the response to LAYOUTGET looks like.

Network File System, Ops(2): SEQUENCE GETDEVINFO
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Status: NFS4_OK (0)
    Tag: <EMPTY>
        length: 0
        contents: <EMPTY>
    Operations (count: 2)
        Opcode: SEQUENCE (53)
        Opcode: GETDEVINFO (47)
            Status: NFS4_OK (0)
            layout type: LAYOUT4_FLEX_FILES (4)
            r_netid: tcp
                length: 3
                contents: tcp
                fill bytes: opaque data
            r_addr: 131.169.191.143.125.49
                length: 22
                contents: 131.169.191.143.125.49
                fill bytes: opaque data
            version: 4
            minorversion: 1
            max_rsize: 1048576
            max_wsize: 1048576
            tightly coupled: Yes
            notify_mask: 0x00000006 (Change, Delete)
                notify_type: Change (1)
                notify_type: Delete (2)
    [Main Opcode: GETDEVINFO (47)]



The MDS is mounted with IPv4. I can provide the full packet trace, if neede=
d.


Regards,
   Tigran.


----- Original Message -----
> From: "trondmy" <trondmy@hammerspace.com>
> To: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Wednesday, 11 November, 2020 00:42:31
> Subject: Re: [PATCH v3 00/11] Add RDMA support to the pNFS file+flexfiles=
 data channels

> On Tue, 2020-11-10 at 18:18 -0500, trondmy@kernel.org wrote:
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>=20
>> Add support for connecting to the pNFS files/flexfiles data servers
>> through RDMA, assuming that the GETDEVICEINFO call advertises that
>> support.
>>=20
>> v2: Fix layoutstats encoding for pNFS/flexfiles.
>> v3: Move most of the netid handling into the SUNRPC and RDMA modules.
>> =C2=A0=C2=A0=C2=A0 Fix up the mount code to benefit more from automated =
loading of
>> =C2=A0=C2=A0=C2=A0 SUNRPC transport modules.
>>=20
>=20
> Note that one cleanup that I did not perform, but which really could be
> useful should we want to add more transport mechanisms, is to move the
> code to parse stringified addresses (in particular IETF style
> "universal addresses") into the transport modules so that the actual
> parsing of mount and pNFS transport info can be automatically extended
> when new transport modules are added.
>=20
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
