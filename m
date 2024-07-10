Return-Path: <linux-nfs+bounces-4779-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4043392D476
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 16:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C781C20CD2
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 14:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF2115E97;
	Wed, 10 Jul 2024 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SwUdGXTY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f03mFTi4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AF91802B
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622717; cv=fail; b=gOVOqLvumrkzS1EfGk1FSCs/JFemRvKOcvYJbOWV5p1u6AHLfc4F5w1T7ycY4T52LOKfbCjP39JQsyima6sZuwaN3EzCMGQi6sJwgxzYh4c944LpKHQbczVj5zZKn0a9OWb9A5UcDZ/1/g6wEtW2A4lOJ85N7reShXR/rZ8E90E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622717; c=relaxed/simple;
	bh=FwJfn3PxeGUIte6sU59xCGc3WM78SnIXPlctyLX0WaQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lBf5GCfY075rksBHs+88dblpW3pN2Tj4R0T6GzD0NbZJZJivVbOlnKTxjx7soXAsIQeLzyX7fE99HkXryhZ31uuo60lzpF8ichW1d9tkLGhCtx0ZttLY6LgRY1hUjy1T3BKaoi1cc/jJRvWgsZuqXyD3RTMjtQM2aTgHFNG0RKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SwUdGXTY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f03mFTi4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A7fZhV004061;
	Wed, 10 Jul 2024 14:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=FwJfn3PxeGUIte6sU59xCGc3WM78SnIXPlctyLX0W
	aQ=; b=SwUdGXTY4+F9c6Cw2w+cjZ7fo/M0owPqCXuWNVbVGwcUR6sFy4p3JOXfc
	vrBJOjMaeDfbCdJD+88KWcDRY+9xj85nVK1z7QqZNVxEU0E2bcnL1KIpQLu0fHUj
	jT79n6Uk5BeHTJZoKHzL8yTUW/d6e5DzWv1GPHdNnKwEobKXXL8X4fYQmmcI2JE7
	ZIwY5edcIRrvipPyFTtM5pKmh/ZodwgmYpnkxXI7Vh54CK0C8DK93Vcd+ceLYcXm
	+lE4ZFoQ8wT4euigo7tDYMFmqDCJOXjMB+H8X0Tuid+KeyL0R7uD7SdlcsIDVYbl
	I9OJsONsZLxa4w2nYLxcfEbPYXf2A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfsqep9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 14:45:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46ADF8iZ037031;
	Wed, 10 Jul 2024 14:45:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tv32311-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 14:45:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3/nMecF42CDYA70sKRdgEagQUDbYqWceWCjboVa36otEcNJDDueLS0TK1dt45Bt2g9BHIYRAA5uxpGLDGjKPuar37bhNc7KuEH5wLWHhkzZ8f3nWBa51gCcBCJiI9FbmQwb9ZGj+i9blhKQBMC8uOPOdOOAuRZ3PDYCo4BZnhVhZQKeu7wYVcTShBU+lCJ73YSsTA5pmUhL9RL+eNqjuH/PT039kLihOTgHGKE+jPLuHU87VR0pLHLOYay8jbMga6VOKA7C0qVNXRs8nOIDapt4gtAkbJKFhDiF3SlgTuYVLUGm/Vvc4fMUcrNA4b2zslsy2gRBnmF4ULGfZ16eHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwJfn3PxeGUIte6sU59xCGc3WM78SnIXPlctyLX0WaQ=;
 b=SNbxOK+w5LXX5MYAA6CvASUj4L+zD+rc3S3cuXj7vUrU0XxvIQFnpxjPcsRfUaYOE42a+2bG/tUI62kM7wd4y2qsJCXUJ1BdT+GEUVxLEa1raiIWIKAGrc/tXZSLnx4+5UhUQkPW4MC4wS67WM1Yw8uE7OG7OHwCgHWzevtVfuh0TapI2HblG7IvK5NadmkCX7GijOADO53U8INzwjz0FpYqxL1IlyZdQuaYLRlhAI1Z2z3Kr1L5HMHjx8ETRM4A0ncHafu01rTD1uJr2i5uAd9C1XYBYs/zxNEU+O2RQD+fWDQ4yel5yWZb1I7OJRDhiBfeBFEdFv2DOsKqDdqvfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwJfn3PxeGUIte6sU59xCGc3WM78SnIXPlctyLX0WaQ=;
 b=f03mFTi47bpwOEpfG0h42aW0830/x5Cl/k0ZK5X7Oz+2IbStQxVOX8AiM5nySdxLdmtLC4vKrcfVWYGZDNWWcxT3VhR7IaiBR4VeZI8lENjJz8EvOrgdzSkWqOIrny2yEJtb7NDa1HXE6kngqMwVsGmwk6IKhO1C0/u/nYiPtuw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6544.namprd10.prod.outlook.com (2603:10b6:806:2bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 14:45:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 14:45:07 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
Thread-Topic: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
Thread-Index: 
 AQHaz/XBfwkxQ1O/ZU+jeIGo74rnYLHrG52AgAHH5gCAADhFAIAAFU8AgAAuOwCAAKE2AIAAbtIAgAEhhQCAAH6sgA==
Date: Wed, 10 Jul 2024 14:45:07 +0000
Message-ID: <9DB557C4-60D9-4148-9017-AEE32792BA0A@oracle.com>
References: <20240706224207.927978-1-sagi@grimberg.me>
 <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
 <9156BC30-78C3-4854-8BC3-510E586B4613@oracle.com>
 <3b4ec3b0-5359-4f95-81a3-1d558756bddd@oracle.com>
 <5a071e49-f214-41d3-b29f-aa1860b12455@grimberg.me>
 <e23bb0d4-7f83-45fd-8df1-b127e1f749db@oracle.com>
 <9b9430e9-845b-4e21-b021-cfc387cbd01e@grimberg.me>
 <53440FD0-58F1-4B92-BCC3-20CB91BB529C@oracle.com>
 <500c22cd-b88c-48e6-8cb4-732f66f8e913@grimberg.me>
In-Reply-To: <500c22cd-b88c-48e6-8cb4-732f66f8e913@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6544:EE_
x-ms-office365-filtering-correlation-id: f8e9a118-b56e-4e04-e588-08dca0eee493
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dmVoemtlYmxtNTdDSHFnbEZNQ1hUeWVyRjJqcDNwRWtkYUY4K1FwaXptSVFm?=
 =?utf-8?B?dlhPZkVBR0dPMjEwTXF5Q28rZTVjZGh6T3g0RVpTbDhHNHErRGxTVnR0L1or?=
 =?utf-8?B?eTZZL3NSY09SNVNPR1JPazlYaVQ2R2cvNGNOQ0tNT094akJYYzJDR2E2b3Js?=
 =?utf-8?B?TWVZTFgvMDMrV1NQOEluWW4wOFhzY0phOFdRV0pRejM3bXdHMXBOdEpJZW4w?=
 =?utf-8?B?U3M3R2RjRzhBNkd0V0pzazNLc1dkOGpsMVltRTNzMHVVbk5sYjNSblRYaUZG?=
 =?utf-8?B?S1dJVngvODZiVDg1azlCVnB2aVpocjhxRWF1N1lGRHlYWjdiQWhkUVNGV3Uy?=
 =?utf-8?B?c1hDdFZ5MVhqUU1nWTRjUjZzVkF4YXQxNUZSRW9YTWM0Uk4zZmVCOWxNWEFS?=
 =?utf-8?B?ZVVFMyt4VUJuTHczMXNqUmx3Y0pKY0xZNTFZRGU1RmsyR3BSbFFwV0tmMHBD?=
 =?utf-8?B?Q1p1bUxVa2ZRdTIzREdMT1VzL3FvVnZ4amNGRGgrS1ZwZ1ZxZnA5U0dHcVR6?=
 =?utf-8?B?YW1WTnNGR3hkM1F0UXkwOFVvMnFqeWxTWVlWR1Y0dzhpZVlVSzNZUjNQdVhR?=
 =?utf-8?B?aVdXY0dUWS9ZRUNoSjYvcnRyeDU2UzhRMWgzdVcxMU53M2ExSFNXamNUcUdD?=
 =?utf-8?B?Q1dGS1YxNWRlczhQcVVvYzlXeksvSklHME1jM1JJNFZzdmYvL3licS9rbWdh?=
 =?utf-8?B?NDJPTXdBd2RyK3FGdWdBOW5mUTQrUWpycHJLWDFkR2V5aFZxNys3M1pUWDJm?=
 =?utf-8?B?SG9kYWRoVXN6Q0hON3FtUGtQUS9jV2RzSW1IeVpweWhMMjZnOFFjNDU5Y2V2?=
 =?utf-8?B?bzY1S2NuQ1dRb2JmZHlpS2ZJMmdFdmRIdjh4Nkd0NkJoTnhYSTFLVEVaTkJm?=
 =?utf-8?B?dTVZYTUxQkkrQkNnTGZ2bWoyNXJ1akRyV2lxOWNPZ2s4ZnQ2SUsybVd5MlJJ?=
 =?utf-8?B?ZWdnV3RtUCtMdUhoYStOVGR1QUkvWDNSZnNHcnVxZUpPZGRxdExVelBKcWov?=
 =?utf-8?B?R08yMXB3RmF3anMzekhtTnp6Q3FhQ21WWTFhVkU3R3RzSHlwd01MQ0tXZE5M?=
 =?utf-8?B?ZmkwdzYyZDkxajE1TkJiVy9SaUlwQXNRdUl2cUp4V0pwNU0xdjltYkJmUnBW?=
 =?utf-8?B?ZzRCV3pjZ0R1dkxMdWJmME9NLzBNVDR6TlZ5Zy9wVGdEZTRScnRsc0ZtS3pk?=
 =?utf-8?B?ZjI2Y0o1NzRWUlkzVjFwb3FjQlQ4YTlWZTNlL3g3QzlFck1BWFVDNUtjUW5E?=
 =?utf-8?B?R0tTT2t6Z2VGVmhtRlZvWWY5R3VvT3M5bUxRek93V2pZRVZrRE1MSUlSSC9Y?=
 =?utf-8?B?aFVtcUMrTUJ2MVhNMnpWZjBreFM2QWxoczViT2VUTmtJNGYwN2JjcGtNcDN3?=
 =?utf-8?B?TExGOVFNazBlSTV0WWIreE5oZTdjNzQrV2ZSc0h1TFRURGsvSVZRSHZ2YWpl?=
 =?utf-8?B?RzZtZ3R6YWdkUkM1VG8vTm9tOVVyNzkrS2lRUlpUNk5ValhuemFrNy9USXU1?=
 =?utf-8?B?bThCaFZ3M1Nmb0ZscVdMMU4xS0lHOUNNK1lsOWFTU2pNaWluMEY0bDJBM3BD?=
 =?utf-8?B?TVF1djZ6NE12alRMTXoxQkRmVXBBNk42NzhlSXF4N0huYjcvRU94cVVmeS9k?=
 =?utf-8?B?Qmd3Z0syWTVqVU01Z1RZZ3ZNVHBhbURYOVY0Z3VBMDZRMURGOW1jTWZtQmpu?=
 =?utf-8?B?cEVmb0tueFo4YUZvMFRZVFAvbDdmR3pLbFBhWVROQWlDMFFyNDJFTU01V0c3?=
 =?utf-8?B?Uk5zM2g4R3dkcklIZFBKSFhDRkdlcmFzb1JyRHF3alRlbHdSZnBGRklMcGdY?=
 =?utf-8?B?ZWNWczlkZnRzZFZkMFFZbEZXTGt4RG40aWxMRzh1MjF4ZFZ0eDEzcHZEMS9D?=
 =?utf-8?B?aG40c0pPSkc1ODArZkllSEUzNnNVekdhaWdBZzNwVnc0bHc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TGZOUGVjbHV6TVVlNnhhSXpseEpPdzhZOGZIL3ZhSUxyc0pFU2cwSW1aSzFE?=
 =?utf-8?B?OGg2ZlBVU1hhYXdWN2ltSEQvcit4aDBKdElBcTFEWTlrN3lsMUo0VlhKdUQr?=
 =?utf-8?B?MjU0SXBDcWY5cDBSdzJBUm5OeXIvWnluc0ZBN2dxZ3puUnFHNlgzeDhXVEZS?=
 =?utf-8?B?OGR5dFZXbGVMeVBEc1l3MGpCcE1Hc1lHNDJuNU10dTduK2dDaWt6L21yczRk?=
 =?utf-8?B?ZTRhZzhWOENRZ2owZlZsTERLQ0pjdWhjeVZvYW5oODFLcmxYWG41YU44UXdI?=
 =?utf-8?B?bmNubDFrWmp4WFhZM2VqeTlZN1AzRVd6QzI2OFQrbE92TWxyTWkrbnE1OHZk?=
 =?utf-8?B?cHJqNU1scDlWNlcwK290V1A2YStPQ0U0MFFDbWtqamtTdFF6eWoyK0dSL0ty?=
 =?utf-8?B?d1hYdGlwRHN5TkVKQ3B3ckNzWk1NT0JTdUFQMnlTSUNaMGpPc0kwNTFpQUEx?=
 =?utf-8?B?Qnp4SkttaDNPbVBLa3BVM3ByOUhDNEUyVnVRdDVZWmE1dnA1citBMWU3bnpj?=
 =?utf-8?B?OEx6S2tBOGpGMEFtL1NDa1dwcWU2UzVUWDM0ZkhIMnk2QUNMWjNxRE5IK2R0?=
 =?utf-8?B?Z04rYmVGY0ZQNWQ0UXc5SUdZVEUzL1ZGNjBEMzFEc3Bxa21aMlJVYU0vbmQx?=
 =?utf-8?B?UkRWQzkyRjkrOE14WlBpTkFabEZXY21SdzBYLzdWM3ZEbDliOUVmMnpHeUpO?=
 =?utf-8?B?U2FJbHcvdGl1eDllVkFINkNWKzNkalFXTENiVmp1YWUyMUljMyt2MXk5cXZo?=
 =?utf-8?B?MFZiT3VzU2llME1YRG9ja25QK3dqT3ZaOGRoWFlSMnNsSkkyaEFuYkw1eTlM?=
 =?utf-8?B?UldmOUZBek5FdjRWdFc4TVd3eFhhSVVCREh5RDZXTnArQmNoWmlTaXNHTzVV?=
 =?utf-8?B?Tk9uL0ZJYWd0TmlJODUyaTVTWE5DYnltUGtoYjRiMXBOSkdXUXM2bGp3c3Jh?=
 =?utf-8?B?NEpxTGxxSVI4SDNwaTQ2QXo0d2U3TWVoN21Zc1VGQXRNcEJXenBEaHNSOWJj?=
 =?utf-8?B?MXJWREZFeTVITXpHMURwbU84N0tlTXI4YXVzWVBIQkJYYTdFWkVUZTBnOEU5?=
 =?utf-8?B?Umg4T3JiWTQ4K1F4UFVnb1V3UUUxa3pEdkZJTmU1SWRDZFBkak5kL3dBUXhh?=
 =?utf-8?B?UlJYVDR4Qnk4Rm9yMGRlS2NDYlJ3WWt1QXpKN0JJcGZTOEd2WkxRd3owbmNn?=
 =?utf-8?B?SUVpc055QStzTENqV3ljL0JjNkdnb3BxSS9Ha1pvR3kxaGNDcjZYM1A1enV1?=
 =?utf-8?B?bFV2ellmcE1TVzVqTXlkRG00aFNJMnFZaWVLYXY3ZUJuWS9peUhhMEozbXJU?=
 =?utf-8?B?VFVBbmNuSUpYcWNWRlNHNWkyWnFhZERtbFpVdXNZWUNyUmRUYVVjaEtZekNy?=
 =?utf-8?B?OEZqbmltYmhuQmx0UExnWXYvK2JaMVV6bENiOWJwbkZpN2VldHBvOHBTNkFp?=
 =?utf-8?B?eS9heXJZOHZjc3IyaTVVLzNxZ1pySDk5T25SNHhTVTFQcGJhUCtKa3VleXNl?=
 =?utf-8?B?aG1qWDBVSFh2TDBVZS9QSXQzL3d0b1JHUERQRmhOOTNjWk1CZzVrSnNRRWRi?=
 =?utf-8?B?VjI5TWpyU2JkQU56K3hUdDhNQmRnTFNWeW9WOUJLOEJuOWhkdDFiOXN4MmZ6?=
 =?utf-8?B?dXZOdlpZVUxFK1dIWDVBWFhFWldiekswQ3NHd1J6TFFrczRob0E1L1BsbDZQ?=
 =?utf-8?B?RFU1cHJIUjR1TVlUSlNJdFRXcWJ5bkE1ZHlJUVhTTDk5RVZ3RkVwTTdyR0dy?=
 =?utf-8?B?QXdrN1RDNTVrc01NWC9JUkNqQ3NTZlBGZWdLdnNVbEt4aFI5U25kMDRHUk0x?=
 =?utf-8?B?UHoxNzQ3N01FUEpvb3grWEZJc01IRXpIZ29XTEVZbmVWbVUxRjM2SDN0cFlx?=
 =?utf-8?B?VUtxVFd6OVU2QXJBTU9wWUt4YXVubldKK0N0ckE0WkZMY2sxeWhpTExvMDlB?=
 =?utf-8?B?VnFVdkFkK3NiRzBYZWU2Yno0NURETFVkYVFFWXNlajBSK2NOMjhGYlMvNUdN?=
 =?utf-8?B?Y1JObHQyaG5BbjVyNThKOU01NDlCRkEyMkxiNGk3eENWbFhuVWZabndDQlUz?=
 =?utf-8?B?TUxaVXdmVEp2enROMlhhVXdydVF5RzFDVDhQWGp6a2pWU202U0VpTkQ0czJi?=
 =?utf-8?B?MzJ6SGxLTW0yUk1mRlIxbXpidkpxRW1lOElYVldOcWxyK1FhWm5ua2ZCWVo4?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B40B2458135CF34988EDDEAC09992885@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FSY0Qop+BwQ50PZNao1EC8JA7OFPepQtCF/doBL97KjAhkH1hy/BHQcbYQ/3x3YHeHwRLwK/DX1Ijqc9vkSYcCSpSzzX9UroJWlEPrNR3eOXoyoP27Fh3lUwVfyvineDuXQ1yy0UjCW7oQ7RcZCcyaO2mdqYa+8Q5LJvp3PJScAEUiZKeSAFH7luMPOg/9yIGZzD34Dey7yCV199i3kL4OcFxDS5HYUEqplzo4mbz8XZBAjKbceEplKiEdp8utF4nZyXT866S00thC/wLs95B0belgjClO+hr4kj2G6gO1TUWvknSYOnUDCj60rlnJWWF4d3Ie1Op/x9QoVFgx+cbaR20qhU5LfqF4q0fGdlN0FB5+d9wCdZjZK4MMaZMn6GwEd7ip4JtmdaUtSeSOd0ejs8c5No1lbbOJgmGX6MTfQj/GgaLVHvm7285qOLkBl6zVJE0eg4syqfj3UWEPSf0fLaLLwxsqNsr6J1PRVU+7UNJ28r4i4l/uh2k9x9u5G81XBkoKlbSjEK63yOP6V/9RyQNFG2dq4rs8etoWH3LlY7sPQa9ojs+eT3lonPe1SiWsV/hdiZM+COZnkVZtb21Cx+ERanydP3wrmE7KqG9Z8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e9a118-b56e-4e04-e588-08dca0eee493
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 14:45:07.7001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A00RclQMXXy02vbQ0/pGwY2g4/2RHiyoev/OLErPehOdJd0tflR4/c6rru//YQ3c0p6/u11qY0EbQ6+9a2N2PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_10,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=876 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100103
X-Proofpoint-ORIG-GUID: 6s_AH49UjLdINL8WEveFwnA2ct4M3zyM
X-Proofpoint-GUID: 6s_AH49UjLdINL8WEveFwnA2ct4M3zyM

DQoNCj4gT24gSnVsIDEwLCAyMDI0LCBhdCAzOjEx4oCvQU0sIFNhZ2kgR3JpbWJlcmcgPHNhZ2lA
Z3JpbWJlcmcubWU+IHdyb3RlOg0KPiANCj4gDQo+PiBZZXMsIGFzIGFuIE5GU0QgY28tbWFpbnRh
aW5lciwgSSB3b3VsZCBsaWtlIHRvIHNlZSB0aGUNCj4+IFJFQUQgc3RhdGVpZCBpc3N1ZSBhZGRy
ZXNzZWQuIFdlIGp1c3QgZ290IGRpc3RyYWN0ZWQNCj4+IGJ5IG90aGVyIHRoaW5ncyBpbiB0aGUg
bWVhbnRpbWUuDQo+IA0KPiBPSywgc28gcmVhZGluZyB0aGUgY29ycmVzcG9uZGVuY2UgZnJvbSB0
aGUgbGFzdCB0aW1lLCBpdCBzZWVtcyB0aGF0DQo+IHRoZSBicmVha2FnZSB3YXMgdGhlIHVzYWdl
IG9mIGFub24gc3RhdGVpZCBvbiBhIHJlYWQuIFRoZSBzcGVjIHNheXMgdGhhdA0KPiB0aGUgY2xp
ZW50IHNob3VsZCB1c2UgYSBzdGF0ZWlkIGFzc29jaWF0ZWQgd2l0aCBhIG9wZW4vZGVsZWcgdG8g
YXZvaWQNCj4gc2VsZi1yZWNhbGwsIGJ1dCBhbGxvd2VkIHRvIHVzZSB0aGUgYW5vbiBzdGF0ZWlk
Lg0KPiANCj4gSSB0aGluayB0aGF0IERhaSdzIHBhdGNoIGlzIGEgZ29vZCBzdGFydGluZyBwb2lu
dCBidXQgbmVlZHMgdG8gYWRkIGhhbmRsaW5nIG9mDQo+IHRoZSBhbm9uIHN0YXRlaWQgY2FzZS4g
VGhlIHNlcnZlciBzaG91bGQgY2hlY2sgaWYgdGhlIGNsaWVudCBob2xkcyBhIGRlbGVnYXRpb24s
DQo+IGlmIHNvIHNpbXBseSBhbGxvdywgaWYgYW5vdGhlciBjbGllbnQgaG9sZHMgYSBkZWxlZywg
aXQgc2hvdWxkIHJlY2FsbD8NCg0KRm9yIGFuIGFub24gc3RhdGVpZCwgTkZTRCBtaWdodCBqdXN0
IGFsd2F5cyByZWNhbGwgaWYNCnRoZXJlIGlzIGEgZGVsZWdhdGlvbiBvbiB0aGF0IGZpbGUuIFRo
ZSB1c2Ugb2YgYW5vbiBpcw0Ka2luZCBvZiBhIGxlZ2FjeSBiZWhhdmlvciwgSUlVQywgc28gbm8g
bmVlZCB0byBnbyB0byBhDQpsb3Qgb2YgdHJvdWJsZSB0byBtYWtlIGl0IG9wdGltYWwuDQoNCihU
aGlzIGlzIG15IHN0YXJ0aW5nIHBvc2l0aW9uOyBJJ20gb3BlbiB0byBiZSBjb252aW5jZWQNCk5G
U0Qgc2hvdWxkIHRha2UgbW9yZSBwYWluIGZvciB0aGlzIHVzZSBjYXNlKS4NCg0KDQotLQ0KQ2h1
Y2sgTGV2ZXINCg0KDQo=

