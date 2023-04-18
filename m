Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40216E558E
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Apr 2023 02:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjDRAGX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Apr 2023 20:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjDRAGW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Apr 2023 20:06:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378D149DD
        for <linux-nfs@vger.kernel.org>; Mon, 17 Apr 2023 17:06:21 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLTXD8015770;
        Tue, 18 Apr 2023 00:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0PmJubtlWAPSITK/gCE4O1i5twvjmup4qdQbaE70pCY=;
 b=Am3o/rB+419+CLFur1sn3oJaIbZ0x41fumSk9cIUY13FyBLMMAO5VNKUjJ1NvhWe9KT1
 RMMuwjV8qP1c6GVN6+fENRx3DR5ErE+VJb+H7glX3vv1eWdVkW+rJVVnUz1DNKGu/aRB
 Ea4Kx2iNTmhlpjJU9W3/ehHYB3Hrb9TABwRxEQuiegO3cpD+cRHdENtMoarSWWve7IXC
 ui8hr8rq+KkzzfCJGIBht5hN6VN/qhdYJZSyOABnpVCclXMhAhhkOuXUCkI2sj7dj4i/
 9tcGk8A6eltFLweuuiGdwgvwySr/Alj03thks/ClNBoxRt/lquzG6IbLN/28vQV55afm 5g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjuc4ewj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 00:06:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLPpCP030748;
        Tue, 18 Apr 2023 00:06:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc4huut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 00:06:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGfSlG8MSyXVbVaSuPPct0xO2Fn2AFlqKB934iPSd76Rbxl84Jh7OMVPbbvr61D03IjLumE2YNdsTE2iaw+VZtqjDLLDHBi5S+XKvf9PMVYOWEAFwi5Jy1B1pX74hG6vtFN34keRhyKh3OUYEtTgSWIx2cazQzititqGETBn9Z/rfIhV5iD0DdO28K7y+x0h5/hmr2TQxYp0C9tHADslAA1r0lIQvLz2h8gg4QF0EyhWGECCgkewqQ5gCivSwVfvd28VQrikMUF3nhb5i5fUiFGN9VrJKc0JG2QE8X5npT5fMujtK3DlsCYSS4ED/h06kZ1QdvNRE01CMfkjMS9GFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PmJubtlWAPSITK/gCE4O1i5twvjmup4qdQbaE70pCY=;
 b=Yoflbzq7aBFd12AipooTlmhUrh395mzrnFA7TrUXLgLF84/AGJQRy3GN+Za2GYcgIu43ow0JCZKjJX/ekOA2IgcKe45cm8prb4tW5TH4X4YM/jhkiGg5wqP7yDxLYQtT7ebn8gMmutf+OK7vgpecUFB7e8rhUROOdRxbcPRbtf3+qGtWjNpCzfVC+pniH3pBU/JQQCG8a4F8zuVtOaTYTVV0QDDwcHJHwUk8N5BTWji9jZP/ePrbIHy0Ts6ATfwYvM9a1xLFX91A0/nWrrjoHpfeI+4fzzo+q8ludOtf21SQ5kJSaTdKdpQ/AAq7ZmYOybj358L1cMhTfj1mlFOiiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PmJubtlWAPSITK/gCE4O1i5twvjmup4qdQbaE70pCY=;
 b=c8PQAOsluFqCTAbJ6DqotLR89PW5fmvSxcrqF9rAUKutTP9Sgsb8PW5C5AYxSzkFFLmpdy+aDeqGLHYUHJdHuTDmEAOb3jOD6PpkwfQdkVzsWNlvkrpLGRMM0BMwG5rW4p1quG8oe/ZdxfUL0qlrMfm0GGftnzdrnbck4Ru54b0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6046.namprd10.prod.outlook.com (2603:10b6:930:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Tue, 18 Apr
 2023 00:06:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%7]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 00:06:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
Thread-Topic: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
Thread-Index: AQHZacp2wdCHl9MJskyADf2q/cMSEa8wCLYAgAAObICAAAHYgIAAAYOAgAAE5wCAACAlgA==
Date:   Tue, 18 Apr 2023 00:06:12 +0000
Message-ID: <C51D04FF-EB0E-477C-B15A-63C10086AC5D@oracle.com>
References: <1680924600-11171-1-git-send-email-dai.ngo@oracle.com>
 <ed95d6e3da7b2a27a27837f19ca39980037eb28d.camel@hammerspace.com>
 <C7FE1DB9-576A-4463-81BF-E7B1EC266E4F@oracle.com>
 <8723e01c577e257c399e8d3b6e20bca6320964c3.camel@hammerspace.com>
 <B7A330E4-EF62-45B8-BFD4-F1465A934BFD@oracle.com>
 <7b9b5c65b16ee7ff4544ad3a36d7de83e519ba32.camel@hammerspace.com>
In-Reply-To: <7b9b5c65b16ee7ff4544ad3a36d7de83e519ba32.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY5PR10MB6046:EE_
x-ms-office365-filtering-correlation-id: 6be51f80-f11e-4d69-7960-08db3fa0b852
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qon/t9ZG2hEXnpQY7q9cPUKAqreT7B5ziUtJ3RBgectd49eIr9SR1UQ8ORc1S5aXhElsG4yKPBxM0RhspuFDKJJcwm6DTOxRyPLdgF5qMw0G+YncAP0it6czjp+zw22k4OZUwxgYO7aCExF3B4gXJEn0NNsafHtHomvEkNrbhq6+40xpdcYyJixySxldPC3QFnzjQ5XqfIFRlL2SFhryaqWb0ttL6TOmfRWm/9AWXt9KdVFCBw82s1Uw00J03muPtWyUxQmjvLB0TPsdVP7xYYYyrw9aXdJQXIjrY7xRqeqxhcVml4CrYO729CHMd1zyr2clFFx3DYCfjwEXxGpJmDCxo4hjlSkPcErKvNppQrGwXbuFMN8ZI61g1mTVUf/lZrJLPytelzwwFvLjSRsgjNCu3/7x3ljqU371M/rmbIu6K6rZfQ6MyAo8OnvEJquAHT36loVc4xASHChzuyB2zKKSlECaCDOqEhhJ4mT/v/25Cwuyj7F1srOEHE7PAqpJWvoRDcvRIOHezpQ7MtmzMQ7U7NPEB9usvzVAfND4TxifLilVs5qDP/Ot9ZRU7ycD9XQKshT5knorJqehyRNUErjsh4dvWJkujU1M/Am8ZwzF+NOME1cUkWn0sT2odZ0RkdY/Je+kx32n3yu6o8xqlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(2906002)(8676002)(76116006)(33656002)(8936002)(5660300002)(478600001)(41300700001)(91956017)(186003)(316002)(64756008)(66946007)(66556008)(66476007)(36756003)(83380400001)(66446008)(54906003)(4326008)(71200400001)(122000001)(86362001)(38100700002)(38070700005)(26005)(6506007)(53546011)(6512007)(6486002)(2616005)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AHvlN96nfL2u52uM4e8P8xAgKQCI/AYvm7RUbhnM9Fu5fI5/Oo9G+M6hYoEn?=
 =?us-ascii?Q?12P8xY3ZAmD+4Rzk26hxFZf8MWmKGMOtu9351Dqh925spHmXzFEmh1kx4BxT?=
 =?us-ascii?Q?QeM8bmJG+7+snuFNJOlsePd2hs7sWuu86zD4owdfzk/ZujVmQWmvAhnMlm6C?=
 =?us-ascii?Q?lsJkV4dqk8IkzMjUv4YoECKPTiw+36IlVKkPi/PVSo43i+rbwL1ZMXT+EBTU?=
 =?us-ascii?Q?RO2KEP34CD30jmyOFnYVSEAHrGfWCdbF5lbQVbW9e1rqt5xeoQKTfftXSCJq?=
 =?us-ascii?Q?tBDR03nGSZEmP3eot65c3fph0cfWXbtisf7EEtJE0pDm/gzVuUMz3hVClYuk?=
 =?us-ascii?Q?fq2FParR3G1YD6DWHnqLxLhlJqEWqEfFzDNzyBPvV4kADXeuYUy/W6GjUs42?=
 =?us-ascii?Q?tEOkIl0U0b0hmM4WSlCk19px+FKdTkgr1bsIwbTP20luDqR7TXU76nuakSmo?=
 =?us-ascii?Q?7pyBO2dn0CYOPKtmG94CJZrYPMirC7WwrzAwGf6x4jvADIQBJzrob7AF4JzO?=
 =?us-ascii?Q?RfLgZ+ws897wdX73kubMbsIRtnBIPKgxlhqon/aLvhWoyyLk9thGPXcS8RMM?=
 =?us-ascii?Q?4DJK1MmkeoyIFAXFbQ77h5wlnyv2Nh4a6F1xRFtpX3sZZRxDLZmP7I2HvPfW?=
 =?us-ascii?Q?JvZaAh+a0GqgbrC2RP6U75THiWYUsiQFib4aD/8RQN9OZZcvlcbuXF6hrl6O?=
 =?us-ascii?Q?UWTg3fhYaf4aAY1dSRgUyLgMbkWdZMY1OaRvzL9YM+yGNcYlIAWtBi54+t0C?=
 =?us-ascii?Q?yRj97tkRPPScTN02G3R7ZKMb+bdz8yiYw+fCMmDV84kSrhjEMDOFuplxiI55?=
 =?us-ascii?Q?+ZfoyRWecQk7Bn9rl3BTTLft8DfYnw7fZJdE16igypM3W95qSvs1QYlIwllj?=
 =?us-ascii?Q?ICdUKB2Y+X5HOs6oMvSSeH8SmFCN5OkFgM513QKCGv3EKHWXovtg0s8oFb4i?=
 =?us-ascii?Q?2+qAD/xFBRroOBoh4n4caT8ygcKKju71sON5OoV1JwYAJf5ZhcrDG6Y4HGfM?=
 =?us-ascii?Q?RC2Ktabhx0iY8V5IBcxmCFgOSA+lJa8L2dfe6rGiIphR4sTCG9j97UGEhrhq?=
 =?us-ascii?Q?1yVLRYSUp0pTq0sC0LUhQDa0GXS+34dooVwasenuJ2ydZwpqcmLobKz4S8pg?=
 =?us-ascii?Q?BWBpV1S4e//0Pk4hW7Q1oTSlAuYlwziYfI/XUhJxzBZ4sNPLTVpDkKMb1J7l?=
 =?us-ascii?Q?oRd3wTOiMM8RK76Fwo+MsdCFwoxm6g5dxq061/TJrZOwAfsQmTBLf9Ms15TI?=
 =?us-ascii?Q?K4WFfT+EtYIoxM0jo5Cb972MYyysrN0yhq8zKqE4ioYU3BweNY8rL2xtoDCw?=
 =?us-ascii?Q?Hcl0MARGzvIOTjxuCNUsYMRXp7pfYyytJdJCfQ58cFi5Fs/QDHQ4XPqc/coJ?=
 =?us-ascii?Q?pHn7stBZDpysurazmJNPVWMBrZIyg2SR6rLit4Nmn9zGnEkNG9X5/o17HI1v?=
 =?us-ascii?Q?keMo8VnEn83yPzOTVMws+9VOtuMODNVqjN35p7DmFeTyuHaOj64y4Uz4rW9A?=
 =?us-ascii?Q?7zRdJrHUIA+cFbsQVSpIfw+sjtJZkQK0Ef83zCpIqcMqCHCl51lnkBdu4FcJ?=
 =?us-ascii?Q?Sl8G095mufW2XMVBiNiFMpA/dD9o8Wli/nVhn74D+YQxQeb8tfnzv3lx5K0Z?=
 =?us-ascii?Q?NQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DCD19E646428DE42A3AD21AECA7E666B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XCqE8BTexWPN2cnVwXjp3/iRiTVOuui4tONu2Q8ZeAJCtVERz7CNzaw4QaEwfnT7bSkpt8+kdqycV7xkYr5/6ax5v82vf6/vvh1iscbQM2bcEXazKUh+TkXCRxZ9jkpBBpvWayjKqgNAQP4UDh5TeWc/j9W+EMO5XQodv5gpxjawgo1SjI03HUceKnTA3+cfnG0DHYOKnVZSU9bTKZs3/haP1//PQSt4cjU22cSdo5kpNqcbzq3e7ITbHxlOouKnq+ybwSdXrw0nKolWBEM+8hhtBRmZZ8omuvi+mSpbVTSKg53QFig29XHBTZZdfRXMD8lr4ZdcwVKpeLc0/Xk4mfcLdMkUXcDX1UbSWkBpZ19ooMpFgP9o3rS9v+UDeYhXH+vzEOHI6IN3Zq+9ZwgzxwvFFvYbFZzkhQym/L4I4M5dcdPmVkRNrtXleSVyTCWFnnqTAzCs/MakW9X2Ng4aqAd+1DE0ASi0ZZUyHwzA6oVsBEdPcrbpz/apGvs43OjrCTik8gYJras8f7B0BmccDQjiQCjMcOMvpTQzXGCyaOi0HERNgxddHCsJPyVpFQD1ITW9VYujtcFosgAfg05oZMWXsWHfdZAFx2TGhWUcEn0HFZTafusbCo3JUAgP4tOrBxaGs0evehO6lVgDFiRAKjOgIGO/2hYwoUXS1kOrRf4cPG6eHiuj0VjveeWJ7vI1KeKdPUeIE3ueAxV5RO4KxErVhH4+ZOhioGxzMQ0qCOoEf0LxksQIC6gFfhRHSOmDZhKHCMKzemlJTC/zN3AQRKphVmV4hYj47pzHlWNoz/1DHX9w1mtvzPVOf5VyZXHDHK3UCt+cmT0J2Twct5p/ig==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be51f80-f11e-4d69-7960-08db3fa0b852
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 00:06:12.2668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 35/xpaOkS7NNIiCN99gBkgZasNu52riLUV47g2E5DY3GTDTsMPyAo4dl0cNpUY7hwmFR+OtZIeJK1dHSVrMGQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6046
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170212
X-Proofpoint-GUID: aewfqgsmfkiHN-Y4zgchRh_A8aPUvzW8
X-Proofpoint-ORIG-GUID: aewfqgsmfkiHN-Y4zgchRh_A8aPUvzW8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 17, 2023, at 6:10 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2023-04-17 at 21:53 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Apr 17, 2023, at 5:48 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Mon, 2023-04-17 at 21:41 +0000, Chuck Lever III wrote:
>>>>=20
>>>>=20
>>>>> On Apr 17, 2023, at 4:49 PM, Trond Myklebust
>>>>> <trondmy@hammerspace.com> wrote:
>>>>>=20
>>>>> On Fri, 2023-04-07 at 20:30 -0700, Dai Ngo wrote:
>>>>>> Currently call_bind_status places a hard limit of 9 seconds
>>>>>> for
>>>>>> retries
>>>>>> on EACCES error. This limit was done to prevent the RPC
>>>>>> request
>>>>>> from
>>>>>> being retried forever if the remote server has problem and
>>>>>> never
>>>>>> comes
>>>>>> up
>>>>>>=20
>>>>>> However this 9 seconds timeout is too short, comparing to
>>>>>> other
>>>>>> RPC
>>>>>> timeouts which are generally in minutes. This causes
>>>>>> intermittent
>>>>>> failure
>>>>>> with EIO on the client side when there are lots of NLM
>>>>>> activity
>>>>>> and
>>>>>> the
>>>>>> NFS server is restarted.
>>>>>>=20
>>>>>> Instead of removing the max timeout for retry and relying on
>>>>>> the
>>>>>> RPC
>>>>>> timeout mechanism to handle the retry, which can lead to the
>>>>>> RPC
>>>>>> being
>>>>>> retried forever if the remote NLM service fails to come up.
>>>>>> This
>>>>>> patch
>>>>>> simply increases the max timeout of call_bind_status from 9
>>>>>> to 90
>>>>>> seconds
>>>>>> which should allow enough time for NLM to register after a
>>>>>> restart,
>>>>>> and
>>>>>> not retrying forever if there is real problem with the remote
>>>>>> system.
>>>>>>=20
>>>>>> Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock
>>>>>> requests")
>>>>>> Reported-by: Helen Chao <helen.chao@oracle.com>
>>>>>> Tested-by: Helen Chao <helen.chao@oracle.com>
>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>> ---
>>>>>>  include/linux/sunrpc/clnt.h  | 3 +++
>>>>>>  include/linux/sunrpc/sched.h | 4 ++--
>>>>>>  net/sunrpc/clnt.c            | 2 +-
>>>>>>  net/sunrpc/sched.c           | 3 ++-
>>>>>>  4 files changed, 8 insertions(+), 4 deletions(-)
>>>>>>=20
>>>>>> diff --git a/include/linux/sunrpc/clnt.h
>>>>>> b/include/linux/sunrpc/clnt.h
>>>>>> index 770ef2cb5775..81afc5ea2665 100644
>>>>>> --- a/include/linux/sunrpc/clnt.h
>>>>>> +++ b/include/linux/sunrpc/clnt.h
>>>>>> @@ -162,6 +162,9 @@ struct rpc_add_xprt_test {
>>>>>>  #define RPC_CLNT_CREATE_REUSEPORT      (1UL << 11)
>>>>>>  #define RPC_CLNT_CREATE_CONNECTED      (1UL << 12)
>>>>>> =20
>>>>>> +#define        RPC_CLNT_REBIND_DELAY           3
>>>>>> +#define        RPC_CLNT_REBIND_MAX_TIMEOUT     90
>>>>>> +
>>>>>>  struct rpc_clnt *rpc_create(struct rpc_create_args *args);
>>>>>>  struct rpc_clnt        *rpc_bind_new_program(struct rpc_clnt
>>>>>> *,
>>>>>>                                 const struct rpc_program *,
>>>>>> u32);
>>>>>> diff --git a/include/linux/sunrpc/sched.h
>>>>>> b/include/linux/sunrpc/sched.h
>>>>>> index b8ca3ecaf8d7..e9dc142f10bb 100644
>>>>>> --- a/include/linux/sunrpc/sched.h
>>>>>> +++ b/include/linux/sunrpc/sched.h
>>>>>> @@ -90,8 +90,8 @@ struct rpc_task {
>>>>>>  #endif
>>>>>>         unsigned char           tk_priority : 2,/* Task
>>>>>> priority
>>>>>> */
>>>>>>                                 tk_garb_retry : 2,
>>>>>> -                               tk_cred_retry : 2,
>>>>>> -                               tk_rebind_retry : 2;
>>>>>> +                               tk_cred_retry : 2;
>>>>>> +       unsigned char           tk_rebind_retry;
>>>>>>  };
>>>>>> =20
>>>>>>  typedef void                   (*rpc_action)(struct rpc_task
>>>>>> *);
>>>>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>>>>> index fd7e1c630493..222578af6b01 100644
>>>>>> --- a/net/sunrpc/clnt.c
>>>>>> +++ b/net/sunrpc/clnt.c
>>>>>> @@ -2053,7 +2053,7 @@ call_bind_status(struct rpc_task *task)
>>>>>>                 if (task->tk_rebind_retry =3D=3D 0)
>>>>>>                         break;
>>>>>>                 task->tk_rebind_retry--;
>>>>>> -               rpc_delay(task, 3*HZ);
>>>>>> +               rpc_delay(task, RPC_CLNT_REBIND_DELAY * HZ);
>>>>>>                 goto retry_timeout;
>>>>>>         case -ENOBUFS:
>>>>>>                 rpc_delay(task, HZ >> 2);
>>>>>> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>>>>>> index be587a308e05..5c18a35752aa 100644
>>>>>> --- a/net/sunrpc/sched.c
>>>>>> +++ b/net/sunrpc/sched.c
>>>>>> @@ -817,7 +817,8 @@ rpc_init_task_statistics(struct rpc_task
>>>>>> *task)
>>>>>>         /* Initialize retry counters */
>>>>>>         task->tk_garb_retry =3D 2;
>>>>>>         task->tk_cred_retry =3D 2;
>>>>>> -       task->tk_rebind_retry =3D 2;
>>>>>> +       task->tk_rebind_retry =3D RPC_CLNT_REBIND_MAX_TIMEOUT /
>>>>>> +                                     =20
>>>>>> RPC_CLNT_REBIND_DELAY;
>>>>>=20
>>>>> Why not just implement an exponential back off? If the server
>>>>> is
>>>>> slow
>>>>> to come up, then pounding the rpcbind service every 3 seconds
>>>>> isn't
>>>>> going to help.
>>>>=20
>>>> Exponential backoff has the disadvantage that once we've gotten
>>>> to the longer retry times, it's easy for a client to wait quite
>>>> some time before it notices the rebind service is available.
>>>>=20
>>>> But I have to wonder if retrying every 3 seconds is useful if
>>>> the request is going over TCP.
>>>>=20
>>>=20
>>> The problem isn't reliability: this is handling a case where we
>>> _are_
>>> getting a reply from the server, just not one we wanted. EACCES
>>> here
>>> means that the rpcbind server didn't return a valid entry for the
>>> service we requested, presumably because the service hasn't been
>>> registered yet.
>>>=20
>>> So yes, an exponential back off is appropriate here.
>>=20
>> OK, rpcbind is responding, but the registered service is not
>> ready yet.
>>=20
>> But you've missed my point: exponential backoff is not desirable
>> if we want clients to recover quickly from a service restart.
>>=20
>> If we keep the longest retry time short enough to keep recovery
>> responsive, it won't be all that much longer than 3 seconds.
>> Say, it might be 10 seconds, or 15 seconds. I don't see any
>> value in complicating the client's logic for that. Just make
>> RPC_CLNT_REBIND_DELAY longer.
>>=20
>=20
> What's so complicated about exponential back off?

I didn't claim that exponential backoff is /impossibly/
complicated. My point is that it is /unnecessarily/
complicated.

That extra bit of logic there doesn't buy you anything...
and the worst case behavior of exp. backoff is noticeably
worse than a fixed backoff, as Dai has pointed out twice
already.


> delay =3D RPC_CLNT_REBIND_DELAY * (1U << nretries);
>=20
> ...and then limit nretries to take values between 0 and 4. That gives
> you a 93 second total wait, with the largest wait between retries being
> 48 seconds.

48 seconds is actually quite a long time. I know some
customers who would find that amount of recovery time
to be unacceptable.

This is not a hill I care to die on, however. Dai should
implement whatever you prefer. Thanks for your input.


--
Chuck Lever


