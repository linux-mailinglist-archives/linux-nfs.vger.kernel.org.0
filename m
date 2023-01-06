Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACE96601D6
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jan 2023 15:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjAFONr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Jan 2023 09:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjAFONp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Jan 2023 09:13:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D79B77D2D
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 06:13:44 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306ANxhT014028;
        Fri, 6 Jan 2023 14:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wVIA1c70J/s1EV8d7blrXWfD3eMSju81ovo++FTE88w=;
 b=uwH/qwzdvOuESAmt6dO2VdickVtVUAhfgjCZlC6F+J97G2P8i9v8JAgOW/D9ANsGm4E9
 EVouNoQRr9uJsScYaIqJGY9nxeesEVjmZPr4BTEVVgyTRI6p5TOH6/0+/OOZNEUiStxx
 JjI/gSE+TQqkXgft4JA841v38i6GtR53x8c+IpYFB5aBETLwkbFNx7J1Yg0bYJQyxvMh
 +hFcL/8Cl59vzMn93Ns297UY9FJGJxCpzjiJYjnXavtGqaaNIWsEryAEcxjakGfrhHjS
 /Nl7bE2hEf2Van3V8o9bXA/600dpspJhfp/EPKqGnZZcYJByCjxnyZndG19iGchkpSr3 WQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbgqu544-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 14:13:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 306DZDrM010596;
        Fri, 6 Jan 2023 14:13:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwepu5jju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 14:13:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCa98T7lNdQGcSLVG0UE+LlomrA6LyrO1fyRa9JArFeGV29jLYu9+/CRrif0ruLZxVxGHxec5XJeCOSFX6ohREOzsh/3qwfovo+KNbF8KcPxGXbZpcoE7OeorM1/8grUsD6xcRlRLCqioS17j93bv3JeDQt2FSAb7k+mmqOoRan3il+I7id2XyGsta5RiMlYT35rfdYlbjCYJdx9P3KxkQy9PDzKmo7VCCWlFH2c/gzfOxOokQRbTXzvwkzUReWC2LUF3M2aieUOPTrD4N4uEhW0uRu1hUGAFhdJMCDEkQ7QaWQDXqWpYcER/F4IVyFthPCR5LY2P3XKcZS1+viuHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVIA1c70J/s1EV8d7blrXWfD3eMSju81ovo++FTE88w=;
 b=YTu6rLERktzR2tbnAl6xdH+qW4O/vNe+XcMlgfLBUbmcpuuoMLbQXCqGXGGd/d/qgfbXVJD3fgnImfB4BQQ9txJUds1jDLJfaTh10BGriMpUwIvGPyZW1oDm96LyXuSdYagd4UbAZluUlmIEfd0DkbmOOpuJE0aozP26P0SVqtgeby9IOMGSrkBgpdSRW7l+IAFt4bwfaQLgjesufs9bFjsl68P/R/JYwCul8xijUUOteE7npC13iIB43k2x0pe8WKVL2Am5wAeDLV/AlH+xgEOsbAcchDFyd8mNEXyMRuA8PGVvO5pBafNyI6rDQoqc9LpSpXEO+AdVALnWdIPjdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVIA1c70J/s1EV8d7blrXWfD3eMSju81ovo++FTE88w=;
 b=R3sIa9/Q8vG7ltVB+lcWF5dT78+8IhREmyR5BA/s68icrrV9de5DRnpPKgDYkMskkddMFcEdmJ5R6gJw9DuVcqTkagBJEM+eNAKbhwRi+jGx81aVF7BKX/+Z42djU2U80zeDyDjq8p8h2K6uQpcpaJXcdGXUDRdCsv6uPs/kggo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7215.namprd10.prod.outlook.com (2603:10b6:208:3f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 14:13:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 14:13:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
CC:     Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Convert filecache to rhltable
Thread-Topic: [PATCH RFC] NFSD: Convert filecache to rhltable
Thread-Index: AQHZIRZdLVddJev/70WpowDSuI8Nnq6Q5jQAgACJsYA=
Date:   Fri, 6 Jan 2023 14:13:24 +0000
Message-ID: <1CAF2C85-59C3-4491-BF88-32130ED77CB2@oracle.com>
References: <167293053710.2587608.15966496749656663379.stgit@manet.1015granger.net>
 <20230106140033.EE9D.409509F4@e16-tech.com>
In-Reply-To: <20230106140033.EE9D.409509F4@e16-tech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB7215:EE_
x-ms-office365-filtering-correlation-id: 9c1db8db-f4d1-4957-afc3-08daeff02c50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aH7swgjCB0I4L10x08/Edn164Q7xQMHa+iZwmnvGZvEFwg6eRRon0MRCMv1Va0IcgvkioPR0fFRoLPquAVdf8vNvpOf/L8FSmeHv/vDYDEf98ad99ujA2SBGJlG4/7+5xbiMaEnyfyiQ1GhAdHehn52FOGwxxka/ryx6K/2iVMzNKB/thDgt8k0Vn0OPp3dLZEaHf7jVnF0KYLWUBF3L+y8ktryeZwQUn3Cvf/FNUKFAwqyUhZPct/izv1bgNqg2BY/7NMkAyV+7ULuNzuAXGiAClpU63gYivSFtYoSoHPkIYUpAukfa0pTKa0rwTmHLuUlKulghR6VghrB7F7vPKJreEs7SPIeIu1Jab7kMNGNHZz7pHMEMj6P4q9oDBCJOOhkKns0U5G+3Amey0xXyS6/hKauXlFl6wlaltJCNVhbNC/2/PL6S+QUI+8zcYitFqm3+nt1BiGxtQmacazKaTNo33ITqL9WjBq3orCgRmKN7fSDuXzE63DcWwL6Zm04mlmOXaaNk1YRPB7B/ddWloyRD4IRqPJT94xaC+s96P4Vp93w3w/+Yin/BqPrJl0ZLgsGY2LbbXjmo6MqrZjPLe9CjDUJx3gjvGyJbGvSR/E0SiZ+pOg5hemhyW6ppAn1CXO2Y//SShfbt5cAhoFsxcva0kEZO6I2mgNh4yUJa8DX6kgpmg4TUOXz0WDONBdySsVLt5nL7vcu/CMjPrX7ulEClRDwQXWOVzuAmMAHI6i8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199015)(38100700002)(38070700005)(122000001)(33656002)(6916009)(86362001)(316002)(54906003)(36756003)(71200400001)(53546011)(2616005)(6506007)(478600001)(6486002)(91956017)(26005)(186003)(6512007)(5660300002)(2906002)(66446008)(66556008)(8676002)(66946007)(4326008)(66476007)(41300700001)(8936002)(64756008)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ropIllS2XBYaFE+RbxW1ipDSbV5NuoQPbqfNhSUISx2YSQhB1y8ZjinHfCl7?=
 =?us-ascii?Q?ekT/xfSzl/7drO04sDE0fRO7uhnd9hwGHnR4t6G2HMntzqx+sPJl+cILBW80?=
 =?us-ascii?Q?VrnraYzTxKO8x4e0Hrp+okssN2lUMx4NqcbR0W6YxH91Nz6+ViZC8GKWW6QK?=
 =?us-ascii?Q?tJDtKu0JKzZqXxpTS82KSAEC6+wN31q2h4+/7PN8P/HHfSbtwyzDEIxRFgsf?=
 =?us-ascii?Q?++CSEY82U5MhIzJAMzBz+5EQCiru9oan1jUZlSr8MukDUVPlK7A0Pwe5evJX?=
 =?us-ascii?Q?rODKOBHwwSdC5ZStYbO1TZZsiR1M4aFW8Ias/nc6SfcQ4ab8XgDMRbsCfjCZ?=
 =?us-ascii?Q?gSqQsHy+jJgQOu07HoKp34AUSdQ6uUSdMBm04WIogPfiC4l65Pmt/c+ZbemM?=
 =?us-ascii?Q?OMuXzg3qodgArTetrvtOw/4F1YAJwUy9aCMf5kNhn+S+wQ8doYjjdfPVm+sL?=
 =?us-ascii?Q?7Qx0/ikKrhdbJu2FQHsco/tQnO/T3WOesdC+bDuiSmoNBwVCQepAEKyA+tYF?=
 =?us-ascii?Q?feTyRNnTR41ewLDLKzWM8JWPY0gmV6bxLAE9ATDHngvmiZsy86sIPipy9Iaq?=
 =?us-ascii?Q?HluXeWAzrajhHcNOkifoeJQW4begyV4NdSIs+GSL5ZsJL6CeQEtj9taiyTqj?=
 =?us-ascii?Q?hCoZuv8G2XnlkyuWFz13v05WzUH92To8me3wa/MlvDmKF3hID4M20slCM0oy?=
 =?us-ascii?Q?WmIXiQEh/U77PzK5LGeoOHYKKHId+CXFU9Pp5CKBgpQfrdr7lna6n54SQ3o3?=
 =?us-ascii?Q?GxuN37VTG795OH/D8DENjkbWsZSyiUEeFs4LyxUisIw26sJ1G4owGvOaPvK9?=
 =?us-ascii?Q?cOUQzLiX20lOISEGlSa96DsAozbUS9Zhg8G1/fQxeA0GpB57+zlRopg8CIqF?=
 =?us-ascii?Q?pieDeZeVLQIbVY52Hkw2khcBXdLnKw95p7MUiu/jzJaA8mBZnaImDK69HkfG?=
 =?us-ascii?Q?PdiI/aYxkrUzBYIS82XmqxU0KaGFbJXADjF9XKM9+2uzmDMab8J4b/BosLCl?=
 =?us-ascii?Q?Acy57KmzLmuVdQ799NqL8qcmY3BdXnnDvK8WZvWsxjWeLPVSC4Oh9IrGhFc6?=
 =?us-ascii?Q?CzeDS3cXWoG4//pgdpUuCYyouZ0w1JHDax1Gt91gzdOcF/Lw1ROExXPldqjB?=
 =?us-ascii?Q?Ckqvfua5MNt9gcpBisO5y60gHVzIXNck+haiNHpd2n1Y3l8xJjBGbwmScKmb?=
 =?us-ascii?Q?ksK0KjbKs8WX+N2a/8bbnRhfedsoX07rUIgRnsrs1zr1GzMFz8yJphXapIx8?=
 =?us-ascii?Q?PU25torLEoDZihBm09cKp276Vv1/R6SiAUzfCVVnISledDMUBKompA+1xKtv?=
 =?us-ascii?Q?GV7jqbNGmbPWrDfNzaTYYLyvIHiV7sAdK+rf4fsvGP8R8Nu2NL4ESGjGZL5S?=
 =?us-ascii?Q?gJusbLxSBO/mhJGJq2nX1BEK3KbCMpA00IWEUwBfwUj/BjM1uZv2bwr75bWk?=
 =?us-ascii?Q?eQo0m1NHDeCwzfHA21jdsbP+Seg3EI8z+8Dh+a0bx2O9nK1/M7YLJbboUcLn?=
 =?us-ascii?Q?1bSONy5UZPVbALbAy+nEx5FQV2u5zYu6BA0xAS4vpH6FbHjMq4PH0asXIb7U?=
 =?us-ascii?Q?cv3J8u3Q/06P33RKIVqou2XErUUY5K3DPrY6HP1umrrZ4rznjDCmUHqjTBD0?=
 =?us-ascii?Q?1w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EAC07404E8889442A95119CC5C7BBA35@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 39T2XEHpmUNRNdrX7lJhftHudRm/o9RHF1TfP6e1aOhsTddAhCtKM8E1yqvumNcO3wQBlZ8ZfqRnhoy3V//88IjAN2RSIUBdSernnvDhcI8wVFGKouo6//xumm/wSVs6lOFulansJ1drdueZOwRmSoLSDLmm/hkP6saETwwhsOUGjPxlq2AFg9J076XqkGpmy3f5yKDZGQZvRhFF0ruukNl/6dYaLayY7WgfXY+OthOy3hWX6be5a0/HbU8bVO8moJqGpBs+LDY+6ZZE2SUieazzOHEpx3NFZ1ltFDfI2DfK2mk9T0x5gn9CYY37UvDTyNzxD5Cy2zE9AXxU8oGiT/2HdXHpHtjYkXRQbwN0ajzziHtmXPaPU4151l9A11EL8aHy+7rIcrOAzg+mHLC4Bgz6jF/OCuocb2FiksOP9atlS9tjRqPmzDzcxXrH1QphqbtJ3V0mcmx9DAUgoIpc2mqejKXJRaCt8YMiGLvkrnNyFF1OEBoCfKSlNDEHHk91slSkC3iY9TUrXL/pBQgaWcnTnM2H1+xrfmCfL88F0NrAfcUCpTs/sDKcfLMNBq1PHCR1f6yrydVzC1hHebzy9yu8YRYJhGC+jr0xBB+y3GKFfNX8RukoKmZ6H1ZMP1/q+ae7pscXazDC4KvsMDDikFMTZkfILu9rkZ+aSgJMJbDbklNZgH4t+h8jDQe21A8YAy2AU3HWZOzVhw3fXfx9+2evY9coAw70qx1a4nhucnv3+e6PRFv4xXa8wNLnqLIeQh62hA85XzBc4z0xCqM5AA5uqBzSdhwMn2CuoTgXWcUDraWzFgFPtbAOOcmfQWj+uGfpvK/4KYg8iE3ID6JCKfswvx6MQD96mn88vzGBoinMMNgeQnrlNxAghRSnCBuw
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1db8db-f4d1-4957-afc3-08daeff02c50
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 14:13:24.0396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1rcR8PSwWCEFd7I8nsbGdvNfTXDU71vWdjvRE1EgsSTE3ASPMv0aHdb9ttupY6t0pxnh3vqhriCz564XX57WDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_08,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=989 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301060111
X-Proofpoint-GUID: ql2Epw2l_jkw-ofPCxJDh41_2gmFVwP8
X-Proofpoint-ORIG-GUID: ql2Epw2l_jkw-ofPCxJDh41_2gmFVwP8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 6, 2023, at 1:00 AM, Wang Yugui <wangyugui@e16-tech.com> wrote:
>=20
> Hi,
>=20
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> While we were converting the nfs4_file hashtable to use the kernel's
>> resizable hashtable data structure, Neil Brown observed that the
>> list variant (rhltable) would be better for managing nfsd_file items
>> as well. The nfsd_file hash table will contain multiple entries for
>> the same inode -- these should be kept together on a list. And, it
>> could be possible for exotic or malicious client behavior to cause
>> the hash table to resize itself on every insertion.
>>=20
>> A nice simplification is that rhltable_lookup() can return a list
>> that contains only nfsd_file items that match a given inode, which
>> enables us to eliminate specialized hash table helper functions and
>> use the default functions provided by the rhashtable implementation).
>>=20
>> Since we are now storing nfsd_file items for the same inode on a
>> single list, that effectively reduces the number of hash entries
>> that have to be tracked in the hash table. The mininum bucket count
>> is therefore lowered.
>=20
> some bench result such as fstests generic/531 maybe useful.

Sure. I don't expect there will be much change, but one never knows.


> And this patch conflict with another patch:
> (v3) [PATCH] nfsd: fix handling of cached open files in nfsd4_open codepa=
th

Yes, this is known to conflict with patches that are now in flight.
I'll rebase once those are merged.


--
Chuck Lever



