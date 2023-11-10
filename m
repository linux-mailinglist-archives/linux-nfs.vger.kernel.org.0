Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EBB7E7753
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 03:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjKJCUC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Nov 2023 21:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjKJCUB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Nov 2023 21:20:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CE73AA8
        for <linux-nfs@vger.kernel.org>; Thu,  9 Nov 2023 18:19:59 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MZHPe016135;
        Fri, 10 Nov 2023 02:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1+UKr5QbmCDB7vs86mSh6f7ciAgcEUGF4PKtkpiWL48=;
 b=SnIDAmvkLHyujn/3y7OXyol9J3jNfT33y0MSm/w32fMP5o8o0e1xjM8RdVp5hSI+oE/K
 Gv61DjIXURu8fZi2EFDeh0z5+5xx3UDI+2hzP0M2/5mOoNeCmsBIdATVPKXQc9nEyPXR
 wxhMSGaZy2JU1hY/PaRiIBLe0mW+LtxpvRfUWHG+FiVQpiknMkxU1vHdMprmHxTebJ4O
 /r92iXvFq6fTcWQAraZO2ooT8bA5UJhB4IVmkmNI46eCqBH/Ly/88vdmK6XSlD4HYyDS
 c+uM+326txXtI7Nh8CC5U6KkcQjuYmrlqg8pjVavU2E5s/WQrXKbuK1HCvyDQA2JAT6g EQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26waqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 02:19:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA22hnb010968;
        Fri, 10 Nov 2023 02:19:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1x9pmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 02:19:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YglpiakP4ODNpfy+x73rR7+NCDh3xSXdqeMjOO7Fsu5VBL21awDIc5nhp8ifw8QEl428BfFYexuIEvYwrKLZuGtpfDsvp1FtjX6QRFKIpPdvITd2LvKuiO1+Rt/Jts86o0+D2LhP11YmMcQJNpH0m6rgjVSvXDTj1wqTh/m0BqL/dWbYyolDVFvEEaB62ulx4Ipt1JDUWAVwbILr38mLagmXtAxPBXLbQl7LClMq8BE71V0LdpyF+PGLmD1SXId68brsirUoDJwhJKOrIq45zKGyuHcMTau3qgXVHOtgm4khVxRt1qEhAYLWNYgEHXp+/0W3jQIASiEyYp+Ngx8wdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+UKr5QbmCDB7vs86mSh6f7ciAgcEUGF4PKtkpiWL48=;
 b=TrZp9KgJPnF73MsAFjHghcaPxrBuw/PoFOPnMQB6xrJsMMgMolFGlMpOFdCjh7Uckey97xtMzdX+4zT0ZLc2OzYMOJJmt3i9zyeWZDxaG2QJW7jYf3j8qG6UQO7bE1i5tJtRvPCPjSfPnyhw+tdUEuqRK7Pfw9fpzlfrt+TmOodI7fvmVuPSr8FhCfTzFx9VtbpIEt37/KiawbJa1Abyj7HQimZlk+V46vlTZ/nhqb1c2Jw+QNAqkZfkIv5YHxi+qIVKyvPjh5nVHdoHEXvSy4POV8dGcWWSQkO9bHXaof7poP31JR0OJJEqRYxdn611zxYj09rxeon5KkbIe7PTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+UKr5QbmCDB7vs86mSh6f7ciAgcEUGF4PKtkpiWL48=;
 b=fyXbNt2rSsfth4rz6qy4nIIiilq1QtlVTutIIgCyUZ/m4s6518uy0spf4cuohHYNjAQj6i60+Lu5IPBnJsu5hi8Z0AFImgeYfurjm/32g9cF6nhCs7utzKqbQdH77XByoFCvvioM6tlz+rnxaQa+N76vT9KOgSkojlhVj3TxTCM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5074.namprd10.prod.outlook.com (2603:10b6:208:30d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 02:19:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 02:19:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Cedric Blancher <cedric.blancher@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: BUG in exports(5), no example for refer= Re: Examples for refer=
 in /etc/exports?
Thread-Topic: BUG in exports(5), no example for refer= Re: Examples for refer=
 in /etc/exports?
Thread-Index: AQHaDXJPkaKnFSGKLkeVN9xiH7a/Z7ByuFQAgAAI+gCAAALcAIAAGasA
Date:   Fri, 10 Nov 2023 02:19:52 +0000
Message-ID: <FD981B2C-5C24-4349-A279-C70F640C0A01@oracle.com>
References: <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
 <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com>
 <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com>
 <CALXu0Uf2z3um+kh=tgnqskr-ZdY2gU=185K3Amr=F_GJpb2_UQ@mail.gmail.com>
In-Reply-To: <CALXu0Uf2z3um+kh=tgnqskr-ZdY2gU=185K3Amr=F_GJpb2_UQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5074:EE_
x-ms-office365-filtering-correlation-id: ddaffe8f-248b-48a2-346b-08dbe1938608
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w7kH/txJgfYUa3N0HlwKglXGvDvs5yucD3d/jCdTO91SSF7Lcl5SBDEhqV4CV2UVGvx5cGHhJjA9MB93UDruKQAHEt6zn27i9P+LrI1GNhlfse4Xn9xFdstOfgom74H2868Gxy6ftBvdZY+4AqPM7yP7C2u7zDPFq843Eer2ROyvGFq7GNdKsBJgPssQLJkDXFCxDfibrG+Eb5I5RaISyzNdRB4cK9/Vhmi1y9/qeoLMIqKOSCtuTw/0Uys/WKW3jhjK3HAsG9Vv0rPaKiwaV1dspyOP1j96l4iA4x4yeNmhHGA9KCK5bLlFDvB7oG9ydWw7d9GQ3Yp3sPWGOcvb2skdLj/nmnAQV9ViB2nAq70TDj08vQHmib0APIWrhS97uZ0IogGnMSOWwfZyxbj3saSkULCWp7srYBNpHE828IY7VSglWNO9dpSXZdGv0x3tLvGDHXAIZe1CfOmtQ7U6ogMT+PQnrI+XWwx7SKoJa0tCugWjvq7FsyLyQVhvJcFdBvvOywLM0g72/eZSqd11cw130mCu4IZ79HM012ch7fKVnkK5mJ4j90uN6zpkJsIU5vCOpXi4y8e25Qt8z6i66/yZ96rIGDnhDcgKnzpUa+mz8aeS9rQyCWd8537ZRv4SIhtM48MI27IsZL6e48a+TQGGR2ANmEecc1htFVEhQYNDcbxnF1M2vT6XUyZ/802lK6ShDnwNwQmyelc0tPlTgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38070700009)(91956017)(316002)(66946007)(66446008)(6916009)(64756008)(66476007)(76116006)(2616005)(122000001)(6512007)(53546011)(36756003)(6506007)(71200400001)(38100700002)(26005)(6486002)(478600001)(33656002)(83380400001)(86362001)(66556008)(41300700001)(2906002)(5660300002)(8676002)(8936002)(4326008)(148773002)(45980500001)(47845010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?slM8GJy2AEyRgYPTBN7g/KmdFv/POYP/kE6c5UR/WacuWzXvgw3F+bqmxLvj?=
 =?us-ascii?Q?EmQWF1l9GXhSBE6zQFIe7fiR2OFlu03TPpD47pAKtqpBx5Q6+re2fbs3kMBy?=
 =?us-ascii?Q?QvbpKr2QKBragJ9IPGKl8QMFytwlhYAKG1bRhJb2euX9lBoMXMAio0dTIjJI?=
 =?us-ascii?Q?YQ/+C/WfA63jpCWMPHum8HmdhzNIWva5dnpbdJhB3nVtMxqXc0bwmvAdcaOm?=
 =?us-ascii?Q?27Nr+1Gb+QhvKDdGf+4wAVQlGgrDSI3maPR5mjHfZCHpK+GcYELI7/z8kXMD?=
 =?us-ascii?Q?PYtcV8btZWK5NDrvERG6vWrQNLppUGrDcJ4fqTSiXf+xL6MyPbVyVFsSLliF?=
 =?us-ascii?Q?7Q72OmoecIoXRFmQGZeEBxhC/JcGsWW9ATy06WspoVoJaLvXzTNH1455Qyyd?=
 =?us-ascii?Q?U5TKnBtkel6U8e6ESTTTmjgK/qvzcssGubEmthj4oL5fN6GeazznRSEVNJOZ?=
 =?us-ascii?Q?k1eFwXWBezNHR+gpAX6FXLmztF0AIK0zaOaajnYGnUzwbWEjH3rAZHOlx6Vi?=
 =?us-ascii?Q?FY7C0cE3s0SofUfmOt8rKYJNg4C1/z7uXVA4ai4vglRIrirwEf8/+E9yfYMu?=
 =?us-ascii?Q?fFkz98HpW888NEHlnrtzigPfZR5xB/PerjcFELu552xIiYUyRO9clPHfpY+y?=
 =?us-ascii?Q?pRopFwTYnYA95qIBnduFfOR9W89MD5N35KtkkC1rkgNiFgSy3pRn9FrR0HYV?=
 =?us-ascii?Q?xRrJu5wA8R1Js4/cq8gcgtG/hQNxYAokUi5RcoxvG6+FXUYz48HKC6drk7Ip?=
 =?us-ascii?Q?VuX2CTaL06kF8KomufM+Nc4SEwP0bGuXJiJTu0tOLCWyX13nV5V05gqGmdxV?=
 =?us-ascii?Q?D32I5CO9oa4FgNA7rDAsHSbq3z6Ii6RiQK4l93hFOIZKubwLsGVZ97E8s7hZ?=
 =?us-ascii?Q?cJXxLQFfPT1t5kT+2JBXw1vQq32OBLa5ZnkgtdaLZD9a8m2ZAX3tXIGM6f1S?=
 =?us-ascii?Q?v0c7ocm2hAc87noIjJH90PxP9+H07D/EtQurs/RqfzhDxw8dReMU6O0DDO/r?=
 =?us-ascii?Q?lgLWPCWldtErDy65sW5Isr4+qM6WD6YAfvuw6CCcz8MmxUVouSMTlg4psCFG?=
 =?us-ascii?Q?Kmp72pSEFvSgo9LXe6w122pAAowTn2WigZGoMk6z6Np0tC5rOU4S9he+KIBQ?=
 =?us-ascii?Q?SW6IP+sswN6foFO5HCQslkkji8XGGxTZFohuk87Ow4/BJ9jsE6bXcZnD84pE?=
 =?us-ascii?Q?ctLgqKHXDgbPUWikKsF8abx31XQ+5ZIv6vrkfkj9YjzD0XS5fZh7biW9SQvb?=
 =?us-ascii?Q?VgWDxzmsq7fylOhNDmlLYDAlI8LMUStO7nfYydHCE2uk8n0M6fq4lJLTyi6j?=
 =?us-ascii?Q?cmvcJZ1/cbWzhZyJGIr2VyITRo9qSW+rwbC5mbDEfwH74WIVMCWNxYF1kLpl?=
 =?us-ascii?Q?Nb5ICYkTGlPbqmYCkzPkjp/KfWESFM9QBZEoiMXZSAu+oKdr84X6ZKOMRU5O?=
 =?us-ascii?Q?5vlrBymD6vD9qkqXvX2dl44A9PQEaXkoKHG4apn1UxuL2ujjXj3rDJ/ukvgC?=
 =?us-ascii?Q?KDvbyitmKvDQBfACwnWtTnXte9/EW1M/+TEUeWmTyaFmALIgecgOKPQwaqrb?=
 =?us-ascii?Q?gAT6bLbhnOupwdqIymSuklAriB87rkop8Vwyq4vrvigjBQbC/suqMV0lifkZ?=
 =?us-ascii?Q?yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6550EA3EE05FB5458C0A3997DFD12BE3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +wXa5qHuZX7O2GVoNpapkF5DOlvuBjE8315cDz+ZMVP3RwmTKyvfpQEXTCoD3ulFA+bQfP+yqCVfeazIITyI9TQeB3NzobZ/a8WVYYAxnjVXcfUNb13ShAMTJs9dy1Az57E9ti5U5QWVTM+vFkmrRnPpRMnJff/7WX/Pwxtr62MgSuyLQ7DjNBl1bQ7krLbDdkX45ApRHpRJO3U8/E2xDYqoXn44qNCKiGfg3Xq5OPXzj7z/DDoCTjGsemEYrUrd65iZH2J7bTLhhHZtAeJnalS7ZYN48oDZ7k8YeZpogHtWYqLNVxTZMKmn2eW9TH5UghJW/PI7SalHz9yR1NQ/d3amhn+yjayvotqCR310xcbyOvXw9IBQiCio5CTsYPe2zOi8+LqZ1ZIT1f/tzajXbtaoE7cMJWz3liJhrIGouaTMLGmzZyAPYQvt+1kQ82UFCVxmUwYa/mjZKE6hAq11JLJMkw4fh3mc70HP04ZXTG1xbPvFS/wSMQC3wsp7oHf3NTufnRYyft9VowPrlWUgQYKqi8VwjUNcqpZFQ2YRakMuJZE9l2Yv/fvUZBARUenuAnRqSumJNYGTmCc+Qr9d+A+TCMiwET9kvzu8fvRWj/GQvFP3uHPudcNlqLYOdLtOqpsSw8drqZA4fdjiDVgxrxhLJ3yfca0gIQAX2Eak/3gcKepatoXMmfSGxXSbeLuXlXT43ilaximm4j2NgnlK05k5k7wSBBW+EK6OpLwcw0eHW/OiUwjenFmdbYi9LYkaTq5DlPKcp1y0bF5oKR6LBNlMH93yHXvjk1lptFGQcEU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddaffe8f-248b-48a2-346b-08dbe1938608
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 02:19:52.8049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o4RAGUwjCY6HhUu6HI+u2e3ONPnCQlBEPvNi+mTffC5IiFtiHCjCpns3Q7r+pq/uSupHS8lxTXEolrPDh8XKtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100018
X-Proofpoint-GUID: SwiCvwz09JPIFA06PDmZr3uemWDXAdyz
X-Proofpoint-ORIG-GUID: SwiCvwz09JPIFA06PDmZr3uemWDXAdyz
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 9, 2023, at 7:47 PM, Cedric Blancher <cedric.blancher@gmail.com> w=
rote:
>=20
> On Fri, 10 Nov 2023 at 01:37, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>>=20
>>> On Nov 9, 2023, at 7:05 PM, Cedric Blancher <cedric.blancher@gmail.com>=
 wrote:
>>>=20
>>> On Thu, 2 Nov 2023 at 10:51, Cedric Blancher <cedric.blancher@gmail.com=
> wrote:
>>>>=20
>>>> Good morning!
>>>>=20
>>>> Does anyone have examples of how to use the refer=3D option in /etc/ex=
ports?
>>>=20
>>> Short answer:
>>> To redirect an NFS mount from local machine /ref/baguette to
>>> /export/home/baguette on host 134.49.22.111 add this to Linux
>>> /etc/exports:
>>>=20
>>> /ref *(no_root_squash,refer=3D/export/home@134.49.22.111)
>>>=20
>>> This is basically an exports(5) manpage bug, which does not provide
>>> ANY examples.
>>=20
>> That's because setting up a referral this way is deprecated.
>=20
> Why did you do that?

The nfsref command on Linux matches the same command on Solaris.

nfsref was added years ago to manage junctions, as part of FedFS.
The "refer=3D" export option can't do that... and FedFS has gone
the way of the dodo.


>> The
>> preferred way to do it is to use nfsref(8).
>=20
> nfsref(8) is not shipped by ANY Linux distribution.

It is installed on all of my Fedora systems, and it's on my
only RHEL 8 system. That suggests, though I can't immediately
confirm it, that nfsref is packaged also for CentOS, Oracle
Linux, and any other distro that is based on RedHat Enterprise.


> The configure switch in nfs-utils to build it is OFF by default,

You're talking about

  --enable-junction       enable support for NFS junctions [default=3Dno]

Perhaps that default should change -- it's been part of
nfs-utils for five years now. However, that drags in
dependencies for the xml libraries... maybe someone thinks
that's a hazard?


> and the
> distribution maintainers refuse to enable it because it can be
> "dangerous", or may be "experimental". I got many excuses why they
> dont want to enable that damn configure option.
>=20
> Also, stable and oldstable Debian do not have it enabled either.

This is an upstream mailing list. We can't answer for what
Linux distributors decide to enable or not.

I've never heard that it was a dangerous feature. If a
distro maintainer has a concern, they should bring it to
upstream.


> Seriously, why was refer=3D in exports(5) depreciated? There is no
> realistic replacement, unless you fix every damn Linux distro first.

Again, all the RHEL based distros package nfsref, as far
as I am aware. And as you found, refer=3D still works. It's
simply not documented.

If your distro has decided not to support referrals, there's
not much we can do about that except gently suggest that you
switch to a distro that properly supports them.


> PS: Sorry for being moody, but I tried to get nfsref(5) working for a
> month on Debian bullseye, and it just didn't work.

Did you report problems or ask for help?

If getting it working is that difficult, perhaps your distro's
nfs-utils maintainer couldn't get it working either.


--
Chuck Lever


