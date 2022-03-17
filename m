Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9898A4DCE5D
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Mar 2022 20:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiCQTDk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Mar 2022 15:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiCQTDj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Mar 2022 15:03:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DA81F6F18;
        Thu, 17 Mar 2022 12:02:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22HGntZO010900;
        Thu, 17 Mar 2022 19:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EvqJE82ena7sEY5n3yNYO9JDkj6pju+E688iAcYW/Os=;
 b=0zneIBNGTbc1h1x0JO/vlXcYJ3m8uyy6GpvvrrNwBbSeBoCIx+JFgMf7y+eDdeN49qOo
 ih709NPasnNAG5yC+VmvlsF1dPnkIU22e0XW0tizS7tWvIqyEqQQia3lZxtxNkH0lRAn
 wNQiRbDVFwWoYzOIt1EOcEfMdOinqUv+wXIVU1n7w44jvvfDivKkGGm03VDg5Q7cj5rb
 9qkeL9JOg2h5Z6vWztkd8dXQZEjO5tvn4nI1+5KXVEOE8lrGFD4ttQc3TI7ZPUj/kAv6
 NcFjqNBr3MQLn4wMIaeYkMnrC5guZrqoZNKzYwxw7csjI6NYhJoFM1s8CPwdUfjtXBwz Vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rhy9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 19:02:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22HIu98Y017944;
        Thu, 17 Mar 2022 19:02:11 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by aserp3020.oracle.com with ESMTP id 3et64menqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 19:02:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/k19gqwtWPYIVB7mFJBfIDufn8p3ckvkr05Zw0m/9ijH9aSZbMGQ8VFfpubKyIcXIEApJ/LmAz5bxke3is1qQBOL/fMWPxdLZVAwLMGY23xNhTsEyHgSw8Bj5TS6yrUbWGgXuoHjlB7xomKg6HmNTokiLwgb9Ueduc+OaaKjr4EZmxNfZU6zo3j6JeOUrA3UlN0LelfNZ6Ycg+f5dHrN+RlHwPdpvs3hhuL7/YLJeDlPtNdY0baxJjFJ00HzoX/e6o3HtsiD8fvKjc40inodm+0pF+l3UVpTG+Ruu2oUhoQoSRqa46cZNaKVD/kcM14q1MAlTB1Qx/sKUC8TFLt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvqJE82ena7sEY5n3yNYO9JDkj6pju+E688iAcYW/Os=;
 b=PYEOdjYaYygkzxB2CoRtVK1DNkBYLHgIkwpesjodhyHePZnvsGMKnsLYh33YdxdkFjmpSAsxmQ4a5PoJmjve44kMIgrJlPKU73T9MDtE+2fX6lKcYQIJBaLIt98zj1xSMPDTm4azVaHJkYy2s4RVZfeT3mE772dKgboBsyH4i8Jnf7S2n7I4L9i1xFxRTNxfJAYS4a0GNFPwFmPDCetHEY8jBpGRxzkKO2C6OxbsN9QLEuL09jhoBAFHjIjXU+9suAJWjcIySLa2a+JMngSDiFwrQiQ+AJc1QUiOxvTQ1vuoYpF09DMT+Ow8Z/ph+k6T7ghXSkh21jZqOHSE1ZrK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvqJE82ena7sEY5n3yNYO9JDkj6pju+E688iAcYW/Os=;
 b=EErbhPdEM+uM7UALP62uGClc+r4cxoKl70ai3uN/lpXkWMGH/n0DoLG6eZ/4/JUxq9oqsVdqRLZVBMMUt0QEdBWPntDqJzKhh8rR60eghcelvB+jVM+JGlpmf6gsxEnFw0E2N+y2P5sC0VSd9vaEHtQ7N34Fn7U6Av5hCkt51F8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY4PR10MB1912.namprd10.prod.outlook.com (2603:10b6:903:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 19:02:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%6]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 19:02:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Thomas Haynes <loghyr@gmail.com>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>
Subject: Re: [PATCH v2] nfsd: use correct format characters
Thread-Topic: [PATCH v2] nfsd: use correct format characters
Thread-Index: AQHYOi7VDYQCL/xF8UKwiKHmI8bB76zD7qIA
Date:   Thu, 17 Mar 2022 19:02:09 +0000
Message-ID: <1F848996-D3E8-45A2-92E0-52939974B143@oracle.com>
References: <20220316213122.2352992-1-morbo@google.com>
 <20220317184222.2476811-1-morbo@google.com>
In-Reply-To: <20220317184222.2476811-1-morbo@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83ceca9f-59a8-406a-ca21-08da0848a344
x-ms-traffictypediagnostic: CY4PR10MB1912:EE_
x-microsoft-antispam-prvs: <CY4PR10MB19124D8D3ADFBE6BAE28E3B693129@CY4PR10MB1912.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mJSLuIDQ6pcWKJ5czKIsF1aaqIhD+DXL0sUzxtLxqRMX7eOt2rOlIwlvno3Yt78ayP47ZjWrJR6TInT+BvJZAhyZBul9aHt6sXkMX1nYd/CGzPV8U27j2hipqCmG5uksYCsY+9Iy3EGzsGm8h/lwG/JDIH717v042v3Per5S/6munw8+7vC0qv89XVbCI1MbbWqFtWVSF4IwQa6gTyv7BDMqp0vQ3etm+kcsnvTkFZkC/nEv3Ar7I+Cxt3OgiOZS1gm/yd0r10SYFpsb0YMku/Q64ZSRvpT86oDQyJzksl34gyBf+N/BokIv5yQOPpT5CYq4x/9UzCXvsd8epFoONYZ8yhBsOnpxz3+4eFcnQoMeNO7rwNcKFmkxuz0KMvR8GNatgzv9v8vbC37Ceeb6Zq6aKy7L3i4AVn1UN0MSuIxmq+UCOfjSVYW6URYVP8DLFKw4jjzpdVoKicORCX/Li54yPdWMt0oTQciUo6cufn84QYrCbBYHuOSjxgTZPKcm+xmx8gUS8NWiIx9cY4oE3rYYZGJc5O+eOu5ipHJOzkZLQDH4JowqdqhVxxbgNohnMiI2WYfudvTyKgsO0bAg1z0kBjiEtlGsTxmmWlnmEWBqMeE4m2Aod+J55R6vfQWOE3al3B1TlynR1o+dGWZvTxIjN2MeIUY1xMb6iy8lTXKFgrTqF5DqNe3/Nm8mOQb6NlSl6aEDPV+y15yuuygQx4OnVq+GLeqS7Gn86wQdZv8RtUcGzSfmaz4oSQu1Ud1uZ8Nr5S6PMDZHkEMTgEbh3F9MnxRYVMa9xx6NFdi1famnPjZpQiYYgH1bwpYXKCa1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(6506007)(38070700005)(2906002)(38100700002)(122000001)(6512007)(83380400001)(8936002)(508600001)(5660300002)(6486002)(966005)(86362001)(66476007)(66946007)(66556008)(66446008)(76116006)(4326008)(8676002)(64756008)(91956017)(71200400001)(26005)(186003)(33656002)(2616005)(316002)(36756003)(6916009)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WUlMKxGfYpiu9/YpY6BsBkdZll2M2oMOFBAxWzz4wfqMy1oAVqoWb2i8utXR?=
 =?us-ascii?Q?MWMJJMLYWKPnRzf3/9eCh6AX2pCwU4Fngj/fK2a1/ZsMFD6HJuesI8QLXF4C?=
 =?us-ascii?Q?tdy5qoeU9ElgIIqu1SCnt+w0VdOkTksTe+uX/kXpE41d1MFlMuTkgCF7cBmf?=
 =?us-ascii?Q?uAnmgquXulh/bJbtqDwdsXsLExLdkRBT9cBby7bSVTTTWdaUmG10W/e39xsr?=
 =?us-ascii?Q?eVuXkxasqHjVkF3/yMHkOjc4UaoymLQu8819YCKoimD/kSvHDEoj9xYzWfm4?=
 =?us-ascii?Q?rsuKu75dc1l4tpVW1MZDdYCsy2vhSQheP1n3l/4h5F548uBoEQC9J5h9NAXT?=
 =?us-ascii?Q?+qH0vibRovxnkC5zlwHvX4kLVlOx73H7o8tp4h9ge+zGTiqeSa1yUiougy0D?=
 =?us-ascii?Q?kV3dhH29UdJ1HjtYnHC6gKZRYYzONBkyrTH1U3qFxJO26uqy8xhZkzMAAHew?=
 =?us-ascii?Q?dyr3gCcAQNl0XWr0wonKoaSkDrOCNI1QEkMFyhP6N3R0D53N2yu8clvuHeiI?=
 =?us-ascii?Q?kgDVqKTE6gz9K8bgtSFj4AOWrDDnJL2QaoubIL4uicw/x/frleULtY/9n1d/?=
 =?us-ascii?Q?GEeSTvE1CKM7B0HZ0uhO8Z9YY3y34APZdpl/NgB1VN6mmQJxV7YtyhcHzSz9?=
 =?us-ascii?Q?jkpnlAOmdOp4uvjL22ShLezCHuINl5/bNjYkhMuyblIWXdvL3pVkvarY7SbJ?=
 =?us-ascii?Q?6X13tMr+mOa0JrdIYfwSVv8y3AicACc0yVjPtEVU1l5m7tMSY8XAxUjzsPw5?=
 =?us-ascii?Q?pKIdXh4qt6OjJmM+UCMNS7+DCQQdE6AZ7+GkkIDgxe3eruaoWNoGKFcJPQYP?=
 =?us-ascii?Q?3eXdYGIOU4DjlBqEAUivrHC2wuiuStNAQ+yGRRTvfcKqBXFiZsRK4pWpr4Xr?=
 =?us-ascii?Q?e0keTijucj7l0x95BfU5dRz5ADzPbRK4K1582MV+6WzRcUaA5rT0M+mp9gPJ?=
 =?us-ascii?Q?Sd7DrX/TuGcgrsvplGSXQXw74ldHNGsmYt7GK0Sdb28PSXtyPCulzUn6pdAZ?=
 =?us-ascii?Q?k1KihO2Iqi3azhU4B293nJSRUmpQlBrZ4VuH4c9nEoQAMORdt2ApPycrT1t9?=
 =?us-ascii?Q?py9Dzn2+CzTJ/4daCK2EdRzDuNWgu0ywtfTQWt9M0O6dPE1yc4IdmlVcDFxc?=
 =?us-ascii?Q?Q9PqbnJeKKvXpoQRmagfyACyDR0NbYi9lGl7OlLKEuP6JhkR44I7GeXEQdW5?=
 =?us-ascii?Q?QFN/HVK5QFOTHpj4Y02OiitbXhdfbLKuz2KwiJ1yGWwjobtMXYTnrbkg2dC5?=
 =?us-ascii?Q?mXJFBX08GWwN8/doWPAvl6wVZHf35qYfexKndvc7fgpYDFQpBVNlY9WecB+b?=
 =?us-ascii?Q?Y47+HBDwZcc66CA2o279KDUah2so8OGaMjjoBUNTFsObPYooZ6o2mF5gnzLR?=
 =?us-ascii?Q?AWpsJsqGoo2jkWyrzs4LHMbDDc3GJYF6Dag/8uCvDwtwqibN2uL7FN9Vz13l?=
 =?us-ascii?Q?Q9jTQ+Fs9HKgFvHrv+TYAu3tWpKw4fxanT74+ldJ9WDUb9nyRE2I3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <78F30F064BE01F4697E897723A194790@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ceca9f-59a8-406a-ca21-08da0848a344
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 19:02:09.5102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocSybme9naaNV3E4L77seF0V4RzchmtHP7WVNteN0KNkuFdY3T0OUXTM262co5H81MUDpbD6bZ9uodGEpM7M5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1912
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10289 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170107
X-Proofpoint-GUID: 6zcg0UqkAvpdNv4NaNzPLnh-mtF_qaI8
X-Proofpoint-ORIG-GUID: 6zcg0UqkAvpdNv4NaNzPLnh-mtF_qaI8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 17, 2022, at 2:42 PM, Bill Wendling <morbo@google.com> wrote:
>=20
> When compiling with -Wformat, clang emits the following warnings:
>=20
> fs/nfsd/flexfilelayout.c:120:27: warning: format specifies type 'unsigned
> char' but the argument has type 'int' [-Wformat]
>                         "%s.%hhu.%hhu", addr, port >> 8, port & 0xff);
>                             ~~~~              ^~~~~~~~~
>                             %d
> fs/nfsd/flexfilelayout.c:120:38: warning: format specifies type 'unsigned
> char' but the argument has type 'int' [-Wformat]
>                         "%s.%hhu.%hhu", addr, port >> 8, port & 0xff);
>                                  ~~~~                    ^~~~~~~~~~~
>                                  %d
>=20
> The types of these arguments are unconditionally defined, so this patch
> updates the format character to the correct ones for ints and unsigned
> ints.
>=20
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
> v2 - Fixed "Link" to be a valid URL.

Hi Tom, can I get a Reviewed-by from you?


> ---
> fs/nfsd/flexfilelayout.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
> index 2e2f1d5e9f62..070f90ed09b6 100644
> --- a/fs/nfsd/flexfilelayout.c
> +++ b/fs/nfsd/flexfilelayout.c
> @@ -117,7 +117,7 @@ nfsd4_ff_proc_getdeviceinfo(struct super_block *sb, s=
truct svc_rqst *rqstp,
>=20
> 	da->netaddr.addr_len =3D
> 		snprintf(da->netaddr.addr, FF_ADDR_LEN + 1,
> -			 "%s.%hhu.%hhu", addr, port >> 8, port & 0xff);
> +			 "%s.%d.%d", addr, port >> 8, port & 0xff);
>=20
> 	da->tightly_coupled =3D false;
>=20
> --=20
> 2.35.1.723.g4982287a31-goog
>=20

--
Chuck Lever



