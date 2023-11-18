Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009477F01F8
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Nov 2023 19:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjKRSeD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Nov 2023 13:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRSeC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Nov 2023 13:34:02 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE81127
        for <linux-nfs@vger.kernel.org>; Sat, 18 Nov 2023 10:33:58 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AIHKuiC016658;
        Sat, 18 Nov 2023 18:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xIOQOmvi+eehTCA6kUElUPIa4d0zyHaHrx6BgQieges=;
 b=kI28dnwalZ6fJRhnfRIvhNXRlYjN35u9nKcC119++d0auUpEVi5mgQ8EBstjxk5/msQ8
 Ms3Kf5AsKdfeeO3hQBMPT33uBtNcjuit7z6gEh4vNE9tcTZYQ1+X59BPIHe2/LXLAxo2
 8wr5UJHdDiYhSBlrz/eV6EjMXLe6zJ5IbieMSJSa6F1LN8vcUvUC4LeOwn/+v2EN5tyq
 1VBtFgRqTqzj+8CawFctcoGgVevqV/Hyi1PKz+5LMCDrfVCwZ5MMFFN+Ux0jvKAA/zws
 0NKTJxLUVSWHfIrvH33yjTPK1Xw7Ho+/pHJ2wFXybAjoRlUwruCvg7A4fEcQwKew80fA gQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uen5b8j1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Nov 2023 18:33:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AIGodRp002385;
        Sat, 18 Nov 2023 18:33:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq3p0ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Nov 2023 18:33:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RS40guhaetMlw9edJSIud4DBhIDiss30tEDf7MwCx4+XbnS6lEQQSz5ciVvHs0rUAnSs2q8nv7/HQufb8h8Nf63clZRslQOjVhx+2pgBy1e1OGQte1l05EklEugyq3uNUUNZlnG2MapP6WUNHj2m4ltp82uyzOBd0BVRXIvk8tRgq9653wH5BgF7aXJ0ZBzK1YqVfseIZsNNoKC1cJHbH2Z/fhxXvK+NmXDSgxo5e/XULvpEGlo5jbFn/76L9FBKyP1+LQ3dBwRAOwJxqFUBjCxB47J2xWqzryaA7y9B5LQkdEZyVazdvR2KB4wdFiFUkVdu6imdZdUQcsJIRlOxUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIOQOmvi+eehTCA6kUElUPIa4d0zyHaHrx6BgQieges=;
 b=CSRlW4IqPF4D3EJnKnK/gBqxO9gtxERVB0A83lnbaq1PvmErbU3gUxN/ajELYxti61wyzXV9WNwhrUeCB66TINpKFEyE+lqpYnh45Vo5Y+MFnS+KhiX0MfntjHc9GxVn3TKB5+4j5yUhOmGkXxXxs9XFnhhCYc6KpfvaXslsO0YI9YplcVpYq9NIbwvKZeqJ9PAVYIVKqSQ3a26d2lauh+jOYyY8o5aiyvUVrBLSnx+Ih/9+tznZ5AzTE9/T+CEAbtqayn1Iw+3tRn2lyudClT6ML9mW4RecNkIR9NiYK+TbnweBBeY0AwzylrXoWfhelUbef/8a/acN0mcffO8Hqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIOQOmvi+eehTCA6kUElUPIa4d0zyHaHrx6BgQieges=;
 b=K9FwNkyBhDBcm0etsl/k3PJi4FYI6gkkJyIdUXgJDg82oyEl72zEYTeD4MSmzVGLomTGxWrFREsjG4qod8QcDA1Bee5SdBiqjTUANetXU35W9R5qcJrj7qHiAed1k0kM0kihoDzyv0Fpcz9zPC2atLOtM04epSEDYQ05VPVKT4o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7560.namprd10.prod.outlook.com (2603:10b6:a03:537::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 18:33:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.026; Sat, 18 Nov 2023
 18:33:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Topic: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Index: AQHaGSnEPMpWeNwF5UG1EZJYD3+ecbB/omOAgACniYCAAAIOAIAAA+qAgAAQ6ICAAAhigA==
Date:   Sat, 18 Nov 2023 18:33:51 +0000
Message-ID: <3D231C38-BA1A-4549-8788-D049CF3467A4@oracle.com>
References: <bug-218138-226593@https.bugzilla.kernel.org/>
 <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
 <CALXu0Ucz2MGCYdMw74ZKGUj_hpGcLP-pxC=MSgpUFGU58=jc=g@mail.gmail.com>
 <CALXu0UdY=ZgcAqvC6Y-X6htxPQ9=XWemt8V4dxTA99wQmHKz=w@mail.gmail.com>
 <959BB15F-5B91-4413-BCFC-EDAC78EE32F6@oracle.com>
 <d8bb0bf43c8fe38ef83248fb55a9549919530cf2.camel@hammerspace.com>
 <095736A1-C749-4B8C-900C-C0471D8F8422@oracle.com>
 <c762fb4fd6e3c529e75541d6944a187a357578c9.camel@hammerspace.com>
In-Reply-To: <c762fb4fd6e3c529e75541d6944a187a357578c9.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7560:EE_
x-ms-office365-filtering-correlation-id: e41a946a-a3ca-4c08-9cc3-08dbe864e9a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5vn2KUX8oamMEd+ilZrHDRg6vP3fe1smIU/bMEhDXMD6CGrzHKcijcdGhMx2k6C4WEE2lWgvqQAU1/KN4VW1a6TCUm3LFl70hku2Zm+uExrn6J/BADU+zeHZn4O2ue74mHPIUBYlrYBjstSRz3/4ukFxxdwUgmE2yHkuyPorMYN61BvdPd3nkU2ccOU0mjpIT2Hd0tPceI8GmIXI7ewufxsOKmiDWu5i4b3gA07tRQkg8f6viXxA+y4uGDRPNNWbybac8B3ThDqseiq0ZbnOxb9uZhuh1Yf02Fyr+y5F28nHihcAMgRFio5TtQhEQC85R669BxMV3gVF2zw0d3CLXy/rXzvXmsJ/P0nSMhLsnaW41MSDmiSq64wIjFrA8vhjZIxL/D6SvagimN+bhuEmHGIjtq3b1RMcDnD6yFik4XTrs6JtlzLFWJf5e2IjvSNYmT6+zIdn8zYeSsWW6ysMCUGgNcTJSRkpEeKxCS/EH5RVZIjUzas8ZCPBtX0+ERVY5Qy9IxpOhZbT+EjJ61G0N2iHaThOIBEF9x4DUX+QvLkVKb2bgwAc76FVV00eLG/RpwC8WgC/ZHWEt3qTE0vE58sjPIZWWGFMOvP6DmQ2g4DQqNxozHu3KiplvO1nkbJEjPTDJmkFSdx7wyv9rV/d4f6JVmypz50Gxv9Mxxmkhtl39tQOFsYQ2CxLCyw54AsklsQ27TvkTl4y5LFVzwb47w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(230273577357003)(230922051799003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(8676002)(4326008)(8936002)(15650500001)(26005)(36756003)(4001150100001)(38100700002)(76116006)(2906002)(71200400001)(316002)(6916009)(66946007)(64756008)(66556008)(66476007)(66446008)(91956017)(86362001)(5660300002)(478600001)(6486002)(6506007)(53546011)(2616005)(122000001)(38070700009)(83380400001)(33656002)(41300700001)(6512007)(43043002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXE1LzVZblJuQ2lMNWl1WVNIbTM4endvVVZmeE1FYkl6VlVRL0RTVThxOHJR?=
 =?utf-8?B?VkJsWDl2RVdzMHlVMlQ0S1YzWml0U1VPM1VsMzFpN1Q3elFJckxBWDZpRGxz?=
 =?utf-8?B?SkJiRFVPUnFWK3RGbG9NZklSWC9yRmR3dkNjRnpqQnNlUlJmUnVhUnFhMnRJ?=
 =?utf-8?B?RUtVNUZwdTV1cWd1ODFTbFRrM3pUYXJoSVY1bTFNZldGWnkrR09OTlNoN24v?=
 =?utf-8?B?MEc0aXh5MmtYZ0VTaXFlRUFzVUFFYWw4WklEVzlSVGJmaDN4U0h0MDVSRk45?=
 =?utf-8?B?bWdrL0xjSDFoSVZWTmlIUmFaakxPeE8zSThORndRTXZzNTJucjF2RWxxNTZ6?=
 =?utf-8?B?SFBpdFljM05oVkhYVUZIakJXWFJmU2tydDZETEl1ZmZQckN4MThzZjJqTklI?=
 =?utf-8?B?ZElXRkhZbzdOSkxLOXh0MEp5SGpvd2ludkg1Q3RRVVNtSG9IcU5hbmZWVzAw?=
 =?utf-8?B?c3hyVm1tZkVMV2xoLzdWTGdEeUpvN2RlV0NWSnVUN2JaamZqTFdVTlBnWFNj?=
 =?utf-8?B?UVpmL3F4cml1MFkwSUZwbm9nZVQ5TjhaNlNSbythZFppRVIyR0VtMFdCRG95?=
 =?utf-8?B?NmQ3S0NaNWNSdklwMnM1K2t5Z0FFNmhlc0c2b3ZqTHBZNDdKQ0hpdC9QK3p4?=
 =?utf-8?B?dlhBWUh0aWgrcHFoL29zMkFGb3pPQXFCMGppSlFmd1AyRC9kdmFQUXNNMm5t?=
 =?utf-8?B?U01HSWFrMnFiZkF3NHdMbmFaV0dlbTRBR2JCejAwZ3NRWHJnL0htRmozUCtz?=
 =?utf-8?B?UEMwT3FzaW4yVjRUNnBsQzdkU0p6eG9rcmZzZmlGSWhERnVJcUJObVpvczds?=
 =?utf-8?B?SlVRb0p4SmxvMGFZZEJBTDlNaGE1SEh6QnpwYUtzcGNnSU9zTHBNNDFzYUls?=
 =?utf-8?B?M1E3Y0w1bzJlS0J1YmFNd3FPdzIzK3dYV2c4MHZPMWJ2RW1SeGtiUzZuV2Rh?=
 =?utf-8?B?NERtMlhWYlVLME9kc29FKzRTcFNTVkNGY0RBUWQ3TW9hcjN3cTFBcC84VS9X?=
 =?utf-8?B?ZmdZRitnOHUrTU5vWUNHZEpYdEJ0UGZ5STMvT2lZcnZOMmJZcmNBaVc4MHNn?=
 =?utf-8?B?Y2doQ1Jvdi9kYndnNmZCK0pEQWRLU25rQ2h3QTFPOEhpNUpKM0R1QStiSUhM?=
 =?utf-8?B?NFB5OGhUdi9nTGw1MzlQSW95UEtNUXhKbTZsRFNjYk41K0l2b0V0K0JRZm1v?=
 =?utf-8?B?V21nbkliYVZ0QWdFblRyM25XcEJIcC9nVm5tS2NpK1NuaFhreWxsM2pLOE9C?=
 =?utf-8?B?Nml4dDB3OEVJYnl6eXJ0dXpWdTUxZm0vSjVmMThob2FQUG9ZMUU2aDhUSDRM?=
 =?utf-8?B?RU42ZFlSRjJ4OEVxL2lJcXIxWHVET1V2SHBjcExXSkJhQW5EcWFzckxLR3pt?=
 =?utf-8?B?dDZGSG5nMnlvVXNQYTVJTVdlNFJEVys3TVp1aXhyODgzUDY1M1FrNmg0OUVX?=
 =?utf-8?B?dkRkbTREdlJhUWZnMVNDQUlzRGlISzJWdkxvTXJSTmZqVGRuM1phUGVFdlBj?=
 =?utf-8?B?amJWVlI4WmdvNllIMjhxWDhwaWJ3Z3NJMmhxa0J1cVQ5SzBaT0tUZ3V4VTdL?=
 =?utf-8?B?S0xxZTRuVERPL0xpMGUrU3FDeGwxZ1FJaUxIL0YzemNvcHlQMmN0MTYwaWdI?=
 =?utf-8?B?TzJ5VjRRNVM1N1V6YmhaWXAzenFReUNRNk9QL3orTUZLdzdsNEh1TnhLZ3c5?=
 =?utf-8?B?VSt1a3hrTUpobWVlSFp3L3cwbjZjV3pndDdhdFkyWWhCSVNPVUp6azE1L08v?=
 =?utf-8?B?eUNiVDFCbTJNN0t1Nm5JMDFyMnNIeE5kRlZURGg5NTN3TlN6Ty9zSmdZS1Zq?=
 =?utf-8?B?bDBrQ2J6VWtxcnNldjNieTZvS2N1Ty9ocjZBOHVnbStHOFdCWXVaQkxkVlpE?=
 =?utf-8?B?a3ZBMjcrYkZOY2ZNSnVJYytqZGNqclRXV1hZVzI0dDArdGNoZk9GL1V6TVRy?=
 =?utf-8?B?bHZObysveGgxTTZqeC9oNFpEM0ZWZmh6WEZEU1FSblJGSHRuZ2FwbUZFNVZJ?=
 =?utf-8?B?RVhQTXJFOW1vK1AxS3pCeEhubEtJaTBGd294N29vNmRralVqTUdjRXNZOWEz?=
 =?utf-8?B?c0liQlQ3cksxZ3ROcVpXWE10N2dHQnpqVWdWWVNhVHFGTDJRZDNjVWYyaVhr?=
 =?utf-8?B?RUtqQ1phOHZrS3RScFZ1RnpXY1ZGQXZjOFQyTWQxbTh3RzJCQUtwZTE3N3dv?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6DD7D6402A3AF41AADA466F4C48FF2E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6vLsoFTEaAFBGl3p0PnqyzO7KKO4jbcWLYOYx7BbdnePJ/b+UdXLzvXVqqDyMMXNopJPgjIS0aQFG9eGDHuvFgYSB6vCbbEP89wO7E0rwnTO3lFpBaFtUpGyEd1JZXM+1k2mOffPtpB4w6ELcgo+BrlvYWrDUwVVGtgcgcviflI9ynlfNLpDjCYlLcHoceBMsDh2DTDVFeqCG1Lz5QLyhBj0sLYg/BJsp0Be/PlvBm+j3Z0+e0lfo5JcJPN+m4GnK0TaOCNwymmlm5xipnoHfPJdyrKAfLBnO/BbP52F1IJ9xp7qmAXX6NsuBMA9i2UAnDaPkXcud9bRwlaz+lsv1uWUU2JqrAe6KQVnJzgjnJ2gnOT68hiDSpv53p1xmjFeylh0WzHYXCt9/tlj7xZJO0zwqMHBERf0yVbkLwHl/fkWPXuffzFhpHD838XLoyMZIN05u0uq88r7r+RWdtDrXEaTfqkXZGqBLXIHe6WVL8tZxDHAjqoGYF6GPavU7OSOt2nR4Er2zlE/SPiDeu5QKEGmCYOOTfuDzB0rx4BDA7Rskhqah52cVmh3FUpjKHKumPgXdKNzyFQdc6HYSQaNOyRtM39FB1Pvxn+eS3htb/jaVwKtLXTaHgYklOo53Ew9UDAuCKVjSWWynLSyMP5zZLxirzErnVmzliEIEBhDnfC14nDjLJflK3lgtC2O4OULxpOsCMbSX56NaIpdPCv8kSXRSvJujr7O63+t0UMa0CC/ijFmAR4633vXl2j2B0LjrGsgqbC6QvdhoAb13KU5GSuK1KhMkNjh/CrQFA+LTQFNhgw6s4XsbBNZqLVI6BEF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41a946a-a3ca-4c08-9cc3-08dbe864e9a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2023 18:33:51.6787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5XsvEB0aGbScsbU7xTWCB0DMIVAhYG5LdW34tPKjTsSVljWlKnqBELB/lMGuxKofZY+9lPZ8Z5bujYltWb1SZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_15,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311180141
X-Proofpoint-GUID: HzY8JKP_lOIKbXepL_cBVEbEKb2Eq1XB
X-Proofpoint-ORIG-GUID: HzY8JKP_lOIKbXepL_cBVEbEKb2Eq1XB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTm92IDE4LCAyMDIzLCBhdCAxOjAz4oCvUE0sIFRyb25kIE15a2xlYnVzdCA8dHJv
bmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiANCj4gT24gU2F0LCAyMDIzLTExLTE4IGF0
IDE3OjAzICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+PiANCj4+PiBPbiBOb3YgMTgs
IDIwMjMsIGF0IDExOjQ54oCvQU0sIFRyb25kIE15a2xlYnVzdA0KPj4+IDx0cm9uZG15QGhhbW1l
cnNwYWNlLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gU2F0LCAyMDIzLTExLTE4IGF0IDE2OjQx
ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+Pj4+IA0KPj4+Pj4gT24gTm92IDE4LCAy
MDIzLCBhdCAxOjQy4oCvQU0sIENlZHJpYyBCbGFuY2hlcg0KPj4+Pj4gPGNlZHJpYy5ibGFuY2hl
ckBnbWFpbC5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBPbiBGcmksIDE3IE5vdiAyMDIzIGF0
IDA4OjQyLCBDZWRyaWMgQmxhbmNoZXINCj4+Pj4+IDxjZWRyaWMuYmxhbmNoZXJAZ21haWwuY29t
PiB3cm90ZToNCj4+Pj4+PiANCj4+Pj4+PiBIb3cgb3ducyBidWd6aWxsYS5saW51eC1uZnMub3Jn
Pw0KPj4+Pj4gDQo+Pj4+PiBBcG9sb2dpZXMgZm9yIHRoZSB0eXBlLCBpdCBzaG91bGQgYmUgIndo
byIsIG5vdCAiaG93Ii4NCj4+Pj4+IA0KPj4+Pj4gQnV0IHRoZSBwcm9ibGVtIHJlbWFpbnMsIEkg
c3RpbGwgZGlkIG5vdCBnZXQgYW4gYWNjb3VudA0KPj4+Pj4gY3JlYXRpb24NCj4+Pj4+IHRva2Vu
DQo+Pj4+PiB2aWEgZW1haWwgZm9yICpBTlkqIG9mIG15IGVtYWlsIGFkZHJlc3Nlcy4gSXQgYXBw
ZWFycyBhY2NvdW50DQo+Pj4+PiBjcmVhdGlvbg0KPj4+Pj4gaXMgYnJva2VuLg0KPj4+PiANCj4+
Pj4gVHJvbmQgb3ducyBpdC4gQnV0IGhlJ3MgYWxyZWFkeSBzaG93ZWQgbWUgdGhlIFNNVFAgbG9n
IGZyb20NCj4+Pj4gU3VuZGF5IG5pZ2h0OiBhIHRva2VuIHdhcyBzZW50IG91dC4gSGF2ZSB5b3Ug
Y2hlY2tlZCB5b3VyDQo+Pj4+IHNwYW0gZm9sZGVycz8NCj4+PiANCj4+PiBJJ20gY2xvc2luZyBp
dCBkb3duLiBJdCBoYXMgYmVlbiBydW4gYW5kIHBhaWQgZm9yIGJ5IG1lLCBidXQgSQ0KPj4+IGRv
bid0DQo+Pj4gaGF2ZSB0aW1lIG9yIHJlc291cmNlcyB0byBrZWVwIGRvaW5nIHNvLg0KPj4gDQo+
PiBVbmRlcnN0b29kIGFib3V0IGxhY2sgb2YgcmVzb3VyY2VzLCBidXQgaXMgdGhlcmUgbm8tb25l
IHdobyBjYW4NCj4+IHRha2Ugb3ZlciBmb3IgeW91LCBhdCBsZWFzdCBpbiB0aGUgc2hvcnQgdGVy
bT8gWWFua2luZyBpdCBvdXQNCj4+IHdpdGhvdXQgd2FybmluZyBpcyBub3QgY29vbC4NCj4+IA0K
Pj4gRG9lcyB0aGlzIGFubm91bmNlbWVudCBpbmNsdWRlIGdpdC5saW51eC1uZnMub3JnDQo+PiA8
aHR0cDovL2dpdC5saW51eC1uZnMub3JnLz4gYW5kDQo+PiB3aWtpLmxpbnV4LW5mcy5vcmcgPGh0
dHA6Ly93aWtpLmxpbnV4LW5mcy5vcmcvPiBhcyB3ZWxsPw0KPj4gDQo+PiBBcyB0aGlzIHNpdGUg
aXMgYSBsb25nLXRpbWUgY29tbXVuaXR5LXVzZWQgcmVzb3VyY2UsIGl0IHdvdWxkDQo+PiBiZSBm
YWlyIGlmIHdlIGNvdWxkIGNvbWUgdXAgd2l0aCBhIHRyYW5zaXRpb24gcGxhbiBpZiBpdCB0cnVs
eQ0KPj4gbmVlZHMgdG8gZ28gYXdheS4NCj4+IA0KPiANCj4gRXZlciBzaW5jZSB0aGUgTkZTdjQg
Y29kZSB3ZW50IGludG8gdGhlIGtlcm5lbCwgSSd2ZSBiZWVuIHRlbGxpbmcgeW91DQo+IHRoYXQg
YnVnemlsbGEubGludXgtbmZzLm9yZyBpcyBkZXByZWNhdGVkLg0KDQpJIGRvbid0IHJlY2FsbCB0
aGF0LCBhbmQgdGhlIHVzdWFsIGNvdXJ0ZW91cyB0aGluZyB0byBkbyBpcw0KcHV0IGEgYmFubmVy
IG9uIHRoZSBsb2cgaW4gcGFnZSBmb3IgYSB0aW1lLCBvciBhdCBsZWFzdA0Kd2FybiBmb2xrcyB0
aGF0IHRoZSBzaXRlIGdvaW5nIGF3YXkgaW1taW5lbnRseS4NCg0KDQo+IFdlIGRvbid0IG5lZWQg
MiBidWcgdHJhY2tpbmcNCj4gcmVzb3VyY2VzLCBhbmQgYnVnemlsbGEua2VybmVsLm9yZyBpcyB0
aGUgbW9yZSBnZW5lcmFsIG9wdGlvbiB0aGF0DQo+IHRyYWNrcyBhbGwgTGludXgga2VybmVsIHJl
bGF0ZWQgaXNzdWVzLg0KDQpidWd6aWxsYS5saW51eC1uZnMub3JnIDxodHRwOi8vYnVnemlsbGEu
bGludXgtbmZzLm9yZy8+IGlzIGZvciB1cHN0cmVhbSBuZnMtdXRpbHMgYnVncyB0b28sDQphbmQg
SSB0aGluayB0aGVyZSB3ZXJlIGV2ZW4gb25lIG9yIHR3byBUSS1SUEMgcmVsYXRlZCBidWdzDQp0
aGVyZSBhcyB3ZWxsLiBTbywgbm90IHJlZHVuZGFudCBpbiB0aGUgbGVhc3QuDQoNCkJ1dCBJIHNl
ZSB5b3UndmUgYWxyZWFkeSB0YWtlbiB0aGUgd2hvbGUgdGhpbmcgZG93biwgc28gSQ0KZ3Vlc3Mg
dGhhdCdzIG1vb3QuDQoNCkkgY2FuIG9ubHkgcmVnYXJkIHRoZSB0b25lIGFuZCBzdWRkZW5uZXNz
IG9mIHRoaXMgcmVtb3ZhbA0KYXMgYSBwZXJzb25hbCBqYWIsIHNpbmNlIHlvdSBrbm93IHZlcnkg
d2VsbCB0aGF0IEplZmYgYW5kDQpJIHdlcmUgc3RpbGwgdXNpbmcgdGhlIHNpdGUgYW5kIHRoYXQg
d2UgaGFkIGJ1Z3MgYW5kIHRvLWRvcw0KaW4gZmxpZ2h0Lg0KDQpOZXh0IHRpbWUsIGlmIHlvdSBo
YXZlIGEgY29tcGxhaW50IGxpa2UgdGhpcywgcGxlYXNlIGJyaW5nDQppdCB0byBtZSBmaXJzdCBh
bmQgd2UgY2FuIHdvcmsgaXQgb3V0LiBKZXJraW5nIG1lIGFyb3VuZA0KaXMgYSBEaWNrIE1vdmUs
IGFuZCBqdXN0IG5lZWRsZXNzLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==
