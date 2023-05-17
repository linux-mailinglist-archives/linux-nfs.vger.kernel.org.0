Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED307071A9
	for <lists+linux-nfs@lfdr.de>; Wed, 17 May 2023 21:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjEQTNV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 May 2023 15:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjEQTNR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 May 2023 15:13:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB83A5D1;
        Wed, 17 May 2023 12:13:09 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGix7002883;
        Wed, 17 May 2023 19:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=bdxlarKoIkka8xj3iX7A/utXPlT7j0oMno7KxhQ5iXM=;
 b=a+T9ewIGBdKIPpoEc7jgXWXBsJwmNtJ1RzUYXW9FupasOPE50NM/2cgRkOPTKA3WwrED
 4FQXnUGLVlRPmEAIoeF//e3TntjuhvJH9isTg40+lK63b+60kq98O8tR26d9O2SVHI5L
 mOXdtnmOaia9iyGtcD1ZwA9ealeRUxGdjFGcleDaQla1xb5ibmkneaDZ1b+iNBVShpT6
 1YS4MRJ4DEi3JTNQqy6s1x5XTYGqpWHtOZww0pb8NQAXpeLRmQcAUrgaanGA+cIlcJd+
 9p4dSjY0n98T/O+tbm+y/xHpSBUsw+U8Tvt5BdprkS/byYwr+7yL8r4Q9eVE75nyXEBz Dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc6nr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 19:13:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIixf4032224;
        Wed, 17 May 2023 19:13:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10bv4pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 19:13:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuRr2DBh9cbiwf+Cc2s3d7Vx+9sXo//FDG7UxNs0ClWUpRSnwfDekT05nPDoLzrqPbgjcGB8BMvcQg0IpbRsynkHwO/K5g3c75s4K7LC6K1ZTAd3X5YxCFvmU1eLC6OdZIwKfeCeyDjnEkQnpybTkB58mx4ogd8+E43ij4F3XoVZxLcKW40xBkVAHEEV20hCkjw4Ui/7p7KTdNfrF8MqOntFQ/5OeGbI8eeaWVWuNbvvD9twlfcikT625M523ob+/v2forQufbqkoDgobpcBKYljlbyH55bJEWlMBEfOw7PZojPku/97HOtuOTlLuavyl38gdBsJ6k/CzHuTSz+MRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdxlarKoIkka8xj3iX7A/utXPlT7j0oMno7KxhQ5iXM=;
 b=IN59UhWfki2qEUNZZx2bt38bmmuq9Li7yZ4Ldz2wsb5n/AEDUB74ZFom3gBEch29c7SknWYh6zR4sBeWdeN+W/eObbwgRgL2LyQI4NbA26bu/PeKLJVQsVDYQhjCP0BkDuuX/DL6TSpxH6ZBldB32+FQBxd3zhIVCHJ/kA/joaJKg808JYOMcr/QMnSAqsjN8t7o3pK3kmbbOIg3cLBCp8Y7hQSGcTWabo6XXQt1b9DsyDp3UsblK5ohHD0xAsdmDgek65dXXccZ3l5aKSjJeIPbFww7AuhMHDcos8xtRy8sPcz9NxrBbC5vkAM7qcn3yVmGzWAucfdPiChkdZCy0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdxlarKoIkka8xj3iX7A/utXPlT7j0oMno7KxhQ5iXM=;
 b=h8GwWpb3ZQfsY134GdGcDJ30ZN8xgizmKPsDtBdG4xWlq8KoHKYTdh0U9PvPA5INAoPNZLUPwBvTuxS4HCCMGXJIe9b8Ob65helU2cxjX9OI99290tbmnbMcHrc+Z5pJ2tQ3/rh4s/HJMVI/rwCgvILLHXIYYAsAe73JWn6RupM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4750.namprd10.prod.outlook.com (2603:10b6:a03:2d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 19:13:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 19:13:00 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Zhi Li <yieli@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: make a copy of struct iattr before calling
 notify_change
Thread-Topic: [PATCH] nfsd: make a copy of struct iattr before calling
 notify_change
Thread-Index: AQHZiNxjTBHmZLbinU6qeN9/OzGsKK9evXMAgAAV/oCAAAH7AA==
Date:   Wed, 17 May 2023 19:13:00 +0000
Message-ID: <D481F0ED-0C54-411F-9A72-8BC5E253AEB7@oracle.com>
References: <20230517162645.254512-1-jlayton@kernel.org>
 <74D303B1-08F8-4CDF-8732-9352FFDEC463@oracle.com>
 <a55a7bfc8be6210dfc7e7721825ac915795a48cf.camel@kernel.org>
In-Reply-To: <a55a7bfc8be6210dfc7e7721825ac915795a48cf.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4750:EE_
x-ms-office365-filtering-correlation-id: d290c653-c7eb-4622-9755-08db570abb2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ACXHg9CsYr5pbMY1OMDSccsTOO2ka0I2o4p24tt17go9HvC2dQbX5UdG9XCDxEcLc/V6vn3mBiaA2YcPLtXBYVX6hT+X7zGL+kooTOLKxfYBPsTKiCi1hTRUBlpIjLXy9CXMZ8h+aWeSAraF/clCJp3RqdxWCgRCf3h8NOf2x3VVHVtL0f+UpqMluL2O2mF5V3vUbQxnr1fERtO1+5G+cF3+aJaMvBo5kdm4nL9bz5R6dg9XhBMd3Rqo49axyyeXuifpPQVwyu+A0trjpi6SDthZU/r5F/Ljvre8+g4xFyQZ5gnQ4uOznJnEwpohpQjJZmQL9/KMy6RE+8qTb3fhZ4BimudmWbCb64o3Y5tE47wNCyvP3WJImEI3xr8b3At6xFYIXEnylaixRA+KF1KW5krPDxHfwo1q/RBt7yMFkZuGe2xRIdiixqXybhu73kvak3bLxV+wQLAZjv4s6chEJlGArZUDn1xl9uvQ+LefGE3y/GAMhBoY0uvq03jy5ZZE7Etejct0NPwUD+WQuP2nkFoKl65TLOl3+RlIUfuWOKrDwwMP/NkOuaWoySBwNoTjr8OVF0Db+ZnJLBeMMWCFsmUzxQQsi5maArQY+FfUaqw/h0BsMG1pvnJaOWngJdVG2dw1dMYCdB4pME0fYvcHeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199021)(83380400001)(91956017)(966005)(6486002)(71200400001)(478600001)(54906003)(2616005)(26005)(186003)(6506007)(53546011)(6512007)(8936002)(5660300002)(8676002)(36756003)(122000001)(33656002)(41300700001)(6916009)(66556008)(4326008)(38100700002)(66476007)(2906002)(76116006)(64756008)(66946007)(66446008)(86362001)(316002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rkTKo05zKRwXSdELTvPFtTA3OT4AbhK+eQXeuYAmVLwUH68LousacQkk1rLh?=
 =?us-ascii?Q?nMqR6adQhhT3scUhmiteHNdVUFjSXMrJBAlQDoCAO/Il2d4f4s1tMEwpJYJ9?=
 =?us-ascii?Q?HhEfvBnGDl2cvNFhAc8wmUHVW4qbw49Zojkz3lsL/v0NIpoR8SnfLvsxxsKg?=
 =?us-ascii?Q?wUjfOXyvA22HVicAHRLGzoxSM0frMkr9bX7CB4GMAE1wqQRvz4fMFHIeWgQg?=
 =?us-ascii?Q?qzGS3u0UIUNjwrNlbc/FW24HPUZ6crMl6KhMNxykk36wbYpSxN8hbl66PFOp?=
 =?us-ascii?Q?JrxjomBBS5UD5Ny1ND8U/mdEcZVY4yMO4FuBu5CODcvE+aanIWB911g5QzAq?=
 =?us-ascii?Q?BuhRTBYN3iaLw4rO3eV/WHp49VB8C+G8x94bwlTW/JP9n2oCzms4tVk2vkZ+?=
 =?us-ascii?Q?rWlefFsFnRE5QqH6o8yL1b9nPQr828f4b58zS0GG2naWhl0iemh3xeDEo885?=
 =?us-ascii?Q?DBVB/pav4+dL97skaLgvHKaLSsaMyXbNe5YWE4JDQGOoiny1VdiKqNV18Vg0?=
 =?us-ascii?Q?LdpywsRnaMSCYDKa+gAKsOkLgzmjPhIZ7JBhoLQpXF9oj7Om+FtySB0vZy7S?=
 =?us-ascii?Q?JBkKZ3Y2SA3s09t/3t7+7noC3Bhp8gEr+LrOo+4lKI5D5cIFWeymeMq9KlAp?=
 =?us-ascii?Q?k7X2BxpmoWXpCuA4ddC6e1y9RaaP3Lw0mTN040pXfuIkjQAc02i+MEzahlAu?=
 =?us-ascii?Q?41Wbb8GRp9gdsUsIXXdW1PUQjk11hEybT2nmN4orqhyRpfwQt5Dpb9S360dL?=
 =?us-ascii?Q?iAfPEcAZPP3r5BeTpvZKWzE6fJoFLn7urvmUukZyPywzED3QDTJykGuAPlq+?=
 =?us-ascii?Q?7Je2m7w25zoCdax6A8zYW8s0agnX+M5sNc+f6/KOV4blJQynQByyPRZM84iA?=
 =?us-ascii?Q?nCSZLGc/0pzP7OZxiYHDASm+f4nlu4RNzSo0qzINxyOqzHHQSY7fysf+zQLg?=
 =?us-ascii?Q?s5t0aB2DQ+R/K4b3IiDuLD6iS0Ik3rR1quS2tQ9uL/Yc/4NZUa6z3/MvlJE9?=
 =?us-ascii?Q?+bqQIqgNREYWSBUNndZv2EAZXkSrU6SIYAmEjgZr7f33noO2n4QYf9yiDlP8?=
 =?us-ascii?Q?Rz+GWaD1F6YfqOQNJN0cDkfRY6gQg5EwsdIqyBKsMSUX+qrBp0UzzivBfgmf?=
 =?us-ascii?Q?qvigYBVAlbVXu9GEbJ7lgnw5OJMvHcekbXr+Mx1N8s//2qyruMid0FE/Th+e?=
 =?us-ascii?Q?EPmZx14m3x3cFPv/GwmxascWqruF6h8n4jMYDB31GPe9MKTIJ93pBuFFEbG4?=
 =?us-ascii?Q?5BLAgUKCU/GLXa5/G5ZhBxM1GjZ7c4+edwb8sOwZg69RXN1Gl8WaJu1V3/Iz?=
 =?us-ascii?Q?8kQ7TEdHu0vKFDna9j/t7NuI7nY6XU3aY7wF572L3v8uaFI1XpgU7FAr5O94?=
 =?us-ascii?Q?OwflOsqzcMmw+ZMzWPiOEJD+uzeJroGjQ1ZiLjZ0rIpsAGsDdIM4pKbelYgC?=
 =?us-ascii?Q?ofIcY6ELXJJxmZkISdhVB/SB4t+Yf4XJGdiimaHUxZgi/S31DdaLd7vCiL0m?=
 =?us-ascii?Q?6+CP6xVJXa0SItgaVZ1vzmgoou0O8j/KbKfWQU8tQP0EqzIdUwdpfOzaDuy8?=
 =?us-ascii?Q?iIBej09ulTqdvf2SybDmuEvXGPJ5dTfvoCb697XC13ctgI9DpkYyyzyvalEf?=
 =?us-ascii?Q?vA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8DF6DB62892C2E499008F11F26853B3C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Zimw7uNC9V6fDhROvlIZ0cGFic92VK+zPScKpEH0/nHxFU5tZfqjIuXqtUwe7MIRqm39h0L7aqC6KgbFqr38rQAhSq8wwiFg3otiUqNHp+T3bjeKiqaDemWGYuhpWW5YHpqTCfY7x76XUd7DNwoZHYUBDwJj4jg8RWmaS/J2a2KffSC3oLs4k1McQuV7w/ptkQkURSU16VWJHi91pEYygMbHGJhp5fAn/fTSbOwmdrtImEbU3x7KxJTxG3mOmZ6oxqfb+bC3161vIz8KfQlkFXbekLudYkHgYO7zNSpKa094KjcLgk/oGxIOUkAQeIwEqazY+4M4a/lJGgNX+xqROpKB2HuMmpCYiz9Xc15rXTxkzpRdoRqtAUVmpacJ2pY+2WiEgYNnFExOEVS0otfjmT/id0Q1qxJq5UTbfO6hDRaXdv+TOCloVF6EBmzdb0+imUrIYP+udy/dX7Iz+GLHvouD1fSTrVmVvLsSIZ9EBFRNKq80Auy8vqOkI4xi04Vc/S0ALVoDdqRKs20pZ7In+xgz8fA3WxkCX3k5KDfpvZNFB3yQMMSUtw8HUFdx5isoR5VVl3PzSd6oDyJaAy3BNZI98rdyPV7KFbZsVDUzP59rfxNTEZStFaDTrZsu4djtcor524TbtfBVA0eDg1Gwehxx9Mny+FvVLTqrXQ1XrMajqCDsaPyaQ6NRc0BlxVCWzFpqlmF3ESCnLKOwNZ9hKv9V23eQ9tPj186fTWMYBQnYWRwkIYIuip/W3hT6/BwfQEw75kl0x4w2SlIJfWosUQXWACwhQ42NVulj9S/DImtPCualP7Lxb+9JP6Hy/cBk
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d290c653-c7eb-4622-9755-08db570abb2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 19:13:00.4185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1VN50B+TVC9q8czcaWuRB97FY+0vxRZ60JjUOUdPtfO1xSDjaW13nH+dcwTOFR0ankPzOOdfuduNo9prpaKl5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170159
X-Proofpoint-ORIG-GUID: Thd0v6noMWpP-U5ymGGjDUvLEwISyV6x
X-Proofpoint-GUID: Thd0v6noMWpP-U5ymGGjDUvLEwISyV6x
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 17, 2023, at 3:05 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Wed, 2023-05-17 at 17:47 +0000, Chuck Lever III wrote:
>>=20
>>> On May 17, 2023, at 12:26 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> notify_change can modify the iattr structure. In particular it can can
>>> end up setting ATTR_MODE when ATTR_KILL_SUID is already set, causing a
>>> BUG() if the same iattr is passed to notify_change more than once.
>>>=20
>>> Make a copy of the struct iattr before calling notify_change.
>>>=20
>>> Fixes: 34b91dda7124 NFSD: Make nfsd4_setattr() wait before returning NF=
S4ERR_DELAY
>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2207969
>>> Reported-by: Zhi Li <yieli@redhat.com>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> fs/nfsd/vfs.c | 4 +++-
>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>> index c4ef24c5ffd0..ad0c5cd900b1 100644
>>> --- a/fs/nfsd/vfs.c
>>> +++ b/fs/nfsd/vfs.c
>>> @@ -538,7 +538,9 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
>>>=20
>>> inode_lock(inode);
>>> for (retries =3D 1;;) {
>>> - host_err =3D __nfsd_setattr(dentry, iap);
>>> + struct iattr attrs =3D *iap;
>>=20
>> This construct always makes me queazy. I'm never sure if an
>> initializer inside a loop is "only once" or "every time". I
>> fixed a bug like this once.
>>=20
>> But if you've tested it and it addresses the BUG, then let's
>> go with this. I can apply it to nfsd-fixes.
>>=20
>=20
>=20
> I've done some light testing with this kernel, but this was found by Zhi
> while testing with the lustre racer test, so it involves some raciness.
> I've never hit this myself.

Has Zhi tested this fix?


> I'm pretty sure though that this has to be initialized every time. The
> assignment is inside the loop, after all. I'm ok with moving the
> assignment to a different line if you like though:
>=20
> struct iattr attrs;
>=20
> attrs =3D *iap;
> ...

Yeah I could do that. I find that easier to read when a loop is
involved; it's unambiguous then what is going on.


>>> +
>>> + host_err =3D __nfsd_setattr(dentry, &attrs);
>>> if (host_err !=3D -EAGAIN || !retries--)
>>> break;
>>> if (!nfsd_wait_for_delegreturn(rqstp, inode))
>>> --=20
>>> 2.40.1
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>


--
Chuck Lever


