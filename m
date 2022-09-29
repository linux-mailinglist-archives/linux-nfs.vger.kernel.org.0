Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42EE5EFA55
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Sep 2022 18:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbiI2QYQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Sep 2022 12:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbiI2QX4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Sep 2022 12:23:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDB51E8035
        for <linux-nfs@vger.kernel.org>; Thu, 29 Sep 2022 09:21:27 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TG63eR010798;
        Thu, 29 Sep 2022 16:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=frcm93A02/Xm7q6iTz5jXOT6alDTJQ+QRAu4Y5FRnkc=;
 b=M9zdXEQey6gmdzJYdZ8uh1s9M48AaPXEgFcaWmGfnWUjC0OTVLN1M798QYH3cfwDkOiV
 T1GQjTx3cHw2eIfVtgk1dwLWuEnqSCy1XpoO56EXFzjRUpcXzHwOt61IptnIaWpCWoX5
 prowmxn8Qwy/e/clozzsjsI0v41+df4uM8efRE2B+lTbKGnhDsCu8POTDTQ0q/+N4mFm
 n7+216CPCMQPVIEmc9KmZJ0Anigha+BFN5xczJkZ72SjUC/5B+xHGjBHZfgBODXGdM4U
 SQ1jq3bDIzM15CRtsg8GkiLkaQiwddyorJbtjOwC6ezUyLuo5lV8ioBc+Is+cORiKcJh oQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jsstpvrrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 16:21:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28TFBulg033669;
        Thu, 29 Sep 2022 16:21:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpv2usfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 16:21:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYrfo3gNn7gGWb/AlVAc/4a8t4LPs9MQO84GTuiXgaMfFuqAcQCAeOSAxsybSMkGPfA6qSNQyeebGYOM3ccURlCJvwQHK0C7aB9j3FR4vPIzCo99nUHKzUi6pv/U2LthCV6WT6t3UsejWzRWeYei4ZIun9Yw9RoT3yCwdLVqgCjrE/xgQbLTfqmSc5r/UZutzWSjD7P/Kr/wwDSkw8kbhyjhRNn+zMDikYXcAN2wZJtsJEOglY3sFJJEdZrvMp4jT6v9jZe5pZN/2/DSrOWxFtY5OY0wH499WbHow8YC+V1tCk+FCyZ07uEp2Sch+9ViPJS//Jal40XsNCATwtAiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frcm93A02/Xm7q6iTz5jXOT6alDTJQ+QRAu4Y5FRnkc=;
 b=DlTgMSKtNocAx85wSr7QNMAa5LRS/2O2e/nyTvpTCimDHVlqDH8B1SIrel3BbMST5hs6K11r0DPIi6z1Q8osPs8U8PqQ8bNDwtZ3pqQUw39o65P3Br4euNIR5OEBLA52Z2LP/uUap4h2xclLPbn0C45JVceQkzyK/SdzqnrUrf17L5O+PBSICqmEeY1l31P0CVWFZhxKznCFkHBRveFh0yptLj8sNf2zo1xYyJvVkA2q4NL3KCKLjORTq3UpP5Bmk/4e95rAe+XeRlyPd4ilnxZvbR6X1spp3DkIXoe9w2EuUrXLGm9Xdp4MSO1sMycbr2J/q/bhrQnhDgugXQ5yrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frcm93A02/Xm7q6iTz5jXOT6alDTJQ+QRAu4Y5FRnkc=;
 b=DfBOWOTORyuOEOtKykJkPJhfTdehG0TEjNWvp5lL0jct903CJmm1KpclFjHUZi8wArMO7dAIBcZJMePDx3ElaM91tul0jln0wsXDmOocFFuwW3CD7kUSlJyBgVavGM36IHqO5bzbbOh4jk5WQ4ojrkRKw5f46BCcg2U/8p455UU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5761.namprd10.prod.outlook.com (2603:10b6:303:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Thu, 29 Sep
 2022 16:21:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 16:20:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH RFC 0/2] Replace file_hashtbl with an rhashtable
Thread-Topic: [PATCH RFC 0/2] Replace file_hashtbl with an rhashtable
Thread-Index: AQHY0pW9EBBNnAcXU0qinA0pUtnizq30o56AgAH2IAA=
Date:   Thu, 29 Sep 2022 16:20:59 +0000
Message-ID: <890D09EB-ADC7-468F-9E44-A62B38C53D70@oracle.com>
References: <166429914973.4564.115423416224540586.stgit@manet.1015granger.net>
 <0dad33838841ca01b1b47317919b4b4d2e59e5e4.camel@kernel.org>
In-Reply-To: <0dad33838841ca01b1b47317919b4b4d2e59e5e4.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW5PR10MB5761:EE_
x-ms-office365-filtering-correlation-id: 1ee918d8-1c33-44ef-17fd-08daa236983d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0VVrpR4rZsaB6icSNkGBqaO/7HFX1G2ifBJF3vR/cB8sQ0mZEUgZlXAsbUJX9Q/xpGhHsLtpJAjDJLIUo6LXZTFNFHL2Plva7cbf+oS6dNy6IKqyeVtdyXtIV3HlE8rxGkS1/vamt1QdWCuptOhtuUwx3sQLxFRpdbfzqg7qyzQM5d9nJ+bRo//PCyj6MXcuTHacX9Qz8BMpIEvJsPPRCkkYcdwvVBoVyAzaP1CufMtHcT2w4wrdhBMCazDg9H5Tfjfect2zEujru7gBa6PMwsobSoTpfIMieJ5Uig1Uxmd3vfweo33HefgN/v3HQLUlRN5YbejW+EDcSrI+9AQS4ZBm30Cvl+enqb4nb4V9m0DUVc6DA22S5oIE5LK6Ri185roMveSxNZG5LtiEKUQMP7pIC4jBXa6qFz8kOec0HgGw2LJ/c7S2R1YVMx+wLELThQo/QplCETuogSIDSUJ6KU6V6qfjpd+rf7NcK0+/F5xBBqD9/wZERF9SmYZhWYDWIYjf25BWjpXlWKpeB4vj3xXW3Vi7nfnfHt5da+u9bafZh8rBcGzrShfJLQk8HyfB0DcuYIxngYMcsGyzxjFgQ5DnHANqzE440FJJJXrLVGqMgXwArs7bCkVKVooN3GTW7iJZBMVgMz4HsqUuz0K9DbJe2bRpVQp7HkonIJUvi9KqctC9zFc0397QaKmC5MLjmGy6dys+awmX1ikyRtVMWtKd7zYa2TEHjalyD/VRLphlZYYfX+LnYTa0cpOCDNn7m9bKt3EGRogeSgQrdtKWwfldlKnI9QtnbX/Je0KL05M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199015)(54906003)(316002)(2616005)(8936002)(36756003)(6916009)(86362001)(66556008)(76116006)(64756008)(6486002)(66946007)(66476007)(91956017)(5660300002)(33656002)(8676002)(478600001)(71200400001)(41300700001)(2906002)(122000001)(6512007)(4326008)(26005)(6506007)(38070700005)(53546011)(38100700002)(66446008)(186003)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1j+iUhq/Ivy0g2QZIK9ktd+2Z6nNnNexNs20yJFr+TFProiP5A3VEm3km41H?=
 =?us-ascii?Q?Uq+zV1rOvWfncuqfBDdeAIrYkSzlIAUI1s49+Ho0yzLb8kWNKY24yN505u8R?=
 =?us-ascii?Q?1PrOHZmvCU9z94th8rRGBxnCaYb5d2t1/52/2ju0Ct0jpA0J26Oa8QncSRls?=
 =?us-ascii?Q?oGlKsmqHtfM3CPOU+/dVr8jxVipTN7lIY14+/ZZOmOCUTIK2Vsd2o7HDfdYI?=
 =?us-ascii?Q?QDDHJXq8cBjfGUDP1qNyWruCV+KU+7o11/JokKo4WyVIPTdnGE/jQFPSxBkE?=
 =?us-ascii?Q?LuI20H0Yq0xsVoECtKCX5v7xWfztLudm2GtNXmIkYOZvVDCEYCLwJKOwFuMM?=
 =?us-ascii?Q?4k9oxJq9aC5lbOzIxA7N3KG+KOPnbx8qUCXdk/CDrqu5CLjKVnjiyNwIvQKK?=
 =?us-ascii?Q?Cle0WDXLjmoQCJEytY3Sl3g+Ome5MUybX4wPRvr5PMZLayEjEPb6Oj2Z8g1r?=
 =?us-ascii?Q?yY3a4cvf4cT1z7ju5/zKzxL64nMLDYanvmK9+020r2RFs+j3+2Qkoi74igzz?=
 =?us-ascii?Q?IuUuwudlvUHKg4P37zs+KwgCP4uwmEnoufYMOiQes8g4NJlHnqj//+Lm1/dJ?=
 =?us-ascii?Q?O6MaHT5vAdhpCT3duOhsLN3kHFx9WpFFnHrk8VHsKcGeLEDyWzteAZv+O2YX?=
 =?us-ascii?Q?i8vMztDXgDbT75MuA9Zx4yU7zKMzXIWKQB5sTL+iFD8pKbG+4ejh81TxPSUk?=
 =?us-ascii?Q?znm1N+U6HKpcR98bGXx78c6RPj9WGQpSm2mq/qO/TS6zYpCxp2DwcgsKRRXr?=
 =?us-ascii?Q?pVtHIFux0pr7rqECaHv7LXqoVRMHOB4Ag/gKCdB5j7WH9V31mPReJvxkcC+K?=
 =?us-ascii?Q?YZRDJWHvku4Q8RaHqVO3YHeA1QUXrBHNrdlR6vOkvIpxZyhpW7JPtqvGsfwr?=
 =?us-ascii?Q?IC5yt7Qzopf9ggv1wT5DzYTASLx5ayswCyzLUIAIqvv9jvT06cyBtFCQ+QYa?=
 =?us-ascii?Q?7sYxXjBnNTVj2X00aC4AIRwnFyICzRq94akgo6AULDtQJECIvQ9p5kJUv1YS?=
 =?us-ascii?Q?/GZE9b4dqtWAKIjySm1f2d5khmUsNJ/9aa5Cds08xi59Kw5bztuQEUPT2QYO?=
 =?us-ascii?Q?5gKSZk77MiRACXyT6+RtqPaZh1pmATRvrdYDBIcg7VqzIoPUHOV9Q53BaQ86?=
 =?us-ascii?Q?5y7XRC92DkPwOFBT6st0ZlYUG/spg2TOQo65DczbvdWZUaZXxCgKPYGWFMh9?=
 =?us-ascii?Q?Mt9mS0HG6gMZZPQ1gDoXoVFrTNXkbCXcnctfKScDhEYaCHd09P0Zy7rvxL3n?=
 =?us-ascii?Q?0KeJqUKMFAIbORdxqfsyVyX18yc622XrQH/BG1LEuUTv+Pl2Cuh0M35FVKV1?=
 =?us-ascii?Q?qb+wijtjLhhEJWqNVq5L4+fIbkai6HQA0vVaJrSkDtpCvD/uY6VBTSBeec/t?=
 =?us-ascii?Q?3LZy5e7xOG/0e76LsnzqMr12adlibGO4SYLTHc+xWqYrH/eVV6FtXJ9Lng2j?=
 =?us-ascii?Q?bG5tspoBTGyRppDVAcT666QMzY15Py5zDu0oz/BnufEJ/V/AB+vrSIR8eEWl?=
 =?us-ascii?Q?83PLACVYsdzNlNul5cB1CZN+li1+qwzKDemRTtBXHGlgkIC/7IBgWTVmlllu?=
 =?us-ascii?Q?imHlGZiM+wFLoUKFJ2RJvuweqcWYRqhjyYdaLJpxGC/ix/kKIByzaGXDm1HI?=
 =?us-ascii?Q?Dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2761C0735303274188FEFF744BAC1BE0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee918d8-1c33-44ef-17fd-08daa236983d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 16:20:59.1795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0q3ZcSkMELC9YshhpcX0/YpvpnYuyD0dVN1QMtubH3nYZ08OQiygAOwKy0EFcHdxjShDLpvNAQ8gA+ymknY57g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209290102
X-Proofpoint-ORIG-GUID: jx0IhpEyU392t03LeHtZIQMyWIioGO03
X-Proofpoint-GUID: jx0IhpEyU392t03LeHtZIQMyWIioGO03
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 28, 2022, at 6:23 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2022-09-27 at 13:22 -0400, Chuck Lever wrote:
>> Hi, while testing I noticed that sometimes thousands of items are
>> inserted into file_hashtbl, but it's a small fixed-size hash. That
>> makes the buckets in file_hashtbl larger than two or three items.
>> The comparison function (fh_match) used while walking through the
>> buckets is expensive and cache-unfriendly.
>>=20
>> The following patches seem to help alleviate that overhead.
>>=20
>> ---
>>=20
>> Chuck Lever (2):
>>      NFSD: Use const pointers as parameters to fh_ helpers.
>>      NFSD: Use rhashtable for managing nfs4_file objects
>>=20
>>=20
>> fs/nfsd/nfs4state.c | 227 ++++++++++++++++++++++++++++++--------------
>> fs/nfsd/nfsfh.h     |  10 +-
>> fs/nfsd/state.h     |   5 +-
>> 3 files changed, 162 insertions(+), 80 deletions(-)
>>=20
>> --
>> Chuck Lever
>>=20
>=20
> This set all looks reasonable to me, and I like the idea of moving to
> rhashtable. You can add:
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks for having a look. I'm not sure I want to push these as soon
as v6.1, as they are quite fresh. That might increase the likelihood
of collisions when you work on cleaning up stateID reference counting.


--
Chuck Lever



