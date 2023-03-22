Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CAE6C584F
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Mar 2023 21:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjCVU7z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Mar 2023 16:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjCVU7v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Mar 2023 16:59:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3D14C08
        for <linux-nfs@vger.kernel.org>; Wed, 22 Mar 2023 13:59:49 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MJJ1JH004409;
        Wed, 22 Mar 2023 20:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Vjlv2xu8BCRA95VGSqaodyJv2iPcKc/nSqViPMNsbkY=;
 b=LSMGM0hbdgm5O1+YUiU/gWjzwQd6Eycn20t9m/dwAafgcY8o9FhBup9NeDqp4LdKBU//
 hcvoqfsm6ttXSPtpPQYU0ksuancT+COtcPj2C2rHf1PDQNjfCNpAdysTj/NH3EdUyyio
 x9kH06XHrKTAPYZ/by1z5GuzXX/Uw8wR7i1k76aUYMceWUpa5PMpGknP6Pq5dQkt/R2y
 65EtzHMbDvsB+El30c+pd/i6chClVxP9CauT45TFDia4Ky0BsrnhXlP5h/Z/WNQ6PDNK
 06xsDhvKrZekVU0DGsgTTV3KY6UoRaM/I19JnL/S70z96iPRnZMyA2LH1gyW2wKrUl0B JA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56b1ytp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 20:59:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32MKiA5i015770;
        Wed, 22 Mar 2023 20:59:38 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pg8yp0njj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 20:59:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBNkKyJ3Lud95z0ZiXxRAIBvngovb6eHQf9aYV2OykdU8kwkrsKQ31kfItvc4kkQx0eNRcdICDU5QGNFw5PDIPgwhy2P3xjGO3NDDROi3Rj9tJ/YZuKszGnIgVU/K0EBVWc3psHVm/yALArzF7j3CEzK1ADOoKE9Hay2C5O0Xl0VGNltzjU7rnek+1HpKCEV6SJtzuAOCkgbJNi1dsiVJJwkbvM/yQmUdygAl2Mhqx4a8WBmv6DAmXxrWNNM8PFsfrBF+OP8jb4mMh7IYfdbabikDI/CFaWGn/SXRIYQw8Y0AF/33B3SNsuYFXmmdUUy4VuBN5JtI68k5R8VHoVdNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vjlv2xu8BCRA95VGSqaodyJv2iPcKc/nSqViPMNsbkY=;
 b=IDJgaOFpNCcdd61w6L3F/sM65MJFxU9YVlJlarDIn4Un0gimg8A//+ZF5XhgRgftTujs3+81O6U93h/saOPBntEYx4GNdJ0NI99mN44D2plfWgq0QTqvcuRnN0GeW3rTTN88LsyHqKBfBtSFIUWJzgyMSI8+hqnWgWu9JBuJxYn8EgA55Ldte7DKvycL8WxEyJNX3d5QYRF2Y0PxkvAYLDroYmXUT6iT0zUH9zY6Q73TmSdcE8hP4rFLBQANI+w38dUHkwep74SS0NqM98o3r2kpzH/2tZLJ/T/nyDlABIVBWtKMY3csGx0nUNiUnMArGLzkgWzYLj+toUv77BbWSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vjlv2xu8BCRA95VGSqaodyJv2iPcKc/nSqViPMNsbkY=;
 b=QRwX/UY646Z/RxtdCKhJiNjfIOTzO9wDffe4659tMH0HZvm7Rv27KCo34GZY4vdlr0iVN8Nx7f95tXENDpSXcwEEu1jamLiC9WSxclie/xZ1p9Mjr2WGHYhGpypvy9hmkgz3BOKkN0d4WYSqdEttkMPxFDExrHKa3g6LlbE1bMo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4628.namprd10.prod.outlook.com (2603:10b6:303:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 20:57:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%8]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 20:56:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
CC:     Chuck Lever <cel@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1] SUNRPC: Fix a crash in gss_krb5_checksum()
Thread-Topic: [PATCH v1] SUNRPC: Fix a crash in gss_krb5_checksum()
Thread-Index: AQHZXPEAohUGHZVco0GPy3wSFS5lZq8HR2WAgAAAaYA=
Date:   Wed, 22 Mar 2023 20:56:59 +0000
Message-ID: <08CC5855-A1A1-4716-BC8A-2BC55E8B8B34@oracle.com>
References: <167951169462.22263.13708891630674211649.stgit@morisot.1015granger.net>
 <CAFX2JfnA=qk+=YGFjaE8nrmW=yUwthvWaeCN3X4k0065eXExuA@mail.gmail.com>
In-Reply-To: <CAFX2JfnA=qk+=YGFjaE8nrmW=yUwthvWaeCN3X4k0065eXExuA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4628:EE_
x-ms-office365-filtering-correlation-id: 401e9138-3abe-4771-49aa-08db2b17fb10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KJNx6eny0nz2pxih2cZQfN0PrkiOSjNfvAhnGHTze2z4Gt5ULiXpvl4qxbF1eUFXk+olvWSRwlxSj0dg92f9MTMo2eUh2GBn9/j0EojplD3s7BlHWzSNDFC6nRjlXOv5Xt3c8WIp8eHh2O5LcChe/XQtQCboqtBMjLMruCRht6hj8kYVqihDKpd9HFqorS4fnLC/jSA51dpnB7K8Hzqgql7nU6SiBnj7DcoA0UiSwenQwpinSs1+ewqRzDlQGWaWoawRfikl/YviWR10p8VXcc9wG2YPlohr5FiyhaBAwy+7mBUCj1pMwIRoxkEedh40KBuP+GMyGzuODcKQUQS6iBjB+tXLJ8o1ogbMxkQS/R9SMZzmXd/wA9rzinyEziLIRXbrEiGVobGYZM0IQ5SBviFknqN4q6PFIAuuBeJhFxUwAt6w3JLLuF5ewdXD35KPg4fOKgGWF61iPrdH4fVlNEZ7DrduttegdtFIgshYH6hfQwo93eUhOkHraiKc+HZeIZ+ywyVHWPIao2F3fVWigJcMnxqgfxKA2H3ZeqKbpFvEYPfSfMlX/cOzVmvCbMB2afQEwxu5KDz/D5XIIyEF71P8M6K7FdzIpEjxZzEXxEaM7ek7wwl0z0gdttC/vpKV0Wc1joo0s+rakVCL8I46/PqvdYw4AWZimrilHgT1cUQ8MXhS8cwYD6yi8Tvh7wSaGfbfsEL2O2sdCsKryt22diP6DNUvGXCHHjVO1ax696M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199018)(6512007)(2616005)(26005)(478600001)(53546011)(186003)(5660300002)(71200400001)(6506007)(6486002)(83380400001)(316002)(122000001)(38100700002)(33656002)(86362001)(91956017)(38070700005)(54906003)(66946007)(36756003)(76116006)(41300700001)(64756008)(8676002)(2906002)(8936002)(66476007)(66556008)(6916009)(4326008)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3c5RkZ2UEtuYVJmbzk2Q0R6UEs1c2NLZy96bW9FNXhrVVRGU3ZvYjdYOHFp?=
 =?utf-8?B?UkVabXNyZWVxSXlGSkUxbEl4NEY5YU9wNU5IUU95S2dJU1FOZmRpb0FqMVVJ?=
 =?utf-8?B?UG5OOWhxcnFlMVBmMi9iM2tWZUo1OWNZRU16dmhtQThtcjdpYkt0ejJVbHFr?=
 =?utf-8?B?MVNkNldSdE5FbjZvZW5ISm04NU9iWlVtN200WkRiOVVhcDVpSWdNd1FpQkd3?=
 =?utf-8?B?NWljaUptOFdTTVpUUkFBQWR2NnkvMEJjMitSYStwQUFUZ3kzNHd5VVJHdVNX?=
 =?utf-8?B?dS84bGVLNThCcGJBSWt0R2s4Z0NNSFRvZHZiRVF2MFdINktKUjFqWk9Vd24w?=
 =?utf-8?B?cXkwemxPSmVJZWFsU0c1TWEzUWIzcG5TZGdyRXV3RTFPWVBlbHJSSkM0MjhU?=
 =?utf-8?B?QU9uNS9xTkxseXM3NTZ5QVBVeE9aTXBOVVBTVjc4WEFoUlJTNFRMbEhDeWI0?=
 =?utf-8?B?dllEdmo3bzZJWkV0Nkpvay9xNmY3YVBRclREQXFuTlRYZXJCYktOeENBVEkv?=
 =?utf-8?B?U24yQWJrM3UzYk84ZS9jK0cvdWdvd01ObmhXNTNpdkh2b1B2L0o3MWRLbkIr?=
 =?utf-8?B?SlAzWG9WR2srSWRoREFoQWJSbWc1MEhKcjhXdTVtWStzNEVwVXZncVlXTW1h?=
 =?utf-8?B?WlhiL1FWWWZCWVI5WCtHWEFwSVVyTWtFN0cvMkNadWRsQ3hnMTlvSkQyWHNs?=
 =?utf-8?B?OWZPcWhNcG1xM2tUbENEL25zY0ZneHdkbjg1cEpZS1g2bUpWYjhaVDFFRys2?=
 =?utf-8?B?N2QzdFU2cDM2Y0QzbmphRENjd3pDaVI2eVRVSHA3dnhvTjkrOTcvWHhXSnJH?=
 =?utf-8?B?RU51MjNxOUJncjN4dWVWOTI0S01SNHFEWmEwcnNrMDYveUV0eFJ1VkMwY2JD?=
 =?utf-8?B?SExpeXZ0UmZyZnhpTHFRSWgybjBNSE1pRnc2eUNNNGN3bVJ3bVhNSVNwenly?=
 =?utf-8?B?Wk9BQkxUWm5OTVZ4anFWczV1VVlFZkxIb1Q1eUpsNnBtVFRRTDhzZzhPMjBP?=
 =?utf-8?B?SUhScjBUenRaUG5zRlN6Y095WkhvdTZpUW9TQTJ4M3JkV1pHRGNJSXk3MFpV?=
 =?utf-8?B?L0RGeHhKSytGT2lKam1CalZnR0o4V2hmU1RVZ2podTBEZXB3SGVlMmpyYzdK?=
 =?utf-8?B?RGM5anBUazVpeXRrczM4WWxyUVVVNFZJbHZGNXU0RUtWUXg3YncvdXNQNVRh?=
 =?utf-8?B?V1grUW5XMU4yWDZUS0ZGL3IyODN4SkN1ZU83VUNEQTRoUjZnMTdDb0lSUkJj?=
 =?utf-8?B?eE1CN2xzRjBMYnhPMWlqV3FQQWI5L3dzTHNwbSs3NS9sQlZYZWtsbE03ZlBP?=
 =?utf-8?B?MlUyMGNwK0hrb0hrTFo5eVpaRnRQaTNIbTArVUpUOHdXNUZURGxGb2NVUmRy?=
 =?utf-8?B?YjJlSEo3Ymp2dSsxempyZVFQazNxNks2L2VHcXRMemlUcG5wUFY3Zk1aN1Mr?=
 =?utf-8?B?OW1jYXdDSVBCMTBOUTZBbFRRVFlydktNZVZ0WHN3cTEvTFl4dXNNbExPRWla?=
 =?utf-8?B?Rnd0ZW9acG1EQ1QrRnFxa3lCSlVQTjlvZndpaHM5VTYzcUxnM21RbEE4YzVZ?=
 =?utf-8?B?d3pFQnl1T1duYmp0bVY5NTZ2cm9MTUY0Q0k4ckx4MFhadjFxOVJxWiszeWF2?=
 =?utf-8?B?Qy8yOHVkb0ZITVV0d3BtL1lPL1o3LzB5Mk5FQ2lTWFA3VWpDQjdNemZ4d1NT?=
 =?utf-8?B?cUVyVGU3NTc0c1p2YmlMQzF1NUdGZThsNEU5SWl6UGVZSEUvc2ZpWVBJc3Fz?=
 =?utf-8?B?TndjSkQ2TTdyQlE4eDlIWXRab1IvTzNkSy9pMTZ2RkdDL0RSYmhxOWI2QlFU?=
 =?utf-8?B?aDVQL1A3MDdCYmZ4dW01eGlFK3V5OUdPcTBNMG4zZVcxZWJTNHRlNGRBNEZk?=
 =?utf-8?B?M3k5dktmWjFCYk5nNUl2ME02OTRqZVA0NVlSWWJHZTBNVDJ5SHQwcFo0MjhW?=
 =?utf-8?B?YmlZT2ZQTE9aRk1OMzZYeFQ5aGlyVmUzWHI5Zm53TVVmOGptRU85Qnp4SVZp?=
 =?utf-8?B?NXltRjVGVWJIVjdvSUZZV1V6MGxuc2hVM3FsMmxqN3g4d1luQUtIbDE1aWNz?=
 =?utf-8?B?SWlPaHQ2UjhibkZtbnkwOUVjM2VlbkllY0U3Ti9oM1gzazBqVWpGVE1vVXMr?=
 =?utf-8?B?V3JnN3haWXZZUzcwYU5zSUNPNG82S1lNZlpEZTNJVE5mVWVGNk1SdFRLRkxn?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69AB0CBDCE1FF34BA48E00E869C859DF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PQYH+yuJulg8+DMmdBhw9EKLAd7MIUyjbNMYHmwLRZ5jVqquQH1aUyOkhgx/TIPsde0RaKg3+4I72e17cKY6rSJPEEhI89y+vzyF2Ambr5L9am/oV6hleostQOU/0h8+HYZsiUiSYaePfRLJNRmkLsE7XA574uVuklpWAvprbkvftNkbbwcPah/GdKrYkotyN8EUXMml8AkjPSh/PdAs/XE0Kx2ZdYS0+ET0p+Pjl9jp2/t7C/oNDKsY3/8gTOHlpunIRlsHvEFX2fpDnjWPRwGivXIra7crjftEbWw0mNam/DoAgFLj9CQ7z1fQc26fbPKDnMOv+Sbslp4wyq3+FYW93k9IwDeHjg+gRJmwr3tLspHOPMqCpPwVRdNyZ8nEt1nCaxS2w1do2Bd836dWCF1KE0iGEKs90oFSdQR10wtuWa2AxiC8KUEZbOQqiP1o6AostEHb/HDa4nMvC9ULbx/+KxY5ZpavfxSx4DpcDWFwrRW0WhnhxdxKjQRx/gdQk/iN8Hd9JlsjlE2wXwiCKdBeomsyuoLNIyhnonOedljAN9/s3W5G3cW2Q2fD482IpAOw2HmTNF+jH3368zbRQCRvfH7/y8fVgiofRaZ89H/tPtXE7+FtNX/Li1nZis9Ec0yOaM4SijJxqdmRKEholVPNcNdvgyxfEskdSu8IfOCvH5oqEPN9tuAO1FlnR6mgqdA2QdjjNATJELMwIqM7fC3jHl/pLr4rkW2BohmcDmOUO+WNYD2iZ4TDY/kFgXkZjvUw7tptCZRowpdIl6hz3i+84aSu9hzOz/zrPhsrAO2t3HJZqlIP0aEYK4QhPiH5NuFml21QHjr/B8Gi5dkwmt1yO/0Z0ptZa7ThUzBwags=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401e9138-3abe-4771-49aa-08db2b17fb10
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 20:56:59.9291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QEr2GXnbV8yEFwAx4r38jRP8H3cezPWQdGY2/KgLymoURYsL9emB/MEAkka8u2TiwndpUZ0rcKZzVdZyu8Gw5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_18,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220149
X-Proofpoint-ORIG-GUID: Ph45UQ3zlfkesjpU86tNQsJ8aA4fVxPN
X-Proofpoint-GUID: Ph45UQ3zlfkesjpU86tNQsJ8aA4fVxPN
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWFyIDIyLCAyMDIzLCBhdCA0OjU1IFBNLCBBbm5hIFNjaHVtYWtlciA8c2NodW1h
a2VyLmFubmFAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgTWFyIDIyLCAyMDIzIGF0
IDM6MTfigK9QTSBDaHVjayBMZXZlciA8Y2VsQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gDQo+PiBG
cm9tOiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+IA0KPj4gQW5uYSBz
YXlzOg0KPj4+IEtBU0FOIHJlcG9ydHMgWy4uLl0gYSBzbGFiLW91dC1vZi1ib3VuZHMgaW4gZ3Nz
X2tyYjVfY2hlY2tzdW0oKSwNCj4+PiBhbmQgaXQgY2FuIGNhdXNlIG15IGNsaWVudCB0byBwYW5p
YyB3aGVuIHJ1bm5pbmcgY3Rob24gYmFzaWMNCj4+PiB0ZXN0cyB3aXRoIGtyYjVwLg0KPj4gDQo+
Pj4gUnVubmluZyBmYWRkcjJsaW5lIGdpdmVzIG1lOg0KPj4+IA0KPj4+IGdzc19rcmI1X2NoZWNr
c3VtKzB4NGI2LzB4NjMwOg0KPj4+IGFoYXNoX3JlcXVlc3RfZnJlZSBhdA0KPj4+IC9ob21lL2Fu
bmEvUHJvZ3JhbXMvbGludXgtbmZzLmdpdC8uL2luY2x1ZGUvY3J5cHRvL2hhc2guaDo2MTkNCj4+
PiAoaW5saW5lZCBieSkgZ3NzX2tyYjVfY2hlY2tzdW0gYXQNCj4+PiAvaG9tZS9hbm5hL1Byb2dy
YW1zL2xpbnV4LW5mcy5naXQvbmV0L3N1bnJwYy9hdXRoX2dzcy9nc3Nfa3JiNV9jcnlwdG8uYzoz
NTgNCj4+IA0KPj4gTXkgZGlhZ25vc2lzIGlzIHRoYXQgdGhlIG1lbWNweSgpIGF0IHRoZSBlbmQg
b2YgZ3NzX2tyYjVfY2hlY2tzdW0oKQ0KPj4gcmVhZHMgcGFzdCB0aGUgZW5kIG9mIHRoZSBidWZm
ZXIgY29udGFpbmluZyB0aGUgY2hlY2tzdW0gZGF0YQ0KPj4gYmVjYXVzZSB0aGUgY2FsbGVycyBo
YXZlIGlnbm9yZWQgZ3NzX2tyYjVfY2hlY2tzdW0oKSdzIEFQSSBjb250cmFjdDoNCj4+IA0KPj4g
KiBDYWxsZXIgcHJvdmlkZXMgdGhlIHRydW5jYXRpb24gbGVuZ3RoIG9mIHRoZSBvdXRwdXQgdG9r
ZW4gKGgpIGluDQo+PiAqIGNrc3Vtb3V0Lmxlbi4NCj4+IA0KPj4gSW5zdGVhZCB0aGV5IHByb3Zp
ZGUgdGhlIGZpeGVkIGxlbmd0aCBvZiB0aGUgaG1hYyBidWZmZXIuIFRoaXMNCj4+IGxlbmd0aCBo
YXBwZW5zIHRvIGJlIGxhcmdlciB0aGFuIHRoZSB2YWx1ZSByZXR1cm5lZCBieQ0KPj4gY3J5cHRv
X2FoYXNoX2RpZ2VzdHNpemUoKS4NCj4+IA0KPj4gQ2hhbmdlIHRoZXNlIGVycmFudCBjYWxsZXJz
IHRvIHdvcmsgbGlrZSBrcmI1X2V0bV97ZW4sZGV9Y3J5cHQoKS4NCj4+IEFzIGEgZGVmZW5zaXZl
IG1lYXN1cmUsIGJvdW5kIHRoZSBsZW5ndGggb2YgdGhlIGJ5dGUgY29weSBhdCB0aGUNCj4+IGVu
ZCBvZiBnc3Nfa3JiNV9jaGVja3N1bSgpLg0KPj4gDQo+PiBLdW5pdCBzZXo6DQo+PiBUZXN0aW5n
IGNvbXBsZXRlLiBSYW4gNjggdGVzdHM6IHBhc3NlZDogNjgNCj4+IEVsYXBzZWQgdGltZTogODEu
NjgwcyB0b3RhbCwgNS44NzVzIGNvbmZpZ3VyaW5nLCA3NS42MTBzIGJ1aWxkaW5nLCAwLjEwM3Mg
cnVubmluZw0KPj4gDQo+PiBSZXBvcnRlZC1ieTogQW5uYSBTY2h1bWFrZXIgPHNjaHVtYWtlci5h
bm5hQGdtYWlsLmNvbT4NCj4+IEZpeGVzOiA4MjcwZGJmY2ViZWEgKCJTVU5SUEM6IE9ic2N1cmUg
S2VyYmVyb3MgaW50ZWdyaXR5IGtleXMiKQ0KPj4gU2lnbmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIg
PGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+IA0KPiBUaGlzIHBhdGNoIGZpeGVkIHRoZSBpc3N1
ZSBmb3IgbWUsIHRoYW5rcyEgQXJlIHlvdSBnb2luZyB0byBzdWJtaXQgaXQNCj4gd2l0aCBhIGZ1
dHVyZSA2LjMtcmMgcHVsbCByZXF1ZXN0LCBvciBzaG91bGQgST8NCg0KSSdsbCBxdWV1ZSBpdCBp
biBuZnNkLWZpeGVzLg0KDQoNCj4gQW5uYQ0KPiANCj4+IC0tLQ0KPj4gbmV0L3N1bnJwYy9hdXRo
X2dzcy9nc3Nfa3JiNV9jcnlwdG8uYyB8ICAgMTAgKysrKystLS0tLQ0KPj4gMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBh
L25ldC9zdW5ycGMvYXV0aF9nc3MvZ3NzX2tyYjVfY3J5cHRvLmMgYi9uZXQvc3VucnBjL2F1dGhf
Z3NzL2dzc19rcmI1X2NyeXB0by5jDQo+PiBpbmRleCA2YzdjNTJlZWVkNGYuLjIxMmM1ZDU3NDY1
YSAxMDA2NDQNCj4+IC0tLSBhL25ldC9zdW5ycGMvYXV0aF9nc3MvZ3NzX2tyYjVfY3J5cHRvLmMN
Cj4+ICsrKyBiL25ldC9zdW5ycGMvYXV0aF9nc3MvZ3NzX2tyYjVfY3J5cHRvLmMNCj4+IEBAIC0z
NTMsNyArMzUzLDkgQEAgZ3NzX2tyYjVfY2hlY2tzdW0oc3RydWN0IGNyeXB0b19haGFzaCAqdGZt
LCBjaGFyICpoZWFkZXIsIGludCBoZHJsZW4sDQo+PiAgICAgICAgZXJyID0gY3J5cHRvX2FoYXNo
X2ZpbmFsKHJlcSk7DQo+PiAgICAgICAgaWYgKGVycikNCj4+ICAgICAgICAgICAgICAgIGdvdG8g
b3V0X2ZyZWVfYWhhc2g7DQo+PiAtICAgICAgIG1lbWNweShja3N1bW91dC0+ZGF0YSwgY2hlY2tz
dW1kYXRhLCBja3N1bW91dC0+bGVuKTsNCj4+ICsNCj4+ICsgICAgICAgbWVtY3B5KGNrc3Vtb3V0
LT5kYXRhLCBjaGVja3N1bWRhdGEsDQo+PiArICAgICAgICAgICAgICBtaW5fdChpbnQsIGNrc3Vt
b3V0LT5sZW4sIGNyeXB0b19haGFzaF9kaWdlc3RzaXplKHRmbSkpKTsNCj4+IA0KPj4gb3V0X2Zy
ZWVfYWhhc2g6DQo+PiAgICAgICAgYWhhc2hfcmVxdWVzdF9mcmVlKHJlcSk7DQo+PiBAQCAtODA5
LDggKzgxMSw3IEBAIGdzc19rcmI1X2Flc19lbmNyeXB0KHN0cnVjdCBrcmI1X2N0eCAqa2N0eCwg
dTMyIG9mZnNldCwNCj4+ICAgICAgICBidWYtPnRhaWxbMF0uaW92X2xlbiArPSBHU1NfS1JCNV9U
T0tfSERSX0xFTjsNCj4+ICAgICAgICBidWYtPmxlbiArPSBHU1NfS1JCNV9UT0tfSERSX0xFTjsN
Cj4+IA0KPj4gLSAgICAgICAvKiBEbyB0aGUgSE1BQyAqLw0KPj4gLSAgICAgICBobWFjLmxlbiA9
IEdTU19LUkI1X01BWF9DS1NVTV9MRU47DQo+PiArICAgICAgIGhtYWMubGVuID0ga2N0eC0+Z2s1
ZS0+Y2tzdW1sZW5ndGg7DQo+PiAgICAgICAgaG1hYy5kYXRhID0gYnVmLT50YWlsWzBdLmlvdl9i
YXNlICsgYnVmLT50YWlsWzBdLmlvdl9sZW47DQo+PiANCj4+ICAgICAgICAvKg0KPj4gQEAgLTg3
Myw4ICs4NzQsNyBAQCBnc3Nfa3JiNV9hZXNfZGVjcnlwdChzdHJ1Y3Qga3JiNV9jdHggKmtjdHgs
IHUzMiBvZmZzZXQsIHUzMiBsZW4sDQo+PiAgICAgICAgaWYgKHJldCkNCj4+ICAgICAgICAgICAg
ICAgIGdvdG8gb3V0X2VycjsNCj4+IA0KPj4gLSAgICAgICAvKiBDYWxjdWxhdGUgb3VyIGhtYWMg
b3ZlciB0aGUgcGxhaW50ZXh0IGRhdGEgKi8NCj4+IC0gICAgICAgb3VyX2htYWNfb2JqLmxlbiA9
IHNpemVvZihvdXJfaG1hYyk7DQo+PiArICAgICAgIG91cl9obWFjX29iai5sZW4gPSBrY3R4LT5n
azVlLT5ja3N1bWxlbmd0aDsNCj4+ICAgICAgICBvdXJfaG1hY19vYmouZGF0YSA9IG91cl9obWFj
Ow0KPj4gICAgICAgIHJldCA9IGdzc19rcmI1X2NoZWNrc3VtKGFoYXNoLCBOVUxMLCAwLCAmc3Vi
YnVmLCAwLCAmb3VyX2htYWNfb2JqKTsNCj4+ICAgICAgICBpZiAocmV0KQ0KDQotLQ0KQ2h1Y2sg
TGV2ZXINCg0KDQo=
