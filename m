Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F2564101D
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Dec 2022 22:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiLBVlw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Dec 2022 16:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbiLBVlv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Dec 2022 16:41:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37CDF1168;
        Fri,  2 Dec 2022 13:41:50 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2LOt0c003761;
        Fri, 2 Dec 2022 21:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=D3Dxc2cJsrw2KtQ6jDw4+0+s2FKD6+d2fW1EJj+Q7ZU=;
 b=AYlyu9geLR2AjKQENLUsxdzf+JBUhI9eib+DX0J+E2/GRLpqKfcApPBXvqKAy1ACYxnt
 Hw20LDUcWoQeHHOeUNK7+MFHqBhn8HCY8LWcYHXgGcbHY6xKeuoDql9DyaDwht7nFm0J
 pepce2IWZGmN8C9qZZchs8krGkreII067ta319HUzpmOp/DZh746Y30qWrTQtBTK/RvI
 2mxr0XmH2u9YNQj3ovGqUCFL5cHAXn2CjaQUQ3HVFcuiE1ql2u3U/WDMvB6GWISSMAUZ
 Whhqy5J1ZFS+jvuUL1s6fP/k+t/RoNf2mRfHoOTYmfIt7z2Fvp5tSQlIdbl/9hEAOJd9 Hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m782harfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Dec 2022 21:41:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B2LGBfN003848;
        Fri, 2 Dec 2022 21:41:35 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398ky06e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Dec 2022 21:41:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auuEnVav53vmRk4nXJ2Pp8NMwFxw2BCCn1thFAh2rZeYns5k4zUnMiwRQY+UbpstlwDup1Y7eov6zHHBCWB1f1jN0zP66pgJ4mi2sp4aJU1LTQuwFApCDssfpG778iEdxfUowA96qorSp68g4NiA16n6Gev99jIqMQZVDSDk3PXzFufhGpMsDcl7PxzmPJ2/Cs366g667w697xkRelXQIvmUCl+xsAjT1phqkuhlT4JvE274K9MMTGnaQk6sysGFDVGRLetUEX8qphgfeWkQW4mfcmEwrqPg2tHc5TfJQaTo22JseRPxUEoET6BM6x+su37QFoG62RQZFotfSqvRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3Dxc2cJsrw2KtQ6jDw4+0+s2FKD6+d2fW1EJj+Q7ZU=;
 b=G5RZN7cI7bQ3/4E6RYjYkiySd0wyqQBthX2J9tgB5asnrsGt47SkKcGffWurNlur/aieixe2DKF5iUKVrRSQjtbmApThlowMcPScJv+Q/R8r0DZZK4WsMO8j0VK13j+4iHEnsqGD8eQZtpnGL/cKQgZUoNGtGrwenWyEKUfJGBjnfGJkWQdqtWV0GbnX7tekpUdAj4UpSFeF6SN0pdxDrr+I1PLEclu8rsxTJzeR1nXHBuIt7HtQpkyfFXiUD/0PhYgVCFnD7al+unP56leuDsuPs3Lo8FrzQpDHJlbGE3OxijQ4eX44D4xmKmjdFXIWjrlfuLUJGxoLxocMVGgO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3Dxc2cJsrw2KtQ6jDw4+0+s2FKD6+d2fW1EJj+Q7ZU=;
 b=0MKMG1yqBuAG64RRE/qrocWFh1Dh0C/f0ogASKwzfk1lR5KhownyUCJoyYcR8J/UCrkP6H+XGfJI0A+SCoRbIKrdzc27A1zqgM7yOVeawUZdIJGQLT/woAqiQQqic9Mmrarts+FBmm4fH6piLw3t9XMkIahi1oUQYdlLfTrPZnQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5656.namprd10.prod.outlook.com (2603:10b6:806:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 21:41:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::1fab:d731:c933:ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::1fab:d731:c933:ed%9]) with mapi id 15.20.5880.010; Fri, 2 Dec 2022
 21:41:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: Avoid clashing function prototypes
Thread-Topic: [PATCH v2] NFSD: Avoid clashing function prototypes
Thread-Index: AQHZBo+HU3IagVKRREW2ZalyBp72VK5bIJAA
Date:   Fri, 2 Dec 2022 21:41:33 +0000
Message-ID: <E1D19946-29B2-4844-BD9D-F91E51222E82@oracle.com>
References: <20221202204854.gonna.644-kees@kernel.org>
In-Reply-To: <20221202204854.gonna.644-kees@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN4PR10MB5656:EE_
x-ms-office365-filtering-correlation-id: a780956c-2ee2-42fd-96ea-08dad4adfaf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: upJgU7usHGAffCuwrIxUvbp0NA/MU+dGdtNju6UPmkasT+ec9aFcOk5fChrrQv1Kv+hTYCXPeRiTXC8GkZcfNVNyQNPtoLf87VKzAoAFRErvjrpZJFk2vXoTdEmMn5U6S3YyJo+FFcXCHEIWwzf8E9hGy8q5nB+ZcSX7jEyjInq5lFdnge8d2faTx/uF4N2EqET0Zhj164kKiJqHKd98gFW8N4I69BQNJzaxuxal0Fv5W2Ox1rKuyhDTsPPMDR8mTdxNXq8kU80e8x5b2wKIuwcmFbDLGDUiO45szE1R44ypv1/ygFV9L0UsI1LXmEeXuGHOe71MpVl20JIjhyQDppSlPB0EUuWRbt10EnWTeL/6YGZ4gJosjztqux81tuMTACdtRzpszFWpTp11zESvIs5FovDsSxTUm1cQSgY9eB6iUBvdCSJlfjVMxrZ2M3PK8j83s6oF4Ggc85I/dFPjmCLL/msDWd2Pp1Zx4jxucnp0LMAIOfsdY5vP/U8C6uvWGVh0h64oWpJJY6wQ2UufXBIJXZtQSdA8ctVVsSIp8F8McXA7H0oAzQPBJWLi3OWN2nUuehOeIZAmYfAQPMTPZvT5bpsubv52mufqaRbbIoh0g8zI0O4XPt7ACFok3Q8w9Newc8DWAuAsM8dVbsV5W4yCB6GyDj2JfLmX7JsaAQ+291NUwfwdxLxFM1F9nqAvzdo5tdV2YYAQexHr/PbsNSTreYObvd5TDG4ArXUCnBZSsDzhet+HA5VKP4YeY+Uf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199015)(38070700005)(2616005)(36756003)(86362001)(6486002)(33656002)(478600001)(966005)(71200400001)(26005)(54906003)(53546011)(41300700001)(6512007)(186003)(6506007)(5660300002)(4326008)(7416002)(8936002)(66556008)(316002)(64756008)(66476007)(76116006)(66946007)(66446008)(6916009)(8676002)(91956017)(2906002)(122000001)(38100700002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bGX59LA4EPOYKz+4LstOMOV4i9gsbo+f7ea0TkqrU+48tIHgjOgv3yKngnl5?=
 =?us-ascii?Q?7WuWMMsW3EOwVOtmlE8O9C7tM70D6cOi1dGq4dq/8R9TnEzL4zZzKF7owi+K?=
 =?us-ascii?Q?UbYzMRAL77ic8AsZTIfk5CvhJWqB5NTYgxxpM5nhaSnv6An2KWiTHyzOaWNm?=
 =?us-ascii?Q?HMkfX4MI8haICeupRsN/5WZ+jaK3Zjni2vTwxgza7EsbR94WsZdKNP7Pm9K0?=
 =?us-ascii?Q?uWiBY9DUSAD1fYICG9lbB41woYkF13Pf1ZHhXGbqdJO1gWc+nbh62GB2vfWt?=
 =?us-ascii?Q?FMRGAO98EMfwcbGVH2J458Am4pLMZ6mFxqxTRHdvlogcn+V9vZfcnPp+5MYU?=
 =?us-ascii?Q?c5RlhKOqeH6lIn6ZXWPu+SDCgy4eYomPzTW+aOOSUboHiIsUU30hU7RRHajF?=
 =?us-ascii?Q?pmgKu4e4nrDqmnBb07A6kPxzbkjTQ/pmIdAm0G1RQ8BAE05WnL7zAyu7z0VP?=
 =?us-ascii?Q?Z1ozzatDE4/5RFmgmHcwhDJ1uGtOOXdZzbzqOarvigh3NtgtWmUMkpvq+Klx?=
 =?us-ascii?Q?CCkbRZP3bkI7Bb+kFgRq239opB38ohOuqHAdHTrxUDiAn9y3x7q2uIpm5ncO?=
 =?us-ascii?Q?hPv3Uj/anXUD78EiCI9amwGY3nDYvfjVc99WTJ2Msko92dTJLoCt12eyp1O0?=
 =?us-ascii?Q?JJXesOOjx2xQr9CKVuELtGb4O6LF1vedcutjW0+Scfu7hwgYVsqf3/3wKYLb?=
 =?us-ascii?Q?vZqA2XkAYf91gZOU74L07luHpRsYYaUNOd0CefsK0CEcA5gCsFml0EyJN5UA?=
 =?us-ascii?Q?o1NrwvIlg36BN/izj7miaZ7eLsynLi64GaW9VPQMC6LmyKiQt0W8mTtIs4iD?=
 =?us-ascii?Q?rkRLjSQPTjnSTUJxhUNjxdTJWEpNvM6xnrcOPPakx17LB7iyU5Qzk6OmUPxM?=
 =?us-ascii?Q?bGqwVNJWG42/nc4jjyXB9zpGSUF85hF0wfCSpbhtBufjUSAt8/r9E0eKiyOZ?=
 =?us-ascii?Q?SnK9BxHcB+b78MARPX2N2MHSaf4ZBnXyItd2Q9lk7+ZIHGQw11LTOpRNtBUl?=
 =?us-ascii?Q?W0MIa85wNRBqjBtiAqBZBWKTx7TO4kPB0c+NKj0z5Xy2spInW2VPBNNgVFZB?=
 =?us-ascii?Q?rIsqhyuGXLQh0Ep4ccim1NUDTvm0sIPAlgJLPzfNb7Gwx4Ym1k7yyovfC7G6?=
 =?us-ascii?Q?ZU9RReE8zbxWlJiE1yyB0IsVl4eYtivoSsX/musfJVl3vDOdVuTIXkP0CA5b?=
 =?us-ascii?Q?h0UcEfaZsv+pW6MhWi5YT5VNitrODpAwSgC/3/iGwQ8I285H8xnpnxEsasTt?=
 =?us-ascii?Q?Ltv/d7y3w8BKzarZRCPrNfAVua8OytB0LmWIs8FyNb1x453/+3MX6G1KXEYu?=
 =?us-ascii?Q?eNnvZ0YHe+JUOiMPZrs2PEtuVXeRpI03SriuA1B5q3xKByeKidkCPmGl13dN?=
 =?us-ascii?Q?44iIg6dUtr4Owl4hvK3FnqdRk+t2KGp8ioAm5TYviIAkAKYPE90QMq9Nk7jC?=
 =?us-ascii?Q?nv+Mvl5pOhMkrP6OG0m7FRrB3gF9vToO/ioDBwMrec8xS7HkUdlpKUtd95Hg?=
 =?us-ascii?Q?qsf1i/lej75yo93Beqa7X0S7yTTXyrKf9qGS58LNRnnrXaxJ80iNWSjbtP0E?=
 =?us-ascii?Q?7aFCGzKLwnxO7coKFG+z0mdr61SHPZAMVb8Zz5jpoIpeAKtxc8t05xil1I6a?=
 =?us-ascii?Q?SA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4FA2EC2466CE35499D72FA7A1583AD65@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mGzFd3ThPGotZrwG/bWt6bE8zoyiUZ7xk0BMBwQFHdur8bvC82DK+TsCQIWv?=
 =?us-ascii?Q?3iDs0RaVsdQ5e8JmG7JY1NgotKTMq9WHmJVT2K+Tms+qDJNP7KOtOdypZQ//?=
 =?us-ascii?Q?G7K4pf4wfgMN9B9mU/bs0bnBBM5YIEhz2DmQQLP1y7spswmTkSoIHXuFhBXl?=
 =?us-ascii?Q?4leADjgBmXcjHN4ffVvi5lrLqJiMOsF/Dap59fugTBo23iQZHeAyR+KP/TS/?=
 =?us-ascii?Q?bq9Yn1BgfQe7e4DlpKEDJBhzPeKR/8L92Gd18XvB8Yc8tJRxAEhp5+IcYNSd?=
 =?us-ascii?Q?HFmvEDN4YA0OQAX2huw4CtJE8c4kP95LvBU8NtRi6RJmwGgMs3ROGwD30fsi?=
 =?us-ascii?Q?3TOe8/oSn9ufLL0gJSZAiOVjUQTciVRsJ8ShzCrC3dFZONLmsPko/3yMyz8Q?=
 =?us-ascii?Q?Tzl1UX1KEQc3VWZi11qqhFzaG+h2U0KRQAOPoJc9s0W1HwNe2VTe38MJtuOv?=
 =?us-ascii?Q?vjijEPIaYhAwlrgOsQt0vmIiCJDM4v2tPKNLzQLsYJuAkHIAcGLYA07ThaWf?=
 =?us-ascii?Q?TUqJgODPKTukkzmGlvGrWtI0L3vx2P8M46u2c7RA1C9zmwwOG+xbKTt+eRqm?=
 =?us-ascii?Q?t2PST30eoGyex+eqhdEtog8mlsEuwUwc9YdyGbW8Fvb4s+vn1EAt0LJfnnMz?=
 =?us-ascii?Q?/kBH72H4fVzp3/uKTG2VvIKYGwiVdRQsbdBLTLaSR6LYS/0ghN/VxVwZMNPv?=
 =?us-ascii?Q?pNMIN+foGNeiLe1Pes8l/YfugdLBH0lky/taRoRuRK3E3HVYhlUOv3RAQpp7?=
 =?us-ascii?Q?+4OFrnt+6S/qI9vSXsYFxjpEXysIcauIBdBiHAAY7G8wet6kzBjTlywJzOT6?=
 =?us-ascii?Q?VpeM0Mo2Kzzy1PBquUYzhiKpmX4ae++4big+vXKd9oFUaTwkYBf5bwV5N1PU?=
 =?us-ascii?Q?ztlmJ3a7nYUdi/9Mq1IN4++AxtukszxJp4g+YQL6tEKBsdgUmXT36VtGO8tK?=
 =?us-ascii?Q?yK6f+wmhsLblPKoJHaydTFMj07Oha/K7p4XnqTVkW0o7YaPPK44ZZ3SgwW5q?=
 =?us-ascii?Q?ZGlUOy8Z+SLyVGUFl74NhPIoscc3Ecccs6xvky3GyclI5RRLmMyFSh2H0Hso?=
 =?us-ascii?Q?LZhtbQJC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a780956c-2ee2-42fd-96ea-08dad4adfaf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 21:41:33.0485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+9fZfB8LOL/7tFecbSWCqI65MubE2glB6RvdkcAA1empHehStr9U3gjjnwKKJ6Cvgq9ZiMUzFu1hh4uhKWDBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_12,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212020174
X-Proofpoint-ORIG-GUID: uavXnMqvhEp-kPgM4P-n3wobHK23MR1C
X-Proofpoint-GUID: uavXnMqvhEp-kPgM4P-n3wobHK23MR1C
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 2, 2022, at 3:48 PM, Kees Cook <keescook@chromium.org> wrote:
>=20
> When built with Control Flow Integrity, function prototypes between
> caller and function declaration must match. These mismatches are visible
> at compile time with the new -Wcast-function-type-strict in Clang[1].
>=20
> There were 97 warnings produced by NFS. For example:
>=20
> fs/nfsd/nfs4xdr.c:2228:17: warning: cast from '__be32 (*)(struct nfsd4_co=
mpoundargs *, struct nfsd4_access *)' (aka 'unsigned int (*)(struct nfsd4_c=
ompoundargs *, struct nfsd4_access *)') to 'nfsd4_dec' (aka 'unsigned int (=
*)(struct nfsd4_compoundargs *, void *)') converts to incompatible function=
 type [-Wcast-function-type-strict]
>        [OP_ACCESS]             =3D (nfsd4_dec)nfsd4_decode_access,
>                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> The enc/dec callbacks were defined as passing "void *" as the second
> argument, but were being implicitly cast to a new type. Replace the
> argument with union nfsd4_op_u, and perform explicit member selection
> in the function body. There are no resulting binary differences.
>=20
> Changes were made mechanically using the following Coccinelle script,
> with minor by-hand fixes for members that didn't already match their
> existing argument name:
>=20
> @find@
> identifier func;
> type T, opsT;
> identifier ops, N;
> @@
>=20
> opsT ops[] =3D {
> 	[N] =3D (T) func,
> };
>=20
> @already_void@
> identifier find.func;
> identifier name;
> @@
>=20
> func(...,
> -void
> +union nfsd4_op_u
> *name)
> {
> 	...
> }
>=20
> @proto depends on !already_void@
> identifier find.func;
> type T;
> identifier name;
> position p;
> @@
>=20
> func@p(...,
> 	T name
> ) {
> 	...
>   }
>=20
> @script:python get_member@
> type_name << proto.T;
> member;
> @@
>=20
> coccinelle.member =3D cocci.make_ident(type_name.split("_", 1)[1].split('=
 ',1)[0])
>=20
> @convert@
> identifier find.func;
> type proto.T;
> identifier proto.name;
> position proto.p;
> identifier get_member.member;
> @@
>=20
> func@p(...,
> -	T name
> +	union nfsd4_op_u *u
> ) {
> +	T name =3D &u->member;
> 	...
>   }
>=20
> @cast@
> identifier find.func;
> type T, opsT;
> identifier ops, N;
> @@
>=20
> opsT ops[] =3D {
> 	[N] =3D
> -	(T)
> 	func,
> };
>=20
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: linux-nfs@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v1: https://lore.kernel.org/lkml/20221007235406.2951724-1-keescook@chromi=
um.org/
> v2: switch to using "union nfsd4_op_u" (chuck)
> ---
> fs/nfsd/nfs4xdr.c | 632 +++++++++++++++++++++++++++-------------------
> 1 file changed, 377 insertions(+), 255 deletions(-)

Lightly tested here and applied for v6.2. Many thanks!



--
Chuck Lever



