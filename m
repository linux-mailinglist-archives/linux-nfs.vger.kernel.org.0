Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8440526585
	for <lists+linux-nfs@lfdr.de>; Fri, 13 May 2022 17:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381657AbiEMPBd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 May 2022 11:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381800AbiEMPBE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 May 2022 11:01:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9463E0CD
        for <linux-nfs@vger.kernel.org>; Fri, 13 May 2022 07:59:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DEduMA006333;
        Fri, 13 May 2022 14:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fr+YjQLPpr63RpfSoxJ0vqlyrtEzzf4pylNkZDkasoY=;
 b=RmME+fLr34c7xJYpckdcfgvVgx+yHHJSRUEX4iJnFvfxvGZz/HMBqr1s7AN3J4lGYBIC
 kG+fOXzZ2WIkTRu2NlD4cCtvwKQAWZ5ePNd+fEdoqiduS7y38clvWvIrWfLejxwKOZ8y
 sGQOFQeUWKrMN8ILjuCM3qeP1EfrWCSIGjaY7e6oIavjT6rF5ONllC12umwtCsDIQWqU
 1Luaya2TYks6i7zzh2ynJS4TzvOCB7JVkgTzlpeJ5bluZo5pe9fA8NQ/b5No6iHxmNIH
 JmYNBZPInJGgv3YDEmonTi5xzc/QNV8IYoe8V6OeS1kEAzplLuzW486zbtE2BQAc2wUG Tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6cfabh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 14:59:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24DEogUp017406;
        Fri, 13 May 2022 14:59:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf76g3ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 14:59:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2UwbJ+ALrj2JtKcpKEy00Zxp7N+545robStzF+UGQTicbLZPzS6fkkTNtj6bC6uxXxfPmTMHrMMwTWoEF3jUTu29du6HgvYt1ghOCIjuT8T3Cy5iCoHfSkWv4nU3ZoDRogl4WO9lXQmecfs/mMiJLPNkp6boUedog7mH67uv0BFAxIGYYLeHosqjbBvUvV/xPxrRFyIv/B2RhxNdb9ICtbMT0bmCDJcY0TgHV2V8HIwlOP9eP3TgGdLwd/8wnRuQP6p1Fzw/Hp6ZAuRbnSrZ8Caonxj9C/uOGVcT3AKFyyyt9mFwk+znVThPJNl/JZdAdJNf5xIcCjcmZkbWIpeTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr+YjQLPpr63RpfSoxJ0vqlyrtEzzf4pylNkZDkasoY=;
 b=KqS9p1oK8iSsG0P/zkF66cly+MGLMd7mYM5TrTAao1tRs6LfG6KsWQGcc9b8MPei8ss8BRFfo9xYIIKcC9TjNED6CFoDq2k/xny58f9qpxiDviyMhFRVHjk60+u1racpbPQjUc5/P77mGd7yREEF1TRR61VgyixRSGk8cnKkNUF7afisPk0m1pcOWTin7Cv6XiqUglrdTIHKDHFeXhfUTI7jAoilMg74m9i78JOeOx4c/Jx0KVmwOMW78w5A+zQNIQ+lcyPEF7G9l+6zBfcj3hSvvKjed2herd5EWIzvFIaUWas8qRuhrswTBXqDFtJ3DzwXC5lLJ2ybjgAruzLBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr+YjQLPpr63RpfSoxJ0vqlyrtEzzf4pylNkZDkasoY=;
 b=kcH/1LWMmwWzq14XnURStzfskgTAXo7tMeJedhiuXlZ9EvaOqjwkFuykJS40U1Df1N0HfUt30n8Zk8EuRhm2cgdXQuEA6A7Y/qnUJRs7hdUBZBpJ9gbgbyTlAvHxQ8P/eo7D+wTw41DaRBfB/82mrmXroMRLyyrAw+5GsLpAJFU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5173.namprd10.prod.outlook.com (2603:10b6:408:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 14:59:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%7]) with mapi id 15.20.5250.015; Fri, 13 May 2022
 14:59:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Olga Kornievskaia <aglo@umich.edu>,
        "dennis.dalessandro@cornelisnetworks.com" 
        <dennis.dalessandro@cornelisnetworks.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS regression between 5.17 and 5.18
Thread-Topic: NFS regression between 5.17 and 5.18
Thread-Index: AQHYWwCixuCyjj49XkSuf+bm0GIRX60Faq4AgAAMfoCAAERPAIAAApwAgAEchwCAAAwEAIAK/HiAgAroagCAABmggIAAGOOA
Date:   Fri, 13 May 2022 14:59:18 +0000
Message-ID: <9D98FE64-80FB-43B7-9B1C-D177F32D2814@oracle.com>
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
 <8E8485F8-F56F-4A93-85AC-44BD8436DF6A@oracle.com>
 <9d814666-6e95-e331-62a7-ec36fe1ca062@cornelisnetworks.com>
 <04edca2f-d54f-4c52-9877-978bf48208fb@cornelisnetworks.com>
 <ca84dc10f073284c9219808bb521201f246cf558.camel@hammerspace.com>
 <bb2c7dec-dc34-6a14-044d-b6487c9e1018@cornelisnetworks.com>
 <A04B2E88-9F29-4CF7-8ACB-1308100F1478@oracle.com>
 <46beb079-fb43-a9c1-d9a0-9b66d5a36163@cornelisnetworks.com>
 <9d3055f2-f751-71f4-1fc0-927817a07d99@cornelisnetworks.com>
 <b2691e39ec13cd2b0d4f5e844f4474c8b82a13c8.camel@hammerspace.com>
In-Reply-To: <b2691e39ec13cd2b0d4f5e844f4474c8b82a13c8.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c987144-a4a1-4828-123a-08da34f127e6
x-ms-traffictypediagnostic: BN0PR10MB5173:EE_
x-microsoft-antispam-prvs: <BN0PR10MB517335E89BBF0A810A65F81A93CA9@BN0PR10MB5173.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KFwMPYfYCnzj1Hs+Qp5HTiqmSp1BrurvgXCARuO3twgFQhUpg+2TU+xtQ7JLvr1LqYJ5AmS/xqCIu1YgykgDGV/lsYqmUWfGbngLrLUSlHFktsH+28oDkg0iB0ocPC+rlcIXFTomzVs4itogzwNIdAggTX2CJAtPE8egq9BtuP998jzsQyw2kk5cTX5JjtRwlksOCckcQnAihezFHu6TRSpbcaK9WqnQv4RGP1oaZxOYT7jk2CYqDsXiuPLn9CweMKgxDVw+lUngYRjqINqUgitov6SPJ3m8H5uLFHKkjTbk8561bEn8dDjgxSKqKTzn0FCD3KDKvxuNaM8lGQxOM6sk9oa77z7wdH4znoGnb9qKAlwF65KnQkR3qtS1o1kUHrU9/i9MzN4BNl8DcZ2SHq7s90KrjBq5sN3JU/WV38TN3kuidjUQZvj0DEm3hBMy20b4rMBagE0oL8BeqBcfnD9CBH1R2gAxIJWdaFOR9texnQc0q12N17OAoX4RtDCqgjPNoG90G4hzYcPolNabPN1MkP+gLisWtdOiqBeFNiIOEIo5+AssV7S5T2lG51OT6SF3uyfeC1Wx7m5GgvHx0X2bc2/rFvOZj8KvQ7O6rcSj8w7S7csGuGtJrsDLa8iPcgJH/uBE/LFEJC4XiBAuHNRBAELe3Wrr/fhlmTTy7gueah0Uevn6PdDbc/W9iiTLiM/BoOdp+PPCS+UBJ+rMtp1RNBlSoSKA2BViwnesRAfw8BBU+aeIzSEOEsrhW04f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(71200400001)(91956017)(53546011)(33656002)(8936002)(86362001)(64756008)(66946007)(66476007)(66556008)(66446008)(508600001)(8676002)(4326008)(6486002)(38100700002)(36756003)(6512007)(6506007)(26005)(38070700005)(83380400001)(316002)(2906002)(186003)(5660300002)(2616005)(6916009)(54906003)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?px8xJls5c91vQy2KBygc93lQb8UyozuPym38mNtJ1zGRgWj2QFYBeefNxgMw?=
 =?us-ascii?Q?im9wHnTmkNOS8x1P4jlJo2uvgPH1pSnE6CNTJn4RsU+Kyc9/s9KJxIxFn6YB?=
 =?us-ascii?Q?jiK+qnTEg2K7BlResprm74dbVg6/kl4rhJP1rj03SCLu1wEKvhwdNi+u9QAs?=
 =?us-ascii?Q?BGLGhR0aGvUNdEv16MzPywJ+AcjxvSiBgNAekDUMvnqSNrPueCz0xwPKEbuH?=
 =?us-ascii?Q?i01KueS2SVmNREDioC3vMjiTDjaqjZL1zUsF7f14EL6LzVKKFrL1DZEYvk2C?=
 =?us-ascii?Q?ATm+RVr+lgJf9GuLRGYs8xvqtTaYNkHamfaojfZuxwRmP05cUqk9Grut1rz5?=
 =?us-ascii?Q?Wdx+cQPvlxmTvPOAvM6VmQ5CJsj2Mc9qbI5fiXjyZ9sf9NEwa6fupEwGRUH0?=
 =?us-ascii?Q?qvIx5XcqY0WFyJXkSh2gOmUpMoPdoQlKsIsmkeoWItHz4NFi32fzoB3AaOZp?=
 =?us-ascii?Q?N7w9vA6W60fces0yB6QchN42E4VvH6Huhe7pjPmTiFMlK2G+QE4BSbLcM7Bw?=
 =?us-ascii?Q?9HZb9HRCdfjB9uxOhrv/e6hGWRTkaZ1pZ/o1m0ervaxs6UNDI/z+CEIwKOTq?=
 =?us-ascii?Q?hg4VislVbrnnfmI3bBs9aemNDUEyYutqer73sX3qUs+ylZwHMNDgXeEEkGmB?=
 =?us-ascii?Q?6iJFaVaQcC6NKZ4+624mndsPzJkmNS0yXf55FGqeSl8nT//jTJ64GO42KxUO?=
 =?us-ascii?Q?yTTKomgsvYrx+H5ayZ/n2Vv4CZkOoiLrlgLlIBeNdU1dAbLK39kbDvUrokBG?=
 =?us-ascii?Q?h/vypb/+hAn3spxOqd3ctRIFUfe7pQDpbUQ1IfMyXC0TvzFK8kbZCHmxG98M?=
 =?us-ascii?Q?rSwCoqD67OlB95+8+FCI3PfFN8u3UNUwycu7mMmwU6oOM1GzLeEg5BZF1mm3?=
 =?us-ascii?Q?3yIo24K0i40Si/r+WQvGwHK9KsVDIoXspxCpBitzf5VqEpKLy7JBYf0yRWoA?=
 =?us-ascii?Q?NIPUrE4E5/iSP1V4oF29JVxYPYtES3OUCn44UU/mVLGeWPFeKVRRX38hVbed?=
 =?us-ascii?Q?jFtAe4jUL8WCodK1ZfOcFUiul+AWPz3VkZmx+qNVf2DSDnOlBxXQdzHgO+Wx?=
 =?us-ascii?Q?vh9rMKZmkN6lv2BxQ2RCAL1BOwIwiK28sUtUWmJ8esEidpMKO6k7PvnfEt5l?=
 =?us-ascii?Q?fCUjEHSpWiEnsxJBKiukSCKZg+o0gsowFDFD0yxrOktNPq0gofdROKkKMaAv?=
 =?us-ascii?Q?b29Fk6Uw1DGZkOwykh1JsKrFK0VphJO9tXwwWWb0VNLhrC7u5Nab6ywA9j1l?=
 =?us-ascii?Q?Y78CZioCCYD5vgu0LhSqUXg5ZM4Etyaw4fMWNFBDHGBwlGgTsDoIXokz0LHt?=
 =?us-ascii?Q?6Ujdkg017nwgC7XIvGL89rNmMeIEP15A43OP3bM0ho4s79XoYU5rNmG3MxUT?=
 =?us-ascii?Q?AaLfISlaaiZK1FXtLw9CsU78T7yaIei4MRctZ62xCSCit+tvjwYomu5Sr83g?=
 =?us-ascii?Q?G8TRfko5nustRSxPTI+XHe9TrRiDuWkoqKv2OBngzIEf3wkfzBFZFO4EfWzj?=
 =?us-ascii?Q?NOJmfbxxVaOFmoVK60AlguaXnluaIMXWzmax6KDaP8vpaathCmUsgT4O7wRS?=
 =?us-ascii?Q?6wihmHbYsPYiCx50awdt3EwWBohorLK9v5gwt2m7MYEugEpGfCvbzCFsY0BJ?=
 =?us-ascii?Q?yn4YjsUIzHUCXyp3hxLZVJLuVJOQRp0vV/EsCMr921uSAchMqg8QgXiaX9u7?=
 =?us-ascii?Q?LznquxCc0by7gFOPNAbT8j9E0HZPBKcDi6RhfD8Gnbby8EjQNut0pfqUhSyq?=
 =?us-ascii?Q?VJe5xmR/qLDVLZupDm4ftqYJXBLS0bw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <44EAF79DD0D05F47976887710281D184@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c987144-a4a1-4828-123a-08da34f127e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 14:59:18.7029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X0ZYtRp5StOdkMG5MAcqWwgq9E3bY/hi8YPRuGD8+Hvpd92suPI4YU6itxHYHTIWvrb+cqV6qkeN8uT6Z1r3lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5173
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-13_04:2022-05-13,2022-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130066
X-Proofpoint-ORIG-GUID: yr7ucLd_2NcCyC9mpkZbrm1AdeHlyk2I
X-Proofpoint-GUID: yr7ucLd_2NcCyC9mpkZbrm1AdeHlyk2I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 13, 2022, at 9:30 AM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Fri, 2022-05-13 at 07:58 -0400, Dennis Dalessandro wrote:
>> On 5/6/22 9:24 AM, Dennis Dalessandro wrote:
>>> On 4/29/22 9:37 AM, Chuck Lever III wrote:
>>>>=20
>>>>=20
>>>>> On Apr 29, 2022, at 8:54 AM, Dennis Dalessandro
>>>>> <dennis.dalessandro@cornelisnetworks.com> wrote:
>>>>>=20
>>>>> On 4/28/22 3:56 PM, Trond Myklebust wrote:
>>>>>> On Thu, 2022-04-28 at 15:47 -0400, Dennis Dalessandro wrote:
>>>>>>> On 4/28/22 11:42 AM, Dennis Dalessandro wrote:
>>>>>>>> On 4/28/22 10:57 AM, Chuck Lever III wrote:
>>>>>>>>>> On Apr 28, 2022, at 9:05 AM, Dennis Dalessandro
>>>>>>>>>> <dennis.dalessandro@cornelisnetworks.com> wrote:
>>>>>>>>>>=20
>>>>>>>>>> Hi NFS folks,
>>>>>>>>>>=20
>>>>>>>>>> I've noticed a pretty nasty regression in our NFS
>>>>>>>>>> capability
>>>>>>>>>> between 5.17 and
>>>>>>>>>> 5.18-rc1. I've tried to bisect but not having any
>>>>>>>>>> luck. The
>>>>>>>>>> problem I'm seeing
>>>>>>>>>> is it takes 3 minutes to copy a file from NFS to the
>>>>>>>>>> local
>>>>>>>>>> disk. When it should
>>>>>>>>>> take less than half a second, which it did up through
>>>>>>>>>> 5.17.
>>>>>>>>>>=20
>>>>>>>>>> It doesn't seem to be network related, but can't rule
>>>>>>>>>> that out
>>>>>>>>>> completely.
>>>>>>>>>>=20
>>>>>>>>>> I tried to bisect but the problem can be
>>>>>>>>>> intermittent. Some
>>>>>>>>>> runs I'll see a
>>>>>>>>>> problem in 3 out of 100 cycles, sometimes 0 out of
>>>>>>>>>> 100.
>>>>>>>>>> Sometimes I'll see it
>>>>>>>>>> 100 out of 100.
>>>>>>>>>=20
>>>>>>>>> It's not clear from your problem report whether the
>>>>>>>>> problem
>>>>>>>>> appears
>>>>>>>>> when it's the server running v5.18-rc or the client.
>>>>>>>>=20
>>>>>>>> That's because I don't know which it is. I'll do a quick
>>>>>>>> test and
>>>>>>>> find out. I
>>>>>>>> was testing the same kernel across both nodes.
>>>>>>>=20
>>>>>>> Looks like it is the client.
>>>>>>>=20
>>>>>>> server  client  result
>>>>>>> ------  ------  ------
>>>>>>> 5.17    5.17    Pass
>>>>>>> 5.17    5.18    Fail
>>>>>>> 5.18    5.18    Fail
>>>>>>> 5.18    5.17    Pass
>>>>>>>=20
>>>>>>> Is there a patch for the client issue you mentioned that I
>>>>>>> could try?
>>>>>>>=20
>>>>>>> -Denny
>>>>>>=20
>>>>>> Try this one
>>>>>=20
>>>>> Thanks for the patch. Unfortunately it doesn't seem to solve
>>>>> the issue, still
>>>>> see intermittent hangs. I applied it on top of -rc4:
>>>>>=20
>>>>> copy /mnt/nfs_test/run_nfs_test.junk to
>>>>> /dev/shm/run_nfs_test.tmp...
>>>>>=20
>>>>> real    2m6.072s
>>>>> user    0m0.002s
>>>>> sys     0m0.263s
>>>>> Done
>>>>>=20
>>>>> While it was hung I checked the mem usage on the machine:
>>>>>=20
>>>>> # free -h
>>>>>              total        used        free      shared=20
>>>>> buff/cache   available
>>>>> Mem:           62Gi       871Mi        61Gi       342Mi     =20
>>>>> 889Mi        61Gi
>>>>> Swap:         4.0Gi          0B       4.0Gi
>>>>>=20
>>>>> Doesn't appear to be under memory pressure.
>>>>=20
>>>> Hi, since you know now that it is the client, perhaps a bisect
>>>> would be more successful?
>>>=20
>>> I've been testing all week. I pulled the nfs-rdma tree that was
>>> sent to Linus
>>> for 5.18 and tested. I see the problem on pretty much all the
>>> patches. However
>>> it's the frequency that it hits which changes.
>>>=20
>>> I'll see 1-5 cycles out of 2500 where the copy takes minutes up to:
>>> "NFS: Convert readdir page cache to use a cookie based index"
>>>=20
>>> After this I start seeing it around 10 times in 500 and by the last
>>> patch 10
>>> times in less than 100.
>>>=20
>>> Is there any kind of tracing/debugging I could turn on to get more
>>> insight on
>>> what is taking so long when it does go bad?
>>>=20
>>=20
>> Ran a test with -rc6 and this time see a hung task trace on the
>> console as well
>> as an NFS RPC error.
>>=20
>> [32719.991175] nfs: RPC call returned error 512
>> .
>> .
>> .
>> [32933.285126] INFO: task kworker/u145:23:886141 blocked for more
>> than 122 seconds.
>> [32933.293543]       Tainted: G S                5.18.0-rc6 #1
>> [32933.299869] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this
>> message.
>> [32933.308740] task:kworker/u145:23 state:D stack:    0 pid:886141
>> ppid:     2
>> flags:0x00004000
>> [32933.318321] Workqueue: rpciod rpc_async_schedule [sunrpc]
>> [32933.324524] Call Trace:
>> [32933.327347]  <TASK>
>> [32933.329785]  __schedule+0x3dd/0x970
>> [32933.333783]  schedule+0x41/0xa0
>> [32933.337388]  xprt_request_dequeue_xprt+0xd1/0x140 [sunrpc]
>> [32933.343639]  ? prepare_to_wait+0xd0/0xd0
>> [32933.348123]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
>> [32933.354183]  xprt_release+0x26/0x140 [sunrpc]
>> [32933.359168]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
>> [32933.365225]  rpc_release_resources_task+0xe/0x50 [sunrpc]
>> [32933.371381]  __rpc_execute+0x2c5/0x4e0 [sunrpc]
>> [32933.376564]  ? __switch_to_asm+0x42/0x70
>> [32933.381046]  ? finish_task_switch+0xb2/0x2c0
>> [32933.385918]  rpc_async_schedule+0x29/0x40 [sunrpc]
>> [32933.391391]  process_one_work+0x1c8/0x390
>> [32933.395975]  worker_thread+0x30/0x360
>> [32933.400162]  ? process_one_work+0x390/0x390
>> [32933.404931]  kthread+0xd9/0x100
>> [32933.408536]  ? kthread_complete_and_exit+0x20/0x20
>> [32933.413984]  ret_from_fork+0x22/0x30
>> [32933.418074]  </TASK>
>>=20
>> The call trace shows up again at 245, 368, and 491 seconds. Same
>> task, same trace.
>>=20
>>=20
>>=20
>>=20
>=20
> That's very helpful. The above trace suggests that the RDMA code is
> leaking a call to xprt_unpin_rqst().

IMHO this is unlikely to be related to the performance
regression -- none of this code has changed in the past 5
kernel releases. Could be a different issue, though.

As is often the case in these situations, the INFO trace
above happens long after the issue that caused the missing
unpin. So... unless Dennis has a reproducer that can trigger
the issue frequently, I don't think there's much that can
be extracted from that.

Also "nfs: RPC call returned error 512" suggests someone
hit ^C at some point. It's always possible that the
xprt_rdma_free() path is missing an unpin. But again,
that's not likely to be related to performance.


> From what I can see, rpcrdma_reply_handler() will always call
> xprt_pin_rqst(), and that call is required to be matched by a call to
> xprt_unpin_rqst() before the handler exits. However those calls to
> xprt_unpin_rqst() appear to be scattered around the code, and it is not
> at all obvious that the requirement is being fulfilled.

I don't think unpin is required before rpcrdma_reply_handler()
exits. It /is/ required after xprt_complete_rqst(), and
sometimes that call has to be deferred until the NIC is
fully done with the RPC's buffers. The NIC is often not
finished with the buffers in the Receive completion handler.


> Chuck, why does that code need to be so complex?

The overall goal is that the upper layer cannot be awoken
until the NIC has finished with the RPC's header and
payload buffers. These buffers are treated differently
depending on how the send path chose to marshal the RPC.

And, all of these are hot paths, so it's important to
ensure that we are waiting/context-switching as
infrequently as possible. We wake the upper layer waiter
during an RDMA completion to reduce context switching.
The first completion does not always mean there's nothing
left for the NIC to do.

Ignoring the server backchannel, there is a single unpin
in the "complete without error" case in
rpcrdma_complete_rqst().

There are three call sites for rpcrdma_complete_rqst:

1. rpcrdma_reply_done - called when no explicit invalidation
is needed and the Receive completion fired after the Send
completion.

2. rpcrdma_sendctx_done - called when no explicit invalidation
is needed and the Send completion fired after the Receive
completion.

3. frwr_wc_localinv_done - called when explicit invalidation
was needed and that invalidation has completed. SQ ordering
guarantees that the Send has also completed at this point,
so a separate wait for Send completion is not needed.

These are the points when the NIC has finished with all of
the memory resources associated with an RPC, so that's
when it is safe to wake the waiter and unpin the RPC.

--
Chuck Lever



