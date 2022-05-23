Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A134E531B15
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 22:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiEWTnT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 15:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiEWTlp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 15:41:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE84BE9
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 12:35:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NGpAA9020337;
        Mon, 23 May 2022 19:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=XcMAltO96nAjM/cZGLY6BuMFKHaTNqgS6qOup7EYxXA=;
 b=tRZZsijlE3DLhUB3Y0jcnofMt1wK4V1rZgxFVeU0uS6FXFcfcMHrgRqEdZ17PUA3z14W
 K3a8/UUYv3fKqGmr7gdGghsCYGbjDdP4528YULmRs6lWW+i1LzyRmR0moMMDEbTnqRsr
 Cs6CSmSNFawgbfsEH2wCzqDiEYGxhth/s6Ll0jSTUiG0OYuJ5eN34Vc71Srysl+WOYqV
 9+A9qr8D3BlU4eEFpqAaqRqSKxGU50/21IExws73FPsvsCt+dXutiszpkKSgblUh0I9p
 fYw3bG2jroQJwuBWYNSxfZgTr9SHbSUb/zoMdRFiC9bmoig61WF8b5Mc6Jhf91E9nyUe xQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pv24j13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 19:35:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NJG6YZ010297;
        Mon, 23 May 2022 19:35:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph1nfv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 19:35:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/xOgg4D7ADZhLpEjMV4TqfVfiYm1EJchb+EPcib6Zsl1RvvCgPIJdQ3Ht4fPK4nn0q3iwScOdhGZHDoLZtDvAKbh9yvKbcVc8J8jO51UBf6RV/5V0j3IRVXnRc4/gxFf554qKlvCikJsuq45UhrKFMQoaGyySoEjFvw9w2RSZ8m+Wzu8pXXhnly4HtFgLbfmZ9PQSeOZ8MdNUW1t+9AMs99nj7qnq/iVIx+giC3I5QF4V/zHwk/PiKr7BJysiFAFtihx9id/0ubbVsg+KnEkAoVNYSTmaLBGFBjXv3IgNVyY+/nWokuAfRMQ8MYdsw0LoQCQuDBfp68ToswsaM1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcMAltO96nAjM/cZGLY6BuMFKHaTNqgS6qOup7EYxXA=;
 b=A8fozyF1FeyLYHalQK/iRkTLmBKugdl2xXfXAZAuTQ2TG3CvPXof/UzN7PEUuMCnUup0qvT4tX/tE9B7DpmR1fDFVhO148c6n17gpc5IdIL8cSGewoNHu+kP0PckDgpjwDm9WhQ5eD5Kfy5ueGcvnmRFGhntCWgCjA3lkYmW9XqmUtMK2g5qDm8EzxvBdeTr6Gav1HYNMhDqcJXjB2x/185/sYulu/IImJWuS0Wi/2tkGgFPy4LieBNaZNRguRHoL31SYexrs03uZ9sSENsNwJNZS8RRdyAcBIsycGxgzmK6rTcq0AT5EDlb4ALftURIp+/xsDFhPcwFHGeu3BN8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcMAltO96nAjM/cZGLY6BuMFKHaTNqgS6qOup7EYxXA=;
 b=y3IYYpLEUH6TVbi9turPG3BStODmsZiz6aWJhtklceH6Z8cUozjaSG2qZW5sDNhFFTTMoYod9kwdhpUMaCjyifB3EHuEnLvI+LVhruBysVrULkj549MMSRCxkZoX1qV2Im4ykEwXs+FSQKZ50Z89IsdBqW2B7d9hWqxtRKk/uwg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB3045.namprd10.prod.outlook.com (2603:10b6:a03:86::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 19:35:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 19:35:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
Thread-Topic: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
Thread-Index: AQHYbfIMzaj7dJY/skSZB97V0kxLh60seYcAgAAWLQCAAAdIAIAABFwAgAAPm4CAAA1wgIAAA7CAgAAgnwA=
Date:   Mon, 23 May 2022 19:35:45 +0000
Message-ID: <9D7CE6C9-579D-4DF3-9425-4CE0099E75E0@oracle.com>
References: <165323344948.2381.7808135229977810927.stgit@bazille.1015granger.net>
 <fe3f9ece807e1433631ee3e0bd6b78238305cb87.camel@kernel.org>
 <510282CB-38D3-438A-AF8A-9AC2519FCEF7@oracle.com>
 <c3d053dc36dd5e7dee1267f1c7107bbf911e4d53.camel@kernel.org>
 <1A37E2B5-8113-48D6-AF7C-5381F364D99E@oracle.com>
 <c357e63272de96f9e7595bf6688680879d83dc83.camel@kernel.org>
 <FF7F2939-C3DE-4584-BFFA-13B554706B9C@oracle.com>
 <f20de886f02402970c86c5195ea344de128afd91.camel@kernel.org>
In-Reply-To: <f20de886f02402970c86c5195ea344de128afd91.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40e9f98c-1c40-4b53-5f2d-08da3cf36e6d
x-ms-traffictypediagnostic: BYAPR10MB3045:EE_
x-microsoft-antispam-prvs: <BYAPR10MB3045DC6DC73FF378FE026B7493D49@BYAPR10MB3045.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nclk1LIx5qXGQ5lKcdHLM1MyfZidZ0kf6MmzWBbPJ7VkT0ZpJ2bWNyNENg2lHxGI4sbBe7+nR2iHfGWAheo5d7CLYcCDyUdwSzjYQkRWenAxAMGiBCM6cjNc2Ybx2et7qTB6hozro85Ykzos267Uifygd8W+ta8CvfQlepvMElCesgzzhTVj7fH0G77vnsiPn7bA7/4Gbt1/ehHKGQqVXwxeS0WSGg9n2SzbrpghDU2oVmvi57VsUkuTpWVjB9MLESkZ7dXZIZ70YfVBXYv/If/ElPaAsvmAVTXW1oFxZf10qyRESRFTNh7OZVzEg3SWOF/74TOZ1YiX8O3SBM8SNt0x10L/x538OGk14TMYqZjzfFTWtHWKQn1uaErIeaSrW6ifyniroPHnmvaBEFAnCk+t5gxImaHwSPWLBriVvUWXer8GAi0mRIxH+lG9Ucm9Gfu7uaCX+6moV7UFv65u5RocZuYJhmoWGeRGIBqD8hh0q44QKym1Ncmy8Gx6Rh4yPnqZMFGVGCQNfdYtjt3u72JNHml9smcXscwWaSK8PcTYZSrmB23+f/FUkCcCPKqvAV/POnE6dWlbtV2dKHtEZR7sDIeADnxjj8i0YYi3zgAjWlKtZjl4w3G9fjjcNn50oTQP0siQOZni4WSheCKS6cOamBqxHNvD8rTjtnxv0RX8Nk2u7Z+lWeb1L8TyL6h8RkCOZ8Vy0V/QNYLnZqMa/x197adzUZIaUyNoT99b08I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(33656002)(508600001)(2616005)(36756003)(316002)(6916009)(76116006)(66946007)(66446008)(2906002)(4326008)(6512007)(26005)(86362001)(4744005)(38070700005)(38100700002)(91956017)(66556008)(66476007)(6506007)(53546011)(122000001)(64756008)(8676002)(83380400001)(5660300002)(186003)(8936002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ymZovgXT/QwJK9E+TWMhxYjMQFZ/M4v+FkStJBonIY7ORledk3wUs7reJJfa?=
 =?us-ascii?Q?fE7V1gokW18dF0qrIfVWQ/JVeEqP91N4/6tFxB5ayHWbdEgzm94wUg10Hjbc?=
 =?us-ascii?Q?nhfs3VfX5zwTZoYrrddj178BSvYiebDatIFkUP/mAQDTonAGneqPATWJa/dw?=
 =?us-ascii?Q?KvRmlKmFyfn83eKsYjiUGBTMncuNKB7rGcNcpSZwQYtSaQTwE79WEtDpAW/l?=
 =?us-ascii?Q?7Fm6dM/hnMvJwj3v9HRzM7MqTA4Sqpnf54K2FszKi6k5UE72r9AhLwDxO6i8?=
 =?us-ascii?Q?BrEIySAPMeiva0aOSg6X95nMzAlldTwQGwBmpb/cdzytGb4Nu0ARhu2lA2Xy?=
 =?us-ascii?Q?D/7WGvSwDA++eq7jbVDzlKun83Nxd3DKV0Ohq6uxfQHiYXW0ymfROc4AM3yL?=
 =?us-ascii?Q?1ap+U4p4mq10mEf8TMKPxDsykELAmnIWBrzw08rdDbKq1JW5lBKa4hMFfR8G?=
 =?us-ascii?Q?pnPd9x/XEu0NnhiocZ3zk+OtQQaXR06oXd4XQUfw/I+7k1ge+VFksF8MdxW8?=
 =?us-ascii?Q?xHgrhJjcPZgg8hIsjqcBX8Pr5EA2wo5aFmDKtSjIzUoiyQ/X6evjqrZn6/fv?=
 =?us-ascii?Q?7k7Ec1Xnq+VClav6lIN76uLcaSV944aofbUQ0UwsUeSxBJVg7TWBZm4cNOUu?=
 =?us-ascii?Q?Hq0TySBpc3+TRIE1Uqomt8g4tcRkFq3yIBRRspCihDrAWO6fmVSJmhDBp6P9?=
 =?us-ascii?Q?Mag/mEeMi7HmD38yH72Y52oBPZHRQOzwLaIkFzTXzkf1fmO6NWhisZfJgDSX?=
 =?us-ascii?Q?Sk2cp9xNkkCd3oCf2H5j0uSJ+nX19dRpTJcTIGbMirHkUE2ee399Fd4qjM0l?=
 =?us-ascii?Q?7mlKtPmLyKK6zdnXgPB4Xo/0UmWPUZx8+i2MFHG8p/vNc6G3VYjDB2uGkaDe?=
 =?us-ascii?Q?E2rAOQfLvmZZXiKJU+TM3LfwpGfPr0DKtWq0/N/9rHluSg5WMhXFLoPt18Ry?=
 =?us-ascii?Q?NWv8Mn14M6HYclatWJF7vChttQbQ8t1YJgyr/rheU7bVM+Fd4VqpDOWOjm0Y?=
 =?us-ascii?Q?7d7rvPld36lXVDudgQmUAy5TSSJwxOFKnjRgC6g/wLQdw38+ZEiF9C8sUyW+?=
 =?us-ascii?Q?6c2kGSqZrXVFiB2oi2W2KjdpTLggrPzwH/l+G+cTv3WRdg3kpbC1spS/7t8K?=
 =?us-ascii?Q?JSUxFofhssNL0FxylkIBQRDFpbWpsmRy91n3rh/QMtzsrqIZhcDk7gHbendu?=
 =?us-ascii?Q?pVX6uV2O+r//unY1k1VCngOca0P+kz9C7vV7DlAF+3OWxbXwktgQhoAdITqq?=
 =?us-ascii?Q?0CrFEvGcPTP9HdOAZ7zDPcv3dwpv9ZMDn1kBF3AFgsvCrCUHOusC0s0m0tJJ?=
 =?us-ascii?Q?Tj+ejdxVpBsvO3bab91nhnrgYR6xTZg3grOTSXS318Q3eyCbfKOJcpm8W1LH?=
 =?us-ascii?Q?jXUlNm0VKy7411iNW29cKJMCe/UvUqEgTZWQIRVf76+d16VqYclQUWKbhFTm?=
 =?us-ascii?Q?v4z9hJzg4oKAOvcl49cRF8Zo3t3xAQNMjaXN1z7lB9ifcpbyMHvmxO5BJbW1?=
 =?us-ascii?Q?csfG0MhrP0oBUZ3j8PABZM0yvIxPIj3B9V6AJNOClN9+xDSbE2t8Uq5jk8mS?=
 =?us-ascii?Q?mvJNT7V16a5JocFptYVeovbdg4pm+GixnTgtU6ie9Xn6aKge4JvPzgJzWgav?=
 =?us-ascii?Q?YNjJhSErA7tfgT3XztRWaskdv3lzeD7aJLv7NIbZspaiac9hKFXELidXrbD6?=
 =?us-ascii?Q?Vi89Mg6BkK8PI1CD3f22/CPVk51tffUX/EmPjYyZ7V2rucye8f1B1XlTLgpq?=
 =?us-ascii?Q?qWaIuJ7kLyY9ht2w12VNHAOy05xlfFQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0B7120955BEF743B38BB880E108E674@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e9f98c-1c40-4b53-5f2d-08da3cf36e6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 19:35:45.3258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pb6NyF87I+vyTtNM6LhjeglVBzd2wbzDXnRyRLbUy0WfWEq7IVT/F32dlBgDKhPIZwe5h1yNWcgbzKgH5EeTXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3045
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_08:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230106
X-Proofpoint-GUID: nR5xHul7w5n8RzgyHKVr9Tb9IgGVZ4fu
X-Proofpoint-ORIG-GUID: nR5xHul7w5n8RzgyHKVr9Tb9IgGVZ4fu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 23, 2022, at 1:38 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-05-23 at 17:25 +0000, Chuck Lever III wrote:
>>=20
>>> On May 23, 2022, at 12:37 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> His suggestion was just to keep a counter in the lockowner of how many
>>> locks are associated with it. That seems like a good suggestion, though
>>> you'd probably need to add a parameter to lm_get_owner to indicate
>>> whether you were adding a new lock or just doing a conflock copy.
>>=20
>> locks_copy_conflock() would need to take a boolean parameter
>> that callers would set when they actually manipulate a lock.
>>=20
>=20
> Yep. You'd also have to add a bool arg to lm_put_owner so that you know
> whether you need to decrement the counter.

It's the lm_put_owner() side that looks less than straightforward.
Suggestions and advice welcome there.


--
Chuck Lever



