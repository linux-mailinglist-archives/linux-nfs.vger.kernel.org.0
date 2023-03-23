Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85556C6FC6
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Mar 2023 18:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCWRz6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Mar 2023 13:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjCWRz5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Mar 2023 13:55:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD8A29E32
        for <linux-nfs@vger.kernel.org>; Thu, 23 Mar 2023 10:55:50 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NHZ5dh004167;
        Thu, 23 Mar 2023 17:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NJ1CnYj54qPGoZv55rnqr314GzAiE3mP9gxxYuoDUu8=;
 b=Qsuvak55MCoAiWyQ0HZobgQO1vXPphrajqc9adlO77lNlFa9oQ27NPiJThfth8irr/9K
 JAKHaE333eJp8iDh2wCMqjlsT0YUJ9TRo18gm0WH37XsJsn5HINbcQez+QTFsrjE7RK+
 lRq+wCOPMZLHlQ/fPgaQLVhdX/g/lHawQ+kKZBmSjgS6uTjhz2qVOsksNZV7LOBxinCH
 yMO6Suag0OU4sMVkhOlt21B02ghp4REJ0t2JDfZ48fZxRNf9bNL/U/uJ17JSRB6wFjXY
 MjPL+7TaxGU+FMW+3mRc1/R+R1BAvZTuYZ0oPbK4LrYmwAU68OQWtCFMQ8VGlupbW3or ZA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pgu9rg2bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 17:55:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32NGsTlM028175;
        Thu, 23 Mar 2023 17:55:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pgtpvjbad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 17:55:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=In67Ot/HN++Ol5hdDb2b29hefTn3o5uX5lSwZNlN368K2xBofgH3C6fFSqiSzaac436nNx8G8wQxsoL0PoTKvdQdV4zaDGhErTu/VyYXNJrNuR6W9ZKVCqe624w8+sDBdZH6swTTWRcGudAowGrdWAvJAvlRaTmWk/loMFS+VWMq3QknADq2bEofWUx8yC5H/+3sYUwMSgdsMpFLecwd6rdWLiTdalEcnl3WbA6sTrXtXKPOFr2T5fEihkJj79VsRrehd1wYlWHCu3mm03lE5mW+8ULBpC8JpFkdAt9tcbdHRKO3zm9v7lhLIgunilMl0G7zwXpcHlzuKNqrAkgYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJ1CnYj54qPGoZv55rnqr314GzAiE3mP9gxxYuoDUu8=;
 b=XE+/i8/+vER9U3y1bAObdPOyIzLRX5qbsXZcWZqHOswE+Yea4PzYBJLMow/SZejGBgxrtkoGmluF36N98i8tmvpYKRjYOgIMem+uTNVleUkdWxgS6GktKIiRqAQCRWKM4gJBbEuSkQnTbfG0QyNjAqWD2cSy9TG0F6bZB2pgsVybfYy7l1WVJZmX0ae4IbrxKlC3QbJ08h3JPkhi6zPcsSFsXfvvkqS38yP0SFNlH1eLI/9GBUwPrx4pjPpmrSTfZg0BILxl5bnbxkpC2f9O8QMmvRZBOAGnHm9dcmYhLCkoCyRHsDXFbv3m7QJyhfp4880DtV3EtQpJEYOMBQQhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ1CnYj54qPGoZv55rnqr314GzAiE3mP9gxxYuoDUu8=;
 b=ZXNOTnRai/iZyf+ffRVnOyozraZgSpnxBtozFtjenO6N2zFD84YmhHSejNLp/VT9riEwqb8R6+NzLODuK5BTLabfTunZim9flwjN58xRQ7HJapHQ0oUJFpGSD/KL1lawizOvfrFr+l9JfUqISprjuPcBeaAoroz8d5ckrAUXRb0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4519.namprd10.prod.outlook.com (2603:10b6:510:37::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 17:55:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%8]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 17:55:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steve Dickson <steved@redhat.com>
CC:     Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 2/4] exports: Add an xprtsec= export option
Thread-Topic: [PATCH v1 2/4] exports: Add an xprtsec= export option
Thread-Index: AQHZWzlIazFNUyn9IUyGBvjG1zIbKq8FIbkAgABn/4CAAA4xgIADEnsAgAAAeoA=
Date:   Thu, 23 Mar 2023 17:55:32 +0000
Message-ID: <BCBC04D8-960E-4025-BBCA-654F357BF7F9@oracle.com>
References: <167932279970.3437.7130911928591001093.stgit@manet.1015granger.net>
 <167932293857.3437.10836642078898996996.stgit@manet.1015granger.net>
 <b1da1fdbb190f50409f9fcd18b466defdfc04353.camel@kernel.org>
 <07F10068-A3E6-4C45-BB1E-F67FF4378155@oracle.com>
 <01df993e636b200dbd7636946761208bb183d5c7.camel@kernel.org>
 <5463b973-7395-8150-f1f7-fe26c3d86443@redhat.com>
In-Reply-To: <5463b973-7395-8150-f1f7-fe26c3d86443@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4519:EE_
x-ms-office365-filtering-correlation-id: 172df4c9-43c9-4c0c-70a1-08db2bc7cbcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kC6otOeGrlTQigFKhkszrFkGJxfsJPpRYnh+BgqSqTmbgLX5I1m6HJIU4s7PjBKq9DBLOZ8NPatYYUOdrDIR0fSoQWeN2177RM4UFhXndPIRlThqJMuqtw1I5xVz+iMBgIJbaktP9XkuZx3HBGJGm744mXU6/Sfgof6CiGRmiDxVaYkUgHaJTH9AcGp9fnDudf3KZkLSkmJQEisEZkOxqiUyfS0rHuw9CtslleR3iQEefWUoILU6eUFAH2pcKckUtaqxwQUo5/BVENZdhor3CDuG9RWeAYu397Jpiqiq+Y4Y2gYlhts9S/+JWHCllfVcN3YJB/2n177SqIbyU5IWLp1WIRBF83c/rFvGopwWMRG+C9z8Mbfawz0maXbeL3e8b5yUKG/4ge8zIUt0tMApsX/8ydb+645CElD1n/BxP68Tck3F1L9I1pmqKMxEuyQk31ZAW+7vNm2WNyULSvxlxK9GYLa0vAZxbo2IV3s692S21Ubetzd5+EMpDfMOmP6/+0Al3UG6n84mm32/U29Oe/H3iCfaLlQqJj6/7LLDfXXyX9+OaJn6kAPSwerpoKw60kfzPqQ3+zQbnRmg1pRaKY+Yw260FQqgWPSuSH4SV+n2zCVNAzB8dCm83tQBvQfHmFsG6cCIKH2mkzTWGy96plLBL6+MS2owmmUGVneijKy87kDmV1KGbo+UpuA7mCmb8U28zXxQyPHRGTbXZZUFyo4o8glXENadO6o0R7G2xo0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199018)(36756003)(33656002)(38100700002)(76116006)(8936002)(4326008)(6916009)(8676002)(86362001)(66556008)(91956017)(66946007)(66476007)(66446008)(64756008)(41300700001)(54906003)(71200400001)(478600001)(6486002)(316002)(5660300002)(2906002)(26005)(6512007)(122000001)(38070700005)(53546011)(6506007)(83380400001)(2616005)(186003)(66899018)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4XADBR4mZhzbaLyffT/oViVn8+p8ZxTYeYLq4W8v6G0ri+7KCVBa/vkPh10A?=
 =?us-ascii?Q?uDzP91G4hR9GP6LyhddwJYiLt/pm6iEOjOj4mq6ELpDUTgTNMk6QkUl+m8px?=
 =?us-ascii?Q?QLzoJ2SZyrxmhz9plfLEWB0aQE4lFj4fwHK8zmGlVoIf+L2qgAUuS2GP+t9B?=
 =?us-ascii?Q?Jh9LSQMfi8fK7B7+yrnu+WM5qqk4uOcC+iIVJry7TudMiqEVBLyjI1cIpI7m?=
 =?us-ascii?Q?onDCHq8UCoPhlXU57ucdTdITC4x7ZCaIhrWAFbYpjkiQumEnhGcFCwxIIcgw?=
 =?us-ascii?Q?GftmottVeO4IXi7cTAH/0PTwNPhjIZNg8TZrVqX4GiWJtjQ4or9deMgNAPDv?=
 =?us-ascii?Q?YuEiyESlBRrJ9sLo17AOjQtSo0x1vYplqMrJr5XFL2g+MMMKJ/ru/rLai/X9?=
 =?us-ascii?Q?NzjHg9kpBKHzo0rZiJDeLniovi/jTqVuRPFvkuXY0LtKldaNsvNnR7KzNwHf?=
 =?us-ascii?Q?nlmOtBgDWzA10IeDa9CviMChIVo1naWCzdbOw3NMcBePTM/WscV6ddXFXYJD?=
 =?us-ascii?Q?1KwpzS6NVyCZUz4HxEVC0x01mRqsTI3u49aMRFElu61UjdGstCOHZusN+HQ6?=
 =?us-ascii?Q?ftVlZA2VEyp5tRpsYKMZB2Z892odaWkNXuRFAM66e5A+7qtdJhLuAonGLHzD?=
 =?us-ascii?Q?jBqqM2UIEWanwZF3bUdKbsKR8U+vkn5ChBLxFF4PYv8IeFuvwU4kw9gzE+rq?=
 =?us-ascii?Q?ZUiWdRmxgnFlDvo8BdQNp2wiC0vby/FQBgzRaR/1rp2EFzz5hWuAphCSiaMg?=
 =?us-ascii?Q?NNPRn0BxoyS7vCqYTNT8pRogvzRYHUBskKw0rFT8o18Ws7e8tZQ8bwVS5nwN?=
 =?us-ascii?Q?ngYsn9DkMibUsqESE9ut1J1402YuEU4q/T/fp0DwJDxA8HNo5iGWmAyIhzqp?=
 =?us-ascii?Q?B1JiCWbHMDdUEiziCtg8oN6vToITHzKwJJ5p68MJD9pKpqQSNN0//ERzUfQp?=
 =?us-ascii?Q?h/ISyl0rkrWp5ic0+rX29XvOxoWLHUXmXPlIspzusFoQW/Y2wlFOgMvCUcxx?=
 =?us-ascii?Q?u8m+5h61LUVMELxxy5EJVCdmFKniitSuTpMJAXyZ5pJBLHGjOigyKtSRcrp+?=
 =?us-ascii?Q?mqx1Gqf+ohVBMWdd2Mja3RJroGLYgP7TcOqMyzj4FSEB+GQhUyKGkYtCAAg6?=
 =?us-ascii?Q?vXEG91cpaPVttlJHUA2FIN8IAmy/IOYxqL2uh2ACdYvJ6Vvkb9kdGCfeOmkT?=
 =?us-ascii?Q?X6zCKi/amRoQvm8hvdhWvuXInutiG0+WvxIBZ7v6/A0uS9SsNgWe9yOVbjcY?=
 =?us-ascii?Q?5u1DZCaybOSUGYfdVU9LVgZoAlW7ZHu+dbZtiJoepTeKOLX9aV0SOO4coMrp?=
 =?us-ascii?Q?lr4aHnb7eHyWSI+3xevPr87D2pGZe4ygPdhv8ICaN8FZzbBMjXCAfmz4SLUF?=
 =?us-ascii?Q?K9BobKjQyT0k3Ck+LECfUXtzfdCLa0JQKK8NSuOoOnFdD0+LTPTaDpFie2rh?=
 =?us-ascii?Q?/IrS6eQUrnRCEJRPsyaRXtpJZErVNIaeVECxf9p3SiRkYImbjp56OzX02taB?=
 =?us-ascii?Q?yhoNS4MlXs0UJRYdHHBk3nT3/4VpzbyiBwkm8+5JRRNqppJKh5II73HzP4Pa?=
 =?us-ascii?Q?zDjTwGlD4fUljABSxzZ7fR6CyLOzQTAGeUeWIPbc5U/x6CYkaHlmPCOD33aQ?=
 =?us-ascii?Q?ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <54FF9FD0BF76144EA23D4C35B8A7F8E5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qxk0aY8h6ewiL+tF9zMVT0b6JGu9K7c+zTXW10c/PlFWI+R/peAkXV3M6NC4bRVafoGe7TOsr8WMEKB14nN1qF/6kiO9brQptciTmMO1Whes7Spg1Jk8YbOZ7A3P+txyzzWi72QU8h263ait1qvdBtzRi+dfidEOxMDxi6ELAE9aP0r5I4Ujb7RVdvo4lhrEBRAOrwG5TlP2sk6XWH6q5aDmeV4jwr8Cc9cGGxErqTfQSlkKHJBHTq2lcG15OLjnneeXpaFBNdbenssOKmykA0Ao2BhGCY+MbEIH0tjmCYhvL1ZBQYJZvJhmr3N24rYLw02Hoe/zkUDEwurY5jJdjkXzenibOk+AEiHOuOmZkZ14e3/XhKHfl6wCf+NL/ztcR8c9Zc20KvGvfyr6H1xR0Woprj1+uCNHRsNKSUrVfELWMhf+jKX+/QN+VQ5XYP5MYKth1k/PoZvsLpwjN8niC3zkRTGC0Em2ZX4P117dzH00UGB1EFuJkm3f84ARd9aakjRMDMtRu8QUQg8lk4qjDIURCa6ziHVUcPYq2avefdQ7N4dxIKsP03f3TchR0wQAD52Cbv0kx1KuKO96eUeCt8LIk2GbOq3hLAEWUDzEGL2jNGTok8seLcEAu9yXzQuVUCMaI8qlmmAd2eCmXGE1c1u13q1bcvMPM99DM6VQ6fmgxNsI3JxQ9q1ezpVfmlFo/wKiAVY3wE+di7jDVWbqO98Xtj7g+7GjKS2gB8mTBUWe5quTzM6rYbjEYkHq3y3uAXWPfi5Jklff5/n9JclekVvcK2Uo91Emd9KrY8pSzpjSGf95PxVYohpVXjRl9CWw
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172df4c9-43c9-4c0c-70a1-08db2bc7cbcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 17:55:32.0247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZLzmXLaTlNSEaw2wLENRxc8TnjPUo/07HZ/OJwkpuijN95QYDjwinwD4F2sMsYm7nGEaDopIMO1v4uLHPxn+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230130
X-Proofpoint-ORIG-GUID: Q6KgZiVqYG-RS_dtvFMsmxDmDh2fxhkq
X-Proofpoint-GUID: Q6KgZiVqYG-RS_dtvFMsmxDmDh2fxhkq
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 23, 2023, at 1:53 PM, Steve Dickson <steved@redhat.com> wrote:
>=20
>=20
> Sorry for the delayed response....
>=20
> On 3/21/23 2:58 PM, Jeff Layton wrote:
>> On Tue, 2023-03-21 at 18:08 +0000, Chuck Lever III wrote:
>>>=20
>>>> On Mar 21, 2023, at 7:55 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>=20
>>>> On Mon, 2023-03-20 at 10:35 -0400, Chuck Lever wrote:
>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>>=20
>>>>> The overall goal is to enable administrators to require the use of
>>>>> transport layer security when clients access particular exports.
>>>>>=20
>>>>> This patch adds support to exportfs to parse and display a new
>>>>> xprtsec=3D export option. The setting is not yet passed to the kernel=
.
>>>>>=20
>>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>> ---
>>>>> support/include/nfs/export.h |    6 +++
>>>>> support/include/nfslib.h     |   14 +++++++
>>>>> support/nfs/exports.c        |   85 +++++++++++++++++++++++++++++++++=
+++++++++
>>>>> utils/exportfs/exportfs.c    |    1
>>>>> 4 files changed, 106 insertions(+)
>>>>>=20
>>>>> diff --git a/support/include/nfs/export.h b/support/include/nfs/expor=
t.h
>>>>> index 0eca828ee3ad..b29c6fa4f554 100644
>>>>> --- a/support/include/nfs/export.h
>>>>> +++ b/support/include/nfs/export.h
>>>>> @@ -40,4 +40,10 @@
>>>>> #define NFSEXP_OLD_SECINFO_FLAGS (NFSEXP_READONLY | NFSEXP_ROOTSQUASH=
 \
>>>>> 					| NFSEXP_ALLSQUASH)
>>>>>=20
>>>>> +enum {
>>>>> +	NFSEXP_XPRTSEC_NONE =3D 1,
>>>>> +	NFSEXP_XPRTSEC_TLS =3D 2,
>>>>> +	NFSEXP_XPRTSEC_MTLS =3D 3,
>>>>> +};
>>>>> +
>>>>=20
>>>> Can we put these into a uapi header somewhere and then just have
>>>> nfs-utils use those if they're defined?
>>>=20
>>> I moved these to include/uapi/linux/nfsd/export.h in the
>>> kernel patches, and adjust the nfs-utils patches to use the
>>> same numeric values in exportfs as the kernel.
>>>=20
>>> But it's not clear how a uAPI header would become visible
>>> during, say, an RPM build of nfs-utils. Does anyone know
>>> how that works? The kernel docs I've read suggest uAPI is
>>> for user space tools that actually live in the kernel source
>>> tree.
>>>=20
>> Unfortunately, you need to build on a box that has kernel headers from
>> an updated kernel.
> I would not like to add this dependency to nfs-utils or sub-packages.
>=20
>> The usual way to deal with this is to have a copy in the userland
>> sources but only define them if one of the relevant constants isn't
>> already defined.
>> So you'll probably want to keep something like this in the userland
>> tree:
>> #ifndef NFSEXP_XPRTSEC_NONE
>> # define NFSEXP_XPRTSEC_NONE 1
>> # define NFSEXP_XPRTSEC_TLS  2
>> # define NFSEXP_XPRTSEC_MTLS 3
>> #endif
>> There may be some way to do that and keep it as an enum too. I'm not
>> sure.
> Is there a reason these could not be in export.h?

That's where I put them.

Jeff's thought was to use uapi, but that doesn't sound workable
at the moment.


> steved.
>=20
>>> I think the cases where only user space or only the kernel
>>> support xprtsec should work OK: the kernel has a default
>>> transport layer security policy of "all ok" and old kernels
>>> ignore export options from user space they don't recognize.
>>>=20
>> Great!
>>>>> #endif /* _NSF_EXPORT_H */
>>>>> diff --git a/support/include/nfslib.h b/support/include/nfslib.h
>>>>> index 6faba71bf0cd..9a188fb84790 100644
>>>>> --- a/support/include/nfslib.h
>>>>> +++ b/support/include/nfslib.h
>>>>> @@ -62,6 +62,18 @@ struct sec_entry {
>>>>> 	int flags;
>>>>> };
>>>>>=20
>>>>> +#define XPRTSECMODE_COUNT 4
>>>>> +
>>>>> +struct xprtsec_info {
>>>>> +	const char		*name;
>>>>> +	int			number;
>>>>> +};
>>>>> +
>>>>> +struct xprtsec_entry {
>>>>> +	const struct xprtsec_info *info;
>>>>> +	int			flags;
>>>>> +};
>>>>> +
>>>>> /*
>>>>>  * Data related to a single exports entry as returned by getexportent=
.
>>>>>  * FIXME: export options should probably be parsed at a later time to
>>>>> @@ -83,6 +95,7 @@ struct exportent {
>>>>> 	char *          e_fslocdata;
>>>>> 	char *		e_uuid;
>>>>> 	struct sec_entry e_secinfo[SECFLAVOR_COUNT+1];
>>>>> +	struct xprtsec_entry e_xprtsec[XPRTSECMODE_COUNT + 1];
>>>>> 	unsigned int	e_ttl;
>>>>> 	char *		e_realpath;
>>>>> };
>>>>> @@ -99,6 +112,7 @@ struct rmtabent {
>>>>> void			setexportent(char *fname, char *type);
>>>>> struct exportent *	getexportent(int,int);
>>>>> void 			secinfo_show(FILE *fp, struct exportent *ep);
>>>>> +void			xprtsecinfo_show(FILE *fp, struct exportent *ep);
>>>>> void			putexportent(struct exportent *xep);
>>>>> void			endexportent(void);
>>>>> struct exportent *	mkexportent(char *hname, char *path, char *opts);
>>>>> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
>>>>> index 7f12383981c3..da8ace3a65fd 100644
>>>>> --- a/support/nfs/exports.c
>>>>> +++ b/support/nfs/exports.c
>>>>> @@ -99,6 +99,7 @@ static void init_exportent (struct exportent *ee, i=
nt fromkernel)
>>>>> 	ee->e_fslocmethod =3D FSLOC_NONE;
>>>>> 	ee->e_fslocdata =3D NULL;
>>>>> 	ee->e_secinfo[0].flav =3D NULL;
>>>>> +	ee->e_xprtsec[0].info =3D NULL;
>>>>> 	ee->e_nsquids =3D 0;
>>>>> 	ee->e_nsqgids =3D 0;
>>>>> 	ee->e_uuid =3D NULL;
>>>>> @@ -248,6 +249,17 @@ void secinfo_show(FILE *fp, struct exportent *ep=
)
>>>>> 	}
>>>>> }
>>>>>=20
>>>>> +void xprtsecinfo_show(FILE *fp, struct exportent *ep)
>>>>> +{
>>>>> +	struct xprtsec_entry *p1, *p2;
>>>>> +
>>>>> +	for (p1 =3D ep->e_xprtsec; p1->info; p1 =3D p2) {
>>>>> +		fprintf(fp, ",xprtsec=3D%s", p1->info->name);
>>>>> +		for (p2 =3D p1 + 1; p2->info && (p1->flags =3D=3D p2->flags); p2++=
)
>>>>> +			fprintf(fp, ":%s", p2->info->name);
>>>>> +	}
>>>>> +}
>>>>> +
>>>>> static void
>>>>> fprintpath(FILE *fp, const char *path)
>>>>> {
>>>>> @@ -344,6 +356,7 @@ putexportent(struct exportent *ep)
>>>>> 	}
>>>>> 	fprintf(fp, "anonuid=3D%d,anongid=3D%d", ep->e_anonuid, ep->e_anongi=
d);
>>>>> 	secinfo_show(fp, ep);
>>>>> +	xprtsecinfo_show(fp, ep);
>>>>> 	fprintf(fp, ")\n");
>>>>> }
>>>>>=20
>>>>> @@ -482,6 +495,75 @@ static unsigned int parse_flavors(char *str, str=
uct exportent *ep)
>>>>> 	return out;
>>>>> }
>>>>>=20
>>>>> +static const struct xprtsec_info xprtsec_name2info[] =3D {
>>>>> +	{ "none",	NFSEXP_XPRTSEC_NONE },
>>>>> +	{ "tls",	NFSEXP_XPRTSEC_TLS },
>>>>> +	{ "mtls",	NFSEXP_XPRTSEC_MTLS },
>>>>> +	{ NULL,		0 }
>>>>> +};
>>>>> +
>>>>> +static const struct xprtsec_info *find_xprtsec_info(const char *name=
)
>>>>> +{
>>>>> +	const struct xprtsec_info *info;
>>>>> +
>>>>> +	for (info =3D xprtsec_name2info; info->name; info++)
>>>>> +		if (strcmp(info->name, name) =3D=3D 0)
>>>>> +			return info;
>>>>> +	return NULL;
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * Append the given xprtsec mode to the exportent's e_xprtsec array,
>>>>> + * or do nothing if it's already there. Returns the index of flavor =
in
>>>>> + * the resulting array in any case.
>>>>> + */
>>>>> +static int xprtsec_addmode(const struct xprtsec_info *info, struct e=
xportent *ep)
>>>>> +{
>>>>> +	struct xprtsec_entry *p;
>>>>> +
>>>>> +	for (p =3D ep->e_xprtsec; p->info; p++)
>>>>> +		if (p->info =3D=3D info || p->info->number =3D=3D info->number)
>>>>> +			return p - ep->e_xprtsec;
>>>>> +
>>>>> +	if (p - ep->e_xprtsec >=3D XPRTSECMODE_COUNT) {
>>>>> +		xlog(L_ERROR, "more than %d xprtsec modes on an export\n",
>>>>> +			XPRTSECMODE_COUNT);
>>>>> +		return -1;
>>>>> +	}
>>>>> +	p->info =3D info;
>>>>> +	p->flags =3D ep->e_flags;
>>>>> +	(p + 1)->info =3D NULL;
>>>>> +	return p - ep->e_xprtsec;
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * @str is a colon seperated list of transport layer security modes.
>>>>> + * Their order is recorded in @ep, and a bitmap corresponding to the
>>>>> + * list is returned.
>>>>> + *
>>>>> + * A zero return indicates an error.
>>>>> + */
>>>>> +static unsigned int parse_xprtsec(char *str, struct exportent *ep)
>>>>> +{
>>>>> +	unsigned int out =3D 0;
>>>>> +	char *name;
>>>>> +
>>>>> +	while ((name =3D strsep(&str, ":"))) {
>>>>> +		const struct xprtsec_info *info =3D find_xprtsec_info(name);
>>>>> +		int bit;
>>>>> +
>>>>> +		if (!info) {
>>>>> +			xlog(L_ERROR, "unknown xprtsec mode %s\n", name);
>>>>> +			return 0;
>>>>> +		}
>>>>> +		bit =3D xprtsec_addmode(info, ep);
>>>>> +		if (bit < 0)
>>>>> +			return 0;
>>>>> +		out |=3D 1 << bit;
>>>>> +	}
>>>>> +	return out;
>>>>> +}
>>>>> +
>>>>> /* Sets the bits in @mask for the appropriate security flavor flags. =
*/
>>>>> static void setflags(int mask, unsigned int active, struct exportent =
*ep)
>>>>> {
>>>>> @@ -687,6 +769,9 @@ bad_option:
>>>>> 			active =3D parse_flavors(opt+4, ep);
>>>>> 			if (!active)
>>>>> 				goto bad_option;
>>>>> +		} else if (strncmp(opt, "xprtsec=3D", 8) =3D=3D 0) {
>>>>> +			if (!parse_xprtsec(opt + 8, ep))
>>>>> +				goto bad_option;
>>>>> 		} else {
>>>>> 			xlog(L_ERROR, "%s:%d: unknown keyword \"%s\"\n",
>>>>> 					flname, flline, opt);
>>>>> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
>>>>> index 6d79a5b3480d..37b9e4b3612d 100644
>>>>> --- a/utils/exportfs/exportfs.c
>>>>> +++ b/utils/exportfs/exportfs.c
>>>>> @@ -743,6 +743,7 @@ dump(int verbose, int export_format)
>>>>> #endif
>>>>> 			}
>>>>> 			secinfo_show(stdout, ep);
>>>>> +			xprtsecinfo_show(stdout, ep);
>>>>> 			printf("%c\n", (c !=3D '(')? ')' : ' ');
>>>>> 		}
>>>>> 	}
>>>>>=20
>>>>>=20
>>>>=20
>>>> --=20
>>>> Jeff Layton <jlayton@kernel.org>
>>>=20
>>> --
>>> Chuck Lever

--
Chuck Lever


