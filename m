Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CE8630F59
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Nov 2022 17:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiKSQNy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Nov 2022 11:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKSQNx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Nov 2022 11:13:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9600B4A07E
        for <linux-nfs@vger.kernel.org>; Sat, 19 Nov 2022 08:13:52 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AJDLF9d003848;
        Sat, 19 Nov 2022 16:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=RM3ELh+9VQJB6uWX8lOEVsCSFbqQ41cE4OHJCNlddco=;
 b=V9lQO3M6ZnErKypsxwpnd1hkVZYmCTBJmLKE8iRkGpnmt7d+TsFqX6xCT/F/XR0JogHH
 +6Xhh4UakFZIgOkZjssz9DIvv/jepyVD9BplK/NYkU/z4FOEu+LpjVrFeCEDpWIYPOZu
 LysGLYnGG/Q+J19Q+8/nYQTvRpF/r2QgCDaB9fUowAjpYFm2K/vqsbm4jXUUH5CDzTPx
 xIovn6CQ/lB6q18r4QEEjg6YO1E+k6OrGc944lf9J+lFQVJSlM+SLgSr6w0QFmD/w0Qg
 xgqkEszXn3ZAA/+NyyamfwNkHn4GS9lw/jRZVZ3j6P1h4Vny4o3IinoL7VggULC3omN0 ng== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxs57gm6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Nov 2022 16:13:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AJENfmN031841;
        Sat, 19 Nov 2022 16:13:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk2828j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Nov 2022 16:13:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msHVuMUfGxzsvdLdVQVgYV28wzAqo59b698H5gmr80Lnvtx6PGTJJLFRCmo44B0jLpzFcx4xFBzefm0d/IWkmOitDhEbvl/y8dVpoCPyeRz+NrztRPidjfriYsSaDaCJLcFYQFYQyNxp4sXK1b+ZJerr/Al2qyzTG/HvEtxe/f2UF9ZAyvHPPwJjBacAS4NMVEaxJSLfGQS9VnvRmpupXTtLJfZgPR78f8CanEj3zkQxsQk3o3OmTvfnfFRKp7hauetr+N41fqaq0IBellBQh0ls2dHqPzBMW8w9JnCMId4dTwE/2nIBHbGDOWl5MFVKQE0HvgamMsYXKsUmBC7zIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RM3ELh+9VQJB6uWX8lOEVsCSFbqQ41cE4OHJCNlddco=;
 b=KYi8SOlklxtD/jNJ+PLY5y98ewWrLMCfGFBLl5F/ABO8Hf3WdkB/0RBEMUsotgrgT6/Q2u9rtCT97oSNY32K7aMIwRQn4Dw+/Dnq5rC2kyPyfJajPgIncdBRzhXEfyWHw/oTmpXTfcqUuXOT3nD4FE+8VaWdprubKL19ruBWk7YOWC2hdW3zkaafHDehr7C3thpAPlFJ2IKIl6NK2kDklfb9mGwZ3/C+v7RFH7YebKTvkeo9GT+w3mi18kvBg1GdQ/XU+lIE4JRW9cl9M7BVl+BwoytrWb+D/Y/hAvqNS2F1q5EabYXVSz3TJsP3Q8a9ld6p2f9wWZUex4tZrA4k5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RM3ELh+9VQJB6uWX8lOEVsCSFbqQ41cE4OHJCNlddco=;
 b=bLLBa0+kgFS0r5H+UAv4lUhK+L1G9d3mTeXLbJqhfl8AAuilNdJ54YWrIQ3xpNNOnHOOftksOQB4ObgqawUKba8qMO+FaM2yo44KNC5ftqCZoCeytNkDUKozq9UrWmkpjNH0jU+oeiBA9EKWcypfL8jYJY/LPwy+B9UQcSyD8zI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6616.namprd10.prod.outlook.com (2603:10b6:806:2b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Sat, 19 Nov
 2022 16:13:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%4]) with mapi id 15.20.5834.011; Sat, 19 Nov 2022
 16:13:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] xprtrdma: Fix regbuf data not freed in
 rpcrdma_req_create()
Thread-Topic: [PATCH] xprtrdma: Fix regbuf data not freed in
 rpcrdma_req_create()
Thread-Index: AQHY+8c8fYPT93yYbUqBc+yb1ZcWA65GbCqA
Date:   Sat, 19 Nov 2022 16:13:29 +0000
Message-ID: <1A22DD8E-CA7B-4071-9DC7-7434174192A3@oracle.com>
References: <20221119043437.1396270-1-zhangxiaoxu5@huawei.com>
In-Reply-To: <20221119043437.1396270-1-zhangxiaoxu5@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6616:EE_
x-ms-office365-filtering-correlation-id: 23d4dbe6-e5af-41cc-dfd1-08daca48ff67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 608wvw0Fp1CFLqW2Hg0MppdiU7V6mtZ08+rI4zhv8eq130xUrn36cOyNPfgKU/bg6LGKAccH67exgESMkB8xTNWWFx87K5BcjTvAoQugP/+AtgvKjtAABBkCtIGwGB2R1uv5TDTSca+PwpZt8MEx73Ob/MY5JeYlyqgkXE9v6TiWqQDm7ZpAOjKEEXdolY/Xhu4vXl/ZsNFJRTa87fuUbLyGfvK/sy0dlHxcmhXFSzgASrA9jbEoE/e9Hq3aklokjwfQGGmKr8bXbB/NPHrEhyyo6Iqbfh4GqD2cg0+coDVgx0ROAwjoD2EpjRS6dTZu89SIwUzCyZrOXwN37WD6Fqe6VM9BTjKEe7HL5HRHOsQpzV91HVviFtVGn3W0gp9LEQxNeqEBAzR83g6h5jvXsRXRWS060cPw5aaUPgOAW5g5iWU7wdGNE72ZOfp7LY7MD5Ax8QfMAflNlyvth8cqvNUXJ+geJPNRH3n19Ib6dJxs46cv5+e00MjZBR+SxwITCCuFWb0xpiDT8wa4w/cK0w0qDGUFq4URJp82Fb/Ji0G0tIMM3T0mwF0mis+/VNZ/+s3GGmenDVySQcxfpH1gpr/Oho2y3+ryglZ3fPHd2+Snd402zQDgsbnr/UG3sLmzp9F5Lz82joWeYKV4iRbXWf/v2C93BZkhTrjV4Fn5DeRJfNlpJWNG/yzjG80eEA23QemEoguH538GZ/kAjr1zxIUzjBNo4DxlxSRpZpHJ1HM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199015)(2906002)(83380400001)(86362001)(186003)(38100700002)(8936002)(4326008)(38070700005)(8676002)(41300700001)(66946007)(76116006)(316002)(66446008)(5660300002)(66476007)(64756008)(110136005)(6512007)(26005)(71200400001)(53546011)(6506007)(2616005)(54906003)(478600001)(91956017)(6486002)(66556008)(36756003)(122000001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jo315YUp2B3qZ+SPLXvoIXydD70Z8YtlT8WrM0jpp87bA7H5hXDd0jEnbyZj?=
 =?us-ascii?Q?kNPhNo8GlJwC/+m+XlVVR6ex5rTrXEqipACo7d3/tbjxn2QPD/HVaipEZpUi?=
 =?us-ascii?Q?AynzbcWG3RcQGpnqk1y2E+S0BoMj4j2bOMAupKKFsgHqPGHzr2hU7vA5qlgm?=
 =?us-ascii?Q?V1fK43ZtzSGsMgnDwZwZcRXot8sDeJ1IOvnP7AWxYg6PY/YzbJe5pM/Zd8b/?=
 =?us-ascii?Q?CWw7UBRzKq6ooGQvEpcqge5lMi3w9atiDGPwjtwLDRAjpEwL2qxFWWPSmHaJ?=
 =?us-ascii?Q?HZ3KkNxZb18OQrYqbp84ROMtmID2kBWK0JOOXMkclyBMQML/y22iCfO4O866?=
 =?us-ascii?Q?RHpIYZ3d8HS3rIy7Q3xCJi1YeW4rZQxrEK1qxONo9i0a55VsTmVgpMy5p8rb?=
 =?us-ascii?Q?MGYFM//GPFJh0pHdA/5qqAh77DwOUTZJ3KikTH5mKYqSnwoRrM7ndlHx9X2f?=
 =?us-ascii?Q?rZ8JJYYjNu0J5V+uHcnvWNcSlrK/5FXYJOVAzzjxFP0fkjpa08Utiq5QeMqe?=
 =?us-ascii?Q?EgA3TH6StHM7FbrB7ld3zr5SPtiQY/OATZ9jXm+gdKwFgfur3w5OMVga7Mcn?=
 =?us-ascii?Q?aomoGMID77CpmUeKXzi8pE8Zmu3tLSLZcDhBwt8te+OqaavlifViG/h5E9ds?=
 =?us-ascii?Q?vRicuq2oeiw548ZfRXOpsfems29PZKJTE7WIN50oGJ3XmKx6M2bkba2hb0GT?=
 =?us-ascii?Q?tp5XMNxooYlwBxl56hXwUh6uYsrdwhs28G+6UGWHLPax2pX4J50LVtTCSjOv?=
 =?us-ascii?Q?GKBF2DSTql9VRw0Sc3+BUJjRIJdYuSYkfntQsBAFxJYtCpv6n2i0a0zwSuXT?=
 =?us-ascii?Q?oJqUhr0A5EXn+aCLoCRuVqlJgWnk5gJx7cf4kWfraE3o2UcZJUtbMLixtciO?=
 =?us-ascii?Q?62ChJxFkPBk+XRLByrqzBfeH6L/+R9pmEG4CITL88Aa3xrQbxKDLsG+zUsHN?=
 =?us-ascii?Q?BAIWWDmaqpHqHNh7c3IZ03HN62107jz9PKf7bjLAyik7nJyq1P03Sl5I51nl?=
 =?us-ascii?Q?wgK7TLi4A8ZylbeP1Sfo7grtO/AjzfljI7+UoD2glhR6oo0ChK+CSqq5SYm/?=
 =?us-ascii?Q?vNCEKapsEwys7s4wxOXSp6a407Eqbsx15Z115r0OwovN1kv4YB8zjjCzaKUh?=
 =?us-ascii?Q?HhYcYHAsj6aVrq21OtBX45Jr3gM9B5QTQsl8fxu4UQ3B426qhfAWDpv7I4ae?=
 =?us-ascii?Q?dab1s/y7awLZ9Tjghg+JT6ZISGuTzY4YbAJiJVkqcRc0OyTbzVJ1rFDKSaDY?=
 =?us-ascii?Q?BWoWiJKY8BMu73LHpG+NYwcC1DlWlMjgAOr3CGbthaQtX3V2BRrN4pPhpW2E?=
 =?us-ascii?Q?yW4IgoIs7PvO4Gev4oEFxrYA8nsI22R/1AK5K4gqhDkPeh8OVhGB9i9NxhzK?=
 =?us-ascii?Q?g6Rj7ZuDv6jFNxj03A6vQIgXEAgEt6MdyBfRYwFfjfdiq0IMDGP+++6JQDoI?=
 =?us-ascii?Q?IwKB+Thu1VXvgTvt7oKkFp2gJSp+/re3vTRoR1ov+QSp3j4KgI5bVAR0o2tq?=
 =?us-ascii?Q?TV8uO/00a8OECBcVa6fOn4anvuLa/Mn8jVb8Ce5u0XVPGS7WzOUDLzW/wAnK?=
 =?us-ascii?Q?TeG7YK16wcxq6vJIJCDXj/DYr4tWTTi4V3jW2OHr605hSJC/Y6pyElGWYDLX?=
 =?us-ascii?Q?Mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6FC03DE7F410BA498FD5CD7873008F13@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ifJDKvAnHo8dOJM6puF+M48EaMUznfPdjkElVCS01UR62D3uHMi6szzkV0/EcFPUshvpTqM8vmU1hsCdQBl6oDhIm5kRNm9mxA+Ov2S2gKwLatibi/SYnSt7rz7xxTmVzh0NFSTJQtEheJlWeo0NOJWtqhN2V8tHZ1hNg4s3GwNuiWwD8Jk1R/XgCTH1J52ePrnFWdT4hjCSR6ezcSgCZFoYO40puXTyDIsaV8zMYEmJnAC2j1/CHFxgkSXzTfDzI/FnpC91npkwWyBlduWAL9RRiUPwhjL9CCPw7RB8cabC0DNZRSNMXI/bt3O3LGESsLlqgus3kZgfC7utcBlmf5E9R5B6tHrbXzvn09pkXJZjFtGz0lTmkpp/tRIrjpxqtDaVbGSJmTtm4a4HyeUywpjS4sehalPI2K+QIMriugfPL7lh43I+yCRwew+/VA9lVhbYAnC738/Aud/xyxlX+pOFyY1xBgnJpR8+xoeLazPXT4jPia9Poz/3oXrAJraJLq3sPlj6NgwBudl/vd9O6OtxI2RZ8S0KDx1L/nmslppqklVR4fQwcdDhc1tU5rgvWIuDq/zU01c9ttte5JGXmITMedLLfZiXJXnpvI4Rb0Nbuhu7ZbuWq8fAsTsjAPFxqN2snzX3taO99PHRcFMp8IEAhrnG6DWXZaenvmMpaYFp1A8ZoHf+6ZGg6b/QEbQhvS/K2O/gvpYaDLH7/PkSW/iNxDiDINUkMcVdaX+jnwjdgSaou+6BsY3bTTRiYyy455Iji+tpIul3W8tDdS5RBqWFmxcFnb+QstuFvJGsPJjq/zewOhgLP/B9O/XrZhGmZ5aPfp+i8Y7t/9/GuYqeKoCT6RtImuznB8C1OMtj94yQ/HYyX43gtRDDXNrf+osY0JCIQIAagT1+dKvY57D7KQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d4dbe6-e5af-41cc-dfd1-08daca48ff67
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2022 16:13:29.7644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRd7k3wvRDtpolY/amnJMbcUJvprEdjKP43prPvuyJ+pq3U7HG+4VcJ2h3i+W9zf4GNaYj3GKl0ntm35gmnyKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_08,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211190125
X-Proofpoint-ORIG-GUID: RCCUwb9p8Gg0MPQrWT96xslteLlOkM_6
X-Proofpoint-GUID: RCCUwb9p8Gg0MPQrWT96xslteLlOkM_6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 18, 2022, at 11:34 PM, Zhang Xiaoxu <zhangxiaoxu5@huawei.com> wrot=
e:
>=20
> If rdma receive buffer allocate failed, should call rpcrdma_regbuf_free()
> to free the send buffer, otherwise, the buffer data will be leaked.
>=20
> Fixes: 8cec3dba76a4 ("xprtrdma: rpcrdma_regbuf alignment")

Actually Fixes: bb93a1ae2bf4 ("xprtrdma: Allocate req's regbufs
at xprt create time") might be better. bb93a1ae2bf4 is the commit
that incorrectly added the kfree() to rpcrdma_req_create().
Even though 8cec3dba76a4 is what split the regbufs into two
allocations, your fix isn't applicable to the rpcrdma_req_create()
that's in 8cec3dba76a4.


> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>

I'm guessing the error path is getting exercised more once
f20f18c95630 ("xprtrdma: Prevent memory allocations from driving
a reclaim") has been applied. Good catch!

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> net/sunrpc/xprtrdma/verbs.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 44b87e4274b4..b098fde373ab 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -831,7 +831,7 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma=
_xprt *r_xprt,
> 	return req;
>=20
> out3:
> -	kfree(req->rl_sendbuf);
> +	rpcrdma_regbuf_free(req->rl_sendbuf);
> out2:
> 	kfree(req);
> out1:
> --=20
> 2.31.1
>=20

--
Chuck Lever



