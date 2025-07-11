Return-Path: <linux-nfs+bounces-12994-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA2BB01F0D
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Jul 2025 16:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C621CC07D8
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Jul 2025 14:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8CA2E612B;
	Fri, 11 Jul 2025 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rvl5wuno";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TUnR/4m9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CBE2E5B09;
	Fri, 11 Jul 2025 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752243793; cv=fail; b=BRgq//xVjOi8Z81KLUfjXQI/khZlgJgg4AVVSdgC//mP/nIxZ6q5hk4f/Fx2tHwDQVbOrNGcO8rBZEOF5JcyxpA7u8YNH95bTnVGucr5r6wGfmC7PkQMB3eCRM0cwwpX2EpG99DTBaajC90LG8tAadOEPv1Cd0YbOmf5AnsB9LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752243793; c=relaxed/simple;
	bh=/bBCvT6yT2KrYv6lDKjL8bdHmUfwFzwIeBSUGozpG5g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mFJKFAgBue6IrXshIXtT5xy3Kla6JJTfvqfr0mS5wnvcMJn2Yhem0tqHEWpo+DKEDVytj6TFa3MjAVT+9oTjsi+ZNQ4+oIhS8+AZVCZeLBncvWY6BvwtqSzh8xjJy13/InrYxsbsDRrcwhb13Pr6ODAvM0xPDeeKXrb3xLbgZlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rvl5wuno; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TUnR/4m9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BE6qtV007546;
	Fri, 11 Jul 2025 14:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VVYqdJQ+fM7CRBOHJrI4FsR1rybbl9BXg/fyC6SUhQM=; b=
	Rvl5wunoKxkLuKxTvL/h/K+i9fB8q4Fo0AQFQtLV+FYs5QjSfcsILPnTFMjmBooj
	eELE4OkofUYJM+GxbclZfFA1FIRi640axzptAEtGx8pFS7Y566iYfpu7KVCaVwZR
	BZEUX/WAYpyhIZ8kXdqdR0QV6EWFqx9yJqHdNL69I+cLs41nWMS9PqwpM48tNLfS
	P6AIFJmvn4G9QHrHr55o2Dtnt4jNsq1yT0cMlEHnT075n4AGUTyu94qHKE//a0PH
	0WXiOSlwTxSe9D6LrleuudlymgSnd2M01d/cfm8BmHGcTtq1puK53XKXlggLPffP
	E3+7/UjTWhQ5pkKOLJiElA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u438g15t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 14:23:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BEL9J7026703;
	Fri, 11 Jul 2025 14:23:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdm6sm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 14:23:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTWzmCezXy5Qkrc4In3586oHTfEjeHqlcEC1ut3dim/8ZfFeKUdBGh4zHMCjhFnosT9oGwGwE4XZop4f71Yitw++d/WkMG5kz2FNDA7c4WzrlPvyj71mnB6/EyT22wBIgu/aTOfuUTe364MHTpatzpvAdD+iW+Mmi2PbBVfRaA9o38laSqDkIAwlD+sBDRbIF8xT2g4Ma9JHkIB5s5w56qaVaGMQWU/nlbAZ50NRA8em2n0pAszNJEHqW27+vBIvLJpUFB59Ovgt5IEUoAMP7l1DwFUwtPaDgXKrT6/PTU1Yd/DjvRkXdRoBelyuBVMHzwbZ3XdQF46cN3ovVebERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVYqdJQ+fM7CRBOHJrI4FsR1rybbl9BXg/fyC6SUhQM=;
 b=d9zfk10kGgMALsMSx8nRRA0tSjJ2dsodXWisppx6zpn6CMpkESD/OAvUAyifWc8kze+4rlCkUgsh8CrlAW+cDT3eGEz4mw3/YQRhLfsKC4zOJUVW9gVaO1WfswG30A3++5fK0BrPsO3leFoGFOVOide63dVswB8LgIMXyl4/hHJuHpTFgrcwyTTJaYA/CzCE7a3JmXtVQf/YG/CQ6nQmNvCLkyAXZowxY7fOyRi04c1wU3Xf2VVCWo5tfuVP0PJkrCxIrAxP1/tvpbGwcTosrYXdR872Ti4PbpfssSCY2Gh68Edxguk/Unck53g7I44GpVLgJHQk8PHKOnAifwIBgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVYqdJQ+fM7CRBOHJrI4FsR1rybbl9BXg/fyC6SUhQM=;
 b=TUnR/4m9PdV5sf14UEcIfZ6cuYoo19czrQAG0bkeqHoI2ch1kFlXmIz684x9UX6wOudHnstI4tJo6F2TObEoPfR0tMmifwc4SuMvye1r67zhbc0ujbMf4LP0b8UOCVJOQQ0Y2gIVJY9ctIOyjc7PrlZ3kgB7w0SnnV80znfvz30=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7338.namprd10.prod.outlook.com (2603:10b6:930:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 14:22:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Fri, 11 Jul 2025
 14:22:59 +0000
Message-ID: <39ef1522-9fad-45f8-9c73-ffba7b1f04d0@oracle.com>
Date: Fri, 11 Jul 2025 10:22:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Using guard() to simplify nfsd_cache_lookup()
To: NeilBrown <neil@brown.name>
Cc: Su Hui <suhui@nfschina.com>, jlayton@kernel.org, okorniev@redhat.com,
        Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <> <cecf4793-d737-4501-a306-0c5a74daaf30@oracle.com>
 <175080335129.2280845.12285110458405652015@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <175080335129.2280845.12285110458405652015@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9c4ddb-9b23-486b-2885-08ddc0866f8c
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dFlpUkFTTjUwZjg4STdTa0ZCUmhMN1Rqc2srTTF0am5SWjh5NmJxcHdPc1FT?=
 =?utf-8?B?S0pwc2c3MzNVRWh2V2ZOZEI4dXZrSEdESm9hZ3B1UnZkeGFHNHVQOWlqKzBW?=
 =?utf-8?B?SzFaZml2anZ2NVpUMVFUQ2t4WG1zdVBPNEdPd01QWWZvTktZRkp1S1JzTHUv?=
 =?utf-8?B?dUJIU1J1M2E2TWU3YlFob0ZoOEtRUVlkdENxZDhrenJXTFpiSU1hdkR2Z1lN?=
 =?utf-8?B?OHYzLy8yRW5oUm9VU3J4Mk9kZnpJUzJRQ0dvSCtCTFFwcUxCZE5QY3lkK3FQ?=
 =?utf-8?B?Vml1T1JiZDVVNjV3SnpKbG04ckRtcTFhSlZ5TVp5T1VldlhOc2ZLd2JoNEZn?=
 =?utf-8?B?akh4ckJNZVVleEpDZUFGMTc5UW1sellJVDZJQ1dUZGJHbTRhZzhNU0RMYU9G?=
 =?utf-8?B?aUxreGpFelorN1ZRUXo5MnJkVXFqR0tBWktmREFUVlFaR3BjbGZyQjhLN2JE?=
 =?utf-8?B?ckxQb3UzdDZuWU5XcHVuL2N1eWYvd2llR1VyY2p0czl5MTgwUHgxTGRiTHpq?=
 =?utf-8?B?N2tncGp1OXIxWnhld2Q2b1g4RFdWdHE1aEM4aTdlZ1VQeVVmNXJ1YjFXVUlG?=
 =?utf-8?B?OXRZZ2oxWTN0b1pzQys1SHVxVnFFTFNNSnhFKy9iYjdNUkVmWkhCUG4wamZy?=
 =?utf-8?B?alRGWldPMGt3TUp0eDdlaytOWkpSRkFtWGlxdUZ4QXRYdi96UEt0YUJMc01D?=
 =?utf-8?B?MXlvbkMwNnlxZmVNamJ6K1pqajIvU3BkUHNCbW5sRjJFTjQwQmR4UEpENUhM?=
 =?utf-8?B?cElKLzFKcFFHbGJuM2J3QW9uVmY2U241K1hZTG1jblVUbkpKV284Y1k2dVhu?=
 =?utf-8?B?Wi9NOXczaFBXOVRDQS9zazBkWDluN1pyaUtsNjF6NUZJQjB6bXFFeFNzbFds?=
 =?utf-8?B?c3VJeWRrZTFXMWhnN2M5REZSSGsvTVlOSlc2ZktFUDkwSTZzOER2b1l0Mm9l?=
 =?utf-8?B?MTRVN1JadkpteWJOakF2NkUzbGZDZmE2b2wwcERGS3VaTFhRWVN0S0Nta0dl?=
 =?utf-8?B?M3VDNUJUdFpWUk1tZkJqdjBka1hxN1JsL2sxZ2d1cUZUOXN4SmNMaFZKSjFO?=
 =?utf-8?B?UE1DdzJRVlRGdE0xUnFOeXZsQlAvRHhuTmhreTVSakw4VVN3YUk1d0xTT0NO?=
 =?utf-8?B?OFBNN2dzTFQrUjl2V29HMWNTN3BIU0ZFbUdZbnJoV1Bzd3MwdytMOGRJeHc3?=
 =?utf-8?B?V1ZuVXE1QzhBRk9XK29WSWRiS1ZqZGJnemVhV2FaMFhzSkhLUkE0ZmwySVR1?=
 =?utf-8?B?SXE3REFLNnNaM1VrQUk2SGVpc3dRNHlWN0lrN3A4N1JmR1JvMEVFODdPYjlJ?=
 =?utf-8?B?Wit6Wkk4cWFJLzJWR0ZTZ2prZjNVWHE2aGNqOFdwUzdiejNHTjFKdFFZZHov?=
 =?utf-8?B?Q0k3WlU4Ly9FVHZVWVB4end6RjN1NWprWU51VS9SdFYyZGtmeHZrYzdPYnhs?=
 =?utf-8?B?enBPWHZqclpSVmJ3ZWhpU0NvNmdheE1ucGMvdTVZZFhwdVM5TEpXVEFVaW1i?=
 =?utf-8?B?RzE2MVRHb240TDlhSEdhSlZHOXplZWIwTGF4emt6bk1NeHVYWnBnUUNIVE5s?=
 =?utf-8?B?Si9PM25aU3BkV3ZrdXQ4dDN1MGZOWjUzMCthbmJsdERHcithWVB4NnUxWUhs?=
 =?utf-8?B?THcvcjN5TnFmSjZkN2dwbSs1bkNlK0krRS96MjkwcTQxOEQrb3I2d09vYWdM?=
 =?utf-8?B?R0wvYXQ1SFQwNElpeHdmdjBCOG04dmhXVDNzUzZDejZvVjdLRTZ3QUlpZjVE?=
 =?utf-8?B?OTV6c1RPaHdoWFRINlFPREkySHhkeWQ4bjNQdWhmdDdSbnYxTUsyRFV4ZU9F?=
 =?utf-8?B?OG42a3NQdkhobk1jLzFTeXJDTkJ6TG5iaXo2K2JacGtVTmM0Q085T0dvU3hU?=
 =?utf-8?B?RkhiZ1ppa3JubFpCN0FqRG03cnpReXRLYVBLYXFpUTRBT054UFVnWUlEY3Vk?=
 =?utf-8?Q?3HyxT81fhoU=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UW4yNzR1TkllZ0kxd0tZWEhWM2JSQWxNUDNUV2NRaFFuUElRMmMyTlBnTVNN?=
 =?utf-8?B?c0F1YkJnbUcwL2NjRi9rZGNzQlFyNG5yaWlNdENjTzNmbEhuTGpLMys4RWtF?=
 =?utf-8?B?aXV5Q1o0cUFZaHA5L0dUSlJuYmd3U3dmcXlJL1lmamR4bitkTkUzMnFhNkxE?=
 =?utf-8?B?TnhVYkRTS2FIaGxlMDBUYllwMFl1THZsV2d2R0V4bWt6MmJsSEVLd0lWS1Nq?=
 =?utf-8?B?aEdhZUhIMUlINU5rZStXM000OFNVVWx2QXl1a3RNODNDM2RmWmZuSnR0TnpD?=
 =?utf-8?B?Vzk4dXZBc1doTjRnY3lPbUZjUm1NRFZzV2E5L0d3anlQd1ViMVVGNWFqRGdx?=
 =?utf-8?B?Z2lvSjdjNm93VGdENkxmNWVoaXIxV0RZelErb2JtTlVhK05wODVuZHVpRlVn?=
 =?utf-8?B?SlhRandGNUJUei9tU1RwTExYUUZZbWlsRjNmek1JeG83RDFKeTZMdDA5Ykdl?=
 =?utf-8?B?MmxPQlRDWjNwV3JEcG1nT0xUR2Y4VUFJUzl6aDA5NHBKNEdsRGpwL2pOWkE1?=
 =?utf-8?B?REdkTnNFWkJKQlA3eHVkeERZaHFXU0drUGxuR3R3Q2craEhRQ2xwRDVZZWho?=
 =?utf-8?B?eDhOOUxkRmNGdlo1ZXVKbkJsNEpJNGV2MGgwYUJNNGtOUXVtWkk5NTJiOFpH?=
 =?utf-8?B?eTVzWTNKUkYrb3hpWXV6SlgzbGczOWY3ekJKc0JndXhuSVlNODZoNGJUMGFW?=
 =?utf-8?B?Q0gvME9iazFSczVhakNxSVNjNlVOVXVleVBIQmExckpCTlkvWURoUUxReEg3?=
 =?utf-8?B?d3dCcm90UE9zajZ5T0VyQ2ZvRVNHRVlKdzdKNGJ3R0wxVmVabWk4aDR4aFNR?=
 =?utf-8?B?dVJZNGNjYWdjQUJtS3pWZzNHeDg4ZjI0bEt3cVhkZkYycnpQSXNnOW1XOVlP?=
 =?utf-8?B?ZDBEMWFlU2kxcTdOMWF4M2VFMU41UWRIb3h5bmRFYkNPV0ZNTGMxQzVyNGNt?=
 =?utf-8?B?MFdka1FLbzd5OHN4cWEwdkpQdllZMVVpdjJNdVRpYmxBemdERC9leVBiaWdQ?=
 =?utf-8?B?R21WODNiYTdzNDFxNW1TcXFvWjRta0R3NU1JYWJ5NGQ3N0d2SkhybzJ0MFRz?=
 =?utf-8?B?bDZ2TUxCdG5BK3VJWHRSa1R1NzFlRnhQT0FiaytWdGdBY2ZaWWs2UzlvRzcy?=
 =?utf-8?B?d053bDRQNTE3aTRQcHB5LzlMRzBxNWtuKzBJMmtFRmJrUlVhOTN2OWxGVTJH?=
 =?utf-8?B?ZDR3NWVJVVNDbzFJMzBzTlg1NVVWLzZKNVJVUWlaS25wWDcva2EyTnh1YjBL?=
 =?utf-8?B?cHlTbXBqRW8rVTJXRE1Td3ZpVjZpUHpkV2V3bWs4U29xc3pTN3IxSWxMUDlL?=
 =?utf-8?B?dGFxaml5N0pTaEpNdHNwNXhXeVFGRFRwZXZqR0ZBam90WXNGaGY4SCsyVDZ4?=
 =?utf-8?B?Qngwd3p1Vkk5Y2c2aGRhQ0JkcjJTTEpzRWVwakdEUmZZa090RVpxaDd2RG8x?=
 =?utf-8?B?bzNNZFdiNVRlN3J0ODRLRGxnZm1BUUowMnJ0YjY2ZnkwZ1pTY1pnZW04eG1G?=
 =?utf-8?B?Slo5Z0xCVE9NWURNRDJkdlJOWjluTEZ4c2tCRnNkcEREbnRTVWZ2YTM3OEVa?=
 =?utf-8?B?aERrbDI2QTczcUVtRkFRb0JLSDE5SUxLaGxQcFZlb1hkVE1ublg4VnVhanVK?=
 =?utf-8?B?QkRPYnMwQVd6KzNlSnlENzRTbTV3OU1BY20yVG5kL1E4ZmVObSs0UWhyL1c2?=
 =?utf-8?B?U0IxOVZqNHRWYmVsUGVEREtpeERqaGpzR1V5cDdLbzZVUS93eWt1ZFZGYzlU?=
 =?utf-8?B?MFRvYnJrUjRna29ySVgyL0UzTjIrTmJTQXpVWDlIS2tIR1JLZGlQeGhHZzhQ?=
 =?utf-8?B?T3JHTDE1dzZ0dk1nZ09uUDF1UWRyYU9zTHhLZW9Zbms5QXBhbjlSYlFYVHVz?=
 =?utf-8?B?cDJ5eWZPL2NibUlTTk9QNUJtVjVzV3ZJR3dZVUd4bTQwc25nN0E0VHZvaHNY?=
 =?utf-8?B?TVlsQW91d1ZwM01FUnpFUms5cE5jNmVNVmdGSlAreG5LaVgwOVFhdTNkVEQw?=
 =?utf-8?B?ZGFtY1NVQm1sV3hPb1dTVGRjQ3NHU0dpV05QbEpORTRxeVp0dm9jMVV6aGw5?=
 =?utf-8?B?Vy9FTU4xZ09Ed09QQ1AxZE4ySHU1Z0h0TUdoTHd6SmxLQVdhKzNSU3RLM25V?=
 =?utf-8?B?QTFKSUFlT2JadURZTE51UXhPNTJ6QXd3ZTFneFI0R1FwK0lVL2x3a1VuWHhZ?=
 =?utf-8?B?b2tiZlFobHYrQThFOWZnSVZpdUtiQ0tWOGdrSHYyUVlQVlhsOVd4WTZyaG4x?=
 =?utf-8?B?L0hSb3RqVUNma3dQYzNnbXJjQ2NnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rehQkcKoBeEdL6pPA29fIodqqiRphXu79xzoyJU/s9a7lH2UBTtpeBmSNzBaWqqIMukitoPqreEIKGl+dHuK/rytusP7gFQ1QtFWEiNhGNelpq6jquCPIe5+GziwjbqwnSLNhxYjfcmVvju6F3Rvw8fYOUW6v1TXpxb49uKmKw8DlT6j45WBD/6T5SuzVJrJVbfMiMNW4gEtTEuxArugYDYG2gCJ+06EdEJs4jUkygmTVN2fYmrNaY8mnO3Nj7cSQdRQmQhLEEkLfWwBEYpeKA4/Y/iLT9RnKRrPZF7bcRelt/VEh8ZPAhn2Vg8HMQe3ADzWtTB40F/iKME7f83xebcFxPnWlYYb+v1d+lM4kGLEZzEbHpV0nvU/vcqDG6WNY2GM9ILvrAD7uttrPUX7QiDpJpvuTz1qPA2A3M2PSp8eC4HAwM2PfirXmtJUmuRBY9/m2qkBYctO1GgJI8cLxb3uqbIc5QglDvbzPq7v63M8f1T/a+hbGp/ZPywUv1igQq5lS+YgXani6LzWfK231M3Opkr8PWM3xh15ladYfRCjsqBXNZYyrStMSlmU5exZPC4kRm7s/Mm9cZ8/qkAgknAoPhejL+KmuO4zRU9Q8Zo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9c4ddb-9b23-486b-2885-08ddc0866f8c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 14:22:58.9738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5Xk3VIk2rd1vJ5Gh4j3PIyiWVez1kqRySFxSz4Qy1VgKicDcfapMQnZZTfMBffpBpLPOH9JFDfeoV8WGhbZgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEwMiBTYWx0ZWRfX51oUG6KRm3yo Q9tPCGpuAnPW94TImB1WQMzlRbKJL1dccvjD+U0sxdnT+x0VZoEprT1W80QUctDbRySGuW0JQVu wvPzIoPFhWcIwWDTI10mGk4XHAqV/qt3WzjxfBHDjEYCFfThSBlpS1jPc1ZXBJq0hKVE7zB8tY/
 ok+jYtgDW0nIYnguuwHg7fWzn0NHVdPx4ZD038+s0zopw5lgRVEBgVjklv+ywyrQzammrbfPN6Y kWp9E0Nj1KQCfArmfcfTJPojX2VVqATLA6dWXLdWJC8J/dL2QBUppYUPGCvKtV2Wh+UcmCe7c3P 9e7BV1Nx2CqLUgVKGC9x0bIOo+gi1KdXmbZoVEe8QHXRRPtwMvn4Tl6gPyTW43AidQMWbk+Yv1M
 s8nmCaCssKh6yt0CkrQcg+45OSYKiZ3kC2wa7ZJXB0nboX2bVYWkMccH8u0Z1vc4QhLymQo7
X-Proofpoint-GUID: dpdIKsA95FvEyrAgv5vKoxAENAuBxrAv
X-Proofpoint-ORIG-GUID: dpdIKsA95FvEyrAgv5vKoxAENAuBxrAv
X-Authority-Analysis: v=2.4 cv=AfmxH2XG c=1 sm=1 tr=0 ts=68711e47 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=lbz-eYdKExC120KwK1wA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12061

On 6/24/25 6:15 PM, NeilBrown wrote:
> On Wed, 25 Jun 2025, Chuck Lever wrote:

>> What is more interesting to me is trying out more sophisticated abstract
>> data types for the DRC hashtable. rhashtable is one alternative; so is
>> Maple tree, which is supposed to handle lookups with more memory
>> bandwidth efficiency than walking a linked list.
>>
> 
> While I generally like rhashtable there is an awkwardness.  It doesn't
> guarantee that an insert will always succeed.  If you get lots of new
> records that hash to the same value, it will start failing insert
> requests until is hash re-hashed the table with a new seed.

Hm. I hadn't thought of that.


> This is
> intended to defeat collision attacks.  That means we would need to drop
> requests sometimes.  Maybe that is OK.  The DRC could be the target of
> collision attacks so maybe we really do want to drop requests if
> rhashtable refuses to store them.

Well I can imagine, in a large cohort of clients, there is a pretty good
probability of non-malicious XID collisions due to the birthday paradox.


> I think the other area that could use improvement is pruning old entries.
> I would not include RC_INPROG entries in the lru at all - they are
> always ignored, and will be added when they are switched to RCU_DONE.

That sounds intriguing.


> I'd generally like to prune less often in larger batches, but removing
> each of the batch from the rbtree could hold the lock for longer than we
> would like.

Have a look at 8847ecc9274a ("NFSD: Optimize DRC bucket pruning").
Pruning frequently by small amounts seems to have the greatest benefit.

It certainly does keep request latency jitter down, since NFSD prunes
while the client is waiting. If we can move some management of the cache
until after the reply is sent, that might offer opportunities to prune
more aggressively without impacting server responsiveness.


> I wonder if we could have an 'old' and a 'new' rbtree and
> when the 'old' gets too old or the 'new' get too full, we extract 'old',
> move 'new' to 'old', and outside the spinlock we free all of the moved
> 'old'.

One observation I've had is that nearly every DRC lookup will fail to
find an entry that matches the XID, because when things are operating
smoothly, every incoming RPC contains an XID that hasn't been seen
before.

That means DRC lookups are walking the entire bucket in the common
case. Pointer chasing of any kind is a well-known ADT performance
killer. My experience with the kernel's r-b tree is that is does not
perform well due to the number of memory accesses needed for lookups.

This is why I suggested using rhashtable -- it makes an effort to keep
bucket sizes small by widening the table frequently. The downside is
that this will definitely introduce some latency when an insertion
triggers a table-size change.

What might be helpful is a per-bucket Bloom filter that would make
checking if an XID is in the hashed bucket an O(1) operation -- and
in particular, would require few, if any, pointer dereferences.


> But if we switched to rhashtable, we probably wouldn't need an lru -
> just walk the entire table occasionally - there would be little conflict
> with concurrent lookups.
When the DRC is at capacity, pruning needs to find something to evict
on every insertion. My thought is that a pruning walk would need to be
done quite frequently to ensure clients don't overrun the cache. Thus
attention needs to be paid to keep pruning efficient (although perhaps
an LRU isn't the only choice here).

-- 
Chuck Lever

