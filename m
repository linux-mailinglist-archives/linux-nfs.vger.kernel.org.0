Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5429568318C
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 16:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjAaPcC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 10:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjAaPcB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 10:32:01 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01D215CAD
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 07:31:58 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VEE5Df022644;
        Tue, 31 Jan 2023 15:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Kfub0g8yi7gTvDpl0mXGiGYL2Op+/cyL6tfCk/F3pwI=;
 b=BowemhJOMWVrbSCK5o1uVHm2NRhLj6X97BGLgem7FEFLjWJp0OraVXPaaT/c4CXRirg7
 csE4LoVDNCyUl+I8REMtPAGnuUmzy38OAKoCwiRbKlwVXu8D3Rh4uHItxKr8ax1uhvLW
 IkbBm/ZiQKMynl22oe1f4J5EtHBGyl8pFrfUZo8SisjSYDhiKoj2Ded6tYI7YXIjYGtF
 YmjzHEYG8rDmwiDx3GJPROG+GwPdC9Z0xlHH7ESfAWhPH0eHKbj1iDk/bbibZ1qEeCLj
 5uzHzBI4sJT1R4X/CcbJxTCKg7PPY35ZVDXVsWv10Z7Lb6rFPcfONqHkNZI+x5VbHglQ Eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvrjwu9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 15:31:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VF5E1v020389;
        Tue, 31 Jan 2023 15:31:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5cmf03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 15:31:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/2DH7p6snXNPE61NlXSE3LxF5amGRg1Npz8JqK58RpVLD+r8OKLR9VxSIzaPoongwLOe3rSuRnCGYEmZUZYXV+Tj9UKUeQBwOAUZxOQQy2iewLwGQp1/OhBC6ExD3QHZqGQ4VZKNI3FdqSOXIFnIFe5rH1nsPQSb5x3S9upkNzl/gvMszuzO/V047V19/TtkI55Gfcj8FqUa0dTJB/lPcVlPMOd2vUmj8fEC4RmyPkbgPwyY9e7HN9kRTrjN1NJeotW9RL4ahHv/0/J+ay7/BdjP7NNQVXsT9JqjLcBGC/Vh/TFJLFhhwOhZ5UotOkso94AqI3s2YYY0K8tHyWa4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kfub0g8yi7gTvDpl0mXGiGYL2Op+/cyL6tfCk/F3pwI=;
 b=VMNW51FxE6rBv9q1mZlRCI3aiM+RuXaZ6EYPB8Tq2B7w+sLyWvobq/GIOl4DCIFyDwVnETNzbx+ULP2FEHnTYbDX5ibFT8jXe4SG0DKolgSoGuObIRl6bIWd/iRJXiSF/bDfQ/x0v4OQuWXe5pVaOPlT8upBTXu8IYlojW5IHqZGea665aOGy/b37zae0wrv6NN/Ip85gK1N9RJHMskef76VmEPYb3uE1hZ/BdaOJf8br6ilPZmFoQWFcoLWZxpQVY7Uv4XlOkWVbJXAYTyFGMIFKFGrr1K/C7R7iK2rigm2sYrYHHixWwKLt0FZrIWqGQ4UBUaDAS9afpoFQ+3gtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kfub0g8yi7gTvDpl0mXGiGYL2Op+/cyL6tfCk/F3pwI=;
 b=PgIZZpgY8vee3eYAwyscLSArDcTeG8eLdMvTgVXfemBiJ1iIytYAbs6iegmvwE9tLqJtt1Jn86arnLICgks0aTYIjI50W/KIDdQtO/DarzPMsZbYlfwkFTjCH2x2bTtnmxSU4GTolwrytEPwflfpjHZgr8YSEtIczCogd/lsPss=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6230.namprd10.prod.outlook.com (2603:10b6:8:8d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.21; Tue, 31 Jan 2023 15:31:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%5]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 15:31:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "Andrew J. Romero" <romero@fnal.gov>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Zombie / Orphan open files
Thread-Topic: Zombie / Orphan open files
Thread-Index: AQHZNPfk4CJ0DwDhNkGXE9jEOOJtYK64haaAgAAU2QCAAA3VAA==
Date:   Tue, 31 Jan 2023 15:31:48 +0000
Message-ID: <DA731F17-4FF2-4013-B8F2-89461D72A14A@oracle.com>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
 <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org>
 <YQBPR01MB1072428BC706EE8C5CC34341186D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org>
 <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com>
 <2bc328a4a292eb02681f8fc6ea626e83f7a3ae85.camel@kernel.org>
 <SA1PR09MB75528A7E45898F6A02EDF82EA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
In-Reply-To: <SA1PR09MB75528A7E45898F6A02EDF82EA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6230:EE_
x-ms-office365-filtering-correlation-id: 29990858-1000-4025-6bfb-08db03a044cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gjf8cWbZOZ1fd8apmyItjDpBN8sFOXIgVGSEgLiQzDBewr+E5qTSwKlqUDcaeJ1PNpURoQ35RxDAC412GZYq8/AjMgYLIblAZugrzZ0dyHLAScaQCsBRTQA3dw0GQt8Tmu9zBAsU4ez1UaG/yEkNu9OHsZsvN/Ps8SJuwt2vOQcRIjLd2g4DYFGriKd9na6Z8hWqq+nVF2tJemSi95VtblPtopGF2E/ERqvjQ3Wv9ThGuq9QnBM597SaDcb6FqgndDY0+vmKKxcqixW+mVgCPGDxmFBETzC/WSk/iwXdl6MUxsrNaRa8Krv3hSi+wLBuPKi019qKQwWBGXPsLS97vjzS5pMdfAl0WlXmB70EuhWY3yNhX+5hFit94YiTIys+rS0GDPpJo+wT0EVaJu/25N9SDSsIWgVUsQ8bKQEGCxYNbaIIFYjdpmsjaCF4ji9yLCXae3MioCmxJ6d5YWepgp4K6HASiU/dq3TcSgC/uiqUUqOGqgDNEE0HY26zlNTNQgseOzEUtyvXG2uTcfp9Gmn39J0oQIBaGonYasHs8Bw9E+ZcshhkXp3oNP4fZVpMMPHp7xG4K5ySIhZyh0U+H1EvrccBZ23Xf3ocEDh0CYvSwaF4UATwPp/CJsGTilhcK8UhjuL7dVUjrZB2hOc5mnfyMTPQcZVBUq17fih/lY6Tq9wtpQdXh1mWhHz1oWhT9LHtuG07OOQNeAHtt1PZg68NUpwwB507TK6P3rxQz+I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199018)(6486002)(83380400001)(53546011)(38070700005)(86362001)(2616005)(38100700002)(122000001)(2906002)(36756003)(71200400001)(186003)(6506007)(26005)(6512007)(478600001)(33656002)(66899018)(91956017)(8936002)(76116006)(4326008)(66946007)(41300700001)(66556008)(66476007)(8676002)(66446008)(64756008)(5660300002)(54906003)(6916009)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DV3rlCYTzjLUMFs049tdE8Fn0/I+AuJkuwtH0Olro/ysu14m5gYX7eTEIgCp?=
 =?us-ascii?Q?a23nm/1OCfTTHeE8RVTPUtnOmtfncZSnBEy3Jovr9BHpajNHYUDldUQSpnKm?=
 =?us-ascii?Q?VzO1vxhSQfFKsyLLgNJnvc9mtGI/El1OjEeEWF8JAYn2Xxy1V9c3p2a3Ff0K?=
 =?us-ascii?Q?/dCuyrDRTqv5428qBtoxXPNdzpFTMaBn/oZLMmbYvmH5v3uioC5h/Qbg5U8Z?=
 =?us-ascii?Q?YYcWa0urXuTUbAWmAhI8CCcv3sP3MH9NTAWB9CRwD1JvsW96CbljtF9FjJ2e?=
 =?us-ascii?Q?6GZCoXzvPukWt73brfHIHLbB1pFzFYxENCICOlwN9xELODyEgUJkQaUwCOGp?=
 =?us-ascii?Q?BDPTFuNzWqksF/P4ZLbt/cZKgb2cTGHKXN1wuLn97eRKAQVTX1wIDajqsEGU?=
 =?us-ascii?Q?AGVQcup8b9MNzULC1WHroBCPQ0Y8h73hNnlQgB6tznETCiO/3imtZaPVsCK/?=
 =?us-ascii?Q?pr0LUxArZvI5NOJA2uDL5r/0JXQByKZtKOIx3eqvrJmXEyUkjLpMiwSih5rM?=
 =?us-ascii?Q?dVbrbZmizjAhlELdAGp1cQT6MiYsbCMWi+UID1x994dm077ZPW2/GrpWYNlz?=
 =?us-ascii?Q?oZZXbiyT5QKh7RzKQBfnGBjdfacSiSSRe43mwKbHLgHzEP1w67fX1NP0abjh?=
 =?us-ascii?Q?vCgl5JO9mngA9IF15oFo+jLgPAYPku8zs+kcHYrGnG510xlLlKUrcd4qchxR?=
 =?us-ascii?Q?cLgvge/3bYAFn1mFgVNs/SJwRttHjzRrbyOr67aWqLNdgr8XSAcz4MOEKtG3?=
 =?us-ascii?Q?RLmaMqjm0mdnHcZYJGnVzQAI3dBOpypnmfrkLpabbKRRBqy7LzbqCdNFiNFI?=
 =?us-ascii?Q?M/gYG0/hxE1ZLMRFYN0UkVByt3VRK479d3q1mJVtlRAuhnSKsVNmXz3PhVVo?=
 =?us-ascii?Q?NBJjBU0GCnEKhylQKDCEsMVpVrk9Fg8Sbea020VJODonuvok/Rw+f/Lg0IsR?=
 =?us-ascii?Q?zRhEzavjiQqjH1NIPu8J4sGKmZgMNh9ql1ayEg2V8JtN/peLbE31r0gxpZLx?=
 =?us-ascii?Q?L5ON2dP4EvOL2+5g5WreGAWrB/MM9y9kk+wVZWoAGL/ez+X2RKXgzQwQtYpP?=
 =?us-ascii?Q?cswAJSafHT9iSTV9K/ksMU5+kNaychOZ7NrX8WbeKTlhd3fSoZ5mpKhvxzD3?=
 =?us-ascii?Q?fA3cMSwFxdFtFaS/lybD4ByNLtL9h1DjHTT4d17NMemfkGDtqi7pYv/1Vezi?=
 =?us-ascii?Q?AwGvWPMDYQmUKVueak1Y65+XA3g0gNeXqlag1xDKobbrhwVHWGH1jnhNJ/QL?=
 =?us-ascii?Q?Yl6DhNLVNMzlDsXI/XyQL/Rwbv8C2b9jEfhOI94qbG1YBQKTvhn/YGSlFN6X?=
 =?us-ascii?Q?/fHpeJK4/X1ClwdQrCKr+pFNLsqeM3reNcm5XzhwD0q2HM3lhzvAfQF0wENM?=
 =?us-ascii?Q?wjhbhK7zP0XoPIanknUDPIJ9HPKIKBzy928bsCkRy8+mkx0t3A/3HSj9DfMB?=
 =?us-ascii?Q?9a9yCnUVbk5a9HnymjbL5CtHH5re/i+1MhtY1ZCgL5BugRXVAXxYwVrWcqxB?=
 =?us-ascii?Q?tQxRhFDl+eo56Gpama0yPFJfRUOt0IEAyBJBMnUp7O8xfHGoYHsD5LxC8nHi?=
 =?us-ascii?Q?u3eYLyutawKt9QKLKhKfeWJVA78iiAhuPPLtLZbmx6WClAKnpjH8BtYIeYEr?=
 =?us-ascii?Q?yQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BF7944389FC0E24D994AB7B0532C257C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aTK/T2cNtLXjmCKCYCkjBaaosHyXf8IjIeO2tzNjlgeyKa7gNhj4sKpwal4uJEqiHCHwNZa+uFaYsRv+vWeab5p5PvNTQvqwxpWSPDbT8Q3xhE77q6DWYlEM2pBSsttnFkM0oeGyWU+G+AOS606qx9EM2dJqkE+yZEEYo9Aoo2wUm0SR5HuJc0h+lxbVq/OGkWq7hthELChpkV4lvYP484cPOdX/sma5XUNS3GQlBjV2UTpwlbR4ppuw635f/7wKBiudh+sjuVTKfOXf8F578M75psCHMDv0DZZPIZmc63d26o/uo8byooGPmqoAtEx5/IoS3H3coXPUF0GcgVxzu77EwCioC93xLV/ifvrtQc7nqCL69qKrksRe2+wuAg0ZDJNYGJqZ00PhubfFoI8Hbl/XWNLzS7BY5xXdCy7VuC4LJqGu+Hwmbwd1wmR2V6zvJbt3yyatdUVzFGpHv3johxDUleXyN7kW1m5th+1Sfun0lBwGFLTUZ2jShiwnKT0xi53jYuqOqJ/zu9ToFz5xMWxNICFEYCYM0yjWldApIHcXZg+HMX1iRUE5KFIkehrYEksuk/veRlQ/eIwoscTAupwaGmAHr8D2CjTXJv0pr0LnCLt6ScEnfNcxAg1mGPpOWXU7R42aRYnqoJJoYpBHS0u3ZDWPB34UENcApyuPxbIl+JUQZQg1vodh5VawAePwSH150McVGTt1ZMHlbWwwOdFUrO/jgXabd5gNC91IWt7TsLOEu1VH4lI5I052n7BR0RMCyhbzQ8IRON5CPqTT7YbwI4/7ylJG0EVB1I4MnHtYx9QalWmwJnOpN+UshRWu
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29990858-1000-4025-6bfb-08db03a044cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 15:31:48.6330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mz4fZpJ2uZlsBXHj77KC3NMNWt/KGvT0N7s5UgbRRqE2YD4DcI7YkZdMwtNsd+/xuSaNeS18VQqO/rS6GxFfUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310137
X-Proofpoint-GUID: C3xiEjAewkv57bngnbncvlwpE_6TpiE7
X-Proofpoint-ORIG-GUID: C3xiEjAewkv57bngnbncvlwpE_6TpiE7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 31, 2023, at 9:42 AM, Andrew J. Romero <romero@fnal.gov> wrote:
>=20
>=20
>=20
>> From: Jeff Layton <jlayton@kernel.org>
>=20
>> What do you mean by "zombie / orphan" here? Do you mean files that have
>> been sillyrenamed [1] to ".nfsXXXXXXX" ? Or are you simply talking about
>> clients that are holding files open for a long time?
>=20
> Hi Jeff
>=20
> .... clients that are holding files open for a long time
>=20
> Here's a complete summary:
>=20
> On my NAS appliances , I noticed that average usage of the relevant memor=
y pool
> never went down. I suspected some sort of "leak" or "file-stuck-open" sce=
nario.
>=20
> I hypothesized that if NFS-client to NFS-server communications were frequ=
ently disrupted,
> this would explain the memory-pool behavior I was seeing.
> I felt that Kerberos credential expiration was the most likely frequent d=
isruptor.
>=20
> I ran a simple python test script that (1) opened enough files that I cou=
ld see an obvious jump
> in the relevant NAS memory pool metric, then (2) went to sleep for shorte=
r than the
> Kerberos ticket lifetime, then (3) exited without explicitly closing the =
files.
> The result:  After the script exited,  usage of the relevant server-side =
memory pool decreased by
> the expected amount.
>=20
> Then I ran a simple python test script that (1) opened enough files that =
I could see an obvious jump
> in the relevant NAS memory pool metric, then (2) went to sleep for longer=
 than the
> Kerberos ticket lifetime, then (3) exited without explicitly closing the =
files.
> The result:  After the script exited,  usage of the relevant server-side =
memory pool did not decrease.
> ( the files opened by the script were permanently "stuck open" ... deplet=
ing the server-side pool resource)
>=20
> In a large campus environment, usage of the relevant memory pool will eve=
ntually get so
> high that a server-side reboot will be needed.
>=20
> I'm working with my NAS vendor ( who is very helpful ); however, if the N=
FS server and client specifications
> don't specify an official way to handle this very real problem, there is =
not much a NAS server vendor can safely / responsibly do.

Yes, there is: the NAS vendor can report the problem to the people
they get their server code from :-)


> If there currently is no formal/official way of handling this issue ( ser=
ver-side pool exhaustion due to "disappearing" client )
> is this a problem worth solving ( at a level lower than the application l=
evel )?

Yes, this is IMO unwelcome behavior, and a real problem for large
scale deployment, as you describe above.

But let's be careful: a "disappearing client" should be handled
properly: its lease will expire and the server will eventually
close out any OPEN state that client was responsible for.

If the client continues to renew its state, and the appplication
doesn't quit or close its files, neither the client or server
can tell easily that there is a problem.

Moreover, ticket expiry is not necessarily an indication that the
application is done with a file.


> If client applications were all well behaved ( didn't leave files open fo=
r long periods of time ) we wouldn't have a significant issue.
> Assuming applications aren't going to be well behaved, are there good gen=
eral ways of solving this on either the client or server side ?

The server needs to manage its resource pools appropriately,
otherwise it is exposed to DoS or DDoS attacks. That will
improve over time, but I'm not seeing an immediate way to
fairly address this on the server side. As Jeff said, the
server is just doing what clients are asking of it.

The client-side needs to clean up when it can, so we need to
explore that. Actually that might be where you have a little
more immediate control of this situation. The applications
need to either re-authenticate or close files they no longer
need. I think you'd have this problem with long-lived
applications running on one big system as well.


--
Chuck Lever



