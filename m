Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278D070366A
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 19:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243501AbjEORKI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 13:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243617AbjEORJW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 13:09:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDA7AD03
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 10:07:54 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGnskL027157;
        Mon, 15 May 2023 17:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=C9gA+m1GO0g80VzzlNCcnqUjDjTCqzh23jUu5vxwoTo=;
 b=nQq6gEJyVvovmTgI0rErph0NSQRtJhYkNBwMXNW8FU8YDgI3a4aelsRnEDRX47n6Vlk5
 excE4gERmVP5XaXeqTYTSvjAT3wK77yXH/D9/sXZyyc1RFjVtabm/iRAVedh6meGJqoz
 mlsWeVVtULJiOVi6r+FJ5ULB45Nul8F0gE+5U5FelDNdaX7Pkl91ih3wgieAODVKvZ9I
 SbifiwvODi8LvzXDOyOZkuCOzFAHQTtJcA+NH/x1Awy/pCz2kA2SxeFJST8eoBoHieap
 ag73xMPMfwmuyhWKZNmq2ydSlrqIcnCMdPZjKIgnkes1V6+KWnaWQ34yde7HC8rtyBy4 ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1520kuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 17:07:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGlCCO029558;
        Mon, 15 May 2023 17:07:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj102xdca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 17:07:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiZbyYrc0GTo/Xn8Ep/fQzRKcaUdvnIbKvlWPmO1BeRS7yCn1z3P0/w6IpYcyIwGJM/SrjQeeAH/hhDWxYo50wZ6/dZf8uXPPf75D7pd1LrggudWNoFy+K9ifDBiOoFMjPwYpYONlKOWu9uBDorZnQmWAXHw25i/AhXvz7sB6dU4ztpWy8CVjaFcYSvhbk0ZVf7706vXiVsUBQbUZNVFE96U8s617cQOQAI6ek1I2slwb1Y2uoYaw7CVzlyw+1MtkNdspE+S7q5ltZi0H2EfnhVkYj2zN4qqIoSqWe9RIY2fM1jVcu7ln1sc8lhdnz+9BGJGyID4IUMPkx2X3D4UdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9gA+m1GO0g80VzzlNCcnqUjDjTCqzh23jUu5vxwoTo=;
 b=J2riZCZxQdi2SzFU3BhRPSYqUNIBYvfx/++Wi/u0VzUGk5eC93Ut192Mg8RZT46l9nO3DdC/9p5M5aKfSqzTkkEmkXQ3yG0AMxgyTNeZifwPetoEQ7Ig3+rkJykwYApIRWWv/bCyfV9CpW9eKX2MdK+yhqsJFKujsNn58IVqL8dX3pvc2/W88bz5L9chTyK6/816LAxAZxagAUiVNQ7yEKQ6+tNMGe8ixZLUHEzymDGCEvGlATBrGOv29st6IpVxvOSV8PWpAYdTWsSBLjSnYe0l9m8egOohJMFxiNY1JDFcCHQz4p4Z3ZXh8bye9wipclmQ1y7YY3dA3y3A66mIyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9gA+m1GO0g80VzzlNCcnqUjDjTCqzh23jUu5vxwoTo=;
 b=lHHUfjPlufHhHgOn0eSSkwxIsmlVZ4CCZepUf6ncdpn4+QMQX0jdZkcnJ63u6iD/lFUabF1rDuUEXA2/4wRhZyHSlnmgDzNtTH7c3kF58FuYY3UR0Z4EM3FKt88E02ddqXprtJlbLg0kxEXzyjN7GPI9vIK4XZKtsc0+RU6QWn4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6233.namprd10.prod.outlook.com (2603:10b6:208:38c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 17:07:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 17:07:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] SUNRPC: Improve observability in svc_tcp_accept()
Thread-Topic: [PATCH 3/4] SUNRPC: Improve observability in svc_tcp_accept()
Thread-Index: AQHZhzHWpcaPoUiNDk601iS+ugLkBa9bjXuAgAADgYA=
Date:   Mon, 15 May 2023 17:07:21 +0000
Message-ID: <C6F66E2A-9FA3-4F5C-BA45-300B56CC0ADE@oracle.com>
References: <168415745478.9504.1882537002036193828.stgit@manet.1015granger.net>
 <168415757392.9504.14836685251349712202.stgit@manet.1015granger.net>
 <13c6a090134e64ce4961c322681a941399268cb9.camel@kernel.org>
In-Reply-To: <13c6a090134e64ce4961c322681a941399268cb9.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BL3PR10MB6233:EE_
x-ms-office365-filtering-correlation-id: 1b7623fc-b0ea-481b-ff86-08db5566d8ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kdD8hNp7L3O35NZuF9Cz1Ly3WBOndXE+0oXuuzcIpNzmYFUku1Xhqkp/+cl+b5ebT+sl/NIaGNhrfVTUkUPcv2eArU1yb+1PSXWTW2ny0faoeLl7Xkf0wuQFKSRopi0IyyWJtM1UALiZmFhJYtPzDdnHuyzRaHAMJkRY2QT8cZ2H0xSUjTPVzBe6cnMoTPSKwo4rPfsI1u2QmaAtW9TY19UTplT/bmtZFYcDi6uIjoR6zpB8y+/LOTGBxtUG40MSORCoX1Y+CuQXYjPS+tg3p7JT1JRv73/pw8FCF1xL1DTTuXhRt0K8Ra49a+0SgK/idGGOj8pw+7g+Q1Orxfbxk7/+OF3vAi1eeW17DcnrmoQ26Mp+gZ+Pd1omv27+QQMWMmYQijkjm7xYdTZKYhTs7h+4Unz+7s82LaQ7y6ZFa6WLOyjEGBz5EvaU3yRDcg0+JfSpgqvV6ipdGp3cLb2VzXWBEjUDZD0kKPSSM58dcdU6x81bIodQaS5rIZPpsVBo6Ff1HHjiSM7RVjCPoVVq5XlTaDRPb9dUej9OjrsNB9zcjsJiyw4UtYH91zgYJUNV4UUhfvOB7QHIgIrXj1u1k6v4LsOeh8EqXyX5N3D/2vzIH6moBwprE38+X1VSHdjVTkOnDMmHlv60uH1PUYZbWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(54906003)(478600001)(2616005)(86362001)(83380400001)(6506007)(33656002)(26005)(71200400001)(186003)(53546011)(38100700002)(122000001)(6512007)(38070700005)(6486002)(36756003)(66556008)(66446008)(66476007)(66946007)(2906002)(64756008)(6916009)(316002)(5660300002)(8936002)(8676002)(76116006)(4326008)(41300700001)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2zUQs3Pu7P2VWNN12AWkOKY9YszAT9+sQF8ntAgut45mqWf7QiQlCQqUBR6R?=
 =?us-ascii?Q?SD41xyESaCmY2hX7A8B0/pR5wfAdbBBnWnu1StXJUeijsB9nrbaBIIniuQkZ?=
 =?us-ascii?Q?jMryiXLZTjUPb/cIprKcMI8D2rB5v+L/Tb8TQMfDr4bo/y8Sa/at9sGO+OYt?=
 =?us-ascii?Q?4AdD1cQvfKOddsOaK8mQuuiG1Uq3aZUozauYtcSkpp7Xeq1kfA+LRfASVzSJ?=
 =?us-ascii?Q?2cCNHBnj9/2hsWA+bVFEW+j3k9QWjXJq+Do8r4+ttvnV9mAPG9QoWMUYkOd9?=
 =?us-ascii?Q?jmsCysUxuvDTKIdDmveveyo/aDUQhqYk016xZPMcvC4r5uUaf9v38wC94YwI?=
 =?us-ascii?Q?Vd0JBQ6MUT1BrjyEsjE1RpOt+l5nWalOADRS5o+xRe3FEGCRhTH2wr//g0xd?=
 =?us-ascii?Q?N9gtvoF+HD+t7xCop7/ZTaU1rQgigAZTdrZtzlsxy5HBH70g8OXPrEPZYgLH?=
 =?us-ascii?Q?dTsMTlI0hAvhPe0T874L9BC9KDHYhF9bYLx4L3dKW85Yq8FH8Zt3WOQ4+gx+?=
 =?us-ascii?Q?g3vlaPyHEnuhp8LklTReeoVUtY3tj/XLjI8JRlCN7IrXscBfCeAIdJ9g4D1P?=
 =?us-ascii?Q?5KpHzkSLLM/+K5LSdwYGFNFPXnnuYn0dKq1vhf0iZnUWugvG2nkuNW7KC5t0?=
 =?us-ascii?Q?OvMq2hyAKzQpuBi0Q68GoK8Ju5MEIM8LLntRSdx5LMztV9fyIfJ3kKp02gzZ?=
 =?us-ascii?Q?Sy0a3mF4ykYnWiB0jY+r0vrH83JAcyxedsHrgHNchBhai8OwHEVThJI+5TG6?=
 =?us-ascii?Q?fpUqkueteTwiPmM9oOtBNOP2ux7xtjCkVG8RkoUTYklsgXFgp6HmrBmGHQDm?=
 =?us-ascii?Q?DZC3HVM2E7ueuyoeMIhifgQKNjvGOH2uxqxLgjH76hch1bKQFcFzmspiXyAa?=
 =?us-ascii?Q?cPZuCttDkM72/msFBlCpWBLnqnsHP8QXWj2jvsxG4Sx33OVPRZ3W7PeRJgNh?=
 =?us-ascii?Q?EcZ1o+mldJDijBJtFrpk8bmlnMUJSV6AxmRx3wr13O5Af0KVTSYA6lycHjnc?=
 =?us-ascii?Q?O6ZvmvXffpxIAIqiaf5s3tswf+sZbPv12y0tUo/sVvCEyWqPp/iTdaqVWBdV?=
 =?us-ascii?Q?SqSGUs7YsdaHsptb/xk2RdzBXbJJkDDFOXPzYR9f8tKynFGV95PnMkCpqpUu?=
 =?us-ascii?Q?nW6R6Ph7/lSebbbRHdY1XskaSMabGl61EdeWkGNOsZUzBgFc9TDoD0OID9fo?=
 =?us-ascii?Q?DYQqGbmihGlM4N0QmI08MBf60AXtt8UApJzBo5/rImUMnkJEvGt/e2CNBkE9?=
 =?us-ascii?Q?CBxpikG8nGvCfgCOYpwmxyr8tbeoR1m+djSHhrdJ4X88ADfcR2pt8rk/uexs?=
 =?us-ascii?Q?YRMmDSoHqzflrDa/okz1X3QNuR4K+kfVHkfAoMDhdLhPj9goY4/fqtCcCeX9?=
 =?us-ascii?Q?An6IwsKfQrzVduoDB6G8YcAYte6dTqnpCEY7XVn69W4hgG/P6uGQkhK5iLLv?=
 =?us-ascii?Q?UhV7Ti9e8RW9em1Hn5zCUnUISAgHKbQpbuo0puoUWkPx7S/1lEukM9k/yQ4B?=
 =?us-ascii?Q?9bJ9YW9lTiiRhoHBo5K4sxrinoJry23Wc+znVMhpQx3sMcgKza+ItufPROP0?=
 =?us-ascii?Q?IkrcSF2lbpaUwH4ch593BwWqB1wHGgXSrEC8CYLHyzsOtJACBKO6Ut6RAqRa?=
 =?us-ascii?Q?Ng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <116E8DB61EAEE34995FDE4D33B6F7C51@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4k07kSzQjcMFkVa0r5anANvC9kliOjC2hV1UEnu/nx7r3Wyc1yWrxPAWzpbGviTc5zVw7AzALLKoCX1+zr+gzZz3f4UknDFjf1fIXDc3wI2V8TDFUtOjbR4AmT5it9TStlHkso2p3f58RYtZVH/YA3ZcjcVjBM6StZ1FRfkdVlemnOc3oDgK0+DaweQwsTY+MoNPUYSCIovg+gu5QoaQZ6jkyt2U1GKJkc4afYuJ8hdbCMPDiUzkFsS++K+fG5fHdlWTPxuxz48L8vh/9XtYx4+Fh+baUlCpZTm8zJs2FzjiZAPdBQooJxOneWFxsuZXEEslTl65a0BB4Vz0m+8+k6aImVDYLn79/k25uwB240rD9hRlkBmg/0tWpC3bhvAGhhyyPLvqSxQGoVWi4O2F1dCql8Sc4XfIbRCbj6S92UjTVjsvItFGu0Ja5+efccIU2qAqxI+6o9Ii98DFAoP/rtcwfuE7U9GOoN6QobzEk/hhW7JalftTkjvg0+f/hHjVzi+z9iRVHjoFFvDeyj1Ep5aaC13Fp1sAn8jEp/IT0bxiKb02BjaLgKXS+zuGSXJywsuFA0RESbWX65IJBHRGe5cD9cnP7E0W753NW9Y3UpxFOjBbdtJ6z6vPwSNTWfIadXrirrSbfRH3Ee9Ts8K5LQEhjnem6UgE9jt7JPUP+2M+pdFiMtngJijEWeH/+ZMKM7ai4clhKmTON3Q5ET6cNND6hmVQ45rkBOcUfrAy+cDdTeLZpN90E4700SIkEpoxju0LSjlzOv8iEdRAWwDWZwZCCixEGyUk/zKaBjW3Kzc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7623fc-b0ea-481b-ff86-08db5566d8ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 17:07:21.7208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O1vrM4H2HwDWFYQV5ZHayKfaCkTBjGl6xcu3eWREhB0g7ynttUNR1Z+SHxqFkr8uO6nWbPYJGHYFN/0E97w6XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_15,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=830 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150143
X-Proofpoint-GUID: -w0xbevWa2b5SHmLmSfyXTun2SibFQd_
X-Proofpoint-ORIG-GUID: -w0xbevWa2b5SHmLmSfyXTun2SibFQd_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 15, 2023, at 12:54 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2023-05-15 at 09:32 -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> The -ENOMEM arm could fire repeatedly if the system runs low on
>> memory, so remove it.
>>=20
>> Don't bother to trace -EAGAIN error events, since those fire after
>> a listener is created (with no work done) and once again after an
>> accept has been handled successfully (again, with no work done).
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> net/sunrpc/svcsock.c |    9 ++-------
>> 1 file changed, 2 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
>> index e0fb65e90af2..2058641ab9f6 100644
>> --- a/net/sunrpc/svcsock.c
>> +++ b/net/sunrpc/svcsock.c
>> @@ -885,13 +885,8 @@ static struct svc_xprt *svc_tcp_accept(struct svc_x=
prt *xprt)
>> clear_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
>> err =3D kernel_accept(sock, &newsock, O_NONBLOCK);
>> if (err < 0) {
>> - if (err =3D=3D -ENOMEM)
>> - printk(KERN_WARNING "%s: no more sockets!\n",
>> -        serv->sv_name);
>> - else if (err !=3D -EAGAIN)
>> - net_warn_ratelimited("%s: accept failed (err %d)!\n",
>> -      serv->sv_name, -err);
>> - trace_svcsock_accept_err(xprt, serv->sv_name, err);
>> + if (err !=3D -EAGAIN)
>> + trace_svcsock_accept_err(xprt, serv->sv_name, err);
>=20
> Would this be better done as a TP_CONDITION tracepoint?

I looked at doing that.

svcsock_accept_err is in a declared class. I would need to
split that into two trace events, one CONDITIONAL and the
other not. svc_tcp_accept() is not a hot path, so it really
isn't worth a whole lot of churn.

Let me know if there's some benefit aside from a bit of
code cleanliness that I forgot.


>> return NULL;
>> }
>> set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>


--
Chuck Lever


