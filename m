Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19F854D143
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jun 2022 20:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358290AbiFOS5m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jun 2022 14:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358415AbiFOS5i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jun 2022 14:57:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49304192AB
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jun 2022 11:57:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FHXpI4022339;
        Wed, 15 Jun 2022 18:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gOLsDimKIXwX4cTsuit+pKQ1A98Sd/OqOJZZYpCaZSA=;
 b=UbAHq0WKmT+BHFcmNbIPV8JF/+cFfCi5pjNZfmPWfAUkjvqJjB/IPXSrn3P/TJCUG2dq
 7y+fblvJPtyJdH4BL5uXXfYMANyymtvumc3ZmeGczjcct1J9bOTeNI5MdKQkbW5lAtMo
 IODHus8jzXzw1E1B4uJq8SK1+vlg+GRl/A+mtdPWcC4DNxUVDRv5n4HZ4Jtn9NimivYN
 DQJspm8oHBLJGK2u5w/lE+KMp+GjzINiIpgVvKLvTBj03Wlr77LmqcPzLKeqcr14tr3j
 v+6RwzwAVvFhN5mvThsQaeTtzQZsCGhF2xTUf/JXS1QoJ8VHr6BrMRtEPG2Z7bOfeEUq eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhfcsbn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 18:57:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25FIuERl010222;
        Wed, 15 Jun 2022 18:57:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpr2ahc3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 18:57:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/kuCSERRu/z5HPko8Dre5h9dB4yun9V2WeRMNCjPhOR1RR5EZyxRfyyJtg3J+l8o3mOY7Cl+tYLWfPXwdok8HDI5bj2ErcGqdkrG2N7i785D+pZIn87L0vUbJVCXQQ97/DQcGGMSkwhqs+aRazFqGDYDkHN2RFyyc3up1lZOIfiGYJNr/W4aCdk7dLNovamVcDmxdN7Q8phWaK3LlMRxqHgLkhgF8LPWnilqACydXlz0MjYV+w6QNIhHVb+jVoy8KY35dD0a7SgE/9fVT0JxQT1WYNKtSdzMYoKYgcaJf4WCKFN3yMEQkpi0ThvFFIC1fsA/0lLufzvnHHxFXag0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOLsDimKIXwX4cTsuit+pKQ1A98Sd/OqOJZZYpCaZSA=;
 b=WtHKFGtG06rJqU+i/J6oS4BDNQAdAdPIMbEOHGiTmqf+Zyvk8xOF6W/SBLvehLUalQx2AZiIzTc+kV7C+9v2gUz8rcACVGsvMyb5aEwul+SU+x/C6QC4xH3GfdEHy+yErQY7dS3yk/Yag6GVcXaDt04l70/KhW+EzNvTi72cG/g06i5/P8LYBeM6E1106F7vCeKHZurtjhzGUjzRZowjSttPozxoTMv+ZusjMkxncgCW6LgtPY3H4PZiZO58zknzrqqvyvgzVINN4vHqU0tKmiv1745LjPeB8ARuk3gtAwBgjk65BMBBbDvGoKS6/9VoPPyFfzeEAD30SouLCVrfMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOLsDimKIXwX4cTsuit+pKQ1A98Sd/OqOJZZYpCaZSA=;
 b=g6EPMUM9SOGYSSPf2/NAdq6dw0ImooJFudI9zSIKEKAD9ziWnodcaLQWJ4aIypvm5BFDn6WVg+CZPqfqwnO56fJvVSVlCUX5Lc/J4kDJbOrh9aO/xAAbj4fhH7XS5rwGlnUED1zEYCybsCkZpNY0wyOa6517la19pKdmI5K2cAQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL0PR10MB3444.namprd10.prod.outlook.com (2603:10b6:208:73::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Wed, 15 Jun
 2022 18:57:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0%4]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 18:57:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RPC] nfsd: NFSv4 close a file completely
Thread-Topic: [RPC] nfsd: NFSv4 close a file completely
Thread-Index: AQHYfi1IwwfFdSiA302AZfT/YMJLJq1MFpUAgASGG4CAAAMIAIAAN3CA
Date:   Wed, 15 Jun 2022 18:57:28 +0000
Message-ID: <66105B5B-A0A4-4466-9BD6-0E68903BF7BA@oracle.com>
References: <20220612072253.66354-1-wangyugui@e16-tech.com>
 <0CBF71FB-7754-4992-BE16-A3CFD404DECC@oracle.com>
 <20220615232810.95CE.409509F4@e16-tech.com>
 <06C68349-C174-402B-A902-31A65BEFFB0B@oracle.com>
In-Reply-To: <06C68349-C174-402B-A902-31A65BEFFB0B@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b02ae5c6-db7c-4f0b-20b6-08da4f00e4e7
x-ms-traffictypediagnostic: BL0PR10MB3444:EE_
x-microsoft-antispam-prvs: <BL0PR10MB3444278E8184C8AE2B416A0E93AD9@BL0PR10MB3444.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HW7hqO9nSSePWQ5ZHD4mgIn3NZRA2tyuIjRWUNwtpQ4e8ZhZBpTdY+wXIUaJPDHgvh0LYrarN1VN6ZuEQPPLezX+YxSq1fW4hgjfcbj1spJcSTUXc6MCBIHA54zlZsCskf1HJdcQQI91fKge4zqBucamOQHdzq/fSpnowenDZopt5JD0nri19xRgqzbNb67drKOzl5aY+FVlY+y9us2Nlz8wg0Gu4xNpsaQ47ArAqznGhdlBuN23UgQkeuqIh5WbM7swtTKDhdOHp3RwG096yXpBzolFZ2QV8ScgZ6gWYwGkt5DVfcBxisQik7+o3/loXMtD2ifPHDGVPraE878xON/IXljxGtz/BYE3/UU4AGrtKpGBrSCkaqIk6RX90KTNpjUObzzJDkDkKnzYIjZcAvziTFLIGbhuGBm96bbm1yHU3JZIVS7sphaQP9PX54uCVUgUfiIczxrrxgfBkgYFMO+soLn1eMP0tUw5i1cuQf2X/WWzg0hAerxiEf2MbUUDwihAM49WjBEX8fYbM6aRd3ZkT/QUWjEcTc1G86qMDt4b2wAYTElRqhz2GbbmF4T1wnulH4nV2+z2Hk7GqJz4fv91ezHbno5trHIeqltCiDSd5qv0LXB1V0dvu+Zo2NChrhYlRRnKZUCHncpoAgXQbJwuPI/ncq6vN5QTslZNBQZZKE3O2S2iISXwgc3RyUuckWZNVpO26dAfXrJjUPIZGlJd5xnQeSzoJcTnm9FsjBQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(186003)(38100700002)(86362001)(2616005)(66446008)(66556008)(66476007)(76116006)(4326008)(64756008)(66946007)(38070700005)(36756003)(316002)(6916009)(71200400001)(8676002)(91956017)(33656002)(8936002)(5660300002)(508600001)(53546011)(6486002)(122000001)(6512007)(26005)(83380400001)(2906002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ETMFgDdEpcV0iY4QK/kyudEueximzGADtfV6rCO5HRw6chzGXYdMk4JhfQeV?=
 =?us-ascii?Q?Vu2+UFHAT//EzApLwASqzL8JZyx7UR5lgRg3i9Sa3y/cJgmqFQ8iFLemvvtH?=
 =?us-ascii?Q?49g847Xe0Ij0q9Hv+t6DheUb4KmUTp8m3VXdoX6jPu2ozkm0p1XJAp+Oc/Lo?=
 =?us-ascii?Q?D8cXw3Qj7vHyk2iF8SmOYZOSdm7iUnLYg3kIU3dU9hk4G5Bd9oJVrwPefmlj?=
 =?us-ascii?Q?31lwWRl25sbXZBKNArblVMfxzz/6C2uLBo1ckUMPAG9IcZ61wIwTUA8Z3mcx?=
 =?us-ascii?Q?IIkcJ/it9GXyxER/wKMClgcW8M79RRhs2WlMSV3qOCpfEKrsA4PKlwRmRw08?=
 =?us-ascii?Q?XzQz38YG9P700Qllg136cmBuN8XPMnwVgEn1gePU7qJWoKkCdVQGwplXxGPv?=
 =?us-ascii?Q?L0QCKBLNW5B3P08VU1oB+jYOWHYWUB0JuG3EyVULNqxR8UUXGZxwGC1r+ImC?=
 =?us-ascii?Q?2hruf2G/Q7DXh3tK7tij5d5aQyZB4ZaYQQcQpXO5tVwE/TaOqzqzvfkLdphN?=
 =?us-ascii?Q?9dPymIRfIjArv2dwwe5mJd6F44WMsBRMAf2Bd12LI6OjqMdkZV0haTWdR/TW?=
 =?us-ascii?Q?LILxFeehwCV0HPNDxQw4quVZPNzuJnMPa6vsmKy0A1MxC82d9Fhb4kT/7w9s?=
 =?us-ascii?Q?ATSR917uC/iVUL+s3wNxiBCU1tOhq9S1mDmhRvv6ZWm2awgAQptNI8sp0ghP?=
 =?us-ascii?Q?QZrkGFb5SLFgKIwqRtE/OWQxAyDiokFoJTZ1e+Cf3l9M/c7Ku25CkdV78XF0?=
 =?us-ascii?Q?gtaWSbQwieh7hlKhAYvNd8QUXuysaGQ9g2a27RIYIe20viD14I34EaAKCGU8?=
 =?us-ascii?Q?2dBha+FbK7WFGUytZ4IE4q9x56Ux85lkkselMWY5ejf1ufnO1+48JVcvxf2A?=
 =?us-ascii?Q?HJeO4DpoKLynndeujSPQMjVvp0mWhLhyHHcSAbvsQf5gPj0KVON1TM4FFJZr?=
 =?us-ascii?Q?4KqAqmNMTZznOOXXo/R2TwxxAWEy4xEcC14WwYDfwA8nm6JV3atQhinm6sho?=
 =?us-ascii?Q?tHCicCSUdajyyMa6DhjTgovGRXbvYIiGDS19p/IVU30xmpEQuby7qgz9bEK8?=
 =?us-ascii?Q?6qQZdBdfYpNDhhypkE03WodqeNTw3RyIjoFFPrkGYCUCioTDQuahcNBuU1Oh?=
 =?us-ascii?Q?/rMArWECs9rV32XjxG3c9RL1QFw6wYvENyO24jJati6Y/7wG0mDUYq9Cy5vh?=
 =?us-ascii?Q?lLaeeLeHmISlnbi1FCmBe/C6BFMgdbEWwPHwYRWPfZqjt/1u0z8y/isA+Zcq?=
 =?us-ascii?Q?lUZ9Ysz1uZ5hGA/u6hRAYgrcEfpsj9wigpFYnv2ov0e0Gbf7+83xlm3OAuBg?=
 =?us-ascii?Q?Q4snlUcZQpJKTbcQwAr8uweFGSWojPHRueq1kextG3qtPdJtU/W7TwS3kB/9?=
 =?us-ascii?Q?kIZWgA3DvYQCmjfNtWrD+bdSpzTRqmsVhiyr+7ZDaqtXFuu+vqJ9pk2ilLev?=
 =?us-ascii?Q?FyrQOUaen48fTU4wJVBw11yn60bZXZL2W42Unh9D1A3B3LMF+c7KarSqE6n9?=
 =?us-ascii?Q?+6GTqn3KrHkzXYb3R0kUgfOkEw176GuUJyHCnKrgS51eBPb+onhGM7XuInZd?=
 =?us-ascii?Q?cnpvlAlmmXPlx3eBdPRZi/jbhEEfJIUfpEuslGeCsMM7+xbAidIf73vBQNKU?=
 =?us-ascii?Q?MSwizfsE5NHrRw7tXHPMuXMdZq0PJ0nIhWAPN7ZaTsG2xgsgxAyEkldhIq5P?=
 =?us-ascii?Q?d1LEWf2Ow+zvo9O6Tl0/dZiWq7mkwgZfXryJd1xhrg9nz5oCQpzeXDHJuP4S?=
 =?us-ascii?Q?Y9eOERSupBX5M0Q9FWaMsd15uFfIek8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E111E57AFF622641B427D9B64D535CFB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02ae5c6-db7c-4f0b-20b6-08da4f00e4e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 18:57:28.4824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HpQdZa8dwzjUuLe1UyQLPqzkiUs856cDMY7EK5zbQDkPRQuSjZLbb5suZ/y9jMCmT8THodD+GTt9FwwwJT82og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3444
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_06:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206150071
X-Proofpoint-ORIG-GUID: NvR2c2mt3WWK1o707vk2TKwqQVS1xdw1
X-Proofpoint-GUID: NvR2c2mt3WWK1o707vk2TKwqQVS1xdw1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jun 15, 2022, at 11:39 AM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>=20
>> On Jun 15, 2022, at 11:28 AM, Wang Yugui <wangyugui@e16-tech.com> wrote:
>>=20
>> A question about the coming rhashtable.
>>=20
>> Now multiple nfsd export share a cache pool.
>>=20
>> In the coming rhashtable, a nfsd export could use a private cache pool
>> to improve scale out?
>=20
> That seems like a premature optimization. We don't know that the hashtabl=
e,
> under normal (ie, non-generic/531) workloads, is a scaling problem.
>=20
> However, I am considering (in the future) creating separate filecaches
> for each nfsd_net.

So I'm not rejecting your idea outright. To expand on this a little:

Just a single rhashtable will enable better scaling, and so will fixing
the LRU issues, and those are both in plan for my current set of fixes.
It's not clear to me that pathological workloads like generic/531 on
NFSv4 are common, so it's quite possible that just these two changes
will be enough for realistic workloads for the time being.

My near term goal for generic/531 is to prevent it from crashing NFSD.
Hopefully we can look at ways to enable that test to pass more often,
and fail gracefully when it doesn't pass. The issue is how the server
behaves when it can't open more files, which is somewhat separate from
the data structure efficiency issues you and Frank pointed out.

I'd like to get the above fixes ready for merge by the next window. So
I'm trying to narrow the changes in this set of fixes to make sure
they will be solid in a couple of months. It will be a heavier lift to
go from just one to two filecaches per server. After that, it will
likely be easier to go from two filecaches to multiple filecaches, but
I feel that's down the road.

In the medium term, supporting separate filecaches for NFSv3 and NFSv4
files is worth considering. NFSv3 nfsd_file items need to be managed
automatically and can be subject to a shrinker since there's no client
impact on releasing a cached filecache item.

NFSv4 nfsd_file items manage themselves (via OPEN/CLOSE) so an LRU isn't
really needed there (and isn't terribly effective anyway). A shrinker
can't easily release NFSv4 nfsd_file items without the server losing
state, and clients have to recover in that case.

And, it turns out that the current filecache capacity-limiting mechanism
forces NFSv3 items out of the filecache in favor of NFSv4 items when
the cache has more that NFSD_FILE_LRU_LIMIT items in it. IMO that's
obviously undesirable behavior for common mixed-version workloads.


--
Chuck Lever



