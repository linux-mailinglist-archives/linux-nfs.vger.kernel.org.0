Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B0067239E
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 17:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjARQkO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 11:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjARQjq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 11:39:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48731CAF3
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 08:39:39 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IGE48w018082;
        Wed, 18 Jan 2023 16:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8f0+sFkmahVWuW4632dP27SNdcNyaDkQgTMl0HLQ7Ck=;
 b=H/Bd+RbACXeu0tfOjDS6WqUrxCYdWLQCMCrR06diNyH63j8SdcrLb6n7Vd2fx9OK/e1D
 W7axtdf1oL2XEj467td3jiSuTiDdR5ru61feJWoFICoFfxm3blhDDye+6WhwCNvBKXmF
 Riwv5xel/kIB1vqZRBcBMgRX279OL3y88d0BUm56R5qE1Nb6UxbfIJfSi9GJ6ObQW1mS
 i4Lvu3PGbopAUFW+U0Zc0JfMyNGMwEd2g2GjGxy/5O5wvhhkYexBIwQ7n9AowIRg453J
 vZ88WnHzX/UqSt6qQcXzgguUSnxQasZEiTnuNOKCngJpQ2cEOUL+kEXISukiMcBkqNhs 7Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3jtuqwxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 16:39:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IG9Hi8028785;
        Wed, 18 Jan 2023 16:39:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6jxm5e89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 16:39:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcfrIlJEmfR3DjEJ/so9GmVwwfMm13p0XDY0MJh2zMlja9aDWDzbgHynnI7GkiaSO3duXMtcmIoJGk3vVL40ucIRkUpvcJe2FlMsRHidWsy1C3uTZmJWccgXeBAlXF6IYfVx3IdoRTJMl7y6ga6WLgZ1I6KZZGdEpCI8m2pu/2sEBoIAsRNoXpmIjPBQoBpekSqvWQI4ZLxcwuo+MqoGnwq+Dc0H+3IHaZC1EL1y4OnvOpR2gi3Z7ZjZ0Vzqo4Vqxxu/extFZBZECFfhx/G8XlfBoDW+OtRU/geSkmYlhTbo/yk4HtniQIsJlVuy/KhpTxTakm49Hh7CZ7OUw1CeCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8f0+sFkmahVWuW4632dP27SNdcNyaDkQgTMl0HLQ7Ck=;
 b=PbOIOrB/vlgQ5SzaAspvMIUfoYT7mH67QvRIz0DeR85YoG+sHN+kH/z8OYY2qAf9x4uVtvYtAtavn6kPo2NqEcULFgVciW9O+C4Ti3bEcmIuc4qLGofYf72Q0b1k2hqDUChxqjf8qFnBkR3NhGEX3rPJw6Z/GtKtEQ0eZGHWEyzPuapK/ljRWPvM3VJalTQVI7/AEdqpcVkFIcj12TgSbcrvKJ56LkkOMmakP3UVlbtAj/pBuYBZXLncSxoEEJL+SxgHKcADVssqsJp1eJWNxaiKkR8oxjFtpugN6hwHfGj4+M2fRdC3lwTGjqajTiiG7aG6Wb3ZcGfwdcU6pcaEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8f0+sFkmahVWuW4632dP27SNdcNyaDkQgTMl0HLQ7Ck=;
 b=CiCFl4Oe0X9gMp1dpkYyZG5hd1Oxt0knj9VJrsy3ZoGPGmTc/SxGkfDe6ZLQFt2C0dZZ4Zn8et9XAFG0lSnLZJgZSI4tywzyunz7Dw3Zd+JIE3ziW92dV+Y7pR1akFzOEknkOPDCgFw6yAsVAzkZItPLLFZ+7Fd3TCSPO6FADWI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5896.namprd10.prod.outlook.com (2603:10b6:510:146::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 18 Jan
 2023 16:39:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 16:39:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks in
 COPY codepath
Thread-Topic: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks in
 COPY codepath
Thread-Index: AQHZKqtMKSgqI33qoEK/JPELcgPtS66kQMuAgAAMmwCAABFIgIAAAtYA
Date:   Wed, 18 Jan 2023 16:39:27 +0000
Message-ID: <12C5F3B3-6DB1-4483-8160-A691EB464464@oracle.com>
References: <20230117193831.75201-1-jlayton@kernel.org>
 <20230117193831.75201-3-jlayton@kernel.org>
 <CAN-5tyHA6JgqnEorEqz1b3CLdbXWhT6hNZKXzgfZy3Fr_TdW7Q@mail.gmail.com>
 <1fc9af5a2c2a79c5befa4510c714f97e26b13ed5.camel@kernel.org>
 <CAN-5tyHKS9o3KDV3zUmzjiOjSxyC1rNe77Tc8c7RHmoXE6s_RQ@mail.gmail.com>
In-Reply-To: <CAN-5tyHKS9o3KDV3zUmzjiOjSxyC1rNe77Tc8c7RHmoXE6s_RQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5896:EE_
x-ms-office365-filtering-correlation-id: 86aaafe7-f1a9-412e-dc71-08daf972906a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JG5WGVPnAPOYKuHOVvIUWHvlTYAVYOANEvfvtvQEkKQrYghS2WoRq5ibpdFB08AX8hweA2mdJVE7Hcou2ldq7q4OTDb0Z2SAFg/1uPbO21TZtmUnqd7v3XexMzUjEsRirJz9ci2v2QEcBlLllSXmlldCoDeCOWY99xPihc4ETD7DF9yjnTO831SEsuCVmyJixqp+vDaRKWNfhPRDuCyqK/luOygCOtZvxjFksUU+0Vg+3R4D27mqsaKEjb5sdOX1A4JPHD+nAdX0IsKUWYE1HzPPgvH14pptr7yaJbXDZRvXie9NK7Xv8v0MFNwQOvwZmh9YF9skz9th4ClW287yUFF4/ng5AzxYFbA2lgFiHHMeZzdhgpQke1V7qpRaNBsEq7ce7pxHvKYxFbs9HZAik7VvNhSVSVhlWoW09x/WPb1mSmacFDAIjYh68raOKdncV4xnmJTupt8W7hEt8U3WM5mCATa0JBCdyWj1m8xNYvCDNz+CBGtJW5sVSxK6GVvGJlWQyaNqQA0OK/xh0CMpeOVxbC8iAHqI7niQXLUQF7WgDE9p3QEcReVPuug1ZnW3U0Yl/2gWfvDM02SjQLXGcI6aHvHU47RDZ/Bny1KuhXVvQp0JDlNeBtGCWm4TLsTJ5t2MH4HL1HNlG5ckmmytFTa453TTtR7TxK+NM3PKSmxcse867Agp6c/p301oEnj8U8uxeHItL+Uc7+XL7NKwMbx5uqv4uz/tuxdoiKmDnk4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199015)(66476007)(66556008)(38070700005)(64756008)(6512007)(66946007)(4326008)(66446008)(91956017)(186003)(26005)(8936002)(2616005)(8676002)(76116006)(316002)(5660300002)(2906002)(86362001)(33656002)(41300700001)(53546011)(36756003)(122000001)(71200400001)(107886003)(478600001)(38100700002)(6486002)(6506007)(54906003)(110136005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?odB63KB6dk3HaqM+TaP6p7fR+kWVDqTXAP3JmUM+90256Dr4cSaPoWAISJ8X?=
 =?us-ascii?Q?OctsF5uzvZOoQlhxWcFDFT0x+yD+pjRpfp07U2/2nsrNMpi5eP5it+Sfap7h?=
 =?us-ascii?Q?okiE7xiNfCPmpcmnuuVw708c85LTDnega7njDeXga/IHA2zhaX4pfKQUXcQt?=
 =?us-ascii?Q?lhadxdlRsR51ad6C5YT8KQmd4v+zlLI2k24Et8acb2yfl1wl5jSoTC384MJ1?=
 =?us-ascii?Q?NymCi4XX9tuaxdCzA2NLolz+RO4qptjQu0rgdUvcXwRkp0hfoxVVW4LWmnAX?=
 =?us-ascii?Q?G5alTFnUOjpVqKFle5YirOFBqKrswPDck6J6A3koXBBZO7097NIj2TXUWnIX?=
 =?us-ascii?Q?20N49M6Td3PlYWzBEBYE55kxGRlba/kfbsYt/faQqIFFIZxgpvHtNXCviiip?=
 =?us-ascii?Q?VGNNbS/T4F3t0uWqIuETb2iZNNncWJXhnyovuNERbIaVih6hFEKMhzx3PrOo?=
 =?us-ascii?Q?rpmjcpLkhldclExkGvnlwD6vbDuYUhbKjy67UDHu2zI5FB0nmB04hf2lyjKd?=
 =?us-ascii?Q?3o8isx4VrLWzrO3SYaEqfIp8th1/y/Ww4VoK8I5p0KALeceASGE6Va3bEOc5?=
 =?us-ascii?Q?al5F7I6FcTfk1IUWlhg4B5UALHs94OmkMKZ5eY/3zuYQRiQuJyz0ObXuG8kK?=
 =?us-ascii?Q?Lo+vDZYFi0sfHz8+f1PCRMU55G6MT7ZnTw58H/cRBj6/JZIRqHSAZInBXcLE?=
 =?us-ascii?Q?eicmgw0d0qMrkFn9pDhhNNxhRjpzLJphaWtafSOImIPnQxTX5oi2aalL5/+M?=
 =?us-ascii?Q?CKhQGMez5va8hrnXatv2OJSOGUMDRnMhgBDMBajddvRy7ORD4XVQZN7GEuJd?=
 =?us-ascii?Q?SaLMKE9TCE5nY+oOtyfxOwgm2I+cWxkG0UWo493WEG/mkGLa2Xiik3/ECOLD?=
 =?us-ascii?Q?t7tE9vtSUFgzlAYw3w47JSI+D0ucX/tmMQd4nXIM2FLy80erW8z5tBKOwauP?=
 =?us-ascii?Q?youSiyqyv+79lJVACd51NLkDVCugEZqKVT3D/EAFCSMhZ/IulrudDoimAqPT?=
 =?us-ascii?Q?FBC+UbCXD6DvrM/KOQ/HR4bq2TR19V8ddRLyMI7PNz0Q4hSwwC5ndG+rlZ/v?=
 =?us-ascii?Q?TcOBlHs2EYwPYP5WVpGmcY0WqI/DE1LScFkC178gLgWMSBuTZD7oU1ow5SMc?=
 =?us-ascii?Q?pAtZEAoBV+Erlgzu6hxe6t86LHSEqIYfPjacAGmoYE2OmQyYMV5dMPv40DEs?=
 =?us-ascii?Q?NQMHnikWISsoDawsgmsUdwqRNi6DW21FbvQ0kvpXqS228tSwKg2UPIeK+UlP?=
 =?us-ascii?Q?UQeOnIgrZwJzfOQo++4KPF0j2pF6lBG40QOjOK4gEuj8yUOSf11M0bDBcoix?=
 =?us-ascii?Q?GiS27jYe6Y6B/OwFYJ1klYavzZ34X5nFzrb9vv3lxGXx5odEsJ/ueWvBD5EN?=
 =?us-ascii?Q?TKGVKsFCDufoud862Y/vTLeHtyoE9nfIWlOB4QnZNXAVy2UW+WQvrHWxHoI6?=
 =?us-ascii?Q?BWUq3OY1rzuKOHX5o0fAKRq6hrsJUASuGbjwl/9WZ9a5ZdKq0RGDvL1Z6hmn?=
 =?us-ascii?Q?ZeTwmnSmO7Yhx1cDEW2l91UerhE/jfE+rpgS7+XTReYEHSDgakG9+yOPohsY?=
 =?us-ascii?Q?dAyQfEo8GsF16telv5D5dYKjue+z0N4L40UX51EpXaudd2pMF3+wtmfmEPoQ?=
 =?us-ascii?Q?tA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6340FE065CC19F4B8940E09901C0DCED@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZrwpkkPcHPGSCwMMUuW1IL7/OdNoeUADZi+l0m8cyTs+nPmfcANNRNeYjdkmwHGM5NjsKAq1NuBtOKWy66UJoGYrNQaQb0+MghRvgE5GwUNbDat9ZjBWLh2q849iVMjzk5bQrs4H4i5fDWgGiB+u5l81EmmmROKR70oIMICvn7z+JSZs6vBHHNFUFrPBsrVEWKnFineDRnpqJLk64qrXQznCsBv95ld+nayakdvXe8RNO5oZMk5e4kuL2lYUyk5M7bs6EAxmj7Gk96LO+DKTyooDktdFnbTAzPGbqrPAnwWIhE0Iprh4fFsz/q2P6GbS2/oQEQ4MmzXqoWvA+45c2Xv6m1MwDY8Y/j1VOXCJcBSxU+RO1jfe2phtlhGzPtS4qWZWDPSRtO2DDDDmu60wox+9X5Cv7t2bWuzGzNNkn/Y14LsEijSTPpm5ucSDdV2W3qefrOrPfIz3Ghi8TB/JrtYCWhtPoBMFgF7OdZ2A9lzd6oQ5+lTl365G53xkGs3XtxO4R4uVyboVbgnZnKudvbsf93JHb5KpJWWgSCzl81CtYh44YUwcXMy4pd+91snsm2MDw2TU+lR3RgkpU0PGc2Mh75/syXp6YQGQMOdvDFIkoVPcV7brnxeRP1MzR6weRkk+65lLv/AUbgWD9Y0Hent2XX1HiOM+L+LWaPuwuvbAIueveABbaE/3fk4FJRFJHhafrb90gC5ZSr6ntVcvmvaqFW1idX+/MbjeQk7tKFQ0YehjVUAeQOMJMfy+26MEKmV35B/pBQ5jjfVoejqGVJS71SjgKaePy+DT0Ricy5We7U7lspHRLrqVWjEHBPW8
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86aaafe7-f1a9-412e-dc71-08daf972906a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 16:39:27.0231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +bYoNvMBrAFvngQK4H9eYzvLTqzdXeOxEaM8nOSiy6+Nu8iQmknkBPV2zfI3onmVgyR+ReCuDg1vQ0c/3lqcZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5896
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=986 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180139
X-Proofpoint-GUID: eixWdpsc6vKKGVaPsv6o-bXlXiV3bd2c
X-Proofpoint-ORIG-GUID: eixWdpsc6vKKGVaPsv6o-bXlXiV3bd2c
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 18, 2023, at 11:29 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Wed, Jan 18, 2023 at 10:27 AM Jeff Layton <jlayton@kernel.org> wrote:
>>=20
>> On Wed, 2023-01-18 at 09:42 -0500, Olga Kornievskaia wrote:
>>> On Tue, Jan 17, 2023 at 2:38 PM Jeff Layton <jlayton@kernel.org> wrote:
>>>>=20
>>>> There are two different flavors of the nfsd4_copy struct. One is
>>>> embedded in the compound and is used directly in synchronous copies. T=
he
>>>> other is dynamically allocated, refcounted and tracked in the client
>>>> struture. For the embedded one, the cleanup just involves releasing an=
y
>>>> nfsd_files held on its behalf. For the async one, the cleanup is a bit
>>>> more involved, and we need to dequeue it from lists, unhash it, etc.
>>>>=20
>>>> There is at least one potential refcount leak in this code now. If the
>>>> kthread_create call fails, then both the src and dst nfsd_files in the
>>>> original nfsd4_copy object are leaked.
>>>=20
>>> I don't believe that's true. If kthread_create thread fails we call
>>> cleanup_async_copy() that does a put on the file descriptors.
>>>=20
>>=20
>> You mean this?
>>=20
>> out_err:
>>        if (async_copy)
>>                cleanup_async_copy(async_copy);
>>=20
>> That puts the references that were taken in dup_copy_fields, but the
>> original (embedded) nfsd4_copy also holds references and those are not
>> being put in this codepath.
>=20
> Can you please point out where do we take a reference on the original cop=
y?
>=20
>>>> The cleanup in this codepath is also sort of weird. In the async copy
>>>> case, we'll have up to four nfsd_file references (src and dst for both
>>>> flavors of copy structure).
>>>=20
>>> That's not true. There is a careful distinction between intra -- which
>>> had 2 valid file pointers and does a get on both as they both point to
>>> something that's opened on this server--- but inter -- only does a get
>>> on the dst file descriptor, the src doesn't exit. And yes I realize
>>> the code checks for nfs_src being null which it should be but it makes
>>> the code less clear and at some point somebody might want to decide to
>>> really do a put on it.
>>>=20
>>=20
>> This is part of the problem here. We have a nfsd4_copy structure, and
>> depending on what has been done to it, you need to call different
>> methods to clean it up. That seems like a real antipattern to me.
>=20
> But they call different methods because different things need to be
> done there and it makes it clear what needs to be for what type of
> copy.

In cases like this, it makes sense to consider using types to
ensure the code can't do the wrong thing. So you might want to
have a struct nfs4_copy_A for the inter code to use, and a struct
nfs4_copy_B for the intra code to use. Sharing the same struct
for both use cases is probably what's confusing to human readers.

I've never been a stickler for removing every last ounce of code
duplication. Here, it might help to have a little duplication
just to make it easier to reason about the reference counting in
the two use cases.

That's my view from the mountain top, worth every penny you paid
for it.


>>>> They are both put at the end of
>>>> nfsd4_do_async_copy, even though the ones held on behalf of the embedd=
ed
>>>> one outlive that structure.
>>>>=20
>>>> Change it so that we always clean up the nfsd_file refs held by the
>>>> embedded copy structure before nfsd4_copy returns. Rework
>>>> cleanup_async_copy to handle both inter and intra copies. Eliminate
>>>> nfsd4_cleanup_intra_ssc since it now becomes a no-op.
>>>=20
>>> I feel by combining the cleanup for both it obscures a very important
>>> destication that src filehandle doesn't exist for inter.
>>=20
>> If the src filehandle doesn't exist, then the pointer to it will be
>> NULL. I don't see what we gain by keeping these two distinct, other than
>> avoiding a NULL pointer check.
>=20
> My reason would be for code clarity because different things are
> supposed to happen for intra and inter. Difference of opinion it
> seems.

--
Chuck Lever



