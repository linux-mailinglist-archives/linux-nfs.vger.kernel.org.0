Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4C774D888
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 16:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjGJOHV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 10:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjGJOGq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 10:06:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7351A1;
        Mon, 10 Jul 2023 07:06:28 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ACdLcu024146;
        Mon, 10 Jul 2023 14:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8kQ704NnEqAooMObod4rhFSxI8b/DRXBKzN+cVltnJs=;
 b=IKY902yshobBbHRLA+u6NyW9LraYmSh2LDcgHGPklDAM6dJctNARcczM1Xcjh6UZzQKw
 wcU7hSs24AK7frdGnor2ApEyGTVrCLh0wNOjCrtsn5ziwk5hmxIRLU2pQ/dnbQo720u9
 QOsPiws5nuq4qYeLitqo2DuswPqvQVO0tbkG0Bo4K5+v/h5PX5vOnm0tECHCQl6ycP7F
 uGPJwdCV9LqmWDjz+UocYO1UNcDU88+kbV+nGOMSJJwc7SlgbHIWO4JpQWm7be7z+SuA
 LkGnKIoPeX8PGFIBvStGTNiy9XvDuwyx4sAP4gtPFJanlaZZkd3VizJL+5kwyXu4Xt88 jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpyud2nnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 14:06:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36ADqj1n016046;
        Mon, 10 Jul 2023 14:06:18 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8410dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 14:06:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zq0cTVd+QqG5iOGh4v4bAUJNtjktFQn34I4U3N2qrkQZubj50oU2npW+0qXLwS9AbJHnr+0RYOmjr11/HYdj1z4jUOW8SZ8tkQZ4ucmIVTAY2K9KPonTBLVLyaeNC222SagJ661yeDRsqpnoPrLEcHrT57457xDx0Jxjt8Fj5UeIJ6PFsfJQPEVyV26SohcGr8spPuDuxn8mb3LfXUfICdHySuO+cWpN0Ocqk7sXJcVky0l605I4pDde2HJzV/+a01jcHeCyogzfbw2X496nqfXmPAEociI+8b4zc6L9wYXjaRwoLNTUxcK3mVR34WAGDVKN7ASd4mvYBPC87l5yxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kQ704NnEqAooMObod4rhFSxI8b/DRXBKzN+cVltnJs=;
 b=azXM+bNH2VyUiAfOmRPe2XNbskFhlRrnWvVsphuT0LeMxQ4YiBXMNPSTXW+Yai1Mbc3O5fAe/v/31w7do7d9SxmeNjZO3f0vHq8EK/t4cORWpUVjtVohN8VuROBDvWGuq47JvJZGoVHoK5kOl6y0d9JeDiJepScVaiFPbIQmNoNp+qvy8doTCKMRkOudPwX1wYdzqW02Gh9zp/UVlVJ9ac1mh/yRcG7lCtKQ6qPQ5lx3s3wuB2AJkIj9BXcAx7oL29/Appu4ItoYdIo8WIbD9CHzKG9gP5oAr171UDPZ+hSCW1yluObO0x36NfoRTnVE8okyh2dxGHomiocFjBoIag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kQ704NnEqAooMObod4rhFSxI8b/DRXBKzN+cVltnJs=;
 b=Eb8j4wjRTWkdEXAO6i+iD7No2boXG8iRwRSunRcWLfmN4mKo7vCnVMdFKsC18gcSVkKqiJIY60xmSlwToR3pgGTgNZR2JiscwaeUrbkLh43GSzYENSRPdCje/oKkdrzxw/cX/PoJQa08ik5T+g2reo26R8mG/BKl3XMZTMcdjpQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB7490.namprd10.prod.outlook.com (2603:10b6:208:47d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 14:06:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7%3]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 14:06:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <cel@kernel.org>
Subject: Re: NFS workload leaves nfsd threads in D state
Thread-Topic: NFS workload leaves nfsd threads in D state
Thread-Index: AQHZscpE2u3hRnymrkaAkGCGMx38d6+ypIIAgABnPoA=
Date:   Mon, 10 Jul 2023 14:06:16 +0000
Message-ID: <3F16A14B-F854-41CC-A3CA-87C7946FC277@oracle.com>
References: <7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com>
 <20230710075634.GA30120@lst.de>
In-Reply-To: <20230710075634.GA30120@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN6PR10MB7490:EE_
x-ms-office365-filtering-correlation-id: 99453a7a-1ab8-42db-3ca7-08db814ed3a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TJnUnyDgWoyN0fbMPahqZmSPzgnt2Lk4QxJl/4lmeY9EaUnj1ZXsFNtwUIeu+NdaX0MMXVuMIdOnGC4Q0HXcXxN/LYkLmLyW0ERm6tSEZsGOe8srPR2AGsfLKxbVQqPBDriMvCwWAJqKdXLatm+JLs4Hv50N5IB0hMlGdRjjYVFfmdclDqxUJk3U9n+okhIPyGmo8LdhQRDWlAMpG/clYtq94TfZnxawl6SF1tQDRS024EaxQ1XiyG5ZayOPY/Dsu6qh1VKGiMNpz9i4m9WRA2JhnisCpycah5o/E3JTAFqUoD0KSxp5UxAZHKP5p+BfUkLrqcn2QWgT5Z14JMzHqxLosMVNTDwhAKmhbtUB8k2IFw4Nget6dgET5pEtDuTS4lm6EqL86Ax9qzIjgG6UyzmTbMkEoFA4z8Z/ZGwehqYLORflgMTOnz3n330jSmamLhXUlZwxUtNRKdzGQrD0DKldBCFIhAf4BCof24yG0PrLyRhABk0tJHVkJotdeN90CtIBy8XngOBhRrCX+axj8+LPjGL6ciFN/5qbanU4fqU0eHW8iVsF73lOVLYRNgT4d6QnlsgYQhQQzTdqNFYjz+kMsTD0dEFQ0y4sql4yufxOVb/uQ1AT4hQ6gCHP6G2q7UEP+6scm3LJc75zrdh7Kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(186003)(53546011)(26005)(6506007)(2616005)(6512007)(83380400001)(41300700001)(4326008)(64756008)(66446008)(66476007)(2906002)(66556008)(316002)(5660300002)(8936002)(8676002)(6916009)(478600001)(66946007)(6486002)(76116006)(71200400001)(91956017)(54906003)(36756003)(33656002)(122000001)(38070700005)(38100700002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Et85M8VncqaMAFlq5cUqr+9WQPrcIgCHg6/xtE1ykAOzDfcCWs/TNXAgeP+h?=
 =?us-ascii?Q?t+U2WMrIMPw0CK8X/KFcZJNLYrb/Q9E/to1tG6PxSWMh4UddOpBo8mnKNuTB?=
 =?us-ascii?Q?VMFLfUC0BrWSnyPBPUJ6Y54HmIr171yTG4nby4mPNkulCIATQNupvthu8Sev?=
 =?us-ascii?Q?M+JivMsKSYljly4AUfGg3Z21sy9/KrW0vUAsP224ta+/J+Lio13vpDxVB+dn?=
 =?us-ascii?Q?CcF58+rU4uJUo20ujSBYELby/YzYN//6sM1L9sx9stSNczzkiZ2jt58hAmEh?=
 =?us-ascii?Q?/JCVLdO5M9sS78IoaRKm7PvBNsd3fpxEVm2RN1M54gO28wbqvQfNvdFUTowA?=
 =?us-ascii?Q?fjhbZ/sObGhJK3yuRfwCX4kD4usyjR+q8ciwZIe85ImYVLbMobNDoYNbdjkV?=
 =?us-ascii?Q?DOUoZ7Oie6eIiY+JC7JgvAGdFXGJdPoxTQRcWt2K22HicIKoCJ6YN5zXp7Q4?=
 =?us-ascii?Q?Au69eLFWT+lEmHis5CNXHMBVcdt6PblA/6Fqt9V/IhQIHYLC+3Js6G3sXXLS?=
 =?us-ascii?Q?t3xriqL/qaEJ7pzBLscbgZIc3EwGUJK6GEbH61R9UOCpBmiKcJRv6yGmGExr?=
 =?us-ascii?Q?AdWP/QpRcbrGvV5yd6maJ/583nFhMWVIiia+rg57F3mAzheS14cpm1Vhh7Ym?=
 =?us-ascii?Q?odHRs9y7ieerTiWQEzvF4mcvGOJanVZv1bNJEmCta4CO76HmJGX5Z+ON9YuT?=
 =?us-ascii?Q?ocOxXLSP1LZIfjfRbwD4z0HtlDnRAmYXEZVarYukTISmCbGquEZsbioUkqF/?=
 =?us-ascii?Q?2WagjoRdzVcpSuEVxZ9INXShAneRnNlsCO3iJiAmECs3imTVbUXPARivNwDV?=
 =?us-ascii?Q?WZwkOdlqBSmZhAfPp1eB2Juz+i94rFg0m5ug3JejpK9ZKgRNw1bDSusYD08I?=
 =?us-ascii?Q?prckJpSC/FLSqlzuRT6qVtvT0L16pLBGSInEFGN3UhV53WGCjbmyx2HmKztT?=
 =?us-ascii?Q?D3ykO1XhfdTfhMurx+Hc8ZqU5S1h6kVK0otUvdAf1tryBuaNk7BYzKF0u3K7?=
 =?us-ascii?Q?o9ppCaK0dzneZWhh6roy88gyuKjsFQ3V1XGtUMYuT0kHyGQiHsMn5QqEXYKk?=
 =?us-ascii?Q?+7WlIJ1dRrSVz6NTIjcbbxYYA3MRitpQZpoGiBVvBlG0GJrRFPZblFFzl/EB?=
 =?us-ascii?Q?w3w6CLLY2u6J/djJRK8vzVrGXSue1lEM4+St7GdElgPfUPnKSiphaiT3LaVx?=
 =?us-ascii?Q?WNz87hwZnhTEqiyWHCFd2coYa9XdMV3J/dWy6YNBwuvHEkHbs/piArPRY5XU?=
 =?us-ascii?Q?Dh6h4nvG0ZuSxIdfUfF3gAvMclkkyqU4xkvHD/t8La6GLuQVRRAFAXK3aHaX?=
 =?us-ascii?Q?wq83sC2JmYULjgaji4tlU5q9HXxB03kqLBaJyhPdAHzovcluYM68KAtqHh4h?=
 =?us-ascii?Q?PStnd+SiORp4rBsX4Jc53XuLdgLXK0L6K1Vw4y4cX8y9JTUwnLnXToOxKMsg?=
 =?us-ascii?Q?e8lo7sERH7yxhAvtTS8XoalYX+5wLqpfWa22e8iVKxCc1Vaiti2VbaQRQAXs?=
 =?us-ascii?Q?PD+fj9IWOb0WKWU24TfRYGZlLf1jibO8LgmJ6dw5YD8lGCUcjFSZ6N7BDO/L?=
 =?us-ascii?Q?X40eL4LdKfNv9QEUYoE1fF0ukgv5wAjrU1NUdhi4q2knDExb31JwzBM/jt9k?=
 =?us-ascii?Q?Ng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E6CF4FEFF321AB4BAFBB618FC7F1EB84@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VHqGhfYQmbH2GKzz7o3S6OKi5X6bW5ng3RnsmXVuk+dyHtRNEKu0L18eRdMW+3dNNMJXVrURgunpfR3SdOcR08EW3NB+zSmkoyzCVy+fzLuXDUJ22kEGIOMiEA0mHxwCDEdPyRa6AEFwnDPAe8jykkIv/6XCDwi2DcTlzwIJAbTolYR5J3f1mJHa4duyXD13Qe4WUCDTJ7dd2eTZLuFGb69CFSl2LAJC8vmzBp0i+T/3q/c1KpjPSNNOZAdKclpWIFqihDDr9TMCLMFz+NPOsTBL0qDngTIhKJkEWT4pKNC4WVAAJ/0K8aSXjE8XTkVJZ2ddTr45GghNK1QOBG7AfDeP9ebnWXblz2eWtGP28+YyRREXLGqH4X5TSlr2O7DxEs38WP0m77bWv/7OOqrAs3V30QA29LIzb/sAhc80mJBND4Ok0eyWviyMFTVYHE4TLi7+flqyAVq1rqO9obNY0yUXLP/q8/XIkUarRt4Tqv/glYG9tEtpsTm5rYkCvief9KyFpdRUUcsQnejZVNi80ghxruSct6gyVKXKON3BFlUK7jbHI52QbadMc1RN2bDqb21+lL2CoATmfuxjXP61lENmGn323XAvS3OWeaA1eIgzyxhqHuCItbO4TGaAmHSpKzPDQtw33gr0sXJAJBe8MStu7xp30gShMZ4cgkyslbusK2JzHBXXwP+CJnE2D8nU1SRlmqWNIRX7vVZ1VAx3/krdbFztfZXi78TiJiC6EHckCHyvoococPJQ5vEu3ogKJN+luKQRnWPFust1weptraoGzOI+2DPTLcoO6mNXY88u86T6RgsX73JJ8KZycu7bDF8JxHb1agp8zqKt031sDg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99453a7a-1ab8-42db-3ca7-08db814ed3a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 14:06:16.0730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zd5G36/StCOyLLSphrnEN7OH/A55WPvKg9+3vekb4t6gXbZxlvNN/6Y4oLZI6w1xZLTRNSg9E8aWvRG6wjZw1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7490
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=909
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100127
X-Proofpoint-ORIG-GUID: Udij08qHpg2EmUlHC5OjA4oSpDAgH4zY
X-Proofpoint-GUID: Udij08qHpg2EmUlHC5OjA4oSpDAgH4zY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jul 10, 2023, at 3:56 AM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> On Sat, Jul 08, 2023 at 06:30:26PM +0000, Chuck Lever III wrote:
>> Hi -
>>=20
>> I have a "standard" test of running the git regression suite with
>> many threads against an NFS mount. I found that with 6.5-rc, the
>> test stalled and several nfsd threads on the server were stuck
>> in D state.
>=20
> Can you paste the exact reproducer here?

It's a twisty little maze of scripts, but it does essentially this:

1. export a test filesystem on system B

2. mount that export on system A via NFS (I think I used NFSv4.1)

3. download the latest git tarball on system A

4. unpack the tarball on the test NFS mount on system A. umount / mount

5. "make -jN all docs" on system A, where N is nprocs. umount / mount

6. "make -jN test" on system A, where N is as in step 5.

(For "make test" to work, the mounted on dir on system A has to be
exactly the same for all steps).

My system A has 12 cores, and B has 4, fwiw. The network fabric
is InfiniBand, but I suspect that won't make much difference.

During step 6, the tests will slow down and then stop cold.
After another two minutes, on system B you'll start to see the
INFO splats about hung processes.

As an interesting side note, I have a btrfs filesystem on that same
mapper group and physical device. I'm not able to reproduce the problem
on that filesystem.


>> I can reproduce this stall 100% with both an xfs and an ext4
>> export, so I bisected with both, and both bisects landed on the
>> same commit:
>=20
>> On system 1: the exports are on top of /dev/mapper and reside on
>> an "INTEL SSDSC2BA400G3" SATA device.
>>=20
>> On system 2: the exports are on top of /dev/mapper and reside on
>> an "INTEL SSDSC2KB240G8" SATA device.
>>=20
>> System 1 was where I discovered the stall. System 2 is where I ran
>> the bisects.
>=20
> Ok. I'd be curious if this reproducers without either device mapper
> or on a non-SATA device.  If you have an easy way to run it in a VM
> that'd be great.  Otherwise I'll try to recreate it in various
> setups if you post the exact reproducer.

I have a way to test it on an xfs export backed by a pair of AIC
NVMe devices. Stand by.

--
Chuck Lever


