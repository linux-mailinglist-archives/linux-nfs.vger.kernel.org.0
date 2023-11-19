Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484607F086A
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 20:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjKSTMk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 14:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSTMj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 14:12:39 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0012F2
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 11:12:35 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJGuBjf027853;
        Sun, 19 Nov 2023 19:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=BLwDDPYCernNemOc762p0f5ZIx4AGX7y2ua0Cw4UkU0=;
 b=UhP0a75Z6j0352NMqUYOeQkdSTgzUvPsmxcD/xVXSJNekCF43r962gQ2PZuwLg1V3wat
 zWYa5EKJFDAjjWeRFssx9lWgaaNjV8sSi1uItgspj811NblT8I9SWUFEbnIPCjQeA5kj
 bYpmkrsLKy+DN/pXQkVmNOuDcetKdBTnTgu2NkOx1TKvhdQL8Xef9AVFliI5QchX+uz6
 /Ri2ElYXYAKZizqZPHOtO/VsmL4hSn3JJkUr2ESDE2Dzp+Km7Dgub2JYXz3cb6t2wW/a
 /+ZSIhW9xYdyhyEth/QXDLNQ5Wmw4IgL+zxQNovr3bAQOuz7s1PkPd+dCOAOjbabNn1V 7w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uen5b9e3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Nov 2023 19:12:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJHpuCJ002412;
        Sun, 19 Nov 2023 19:12:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq4gsdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Nov 2023 19:12:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enKIA2ZmWHP7gnVAFosbKyFWY+2J6+k0AJtCjauxXKzGPWE5WVg9PGM0SDqOVuyBNVy1rusI+STNc8STwmVSOPmsjk0S+9UrlwtVIOz1CBTq6iZAa760jwCp4BDWlX+MY1Fv1tfNExsUJ/bStkJ7WjfJfE1CjqaNLadkUKrsQZEqhzSbQFPCA8Xv2C4bsqxTU5fVKJCt8lleRd0teyWbl8dPGCwgQ9ZK5DgNTmEDVl45OMFMKcbA14azIK4azMlMWrt9Le3C9HhVWsnH3IxT7RP3VyJimykBLiRuAkF8OZowYmFu9B35S2I831IGqb7mTfgQd1lOG2p3I19+J5VNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLwDDPYCernNemOc762p0f5ZIx4AGX7y2ua0Cw4UkU0=;
 b=X5+ZD4dQ260zLwVON/or9vcSFxLlh3W9FF0t7rjVgX0EStDlp61sfQYvFhjbSprIAyN5/NsJCyCJC6ua54we7kxXLs/zWgCaCM+L6CRJeRUhZfzWzm4JnlQ4UeDXR4s6cqYN0/P5ciAE6hvPig3YfnqRFnY5FfZq2nTTrMqepLnln0mM82xWr3bc9cQ5U10KBNlR3Wk6TAk63IphKh/cdheLknLDhEAIQRqTyo3u+31tcbPk3qYTmBE8xLpWYaKnHshAXftWQ9jvYlyST+B/8yIsw7fsQvnf+3Mvro2iUAOki1xlfjs+M8oJUumENSNEJwLHkgGT1USm0nH1TJ8Dpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLwDDPYCernNemOc762p0f5ZIx4AGX7y2ua0Cw4UkU0=;
 b=f3BjOvc/BFw8tCQ09eEniMYGS8h0PycDZlDwX9PVKjYz5ykUGJiBVOsmawGiiQRWj+yRZiAeXS8Y8VO2tv1fa4BEd59gn8wV9RHnqBSHqajxK5SscnHikyF1yFvUHYqnbCfIEkqQeG7YhUX/fb076e/um9VOCKD7bi5Fhmy3zdU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5294.namprd10.prod.outlook.com (2603:10b6:5:3b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Sun, 19 Nov
 2023 19:12:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.027; Sun, 19 Nov 2023
 19:12:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Martin Wege <martin.l.wege@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: altruistic company who can save linux-nfs.org? Re: Who owns
 bugzilla.linux-nfs.org - account creation broken? Re: How owns
 bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way to define
 custom (non-2049) port numbers for referrals
Thread-Topic: altruistic company who can save linux-nfs.org? Re: Who owns
 bugzilla.linux-nfs.org - account creation broken? Re: How owns
 bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way to define
 custom (non-2049) port numbers for referrals
Thread-Index: AQHaGSnEPMpWeNwF5UG1EZJYD3+ecbB/omOAgACniYCAAAIOAIAAA+qAgAAQ6ICAAAhigIABH1EAgAB9z4A=
Date:   Sun, 19 Nov 2023 19:12:30 +0000
Message-ID: <391FC5F3-2F63-4722-9A61-43AA735695F3@oracle.com>
References: <bug-218138-226593@https.bugzilla.kernel.org/>
 <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
 <CALXu0Ucz2MGCYdMw74ZKGUj_hpGcLP-pxC=MSgpUFGU58=jc=g@mail.gmail.com>
 <CALXu0UdY=ZgcAqvC6Y-X6htxPQ9=XWemt8V4dxTA99wQmHKz=w@mail.gmail.com>
 <959BB15F-5B91-4413-BCFC-EDAC78EE32F6@oracle.com>
 <d8bb0bf43c8fe38ef83248fb55a9549919530cf2.camel@hammerspace.com>
 <095736A1-C749-4B8C-900C-C0471D8F8422@oracle.com>
 <c762fb4fd6e3c529e75541d6944a187a357578c9.camel@hammerspace.com>
 <3D231C38-BA1A-4549-8788-D049CF3467A4@oracle.com>
 <CANH4o6O-02vK1or+njpz2t8m7wDkpszhUqD5EP-yOe4XYyCbQw@mail.gmail.com>
In-Reply-To: <CANH4o6O-02vK1or+njpz2t8m7wDkpszhUqD5EP-yOe4XYyCbQw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5294:EE_
x-ms-office365-filtering-correlation-id: ca9c43b9-b847-49c0-300d-08dbe93379e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MLyEgbXQ7Nex0eBcrepc22row3HPuhLdxZZzKs75+Jz80Mzw8wKm7xnU1rQ6Qg+rrUIemn0+stkopMKGOX6FXSLIMjMbgEA4A/NqQ3NbmAoO2xbMLWS8/i1ZKVecSJP0OfEmSa065/3xiPnXhIgbMN5ZcV3Dx7pqb77iSR+XetNyjjrbZ8pX8ry84/QSqxdwYPqS+55t4oK3R4fJlWQgx9dWYvgEAT5zmIwNj8hmslDoO1FRRPUBr3FBlgQP/TS/2+BJEHtOnqd02FXUBtzliUSwqzCGm5vG46QLilFNhwNsmKQhdBPUVwYEbOFaha0OTL//l3cIyVk6R7EUew2RUZpB2MfVO9O3/Lx8BkjMWHNUxjt3OsgP+9HbI0gTiUy+j+uvpCWM1HKyibS9g5WE9g4nYQXcZXrIo5KAn6klpH2scR9dq6UynzWBRvKgbGgcywQYl8HCwpt52eR8/NpEKpjFQHrSwaTGGpVLdXeYKEjjyrXAFcrI1CaXepKBO2r//TjMx1zHvhFUvXyRiXgZBVxlODJ51HdBLnEgmvPVdHHeYnVIIJ3z6MYijWNWTNrSHzgaQeyZujDjUsn2VVztE+/Tk2b6egbNUDvCNu/bxu+/cFzSb5usY4254k8MXW4zw+IZdugKo0dGfMwnAGyKhBWwIlgeas/0Rjt2PGA6bFRbqZTz1ahSh1ApCrjRwqvgAGSo/Or2lBBHiIiOvt+GUFuB7C6QWLMGwvifIONCMY8Ghx+pONXMvCil5aTwFDNw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(230173577357003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(66476007)(66446008)(66556008)(66946007)(110136005)(91956017)(76116006)(64756008)(316002)(53546011)(6512007)(36756003)(71200400001)(2616005)(6506007)(478600001)(38070700009)(6486002)(26005)(38100700002)(122000001)(83380400001)(33656002)(86362001)(4001150100001)(2906002)(5660300002)(15650500001)(4326008)(8676002)(8936002)(41300700001)(72063004)(219693005)(43043002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG1kTUVwVGx6VmpRL0w0bXU3bWo4eFUzMVlaSm1kekFDbk1RbmIyOXQwdWp4?=
 =?utf-8?B?SUFYaStJQ3dEbU5LUDhnRHpHOUtWYzhaTmFBLzFudW95TTdEL053bzYwZ2J6?=
 =?utf-8?B?U1hEVTBtV0RnZXM4ZVkzQ0FJRjl0bFduSjB5dlFGRzZEa2xOZUZacklMeDNN?=
 =?utf-8?B?ck0vaHV5eTBLMnlMQjhhay8yWFh4UEpEVTlaOVZTZS9VVHZPK3M1bXRFR0xr?=
 =?utf-8?B?R0dUak9mYUdIZnpRdWtJa2Q3RHlCNDQrbC82eVJXYWhRTTd3MlFRMzg2Q3Zs?=
 =?utf-8?B?b1hiYXdQeWExc1czbGVoNUE0ak12QnRodG00NEtMOG5uTjB2UUI3K1Zvc1NL?=
 =?utf-8?B?b05oNURLUWxEVlZqdG9SbEE0aVd6Nm41ZUxLNENOZHFUdnNaWUdLOFBQVzR0?=
 =?utf-8?B?bXFGRzJPbG9LZjVNZUVodkxsTDcvdnpTSXJTTVVCRDBacGZERzRJaDRGa1hz?=
 =?utf-8?B?WFlpbFowdU5Kd2xUdWo3L1E2Znd3aWZkUVZSZzBSZTBOODBIek1ZNkdMK2Ry?=
 =?utf-8?B?S1FUamgwTURsOVJyS04vc1ovSmJjVlpXMEZZQkJoUXpwbnFyNTc3bEs4amlG?=
 =?utf-8?B?WStPYW9nNVdKcndsMkMzVGRrQWFGS0t2b3ZhT1ZZRmdmNUZ2YnN0UGRPbkVC?=
 =?utf-8?B?dWFVRWlmSmdpMWhsZHR5d1NWaVlvZ09ueXhXa2tJZ0M0ai9ZK3B4WWF1emMv?=
 =?utf-8?B?MlFDOHQ0UjZsemt2b0NONmJEMDZZdHFZbEdhUStFK0FRNDEyc0hJWmxqbnRI?=
 =?utf-8?B?VFZIVlh6aVRpR3pHKzUvVjRFbVE4UTdzelNNVDRJUW9ZTWhhMVNtYW9vTHM1?=
 =?utf-8?B?aWZVQnR6TElKSW1TVkd5WkJxVkVHeVJ4TDdvZ3FLdjRIVkdoeWxaT1pJdzhU?=
 =?utf-8?B?cnRleWp1aXhJOW5QSlZkamN2NXNTUzlvdFFiNmtsSlpVc0pOSG9IZ2NneTdZ?=
 =?utf-8?B?Q09zUzVaOThPTTdmZ2ljSUxLSHhmVElYSkVybjdqZkN3cGVUNXZyejgzSGZq?=
 =?utf-8?B?RDByT2JDakt5NGwvTWdCU2lYUmtqc21zU1FTeUxQcHZnaDZxa2JObXArYXhG?=
 =?utf-8?B?bEFFMFJHZ0VMeFZXaUR1ejF5eFVrSWRlN2lIVE5HektnRkFLTnRpdGdFMlUx?=
 =?utf-8?B?Zi9TcWNXQzZ3aHkyUHVId3lra3FKZ3pCeU43Und4MFllYUNhRnVucndKcXVW?=
 =?utf-8?B?QWFjYXAwOVlHaUJuRnVxam1TVHBnTkdkN0lYNVJwczJlWjJGSkFQeG9iSDlK?=
 =?utf-8?B?em1LUEJiaXJoQUFYNDBXRXNpdVBCbnhOWjllL3RhY0xmSFVGWUUrdS9nbGRj?=
 =?utf-8?B?UUNyWUliNGNQOGxnRWpGaUdZK05NU2R6MkZJK0ZoVENseVIzayswTkpFS3h1?=
 =?utf-8?B?ZWkwY1V4RXVEZk54YkRLZlFqc1ZSdVl5bFMyTWRBNHlUVGRJZzdoVnJxTWNa?=
 =?utf-8?B?VUhHK2Qvdk4zSUFKQ09UTFZUUCtJTTArRGVwK2VBb3VROUZqMzFLR3ZkVlR6?=
 =?utf-8?B?bzU1NXhlaS84ZjcrR21qd2E4VmIvVUZQRDJvRDk1U09KZGF6dUl3dnA1VDZ3?=
 =?utf-8?B?WmZVYllqSzZBaDBodVhGNGFTeU05RklCVS9zd3ZZYU5iQ1Q3T1hPSDBHOWo1?=
 =?utf-8?B?b1NjV0pzN1FFankvaEZqdHJ0TW5iWERxdWRVTURJbXlzRFlpSHNSLzBGVk9j?=
 =?utf-8?B?TkFoekNoaGxmc0hobGIyU3JMU0JmUGd0SEUwcno3alpmQVhXTXg3S25LdjdW?=
 =?utf-8?B?QzBrNWo5MG9McDFjZzI2WHZzWFhwY1RLcXdZUlZ0VXlGU2MzeEtGS1VyS29x?=
 =?utf-8?B?WGZLWThpdGd2cThIWVAzMFJIS21kMCs3K1FOdFErNmpyb0Rxa0EvMzN3aEJ0?=
 =?utf-8?B?QkVVbFJQSlJCUDVnZDUzZUJCaTBqbER0YzNyZ2ZFN2RwaE9wZk40NktIVFVD?=
 =?utf-8?B?VCtvcTF4RlhzN0hPZjRyNDJLcElFUXdGd1hyMHZ4VlI1U1NxbFMxUjREZXYw?=
 =?utf-8?B?Q2ZiTERjV3FwamV0SWxjOVdkeDN3ek5VM2NQZ0EveXVnYUp4ZmFJdFRFUVBw?=
 =?utf-8?B?SlBNemhZQUJ1STcvdGhiT0xaZUJ4T25oT1Fqcm1KY2NyRkNsZ1Bpci9YcDdj?=
 =?utf-8?B?WkhVNUdxOE56ZUxnaUpXcVlyMFo2L2JiL1pmQkJnSGpLM3NkSWtiY2ZwbVpV?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D36E119027B41249A4609E5A4837F449@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vE0VWho1kHsMDGFjAWatndKik9v8I8fKEoQgNezhRh21PpgTII5vbd2ZamZo3CCnn5UQh4eNfXOcHxFDUqCFjxqbuHcXocyuXO8xUD4WZgUs7S6I4Xhfp1Lqn4rsNx7Yxs5pHLGZumb1s1NYdmp1hEwRf4WYz5vRQW7t66FHH+OlUrwXu+1fs0sfNl824JEhSTVcbbSwwGAxScLADpjXgGlXtOqw1sIBUM4q+r9ldbw+tVSuQkoJYEuQ4sBm/7f5ZFqmmHdal3baNoJ8GWQ+VNe1h4/ACBy3mL4CvbdqWRaoOhu+J76t/bpfP/0QsMhuBySkouZsnxa/KlvGBEGWvDQ2Zr/Wiap8WaEhxk0NdSmFYD+LvOkoeE+p+76y/vz5mL9e73f4RNAZFc1SsvunBvLIERt0LgfxkcSAe6Fx9a1FeGAqSR7p0T9iC1+EXQM2UefxnNP4Iol4UoW4cfgOmTSOGhZZr7Y2ydSsHu2krbN1emmCyhoAYI8uf2Fx4vYD9zfXtgd2v50dTadTC9bqCXdOkp6kJLdPO+v0Al5Edw9lfL12497/4x7gEEMS17ubqsjSriUc6lNAqp71oQlPjx08P6GnAWOecx9uAAqjsFjX9O1kDvVUUyr7PA3G7829/toOQNJYu0ZA2cp2hAY5y3+7VKeP/Y6FfVQKxy2mX52qdjWADZaDm/c1UtWETzI/Sx0nYUyLMCo1Y2aDLsh/tyPJfn9hISG/si5a70vQCbOEKFAxj0bWpaf6tdYykUPFKTBbc7wPKDLyBiv9fbDSN4RDyAM4MMJdjEyyW1GOn2jsapuzWRhWsxNanfr9XgTyrilRTfuJlEfTBbQv5e2/hw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9c43b9-b847-49c0-300d-08dbe93379e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2023 19:12:30.0158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4zDSTooizs6VjDi9tlKOQiDXqk3iUaZ6D4rxVAsPPh3dgldBeJq/aeiPR969cxBkjeWlOo/0f17c4p4lLuow/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_18,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311190146
X-Proofpoint-GUID: zFn1XaDZtJV2g9IhG62eY_RAUiSkj_Kk
X-Proofpoint-ORIG-GUID: zFn1XaDZtJV2g9IhG62eY_RAUiSkj_Kk
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTm92IDE5LCAyMDIzLCBhdCA2OjQy4oCvQU0sIE1hcnRpbiBXZWdlIDxtYXJ0aW4u
bC53ZWdlQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBTYXQsIE5vdiAxOCwgMjAyMyBhdCA3
OjM24oCvUE0gQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToN
Cj4+IA0KPj4gDQo+PiANCj4+PiBPbiBOb3YgMTgsIDIwMjMsIGF0IDE6MDPigK9QTSwgVHJvbmQg
TXlrbGVidXN0IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24g
U2F0LCAyMDIzLTExLTE4IGF0IDE3OjAzICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+
Pj4+IA0KPj4+Pj4gT24gTm92IDE4LCAyMDIzLCBhdCAxMTo0OeKAr0FNLCBUcm9uZCBNeWtsZWJ1
c3QNCj4+Pj4+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+
IE9uIFNhdCwgMjAyMy0xMS0xOCBhdCAxNjo0MSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3Rl
Og0KPj4+Pj4+IA0KPj4+Pj4+PiBPbiBOb3YgMTgsIDIwMjMsIGF0IDE6NDLigK9BTSwgQ2Vkcmlj
IEJsYW5jaGVyDQo+Pj4+Pj4+IDxjZWRyaWMuYmxhbmNoZXJAZ21haWwuY29tPiB3cm90ZToNCj4+
Pj4+Pj4gDQo+Pj4+Pj4+IE9uIEZyaSwgMTcgTm92IDIwMjMgYXQgMDg6NDIsIENlZHJpYyBCbGFu
Y2hlcg0KPj4+Pj4+PiA8Y2VkcmljLmJsYW5jaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+
PiANCj4+Pj4+Pj4+IEhvdyBvd25zIGJ1Z3ppbGxhLmxpbnV4LW5mcy5vcmc/DQo+Pj4+Pj4+IA0K
Pj4+Pj4+PiBBcG9sb2dpZXMgZm9yIHRoZSB0eXBlLCBpdCBzaG91bGQgYmUgIndobyIsIG5vdCAi
aG93Ii4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IEJ1dCB0aGUgcHJvYmxlbSByZW1haW5zLCBJIHN0aWxs
IGRpZCBub3QgZ2V0IGFuIGFjY291bnQNCj4+Pj4+Pj4gY3JlYXRpb24NCj4+Pj4+Pj4gdG9rZW4N
Cj4+Pj4+Pj4gdmlhIGVtYWlsIGZvciAqQU5ZKiBvZiBteSBlbWFpbCBhZGRyZXNzZXMuIEl0IGFw
cGVhcnMgYWNjb3VudA0KPj4+Pj4+PiBjcmVhdGlvbg0KPj4+Pj4+PiBpcyBicm9rZW4uDQo+Pj4+
Pj4gDQo+Pj4+Pj4gVHJvbmQgb3ducyBpdC4gQnV0IGhlJ3MgYWxyZWFkeSBzaG93ZWQgbWUgdGhl
IFNNVFAgbG9nIGZyb20NCj4+Pj4+PiBTdW5kYXkgbmlnaHQ6IGEgdG9rZW4gd2FzIHNlbnQgb3V0
LiBIYXZlIHlvdSBjaGVja2VkIHlvdXINCj4+Pj4+PiBzcGFtIGZvbGRlcnM/DQo+Pj4+PiANCj4+
Pj4+IEknbSBjbG9zaW5nIGl0IGRvd24uIEl0IGhhcyBiZWVuIHJ1biBhbmQgcGFpZCBmb3IgYnkg
bWUsIGJ1dCBJDQo+Pj4+PiBkb24ndA0KPj4+Pj4gaGF2ZSB0aW1lIG9yIHJlc291cmNlcyB0byBr
ZWVwIGRvaW5nIHNvLg0KPj4+PiANCj4+Pj4gVW5kZXJzdG9vZCBhYm91dCBsYWNrIG9mIHJlc291
cmNlcywgYnV0IGlzIHRoZXJlIG5vLW9uZSB3aG8gY2FuDQo+Pj4+IHRha2Ugb3ZlciBmb3IgeW91
LCBhdCBsZWFzdCBpbiB0aGUgc2hvcnQgdGVybT8gWWFua2luZyBpdCBvdXQNCj4+Pj4gd2l0aG91
dCB3YXJuaW5nIGlzIG5vdCBjb29sLg0KPj4+PiANCj4+Pj4gRG9lcyB0aGlzIGFubm91bmNlbWVu
dCBpbmNsdWRlIGdpdC5saW51eC1uZnMub3JnDQo+Pj4+IDxodHRwOi8vZ2l0LmxpbnV4LW5mcy5v
cmcvPiBhbmQNCj4+Pj4gd2lraS5saW51eC1uZnMub3JnIDxodHRwOi8vd2lraS5saW51eC1uZnMu
b3JnLz4gYXMgd2VsbD8NCj4+Pj4gDQo+Pj4+IEFzIHRoaXMgc2l0ZSBpcyBhIGxvbmctdGltZSBj
b21tdW5pdHktdXNlZCByZXNvdXJjZSwgaXQgd291bGQNCj4+Pj4gYmUgZmFpciBpZiB3ZSBjb3Vs
ZCBjb21lIHVwIHdpdGggYSB0cmFuc2l0aW9uIHBsYW4gaWYgaXQgdHJ1bHkNCj4+Pj4gbmVlZHMg
dG8gZ28gYXdheS4NCj4+Pj4gDQo+Pj4gDQo+Pj4gRXZlciBzaW5jZSB0aGUgTkZTdjQgY29kZSB3
ZW50IGludG8gdGhlIGtlcm5lbCwgSSd2ZSBiZWVuIHRlbGxpbmcgeW91DQo+Pj4gdGhhdCBidWd6
aWxsYS5saW51eC1uZnMub3JnIGlzIGRlcHJlY2F0ZWQuDQo+PiANCj4+IEkgZG9uJ3QgcmVjYWxs
IHRoYXQsIGFuZCB0aGUgdXN1YWwgY291cnRlb3VzIHRoaW5nIHRvIGRvIGlzDQo+PiBwdXQgYSBi
YW5uZXIgb24gdGhlIGxvZyBpbiBwYWdlIGZvciBhIHRpbWUsIG9yIGF0IGxlYXN0DQo+PiB3YXJu
IGZvbGtzIHRoYXQgdGhlIHNpdGUgZ29pbmcgYXdheSBpbW1pbmVudGx5Lg0KPj4gDQo+PiANCj4+
PiBXZSBkb24ndCBuZWVkIDIgYnVnIHRyYWNraW5nDQo+Pj4gcmVzb3VyY2VzLCBhbmQgYnVnemls
bGEua2VybmVsLm9yZyBpcyB0aGUgbW9yZSBnZW5lcmFsIG9wdGlvbiB0aGF0DQo+Pj4gdHJhY2tz
IGFsbCBMaW51eCBrZXJuZWwgcmVsYXRlZCBpc3N1ZXMuDQo+PiANCj4+IGJ1Z3ppbGxhLmxpbnV4
LW5mcy5vcmcgPGh0dHA6Ly9idWd6aWxsYS5saW51eC1uZnMub3JnLz4gaXMgZm9yIHVwc3RyZWFt
IG5mcy11dGlscyBidWdzIHRvbywNCj4+IGFuZCBJIHRoaW5rIHRoZXJlIHdlcmUgZXZlbiBvbmUg
b3IgdHdvIFRJLVJQQyByZWxhdGVkIGJ1Z3MNCj4+IHRoZXJlIGFzIHdlbGwuIFNvLCBub3QgcmVk
dW5kYW50IGluIHRoZSBsZWFzdC4NCj4+IA0KPj4gQnV0IEkgc2VlIHlvdSd2ZSBhbHJlYWR5IHRh
a2VuIHRoZSB3aG9sZSB0aGluZyBkb3duLCBzbyBJDQo+PiBndWVzcyB0aGF0J3MgbW9vdC4NCj4+
IA0KPj4gSSBjYW4gb25seSByZWdhcmQgdGhlIHRvbmUgYW5kIHN1ZGRlbm5lc3Mgb2YgdGhpcyBy
ZW1vdmFsDQo+PiBhcyBhIHBlcnNvbmFsIGphYiwgc2luY2UgeW91IGtub3cgdmVyeSB3ZWxsIHRo
YXQgSmVmZiBhbmQNCj4+IEkgd2VyZSBzdGlsbCB1c2luZyB0aGUgc2l0ZSBhbmQgdGhhdCB3ZSBo
YWQgYnVncyBhbmQgdG8tZG9zDQo+PiBpbiBmbGlnaHQuDQo+IA0KPiBDb3VsZCB5b3UgcGxlYXNl
IHRvbmUgaXQgZG93bj8gSSBkb24ndCB0aGluayBpdCB3YXMgaW50ZW5kZWQgYXMgYQ0KPiAicGVy
c29uYWwgamFiIi4gU291bmRzIG1vcmUgbGlrZSBUcm9uZCBpcyBpbiBwYWluLg0KDQpUcm9uZCBp
cyB0aGUgQ1RPIG9mIGEgc3RhcnQtdXAgc3RvcmFnZSB2ZW5kb3IuIEhlJ3Mgbm90DQpzb21lIGtp
ZCBpbiBhIGJhc2VtZW50Lg0KDQpJZiBUcm9uZCBpcyBpbiBwYWluLCBoZSBjYW4gYXNrIGZvciBo
ZWxwIGxpa2UgYW4gYWR1bHQuDQpSaXBwaW5nIGRvd24gYSBjb21tdW5pdHkgcmVzb3VyY2Ugd2l0
aG91dCBhbnkgd2FybmluZw0Kb3IgZGlzY3Vzc2lvbiBpcyBub3QgYWR1bHQgYmVoYXZpb3IuDQoN
CkFzIGhhcyBiZWVuIHN0YXRlZCBhbHJlYWR5LCBhbmQgYmVhcnMgcmVwZWF0aW5nOiBUcm9uZCwN
CmlmIHlvdSB3YW50IHRvIHN0ZXAgYmFjaywgdGhhdCBpcyBmaW5lLiBCdXQgZm9sa3MgYXJlDQpj
bGVhcmx5IG5vdCBwcmVwYXJlZCBmb3IgdGhpcyBjb21tdW5pdHkgcmVzb3VyY2UgdG8NCnNpbXBs
eSB2YW5pc2guIExldCdzIGNvbWUgdXAgd2l0aCBhIHRyYW5zaXRpb24gcGxhbi4NCg0KDQo+IEJ1
dCBJJ20gYWxzbyBzb3VyIGFib3V0IHRoaXMsIGJ1dCBmb3IgZGlmZmVyZW50IHJlYXNvbnM6IFRo
ZXJlIGlzIG5vDQo+IHNpbmdsZSBhbHRydWlzdGljIGNvbXBhbnkgd2hvIGVhc2lseSBjYW4gaGVs
cCBvdXQgcXVpY2tseSBzaW5jZSBTdW4NCj4gTWljcm9zeXN0ZW1zIHdlbnQgZG93bi4NCg0KTGV0
J3Mgbm90IGNvbmZsYXRlIHRoZSBuZWVkcyBvZiB0aGUgTkZTIGNvbW11bml0eSBhcw0KYSB3aG9s
ZSB3aXRoIHRoZSBuZWVkcyBvZiBMaW51eCBORlMgZGV2ZWxvcGVycy4gVGhlDQpmb2xrcyB3aG8g
bmVlZCB0byBzdGVwIHVwIGhlcmUgYXJlIHRoZSBMaW51eA0KZGlzdHJpYnV0b3JzLiBXZSBhbHNv
IGhhdmUgYSB2YXJpZXR5IG9mIHNvdXJjZSBmb3JnZXMNCmxpa2UgR2l0SHViIGFuZCBHaXRMYWIg
dGhhdCBhcmUgZGVzaWduZWQgdG8gcHJvdmlkZQ0KdGhlc2Ugc2VydmljZXMuDQoNCg0KPiBJIGJp
dHRlcmx5IHJlbWVtYmVyIHRoZSBMaW51eFRhZy9MaW51eFdvcmxkIGNvbmZlcmVuY2VzIGhlcmUg
aW4NCj4gR2VybWFueSB3aGVyZSB0aGV5IHdlcmUgc2luZ2luZyBtb2NraW5nIHNvbmdzIGFib3V0
IFNVTiZTb2xhcmlzLA0KPiAiTGludXggV09OLCB3ZSdsbCB0YWtlIG92ZXIgdGhlIHdvcmxkJyBi
bGFibGEuIFRoZXkgZm9yZ290IHdobyBoZWxwZWQNCj4gdGhlbSwgYW5kIHdlcmUgYWx3YXlzIG5p
Y2UgdG8gdGhlIE9wZW5zb3VyY2Ugd29ybGQuDQo+IA0KPiBXaG8gaXMgbGVmdCBub3c/DQo+IA0K
PiBTVU4gaXMgZ29uZSwgSFAmSUJNIG1vc3RseSBsb29rIGF0IG1vbmV5ICh0aGF0IGluY2x1ZGVz
IFJlZGhhdCwgd2hvDQo+IG5vdyBnZXRzIHJ1aW5lZCBieSBJQk0ncyBiZWFuIGNvdW50ZXJzKSwg
YW5kIHdobyBpcyBsZWZ0IGFuZCB3aWxsDQo+IGFsdHJ1aXN0aWNhbGx5IGhlbHAgb3V0IGluIHN1
Y2ggYSBzaXR1YXRpb24/DQoNCkl0J3Mgbm90IHRoYXQgYmxlYWssIElNTy4NCg0KDQotLQ0KQ2h1
Y2sgTGV2ZXINCg0KDQo=
