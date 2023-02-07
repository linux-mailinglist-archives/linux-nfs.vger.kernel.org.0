Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A3C68DCD8
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Feb 2023 16:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjBGPWE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Feb 2023 10:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjBGPVy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Feb 2023 10:21:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D28144A1
        for <linux-nfs@vger.kernel.org>; Tue,  7 Feb 2023 07:21:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8323FB819CD
        for <linux-nfs@vger.kernel.org>; Tue,  7 Feb 2023 15:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D051BC4339B;
        Tue,  7 Feb 2023 15:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675783310;
        bh=4yOplTOxXmVfnh3HCod4TifPb+qBDUJsd6goWxEBz+c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mexSsdvMu3b7OXUAkeEfx95MCs6Okqgg1fXvs39GpA9+9IRUQKtvGPst6BswIBTpC
         qFthKJfv3d0PzWTXm0WqtxRi4Awd0Ue7LyU8iSmcrQEHZrmyX8ZuvZxK2OxGWiTGuM
         WuUnT6ANaYKtIn4c26fO2Q6mFXSMbydEEM06dkH0VjSboLP4J4MivRr9omlpvqEiwc
         MFIibbcFoSPotkRKIyWbMg9NWhNTcJWdkWlJ3zkbcmoZNwuwXsTkulsNY29NHfZCGl
         29gpe1/4LJFTppuR1Kt6u6s5gv4gbyL92lpwSv6TLpOeD9uh/l2z1F+u6mGs+EJLJQ
         vNnhXRd+/70oQ==
Message-ID: <8a02c86882bc47c1c1387dba8c7d756237cb3f3f.camel@kernel.org>
Subject: Re: Reoccurring 5 second delays during NFS calls
From:   Jeff Layton <jlayton@kernel.org>
To:     Florian =?ISO-8859-1?Q?M=F6ller?= 
        <fmoeller@mathematik.uni-wuerzburg.de>, linux-nfs@vger.kernel.org
Cc:     Andreas Seeg <andreas.seeg@mathematik.uni-wuerzburg.de>
Date:   Tue, 07 Feb 2023 10:21:48 -0500
In-Reply-To: <59682160-a246-395a-9486-9bbf11686740@mathematik.uni-wuerzburg.de>
References: <59682160-a246-395a-9486-9bbf11686740@mathematik.uni-wuerzburg.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-02-07 at 11:58 +0100, Florian M=F6ller wrote:
> Hi all,
>=20
> we are currently in the process of migrating our file server infrastructu=
re to=20
> NFS. In our test environments, the following problem has now occurred sev=
eral=20
> times in certain situations:
>=20
> A previously very fast NFS file operation suddenly takes 5 seconds longer=
 - per=20
> file. This leads to applications running very slowly and severely delayed=
 file=20
> operations.
>=20
> Here are the details:
>=20
> NFS server:
> OS: Ubuntu 22.04.1, all patches installed
> Kernel: Ubuntu Mainline, Versions
> 	6.1.7-060107-generic_6.1.7-060107.202301181200
>          6.1.8-060108_6.1.8-060108.202301240742
>          6.1.9-060109_6.1.9-060109.202302010835
> Security options: all Kerberos security options are affected
>   (The bug does not seem to occur without Kerberos security.)
> Output of exportfs -v:
> /export=20
> gss/krb5p(async,wdelay,hide,crossmnt,no_subtree_check,fsid=3D0,sec=3Dsys,=
rw,secure,root_squash,no_all_squash)
> /export=20
> gss/krb5(async,wdelay,hide,crossmnt,no_subtree_check,fsid=3D0,sec=3Dsys,r=
w,secure,root_squash,no_all_squash)
>=20


I see you're using the -o async export option. Note that you may end up
with corrupt data on a server reboot (see exports(5) manpage).

Assuming you're aware of this and want to keep that anyway, then the
patch I just posted to the mailing list may help you, if the stalls are
coming during CLOSE operations:

https://lore.kernel.org/linux-nfs/9137413986ba9c2e83c030513fa9ae3358f30a85.=
camel@kernel.org/T/#mcb88f091263d07d8b9c13e6cc5ce0a0413d3f761

>=20
> Client 1:
> OS: Arch Linux, all patches installed
> Kernel: 6.1.9-arch1-2, 6.1.9-arch1-1
> Mount-Line: servername:/ on /nfs type nfs4=20
> (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,hard=
,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dkrb5p,clientaddr=3DXX.XX.XX.XX,l=
ocal_lock=3Dnone,addr=3DYY.YY.YY.YY,_netdev)
> krb5: 1.20.1-1
> libevent: 2.1.12-4
> nfs-utils: 2.6.2-1
> util-linux: 2.38.1-1
>=20
>=20
> Client 2:
> OS: openSuSE 15.4, all patches installed
> Kernel: 5.14.21-150400.24.41-default
> Mount-Line: servername:/ on /nfs type nfs4=20
> (rw,relatime,sync,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255=
,acregmin=3D0,acregmax=3D0,acdirmin=3D0,acdirmax=3D0,softerr,softreval,noac=
,noresvport,proto=3Dtcp,timeo=3D1,retrans=3D2,sec=3Dkrb5,clientaddr=3DXX.XX=
.XX.XX,lookupcache=3Dnone,local_lock=3Dnone,addr=3DYY.YY.YY.YY)=20
>=20
> libgssapi3: 7.8.0-bp154.2.4.1
> libevent: 2.1.8-2.23
> nfs-client: 2.1.1-150100.10.27.1
> util-linux: 2.37.2-140400.8.14.1
>=20
>=20
> The error occurs for example if a file is touched twice:
>=20
> touch testfile && echo "done" && touch testfile && echo "and again"
>=20
> However, touching a large number of files (about 10000) with (pairwise)=
=20
> different filenames works fast.
>=20
>=20
> Here is another example that triggers the error:
>=20
> 1st step: create many files (shell code in Z-shell syntax):
>=20
> for i in {1..10000}; do
> echo "test" > $i.txt
> done
>=20
> This is fast.
>=20
> 2nd step:
>=20
> for i in {1..10000}; do
> echo $i
> cat $i.txt
> done
>=20
> This takes 5 seconds per cat(1) call.
> After unmounting and mounting, the 2nd step also runs quickly at first. B=
ut=20
> after executing the 2nd step several times in a row, the error occurs aga=
in=20
> (quite soon, after the 2nd or 3rd execution).
>=20
> We were not able to reproduce the error without a Kerberos security type =
set.
>=20
>=20
> Attached are a log from the server and from the client. In both cases
>=20
> rpcdebug -m nfs -s all
> rpcdebug -m nfsd -s all
> rpcdebug -m rpc -s all
>=20
> was set.
>=20
>=20
> Best regards,
> Florian M=F6ller
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
