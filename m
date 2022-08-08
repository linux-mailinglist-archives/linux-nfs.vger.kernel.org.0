Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4292558CFE4
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Aug 2022 23:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbiHHVrV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Aug 2022 17:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbiHHVrU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Aug 2022 17:47:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3805A18386
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 14:47:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278LHMkv027065;
        Mon, 8 Aug 2022 21:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BbubgQkdqOlyMWmzlfZ/Bz2SDBE0yxllqLB+NnM7RFg=;
 b=bxSsFDU9Dp1EgSFQCQFnQthRFuHw7ffwzr7yr3dtT+QFYaJ44KwLdcEt88fLwvlykPer
 Lpq36v+MH1raM1QqqutCyMaaZ9RA+1znlnp9z5Um50zn2xhAfdueZaHCdT6siTBHHSWs
 164hkQu0L1eEDbZIyasY9/7jN8QXNTdiF8mtf1hE3U+HBE/NqGBoYIepq/dwYF56czSC
 NlxPjoNayRGekJVAPFbyaMHlGquKvO53j065V2s5H1lGWnyms/8ukksOVmhJoKDkefSj
 7pLB/uBzBvg8UCwiBdz2Ew4hOZtniUXpLw9+43RGqrFVFdhbOom5w39xy6je1kgGoMEk gw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsew14y6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 21:47:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 278Jp50f023179;
        Mon, 8 Aug 2022 21:47:15 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hser2ayhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 21:47:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZQ7Jj8O0VMsMCTVte8+RrdyagZWpxXIw8w5J+iDCOluDlYeYaKsIt1i6/Ffy35onSgCVqzVpHcH29+RMsxRM86NPyEpc2M94aUucuZDZRRTcFADvESFwS23xv9bu1dh0p5drXA9mpiX66nDszPYDEmazgpEw10OC2jq8CCb3SMqYvzOz7mqSTGtULHFY2c7gozPgkokQ2jPWSCz51I0aCRaUa9YI4u75g6deNgZnf+FjveCRwUDtexhsDLniKLAwbY7WtAmXPZ8nrQ9ygY1okBQRJc4ZUl85pjJ8Jfv2jQCcp8bW+Oia1KsJi5NDNDCeg27MRB+83qtwpQ3W8kFBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbubgQkdqOlyMWmzlfZ/Bz2SDBE0yxllqLB+NnM7RFg=;
 b=lokEzOjzMIp6DNTA/t9N/fiIi2zIvuTTzJHDFLQDFA1JV76l4aNDXw+jhUXClxQIP93r4Zd1tp6k9fsMYV+VGvqCdlz0ls0XmXUJh+MuUlvUaqqlROHVKdB2j2lpaPNCX4VIMHWlUwe6o1gGaNiInMDJ8/UuKkxgpNddkFVbTt4dmXVxjvf3//ZEpzQGNnyJeogUZ5Ipiuz1UCCzanTr/2fpEZsWFBX9AXBv4D2+HC/rOHo3l//9X2LZm5SmKfpCWqEvvsjYFwK/PI+qCG2d47ml2eHp2ocOQHNN6t/rHTYxavXGwqos1uQGtdZW7BzOLZXrdqCpEKqbu0BNqiOtvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbubgQkdqOlyMWmzlfZ/Bz2SDBE0yxllqLB+NnM7RFg=;
 b=bWY1daOF6GBvyMOtKRpGHbBXUAD4k+iUchF35mMtXUwiAes0ayae2ri0XhRv7+nLc+Xz6w75vT9BDbUDyoNjp7CHlfrsYa6KBEz3UkDw3GglQyvInIwaEkB4VX9591Wt6zpjmy0JicXGIB6K8D/nWdKTtniqiXFeHd4hb+3FTrU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB3591.namprd10.prod.outlook.com (2603:10b6:a03:124::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 21:47:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9%7]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 21:47:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/7] Wait for DELEGRETURN before returning
 NFS4ERR_DELAY
Thread-Topic: [PATCH v3 0/7] Wait for DELEGRETURN before returning
 NFS4ERR_DELAY
Thread-Index: AQHYqy4gRT0K7GpiEkGiJB7utcU4AK2lWIgAgAAVxACAABwpgA==
Date:   Mon, 8 Aug 2022 21:47:11 +0000
Message-ID: <663D7867-563F-4DEE-94E8-C9C81B0446C2@oracle.com>
References: <165996657035.2637.4745479232455341597.stgit@manet.1015granger.net>
 <55bc0656a841cc1229d2b1594d4f9eeabfd00ae5.camel@kernel.org>
 <3D17DE4C-73B9-4635-A102-72955D19CCDE@oracle.com>
In-Reply-To: <3D17DE4C-73B9-4635-A102-72955D19CCDE@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c720c7c-2ad4-453e-dae2-08da79878ce3
x-ms-traffictypediagnostic: BYAPR10MB3591:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: znXdO4ATSbvRGA1uLBbvwxvTNw1SA3hkji/Nja7jCgPAYg79XXJ7vL39k2hfz/ji4+80PgvxyHpkcdAy13+yErGgnhXhoIKaof9KfAe9A8AEXzOH5TTNqdXMHeT8NjNTcEfNRAFS2kOCIsrwTSAji6OzOYqrd0EpPFBqyUsw/CLYPTqTU5tp1DZvDeoY4mv2IoK6FWleHO9YdwOT3nPuhjaaXxFcHIiRXSCxw9FcqZq9rej7z1YdJvnvQIZf+oAdICR87uTzH/EOLksIQWo2PwuIunCsVgh28u/OpfMu89P62zYQzRNzQ+xVJm5CQnRvjDrN0CyyeOfiTrKlyGF2Tlk0hH7xtPlQ71aHI5ogBCZw9tapWYEQeiyAnaA8CnE9CVLV8IOHaOyf0tugZSUEMndeg6/qtK8j5wi5oP2ZIq4ILycVasx6k7CrCed4g5ZW9H1RBonI6JgN7ng7HdLjd34puaCawa5PGOMABy3qtdvrYYaqdVLlRjCLB5XxMOenwlpNkXfF1ZETZVBGwmrKcaVn5dAr2Vzx8KhAZYOEvK/ttoXaOYB2xMeaiRCRgEfoBpqryxJfxjvq4+nTmYC0OECOMMvwDPjB8HHWByhWxmrQD5bEJwfZpGRpM4h+EFUSJiIBNUJ5tTi45XkdQPKqRQkCs3WBSawBT93pLnx4Kd2iU0o/lnYDGQ+q6kt9Adz8tjciHQizimjkgmZ2IMu481zpSBIQWvVOtTkFU6upMkZVRwnT0t0DZn7iXRTHIo3IWZmov7IgqNIDznAQZNgW+orla0F6SGmwaLJEefzNnExV+DynzE6w+HvBVjKHN+qOYpgTKi6js9aSu47GYjr4tg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(136003)(366004)(346002)(83380400001)(8936002)(8676002)(2616005)(66476007)(66446008)(64756008)(4326008)(122000001)(66556008)(66946007)(76116006)(71200400001)(6486002)(186003)(316002)(86362001)(91956017)(6916009)(33656002)(5660300002)(6512007)(38070700005)(26005)(53546011)(41300700001)(478600001)(36756003)(6506007)(2906002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hw18b+zs8yBUB9a8Dous2M2n8MXTml1Dnrag5zp5bsI45UkanTlF4JgZryh3?=
 =?us-ascii?Q?VRmhAhSWVzyzFmWVzLcR7bWduGAGaAGQrmOcamEaUwoYhCVYAFTBkLsFiG+A?=
 =?us-ascii?Q?mG5ZVzZvsy8xYELmFM3a1Y5f0m+zT65xiKfNoWwzzey3DZ4q03Wk2XTdMWrc?=
 =?us-ascii?Q?LOedAE02wsHIJ8sC7Wk0SwikD60AkrLhTtLcDIHuDT5E+zJD4nJcegb4tk2y?=
 =?us-ascii?Q?4aaGnEAqZPSOtLL4X91UYuPMOKboSA8lpI8oCOT41ru147RGSmDYIgrtmJ/q?=
 =?us-ascii?Q?957KeHfydIk3sI5EAD3Cl/KWKbdCk6kp/lbhpRCD+5At0d0PLaK89pHcs4gX?=
 =?us-ascii?Q?wYAaPbshgQIyKTN5HNssIRXAYGp3WJFANyE+puWc+BfoSOJBR+kqEBeAsuzN?=
 =?us-ascii?Q?jER3jG4oeYm7rksGf7SEGFu8j163dceCMiGUP+EHrHj0QPe9mqiwa390O5cj?=
 =?us-ascii?Q?Cw4RThuJfd0rZq05LRkjYyD5xZ6SSHVKs2gNFz4M+dyyV0OWQOTT4TvmYQEI?=
 =?us-ascii?Q?epJZ92DjYz5hNzWKJC2QEZNdA3kqmEq3K3pm95+9+7aD5kknNzyasjI1Nf6w?=
 =?us-ascii?Q?Z8yWv3M6MynmTjJiOY6ytMEtw9z9diFx3Qzns2bNI0n0j1SwoGI9jY6hLCTa?=
 =?us-ascii?Q?qb6L0zIxkt/htvH4GcVP/FNUBy6BJOl4y937Bbfd+Q+5+AEKS/MJp+n8dRyM?=
 =?us-ascii?Q?hsz/6f77GlI7zzxl7CLqzBZASJXK+VxF+zsVNLIzMJHi0NgVZlJWd0Tgpcmg?=
 =?us-ascii?Q?hXGqS9hQdvuFH80NOq0WSk7qTc2YOZ0Mfo8bNU7zF3sr3XKplEbJ8uQftA/R?=
 =?us-ascii?Q?WRohSimxQ8S9ZE6srU6a5RLv/0betykSn/FSebGlKvFB9ccOg+5zB2caBeLk?=
 =?us-ascii?Q?H63KTFXUOAtnbt6kKREYIX8JZt/6kNFJq9nRzepXAcqZBC/p5Sif8QNKWBdU?=
 =?us-ascii?Q?e6CCzFY3FCoDJLMuLp15SjAueoKJJ29nI6NKlcsmVQvHA+B6aKH7oj+MM7uI?=
 =?us-ascii?Q?+0VGsCfjETUfgXrA1NUG8yykeohlPuH9d7lp4DOrUjqEmU/vnEW5TQ3xZrWr?=
 =?us-ascii?Q?NMjiKHF2Nsx1CuJwAP6v3fSG87sXNrMiJtbukuVTW0yBPAhp2iNb42r0174r?=
 =?us-ascii?Q?SKF0CpcngaZGgKtWG5I1Gno5PaY+BYuZ9+E94Ia5yN0f6aC0BlH8guhUODpy?=
 =?us-ascii?Q?T3Y6tolozMZ/O3scfkDystjXhyoOE21sxvZFJsT71+YklAxy2dtAqUEw1nUP?=
 =?us-ascii?Q?kUwRoQnjvaz1AWPzbnejn0ri1CQ3/14mUZG25Kvk6GscIpIa0TyAQRVnrmUt?=
 =?us-ascii?Q?P1vjm1QhpGLPWK6Xryg8j4eUj/XzQ09g+i3iLul0JyH7eOeaED13LUX9FHZ3?=
 =?us-ascii?Q?f12Q+A8ZP1ydCEHBFr65zUGuth1ehtNF2dbf0OE6O8Uv1u9+rluusGcNMy1R?=
 =?us-ascii?Q?IUEXhQdm+quzWKl/XXqWncYH0MG7ZfnaVXrm9xUnVZNcBIPIambwLirVr2Hr?=
 =?us-ascii?Q?3oW0d7eg8W2JTS02BdMoVtpmu/1jp/qvWHpLTPPqG6O2DwidoBHHa4O4l0/E?=
 =?us-ascii?Q?v6TbME3lbAMzcfxiIStI6YnNphpsFX1RawA6X4B+JvE2JWjFSkz/ACAqCGPt?=
 =?us-ascii?Q?iA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <51F1B109B659574EB961A3A5CBC5479F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c720c7c-2ad4-453e-dae2-08da79878ce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 21:47:11.7479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clgJEymkpOWkrpZAJIqhvI7rS8LKigMBrzQKOz5ZoYohfRpjlYFAJlccFpRuu9JdVGSuV9p+gwA0gcszWGPTDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_13,2022-08-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=971 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208080093
X-Proofpoint-ORIG-GUID: 4gB5ae859JlrpDoiZIbVEGUbn6tcDscB
X-Proofpoint-GUID: 4gB5ae859JlrpDoiZIbVEGUbn6tcDscB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Aug 8, 2022, at 4:06 PM, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>=20
>> On Aug 8, 2022, at 2:48 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>=20
>> On Mon, 2022-08-08 at 09:52 -0400, Chuck Lever wrote:
>>> This RFC series adds logic to the Linux NFS server to make it wait a
>>> few moments for clients to return a delegation before replying with
>>> NFS4ERR_DELAY. There are two main benefits:
>>>=20
>>> - This improves responsiveness when a delegated file is accessed
>>> from another client
>>> - This removes an unnecessary latency if a client has neglected to
>>> return a delegation before attempting a RENAME or SETATTR
>>>=20
>>> This series is incomplete:
>>> - There are likely other operations that can benefit (eg. OPEN)
>=20
>> Does REMOVE need similar treatment? Does the Apple client return a
>> delegation before attempting to unlink?
>=20
> It's certainly plausible that REMOVE might trigger a delegation recall,
> but I haven't yet seen this happen on the wire.

I started playing with REMOVE and DELEG15a, and ran into an
interesting problem.

REMOVE is passed the filehandle of the parent and the name of
the entry to be removed. nfsd4_remove() doesn't have an inode
or filehandle of the object to be removed. nfsd_unlink() does
acquire the inode of that object, though.

And, I guess if we want to avoid NFSv3 operations returning
JUKEBOX on delegated files too, the "wait for DELEGRETURN"
really ought to be called from the fs/nfsd/vfs.c functions,
not from the NFSv4 specific functions in fs/nfsd/nfs4proc.c.


--
Chuck Lever



