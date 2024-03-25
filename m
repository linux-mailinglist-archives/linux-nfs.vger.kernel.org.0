Return-Path: <linux-nfs+bounces-2465-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD2888A955
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 17:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412751C613A9
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20AC149E07;
	Mon, 25 Mar 2024 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L7cPpb57";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dBGIoMxR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30327137908;
	Mon, 25 Mar 2024 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377210; cv=fail; b=ku5YK5JgkNd2a2+8jbg8ova/KIVClJqA96elxvWorM18EZhFFiZyocDCKC6u7OHRC/nVq9qJJwsvipr4tU5FXaZVTgafrigtvSzDUESCVG7redmotudRRivLoXtLLxXEzeLLHz1YthA382pPrnC6s8ql6dWuCTO8kWnyPwqITQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377210; c=relaxed/simple;
	bh=dMudCFrFLrOpxYnVh8fNecKN5Ddo255SQ7K87QYW+zY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A3P2zlUih4kCTS2E8JSuXMdJx3jLiKTycWLHilUGd6r79Unb/yTr/CmduUEEKQNAvmRhN37cnMsZFJkvyHHuIcA3Zt8dIpcAKo1uEv0Efp9wko3/Fnbr02Kv/JeqOhDuDREghxCBh9HvRXRC0q0CR9Ty66eByeWgLq5PbN8oCCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L7cPpb57; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dBGIoMxR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PBtZNE004027;
	Mon, 25 Mar 2024 14:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=dMudCFrFLrOpxYnVh8fNecKN5Ddo255SQ7K87QYW+zY=;
 b=L7cPpb57kwv7Sqx5SmY3Qt5p5D7M4753i+4EPxJwLiDs2vs5s1GspbCyAa5ZFnnFdo+n
 gVizz5TBtVO+RFjtRBQd5oYbI5Uld86WAvzfurVELh46FVYY7iMzsqK/e8/FtQNUzH5n
 VCQzXF4k9+2P9jFt0+q7WxiiF7+G7Wqug7kXHh4xxUjoaroyZ9uD9bhSrN32rJZyfIjK
 O3g224Rfp/WT/nb7lZ2D54WlrE07dWFZryijtwfig8HcPqAgyyWCr7uIEdytr2SOm/ni
 LJeh/mGPSQ1X1E10qnHThKlWKjP1Ik1jEmi0gORCRlTdf/HvIdYvrg/oiIPUvudNm8jw qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1pybjtcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 14:33:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42PDp0NX024422;
	Mon, 25 Mar 2024 14:33:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhbu65a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 14:33:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuazu6ViauVypEwYvtSbj/9JhCEofEd8dDogfLvYWSAEeBMYpvMiIuCTWnf1dVNGW9ZswmGoe4g2m5Yhf9QY3b0r/1V1VwVJMCqOPYBpYD+FY19GMRJQTy2tDjS9KjZgKNHl0eN58CARqxXr6IwcZNytrWlO9JozrBr1K8shH3tvWvpFKp4NNz10O26fXWsyDsR1dUNBkO1bvUwjwtSSOtauP9m2zLG01Sa0avs05tkDZtur5q/D+gkQvr1JpEECSTav7e+8BaI3sNSV+uzwT4ztd7KgMxYHQqjfZFfFvA9mb2UeJz3lsUKknAHqqmLPdMXX66eznpZ4iJePfwHraQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMudCFrFLrOpxYnVh8fNecKN5Ddo255SQ7K87QYW+zY=;
 b=kc/vCETJ/9tT6OZcmi1nQ3KKMiFYtdd+AS+cACuZCw9WKJvyBWbRiRzqo7qQScvuhFfKwUWQD/D6cg/C0zibZe1yDUSEGuM1nX0KCLX07T1mNGgU5l5ukKhZSiynSjXj3elhKzU0fN8a1dbBcnoVtCNOb6GOrpOpPTJECPN2GAnEd6JqyNgIcrP3MAJE03YQu0U4jGGSb3/abDYUzlFdvUNMsLgFjCngfSy+zqxFy+k+EmQZw0wNAtlI/mo50vaUc8TUJhYKAvKFrsREkLEqjCk9ot97LshsDHBOaw1Sdt9E89OUimmjg1t0OtgjkXC/OnIgaDExJW/aakwSNNnrYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMudCFrFLrOpxYnVh8fNecKN5Ddo255SQ7K87QYW+zY=;
 b=dBGIoMxRfQ0DNRvobKHNkUMOc3wzZCdtzaJqZSYg9paBD92EfJiKwW7RCwSB7WpI8qHKK4fcM5wiV1q6xyUi69lKG4QF2r26Z8OAaLUHZYLNwmDhLFNs+BTjJP4WKopZ0kjWEnp6e5GT3J71cciQ6VyZ49sRFSSjl9t/xu/sy4U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6124.namprd10.prod.outlook.com (2603:10b6:208:3a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 14:33:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 14:33:18 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: jaganmohan kanakala <jaganmohan.kanakala@gmail.com>,
        Scott Mayhew
	<smayhew@redhat.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells
	<dhowells@redhat.com>,
        "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>
Subject: Re: [External] : Re: LINUX NFS support for SHA256 hash types
Thread-Topic: [External] : Re: LINUX NFS support for SHA256 hash types
Thread-Index: AQHY0zKLaDiZfQG1FkW5IfB4RW19Ga32l+4Ag1S+roCAAIW0AA==
Date: Mon, 25 Mar 2024 14:33:18 +0000
Message-ID: <DEC63E8F-A254-4A2C-B0CD-74E2256D0990@oracle.com>
References: 
 <CAK6vGwma1mALwE1zDUqXhGP+YHjtXdPipykui3Tt0a6NL_KOqw@mail.gmail.com>
 <2DC5A71F-F7B7-401B-954E-6A0656BDC6A9@oracle.com>
 <CAK6vGw=50xecARE1MHmB73VrQS_OFzSqA5c1JF9AuOmjusUDNg@mail.gmail.com>
In-Reply-To: 
 <CAK6vGw=50xecARE1MHmB73VrQS_OFzSqA5c1JF9AuOmjusUDNg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6124:EE_
x-ms-office365-filtering-correlation-id: 604fa584-ba1d-49c0-1603-08dc4cd883a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OXmKMI6xtw16JPfKntbTpZ9kyf+NYkkKn3vFFNoTvyuoArzZbqkBejSmXjazJJVG40G20yY+i/shHFFiN1R2AOh1ZMmTtFmbe5IkotPiXvkeah8X6gIr0e4ozgea8FJY03Xw9vzp9klGg3mbQb1JTgsPQB8hy3KZwURHYZcKq4P8+OuXHRERcbt0HsgfeB7flR/j6dUlwxFR7P3eV8ytJACzrQfXTjyMnMQAWOAF4mjsdinrtyQLc8R81m9tYmtHK8pi9nZ3gbHfaC1Lr/BaQcSuMcv+ZnIJRGpvzE02mMx5hsxoI3Ex0Br5kVa2AoRylrWRiaAUWoIQ1ot/oV4e8bTrggWPOnbsxBnQ1CednUHpGvbuWRmOgeBhaUjR5yn/1QcP57vr68D5RKBYn6bXTLj6KrwVNiQI09W5VWaVgtTNau/ae9bEhI0ZxxJyNbdLMng+H4+r853r0OCA4ZBO7QQzjMrWqiNSd6CUZe+V1RenemQtoJMPp3fJBrT52lXLZNLJL8lk8QGdHP2RPZQRIbv+NttW0kEv/3HQVskwXBUtFvN1DtIxkJnoIR+HFoia+X4HC995C09Z5fBRWWKnlWuyhHmfuuNi76BdM/LfXcF2vMsUsWHorhCUfXxNsvTR38fTaaj2HUSD4eSxvQb8aDAHT11RCvkqCe5gy427zzE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YjI2RDFQdUp3Sm9WRHVnZ1hCTXNCaTNLeTBSWGJML3NTNHgxYng3TUkwTWYr?=
 =?utf-8?B?VVZOdnFDOXJRcVFQZ2NldXBqSm9zZXUrTmN4YjJJcFhNanQ4dGZHWjlnWjlL?=
 =?utf-8?B?NTBuMitBbUxOUHpRME93dVVIcVR1V3I3dCt3aFNmc3hpTzhrbzVrRkdteFh3?=
 =?utf-8?B?bXNNdTVsZmdlbUFPRy9yZisxWHJPTVFmeFkxNUN6cXhlSy9DSm51a3M1dFNr?=
 =?utf-8?B?a2lUZnYyMmhUSGE1MU1sM0JhaHMwOVNJS3FrQVVUOFhKTWpwNnZMWk5Tc1Na?=
 =?utf-8?B?L3I5dXNWMWZvSStQdHFZaE83NGZLWHdCcWtNOUhyZkp3UGpTZ0tjT3U5MWll?=
 =?utf-8?B?OHZRZ29LeDZqK3Y4ZDEwcDVRZjcyVWdxQVJHWGJ5TFpMaTZnQUE1Y3dLOFFZ?=
 =?utf-8?B?Q3dzb2tOSi9zbG5CMUpTa3VnMTNuTkFWL20zakYranN5NTV3cTQzVHNYYW5t?=
 =?utf-8?B?enRKY3FlV1pHVUtONXZoY3VPNS8rSWx4RzZIRnRtSSt1RldFZVk0NWtsOFpG?=
 =?utf-8?B?T2dNdENab3pza2QxYWtvRVgyUElrWXJqSEs0NFZjOFhqWkRzbnFLU3AvSlRK?=
 =?utf-8?B?ZW1vcVBrcHlmZUhNeW5oeER6WnlpQy8wWmFBTG1FUVRNN3N3eVg0ZVU0ZVVq?=
 =?utf-8?B?bm5tSWxqMERSYzRITDBPSE5NempiTng4RXFtRFZxVWlwd1ozSzBvZmN6cXdC?=
 =?utf-8?B?RDNZT01mMkFhVG1wK3dsZ0gvd0d0NXVmdnlEYm4zM3BVUExWcE84V3lKbURH?=
 =?utf-8?B?QmI4RS8zMEFUWkNSM1hiUWlEUjhDaGRFMEJyZU56WCtyUndiMDB5NEJsK3NU?=
 =?utf-8?B?ZUZLZHBsU3NYNmlkeFVzeFZoVnMrUEx3NjFBVFFBTXBnTHpDdDNEWkNaRkZY?=
 =?utf-8?B?L2hwZ1E5L0l5MkhYNDdjTWVwSjRNcnFqeEVyUitzbDNMODQ5TjY0VHFnUThS?=
 =?utf-8?B?YjJXVU0zMFBxNld5aHpOOEc1MEFFSTNoRzB1WkJ3NjEwYmo0NEsyT3c4NHdk?=
 =?utf-8?B?cGxBVlVGTEovd0RUendPL1F4a1VudVEwR0tQdmhsWlFHQWJ3ejFqNEtMYkZU?=
 =?utf-8?B?clZVNkpHbGJrYi8xMCs4ZWRqVjlObS9IM1FMVkQwaHVFM1dOeTNJWTVZQUV5?=
 =?utf-8?B?N0ptYmkwaGEvUExNZkE2enM1Y3k1NTJpcUx0OTZ0Zk1CdUdtc0FySnppKzc3?=
 =?utf-8?B?azJkbGhWS3hVc0hDVlNuMGszamZrVHJmbHVBVGVqRWRyZC9jaG5Na09CSm9p?=
 =?utf-8?B?bkJHOEw2K1U4OCtBaGN0Z2xaZ1lDVEp1dGdVN0Q2U2lzNzR6Y1l4NXB3NStF?=
 =?utf-8?B?dGx5bGhweEhnZWlIbi9KaWNLTHFNQVovTlh0VEV6UDJaenFuNjhiaTFBVldY?=
 =?utf-8?B?cHdGT09SMGFxazBud2lvSU1OaXNpNUkzOWttZkVRTyt3U0hpbDNON2FldDR5?=
 =?utf-8?B?Y3N2eUhJeUNqTytvWWNOeTRqaHIyWHN2Z3JJSENLRGllY0pBc2o0N0ZNNkxE?=
 =?utf-8?B?Uy9mSThrV1VsSFJDZU80UkVUM09IOXlHbkdhQ3d4eDdWR3BNRDB3cDhjZmdI?=
 =?utf-8?B?Nk81b2FhL0M5bmNtdzE5Tmgva3Z2eThqbEtZWnBhSEtOMXRNb1ZUWlFoUmkw?=
 =?utf-8?B?elpQdlNtekdhNXRHa0hlVDJPWHFhNXNMc3JibTAxS0R5aWxOdVRiZXQrYXFk?=
 =?utf-8?B?My95bkNXNFhFVEp2UmxzYTBqZlg4S3pYaXFTRlk0YjFHWTIvc2MzZy9HK1Zx?=
 =?utf-8?B?NTVCamJIeGRyZ2JRb3ZOajBKZDF4bmhabHlxTFRvV0xzL0thWDRlRDJ4dGE0?=
 =?utf-8?B?ODNwVjQ3S2JNS0RSSTFzWmdUYkdna1ZUand3UndEMzZsZUx5YVM0U0JQZzJ0?=
 =?utf-8?B?QU1JSmFpdGRXd0wrcnd5V0FzKzJqbEd0L1ZkeGtTSnBQSGZVK2dSV3c4aXgr?=
 =?utf-8?B?ZTNVSEQ4VTk1empBc0xIWUFWS1ZJU2V4QkJNSCsvSC91NnVSaHZYQnd6aFNK?=
 =?utf-8?B?TWF1QlVQUW5xSjNnRHk2aUJvT01PV0U3VjNGRFdpcmZobWU4d3E1V2tvKzZF?=
 =?utf-8?B?bEx3YWJtU1NOUERmZ3ZNZTM2amsvRy8zbWNvUnpFaWtmc2ZHakQyMDM0Rm42?=
 =?utf-8?B?am1ZbW40cnpwZ1hjdzY1a1crZHd4eTlsNmpnY2hLRU9tSmdDRzR2THF0QWZQ?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB2CD0859E6736459CA381E8A7AAB43D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QgOFjk15zb6FD92ZCmMMEOTj74bKDhCiAXBEw7Kzbbpy+zgmykb4m1574AUDZyfw1+/SxMyfo8FDbOi3016MPZzAezzL0AJXr+wDrD8OF8qBgb1IsSXSFzRaRnAAkNMRlacph7yljkRPHFZsH8P5YauqrHlayoxc00CHKCK9EVCYm4EXGIPTpeoYwyqlN3+N1FTT+ODQsg6UuZNFSOhysTLYf6cuujxZ+KCI+/60yS1lZeEWE64xphetDQEpm2dPUEC0LEeekJS8SGIW4lU+f0QCg8PezWjE0w3bq9ZvJ2JuippJMGIn1X6VVoY/FnBvbiTXaPP2JxMbPkdxbXLsGtgcy7hUleMd2Uyu6dDoPtIbKcHiNPopTgDsQqMioXtilUWUy0l5wGOkRFMM3/wCjg0bK9aBzXm4mbwch5Gx2Nx6kLsN2/xTT98/8cLTKFwjMHIBabwVDwDSXmzzw0C/Ock8ww3STsRw+SJNkllqgvMRYVltKelE8RYUJSe9TrYy1eAPxfT1rPdrZ4KfoNJPIyP4/kfdEOv177FVzb7vJZqF+J6OjqzTo66cz4P8lYJA5Afs/5kSISPdNe6lJnQBZH2HHuSSrG+9a1hI3YE4l8w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 604fa584-ba1d-49c0-1603-08dc4cd883a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 14:33:18.4592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6t4osmQYrSjIXVyNASpD0khFJXD4sUOETQovDhwfE1JJ4D7+zBTOuWv5LzqRlPvViJfwzFslslpn7fg/Az33fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_11,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403250080
X-Proofpoint-GUID: 643cYe-1Qziasl59nKvDB4S80ZKhCcGu
X-Proofpoint-ORIG-GUID: 643cYe-1Qziasl59nKvDB4S80ZKhCcGu

DQoNCj4gT24gTWFyIDI1LCAyMDI0LCBhdCAyOjM04oCvQU0sIGphZ2FubW9oYW4ga2FuYWthbGEg
PGphZ2FubW9oYW4ua2FuYWthbGFAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IEhpIENodWNrLA0K
PiANCj4gRm9sbG93aW5nIHVwIHdpdGggbXkgZWFybGllciBlbWFpbCwgSSd2ZSBub3RlZCBmcm9t
IHRoZSBmb2xsb3dpbmcgY29tbWl0IHRoYXQgdGhlIHN1cHBvcnQgZm9yIFNIQSAyNTYvMzg0IGhh
cyBub3cgYmVlbiBhZGRlZCB0byBMaW51eCBORlMuDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2
YWxkcy9saW51eC9jb21taXQvYTQwY2Y3NTMwZDMxMDQ3OTNmOTM2MWU2OWU4NGFkYTc5NjA3MjRm
Mg0KPiANCj4gVGhlIGNvbW1pdCBtZXNzYWdlIHNheXMgdGhhdCB0aGUgaW1wbGVtZW50YXRpb24g
d2FzIGluICdiZXRhJyBhdCB0aGUgdGltZSBvZiB0aGUgY29tbWl0LiBJcyB0aGUgaW1wbGVtZW50
YXRpb24gc3RpbGwgaW4gdGhlICdiZXRhJyBzdGFnZT8NCg0KIkJldGEiIHdhcyB1c2VkIHNpbXBs
eSB0byBtZWFuIHRoYXQgdGhlIGNvZGUgZGlkIG5vdCBoYXZlDQpzaWduaWZpY2FudCB0ZXN0IG9y
IGRlcGxveW1lbnQgZXhwZXJpZW5jZS4gU28gZmFyIHRoZXJlDQpoYXZlIGJlZW4gb25seSBhIGZl
dyBidWdzLCBhbGwga25vd24gdG8gYmUgZml4ZWQgYXQgdGhlDQptb21lbnQuDQoNCg0KPiBJIGhh
dmUgYW4gTkZTIGNsaWVudCB3aGVyZSBJJ20gdHJ5aW5nIHRvIHN1cHBvcnQgU0hBIDI1NiBmb3Ig
S3JiNS4gSG93IGNhbiBJIHZlcmlmeSBteSBpbXBsZW1lbnRhdGlvbiB3aXRoIHRoZSBMaW51eCBO
RlMgc2VydmVyPw0KDQpZb3Ugd2lsbCBuZWVkIGEgTGludXggZGlzdHJpYnV0aW9uIHdob3NlIHVz
ZXIgc3BhY2UNCktlcmJlcm9zIGxpYnJhcmllcyBzdXBwb3J0IEFFU19TSEEyIGVuY3R5cGVzLCBh
bmQgb2YNCmNvdXJzZSBhIHJlY2VudCBrZXJuZWwuIFNjb3R0LCBhbnl0aGluZyBlbHNlPyBEb2Vz
IHRoZQ0KS0RDIG5lZWQgdG8gaGFuZGxlIHRoZXNlIGVuY3R5cGVzIHRvbz8NCg0KLS0NCkNodWNr
IExldmVyDQoNCg0K

