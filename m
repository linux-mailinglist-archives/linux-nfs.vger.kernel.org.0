Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285DB7B5673
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Oct 2023 17:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbjJBPTr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Oct 2023 11:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238054AbjJBPTo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Oct 2023 11:19:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B03A9;
        Mon,  2 Oct 2023 08:19:39 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392EAOi6010779;
        Mon, 2 Oct 2023 15:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ydW5blqNsBysyB0K2ZtWVBoA3jeCECOZO1h44I0uy0g=;
 b=J+p0RyRpikctBJGQGjpak/YkVD12TFIGqdg9ynoBKr0mcY1ru6ESyNc73KzpPv17D+20
 hY1IcDCf7herLZ262RCIfoAMtdH7+jhLH8tF+YInsoxH3mjoX02MjB5KZFqBuACf328J
 S+mmYvkAmoTtHTXXKlUjRoXMnYxUvgWbs/LtUKQJu8rvW28zQLzJ3moZovJ4bNcScJ4B
 Htq186XzbRa4R5iq7A7t6OZYXb3owwOAHK36TJvdavjsYNekprziDLcMMj5XFiEz3rDc
 i8jV5INSoPv0WBHP1A13Xivr3HnkMWdnIdrfalYtFzqmf+gtru1nA3Acu134hV42iF0/ XA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3eardq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 15:19:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 392Ev8B0006102;
        Mon, 2 Oct 2023 15:19:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea44rbe2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 15:19:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHk8EnqAegicL2OJi7m3YXLa9RZARWbwBDzdQf1/+XHeVIkbkTEPGMgnxMsYVhC/IX5LuKGG9TPv17QKelB0MiDIvv+b09kLMiPv4AnBo+HHPf5G9WdnbI0eZriT4+JC3gy2ahNUWhVMUutfzu5E4+JiTQCYepaZolV1xSIfRa01Uk2AO6llLH8zzz1sjUB4pjyksiinyVlk38wcmL6NmddaN2i5JrYUG8P+Qk80kzWdX3/0h0+HfgtZBHAbxp+OUTmrjQ4xHfsEaoIU6rQ3+nzZ5T9L0Clr3eI3WpR7Iej+w8nPdgYFUlGFehxXm6NHQNwpZY9e2dRCzLHxJAegMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydW5blqNsBysyB0K2ZtWVBoA3jeCECOZO1h44I0uy0g=;
 b=kNnneq+xAqJuHMWoRiDAIzZp+Wj352gp0VM0+cZviIdMAg96z/oH2YOTz8cN0pQBcgXQtpIIfo8TiJzbumrtCBtppO2gzH7Jxf0yma9dmmA9+NOq5O6WCsEvSKajq7K9/WNZxSM3mR0biVu+C7ajfylO5yF4/mL6rjtu7GmHNaK6QAhe0Isv1K+uH2vgHcUDbz2bspvADupw1LPldh9KJvtHTdozYkWBL6VFDPk1PRWz4sVtMKume3j4PsSpaMZnYAcofeN1RmvIJNJhmyNO9XBEd45qPEbu/rhFLBj2CkbWns5lnIAzwUG25i5m+DhjDAXtxkon1z6FKJbdfqMNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydW5blqNsBysyB0K2ZtWVBoA3jeCECOZO1h44I0uy0g=;
 b=Eyw0NqMWrDElNfgoVPH9K6l441raAl3d07TRsKYLlyjHtEIiKThgYbiDgfyr52Ls5wMFlsdpd1oZWctun9tgC4ToJYrwAm70DOIuBZSfJS0ZzxkPKaLqgzWIlSEuvEGsN/un/iiyWAgNSISLEZjAYr5FgDiVfoYe93VblOrUi/g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6614.namprd10.prod.outlook.com (2603:10b6:806:2b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Mon, 2 Oct
 2023 15:19:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 15:19:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>, Lorenzo Bianconi <lorenzo@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v3] NFSD: convert write_threads, write_maxblksize and
 write_maxconn to netlink commands
Thread-Topic: [PATCH v3] NFSD: convert write_threads, write_maxblksize and
 write_maxconn to netlink commands
Thread-Index: AQHZ8Ma6QVfM7SVFaUSgOHTmfVn4XbAtuj4AgAQaPYCABLHgAIAAH7CA
Date:   Mon, 2 Oct 2023 15:19:24 +0000
Message-ID: <11320C5D-9BB2-48D5-90A0-353F6D8EA78A@oracle.com>
References: <27646a34a3ddac3e0b0ad9b49aaf66b3cee5844f.1695766257.git.lorenzo@kernel.org>
 <169576951041.19404.9298873670065778737@noble.neil.brown.name>
 <ZRbUp0gsLv9PqriL@tissot.1015granger.net>
 <a1ab72d41a502906ea31b983f147ae75f6b0e3a2.camel@kernel.org>
In-Reply-To: <a1ab72d41a502906ea31b983f147ae75f6b0e3a2.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6614:EE_
x-ms-office365-filtering-correlation-id: a61bca41-4356-4e04-f351-08dbc35af5eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nhp5WVUvqH5pGl9fB0vkc/3vgRzb37MPw3NICFAwsUg+cQjXBLKnLVdkZ7y1dE3Ro5oGx9c4Mlw+wgc8Jm7xAT78+Un5UWYwQjTTVZJ5tH72wUS9VKPBTQDIeJrUiP19R1omHD6fBQrSUKYB6yk2kNUTPP6TxJ949/xA9eIGt+cWRBKvuQYO4NXfECDwwo4aOEiFamFp6skUNOvonLD9Iom5MSTduesThSD1LDnJomneYnRULtGnVrOUC9Y/WuM5LGX3nZDNgFqTwQSqkbVbUxMhXm8euHrubX2BFfXVBEx0tw3X6vK7hcNVZHnidXGheEvvh/6oVjA7jYzbsfIyD64uT/ilKMhTQsbHIMF8aJ8ry63exvr+6K3dp6lQouWcC7DIwkwiobrGGQa3IfTGGfDC1auzjufqfgc8nSC/lgdT+XeEjQt9CbCWVhVCwlY7DevtNlfBQEdlTcPWtlqgPEQbeTdevcEtVRHbNdGJ8uy77Oy9r3D9nauLaOBwTaKrjs4WwgaGXkwI+qaCODKEYyhTf5hEdm7sIXBAArvXcvjjQ1Jz9bh4VkCThkMXiAHizwi5P8x8AtYK7FdwijkDkvk+oPeQ5j7Su2Dhe21wJoVgQ5RzKQn/nWPY5LJU+7M2i4ncYHpj7Uh8b2vrN1IYog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(66899024)(2906002)(36756003)(33656002)(86362001)(122000001)(38070700005)(91956017)(54906003)(66556008)(64756008)(66476007)(66946007)(66446008)(6916009)(2616005)(316002)(41300700001)(53546011)(38100700002)(76116006)(6486002)(6512007)(26005)(4326008)(8676002)(8936002)(478600001)(6506007)(71200400001)(5660300002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XLw7lkDOr6OvFgJBHROXvI+GNlzt52fsPLJ12OwIezDr8lhlC6GwM93+cgAs?=
 =?us-ascii?Q?Z+sHJPDqHDZ7Obxi29oMt6ueMDapayDEmOm6OuDLp8yHTDrFAvFwpNLHwnBJ?=
 =?us-ascii?Q?lOSGf2BJmAwBl2vq87VZuzvVMiVAkMwHulHS8C1+cQrLHRYIWD6f5GDK02k2?=
 =?us-ascii?Q?kuZLL+f+8f5rP40eDoNAQUfsSneLeKbQRL+Qb9axVglZ4cULZQtP0qd8S/ym?=
 =?us-ascii?Q?hutuJrfDMD8fm6km++LUlPgONkc4wT7YCYiyljsEF54SFXTOSqFpGBHQK7S5?=
 =?us-ascii?Q?Qjr897w0oFgAC5IGVxsA8jeS4UJJ+ZohUBr7XRKKZKAlgjYlr2W+c3wAcicp?=
 =?us-ascii?Q?XZsrV8wcjmCjWBnzye4sh8L/YOFnvREAaZ+94kGdG/TwdPKBetwtv3yL5zuv?=
 =?us-ascii?Q?mBQXaWkJkf8xqxZ1/dPhMYnCxPfZOQZWhnXkj3If9rFxa7cHoVdP6z3gNJIG?=
 =?us-ascii?Q?PDynZ15FGlcNajOyIi4As1axacPo/Rb89/DUnnOoFw9at5fjZ4UH0CaFQ9yr?=
 =?us-ascii?Q?IStGeyN1OOJa2RxOUKpOVP4Kpu0nOdDvQjA6m+2jXb5YI8f1SrlvHpS3z2Dv?=
 =?us-ascii?Q?fy27tErqd9bFY6r2lejSJCGejpqIs/dI3cmPVhvh0nuzjePeHWfshdOLJjbU?=
 =?us-ascii?Q?kkTLXzK8TH6kzMqj3IkcLFt0py2XJLSMj8PrE/kH7lNSSTZNtFg6HzmzMv/1?=
 =?us-ascii?Q?sfCIoD2cG8CjcWFCTNoC7q/RBDJlXbv5JQ9EB32BtaFhqY2hESjpNlKt/o0P?=
 =?us-ascii?Q?iaNslRhH6utqYt5fsfAOt2sdfCsGzow7gh1+JTWfq6o5ggB+eDHuSOiTv1M6?=
 =?us-ascii?Q?KEHevCNzbCsFTqUwPVRX63u66EiCdt1spX1cRTfkHT97d8kZRmeqo8KDLvIs?=
 =?us-ascii?Q?2EXSHZkbieHBVk6kwpQdBdTFZGWFLzD9Y9UGjHY55WZ1s/PDoJLDYLnyv+fN?=
 =?us-ascii?Q?XysRrO0JUnG0aUvAN9Fpg3hlPC4dliFWHehYeDNxfXPm9Z6OmCAPjq3ie6bY?=
 =?us-ascii?Q?xLwqK/VHa8d4IZfp0tCJChwOcRVXkjxMDFLfVe95NYfQLQo5ebeSiwSSaNu/?=
 =?us-ascii?Q?NSLcjLDrtT9RRM59P2N/ymB4cYVvg1DLqTPVFNDfx4C+P7w0IxKuCTDPz0iQ?=
 =?us-ascii?Q?5mTUU8Ae0y4j4YrbUFrxbbo7YGPYAxAS+i949TuwcWO/gEETMqRsyBkPoVzP?=
 =?us-ascii?Q?oqeNz5j8DTDlefruj9oyaZRtUX/a7OHr0lBmOP+q8UmS9qOxQ+15xkN8YQOl?=
 =?us-ascii?Q?SeXJXN8JAtYZ4yK+1/SCXIqlGx8ruLG8+yIKwL2aSX6tnKM3suXQFeCAI0vB?=
 =?us-ascii?Q?3wzmzkQsiBJWur30RYSxvf5QT2PJysrmQq8FBzB+8GZ2TXCQtH2I6Zkiy2pO?=
 =?us-ascii?Q?ZvCN0Jkgnrn2Wd2stsr6XLAvsURNmvHcBkquu/a5F/odP/3fgmFOXw5bRIn8?=
 =?us-ascii?Q?Yjth6hWhQGaTSlkeS2NtFOTuVfInBlWVXVjsGAO99AMvW+4rhYiYNjYdGDfZ?=
 =?us-ascii?Q?xS9Lcf4wkHMtPosYfncuxn4ZaNEVdaKqtbL+pbdSsXqYw6dJIGqq5a13zCty?=
 =?us-ascii?Q?Lr0lOLSkIRnn31+/sRv6Lf3v6fo87BSbIYPwbOEJPlPIj2IxFbhA63wKsAj9?=
 =?us-ascii?Q?IQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D0DFE82C0C448848B67E32901A26EB2C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fo12dP448doUzwnzmTR3laEwvCPlAC0D93sH1mSgAJa4bQ140VsSFaC7LPRT11g9T7A7+uq9B4QVHY9cRmvPuO8KtATpL8S7A9/9RQRILDf/xxfkdM9bq3TLznHkB+3rZgoyQNpXTeQTdjlTLwVT3Chv/4zI2l1QfxUgGJSGLVRUIPvY8VCviMm7JL/OXsdCOo1sxGISG48Wk+pN5qs4WJEkU7u8o6CcLYJXW2D0BxePpyki0NNCYdtIm3Ow+AhHMjETkiUmIzNtBjQRh+lM/UuYj+5/ELrY0O4S37JcK3VZFe5k3IScRrpFGVpLsorFc3I9irC5Ad/qs/qx5/K+q1Hwq9yk4A+gxSWGDNLzanIhAsegRflnJTpHYwnmAGF77XS2B3ctQe4rlucOPYXCrtLAXjHcQ2tqg6WKK20fF6teoci4fTu5jVq29+Lh51Wo+9sAHBBc/aSgkW2C8EVT4Yh+mQ/iMSvMQdoTHFSEqlNQB4H0voE3c9LwuevqLkc60aHhmZLirybz+zWQMsu52Tq6CxzD/nKmJNeAlCJxpCYoVjfcOm4Oga2Tr4jekQ9KvYx2+MaELxa/oNNYTz3i6l6yFJ2CAqXIte71JpIlvVP4mBZ7o0Dt5ccnc8e3fSrzxAcYylL6fgZmSaSB9gR5iqNnLvQTEnHt/+M8dAgZenA1WC57YhIiT1rV7U/hc72bqpYwc5GELE/3LQQZrat7yAptMUm1LyTMNixVlurnbZWqHYWKPJ86CF8N7m8QI2gvlZW6DfUwqGTVO5cMUq59ChYOEHc4AKPgY7V+MUe3Y6MW1F7ZgBHLD1hpOCXMSjEQoewtBGuj4WUKEdzwVQYltQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61bca41-4356-4e04-f351-08dbc35af5eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 15:19:24.3079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C5AjtjrhSN9zWVQyohkae6AyycpT/U+sapZzg91cXcgUZafsS8Fv4kUFtZ2I1HMPeNdB99KdURPkqlMAfpOOnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_09,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310020116
X-Proofpoint-ORIG-GUID: -RE1u7t_g2sUGZdmgbA6kVtSln9XaXGI
X-Proofpoint-GUID: -RE1u7t_g2sUGZdmgbA6kVtSln9XaXGI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 2, 2023, at 9:25 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2023-09-29 at 09:44 -0400, Chuck Lever wrote:
>> On Wed, Sep 27, 2023 at 09:05:10AM +1000, NeilBrown wrote:
>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>> index b71744e355a8..07e7a09e28e3 100644
>>>> --- a/fs/nfsd/nfsctl.c
>>>> +++ b/fs/nfsd/nfsctl.c
>>>> @@ -1694,6 +1694,147 @@ int nfsd_nl_rpc_status_get_done(struct netlink=
_callback *cb)
>>>> return 0;
>>>> }
>>>>=20
>>>> +/**
>>>> + * nfsd_nl_threads_set_doit - set the number of running threads
>>>> + * @skb: reply buffer
>>>> + * @info: netlink metadata and command arguments
>>>> + *
>>>> + * Return 0 on success or a negative errno.
>>>> + */
>>>> +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *i=
nfo)
>>>> +{
>>>> + u32 nthreads;
>>>> + int ret;
>>>> +
>>>> + if (!info->attrs[NFSD_A_CONTROL_PLANE_THREADS])
>>>> + return -EINVAL;
>>>> +
>>>> + nthreads =3D nla_get_u32(info->attrs[NFSD_A_CONTROL_PLANE_THREADS]);
>>>> +
>>>> + ret =3D nfsd_svc(nthreads, genl_info_net(info), get_current_cred());
>>>> + return ret =3D=3D nthreads ? 0 : ret;
>>>> +}
>>>> +
>>>> +static int nfsd_nl_get_dump(struct sk_buff *skb, struct netlink_callb=
ack *cb,
>>>> +    int cmd, int attr, u32 val)
>>>> +{
>>>> + void *hdr;
>>>> +
>>>> + if (cb->args[0]) /* already consumed */
>>>> + return 0;
>>>> +
>>>> + hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_=
seq,
>>>> +  &nfsd_nl_family, NLM_F_MULTI, cmd);
>>>> + if (!hdr)
>>>> + return -ENOBUFS;
>>>> +
>>>> + if (nla_put_u32(skb, attr, val))
>>>> + return -ENOBUFS;
>>>> +
>>>> + genlmsg_end(skb, hdr);
>>>> + cb->args[0] =3D 1;
>>>> +
>>>> + return skb->len;
>>>> +}
>>>> +
>>>> +/**
>>>> + * nfsd_nl_threads_get_dumpit - dump the number of running threads
>>>> + * @skb: reply buffer
>>>> + * @cb: netlink metadata and command arguments
>>>> + *
>>>> + * Returns the size of the reply or a negative errno.
>>>> + */
>>>> +int nfsd_nl_threads_get_dumpit(struct sk_buff *skb, struct netlink_ca=
llback *cb)
>>>> +{
>>>> + return nfsd_nl_get_dump(skb, cb, NFSD_CMD_THREADS_GET,
>>>> + NFSD_A_CONTROL_PLANE_THREADS,
>>>> + nfsd_nrthreads(sock_net(skb->sk)));
>>>> +}
>>>> +
>>>> +/**
>>>> + * nfsd_nl_max_blksize_set_doit - set the nfs block size
>>>> + * @skb: reply buffer
>>>> + * @info: netlink metadata and command arguments
>>>> + *
>>>> + * Return 0 on success or a negative errno.
>>>> + */
>>>> +int nfsd_nl_max_blksize_set_doit(struct sk_buff *skb, struct genl_inf=
o *info)
>>>> +{
>>>> + struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net_id=
);
>>>> + struct nlattr *attr =3D info->attrs[NFSD_A_CONTROL_PLANE_MAX_BLKSIZE=
];
>>>> + int ret =3D 0;
>>>> +
>>>> + if (!attr)
>>>> + return -EINVAL;
>>>> +
>>>> + mutex_lock(&nfsd_mutex);
>>>> + if (nn->nfsd_serv) {
>>>> + ret =3D -EBUSY;
>>>> + goto out;
>>>> + }
>>>=20
>>> This code is wrong... but then the original in write_maxblksize is wron=
g
>>> to, so you can't be blamed.
>>> nfsd_max_blksize applies to nfsd in ALL network namespaces.  So if we
>>> need to check there are no active services in one namespace, we need to
>>> check the same for *all* namespaces.
>>=20
>> Yes, the original code does look strange and is probably incorrect
>> with regard to its handling of the mutex. Shall we explore and fix
>> that issue in the nfsctl code first so that it can be backported to
>> stable kernels?
>>=20
>>=20
>>> I think we should make nfsd_max_blksize a per-namespace value.
>>=20
>> That is a different conversation.
>>=20
>> First, the current name of this tunable is incongruent with its
>> actual function, which is to specify the maximum network buffer size
>> that is allocated when the NFSD service pool is created. We should
>> find a more descriptive and specific name for this element in the
>> netlink protocol.
>>=20
>> Second, it does seem like a candidate for becoming namespace-
>> specific, but TBH I'm not familiar enough with its current user
>> space consumers to know if that change would be welcome or fraught.
>>=20
>> Since more discussion, research, and possibly a fix are needed, we
>> might drop max_blksize from this round and look for one or two
>> other tunables to convert for the first round.
>>=20
>>=20
>=20
> I think we need to step back a bit further even, and consider what we
> want this to look like for users. How do we expect users to interact
> with these new interfaces in the future?
>=20
> Most of these settings are things that are "set and forget" and things
> that we'd want to set up before we ever start any nfsd threads. I think
> as an initial goal here, we ought to aim to replace the guts of
> rpc.nfsd(8). Make it (preferentially) use the netlink interfaces for
> setting everything instead of writing to files under /proc/fs/nfsd.
>=20
> That gives us a clear set of interfaces that need to be replaced as a
> first step, and gives us a start on integrating this change into nfs-
> utils.

Starting with rpc.nfsd as the initial consumer is a fine idea.
Those are in nfs-utils/utils/nfsd/nfssvc.c.

Looks like threads, ports, and versions are the target APIs?


>>>> +
>>>> + nfsd_max_blksize =3D nla_get_u32(attr);
>>>> + nfsd_max_blksize =3D max_t(int, nfsd_max_blksize, 1024);
>>>> + nfsd_max_blksize =3D min_t(int, nfsd_max_blksize, NFSSVC_MAXBLKSIZE)=
;
>>>> + nfsd_max_blksize &=3D ~1023;
>>>> +out:
>>>> + mutex_unlock(&nfsd_mutex);
>>>> +
>>>> + return ret;
>>>> +}
>>>> +
>>>> +/**
>>>> + * nfsd_nl_max_blksize_get_dumpit - dump the nfs block size
>>>> + * @skb: reply buffer
>>>> + * @cb: netlink metadata and command arguments
>>>> + *
>>>> + * Returns the size of the reply or a negative errno.
>>>> + */
>>>> +int nfsd_nl_max_blksize_get_dumpit(struct sk_buff *skb,
>>>> +   struct netlink_callback *cb)
>>>> +{
>>>> + return nfsd_nl_get_dump(skb, cb, NFSD_CMD_MAX_BLKSIZE_GET,
>>>> + NFSD_A_CONTROL_PLANE_MAX_BLKSIZE,
>>>> + nfsd_max_blksize);
>>>> +}
>>>> +
>>>> +/**
>>>> + * nfsd_nl_max_conn_set_doit - set the max number of connections
>>>> + * @skb: reply buffer
>>>> + * @info: netlink metadata and command arguments
>>>> + *
>>>> + * Return 0 on success or a negative errno.
>>>> + */
>>>> +int nfsd_nl_max_conn_set_doit(struct sk_buff *skb, struct genl_info *=
info)
>>>> +{
>>>> + struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net_id=
);
>>>> + struct nlattr *attr =3D info->attrs[NFSD_A_CONTROL_PLANE_MAX_CONN];
>>>> +
>>>> + if (!attr)
>>>> + return -EINVAL;
>>>> +
>>>> + nn->max_connections =3D nla_get_u32(attr);
>>>> +
>>>> + return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * nfsd_nl_max_conn_get_dumpit - dump the max number of connections
>>>> + * @skb: reply buffer
>>>> + * @cb: netlink metadata and command arguments
>>>> + *
>>>> + * Returns the size of the reply or a negative errno.
>>>> + */
>>>> +int nfsd_nl_max_conn_get_dumpit(struct sk_buff *skb,
>>>> + struct netlink_callback *cb)
>>>> +{
>>>> + struct nfsd_net *nn =3D net_generic(sock_net(cb->skb->sk), nfsd_net_=
id);
>>>> +
>>>> + return nfsd_nl_get_dump(skb, cb, NFSD_CMD_MAX_CONN_GET,
>>>> + NFSD_A_CONTROL_PLANE_MAX_CONN,
>>>> + nn->max_connections);
>>>> +}
>>>> +
>>>> /**
>>>>  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>>>>  * @net: a freshly-created network namespace
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever


