Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CD47E8258
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 20:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346101AbjKJTQ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 14:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345693AbjKJTQr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 14:16:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0920B6A4E
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 10:55:14 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAHifH1019404;
        Fri, 10 Nov 2023 18:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=UropmDfow/9pchki4PKiS4yiLnS2QLMCBe/JqWOD3N0=;
 b=0K2jOLLsqs0syvaBtV0KTymJZgfDIWxIqKUedCTbXf3z9+z6RTJHDrGaF01rry5z+OKQ
 vr5ZzzW4YDImfKx3Ge3DwD/qbtj4aPmi9LtlWudw+fduKdOwwh7/tOrr4mXISiOWFuFV
 LihCkiS01aYufSxRsRnIM2kAqFTpg5Sv64aR06TgrMK2aJ+tOFQV1j1YDV4tPEoLBsha
 kUPNHDKIaWWaTyvZ5dTsfz/OFo9u8YPD9E7I9QNRt3fXkK4pkpY4vp2H1FAR3jhlJ8Dl
 i8GFYdiELp5cAvYRpyQDAJjkOWiYF1zSpUapNhKQ0C5J6sbtYqlZ33NUKiUGxmIgN8oq ig== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w236scy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 18:55:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAHVh4N023860;
        Fri, 10 Nov 2023 18:55:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w28g5wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 18:55:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhDatZ7uC27elkwOfd2PnC2+TiC8R8wcMR95Cv61Nvw1vNaB1GyQJju1MmPTlE0FVhmv/xvjuK5LTISyZaxIpOOm+zB+OxV32OdzafZ6LRwB+1dacDUc/R3ERBKTsZh6fbshkLklN/Muz1JifdDEolnnW4Y2QWjxwDTR5X5xHUogqao9xRc+w2I8wyGRZNeQa+G5j6UWQ1bWoc/TOwF8bnc1pmKCdVd2qI1FluisptbiqQeJ9lLdUgi9ZBBfMbGSl3L3ER8ALRIxz7FeBOXlqK6UFqDrkjrlx1K3qNoN4mcyimNwa/50mEDHYCM5Frc7JfYJYUfPvkRFIOhSH1YjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UropmDfow/9pchki4PKiS4yiLnS2QLMCBe/JqWOD3N0=;
 b=N5vw1jBBqARWlyguIYchV2Yydt7e5G4gHJw70WhUzXIL8Pk1KorZlfr4Pc03cdKqGlU3T1qydpInLSQ3NXQL2rBLSZceSv1nP3ehFsAweup4843VIw7J9vr/WVaoRcUjyDzIGk55QxP46GfD2iTeVQqYJyTn3Q2LpQyIF/bVIOmy7jGJtYvjX5dyaWqvb8PeUyAWsEoJKXs8u5DEIj10mKFRHWENqx2kGeimbpSdEURV1NbDWrTbWQZ1fZolf+CId0PJOO0WHDqPPQfYxCastPLfuQNtA1cvTOiRHngARVyAqAh9+bAEV0ZIzO5+Ey5n+qZ7dzfdpQLHaVB7bmsRnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UropmDfow/9pchki4PKiS4yiLnS2QLMCBe/JqWOD3N0=;
 b=T+lXn2YHDWm1J9Jwi/DWascmCFtLONDSwe2fwbnnpKb/O3aqYeF+1ylvat2xYejVZvxWZ9XhXM3DXID7koIGlCJUWa4FxtKxu3pk0Itq60wUDjXSPEfmlOLlOkKxK1vi1cHVzSCbsANpn9gkMSvkIKhT0S+/v3djxX+8RhDd+d8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7314.namprd10.prod.outlook.com (2603:10b6:930:7b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 18:55:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.6977.020; Fri, 10 Nov 2023
 18:55:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Martin Wege <martin.l.wege@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: BUG in exports(5), no example for refer= Re: Examples for refer=
 in /etc/exports?
Thread-Topic: BUG in exports(5), no example for refer= Re: Examples for refer=
 in /etc/exports?
Thread-Index: AQHaDXJPkaKnFSGKLkeVN9xiH7a/Z7ByuFQAgAAI+gCAAALcAIAAGasAgABndgCAAK6dAA==
Date:   Fri, 10 Nov 2023 18:55:09 +0000
Message-ID: <5DA015E1-50C6-4F56-B4E7-62A4BE90DBA4@oracle.com>
References: <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
 <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com>
 <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com>
 <CALXu0Uf2z3um+kh=tgnqskr-ZdY2gU=185K3Amr=F_GJpb2_UQ@mail.gmail.com>
 <FD981B2C-5C24-4349-A279-C70F640C0A01@oracle.com>
 <CANH4o6O=ihW7ENc-BTBXR4d4JL0QJjZa5YdYaKAdoHdq9vwGcA@mail.gmail.com>
In-Reply-To: <CANH4o6O=ihW7ENc-BTBXR4d4JL0QJjZa5YdYaKAdoHdq9vwGcA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB7314:EE_
x-ms-office365-filtering-correlation-id: 75e4ff93-e063-4143-7f56-08dbe21e8fcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dWNrUclgD8Ux03sKqxrPagDuXpr9uh9aKreL3cOlroSIxKBB76i6HHbXu49gSgeL6r12OgqLBcwymzn0Gg9BmOLxipg8jTdHU/pWdAtiHYzmqdeIxUSzfjJZgwdUNn0zdXqH+IVUxerP3fAuAko1liZGE7EYp3ATVnwCbHqVq+ChBG+SEutPx094ntlmZugk/KAdprpjvuAKFWMSVsQOH0g2JCcs3FPpDnJR+xy05rvTFi23qfk2AqyXewj+x9Hswwrao1X+jBsAopgA+RuP2/pjC+mmz4cePinHLXpXJ4r/Ih9/YsdLmci755jigBTzy3HsDOTWOrE7+i3+UAQ2kY5/KSE5NByDGFV0BkKXLHgtuVbiqKTBq0Y35/vOr7OnQBl0jLVwqToRTvrdMP6fYx0bQGLSbNWk7boWtN6jrvHt4DfNwU6cxh6uz29PyX1rmG8CVitJSFeD7JpFW1xGRSASnVMAsoJObmnJ0FaSPwqc8ScoTjsorZJwe1apkJkDbaMEvHCCfrd+Gi7wAC0TN8AnkIrfOLO2kRTwN3tm/Sp3Mol96FB0E95bnKLSTGIL4+cEOaMktlf+XWFPjPrH0aVz1t6WfW5/e24tVW8GxoP32o0rUEFwBCdq54XC2uTvQ1m8fXMjMqnOGTLvCoqxcFt/r3DHdOKyNsVH6kleKvnMlAW79YABFPTfnXnM+0ruCUzWWBZSazmFO6XZjsfvMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(316002)(76116006)(91956017)(6486002)(71200400001)(478600001)(4326008)(8676002)(8936002)(83380400001)(64756008)(53546011)(6506007)(6512007)(5660300002)(2616005)(26005)(66946007)(66446008)(6916009)(66476007)(41300700001)(2906002)(122000001)(86362001)(66556008)(38100700002)(36756003)(33656002)(38070700009)(66899024)(148773002)(45980500001)(47845010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXlpeUNzTU41bGRINVltN0pZd3ZlSW1TSkRPbHpiSzVrY0dXdS9vRi9ub28r?=
 =?utf-8?B?SFV4b1hWdGtaY0l0d0JVOVFUOVFaS25sY0dnT2RyV2l0am01V04xME9uMmdi?=
 =?utf-8?B?UGk4UUdGeVk2Sml6TnlMd05hSWlpb0JXd3BnK2pqWkJFMEhtOFQ0UjlpRE13?=
 =?utf-8?B?c2dSZ2xpdWhiNWpuTFFrcXUzbnRabkJVTjVJQXlBVVRpZGlNZ1Zua2F1U0lU?=
 =?utf-8?B?REd5ZjFkTWxzN0t2c2s5TDBqUUp2MnIwWis0a2ppR2NkMlpnLzI2OXVhSENP?=
 =?utf-8?B?dHNEMWt3MWJZR1pJTXVHZC9xajNUNzFmWElHbVBVN1lXSUtPbFUzcGFGUVFi?=
 =?utf-8?B?dUN3Qng2OGtxaTJVUDNwd0swWTJJaGNwVHd6MVEvZjYrV1dyaC9OWTFSR3Ji?=
 =?utf-8?B?YWxJaVVuSUdUREdXZkwxOVJyL1AvSUVqVStkcGRpT3RESmM1K2NXcXQzVDB6?=
 =?utf-8?B?ZjdaYzk1MGdaYlVkRDR6VHlIWmRFSTRLVjlac0NGdzZDejFrb3VPUnQ1dmQv?=
 =?utf-8?B?dXZoZUh2cnBlakNOd0tQMkN4MkpOM0V6b3JVc2NvOTM3MHJHUCtwL0F0SmFL?=
 =?utf-8?B?MkJyNlJ3am1qQmtrbHN6SUh1YkZnejJUNzhacXFDaGRqNHhNWEppVmN0RER6?=
 =?utf-8?B?YjdjZGVvY3A4VW9sTzlwTnVCUWJuS3JjYjI1Q2t2YzJKZzJaU1JESlhUeTFv?=
 =?utf-8?B?TENKbVFCTDhoMUszYXFOSFhmQjQ0T3FLUGVjdFRLbFVwR2xydmtGaFZPb25G?=
 =?utf-8?B?QzBXM3NIVDBKZHRIRktpS0pGTXlkKzBkRU9GSUtzc2FyQ05lWHFUOWx6dkVM?=
 =?utf-8?B?RnFrbFh2Q3ordnlmd3h1YTZwTnliM2RkUjFUSHdlc1ZsdVJMNjI4ZWY3MTVz?=
 =?utf-8?B?MDcyMHJMaXM1aWZBRVVCTE9NOWxNOUtNM2E3Vy9SNThONkh2Rml5Y1RHOWtV?=
 =?utf-8?B?aEh2dWVuWG1MOENneWhZbytFRWpPc3pDU0VwRU43aEhmQmNHRlE4V0hCYzNW?=
 =?utf-8?B?K2RwdkZtWE9QTnRwcnB1dk5YWWlsb1VVczFtRHhKclNoMk9zbVdnSU5Pa09S?=
 =?utf-8?B?R2ExUTdYeDdOSkcyTzdIQjdmb3FhdWk0SlZBNlRjOGdKbjU3aVJYUjBuYVlu?=
 =?utf-8?B?MjF4NThsWTR4VzR5Q3VNQjdLNDVyT3lNNjJEN2VHeUJUTWdxZ1kxME1LMTRM?=
 =?utf-8?B?VzM4b2F3TkVhVWR5NHZteEVqY2FSeVZzdkxDbURoZ3Y2NmszdEErT0tLcXc2?=
 =?utf-8?B?WGNXcjMzNGhUSzdwVnlONXRwVjZtclNaWVdsSGZxRkEveXlBVi8xbEU5RmtL?=
 =?utf-8?B?SEI0ZkpVOVRYbU1qSVo2UlFFRW80OUxJdTBaa0NHRngwSUk5QnhjYUJBa1Rq?=
 =?utf-8?B?QVVnNmtwaU9ZVFNXZitSaWpIUUFiTVQ2eUJFWnFQNDdRdHZPWlNZazVzZXYv?=
 =?utf-8?B?eVNkdVEwOUJyVjZpWEVqTHNLTTIwcVE5WjR0eEZ1SkxBL01hMWpTazN6aWFL?=
 =?utf-8?B?UlBTeEllQWt1ZUNKMDFybm9JL1kyUFpiRyt2d3ozRStETmMzMmRoODZBVWF1?=
 =?utf-8?B?ZEFrcFhiZlU5YiswVUczNy9tRlp3bmpUbXFPTXd6a29UUXdFc3cxWDVyRlli?=
 =?utf-8?B?bTd5QVppSTF3NWVwM0ovcHptOVpBdTl2NVI4Y09adlBTaVNiZzQ1Wkl1L01U?=
 =?utf-8?B?VGhnWEdNdFB1RTNlY0pyUjBiTldRZXc3VE9JaUNGQm9LNnE1Q1B6OEp3NDdl?=
 =?utf-8?B?NDBQcldNSzU3SjNZRjJHeGpCWHZyempaVmVFYTRJQlM2aVdaWVlrNGJOamJT?=
 =?utf-8?B?eDZNbnRuSG1KL1paRXVIYnNCVVI4aUlEL0tZZ2kwenNFYzFTTkdpVENFTzBN?=
 =?utf-8?B?WktQWGVkOWl2aU05NWg4UkNMd2JPYmVrSmxXYUoxMkhoTEczUVhJelJTNXhE?=
 =?utf-8?B?a0JQc2JkMEVBZjc2cklDVlFmUkEyNHFzQVQ0TEJ4YVB1U3RONjNFNmJvM0I0?=
 =?utf-8?B?cmxlS2NTUzY0bHh1YThMYWNjelFJM09UVnMwRFNzTGEyTmlrbVhoM2psOEp2?=
 =?utf-8?B?R212OENMcU9FWmVEQ3ErZWJJb2tFM3dWcVlaOUFOdzQrR1NlWERWWFp2dHgw?=
 =?utf-8?B?a1NMeHlWK3ZEeURKREpMRU5QakJxVEdhcUZOUjRmRnd4QnErUWtUTFd3eUIv?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <127B4C0DFA2D4348BCD9E59B5BFF6B64@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: D7EJHh1y4c9oeJT4P0km78/4IboWzhpGlViy7clpZltOgBR6+OCEcUuKk9rD1+/J+3ndz5fjpTIByJCNxbvq0XI1U2OkaMqKyPhtftwwVWUWqFt7tM1WVrwvHNivu3YbeI+iWkHX3Ov7ED70ww+oCN25o+qOVdePynKPRL258dHTXew9PPVpURxL8wwPoKPoHx/q3YGuD8L8ZtoFCNtMeHgSe77Cr+yC5mOuxGodj0OMGcUamFsgINj0mkD0Z/qoPWMiCEm5v0Pu6L0OsaCwizRErmW4oMueedmUWoj24100cps/VstJ4XMqHCSLzR75FkDQbXpEAxWlJRZ8HuEvZ2900rNUivF39hbm3tJ/bXBItidWFxevCZxv9Fj9s5F83taAed22XI4noYsUBDht2pH5NW7ytGv5UYxLepcHISqd9Am1u8GkR2+QnlCdwJiBIfMn+EZMYfJbKdC8yGkWUxQfF59Zf4jzmiw1INHo/jp5VTx2UcK9J13MRgbd3GgqZgyninboX80IwG00tYEY4Qvm7OMbJVJcf0uD694SFTc0Xa3f/VD/9CIKofaQjfUypl6NCyHLwWolzvVbmUlKJUh2SZmDz5Xq/Ybb0I5/Tmx2oUCg1YkUmId+RFwxe7xhK5dHug09coPndr9eVdCgNOpontqnLEu/spwDybNSTdFEWytVkhN+yKkhCtSjNFDx0rw/zO0eXH70qyL6gc1mR+jDzdvVSdKzQz4RRFAKM+EG8G5K5BpPni/7OMlb6DP1NMTnOh+1hxDEq3pFlZAQ9q/yDBYJiyTBOyjGgqIawRU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e4ff93-e063-4143-7f56-08dbe21e8fcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 18:55:09.1999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qUExeGgQS+CWPJleqGDJJ1Gn1iiHO9qURfCOvFgr0I5q40hgkBQuYlrkz5YODmXKnN2nQgtMtwMsXSq1/8z97A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_16,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100158
X-Proofpoint-GUID: lUVF6OYIvo_FGUgKotzwJ5EGCs2_m8Du
X-Proofpoint-ORIG-GUID: lUVF6OYIvo_FGUgKotzwJ5EGCs2_m8Du
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTm92IDEwLCAyMDIzLCBhdCAzOjMwIEFNLCBNYXJ0aW4gV2VnZSA8bWFydGluLmwu
d2VnZUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBOb3YgMTAsIDIwMjMgYXQgMzoy
MOKAr0FNIENodWNrIExldmVyIElJSSA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+
PiANCj4+PiBPbiBOb3YgOSwgMjAyMywgYXQgNzo0NyBQTSwgQ2VkcmljIEJsYW5jaGVyIDxjZWRy
aWMuYmxhbmNoZXJAZ21haWwuY29tPiB3cm90ZToNCj4+PiANCj4+PiBPbiBGcmksIDEwIE5vdiAy
MDIzIGF0IDAxOjM3LCBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdy
b3RlOg0KPj4+PiANCj4+Pj4+IE9uIE5vdiA5LCAyMDIzLCBhdCA3OjA1IFBNLCBDZWRyaWMgQmxh
bmNoZXIgPGNlZHJpYy5ibGFuY2hlckBnbWFpbC5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBP
biBUaHUsIDIgTm92IDIwMjMgYXQgMTA6NTEsIENlZHJpYyBCbGFuY2hlciA8Y2VkcmljLmJsYW5j
aGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+Pj4gDQo+Pj4+Pj4gR29vZCBtb3JuaW5nIQ0KPj4+
Pj4+IA0KPj4+Pj4+IERvZXMgYW55b25lIGhhdmUgZXhhbXBsZXMgb2YgaG93IHRvIHVzZSB0aGUg
cmVmZXI9IG9wdGlvbiBpbiAvZXRjL2V4cG9ydHM/DQo+Pj4+PiANCj4+Pj4+IFNob3J0IGFuc3dl
cjoNCj4+Pj4+IFRvIHJlZGlyZWN0IGFuIE5GUyBtb3VudCBmcm9tIGxvY2FsIG1hY2hpbmUgL3Jl
Zi9iYWd1ZXR0ZSB0bw0KPj4+Pj4gL2V4cG9ydC9ob21lL2JhZ3VldHRlIG9uIGhvc3QgMTM0LjQ5
LjIyLjExMSBhZGQgdGhpcyB0byBMaW51eA0KPj4+Pj4gL2V0Yy9leHBvcnRzOg0KPj4+Pj4gDQo+
Pj4+PiAvcmVmICoobm9fcm9vdF9zcXVhc2gscmVmZXI9L2V4cG9ydC9ob21lQDEzNC40OS4yMi4x
MTEpDQo+Pj4+PiANCj4+Pj4+IFRoaXMgaXMgYmFzaWNhbGx5IGFuIGV4cG9ydHMoNSkgbWFucGFn
ZSBidWcsIHdoaWNoIGRvZXMgbm90IHByb3ZpZGUNCj4+Pj4+IEFOWSBleGFtcGxlcy4NCj4+Pj4g
DQo+Pj4+IFRoYXQncyBiZWNhdXNlIHNldHRpbmcgdXAgYSByZWZlcnJhbCB0aGlzIHdheSBpcyBk
ZXByZWNhdGVkLg0KPj4+IA0KPj4+IFdoeSBkaWQgeW91IGRvIHRoYXQ/DQo+PiANCj4+IFRoZSBu
ZnNyZWYgY29tbWFuZCBvbiBMaW51eCBtYXRjaGVzIHRoZSBzYW1lIGNvbW1hbmQgb24gU29sYXJp
cy4NCj4+IA0KPj4gbmZzcmVmIHdhcyBhZGRlZCB5ZWFycyBhZ28gdG8gbWFuYWdlIGp1bmN0aW9u
cywgYXMgcGFydCBvZiBGZWRGUy4NCj4+IFRoZSAicmVmZXI9IiBleHBvcnQgb3B0aW9uIGNhbid0
IGRvIHRoYXQuLi4NCj4gDQo+IFdoZXJlIGluIHRoZSBrZXJuZWwgaXMgdGhlIGNvZGUgZm9yIHRo
ZSByZWZlcj0gb3B0aW9uPyBJJ2QgbGlrZSB0byBnZXQNCj4gc29tZSBvZiBteSBzdHVkZW50cyB0
byBjb250cmlidXRlIHN1cHBvcnQgZm9yIGN1c3RvbSBORlMgcG9ydHMuDQoNCklJUkMgc3VwcG9y
dGluZyBwb3J0cyBpcyBvbmUgdGhpbmcgd2UgY2FuJ3QgZG8gcmlnaHQgbm93IGJlY2F1c2UNCnRo
ZSBtb3VudGQgZG93bmNhbGwgaW50ZXJmYWNlIGlzIHRleHQtYmFzZWQsIGFuZCBpdHMgcGFyc2Vy
IGNhbg0KYmFyZWx5IGhhbmRsZSAicmVmZXI9IiwgbGV0IGFsb25lIHNwZWNpZnlpbmcgYSBwb3J0
Lg0KDQpPdXIgcGxhbiBpcyB0byByZXBsYWNlIHRoZSBtb3VudGQgZG93bmNhbGwgd2l0aCBhIG5l
dGxpbmsgcHJvdG9jb2wNCnRoYXQgTG9yZW56byBpcyB3b3JraW5nIG9uLCBhbmQgdGhlbiBpdCB3
b3VsZCBiZSB2ZXJ5IHN0cmFpZ2h0Zm9yd2FyZA0KdG8gYWRkIGEgcG9ydCB0byBlYWNoIHRhcmdl
dCBsb2NhdGlvbi4gQnV0IGdldHRpbmcgdG8gYSBtYXR1cmUNCm5ldGxpbmsgaW1wbGVtZW50YXRp
b24gd2lsbCB0YWtlIGEgd2hpbGUuDQoNCg0KPiBJIHdvdWxkIHNlcmlvdXNseSBzdWdnZXN0IGtl
ZXBpbmcgaXQgZm9yICJzaW1wbGUiIHVzZSBjYXNlcy4NCg0KV2UgZG9uJ3QgaGF2ZSBhbnkgc3Bl
Y2lmaWMgcGxhbiB0byByZW1vdmUgc3VwcG9ydCBmb3IgdGhlDQpyZWZlcj0vcmVwbGljYT0gZXhw
b3J0IG9wdGlvbnMuIERlcHJlY2F0ZWQgKG5vdCAiZGVwcmVjaWF0ZWQiKQ0Kc2ltcGx5IG1lYW5z
IHdlIGFyZSBpbiB0aGUgcHJvY2VzcyBvZiBtb3ZpbmcgdG8gc29tZXRoaW5nIGJldHRlcg0KZm9y
IGV2ZXJ5b25lLiBTbyBkb24ndCBidWlsZCBvbiB0aGUgb2xkIHN0dWZmLg0KDQpIb3dldmVyIG5l
aXRoZXIgeW91IG5vciBDZWRyaWMgaGF2ZSBnaXZlbiBhIGNsZWFyIHJlYXNvbiB3aHkNCnlvdSBj
YW4ndCB1c2UgbmZzcmVmIG90aGVyIHRoYW4gIkRlYmlhbiB3b24ndCBidWlsZCBpdCBmb3INCnVz
Ii4NCg0KDQo+IG5mc3JlZig4KSBoYXMgWkVSTyBkZXBsb3ltZW50IG91dHNpZGUgUkhFTCZSSEVM
IGNsb25lcw0KDQpOb3QgYW55dGhpbmcgdXBzdHJlYW0gY2FuIGNvbnRyb2wuIFdlIGNhbiBoZWxw
IERlYmlhbiB3aXRoDQpwYWNrYWdpbmcgY29uY2VybnMsIGJ1dCB0aGV5IGhhdmVuJ3QgYnJvdWdo
dCBhbnkgdG8gdXMuDQoNCg0KPj4gYW5kIEZlZEZTIGhhcyBnb25lDQo+PiB0aGUgd2F5IG9mIHRo
ZSBkb2RvLg0KPiANCj4gV2h5IGRpZCB0aGF0IGhhcHBlbj8gOygNCg0KQ29tcGxpY2F0ZWQgdG8g
c2V0IHVwIChiZWNhdXNlIHRydWUgRmVkRlMgcmVxdWlyZXMgTERBUCkgYW5kIG5vDQppbnRlcmVz
dCBmcm9tIHRoZSB1c2VyIGNvbW11bml0eS4gcE5GUyBjb3ZlcnMgdGhlIHVzZSBjYXNlcyBmb3IN
CnJlZmVycmFscyBhcyBmYXIgYXMgcGVvcGxlIGhhdmUgbmVlZGVkIGl0IHRvLiBUaGVyZSBoYXMg
YmVlbiBubw0KZGVtYW5kIGZvciBpdC4NCg0KUGxlYXNlIGRvIG5vdCBjb25mdXNlIEZlZEZTIHdp
dGggc3VwcG9ydCBmb3IgcmVmZXJyYWxzIGFuZA0KcmVwbGljYXMgaW4gdGhlIE5GU3Y0IHByb3Rv
Y29sLiBUaGUgbGF0dGVyIGFyZSBub3QgZ29pbmcNCmFueXdoZXJlLg0KDQoNCj4+PiBUaGUgY29u
ZmlndXJlIHN3aXRjaCBpbiBuZnMtdXRpbHMgdG8gYnVpbGQgaXQgaXMgT0ZGIGJ5IGRlZmF1bHQs
DQo+PiANCj4+IFlvdSdyZSB0YWxraW5nIGFib3V0DQo+PiANCj4+ICAtLWVuYWJsZS1qdW5jdGlv
biAgICAgICBlbmFibGUgc3VwcG9ydCBmb3IgTkZTIGp1bmN0aW9ucyBbZGVmYXVsdD1ub10NCj4+
IA0KPj4gUGVyaGFwcyB0aGF0IGRlZmF1bHQgc2hvdWxkIGNoYW5nZSAtLSBpdCdzIGJlZW4gcGFy
dCBvZg0KPj4gbmZzLXV0aWxzIGZvciBmaXZlIHllYXJzIG5vdy4gSG93ZXZlciwgdGhhdCBkcmFn
cyBpbg0KPj4gZGVwZW5kZW5jaWVzIGZvciB0aGUgeG1sIGxpYnJhcmllcy4uLiBtYXliZSBzb21l
b25lIHRoaW5rcw0KPj4gdGhhdCdzIGEgaGF6YXJkPw0KPiANCj4gSSB3b3VsZCBjb25zaWRlciBp
dCBhIGhhemFyZCB3aGVuIHRoZSBrZXJuZWwgc3VwcG9ydCBjb2RlIGRyYWdzIGluIFhNTC4NCg0K
Q2FuIHlvdSBiYWNrIHVwIHRoYXQgb3BpbmlvbiB3aXRoIHNvbWUgdGVjaG5pY2FsIGZhY3RzIGFz
IHRvDQp3aHkgYW4gbmZzLXV0aWxzIFhNTCBkZXBlbmRlbmN5IGlzIGEgcHJvYmxlbT8NCg0KDQo+
Pj4gYW5kIHRoZQ0KPj4+IGRpc3RyaWJ1dGlvbiBtYWludGFpbmVycyByZWZ1c2UgdG8gZW5hYmxl
IGl0IGJlY2F1c2UgaXQgY2FuIGJlDQo+Pj4gImRhbmdlcm91cyIsIG9yIG1heSBiZSAiZXhwZXJp
bWVudGFsIi4gSSBnb3QgbWFueSBleGN1c2VzIHdoeSB0aGV5DQo+Pj4gZG9udCB3YW50IHRvIGVu
YWJsZSB0aGF0IGRhbW4gY29uZmlndXJlIG9wdGlvbi4NCj4+PiANCj4+PiBBbHNvLCBzdGFibGUg
YW5kIG9sZHN0YWJsZSBEZWJpYW4gZG8gbm90IGhhdmUgaXQgZW5hYmxlZCBlaXRoZXIuDQo+PiAN
Cj4+IFRoaXMgaXMgYW4gdXBzdHJlYW0gbWFpbGluZyBsaXN0LiBXZSBjYW4ndCBhbnN3ZXIgZm9y
IHdoYXQNCj4+IExpbnV4IGRpc3RyaWJ1dG9ycyBkZWNpZGUgdG8gZW5hYmxlIG9yIG5vdC4NCj4+
IA0KPj4gSSd2ZSBuZXZlciBoZWFyZCB0aGF0IGl0IHdhcyBhIGRhbmdlcm91cyBmZWF0dXJlLiBJ
ZiBhDQo+PiBkaXN0cm8gbWFpbnRhaW5lciBoYXMgYSBjb25jZXJuLCB0aGV5IHNob3VsZCBicmlu
ZyBpdCB0bw0KPj4gdXBzdHJlYW0uDQo+PiANCj4+IA0KPj4+IFNlcmlvdXNseSwgd2h5IHdhcyBy
ZWZlcj0gaW4gZXhwb3J0cyg1KSBkZXByZWNpYXRlZD8gVGhlcmUgaXMgbm8NCj4+PiByZWFsaXN0
aWMgcmVwbGFjZW1lbnQsIHVubGVzcyB5b3UgZml4IGV2ZXJ5IGRhbW4gTGludXggZGlzdHJvIGZp
cnN0Lg0KPj4gDQo+PiBBZ2FpbiwgYWxsIHRoZSBSSEVMIGJhc2VkIGRpc3Ryb3MgcGFja2FnZSBu
ZnNyZWYsIGFzIGZhcg0KPj4gYXMgSSBhbSBhd2FyZS4gQW5kIGFzIHlvdSBmb3VuZCwgcmVmZXI9
IHN0aWxsIHdvcmtzLiBJdCdzDQo+PiBzaW1wbHkgbm90IGRvY3VtZW50ZWQuDQo+IA0KPiBUaGVu
IHBsZWFzZSBkb2N1bWVudCBpdC4gWW91IGhhdmUgcmVhbCB3b3JsZCB1c2VycyBmb3IgdGhhdCBv
bmUsIHdobw0KPiB3b3VsZCBiZSBncmF0ZWZ1bCBpZiB5b3UgZG9uJ3QgcHVsbCBhd2F5IHRoZSBm
bG9vciB1bmRlciB0aGVpciBmZWV0Lg0KDQpMZXQgbWUgdW5kZXJzY29yZSB0aGlzOiB3ZSdyZSBu
b3QgcmVtb3ZpbmcgdGhlIHJlZmVycmFsIGNhcGFiaWxpdHkNCmZyb20gdGhlIGtlcm5lbC4gTm8g
b25lJ3MgZmVldCBhcmUgZ29pbmcgYW55d2hlcmUuDQoNClRoZSBhZG1pbmlzdHJhdGl2ZSBpbnRl
cmZhY2UgZm9yIHRoaXMgbWVjaGFuaXNtIGlzIGdvaW5nIHRvIGNoYW5nZQ0KYXQgc29tZSBwb2lu
dC4gSXQncyBzaW1wbHkgdGFrZW4gbXVjaCBsb25nZXIgdGhhbiBhbnRpY2lwYXRlZC4NCg0KQW5k
IGFnYWluLCB5b3UgYXJlIHdlbGNvbWUgdG8gY29udHJpYnV0ZSBwYXRjaGVzIGZvciB0aGUgbWFu
DQpwYWdlLiBUaGF0J3Mga2luZCBvZiB0aGUgcG9pbnQgb2Ygb3BlbiBzb3VyY2UuIFlvdSBkb24n
dCBnbw0KYXJvdW5kIGRlbWFuZGluZyBzdXBwb3J0IGZvciB5YWRhIG9yIHVwZGF0ZXMgZm9yIHN1
Y2gtYW5kLXN1Y2gNCm1hbiBwYWdlLiBZb3UgY29udHJpYnV0ZSB0aGVtIHlvdXJzZWxmIGlmIHRo
ZXkgYXJlIG1pc3NpbmcuDQoNCg0KPj4gSWYgeW91ciBkaXN0cm8gaGFzIGRlY2lkZWQgbm90IHRv
IHN1cHBvcnQgcmVmZXJyYWxzLCB0aGVyZSdzDQo+PiBub3QgbXVjaCB3ZSBjYW4gZG8gYWJvdXQg
dGhhdCBleGNlcHQgZ2VudGx5IHN1Z2dlc3QgdGhhdCB5b3UNCj4+IHN3aXRjaCB0byBhIGRpc3Ry
byB0aGF0IHByb3Blcmx5IHN1cHBvcnRzIHRoZW0uDQo+IA0KPiBZb3UgY291bGQgdHVybiBvbiAt
LWVuYWJsZS1qdW5jdGlvbnMgYnkgZGVmYXVsdC4gQW5kIG1heWJlIGdldCByaWQgb2YNCj4gdGhl
IFhNTCBkZXBlbmRlbmNpZXMuDQoNCkl0J3Mgbm90IGVhc3kgdG8gZ2V0IHJpZCBvZiB0aGUgWE1M
IGxpYnJhcnkgZGVwZW5kZW5jaWVzDQpiZWNhdXNlIHRoZSBqdW5jdGlvbiBpbmZvcm1hdGlvbiBz
dG9yZWQgaW4gdGhlDQp0cnVzdGVkLmp1bmN0aW9uLm5mcyB4YXR0ciBpcyBzdG9yZWQgaW4gYW4g
WE1MIGJ5dGUgc3RyZWFtLg0KDQpUbyByZXBsYWNlIFhNTCBpdHNlbGYsIHdlJ2QgbmVlZCB0byBl
aXRoZXIgaW52ZW50IGEgcHJpdmF0ZQ0Kc2VyaWFsaXphdGlvbiBmb3JtYXQgZm9yIHRoZSBqdW5j
dGlvbiBpbmZvcm1hdGlvbiwgb3IgZ28gd2l0aA0Kc29tZXRoaW5nIGVsc2UgdGhhdCBhZGRzIGEg
bGlicmFyeSBkZXBlbmRlbmN5LCBsaWtlIEpTT04gb3INCnlhbWwuIEkgZG9uJ3Qgc2VlIGhvdyB0
aGF0IGlzIGEgd2luLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==
