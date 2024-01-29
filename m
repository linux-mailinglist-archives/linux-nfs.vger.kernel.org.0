Return-Path: <linux-nfs+bounces-1565-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E61E840A99
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 16:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F7928C3A3
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7859660EFF;
	Mon, 29 Jan 2024 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k4nn4V03";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IAIJiJtj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4E160B91
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543517; cv=fail; b=Z4dAGR3wp/wJKVKl+a1HOLA0yiW+MjMzAOEVSIcWh6fA1ktrxy/aHl9CJu066lLPjj8wj22lThkVB84iFTMBM+51ltduS0gHEGX4DzpppVYb/lAF61h+7cNucqqSTuTQvlxdwkw1xZyQ54GxwoYC8smrJFFb86eSEy6mPtBXwxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543517; c=relaxed/simple;
	bh=omuHlhChEiGmTQ1WfUfDNHp5qN2GNMMWye2PPE+WyX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rBtRc/qtbkyBOquEVAMVZo6zN1KZDuCwbvgpISDXAuQvEGqMVKFtjNEQSyzd+OWgD/0/Bxdx5YKmG/Q/WPym9/0O8X4Aq+NvaRNLMFsGwudCBlSw3PMjKn3bZ7swq08HKbY22/fLmM951LhC+WnTU5ZUrVBDrcxnOsumpb05iDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k4nn4V03; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IAIJiJtj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40T9iXet015992;
	Mon, 29 Jan 2024 15:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=omuHlhChEiGmTQ1WfUfDNHp5qN2GNMMWye2PPE+WyX4=;
 b=k4nn4V0365gmmUj3FDsfpKXl407omIvzP/R98Yff4G/zSkK1P4mo87YktwFLFUF9jlzk
 DuCJ/jOA7GBQJiRTgGB4opFA47t1etbc2+tEDP9kJDGT8ngMuDg3C+T0/9KHBhc4+WbE
 4Cw9xG1LsmkPaukWPF97v4F+L01mTCd+s7TaaOcq7PlxvTakkYX19LKen/YIRpTxN0Xc
 A5RgIAJXZrW5WWR6qOw+6NNhBpHbDT9eEMMR/INw8FUnSvya459aiSNJ4gT4EFEnUNJT
 6uztODDweqmvGt5MjgvE/kEpRwg4SUdINXKcPojwSfakExWcgEC5aHFN3yg5p0WPbys6 cA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcuv6rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 15:51:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TEpvkR035318;
	Mon, 29 Jan 2024 15:51:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9btv6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 15:51:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfiFEDYIcLsHALnQJbfPuJ3l4SqP26YHDcZ7xc7acreTtxMltPCQO3ddDN+/QgwuAsZofV15WLKf7q/bREMDV3WFlBkFGKKRNCZkWGtTB4XJFwP+WvWnWzFDvE7DPCyyhg1Cx6RUYDQhK9OMdpQ5tUExye8+ftV28728vY+AJTrxz9X7a7oguT7ezMTzcAKZsR1EPgN4EhHqOth/+4O3S5UERkMNvJ6GCerNbYmel8w+pi1k1QbGHU7AkT9Njwh4QyXkAGQRIlmDK4bVJxOFZKURLaRIxMk6Zj1PblWY6VQGBKgNfn1MZnTymXJaAcRVRxPTkSdGM3PlW9DogetKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omuHlhChEiGmTQ1WfUfDNHp5qN2GNMMWye2PPE+WyX4=;
 b=fY9B0kynqaKWOoGxEALcJuYQng7ZfhOTtxMgW/i2azk2F8kKS5NlZoxQtAD+68kRHhH0obtIyFe+shSgUMpYxbsjbNG0q5hxZPCf4HU8m7jIMIywFJSDscR3PpK13zRWXq2P84DSA9Xkkc9B1bIiPism3i+ciJNUp6iw5ANz/pXGN5qbeWhH4e/BOR1Mu0+UNCTDd7vlJcC4PJkgWsaRAhfxgAxOfLPq7jT/kKUOOGIKvHuLVuYo149cWDyk8ZNMGCP5I4UyA8504fV85SxiG42UdWrGzqOPYh8+aYBIJjCXwCNcZlMGRwNwqx5XSpBmgmE8SUxPyZxfI+OrVyVS3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omuHlhChEiGmTQ1WfUfDNHp5qN2GNMMWye2PPE+WyX4=;
 b=IAIJiJtjAtDh8qr7b+Uypwf+3XhFLoJ3P/7CGOKToaAnz48p/k4Nvfc0uWl+Tob1/smtQUyJ37lCckcytBkHQ5Jt6gPYeTkwnKtVIcTFdXvphPh2oyAWnfT6JeGs0Yljm7GNCvgq5xYSnejeU179hIpSQSyARzvARaQtGL1nAFQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6860.namprd10.prod.outlook.com (2603:10b6:610:14d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Mon, 29 Jan
 2024 15:51:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%6]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 15:51:48 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Roland Mainz <roland.mainz@nrubsig.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Martin Wege
	<martin.l.wege@gmail.com>,
        Cedric Blancher <cedric.blancher@gmail.com>
Subject: Re: refer= syntax in /etc/exports for custom non-2049 TCP ports ? /
 was: Re: Change "hostname" to "hostport" in text-based mountd downcall Re:
 BUG in exports(5), no example for refer= Re: Examples for refer= in
 /etc/exports?
Thread-Topic: refer= syntax in /etc/exports for custom non-2049 TCP ports ? /
 was: Re: Change "hostname" to "hostport" in text-based mountd downcall Re:
 BUG in exports(5), no example for refer= Re: Examples for refer= in
 /etc/exports?
Thread-Index: 
 AQHaDXJPkaKnFSGKLkeVN9xiH7a/Z7ByuFQAgAAI+gCAAALcAIAAGasAgABndgCAAK6dAIADivKAgHm3SACAACn/AIAADsUAgAAMSoA=
Date: Mon, 29 Jan 2024 15:51:48 +0000
Message-ID: <BCB4C051-B76D-4025-A3FB-78B2F2D069BD@oracle.com>
References: 
 <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
 <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com>
 <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com>
 <CALXu0Uf2z3um+kh=tgnqskr-ZdY2gU=185K3Amr=F_GJpb2_UQ@mail.gmail.com>
 <FD981B2C-5C24-4349-A279-C70F640C0A01@oracle.com>
 <CANH4o6O=ihW7ENc-BTBXR4d4JL0QJjZa5YdYaKAdoHdq9vwGcA@mail.gmail.com>
 <5DA015E1-50C6-4F56-B4E7-62A4BE90DBA4@oracle.com>
 <CALXu0UcLV-KZ4GNY8UgWCwiUOO_HsH=KLWOKuWJ2uEDP+a9sqw@mail.gmail.com>
 <CAKAoaQ=FDdkTW2Vh=_Y08DEWZYaJa6tDSYKnFiZCfQ6+PW_5iQ@mail.gmail.com>
 <610FDE39-3094-40EB-B671-F2CA876CA145@oracle.com>
 <CAKAoaQkdf41emWL-2Uq9_kFjF99Xc7UEK_ur0MmnfFAjJqLM7A@mail.gmail.com>
In-Reply-To: 
 <CAKAoaQkdf41emWL-2Uq9_kFjF99Xc7UEK_ur0MmnfFAjJqLM7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB6860:EE_
x-ms-office365-filtering-correlation-id: ac2a5319-1c43-4020-a963-08dc20e233bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5qlP8PajE8grrmyVRTFit4kkDpzLsoIkOO0O/hi+voPiuYC3HeNzLCSwtexBCfXuWMni8Bnw/I44W3eUZmboNmzWLi+YXo83NDVmnbYrykxjOMhjsOQs8N4cCgzbfuwW3dzuKTM3x+peFwXM9ogiWvdKq6f+4WrmVqusgnFVSZ35drtRhfVmnG5D3Glz8r+ra25sjBTnmFI07OMtJEmiubn009YnmxkboUUV9dlfcrxCTgW0urBoBFQIgsTrPhU1uaYe9n07O3sZzVckjsnYOekySczs/GLkGA/HYo+IBtoGnLxdu8pHwnBihQW2EjbzhwSjYFd58uJyo3PsL/2U1vsuVoYrB3Xp1lVU8YN+tXQ6XugFnsB/aqni8VvrgNjMAgCm9i9aBcEtUrvx/W/i08THcSLfZL+zANJcd+AS6yb5s0wVtk9IIjj7s/W8k5GeY5TN3yp7FJcocg6Y+3qiW60W2f/RYSk7ohy899ePSQS15IwY14PuOSYVjsSA72mUSdAQyEr4CclDXa8XX8wKde41XMHBr6VowaRHIkQRBGI4KsS19WukIuPbVWTV2/WRihEuworhfV2KRD5zuBWr5evW+f2stZte1N+RHsQpP9T9o8OHzOLiReqVYha+/piYQ0z9Wq7qSzW2be4jBku/9co40PJnK+jv7RKBijUHrfF5SiiD6eqvR9Lrvyqska41FHKkAgPnAVQqJVk8cy+U4w==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(33656002)(86362001)(36756003)(38070700009)(122000001)(38100700002)(26005)(6512007)(2616005)(66446008)(66556008)(53546011)(6916009)(6506007)(6486002)(2906002)(8676002)(478600001)(76116006)(316002)(71200400001)(54906003)(64756008)(66946007)(66476007)(41300700001)(8936002)(4326008)(5660300002)(148773002)(45980500001)(47845010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eUllcUZzTjR5OTRlTFdGS1hZUk1RdnVmWFZSV1lIeUdoZ1p3NVFHcmI1a3Ja?=
 =?utf-8?B?OXZQR0lacGp5K0JNNkxJdkNiNFpQcGlaRHpaRUNvdmRqMWtnRDViUXkwekRH?=
 =?utf-8?B?VjZqanVHY1A0R09EMXlXV3R3MHZ4MXZZNUliQWRweEdCeXJYVnExQmFvckdk?=
 =?utf-8?B?ZHlSUXVNVnRRTC94ajRrVDZJdTRYQnMxemYybStsdG9wVzlzWTM0VWp4MmR3?=
 =?utf-8?B?V3R5aHJpazJSQzBhK2JUeWNaZ21UWU9iMzUycmNQMm01VDhrTGdFZmx1VjRP?=
 =?utf-8?B?OEgwWktWZnpRTnNNYm1wcE5zcWZlclFGUUFEVG9OU1RHQWJwTDVDbTNCMGtm?=
 =?utf-8?B?ejQ1M0VHblhyQmFENFRSbnFrbHpOUVo1UHRvVEVneEFmc3dTd2xMbm5XT0hu?=
 =?utf-8?B?dGdlc3dtMXdvbXU2SmoxbVdHdXZ6NTh2Z3RDSW9HQThsUk1wSFh6WG9yNnhh?=
 =?utf-8?B?U2o4RElrOEVKUDcvWHR2RGVIYzFoeUtpQXlxb0pSSms5ZEhtREhTNjVSbFRh?=
 =?utf-8?B?ZldabUlPRFJwV3Z1U2FTcVRrK3pqQTArdkFFcU5TeXl6UC9TUlJQYmQ5Yldm?=
 =?utf-8?B?bWd5NUxjM0RSTjk3SzVONGJ1b3Q5bXJ3dzJvdUFCenRTbGZZYkFxZHVYaUky?=
 =?utf-8?B?aHFVUVV3VlQ2RlZrMmFaRjFPU3lBd25nNGVmWjNUUUhOa3l4UmxSTklSWksy?=
 =?utf-8?B?L043YWlQdDB5eGtBWnZUZ1F4clE3OUwyNFpGMHdXcFZYUnZ1RUhuRkFBREV1?=
 =?utf-8?B?aXU0Zk5zbjNmVTcwMWFQSFdPR3c2eXV3cjM4S1RUd29qOVlJeDZjb3lhU1o1?=
 =?utf-8?B?WmxuelFCVVlObnVVVkx4RmFGeEtMTFE2YytWYWhvd1R3eG9nT3IxTFEwWlZ2?=
 =?utf-8?B?aEV2K1p1QU81UnJPcFd6eFUySDl5bmJ3RWJqYzY4VEhkNHNPVzhSWDFqNzkw?=
 =?utf-8?B?akhPbmNLOFE4YWxLY2oweVBWNlZsRTZ3RGdTWThCUWVZT0tINmgvQThPaU5z?=
 =?utf-8?B?a3dwaDNicm9OcWszaHB3Z0lKS1FEZlMya1RTREN1bURFbEdFL2d6NS9zUmJ6?=
 =?utf-8?B?dUt5a0dwWE1ZYlQyb21FOFdmWTFvdHBHVXhtdktJZUxFdEdneTRqMFU5bEk2?=
 =?utf-8?B?VWlIc3FWeVp1dXE2elZ1bm1BR0c2TEdRYUNRYzdCeC9XSWhPRldxWFRiZnR2?=
 =?utf-8?B?ODZvUjlseCszWFhUTVVzckxaa29MM2UyaVFzOU93T1pqU1hGc2hLWDBsMVFE?=
 =?utf-8?B?V1pvUW1IcC9yclltM2tRcDNMdjJBU1VNR09iNW8wbGlSMzRzTTNhS0dlUy9a?=
 =?utf-8?B?enFCQ0U5NnM5QmFubWh3NHR2T0ZBbUJRMU5rQzJtUlhpRzI0Z0M2TDZwUDlj?=
 =?utf-8?B?eCtOdXpMeHpDL2VRR2lKN2RFTXQwUjN1YkJXRXhRZjJNMXBqdjNwbThxUEVB?=
 =?utf-8?B?VXRJOGovcVFUc3REY2JHQnlBVUFJWWQ2Y2tEUER6UkRoc3dSalo2d1VqLzBB?=
 =?utf-8?B?U2FNbElTdkxKZmJGN2tmY1N0bUUxWFdLNExpTmlIQjNjTTZaZzlBLzNIdmxF?=
 =?utf-8?B?UVFXaGNwMThYeFIzNXA2SWRreGtDdHVaMU9TTzExeFpKMmVud3BpWWg1STZs?=
 =?utf-8?B?YUJMRWwwa04yV3ZWVEg5eDRTSUhSMHg0eEgwb1FsSktnVlh0cEJpTnZNaXo5?=
 =?utf-8?B?aHVmVHVVc2FKZFhFL0w4THNSUGsvWjVweUJGc0dSUlpuem9qUXZTSklGVnls?=
 =?utf-8?B?NjJaNmR6UE1WK0I2T3NkQ1B0RW1IZklUbUd2STJkQXpBb1FnYVFmaHNaMVZj?=
 =?utf-8?B?WXdlU3FPL3dRUG9TSXlWcEc1cjE4OUVQTlFMZjFwc0RaUUc1Sk1lTjZNc2l2?=
 =?utf-8?B?K0JoQ1RlbGNvdVJkMzE3YTI4a2hrZnEzRnBhTVdJUEppeWpsRk1rd1pVMXVX?=
 =?utf-8?B?d1AvUUxBemtkK1RoMnd3bjdpVlB0SkNwWlNKZE9nZnprM3dmdHJSZWZkMm83?=
 =?utf-8?B?L2FZaU9PcDl3MTBSdjdaMWV5UEtYSktBdjljU3lzYTZWVjZBTjloQkxKaTNR?=
 =?utf-8?B?cis1VU5aN1kxT2p5emZwd1BXOTVVemgrKzlPeWcyN1hDN2Foa0xsbUVLUDlO?=
 =?utf-8?B?OXg2QnYvbVhmcG5oSFlHcE1HbHVROTZEYTlmZk5TZFNsRXRTeXFUc3VjMmt0?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A12300F5A3E28D45A82E7C34D81703AB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ItHeM32R9vakb4xxxTbaFUXXs1w+v5wkPh8Ei5/twfDfLs8/SnJR9sTjpscEHs05+QmY9RK7icPiywRmoBMCwfYRJWYYF9IEc9VC5PH370v5rW9wVK2nk/iqis2gVdGFK6R46S6cUgcXjPkbca5r0M0yTnt8xI9CZB5dcrGEr6yZPOGRrFULGCrL2d4TR/8OCts4tyIRhmZB5MGp47UHEPLxBtwBgOj5f1aUwyJTnvkhwU6/0LSklQ4NOPO4LdgWC+1Nx4n+rQfs9ZNzCNeQ2zoVBZH3Xmvs+NYwgKoPdGoyuyol/qldGcJu14AW6nDv4pvXI84KkZsGdtVeECp0EgDBXTas0/DIWdGsClpGty/yi5+kUhY783yyxAGWGrwGFly0s4frYhtr1EKwUABVE0x+u2XJtAe1/b2fl5LF77kPEWJkV5zD/b/dPBAfkw2gI4LzPUI+2ivFgC3C768YUhPZXy7zJylc+J3tLifwC9TVuhh2m/jtFIa9LWKBpHtl0BRqByhBRRq/UhGaziuAIR9/p+A3xzYZo16o8IZoNJSq9Gmtnd4I2FFkvd1gY5B+c39z2XrZX6XaAQ0L+5GCQxBwrQN+3ENgKRo8UjdKRjA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2a5319-1c43-4020-a963-08dc20e233bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 15:51:48.2483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5o7XLrW2XDiu7onTJv3WIXwpqacPybTtEqhBTGgS+7T8lF9g9H3dgCcT5Cd2wUkKZMhu1kq1cYwgMPk+LiY5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_10,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290116
X-Proofpoint-ORIG-GUID: zamgej6WFwlOfR0BOOLKYEVGccgB38HS
X-Proofpoint-GUID: zamgej6WFwlOfR0BOOLKYEVGccgB38HS

DQo+IE9uIEphbiAyOSwgMjAyNCwgYXQgMTA6MDfigK9BTSwgUm9sYW5kIE1haW56IDxyb2xhbmQu
bWFpbnpAbnJ1YnNpZy5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBKYW4gMjksIDIwMjQgYXQg
MzoxNOKAr1BNIENodWNrIExldmVyIElJSSA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6
DQo+PiANCj4+PiBPbiBKYW4gMjksIDIwMjQsIGF0IDY6NDTigK9BTSwgUm9sYW5kIE1haW56IDxy
b2xhbmQubWFpbnpAbnJ1YnNpZy5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIE1vbiwgTm92IDEz
LCAyMDIzIGF0IDI6MDHigK9BTSBDZWRyaWMgQmxhbmNoZXINCj4+PiA8Y2VkcmljLmJsYW5jaGVy
QGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+IE9uIEZyaSwgMTAgTm92IDIwMjMgYXQgMjA6MTcsIENo
dWNrIExldmVyIElJSSA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4+Pj4gT24g
Tm92IDEwLCAyMDIzLCBhdCAzOjMwIEFNLCBNYXJ0aW4gV2VnZSA8bWFydGluLmwud2VnZUBnbWFp
bC5jb20+IHdyb3RlOg0KPj4+Pj4+IE9uIEZyaSwgTm92IDEwLCAyMDIzIGF0IDM6MjDigK9BTSBD
aHVjayBMZXZlciBJSUkgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+Pj4+Pj4g
T24gTm92IDksIDIwMjMsIGF0IDc6NDcgUE0sIENlZHJpYyBCbGFuY2hlciA8Y2VkcmljLmJsYW5j
aGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4gW3NuaXBdDQo+Pj4+IFllYWgsIGluc3RlYWQgb2Yg
d2FpdGluZyBmb3IgTmV0TGluayB5b3UgY291bGQgaW1wbGVtZW50IFJvbGFuZCdzDQo+Pj4+IHN1
Z2dlc3Rpb24sIGFuZCBjaGFuZ2UgImhvc3RuYW1lIiB0byAiaG9zdHBvcnQiIGluIHlvdXIgdGVz
dC1iYXNlZA0KPj4+PiBtb3VudCBwcm90b2NvbCwgYW5kIHRlY2huaWNhbGx5IGV2ZXJ5d2hlcmUg
ZWxzZSwgbGlrZSAvcHJvYy9tb3VudHMgYW5kDQo+Pj4+IHRoZSAvc2Jpbi9tb3VudCBvdXRwdXQu
DQo+Pj4+IFNvIGluc3RlYWQgb2Y6DQo+Pj4+IG1vdW50IC10IG5mcyAtbyBwb3J0PTQ0NDQgMTAu
MTAuMC4xMDovYmFja3VwcyAvdmFyL2JhY2t1cHMNCj4+Pj4geW91IGNvdWxkIHVzZQ0KPj4+PiBt
b3VudCAtdCBuZnMgMTAuMTAuMC4xMEA0NDQ0Oi9iYWNrdXBzIC92YXIvYmFja3Vwcw0KPj4+PiAN
Cj4+Pj4gVGhlIHNhbWUgYXBwbGllcyB0byByZWZlcj0gLSBqdXN0IGNoYW5nZSBmcm9tICJob3N0
bmFtZSIgdG8NCj4+Pj4gImhvc3Rwb3J0IiwgYW5kIHRoZSB0ZXh0LWJhc2VkIG1vdW50ZCBkb3du
Y2FsbCBjYW4gc3RheSB0aGUgc2FtZSAoZS5nLg0KPj4+PiBzbyAiZm9vYmFyaG9zdCIgY2hhbmdl
cyB0byAiZm9vYmFyaG9zdEA0NDQiIGluIHRoZSBtb3VudGQgZG93bmxvYWQuKQ0KPj4+IFtzbmlw
XQ0KPj4+IA0KPj4+IFdoYXQgd291bGQgYmUgdGhlIGNvcnJlY3Qgc3ludGF4IHRvIHNwZWNpZnkg
YSBjdXN0b20gKG5vbi0yMDQ5KSBUQ1ANCj4+PiBwb3J0IGZvciByZWZlcj0gaW4gL2V0Yy9leHBv
cnRzID8NCj4+PiANCj4+PiBXb3VsZCB0aGlzIHdvcms6DQo+Pj4gLS0tLSBzbmlwIC0tLS0NCj4+
PiBgL3JlZiAqKG5vX3Jvb3Rfc3F1YXNoLHJlZmVyPS9leHBvcnQvaG9tZUAxMzQuNDkuMjIuMTEx
OjMyMDQ5KQ0KPj4+IC0tLS0gc25pcCAtLS0tDQo+PiANCj4+IEhlbGxvIFJvbGFuZCAtDQo+PiAN
Cj4+IEFsdGhvdWdoIGdlbmVyaWMgTkZTdjQgcmVmZXJyYWwgc3VwcG9ydCBoYXMgYmVlbiBpbiBO
RlNEIGZvcg0KPj4gbWFueSB5ZWFycywgTkZTRCBjdXJyZW50bHkgZG9lcyBub3QgaW1wbGVtZW50
IGFsdGVybmF0ZSBwb3J0cw0KPj4gaW4gcmVmZXJyYWxzLg0KPiANCj4gSSBrbm93LCBidXQgdGhl
IHF1ZXN0aW9uIGlzIGFib3V0IHRoZSBzeW50YXggaW4gL2V0Yy9leHBvcnRzLiBUaGUgaWRlYQ0K
PiBpcyB0byB1c2UgdGhlIHNhbWUgc3ludGF4IGZvciBvdGhlciBORlN2NCBzZXJ2ZXIgaW1wbGVt
ZW50YXRpb25zIChsaWtlDQo+IG5mczRqKSAuLi4NCg0KV2UncmUgcGxhbm5pbmcgbm90IHRvIHN1
cHBvcnQgYWx0ZXJuYXRlIHBvcnRzIHZpYSB0aGUgcmVmZXI9IGV4cG9ydA0Kb3B0aW9uLiBJbnN0
ZWFkLCB3ZSBwbGFuIHRvIGFkZCB0aGUgYWJpbGl0eSB0byBzcGVjaWZ5IGFuIGFsdGVybmF0ZQ0K
cG9ydCB2aWEgdGhlICJuZnNyZWYiIGNvbW1hbmQuDQoNClRoZSByZWZlcj0gZXhwb3J0IG9wdGlv
biAodGhhdCBpcywgdXNpbmcgdGhpcyBVSSBmb3Igc2V0dGluZyB1cCBORlN2NA0KcmVmZXJyYWxz
KSBoYXMgYmVlbiBleHBlcmltZW50YWwgc2luY2UgaXQgd2FzIGludHJvZHVjZWQsIGFuZCBoYXMg
YQ0KbnVtYmVyIG9mIGxpbWl0YXRpb25zIHRoYXQgd2UgaG9wZSB0byBhdm9pZCBieSB1c2luZyAi
bmZzcmVmIiBpbnN0ZWFkLg0KDQpBcyBhbiBhbHRlcm5hdGl2ZSwgU29sYXJpcywgZm9yIGluc3Rh
bmNlLCBkb2VzIG5vdCB1c2UgdGhlIC9ldGMvZXhwb3J0DQppbnRlcmZhY2UgbWVjaGFuaXNtIGF0
IGFsbCwgcHJlZmVycmluZyBpbnN0ZWFkIHRoZSAic2hhcmUiIGFuZCAibmZzcmVmIg0KY29tbWFu
ZHMuICh0aG91Z2ggYXMgZmFyIGFzIEkgYW0gYXdhcmUsIFNvbGFyaXMgZG9lcyBub3QgaW1wbGVt
ZW50DQpzdXBwb3J0IGZvciBhbHRlcm5hdGUgcG9ydHMgaW4gcmVmZXJyYWxzIGVpdGhlcikuDQoN
ClNvbGFyaXMgaGFzIHN1cHBvcnQgZm9yIHJlcGFyc2UgcG9pbnRzIChhcyBkb2VzIEZyZWVCU0Qp
LiAibmZzcmVmIg0KaXMgc3VwcG9zZWQgdG8gYmUgYSBtZWNoYW5pc20gZm9yIGVkaXRpbmcgdGhv
c2UsIGFuZCB0aGVvcmV0aWNhbGx5DQpyZXBhcnNlIHBvaW50cyB3ZXJlIHN1cHBvc2VkIHRvIGhh
bmRsZSBtb3JlIHRoYW4ganVzdCBORlN2NCByZWZlcnJhbHMuDQoNClVuZm9ydHVuYXRlbHkgSSB3
YXMgbmV2ZXIgYWJsZSB0byBnZW5lcmF0ZSBhIGxvdCBvZiBhcHBldGl0ZSBpbiB0aGUNCkxpbnV4
IGtlcm5lbCBjb21tdW5pdHkgZm9yIGltcGxlbWVudGluZyByZXBhcnNlIHBvaW50cyBpbiBvdXIg
ZmlsZQ0Kc3lzdGVtcy4gT3VyICJuZnNyZWYiIGNvbW1hbmQgaXMgdGhlcmVmb3JlIHNvbWV3aGF0
IGxpbWl0ZWQuDQoNCkhUSA0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

