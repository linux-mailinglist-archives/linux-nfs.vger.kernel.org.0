Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4605AC53A
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Sep 2022 18:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiIDQDQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 4 Sep 2022 12:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbiIDQDJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 4 Sep 2022 12:03:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DDC399DB;
        Sun,  4 Sep 2022 09:02:49 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 284CUHjL004049;
        Sun, 4 Sep 2022 16:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=sJvZgWEsj5bvHrZogtLXt63CpaVGAkhv3TIxYvZqxHY=;
 b=yLxLVYrNVY2al9wT+9v53bAwNtksqhnfzdVu9q2uuHUqxZRjgz5mN4mT6NSwoJ64as4J
 mzxXewY4TYXfYy7c4+muSKWCS+7u8f73RbG+mM7Ury6bo5LdVha7m6ALm4N+JWqR6nJS
 vuoDS+6oFj2agssraYv9kYvTr+8KW6GZnK5+gUcFRds0jAiSmjQAgw/aOijlpBIhCZwu
 TY4zhqKeiYGdsM9qMOlkINKjWj5+7Qbm+0DiMa2vuWx8P+qcgC5bQyamei9GTcAnITU+
 6jCoB0ETL5FXg6WceD96jEq3hpka7CP6+p/YXwL2xGZdObVFje4hgaJtXElXaKkAauW5 BA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq29y33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 04 Sep 2022 16:02:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 284C0Vr0002885;
        Sun, 4 Sep 2022 16:02:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc0teyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 04 Sep 2022 16:02:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHMMT53ZE7Bxgom3+RsqBIXpOiCpVBMUU1/Rf2Dng0gHJroAJQB4iVDtEjKI3/MySU/75cjEHftF2iHZ/19KNsAfRjGUVjHlbwH/vzrsVKL912fBUL3SoHTIAw5JHVc7NX2YvI7YI/rNrH3zCrfVgSK4HaWBjG8Ff3WO7B3OlAt9DRQrjg6cc604v/C+NqKtvlZXJx4ZwKAuA3plg1+XqlAJkdqW1kEGqWbUXL28lQWVHV0YeoS1xEax1ZTjAip9Ek7Puso8lFnl/ZVTm9L84vRggjUZh9LVCWZbXPJDRvGj2KfHKqA4wZxPBgMEScYyC9oiQXiA0jqUWhvlFPHjew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJvZgWEsj5bvHrZogtLXt63CpaVGAkhv3TIxYvZqxHY=;
 b=Rt0Gk2MQ+3kDb/5czyCxUX+4pSLTUoV4d3qqFwuHyKNqQ7/oj++gFisa16m2UHzaNkyDvqwpNPU4NEwNIRi6r/PQ0VzzNIMdylTKKceZDLm/93B30g5HMuwDhg114uEFf8n4VDVcIDyyQgEQCoKivcN5/QGPrzVmkA4ZiqoA5JsWMoVqAQ3v6AkXuHWmpRajskzVSM509vNIOeuLXlZO9aK9EwP2k5fNfYkgi5wMkEE/+nxd61J7Iv5nke4Qvu901NXhmDD14Rvl6/cDmYNtDX6M87st0IRliKStqfpkfje61s3eyGB8IUbhLhUfrEl81jaYUjfyMEY5vVNKLEINRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJvZgWEsj5bvHrZogtLXt63CpaVGAkhv3TIxYvZqxHY=;
 b=xrc0z09ehvH5U78mPrb+in2iAaC/KB7OOc6hXMCU0uADeS+Fjk39AfC3tRUUGxyCeUQGjItxwlRnPG1gYkHVyaUyrJzOeeE6PH2cjHFmvcIt0N7uzK/NdGpqFVSFxCZ32/teoh4YONaqiRnTmMiXJNdz7rptdxGmTvhEau72Yqk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5177.namprd10.prod.outlook.com (2603:10b6:610:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Sun, 4 Sep
 2022 16:02:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.017; Sun, 4 Sep 2022
 16:02:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "djwong@vger.kernel.org" <djwong@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: generic/650 makes v6.0-rc client unusable
Thread-Topic: generic/650 makes v6.0-rc client unusable
Thread-Index: AQHYv8UPIvgoSU1RX0u5XzLtJ9lDJ63PQWGAgAAunIA=
Date:   Sun, 4 Sep 2022 16:02:44 +0000
Message-ID: <0AB3B4E6-3B0F-4F04-8618-A3257D820FAA@oracle.com>
References: <3E21DFEA-8DF7-484B-8122-D578BFF7F9E0@oracle.com>
 <20220904131553.bqdsfbfhmdpuujd3@zlang-mailbox>
In-Reply-To: <20220904131553.bqdsfbfhmdpuujd3@zlang-mailbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1085cbef-9b16-49c5-b871-08da8e8ee741
x-ms-traffictypediagnostic: CH0PR10MB5177:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IOxW7wo6aOgRmsm14y7nODkhx/Z9LLD3ks5mHxVvC646GQNxB06kYm36hOpL6+EVKO9skZj/SzXwdluLWeNKWJhUfbqprtk8bmtdVtTqxUywPrY6SM6YfgXMUfSYvwrMP3jRGZus5hjs5VpwpUmfz9UCJkk5gBH/Oj4MLQswZSL3OsRQxI7hcWrUpsZIT3Xtep9nLaqWIFB64x0xgbIvzKPJIGlVGemsh7w6+ezoyRLdRRlRIamlbe0pEXnbjA0Kw2GHUVuQOjC+JvbIvSzvof0gJu2bm02nzm2mvtTxxKznGweuUi/3aFbv07LBmErifYvKEx5iEju3JTXwYsvjUwVmqYK6oKUMzL9+92MJDM7zuY4+xCMoClvO0CQniHNU71kidRdYZ4mG0MjCIQCyy8yt7eV4QXxytDgaqvgEnRiCSixoDoeiONTeGylKhIOKbhmhTbzyMdnTZ8fNJV3PvLw/Oo8GN83RiOxdgeSLWPsebrbUAEqoOr8EVECH36dywuE62yFi0VWrXCegdLtmevA4kp7Tjyi3ew6EcWBywQW7KA7xmzXg3G/Dk/UKyeDwm39cRnRM5thCg6lFSJHsrq73J3SMUIDpcLTFv5Yk6hNzxUHuRzvIR3jXlSpiI1iXGviy4cY9DRoQSVU9co407XbM31eLlaJ0/4yrrgmshj9wGfMjNmiy5aAcS+4zHfyjY1DYj4HDerzKzlA/KUPfnJTyIgRWB6yfMXKfKIPTJFAGJE5DcPwREyBiiCDVTtUJIkJhhX+J4CvZyHMPl3Aq6rFDGPbekB7cMFrpFLiKTEhhPv9bCqIq94zfR+2W0b3bTrz5qdPUTMzCcY5CzDfJZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(136003)(39860400002)(396003)(346002)(2616005)(186003)(66446008)(8676002)(478600001)(4326008)(316002)(54906003)(6916009)(36756003)(64756008)(6486002)(76116006)(66476007)(66556008)(66946007)(91956017)(71200400001)(53546011)(33656002)(2906002)(122000001)(86362001)(6506007)(5660300002)(26005)(8936002)(41300700001)(6512007)(83380400001)(38100700002)(38070700005)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gR/9qPRueW+ZuddeJtfe3Q7dFXo/07dySfPjO5l+tkFnAr435EL2vINy0LXR?=
 =?us-ascii?Q?cHSZoBqpwy6uNnfIPnqcDQkt5X4i1WpHMmYKmwBsL6lfzgz1yMMFWHb/5N8R?=
 =?us-ascii?Q?D5lhAyvWBtUpxknHFPnQOkUsMFqUe3O3PQw96pmyyS8CZ68pKEgB0/ThR7wW?=
 =?us-ascii?Q?vx38BMff95nVmDp0l3Iw9KQ7oO8WWc1liSAfoThsqlZJWaJ/UYnTV6sWNGMe?=
 =?us-ascii?Q?pKoQUE7oyxocMdKO6KJkhmRinJvXNepEwDBhsq2UdRjDLxdkPYm3uLjNPBzw?=
 =?us-ascii?Q?eCi3SPdt99EKA2LkLbKAGctNvuyfit0kXEKvsu8Qz+EDJVXj95Jg3XnQT0Hq?=
 =?us-ascii?Q?osz8RQgEUxC7DQ1+xwHCdeXrexjXG9tXhy2KmxwEA6rK27NRr32KgHwoaOu1?=
 =?us-ascii?Q?bm9brEN+WoWMLW9BXvh1EK5QerSwNxHZgQgiyTha4J1wo7EiNR+avbZ5MXnh?=
 =?us-ascii?Q?v/+1FNJXqJDhC6C6Wcak3aZ8BsVZBwaDJZ0uXN5YoMWIAk1ymMwCdbmdo5Vq?=
 =?us-ascii?Q?/UPqjD3KWltPz0MzsKHLNOQFxpc81lAdp1qWx+ATOB8iVsUwdf7Q2BYOG0sJ?=
 =?us-ascii?Q?gwuR5Ze3E4jeb8gqoX1Av8yJvcf3aKRNFA+NYW4xf5yyx3GfkD5oi7T33qE5?=
 =?us-ascii?Q?sWllKDXyoH8bOrCLXaOf42WABD5MkP8Lt/z6IaDAO6JjXuVVKKpMFbWKihaR?=
 =?us-ascii?Q?MZ5wlzHKqFGfrNmeTfG0CiTtMG0i80oGhzV97lv/SPWuG7gB8RGZDLezduIt?=
 =?us-ascii?Q?2u8EeoQiDuWjq74lKRTRi8MkPBuI40UH5aK3akeLkm+ImyX4/lOoi6BYFvYD?=
 =?us-ascii?Q?VuB6xTPU+XPaNPzprpQTBXvlTUgfHZv8VyYKoj5G/xM2JIzfSbkUie4/bLw3?=
 =?us-ascii?Q?yQsrCo7OlsRK7Rv9wQhvexnMDsmnPbQsivSmZKPu4fO04ZDy1Ql8bA0dHMay?=
 =?us-ascii?Q?FPtnxhzEYkgdkLWJJcXeloe7as4iwyysEeGQm4HPiFk7Q/XQZuknn7IHePkG?=
 =?us-ascii?Q?QQg2e6VJYOmxUDoxRoYnIM8ZEatDVfB7vnS6v7ipyy/BB8fFQG2vCSnEEXZN?=
 =?us-ascii?Q?B+JaE7TS/Z8A7fetFExiO9Pzz40YjLumnIHDhs8N2BmgZhS6gsYmh0hpzHYZ?=
 =?us-ascii?Q?uqxnWws0c7SM5NT33h1kWVYP1yqpM56XCmnAj1KlprhJbQcAg6/MxfVnIKB4?=
 =?us-ascii?Q?CzSklg0gHIA5WiMrBV9l4zEXZHKKslYfZP9MHmcuiXYCR76e++BBWCBhIcWg?=
 =?us-ascii?Q?AMChMOeRb7CbbHXT6LVHHs/4lcOEBjJ5qPlXVp9CcfNk2+XbESPMrKcb8iE9?=
 =?us-ascii?Q?yUyhzfPJCgkcPNa/qr4D/6r1/5s1rzvTQtm0MKzS9Fz8qa/l9SqoYjAkLyST?=
 =?us-ascii?Q?2sb14czpcoS4YxFp7VsvO6IjnZ1wZvR0LYS/XpUCjUfqijwbSn5vknssrtz0?=
 =?us-ascii?Q?ZGL0BtHMePxqMH0VI/0M920m/JF+FO2+1l5uzmHWUSW7VDKEbznNkTnfxtt5?=
 =?us-ascii?Q?6wI96I72sRvLTkQ4j0/eS85y34h/qH8jMUsNYgscMJAO83uSIN4iyvJKWn0x?=
 =?us-ascii?Q?K4PunsshTPnnvRDlQbb/rLyCvamnvuwGGxYhNjYsWPohI6qkxHVKB2I07uso?=
 =?us-ascii?Q?iw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A0908AE75556A649BA776C7DF0285C17@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1085cbef-9b16-49c5-b871-08da8e8ee741
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2022 16:02:44.1884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m8D8GtFn3f3xiNmxQa24yGy+0DHVcz+sJXaxFcWFvNFN3RF4PlA+3Dd8OkKYyil+HF5r4XVxVf6XPOm+JnZlvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-04_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209040081
X-Proofpoint-GUID: pocGIbqku0MwAjqsvJO13QEgY5dAtFqh
X-Proofpoint-ORIG-GUID: pocGIbqku0MwAjqsvJO13QEgY5dAtFqh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

> On Sep 4, 2022, at 9:15 AM, Zorro Lang <zlang@redhat.com> wrote:
>=20
> On Sat, Sep 03, 2022 at 06:43:29PM +0000, Chuck Lever III wrote:
>> While investigating some of the other issues that have been
>> reported lately, I've found that my v6.0-rc3 NFS/TCP client
>> goes off the rails often (but not always) during generic/650.
>>=20
>> This is the test that runs a workload while offlining and
>> onlining CPUs. My test client has 12 physical cores.
>>=20
>> The test appears to start normally, but then after a bit
>> the NFS server workload drops to zero and the NFS mount
>> disappears. I can't run programs (sudo, for example) on
>> the client. Can't log in, even on the console. The console
>> has a constant stream of "can't rotate log: Input/Output
>> error" type messages.
>>=20
>> I haven't looked further into this yet. Actually I'm not
>> quite sure where to start looking.
>>=20
>> I recently switched this client from a local /home to an
>> NFS-mounted one, and that's where the xfstests are built
>> and run from, fwiw.
>=20
> If most of users complain generic/650, I'd like to exclude g/650 from the
> "auto" default run group. Any more points?

Well generic/650 was passing for me before v6.0-rc, and IMO
it is a tough but reasonable test, considering the ubiquitous
use of workqueues and other scheduling primitives in our
filesystems.

So I think I caught a real bug, but I need a couple more days
to work it out before deciding generic/650 is throwing false
negatives and is thus not worth running in the "auto" group.

I can't really say whether Ted's failing tests are the
result of an interaction with the GCE platform or the test
itself. Ie, his patch might be the right approach -- exclude
it based on the test platform.


--
Chuck Lever



