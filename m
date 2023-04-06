Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E0E6DA1C5
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 21:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbjDFToI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 15:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbjDFTnx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 15:43:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5818513D
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 12:43:37 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336EeNCj008883;
        Thu, 6 Apr 2023 19:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QaJgh2+XEq7vHWLjo+66TtaU8Mo+tIZ5NHVLQwhCllY=;
 b=12wUkRlTkhnnvawblDe1GxXjPW4R1JcYrVSwElk8V9Kh5RW8JGCnVahCDa8MCWXXgV/V
 KjOH54kaQ+uP0EfnBx4cY6Cbz8iLvnqsbNtTIJQTzlDQJtOYL+ToMqOBplqzhnSJpD4r
 qrttSZ97BZCl7+zRTKEZ6cKtqW8F4NATNKnHDKwRxbKMrNJUHaLLEULaF6Aj4s7m3Eki
 F+vx1V4YotYDJnSZWMBhKNHpCdYMoSCBm++aVizVao++hpFd9HUUuep5NywnJX9oYsq0
 W7ChV3kvKA497jY2L1911T/xkiRmHZ7nbI59mFNewjqEb61OxO9jNZXvSGbxxJoluwYa 4A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcnd3sp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 19:43:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336IdFBf008969;
        Thu, 6 Apr 2023 19:43:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3kg5mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 19:43:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkA642++yWw3sMuSsiiiV6rNMyhROqvjz7SSnss7+ZN168f6oO41P9gZq3jYa3hF+qvahFu7bbGxRL2GLiK45yt53ZqVt/TsIHN+bYgenwMsui5uDlfX3sraeLxYzS1fRVDWJr8dLAbMQeKOvvQwZarezt/43HfYhCZTuc2sHK0lnA6N8soWsGhr8M9fDtT9NfwoGHnPPHyRR5KCLMh8Y4y0p8GPP8kJCtayHODiLer58me0Bs6AK8ha0Jw80OUdEHLcbephheMytrVmLNqc/AQj3q89WLhrgAXEsLuVYyoJdseN+DhRd817XkvLfiASYRZi9PmHpkghafF5984wwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaJgh2+XEq7vHWLjo+66TtaU8Mo+tIZ5NHVLQwhCllY=;
 b=Jzd3ccluByCe7MMIunUVpYraMeE6QRwVE10kcDI7PhVbPp1WIT1P6P7PBwB+Rwri0CnWUf1ZlLT/oa8bwc246+XNODFQV/yWILFcwYEXJwP4TrgEyEbbjyOi6upkcA1ITs2UJdYvgRTsyHOnOnIvD98KYQqgzmOFfT0WU3PtpbWX+M51sqUZ19Ya6YPblHmjM2Thu/D1TEFEIwTexQE58olb7/gWDxw0e56iyWvRz3rS4l9W5GMA5JfFitR+gsoC1Ww0cip6vi3cBNGtIUr3Yr1jXNLfM7UR46Y2cltZ4ZJKx4K1KSgD4XVB0JbzMwFpxGCvyvh/b6NDhLwTS4beMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaJgh2+XEq7vHWLjo+66TtaU8Mo+tIZ5NHVLQwhCllY=;
 b=SetnkdsvQ/bq07XV9NLooF//yNUb6KbcarhIMOdIDF5xZqm0B3kLz6d7RNf+mmejLK1bXGFPkccy/NLPkjTlrAkreo9hMdRkbdIorxJy/jYaum+k1SJdLFahc9NgY1akwPRms8etbLj24XIpPTbAseBczcy26abu4bajvlDHiGU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4867.namprd10.prod.outlook.com (2603:10b6:208:321::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 19:43:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 19:43:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Helen Chao <helen.chao@oracle.com>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [PATCH] SUNRPC: remove the maximum number of retries in
 call_bind_status
Thread-Topic: [PATCH] SUNRPC: remove the maximum number of retries in
 call_bind_status
Thread-Index: AQHZUe5IYt0u1Oe6Pkap8e148U2pua7xOd0AgAADsQCACUAXAIAkOkwAgAAKdICAABf2AIAAAdmA
Date:   Thu, 6 Apr 2023 19:43:28 +0000
Message-ID: <F925BB7E-4E1C-48CD-A0C0-A058058E55BD@oracle.com>
References: <1678301132-24496-1-git-send-email-dai.ngo@oracle.com>
 <9D5A190A-333A-4470-8572-CF85EE9A8086@oracle.com>
 <182842b2-3de4-d64b-d729-f4f6c9c576d6@oracle.com>
 <ed870a33-0809-3cfd-2d5a-b97409568b97@oracle.com>
 <64c4e5c4e61962fd828bcbef79db1df6466a875d.camel@kernel.org>
 <f6c0553c49efd9e2f643240aacdea8dd1f728443.camel@kernel.org>
 <07d8f93d-c8f3-5ede-66a3-219eea0fdfe6@oracle.com>
In-Reply-To: <07d8f93d-c8f3-5ede-66a3-219eea0fdfe6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4867:EE_
x-ms-office365-filtering-correlation-id: 5bc9a607-57f1-49e5-dccc-08db36d731ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x4BEfdtJxnobTm5YmpLn5zyjXjj/VVdFRvP5ct2giHWsalYmmf1BFVSRKB835+uYtaRyriPrZ02nawiYiz+1JE7auhk0b1M3Bh11fISSLQCHcxySusEDdeM3Y2NdOrcytwZp0CEqy086NJ/6qiyq5AhB2SiLNNSu5YLC/ucyT0SGrKRVeBLESNKHUKUH77mWxiGKTgRNFzNgaDsksVo6s3y/Wcn0obIfd/8unA6RLjtveaq5QDq2UK46Qe6rk5T2au8nCk+TOMjQJ+YqWFvs/GoSoORVzAHPFPTgdiNQWubMzG+UhjNbccR3qaV4hiAY9eJC5/RIb/9oB5J4VpAJHoVGBRU9k0AROS2D37lUIugFYqxtkJONEVpYVp58XlKAvTbCYXQB6IUv0j8mLRA4n5rd8bPLizwzQFnaYBOh5aR8ONfaCa97gTZFJ4Xzj7jfzQ/qabEzm3HzIgHjtTtrv8dZa01PqXwPgfC7m5ptLGYWvRsJQtnqXq89ZX2B+tomW3VDaETVEConKSfwKV+1Vn8Dbq3yhqEJsG/ca3g0odLUb0rkCid7fNR+VpC7Pn0Z0HlSU/MPB8XEWDYi8Bpf34nUq1/WqnrZSGygcNJbOR4NRP2C+bbsB1EKDmBzdcYYY7rZHWx9wMwTGgrf4CsYHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199021)(6486002)(66556008)(66476007)(66446008)(64756008)(8676002)(66946007)(4326008)(54906003)(478600001)(71200400001)(6636002)(76116006)(38070700005)(91956017)(41300700001)(37006003)(316002)(33656002)(86362001)(36756003)(2616005)(6512007)(6506007)(26005)(53546011)(83380400001)(2906002)(5660300002)(8936002)(6862004)(38100700002)(122000001)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VNqKxWttbX12DriwsGycnK/jRioZhTxBIbpiGoZRSYNthomHsjYlGhkrMYm0?=
 =?us-ascii?Q?Y4+mJJ5dJOxmqFpHgUErB+ClV4rTBosticw7AipZYSgCLBkQ41EdKHkKB81z?=
 =?us-ascii?Q?9BRMtnlQ0MNKukmWhyHEbl6Nm7lsRNBjPor3+NafGkcWTwzzJAddKqqQSul9?=
 =?us-ascii?Q?1ez2rqZk0wraPy9ARqp54YNTrGmKZ1aMGbkkpbUoQFqRD8G5xLNiFcnQTVFL?=
 =?us-ascii?Q?9rswj/X4hzGqCyiQvDbvHymPeGsnIUw4VMe0yeQXVBLQqjSBozTog5FTUheV?=
 =?us-ascii?Q?1MZBR0o2zFk1xXGo+P2X79SgxhTKWi9DV+ymx/PhRIfZ/2GhWgS5J8a/0mYK?=
 =?us-ascii?Q?ELG05h4+zv4tovak/Y4Abm5kI4CDPYcI/thxJHhZeEx13YJtjwKylIfKmz5I?=
 =?us-ascii?Q?88fcp21Hv0cfr620cy+8NmHqCSdYZVEHbILtLLS9GtubnbfKEa8sU7x3tINm?=
 =?us-ascii?Q?gSZZrCP+d+YUTLpy2lUNWM0HSTuJvP6prNsNOYWQ7T8gjgIShUfEJbdUELre?=
 =?us-ascii?Q?wemR2M8eFHeZlQIguud6k3uEM3Q3wtMrq3VRyR4+s59hOcYBnGUrVSdsYvrD?=
 =?us-ascii?Q?YNsGFlXn0eZ7X8NYJmUHIsV4B/5u+Drk1d5E36hjL+O8Gg7EadBmVKbMs52+?=
 =?us-ascii?Q?7BmgFtOlX/Rnp9QvnM+tbnrZdiFjhCTPyAkCSJv/v7s/LTguFSzMY/pkWW5w?=
 =?us-ascii?Q?AdgcEccujXKnP4YnA9QqIQCRzFQqHmSOVOy9gsrAraSNY8SRBGrr1GNbD4WE?=
 =?us-ascii?Q?5JGYQKEyPBK5Hvfm3X/fjBFmaQKaMh3Ay1+vbOCCDgVAFrW9B0P3bgJvczom?=
 =?us-ascii?Q?oHjyuoKgtVtPjkx+ccFNdouDEw6SHcv441Kdc9t01ctXT1SLL1FJ4UxbSlp6?=
 =?us-ascii?Q?mwMsmpPkEnBDlPbDVTwggfuePQSEk1c+7DTPel1HEvpTo38wcp8vnXs76Cf6?=
 =?us-ascii?Q?J0tgkxXInm85KRFgzvwOa2SiJj6k92AdNSFeR7fYGIwTg8kbriplmme4zRDs?=
 =?us-ascii?Q?6clwyQLhohj1ni6GYtQTVPjBuot5ZRqcPweRdyncMfUf/acgmhqFVpRU9gN4?=
 =?us-ascii?Q?/Opbt8hqj1R1MkVskzqdbDSBePbCp3rzTC5+ovsW0kJPrgGU2D1j9ZOZLzwq?=
 =?us-ascii?Q?ceaUDzk63HPR86K5FpAZWn7xr9swHgzpLQWQzXq+QG6uJZggx/5QPOM+wsNu?=
 =?us-ascii?Q?QRHFkMN7z0rj52yZqp88iXunu+nzqtH3TizGWTjLfnsWnKgsuYbWFBSQewE6?=
 =?us-ascii?Q?D2O6DU4wOn826SjCBvC4qs25voGUpFpwUxC/YMoR9ClysYzTFVrMLQtlXhXj?=
 =?us-ascii?Q?5WwUoqX2HoqrSG53mliR4sx1r82i5EO9UbHr2KzFZdTIQfdR8CoXlCkCfw4C?=
 =?us-ascii?Q?UmrXDtJLKVcGbTOfMFvHJVt1FH+2+BvonWU710fI2OrqiJIxbW+ak4QgB8c+?=
 =?us-ascii?Q?jMrLuzw7SOVCEXvQkUCJD2Rl11bs3+verZE+0HBp2lym+HdhBH7wph9GrGyA?=
 =?us-ascii?Q?k3rNsZQCPmzjHWGlN59FuKqCYJKTAmFXQjc7TQYH6srHQOuVjhcP6VhC0nLd?=
 =?us-ascii?Q?hZFcPJdkp2Q0s8Ty9KlK//VbQWvhHhJlYOoM/ll+kqNznZbufy+QbWFjZ1sI?=
 =?us-ascii?Q?MQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A6170B821AF2834899533832C56A3E44@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eXelb8v7IPw04ShTVsqTVW7GoZD9dET073o2x+BcymfkCsk/COv+4GfwjVgK/AAiUxl0u7B6rcLHNgQ86nL1ufadjrZXCFazGztSUgZmv8wtimzLzNv3+L85N3s548+DXsbBBCICEr/rMmEZ/nwKmc+6v/Ckh9p//mnH1JphovXxtGpaMvtHPgAJDyuQt0rZqJSFM6OeJqUujm5Gv6usn+gYxqk7oTl6c9T8rgrMPDXSZadOYdmUPXsfmK5xa37YDqZbp9XfE1fFzc15irgFPmLeidwRU6R9XtfUSbfGwBOtQ0Pieo7BqI9dDMBwvvTt/AwldQeskA9Nkwxazmu/WJ+FtnVVPhiafAmVKZQ7kijclqPo9lLdibvhqu0UkQS/Q/xh6siHLAmEdxx+cV1gbQfAMYuZga84YlgPTdFMu9KTa41gdob4/Nz/ox3akz7KImoUviHpDHzGODPxOQPmsLVzWQyrqM31VpSp0e/LR1ULZSml5aWiPVn8xz2BRYH9pNFaTc92nzuCuV1MIh5ZENfks+q8r9afmLMUzaY9rPfctY6Z8YI5aIakaSEQuMfsDwNh23bRE0RbEbrLemvfcfYIVulNCxRzR8wbYqWy6ljz5+E0qQQzbAcqYWb02ko6jB7wlrrvxW0fiSo/CaVzLubcps6BdzFG2ESB6najUAwKEcEqYhjIqqSrX1R2gTxKM2f8tJ0DgnZR1hmKQB8Tbn4JkBsVHcelP59ELSuzOC3ZnB0XLJU9/UT1Igh1sdyNw520HCCkWY+5JS4595YTPRr26txhz4OnagbKK7gfHsUog4sTbzn9zLCuyr5LvaSTNvAtTTI7K7B5H7Mur5zM9Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc9a607-57f1-49e5-dccc-08db36d731ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 19:43:28.2133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S+XuJwcjhuDW5DWOY4Llh3HR5UZ/5VNH5sci0hJZxngrapveSGQYMCBY5L2q6My6ag927UeCV2NPjSkWyAq1EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4867
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060174
X-Proofpoint-GUID: ixsn981RgBcGgSPOblbckmelDMYbZvxw
X-Proofpoint-ORIG-GUID: ixsn981RgBcGgSPOblbckmelDMYbZvxw
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 6, 2023, at 3:36 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Hi Jeff,
>=20
> Thank you for taking a look at the patch.
>=20
> On 4/6/23 11:10 AM, Jeff Layton wrote:
>> On Thu, 2023-04-06 at 13:33 -0400, Jeff Layton wrote:
>>> On Tue, 2023-03-14 at 09:19 -0700, dai.ngo@oracle.com wrote:
>>>> On 3/8/23 11:03 AM, dai.ngo@oracle.com wrote:
>>>>> On 3/8/23 10:50 AM, Chuck Lever III wrote:
>>>>>>> On Mar 8, 2023, at 1:45 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>>>=20
>>>>>>> Currently call_bind_status places a hard limit of 3 to the number o=
f
>>>>>>> retries on EACCES error. This limit was done to accommodate the
>>>>>>> behavior
>>>>>>> of a buggy server that keeps returning garbage when the NLM daemon =
is
>>>>>>> killed on the NFS server. However this change causes problem for ot=
her
>>>>>>> servers that take a little longer than 9 seconds for the port mappe=
r to
>>>>>>>=20
>>>>>>>=20
>>=20
>> Actually, the EACCES error means that the host doesn't have the port
>> registered.
>=20
> Yes, our SQA team runs stress lock test and restart the NFS server.
> Sometimes the NFS server starts up and register to the port mapper in
> time and there is no problem but occasionally it's late coming up causing
> this EACCES error.
>=20
>>  That could happen if (e.g.) the host had a NFSv3 mount up
>> with an NLM connection and then crashed and rebooted and didn't remount
>> it.
>=20
> can you please explain this scenario I don't quite follow it. If the v3
> client crashed and did not remount the export then how can the client try
> to access/lock anything on the server? I must have missing something here=
.
>=20
>> =20
>>>>>>> become ready when the NFS server is restarted.
>>>>>>>=20
>>>>>>> This patch removes this hard coded limit and let the RPC handles
>>>>>>> the retry according to whether the export is soft or hard mounted.
>>>>>>>=20
>>>>>>> To avoid the hang with buggy server, the client can use soft mount =
for
>>>>>>> the export.
>>>>>>>=20
>>>>>>> Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock request=
s")
>>>>>>> Reported-by: Helen Chao <helen.chao@oracle.com>
>>>>>>> Tested-by: Helen Chao <helen.chao@oracle.com>
>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>> Helen is the royal queen of ^C  ;-)
>>>>>>=20
>>>>>> Did you try ^C on a mount while it waits for a rebind?
>>>>> She uses a test script that restarts the NFS server while NLM lock te=
st
>>>>> is running. The failure is random, sometimes it fails and sometimes i=
t
>>>>> passes depending on when the LOCK/UNLOCK requests come in so I think
>>>>> it's hard to time it to do the ^C, but I will ask.
>>>> We did the test with ^C and here is what we found.
>>>>=20
>>>> For synchronous RPC task the signal was delivered to the RPC task and
>>>> the task exit with -ERESTARTSYS from __rpc_execute as expected.
>>>>=20
>>>> For asynchronous RPC task the process that invokes the RPC task to sen=
d
>>>> the request detected the signal in rpc_wait_for_completion_task and ex=
its
>>>> with -ERESTARTSYS. However the async RPC was allowed to continue to ru=
n
>>>> to completion. So if the async RPC task was retrying an operation and
>>>> the NFS server was down, it will retry forever if this is a hard mount
>>>> or until the NFS server comes back up.
>>>>=20
>>>> The question for the list is should we propagate the signal to the asy=
nc
>>>> task via rpc_signal_task to stop its execution or just leave it alone =
as is.
>>>>=20
>>>>=20
>>> That is a good question.
>=20
> Maybe we should defer the propagation of the signal for later. Chuck has
> some concern since this can change the existing behavior of async task
> for other v4 operations.
>=20
>>>=20
>>> I like the patch overall, as it gets rid of a special one-off retry
>>> counter, but I too share some concerns about retrying indefinitely when
>>> an server goes missing.
>>>=20
>>> Propagating a signal seems like the right thing to do. Looks like
>>> rpcb_getport_done would also need to grow a check for RPC_SIGNALLED ?
>>>=20
>>> It sounds pretty straightforward otherwise.
>> Erm, except that some of these xprts are in the context of the server.
>>=20
>> For instance: server-side lockd sometimes has to send messages to the
>> clients (e.g. GRANTED callbacks). Suppose we're trying to send a message
>> to the client, but it has crashed and rebooted...or maybe the client's
>> address got handed to another host that isn't doing NFS at all so the
>> NLM service will never come back.
>>=20
>> This will mean that those RPCs will retry forever now in this situation.
>> I'm not sure that's what we want. Maybe we need some way to distinguish
>> between "user-driven" RPCs and those that aren't?
>>=20
>> As a simpler workaround, would it work to just increase the number of
>> retries here? There's nothing magical about 3 tries. ISTM that having it
>> retry enough times to cover at least a minute or two would be
>> acceptable.
>=20
> I'm happy with the simple workaround by just increasing the number of
> retries. This would fix the immediate problem that we're facing without
> potential of breaking things in other areas. If you agree then I will
> prepare the simpler patch for this.

A longer retry period is a short-term solution. I can get behind
that as long as the patch description makes clear some of the
concerns that have been brought up in this email thread.


--
Chuck Lever


