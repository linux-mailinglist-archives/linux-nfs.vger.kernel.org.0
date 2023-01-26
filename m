Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A98467D82B
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Jan 2023 23:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjAZWIG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Jan 2023 17:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjAZWIF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Jan 2023 17:08:05 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2095.outbound.protection.outlook.com [40.107.100.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA90EF8C
        for <linux-nfs@vger.kernel.org>; Thu, 26 Jan 2023 14:08:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaGhzKVuTLYmeJRT4F9tG2YVNjKOKITSmn1QfSXGIAL9qtLkLJ4P1OzajWoI5Oe2jtY5qaKtUc3gghfUX+N+XhDEIrpB0+0ZNW7KyMVU51swr+flvVkeyBDVSQzLYTwJxfpX2XtZc2hMd9BknmozPAW1QboTt8VCPdrZgbml6W5/JjgXEtjI4pzhlSl39UkAzUFdkeouikCSA/cvU97foK0cSH8/nAJOvF/lxkSrioZjOILjSi3cRgxPKTItQnn1AW/GdunQ/ULZZ3smuk2INlXmYLJrajw5qJl11cQoii06qqWtKKsTWhdcf30MzaCxzeOvjeXIHm1rsHMKH0r1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxcd6Z+BISxVJ5wv6Yoe+nT5PPJO6wC8Jjd2/QBAheA=;
 b=dvrnZsywOQwBZv0aP5VuC9pOA1wWz4vkSDpwC5zVDHN/2isHZUxEoKRaXcrjetcGdYf9yFDmZXO8hFbjwkLmiFrJojguos12iBjOE/steV9R349IwmtD9KnDYutaMPX+BArl4k6+y2+3nnDvAGuChjIBhltCTfT6H/DPBS6HDOaDSbqLCaRCsAyTOtp7YDzoR1JN6212eRy3O08WWjznIhixELaNbsZ+VvWcUV2otvgR6W82AIb4UgYuThwMaesWqL0xG6/kj3HTTvzVBiGYwFfXYDt+SPnsdY+eGGzGRR1M30/S1t8G2k931xxBTfRgH1+5rme0IhQvUnQ/fRaMYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=boatrocker.com; dmarc=pass action=none
 header.from=boatrocker.com; dkim=pass header.d=boatrocker.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=boatrocker.onmicrosoft.com; s=selector2-boatrocker-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxcd6Z+BISxVJ5wv6Yoe+nT5PPJO6wC8Jjd2/QBAheA=;
 b=V2d61At3K9r2g3RG7TwQ4Ao/xZ5KKLRCbqca5eOrXDXOl1jj23aih0iECgCb94nxca18voXHxaBVL3paybJcAlhYfIHTLcjp1Ap/JKTUxkQZH3c2oqo0l/VRhWmIW8nAyT+deqe3iTIYiCKy9+Xd9toxue1NLqMTLEPhlty6Zfc=
Received: from YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:69::7)
 by YT3PR01MB8135.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 22:08:02 +0000
Received: from YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7303:f215:657e:1643]) by YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7303:f215:657e:1643%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 22:08:02 +0000
From:   Andrew Klaassen <andrew.klaassen@boatrocker.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: Trying to reduce NFSv4 timeouts to a few seconds on an
 established connection
Thread-Topic: Trying to reduce NFSv4 timeouts to a few seconds on an
 established connection
Thread-Index: AdkvR33g3mzLGSb7R/abGwkCKolj9QCUyz5AAA3zOxA=
Date:   Thu, 26 Jan 2023 22:08:02 +0000
Message-ID: <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=boatrocker.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YQBPR01MB10724:EE_|YT3PR01MB8135:EE_
x-ms-office365-filtering-correlation-id: cba942a6-1d6e-4a9e-f187-08daffe9cb05
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199018)(83380400001)(2940100002)(186003)(26005)(9686003)(2906002)(55236004)(6506007)(38070700005)(71200400001)(5660300002)(316002)(8676002)(8936002)(66476007)(6916009)(66946007)(76116006)(52536014)(64756008)(66446008)(66556008)(41300700001)(38100700002)(33656002)(478600001)(7696005)(122000001)(44832011)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kFSGImXeaYFpKM8dUlt9NcwH/W65UlBljCClx236kmspXiuuUHdP1odL7V66m0OjQqBwZThaERqJhTwJPO+zek/Qot0S6pD4Z05kd7162tr+5NNWsqtM9iQf9Bc4iZ+jkyLgpLs2c5VSTFoZWnXAs6osq+IRbCxoQQ+Y4LQCd93Su2e5RY5V4iMjONilEbWlkNTVfl5oeqFTmyFTHoGF/exQ8PKTL91QTyZTQR9V4rOO6GlL7I1W6yAqc8mNuArHI9oS2qPxX8/5LEzkOfYBsX04h5ILi0NiHw9LHU1XrAo27bbo0yr/e2PWKVuTXY8OsN95dvxPL0YR4/Wb/eRc/GRL6AYwKf1gVbpXuWtYSuJXFlgyWWHkh1YczFBujRhQ4VNwVOGpsMrO5OsK9vHW8tunvrnlv3MfazJoMHOCqVvMJ+Oe+S0CxPw5Kw3Gwpg7PqMpvOdUkZzyaBiC9GbNnknPpOU72zVu7E1CHZ+nIcrUPxMye0cOYWueydYpyxu8epqPpTjv9D8mMuLljz2XnAUI6JVTwE52iPJno9Fw3Hpf2bkMKeD0UvW0UTfwfomIGuvFwBvKgboP+giQXl1KcKpfpTHQsvlUDAFKElnRI7K5QupP2vDcYF9oRN/w4C5uPlFviuro9EeWtMljJLqzaMcwtzLeoy4t6Tbtrqrl8CHkerFbKcx0jGbxcN13796uCAy6YJgrPYqsvbdDz9DTaQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EJxkxNA4DBj2HVTo4qheHZCwPfoBwe1l91AJ6qR0l8e43SrLxZcDKTc94YWI?=
 =?us-ascii?Q?Zfl5aBrs54ECiJ9ffzKA5gTcXUznhLOTRJ4qUUXpN4BTi2FMcN4IgTgi7ny/?=
 =?us-ascii?Q?wFxAx7P8HbVmB8rMl9qt/QlXHIc4aWrWt76R8Qi4ysk/NbcnqR0/MMNwB2gh?=
 =?us-ascii?Q?twbWj56cQmFIX2oEF6QZNpRr4dGE0ZoY3WqN9bYyUoMz7GMWpnO30daZcM/W?=
 =?us-ascii?Q?4/bYPeEyTX73uHewB3aZFiZ5ywkldbBDguQh5uFTSAIlB/t1R4FIKkFD0T+7?=
 =?us-ascii?Q?VObyTuASnuqOqMGnfaPpueeMTN3fKEoawsEV8140QFEt/KcHZ1b1EKZ+bae0?=
 =?us-ascii?Q?D/W7m1XVvcXN58mLON7NJXkIfzwvQP8OVKLsn+UdfJiEpuzA0WWc3AI6vw6Q?=
 =?us-ascii?Q?1+R2ZfuLYatog9I2dTZD/x37evVI2GFuQ1OqADnblFL0vmDTYdM7WwsRecUM?=
 =?us-ascii?Q?GBd9AY4Sf5cTVVxyySZ+LCq5S0WxkeVSwEoCcxd8+GYAvR5V6G8fOI17SLL3?=
 =?us-ascii?Q?T+cGH/JMRDLpFY1q3w/lYro2rYYw35VVu5wxfc3bP3B8eQShJAAJdqu6TPXo?=
 =?us-ascii?Q?I7ieF2KKCpWH4aLZhlnHR1JFOdp8vscD4xgqcTbLb0l76YgGCHk4/bTi/h9r?=
 =?us-ascii?Q?I9yXtE5P4AO1EdfhcAqnDPTGOGmIyroty1ScF2SWyCBdQo9+EQefFk04JpIR?=
 =?us-ascii?Q?Kn+4M6aHeTWHTL0fb/k9fxHHRo34CeAKTx96E5NvW24wD0pAiI82kFde7lTa?=
 =?us-ascii?Q?6tveUIF4CiJwVXe5UcfiJLw8ps3ulPbjaI4K1wRKzsqyPlCpM2UqUYByhUp5?=
 =?us-ascii?Q?KLYQmWeGricpHIOSvQ2LTChyF8DBLboxC29E3cY1ttiTVtO7Dc3vhHqAhFBy?=
 =?us-ascii?Q?tkkH0PXfB7MQJkAKDZ2zsyQ+HQY/tcqGX1+4Ie65sVZn6fqb612XLwmzRCLy?=
 =?us-ascii?Q?84B72rRhvy4654h9CsL5XmKMOhVEgc6Ue3/Pr9mkYiHSiRnxiE0sBaEPNUPk?=
 =?us-ascii?Q?83uMq2EGkNftaQIOjlWJZdQSmMUNYlzai9O6W4E031MCFGje42cabdlPasfQ?=
 =?us-ascii?Q?SbtjNoXvTUMF9SCJ5oQY+ldIK5sQ9/n/vmhxMNMxOcK5Hcyi1VsM0v33QMa2?=
 =?us-ascii?Q?OVM1byoDC5uh0Ss0Bt33ttA6gQzpflOP2l7rat4kRakXWC3qGkPpRtkJG/wh?=
 =?us-ascii?Q?E4KHW3SvfOrkhiNIbYA1QW/zCAbeYRpkIr12dG4juppKm4Y6Iak6NaPnxXnk?=
 =?us-ascii?Q?RMaCJLqqlXDpYEECZKEe6D/JVqyeNHUdvf1qZG7oZ15QSoZiwf/slbgXh7FE?=
 =?us-ascii?Q?KzOOToLziCNe2QdPpr/Ndcyn7y751d+L39seHAebMPd619lJivRl0STa0tEX?=
 =?us-ascii?Q?+6aqIhgFEK+c/fOh+envaaDL5kcc3pCTVG9A0z/svaMMgDDMcXqzDwdltfuU?=
 =?us-ascii?Q?tqGs/VTSSjmLJfsDlXAmVhvER50f4rxblUpdlYW6JJBKMxzVamgiyCw8kgWT?=
 =?us-ascii?Q?iwaZbORm4ot7DPR0QoGh/P1wBlXapoulT1VMSkNw8QXK4NF/zanS4L9Ne0yF?=
 =?us-ascii?Q?0LCmExwOYSqk0HZP4imKWIigVBcuBn8pFut7gWvWTsku15g9iCXsV4mRHWs4?=
 =?us-ascii?Q?Kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: boatrocker.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cba942a6-1d6e-4a9e-f187-08daffe9cb05
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 22:08:02.4817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fd92a966-cd05-4664-965e-b69e7529781a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ghwXpdLb2LFzFET+TJyzBlH5g/rvM6Zvegz0Gati/Fw34ynDPXTnlamJRMl3MmuwDtvGdMkO8CYAKt/mSngevAXUiaIqkBRgDmvaBZX+xY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8135
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> From: Andrew Klaassen <andrew.klaassen@boatrocker.com>
> Sent: Thursday, January 26, 2023 10:32 AM
>=20
> > From: Andrew Klaassen <andrew.klaassen@boatrocker.com>
> > Sent: Monday, January 23, 2023 11:31 AM
> >
> > Hello,
> >
> > There's a specific NFSv4 mount on a specific machine which we'd like
> > to timeout and return an error after a few seconds if the server goes a=
way.
> >
> > I've confirmed the following on two different kernels, 4.18.0-
> > 348.12.2.el8_5.x86_64 and 6.1.7-200.fc37.x86_64.
> >
> > I've been able to get both autofs and the mount command to cooperate,
> > so that the mount attempt fails after an arbitrary number of seconds.
> > This mount command, for example, will fail after 6 seconds, as
> > expected based on the timeo=3D20,retrans=3D2,retry=3D0 options:
> >
> > $ time sudo mount -t nfs4 -o
> > rw,relatime,sync,vers=3D4.2,rsize=3D131072,wsize=3D131072,namlen=3D255,=
acregmi
> > n
> >
> =3D0,acregmax=3D0,acdirmin=3D0,acdirmax=3D0,soft,noac,proto=3Dtcp,timeo=
=3D20,retra
> > n s=3D2,retry=3D0,sec=3Dsys thor04:/mnt/thorfs04  /mnt/thor04
> > mount.nfs4: Connection timed out
> >
> > real    0m6.084s
> > user    0m0.007s
> > sys     0m0.015s
> >
> > However, if the share is already mounted and the server goes away, the
> > timeout is always 2 minutes plus the time I expect based on timeo and
> > retrans.  In this case, 2 minutes and 6 seconds:
> >
> > $ time ls /mnt/thor04
> > ls: cannot access '/mnt/thor04': Connection timed out
> >
> > real    2m6.025s
> > user    0m0.003s
> > sys     0m0.000s
> >
> > Watching the outgoing packets in the second case, the pattern is
> > always the
> > same:
> >  - 0.2 seconds between the first two, then doubling each time until
> > the two minute mark is exceeded (so the last NFS packet, which is
> > always the 11th packet, is sent around 1:45 after the first).
> >  - Then some generic packets that start exactly-ish on the two minute
> > mark, 1 second between the first two, then doubling each time.  (By
> > this time the NFS command has given up.)
> >
> > 11:10:21.898305 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834889483 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:10:22.105189 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834889690 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:10:22.313290 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834889898 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:10:22.721269 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834890306 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:10:23.569192 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834891154 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:10:25.233212 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834892818 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:10:28.497282 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834896082 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:10:35.025219 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834902610 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:10:48.337201 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834915922 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:11:14.449303 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834942034 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:12:08.721251 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834996306 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:12:22.545394 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq
> > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835010130 ecr
> > 0,nop,wscale 7], length 0
> > 11:12:23.570199 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq
> > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835011155 ecr
> > 0,nop,wscale 7], length 0
> > 11:12:25.617284 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq
> > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835013202 ecr
> > 0,nop,wscale 7], length 0
> > 11:12:29.649219 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq
> > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835017234 ecr
> > 0,nop,wscale 7], length 0
> > 11:12:37.905274 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq
> > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835025490 ecr
> > 0,nop,wscale 7], length 0
> > 11:12:54.289212 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq
> > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835041874 ecr
> > 0,nop,wscale 7], length 0
> > 11:13:26.545304 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq
> > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835074130 ecr
> > 0,nop,wscale 7], length 0
> >
> > I tried changing tcp_retries2 as suggested in another thread from this =
list:
> >
> > # echo 3 > /proc/sys/net/ipv4/tcp_retries2
> >
> > ...but it made no difference on either kernel.  The 2 minute timeout
> > also doesn't seem to match with what I'd calculate from the initial
> > value of tcp_retries2, which should give a much higher timeout.
> >
> > The only clue I've been able to find is in the retry=3Dn entry in the
> > NFS
> > manpage:
> >
> > " For TCP the default is 3 minutes, but system TCP connection timeouts
> > will sometimes limit the timeout of each retransmission to around 2
> minutes."
> >
> > What I'm not able to make sense of:
> >  - The retry option says that it applies to mount operations, not
> > read/write operations.  However, in this case I'm seeing the 2 minute
> > delay on read/write operations but *not* mount operations.
> >  - A couple of hours of searching didn't lead me to any kernel
> > settings that would result in a 2 minute timeout.
> >
> > Does anyone have any clues about a) what's happening and b) how to get
> > our desired behaviour of being able to control both mount and
> > read/write timeouts down to a few seconds?
> >
> > Thanks.
>=20
> I thought that changing TCP_RTO_MAX in include/net/tcp.h from 120 to
> something smaller and recompiling the kernel would change the 2 minute
> timeout, but it had no effect.  I'm going to keep poking through the kern=
el
> code to see if there's a knob I can turn to change the 2 minute timeout, =
so
> that I can at least understand where it's coming from.
>=20
> Any hints as to where I should be looking?

I believe I've made some progress with this today:

 - Calls to rpc_create() from fs/nfs/client.c are sending an rpc_timeout st=
ruct with their args.
 - rpc_create() does *not* pass the timeout on to xprt_create_transport(), =
which then can't pass it on to xs_setup_tcp().
 - xs_setup_tcp(), having no timeout passed to it, uses xs_tcp_default_time=
out instead.
 - changing xs_tcp_default_timeout changes the "ls" timeout behaviour I des=
cribed above.

In theory all of this means that the timeout simply needs to be passed thro=
ugh and used instead of xs_tcp_default_timeout.  I'm going to give this a t=
ry tomorrow.

Here's what I'm going to try first; I'm no C programmer, though, so any adv=
ice or corrections you might have would be appreciated.

Thanks.

Andrew

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 0b0b9f1eed46..1350c1f489f7 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -532,6 +532,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *arg=
s)
                .addrlen =3D args->addrsize,
                .servername =3D args->servername,
                .bc_xprt =3D args->bc_xprt,
+               .timeout =3D args->timeout,
        };
        char servername[48];
        struct rpc_clnt *clnt;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index aaa5b2741b79..adc79d94b59e 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -3003,7 +3003,7 @@ static struct rpc_xprt *xs_setup_tcp(struct xprt_crea=
te *args)
        xprt->idle_timeout =3D XS_IDLE_DISC_TO;

        xprt->ops =3D &xs_tcp_ops;
-       xprt->timeout =3D &xs_tcp_default_timeout;
+       xprt->timeout =3D args->timeout;

        xprt->max_reconnect_timeout =3D xprt->timeout->to_maxval;
        xprt->connect_timeout =3D xprt->timeout->to_initval *

