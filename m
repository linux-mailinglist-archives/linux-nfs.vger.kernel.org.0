Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167A96F45DD
	for <lists+linux-nfs@lfdr.de>; Tue,  2 May 2023 16:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjEBOOw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 May 2023 10:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbjEBOOr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 May 2023 10:14:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672DB1FE3
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 07:14:42 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342AKerk017191;
        Tue, 2 May 2023 14:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=e9ic+o7QDGIDPpyyLb5WqQwY0vim+mCJtf2QO5KBckU=;
 b=iyXp27beeSpCw6cJSiTs+vBf6v6bNrEjLNR8Us2R73bB2DMYKS5MgRNUIctx1fpBJscb
 INehtUywjvBqDpJeTF2jJYLGOqdmpkzEoEP8fTY2Xra8BXkOpx4FUf+GZ5fsk3P3+uXI
 tNhIgW370OsKpJ8hZkknhyAkct9g5vJSsR+6SWXJj40OOl6DfkR18iDs7j2C5hxG+yc2
 fDlWd8VOCGgmXzGnSzedRzdPvCnIv3zu8QujGN7TsGnBrPctOhH2MhMpKOGweRS1SmFU
 /iDqSeAoIzg0XTOmU6qxTqWDmBfGpKMsNXYmBu5gH3izUJI58Fnd12JdEAlHMbit9d+M nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4amt3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 14:14:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 342Cnxj7040553;
        Tue, 2 May 2023 14:14:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp5tdv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 14:14:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3CYABHxLVskzVm6c2NqmwZP+SFD/y5VXzYmKpPA3f6Sr35sVfkyicA477iziB5fc1xDBy80iKWe4VtdCRXzQLsPx3RqhXnu1isJxNOsgFHFDaOOend5my4Hk4vBqrcJ93xTQqhbH+uVODM6JCpLgqPLHmKniV5tDdDBWorPR8swLjoHCFxG0mtoOoZMZVWmpi8jSocHV8HrfvFh9WJwLjxKXJTB8ajj4ivWQfLqhoJNbm1CJJ10+pRWbi8PZDdGOjUgeT6mPTdzan2NLik8XJ17yJmnJU5JxQ9YKkCu1pAMiWUoKWjVfG+5cPjPDpgUVwVwePKwKL6yQDf5LNH4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9ic+o7QDGIDPpyyLb5WqQwY0vim+mCJtf2QO5KBckU=;
 b=lfAUB1ZhNHehBjYE+JStrvi7EjJwfonev1ehNMP+wckU3a64mop+DvZnsTcrp0s0N/YSWpHH9syBWPEqpBDamyI74qJ0CRMjdm4aKDLVf7dCeQCOsWombhNORtY2QvIb/NGmm8Mrnt48Hdjp73xu0QsZ0rwqtArRJZRLA14BFYNOy8DIpezd9OfpFsY7EDU/1b3ZhT80Xs1zyhdA8MvUavkL7sOG3ytDS5/aNVQxG0gbAnXAZMVjiMtJpgSZjzF69h0nHkDXt70CrVFY9U0pYpBJQp5JHPN3fQrNQk0b6QrPtUo++cO6jg8q2KfO2igyhuRFK+z2+OViWbubIZ7Brg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9ic+o7QDGIDPpyyLb5WqQwY0vim+mCJtf2QO5KBckU=;
 b=y5Jyf99YX0EFwdAlkMqVSYqIDjkn8yGhI39BiVrtn3VFUkESKLW2rXJOGtEznK7JcygU1umnF7x0Tcx4OfVJ4JmCLRWuGmnHczHbmE/F8RRbFdVOtrvhbHbOBKv3GHTjAuToEc58sXyF43sPvEASdRGBTodZVXcqyiPd+5EKdmk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4912.namprd10.prod.outlook.com (2603:10b6:5:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20; Tue, 2 May
 2023 14:14:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 14:14:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Steve Dickson <SteveD@redhat.com>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v1 26/27] SUNRPC: Set rq_accept_statp inside ->accept
 methods
Thread-Topic: [PATCH v1 26/27] SUNRPC: Set rq_accept_statp inside ->accept
 methods
Thread-Index: AQHZI37QRUQ4TvDJik2GwoQT/5RlW69HhAGAgAA1uwA=
Date:   Tue, 2 May 2023 14:14:21 +0000
Message-ID: <4AB1ED03-57C8-42C1-9A04-6C224E98EDCC@oracle.com>
References: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
 <167319546521.7490.43383592461162363.stgit@bazille.1015granger.net>
 <3e34a2dc-7d72-b719-248f-e78361db8a5b@kernel.org>
In-Reply-To: <3e34a2dc-7d72-b719-248f-e78361db8a5b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB4912:EE_
x-ms-office365-filtering-correlation-id: b6c11cf3-2ffc-4c6f-a0bd-08db4b178640
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tY3J4iW6lBNEOibrQcEVD13GV5M0eCLcr+am9oa9VzdkPKLaeKISz9sxwP8RfxVhSl3TksWefT+IEidod5JrkjnBVv4lyJbWG/QMvDumUCfHtJJSUnfnLBZ43YzBo4JkFPx9TFfWp390VnWGJcRHEdAo/nP4dPpXN87ze1P0+lOTjJ1hUM2focLPh8p56T92BJwqKrAAU37i7LwkPE9rg2pOesGOEI/9XHau72D1JQ/QjvktV9ihAz1jCUYYLbsAT91rfq0dB64ROuEGFWk/lgq9cIQW+aiBwMiFY5/1BWPvA241qIfF+K5G7fwEZmSzJTy6bIldv/ObnoPy5ZqEn80Y/zwiTcSEmPQr/35X+WrMeOy469apWCt0KH6OuODwpgYW2ULST062xDYPU2eyTLuyrOHDIuT3gNwPLhYx6yR55Es+PYt7qp9RZBfzZ7sudo+cGR3TbqRjXEzblLncCCJ1q7w+EREN/velBZNdh0Qf7ybRzXIwRDWQMITzYTZvnY6wj06SurChEqigQxesD9D26zEQfRB2aCyXy+8P48Vcxv6454UME2Sx2CnSLKUhMcR0tusBTDfjFKIMM3QxQueadkxip3ksQyVVts3T35Uwk5FaNPKxErGGpncqmalotXpbiuPS3WEXFld4+wm1vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(64756008)(66476007)(66556008)(66946007)(66446008)(76116006)(2906002)(86362001)(2616005)(5660300002)(8936002)(8676002)(36756003)(41300700001)(316002)(4326008)(91956017)(54906003)(110136005)(478600001)(33656002)(71200400001)(6486002)(966005)(186003)(6506007)(6512007)(53546011)(26005)(83380400001)(38070700005)(122000001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Dn6cutfGQYdLZd0TzAZa/PbHWcarbRyjDzzaAS7QyR7yM+horVQQR/GyBc0v?=
 =?us-ascii?Q?ownH/Vz06rTnBA2G+SDPBIDIpueVE/FRz4PPziDc5qCCc7X7ZJGks8z16Fjb?=
 =?us-ascii?Q?4CrBFy3b+y+0yDhh8NhUDKB1mNoSirbISjvP6K2kgsQu4JaAp6hbMDJv4F7r?=
 =?us-ascii?Q?nxFHpIx/8bTSKjFOVVgXWkwZdMBtkshzb4tOP1uxCbbg7A7yfbn+zuQuzWW6?=
 =?us-ascii?Q?H9NsMQJSVEnLJF96tYoR91P95/POkALEd9XixPPG2WzCqea6OQLu0XmDz5Ou?=
 =?us-ascii?Q?5ewQrl9qRmnOgUJ7vgRI3caqdDsLpuNYl+3zN3OEA90+iQoJGRmeCnMYvW5g?=
 =?us-ascii?Q?hZMW0Sx8S6x9Pd2f29qkuORRol3oONkOpKxEYEsvYqAF7RINq7Jgiwa69ltN?=
 =?us-ascii?Q?lDVlWbND2v5XbR+bnkwsqXPOx1KbUt3tcJzLy5ZONle5LVEKQ0YE/gDE10At?=
 =?us-ascii?Q?xEj6smQSrCnKLGFQveGif5QM2eTJTdgUJQK0p+o3+4Q9CO7+ZXN++/qSh3Gu?=
 =?us-ascii?Q?v7JUhzqUWscBdTfDYFexc9J2mIvfZ9QWTzjrW2CNeNY7vAy/JY+4ofAgps3G?=
 =?us-ascii?Q?SVVZQmIrFGmrDABoszx4TQAqc1Lk+oAyRvX/bZiPmAfuzSshHoalkd6DwjgT?=
 =?us-ascii?Q?ZfWEpgsxHfQ3c9XVqD3FqGKA2EKGLB7bjCvKbBP7yUeYUli9ONBMW8ybklzo?=
 =?us-ascii?Q?FXe/KQdyds9qNEcKzUeAS/QHzgJHZyjtoDsSGpqjk20K/lncDUW0ac3WtSB4?=
 =?us-ascii?Q?EuBfmkURKiTFg99ON3KmVus36LU7l2TA1cj1vSIW8mPSEAJiByBRjG5ni9EM?=
 =?us-ascii?Q?m+hYjyPP7DUXCdwFjDIwwYxblRn7/AYK73PLu+T9LiBrDkzHbtI/Yd1Aoyq7?=
 =?us-ascii?Q?xGHR+HKuzHwVNm4DzLC2WjgHhBhmh1NK/7L2Axb/EkD+Rne3fTCbidzYAy+j?=
 =?us-ascii?Q?aaDV8kcuxM+dpThCgt0Eovvyeg1r9lJW9lLTrlF1Vgw6aUFYrXEnX1Rettkm?=
 =?us-ascii?Q?d5df6s4SaNxIjRDulldze1NYZBmfKJJJn9K4C2jfdlwKb8gyYDl11PoYFMXB?=
 =?us-ascii?Q?nw1oPYgqrfxTMTPcM18PODn/hk/EPi0n9MdJFrbLnIbrglloWTY+NFVj70rJ?=
 =?us-ascii?Q?ieVQyGfsoFVeGjd0/BWstOHbV6+H0HoreOwnd/SNMbAr0PeO8DXoMwB+A343?=
 =?us-ascii?Q?WPNs6mu5yJ761CLkJVplw3ou+N+XF7SwRNojygE3GqEe0cjta3tIiIxeg5q2?=
 =?us-ascii?Q?R2UkZSxBlMCl/D8MqjvNY58YbdHe4rI6gqOV9xOHlRcPE0/LjHsG2JbmKBoT?=
 =?us-ascii?Q?+zckAOKR/8NPFEwrJqtovO2iouPSr3+5dKd/FH9YZXP+94aBgLxpDHkz/K6Q?=
 =?us-ascii?Q?ODDPdKVb8K5YXxujWrMS4jSKnLgYhLKPBH+abPUsP2ieUbNK8IhYxh5GZjbo?=
 =?us-ascii?Q?yE9hWsdV8MZqtkDu0CWm+qOqI5/H0IGfO3DDXSBK9zhuvjD2KxD5VNd4oJF/?=
 =?us-ascii?Q?JqlNDgApIKvrjvgbFrvB9gHJyWcWPw7oDwiC6w2w6LuwdFWBhWFnA9pABmtj?=
 =?us-ascii?Q?8yhmi26/N8+1QB37oQm3bdBMrv9uzO4eDCb7dBeDmmWCktfrOj2ufNiz85c0?=
 =?us-ascii?Q?0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98B79DA2E1FF43459114CE6E5F5337C9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1OZLXeKR0jgIoOF6qBP5dmU367ws6VDzN0IOjYny4oSkLs2lZeu3l1N2InQcs8ueMIkRARyMUM05oCkWhUmkOfd73o0sZKY9FVrTgvnWxEeA/tV/fpgjf5rhGpOW4Ospz8M4oINSaRYsSoAjmMpsVYMsF8KqnZo5c3FYEGD5C1gKYbsYZtJC9DUVW/r5vF/KvkuC680i2VpsDBSKrBthhjqfiKNUv7+WaHCI810fvylfao9s88NvHq+52yzP1k0JjFXlFsCpggYeSuaUINLtk2qnXh6CVMNEmdOFHhA3G+hcNbdhPInNUk21gQ1pTW1OHjb7nG+/APk4i4MP6NjsDMvrNmyA35SQjXDR7FyxtlYt3eMM3YnPZHs9fi1ZWY6v5et5rQ8/Y4bo82JLqxNtQVU08KyPQZx5Fpjuaqf5mNSWZXc/GuILnF97Z5DIDl6iQyj56tDLKZtUYbRwtFIvZ+Rn0XYMACfhbnnXq99X7R61+rTYg8DmnqGgwqk1g8Ayoq/mzW6edp2ywGPoAepv+y7kwPcCOVqYo911GW3692fKojAr449zvbDhitvLBczEJOtUhLRT6OrPGdmGqsmImyl4OTTu30KeSS6md4uhYcky6v247N2/cla1eS2YrsWnYvT7M0Agw4MiHOSYtY0xs9ubVDHC4UAn/T8YlQNUoif5VD6yEG/YcHcfWb5bUcUuVGS/0kXFl2uARXEb2NzfyfLaDU32+Y9ICeDvVPn/ZcyTlD8MxqisHqJv4SDS+eMW0Ugcag7Z0LIzCtUboFjkUJ3iZrinbwY7iSG/j5THQIveCcX6X90z9O8eI315ZENnMALM8BPcfBYRM+cohgKg2A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c11cf3-2ffc-4c6f-a0bd-08db4b178640
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 14:14:21.1346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rnA0vIgKs3kAdMk1V17oHWNlS4t/Hpa6SoCLLcs7rqzH6Q6g3q46yyolZlGQe69PD+1xhFWfziFnrP2Ck+dfFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020121
X-Proofpoint-GUID: Bd_iUDOQSOBJ5kng9uszdrLzxq5U3lJZ
X-Proofpoint-ORIG-GUID: Bd_iUDOQSOBJ5kng9uszdrLzxq5U3lJZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 2, 2023, at 7:01 AM, Jiri Slaby <jirislaby@kernel.org> wrote:
>=20
> On 08. 01. 23, 17:31, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> To navigate around the space that svcauth_gss_accept() reserves
>> for the RPC payload body length and sequence number fields,
>> svcauth_gss_release() does a little dance with the reply's
>> accept_stat, moving the accept_stat value in the response buffer
>> down by two words.
>> Instead, let's have the ->accept() methods each set the proper
>> final location of the accept_stat to avoid having to move
>> things.
>=20
> Hi,
>=20
> I bisected to this (4bcf0343e8)

Assuming you did the bisect on the NFS server's kernel?


> as it breaks nfs3-only servers in 6.3. I.e. /etc/nfs.conf containing:
> [nfsd]
> vers4=3Dno

Note: Changing the settings in /etc/nfs.conf had no effect
on my server, so I effected the change by stopping the
server and poking values into /proc/fs/nfsd/versions by
hand.

Steve?


> The client sees:
>  mount("10.0.2.15:/tmp", "/mnt", "nfs", 0, "vers=3D4.2,addr=3D10.0.2.15,c=
lientad"...) =3D -1 EIO (Input/output error)
>  write(2, "mount.nfs: mount system call fai"..., 45
>  mount.nfs: mount system call failed for /mnt
>=20
> And the kernel says:
>  nfs4_discover_server_trunking unhandled error -5. Exiting with error EIO
>=20
> I reported in downstream as:
> https://bugzilla.suse.com/show_bug.cgi?id=3D1210995
>=20
> It cannot be reverted cleanly on the top of 6.3.
>=20
> Any ideas?

I can reproduce a similar problem. Network capture shows
that the server is responding with NFS4ERR_NOENT to the
EXCHANGE_ID operation, and the client kernel log says:

>  nfs4_discover_server_trunking unhandled error -121. Exiting with error E=
IO

That's not the failure mode I expected given the commit
you bisected to, so it might not be the same problem you've
hit. I'll troubleshoot this and send a fix for testing.


> Thanks.
>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  include/linux/sunrpc/svc.h        |   19 +++++++++++++++++++
>>  net/sunrpc/auth_gss/svcauth_gss.c |   21 ++++++++++-----------
>>  net/sunrpc/svc.c                  |    2 --
>>  net/sunrpc/svcauth_unix.c         |    6 ++++++
>>  4 files changed, 35 insertions(+), 13 deletions(-)
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index f40a90ca5de6..392d2d2620fa 100644
>> --- a/include/linux/sunrpc/svc.h
>> +++ b/include/linux/sunrpc/svc.h
>> @@ -544,4 +544,23 @@ static inline void svcxdr_set_auth_slack(struct svc=
_rqst *rqstp, int slack)
>>   WARN_ON(xdr->p > xdr->end);
>>  }
>>  +/**
>> + * svcxdr_set_accept_stat - Reserve space for the accept_stat field
>> + * @rqstp: RPC transaction context
>> + *
>> + * Return values:
>> + *   %true: Success
>> + *   %false: No response buffer space was available
>> + */
>> +static inline bool svcxdr_set_accept_stat(struct svc_rqst *rqstp)
>> +{
>> + struct xdr_stream *xdr =3D &rqstp->rq_res_stream;
>> +
>> + rqstp->rq_accept_statp =3D xdr_reserve_space(xdr, XDR_UNIT);
>> + if (unlikely(!rqstp->rq_accept_statp))
>> + return false;
>> + *rqstp->rq_accept_statp =3D rpc_success;
>> + return true;
>> +}
>> +
>>  #endif /* SUNRPC_SVC_H */
>> diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svc=
auth_gss.c
>> index 560fb8a2803d..333873abb7d9 100644
>> --- a/net/sunrpc/auth_gss/svcauth_gss.c
>> +++ b/net/sunrpc/auth_gss/svcauth_gss.c
>> @@ -1220,7 +1220,7 @@ svcauth_gss_legacy_init(struct svc_rqst *rqstp,
>>   if (!svcauth_gss_proc_init_verf(sn->rsc_cache, rqstp, &rsip->out_handl=
e,
>>   &rsip->major_status, GSS_SEQ_WIN))
>>   goto out;
>> - if (xdr_stream_encode_u32(&rqstp->rq_res_stream, RPC_SUCCESS) < 0)
>> + if (!svcxdr_set_accept_stat(rqstp))
>>   goto out;
>>   if (!svcxdr_encode_gss_init_res(&rqstp->rq_res_stream, &rsip->out_hand=
le,
>>   &rsip->out_token, rsip->major_status,
>> @@ -1348,7 +1348,7 @@ static int svcauth_gss_proxy_init(struct svc_rqst =
*rqstp,
>>   if (!svcauth_gss_proc_init_verf(sn->rsc_cache, rqstp, &cli_handle,
>>   &ud.major_status, GSS_SEQ_WIN))
>>   goto out;
>> - if (xdr_stream_encode_u32(&rqstp->rq_res_stream, RPC_SUCCESS) < 0)
>> + if (!svcxdr_set_accept_stat(rqstp))
>>   goto out;
>>   if (!svcxdr_encode_gss_init_res(&rqstp->rq_res_stream, &cli_handle,
>>   &ud.out_token, ud.major_status,
>> @@ -1640,16 +1640,18 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
>>   case RPC_GSS_PROC_DESTROY:
>>   if (!svcauth_gss_encode_verf(rqstp, rsci->mechctx, gc->gc_seq))
>>   goto auth_err;
>> + if (!svcxdr_set_accept_stat(rqstp))
>> + goto auth_err;
>>   /* Delete the entry from the cache_list and call cache_put */
>>   sunrpc_cache_unhash(sn->rsc_cache, &rsci->h);
>> - if (xdr_stream_encode_u32(&rqstp->rq_res_stream, RPC_SUCCESS) < 0)
>> - goto auth_err;
>>   goto complete;
>>   case RPC_GSS_PROC_DATA:
>>   rqstp->rq_auth_stat =3D rpcsec_gsserr_ctxproblem;
>>   svcdata->verf_start =3D xdr_reserve_space(&rqstp->rq_res_stream, 0);
>>   if (!svcauth_gss_encode_verf(rqstp, rsci->mechctx, gc->gc_seq))
>>   goto auth_err;
>> + if (!svcxdr_set_accept_stat(rqstp))
>> + goto auth_err;
>>   rqstp->rq_cred =3D rsci->cred;
>>   get_group_info(rsci->cred.cr_group_info);
>>   rqstp->rq_auth_stat =3D rpc_autherr_badcred;
>> @@ -1706,7 +1708,6 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
>>  static __be32 *
>>  svcauth_gss_prepare_to_wrap(struct svc_rqst *rqstp, struct gss_svc_data=
 *gsd)
>>  {
>> - struct xdr_buf *resbuf =3D &rqstp->rq_res;
>>   __be32 *p;
>>   u32 verf_len;
>>  @@ -1721,13 +1722,11 @@ svcauth_gss_prepare_to_wrap(struct svc_rqst *rq=
stp, struct gss_svc_data *gsd)
>>   p +=3D 1;
>>   verf_len =3D ntohl(*p++);
>>   p +=3D XDR_QUADLEN(verf_len);
>> - /* move accept_stat to right place: */
>> - memcpy(p, p + 2, 4);
>> - /* Also don't wrap if the accept stat is nonzero: */
>> - if (*p !=3D rpc_success) {
>> - resbuf->head[0].iov_len -=3D 2 * 4;
>> +
>> + /* Also don't wrap if the accept_stat is nonzero: */
>> + if (*rqstp->rq_accept_statp !=3D rpc_success)
>>   return NULL;
>> - }
>> +
>>   p++;
>>   return p;
>>  }
>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>> index 3c194e6f8f5e..c2ed8b06fadb 100644
>> --- a/net/sunrpc/svc.c
>> +++ b/net/sunrpc/svc.c
>> @@ -1314,8 +1314,6 @@ svc_process_common(struct svc_rqst *rqstp)
>>   trace_svc_process(rqstp, progp->pg_name);
>>     aoffset =3D xdr_stream_pos(xdr);
>> - rqstp->rq_accept_statp =3D xdr_reserve_space(&rqstp->rq_res_stream, XD=
R_UNIT);
>> - *rqstp->rq_accept_statp =3D rpc_success;
>>     /* un-reserve some of the out-queue now that we have a
>>    * better idea of reply size
>> diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
>> index b101700d155c..62dfc8cdf8c5 100644
>> --- a/net/sunrpc/svcauth_unix.c
>> +++ b/net/sunrpc/svcauth_unix.c
>> @@ -775,6 +775,8 @@ svcauth_null_accept(struct svc_rqst *rqstp)
>>   if (xdr_stream_encode_opaque_auth(&rqstp->rq_res_stream,
>>     RPC_AUTH_NULL, NULL, 0) < 0)
>>   return SVC_CLOSE;
>> + if (!svcxdr_set_accept_stat(rqstp))
>> + return SVC_CLOSE;
>>     rqstp->rq_cred.cr_flavor =3D RPC_AUTH_NULL;
>>   return SVC_OK;
>> @@ -866,6 +868,8 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
>>     RPC_AUTH_NULL, NULL, 0) < 0)
>>   return SVC_CLOSE;
>>   }
>> + if (!svcxdr_set_accept_stat(rqstp))
>> + return SVC_CLOSE;
>>     rqstp->rq_cred.cr_flavor =3D RPC_AUTH_TLS;
>>   return SVC_OK;
>> @@ -960,6 +964,8 @@ svcauth_unix_accept(struct svc_rqst *rqstp)
>>   if (xdr_stream_encode_opaque_auth(&rqstp->rq_res_stream,
>>     RPC_AUTH_NULL, NULL, 0) < 0)
>>   return SVC_CLOSE;
>> + if (!svcxdr_set_accept_stat(rqstp))
>> + return SVC_CLOSE;
>>     rqstp->rq_cred.cr_flavor =3D RPC_AUTH_UNIX;
>>   return SVC_OK;
>=20
> --=20
> js
> suse labs


--
Chuck Lever


