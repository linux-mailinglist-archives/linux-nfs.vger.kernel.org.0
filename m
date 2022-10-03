Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E405F3042
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Oct 2022 14:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiJCM0d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 08:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJCM0c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 08:26:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACBB32D87
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 05:26:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60FF061049
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 12:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796A4C433C1;
        Mon,  3 Oct 2022 12:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664799990;
        bh=tnP+xIoBBX9g144p/VX/tFx+XgD5ZGTG7ZZwPx6yGp0=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=aPdG124zRFylagsJDo/inrsYBI1vJzzXb3txfGnXe3lOOyKgLQs0ma5pLqFBODSKt
         7q+DDYVTjoLcbNdezshVxS75iPfSAbMcMlClK3lh3S/KiRAXtL325Hp8MYbHYr6Z/h
         b6gr/S61C1647VME5SqAmsBMLqDt7yoRDwnVnG9VnjgDluBM/C35E9lG1PWkJvP/in
         R1dnorquflR/ypC6IHxEmbStqTD8dxcR+xtuTtayTtkgZVKRKjNRwB+iX15o77TmrL
         MlgMJBjdCS+FbqefVjjhm7AdrGF2VqaMLum3xpTigP4hAIEExv4hk4jambpv9YFbWi
         F8wy8wJlJNyhQ==
Message-ID: <c163b299164cd9abe21325a947c9efe908a04331.camel@kernel.org>
Subject: Re: nfs4.1+: workaround for defunct clientaddr?
From:   Jeff Layton <jlayton@kernel.org>
To:     Manfred Schwarb <manfred99@gmx.ch>, linux-nfs@vger.kernel.org
Date:   Mon, 03 Oct 2022 08:26:28 -0400
In-Reply-To: <8550c032-2ef8-4ddb-19a0-307777bd9645@gmx.ch>
References: <39bf58c7-47d9-744b-6d26-d672aa713024@gmx.ch>
         <8cd63730f7b5f3e2aa3bde98587de0c6a42b384b.camel@kernel.org>
         <8550c032-2ef8-4ddb-19a0-307777bd9645@gmx.ch>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-10-03 at 13:55 +0200, Manfred Schwarb wrote:
> Am 03.10.22 um 13:39 schrieb Jeff Layton:
> > On Sun, 2022-10-02 at 14:35 +0200, Manfred Schwarb wrote:
> > > Hi,
> > >=20
> > > I have 2 boxes connected with 2 network cards each, one
> > > crossover connection and one connection via LAN.
> > > I want to use the crossover connection for backup,
> > > so I want to be able to select exactly this wire when
> > > doing my NFS backup transfers. Everything interconnected via NFS4.1
> > > and automount.
> > >=20
> > > Now the thing is, if there is an already existing connection
> > > via LAN, I am not able to select the crossover connection,
> > > there is some session reuse against my will.
> > >=20
> > > automount config:
> > > /net/192.168.99.1  -fstype=3Dnfs4,nfsvers=3D4,minorversion=3D1,client=
addr=3D192.168.99.100   /  192.168.99.1:/
> > > /net2/192.168.98.1 -fstype=3Dnfs4,nfsvers=3D4,minorversion=3D1,client=
addr=3D192.168.98.100   /  192.168.98.1:/
> > >=20
> > > mount -l:
> > > 192.168.99.1:/data on /net/192.168.99.1/data type nfs4 (...,clientadd=
r=3D192.168.99.100,addr=3D192.168.99.1)
> > > 192.168.99.1:/data on /net2/192.168.98.1/data type nfs4 (...,clientad=
dr=3D192.168.99.100,addr=3D192.168.99.1)
> > >=20
> > > As you see, both connections are on "192.168.99.1:/data", and the bac=
kup runs
> > > over the same wire as all user communication, which is not desired.
> > > This even happens if I explicitly set some clientaddr=3D option.
> > >=20
> > > Now I found two workarounds:
> > > - downgrade to NFS 4.0, clientaddr seems to work with it
> > > - choose different NFS versions, i.e. one connection with
> > >   minorversion=3D1 and the other with minorversion=3D2
> > >=20
> > > Both possibilities seem a bit lame to me.
> > > Are there some other (recommended) variants which do what I want?
> > >=20
> > > It seems different minor versions result in different "nfs4_unique_id=
" values,
> > > and therefore no session sharing occurs. But why do different network
> > > interfaces (via explicitly set clientaddr=3D by user) not result in d=
ifferent
> > > "nfs4_unique_id" values?
> > >=20
> > > Thanks for any comments and advice,
> > > Manfred
> >=20
> > That sounds like a bug. We probably need to compare the clientaddr
> > values in nfs_compare_super or nfs_compare_mount_options so that it
> > doesn't match if the clientaddrs are different.
> >=20


Actually, I take it back, clientaddr is specifically advertised as being
for NFSv4.0 only. The workaround for you is "nosharecache", which will
force the mount under /net2 to get a new superblock altogether.

> > As a workaround, you can probably mount the second mount with
> > -o nosharecache and get what you want.
>=20
> Indeed, nosharecache works. But the man page has some scary words for it:
>   "This is considered a data risk".
>=20

Yeah, it does sound scary but it's not a huge issue unless you're doing
I/O to the same files at the same time via both mounts. With
"sharecache" (the default) you get better cache coherency in that
situation since the inode and its pagecache are the same.

With "nosharecache" you need to be more careful to flush caches, etc. if
you are doing reads and writes to the same files via different paths. If
you need careful coordination there, then you probably want to use file
locking.
--
Jeff Layton <jlayton@kernel.org>
