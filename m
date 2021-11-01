Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A634441EDE
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 17:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhKAQ6g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 12:58:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21574 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231453AbhKAQ63 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 12:58:29 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1GJd2A018787;
        Mon, 1 Nov 2021 16:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PwAL/VBeOfDPTr4QNvw2HItU2jrjOBMQ+YpyBIsJKuU=;
 b=JUg8f1XPFv0bNUbAc7Y7HcJv5NX/MdM2kov6qHQSrKjTtqaRbO2qaXYz0YjN2RzCtW02
 OqpnIrEYtWRx58Ud5ggkDKuSNq9zNrilS2Y7/pps1R/7OF6KnbQg6xOWzoPrtgWBiZQ1
 nKybvqA0+Rl6w5zdQDPhh3tNdT4b3HHd+RN9tTRQakdOx6Vv5DWdfJtQOqyxXrCGAiX9
 jgRv1E6k+Ve3jWI1R7nSMSq938oHjRDa6P/KI2GbMd2qA01SbHulrJsC3aUZTHsTYplc
 3+EqH47Fd9ENLHveXZFmfCcUaApjWJV6Zoex1El67PyYZ8VgmKiFfyDlH48NE2zbPFqj SQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c2aa3ahn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Nov 2021 16:55:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A1GtmdK052199;
        Mon, 1 Nov 2021 16:55:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3030.oracle.com with ESMTP id 3c0v3cedy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Nov 2021 16:55:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCvGRGiE/HACIctE4R6bbsv0Zp4Tu+y2uIKFJ7t3oyLnsakq8CO+w0r5gxX5xgwnDQDUKqjTxNc1GSPSUYCXpiW/SFKxzzfwYvCoXw5j7Cllya2ur+vHWh4wuUSeKrPbUGFhQQtJU1DL7pqiPbpfhbwdeFU0ShIyjUKb/dnYa4Q5kyYLxFkvN018ubiJj1OtxDRr8j1Tn0CeTWd1lWU2MEMWGM7NFRZBrMaQb3qV1j59Y/oM2qvzPSrNGhUQ9Sq2p3X1hYjEXoAlAnA74Ipw4PtEo4Q9t7h3R5Km380eqMI5sZyLM7QUpQCAnn3vQhSpFoYDN7dsp4VZv8nK7VSOMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwAL/VBeOfDPTr4QNvw2HItU2jrjOBMQ+YpyBIsJKuU=;
 b=L8oPtZtB9Y7uPT3hXKA3mU38R1ITaj4W2d3LinaIvmtbiPr2UJte/tb89pX4L++LpRRCj+a5pGfUk4sUjYXcW+QAu26CWSFexUC4XW6K1U3gKSXwcjCFH9gzW2SEGuKnEwI0aRHZuUvHJTAdd/NGUacGktuWXAHlS0+/gKlrVnlgZUy+eU6rbzbHx8bk3GCPmO2I9IPeuv+uKiqhSdfN+Yvh5dFIakuwvq6hkpj8OJzgdLN4NxWdrJB3slMH3gbffLxMy5n7GVOJcMHbJSLn9zcRlotvQvkBvfCmqBsnqqwBvqyrkq7p+MJbH2KPyvDAfTXhD2cqBIECvGXTPDzZ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwAL/VBeOfDPTr4QNvw2HItU2jrjOBMQ+YpyBIsJKuU=;
 b=be+J4pT9MihK2EdF5K+fGVf4mDhfOTkT8FwfnYLLwY2BgRo6fZszk4gKqyfaFOCaWcyy6d5bCngSe2jthAXoMKOcYEtSm++1/ihjpN2RPl6ChfFevIx6IoNueL2MFo51xbWr53CW+gJogNY7CKPNW0nk7VeyNLM5cDzdEzYF0xo=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4210.namprd10.prod.outlook.com (2603:10b6:a03:201::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Mon, 1 Nov
 2021 16:55:45 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200%5]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 16:55:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/1] Enable inter server to server copies on a export
Thread-Topic: [PATCH 0/1] Enable inter server to server copies on a export
Thread-Index: AQHXzAr3yIMqaUdei0uEQ5nE8lcyw6vp/mgAgAATygCAAB03AIAADd4AgAAdDoCABHh4AIAAAskAgAAU8gA=
Date:   Mon, 1 Nov 2021 16:55:45 +0000
Message-ID: <93DAB7C7-D0BB-48BA-9BFF-2821D88582EA@oracle.com>
References: <20211028144851.644018-1-steved@redhat.com>
 <20211029134534.GA19967@fieldses.org>
 <3e928624-6a7a-8583-7ea4-4eef9c22488e@redhat.com>
 <20211029164058.GE19967@fieldses.org>
 <65b31c94-54aa-5035-546c-75eb0048ba96@redhat.com>
 <20211029191435.GI19967@fieldses.org>
 <ce34c1f2-a0ad-fcb0-99fa-a1ccea8abfd7@redhat.com>
 <20211101154046.GA12965@fieldses.org>
In-Reply-To: <20211101154046.GA12965@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01cfbf0d-b536-4b46-f495-08d99d587295
x-ms-traffictypediagnostic: BY5PR10MB4210:
x-microsoft-antispam-prvs: <BY5PR10MB4210C9BE6EBDA4E3467F2613938A9@BY5PR10MB4210.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gPAM6uc2y0pkvO5Xub+7RioS/SUWKrFT3mBwXbKOW0jqroVzoFuHCrNiaZ91vn4PFVOxdRKSReFUA9Yzti4whwqmOqmJpplVV3h2AMAmWgSp7aRZs1XjK4R7dcGIwqGuuSUIKHNE5d4pjV3EPtwFhWnIHjj0JrwIblbQKkq6hDAW6JA+HUfYHhxYgbl8PmE+zt4q1/UijqQ0EKxK1p2SyChmtvKxizpmhR8NEMaBnHpkbL1CDk6tI1//VZmIKNpWg3OujaOLn7HrEtUE5IKcQciJSJnRV84QueH3cvYfdRmwmSsltVQ9fwicrAZiyzToxGNQGt5TlrIKBWCVOqH8fDi08TOQjsFlRcWvnAu+P1SMmO90Tpti6KvbJTP2ZR414MI/9rTN6a/9WWkCu3nNEciujNZJ948poe4g1mTIp2Em1YmXM6mtkqLYRfHE1qHPvPZI4X65CIchUZvdHQRKeotleZbDVjmyVCh8hDAu7KwwSOOLDOpooYo/RWrtZGr+9VYTviv+Vr/nud81HyPFsY0vuDywwAY//i2v2spW6HTRXC28HvYYaxT4no55SQmlItkarozPN/Mw1pQ578NrlfKMZ7wTjqJAjnuGdpP6apz5p7VgUAsyZnw9Lc4F2vW8kQP1NHgtkibQyXhK8vqLoq7xXZIwSd0+slubiucTwBoDh18WsZiIWjCq49FU2arqTxqE85c253jPBRLdpHNcfta4i1nGYa+uKXFpmR94ySH5aJOuVHKdufZSgIwqeDb1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(2616005)(38070700005)(508600001)(6916009)(26005)(36756003)(86362001)(83380400001)(54906003)(8936002)(6506007)(38100700002)(4326008)(66556008)(186003)(122000001)(66446008)(64756008)(316002)(8676002)(66476007)(66946007)(2906002)(6512007)(91956017)(5660300002)(71200400001)(76116006)(6486002)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RtYtZIPz4IfVyz7SxKC712PF7qBnbNQm+P9DLmyDUWNu0imAZfLmsb1nUWym?=
 =?us-ascii?Q?l96AvZSjwwDwj6nkOGQdh8sMf4wpdmr+T5fuAS73ApPteQRQewXcivCCryrU?=
 =?us-ascii?Q?GnXK3NtmpffWNJpS6ySO/JfsqUK/G36amUsMoqneQS0Oem5Nle6DHAZk94cI?=
 =?us-ascii?Q?TA52cjzNnheX8r+cZAOSpg5JVSRNH9QuIZc6cREAbExbkppF8rDgJmi7rH5g?=
 =?us-ascii?Q?A7eBJhTYpDGrwEnrgcAe3GN6FItqDLRI1LpayMZNn+uNXHPNavq8dT39ALY2?=
 =?us-ascii?Q?XUaZIvCA7Vxp3+0/OZgH4Rz7p6f4OOrhkBF6obwXzFSuROXg7TqyzT+lb7ja?=
 =?us-ascii?Q?vm3zSZqX46/pV2sbWPsHER8UcH67nV2LOmy19WfQ+TNcpi5sADQPqyf5q04Q?=
 =?us-ascii?Q?btNB/TSLwPMYgDO9ulUWB0WmkuqBDPjeQr2ICA7ilt/QpRxsXWWxwjcfQBC+?=
 =?us-ascii?Q?I/MsQIQ7icg1zCcDm9k72DJgijhS41rflxDekgWowB+V8f2E8EUo6IBEYf/Z?=
 =?us-ascii?Q?NeH6X204KwCZHMy43bryA6L53wW2dYnfNoKNQFXo3jooWzeu96lcN2vS6DoB?=
 =?us-ascii?Q?7gThWDBiO23WQZOv38zIKT5tYDQilpdRuubGFkDqoQfRKmhw8eOaWKtgRpZR?=
 =?us-ascii?Q?GOK0D0zsAyi+CmQIpdUZLM1v/Z9OM+/r4aGUPFgIMQwdvNF7zSYOIjlLJpQ0?=
 =?us-ascii?Q?PoNWigdzl1ZqrthKJ6eqqUKuwxgT07Euj92dagpqs39M0CAho4Z46ThNnevW?=
 =?us-ascii?Q?UIFOtBqbdcDavgw9umarlz5HaxsOaVGo71UqF1EjcKGYl/AMYYz356YGaVwt?=
 =?us-ascii?Q?3+Ia8WP6t9M7x8hFBQpXr6JzaaT3IB1Aj5kNpMTq/Oh7IXt89frocyn8UKyQ?=
 =?us-ascii?Q?sPPBzJELE8USKDpm5NyZWekVJzqrzn4kClYB+s4HHgqUQ8t4fIjnqXzOfSJz?=
 =?us-ascii?Q?/j42JTRZxnnNOaHof7utZraaAHKWvFvWI88kArAZAfxWJ0s5j6RK3+zhmsx7?=
 =?us-ascii?Q?FqviYlDtQxA9sB+eYxl+/Bza+V9OF7tIN/G+uB3XZWqkznQLgh9ppoGyav32?=
 =?us-ascii?Q?tqPhZTV3jJdK0uwV/9rYjjDCTBHHdog5NyPeKgC6qi1ZdOchZ5/TCRTHulqD?=
 =?us-ascii?Q?YpSqpp+g+rDf9qSh4Dv6+Ten8l1Uda1vxGgg7U3IhsMTIN7ytDc+qR3zpb9T?=
 =?us-ascii?Q?nijTaj0tp4iil8HlmO1Vkwalb/huBx9PjWFgUJK2EHRxT3yIo1NUSqgw2dfP?=
 =?us-ascii?Q?YcA500dtsVBhVfSeIz5l5U1TL6ZCn2MdQOwljaWEYOq91cff2cG65NGSQPXY?=
 =?us-ascii?Q?90mUDiNr/23zkTxlukZVg93BBtc/vQDHpC414pVTlTqNMDKXf2uSioJG8RjL?=
 =?us-ascii?Q?4UCXe7gJ/1AH2Ia7vIowHuJnzCPDVWu24CQgeFZmFh232ZpIWzZzzLX4fVEW?=
 =?us-ascii?Q?k+mEmU3gvHJy2Sq6XZhxiVUyaSvERivhQ2UPgcetuDDeEyQ0AtO5xJbTykGi?=
 =?us-ascii?Q?ww/wQbJz5j1vr/1m/AMTO93V99gNicSMn58bzKmAgwey0K27SUWgr/c2mX0I?=
 =?us-ascii?Q?5djCjJuIJlM0haHv6gyfi/8z58S29NIV3Aq+CdIbHmWRbHOdEA617pvAXubh?=
 =?us-ascii?Q?0q8Wfu3VTgusz1MuzYdG1O4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A89ADC7DBCBFF643BAE1C1A1898268FB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cfbf0d-b536-4b46-f495-08d99d587295
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2021 16:55:45.2956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nt+HanRyCTH1jJuzdjGtwQIMSUrjMWZuli2p5AMgoKLXjdVTr76pmGoJghcK4jXNxEZjQuPeZ8X1J+DiGCxJSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4210
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10154 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111010092
X-Proofpoint-GUID: 6GEZhg4ZrdHQgXjKTtOSfNtaKI5W_BXW
X-Proofpoint-ORIG-GUID: 6GEZhg4ZrdHQgXjKTtOSfNtaKI5W_BXW
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Nov 1, 2021, at 11:40 AM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Mon, Nov 01, 2021 at 11:30:48AM -0400, Steve Dickson wrote:
>> Hey!
>>=20
>> On 10/29/21 15:14, J. Bruce Fields wrote:
>>> On Fri, Oct 29, 2021 at 01:30:36PM -0400, Steve Dickson wrote:
>>>> On 10/29/21 12:40, J. Bruce Fields wrote:
>>>>> Let's just stick with that for now, and leave it off by default until
>>>>> we're sure it's mature enough.  Let's not introduce new configuration=
 to
>>>>> work around problems that we haven't really analyzed yet.
>>>> How is this going to find problems? At least with the export option
>>>> it is documented
>>>=20
>>> That sounds fixable.  We need documentation of module parameters anyway=
.
>> Yeah I just took I don't see any documentation of module
>> parameters anywhere for any of the modules. But by documentation
>> I meant having the feature in the exports(5) manpage.
>=20
> I think I'd probably create a new page for sysctls (this isn't the only
> one needing documentation), and make sure it's listed in the "SEE ALSO"
> section of the other man pages.

Aren't sysctls documented under Documentation/ ?


>>>> and it more if a stick you toe in the pool verses
>>>> jumping in...
>>>=20
>>> If we want more fine-grained control, I'm not yet seeing the argument
>>> that an export option on the destination server side is the way to do
>>> it.
>>>=20
>>> Let's document the module parameter and go with that for now.
>> Now that cp will use copy_file_range() when available,
>> what are the steps needed to enable these fast copies?
>=20
> 1) Make sure client and both servers support NFSv4.2 and
> server-to-server copy.
>=20
> 2) Make sure destination server can access (at least for read) any
> exports on the source that you want to be able to copy from.
>=20
> 3) echo 1 >/sys/module/nfsd/parameters/inter_copy_offload_enable on the
> destination server.
>=20
> --b.

--
Chuck Lever



