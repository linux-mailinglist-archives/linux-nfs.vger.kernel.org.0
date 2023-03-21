Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ED76C33AE
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Mar 2023 15:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCUOGe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Mar 2023 10:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCUOGd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Mar 2023 10:06:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A852E83B
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 07:05:53 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LE4DvC004182;
        Tue, 21 Mar 2023 14:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+7qmGTc0F3B/N1EjSh11u4qYBvUB+1rCzCwvTCveMjo=;
 b=zl3iknikf13hw1CR9QyCbCJ9ySw3axZsXDVIuhlqaK74xMg9fkyLwMOtdDJCh9MvBFVS
 0hKBDs+1ZYG85K0cJeTn23+x766uWQACtva8k9Rjbn9q6EG6Iruig59uyfYZp4JC59bh
 Elo5sfxlROhg79fgHGJ0ShuldpMtQlxdHt6lfe3h+ZN9ltEfBPoK6ue8MndO0tJchtsA
 2EzJUaa4lo6FfWtxAXlFZkG9FFJckvCsVwv3xNbdODw4hmi0jW35JbS7ivxZ9k7V4YRI
 8i6I40DjVyNd495X5zjgUyDeQbVemQ2dFEdjZR7b4beP2RGCMUsoNa9jLfSXZZvlvjM/ HQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3qdp8w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 14:05:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LDNj8T026528;
        Tue, 21 Mar 2023 14:05:19 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r5sdqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 14:05:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeQDx09z4W0iL3/C0o/TnIDiFvWltwjBfiBgUvRkleg/LM8J4tYnL0r/chXAywbETOdNlR8I/0Q+RvupoLRGK9JFrd5goMGxt0wAZpXICGBK0CTh1T8x4H62WXwhQwe4x9FhYePktC39Byqs1fI2HNTEJeRQXZrUwFOT1hakjx1zJlD+mbmkqX7kgFCvaErtRDoakkvhn/JAXYt+eMsIZh4mUk4MERkbGxiX6mSi/6Q8ATukTAibR6+s5X7op+n+PUbyZwIsOtDqWRKiCl5sWR0LvXk22bJEDoeHFZE54Cf5Rhz80kyGDXMZVDex5WQQQFeqRs8MTAQexCItlFsdKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7qmGTc0F3B/N1EjSh11u4qYBvUB+1rCzCwvTCveMjo=;
 b=Cph/vrI6y6t2uI2teNvGTwnrlFaxJYH9mCoi0o1vi+Q/Mo9Y4Z7zikUrHnyRiUFNktuiHu1RfxS4cfucbgDzszMVg3SQ/fQL6FnTFn/XmS3Ii6x4vJjKrWBUR09W3nukQkMOwzqbZ6INDN9oLKM2CHWhc787sCDU7izRqaYsaC43tQWfE0B9RQuwuPDC9EjRf3wraAJ/b+S1ZJ4L7GWNH4B5CBcm9uptwkPlCco+j4El1D7RKCAeLSjr0Ivg7TJmJlUjkTeqdSBSynNxQ23rTFleWKeD5AVmC2aSCWOkfRJOaixYt9izKBe9z8nR3vyOFJTfzBnM63lU7RMNLw5bCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7qmGTc0F3B/N1EjSh11u4qYBvUB+1rCzCwvTCveMjo=;
 b=E/9h4FqPo0VV4ILbQvjUF3lu5LdDdKNA/wY0ovB3NjaWc7aUPmbfCApFsq9/YUUVzZ7zXITkDgHMnxzRHjDtGB4sF0xE5uOzvBoPDA+xaArYw3dOxZDyI4+HFtDrVhZZTS7B5Uw7vKSm/xOYpEIfg9yi31w07eRZeePOm4ivRu4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5243.namprd10.prod.outlook.com (2603:10b6:610:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 14:05:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 14:05:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-tls-handshake@lists.linux.dev" 
        <kernel-tls-handshake@lists.linux.dev>
Subject: Re: [PATCH RFC 5/5] NFSD: Handle new xprtsec= export option
Thread-Topic: [PATCH RFC 5/5] NFSD: Handle new xprtsec= export option
Thread-Index: AQHZWze+3WPFBN8ymkiTpv6lYNxrOK8FIDwAgAAlpoA=
Date:   Tue, 21 Mar 2023 14:05:15 +0000
Message-ID: <C56DB6DF-5120-44D3-B5C4-09603A3B3553@oracle.com>
References: <167932094748.3131.11264549266195745851.stgit@manet.1015granger.net>
 <167932229302.3131.3108041458819604050.stgit@manet.1015granger.net>
 <3dec5ea0dd4efbf96767333d3de90457b9fd3ecd.camel@kernel.org>
In-Reply-To: <3dec5ea0dd4efbf96767333d3de90457b9fd3ecd.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5243:EE_
x-ms-office365-filtering-correlation-id: c980975e-2da8-473f-c1ac-08db2a154bde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4iC1pqCcl0bz10fCnSXmrPlhowi4d7YDTtwKOWJv4kGml/LZwk2XajLqk+bAEUQJCt5xJ/gGM5nV6Cr/gtDZPcI6EZgCpZzpWDNTqkKpXgfUhHhMBO7PfjDWO3XEVaXU1Wi504mFNFAT5encBs8j8fSChchplMCyeFThSJxd7qXYRRKgv6IHHR6XiSV2Rkh7RNKR69za2++rH2a8G3AGwI3WsgjH3l3RviL73shDzFbeGLV4gMVbL2NIwF+Yw2IxqsaW8h3ViYcJgKwjFPB2qSmCopQ1Tch4Y7HYK4ddCCROLl/EhsytOpOR0iMJX64YCWEb4YR02elm6pyzzR6+yAoGmBL/M3tL4k6e2ZpjqAlMxvtGFx77yZ+Nx1QrvYuvGfytPqA6AwMmjhQAMDgQuiHVGj5aktlzDGvHeVAkodug0O8tyoCPociiN094PXxxDGXdOzO31F8b2yRCySoog+v/Z5yxWTV/6PWDHv55G7bYIGeL1aGXJcQD6mlLMYZx6GIKzHItv3zPA9UAt1nz4DxkKqp4FgiauKNrfdTHSG2BqmSn/dwQSwWrlHqenS3B+rExkVlPbVWZYEVlk3EkOOxoYIWUt9zuG0sEf243qlCQJrKQqEwuUv5NJVCD7nPS7XGWYcXcJprSVIDXWRJDhHpGQ2fz6mpFW3CY+EXRiDQhEZcea8mNG9s/ZqiHOe6g7wYGusHnU691WkqXI5thhQY4ksFi/kLv/R8E3Q1dhUQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199018)(478600001)(2906002)(83380400001)(54906003)(316002)(38100700002)(2616005)(86362001)(122000001)(38070700005)(53546011)(6486002)(71200400001)(6512007)(33656002)(6506007)(36756003)(186003)(6916009)(4326008)(76116006)(66556008)(66946007)(64756008)(91956017)(66476007)(66446008)(8676002)(5660300002)(8936002)(26005)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7WgD+onoyx9fCoLcWxShPoY48UVfDoTon1fyHttbcHkSrVkXRKAlaAQd81jt?=
 =?us-ascii?Q?1ZsZQJdRvBa4a5HMXgztsNj/9HzFWFCseqkDoJKTcYRp7iShPJ/Dk0SF8BCL?=
 =?us-ascii?Q?j/gtg1gFyisqvb/ao7htlrdYxwTmb5nnWZBGeN2onOcl3//VCjrUa7yCZ8iQ?=
 =?us-ascii?Q?uNIboyXB72qyegz4iHVE6xPbYgLDf1ER7x3V9IVlFpbTW2fDAp88WeD8FClJ?=
 =?us-ascii?Q?EEoi9wMUdYWth9nGk8AA4M9KFYwhh/+fcgg3sM3ChupC4tIkQ6QPtj1yY2vW?=
 =?us-ascii?Q?8PLfjKqLGSGeiTyxlzFFI970K85az6l1e5FCjXW10xryKHZSWWA7viUrTKxG?=
 =?us-ascii?Q?//r1VkzRZe2ABKgowVtwrS6vAO5MTWr2bvd31uDT0x/vRbZIP+dWT8bBWyd8?=
 =?us-ascii?Q?w88RIhTfbYcvvF41YlkPEOAGlOcH6vI+0ibnjUAB2kKCsnZpgKlKCV/j2GMm?=
 =?us-ascii?Q?/99NIqjg5G5w/4VuGMZ5jQMl7IAfgvm3NcLpq9tOccjNCVtqq3Uo+2aoM/aY?=
 =?us-ascii?Q?TBPJ0qbtvNPlU40buiLTYRv3cz6OQNw44Ca0S7egyF5AFfN5tLmY5gwEN1FQ?=
 =?us-ascii?Q?qfN1axL4T5MJ+ciV2bTbMg0M40vsRljpStpsIVTJXzHmbjJUXcqt+navxD5O?=
 =?us-ascii?Q?ZZy27OwoeV8eJ6pU+eVXBZTU8iX3zLy4js0ayV/HWbE3j+v9WpSTqQK8jZ2a?=
 =?us-ascii?Q?Uan9yJm1jUuiMI5OHwi/UvZZVnSY9lIpQyI+rP7lVqCEfmfoRfhLnuzU3Vhj?=
 =?us-ascii?Q?F8y1+bhsf3vZ2QUCEn7czaMjYrlH0dvFskPqord5UPqtfeys2/VVHaEnJdQB?=
 =?us-ascii?Q?F7KCCoGiH9BqDkMHpDMRmmZBhmmYyv9qujleJOOJoUugr1T8mDeQVw0Zv9ox?=
 =?us-ascii?Q?6wZ395BkdtUFYSEabReZuVsD/8FtNsnU38Etdjmxx8yNhBe1WlLFqQi5ZqWY?=
 =?us-ascii?Q?+fOLDHrnfOwYD8riJXXVkSIA6vke7dna1A7PtRYZaMZIvoQu1EKjs5vnIbB1?=
 =?us-ascii?Q?md/Roe342MLASpVTyefRhK7SlkSuMPJSuVkLYXA6AhpcacDhNJb0RGvReJkY?=
 =?us-ascii?Q?2rdJ71x+PiMFYQy5kOARL2zRCgJQE8rlQa0+SzPUBDE+e7L3zjZiU7pMNssr?=
 =?us-ascii?Q?PRtrLJ5ydvJ887PY6z7ycQoz150jW4SydIiR5mja4C60J0BLfVHKhSxvK7fC?=
 =?us-ascii?Q?6UsIbPeCMwS8KgfVvCubt9mxJZiqWVDJW4Nm6soiVc+KsUeouwl8LOZHRb8R?=
 =?us-ascii?Q?pv9a6g8wJ/RkB93T4MxqAIpuILSJ5wNQVJ9GvNA15ATpQph2iV1Hndk4H2qg?=
 =?us-ascii?Q?fwz8cWnKSxpL7tK4haA1XBIzMCDfAXJP1DfOFKtpL/1lmm6XsmbrTsxbsEav?=
 =?us-ascii?Q?U1OPiknivG3qSVbsha90x1wnyWb4jeo56ZuLRWXJYyRlEDgALktVfgDuWd+Q?=
 =?us-ascii?Q?DEYqKkpdurxVtfmBjv+RBh6tixhXcfdri+NxjlXv0CDrpqX1rhseZR88dU88?=
 =?us-ascii?Q?T8yWEXhm77/P+YZJYiTHn0CuIPKLbG1WrAXlI3HCV2KvNxsIMffYQLR/HJsY?=
 =?us-ascii?Q?NNQvGSfQslnCqK+np21IGwUDnzx7QNef4IpvtgLg9Q9mpdMzwY9BExtEW5AJ?=
 =?us-ascii?Q?sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8F782C97737C2640A9CE0FD142027D9A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QI3PGszOfBA08MLe6hnedOrBbZPqjPvuNF+mXxwogGaI8IomzRSjyB9Lb2197jpBYhwzSt8iovJjiO34Mu0k0QEbpms3dwzWwIbASetuEqSLKX9uRlq0DwXxU2nGuUgB2uxQY7u/g4ue37TzA4e8XRrnrd8CMGt1uuIH0ihJx3rnoSsgaL8d3215JkXSVVJaXvqRRxDF7WI4agb+z85Po1gam+4hePeg8lXyCmlwZXQQv6iIXl66kJBqJP1jYk2CgHXZ2ObUND3G/AdMkmlNIDkWhYLgyq3sofSribrU3nBHbPZSLQa/qeqwC/SZdknV3NHK87N+20UGMaDVDJDCirbtMccgPmUR5+SH9e6UD4ERog7tPWO5Ne3upMWImdBvhKJZr3+1UxKJBDe7UV0AnMSvT89TnKxtjvQuHDHOiChtftUTcVcmesoe+/bX4JrAVWNHdFFH/0JF/o8k90V8YfkoYPXyqoZMBCkJRzlg+KBIikaFZ++aVA1RDNm6YjoXnccHI/zAv3XEV2oDvRwKH9iDoYnwjDS3KPD9ur+t62sILsWuZCKfKgczvK9lc0aO5Z/uS6weU7S2JiKkFIv9BFZVeoHpW9wpEk4vTqWIrz1V2Wu9KxOXcvNzuHWeUZ4IbvN2xz5oI4Uo/9MO5Kc4IeKZ0vkHu6zLWEcGci+DZinsEboVEX3t7i7cHX3ocmKALSsp2Z345CbgjD0He9dglZID7N+ytWQs4KaL25oEiX6ytS2WfUu7IQ0R4e4NDvrBWRt0q2EQWqJ+qipw00ca0Kfvmv7TfSEXq16PnvqV4M9bnxOPrtWQhycIXgAANi40Br4rIO+OO7JYKxKG7ozoCg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c980975e-2da8-473f-c1ac-08db2a154bde
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 14:05:15.8314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fsI5M6uSTpTWbnHF0o9/q8nd1cWjruVVI5uzQ5mBHW31cbzhJY3phrLYDI5/+X7g+qOb1K48yVFEKGf+MaHXxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210110
X-Proofpoint-GUID: frKN8QhDjHltmsbX9If5uYryDIsrAcqN
X-Proofpoint-ORIG-GUID: frKN8QhDjHltmsbX9If5uYryDIsrAcqN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 21, 2023, at 7:50 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2023-03-20 at 10:24 -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> Enable administrators to require clients to use transport layer
>> security when accessing particular exports.
>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/export.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++=
++---
>> fs/nfsd/export.h |   11 +++++++++++
>> 2 files changed, 61 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
>> index 668c7527b17e..171ebc21bf07 100644
>> --- a/fs/nfsd/export.c
>> +++ b/fs/nfsd/export.c
>> @@ -439,7 +439,6 @@ static int check_export(struct path *path, int *flag=
s, unsigned char *uuid)
>> 		return -EINVAL;
>> 	}
>> 	return 0;
>> -
>> }
>>=20
>> #ifdef CONFIG_NFSD_V4
>> @@ -546,6 +545,31 @@ static inline int
>> secinfo_parse(char **mesg, char *buf, struct svc_export *exp) { return 0=
; }
>> #endif
>>=20
>> +static int xprtsec_parse(char **mesg, char *buf, struct svc_export *exp=
)
>> +{
>> +	unsigned int i, mode, listsize;
>> +	int err;
>> +
>> +	err =3D get_uint(mesg, &listsize);
>> +	if (err)
>> +		return err;
>> +	if (listsize > 3)
>> +		return -EINVAL;
>=20
> Might want to make a note that the limit of 3 here is arbitrary, and
> that it might need to be lifted in the future (if/when we grow other
> xprtsec options).

Well I can easily add a symbolic constant for that too. I
missed this one in the final clean-up before posting.

The bigger question is whether the new downcall parameter is
sensible. If there's a nicer way for mountd to get this
information to the kernel, I'm open to suggestion.


>> +
>> +	exp->ex_xprtsec_modes =3D 0;
>> +	for (i =3D 0; i < listsize; i++) {
>> +		err =3D get_uint(mesg, &mode);
>> +		if (err)
>> +			return err;
>> +		mode--;
>> +		if (mode > 2)
>> +			return -EINVAL;
>> +		/* Ad hoc */
>> +		exp->ex_xprtsec_modes |=3D 1 << mode;
>> +	}
>> +	return 0;
>> +}
>> +
>> static inline int
>> nfsd_uuid_parse(char **mesg, char *buf, unsigned char **puuid)
>> {
>> @@ -608,6 +632,7 @@ static int svc_export_parse(struct cache_detail *cd,=
 char *mesg, int mlen)
>> 	exp.ex_client =3D dom;
>> 	exp.cd =3D cd;
>> 	exp.ex_devid_map =3D NULL;
>> +	exp.ex_xprtsec_modes =3D NFSEXP_XPRTSEC_ALL;
>>=20
>> 	/* expiry */
>> 	err =3D -EINVAL;
>> @@ -650,6 +675,8 @@ static int svc_export_parse(struct cache_detail *cd,=
 char *mesg, int mlen)
>> 				err =3D nfsd_uuid_parse(&mesg, buf, &exp.ex_uuid);
>> 			else if (strcmp(buf, "secinfo") =3D=3D 0)
>> 				err =3D secinfo_parse(&mesg, buf, &exp);
>> +			else if (strcmp(buf, "xprtsec") =3D=3D 0)
>> +				err =3D xprtsec_parse(&mesg, buf, &exp);
>> 			else
>> 				/* quietly ignore unknown words and anything
>> 				 * following. Newer user-space can try to set
>> @@ -663,6 +690,7 @@ static int svc_export_parse(struct cache_detail *cd,=
 char *mesg, int mlen)
>> 		err =3D check_export(&exp.ex_path, &exp.ex_flags, exp.ex_uuid);
>> 		if (err)
>> 			goto out4;
>> +
>> 		/*
>> 		 * No point caching this if it would immediately expire.
>> 		 * Also, this protects exportfs's dummy export from the
>> @@ -824,6 +852,7 @@ static void export_update(struct cache_head *cnew, s=
truct cache_head *citem)
>> 	for (i =3D 0; i < MAX_SECINFO_LIST; i++) {
>> 		new->ex_flavors[i] =3D item->ex_flavors[i];
>> 	}
>> +	new->ex_xprtsec_modes =3D item->ex_xprtsec_modes;
>> }
>>=20
>> static struct cache_head *svc_export_alloc(void)
>> @@ -1035,9 +1064,26 @@ static struct svc_export *exp_find(struct cache_d=
etail *cd,
>>=20
>> __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
>> {
>> -	struct exp_flavor_info *f;
>> -	struct exp_flavor_info *end =3D exp->ex_flavors + exp->ex_nflavors;
>> +	struct exp_flavor_info *f, *end =3D exp->ex_flavors + exp->ex_nflavors=
;
>> +	struct svc_xprt *xprt =3D rqstp->rq_xprt;
>> +
>> +	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_NONE) {
>> +		if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags))
>> +			goto ok;
>> +	}
>> +	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_TLS) {
>> +		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
>> +		    !test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
>> +			goto ok;
>> +	}
>> +	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_MTLS) {
>> +		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
>> +		    test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
>> +			goto ok;
>> +	}
>> +	goto denied;
>>=20
>> +ok:
>> 	/* legacy gss-only clients are always OK: */
>> 	if (exp->ex_client =3D=3D rqstp->rq_gssclient)
>> 		return 0;
>> @@ -1062,6 +1108,7 @@ __be32 check_nfsd_access(struct svc_export *exp, s=
truct svc_rqst *rqstp)
>> 	if (nfsd4_spo_must_allow(rqstp))
>> 		return 0;
>>=20
>> +denied:
>> 	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
>> }
>>=20
>> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
>> index d03f7f6a8642..61e1e8383c3d 100644
>> --- a/fs/nfsd/export.h
>> +++ b/fs/nfsd/export.h
>> @@ -77,8 +77,19 @@ struct svc_export {
>> 	struct cache_detail	*cd;
>> 	struct rcu_head		ex_rcu;
>> 	struct export_stats	ex_stats;
>> +	unsigned long		ex_xprtsec_modes;
>> };
>>=20
>> +enum {
>> +	NFSEXP_XPRTSEC_NONE	=3D 0x01,
>> +	NFSEXP_XPRTSEC_TLS	=3D 0x02,
>> +	NFSEXP_XPRTSEC_MTLS	=3D 0x04,
>> +};
>> +
>> +#define NFSEXP_XPRTSEC_ALL	(NFSEXP_XPRTSEC_NONE | \
>> +				 NFSEXP_XPRTSEC_TLS | \
>> +				 NFSEXP_XPRTSEC_MTLS)
>> +
>> /* an "export key" (expkey) maps a filehandlefragement to an
>>  * svc_export for a given client.  There can be several per export,
>>  * for the different fsid types.
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

--
Chuck Lever


