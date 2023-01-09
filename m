Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E507662F0E
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jan 2023 19:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbjAIS3i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Jan 2023 13:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237714AbjAIS3T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Jan 2023 13:29:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6A315F1F;
        Mon,  9 Jan 2023 10:25:45 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309HuGBI023484;
        Mon, 9 Jan 2023 18:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mzsWZv5y35PEInMfuqZ4eK97MDlkntiudZfBxUrMyHM=;
 b=iENDMfo4cqXQDTqIVVQ9enjgbUwDQTJSG5D9TYkM4ElfQiFFEKMzSU2B2Aw7q6zMTs4h
 kQsu86gINi23gGX2ojo5f1YCVL9B8VG41p55DikX3Hk8dO6b2BpbxKoX8D0IgXbPjdHK
 l7sYVRMicMWHHHNDpSr4Mb7Yl1odjUrMcLjWLpnZg/Bsaw+HekftkXtr2J/2aVvnwsqv
 w9ne47zvgxhNXoZkHdberv2m5c0DNaWeREeKTQLqE01/28pvdPnKRCeCBgi2LlMrxV6z
 XinFDCNEI7p8JU341xGqP/fPsdBHa9xMkFtbbB3LA9iHlf6qXu/24XYtmq7WXVG8dnph 5A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n0nn10h62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 18:25:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309GtQAm002400;
        Mon, 9 Jan 2023 18:25:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy64cqtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 18:25:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC/qOO6OqqdjiEyuMvvxKrXgHR4ouWdMAs9SylNFu4HdDagjT1ufC2BiHcT553wKN4URodO+echAFerFxyGcH873+o0oXQuthnAEjhT6dAPQSeg5+uk4oXjeVo6aG9ExrwDGvoOiIatLxkIN8de4l+lTFS5ogAwrim0aS2cTdQMInAUR1+uWXUIg9sSvGoTCGfSRyJk4sELnpO09u5pSjd5JYVqxymlLydlyRaBTUnEjJs7PkrXwwey7HfpS1k7gMLe4TUcPxzrxIlNvKgr7gAGRs3dPFFfGDPVsgW1g2NblDvTId5WiVY9eh6mFvgd1Acj/whExZbemeXv87cv9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzsWZv5y35PEInMfuqZ4eK97MDlkntiudZfBxUrMyHM=;
 b=Z/MwD+Ei9X8h/fXX0Zxa2TlT1aypRg8NuvAfjD7qj0NuEbJMUFjA6g4W65pLgqaFhNtTqb5RYsRSQU/qV3BTSPQAypsO6ANcffCacPOGrkXYVjXgx4brWdKDqTv1ZomYwCXZg75boFy8dhGvuV5y1DEiVhIp4AdsGnzKz/rzGOW1kPsDMDCBjW6wZb7kMMpyL3WZYrec/kHncyRBKGDruOdfZKfBP8VH0bC3ao2lN2M4/0XMQXepMqyyBGyFAtflnTfPX9zqDV4YUY/c/HP9EERB8YRDR45GwJ3Zn/Dxh0FoeHy2rBaLQM9qeSgoVMutmR54jvEFbJapbN7MBOAhtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzsWZv5y35PEInMfuqZ4eK97MDlkntiudZfBxUrMyHM=;
 b=xAE/lv/tDvAcON2Oz0Xm9CpoaulUh5fKrEU6IgZlfe7kxgIxtFHHiASPxeilZLF9eHWgmhIrp5456ltH3iUV7QAHUrXf/4x85Efbm+d3IzanKlYiF9+ap+Ah/9nycgGM8NuciyAFBktHiUZEy0a7iOSXq1Keeps7QK2mgNXzyx8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Mon, 9 Jan
 2023 18:25:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.011; Mon, 9 Jan 2023
 18:25:35 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Thread-Topic: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Thread-Index: AQHZIq8GJkROOS2NVU+FmVsgVWlM/a6UhAWAgAA+nYCAAPy6AIAAB+QAgABlFgCAAAaNgIAABTgAgAAyDQA=
Date:   Mon, 9 Jan 2023 18:25:35 +0000
Message-ID: <0A48B454-1CC1-4C1F-BAAF-46A780BB5E74@oracle.com>
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org>
 <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
 <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org>
 <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
 <6F61B478-A0FF-4E28-A7DE-8DAA6E11B128@hammerspace.com>
 <DB31E56A-42D7-4B62-83CD-3D96AC4A4C20@oracle.com>
 <CAFX2Jf=Q-vuFGAeGKQT7mxhvZTGSZBjDs6YWvWE6cwTFenW8Ow@mail.gmail.com>
In-Reply-To: <CAFX2Jf=Q-vuFGAeGKQT7mxhvZTGSZBjDs6YWvWE6cwTFenW8Ow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB7309:EE_
x-ms-office365-filtering-correlation-id: 1c408af0-aef8-4643-762d-08daf26ee64c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lRTtgYYSONpJF6iGZCzh+qHFMLsuAAHQSTsQVpmvsYwNv47KwfOL6gldElxy6WrIEhf6Bvzs0XAnHfNsEptpmqjvKM5G+Q4fzCriEv4tLYd8LsVF7Y9I0o27XKytGfSwuyPIRTNDj6G+KWmerWBN9yW/JgbbCE8FGYH+DOTW2gUJG7Co45ZiQQjiX6s1UmmqNDnrTPfM0ETP9AVJKZWXq/BP8lzsoR7ou2nr70Ug6fxyUsD1pS2M9sNO1VpTslYwW7dT0eOhx2vW0ujQX1B+O50hrtc52pBidipXYdmzooiaNwXVbMtSlPYRDuemcPuNfuEBiXKxuJm6bgJgyvmUaUp+wxDhKY0q8aHXIKQnf/xGm7uz54notIhKtTX4uXjZjFu+pS7blF980v13EJ2eQnEsKtQpaoDDJ3UuoT3eVGUqpzg9yRUpWHQI4BGLcIuL4Xs6SDPWnboeT9FnmD5igSqacOJe+NxcJzXTgjxr94MTMtml/BDstFIKjyuMajxZ9oO1iueFIRZgEkxLBSUTtqA0FimjvROA/qMpk803HJCXEhkv7oF6DLFuZhdi0YYKPvYCfO51nSv5eBOPVYT035tXuFtSda98fwsbmDrf82pDCixtYCfQik62QU/e2YP0UNSZbEwlo9pSL5UdgIdAI21tQppXNjvFAHD+j8qkK25UwYFKjeQx+SY1+qhrteNt8hSAQ/Wdzo0cctkZZhLmD7F4mo7G/2Sh4zX/wkL29II7LTHOA1xB/jhxMlB4dwUd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199015)(36756003)(38070700005)(86362001)(6916009)(2906002)(8676002)(4326008)(8936002)(66556008)(66946007)(66476007)(66446008)(64756008)(5660300002)(76116006)(122000001)(33656002)(83380400001)(38100700002)(6486002)(478600001)(966005)(71200400001)(54906003)(316002)(91956017)(41300700001)(53546011)(2616005)(6512007)(26005)(186003)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RYaz/geWollBurTKHAgf8exCnjORCZFKUAm34KS9JEoLv+0jDwABM6W66AnG?=
 =?us-ascii?Q?7zFpu/PVML+yJtQ3/I3NrbWdq/TMhVvDf3ucl3LZK9ObfpgvZ03Vd8zNoVEg?=
 =?us-ascii?Q?x1Q9nCbwjNXMfETOeJk7FZ6e1knwsR1rAtWFxEBDeSVnY6OudXteN/K5k7nT?=
 =?us-ascii?Q?4V9Cw4I0cn+q/Vc4e+djdNAUTva41kcq+8XoR+7L/9UXsFmaCNYyoVTKI/5b?=
 =?us-ascii?Q?ZNROU6S+RFn0q36SyirwgifESDHozhnfTDXFKIkQZL8zRmWcyqmjS59g3KWO?=
 =?us-ascii?Q?B5TROEaa8MdxhBQCF1dPLLL1ThC8uSl5vloHW8EdzOoHIXvaE4BUV2uvzJfH?=
 =?us-ascii?Q?gCNwJsmiTXrWwJpw7ae1++lQDSgiaTh7mdhxRKzyMi6dxYO/iywLjfvLeh27?=
 =?us-ascii?Q?AvCXrrFKR9pyJ29UO8DPWyF2tNop+lXz/DgSATtmEeyzdJxxCkrVK2JEtYDC?=
 =?us-ascii?Q?bkvMWmksb5tGpTAgNaZP/JGJ55VVgh5Y5PhaK7fxzQyOx2/ciSgh9udPYOdP?=
 =?us-ascii?Q?d1tFSZbumhnMMsmBbT1TabMuwtv0PqqWtz4x5z3ma2Iix0XNWycf1mSeUxt3?=
 =?us-ascii?Q?dgcGBrDDGm1A3EPhI+SuQ6Q6afrk7FjsJWI94x4Pc5TWQW3EhSgbk3NoptNX?=
 =?us-ascii?Q?0lqxWIY5krbcK/80oJ7ave5nWg06HQCD++VWnLhXMHZw7Yr2EbPVThiZz3Iu?=
 =?us-ascii?Q?EN0fN6ABeMNEronSXwPMmEjPYsbzyAYJFkPpHn7OEmE30VyCidg++u/E7KsY?=
 =?us-ascii?Q?4PG0GDBPs9w3DNjCuDS6goyBW3SyQR4XJey419lUn4QNqspM3NMLZ6smrtHg?=
 =?us-ascii?Q?rdaAHxIRz5ZsWFz6+vjPvVtJxytm+D0kg1ZeOnwv8/wRi/ITTq5q7PfTWy7z?=
 =?us-ascii?Q?bi14s9fY1C8iAylYosDFlulX1xVJumB5N/gHgG2hik76Y5ZYV/w8j5R+7Bkl?=
 =?us-ascii?Q?pfCHmaMUsJ7bgjILYfba6KEQOXNEJjCNpr6CUGbWlLPbD+nm2baSwxrjTDcJ?=
 =?us-ascii?Q?XpHpwLUoJ473j+9rU/d2hvoVBgGDtzcto/k2MdUGQtIX1E5lkG0ZxPeJHoEf?=
 =?us-ascii?Q?s57ig1bha1dzUIGGFf35uNL2mvsP4y8XKu/pPG6/9AHp+9V9rF/ugSPjiGCx?=
 =?us-ascii?Q?A0uP+iXn6txuMfZ+jewpk3yZtvb8NGx1T4FBkWdVy6o5QtK6iHzaQO4EUsFU?=
 =?us-ascii?Q?YB1ugBIRrE/koT91RR0UYm4xQYA/WDiENdVWKUnnFmRYDxN9Uaa3qRxWydH4?=
 =?us-ascii?Q?pxWy5NI8jkCCmMXIzVOSPvSYP7cCGmT98vmeL6XesUCyEPzwc98LdxZWnzio?=
 =?us-ascii?Q?sPdad35KdSJ8ybg6zzDgJEnlYGVshr3COT4LKzDCGIPGww2L6O7Y0lA6eyDz?=
 =?us-ascii?Q?iuTIoRYJ5v6GuqqLq/ybQtfE0F6qwhccAAcr3OU/OaVFlT28FfwAvf67t9wx?=
 =?us-ascii?Q?NQROPO5uEIxj11lLp6+IRjuLSB2yGG+zzOgrI7afwa3AjVtFLM3IMiL8Fsyn?=
 =?us-ascii?Q?wFB5L0qsAop2QbY81gUPd2MbGhy/YcWSVBQLbDWE5nRw2TclGBT7o8hq2t41?=
 =?us-ascii?Q?4xzeGPp64Fqu1BM59ChfPdyJcxTRj23CjZ/EbG54N3KrECAsOd6fp0pP/Fcx?=
 =?us-ascii?Q?Wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <02ACC7538C347E449C93F69B1A988531@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SHm2O0Ave/FBkO8Tyz+jikKPt1f4ObOcDKH0edu9HPcC2A88NoqTL7Al/HC70xJCfcXOny4+vu68dDtwbf+JrGwp7aLZsDJdovVSOLagcdgunL45ZNARGGfINFn5gWjjoc7Vn8bgRS+Cd2zaYER1Iyk7ma2YeBrNoJqFXbhRvEoF16KIyJ9iwVWlaqfzctaAv47QrP/awL9Cz/sTcgmpFkTtv0fteatO63FZj9RtHToWvoOGS+PA8AqPuct7c48qt4EgpRjKtfmNJG/+RUjAKXwxLHRVulHqkpkunUEWbXU07L33wTTVy1Fjtlm0ao6S1wMRc/hT78XFhQyjwxUw6sE7lySMVSwhK4iiY/054/6yLTINZesFZlxDePD5ppV1EuuSmVChnYO2izABrfycDC+moPXq3OdUVEvyfjB3Hk5kQNgOXrqJRpbXCy55L8EPK9ng4smI00lzfJAaxUFCSaq68GNNiCAxN83t2llKvJ7a0PtzsSSCUClWpKFcMTiody1Aqnk3+/s+TC7/oBpk9eb/WdeNmPRke3a5GfoDOXlqjbojaD5/mo6mDgSqpH90OrGK1IOatgTbMSL3Arz97cyYm+URu4NxpSlHQ0s4HMUzHzhBMW4vVcHVHrEAUGYlSZeqO1iHDU0KeMcsLfiiAgE2BJxgeK66YcniUk/SFLQEeNLRrIdPUOELfeUZqwSXR9G3E+y9gDPAqM64wqQZQES1nZe/wJqxDlITxcpUpq8HvH7awjIlXv87JFGaiUPF4QFB58drrd0CsDX21SExUnQa46ar0G8AHeQGLb3wy9Lkox8JMOhUwHUws6LY6CFeh6F/5EJS1O6tvMZ5PA03tckWrG1V5vjuNr9haOd3BO5r/hLUioRS+KEG+rsrRWTPPmCYA1X0e+LGQDfFoFFihfY9HmOkdH+ySYP+m2hT3rg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c408af0-aef8-4643-762d-08daf26ee64c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 18:25:35.0119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1QviGBfasK1MZs2liNt+FzqoPuvlf8zuast9Hg1DQisTBuZmgLQxhK89lUiml4lWyWfszuilYzqSMrtioCNGfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_12,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090131
X-Proofpoint-GUID: IJUQMin3S7jVRbcZrkIaYhEzteH5PvBF
X-Proofpoint-ORIG-GUID: IJUQMin3S7jVRbcZrkIaYhEzteH5PvBF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 9, 2023, at 10:26 AM, Anna Schumaker <schumaker.anna@gmail.com> wr=
ote:
>=20
> On Mon, Jan 9, 2023 at 10:12 AM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Jan 9, 2023, at 9:44 AM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>>>=20
>>>=20
>>>=20
>>>> On Jan 9, 2023, at 03:42, Krzysztof Kozlowski <krzysztof.kozlowski@lin=
aro.org> wrote:
>>>>=20
>>>> On 09/01/2023 09:14, Krzysztof Kozlowski wrote:
>>>>> On 08/01/2023 18:09, Trond Myklebust wrote:
>>>>>> Hi Krzysztof,
>>>>>>=20
>>>>>>> On Jan 8, 2023, at 08:25, Krzysztof Kozlowski <krzysztof.kozlowski@=
linaro.org> wrote:
>>>>>>>=20
>>>>>>> [You don't often get email from krzysztof.kozlowski@linaro.org. Lea=
rn why this is important at https://aka.ms/LearnAboutSenderIdentification]
>>>>>>>=20
>>>>>>> On 07/01/2023 16:44, Krzysztof Kozlowski wrote:
>>>>>>>> Hi,
>>>>>>>>=20
>>>>>>>> Bisect identified commit 7fd461c47c6c ("NFSv4.2: Change the defaul=
t
>>>>>>>> KConfig value for READ_PLUS") as one leading to NULL pointer excep=
tion
>>>>>>>> when mounting NFS root on NFSv4 client:
>>>>>>>>=20
>>>>>>>> [   25.739003] systemd[1]: Set hostname to <odroidhc1>.
>>>>>>>> [   25.771714] systemd[1]: Failed to bump fs.file-max, ignoring: I=
nvalid
>>>>>>>> argument
>>>>>>>> [   26.199478] 8<--- cut here ---
>>>>>>>> [   26.201366] Unable to handle kernel NULL pointer dereference at
>>>>>>>> virtual address 00000004
>>>>>>>> ...
>>>>>>>> [   26.555522]  mmiocpy from xdr_inline_decode+0xec/0x16c
>>>>>>>> [   26.560628]  xdr_inline_decode from nfs4_xdr_dec_read_plus+0x17=
8/0x358
>>>>>>>> [   26.567130]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x30=
4
>>>>>>>>=20
>>>>>>>> Full OOPS attached. Full log available here:
>>>>>>>> https://krzk.eu/#/builders/21/builds/3901/steps/15/logs/serial0
>>>>>>>>=20
>>>>>>>> Disabling NFS_V4_2_READ_PLUS fixes the issue, so obviously the com=
mit is
>>>>>>>> not the cause, but rather making it default caused the regression.
>>>>>>>>=20
>>>>>>>> I did not make the bisect yet which commit introduced it, if every
>>>>>>>> config includes NFS_V4_2_READ_PLUS.
>>>>>>>=20
>>>>>>> When every kernel is built with NFS_V4_2_READ_PLUS, bisect pointed =
to:
>>>>>>> d3b00a802c84 ("NFS: Replace the READ_PLUS decoding code")
>>>>>>>=20
>>>>>>> commit d3b00a802c845a6021148ce2e669b5a0b5729959
>>>>>>> Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>>>> Date:   Thu Jul 21 14:21:34 2022 -0400
>>>>>>>=20
>>>>>>> NFS: Replace the READ_PLUS decoding code
>>>>>>>=20
>>>>>>> We now take a 2-step process that allows us to place data and hole
>>>>>>> segments directly at their final position in the xdr_stream without
>>>>>>> needing to do a bunch of redundant copies to expand holes. Due to t=
he
>>>>>>> variable lengths of each segment, the xdr metadata might cross page
>>>>>>> boundaries which I account for by setting a small scratch buffer so
>>>>>>> xdr_inline_decode() won't fail.
>>>>>>>=20
>>>>>>> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>>>=20
>>>>>>> With a trace:
>>>>>>> [   25.898462] systemd[1]: Set hostname to <odroidhc1>.
>>>>>>> [   25.933746] systemd[1]: Failed to bump fs.file-max, ignoring: In=
valid
>>>>>>> argument
>>>>>>> [   25.986237] random: crng init done
>>>>>>> [   26.264564] 8<--- cut here ---
>>>>>>> [   26.266823] Unable to handle kernel NULL pointer dereference at
>>>>>>> virtual address 00000fe8
>>>>>>> ...
>>>>>>> [   26.597263]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
>>>>>>> [   26.603222]  call_decode from __rpc_execute+0xd0/0x890
>>>>>>> [   26.608328]  __rpc_execute from rpc_async_schedule+0x1c/0x34
>>>>>>> [   26.613960]  rpc_async_schedule from process_one_work+0x294/0x79=
0
>>>>>>> [   26.620030]  process_one_work from worker_thread+0x54/0x518
>>>>>>> [   26.625570]  worker_thread from kthread+0xf4/0x128
>>>>>>> [   26.630336]  kthread from ret_from_fork+0x14/0x2c
>>>>>>>=20
>>>>>>=20
>>>>>> Is this test being run against a 6.2-rc2 server, or is it an older s=
erver platform? We know there were bugs in older server implementations, so=
 the question is whether this might be a problem with handling a bad/corrup=
t RPC reply from the server, or whether it is happening against code that i=
s supposed to have been fixed?
>>>>>=20
>>>>> I would say that buggy server should not cause NULL pointer dereferen=
ces
>>>>> on the client. Otherwise this is a perfect recipe for a rogue server =
in
>>>>> the network to start crashing clients and running exploits... Imagine=
 a
>>>>> compromised machine (through some other means) in a local company
>>>>> network running now a server with NFS share "HR salary data" or "HR
>>>>> planned layoffs", where unsuspected people in that network access it
>>>>> leading to exploit of NFS code on their side...
>>>>>=20
>>>>> Server is Raspberry Pi 3 kernel: 5.10.92-2-rpi-legacy-ARCH
>>>>>=20
>>>>> Which points that it is not latest stable, so anyway I need to update=
.
>>>>=20
>>>> I updated the kernel to 5.15.84-3-rpi-ARCH which is pretty close to
>>>> latest stable and I can reproduce the issue. Therefore:
>>>> 1. It is visible on two stable (one new, one old) kernels on the serve=
r,
>>>> 2. Buggy or rogue server should not cause NULL pointer on remote devic=
es...
>>>>=20
>>>=20
>>> The nfsd READ_PLUS code is borked up and until 6.2-rc1. I thought we ha=
d a server option to disable that code, but it seems as if that is not the =
case.
>>> Chuck + Anna, can we please send a stable patch to rip out that code al=
together from all the older versions? If we want to enable READ_PLUS by def=
ault on the client, then we cannot do so if the majority of NFSv4.2 servers=
 out there are running a borked implementation.
>>>=20
>>> I do agree that we cannot allow buggy
>>=20
>> or malicious, or non-Linux,
>>=20
>>=20
>>> servers to cause memory corruption in the client code, so I propose tha=
t we revert the Kconfig default setting change again until both the client =
code and the legacy servers have been fixed.
>>=20
>> I stand ready to receive and apply server-side fixes, as you suggested.
>>=20
>> However IMO it would be most responsible to go straight for a client cod=
e fix. The Kconfig setting is a red herring (as delicious as that might sou=
nd). Any thoughts about how difficult that fix might be?
>=20
> I'm wondering about how hard the fix might be as well, since it could
> be a legitimate bug or some error checking that I've overlooked. I've
> gotten as far as installing a 5.15 server in my testing setup, so
> we'll see if I'm able to reproduce the crash this morning.

All current long-term stable kernels have 72d78717c6d0 ("nfsd: Fixes for nf=
sd4_encode_read_plus_data()"), and so does v5.10.92. I'm not aware of
any other problem with READ_PLUS except for performance. Let me know (or
file a bug) if I'm missing something!

For the possible performance regression, backporting eeadcb757945
("NFSD: Simplify READ_PLUS") is the proposed stable fix.

* v6.1.3 - eeadcb757945 applies cleanly
* v6.0.18 - eeadcb757945 applies with offsets
* v5.15.86 - eeadcb757945 needs 1e37d0e5bda4, then applies with offsets
* v5.10.162 - would need a hand-written version of eeadcb757945
* v5.4.228 - does not implement READ_PLUS
* v4.19.269 - does not implement READ_PLUS
* v4.14.302 - does not implement READ_PLUS
* v4.9.337 - EOL

If someone volunteers to build and test, I would not object to
a request to stable@ to apply eeadcb757945 to 5.15, 6.0, and 6.1.


--
Chuck Lever



