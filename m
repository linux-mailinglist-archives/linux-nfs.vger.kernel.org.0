Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E53C7DFB8E
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Nov 2023 21:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjKBU3d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Nov 2023 16:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbjKBU3c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Nov 2023 16:29:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFB619F
        for <linux-nfs@vger.kernel.org>; Thu,  2 Nov 2023 13:29:28 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2JM536017184;
        Thu, 2 Nov 2023 20:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=iloDd4ROmmRjmIua4a1VVBgFkb5R55QeeCt1AZ97Vi0=;
 b=2axO0jKR5B9EfwWrTUGMq/hTxqjbmSU/+95LZ/hgf7sJWjoy8/oHTMD7CsX3zCVjvBfv
 m93z9fUa/a/l4X5qtSzSTswnkDc+o4qAooKIbXxz22I6+jxFXm96VIoC+ydhz2uWi48y
 bBo3z0NSRQoxHyNWsqY2ADggVMW1rAdH+/EFaeYVwNgQdjiR0oE7ykEAl6tvGJ0Kda3g
 bm+UMJUk5yWkWsNhMFO6+Goy3aEAdFMXGVpi+DXdwj4viShlV1Yy8Iqm/6joW+LYu4g3
 EaEXr6HangI3EAr2CdT2MRYIkiX/OnUK224WqgKF3koWogtqlhDxsRyQ++JlppXfnrUk Tg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tbdtsgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 20:29:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2JUFxp001099;
        Thu, 2 Nov 2023 20:29:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr9fpb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 20:29:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZF081lZxzdA4SDbd1AeRmcHLMJ4Iw8E3sKHfh4nIUgwm1FKRpGo00iBA8iqX/2oOKbz8dsnxZ2+bvp5BrnFNMK8eD2ui9xhSkmSara6IfMRZ19Dn+CiKiZ+YYeijmUz0BL2GxywCNwtYq2mJLTTkp5QGpOHRG4vRFLchqxIMXWhSqHHi9orqXTx8EBfPYi2iZED4bCjZ+Nk1oRPJj7UEaj1FhYeJCtrAPa6EeN8tugy0byax44UdDNvOkNHoZlhcX30j5yW/fUuXmLnykKWJ9Nb8qgpCaHctLMEregoFZSg1AMG7J5E9dmqekZQ7T8napEtjzcr2RORHzXYTzX5azQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iloDd4ROmmRjmIua4a1VVBgFkb5R55QeeCt1AZ97Vi0=;
 b=YJSVdt0XQuLnugsewYifqxflMvPksNRwXGeBCDeuv9ZDjgge58Buwq0WbRFbB1M/RJc8Vmo90ulcTLr5cHFZI3VJsr9FNABqdKTQyg/My/NSjQaHHfvxvEkz2kD4z6OUiIBGbWPAzExnnfOMAxEQ/z4HFdWaBqqHh+xnboMDgBqLBGv4GmV8mGRPar1zBIOxee4H9D41ihyiSGIaOhVDEMqyuB1MxsHzcuUsCXPzaFx6bB0K4fOusRHidJTjPHnaJ+ma9DPQetBi4stejJRzhCxrxtCeFJO0aQnFNC7DJu8PmFmZTEpGQ3XDhN+EcFQwWqbBweFKQSAJeIzXqdx1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iloDd4ROmmRjmIua4a1VVBgFkb5R55QeeCt1AZ97Vi0=;
 b=DOo27iTqqtxrrVe56nuUBFAMlGUNWGXU7piDdX/FGv05W7dLjonM+mlzQ2VsOjbyyxL+kNDYsNCgztF00OOL5nABzQ45t0PtFA4hnxErniP3q8ZWR7aoboqKa+Z6scHSzAycOIOb241qjFLmRRtywZld/9kqUY/AqPAXp00SRqQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6474.namprd10.prod.outlook.com (2603:10b6:806:2a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 20:29:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1%3]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 20:29:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 1/6] nfsd: prepare for supporting admin-revocation of
 state
Thread-Topic: [PATCH 1/6] nfsd: prepare for supporting admin-revocation of
 state
Thread-Index: AQHaDF73s0OFopx3Wka1T0y0IH32GLBm2ucAgACbjwCAAAYNgIAAAS0A
Date:   Thu, 2 Nov 2023 20:29:13 +0000
Message-ID: <E792C97F-BB0F-46DD-828F-113F95270464@oracle.com>
References: <20231101010049.27315-1-neilb@suse.de>
 <20231101010049.27315-2-neilb@suse.de>
 <171568f8371932f66429b4557bce7aaf959215ec.camel@kernel.org>
 <169895539002.24305.2542985743958570903@noble.neil.brown.name>
 <83c7ff4f3166c5780ce803e43eaa65e9d9e2f6bb.camel@kernel.org>
In-Reply-To: <83c7ff4f3166c5780ce803e43eaa65e9d9e2f6bb.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6474:EE_
x-ms-office365-filtering-correlation-id: d5df6c1c-e87b-4273-e6fb-08dbdbe260a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZwEl8mE8/DMoLCdvnc+Qf+YJTT0UQlvtMVYeFJHeanVr/uYWHjGcVaNcNrmR5BhisGgsheXyvzueeFkbYPW7eBYvek83cS7jdkfRBXilaQkC5S5xkLtVQlHRmew3Fv7VCfELRD1A0zGvI2uRmfEcw0+QtKgw+pBdjp+/UaVf2Tx00cdOM1iiwsGLq2Rnt6YF1+f3RN2G65OFA0TiMY0k6+mM9w+oVCYovWqc61yAbd0hIgrDe1dy1+5obNkn4uMIvbY7dPJeY1ErAI9e8wgoJPMMoQcWmQSW5bEldtdYsGp+Io3IlwO3YImNg2LciE7ELHw/muP/kJpPmLc/Xfc0r1pq32/Ewem8keif3+Ai/38QTkIDS+Db6a8WVqg83bjYzmNul08E7zsT5YxZYxoHKexBE/yIKmgUL47jFmP6y1E/7GHb0yedE70DNu8ZhQPthgu47WVEurll9im++xG0yMa9nvprbxb7RSjhr1WsB1Uol+k9XX0pRh7Z43MgPV0JgqB37YzWt7t+TaCAJIzRRVU7jm+V98b2EEc2DRXK/7rItwNkiKbrUXlwmHSrktkL4entlEUqmzA6FY5706z5GDskNSpFQmkNECUhUdSX7fPL27UlxLZYnXtA/o6k8lDP30QMNVk9ejWko48mPvMaW658mRAvHZNQFF4E/cWBhVE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(91956017)(41300700001)(71200400001)(66946007)(64756008)(66556008)(66476007)(38070700009)(2616005)(54906003)(316002)(66446008)(76116006)(6916009)(6512007)(478600001)(53546011)(6486002)(6506007)(26005)(8676002)(83380400001)(8936002)(4326008)(2906002)(30864003)(38100700002)(86362001)(122000001)(36756003)(5660300002)(33656002)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yh69BTddXUDbvzwvHX7UHbLLed9VE0obBOAz/T1whs+UdKvJFq4pwAoVfywb?=
 =?us-ascii?Q?2zaq0m06qb3kZjg8yIGCdqYdj94qU39k9GL9MrRUn96LMPwqF9FppcNd4AHu?=
 =?us-ascii?Q?nlUOXD5fdDwmMdXnc320XK1uz5SxqW+Z9JRNlM763077yz1krWXXvOTRTyDZ?=
 =?us-ascii?Q?WtWtxjXdcIaECN+WTGeyMHBv957bFHupJuSvmRTOuy7+7ySmpRBqWmsknXF3?=
 =?us-ascii?Q?MM90D0OjtoNivhc84JJkqGswgR5mkJQyL7J85/ec5qm/QXwYpN6bw4w87vqi?=
 =?us-ascii?Q?J+nDZ/b7790r+UlIuc15YoHdeQOWVgS9m7emFbGqVpDRHBVxBPuADWo7eXT8?=
 =?us-ascii?Q?9vPOcmJeGZdpHBZFYw0E/KeU+Zq70TJP50DdrlET+4UN1pIww4SOFsw3E1Jl?=
 =?us-ascii?Q?64jV+BKvbS/22m8QD2b+EAglkSWcPP9dE7eC1NnkZe+IkTEoTFIB0MUn+EVz?=
 =?us-ascii?Q?HVjtKLw0AjdPAxUbqsHE0/fQrHGFTmF8GWxf7U/c6ZV19ohvQwXunS0GIZB7?=
 =?us-ascii?Q?760mBbo/Oi2OS4hJzcAR8nHcz+8A7S6yZaBw4R6Xq7eolAY0Uprsc6ulcw6k?=
 =?us-ascii?Q?DRD4XWRG6BUJHBC8EFu3OIkQI+CyQ/T3wL6LN+bh/x4qJuksGKbSQVIdrrHj?=
 =?us-ascii?Q?0QX2xakMyUQqxysdxWLke5F8O7dtekK6VEcW/QJA5BRfb4BAcIGkGc0JUKph?=
 =?us-ascii?Q?0yrFSO/EWlbN3kg/ytYfIPAtOvuBBcJeuAqYJBE5jmGp/WdoSXEw9lrGNYmj?=
 =?us-ascii?Q?MXaKDQmD9ohCzb+HfWrxDPrYHaWT+xjUXG88p1YreZm4kQivJs9PyncM1mt5?=
 =?us-ascii?Q?QylQGEPUZvOTrWslDTQkE8q8L55+FQNLBm8eRj0H0/f7T7uW4qK1EhmYesSc?=
 =?us-ascii?Q?ULD5gs54lxEURiNSZokmk3tsI/KZxhBs/ltukfiy4RzJQ17w0vNo37ffzXye?=
 =?us-ascii?Q?3epRcapxH2f+ETSU/jBVQypk6D6+YAWt4CQJpUTeb+yeorxXnYfqUZ1oYNmQ?=
 =?us-ascii?Q?ZLcCcnUn5azmreXxrCd31mkONq4rFKJ3ytfLcKNsDcrKhk2LRmxywylumu1A?=
 =?us-ascii?Q?UivGenWlHVFK29K/l9pJH/DH0x2bNfK6dBj0/oIrr9Vx/bGCI1SwLxV3dMIJ?=
 =?us-ascii?Q?88WgKFswjDy5+oWKAANFbCWMowatCru0kmGjeq/1rrzSMsAgAEPvx22b8CTi?=
 =?us-ascii?Q?w3rpsSoemt+Xnym+AuvvpfVyxH8T/HEYpna2AtMBufRKoeBvEGeNvmSTYGy8?=
 =?us-ascii?Q?MFsNy6BJ6kATs3FCJC51sOnCsvXm2aMSM/WovQ2ZXB1SR28c1r739xHk4ufb?=
 =?us-ascii?Q?98xgsFMwvk/PYrTrfNoAfN317drUsoURNxkjb+gNA7gA6q3ukxF1d6Z2lcZ3?=
 =?us-ascii?Q?Ej0ysLBXMkFxDP3IG0Sij2ty4jwwZNe3moGcxcKYA0GXvc2JJI2p1MlMLwhN?=
 =?us-ascii?Q?lH53qtvGY0htKxBa63EfgXQM5kUdf142pOuAwiJiiPLfLAUmMl7/A2wGWAuk?=
 =?us-ascii?Q?eCaRsFQhvO1SAL6dQRTbTnC52R8crj1H0W/erwvsjYPlVTfzDC2/Kg4XyfMA?=
 =?us-ascii?Q?vhmfHDSUhNmQDbK1qgtL2nlgldQ9+4E/Lbg3U6dR?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <40F1AC99BFB82C43887D9F16F84A5588@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RySO67RfHiPf/GaiOT3tMWcF53xpjoFo5S58HlxnQouW8WxrLPvAgUX35hN6Z4XvpG1upBpgR/Mf6DDMN6Dlj2in7Uvdxs5Fe5cX1irY1EnYnEKfM6WhjXHsQ0w99w+1/bN6lK9DijT0XI0l9FAFXgwqVpVmIyz0U77qhnmZ3gE1ty3RMkP0rU8G/gu0FygsL7TScyxuspbx27fYiXdP4hXa2altXUNdG5v72wGeVq0WLBwdNDDsZgau+q2zTTDpdmwTcY8ezLoxERmu2KU4BHb8obOkf0nasGEB606y6z8lJapU89bRkkb2jVlCcXSqBNTueaRB11B6epzaHdEWJfXw1w813/BrcWITGJvyn9Ed6aDGeXCfAl4hFgUlenk5uEBWZJT1pMJqdy4n5aSk9Uuh9751XHZ62bbIArqxtwTkViuvzKTA881+THC4L4h0rp2bl4T90eXzVbg+j/IsSy8MsyFJgaAjxRmC0jxdqlzRqNM9tMgyU59Xd1gYDEF/ly88pEMEeJP/UV/SlHRngTvM4zkm3SNgZHAyJcexCr+nFy76VJ67Cv4uDHVk8FBOaQpYax36VFFWoPewKB+947mAWS5zE2cX9FJiSkIDe81qHnZ9HHoK+DzlOJPyKu82zU7xPYkoKvDO3GJec48kivx6a3BgaduCHA4g3sgOzsyJP2KLRBzaH5uZlBm+f7i2HHJGDmnz3XGInqZIz+mjiibLrRS7erK8seVtxerudo9j4e6KxDSvJQmbya0ooQtFXDnWIuspMejGXVMgVz6Fnjfvx8/+KS3UQPpJ2stRs7k9vwUkoFLPWLCxRA6hMaq1aJSajGJJqQTbQVn5KrgUKTrQXzNdpL8xHo+ZsV2xh9RXTAI5x1hzhc83awutmfvW
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5df6c1c-e87b-4273-e6fb-08dbdbe260a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 20:29:13.3136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJkZaINpv1fPnKTj1PL7dE6HoHmUIlFoGvI2abgMLIM96pF7xKXNM6PgPsHUb0ssGbOSIdhzoxwbnWggoRYiKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6474
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020167
X-Proofpoint-GUID: uUN9d8uGRLGDJp1C0vZ70kywsrVyau6j
X-Proofpoint-ORIG-GUID: uUN9d8uGRLGDJp1C0vZ70kywsrVyau6j
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 2, 2023, at 1:24 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2023-11-03 at 07:03 +1100, NeilBrown wrote:
>> On Thu, 02 Nov 2023, Jeff Layton wrote:
>>> On Wed, 2023-11-01 at 11:57 +1100, NeilBrown wrote:
>>>> The NFSv4 protocol allows state to be revoked by the admin and has err=
or
>>>> codes which allow this to be communicated to the client.
>>>>=20
>>>> This patch
>>>> - introduces 3 new state-id types for revoked open, lock, and
>>>>   delegation state.  This requires the bitmask to be 'short',
>>>>   not 'char'
>>>> - reports NFS4ERR_ADMIN_REVOKED when these are accessed
>>>> - introduces a per-client counter of these states and returns
>>>>   SEQ4_STATUS_ADMIN_STATE_REVOKED when the counter is not zero.
>>>>   Decrement this when freeing any admin-revoked state.
>>>> - introduces stub code to find all interesting states for a given
>>>>   superblock so they can be revoked via the 'unlock_filesystem'
>>>>   file in /proc/fs/nfsd/
>>>>   No actual states are handled yet.
>>>>=20
>>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>>> ---
>>>> fs/nfsd/nfs4layouts.c |  2 +-
>>>> fs/nfsd/nfs4state.c   | 93 +++++++++++++++++++++++++++++++++++++++----
>>>> fs/nfsd/nfsctl.c      |  1 +
>>>> fs/nfsd/nfsd.h        |  1 +
>>>> fs/nfsd/state.h       | 35 +++++++++++-----
>>>> fs/nfsd/trace.h       |  8 +++-
>>>> 6 files changed, 120 insertions(+), 20 deletions(-)
>>>>=20
>>>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>>>> index 5e8096bc5eaa..09d0363bfbc4 100644
>>>> --- a/fs/nfsd/nfs4layouts.c
>>>> +++ b/fs/nfsd/nfs4layouts.c
>>>> @@ -269,7 +269,7 @@ nfsd4_preprocess_layout_stateid(struct svc_rqst *r=
qstp,
>>>> {
>>>> struct nfs4_layout_stateid *ls;
>>>> struct nfs4_stid *stid;
>>>> - unsigned char typemask =3D NFS4_LAYOUT_STID;
>>>> + unsigned short typemask =3D NFS4_LAYOUT_STID;
>>>> __be32 status;
>>>>=20
>>>> if (create)
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 65fd5510323a..f3ba53a16105 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -1202,6 +1202,13 @@ alloc_init_deleg(struct nfs4_client *clp, struc=
t nfs4_file *fp,
>>>> return NULL;
>>>> }
>>>>=20
>>>> +void nfs4_unhash_stid(struct nfs4_stid *s)
>>>> +{
>>>> + if (s->sc_type & NFS4_ALL_ADMIN_REVOKED_STIDS)
>>>> + atomic_dec(&s->sc_client->cl_admin_revoked);
>>>> + s->sc_type =3D 0;
>>>> +}
>>>> +
>>>> void
>>>> nfs4_put_stid(struct nfs4_stid *s)
>>>> {
>>>> @@ -1215,6 +1222,7 @@ nfs4_put_stid(struct nfs4_stid *s)
>>>> return;
>>>> }
>>>> idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
>>>> + nfs4_unhash_stid(s);
>>>> nfs4_free_cpntf_statelist(clp->net, s);
>>>> spin_unlock(&clp->cl_lock);
>>>> s->sc_free(s);
>>>> @@ -1265,11 +1273,6 @@ static void destroy_unhashed_deleg(struct nfs4_=
delegation *dp)
>>>> nfs4_put_stid(&dp->dl_stid);
>>>> }
>>>>=20
>>>> -void nfs4_unhash_stid(struct nfs4_stid *s)
>>>> -{
>>>> - s->sc_type =3D 0;
>>>> -}
>>>> -
>>>> /**
>>>>  * nfs4_delegation_exists - Discover if this delegation already exists
>>>>  * @clp:     a pointer to the nfs4_client we're granting a delegation =
to
>>>> @@ -1536,6 +1539,7 @@ static void put_ol_stateid_locked(struct nfs4_ol=
_stateid *stp,
>>>> }
>>>>=20
>>>> idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
>>>> + nfs4_unhash_stid(s);
>>>> list_add(&stp->st_locks, reaplist);
>>>> }
>>>>=20
>>>> @@ -1680,6 +1684,53 @@ static void release_openowner(struct nfs4_openo=
wner *oo)
>>>> nfs4_put_stateowner(&oo->oo_owner);
>>>> }
>>>>=20
>>>> +static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
>>>> +   struct super_block *sb,
>>>> +   unsigned short sc_types)
>>>> +{
>>>> + unsigned long id, tmp;
>>>> + struct nfs4_stid *stid;
>>>> +
>>>> + spin_lock(&clp->cl_lock);
>>>> + idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
>>>> + if ((stid->sc_type & sc_types) &&
>>>> +     stid->sc_file->fi_inode->i_sb =3D=3D sb) {
>>>> + refcount_inc(&stid->sc_count);
>>>> + break;
>>>> + }
>>>> + spin_unlock(&clp->cl_lock);
>>>> + return stid;
>>>> +}
>>>> +
>>>> +void nfsd4_revoke_states(struct net *net, struct super_block *sb)
>>>> +{
>>>> + struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>>>> + unsigned int idhashval;
>>>> + unsigned short sc_types;
>>>> +
>>>> + sc_types =3D 0;
>>>> +
>>>> + spin_lock(&nn->client_lock);
>>>> + for (idhashval =3D 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
>>>> + struct list_head *head =3D &nn->conf_id_hashtbl[idhashval];
>>>> + struct nfs4_client *clp;
>>>> + retry:
>>>> + list_for_each_entry(clp, head, cl_idhash) {
>>>> + struct nfs4_stid *stid =3D find_one_sb_stid(clp, sb,
>>>> +   sc_types);
>>>> + if (stid) {
>>>> + spin_unlock(&nn->client_lock);
>>>> + switch (stid->sc_type) {
>>>> + }
>>>> + nfs4_put_stid(stid);
>>>> + spin_lock(&nn->client_lock);
>>>> + goto retry;
>>>> + }
>>>> + }
>>>> + }
>>>> + spin_unlock(&nn->client_lock);
>>>> +}
>>>> +
>>>> static inline int
>>>> hash_sessionid(struct nfs4_sessionid *sessionid)
>>>> {
>>>> @@ -2465,7 +2516,8 @@ find_stateid_locked(struct nfs4_client *cl, stat=
eid_t *t)
>>>> }
>>>>=20
>>>> static struct nfs4_stid *
>>>> -find_stateid_by_type(struct nfs4_client *cl, stateid_t *t, char typem=
ask)
>>>> +find_stateid_by_type(struct nfs4_client *cl, stateid_t *t,
>>>> +      unsigned short typemask)
>>>> {
>>>> struct nfs4_stid *s;
>>>>=20
>>>> @@ -2549,6 +2601,8 @@ static int client_info_show(struct seq_file *m, =
void *v)
>>>> }
>>>> seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_state));
>>>> seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
>>>> + seq_printf(m, "admin-revoked states: %d\n",
>>>> +    atomic_read(&clp->cl_admin_revoked));
>>>> drop_client(clp);
>>>>=20
>>>> return 0;
>>>> @@ -4108,6 +4162,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nf=
sd4_compound_state *cstate,
>>>> }
>>>> if (!list_empty(&clp->cl_revoked))
>>>> seq->status_flags |=3D SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
>>>> + if (atomic_read(&clp->cl_admin_revoked))
>>>> + seq->status_flags |=3D SEQ4_STATUS_ADMIN_STATE_REVOKED;
>>>> out_no_session:
>>>> if (conn)
>>>> free_conn(conn);
>>>> @@ -5200,6 +5256,11 @@ nfs4_check_deleg(struct nfs4_client *cl, struct=
 nfsd4_open *open,
>>>> status =3D nfserr_deleg_revoked;
>>>> goto out;
>>>> }
>>>> + if (deleg->dl_stid.sc_type =3D=3D NFS4_ADMIN_REVOKED_DELEG_STID) {
>>>> + nfs4_put_stid(&deleg->dl_stid);
>>>> + status =3D nfserr_admin_revoked;
>>>> + goto out;
>>>> + }
>>>> flags =3D share_access_to_flags(open->op_share_access);
>>>> status =3D nfs4_check_delegmode(deleg, flags);
>>>> if (status) {
>>>> @@ -6478,6 +6539,11 @@ static __be32 nfsd4_validate_stateid(struct nfs=
4_client *cl, stateid_t *stateid)
>>>> case NFS4_REVOKED_DELEG_STID:
>>>> status =3D nfserr_deleg_revoked;
>>>> break;
>>>> + case NFS4_ADMIN_REVOKED_STID:
>>>> + case NFS4_ADMIN_REVOKED_LOCK_STID:
>>>> + case NFS4_ADMIN_REVOKED_DELEG_STID:
>>>> + status =3D nfserr_admin_revoked;
>>>> + break;
>>>> case NFS4_OPEN_STID:
>>>> case NFS4_LOCK_STID:
>>>> status =3D nfsd4_check_openowner_confirmed(openlockstateid(s));
>>>> @@ -6496,7 +6562,7 @@ static __be32 nfsd4_validate_stateid(struct nfs4=
_client *cl, stateid_t *stateid)
>>>>=20
>>>> __be32
>>>> nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>>>> -      stateid_t *stateid, unsigned char typemask,
>>>> +      stateid_t *stateid, unsigned short typemask,
>>>>      struct nfs4_stid **s, struct nfsd_net *nn)
>>>> {
>>>> __be32 status;
>>>> @@ -6512,6 +6578,13 @@ nfsd4_lookup_stateid(struct nfsd4_compound_stat=
e *cstate,
>>>> else if (typemask & NFS4_DELEG_STID)
>>>> typemask |=3D NFS4_REVOKED_DELEG_STID;
>>>>=20
>>>> + if (typemask & NFS4_OPEN_STID)
>>>> + typemask |=3D NFS4_ADMIN_REVOKED_STID;
>>>> + if (typemask & NFS4_LOCK_STID)
>>>> + typemask |=3D NFS4_ADMIN_REVOKED_LOCK_STID;
>>>> + if (typemask & NFS4_DELEG_STID)
>>>> + typemask |=3D NFS4_ADMIN_REVOKED_DELEG_STID;
>>>> +
>>>> if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
>>>> CLOSE_STATEID(stateid))
>>>> return nfserr_bad_stateid;
>>>> @@ -6532,6 +6605,10 @@ nfsd4_lookup_stateid(struct nfsd4_compound_stat=
e *cstate,
>>>> return nfserr_deleg_revoked;
>>>> return nfserr_bad_stateid;
>>>> }
>>>> + if (stid->sc_type & NFS4_ALL_ADMIN_REVOKED_STIDS) {
>>>> + nfs4_put_stid(stid);
>>>> + return nfserr_admin_revoked;
>>>> + }
>>>> *s =3D stid;
>>>> return nfs_ok;
>>>> }
>>>> @@ -6899,7 +6976,7 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_=
compound_state *cstate, stateid_
>>>>  */
>>>> static __be32
>>>> nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqi=
d,
>>>> -  stateid_t *stateid, char typemask,
>>>> +  stateid_t *stateid, unsigned short typemask,
>>>>  struct nfs4_ol_stateid **stpp,
>>>>  struct nfsd_net *nn)
>>>> {
>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>> index 739ed5bf71cd..50368eec86b0 100644
>>>> --- a/fs/nfsd/nfsctl.c
>>>> +++ b/fs/nfsd/nfsctl.c
>>>> @@ -281,6 +281,7 @@ static ssize_t write_unlock_fs(struct file *file, =
char *buf, size_t size)
>>>>  * 3.  Is that directory the root of an exported file system?
>>>>  */
>>>> error =3D nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
>>>> + nfsd4_revoke_states(netns(file), path.dentry->d_sb);
>>>>=20
>>>> path_put(&path);
>>>> return error;
>>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>>> index f5ff42f41ee7..d46203eac3c8 100644
>>>> --- a/fs/nfsd/nfsd.h
>>>> +++ b/fs/nfsd/nfsd.h
>>>> @@ -280,6 +280,7 @@ void nfsd_lockd_shutdown(void);
>>>> #define nfserr_no_grace cpu_to_be32(NFSERR_NO_GRACE)
>>>> #define nfserr_reclaim_bad cpu_to_be32(NFSERR_RECLAIM_BAD)
>>>> #define nfserr_badname cpu_to_be32(NFSERR_BADNAME)
>>>> +#define nfserr_admin_revoked cpu_to_be32(NFS4ERR_ADMIN_REVOKED)
>>>> #define nfserr_cb_path_down cpu_to_be32(NFSERR_CB_PATH_DOWN)
>>>> #define nfserr_locked cpu_to_be32(NFSERR_LOCKED)
>>>> #define nfserr_wrongsec cpu_to_be32(NFSERR_WRONGSEC)
>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>> index f96eaa8e9413..3af5ab55c978 100644
>>>> --- a/fs/nfsd/state.h
>>>> +++ b/fs/nfsd/state.h
>>>> @@ -88,17 +88,23 @@ struct nfsd4_callback_ops {
>>>>  */
>>>> struct nfs4_stid {
>>>> refcount_t sc_count;
>>>> -#define NFS4_OPEN_STID 1
>>>> -#define NFS4_LOCK_STID 2
>>>> -#define NFS4_DELEG_STID 4
>>>> + struct list_head sc_cp_list;
>>>> + unsigned short sc_type;
>>>=20
>>> Should we just go ahead and make this a full 32-bit word? We seem to
>>> keep adding flags to this field, and I doubt we're saving anything by
>>> making this a short.
>>>=20
>>>> +#define NFS4_OPEN_STID BIT(0)
>>>> +#define NFS4_LOCK_STID BIT(1)
>>>> +#define NFS4_DELEG_STID BIT(2)
>>>> /* For an open stateid kept around *only* to process close replays: */
>>>> -#define NFS4_CLOSED_STID 8
>>>> +#define NFS4_CLOSED_STID BIT(3)
>>>> /* For a deleg stateid kept around only to process free_stateid's: */
>>>> -#define NFS4_REVOKED_DELEG_STID 16
>>>> -#define NFS4_CLOSED_DELEG_STID 32
>>>> -#define NFS4_LAYOUT_STID 64
>>>> - struct list_head sc_cp_list;
>>>> - unsigned char sc_type;
>>>> +#define NFS4_REVOKED_DELEG_STID BIT(4)
>>>> +#define NFS4_CLOSED_DELEG_STID BIT(5)
>>>> +#define NFS4_LAYOUT_STID BIT(6)
>>>> +#define NFS4_ADMIN_REVOKED_STID BIT(7)
>>>> +#define NFS4_ADMIN_REVOKED_LOCK_STID BIT(8)
>>>> +#define NFS4_ADMIN_REVOKED_DELEG_STID BIT(9)
>>>> +#define NFS4_ALL_ADMIN_REVOKED_STIDS (NFS4_ADMIN_REVOKED_STID | \
>>>> +      NFS4_ADMIN_REVOKED_LOCK_STID | \
>>>> +      NFS4_ADMIN_REVOKED_DELEG_STID)
>>>=20
>>> Not a specific criticism of these patches, since this problem preexists
>>> them, but I really dislike the way that sc_type is used as a bitmask,
>>> but also sort of like an enum. In some cases, we test for specific flag=
s
>>> in the mask, and in other cases (e.g. states_show), we treat them as
>>> discrete values to feed it to a switch().
>>>=20
>>> Personally, I'd find this less confusing if we just treat this as a set
>>> of flags full-stop. We could leave the low-order bits to show the real
>>> type (open, lock, deleg, etc.) and just mask off the high-order bits
>>> when we need to feed it to a switch statement.
>>>=20
>>> For instance above, we're adding 3 new NFS4_ADMIN_REVOKED values, but w=
e
>>> could (in theory) just have a flag in there that says NFS4_ADMIN_REVOKE=
D
>>> and leave the old type bit in place instead of changing it to a new
>>> discrete sc_type value.
>>=20
>> I agree.
>> Bits might be:
>>    OPEN
>>    LOCK
>>    DELEG
>>    LAYOUT
>>    CLOSED (combines with OPEN or DELEG)
>>    REVOKED (combines with DELEG)
>>    ADMIN_REVOKED (combined with OPEN, LOCK, DELEG.  Sets REVOKED when
>>                   with DELEG)
>>=20
>> so we could go back to a char :-)  Probably sensible to use unsigned int
>> though.
>>=20
>=20
> Yeah, a u32 would be best I think. It'll just fill an existing hole on
> my box (x86_64), according to pahole:
>=20
> unsigned char              sc_type;              /*    24     1 */
>=20
> /* XXX 3 bytes hole, try to pack */
>=20
>> For updates the rule would be that bits can be set but never cleared so
>> you don't need locking to read unless you care about a bit that can be
>> changed.
>>=20
>=20
> Probably for the low order OPEN/LOCK/DELEG bits, the rule should be that
> they never change. We can never convert from one to another since they
> come out of different slabcaches. It's probably worthwhile to leave a
> few low order bits carved out for new types in the future too. e.g.
> directory delegations...
>=20
> Maybe we should rename the field too? How about "sc_mode" since this is
> starting to resemble the i_mode field in some ways (type and permissions
> squashed together).

In that case, two separate u16 fields might be better.


--
Chuck Lever


