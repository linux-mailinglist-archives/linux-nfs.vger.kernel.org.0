Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074B45B4A35
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Sep 2022 23:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiIJV3p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 10 Sep 2022 17:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiIJV3E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 10 Sep 2022 17:29:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB4921E25
        for <linux-nfs@vger.kernel.org>; Sat, 10 Sep 2022 14:23:59 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28AFrrkD030639;
        Sat, 10 Sep 2022 21:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NGwBNU92Y/Ch8F3YNUmbXz+d/1/SIr1WpUWijdfpHc4=;
 b=bZ3NRCnYdPd/kmBSYZTGfEMzo5eIn/D6i7aQOqXzxmpaJY+fjUtI7RSUpHFXbQ5Z2bwS
 YDCWIWVFXS6XaTlkVJusCZTenmPUeaNv0QAaIhOrQK9gktgvw1Cf/41eoB67Z+uBQfjQ
 baRokXW96OozMA5kfiKb2LWYoVcvvKoH32vx5u1IPv9sF0ssqcHEJfHEhd5ZlFxO6SgH
 MWiKCGUBVa6v5/PUNSpPcTpSlXRD1R+6PRwqblvIBJb/pHjrC3UQ894b7jFIPHBCXYb5
 K7OYWh3ev820xbrbRPp+Np/0c21bIeHB57HaZRY0AX6AbzMWrQgprCFoXxJb9gAL+AmN Aw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jgk4t8tty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Sep 2022 21:21:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28AKUwkZ012432;
        Sat, 10 Sep 2022 21:21:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jgh115g6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Sep 2022 21:21:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJMw/h1GDJI9r2ciXL8FX33vL+RsBfHDJKJJuUIdWM7PL9iELNAuDXOqZvDfHtZ3mxuKnujKofFlNR+qdnQimi7Rdyt6ClYM7hxZ8BMJhXZVI87EDhxJ/zP/NDdOcebn0tBGG8ulLRaUOXATSvl6Wp2RGQ3FBY1LlCnU3Pketc2n/pRyMgtd0+nTDGyFtKWvqcYqWfENWWlo4RcEEf8md3p6xw7gCMfSSk4ft/5zRc6adVlNSe4t8ADIXmqvyCVR03jKNTeUrMj0vS1lruPHuE6QiJESLd9mXe0eh2syYEodcqrw9MI96igWOD/svya5q8/FotKueMP3JcsXxBKGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGwBNU92Y/Ch8F3YNUmbXz+d/1/SIr1WpUWijdfpHc4=;
 b=P/Iow3ZhCak6kiJS+S0lqtBIEkVy/JicL+8eFEm3VWx9fQgIP9j1DSoyhBCIPEfEewqm3z2alcJNTl6d8+B3Hx/dBhmHHCY2AME1nznUdvstuGnApmWpf37l7bbeaKT5Vp0uhgrutt4Jr9rcy6vnzUOlMMoqhJknr+RWLfIgrsUabPJ4uX4s0ixeBHGJ8gOkKuDGVCfSDfECfxR9sTyHn3JYyqduMEqV/WuMtKVMdICTy4GUHgU2APNJdXchl+mqE9S7viw8eatnzAHqOsTUKGLjRF7xmw30vukcJVBupFVsREJE1TdFnFjg0GygdnHZOJg5Xtef6N8iS5MfsQtq1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGwBNU92Y/Ch8F3YNUmbXz+d/1/SIr1WpUWijdfpHc4=;
 b=VBOIT7Wfp2JnziVNIA7MGG+ktNfDo9eR2ngTT+7WGCJq1FqCpkH+m505/Xg+XE3F2I8PfPk5AD0DWe67GvxdwuCj2IH3BKcyPLhX5Zcq9c2+Md1WLSi/ayx4PSDRx3M6d2O+bp7wabtfIYZu2YRLOnz73Q4vqSWYEwfCO7asnu4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4457.namprd10.prod.outlook.com (2603:10b6:806:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Sat, 10 Sep
 2022 21:21:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.022; Sat, 10 Sep 2022
 21:21:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Is this nfsd kernel oops known?
Thread-Topic: Is this nfsd kernel oops known?
Thread-Index: AQHYvJP9R6JamLcYaUyLf/owehh7vq3HuG2AgALiPACAAGl2gIAAWREAgAdmpICAAAw8AIAAo8KAgACEegCABUMMAIAAAf4A
Date:   Sat, 10 Sep 2022 21:21:11 +0000
Message-ID: <9D6CDF68-6B12-44DE-BC01-3BD0251E7F94@oracle.com>
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
 <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
 <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
 <D0A6E504-F2C2-4A5F-BC51-FD3D88A790F0@redhat.com>
 <CAN-5tyHYH7ODzmTK=Maa3NZOSxfcE0mfaWY11+n2htQpya869g@mail.gmail.com>
 <EE9C1D1C-AA5B-48BC-9E3A-8A4523456AEE@oracle.com>
 <25AF9743-A2A2-4AFE-9123-BAD3C8F17655@redhat.com> <Yxz+GhK7nWKcBLcI@ZenIV>
In-Reply-To: <Yxz+GhK7nWKcBLcI@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4457:EE_
x-ms-office365-filtering-correlation-id: 78f17cf9-272a-43c5-c543-08da937262d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3rSr8LvvLPCp8cAl6YKxz34yDy1iFhgX7tSxqErqnIwtBqDsMPJBB1A4UvhVCtbn4DbnXtwcOdJTZF+GmqBdpDxdDdzHJeY/NHinvgPlcQEpcwgSQdpx5vEPcYq+jrpQIYjgN+fVrEbL6w9Nxs/OtppHQ+zOByBYks3JNXakp+GKeWdj12XRX1fT92woeyAusDJqMU4rYodJaLtz/fddSwq75Xin9Unaao+lnQlSgGGJm2n5NrGmHZOs6WTzjKsEUY40FSdFwvNA9BidjF3g5HuFjpAmugbHZndUlbzvcOrtYdI8K5nuZQ7GgfT2JvwsRZ3E8OoVIBYPwnrsxRg/WEiOj51wz6BbgE8+3q3eUaFtulrWGPx5n6b5ydNQmMkSW962IM2+dXpbUILLFPxgSBdPjJBxEVKa0vvdTOGJ4XpEQdePbYi3ou6zb5CVpEdduAdqilkU0VSGtXJJUoeMx0p089ovIQzt60bV6F6ENWK1/2ZdUmf031dbFs1ZZZwByF6NCf7BF7WFD7I1ispVp2G6mHOzUYXnfN38E74u97jSrcOD9zPFsbXt6B7tkkIv+jf8r3CDl+9c8Suq4aNFouA383lh8Y/eN/RqcpNPSzXM6V3DoKrPa4gvNjk7AvAaHsymhiIBO4ETj6I76/KJYspTujClV/9S7od+R3MwVuAOLiHLua8YVmxZVVkv+Q0IWjaSZ02DfNlnsFlKjYaWnWW3qyX+a7/R2KhlbI7pPDuIKn2s1OLr0ruvH01HaHNBPOSqL5yDlj4ynr/EF2LTIqeArW9k5vO/wCuOJihGAwE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(39860400002)(136003)(346002)(6486002)(8676002)(66476007)(66446008)(64756008)(4326008)(66556008)(76116006)(66946007)(478600001)(41300700001)(71200400001)(91956017)(5660300002)(38070700005)(86362001)(8936002)(36756003)(6916009)(26005)(6512007)(316002)(38100700002)(186003)(2616005)(122000001)(53546011)(6506007)(54906003)(83380400001)(2906002)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QP7sQxZcDr8ZtP9st+Iht20D9lTM7MVnVdmQu0ppTKR6z54CyCpOmDGS4Aj0?=
 =?us-ascii?Q?oQSBH2hxMHNTdgxOtR9si1Pzpmg1BCOAaO7U0afUiS725S8BZjBOzLGDlfoi?=
 =?us-ascii?Q?N7DVRWdsJgMGtE9sF9fNrcZL9rJFzx6GDjAnihFoWbMd2OAuxvsihyMQdgzT?=
 =?us-ascii?Q?AqUBg/cNtCPOPq8p3WW3y+GD8Y25qRD/gNEOmps6Gc6acYpW+jpbI2yyrCq+?=
 =?us-ascii?Q?eC/9f+nXXxx377668X9etMPJxu2imUgq191+Jh/+cYyHIT+YxoYN5Mj6fTGJ?=
 =?us-ascii?Q?OLSoudVuYb78BymeirfoZdyEnb+lX34Nk0vwpWIm/b0BVZZeGq5JqGeeBuXQ?=
 =?us-ascii?Q?vx0ZR3T/+I72loZ7iayoW32JMpFmcbmLdmcXeSHZQ2nQdF5mO+8H6uAGbO36?=
 =?us-ascii?Q?tm3MlSczLmRMDX6d83MYhSMrlLjPcx5K0Jqbx2R9CSiRwlxjiWB0kwZWDvm2?=
 =?us-ascii?Q?H77CRrJWGdI5MzQGIFC/n/G65GwVASsAAUtZ0Ye1J/FMhoNo4YZ/qCmqR2Fj?=
 =?us-ascii?Q?FAZIl7Lxyi4+jdMeg0lyvhSUD6X9KWdm7EzBSf3Ram8IIZjut3kYT86Hiuox?=
 =?us-ascii?Q?dxOmLolc6gto5v4i2nXtnNTbXzLUqhWiNiz/91DT8l1bv80XgasEdxrDXWfR?=
 =?us-ascii?Q?rxLVxzSI48W4D+TOHyLQVZmJxuzzOhoylaROKRMfq8IqsiPRfZGm0YlW7yDN?=
 =?us-ascii?Q?htwTAEurMlVqIAR3bImNPmb0tPpbWU54WCVwPs0noxi/7vqr45P2Y0fTR0IS?=
 =?us-ascii?Q?53d+uuRUbqBsvNGTqdqcQEAM4R6C5MhRRhoEWaN97kErh/j01/rDfvo0VMfx?=
 =?us-ascii?Q?1dTOPJ+JSBJDQ7cNMdxCCNQ1jjlzgO0/XpoOCeby+Jy2CCUlgERJb7F8ZS1v?=
 =?us-ascii?Q?38I0wCtH2bc8Pn1RQWzZ62dgH83UY933AAGx02AE7852h7ZNqTekOEvbv1Lo?=
 =?us-ascii?Q?wNtb+q4aI7IiINJarRmWG8MnJCe1XH1AQIni8xGmZ+UTvNOUtfxP31qATN5V?=
 =?us-ascii?Q?VRLw2hxlDoOfGQsJxPheXBmd/i73LWpELNSXa3rtVsb9XkrX8eGf14CH0WDF?=
 =?us-ascii?Q?74WaAgrYnHHoYVQYdhcnK7tNXJiYKzvsQAiE9/iX/Ziav999a+YZ0dV2niyW?=
 =?us-ascii?Q?FfhM+owWOKG/m4Vm37QhD9CkQ5+9s6PeO186RzNXo0XcxixcjanwvlYRiNUt?=
 =?us-ascii?Q?2y1MSlbc/5QRvkZT8dNrFjXts7pLa4WmNnESpmIcONmNVq6eigIrKp8vjLUd?=
 =?us-ascii?Q?1DLRZtQqwACpBJ+EtPQUDsDNJJ3ICzWp56bzERqIoa96edehwtfWkuGWqONv?=
 =?us-ascii?Q?8Oyolg0Nr5jgXd19ChAZY43G06qtp10ukyjQesR9CftekdqdnTAdjCwgL8x6?=
 =?us-ascii?Q?ia4MXKtgYuHk5yWVvO60IXvL30l8+YHux2Hcb3n4DBfbWRnWzg7IvR48+WA8?=
 =?us-ascii?Q?mTt1cmC/8+pyJAymDUe3eYAavbWP2witFJC4bKccNVlapBut6Wz0GP/UrEhm?=
 =?us-ascii?Q?Ks9BG1VUd1vhmvWCfIJ9iSRlNoIIea2upPTnzlnNiviSH6rtG311v769W6gy?=
 =?us-ascii?Q?6dVIRK8Hx6vO0yD/X19IQKqsWno/6y9KHm+pxZSbOyKkqc5Rm+bq0l6U0amC?=
 =?us-ascii?Q?2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E418D1FAFED577429784B89EBBFB5AE5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f17cf9-272a-43c5-c543-08da937262d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2022 21:21:11.9725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l28KzFBLB7p3/ht3t/fXKCxQns+tJBTDEVEFwIiVFrhLCXQ8qwFVhuc37H/zD+0zMcdVjlr5qybWIn6rmxjclQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4457
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-10_10,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209100079
X-Proofpoint-ORIG-GUID: ltOz8Rnk0t6mL5cA1OFjVYUMHfMk1VNo
X-Proofpoint-GUID: ltOz8Rnk0t6mL5cA1OFjVYUMHfMk1VNo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 10, 2022, at 5:14 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> On Wed, Sep 07, 2022 at 08:52:46AM -0400, Benjamin Coddington wrote:
>> On 7 Sep 2022, at 0:58, Chuck Lever III wrote:
>>=20
>>>> On Sep 6, 2022, at 3:12 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>>>>=20
>>>> On Tue, Sep 6, 2022 at 2:28 PM Benjamin Coddington
>>>> <bcodding@redhat.com> wrote:
>>>>>=20
>>>>> On 1 Sep 2022, at 21:27, Olga Kornievskaia wrote:
>>>>>=20
>>>>>> Thanks Chuck. I first, based on a hunch, narrowed down that it's
>>>>>> coming from Al Viro's merge commit. Then I git bisected his
>>>>>> 32patches
>>>>>> to the following commit f0f6b614f83dbae99d283b7b12ab5dd2e04df979
>>>>>=20
>>>>> No crash for me after reverting
>>>>> f0f6b614f83dbae99d283b7b12ab5dd2e04df979.
>>>>=20
>>>> I second that. No crash after a revert here.
>>>=20
>>> I bisected the new xfstests failures to the same commit:
>>>=20
>>> f0f6b614f83dbae99d283b7b12ab5dd2e04df979 is the first bad commit
>>> commit f0f6b614f83dbae99d283b7b12ab5dd2e04df979
>>> Author: Al Viro <viro@zeniv.linux.org.uk>
>>> Date:   Thu Jun 23 17:21:37 2022 -0400
>>>=20
>>>    copy_page_to_iter(): don't split high-order page in case of
>>> ITER_PIPE
>>>=20
>>>    ... just shove it into one pipe_buffer.
>>>=20
>>>    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>>>=20
>>> lib/iov_iter.c | 21 ++++++---------------
>>> 1 file changed, 6 insertions(+), 15 deletions(-)
>>>=20
>>=20
>> I've been reliably reproducing this on generic/551 on xfs.  In the case
>> where it crashes, rqstp->rq_res.page_base is positive multiple of PAGE_S=
IZE
>> after getting set in nfsd_splice_actor(), and that with page_len overrun=
s
>> the 256 pages we have.
>>=20
>> With f0f6b614f83d reverted, rqstp->rq_res.page_base is always zero.
>>=20
>> After 47b7fcae419dc and f0f6b614f83d, buf->offset in nfsd_splice_actor c=
an
>> be a positive multiple of PAGE_SIZE, whereas before it was always just t=
he
>> offset into the page.
>>=20
>> Something like this might fix it up:
>>=20
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 9f486b788ed0..d62963f36f03 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -849,7 +849,7 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, stru=
ct
>> pipe_buffer *buf,
>>=20
>>        svc_rqst_replace_page(rqstp, buf->page);
>>        if (rqstp->rq_res.page_len =3D=3D 0)
>> -               rqstp->rq_res.page_base =3D buf->offset;
>> +               rqstp->rq_res.page_base =3D buf->offset % PAGE_SIZE;
>>        rqstp->rq_res.page_len +=3D sd->len;
>>        return sd->len;
>> }
>>=20
>> .. but we should check with Al about whether this needs to be fixed over=
 in
>> copy_page_to_iter_pipe(),  since I don't think pipe_buffer offset should=
 be
>> greater than PAGE_SIZE.
>>=20
>> Al, any thoughts?
>=20
> pipe_buffer offsets in general can be greater than PAGE_SIZE.  What's mor=
e,
> buffer *size* can be greater than PAGE_SIZE - it really can contain more
> than PAGE_SIZE worth of data.  In that case the page is a compound one, o=
f
> course.
>=20
> Regression is the combination of "splice from regular file to pipe hadn't
> produced that earlier, now it does" and "nfsd never needed to handle that=
".
>=20
> I don't believe that fix is correct.  *IF* you can't deal with compound
> page in sunrpc, you need a loop going by subpages in nfsd_splice_actor(),
> similar to one that used to be in copy_page_to_iter().  Could you try
> the following:
>=20
> nfsd_splice_actor(): handle compound pages
>=20
> pipe_buffer might refer to a compound page (and contain more than a PAGE_=
SIZE
> worth of data).  Theoretically it had been possible since way back, but
> nfsd_splice_actor() hadn't run into that until copy_page_to_iter() change=
.

It's also possible that recent simplifications I've done to the splice
read actor accidentally removed the ability to deal with compound pages.
You might want to review the commit history of nfsd_splice_actor() to
see if there is an historic version that would behave correctly with
the new copy_page_to_iter().

Is the need to deal with CompoundPage documented somewhere? If not,
perhaps nfsd_splice_actor() could mention it so that overzealous
maintainers don't break it again.


> Fortunately, the only thing that changes for compound pages is that we
> need to stuff each relevant subpage in and convert the offset into offset
> in the first subpage.
>=20
> Hopefully-fixes: f0f6b614f83d "copy_page_to_iter(): don't split high-orde=
r page in case of ITER_PIPE"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 9f486b788ed0..b16aed158ba6 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -846,10 +846,14 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, str=
uct pipe_buffer *buf,
> 		  struct splice_desc *sd)
> {
> 	struct svc_rqst *rqstp =3D sd->u.data;
> -
> -	svc_rqst_replace_page(rqstp, buf->page);
> -	if (rqstp->rq_res.page_len =3D=3D 0)
> -		rqstp->rq_res.page_base =3D buf->offset;
> +	struct page *page =3D buf->page;	// may be a compound one
> +	unsigned offset =3D buf->offset;
> +
> +	page +=3D offset / PAGE_SIZE;
> +	for (int i =3D sd->len; i > 0; i -=3D PAGE_SIZE)
> +		svc_rqst_replace_page(rqstp, page++);
> +	if (rqstp->rq_res.page_len =3D=3D 0)	// first call
> +		rqstp->rq_res.page_base =3D offset % PAGE_SIZE;
> 	rqstp->rq_res.page_len +=3D sd->len;
> 	return sd->len;
> }

--
Chuck Lever



