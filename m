Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEA4679F40
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jan 2023 17:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbjAXQzN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Jan 2023 11:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbjAXQzL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Jan 2023 11:55:11 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C3D46088
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 08:55:10 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OGNfB7027750;
        Tue, 24 Jan 2023 16:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=a1GBAbMb8y+8R3kKFA9H+qHNGNlfycqGcgPjwWzrAA0=;
 b=EjwjPUUkMsxnyxcnzoOkCjyl8USj7AxGtLMO7vOlx76vhowSXiZ9Om8l+xYMmmFCLcT8
 e7pcyfOoGRTZsuzMrtT+uhG6hq6oZ3Qmu0tLHbHjOWAvhwzIwf+YwgqH6mzRTd3CtW5U
 zW/0Ic4soac6jEGWOHEpVCdXODN7ngm3rpeshWijK0qucK62d8sDf1abZjOH4LLz1NFT
 H+PXyEerVgHqIfRaEYbvaU/mNReqrGcGdlmJetHvT921p0e4Sq2vq3vVMOYYcivZluF9
 h5jmv7kA3+qWmr1wz9GBRHvNOUAnfQTB7NGt9X4bfEeEPakKxW3GeryCn4f8pNTh6bmE MQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n883c5x7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 16:55:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OFhKZX025375;
        Tue, 24 Jan 2023 16:55:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g4pp46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 16:55:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ap7DgYugf46lVaYmgfZZ/8MNdu6VFnjB6cWAjeeDLxFvrkEU8dHm9q0DKrUC0ZG9VEMqmf6lkMyeoo7u2NUFF4QqcMkVHUWbVBdPWwn/7ukUXsMnypAid3Iuj7tZfRrAErowWp5g/f6/0XKyBj3QwTkWaiGL3XhyjMFl0ElzzQTDNPNaONA6zB5Yp+9v+0ciRSaYWSnPqf+tv19iOvY/utdQHwA6789CINOI8/noOsu6mQiFjaBNJPyIxR+uYT4NyQPtasqIG8boKRYuZT0YYMagjX+pLkQpkzkjSkSLggn1Q20kysMkjyw0a9bOzATfUU85pxR3wbZeThmNQc5BAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1GBAbMb8y+8R3kKFA9H+qHNGNlfycqGcgPjwWzrAA0=;
 b=karSfz3zhOo79hj/xTdoH/QRvdaEiw/94htg69+7l92Mfqe5q38bIcdsAxQxVVaONHlcY5kud/payQ+4eSQWo5YTyZDextp88Fj/d7plNp9EwpGQJ4oV0+j0y6KReD6ssJWAKg4S7ToJ4pAyHhKNKIpCm6Lwl52T9+ri3dfyTChP4vqVHeZ5EFI3k5lqhe8jNPMRUQU6x105mTo5g9WsiJpp9917/7SnzI/NfLqf8vP584pF5aJ2x6OZSzqn+mNHfeRX9eBgedvbIZFMtwpLdW8IFvLSrhRB1aG5hXo2IPn4MtwJ9BMbRQsc3mT2vINjw+aeu7YsevnRFn1v3Tw1EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1GBAbMb8y+8R3kKFA9H+qHNGNlfycqGcgPjwWzrAA0=;
 b=OSk959TSw1oodHMxYpTYcV8SfETIO1HkozegIrbbvcOT+P5r5rYJDmdX2R9WVvhSWFwslaiMuEI3deICzt7IApY2q4U22ws5RoK4JKQrYRTs8Xpya2SxKQDyb5AQEiUdsR4UPLcXaloQ4amEyBpfV6VQt4iR5ex3Imam2eQVDUA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6516.namprd10.prod.outlook.com (2603:10b6:930:5c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17; Tue, 24 Jan
 2023 16:54:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%4]) with mapi id 15.20.6043.017; Tue, 24 Jan 2023
 16:54:57 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix leak referent count of
 nfsd4_ssc_umount_item in nfsd4_copy
Thread-Topic: [PATCH 1/1] NFSD: fix leak referent count of
 nfsd4_ssc_umount_item in nfsd4_copy
Thread-Index: AQHZL7WG8jsGDCk4gUeNJkqn2SORI66tycKA
Date:   Tue, 24 Jan 2023 16:54:57 +0000
Message-ID: <75A8D1EC-EDFF-4632-B70E-4FC15EC87E1B@oracle.com>
References: <1674538453-12998-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1674538453-12998-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6516:EE_
x-ms-office365-filtering-correlation-id: 667106f2-bdf5-45e1-a208-08dafe2bb9ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6kBdP1nQoYy5FOPlRN4DK20AinTtIFsbJfDijAjYvNMbcSnqXzguNCFdU3ruE1MTu6M/qhxU3gYYZ1LVSDBd+/2x+iPFmt9T+3y0mzWnceqCCv4/1JkxTvjc8lcrhBVEdIK+w6YJI+3sqtWpQswOF2zBUSyHUKXOOYTT9cKPryCYwqZYTbGB1IR/revGvOciNJD1csYOGjPmGIdLQuz4yPRs59oYeMY0XYD6LiPZ0giaeO2T3i+9nPgQw7Cf5rK9cKqoHEqPlT0JCUh3gsVSYKgzu3HVjoeoK+PLyYh9LQP1m0jhcvKF3D/k97S6tCzzKHY+wNf+lAnO7j2bYRFZecq4d1vrNm/7cy/vhrT6PClQUEsmMQEzZKPxieJ2LGlT8q++xhazwMe9fdQD7JbMgU4NVvsqEJ6Mz94iwd/2zHlAvl2MSadRyIYiFDUWdkWMJuyrKn0Xl/2FWr+nuxO6mDfvYTnd4ts2iLS0jmk0RaH/uBnJ6GSUooqez/nuKaxtd+hdd8+G+RmCPwbzyynjWmwlGqACwUqZaKd2jUHUvfGslVxWl3K3iY47Wc0I4aZ3VEP55JLjbbu4iAGa541qiPd8+oBpJihxKgxSG3yco0zjdkTjdaDhqLbRyWiRxFkJfz10uQiIU8QlL6zti1RVnH7pR3CEjuwr3kr1x96AIW1ftBRFknqbQtO61ttHUtFM9zbp/coJgsmjmt6Vqbp1KYWppF6Zi8/cxFFWPokh2BU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199015)(36756003)(33656002)(86362001)(38070700005)(4326008)(91956017)(76116006)(8676002)(66946007)(66556008)(64756008)(66446008)(66476007)(41300700001)(8936002)(6862004)(316002)(71200400001)(6636002)(54906003)(37006003)(5660300002)(2906002)(38100700002)(122000001)(6506007)(26005)(6512007)(186003)(53546011)(478600001)(6486002)(83380400001)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?skoVGBBDuVu5UTyVH3IMeKa6bI+WDYctvkswkDopqbxbBvww0yw//Gp7Vxjj?=
 =?us-ascii?Q?ICXNO/6e7ImkFp4/BAOGc6n0szyLmQen//L/oOqMEYUoy90e3d+Q/Mmr0bad?=
 =?us-ascii?Q?KXysN5SFQLPLve3CRZ3A/wdFxYc3hhAYAiiUfjQ1zBur+jZM/KnrJ2bt3qNJ?=
 =?us-ascii?Q?3YrbGfxsx/Ss2Fw5yjb3nmcMj8wi0UBnuCYc171rBS3CKw9sYTgroZUxUaDh?=
 =?us-ascii?Q?i/QKgs9QaA+UO1wINgJwNibLO6BUMHDutzUrMHLwETFoV6pPZ6apGSMTNCzZ?=
 =?us-ascii?Q?rvpzq6pywCg4l7a8x3zi/pymB7yW6ZE99tEizgFVupfiQNQ7DVZcg3UldHuU?=
 =?us-ascii?Q?sgFFqSHVlIMEET9/02MXgShEZwRkR2oRLNVW8tJvIJm3hukib/HPU8Mk4NQ6?=
 =?us-ascii?Q?5C6rmkqEz1dK3ttPt3YKc0Z5viaaYi8t4mWgy62eh9o6R2ALVSNoJucpIeBV?=
 =?us-ascii?Q?k9bZNTKSBsvuJOP6mXIQzJgqNRFcBYjq1ptKufMGkk2OarhjLIsnBbRYiM6j?=
 =?us-ascii?Q?dZ2BP2W1AVqp97PDlHXcK4/uOjMT1xXlRuZqC8mpVjjSIHQyIPdVerHG595H?=
 =?us-ascii?Q?+obU+cksg6PToxGPmcYNHoPVCTyyGQgVny7WwA6rA3fxfhZDM/WJzVQKhFLZ?=
 =?us-ascii?Q?Kalm6AfntocRWY9EeekR28gPiK5p0t2khbcZt4Wuw8OogQPLznhuHnl5jOkx?=
 =?us-ascii?Q?u1z/pbtGdEENG+ba71Jfui7G4JqTEi9Ii5CD/BV9WBVIEhdn4+P7chRNMCL8?=
 =?us-ascii?Q?hYSIae4UKb9woDhQLaXGFi+mPPovNYLthCEOHAa+H1QF+m5orUQzIfE5pNtJ?=
 =?us-ascii?Q?0PB+jR5lbdFfIC25ERNPxfLF+qGNzMWi6OYjnavXki5IVM+FqskVNCvhxRVj?=
 =?us-ascii?Q?z1ML6T1gGOtlbkskSh3fAbFWQmfbVHlcFq93Q9H+p2B83LvO7rXUKXzARG2X?=
 =?us-ascii?Q?dthJZGnkc/cX+nqnuXLc5xVKRKzBrY6ZC57bRxJuHzThDDmQ/WpGHtZZ0CHP?=
 =?us-ascii?Q?K1fqT27zmdZ6Fi+2K5oMgtqei09Xp7NOk61rFhtO3MIzpx6p37PoaTDNaOHC?=
 =?us-ascii?Q?b7OuFi7ImOpzFjFV2l4kqDmVsbT6Dfiv3C6o/LoKoh2lG/xixTBxvWazx97O?=
 =?us-ascii?Q?VH7eZdJ0ZqzQHzA6AF61Msi65WqlzGcbQlJSzMpHWFXLsqLaJYmS95UUa3KZ?=
 =?us-ascii?Q?pLLJsZW4TR9iyRloglKFLZFowCDYG0lR+uTTVx2fPhUT+Zn05gJuwXzHGomY?=
 =?us-ascii?Q?p12rjP9v9hMBOyrYsHiBQia4yUJeINfhEECcRNG3lWKnxbEwznDbu0nMNPMP?=
 =?us-ascii?Q?tAwU1V2iYPfNda9bolSfCq3OKuP14LnXprNv1eg29ulBw2eUsBsc1qLzEamc?=
 =?us-ascii?Q?hKRxelk6Tvp0ohYeJyFO0Q3SiL485LpjsiO+TvDIEJ9+1mrcoiByQ16VfEvb?=
 =?us-ascii?Q?irCvHTtPzaSbMGo30ABDaxQPu8V1r2Gg1eCzxMOC3FVwmfll10zyISBTY+a4?=
 =?us-ascii?Q?Uh77Sb4TeANWWGG/fuvpe1N6PzSOhYNI2HHII24XpIXr4a/bS3kdhB0rXFd3?=
 =?us-ascii?Q?TX4HuT7mukBtZyso/zOFlqr/LVnZfaqZ7aD7gwzFIwjNbGzIFgWNszYy2D9C?=
 =?us-ascii?Q?ZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A6FA3E697A6D5E4CBFFE1AE973A2F329@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /3rOFFcdMEp78khVRo02W/8BV/YmLgnks/g0dUeHT1ekImADsS6ARta2wwb/YQYWI9oLhOG+veKTMOmaDJo8v6rCGdcIBk77eQI4QF7VrQzrUe8Kz4bZ5CSY2c7zeYe+AlvZfJD3sqpL+OTI/W/G7/jWC38N6cemgJm9eEOVkLBvlBZDwxeAksf9NOS7qNoIhdU3EaIIZEPmV+a+Hfsup9jCEjtC5nstTna4wQ3QE4L0jxnmnxX740YHbE0OV/DI+TGHFKEAeEqKpMVXaEAYoU6CkpxgoJ9t7Jc/O74whHFqw6Lom94rFl/WHBvNVf2qiyBfTbcpAJbKsEeTO/acXSXEITgVahpyvmo5ObLqNfIpThz56I2OZvy2ZXwn5gQWveSs8dy4jYPEtIff0uWQAM2NBeHTWduaaRADwSo7sB1aUlge015lk6n1HFmarlJ0ggbU9wVSnwnJ5g1Lkydvzo2h1QwB9z128pwUfVHBHcpSXodmP35C3LqZCI/LVTxMGowXQfrpuBZWL5rM68vbZ30yXs7YcD4TE+YJ/Rj/D8wrFZX2UEL4nLwKVRT5z3nlqdDddIw53wNaru9n7g6M0RCitNORnb6G3wOVwIyXE6slYmyWkl/u7Rs7WMm4nSjk+qyldWyhooRNIyTj8t5R98V0UEd0MdvORD+C9UMHlrnSrEM6eURwJodxJpsxYo2iSHjMA9x8zsWk94QAkpPRYVvhYgpYcgtkRoRGTgO8kLXNClESEYE4QFl/Vh7Kfcqe4I8LeuVLbavN2wY0TdGFtDn0BTCzhf/Qrm2LeX38Xhn6gckj4329XQSzTceY5f9Y
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667106f2-bdf5-45e1-a208-08dafe2bb9ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 16:54:57.8247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgU6NU8QKTyvc5bBASzNCX6hmubtfUXgi8Blok4lE15cPmn2q8xif5RF/Xxb4by1+szqSIhHOLb74SiYaDNqfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6516
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_13,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240154
X-Proofpoint-ORIG-GUID: SR_77RpR-ev_ILHnJNgt_iFRjcQ9raSX
X-Proofpoint-GUID: SR_77RpR-ev_ILHnJNgt_iFRjcQ9raSX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 24, 2023, at 12:34 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> The reference count of nfsd4_ssc_umount_item is not decremented
> on error conditions. This prevents the laundromat from unmounting
> the vfsmount of the source file.
>=20
> This patch decrements the reference count of nfsd4_ssc_umount_item
> on error.
>=20
> Fixes: f4e44b393389 ("NFSD: delay unmount source's export after inter-ser=
ver copy completed.")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

Applied to nfsd-next, thanks!


> ---
> fs/nfsd/nfs4proc.c | 12 ++++++++----
> 1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index b4e7e18e1761..889b603619c3 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1821,13 +1821,17 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> out:
> 	return status;
> out_err:
> +	if (nfsd4_ssc_is_inter(copy)) {
> +		/*
> +		 * Source's vfsmount of inter-copy will be unmounted
> +		 * by the laundromat. Use copy instead of async_copy
> +		 * since async_copy->ss_nsui might not be set yet.
> +	 	*/
> +		refcount_dec(&copy->ss_nsui->nsui_refcnt);
> +	}
> 	if (async_copy)
> 		cleanup_async_copy(async_copy);
> 	status =3D nfserrno(-ENOMEM);
> -	/*
> -	 * source's vfsmount of inter-copy will be unmounted
> -	 * by the laundromat
> -	 */
> 	goto out;
> }
>=20
> --=20
> 2.9.5
>=20

--
Chuck Lever



