Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7CD70DD3B
	for <lists+linux-nfs@lfdr.de>; Tue, 23 May 2023 15:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbjEWNLW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 May 2023 09:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbjEWNLI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 May 2023 09:11:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50FD11F
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 06:11:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6F09T031826;
        Tue, 23 May 2023 13:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Bo+JLycrfZobB5BW4oZF6T8AzurIgR4hFsYjrPlo1a8=;
 b=pUk75ct7AGHedRy959oy0+O2WF5zeb9KaKGFpjHvs2G2aFX6Pti1I9V5CPUsxk/YE4+G
 yA7YFWReA2UJiRozs7oMJ2H6GNnLr9KZCgTv6mpEIw/Nc/MIE1piR1TDZuXIU4657myG
 eH8T1iCFmOu8RAvIVLFUgUMzQVTuA8kIKiJ/3hfH5fuMeOkOdpGiRs1pb2KB7AMHZqXN
 oLdWBxJzg3foFOaJ8xwqUiAk8YUPPZ4jP4wAj9OH0AA6m8v91IUFZP1dYFMUM283rtGL
 Z7bjstqNvHqwrSwk4oAxNJcIAm7qpv2Zp2wrbSIMiAkdJhz8W2tdnMbAZ3dIdH/H8/DF oQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3mn353-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 13:10:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NB8fih013218;
        Tue, 23 May 2023 13:10:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7et5uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 13:10:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBWcM3DC6hAJAyIUGxKW0aLbt7KzSy077KEEgnmsr/Rb8sL6qTROsNE8G6jmAJCQSVQl1KgmleNlBrfOeCyInaZCIOcRvEeFMIYYfq4phPjTGddLb0/q9GjTSSmSP5PFxpJQHq+T2YtrYFMYNhJvcOwTO8lpmtBV3H9zCgeFNZ21Az1QqAnPTHkKdm3ncJpJoS8TBSGk76uF9zw8t1j6S9VwMaRP156tdcmj3JQO0EkDohUTTstSYR+BzHzU/l4WozzJka+RmkTnlWSlOvOVLJeh93PeQT7phAmBSXFnajwG85hJ/bCjijt2RQnSd9lqojIfOGVVoNj/n86b3QZ4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo+JLycrfZobB5BW4oZF6T8AzurIgR4hFsYjrPlo1a8=;
 b=byBmUjukssUHHMiAy2KNm7+brVPs18JJmtnyR9vJdmi2DotB2yu5CoPlUH2k6Nt0MUooLRG/prqiNy5UusXdiK2GYCTp9Vl5W7IucZRov/2N184lrWfrXDC6v1KguUtYpkt9YA3rBO+aJjIUdKWgEBv6Hg8QRiLqXcaWSHrjTUbtrX2AEO2uXNHMLSv9l15WUbF4V7UrGRdLeq0tbQuScsP76u0RL7JCBWo32NvTteIRUrN2ZYw0wK7xolg9yqgTyerj63xkYLPENaPWP0XrhzLQMl/UM5ywQBMHwqJkvm6uJ7Z7SZA9Qshw2szhYHEraGe7f7Sx1e7JvBDoqEBuWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo+JLycrfZobB5BW4oZF6T8AzurIgR4hFsYjrPlo1a8=;
 b=TXaSS3AIhgS+1Qz7uzR6ccxPfdhgFEP+yQVPjHohKrJgNXD6WaUfPIDanlDU6d9/FncJOgYLY+wWeWdV/1lUmXuQQSwiTtqebVDrQ5Q9aiLLinYiZ0wcljYjJBEpzq370poCqZ/EMvw/THwSfvPFVDt0tqLBPfctErg9dhiVC88=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4882.namprd10.prod.outlook.com (2603:10b6:208:30d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 13:10:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 13:10:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: don't provide pre/post-op attrs if fh_getattr fails
Thread-Topic: [PATCH] nfsd: don't provide pre/post-op attrs if fh_getattr
 fails
Thread-Index: AQHZikOAXGHeeefv3UWBymioFz6Qoq9lg78AgAJXrgA=
Date:   Tue, 23 May 2023 13:10:53 +0000
Message-ID: <143D2797-B071-43FF-AA85-E4C4A7218691@oracle.com>
References: <20230519111723.20612-1-jlayton@kernel.org>
 <168471866230.5298.3283829268036917998@noble.neil.brown.name>
In-Reply-To: <168471866230.5298.3283829268036917998@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4882:EE_
x-ms-office365-filtering-correlation-id: 7f5a580f-ed92-43d0-ee76-08db5b8f2323
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O8R1aXgO0soNTKQupjJZapbnHZ40NDlMnhJtnUZ9Ln5qDuwuYajtxfpFPMDpBXCr0dxB4JDVLRTDfnXIPIIhODXmOfWprMRyb3IFrBp5V9C/jFPs9TBHXpHm6/rOJMkRV/oBFAcX5tjQHNzL8valW5S6L8yKS0P5cFnHe7PVcX+lZ/H17u1tgDdFt2GV5C5+eHOG7AnLW8FZzN1Bl5hUWYpjNjChGKu9WQTgCB/8ceHl01G4R+wd95tpDB1Kv+DkxBWbgjm3263diDj7Ih8i1MD0p+Gs2XcsA1hYMVVkdwTgjg/VxB5upB70CLqy0nLYhEJkifiQBWsy0ZC5CLQfhKaWPZfAOn4GMd2z2Bxg3kAQ8UILy4SNYQ8YPX2kqm2XYOrCrdPA1/9XTKuf4aynBd4Hfr5rivXOoaknnBFa3d7NB4izVPUks6PNTVnAU2h1LzxbtkZ/l0Anl9mBlwMzZDbGaKIEz+uIKiQvUcd1ZBiXyhUPluVafPpkV+jsz04y5vLbXDxajd7d6NseGkL9GM7cRVbZin3s+0Y1wd/CEIVEe/k12HoXdrAZ3IAZkYbyqdPirUGY2YtmzfvYLRR7hZsEVlXKzfIAcOqOmW3LT5+B2wSNuudRKSpRabWTyeN8a9Yc8KCorXVaURTrjMwqvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(122000001)(33656002)(186003)(53546011)(6506007)(6512007)(26005)(38100700002)(2616005)(36756003)(83380400001)(2906002)(6486002)(41300700001)(316002)(71200400001)(54906003)(86362001)(478600001)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(76116006)(91956017)(38070700005)(8936002)(8676002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OVD4li73emZ27G46QebX04QmaUaZjresOFu/fTIy+9GJ5Thwvf57PQWnBvrY?=
 =?us-ascii?Q?bixFdO8TvzSvGNR30jNzEi8Soj7i4bh9pZB9tnYAxvCztOrIZWaCrXu/p2yM?=
 =?us-ascii?Q?JNbtzmVrR2IYDiYY7YPjywWO9fzcxHgdZR9W/539Pypzp1L3WNkLHFzrZSL0?=
 =?us-ascii?Q?Y5s3wRTRdut0ulOQOFcq56gV6vIvFY+N77MqHxJqhc2zLsSl26PhxL2FVizc?=
 =?us-ascii?Q?5e+P7WuEZocnykaeUT4fHsJPpw9eeVHVdfLIzlXnhn9u563oQiieRSISvcWY?=
 =?us-ascii?Q?DaD3LWPmOvWWhgSCGgoMF0c96VBDTHTXlNaC/VdQ3ZrWh41ySw85Dnma8iKh?=
 =?us-ascii?Q?oqw/mrOhCFJthekNsXwr4FBXQBEwmkgr6/jZ9qpURkgwtO8vK/+mJkgO+lmD?=
 =?us-ascii?Q?u2AsJCFYmXlRPUsCeeyNigUTB/bC+Qt9n7UVp7Y1qRphYwglVd2DPBJGulyU?=
 =?us-ascii?Q?S6CIA2CH1BEx93DTUQn6OZkJep/dgIgMHFYGvz/FKyekNjmHH/y5+L7567FX?=
 =?us-ascii?Q?sIp9XmK8tBDE2qc14JHN8U0nOIb2ZP6v7ikb6DLIGMFPlBMwyHV33xR82H1L?=
 =?us-ascii?Q?edlMSRUZeyvKHy/F30YN7rKdWetfFscdsQ15uo34BYBA69hyYk/1LJCwti7E?=
 =?us-ascii?Q?lxhczE3ardBAOzlmYDkzO1JL0Q57CGpPAqXVs2JRd5UWFx6HiUlVcgQZkH9k?=
 =?us-ascii?Q?f0uYlDZl6fuoIImVKpBSRPody2Cbmz8/ZmDUzh48UMIuRBLhbf8j6dp6X3vA?=
 =?us-ascii?Q?K0qgRgYlrLrgAhQKV1ydKbM4Mp0xIyNjjQCTbXszWaF+XWCiredQL/Dpul+N?=
 =?us-ascii?Q?wvN29B3j6T6H2I2ve1eGVNsQHWru1M9gHkbvq29V+8i7RSPFQmFo6Kkg+78p?=
 =?us-ascii?Q?/KHso22vFXCwAGJ/oruzxout2Va1Mre7JcXqZR6O5YUHLmGh6YSTOZvzouJ0?=
 =?us-ascii?Q?tbdGyYAjHT1W4DSNCEZijac34aVV2Y/Z254qBLoGbogFwkQ1jTLDrsOZdGt+?=
 =?us-ascii?Q?0SYeC2xs/PEvgOQ1z7PCYWJwbUEIAQi0OD1wdFNTLm+9BlRu4I6rvPlToxK1?=
 =?us-ascii?Q?/KANVvzAlqoQnJpr+0GAhaFLkX2oPjrHrCqIQGf+9DY4bcAQtu1K5DokyPiP?=
 =?us-ascii?Q?gTrb/zc8lUPRPw5A3SuecvToGk8Gu+VgsAHgiXEu8ky6TuNvC51qlrtijWMu?=
 =?us-ascii?Q?SSAm5gCESX80tacZf59EgyIfkjLxOzy5TNToXMz0cohYdH0DAmMGum4krygl?=
 =?us-ascii?Q?i9pD9ATGUE/f/8UuoQbsr4FSqzDS/wIot5JqunI6fB+fXyV/7cSEl2Yit8PX?=
 =?us-ascii?Q?T7jxPyrYfIux0ryUhjhJ/R5QbudIUgtFpiX3U/rwGIy9EMogZbzYGFMMN559?=
 =?us-ascii?Q?Bucsj+hM7XlOXHPhbbIksuK84EX056IUTGc4xEHQktfLmZzkTk7m5qQWLm+E?=
 =?us-ascii?Q?EPRJ8MCsMLBBNEZccftXRWGKFgfKZj1kws6Lw9D2X6Bv7rd64ju+BFOD/yYs?=
 =?us-ascii?Q?Kjc2//C7r6wv2vjl0iVbvS6IawGSWqAOo+eVKRxq9kiBizxpnmsXGNBt8X5C?=
 =?us-ascii?Q?MDDhjA6EZ0Cpn5imDkBMXwQZ4cWgWhF0mOYR8uLtVkPUQywH4Kf00SwtRCPq?=
 =?us-ascii?Q?XQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <67EB24667E30FB45877B172BE506DA7E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3nvdoBh+qvuEC71nRdr8AInykKcwRYzCo4YFgWzS5TLXvlaBKIxDL2aE2BhDgndx/kaxE2xPhRB6v6cupYu0iJsuSAcHTonkEyYwqNksqYQ8URWwUU7XDLg4U4Lr/Jg3l+fmTipOmB+uN5ArQE5OumwAWzDYR9pUUwmqAdXhVgZXIQBPwtT/qnI/ciNMenbyRcBHsgeUaWYdzgLTUbPAt22loMMflGdExqyhpkfLmEJEQvoygXMCxsEoudLJ7Dl6z6xD7eMKwo5g5/j9h1S3Lmgpym3DBd0p58qBB0Q4KkjU8/pUCZfZAflJjyzwCd87XwPk28ybUPThFJeoexW8F8rqHBc/lpvKrH1ECbHzjrQU36gRQedRJfRuoolZTBrSV8iQ1ngKynsTOa7crrIakNnm/N7PEwQ+rK77/QhvvJHx7uN8XbQkONhNV9MOPgrOr9XdFPGlqBLJMI82VYCart/1yStFp/Fjtv3/WNyO9kpb8WcTcv2VLTRBXZjBzxt7N+O6pcOAq4eXTjMznlG3gv3AIFvSHYth4wIm863DbQPv24Lm/S49qb90E3jUpH5Fv9M9rdbmd9sOXufBcGA3E35lW5AA4IPzmD+1mvxSuIR3CiKoOo73XUfv5VZ4VqkoROsyQTdMPsupqeZiSyNlqMkSE8X7+JV73A/GsWYnd48RHcJMQAeC9jtS0r9TABagB50jMpZ6hX7ZQmtD6xQu8c/ASbzogM2pUn90uNisQKWyTQI9oZFNT9d1O9lYudDMlr/KJcHhLV8mJhTxbW0A0MiFX01R9p41vNp/wdRQTUveqD9Pg/+b/VJmH2HxHg+r
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5a580f-ed92-43d0-ee76-08db5b8f2323
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 13:10:53.0862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5x3w+3tK/zZsm1ELuRwuWMwd4JIQqY4CoaReIskpflavRPCVCqeBAT8TfLancHIQkilTMC2uPnCZeWdP4KzFNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4882
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_09,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230103
X-Proofpoint-ORIG-GUID: k1xI7rGONoSgCjQD8AzS6jX_dJdweX4c
X-Proofpoint-GUID: k1xI7rGONoSgCjQD8AzS6jX_dJdweX4c
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 21, 2023, at 9:24 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 19 May 2023, Jeff Layton wrote:
>> nfsd calls fh_getattr to get the latest inode attrs for pre/post-op
>> info. In the event that fh_getattr fails, it resorts to scraping cached
>> values out of the inode directly.
>>=20
>> Since these attributes are optional, we can just skip providing them
>> altogether when this happens.
>>=20
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>> fs/nfsd/nfsfh.c | 26 +++++++-------------------
>> 1 file changed, 7 insertions(+), 19 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
>> index ccd8485fee04..e8e13ae72e3c 100644
>> --- a/fs/nfsd/nfsfh.c
>> +++ b/fs/nfsd/nfsfh.c
>> @@ -623,16 +623,9 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
>>=20
>> inode =3D d_inode(fhp->fh_dentry);
>> err =3D fh_getattr(fhp, &stat);
>> - if (err) {
>> - /* Grab the times from inode anyway */
>> - stat.mtime =3D inode->i_mtime;
>> - stat.ctime =3D inode->i_ctime;
>> - stat.size  =3D inode->i_size;
>> - if (v4 && IS_I_VERSION(inode)) {
>> - stat.change_cookie =3D inode_query_iversion(inode);
>> - stat.result_mask |=3D STATX_CHANGE_COOKIE;
>> - }
>> - }
>> + if (err)
>> + return;
>> +
>=20
> I wondered if this might exercise error paths which had not previously
> been tested.  Before this change fh_pre_saved is always set, now it is
> not.
>=20
> The code looks OK, but I was amused by xdr_stream_encode_item_absent().
> Various places in the code test for "< 0" or "> 0" which seems to
> suggest that "0" is not being handled consistently.

You can read those as "returns positive" and "returns negative" tests.


> But of course xdr_stream_encode_item_absent() can never return 0.  It
> returns either XDR_UNIT or -EMSGSIZE.

I don't see any tests for it returning exactly zero.


> I wonder if we should be consistent in how we test for an error ....  or
> if it it really matters.

The xdr_stream_encode_* functions conventionally return a negative errno
or a positive number of bytes encoded. The "< 0" and "> 0" tests convert
that return value into a boolean.

I reviewed the call sites just now and do not see an evident problem.


> Patch itself looks good.

May I add "Reviewed-by: Neil Brown <neilb@suse.de <mailto:neilb@suse.de>>" =
?


> Thanks,
> NeilBrown
>=20
>=20
>> if (v4)
>> fhp->fh_pre_change =3D nfsd4_change_attribute(&stat, inode);
>>=20
>> @@ -660,15 +653,10 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
>> printk("nfsd: inode locked twice during operation.\n");
>>=20
>> err =3D fh_getattr(fhp, &fhp->fh_post_attr);
>> - if (err) {
>> - fhp->fh_post_saved =3D false;
>> - fhp->fh_post_attr.ctime =3D inode->i_ctime;
>> - if (v4 && IS_I_VERSION(inode)) {
>> - fhp->fh_post_attr.change_cookie =3D inode_query_iversion(inode);
>> - fhp->fh_post_attr.result_mask |=3D STATX_CHANGE_COOKIE;
>> - }
>> - } else
>> - fhp->fh_post_saved =3D true;
>> + if (err)
>> + return;
>> +
>> + fhp->fh_post_saved =3D true;
>> if (v4)
>> fhp->fh_post_change =3D
>> nfsd4_change_attribute(&fhp->fh_post_attr, inode);
>> --=20
>> 2.40.1


--
Chuck Lever


