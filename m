Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C220C4F1883
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Apr 2022 17:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378610AbiDDPgY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Apr 2022 11:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351015AbiDDPgW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Apr 2022 11:36:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1556A2DD79
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 08:34:26 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DiQBb000758;
        Mon, 4 Apr 2022 15:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BgW3f7GkxziqdCSFq7bCYRf6nFaovMPjVfKXC+2koiM=;
 b=M5Iv8+8Pd5P6vsisksjyzTndLP0Ncz9P2PgspEPZjPtXoUNmEkuTwbXV252u5Ds5/HrA
 HMju8U3k4BL2wFsbjr07ukiU3s6qqzgK2CegHqGGlTC27KKjc2gx9LaEjOPuYX9lFE60
 UqczJbNieE1jPkDsLiGncftHQRuxFWFy4qHSH8c7bH/tyENw9cCSapRCzLmEFN3ux+Mz
 goxxZ55FXugQGd7DGUb1cR+RTmI9uwNWSIFAQWBk6EdcPXMP2LhvQTJ0RYHq6SSr4wNU
 dAGUL70RNPZE033sIJ39LBpcxbUTpWBAk60heWF3p4NvA0bqMSEYxnhw2BQNhhR75pre Pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3skj5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 15:34:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234FUMba014845;
        Mon, 4 Apr 2022 15:34:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2ek1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 15:34:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fn4CA6YUXNKTWH8xeqmYXO/oMR9ipzMscLqvX6w6JDhvgi9Oqxjr+TPh8pqaMYcdFpoEsueNCrj2NZZgY6P4BUhNgUuJXhuY4DrumO+tB9SsLRCKE++bRQj19tQ1/44/v44/8EEW5b8MbMWAbMXUD1RZjIq7eCXg/yjYBkA4RygsTIG3nrn96vnCNGwdhIaG1UWfPzNPiAdr7MFxGdRRHAsZy5rkmOrXk9ltocL2GczYNjJVWyKU3Kbb0i91IJeop71+iW3sy+arKH/EMzviU2Sm0ztmxrVTMeK0kn/sHzlWWW+I4ZZ4EYozV+1o+ORIJi6W39I0mpGQxiV7E8VZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgW3f7GkxziqdCSFq7bCYRf6nFaovMPjVfKXC+2koiM=;
 b=O+fYQ7DP9hDDxZhNsqfhs6mtW8TksC+9w/CPLxzCXI6eaN5HPgzeKaECGFhtC9e1u8mgk8/hybG8iVIEcRFiWu+iNL4pRbrOIUCsABCB0xJDVEOiHBWboHDQfgLF8homNZWNp/5aGRDyp2L4TsVgUNk75Ws2u8Ro+sVJK3eTCT1VOHANbXcVpPbWNtNaCdy6IgVkN+iDk7j8fpRQKBJNbTXCRItl00BTjZZKWXd9HwOdQWSHBdvH2892zcHAQXjaJqBgT+7Ii/SsYuryEFYeWPRYL1fXTbr152eSgcOlYUxf71Drbrc+L5YiaIOXUPRzn/EXlNXaeUr42Tn1YNn7ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgW3f7GkxziqdCSFq7bCYRf6nFaovMPjVfKXC+2koiM=;
 b=LeBHYRsjaHFEqL29zz2n1GfCz31QVn7N8Njn9t1rDpej5w9vrjUVcFjzgbmWUgfcQwr4kHMv3GuIjwYkodMuEMWxYNHrRgTfXVKbyMai528o8p+Mt9Lcm+t2m0j/z8h70f8ZKcQIbWS85tvx3YyaYOUeKv5+5a7sU1FdZgUU7OU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4251.namprd10.prod.outlook.com (2603:10b6:5:21d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 15:34:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 15:34:17 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Question about RDMA server...
Thread-Topic: Question about RDMA server...
Thread-Index: AQHYRRJNBcdkabgaO0Catodzu/oRE6zZm94AgAAKfQCAAARwgIAAAYeAgAABP4CAACmZAIAAFQAAgAX8lAA=
Date:   Mon, 4 Apr 2022 15:34:17 +0000
Message-ID: <930A468B-E674-4F5D-8BC0-DB9F45611A9D@oracle.com>
References: <82662b7190f26fb304eb0ab1bb04279072439d4e.camel@hammerspace.com>
 <1114899D-BBF5-4CB1-9126-E4E652ACAAB6@oracle.com>
 <5DCBD9EB-7721-48FC-9EBD-58B7DF05A704@oracle.com>
 <8af942181abb39cd7ce8fe91be9c4c2f8c9f2c56.camel@hammerspace.com>
 <2E4807E4-5086-4F15-B790-8D952B394FE5@oracle.com>
 <974fa169124661c2ce5ed549d499837435cc7b4c.camel@hammerspace.com>
 <E7FD566B-0570-4D14-9936-5C737B619E0B@oracle.com>
 <b9b98ad9b21f228566a5ebd643198c669c9f3408.camel@hammerspace.com>
In-Reply-To: <b9b98ad9b21f228566a5ebd643198c669c9f3408.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb2c2ef8-e904-40ca-b930-08da165094c4
x-ms-traffictypediagnostic: DM6PR10MB4251:EE_
x-microsoft-antispam-prvs: <DM6PR10MB4251D7E3320E481860040DFB93E59@DM6PR10MB4251.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wK+MImwx+zWTT29sJ0/udCYUTFy9ZPDq7aK68DkPXqJ+9ix/4YXFj+aSRhBst0nu5sz85Z1Z5WZWj60KDO+9JnzAMDjEKaIEOn4FX0/HEgqANWmC5xwbTqkhYoRXs729B3AH2Umr0VG+/onOgempIcR3dEaqc/G4Q7QUPtDVKYo3ty1wZMr6RegkDRLauu/rtVFUDhQjOUa6GkiAZT/mtQKXVb8DdakJSkJmKCmEyg1s719ZaMbjFGHKV1xXOfu/IFXKwerVQcbqy8206Jy/XGAn0cIA8nKWTczOPddd6LrgmjP/jy35z/lqBG5SOvFJjc+UL1smSE3xbsvwTxTZgoGkq95kj61QJ5KwJA/9jvz65xP6gf6mNy1HuFlaiLD8T+WXzV31T1GZ1/qKMJ2kvc8v28yQQEt1WrHc8J4a8O5azJZbeAtrTZEo5N/HYtqhCR4BgFfYykHmXm27Y332F9/apxSPK2gYWL4qaKwZboCK+YfwPOyhEbM/iX1TCXvTKgEKtCwoEcYH+P3MT+xbQNzEhu99g5b6D71qs26F9qRWPkhHS2YfdRdu3REp52hLsX8+c0RyBx3+sP2QKjuiP1CoosIrRwHJPNOxP4b4t7sPcxwnHPTbE3tYNtkjDs2cXY8qihK3tIMr3iyy5RKX7zcicLH7fINk6v8lqDVIIa0S6Y+kv8vqZkGHXQv/PCsDN2Y4X5rsTViWTkaChQeXu4znxSuwHHvKsDG1B/uiOn8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(38070700005)(53546011)(6486002)(36756003)(6506007)(2616005)(71200400001)(6916009)(86362001)(6512007)(26005)(2906002)(316002)(186003)(91956017)(8936002)(66556008)(83380400001)(66946007)(76116006)(5660300002)(3480700007)(8676002)(4326008)(66446008)(33656002)(122000001)(64756008)(66476007)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fRQWAx7kmNdD+UHLskmMXZZ0Z4ynlHIrt2DKu/QqYQHcIHwNuS/uQCw4bgSi?=
 =?us-ascii?Q?ISsboVeHgD6BibAYqtAnwmESwn0EoC4JNh5y5YONA3KE76LEhZyWWrt/0oDH?=
 =?us-ascii?Q?NFj99WekjjzAsQA2rxQaE0MXVh8uQ0BtODZrm+M6iwcj0+JAaQnPLUnCXbgt?=
 =?us-ascii?Q?b8RLNhyOuxnfqZVkznpll9dNb5Bk8kXVGmtu9RHmpbuGLq+YMPIe1K3I7bel?=
 =?us-ascii?Q?myTjOgkGGKqaNSUkZgtdu47NVDSxmq5yPvttvSh/dxCKDIiAfaNtqbLAm7t+?=
 =?us-ascii?Q?xsw+TfkFkuCQmH9raoU201AeJzDEbYeENu8RSonG27X2W8ltoHlDHeEPJHpf?=
 =?us-ascii?Q?vy6HbCRF96YotdEI68ZLKRORCaaBQezN4R6Vj9sqAmb0MdZck4JmpIhpC9ca?=
 =?us-ascii?Q?9LRcgWI0kA3QO266bKU4XHSUUShSDFeeJKnqVELOJlRdoo2kyN5Rf9lsfH6X?=
 =?us-ascii?Q?/LHyF4C1se4s0iQ54pXttHuF3FVF37NUSnKWnws0PDyj7wz906QI7wb1Hkc5?=
 =?us-ascii?Q?0YQqfqQzMhGOyH1Wntt9PwKDwhKsLapDwYE9oBDUYys/FwrDCYci9jJHX7++?=
 =?us-ascii?Q?zffeLqMTdMkETwWI015P7dWpuRyrF02ZoU6l99CsDb4ogVaP6oLUecd3IXEu?=
 =?us-ascii?Q?xKN4olo/BB8d2+HEk5qPTPUzSazdd5e0B/19LvE8tgI8eO/2dO/3TgiqKpqG?=
 =?us-ascii?Q?7hM1zxwh84xF/rz/YuRcq2cXcYbDBeWjzLobyFfA69vFKsclR/s0O2cSSxj7?=
 =?us-ascii?Q?q5hf74oC3KWNXF7rWyFgRuJqDAeYdOWPMBAdEySL01AAJQ13YBC+JU3/ovXJ?=
 =?us-ascii?Q?Pjy3/KCwp1cEMbbIXVZ3Wwn7qfS/SZzjUxOBPS39sLXiRsvZaPTU0fRvXldc?=
 =?us-ascii?Q?Z/82odHLqUWbF+eD/BLy52Fu8SPVVup7liWSMZiGgq6CIszF0t+fC4h/e4Ux?=
 =?us-ascii?Q?+3nz/PfwydrgoYfTpTClsdCcBOTzovXrSvMpZVpZn3D7wjVcCIY3clYPt/Gf?=
 =?us-ascii?Q?yijUQkp6jATUnmanI0wC0gnNjm2kQGnpM7wd8YRpuzYvD4gx3i3gfotwOoMm?=
 =?us-ascii?Q?lSUYlfE8AJTsTBgGofHdvFuHJG+rZIl9yS2Hb29KEm2wvR+JA1L2Dl6nqnSu?=
 =?us-ascii?Q?LAjO27O2SJxBthqSuWH6AnfJ4yZ+WboZCMW8pj0rB0TWEumcByZ+GlHPbzUQ?=
 =?us-ascii?Q?bjrGYpPFBfH269DlTVZxEyfdbgeWjcgMp4678XZJV2smU2Lgvy0XcSvgKktF?=
 =?us-ascii?Q?yLpbsi9ezHqOU7R0wNFwveVhWj49l+8XvgDBebveAy4bboTxhmBW+atoUJyG?=
 =?us-ascii?Q?fsVsqDJtJPalIQdMfdRz6YWrjqxaWdzBdd8VbzPTvZi/kAtBtP34BbZ5Ezei?=
 =?us-ascii?Q?cxCemSDG6uDOuewe+r5GVG2/10NM4h3yAx/0B2xrSpADjpec4u0IzFUcUlUr?=
 =?us-ascii?Q?1RxB1vvq0+iENODBzQMsLiK2KbYLepzjuHklP3Yr5jb44hNyqCicfiRmqCnd?=
 =?us-ascii?Q?gf6JBOCIiJcjFaa6IGKo8U4155FTw9HPWBSJKAgKKNIHZIXZ8F6q7+eT9+0L?=
 =?us-ascii?Q?l7mu3TbNZ/3aI3duN4jYvwTW0niuEQxzvB1Psaoyx9ljM4zQAg+IDCqDRnix?=
 =?us-ascii?Q?mnIDmacjJFqCzagKM0tz/cq3940B7AxJYhfCOQKKq+AiYXWFXwnEex9s+Gw4?=
 =?us-ascii?Q?yWnzwtIlyNlmHmTKidWjZVBxEn1WCUkYzgzBtP3RyTrTZCZxNJoxlP1vQbla?=
 =?us-ascii?Q?oiJKQoC0Ra8HnCmbgS3+I+K1XUYu2cA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49A6A5BD1811F347987C8858E072A6FE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2c2ef8-e904-40ca-b930-08da165094c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 15:34:17.4211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTnLgLm8IapxJTA6Vn5FUeq1AX1V0ujmXGHru1KLLq/twqZpVyQBozFqIOmk8Ykylvx3748o92quVYeVf/KRFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4251
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040088
X-Proofpoint-ORIG-GUID: bAt9qpDhDs-A9rK3ErRyv5YpIcieAnDA
X-Proofpoint-GUID: bAt9qpDhDs-A9rK3ErRyv5YpIcieAnDA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 31, 2022, at 4:08 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Thu, 2022-03-31 at 18:53 +0000, Chuck Lever III wrote:
>>=20
>>> On Mar 31, 2022, at 12:24 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Thu, 2022-03-31 at 16:20 +0000, Chuck Lever III wrote:
>>>>=20
>>>>> On Mar 31, 2022, at 12:15 PM, Trond Myklebust
>>>>> <trondmy@hammerspace.com> wrote:
>>>>>=20
>>>>> Hmm... Here's another thought. What if this were a deferred
>>>>> request
>>>>> that is being replayed after an upcall to mountd or the
>>>>> idmapper?
>>>>> It
>>>>> would mean that the synchronous wait in cache_defer_req()
>>>>> failed,
>>>>> so it
>>>>> is going to be rare, but it could happen on a congested system.
>>>>>=20
>>>>> AFAICS, svc_defer() does _not_ save rqstp->rq_xprt_ctxt, so
>>>>> svc_deferred_recv() won't restore it either.
>>>>=20
>>>> True, but TCP and UDP both use rq_xprt_ctxt, so wouldn't we have
>>>> seen this problem before on a socket transport?
>>>=20
>>> TCP does not set rq_xprt_ctxt, and nobody really uses UDP these
>>> days.
>>>=20
>>>> I need to audit code to see if saving rq_xprt_ctxt in svc_defer()
>>>> is safe and reasonable to do. Maybe Bruce has a thought.
>>>=20
>>> It should be safe for the UDP case, AFAICS. I have no opinion as of
>>> yet
>>> about how safe it is to do with RDMA.
>>=20
>> It's plausible that a deferred request could be replayed, but I don't
>> understand the deferral mechanism enough to know whether the rctxt
>> would be released before the deferred request could be handled. It
>> doesn't look like it would, but I could misunderstand something.
>>=20
>> There's a longstanding testing gap here: None of my test workloads
>> appear to force a request deferral. I don't recall Bruce having
>> such a test either.
>>=20
>> It would be nice if we had something that could force the use of the
>> deferral path, like a command line option for mountd that would cause
>> it to sleep for several seconds before responding to an upcall. It
>> might also be done with the kernel's fault injector.
>=20
> You just need some mechanism that causes svc_get_next_xprt() to set
> rqstp->rq_chandle.thread_wait to the value '0'.

I gotta ask: Why does cache_defer_req() check if thread_wait is zero?
Is there some code in the kernel now that sets it to zero? I see only
these two values:

 784         if (!test_bit(SP_CONGESTED, &pool->sp_flags))
 785                 rqstp->rq_chandle.thread_wait =3D 5*HZ;
 786         else
 787                 rqstp->rq_chandle.thread_wait =3D 1*HZ;


--
Chuck Lever



