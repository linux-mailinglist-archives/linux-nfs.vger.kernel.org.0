Return-Path: <linux-nfs+bounces-2601-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB058956A6
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Apr 2024 16:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8721F22A36
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Apr 2024 14:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ADE85260;
	Tue,  2 Apr 2024 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ukg+ub6e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N7Ipzqs7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6503086ACA
	for <linux-nfs@vger.kernel.org>; Tue,  2 Apr 2024 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068174; cv=fail; b=NlQMo+6aEYrNbGVxqKoPlVHT4K68YME/B5/Uv4kgWh5xbNMEhysmKBXnZxleUFr5qTKcL2nN+yViDuDasocwQvRIVg1DIDQFO08H0KHqYuVM960G4DoJ77kdKN880RnS/hMzcs7JuIdPuiBrEZTMJWVygvuemr2vRB3j7+9W76A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068174; c=relaxed/simple;
	bh=Z6tIAJAOZ8/Snn6cDMAHEX8yEQIdBPofn0zgPoHZP9s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dHW81LJXs60/6DgsqysvD8tYCftrMCClWrxahgDEiCYOYddRDWS7Cl5fJtv9i+iuzMiLukQyyRlEZ3skgvS5V9Jek9rEH9PWby93nL2u0BiEnp22lfKUCfpMvm8mbGxpvDI77oTK07DhvTj0mtRXSQMiUpTrXVIlrtxm27hVlJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ukg+ub6e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N7Ipzqs7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4327hqup020074;
	Tue, 2 Apr 2024 14:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Z6tIAJAOZ8/Snn6cDMAHEX8yEQIdBPofn0zgPoHZP9s=;
 b=Ukg+ub6eagaqBkxez4hFEkyJZ1z195IVtWxmgKkir3Bm+mrqC2xwt3H1r9q50Wd/kNdG
 cQp8+kX66QE22OVT94f28CI4XBxsrGYMSorCjB9W9foVnceEqcLusA1hoawdJthP5lfM
 /P/wx7OyXluap1gPWkL3OQ3/EN8PPrb6NOWGbpwTiKY+xayqQjIb+wNq+AgKWkyKXxSp
 HL11grUosDLxh0fe5nZVdMKw1WqNOFtIG+G87vDSTp5PyDT/JVFcz1N3a55f/Bc7Inyu
 UdZacr36SORtb0MZjt5MSnAj0EWTM3OlkU9qsGCQUUyihQnB/ZpV00o8hDtVOcY3OiKR NQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x7tb9ttdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 14:29:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 432EEblS000894;
	Tue, 2 Apr 2024 14:29:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x696d53vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 14:29:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABCKIXTG+d0J8Pa81Ra6NdB1tVmMXKz/foX6DyOmUY1hvfgTrYgijivzHbgIqBs20g/7IsqlSHGWCOJg2Ne4/NW8EbPtOK17EreyuC0aSzftXDemjzo/C3rtC7DFJ7hrZRWgrrIKB7mT1HyymcaVruu4AuJ0HedYdQiXDMzciFGU3M2D80ZyCtfr1kyxXNSZuM6txE8QR/IozzP6M9NfM7bgOPEL/ErjF/vzieEcmgfPOnpJOIKflIoLele5+fmBnxJsdu2Atlphut5ZOq214Tkvi6XfXiS5Ih41bfmrVBPFEDiuyVOBIiI48rxX1wnk/IoZQu59L/tI6ww8Cw7cpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6tIAJAOZ8/Snn6cDMAHEX8yEQIdBPofn0zgPoHZP9s=;
 b=KJr6z32Z+vsliFYzOwk5D9OCot2xazxEsT+U368s52yMBah4GfZk1reHurkxh2HgxZ1K5vGr966SlMPnopIbjh1LlL8EHkK3Fp51QblkjLDaC7Pe+6WcD+zniBcnpsISYd2iJm88pPYbZ5XyBmS7DcEoQ+YO0avDK5tjLVId7HnrTnZxaLym38cAN3uXi+ByOezckxor7oP42G2pVecgFPF+iisUCWUecvAouoBzNgqCcdsv9svLyd6MeFtWFDWuOGhUinWaHzQKgf+MpiH4Yv/TnOLBKoqsH1eriS6uhvVMurJEX0l/rPt0SZjJ4OSOXONPNIZO6NprgCSVsfrrAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6tIAJAOZ8/Snn6cDMAHEX8yEQIdBPofn0zgPoHZP9s=;
 b=N7Ipzqs7YtQpbqNk2M5QUwaIgIvrUyBjRvGGzYgpM7FUpCyy7EHfBIRBikA1QW7MNW1az6mOJHTCIcZFX0MSDR2UyS3Ldq0UxuPACEj08VeBp26sKsuXcnCQ5cEKWgL3SpnrrwI4ZwUwVAVEDoKcatH+L0Lg0BT520h4q679BXg=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by IA0PR10MB7304.namprd10.prod.outlook.com (2603:10b6:208:40e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:29:23 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:29:23 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: Chuck Lever III <chuck.lever@oracle.com>
CC: Jeff Layton <jlayton@kernel.org>,
        "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
Thread-Topic: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
Thread-Index: 
 AQHaf6lU7sd/eZRSf0OHFaRBFGAVjrFKV0MAgAICkwCAANmXgIAARN2AgABpJACAAPGkAIAAMrQAgABgaoCAAS7HAIAAC9WAgABURICAAnHHgIAADIKAgAAovICAAAzdgIAAEbuAgAAjCACAAS6VgIAACLTD
Date: Tue, 2 Apr 2024 14:29:23 +0000
Message-ID: <9E87E800-BD82-4A99-AC16-3980E57EF20C@oracle.com>
References: <ZgdR48dhdSoUj+VM@tissot.1015granger.net>
 <09da882f-4bad-4398-a2d0-ef8daefce374@oracle.com>
 <ZghZzfIi5RkWDh9K@tissot.1015granger.net>
 <84d6311e-a0a3-4fc6-a87e-e09857c765b3@oracle.com>
 <039c7e38b70287541849ab03d92818740fdf5d43.camel@kernel.org>
 <Zgq365RJ9M5qsgWY@tissot.1015granger.net>
 <5108ca5a-b626-4ae9-a809-ae3fffb50cab@oracle.com>
 <a30b343f-b6cf-4566-9565-28a5fd5ca851@oracle.com>
 <ZgrzwVp4GrbmZGWt@tissot.1015granger.net>
 <86dd7031-744d-4448-96ed-6d3d9c2e49b0@oracle.com>
 <ZgwO9/3pwOoC/qIk@tissot.1015granger.net>
In-Reply-To: <ZgwO9/3pwOoC/qIk@tissot.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4257:EE_|IA0PR10MB7304:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 aDlowzrdV02IxMZHc5OtprJR8lvkuRW9m2M7ENQVh9pTekhD0cbXwYlvunteE/rr/KehOkTaATdi0Xq47WID7z3CQKDIqBlO6M+wYrUrrPg7EBs7G6RxPwuGluksPx5BApHKlnuhPjJa5b3xexYJIZDvZoo6okeGGboO5szMOiQEiGbmADFklk6sHvYE5W2WYWSm68Rlr4bRysNWqXyOgZrFV85onijVp/H8e+2UvrEhW8rKp4qBvO72xC1f4zqWtN+udgqJXbXEqXhJuuJIt/t2qfnIjYqGgSWKhlICrRVDwuejorswJg3S3bhSgl4I81hgzErRG3Pfce0pLwMfMAf0R63sRBaztKPVffFe10H60s8Mq+q1OR5DH1hAB3Uy4j3O2zUAtNSjMACatqd23HVN7EaQYyyvAMSybhUcIa2Oj7RRYTHubd8kN/2n26By0lWCfXj80fqu7YMhi16duHHSxAFtkcYeYGr7rvEL2Nm8pXHCzkGtdJOoJ45sN6VZgJOpWexgChyySSo6kVu8PsoWfGQ6gOrgCR8YQfRSRcH8LAyKNgiTIRx/KrVUDStGo0FHU50aMYLpROkhtGjScDcPZJULAdFwyInMkh7f9uTBhn/MPeOHdwBrcOLp3og8yJEQB5NLSketQ3DcOcn3h20VbJf3WJ6qmt/oyUzcCf4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZTg3cU1BVWNKdzA5U1RKaFo4c242WkxXTVRYaUlGTTU0bDU0MnJHYTJycUtO?=
 =?utf-8?B?VjRtNGdla0Y3bG9rY3JOaU5DRVhCWTJuZHNMRS9ZSkRWQ1R4QnlqQ21EMzNk?=
 =?utf-8?B?SllFQUlidEVuQXlWcW8wclM4QUFqai9zcFRidnBpTjFsemZEdzFQUUZRNEV2?=
 =?utf-8?B?S1pOakw3ckh5RXNWTWl1b3pQRzRXempZK01XOG8xRVF1RUhYK3cyeERZcm1r?=
 =?utf-8?B?MGRlSW1BajJRL2xjc1FDN3BhODVuQ1VFb1ZmTi9hd3hZK1hkS1gyaGhwWnE5?=
 =?utf-8?B?U3ZBWHpzUmdSUDV3UjR4VlEvQTc0eWsyVnVHemFDS012ZGJab2VzcFZ0K3kw?=
 =?utf-8?B?NmxPYk1oRWY3SmdubWh3bGpRNytEbG42THpzR285Y3lXZWd0bFZ4S1NPRWJL?=
 =?utf-8?B?VkZGTmcvMThOZ3QwaTc3azdEQ2c3d3ZYSS9uM1U2cm1JODBvWTBMMHhDdTJE?=
 =?utf-8?B?QWh1dU10Rm02RmR4YnhhdW5RSVNwNzZnb2k5ZE9RME9IdFVzS1N4djNOeEl5?=
 =?utf-8?B?dG5CMDhYRHVYOUxUMDZOektadFRraEgvK0g2aDYvTDdnOVlLcGpHZXE1ZWhF?=
 =?utf-8?B?U095NGY5ZCs4Qkl2MjhyZDJRbU5wRThjYUJyR3g2M281NEZhTzZhajBYcHFh?=
 =?utf-8?B?VkNGRDMyRmJabG0yeFBEVWlOQVZ1YU9qVGY5M3FJbHdDdzBqUFFZbmxuZk4x?=
 =?utf-8?B?R1pLTjgzL3ZKOGhrTndiME9CNnZXbzlHbW9BbW5tQ1VXZ2JIWnIxVHVZR29S?=
 =?utf-8?B?NDVFR3ppSkl2NW91aXN3Sy9DQWpmZnFyeDlMbWlhbEZjekF6TFVkVmVZMGFi?=
 =?utf-8?B?MW9aVlRkQSttOURwK0M4dFF5MWh0dXo3S1hzQ3FSWXg2TEs4M1JMUmR6S01r?=
 =?utf-8?B?U2tTckNDQXVzSEhMWW9wS1lYaTRNRURpc2FxQ2JPWVg5V2RDSGVYMHphVGk3?=
 =?utf-8?B?Zm8vcFErZS85eTJFbUgvTEcrdGJQT1lnMkE1L1B6SkVTRWtnYkNjb1Vib1pQ?=
 =?utf-8?B?S1lqcEhUMVlRZUJ1YkRMeG5JSnJZazZicHdhMTV2ZjhPbW9MMHdtSThubUdD?=
 =?utf-8?B?VmtLR2JrUHJKVy9qMGo4QUpZYmdFZUdLWTllN1B6RTEyZXdIb2lRZW9OOW1P?=
 =?utf-8?B?S0hTRjBiUlh0ME15d3BBK1pSb25sREMrbjhFUHBzVlJBRFB5QzgrMkZtMXpP?=
 =?utf-8?B?ZTlaVFU1NGVObnQxczlFZENjQWMxN0FhSDJxc3BXMVdUWDU1aW15K3MwQmdO?=
 =?utf-8?B?bjJpa1g1a25Fenp4aVd0aFBpeW81UzNZZFpjQXpiNTVRNDBxZ0tyWlRTM3h2?=
 =?utf-8?B?QUErMlFWV0ViMnJZeWEyWWdoSUpJRzl3eHFvd0dyN2hMamw3ZWZFeWVWTFRT?=
 =?utf-8?B?TnhGeTcraTIvL3hCM2FhT28zMjdxbHRnN1FIeGVSdmR4VlZ3b1lCdGE2S0NC?=
 =?utf-8?B?OW9FYk9kY05FWitiaTk5RUhQeFlhdVVnKzMwSm8rTmFFS0tPQUJWeWc1WTVu?=
 =?utf-8?B?Rk82c0NubkdXSVJMMjZlMzd2Y2xLTnlMQW1ZbitsdE55OVR3a2R2czhQQlI3?=
 =?utf-8?B?WjUvQkhUdnhYdk5URk1ldTlUdmhoN0tWeWhUaitRY0hlcmtidjJzMjEzZ3c2?=
 =?utf-8?B?dGhvUC9lVkNQSGxPZkN3WGdGSS9BTUFZcU9oNmtFbnFBUUNPU2FjeHpxVTdL?=
 =?utf-8?B?K2pkbWF3R3Jjc2s2Qnp4N0VWVFlleHNseFIwT052NXdOTU0zMC9MNkxMdkdS?=
 =?utf-8?B?WkViN0VHTmZmTG45RGxuaVFFbGFDYUZUVkFBa2lrK3dWY3pZOHJKSE50Q1pl?=
 =?utf-8?B?ZGs3WFg4bGVOcGJ0NTBnRG9uRlMzM3BYd1JsdEVtdWsvOVlhdHJsZkFWdzNy?=
 =?utf-8?B?NFdSQ1NER1ZteGY5Y2F4Y0VVZ2RVNEJJTkI2dWY4ZzRMKzdMV2lKemR6M1hF?=
 =?utf-8?B?ZXk3ZVdtZEZUWHBKNVJSTHh3eTBrNTViMmRVRVpsNjJpMlVNK29FT0hSQ3Fp?=
 =?utf-8?B?dkFjZFIrVkRQYk8zeWhVMWtKejJhRUlmUDlUTU5qZEhpaVNuK0x1TVRKNndl?=
 =?utf-8?B?VmkzZ3ROdTBydTBkZU5Pc2tkcHdXQjN5SnowQ3Z1NWFPZ1NhbzJLUW1Va3RP?=
 =?utf-8?Q?lZvxFzizZnbeDEOkRLA5NieqA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hlGy7gkvbehnBvqZl24IJAInXRjWDD3gu+93PIJjleOk4frqKTSk0vfkxYJeKuDUU3zNq2FmvY+d6W64BU2OhWdTdP5+EgGXTV38/FEyQBf/WUOWUp6qcSPKHOhS/6Zg+7HHqVpLou9zv5E3IhUQRGWvfFFxYWI7f1o0zOb63FOZLyfF32VjFvQRI3ybvgdg65nfS+43b76h/rbNaMPwHX90tP/wPOhnBiycOwZ+ilriheBXU/VeN32gA6nuwi56WKewZPUwceXwYPteHdRT2llEdZhpR2lrqC4FcJRZ28oChVoJEdflvvvbnGShKimFAXa92vyOXsa3K0FRzEmZxTPq6c1qL5/4ClHPizHx3M7Rdftwf7wKrR7QT0xZu9JcnG3Z375+TacbNFqj/ZhScJg7SEbRAHhIjVTEnQH3sk+lI5D8aBZeMF0MoIbyzpu53zkCeP6AJ1xelhwjBilbbThjoCGemfXGNtreXSMDEKAkeZNDIviXM8KqRghiGmuNxmJmu4heu5pgTfoHG5z6zQhtV+mmjH548aghKTeD37UEnX2KLNGtywWqPTVx9E8FZznAfGyLH4zIGUWIDhgJRGTwSp4JOVqBh0iEXea4XI0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69af9596-bf9f-4c4b-6dbc-08dc53214afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 14:29:23.6766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dh6dCA7ZiVbJUrH/TkBQuZ12DYyjcnHcQK2t7e+RD9E5Xe1vHGzgK6swFmHbokC+AJEKMB0KEUwlpQtzfMh2ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7304
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_07,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404020106
X-Proofpoint-GUID: PKAgjxrya33_-xwVkF-ZOXXjCdkrb7JV
X-Proofpoint-ORIG-GUID: PKAgjxrya33_-xwVkF-ZOXXjCdkrb7JV

VW5leHBvcnQgd29ya3MgZmluZS4gSXQgd2FzIG15IG1pc3Rha2UuDQoNCi1EYWkNCg0KPiBPbiBB
cHIgMiwgMjAyNCwgYXQgNjo1OOKAr0FNLCBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxldmVyQG9y
YWNsZS5jb20+IHdyb3RlOg0KPiANCj4g77u/T24gTW9uLCBBcHIgMDEsIDIwMjQgYXQgMTI6NTU6
MTZQTSAtMDcwMCwgRGFpIE5nbyB3cm90ZToNCj4+IA0KPj4+IE9uIDQvMS8yNCAxMDo0OSBBTSwg
Q2h1Y2sgTGV2ZXIgd3JvdGU6DQo+Pj4gVGhlIHF1ZXN0aW9uIEkgaGF2ZSBpcyB3aWxsIHRoaXMg
dW5yZXNwb25zaXZlIGNsaWVudCBjYXVzZSBvdGhlcg0KPj4+IGlzc3Vlcywgc3VjaCBhczoNCj4+
PiANCj4+PiAgLSBhIGhhbmcgd2hlbiB0aGUgc2VydmVyIHRyaWVzIHRvIHVuZXhwb3J0DQo+PiAN
Cj4+IGV4cG9ydGZzIC11IGRvZXMgbm90IGhhbmcsIGJ1dCB0aGUgc2hhcmUgY2FuIG5vdCBiZSB1
bi1leHBvcnRlZC4NCj4gDQo+IFdoYXQgZG9lcyAiY2FuIG5vdCBiZSB1bi1leHBvcnRlZCIgbWVh
bj8gRG9lcyAiZXhwb3J0ZnMgLXUiIGZhaWw/DQo+IFNlZW1zIGxpa2UgdGhpcyBpcyBhIFVYIGJ1
Zy4NCj4gDQo+IA0KPiAtLQ0KPiBDaHVjayBMZXZlcg0K

