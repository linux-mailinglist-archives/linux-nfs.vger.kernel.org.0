Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BF85F2FC3
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Oct 2022 13:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJCLjN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 07:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJCLjH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 07:39:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7290EE0F
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 04:39:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C013B8106E
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 11:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D141FC433D6;
        Mon,  3 Oct 2022 11:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664797144;
        bh=Hn7dwJdMjfjwj64RrVYMraCigdGyaiUEZKiIc3cfoCU=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Xw2o/piAQ3bKX/00ZYZeJLu4wDithvikWPxWuw4pcncwwuxXwTKRsUJlyYPgAGWcf
         gclYd3MfQrKAMVgOs+dYi2S237qGqqlJM61cvAMyQgg4kXiIOPYJwsaBMegP2lTfOZ
         jWfYF3XogbM7pLdI+o2Hx/ya0o1Vc2IlvkckBJi92JD9izI3E18sKfaPVLkZiZjq8L
         Kq5END2gZHLUjgY5KAssJ0xXTYr6iTf4LFjwmNnw7xvL5xA1ZWOcYshKLF5HGgGXbi
         5OukBAFoAkDPxacxtQ7R7mXmNJWlyip2s9TIYlvxVa8FArYkxP1QZm+lduFYYnJNIE
         NXGEIwMnMbNIg==
Message-ID: <8cd63730f7b5f3e2aa3bde98587de0c6a42b384b.camel@kernel.org>
Subject: Re: nfs4.1+: workaround for defunct clientaddr?
From:   Jeff Layton <jlayton@kernel.org>
To:     Manfred Schwarb <manfred99@gmx.ch>, linux-nfs@vger.kernel.org
Date:   Mon, 03 Oct 2022 07:39:02 -0400
In-Reply-To: <39bf58c7-47d9-744b-6d26-d672aa713024@gmx.ch>
References: <39bf58c7-47d9-744b-6d26-d672aa713024@gmx.ch>
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

On Sun, 2022-10-02 at 14:35 +0200, Manfred Schwarb wrote:
> Hi,
>=20
> I have 2 boxes connected with 2 network cards each, one
> crossover connection and one connection via LAN.
> I want to use the crossover connection for backup,
> so I want to be able to select exactly this wire when
> doing my NFS backup transfers. Everything interconnected via NFS4.1
> and automount.
>=20
> Now the thing is, if there is an already existing connection
> via LAN, I am not able to select the crossover connection,
> there is some session reuse against my will.
>=20
> automount config:
> /net/192.168.99.1  -fstype=3Dnfs4,nfsvers=3D4,minorversion=3D1,clientaddr=
=3D192.168.99.100   /  192.168.99.1:/
> /net2/192.168.98.1 -fstype=3Dnfs4,nfsvers=3D4,minorversion=3D1,clientaddr=
=3D192.168.98.100   /  192.168.98.1:/
>=20
> mount -l:
> 192.168.99.1:/data on /net/192.168.99.1/data type nfs4 (...,clientaddr=3D=
192.168.99.100,addr=3D192.168.99.1)
> 192.168.99.1:/data on /net2/192.168.98.1/data type nfs4 (...,clientaddr=
=3D192.168.99.100,addr=3D192.168.99.1)
>=20
> As you see, both connections are on "192.168.99.1:/data", and the backup =
runs
> over the same wire as all user communication, which is not desired.
> This even happens if I explicitly set some clientaddr=3D option.
>=20
> Now I found two workarounds:
> - downgrade to NFS 4.0, clientaddr seems to work with it
> - choose different NFS versions, i.e. one connection with
>   minorversion=3D1 and the other with minorversion=3D2
>=20
> Both possibilities seem a bit lame to me.
> Are there some other (recommended) variants which do what I want?
>=20
> It seems different minor versions result in different "nfs4_unique_id" va=
lues,
> and therefore no session sharing occurs. But why do different network
> interfaces (via explicitly set clientaddr=3D by user) not result in diffe=
rent
> "nfs4_unique_id" values?
>=20
> Thanks for any comments and advice,
> Manfred

That sounds like a bug. We probably need to compare the clientaddr
values in nfs_compare_super or nfs_compare_mount_options so that it
doesn't match if the clientaddrs are different.

As a workaround, you can probably mount the second mount with
-o nosharecache and get what you want.
--=20
Jeff Layton <jlayton@kernel.org>
