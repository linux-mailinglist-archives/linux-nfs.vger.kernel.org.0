Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747A663AA50
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Nov 2022 15:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiK1OCZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Nov 2022 09:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiK1OCX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Nov 2022 09:02:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEFCB7E
        for <linux-nfs@vger.kernel.org>; Mon, 28 Nov 2022 06:02:22 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASDiBkH001470;
        Mon, 28 Nov 2022 14:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=sgkpLuMDUyUoo1S0sSv0DrNQdmS0hotN5P8X+Pq1cxU=;
 b=wodwQycTRyogO7BTea05RKpFOOyit40nVlLaCvQFbnljR10+ePuk0lyKrsuE/QCtO367
 R3c+SBT80bb+CrRISyEhcmHWkjc29lOaC2IuO2zhzSINPgPHkPbgJ22f6YVoBCw0UloR
 kYgGZZGGAeRS5PQ4IRsGEF2m4vicpQNoe+Id+BHG3Wr5xUC55/bGKNVdAkD+cPXzRLld
 XrAVNjYmXdWFbrUZ7CNK6q4mBR1jVL8KoJJ8/S6bCZYX0FMdM7uqzUQ3kOWcmCVMYstB
 Q3gUHH+l4MVkOM4yc7Y/RX2mGqHSlEcMqgVFO/yMnMmuGZFpzlrdQlaWZ7GGNILmleT4 5A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3tcsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 14:02:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ASDUS63019342;
        Mon, 28 Nov 2022 14:02:19 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398bgnuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 14:02:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuXAK/s/1+vS6AVEwMvq6lC/CVg/rEKjegKB6jy71wQfei9eVxikLUvWJSOLg0ay5s/lpI51CjxNIu+eRDSF+SbKGmRP5PfX64irA/E8pethb0l7drIVM0o9eWUnA7TUdGpHrVhVaDxJUSFCa2cZSV7iVXkx8KFf3eLw/E7jxx9m7rxFV1TY996b/JfX5Okx44iBxWHb5n5k/FjzIpO7arsAaz68V5ptYlru2oKoHfmN+N0Aq3wESF1i5/AJag4CFJWNDd98X99WJiwh6tqS9gVgAhb22xtyMCJJqhIr244DPRVxd/1bhR1YOaXTUxovORlmKBpGUBRUpY7prIoGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgkpLuMDUyUoo1S0sSv0DrNQdmS0hotN5P8X+Pq1cxU=;
 b=BXhVwU2pO9dVQ8hXaLOlLxPZ77ZlZ4Mm0wRfx8uxhkQeMlocy4Y/qBBYRu0bqS++n1wj+0guu94lg/i8RElx2JnMu4ahEl9/4jLkyBVXWlXFJMpguPSFp89LWOI43CGYgsyxsFx+6yYgKY1jF3c6BPE2e/zUkeN89QY4CqEQf9qXAZNGMhlMmemnGreFjYC00wDI+TLAHrkJxCQ6wkj7Uo4hvdkUpiykhIHO/o3ZNCayGSPcq8sC3YIpw1B21KeCU6bnJbz7OGFZbiNHoDoG+4pd0wtdjaNInq+GYYOhmi/o35Ed67eyytqjk4b3izADU9+45bapaZkg03c+Mk1oqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgkpLuMDUyUoo1S0sSv0DrNQdmS0hotN5P8X+Pq1cxU=;
 b=CG8wIW86KsioV9tTyg0mLpKNU44haLbwoRx5yzq7HohthXE9IHvMOCLApcvM+7CKyRqVanC9uxlI+moiVtJoGhbzq9lypMbTzCWEiipkGwBB6xCK+fJBRYIAopoPzP0NM5u0lESBgBe28ndS9pDjtqQZaTK0+d/Kc6nRCiFZ8do=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5785.namprd10.prod.outlook.com (2603:10b6:a03:3d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Mon, 28 Nov
 2022 14:02:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 14:02:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@poochiereds.net>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/4] SUNRPC: Don't leak netobj memory when
 gss_read_proxy_verf() fails
Thread-Topic: [PATCH 1/4] SUNRPC: Don't leak netobj memory when
 gss_read_proxy_verf() fails
Thread-Index: AQHZAdlxKSse4NQqL0iCXWrGsPU+L65UUiYAgAAOMIA=
Date:   Mon, 28 Nov 2022 14:02:16 +0000
Message-ID: <466F83EA-12E1-4C36-8F42-AE4F8578DDEB@oracle.com>
References: <166949601705.106845.10614964159272504008.stgit@klimt.1015granger.net>
 <166949611830.106845.15345645610329421030.stgit@klimt.1015granger.net>
 <3e33c1ba057d39f145bb935b6f92f17dc9cbd207.camel@poochiereds.net>
In-Reply-To: <3e33c1ba057d39f145bb935b6f92f17dc9cbd207.camel@poochiereds.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5785:EE_
x-ms-office365-filtering-correlation-id: 68b9a45a-3e57-4303-8aca-08dad1492846
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jmwI/zR3PNulx1TpjEGX/+uFFyr+KfnaYu5kH4CBTZsFY24AmcG7F46gmaJXXdzqXWfDVdajuBnkqqeI+tManbHLjiP4iY+DsghZ9o3fXTxRch7XtN0hifk0srLWu0XozmS8Z7bQgmvv9xIcUps2X9/8KAvRPmiFH6SgM7n+yJPhkU/blvx332KTKfoGbzD0AmSc+YiAMk3FFrKGfgeOFZ+06dtFxVRbe39OCCsWExZuCi7F4ghDOGSFgmXj79h3v5UJgPKuzbW7RLB5kQJ2T2XcIJpNfHX+LEIlM7/BT+iBtLyYOZVh5PcERNjy5HAvsOXFDN4kGBL+9oLJvxG6tiX5v3y0EZlZ3XswkoOSBm+Usf0AC1B/RHymuEWfI9CaWomrTZAquvW3ZF9SAdFzXZgRg2TGsIr3hLg30jlCKILJP328NhSHXMPG5tlaw4QnvtQj9v1o430M16c0bpExkCEklRd1s5NALdgePjs6FF9M7jfarsXv9/U6R+yUm1WZGcBnvUI7VnIP011ErC0LfluUeahUntbBD0+GMH37acXralmc8tDI2vYzRhn46QMPSQopH2nX1Phubnsf6Z/VgOo5MMu1R6pWm4s8btFetyl9jsDG4pXq/9PQKI+zqTA7ArhtDTtX8EpfNKj2cfVHJFFjpsMs+00854rhAF7ChClT5aBfzoVcup1EZViQdRNFETq8Xl1Ly1NawkBCuIPikZ6+qhHaKbnKN1koGbqkEJg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(83380400001)(6506007)(36756003)(6486002)(33656002)(86362001)(71200400001)(6512007)(38070700005)(66446008)(122000001)(38100700002)(26005)(186003)(91956017)(5660300002)(2906002)(64756008)(53546011)(8936002)(6916009)(478600001)(66556008)(66476007)(66946007)(76116006)(8676002)(4001150100001)(2616005)(4326008)(41300700001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O1R41y8wshSVVDT7XjuIuHVLDIDbnj1geFbmZuycoycA0OBfGwLx7HfhYCqh?=
 =?us-ascii?Q?gujHlL6wEpGeTlP82lG6xz1sG7PL6HEpmFALyEsPRuwW90xO3vzt5lP9ujRB?=
 =?us-ascii?Q?sQ18Bvwd7/TVxIiNFKLtN8myFjpONQE+UrbIA3UctyitxvS58hFiYoUD/A+9?=
 =?us-ascii?Q?mvJzroi1s3sIxfLpZOCLOoQ64RD1Xjz3OGyfcZh1xTlZF1ZORWkQ7rYAjkzN?=
 =?us-ascii?Q?VHOrhVI2UkljPYjdBMxDMQTzF8gPeAqCHq+jcd8KK0yE6QfqIkNA3sld46/g?=
 =?us-ascii?Q?hIm4nKVNNptZLlg6RGJGqp/QVOXN2vQkARiKOwMqyGgQDAEYyBHobR2u78Hq?=
 =?us-ascii?Q?mmeLcKo4x4t/1RYz726Q5hkpJpyB4D4E3XXDhtRB2YPWIBfnEscVOp5T4n6S?=
 =?us-ascii?Q?SHtrb3KbLJRpQiSXJMf1t2WBu6+b8WdmxE5ylFSdErP8Kz0Nod0wlsIFhJeL?=
 =?us-ascii?Q?hxKkvo+UNPFq06+55qheboqfbfvAO9oP15ZFZCAYsGPuGT0iCKRckCv+jze0?=
 =?us-ascii?Q?WBf0w552Y4H0rbVBmP/BsoY+oGUOn9D+uQ2a1ejiXfB844DxNpDcDK76uetX?=
 =?us-ascii?Q?tQqhOVP2Hdvd2aZHS8ViS0r4BpqBB2IP9KvhY5PIHVmfCKFr3fItwlgotbHc?=
 =?us-ascii?Q?0ZIDuX7KoySoZwAT32BzYtwZmIZrmMFAWwwZyrjR//iULr7FFyuyHXt69rm9?=
 =?us-ascii?Q?ooEBP2lWOQifE+fTNt0hsWSzLID7MRDGmS5I7DDvRm2coB6bDbZ0DA8JfFuE?=
 =?us-ascii?Q?LdcOXvxmuPgRW1rf6n0aFlFoMpxdm0hthQnENJ6bsgDM/Zv8tCGDpI5f/jTK?=
 =?us-ascii?Q?LlR5cBz9KnGq3IHubOcbzmq52Q4SsIY858nzc4CUupVIuDDKVUa9u4anmx/Y?=
 =?us-ascii?Q?/TwdaKQkMe6UlPYO1J8smjUFLy05kbVidN/hlht5OIxbUYs8a5ac7U1K896v?=
 =?us-ascii?Q?G/aQAl9nnxkYbuBVE07LE75ohNcaydI8DtseMPqfQ5GMen498OEAYrHTuZev?=
 =?us-ascii?Q?UPngHdHkzsvGrnLTTD4JrHBdJEg8opxdhBUGzMgYYS6zqV7VCFhPJa+tDLpM?=
 =?us-ascii?Q?I/hkVpmRSgJN4JUQnbYXbmQBo1Y6OKslPE87LEMHqcVe7bcPdMVOiIspuzgX?=
 =?us-ascii?Q?H14hFyjY6B3nsbMIEPnEIw/+7At2jK/A9tTgwdVP8DpUYk2IFLir0jnT0YNu?=
 =?us-ascii?Q?iJlwpz4m44kLmvBuFq/071vOGe6IrF+TOjfn79wnTv8UtPnyCXHuMnXDBOSz?=
 =?us-ascii?Q?7vYsI81qRD3OuYjNij9IUW7X5PGq2eZkJ54UvGNONvom/n1I55OUh7BuxhA3?=
 =?us-ascii?Q?0Qsu7BlqXiwteNIbtVjoZy39MiDtWOyT+gtmRR3iyjLlAAWhmKsO5CK4LaFp?=
 =?us-ascii?Q?FMML2ToOQbWyqXqb72G5G7fKTcMjUSTm9gxkmXN0bhp0qrgaK1myoITe6Gc2?=
 =?us-ascii?Q?W+k3Zcv2v+dkIW24z/7eDUmWDdDyXUtyfqxitpO0N18334ogaa+BUlk/VTlu?=
 =?us-ascii?Q?/aLyRObAGaCbvbvNd4EOfWptO8Woi3rrjbkCPGrKbMhJp+zJi2F5HX1ayZ4K?=
 =?us-ascii?Q?QiDp8aGpzxE6UV6oYNWkEdnA/0hP4dnzjmn0zkdKKwIAYysnHK+t4MAyKH87?=
 =?us-ascii?Q?lQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B9A757E2DE6F9148ACB453AD47230309@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cFC2BhcyyY0gTmLugxtmIZG8xD1S5ZZQPwLhBJZAZUnfZpitlq8pg7qq1EUuEUmB8QovZgS1jdiFChrxmSPyxmpbadqngyaF18br9TXNmn9gvOEXRFSk0M/PqRmkYUK8+vbYyHZqE2p04tFc6dLud1bij8Hv4XPm4TGXlMLwEuttH5m7JA2H9Nxe6kH2diigwukiYpUsKbkoMmAJCTe8ROUpx/9KxiM6v84sRQdC1/0fBn+CoORYx87SiCHbrRQmYLc+wUpTCOEzFSltYFkA1YkrCefnHFurneFmykafDFdFwD2gG8K2Iv88TsskftWs0vSxfxk/ancUpT62EwXU8wVqCoUW7fbuq9Eo1v3s6mBoQYwa881/WR7xsymlw3C2YB+kUOq1ZfwKt6yS/tw0Bu8tM7Q35i+G2fHsjK7fe+KVh5LDNO9Iplp/6dJlvKLoNS8AQ6Ij8+FROBKe5e9EtDnpk99Ty+dpN7E86tTl7ECm99n/yRKkSkm9DRxeumauBl/a0shXLteU5yKSer73+SYS++H+2w2B+ICbw7XScCx+TV1XK8arY/c8vSv1wK+zT5nysOkW2SoJcHeoaiT1SKFavL4gJ6xYff7j+FkimcGZdwOV96Hq2GfYiUhDvZxsQcRDKIwRznl/FgkiOqqPL3L7863IrxphBD1y9cPs/mmTvbrmiBhqEP7iJFnt5KgCMUDQKdGAbJsrOqc+vbv7F3PCZDj+mnqT8FNZYRxQiwFgFj1hh0OLEmIJZSjjfFE6fQimBK++1gyqLScYx65/buzYAdqZZuLrRIY8Zl1WCQqrrz18ol6ZlUsk5lIVCR0l
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b9a45a-3e57-4303-8aca-08dad1492846
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 14:02:16.4251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfDd8QvrU4DYSZCQUtXdAoutAxCfUIX/RFR8E7QLsTLiU0hnFBxPl3mPLDsKeKyZRkjeNqjJ3F+5cxEnU9nDSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_11,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211280107
X-Proofpoint-GUID: CmcH2H8abkaujWtdedAKWQA41P7omr3S
X-Proofpoint-ORIG-GUID: CmcH2H8abkaujWtdedAKWQA41P7omr3S
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 28, 2022, at 8:11 AM, Jeff Layton <jlayton@poochiereds.net> wrote:
>=20
> On Sat, 2022-11-26 at 15:55 -0500, Chuck Lever wrote:
>> Fixes: 030d794bf498 ("SUNRPC: Use gssproxy upcall for server RPCGSS auth=
entication.")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>> net/sunrpc/auth_gss/svcauth_gss.c |    9 +++++++--
>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svc=
auth_gss.c
>> index bcd74dddbe2d..9a5db285d4ae 100644
>> --- a/net/sunrpc/auth_gss/svcauth_gss.c
>> +++ b/net/sunrpc/auth_gss/svcauth_gss.c
>> @@ -1162,18 +1162,23 @@ static int gss_read_proxy_verf(struct svc_rqst *=
rqstp,
>> 		return res;
>>=20
>> 	inlen =3D svc_getnl(argv);
>> -	if (inlen > (argv->iov_len + rqstp->rq_arg.page_len))
>> +	if (inlen > (argv->iov_len + rqstp->rq_arg.page_len)) {
>> +		kfree(in_handle->data);
>=20
> I wish this were more obvious in this code. It's not at all evident to
> the casual reader that gss_read_common_verf calls dup_netobj here and
> that you need to clean up after it. At a bare minimum, we ought to have
> a comment to that effect over gss_read_common_verf. While you're in
> there, that function is also pretty big to be marked static inline. Can
> you change that too? Ditto for gss_read_verf.

Agreed: I've done that clean up in subsequent patches that are part
of the (yet to be posted) series to replace svc_get/putnl with
xdr_stream.

This seemed like a good fix to apply earlier rather than later. That
should enable it to be backported cleanly.


>> 		return SVC_DENIED;
>> +	}
>>=20
>> 	pages =3D DIV_ROUND_UP(inlen, PAGE_SIZE);
>> 	in_token->pages =3D kcalloc(pages, sizeof(struct page *), GFP_KERNEL);
>> -	if (!in_token->pages)
>> +	if (!in_token->pages) {
>> +		kfree(in_handle->data);
>> 		return SVC_DENIED;
>> +	}
>> 	in_token->page_base =3D 0;
>> 	in_token->page_len =3D inlen;
>> 	for (i =3D 0; i < pages; i++) {
>> 		in_token->pages[i] =3D alloc_page(GFP_KERNEL);
>> 		if (!in_token->pages[i]) {
>> +			kfree(in_handle->data);
>> 			gss_free_in_token_pages(in_token);
>> 			return SVC_DENIED;
>> 		}
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@poochiereds.net>

--
Chuck Lever



