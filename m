Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1BD5371D0
	for <lists+linux-nfs@lfdr.de>; Sun, 29 May 2022 18:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiE2Q6U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 29 May 2022 12:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiE2Q6T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 29 May 2022 12:58:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A06B6B084
        for <linux-nfs@vger.kernel.org>; Sun, 29 May 2022 09:58:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24T8xirj032454;
        Sun, 29 May 2022 16:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tFlRPYhoinPslCAMZDARBv6+HRdgtAlaYx5XZW65zPw=;
 b=XwkuszXEefsX5EpEHnFg05ln78tgXEBzuqQyY7AFPdzXFy6eUJxQDOurDqCDH2gqYbdZ
 nZodl4Z8e12F1bF1jifY/0geAlBkz0hEVUFWX9Avor46KgQTdjO1+ceT3cXVw19Oweud
 KYaRDxO/fBP8sFSfFmYzcXhvvdzvls6cJCyiep41s/VZYy/AVGsl2QF56u4IKKeQsssD
 uPhyt9dA0HEM0uIAe8bIOf1m3xFAm4QJjvloLpGGFPwT8w5abb1qTOqu1meTDst3zX96
 pUS8PQutqS2KGBzlmknmg8gxYp9fe/1D5k217LKYvn7uhVW0UMfW5WwA0P0C2qRoE9TI +w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcahhjga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 May 2022 16:58:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24TGtRh2024218;
        Sun, 29 May 2022 16:58:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8kdbbr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 May 2022 16:58:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+N7lWv1XDQXILayBU3d4z3C6WhoHbn3joj/jMV8hPxpsUBUz8OP0X8MXDJCGac/T0nvhKXcT428z19z2v+azE4I+H8FZdFtcx47/GkMsot/fZb3rguqupga6VGylXPzP6S6ClXqbc6GdVYy9UISXqjUyNc5QcKfQP7TeL3OF+HtFVutDlp9dinMuIkcX4dFP0vK9foc1FKsOCkZpfH9YCYHHvktsNaH4yH+T46FHrIMEim/5uva8EHPBN6wFNW6bRQXZUCZhDmXS6J644ziX7rKjzwPg+EETKuaCWlQPqAKIu+pbLvXQC5fIdnyaoa/yx0z7juXPZ0L5dt4TftngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFlRPYhoinPslCAMZDARBv6+HRdgtAlaYx5XZW65zPw=;
 b=iBryM4riCCWwMtiWVKTrjdjV3H/bvaWkrfXp6rtp1B14FpZk9kEMILwm0R+U5LKhyQQ1O50yyUGbdYqtamdnyvbT7qHn6Jw6F8J+EqMsgNbXhIfygQnNidzuaDaoeZstSzmSjDKX8jZ99kXxSOxdzOn0ExI/cll7OiCEPZfP8oioWG/nxGZb/TDz2jhKd+Wh6b+iiMlHKcUhU0utJ99k60jnnfOtwZNCTL3Vtllj1rxWntm5OKtcNPMbdSxGxEoFwFGkMoA+Nmuet+2An++1iSIcttSfmz73teGL4AOMP8mxvCJj0FLZXbL3t6DL/91+h9x8u67N9PeCadSoDLDFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFlRPYhoinPslCAMZDARBv6+HRdgtAlaYx5XZW65zPw=;
 b=cQHM9wCeRUFVNOeRyOpA11jPcOfsiE6YAt0J+rWZDqz3AiYit5meYngrxu+NOhVfLvifphH7GwrzGyffZH7sKGyj94iQYN1ysmaP/6o9w7dmd/D3XmrVuzz1kcNKqQ/C7MOuZmxUdjCeHVcFWYjiKnMuIFNQWeF00pCA98meGRU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR10MB1642.namprd10.prod.outlook.com (2603:10b6:4:b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.17; Sun, 29 May 2022 16:58:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5293.019; Sun, 29 May 2022
 16:58:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
CC:     Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: filecache LRU performance regression
Thread-Topic: filecache LRU performance regression
Thread-Index: AQHYcfvwqM9TwnG0lkutiJn4EA8Bxq0zLyiAgAAP6gCAAeWYgIAA8egA
Date:   Sun, 29 May 2022 16:58:09 +0000
Message-ID: <69EAFC64-E5B1-450A-9DCE-695E478A213B@oracle.com>
References: <20220527203721.GA10628@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
 <ADD1751A-7F67-4729-BFFC-D6938CA963A0@oracle.com>
 <20220529103218.65DA.409509F4@e16-tech.com>
In-Reply-To: <20220529103218.65DA.409509F4@e16-tech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c97535c-f1bc-4ebd-cd1b-08da419468b7
x-ms-traffictypediagnostic: DM5PR10MB1642:EE_
x-microsoft-antispam-prvs: <DM5PR10MB16426F4AA966369DFEA03FC393DA9@DM5PR10MB1642.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: njx2PftstBUoTwXBrUAliVaHeN5wIjPPhaTn+vVb/5VzaSGtnjOzqncTKY2i9nlDwPh2+a6/yrwas69RfyDNK+uwjNBu+VvuFRFeiPhcIsdGs/kjcxzO+W+u3l4kwciklC1wf1Skrq8YpJLO2e2/esYVvqnP7abBo9f3Jp9eSgxLhF2CJflgDWEwWnixDOfm7LCFulLoz4Dg1w4wGqxb4xvUf6wMmDlbrEJTGiVOqMc0vWhAs36AV+ImCSAcr8SF+CsmPNu0So7a7oAkzJLSZ2fjvr4WViqgHZi+rEJf1ZJZRE1L3y09/Y2FUA+OPAZC2eVVpRVrJyLU1gP3c2ilvuZRCy3Q5eju+1uPWe+N1EaOkjTw1WJs6g2oGQewiB1M7U7LxQL8sjA6ZX5ZL5ApjumKOOZgZGMro27MK+cD1qOBi3Czy/LLZaD7mXMyl3eziVCM7kFk6vdH4Pj9sSCh9peQ6WzcqrofWyflvvpUDjZOuDRKwDOt5JrVgYDEo7YK4kD6ib8GofrnWjPRQfESTc2BwkjakWhCKafBRV+tpAlKUbmLfNl0xXLNEmaeanD7S2YITU/Q0jF4LH1zbQRZ++9FMSDBmsmlFRBljhUldoi/mSqvxcVdhcI8FzOvP69ZDw/dUy1j8RgrajqLgiCM/FAr7P0ukDfVJ0MozVcQUwsak6TjrnDzbqsxm30O3p2YfgutYRTqxK75S5h5veZ35uTYGewdalotwDBwMh18Pj+vRNSfkPR2NrL9Hm4YJ3ZHtGp/G6GWLZmPbnUqq2peUz+dQcIMQwgnW0iayCRuCKKXjpEhINbR4RTSlz3wS+e009ycaug41Ruy3/Mru96/XiSpNZsDTK9bAZI5/wNqaaA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(86362001)(966005)(6486002)(26005)(8936002)(6512007)(2906002)(33656002)(38100700002)(186003)(83380400001)(6506007)(53546011)(107886003)(5660300002)(508600001)(122000001)(8676002)(4326008)(76116006)(66946007)(66476007)(66446008)(64756008)(316002)(66556008)(38070700005)(91956017)(36756003)(3480700007)(71200400001)(6916009)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?daFbsYFCLsCp7dfYs2z/f6uczltC8Jda5v4JzdawFioRwH1lSjrgPsxQ4vLk?=
 =?us-ascii?Q?aF4wByIJyvJZit99x1dDXXuIyJfqfr361vQtKdp45DTbPq+4+tiSe3qVZG5I?=
 =?us-ascii?Q?HkskJgwxGvcRSvrZPdpYDo/hXXNbIZYO6BLvNTdtEDg/gNW4QnWR2sNeRXF4?=
 =?us-ascii?Q?Ep5oH6BpJCjS1C1HETjxh9oAbAT0Z0IsWZ2+xBtfpTxBPOHs3T8J1jN44zLN?=
 =?us-ascii?Q?v5CVf6kgRT0ptixUWuK7sQHhANSvzej+E9p3VqVZTEiYpDjCCTwR3mBGJEFb?=
 =?us-ascii?Q?Q1EpBxwh48Ky9PlgwMferSk0ykaK6w83CWvhJgwrlHIuENW04f/VEhRbcKda?=
 =?us-ascii?Q?JYLDYrAGBncoc2aIt2hVrUNjyfPdnSv9AW6hXxM+hZuycCW/CZdDRzd/WY9q?=
 =?us-ascii?Q?M/UaPXx1rhxoHAB2XhfO1Bf7ZydTCEOifUJPqwAi03HTGkC7ZyarPTFb4g8h?=
 =?us-ascii?Q?pxGU1RxukbdT4xAt2mk/27E2eGqj16MLlUQgb+1rd968icRvF6Dga9GatxcD?=
 =?us-ascii?Q?f8/8wyYPbLx71bvMEb/ImFwlGV6DRYSibfL38HnaHtYg9UuLVCsG1Tc+7pG0?=
 =?us-ascii?Q?m4dyPV4cnloviegYBPfnvy3Q5+ovXghLE/jLakuw0k+XwmT3yurql4aE3Iqb?=
 =?us-ascii?Q?IBZck39oflCbnpGt+ciEBZBXbJNeT7D83GAMqgR1NsnjreEaa61CS6+7SoIH?=
 =?us-ascii?Q?4d1JBkEXwGofIHrvghKFOFRtcwPg3YErg5LeSnzFa+WQQehk2G+Esh6C2kPw?=
 =?us-ascii?Q?VGJXxwLjq9KOUPWy9ZBtzIESaT15/X9dGEdEseq4yTjFtWOVmPzuY9wvl4wQ?=
 =?us-ascii?Q?9y/EhzHSreuF3mCkskqffX/JzCNpupk9F0mzFULvlqN7NTC1Jzu3v6gSIaK/?=
 =?us-ascii?Q?eK/dCA5I2SipdkMOhWYVAa/+Ey1AOrBITMikpEm1KORbIHUqmiltUlTxfURd?=
 =?us-ascii?Q?ae+8hMynYpx/ejesPRVxIh7ok0WmpBVsOwX3/fCTlcTXOi5+OAULlQBEKtaE?=
 =?us-ascii?Q?PYbf5GUJs4Hfqls5bYdG9qpye3ET5csRR9YLg8w6B45oaWGAUFFcNBtsZsEP?=
 =?us-ascii?Q?KhvQf9VQ8ucQeFEY7J61kspUTwE2G8pKFRiZMxjslq/rBO+weQ+7qZ/cQtvk?=
 =?us-ascii?Q?PW7abYY7H2WdDaPxaWsLiMObvK45P+fbdY8+bwyCNZdZ+t1RCx3ZNH+IDsBd?=
 =?us-ascii?Q?BRLG6TgvKvAkdJ9y1SBkapm1FDchbI7NDvk1i8WCX4xz8eSK8rfxEMK8Wsm1?=
 =?us-ascii?Q?/NBCcY19gNkgvdpdsLBygRyLpSaT5VRi0X1uLV+yibSsbkAcV8K/xewtwYQq?=
 =?us-ascii?Q?Cdez1u0RFeYhXzfQCXU8/JVgKtmv0420KAx9HTeBWoXE+42Hf7nIBbshjQjS?=
 =?us-ascii?Q?f7F3tjSG6ndqsaDlEfScJr0IFncWNo7tWQOdhI2fiPLRf9OxV1a0OfYUzbkZ?=
 =?us-ascii?Q?w3D2UPqk7xt0YBeXQpE9TvTy7msNLG0hfc8MZnpgKJjdRjaa+ZLkVsXlURcD?=
 =?us-ascii?Q?fzdxM0OTbm7+jHWNOQoaBIZOuzVl+bH5GV+y5loyGmoWMEfNxF5net/Tylj3?=
 =?us-ascii?Q?V1wKe7uHTlr/8jE3kOY9CW/S6wGAJKh3Ds4pzOPZj/AZEwdwzAB/NV1sTGdp?=
 =?us-ascii?Q?i5/Qrqgnre4SWYryhKBtkiClHOHQhvi/4vZkSjQXv92JMXfszSw6VLSZlyAY?=
 =?us-ascii?Q?0BHKsdgbqY9FdTsO0BuiXtYMafJxdJbWBK52xajHNirFO5tVboj1hjeFZJIj?=
 =?us-ascii?Q?+JFqXoiaU/KKjolNIKJInTSzpU29qCg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D700468B1E322C4BA21E28BDEF90B86E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c97535c-f1bc-4ebd-cd1b-08da419468b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2022 16:58:09.3719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vf/MPxtNh9V2PICa4D7HJDhIYOpHJcXsHSuJIDqneWW/GNyPkblXtxrYW5Yl/qacjHM+qEOyGofBPty88/SBLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1642
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-29_03:2022-05-27,2022-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205290098
X-Proofpoint-ORIG-GUID: NOKCfYkByH70kgcPPfs_eKI9baMzhNmQ
X-Proofpoint-GUID: NOKCfYkByH70kgcPPfs_eKI9baMzhNmQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On May 28, 2022, at 10:32 PM, Wang Yugui <wangyugui@e16-tech.com> wrote:
>=20
> Hi,
>=20
>>> On May 27, 2022, at 4:37 PM, Frank van der Linden <fllinden@amazon.com>=
 wrote:
>>>=20
>>> On Fri, May 27, 2022 at 06:59:47PM +0000, Chuck Lever III wrote:
>>>>=20
>>>> Hi Frank-
>>>>=20
>>>> Bruce recently reminded me about this issue. Is there a bugzilla somew=
here?
>>>> Do you have a reproducer I can try?
>>>=20
>>> Hi Chuck,
>>>=20
>>> The easiest way to reproduce the issue is to run generic/531 over an
>>> NFSv4 mount, using a system with a larger number of CPUs on the client
>>> side (or just scaling the test up manually - it has a calculation based
>>> on the number of CPUs).
>>>=20
>>> The test will take a long time to finish. I initially described the
>>> details here:
>>>=20
>>> https://lore.kernel.org/linux-nfs/20200608192122.GA19171@dev-dsk-fllind=
en-2c-c1893d73.us-west-2.amazon.com/
>>>=20
>>> Since then, it was also reported here:
>>>=20
>>> https://lore.kernel.org/all/20210531125948.2D37.409509F4@e16-tech.com/T=
/#m8c3e4173696e17a9d5903d2a619550f352314d20
>>=20
>> Thanks for the summary. So, there isn't a bugzilla tracking this
>> issue? If not, please create one here:
>>=20
>>  https://bugzilla.linux-nfs.org/
>>=20
>> Then we don't have to keep asking for a repeat summary ;-)
>>=20
>>=20
>>> I posted an experimental patch, but it's actually not quite correct
>>> (although I think the idea behind it is makes sense):
>>>=20
>>> https://lore.kernel.org/linux-nfs/20201020183718.14618-4-trondmy@kernel=
.org/T/#m869aa427f125afee2af9a89d569c6b98e12e516f
>>=20
>> A handful of random comments:
>>=20
>> - nfsd_file_put() is now significantly different than it used
>>  to be, so that part of the patch will have to be updated in
>>  order to apply to v5.18+
>=20
> When many open files(>NFSD_FILE_LRU_THRESHOLD),
> nfsd_file_gc() will waste many CPU times.

Thanks for the suggestion. I agree that CPU and
memory bandwidth are not being used effectively
by the filecache garbage collector.


> Can we serialize nfsd_file_gc() for v5.18+ as a first step?

If I understand Frank's problem statement correctly,
garbage collection during an nfsd_file_put() under
an NFSv4-only workload walks the length of the LRU
list and finds nothing to evict 100% of the time.
That seems like a bug, and fixing it might give us
the most improvement in this area.


> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 3d944ca..6abefd9 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -63,6 +63,8 @@ static struct delayed_work		nfsd_filecache_laundrette;
>=20
> static void nfsd_file_gc(void);
>=20
> +static atomic_t nfsd_file_gc_queue_delayed =3D ATOMIC_INIT(0);
> +
> static void
> nfsd_file_schedule_laundrette(void)
> {
> @@ -71,8 +73,10 @@ nfsd_file_schedule_laundrette(void)
> 	if (count =3D=3D 0 || test_bit(NFSD_FILE_SHUTDOWN, &nfsd_file_lru_flags)=
)
> 		return;
>=20
> -	queue_delayed_work(system_wq, &nfsd_filecache_laundrette,
> +	if(atomic_cmpxchg(&nfsd_file_gc_queue_delayed, 0, 1)=3D=3D0){
> +		queue_delayed_work(system_wq, &nfsd_filecache_laundrette,
> 			NFSD_LAUNDRETTE_DELAY);

I might misunderstand what this is doing exactly.
I'm sure there's a preferred idiom in the kernel
for not queuing a new work item when one is already
running, so that an open-coded cmpxchg is not
necessary.

It might be better to allocate a specific workqueue
for filecache garbage collection, and limit the
maximum number of active work items allowed on that
queue to 1. One benefit of that might be reducing
the number of threads contending for the filecache
data structures.

If GC is capped like this, maybe create one GC
workqueue per nfsd_net so GC activity in one
namespace does not starve filecache GC in other
namespaces.

Before I would take patches like this, though,
performance data demonstrating a problem and some
improvement should be presented separately or as
part of the patch descriptions.

If you repost, start a separate thread and cc:

M:      Tejun Heo <tj@kernel.org>
R:      Lai Jiangshan <jiangshanlai@gmail.com>

to get review by workqueue domain experts.


> +	}
> }
>=20
> static void
> @@ -468,15 +472,22 @@ nfsd_file_lru_walk_list(struct shrink_control *sc)
> 	return ret;
> }
>=20
> +// nfsd_file_gc() support concurrency, but serialize it
> +atomic_t nfsd_file_gc_running =3D ATOMIC_INIT(0);
> static void
> nfsd_file_gc(void)
> {
> -	nfsd_file_lru_walk_list(NULL);
> +	if(atomic_cmpxchg(&nfsd_file_gc_running, 0, 1)=3D=3D0){
> +		nfsd_file_lru_walk_list(NULL);
> +		atomic_set(&nfsd_file_gc_running, 0);
> +	}
> }
>=20
> static void
> nfsd_file_gc_worker(struct work_struct *work)
> {
> +	atomic_set(&nfsd_file_gc_queue_delayed, 0);
> +	// pr_info("nfsd_file_gc_worker\n");
> 	nfsd_file_gc();
> 	nfsd_file_schedule_laundrette();
> }
>=20
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/05/29

--
Chuck Lever



