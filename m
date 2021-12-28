Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9362D48062F
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Dec 2021 06:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhL1FL6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Dec 2021 00:11:58 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:60354 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhL1FL6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Dec 2021 00:11:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 063701F37E;
        Tue, 28 Dec 2021 05:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640668317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5p3h+O5QDJ7u5euHzPo+uVlgrtgkEYBoMZvoFGKb41k=;
        b=W+gx+0f6cRoYrjmiGj9S6KSkj5m7UWUVqWNVS7p7Ck4618wVtExsrh3xU4D0Bz+Q+YTZJj
        sGxgaFog0bhP+9AT01WsCzYDpL44LmQ3xALCSwLPdaDNcVccsVrIlZczzrQSUzIvV5eaZH
        kkKPGa+jhQ/8s37S9u8Tt4cbUWIK/tU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640668317;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5p3h+O5QDJ7u5euHzPo+uVlgrtgkEYBoMZvoFGKb41k=;
        b=Kio2aCrTSUMWHiSmBWckfWunZEio1LHUOgrsh48PL20ST42axAiCwnThKYSU3z1nSwTSfB
        nhwsMsx8WvbZQCDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A8F113343;
        Tue, 28 Dec 2021 05:11:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CcRKAZucymGgEwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 28 Dec 2021 05:11:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>
Cc:     "'bfields@fieldses.org'" <bfields@fieldses.org>,
        "'Matt Benjamin'" <mbenjami@redhat.com>,
        "'Trond Myklebust'" <trondmy@hammerspace.com>,
        "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: RE: client caching and locks
In-reply-to: =?utf-8?q?=3COSZPR01MB70504AD76843695B93634510EF439=40OSZPR01MB?=
 =?utf-8?q?7050=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
References: <20200608211945.GB30639@fieldses.org>, =?utf-8?q?=3COSBPR01MB294?=
 =?utf-8?q?9040AA49BC9B5F104DA1FEF9B0=40OSBPR01MB2949=2Ejpnprd01=2Eprod=2Eou?=
 =?utf-8?q?tlook=2Ecom=3E=2C?=
 <22b841f7a8979f19009c96f31a7be88dd177a47a.camel@hammerspace.com>,
 <20200618200905.GA10313@fieldses.org>, <20200622135222.GA6075@fieldses.org>,
 <20201001214749.GK1496@fieldses.org>,
 <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>,
 <20201006172607.GA32640@fieldses.org>, =?utf-8?q?=3COSZPR01MB70504AD7684369?=
 =?utf-8?q?5B93634510EF439=40OSZPR01MB7050=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom?=
 =?utf-8?q?=3E?=
Date:   Tue, 28 Dec 2021 16:11:51 +1100
Message-id: <164066831190.25899.16641224253864656420@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 28 Dec 2021, inoguchi.yuki@fujitsu.com wrote:
> Hi,
>=20
> Sorry to resurrect this old thread, but I wonder how NFS clients should beh=
ave.
>=20
> I'm seeing this behavior when I run a test program using Open MPI. In the t=
est program,=20
> two clients acquire locks at each write location. Then they simultaneously =
write=20
> data to the same file in NFS.=20
>=20
> In other words, the program does just like Bruce explained previously:
>=20
> > > > > >         client 0                        client 1
> > > > > >         --------                        --------
> > > > > >         take write lock on byte 0
> > > > > >                                         take write lock on byte 1
> > > > > >         write 1 to offset 0
> > > > > >           change attribute now x+1
> > > > > >                                         write 1 to offset 1
> > > > > >                                           change attribute now x+2
> > > > > >         getattr returns x+2
> > > > > >                                         getattr returns x+2
> > > > > >         unlock
> > > > > >                                         unlock
> > > > > >
> > > > > >         take readlock on byte 1
>=20
> In my test,=20
> - The file data is zero-filled before the write.
> - client 0 acquires a write lock at offset 0 and writes 1 to it.
> - client 1 acquires a write lock at offset 4 and writes 2 to it.
>=20
> After the test, sometimes I'm seeing the following result. A client doesn't=
 reflect the other's update.
> -----
> - client 0:
> [user@client0 nfs]$ od -i data
> 0000000           1           2
> 0000010
>=20
> - client 1:
> [user@client1 nfs]# od -i data
> 0000000           0           2
> 0000010
>=20
> - NFS server:
> [user@server nfs]# od -i data
> 0000000           1           2
> 0000010
> -----
>=20
> This happens because client 1 receives GETATTR reply after both clients' wr=
ites completed.
> Therefore, client 1 assumes the file data is unchanged since its last write.

This is due to an (arguable) weakness in the NFSv4 protocol.
In NFSv3 the reply to the WRITE request had "wcc" data which would
report change information before and after the write and, if present, it
was required to be atomic.  So, providing timestamps had a high
resolution, the client0 would see change information from *before* the
write from client1 completed.  So it would know it needed to refresh
after that write became visible.

With NFSv4 there is no atomicity guarantees relating to writes and
changeid.
There is provision for atomicity around directory operations, but not
around data operations.

This means that if different clients access a file concurrently, then
their cache can become incorrect.  The only way to ensure uncorrupted
data is to use locking for ALL reads and writes.  The above 'od -i' does
not perform a locked read, so can give incorrect data.
If you got a whole-file lock before reading, then you should get correct
data.=20
You could argue that this requirement (always lock if there is any risk)
is by design, and so this aspect of the protocl is not a weakness.

NeilBrown
