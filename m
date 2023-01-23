Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB40678176
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jan 2023 17:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjAWQbM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Jan 2023 11:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjAWQbM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Jan 2023 11:31:12 -0500
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2095.outbound.protection.outlook.com [40.107.115.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A752A99F
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 08:31:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJD80PUIUAVNVPIgzUHCHp9YnPhSP1jDS/dSPz/upWUTE+2+HdrEKD41a+NOVH1y12LWHU4mKIYxFSkfarjGSQcwe3na0OukiFctpEz3WbCXXdrDXQPzCurU728ColAQo/3ynHmY6I6FS6aegCIXoS2F25i+AGjcrv8H3E/XMuinwy+fxq0CUNB7CYyGVGCA1j/9WLofYWKzLYzR4Iu9oxf5/4KAyCsTE+zH2W0hnIHNPNhtEz6nNiCrU3va2ADsgCZc79VJlDs+r7BbKvNMnjGhEYqqSxBonmuTmQxvMOjnTm6GatLirrWQj2o6IkLrwNJzUfAZ4x5jkGRDxtZSkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0JvS1aVmIwueVV4/l8u+mBC5o9ObLUN97js6CqcDO8=;
 b=a7VIZ+8QjHlO+yzLaTGAEHpmYFbYZDU+aB/OKzaafoqgwtfIavrjX6GLfrn5vwjtj5XCJ9Yy8coEgHqOXJSNFV8UVP0dyk2Qt0QFEcZqoNcPIVWSoewepqG30/qWATflktArHb2qKollWLoVpTtE2u8L1g7I/ECsAQzaDgHg2nhO/bcFntLYZZxK7+HiqOdMCNBD/nLyks0gqYgcpX+tdaVN79/ZIvHWt2p//Wu7s4ioxjuss4mNG3GNAaEpHsVU6BOrRm9jCjiXvMnYecsCFtLXGIT8DOappOLWWMcTvqxRWK6Hbo3aX5mY2ntv2ysBoj0SDNe3pF0bNyuztSFyrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=boatrocker.com; dmarc=pass action=none
 header.from=boatrocker.com; dkim=pass header.d=boatrocker.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=boatrocker.onmicrosoft.com; s=selector2-boatrocker-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0JvS1aVmIwueVV4/l8u+mBC5o9ObLUN97js6CqcDO8=;
 b=roFdDM/S0GRxurE493Kjf2I0PX33EghSMZ6vSPkrKE0G/lollGEfDD8tidPeYkoejRgrTrmlp0k8y8KI0iC96LpB0JCncDppPlY682Pn5BgGW6iB4DWPTfqOfIIGeQHQs76tUHVUUAdLj510naip6H5yN6fkqzCelnNoEFWewoU=
Received: from YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:69::7)
 by YT4PR01MB10599.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 16:31:08 +0000
Received: from YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7303:f215:657e:1643]) by YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7303:f215:657e:1643%4]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 16:31:08 +0000
From:   Andrew Klaassen <andrew.klaassen@boatrocker.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Trying to reduce NFSv4 timeouts to a few seconds on an established
 connection
Thread-Topic: Trying to reduce NFSv4 timeouts to a few seconds on an
 established connection
Thread-Index: AdkvR33g3mzLGSb7R/abGwkCKolj9Q==
Date:   Mon, 23 Jan 2023 16:31:08 +0000
Message-ID: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=boatrocker.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YQBPR01MB10724:EE_|YT4PR01MB10599:EE_
x-ms-office365-filtering-correlation-id: 27adc022-3cfa-47c0-89bf-08dafd5f3b6f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(39850400004)(346002)(366004)(451199015)(122000001)(83380400001)(33656002)(38100700002)(38070700005)(86362001)(2906002)(5660300002)(41300700001)(44832011)(8936002)(52536014)(55016003)(8676002)(9686003)(6916009)(6506007)(55236004)(26005)(316002)(66946007)(76116006)(66556008)(66476007)(64756008)(66446008)(186003)(478600001)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YY8U2DmojW+IQZza6i8Dvpnb1zy3cryzBH+H6sGJnbJ9UTf5zFJWXIXdUC+MemytX/bK3NjNDf10PhZ9+4vycjhcKbSXMCxXZFuBuL32d1g8PQPewTRYlTzvpvTxgeFhRXwMetcmuefK0UpGglEerZn6ntwUqjaYaGbYm0Xh5TAP33+WKKeNMvyQ00+FThtvw1vSuMtr7Cv3miVSFVxm1AanZIC1toVOToZ1/2T98EjKi2AmNMi93lwEEw4PX8mZGgEor0maloVQBv1/B00Yx27cKfEKPXsigTCtvsd1TfAdcZyuo7rc6nt4ay4IEKf0XynFynQotYr7Yp/cxyR6iHYqJG1SPJfB4JVxtm9Xpq6CxsnC+ZAzv4h+Q4wenBpU+Pd1Fr7c1qeJjxS40RX4zRz+T9G8z0/9nnRMQa4aVCO6BRk3iHKIue9kzO06ACv64tAz8c9yPROmL3qtzesAdTV6ZKKJmTwsacdcBdg74A2cPsF1KgBt5ifX/7CWLwOoaEXnkLj8ezrxGZvBauwD6ZCYogijhQSL9cCMiIxQYW1Jqa++hcWZQLvKKurrTblZUyuuvLvByr1CcuFMk8W9UuP/fIb8V8EPvhD43exbs3KJsA+AFxuaTr+uWZdstT3hCB4akCS2KB2/L3xWjakcSR+F8WYl4/qzCsfhKAM0NMcSgZ7ncrvTErIz2VYrtV2qVblLN+HZayZbfAH6Fvkikw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s9MC+BPeSHBGACYYW88HpaozCviElIXN38RXnCVb0/AK83rRVn4WAPze7xrM?=
 =?us-ascii?Q?VpmqIBzkj1/P8AcR/92vL0V01l8lWxaI7c+xTbqxZxYIBEdSrSnk1HxaeghD?=
 =?us-ascii?Q?IfnEvwtscjU8nQCWf/z7ZvydIFKVud1G5Sha8pECKY8K7whXS3ReLZ2owPE+?=
 =?us-ascii?Q?SecLizhuofqcKbN/lx4HPXw7ViDytAIRH7iLTez9P5Rt+B8Sag9C9ybHPttX?=
 =?us-ascii?Q?EvwN/d/WGZyICUfyzGkEswbsvZXvy+WysfbMX+hIE30F87rMxkgYzdhbdnWz?=
 =?us-ascii?Q?pKX3MVdQFSdLgDeRNv/yiX6DCkBRi8uwc8l20Vpo7Ojoax8b2NJ5J45zWpYN?=
 =?us-ascii?Q?niWEQVqtVoG7h01LuSonGoBOlVZiZ7SRjpzwSVhb4b1RQWtk/saeOhRtLw7F?=
 =?us-ascii?Q?vlq99PNd+OAXa9fVB91be2Hb+ftJpP0gp0hehFjPYZExuCUbrjOHY9VVGKOA?=
 =?us-ascii?Q?sdrc1jo0DfAP9KMGvknn/zM1eSk9MOBGiObyBSFyJQqguW/ddjIdC4WLmWuA?=
 =?us-ascii?Q?B4Ctt1FprDB2XPZhcI254Lcp4MS5XUQR4JOJ+vJ8zrQwasPsj54fbxsfnJi3?=
 =?us-ascii?Q?B8KtqGpn9gzMPntJgeUlSfJRUrOqkqy0DAlZGcgo1WWhtG/9CcDt67O5/foN?=
 =?us-ascii?Q?vywoRyvjKhDFzOT9faw7NhlIhg7HnNtvmDoH7fi7JMhDYvFe+0dJhk9x6lTJ?=
 =?us-ascii?Q?6D4rmgkKAl6BERizyhSNq3yxaWCmpBB7orCUbf0Y1Rqz6Ljt6wsYKzAbCnKT?=
 =?us-ascii?Q?JLBaZWCiQjigpH3MZDRLNdy3pBO+ICVmE5+jb9L8BDCQv8YWebZJ6dBsUIAa?=
 =?us-ascii?Q?GQY1/KPH8bA8tn0V06v0kBbNJoSuwGAxTISjnbjU3YREK7U5n4639WGokt2P?=
 =?us-ascii?Q?HdYHVFO1ZLsrtNGIxmUNphGvOBYAo8wfynvqmoyq4+ZcfyilGyfxpAX4VMUt?=
 =?us-ascii?Q?iS9IS8/AaqSOQGSm6XFHezuYXYSoVm+c0y42O8hyjt1+VMgKTCzxdMV1W/4j?=
 =?us-ascii?Q?GhoVASYowJxU+KlAI4OQyte1qRNoluvQDr9lF7fdc3QKNWv60tNrPPaMPxTa?=
 =?us-ascii?Q?VkYkjrTJGdke6I/Bl5U3VdAc1/aGPYJYudxVo1HFXZfZGnfPx819qVgUYiAf?=
 =?us-ascii?Q?/i0iZHrsZZGgZJzU5opcpWzu0mM5OpAvRLy6v+P/zOv4v+L4z1IP9B+fWVkB?=
 =?us-ascii?Q?sKL2mBOtH5KRP6+J1fzYr5baetfuATSCvdR61Jor0qMPc7QVPyvRN0xSquPH?=
 =?us-ascii?Q?/rGTvUvsqdK1ry8CZCiNmr88ZHE5yrlga3iTuFaUNP/oh8V4rJDHG2Vw2i0M?=
 =?us-ascii?Q?ZQrfPvOXc2SSGUt/Vl3QfiCTMossHxHqAUYOVhFO5Ce/LJrSJC2rRNMCn0j7?=
 =?us-ascii?Q?jI5og6GNNlTxOKxtJeZO/itP6ngPmCx1joXLeibkY3/R82LIGk9o2LQAeHo+?=
 =?us-ascii?Q?7VQc/40wwmq1Y1YGixWv1Xult6GVxkAZILJaVDPyT1J04CF3wBb+6Rv/YavL?=
 =?us-ascii?Q?6PaE5WUvzyYmJizcOUGUaNfPjhgqGVzADhTyRzJGruD5PXGsM5138SYX5gCG?=
 =?us-ascii?Q?eb69GBKtVX2m6fY1je1JF2E0+D2C+9r7IOb71AkznITEY68FpUZcUfo3bW4u?=
 =?us-ascii?Q?5A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: boatrocker.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 27adc022-3cfa-47c0-89bf-08dafd5f3b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 16:31:08.6763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fd92a966-cd05-4664-965e-b69e7529781a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sfwlexShpqGN+24gYo4VIg9wVvAyr/DUlMUdbh036/HzWhOEVrpsqJo1wazAZw3TH1qZwMt+I+iNNWuT1IQnI+wxTzr16xaKKXbUaKcI90E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10599
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

There's a specific NFSv4 mount on a specific machine which we'd like to tim=
eout and return an error after a few seconds if the server goes away.

I've confirmed the following on two different kernels, 4.18.0-348.12.2.el8_=
5.x86_64 and 6.1.7-200.fc37.x86_64.

I've been able to get both autofs and the mount command to cooperate, so th=
at the mount attempt fails after an arbitrary number of seconds.  This moun=
t command, for example, will fail after 6 seconds, as expected based on the=
 timeo=3D20,retrans=3D2,retry=3D0 options:

$ time sudo mount -t nfs4 -o rw,relatime,sync,vers=3D4.2,rsize=3D131072,wsi=
ze=3D131072,namlen=3D255,acregmin=3D0,acregmax=3D0,acdirmin=3D0,acdirmax=3D=
0,soft,noac,proto=3Dtcp,timeo=3D20,retrans=3D2,retry=3D0,sec=3Dsys thor04:/=
mnt/thorfs04  /mnt/thor04
mount.nfs4: Connection timed out

real    0m6.084s
user    0m0.007s
sys     0m0.015s

However, if the share is already mounted and the server goes away, the time=
out is always 2 minutes plus the time I expect based on timeo and retrans. =
 In this case, 2 minutes and 6 seconds:

$ time ls /mnt/thor04
ls: cannot access '/mnt/thor04': Connection timed out

real    2m6.025s
user    0m0.003s
sys     0m0.000s

Watching the outgoing packets in the second case, the pattern is always the=
 same:
 - 0.2 seconds between the first two, then doubling each time until the two=
 minute mark is exceeded (so the last NFS packet, which is always the 11th =
packet, is sent around 1:45 after the first).
 - Then some generic packets that start exactly-ish on the two minute mark,=
 1 second between the first two, then doubling each time.  (By this time th=
e NFS command has given up.)

11:10:21.898305 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 14452:=
14652, ack 18561, win 501, options [nop,nop,TS val 834889483 ecr 1589769203=
], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
11:10:22.105189 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 14452:=
14652, ack 18561, win 501, options [nop,nop,TS val 834889690 ecr 1589769203=
], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
11:10:22.313290 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 14452:=
14652, ack 18561, win 501, options [nop,nop,TS val 834889898 ecr 1589769203=
], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
11:10:22.721269 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 14452:=
14652, ack 18561, win 501, options [nop,nop,TS val 834890306 ecr 1589769203=
], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
11:10:23.569192 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 14452:=
14652, ack 18561, win 501, options [nop,nop,TS val 834891154 ecr 1589769203=
], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
11:10:25.233212 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 14452:=
14652, ack 18561, win 501, options [nop,nop,TS val 834892818 ecr 1589769203=
], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
11:10:28.497282 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 14452:=
14652, ack 18561, win 501, options [nop,nop,TS val 834896082 ecr 1589769203=
], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
11:10:35.025219 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 14452:=
14652, ack 18561, win 501, options [nop,nop,TS val 834902610 ecr 1589769203=
], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
11:10:48.337201 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 14452:=
14652, ack 18561, win 501, options [nop,nop,TS val 834915922 ecr 1589769203=
], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
11:11:14.449303 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 14452:=
14652, ack 18561, win 501, options [nop,nop,TS val 834942034 ecr 1589769203=
], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
11:12:08.721251 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 14452:=
14652, ack 18561, win 501, options [nop,nop,TS val 834996306 ecr 1589769203=
], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
11:12:22.545394 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 1375256=
951, win 64240, options [mss 1460,sackOK,TS val 835010130 ecr 0,nop,wscale =
7], length 0
11:12:23.570199 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 1375256=
951, win 64240, options [mss 1460,sackOK,TS val 835011155 ecr 0,nop,wscale =
7], length 0
11:12:25.617284 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 1375256=
951, win 64240, options [mss 1460,sackOK,TS val 835013202 ecr 0,nop,wscale =
7], length 0
11:12:29.649219 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 1375256=
951, win 64240, options [mss 1460,sackOK,TS val 835017234 ecr 0,nop,wscale =
7], length 0
11:12:37.905274 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 1375256=
951, win 64240, options [mss 1460,sackOK,TS val 835025490 ecr 0,nop,wscale =
7], length 0
11:12:54.289212 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 1375256=
951, win 64240, options [mss 1460,sackOK,TS val 835041874 ecr 0,nop,wscale =
7], length 0
11:13:26.545304 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 1375256=
951, win 64240, options [mss 1460,sackOK,TS val 835074130 ecr 0,nop,wscale =
7], length 0

I tried changing tcp_retries2 as suggested in another thread from this list=
:

# echo 3 > /proc/sys/net/ipv4/tcp_retries2

...but it made no difference on either kernel.  The 2 minute timeout also d=
oesn't seem to match with what I'd calculate from the initial value of tcp_=
retries2, which should give a much higher timeout.

The only clue I've been able to find is in the retry=3Dn entry in the NFS m=
anpage:

" For TCP the default is 3 minutes, but system TCP connection timeouts will=
 sometimes limit the timeout of each retransmission to around 2 minutes."

What I'm not able to make sense of:
 - The retry option says that it applies to mount operations, not read/writ=
e operations.  However, in this case I'm seeing the 2 minute delay on read/=
write operations but *not* mount operations.
 - A couple of hours of searching didn't lead me to any kernel settings tha=
t would result in a 2 minute timeout.

Does anyone have any clues about a) what's happening and b) how to get our =
desired behaviour of being able to control both mount and read/write timeou=
ts down to a few seconds?

Thanks.

Andrew

