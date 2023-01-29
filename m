Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D2B680057
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Jan 2023 17:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjA2Q5C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 29 Jan 2023 11:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjA2Q5A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 29 Jan 2023 11:57:00 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ECA1B551
        for <linux-nfs@vger.kernel.org>; Sun, 29 Jan 2023 08:56:59 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30T4qeIP001885;
        Sun, 29 Jan 2023 16:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tZCPa7Lgwdg7bj758jZOQO9jnev3lNRtGlJkK4rkC6Y=;
 b=IrBPLC4eDSQul9xUKZeRUfQZkenkxOmhiQWfm6/qbRyk5eXmuK6s/utiT8KHWWLAD+XF
 bF8uHbBT1XVjrErBTppEkwM9IPuU/P1NQ4iG7dNN4/gUTtbY3CT8QR9HfxaK8ReAkn1q
 4swj3MrafGbCa32tQM9wR5+9OxCVk71P2Lh4VNZw2W22V/bmsVORUWYko4Sit46tyToB
 bVMNSnDt8NpQ8N3R/GBDdO7QnstTyLgANsaGMMOdHu1VBbpg0DP7c/faPQwzx9r1KmoK
 Q2jbC3da1ViSf5MX8dBzgKEOjStta4Tp5+ZXicV4K6DOphQsVD/0qfk/Xc8q7bdRnmYr 5w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvqwsk11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 16:56:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30TCLS4n024947;
        Sun, 29 Jan 2023 16:56:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct53fgx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 16:56:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCbPr3KYexkLY9yAeejHOXMbKqJ3dIHnQBrbzicccUjQA2BQJUEvlKlx6m/DcgyeojxT1RfNQWN6bsh6q9pimYY0WHN84qDAwT95lbyuOQzKp5eljbfQxeqSzFnfatiE9ljYbukOK5ZjhItlepDuCkOxCYcgty8DKu0rF58iUrQ+WqyfpOdbgPr6Clacl0t36c+kzEJWDbfDhTecY4rKk1JDEjLo8hQDxF2fl2XttgEvhNjDl+BspUj+jaQOcnQL/ymKA37kzy1/8ox5v9KKxLI5MovpiSuMv43FwMstHLGeRjBxhtk7IHOxseSzoYS9xZfBWLtji5+3ZmekIsYtgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZCPa7Lgwdg7bj758jZOQO9jnev3lNRtGlJkK4rkC6Y=;
 b=MfYQj76z9uICuxkIhIEaK31UAo4UdRxwyroiqmavW+IqBeU7znXx1CJBscfvKWX56L2a3RiDA0IGubcHPjezA6A1IqwdNgc/nzq2OxBOFxiUg6ha1cMI6hTDJOmuDqOeWnbd+VV//jntufA2Ws6m2YnoB1HaKDRxDmN0vEF/Afe2SZ7P/6GSvp7HIWw4LAfjEzKHDTLWJ7Y6jYU3QEQLENoZb/RRncSOxXMuUD0NuWcTCd9TwSEAIcVwCv2gMo5RRk2AvYhHtul7nr/iUSLcW8p0V9Cp1TXEH5QYNq1dvpFYd3Ul6beyVac2pGHOKmFE9Z0Z0bO6/ssgPcPabpIjjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZCPa7Lgwdg7bj758jZOQO9jnev3lNRtGlJkK4rkC6Y=;
 b=Kxbuj2iPKN7o0AHLvyoQbgLe+wQNrbfNaOI4N7piJJvnqGRFUOKgQZWy4q4JUFgDrODRNhryIVi6cqlk47mpxZRTsRPRrM1dq+mmhUMqADvZ25mxnxg2oPYlJcQ1t1Qh2JXViUPDi6MuVMAXZxf4hfO8DNfn3nW4COUKvxeQh/Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4714.namprd10.prod.outlook.com (2603:10b6:806:111::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.19; Sun, 29 Jan
 2023 16:56:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%5]) with mapi id 15.20.6064.019; Sun, 29 Jan 2023
 16:56:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nfsd: fix race to check ls_layouts
Thread-Topic: [PATCH] nfsd: fix race to check ls_layouts
Thread-Index: AQHZMmsV5D34wjZzDESw+lpk/7zjnK6ydZmAgAACMwCAABbPAIABRlkAgAAEQoCAAAfHgIAAEkGAgAGtRIA=
Date:   Sun, 29 Jan 2023 16:56:48 +0000
Message-ID: <CAB9C65D-7E34-4BC3-9A45-7747623C684B@oracle.com>
References: <979eebe94ef380af6a5fdb831e78fd4c0946a59e.1674836262.git.bcodding@redhat.com>
 <C9FA580A-52A6-4208-AFA2-91E8BCB36B9F@oracle.com>
 <49815925-FB60-456F-8633-79B4C203B782@redhat.com>
 <0412daf06541dfa71866be1efedef5456e524ece.camel@kernel.org>
 <A1324B12-C0FE-4A60-8116-4DCD98C92A8D@redhat.com>
 <4305a18844f395657ef0fd3af313d8e15c330499.camel@kernel.org>
 <34272738-0EB5-471C-A978-66F763664B7E@oracle.com>
 <e0e53e0299a62d4d2fef80b5811659b200053ae6.camel@kernel.org>
In-Reply-To: <e0e53e0299a62d4d2fef80b5811659b200053ae6.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4714:EE_
x-ms-office365-filtering-correlation-id: ea967712-f9bb-4bed-d7bf-08db0219cf90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FoVWxzbeIMHLWfdUYlSH/F0LmTC0viGHrJleLEbcOMqj5WMe9AzgK7XItxrVFhPLf9W11xXGSOksVv64uR4LIFGjsyZn+bywLaUH4DEkg1mpqh7WgDOS+pveSkQ8PzV5QLaIZfl1wdHk5y4kIMthZzBNYXbhDvNP5baLzqM3Dk+Td/ZQVjM1D5w3j+M106q5cSr+gxJAEqiogmAmAp11EkpwTd11wuT1XMZFjnP1/dvNbY26V2dBcWbQbc9f76Cc3IVHHVLc8ot9D9Ierzw49dJOM2DmWg8cwqx6J+y6RlMOQ95P7XE8fLmm1YfPtyAimfABnbhoywwAgTm0k5F/YGikynlSW2KQywELL5oLZaEkJ+ecTR4dZhidmHCp1GfOVh8K3M66iOUd99lTLkNDMY4CF7zo0xDS77hnOGrZUQd7SI8EnUYbAs4CWoi8VzOZGyBxcd8ioRPf6Ow2EE8ciLIoImLRVpQv/RFhzX5WtSN4ltZ3kHP6sTv068VqTAXmub2pBJRflpecO6jaMlKAqzNVHq0TiUcibdpDrT84oKo698WHN68jvNc+gjj+Q09CcKSapZ9xoYXJvHC58xN1GX7Ma5gAEqAyE5PyPKg9S8YuxL/yvoz/e+vrk7y/cdioGRVfJ9S/elg/5uwooB+mpFuOTtbbLlmTXIVIgxgAxr28G2pJp++t1ouJw8tzLEmqLLfHNIH393/F00b3JKrI3lkxknf47YA9hHvzA2bKVbscTDTlUqqByqjptFR6vFG3nfO/lAuFEQ8ys4jZQadU2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199018)(122000001)(2906002)(33656002)(966005)(6486002)(478600001)(54906003)(71200400001)(41300700001)(86362001)(38100700002)(36756003)(38070700005)(2616005)(6506007)(53546011)(66556008)(8676002)(4326008)(76116006)(6916009)(66946007)(316002)(91956017)(64756008)(66446008)(8936002)(5660300002)(66476007)(186003)(26005)(6512007)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t0sreBH/aCf41BjwwS67jcVvyysfhUX+jH0d9WpU69gwajvxD0Kg7sbCbD7l?=
 =?us-ascii?Q?92n9AtXlwpcxgzNOiRyio3BDEVjo+5ZbSRdL+NdBlElqd/s+8Jb2LGxaLx7u?=
 =?us-ascii?Q?U3ZWN5gkufEmFa7NbJIwTDehJWJTXEhBrL9mqTMqHQEbVSQglZFJ2mcUAgzB?=
 =?us-ascii?Q?b4RZbYB2SvghKa8Q0F3sl4yFl37RjsuJXgM3SBija4hPLlGEjHnwt5gWvJtk?=
 =?us-ascii?Q?/uAyEGxLAUNBhnX4S8eVEpwvEJ48JlHDl3hq9B0nVznRSB4Io2ZSWAJrC3Vy?=
 =?us-ascii?Q?sf1cXRcTyhl2biGD4FoASsNtdg+yQkp0sfs8P1wb2yvCgOagO/fn6Pzm26jj?=
 =?us-ascii?Q?5tS6v4bQMLHGZQMv89zHmVL7HCtp99eiMeWvYqqOkXZ4i40NJ1HnJ5NXyC+J?=
 =?us-ascii?Q?zQMmywTO3aA0wbSUkwmglPM+zZycrl/khIQMF2gkcN9awkhXPKuGFz4PUua6?=
 =?us-ascii?Q?mhKAzMrfEzloxqTMC0HH4BF6ErBLWkJT/L+EFEbxD8sxPTByVJkUARqTiVm8?=
 =?us-ascii?Q?RbnUqGWThYnlvLt07Gg1HgWJRSsFDrmCc9QAOB8BOCt/iRu7Gof6Lr90QLfx?=
 =?us-ascii?Q?ToagbBwc1aj6FdGgZCvxqsCyKGb4PWA7v6ppjls6bO3BXsbIh3F/a2eIzdbw?=
 =?us-ascii?Q?ootuDwhaUxLgQXBjQJmuZUNQELD6BLgzLyWKSojxmSHnMZiR/qmIjuMrI77/?=
 =?us-ascii?Q?1PTyhdGY0d2KPh+90+5ukGJCdhM8Q+LKBa9aB4Cfjyd3085X2/YzwgYCmOBT?=
 =?us-ascii?Q?IBLWNdGm7Yu3NrykQgXesgynQiM/q5oVJosMtoklZqboJ9RbafsXyrv6nA7I?=
 =?us-ascii?Q?rsrw2XofGaI4JvIU7t/P/3/zu+sJpK7UJDrRmXPnRvpC/jCDATH7F9xUk4hC?=
 =?us-ascii?Q?VBUXU7K4R9+88M632AGN7PqoAQRLWts/jGshizcGpR92DldklhbnfySeUaSr?=
 =?us-ascii?Q?oqI+x0xdogPY3jGvaaogPi4U3UOHBeGgNAD0hNPq2cfNa63kOrBs2kr3YPS2?=
 =?us-ascii?Q?OVRmMbyBZrRXYxHajibbFbw0E3vGTUzvOck4m0qE4Pl3opUrXn3OJlFfxoWX?=
 =?us-ascii?Q?H25FFN///69VrEGaq1XHfUbIsrHX1fs93NUM2ztCPxDU/uW+wlArTnNKOREk?=
 =?us-ascii?Q?eQGe3uhk0W1hyXiFI4ma6Abvu3feWVWXwICNNeGvL+YrKMh9kIY7Fn9g1xD6?=
 =?us-ascii?Q?rpQIARgfrY0UGh3FUJ3f9HTUsYNgF8cK7REMrtw3o2vrylyDFsAmFYKPRX1h?=
 =?us-ascii?Q?xCxHelfMJaL7ObaUHEP03huG3MLP2G8M4GwNGJS/u4G//016xoLXeDykYYw7?=
 =?us-ascii?Q?AqYnQZQ1E/lwcCSlOqe+daP5GopCQGTlcOtXo8TQRc24RnKe1CGZMoZqgzUE?=
 =?us-ascii?Q?nYg6oHrAZZO4Xt0fBCwrePEeRD9X+9Q8+byw1z0r7T1oISo61dYFo5Yzd3Vx?=
 =?us-ascii?Q?qyy1FKUWqO+JXoZmVfbpgXae3Be+vbDew7T6YbMklJbvuhRya/34E7Z2DQN1?=
 =?us-ascii?Q?c2B7hv6CPsrjCIeO4kNZ0qP/+A1mHi5Fkn4OkfJ08bKNiGlmfQpbmkbKKMYD?=
 =?us-ascii?Q?+bqa8WyY9d9mJIpGdiZyaHNmWlA5C/Mz0mwL4uPKtkdxKo/203kYXJDb3TX7?=
 =?us-ascii?Q?tA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32B69CE11B369C44B546BC509DE403B9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TiVklrYQ+SXC5LbG9aAWkQxDF69/J0RwBTZyL9pP83Pnx4hUXzns8vPSQZiQJ6D7imlCoNVZwiiaFSqyeEMCuJ27nyyUG+k1qFD9+azcBMAMyQbDQvf9NaRq1YDVDRq2xsfQS4MKvwnVLYOUAabmqC/ctfNLeTf76Y8y/vkt/Y2prFU+M1hLjmX8R+/Y2OmNBF/Kfg/Mf6Z5vdR4AD3dLraNwMszkNiLS5z3F7zIoNNaM4l3tJiYbtbJLVBpyNkylU9aCcVd6Ljfe9pCveFfkEZIGa5aViMvJbU19QOtMQqvTIjsiRg6RvxDmIjcgfusMpOuJXnfa450E7e776NUsAPHphdh4GGTgN2PGnr0FqXLfki7lcUrbaVxvQ2XJKLPdr6XGVFqvM9yqXjePItkDtV6zlinXQY91vY9YZas88UAQdWCmpzWJ5umZ5ldl2SeUW6f3lOpcZR5CCljpyJT7N8fTUbj0fPouau93Gw4XKoIaV1ZR/EKboWaWXg/iwEvRph/tYiBN8/cEexNgPI+1u2m37pYYL1eDMiCtuljMPfdGK7Mr8A0miVKl0KRdDxjhZbzyxnoMd13buE9iW8Z13y6z237t7nRfUfrORNAc8+MHgMU56cVNVxg4vPgYqNCe/9Od4480zKVgGIuH54bSmLTbduyyM10i0H7kOYHs23CIqdmvYb/9x1TLsGH7vhqk0vqffP0U3i/VeknihfyaQVLEuajvyigMqchVd+UcNEK/0qjdihdK6mu+mc4nSkJq5oW8/anQqfpD7HybO7CPGnOpus7KhMNh2y3+n875SwWVDna2Rhkoqw7XEzSpjdUbGf/8W/YZ+8VE6c5tGXVAw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea967712-f9bb-4bed-d7bf-08db0219cf90
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2023 16:56:48.2402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ikugt7z0nKwQaxtKdcTUA3RvjyZBX2qbuthMpx9UYhCzlyKd8hHVZWQF0vUqBspqZaYU7ZLjp08Pv5RHEppzVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301290167
X-Proofpoint-ORIG-GUID: Ypd1uT6BfA_AzY1wfx773EVPCMVH6R7W
X-Proofpoint-GUID: Ypd1uT6BfA_AzY1wfx773EVPCMVH6R7W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 28, 2023, at 10:20 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Sat, 2023-01-28 at 14:15 +0000, Chuck Lever III wrote:
>> [ Cc'ing the original author of this code. ]
>>=20
>> Proposed patch is here:
>>=20
>> https://lore.kernel.org/linux-nfs/979eebe94ef380af6a5fdb831e78fd4c0946a5=
9e.1674836262.git.bcodding@redhat.com/
>>=20
>>> On Jan 28, 2023, at 8:47 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> On Sat, 2023-01-28 at 08:31 -0500, Benjamin Coddington wrote:
>>>> On 27 Jan 2023, at 13:03, Jeff Layton wrote:
>>>>=20
>>>>> On Fri, 2023-01-27 at 11:42 -0500, Benjamin Coddington wrote:
>>>>>> On 27 Jan 2023, at 11:34, Chuck Lever III wrote:
>>>>>>=20
>>>>>>>> On Jan 27, 2023, at 11:18 AM, Benjamin Coddington <bcodding@redhat=
.com> wrote:
>>>>>>>>=20
>>>>>>>> Its possible for __break_lease to find the layout's lease before w=
e've
>>>>>>>> added the layout to the owner's ls_layouts list.  In that case, se=
tting
>>>>>>>> ls_recalled =3D true without actually recalling the layout will ca=
use the
>>>>>>>> server to never send a recall callback.
>>>>>>>>=20
>>>>>>>> Move the check for ls_layouts before setting ls_recalled.
>>>>>>>>=20
>>>>>>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>>>>>>=20
>>>>>>> Did this start misbehaving recently, or has it always been broken?
>>>>>>> That is, does it need:
>>>>>>>=20
>>>>>>> Fixes: c5c707f96fc9 ("nfsd: implement pNFS layout recalls") ?
>>>>>>=20
>>>>>> I'm doing some new testing of racing LAYOUTGET and CB_LAYOUTRETURN a=
fter
>>>>>> running into a livelock, so I think it has always been broken and th=
e Fixes
>>>>>> tag is probably appropriate.
>>>>>>=20
>>>>>> However, now I'm wondering if we'd run into trouble if ls_layouts co=
uld be
>>>>>> empty but the lease still exist..  but that seems like it would be a
>>>>>> different bug.
>>>>>>=20
>>>>>=20
>>>>> Yeah, is that even possible? Surely once the last layout is gone, we
>>>>> drop the stateid? In any case, this patch looks fine. You can add:
>>>>>=20
>>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>>=20
>>>> Jeff pointed out that there's another problem here.  We can't just ski=
p
>>>> sending the callback if ls_layouts is empty, because then the process =
trying
>>>> to break the lease will end up spinning in __break_lease.
>>>>=20
>>>> I think we can drop the list_empty() check altogether - it must be the=
re so
>>>> that we don't race in and send a callback for a layout that's already =
been
>>>> returned, but I don't see any harm in that.  Clients should just retur=
n
>>>> NO_MATCHING_LAYOUT.
>>>>=20
>>>=20
>>> The bigger worry (AFAICS) is that there is a potential race between
>>> LAYOUTGET and CB_LAYOUTRECALL:
>>>=20
>>> The lease is set very early in the LAYOUTGET process, and it can be
>>> broken at any time beyond that point, even before LAYOUTGET is done and
>>> has populated the ls_layouts list. If __break_lease gets called before
>>> the list is populated, then the recall won't be sent (because ls_layout=
s
>>> is still empty), but the LAYOUTGET will still complete successfully.
>>>=20
>>> I think we need a check at the end of nfsd4_layoutget, after the
>>> nfsd4_insert_layout call to see whether the lease has been broken. If i=
t
>>> has, then we should unwind everything and return NFS4ERR_RECALLCONFLICT=
.
>>=20
>> Shall I drop this fix from nfsd-next, then?
>>=20
>=20
> No, I think Ben's fix is still valid. The problem I'm seeing is a
> different issue in the same area of the code. A follow-on patch to
> address that is appropriate.

Thanks for clarifying... I wasn't sure whether y'all were planning
a replacement patch or an addendum. Sounds like the latter, so I'll
leave Ben's fix on the queue.


--
Chuck Lever



