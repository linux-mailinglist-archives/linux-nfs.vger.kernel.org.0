Return-Path: <linux-nfs+bounces-629-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D251814BF0
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 16:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65751F24EAD
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7565E3716F;
	Fri, 15 Dec 2023 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n8n7alcx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xh6YN4gB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599CB37152
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFEx0bk015099;
	Fri, 15 Dec 2023 15:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Ts5N8T97RO4IPpmoKKa5klk7NNDkghvK/wz6clnUO08=;
 b=n8n7alcxpfEq47/SumUM9CNID3Tz57XLrP+5YPra5cksAgImIN16Gmb6KsfwWBWaAC1U
 RqYJk6yN1tTH+TrxebPf6JU9+L1PpgjaBQoKRmFEmqKxHmL2U8Ce5xuQWT6SsIWtCEqC
 ojCMRMN08qBEllN0dVS4+SnZoXKatcPSPz0YiyFiM0gTiTbMby9MxRV2xWEB0qqCkipP
 VDsGj9suRu2UOSA1ILeRuqpvm9sp3QxPr0zP6n1efu9BwIXBBYvhbxFHAQhzM2emroj2
 KD67fWsfPhCnFvzR78JJPNnz64SKU33m1BgmFWzke8yMWSuS93673ncPapanwmVBzxbC Xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3utb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 15:38:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFEwcGH030645;
	Fri, 15 Dec 2023 15:38:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepc2w1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 15:38:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGBL3PlB6elf6meeSjUmwmdMDsWebKCd2abnLacBmrNhG8pcgmH8jIgylC0y0MlgdN1dvBymxY12gWIMYwcx/358ORRrzS3PHAjMPDSQriY1x4j+wBUKcSg+3TZqgV0Ce30TwXoTfGN+IcGckwyqvJK8qRYY0Rup+bhrgAGR4q5QCXM+wYcVJYe1NKsYhMdHQcTl8jKrjTlgv5i7BMM0YTx7wP9N51ZlPyZxlyoz+TBaRH8+2KJYCME9nGdvU9PdWZsoazliJKvxxnruhqYK6pbZZBWnY8nq04nMYc4CHMkzhiMg0NkR+pMSejKZuQvwP3uvps1r4bCQsYpj+Sd7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ts5N8T97RO4IPpmoKKa5klk7NNDkghvK/wz6clnUO08=;
 b=NPhn1zRpriNJ9PDEcloFvy1yol4/LI+pvmbNHFWytaJgXIYA8wIOljEMD3zZlgnCEYd0kIb0pN9yz4zR7TD2ocakYiYe2f7ywPm22ExZtomoLWW5f0hDe92J/zQjy6Xq988LxOuTl+dI2G5MsNrMx+SOAjM0u5RNU0po6nFH5qqHg5WHAktxSbWNoqyg0G+anrY2a9wVDZKId2USHuNj5x+4lLuKCTvgSkRe+vgpoFPqZ8LIEVm/dIMRFWAzgDta+qvZTfgW50pCXrjWOw9kMnuqmOPpVlRnao9OC0KvU+7eZLE7qPYVNlAv7IrYe1H4J2XjUdQwQtZ4Kfx3cKkTEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ts5N8T97RO4IPpmoKKa5klk7NNDkghvK/wz6clnUO08=;
 b=Xh6YN4gBfpq0uMR/SOvFO3pKSaY5ubaeis3VPlgT6v0I2vul70xf/WGV5SIxeJLxm/KCrNAJp+MY1h0eIQ82+u7hRZEdHmmNt9Wv1UJax+pdnvXtBtkCHapKVYmHzAloFzKDk4Ib3rUDZOUH7sWNVL3TwUzTxi5aTjwk+6NhVjE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6308.namprd10.prod.outlook.com (2603:10b6:806:270::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 15:37:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 15:37:44 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia
	<kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH 0/5 v2] sunrpc: stop refcounting svc_serv
Thread-Topic: [PATCH 0/5 v2] sunrpc: stop refcounting svc_serv
Thread-Index: AQHaLvIpI3Gh1yYMNEWNLEmjJILL4bCqLZEAgAA35gCAAAIGAIAAA2EAgAAQe4A=
Date: Fri, 15 Dec 2023 15:37:44 +0000
Message-ID: <C91850FB-094B-4D31-9CED-0C8C107645CE@oracle.com>
References: <20231215010030.7580-1-neilb@suse.de>
 <7659cf71534f9e81cb95f1571f1942a30b7f5a60.camel@kernel.org>
 <23A34EAB-A72E-459E-8D2D-7160CB25B549@oracle.com>
 <c8b275c3a9b168e8e4b4a4b4e921e913428294a7.camel@kernel.org>
 <C923978C-5171-4394-A3F7-101E07092EBD@oracle.com>
In-Reply-To: <C923978C-5171-4394-A3F7-101E07092EBD@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6308:EE_
x-ms-office365-filtering-correlation-id: 62b84e80-9cb8-4f35-9f26-08dbfd83c801
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Adb5l1hNwGhdTb0GHvcfXcCWifjJALEjTZK1Kqj8PtwhU2KqYPcU+8AXXssBGNSXTdpl8aTlRGXP2bFVWFidNYh+rs4/M7sGKRCAidNnH0a+sjR7+MZAPpZ0ohGHUobGKjPXiKsruMNPFOUsZim1fy1IM8qhW9k8KI4wijUyHYe0/Bh2+8S5iaTHTMqdreovBMhno4lRCVj6/3kU8xZ6XWwROiF5NnF7nKnEvKQMUauRQR2C4ASnVp7ThzPy6T8YuRYM4Fz6LNZ0qeFEXnKMECl3BvY2A6/3115ins2C5FkKTMuLpQpFOpXT7weEiBOetYK3Lv2JsJdjN4Ql42sGNC1ab+9isBzkyRQQJ5qU3Md0EoZyDJ5vY6MonEdcqAVWyz7v4Qrt0qKQ/hcunbFDT2zJL0bu5DL6owXtkW5NH4OGLFcNGJ/jV+DRbqntiHVQomSnRqUMOW3rdb+OI9TRWOs4ItY51YsW1MoJ46pnSAz1IQ7b3nBqHUlGj6GFS9tDxww6yWPES/J+s4vvC7rU5RydXXBVhGOuyjxwnknBo+YO2km1DRS+0PsSl4iGckg97NS4fLvH6LEaMig1xUMNj4c875RTBJwxlUAnTk4NKZQdK2IseAZc0OjUuKDnCSybjufzIdYvAhqJf+A9da2ly9vM1WJBoUINxYvryUa8CpU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39860400002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(86362001)(122000001)(36756003)(38100700002)(316002)(76116006)(110136005)(64756008)(66476007)(66946007)(66556008)(66446008)(26005)(83380400001)(2616005)(91956017)(5660300002)(54906003)(4326008)(8676002)(8936002)(53546011)(71200400001)(6512007)(6506007)(478600001)(966005)(6486002)(41300700001)(4001150100001)(2906002)(33656002)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dWlJMHczeVprRlhUNk1JMkljdmgrNis2QjVHTFRZVk0yOHJBTk5EL3dqMnor?=
 =?utf-8?B?bi8zMU1oVE0xMEd1cmtRdGFCa3ZkMi9nK0JsekM5S1ZjR3YvREVTbi8xbEdV?=
 =?utf-8?B?TkRTUzBUbjFTMkFaa3Y4UEpuN2phZE9iMUtoeG5BZUNua0ppT29TUmRGeUgr?=
 =?utf-8?B?cEMwZTJiM3ZiMmE0eEp6cCtkN0tCdE5mRUNoVzdTcUJxMkZ6Mzc4b3Q1anh0?=
 =?utf-8?B?VC82Z1VuSUc3aGhrZXBXUWYySHgwcklLdTJPeWhpNmJpbHBtd0lDc04zdnhF?=
 =?utf-8?B?YW1GamJaRTJzQ01FTmlNMHh1RTZsTDBxV2xKRG93K3o3WlFmdzh2dkhzaXd1?=
 =?utf-8?B?bytyVXlzaGI3VVFqcFI3YVJOUUQ1TXdrMjdMUFlXbW1zVHVScXhUdDlTc2pI?=
 =?utf-8?B?S3ZMNFBIUzVwV1ZhZmprWkVyZ3JzZEk0OUx0bDlMSy9vUUVtVm43RGZEM0ph?=
 =?utf-8?B?aHFtaExtQ3U4VVpCV0NiU2dnc3NzR1dGcGVCUDNtd0V1ZStuWVNOSGtzNFJl?=
 =?utf-8?B?M1dKNEVzV1NEUzdYeGdqUER1MU5VWXlOMWdJVVlkNU1jSjhmeXpzWXJuN1NO?=
 =?utf-8?B?TlZoZjA2RXlEdzNtUXhnYmxsWFJVQ05vbGJzTFhFVkNQd1A3TFhzQVd0R1pT?=
 =?utf-8?B?VVdwY0I2Q2xBZ05mS2F2cnRJVW9WWUJwL0NZK2tXOVBNenBxYVg4a3cvMHh6?=
 =?utf-8?B?YUVkT00vaUtaN0k1SUR1TWFFRVFKNkVZNXRjYlc0NFBjdGpRMXZXVkZEVmth?=
 =?utf-8?B?RTFwbWZDSlpkRWhPN2ZXT1NLa0hUS292bFFxRjBQMXplWGlpVSswaTJpSTdz?=
 =?utf-8?B?K3lGNDNCN09EZjRMc1dPbmdpOHp4NGdkclk3WVRQdUZHSlZIUDJsYmZVVjdi?=
 =?utf-8?B?bUx6SVlTTnVWc3hlUzlTZ1pSMGYxaHEveVZScEROeTlBaXBUVWsybXdPNUZi?=
 =?utf-8?B?L0JtNG5PKzNtaFkyU3dIL0d5djdBUTRDY1k1R1lPU3JWeEFES3F3RTFJaEZQ?=
 =?utf-8?B?V1Q4MWlwMi80Y3BPZ0Uwak4xQW0rMGVUMkVUZnBxMGdjSStiTm0xTEw5aXZq?=
 =?utf-8?B?UzFiYlVqUFp0QVNMVFgxL2NpVzh2N3dveW5wWXF4ZWcvcEJlUXdsQXhYSzhJ?=
 =?utf-8?B?eFJNMVB2cCtjT2dZeTdLYU1XSWJUWUF0N0F5VjhQRlFGUUlTTTE5NnEwOUQw?=
 =?utf-8?B?Tk1rdlZwdzNIWkJ0WlFvR3ppR29LR1BPUUY2cU9aLzB4Zkw4VmVWa0p0cFhF?=
 =?utf-8?B?S2tDTjhKY2tHNVJ5MkIzN1ExdE0yeTRtbnFJQ1QxcjhVN3pZMFV6QXk2YmNi?=
 =?utf-8?B?aHE1SHIwY2g5ek5DZk9pSUVtelpJRm9TODQwcjBYbFY5UVNOZGR2bWdTbU5J?=
 =?utf-8?B?QmQ5SjEvNkZqZlhjejJMczFuS0UrOXFrUlhBNmhxNGVQN0liUGNKdjh2aXJ2?=
 =?utf-8?B?dWk3bWVrKzZnOXprd2dqMDhVQS8vNVNyWW93cTN0UkpLYVFtVVRrcWJ4bklY?=
 =?utf-8?B?S2JLenM2Tk1lanNaWjE0cTBjVTkyQkhRR2FoeVVvR2JzeHFDNDNsUFJxZ1ZV?=
 =?utf-8?B?UmJ3YnhaTVdkaHN3d0haVzM5dndQenMvWlV3SVUvQ2FRdituZDFDdWx4WDJx?=
 =?utf-8?B?QjgrN3RMb2RFaDZZUFZldzBJSmNFQnpaMlA1eHhvcDJyeDhIVzBTZ24xKytJ?=
 =?utf-8?B?WHBPTHNGWktUN21aQTZpYllFT2hZU29hTTg0SWw0Z2JadUJFOVd2QTVMSmY5?=
 =?utf-8?B?WHV3TTlsazdPbVJ4NkI1eWdWd0JFa2F0dGUxNGZCNVdMMDh3RXNweTlwWWFx?=
 =?utf-8?B?M3VNVHkwQk9ESXRCbXRmMTkveTh4eEE0TmxVaFV1TjdLTG1MSk9YM1Y2Z2FV?=
 =?utf-8?B?U3d6MUc2b1h3QlZEODlxa3B2RDdxRXpKV3k2a1ZWNVhHREV2ZXhSSDZYcUIr?=
 =?utf-8?B?SnJYamRKek9adk5oM2prWTlRS0lEVW9IMEd5YjJFUVI3U3dUd1lDWUNVNTF1?=
 =?utf-8?B?QnhjRjBMbUlOMC9XRXUzQkd4QUU4R2xiMmZldTZ3VGEyNjN3NmxzVkR4cEpD?=
 =?utf-8?B?bmdWRmRwbVEyUXEySjR2KzB4eTcrSWg5cmYweE5YYWNUaFpWREZqVUFLdits?=
 =?utf-8?B?RHVPYitLemRvK2RDS2xhYjRmbzMwbHFHVzRDdzJpTjZpdlRuSEl6WU1CTHg5?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0ADD253314BD64FA8F1B02053F15832@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xv/aERRox8rvWEr5r4RiHGUvl6+vA+9k/in+unMTFb9aSRbjZKM0o7zMVknyTiJ/LyhHRY50H/25c8Wljf1FNvPRzI5KIpR6lgALJaNAmO25emy+jDQ29n4qKEasWfxrcWfuzK6oENTnHo3FVKSrfvoX5zmGYtn7CfdDyXn0BrsBrcqzHZYw9F/BfVx1T8E+SISHmbBm0NX75oKSCCpXbCjZRnKFl+886hlUUkMHpAJEYV/A4Mr2hreuQO/YOi7gkgLkJykWaWwy4R/kvphVYPZb247wjSK7QZedniJb4U72uCCE4zhGCIHT/0fkVrn8wOK/gffJYVqyZPV4jbJgQkgrnDpj0B23JrK89rtdvFj2tticoWxGBfU4XQiiM5C+oGICWkc5n3xF+jmP99FcyHsFQ4iWt5Vl3QrxMMKc0/OBURutu7yQVTiLW7oO/gSVcrxnSybBGzz0jXsNmARqOWqv02Cjq4OLeZiShGje+qmxg6s1iPKdrdzapAdLK9d73qqbzbWG4z+XucEJsW6UrrnVsZIXWEKkjpEtALQ0adW51GxV9bpvvnVwYKmJBBVxI7BVJVOsSljgZJS6i9LF4RHaMRJravebdetYrl+ACVI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b84e80-9cb8-4f35-9f26-08dbfd83c801
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 15:37:44.1080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ez2c5lnjvkVloCRYKaSS44oJljn/96dxE65HDlMiOMIGi9dXuvSYhArKr/T6JYPQzDVh+iT7KHkh7BxN0XHtJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150108
X-Proofpoint-ORIG-GUID: B66MtZiuSIGn-c5GYaPaWfWjCOzVjBJc
X-Proofpoint-GUID: B66MtZiuSIGn-c5GYaPaWfWjCOzVjBJc

DQo+IE9uIERlYyAxNSwgMjAyMywgYXQgOTozOOKAr0FNLCBDaHVjayBMZXZlciBJSUkgPGNodWNr
LmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4+IE9uIERlYyAxNSwgMjAyMywgYXQgOToy
NuKAr0FNLCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4+IA0KPj4g
T24gRnJpLCAyMDIzLTEyLTE1IGF0IDE0OjE5ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+Pj4+IE9uIERlYyAxNSwgMjAyMywgYXQgNTo1OeKAr0FNLCBKZWZmIExheXRvbiA8amxheXRv
bkBrZXJuZWwub3JnPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IE9uIEZyaSwgMjAyMy0xMi0xNSBhdCAx
MTo1NiArMTEwMCwgTmVpbEJyb3duIHdyb3RlOg0KPj4+Pj4gSSBzZW50IGFuIGVhcmxpZXIgdmVy
c2lvbiBvZiB0aGlzIHNlcmllcywgZ290IHNvbWUgZmVlZCBiYWNrLCByZXZpc2VkDQo+Pj4+PiBp
dCwgYnV0IG5ldmVyIHNlbnQgaXQgYWdhaW4uICBTb3JyeS4NCj4+Pj4+IA0KPj4+Pj4gVGhlIG1h
aW4gZmVlZGJhY2sgd2FzIGFyb3VuZCB0aGUgaW50ZXJhY3Rpb24gYmV0d2VlbiBzdW5ycGMgYW5k
IG5mc2QgZm9yDQo+Pj4+PiBoYW5kbGluZyBwb29sc3RhdHMuICBJIGhhdmUgY2hhbmdlZCB0aGF0
IHNvIHRoYXQgbmZzZCB0ZWxscyBzdW5ycGMgd2hlcmUNCj4+Pj4+IHRoZSBzdmNfc2VydiBwb2lu
dGVyIGxpdmVzLCBhbmQgd2hlcmUgdG8gZmluZCBhIG11dGV4IHRvIHByb3RlY3QgaXQuDQo+Pj4+
PiBzdW5ycGMgdGhlbiB0YWtzIHRoZSBtdXRleCBhbmQgYWNjZXNzZXMgdGhlIHBvaW50ZXIgLSBp
ZiBub3QgTlVMTC4gIEkNCj4+Pj4+IHRoaW5rIHRoaXMgaXMgbmljZXIgdGhhbiB0aGUgdmVyc2lv
biB0aGF0IHBhc3MgYXJvdW5kIGZ1bmNpdG9uIHBvaW50ZXJzLg0KPj4+Pj4gDQo+Pj4+PiBUaGlz
IHNlcmllcyBpcyBhZ2FpbnN0IG5mc2QtbmV4dA0KPj4+Pj4gDQo+Pj4+PiBUaGFua3MsDQo+Pj4+
PiBOZWlsQnJvd24NCj4+Pj4+IA0KPj4+Pj4gDQo+Pj4+PiBbUEFUQ0ggMS81XSBuZnNkOiBjYWxs
IG5mc2RfbGFzdF90aHJlYWQoKSBiZWZvcmUgZmluYWwgbmZzZF9wdXQoKQ0KPj4+Pj4gW1BBVENI
IDIvNV0gc3ZjOiBkb24ndCBob2xkIHJlZmVyZW5jZSBmb3IgcG9vbHN0YXRzLCBvbmx5IG11dGV4
Lg0KPj4+Pj4gW1BBVENIIDMvNV0gbmZzZDogaG9sZCBuZnNkX211dGV4IGFjcm9zcyBlbnRpcmUg
bmV0bGluayBvcGVyYXRpb24NCj4+Pj4+IFtQQVRDSCA0LzVdIFNVTlJQQzogZGlzY2FyZCBzdl9y
ZWZjbnQsIGFuZCBzdmNfZ2V0L3N2Y19wdXQNCj4+Pj4+IFtQQVRDSCA1LzVdIG5mc2Q6IHJlbmFt
ZSBuZnNkX2xhc3RfdGhyZWFkKCkgdG8gbmZzZF9kZXN0cm95X3NlcnYoKQ0KPj4+PiANCj4+Pj4g
SSdtIG5vdCBzdXJlIHBhdGNoICMyIGlzIGJldHRlciB0aGFuIHRoZSB2ZXJzaW9uIHdpdGggZnVu
Y3Rpb24gcG9pbnRlcnMsDQo+Pj4+IGJ1dCBpdCBzZWVtcyByZWFzb25hYmxlLg0KPj4+PiANCj4+
Pj4gTm90ZSB0aGF0IHBhdGNoICMxIHByb2JhYmx5IG5lZWRzIHRvIGdvIHRvIHY2LjYgc3RhYmxl
LCBhbmQgSSB0aGluayB3ZQ0KPj4+PiB3YW50ICMzIGluIHY2LjcgYmVmb3JlIGl0IHNoaXBzLg0K
Pj4+IA0KPj4+IFJlbWluZCBtZSB3aHkgIzMgc2hvdWxkIGdvIGludG8gdjYuNy1yYyA/IFRoZXJl
J3Mgbm8gRml4ZXMgdGFnIG9uDQo+Pj4gdGhhdCBvbmUuDQo+Pj4gDQo+Pj4gDQo+PiANCj4+IEl0
J3MgdGhlIHByb2JsZW0gSSBub3RlZCB0byBMb3JlbnpvIHRoZSBvdGhlciBkYXk6DQo+PiANCj4+
IA0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbmZzLzVkOWJiYjU5OTU2OWNlMjlm
MTZlNGUwZWVmNmIyOTFlZGEwZjM3NWIuY2FtZWxAa2VybmVsLm9yZy9ULyN1DQo+PiANCj4+IE9u
Y2UgeW91J3ZlIGRyb3BwZWQgdGhlIG5mc2RfbXV0ZXgsIHRoZXJlIGlzIG5vIGd1YXJhbnRlZSB0
aGF0DQo+PiBubi0+bmZzZF9zZXJ2IHdpbGwgc3RpbGwgYmUgYSB2YWxpZCBwb2ludGVyLiBIb2xk
aW5nIHRoZSBtdXRleCBhY3Jvc3MNCj4+IHRoZSBvcGVyYXRpb24gKGxpa2UgTmVpbCdzIHBhdGNo
IGRvZXMpLCBzaG91bGQgY2xvc2UgdGhlIHJhY2UuDQo+IA0KPiBPSy4gSSdsbCBhZGQ6DQo+IA0K
PiAgRml4ZXM6IGJkOWQ2YTNlZmE5NyAoIk5GU0Q6IGFkZCBycGNfc3RhdHVzIG5ldGxpbmsgc3Vw
cG9ydCIpDQo+IA0KPiBJIHdpbGwgYXBwbHkgMS8zIGFuZCAzLzMgdG8gdjYuNy1yYywgYW5kIHRo
ZSBvdGhlcnMgd2lsbCBnbyB0bw0KPiB2Ni44IChuZnNkLW5leHQpIG9uY2UgaXQgaXMgcmViYXNl
ZCBvbiB2Ni43LXJjNy4NCg0KUGxlYXNlIGNoZWNrIHRoZSB0d28gcGF0Y2hlcyBhdCB0aGUgdGlw
IG9mIHRoZSBuZnNkLWZpeGVzDQpicmFuY2ggaGVyZToNCg0KaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY2VsL2xpbnV4LmdpdA0KDQpJIHBsYW4gdG8gYXBw
bHkgdGhlIG90aGVyIHRocmVlIGluIHRoaXMgc2VyaWVzIHRvIG5mc2QtbmV4dC4NCg0KDQotLQ0K
Q2h1Y2sgTGV2ZXINCg0KDQo=

