Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45164DBA7F
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Mar 2022 23:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343897AbiCPWGb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Mar 2022 18:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243216AbiCPWG3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Mar 2022 18:06:29 -0400
Received: from smtpout-2.cvg.de (smtpout-2.cvg.de [IPv6:2003:49:a034:1067:5::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB511D9
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 15:05:12 -0700 (PDT)
Received: from mail-mta-3.intern.sigma-chemnitz.de (mail-mta-3.intern.sigma-chemnitz.de [192.168.12.71])
        by mail-out-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 22GM5AKZ001402
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 23:05:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
        s=v2012061000; t=1647468311;
        bh=OnlYcD2Bt1lsZjDgEnNXPDoWxg9Bx81/JrBm8vdvjRs=; l=2823;
        h=From:To:Cc:Subject:References:Date:In-Reply-To;
        b=FzsMjKL4JLRa2GVzCHW8QaXlLNkzOhy1TEBa5R8B5wCXqqVSBYooi2kbj5Uc1a4HB
         Cib1SnH7iQmqkWu5Cb3XQoDhAB65pUmbrRBL4fta1QJADFaYi0Fpt9N7P77v6cYVay
         Z13xMcdfE7f65H/P+/nH+84WAiaNV87yXIe37VCA=
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
        by mail-mta-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 22GM58b9741411
        for <linux-nfs@vger.kernel.org> from enrico.scholz@sigma-chemnitz.de; Wed, 16 Mar 2022 23:05:09 +0100
Received: from mail-msa-2.intern.sigma-chemnitz.de ( [192.168.12.72]) by reddoxx.intern.sigma-chemnitz.de
        (Reddoxx engine) with SMTP id 713C0D4D2C9; Wed, 16 Mar 2022 23:05:08 +0100
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
        by mail-msa-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 22GM57Ze001374
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 16 Mar 2022 23:05:08 +0100
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.94.2)
        (envelope-from <ensc@sigma-chemnitz.de>)
        id 1nUblR-0003PJ-UO; Wed, 16 Mar 2022 23:05:06 +0100
From:   Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Random NFS client lockups
References: <lyr172gl1t.fsf@ensc-virt.intern.sigma-chemnitz.de>
        <lysfrhr51i.fsf@ensc-virt.intern.sigma-chemnitz.de>
        <fd4d017808a5ff9492fc6dfce8506f64e600fb35.camel@hammerspace.com>
Date:   Wed, 16 Mar 2022 23:05:05 +0100
In-Reply-To: <fd4d017808a5ff9492fc6dfce8506f64e600fb35.camel@hammerspace.com>
        (Trond Myklebust's message of "Wed, 16 Mar 2022 21:39:37 +0000")
Message-ID: <lyilsd8sfi.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond Myklebust <trondmy@hammerspace.com> writes:

>> Mar 16 05:02:40.051969: RPC:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state 8=
 conn 1 dead 0 zapped 1 sk_shutdown 1
>> Mar 16 05:02:40.052067: RPC:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xs_clos=
e xprt 0000000022aecad1
>> Mar 16 05:02:40.052189: RPC:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state 7=
 conn 0 dead 0 zapped 1 sk_shutdown 3
>> Mar 16 05:02:40.052243: RPC:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xs_erro=
r_report client 0000000022aecad1, error=3D32...
>> Mar 16 05:02:40.052367: RPC:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state 7=
 conn 0 dead 0 zapped 1 sk_shutdown 3
>> Mar 16 05:02:40.052503: RPC:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state 7=
 conn 0 dead 0 zapped 1 sk_shutdown 3
>> Mar 16 05:02:40.053201: RPC:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xs_conn=
ect scheduled xprt 0000000022aecad1
>> Mar 16 05:02:40.055886: RPC:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xs_bind=
 0000:0000:0000:0000:0000:0000:0000:0000:875: ok (0)
>> __A__=C2=A0 05:02:40.055947: RPC:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wo=
rker connecting xprt 0000000022aecad1 via tcp to XXXXX:2001:1022:: (port 20=
49)
>> Mar 16 05:02:40.055995: RPC:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0000000=
022aecad1 connect status 115 connected 0 sock state 2
>
> Socket is in TCP state 2 =3D=3D SYN_SENT
> So the client requested to connect to the server

server closed the connection (state 8, CLOSE_WAIT), client cleaned up
correctly and reconnected.


>> Mar 16 05:07:28.326605: RPC:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state 8=
 conn 1 dead 0 zapped 1 sk_shutdown 1
>
> Socket is now in TCP state 8 =3D=3D TCP_CLOSE_WAIT...
>
> That means the server sent a FIN to the client to request that the
> connection be closed.

yes; the same situation like above


>> Mar 16 05:07:28.326679: RPC:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xs_conn=
ect scheduled xprt 0000000022aecad1
>> __B__=C2=A0 05:07:28.326978: RPC:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wo=
rker connecting xprt 0000000022aecad1 via tcp to XXXXX:2001:1022:: (port 20=
49)
>> Mar 16 05:07:28.327050: RPC:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0000000=
022aecad1 connect status 0 connected 0 sock state 8
>> __C__=C2=A0 05:07:28.327113: RPC:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xs=
_close xprt 0000000022aecad1
>
> Client closes the socket, which is still in TCP_CLOSE_WAIT

the 'xs_close' is very likely a reaction to the state change reported
above and should happen before 'xs_connect'.


> Basically, what the above means is that your server is initiating the
> close of the connection, not the client.

yes; but the client should reconnect (and does it in most cases).
Sometimes there seems to be a race which prevents the reconnect and
brings the client in a broken state.



Enrico
