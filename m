Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2BC793F26
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Sep 2023 16:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbjIFOnu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Sep 2023 10:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjIFOnt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Sep 2023 10:43:49 -0400
X-Greylist: delayed 977 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Sep 2023 07:43:44 PDT
Received: from antispam-1.ensmp.fr (courriel-3.mines-paristech.fr [77.158.173.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E365172E
        for <linux-nfs@vger.kernel.org>; Wed,  6 Sep 2023 07:43:44 -0700 (PDT)
Received: from z-smtp.mines-paristech.fr (z-smtp.mines-paristech.fr [77.158.173.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by antispam-1.ensmp.fr (antispam.mines-paristech.fr) with ESMTPS id 4F7B555F6D
        for <linux-nfs@vger.kernel.org>; Wed,  6 Sep 2023 16:27:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by z-smtp.mines-paristech.fr (Postfix) with ESMTP id 4CB7F1C00E2
        for <linux-nfs@vger.kernel.org>; Wed,  6 Sep 2023 16:27:25 +0200 (CEST)
Received: from z-smtp.mines-paristech.fr ([127.0.0.1])
        by localhost (z-smtp.mines-paristech.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Q4-b-06TYOMy for <linux-nfs@vger.kernel.org>;
        Wed,  6 Sep 2023 16:27:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by z-smtp.mines-paristech.fr (Postfix) with ESMTP id F24AF1C00F2
        for <linux-nfs@vger.kernel.org>; Wed,  6 Sep 2023 16:27:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 z-smtp.mines-paristech.fr F24AF1C00F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mines-paristech.fr;
        s=22b35c52-6eac-4abe-ae29-0aba6ae35064; t=1694010445;
        bh=RRqVqUDYgKnxt1jU6d9dk30v+TC3pEPVp/KIgIzdMKk=;
        h=Message-ID:From:To:Date:MIME-Version;
        b=dauEpTUoTl2HGJRijSrooQO8saiwF+36UyGYWGnRFPSIPKmbcrWcGgaUW4s3nOqAc
         rEs27xGz+iqXjwpBFHnUpHF05CGSMKk4BXZ9g71ABAiXBikD+gngDQ6UUPWyZSAdSg
         P/GLzUsYtcEEcQ0DC0TqTDfGQ+N+DGMJvVI9HuoqHvwVeE/83FHIYiyEIDq2NPMhXY
         8hSuvA52nCt+phe4gHvOT3EShCpyKfdo838IrIMAZDJIsWbNDhjY0Ina4qKO8yitOi
         OPCSTHUtNMQgSJ1SoUw7VEU+Lggvt9TibYMqnFJPVFFfDGadXapbfnPa6DF2rmX1ga
         X/BXqFmTB+ufg==
X-Virus-Scanned: amavisd-new at z-smtp.mines-paristech.fr
Received: from z-smtp.mines-paristech.fr ([127.0.0.1])
        by localhost (z-smtp.mines-paristech.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id esRXExOwMFCy for <linux-nfs@vger.kernel.org>;
        Wed,  6 Sep 2023 16:27:24 +0200 (CEST)
Received: from hive.interne.mines-paristech.fr (nat2-sop.mines-paristech.fr [77.158.181.2])
        by z-smtp.mines-paristech.fr (Postfix) with ESMTPSA id CB4821C00E2
        for <linux-nfs@vger.kernel.org>; Wed,  6 Sep 2023 16:27:24 +0200 (CEST)
Message-ID: <0394bda7dd3e5dd4f1d42b790f736d52c1f01e74.camel@mines-paristech.fr>
Subject: Unexpected high latency
From:   Benoit Gschwind <benoit.gschwind@mines-paristech.fr>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 06 Sep 2023 16:27:24 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-DRWEB-SCAN: disabled
X-CLAMAV-SCAN: ok
X-VRSPAM-SCORE: -100
X-VRSPAM-STATE: legit
X-VRSPAM-CAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudehfedgjeejucetufdoteggodetrfcurfhrohhfihhlvgemucggteffgffitefvgfghtegjpdggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvffftggfggfgsehtqhertddtreejnecuhfhrohhmpeeuvghnohhithcuifhstghhfihinhguuceosggvnhhoihhtrdhgshgthhifihhnugesmhhinhgvshdqphgrrhhishhtvggthhdrfhhrqeenucggtffrrghtthgvrhhnpeeuhfdtfeeghefhteffteevfeelheettdetkeeltdehieejudffieegieejieduffenucfkphepjeejrdduheekrddujeefrddufeejpdejjedrudehkedrudekuddrvdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdpihhnvghtpeejjedrudehkedrudejfedrudefjedphhgvlhhopeiiqdhsmhhtphdrmhhinhgvshdqphgrrhhishhtvggthhdrfhhrpdhmrghilhhfrhhomhepsggvnhhoihhtrdhgshgthhifihhnugesmhhinhgvshdqphgrrhhishhtvggthhdrfhhrpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

I did set up nfs client[1]/server[2] backed by raid6/btrfs filesystem,
and I get very noticeable latency, i.e. opening/closing files take 5
seconds.=C2=A0
To access the issue, I did basic benchmark of the filesystem using
bonnie++2.00a and when I use it on the server without nfs in the middle
I get the following results:

Version  2.00       ------Sequential Output------ --Sequential Input- --R=
andom-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --S=
eeks--
Name:Size etc        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /s=
ec %CP
SERVER       63808M  200k  98  379m  64  183m  51 1146k  99  1.0g  84 533=
.8  62
Latency               162ms   38609us     494ms   25987us     452ms     2=
04ms
Version  2.00       ------Sequential Create------ --------Random Create--=
------
SERVER              -Create-- --Read--- -Delete-- -Create-- --Read--- -De=
lete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /s=
ec %CP
                 16 16384  29 +++++ +++ 16384  92 16384  66 +++++ +++ 163=
84  84
Latency              1106us     420us     824us     321us      25us    37=
88us
1.98,2.00,SERVER,1,1693984997,63808M,,8192,5,200,98,387908,64,187033,51,1=
146,99,1078676,84,533.8,62,16,,,,,3780,29,+++++,+++,16381,92,15276,66,+++=
++,+++,13370,84,162ms,38609us,494ms,25987us,452ms,204ms,1106us,420us,824u=
s,321us,25us,3788us

In this benchmark, all seems good enoush, even if they are slow legacy di=
sk (i.e. not SSD).

But When I put the nfs + network in the middle with following settings (c=
at /proc/mount):

X.X.X.X:/m0 /mnt/m0 nfs4 rw,nosuid,nodev,relatime,vers=3D4.2,rsize=3D1048=
576,wsize=3D1048576,namlen=3D255,hard,proto=3Dtcp,timeo=3D6000,retrans=3D=
2,sec=3Dkrb5i,clientaddr=3DX.X.X.X,fsc,local_lock=3Dnone,addr=3DX.X.X.X 0=
 0

I get the following result (from nfs client):

Version  2.00       ------Sequential Output------ --Sequential Input- --R=
andom-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --S=
eeks--
Name:Size etc        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /s=
ec %CP
CLIENT         126G  702k  96  111m  18 31.7m  11 1852k  98 47.1m  10 407=
.8  16
Latency             27010us   56044us   12422ms   33647us     506ms     2=
60ms
Version  2.00       ------Sequential Create------ --------Random Create--=
------
CLIENT              -Create-- --Read--- -Delete-- -Create-- --Read--- -De=
lete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /s=
ec %CP
                 16 16384  23 +++++ +++ 16384  16 16384   7 16384  32 163=
84  18
Latency             11543us   22772us    1871us    8949ms     840us    36=
54us
1.98,2.00,CLIENT,1,1694022898,126G,,8192,5,702,96,113319,18,32419,11,1852=
,98,48229,10,407.8,16,16,,,,,627,23,+++++,+++,2620,16,587,7,3147,32,2846,=
18,27010us,56044us,12422ms,33647us,506ms,260ms,11543us,22772us,1871us,894=
9ms,840us,3654us

In this benchmark I get top speed at 100 MB/s wich is expected because
I'm using 1Gb/s network link. But for the rewrite benchmark I get an
unexpected 30 MB/s and more over *12 seconds* of latency. I also get
the unexpected latency for the create bechmark where I jump from <1ms
to nearly *9 seconds*.

Did I my setup is wrong ? Does it expected ?


Thank you, best regards

[1] client kernel: Linux 5.10.0-23-amd64 #1 SMP Debian 5.10.179-1 (2023-0=
5-12) x86_64 GNU/Linux
[2] server kernel: Linux 5.10.0-25-amd64 #1 SMP Debian 5.10.191-1 (2023-0=
8-16) x86_64 GNU/Linux

--
Benoit Gschwind



