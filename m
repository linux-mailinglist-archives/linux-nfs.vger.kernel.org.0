Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5CC67818B
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jan 2023 17:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjAWQfO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Jan 2023 11:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjAWQfN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Jan 2023 11:35:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F932BECA
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 08:35:11 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NEhl91030235;
        Mon, 23 Jan 2023 16:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Sf92+Y1mLKfnQUOMbHzkXpzpG/zClGAdEtFy8bjOMBI=;
 b=Ej0ynH/aHeG3XpftNoCSLoblxd//PWTG0KG46TJQsWKfFBiidrXP2o2LLS6lH/8Da99P
 eZY9IfL8mZsMZvR/LaE9VHj9ObKl0xRr1PQlSH5Y/b2fSy0LhogyInx5tkPrcb5I2dL7
 rcScRsOY6bxLJ661cgZpEiJHELl1mV0vtSCtKAdfhbcrq7xQF4IUgtMr3wByyMK7TJlS
 9ExLAVcftZPyNMQ0mR6mkZSphLzn16fdOynGQmFo+eq1zryEkIEvX44SOCwalbsOnTNQ
 06H0WqtgJYbQtWK97shjIEcplB0Ztf4NhaW/VXc10F0lGPBDPZQxTAGs0jxHUMtFeBU1 1A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n88ktu57w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 16:35:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30NG3Kna001102;
        Mon, 23 Jan 2023 16:35:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86ga152n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 16:35:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBpGSDbNGv0VrkMzGcx1z7jEkAce+JikWA9aPrSDgvM38ksJ0wCU/HDqrV7nAYJrT/Sclz+jzybhqFpNvaFddDcXyqs09/CyH4+/OjwbChWMFWrWu9n0x4FVL3LYyPI6Bb00F0wIdRaAV6UCflEGihdyqX2SDZZHYCbKrNTD4exlbZ/brKFj1NaWYkE6iD8FmyUDTIKA+Jg2Acv9Pk51r4qLeSSznQ7bzZupA42kyVAJ/zogdg6HkC9UtwNA8vwjyVMgv4ahlKbdjfl2/DSzHjdd89m9SR0sYJxjlTSn7WSbRPTDm02MIvDck9rLENrZVGwWoBYRY27HKtEmdihYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sf92+Y1mLKfnQUOMbHzkXpzpG/zClGAdEtFy8bjOMBI=;
 b=cDsQE6vSK3V/P8tN7o88Q9yIb2Lu5HCIsN5PQ5DkSJF99yyQWfLilougEO4Fcvehsc4kGMSqnJYFJvzzVx18zFxu68FlnXMlvqz5H36vrMfj9W34AkZK197vhgWoJ13SLIR8qzVQI79mwakJva6wXYPyQBSKkomXZFsefFOWKGIszX2tL4SFa4DfYNXkm1FjQF94zemtk/dcNIF6T/0wI09+TbpqtI+Xm1LhlUPSsgIGNWeiHPMI3M+QFfwTuQ/+A8up0Q+NeZ6JnbWtOUaAB5srw4Faq+dz702XveDGDCb2zw4MhFHclxXLghb8xFsloTF+bqJLk4G5aG4g21k8Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sf92+Y1mLKfnQUOMbHzkXpzpG/zClGAdEtFy8bjOMBI=;
 b=thwCKVtomAK7u2A0p+sKV/ukmqoqNcbzdc1eULoD66jkdl3zzz4ZB8v/KMyiUHgrUXZxcFp44opCyVUtHtu7ubQOp3wKWfO/K+3UZ6gDNaNLzqcEp5myCnUoc6vGm/VpMKIRd6L30BvQUVtAfm29xzTdsatMOOzOQFUFJu9co5I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6171.namprd10.prod.outlook.com (2603:10b6:208:3a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 23 Jan
 2023 16:35:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%6]) with mapi id 15.20.6043.016; Mon, 23 Jan 2023
 16:35:04 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Andrew Klaassen <andrew.klaassen@boatrocker.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Trying to reduce NFSv4 timeouts to a few seconds on an
 established connection
Thread-Topic: Trying to reduce NFSv4 timeouts to a few seconds on an
 established connection
Thread-Index: AdkvR33g3mzLGSb7R/abGwkCKolj9QAASdUA
Date:   Mon, 23 Jan 2023 16:35:04 +0000
Message-ID: <A00E49F5-9BD7-498F-95A9-FA2D5572694F@oracle.com>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6171:EE_
x-ms-office365-filtering-correlation-id: 1e9643ef-b890-4c3a-039d-08dafd5fc83b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dwTt6dkFi5JGCQar8YhapG+A5zq7PaC+tjAV2BuMLyVZMvm3SGwq+JMMWXrbf+/m4sM1m+15evRquAX795ENu6qbX9+l3fvRxXGOOciL0fatk3SqVF3szF5Wkzdxd7du36bBY2UIVEpFvLmCOf4yf1EkDdYzgT/kf5mo7I8jT9foraw1HIqBVlaSB+sDiykkp488spv3jOPHhGueCE/sMjtKiB4cVA1Om/nT7aedPup+xekhW8bNl72B8wdDveim9JXDbjSh//CXwlDvczIa5GacCZR+h9oO/RKz0rpuPyoilvn3EM+gyssKUosV1/YJbgrTvxoJI0M3JKgDGoyvwehlQZZPRzKJDuLRPZpP2Gjm2s7NtguIGf99Aq3yeFxwws4iT2cUBhnu3uqpGq2tt2N2g8/WRDgDnJv5CtrSAXSnrDDhcNV0Wlr9//Vm+vYwFsFSltgJ/s+ULOXYrxBOrXBYJPGbxkRfbHuuKwPwhFVvLn5NahMSHUQKu3Bf0sAFoZ5DBRJ5t3MDh0DvAlvTcuL9hhVMcDOjmzB1EX56mp1GClQ+tOcU2Ca/unheXzqnDQLtWd6o2hOMe0w8Cg1tViz2r58W22cFIt91n9n8lRx2iD0z293vqfesHDBAY5uN09JB6uKp4Tdt6JZi8/jRhdDOEEScgnuVtKA6bqB0y8OjHQ8gp4bspXSt9pSjcdTnjlqZF1pWZO+gNfuhzEV3OJ0IhY7bO9KwWokdOJHRWhg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199015)(36756003)(91956017)(5660300002)(76116006)(83380400001)(8936002)(66446008)(4326008)(41300700001)(2616005)(66946007)(64756008)(86362001)(38100700002)(2906002)(38070700005)(316002)(122000001)(6916009)(33656002)(66476007)(8676002)(6486002)(71200400001)(66556008)(478600001)(186003)(26005)(6512007)(53546011)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CpVAzVxUSLAcbI/rZ4XUWvgmgvvsFQn4vumir8jvlKlOEZXjY2VQPENwC50j?=
 =?us-ascii?Q?3O1uz2PXZo1K2+Lx+TMOxKVYb8GQhTVxEbjq2pnhkBvs0nYzsB4WXk+n6lEg?=
 =?us-ascii?Q?8QVGd1sZrlC2/CzooeG669adBT+UlUV1OONCU79q+Fs1HxCCoUOB5Re5Q3ZE?=
 =?us-ascii?Q?3Ry3sIjTf8kwRLr4JtqUw7nzHLMilPfKRmlv427epvcMe9VVrwgZ4mKurDks?=
 =?us-ascii?Q?JajjmAILy0CivffqKsP+THYiU5XPNfkgLSIkSOLK/M0B1M7FIOumbjZnyhJk?=
 =?us-ascii?Q?Riw+2diJFx4yZGXRCKW+zkRRLRxZmlYRI8osaY8WTX5DzrLiQ4REi3AwKf0E?=
 =?us-ascii?Q?ibawhpz9xmpPXDX73gFOccAGUvhf//wYKF3xd494zxDToNqTkV8IiCfpf92a?=
 =?us-ascii?Q?S3R/PDFza7Jp2jFngxh8MYInLl5Zle80wajvPI1JKNhuAgz/xx9+qYkkTWXH?=
 =?us-ascii?Q?LhoS2oW6/mjavVbPHAZgr4RdyhrlI/y0It423bs2gG9L7jdyQcOw3ZS8FL2k?=
 =?us-ascii?Q?GTh2wLgeCQrLXSWfNXTZmdO10sjz3athcd8MT/+2Omx/efA3qcHI7Tj+RkqX?=
 =?us-ascii?Q?jxdz51Md3RAZQHI5pgWBP6qH1/WkG8ujjCX2NB4HQnd8lgrKAi8IUefJHzKJ?=
 =?us-ascii?Q?tf8d0b9D05UFGFMaKOkQ2jw22xItxrrImXONWpd+1NAT630oSPUATNS7PuJo?=
 =?us-ascii?Q?HLYUtO4cPtlyeO6fyqSy6jzeE+ukaVbB+Yu8hA1S2qL1u/Pe0mnNoTB29Rt0?=
 =?us-ascii?Q?bZJnhiJriJdb5vU5tnTZ789ONpqEI6gQbDkG72yVBH9qMQailIiQ+funNjlG?=
 =?us-ascii?Q?KRBeVYTrhptRdkcbTb2y1VjWX+WD00sEg/sXn3flsM+PpN61k1PjQdIjga9M?=
 =?us-ascii?Q?mHXFcVvetUmMhrhwbPyod/vOOY/ZCBL5ID6IcVZPbpQ1+vcxkViZk7qJXLp5?=
 =?us-ascii?Q?VPZWGyE6pbCYwfYsfcYQwpr4OlL9gzSUHDVFScdgUC5knC30kLNBx8+XhkY4?=
 =?us-ascii?Q?Sxek5E0LkkqlAhJpe9UjlzcTIQH1hWCkXVlDd5i/jllZGa7XBylpFL9UjaqH?=
 =?us-ascii?Q?xpMhDwKTzTmbnGVpm4BbIEGv+rvBqaWZlrEDjF1sLwInRImTNZYYm3AZK9Ey?=
 =?us-ascii?Q?BeGjpR3Pqu0CuQgJNqAtzcPWRIB2an5qOOKrsK0A+ivekAL9QeLMf3KJqISz?=
 =?us-ascii?Q?/TKx+TeZZGAVo3v0YU6DXNMDyGGpC9v73txsg1ISWDWAVbWY2U+c4/Uf3e5w?=
 =?us-ascii?Q?lshDf8LhBskdjtwUFSr7ft0C0yLXDX4Fodk5twiWvoo3hGVEUxvAMJWZGSu+?=
 =?us-ascii?Q?Lsfp9a4O2UyApDv1noYJVwKY/TEE9wXXQcBUFcLNVTIJJJIlRtyw/zTomopg?=
 =?us-ascii?Q?txQir205H2ElRUizVPhsh4jtlD7sZzS8Cw+yzCtI3pza7infhrJ8fXZjltAN?=
 =?us-ascii?Q?6ND6X/C4UIno4LM0s+dTRas7ThCFXSM4VWqNk4/pNA2RURV5+KJ/+zryhPr1?=
 =?us-ascii?Q?PX9OvwVRQmQUP/Hm2nb8LhCZjuwxz+mV8+TiETrgGMyqhIsbxgJakBpiVbfF?=
 =?us-ascii?Q?YzfuxsKSKBI6OhhexUoHHdNAC1+2qjy4gvojwRwT/1ZPTzhceQT8uza+2kov?=
 =?us-ascii?Q?Tw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9A93EEB2F29A964482E26630C9776F9B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7btfe++QSqMIUJdAKaa+xiSte4l2CH1Gy7DJ65c8rqBRobnH6PgUrTaMxiCKtxvL8hzqXogIBXZNWvDYU+XQwBT1EQbUvyt3lyhM/0xRZgpEsejel6bL7Ih4eu9x4QdLWDIoOLcz37SJFhpGX0zyouWfI19wC9Fsx+WRH72nExv6XINPX9rojFCq/lr4A0Iw0CaqGoUdOXe8LQV+YQPEZjP1uc0G7kT1rHqr7oNuKRSvu+IkJv885jYKYC8vrN3q0bw48LrYbWR2WKWJ6UJRe2Ozd0HqxfqPFh5nf820AhMns1DpmsigKV86mnKrKo+pjI7vHtymOLduU67U8rKYAw/xF950zuGHjG90Ou/2SlNGGusj0RfTVhmsYjARGWx9Ikye3ze4FDLt2JDJjlJyZf8gWiBcCnK9zvYSbHNKSTy1IEly65BolapMAFVkwwCYGTgG5qqS7i6ikm5G5I/GDKBIAJmIm8UTt87mW4HBMffDw6f3eW2f6Ye8k7sNhGTTWjtVp5lN8nHi5ryH0lXzbRysYSwpEiHcRuCxtrOE5JOHTlNSeXzyhAEL2DBd7MGU1QDoc2vP2/QXVWwdGIuquAgc5kMxhewIAXqQg1yGaKsXXGtUmOtUDhvHd2vm9v7pzlrK/YcigKeRsvrvkDhq25/RlNRdqLirY1PdWJqruGN6OWAvVAXeoJR4O6OEp0H4ZPvC3l+duKi5ml0l8RboNndvBnHGLTX2lQOPMc4WgIoRwmVMtwKtwTNMAdqc42LiZxSTyt6X/9GAVegt7RJes2mt2XUvUXRZdSbXWpTNgNI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9643ef-b890-4c3a-039d-08dafd5fc83b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 16:35:04.8752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OaQPiW1BOEaE/ltnB9HmZ7RrNMcBwe+ioIIHZ7VZiFsnVq0fASJrLNVC9Kwe+PXtxyHtJSFRVsmyamhq8hyP4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_11,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230159
X-Proofpoint-GUID: KlrteOlHADpAv7hQn4gtIa6ANiKQsIGq
X-Proofpoint-ORIG-GUID: KlrteOlHADpAv7hQn4gtIa6ANiKQsIGq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 23, 2023, at 11:31 AM, Andrew Klaassen <andrew.klaassen@boatrocker=
.com> wrote:
>=20
> Hello,
>=20
> There's a specific NFSv4 mount on a specific machine which we'd like to t=
imeout and return an error after a few seconds if the server goes away.
>=20
> I've confirmed the following on two different kernels, 4.18.0-348.12.2.el=
8_5.x86_64 and 6.1.7-200.fc37.x86_64.
>=20
> I've been able to get both autofs and the mount command to cooperate, so =
that the mount attempt fails after an arbitrary number of seconds.  This mo=
unt command, for example, will fail after 6 seconds, as expected based on t=
he timeo=3D20,retrans=3D2,retry=3D0 options:
>=20
> $ time sudo mount -t nfs4 -o rw,relatime,sync,vers=3D4.2,rsize=3D131072,w=
size=3D131072,namlen=3D255,acregmin=3D0,acregmax=3D0,acdirmin=3D0,acdirmax=
=3D0,soft,noac,proto=3Dtcp,timeo=3D20,retrans=3D2,retry=3D0,sec=3Dsys thor0=
4:/mnt/thorfs04  /mnt/thor04
> mount.nfs4: Connection timed out
>=20
> real    0m6.084s
> user    0m0.007s
> sys     0m0.015s
>=20
> However, if the share is already mounted and the server goes away, the ti=
meout is always 2 minutes plus the time I expect based on timeo and retrans=
.  In this case, 2 minutes and 6 seconds:
>=20
> $ time ls /mnt/thor04
> ls: cannot access '/mnt/thor04': Connection timed out
>=20
> real    2m6.025s
> user    0m0.003s
> sys     0m0.000s
>=20
> Watching the outgoing packets in the second case, the pattern is always t=
he same:
> - 0.2 seconds between the first two, then doubling each time until the tw=
o minute mark is exceeded (so the last NFS packet, which is always the 11th=
 packet, is sent around 1:45 after the first).
> - Then some generic packets that start exactly-ish on the two minute mark=
, 1 second between the first two, then doubling each time.  (By this time t=
he NFS command has given up.)
>=20
> 11:10:21.898305 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 1445=
2:14652, ack 18561, win 501, options [nop,nop,TS val 834889483 ecr 15897692=
03], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:10:22.105189 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 1445=
2:14652, ack 18561, win 501, options [nop,nop,TS val 834889690 ecr 15897692=
03], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:10:22.313290 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 1445=
2:14652, ack 18561, win 501, options [nop,nop,TS val 834889898 ecr 15897692=
03], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:10:22.721269 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 1445=
2:14652, ack 18561, win 501, options [nop,nop,TS val 834890306 ecr 15897692=
03], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:10:23.569192 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 1445=
2:14652, ack 18561, win 501, options [nop,nop,TS val 834891154 ecr 15897692=
03], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:10:25.233212 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 1445=
2:14652, ack 18561, win 501, options [nop,nop,TS val 834892818 ecr 15897692=
03], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:10:28.497282 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 1445=
2:14652, ack 18561, win 501, options [nop,nop,TS val 834896082 ecr 15897692=
03], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:10:35.025219 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 1445=
2:14652, ack 18561, win 501, options [nop,nop,TS val 834902610 ecr 15897692=
03], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:10:48.337201 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 1445=
2:14652, ack 18561, win 501, options [nop,nop,TS val 834915922 ecr 15897692=
03], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:11:14.449303 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 1445=
2:14652, ack 18561, win 501, options [nop,nop,TS val 834942034 ecr 15897692=
03], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:12:08.721251 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq 1445=
2:14652, ack 18561, win 501, options [nop,nop,TS val 834996306 ecr 15897692=
03], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:12:22.545394 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 13752=
56951, win 64240, options [mss 1460,sackOK,TS val 835010130 ecr 0,nop,wscal=
e 7], length 0
> 11:12:23.570199 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 13752=
56951, win 64240, options [mss 1460,sackOK,TS val 835011155 ecr 0,nop,wscal=
e 7], length 0
> 11:12:25.617284 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 13752=
56951, win 64240, options [mss 1460,sackOK,TS val 835013202 ecr 0,nop,wscal=
e 7], length 0
> 11:12:29.649219 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 13752=
56951, win 64240, options [mss 1460,sackOK,TS val 835017234 ecr 0,nop,wscal=
e 7], length 0
> 11:12:37.905274 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 13752=
56951, win 64240, options [mss 1460,sackOK,TS val 835025490 ecr 0,nop,wscal=
e 7], length 0
> 11:12:54.289212 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 13752=
56951, win 64240, options [mss 1460,sackOK,TS val 835041874 ecr 0,nop,wscal=
e 7], length 0
> 11:13:26.545304 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 13752=
56951, win 64240, options [mss 1460,sackOK,TS val 835074130 ecr 0,nop,wscal=
e 7], length 0
>=20
> I tried changing tcp_retries2 as suggested in another thread from this li=
st:
>=20
> # echo 3 > /proc/sys/net/ipv4/tcp_retries2
>=20
> ...but it made no difference on either kernel.  The 2 minute timeout also=
 doesn't seem to match with what I'd calculate from the initial value of tc=
p_retries2, which should give a much higher timeout.
>=20
> The only clue I've been able to find is in the retry=3Dn entry in the NFS=
 manpage:
>=20
> " For TCP the default is 3 minutes, but system TCP connection timeouts wi=
ll sometimes limit the timeout of each retransmission to around 2 minutes."
>=20
> What I'm not able to make sense of:
> - The retry option says that it applies to mount operations, not read/wri=
te operations.  However, in this case I'm seeing the 2 minute delay on read=
/write operations but *not* mount operations.
> - A couple of hours of searching didn't lead me to any kernel settings th=
at would result in a 2 minute timeout.
>=20
> Does anyone have any clues about a) what's happening and b) how to get ou=
r desired behaviour of being able to control both mount and read/write time=
outs down to a few seconds?

If the server is already mounted on that client at another mount point,
then the client will share the transport amongst mounts of the same server.

The first mount's options take precedent, and subsequent mounts re-use
that mount's transport and the mount options that control it.


--
Chuck Lever



