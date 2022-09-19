Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62DA5BD3B4
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Sep 2022 19:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiISRaI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Sep 2022 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiISRaG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Sep 2022 13:30:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A301211A12
        for <linux-nfs@vger.kernel.org>; Mon, 19 Sep 2022 10:30:04 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JGO4ac002805;
        Mon, 19 Sep 2022 17:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=sSUEX3s4w8s3FJPrgy4j8d/i9Wxd7CyT9ApYhdRMf5c=;
 b=OwhIMzveXhnMdvGMqpGMNhGNUDmkLuWjqsbgm+Nxqio+3oLETTVCpISe9kH1Wqi+j5rT
 LsiQBsJcYCTOBRve5QBGN7QolhL98/NZV+4pnMrdmg8AovgsY6341vdbJb+zRTPt1WLq
 IPZVLLnynUfUa1jqIhgx0gWG2/D9y0jyOMAexSsMT+ZNq2OkB5lza7ac5uAbxQy3W6go
 FkbXuoj+t+YwZ+XJuhO35h82HnVEcRF//dVXrtBx8eRpEhyRBHujPgcKbGLakIvXqcJX
 T7Gai6kdOlLfKmNvyMenrF4anBOvtxLLHD3+1HCLsD5DWM8Bpd9U6YM+aHtnYHX4o+Iq BQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn688cd5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 17:30:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JHCMFI009400;
        Mon, 19 Sep 2022 17:30:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3c8195g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 17:30:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhLuvlEMbGL0DdLUf7RujsL+WvFXInN9NiIs75m/OFtGk9fYXZdyelgoVdqQCmSAHWQEWsD9VAuVOyvwOEj4j1tnzmgM2Zi+79SQ5KyB1PVkl6GBwL1/+7XjyJJFIfiozz45SfrHyxq3jC5JFayeR6r3BLroERtFUYObUeeASnimVtQmSVx4wysp84YjtQ7VMNOmp/y5bdZZXUcZgzLudGNSr8TEcaEQ1Lqs52mW4Ppx+vh89pqfAuZ+2usEEl7/DM9sfEAyblbaEf80Nf+Y4GaH50eKhnpuzk9DRqGFFWNRxHLg1k7UUsr+7gedpCYmBd5UfdI5JTmQUZcbU4kW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSUEX3s4w8s3FJPrgy4j8d/i9Wxd7CyT9ApYhdRMf5c=;
 b=C9JpWVaZRDhM3C7OMaH8evtYc3VEWiItdTbOMGQGbqzO2uaKdZDDrVahRmD/GHFCgGqk1plT79KeIf5SgExjLskfWgU3vKJ8jTxy6WOxJ1fiv6NGeoZ0ZasJWZ3C/hClo6uGmfs7jOhEzxToFqAU02pnTeGZlNh83K1rjYHygSd5XurSYJHbeKO3BJ914H+bDPlaDIYYEIaeNxepCK46LCpjIEc2z9uAa5LNVRah0XuyTFdGoADYbhrLb8Xn+Zb8NpYlgZRTBRcUwpW6UdYqFb8wMatSBminiajWKeg/iPPpg5hBFeGieex4LncDKo4kEAdm7puNe2fzo3GNHg51dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSUEX3s4w8s3FJPrgy4j8d/i9Wxd7CyT9ApYhdRMf5c=;
 b=tOT20Omxwhp3X8IyNQ2gtrUjTDSW+CuVz1VwVXiU2qi7I40WEQIl3LQ1+1AMbKpYr8Eq829Pmj1vAa30uEp+qNBu6tP8F9jY9sh+v3Y3wRPuMtvwQ8mp9Ip4O0qUMg57Im1CV0/HjTCpaj/BqRxRgxlXZ6bysCiIXKIZpHPwjEo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6115.namprd10.prod.outlook.com (2603:10b6:208:3ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 19 Sep
 2022 17:29:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%6]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 17:29:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
CC:     Steve Dickson <SteveD@redhat.com>
Subject: Re: NFSv4.0 callback with Kerberos not working
Thread-Topic: NFSv4.0 callback with Kerberos not working
Thread-Index: AQHYzDztMjvFTe1YQk+Xo2ZaIaryZK3nAmcA
Date:   Mon, 19 Sep 2022 17:29:59 +0000
Message-ID: <EA530823-7957-4D54-8AB2-27D2F936B742@oracle.com>
References: <BE5B3B9F-53EF-49E4-9734-CF89936D5F2C@oracle.com>
In-Reply-To: <BE5B3B9F-53EF-49E4-9734-CF89936D5F2C@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BL3PR10MB6115:EE_
x-ms-office365-filtering-correlation-id: b2b71acb-f6a6-4c1c-5cd5-08da9a6493af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8GZCl+TewOCTlPwtaEmsQjdfusf5FQ3uKo3sk2mg5mzeiU6D2JpFSODEaq5cOND9aIJQ5/6EdzwIAkdsjDyi/cmrhHBs1zjPBRJtjpAZVgt0l/UDQ8NY+VfC+fBJTBlv/iVNl1SnTXvmiLNd1eK+8w3Gs+SXsIOE/hrhLuNs8jHvToMqYDHtbfZAU4pXmTJDIfIj82LCqmFeqtCvytaJIQnjOK0FZVsS8dTb98Bbb0PGz7uYtxRFnbI9jquLiI7y/D7F5d1pB5DnOFAvFIlwR1CrBb8MymYUfszJdAi+uoduS/52t26ZHzROqViMw9l+/xgLNwDfa1xGHf3HiUQKQa8HOFlLGkYAnRIJunG4VanBlaVQ8WsNOSmh1gpIhpDJVGwvLzDUUioOQxjDukgM12kdcSKQehb2uB+0lgLHZA6QwFYaIhlMWXAKVdUls7kTLcFtm/V35A3sV7dz0HSOSR2C/1qlqIg5p6A415RMx3a4Q8MhyvD+cJFRjGao+YFSkqMUiWaWVSMtm73w8SVH5k82ViEpRt6/nuKs0jyAjxCxKwjXHXYjh+MV0HeYrya68eoGeEfSDhL7ZrLvI/DfTcHAsYmyIQyT52HPkfBFxOfMKMsQR2YKtxqD9RKrrO7T6yZoGJycfTYJLI+Mr8DGXz7yf1xi84fhyxWSVew3SJvcjSbaD/OVZJ+ZQHH17Ed9QA0kwmFfH1sSoXKjTsMQ27uFwg5/7uQpE5VJMx1eVaHdL9veRIuS8pin4C7q2yyW+/FLto5tG+tLwiu7u4Oa3F1LjfAwwbjr+brH0cTHTn8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199015)(26005)(4326008)(66556008)(2906002)(186003)(6916009)(66946007)(38070700005)(83380400001)(76116006)(8936002)(66446008)(6512007)(122000001)(2616005)(5660300002)(66899012)(66476007)(478600001)(53546011)(8676002)(6486002)(91956017)(6506007)(71200400001)(64756008)(86362001)(36756003)(316002)(38100700002)(33656002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3el52KxqmHnWBol5MvSRpd/W1j6qbYTgZElf02tz/odkAsukA5uubpXuU1pS?=
 =?us-ascii?Q?j7vsQjwDPkJhsxQA4oqJu3wesosR3V0YM/Q2pp3D02KN3NUsHDF5WWbmjLRb?=
 =?us-ascii?Q?I40aTKXiAu8YXsODcLXRLsCVDmxSj2vBM8kMIVyQ3SbcTJUufvbbgOYVku/e?=
 =?us-ascii?Q?wqy7RsEi5cRcnm6bV/PKRoNsGYimvI+5Z3AjwgoRX0ZjQTZbZlrPqnxdu+KC?=
 =?us-ascii?Q?uG+74dKFN87iQgauYEFOdIBMfQARkK6S+Rg27rYiXc4UbLVDqyfrPnFYCZe9?=
 =?us-ascii?Q?QHoGfdhtkJVqonffwdaxUYcKEYQQko0I6KVpNyUIorT8+m6CxsQEnYB+zkCX?=
 =?us-ascii?Q?ESqBkXLqwrBeuQXZXwz7+SpKYrcIbwZtebjSewN5kDNnJrYqDi/oCnlA4PgO?=
 =?us-ascii?Q?6JOINQOGheBSiiCkjQ+nBWM6rdNAKxHgg5WeI/LEzBRYvrh3BupYxuHlUvqA?=
 =?us-ascii?Q?Jl1vCcw3VnSC6bOfQEJB+Fc+ttrPPcnidQk6QDYpd+2Hy2LiF2rNDTP1YZ+0?=
 =?us-ascii?Q?la8P/mJQeMuGz7SXC+TVbqdXqCzVtBp40W9Aoa1vjp2q/h13iz4UF1ja+fj9?=
 =?us-ascii?Q?mTNAjwALcTQoucGh1PSQaUAvLDPZ61lo5+kdxpWeceB5V4IziPnHXSeeJ8E7?=
 =?us-ascii?Q?amdPXRJfzxjYLCX+uOHzq7rfl7lMViZ8DEKBOEha88Ht3tEhyA05ovnhrlrb?=
 =?us-ascii?Q?431zG44I520mQxE6APL1lJRhNT8pisvlQOxqAmPq0D9VgyK/Wc8jUj3kmRu0?=
 =?us-ascii?Q?8WJH/ljFnR4o4Ed1fEEN5XmoL72irR9LDmRjsINWVBc6SWSiAtvdmwk2CZBF?=
 =?us-ascii?Q?tWZf+vrbLMJXAEqshbDeOFoWtwy9jSiAdKOl/BUb6pd76FlpvLRYebNHJNDD?=
 =?us-ascii?Q?gI7kJFwyyGZkgSNwAoLwHKd3HO7D4eduwD6fbSiJyf1XVFZo7GoeKvODz00+?=
 =?us-ascii?Q?3i63rKH8wpir6ik8rMdLHuTN0cFFRdvmJ+ck+2hLpStSOHCiBZcWliLiJoNV?=
 =?us-ascii?Q?n674wDmrUZqq/5q/ZcW8ePHi7EFHlKwm20DK9RM+B1VEFw4tlCGd1MiYTc0q?=
 =?us-ascii?Q?hxQE9RvtCZ4fIzcT32UgRXkyYNmnRiBqBF8R3TWAjeAbHVfCU77XFsqHSmYK?=
 =?us-ascii?Q?h6iDyn/uo27H9nYPQTt1T+U/DYRkspHpPtNNEJbDXiGPJqrDHGwbq3W1gcDD?=
 =?us-ascii?Q?R8ab+khv0yFu93Hscer9FFX+2tXkD7RDg1s3azxIFHXJCkOyoj7Ncow5iyBw?=
 =?us-ascii?Q?DBDdHknL7AJX+vmbfhAO7Me+/47wrJ5JwUKLG0APAIqlg1JOkQWe+jw9qg36?=
 =?us-ascii?Q?3tRdSDzznGjBfTh898xvx7egltVWFl5p0caJXxRpa5XI8+4klTzbkRTZaFfV?=
 =?us-ascii?Q?4uAS385QKyYzITKw1M/CRALYKvii9G3o0GGAMawq7u2eYU+HplyVuvFAzTeZ?=
 =?us-ascii?Q?Cq89URH79cy8r+NHlXGzXeQzudq+YG6rxPvnyIzLCpbEt4sAby2X2T2Mfg07?=
 =?us-ascii?Q?TNfFMgvO2uiNvxALXhqo2QnmLIQxr+xOJhcy10f7yCEX/Vx/keMqh+66x4B6?=
 =?us-ascii?Q?K5OK3lsz0wOrSj9HDSTGlEmhypoxdGBeTpj1RJH1EyVU6bRp6E4+G31+oeU+?=
 =?us-ascii?Q?4Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <059277737392524F9A5BC277A7226060@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b71acb-f6a6-4c1c-5cd5-08da9a6493af
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 17:29:59.1340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fn0VXT5R6i8EMwZ15xZabFMzz9aMv/r0udTenjiIPdV6bPNuxzLxlHESCMeJMQMdtWi9pR3AvbKwwE23otMQiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190117
X-Proofpoint-GUID: q-zd5_qeFYT3TPOYxDOO2j5EXmbfR7J7
X-Proofpoint-ORIG-GUID: q-zd5_qeFYT3TPOYxDOO2j5EXmbfR7J7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clarification:


> On Sep 19, 2022, at 11:31 AM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>=20
> Hi-
>=20
> I rediscovered recently that NFSv4.0 with Kerberos does not work on
> multi-homed hosts. This is true even with sec=3Dsys because the client
> attempts to establish a GSS context when there is a keytab present.
>=20
> Basically my test environment has to work for sec=3Dsys and sec=3Dkrb*
> and for all NFS versions and minor versions. Thus I keep a keytab
> on it.
>=20
> Now, I have three network interfaces on my client: one RoCE, one
> IB, and one GbE. They are each on their own subnet and each has
> a unique hostname (that varies in the domain part).
>=20
> But mounting one of my IB or RoCE test servers with NFSv4.0 results
> in the infamous "NFSv4: Invalid callback credential" message. The
> client always uses the principal for GbE interface...

... for the forward channel, but it expects the backchannel
principal to be the acceptor that the server saw on the forward
channel.

Currently, when a Linux client mounts server.ib.example.net:

   - the client uses the acceptor host@client.example.net
     (if the keytab happens to have a host@ principal)

   - the authenticates to the principal nfs@server.ib.example.net

   - the client expects to see the server authenticate to
     nfs@client.ib.example.net as the principal on the
     backchannel, but gets host@client.example.net instead,
     and check_gss_callback_principal() fails

IIUC, the NFS protocol expects:
   - the client uses the acceptor nfs@client.ib.example.net

   - the server uses the principal nfs@server.ib.example.net

   - the client should see nfs@client.ib.example.net as the
     principal on the backchannel


> This was working at one point, but seems to have devolved over time.
>=20
>=20
> Here are some of the problems I found:
>=20
> 1. The kernel always asks for service=3D* .
>=20
> If your system's keytab has only "nfs" service principals in it,
> that should be OK. If it has a "host" principal in it, that's
> going to be the first one that gssd picks up.
>=20
> NFSv4.0 callback does not work with a host@ acceptor -- it wants
> nfs@.
>=20
> There are two possible workarounds:
>=20
> a. Remove all but the nfs@ keys from your system's keytab.
>=20
> b. Modify the kernel to use "service=3Dnfs" in the upcall.
>=20
> I favor b. The NFS specifications do not appear to require it,
> but they suggest that an "nfs@" principal is always to be used
> for protecting NFS with GSS.

And: the NFS callback channel is an NFS service that needs to
use an nfs@ service principal. So when the server attempts to
authenticate to the client's callback service, it always needs
to use nfs@.


> But more importantly, other subsystems share the keytab with
> NFS. They might want a root@ or host@ key in there too, and
> that will break NFSv4.0.
>=20
>=20
> 2. nsswitch.conf::hosts now has a "myhostname" service, and it's
> placed before the "resolve" service by default.
>=20
> I enabled systemd-resolved on my systems, to be part of the future.
> Yeah, I know, right?
>=20
> Now, a DNS query for the hostname associated with any of my system's
> IP addresses (and there are several) always resolves to the One True
> hostname. So gssd always gets the wrong principal when mounting via
> alternate network interfaces.
>=20
> Moving "myhostname" after "resolve" seems to address this issue, but
> I'm told that this will be reverted if I reconfigure the resolver or
> update the system?
>=20
> The bugs I found that document this issue keep getting closed because
> they target a specific Fedora version which always gets EOL'd after
> a year.
>=20
>=20
> 3. gssproxy gets the acceptor name wrong.
>=20
> It has the same problem as in 2, even with the nsswitch.conf
> workaround in place. So gssproxy returns the same principal for every
> network interface on the system, and that breaks NFSv4.0 callback.
>=20
> Note also that adding "use-gss-proxy=3D0" to /etc/nfs.conf does not
> appear to disable gssproxy. I had to boot up and then "sudo systemctl
> stop gssproxy" and even then, the kernel still tries to make upcalls
> to it.
>=20
> I noticed that setting the gssd debugging options in /etc/nfs.conf
> also has no effect. I had to edit the gssd service files to get
> debugging information
>=20
> I'm not sure how to fix this one -- I'd like to see gssproxy
> fixed to deal with this correctly, but also whatever reads
> /etc/nfs.conf needs to get fixed so that the gssd settings in
> that file are observed.
>=20
>=20
> Any opinions or guidance appreciated, especially from maintainers
> (like, aw hell naw, or yep that's broken, send a patch).

Another possibility would be to make check_gss_callback_principal()
more flexible.


--
Chuck Lever



