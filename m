Return-Path: <linux-nfs+bounces-11927-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D61FAC5AE6
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 21:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5994A3868
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 19:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD1D289E2E;
	Tue, 27 May 2025 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gF/0ehHI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F2yiHuDa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C9E3C01
	for <linux-nfs@vger.kernel.org>; Tue, 27 May 2025 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374906; cv=fail; b=BYukEfiSPCjWQCC0XH5qVjeEV7Pbscv4eoGXtaL+EmRCPDa4iIocJw6/sayRWVF4FpXngg/OjZW7+JtwJRTUB7uSJlnchkDeOAwCE+8GJIGetIaOheahvmOaJYAqMT5Qr+s4OoQA9qPePPkIxwhk91ochWSiJevUSe3HitS1HnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374906; c=relaxed/simple;
	bh=9PF6aRr3pyGfN4Tc41x+xtNJ9txuYjywOCcWYZwW9y8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mNvhgq8HtWbeDnckcyFb0zHW913O42iQ1mZ8jJEv3VA0gw9KZtwrIXmu58ph4ZWNt8GQ6W1ICPYCSOuoJlz6tutoZM/JQpFiBO954gUEigqumU3UnPKk/1EHjTnC+6SCagyUHO5PxSCUI+6OVPacqo8j+YyjDEQeyAx1FKVM6/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gF/0ehHI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F2yiHuDa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RJXsKd016456;
	Tue, 27 May 2025 19:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IYpfOjJKTorvJHNnmSd6tzsBAzWEwYoicpBtc9mkKUI=; b=
	gF/0ehHIsXaLUv+Uxgxb3tk869rXm9QjRDGG+JAyJhXlCf0gDbQKfdtKqj/i8jV5
	sHMU4VW0I/gtPBtHOjxIpI/V/JzMfggW630j7axA4149IaUFWb4y0KtF1diK5sg3
	3Rrj6/N0FNKfU8IE7v3gJFL9QJdDQzvVGPRF7VUaA1M0KigsdPkh6tvoWjfjXwxp
	DoZlRicUcF/l16+UQthyn5w1idYNSYmbPI32euLwo3X0jlaVtU2W7udYBgeW4hqQ
	BLdh7u3dkFFr1MdQ+O7puwABhUgRTew7ux11g7WJrB3NCY1g7l659tXy8EThUYMy
	suA67c7hcKtSSWMFfM2+oQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46wjbcg7qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 19:41:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54RId8lJ035744;
	Tue, 27 May 2025 19:41:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jae3r6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 19:41:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZFqOjc2QgcAZsd08p7kXemoeBdEh3uOxmvBY4WpRFC+J3gaYte596MznM8zVEP7qQfaVU4RIhkN6j6RL+AimFKrXg4lUTtgKZCh3o7VOwD6ms6kWCLNY/7ZlH7mcoGeNh4ZtpAFRr0rfr3LbR9er+zNZh+/TUzYSt4fr4cpqkjIA3MHNEZnaFmkAZ2Arxl0AR7cEpb2EHKvx7jYT0RJnIqSPX0o6OCAivuRrDJlrXPbN0b7dU9fSmMLlVgG3U21guWWns3nKGlywShBxSHom6/3HCyuI7LQ1xbWi/6Sr8GqzdWpJP2NhtlQuBzwJSF32x43vNGRuQU2g15BMkqyKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYpfOjJKTorvJHNnmSd6tzsBAzWEwYoicpBtc9mkKUI=;
 b=YEEWe29UJyIVa/aaBI71bVUPhtxI6sXE5u8WvTfMeCMCwXG1iZ85CgEqge9Q0du7x04w51cgNlRWeV/WcILIlupIWQh6KiOop1K2fPxHMc6FeN7dfbRwwgH17MlxmGfs23tj3MiCvf34bTvCmecRJ1D/wVr2OXK/gjZCVzKTSG08uc4d1mP/adklP4Lhu6RO3F1cy+t71MKyxi1FyW4ZtQ9LJ4cmUMBQRm5mHPZiqW5/AdFsJ/wj+xjkci55uECbCNrWuZHV2CtpmdPWru7bzKgbVzNHIo4sl7FrG3gnzk1X28/P1/X9DNpfaa1MhxG/YlE2CDv6yq+XSgop1ZdGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYpfOjJKTorvJHNnmSd6tzsBAzWEwYoicpBtc9mkKUI=;
 b=F2yiHuDaG0GVhjCbsnzB0iuaxLnSZK3jGwbAY4gNwPvb58fJ46oNc2L43icHjI9svlWKiZS8bDO+qRREd44qUaQszRZvoFmzaPNXPMbrpy7Np8H1D5g0YBVVhbrRT+6ykuXq6hl2RzxD0KXSxAsHzz0kwEczXNrZsqHV6PmPDqU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5008.namprd10.prod.outlook.com (2603:10b6:5:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.39; Tue, 27 May
 2025 19:41:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8746.035; Tue, 27 May 2025
 19:41:35 +0000
Message-ID: <e6daff16-2949-4413-b801-58393d9cb993@oracle.com>
Date: Tue, 27 May 2025 15:41:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: Benjamin Coddington <bcodding@redhat.com>
Cc: NeilBrown <neil@brown.name>, Rick Macklem <rick.macklem@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>,
        Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
References: <> <d539c502-e776-460f-852c-8af9722ad9f8@oracle.com>
 <174821817646.608730.16435329287198176319@noble.neil.brown.name>
 <f679b62b-cbf3-4225-a163-870c65ff0c9b@oracle.com>
 <3DF74DD6-E300-4CDE-B8D9-EECD5F05BC8B@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <3DF74DD6-E300-4CDE-B8D9-EECD5F05BC8B@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9454f4-b79d-4555-35ea-08dd9d567da7
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?T3lCbEJNWCtPZjNqbWwyeFJlbDZsVWg3a2ZXYU54ejFSeXZ3NWJqUVI5ZlFR?=
 =?utf-8?B?cnhQTTNvalhhSE9DU2VMRVppZXhIZitUdU1yYU1xa1BCUVZxNzBIaTNrdlZk?=
 =?utf-8?B?UkRYRDgvREVncWVJMFJRYnZObEFlMDdONG05ZW1VeDlGUmFXVzRzeUNVMjdl?=
 =?utf-8?B?bEQ0cXBnZ2d3STlkRVNzOC95Vzh3NzhmSCtPT0d0VTBNdkxwK1E5blpxaGJo?=
 =?utf-8?B?WEViMmd0MVNwbUhGVSsvdHd1OXhmNWFKREszUG9xMXVxTXE3RkNvR05aRkpC?=
 =?utf-8?B?NmlmMTlNQ1BhbEpubWl2V3N2NVVIY0ZRUlRlaDNuaWl1OW55WnZiQlkrZllW?=
 =?utf-8?B?Y0ZsbkZ6ZjFRbnc3K1gyOWVCNVQ2NkV1MVFaREhGWmJ2cFFZNU9Ja2lqNzU2?=
 =?utf-8?B?WE1RRHUrQnd2dHdUN0x5d3hXL3ljNXJ6MUdjazVUcFBndXp1YkhBb2Z6WG0v?=
 =?utf-8?B?cU1ybFRobnBocXhESS85eTFlTUNtMzIvQTZBcDVCLzBJWk81cUtjdnpCak5y?=
 =?utf-8?B?TVpVY3B6SDlkNHBnQjlZSDNaeXlXTzhJNkZ5LzlqaFQwTGFFNUMrR3Y4THhi?=
 =?utf-8?B?N2Q2WldPY0pjOURQVHl3dDUzS0pXK3BsbCs5VXZVL3JBQ05pT2h4WEc2OWJn?=
 =?utf-8?B?OFlzaVhlc2d3bVFNZU9xT1dOZTNNdk8ySGozamRNSVZHRUl3MldMRzd4aGgr?=
 =?utf-8?B?akM3ZFBISlcxbmFLTlM3MUxmS09vOWVWNmY0OGR1ajVTalh2cWRMbkdmOGRq?=
 =?utf-8?B?MzNkSGg5L1VOU0ltNEVqdHJ1NnBGejI0OHBWbWFRd1JsaGxlMllCM0NMREpB?=
 =?utf-8?B?U0dDR2lMZXN0NTRIL0V1R3JMcU9iWEFHZ1R4V2R1c0NZWnc0U21EWi9vYWRK?=
 =?utf-8?B?a1pLL1R6WkVPYjhLUXBYcDRLcXZFUGVLcjJQRnRRZHk1U0FKSW1VSVMzc3B0?=
 =?utf-8?B?SkJsc3dPQ044MGRaQVJNRFd6b202Q25hUDFCYndJYU4za2RzYmQrTHdwRG95?=
 =?utf-8?B?ZjF3ZGhiaXJvdXo1UWF6RG9EMjcwZVFqODgyeDZ0dmg2ekVycFlNeXV5WW9q?=
 =?utf-8?B?ZUg3NGh6ck9mSTYzK0Y0TFRQbVVZZ09SR1A4WGQ0cVphV1hoNVlINysvODVN?=
 =?utf-8?B?UUE4WWRnNU5rbXkzZ3Jya2tjMk55ZTIzdUduYU9MWWpUTHNpVGVqQ29nRWtR?=
 =?utf-8?B?K3FvWEhybWRmenZQeUd4eThmYmlnTTd6a0JvM2swOWVXR3ZTVmVEd25HVGdu?=
 =?utf-8?B?dFZoNVIzZkJDTktDSWI5L0l4MnJicnpXTExhRThaWWwyMlRtUGVUdzVidXly?=
 =?utf-8?B?cHBwK0g3TnhTZjNaRlZtY2FvMUVqV2wvVElhVmlVWlBrT1RVNnV0dUt5UE5i?=
 =?utf-8?B?L1VwaytsT1l3WE9YN2lVSVpKRnV5NzAvVXBnRDFzelNSMzNjek9xdmdBejZy?=
 =?utf-8?B?MHhweUxPMzI3ZG9wN2RYZDRMQ3psRWIwU09xMzNBTlBCYnZYeGRTbzVNeWFY?=
 =?utf-8?B?QmkydUdRcE54SFhZbVV6TnFidkY3ZG5GdEh6YVVtanlVaDNzZGdNaTFrKzM4?=
 =?utf-8?B?N3N0L3ZnZXVjMGdxaVZhbkxTN2RTcE42RDQyN0NkSCs5UjNKRDY5amFDbURU?=
 =?utf-8?B?TndUMFBSOUN4K2hpYWxBN2I1YnU5Q29BcTBuNGtjOVh3NlFLai9rcENqU0E4?=
 =?utf-8?B?cEtGQlYydTV0cnRJa2N4N3lYSjdyb0hqTU14U1dJeGR1WWhJa3l0OFFIcHpU?=
 =?utf-8?B?a2hUVDBkb0JiS0YvVGdoT0pCYUJaVTZLZzh0YU9TZXlicjQ1R1ZmaUFjVHho?=
 =?utf-8?B?d2paRzZjY3JSSEZ3OEZXc2pLUkx0RVhQZm1uWFpTNlJDRURKM0luMCtBcDR3?=
 =?utf-8?B?OE5KNVV4QXdHSTA2ekk3cW5Xc0NGMm5RS1R4dlR0RHgyN2pFQjRHWjJaVGFm?=
 =?utf-8?Q?KxnOxYqpaS8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?L3lKcUx1dTVvSVhvTk5kamh6cTlvYkN2ZmJpN2dmbmVvQjdjd1J2cllSOFJY?=
 =?utf-8?B?MHVrQXZ4aHZlZE8vZFI4Wm9aR0lVWi8zcVQvUEdIOVgxckRWdkhlQXAxSWth?=
 =?utf-8?B?ejhQcDAzZ2tUSWNJWE9RYVdZMm9Eb1pjN2hCNHNxWjJjMmhlczNnK0JBcVFX?=
 =?utf-8?B?R2FOTkYyN21xZGtBZUVKazQ0RXVZZk83b1c1RnpOS3VGb21OYmVZVUphQlVh?=
 =?utf-8?B?ME4vQWt0WWZ0SENWZ2p0VFl4QlBUeDhsSjJWSXdvek1rMUNKZmFWOUwzbUZm?=
 =?utf-8?B?cXFkYmg5ZzVJdHZlbUJ0cWFJbmhWVjI1OFp2VnEwTEw4VlpsbkwyRUJWekFm?=
 =?utf-8?B?MFdjWDA2WmhFTW1VbDFtK3pnYkw2bWhmQWk1V29NdGlxM0Y5dFgwWDJOZ0JQ?=
 =?utf-8?B?MFNwaDArQ240R3NrVE1BcmlWanNzenpVSHJRRGJhdFpvZFpOT0s5ZTlhTTdn?=
 =?utf-8?B?Vi9Kdmx4L3h3bVNKQ3UrZStLZkdwZ1QxTUxDcjN3QWhoUmdwMEV1YWE5OWJQ?=
 =?utf-8?B?cG54bWZQOXo3K1pxUVBTWXVJT002aUpIcVFyUm1nOHlDMGRqdStRV0JMT2l3?=
 =?utf-8?B?Z2FCUHIwOXkxVkhaMDA4UkpoQ2pPNm8rMzV3UGQvZ2M1WnphbmtqZHp4a3Vw?=
 =?utf-8?B?bzZxS3FKUWR6NVFaektTbmJxZFhBenhQVjBkTXc3eC9zUUJ1Qk15MERxSDBr?=
 =?utf-8?B?VzRzOHVvL3BGcUpCNXJVVjVuZFJCUGhnSm8wejhCWXJaSUlHYjdVK1VCU0tz?=
 =?utf-8?B?S1pIT0d0VkpoVFFLaVNqNi9CeHVkV1d5TUlyMHBDcXBJMkNFOFkrWDVGcHVF?=
 =?utf-8?B?cHhITnNWZTJtQzd4WXN5czVqTDNmNzRPNnpWQkdVTWpTRzhMeEdPVGFvT1lV?=
 =?utf-8?B?ZzZidWRmY1hqWlBZWlBpTXNWUHVYZ0N3aTJKZDFXZmg3QU9NcmRuTmsyR1p2?=
 =?utf-8?B?RjdEVGlJcWI0SHM0WVNZbTZjQkppRzEva3oreEptc2d3bDIvL09vUTB5enh2?=
 =?utf-8?B?WG5HR2wwa3VFWkhFK1Y5NjJCNjBPcEV0dG0vOFp6NmRNbEJENlZpQ0lCTmJO?=
 =?utf-8?B?UFp6NUJocUk5WlNIUUI2MkhPN0MzOHpBck5RVXVlZDMreHJtcU1mWEMwcjRp?=
 =?utf-8?B?WTluR1hiMmoxY3QvNHk1Kzc3RDF1NGI0MVBvZGhvSWJmbnNUREMybS9qL09O?=
 =?utf-8?B?SlI4WFFpekpyZ1VXajd5Q29SMU5EaHFzTDNKVU1zQWpQMkttbWEzR21OVGxD?=
 =?utf-8?B?UE9nRXpGcmIweHFlaTdMbi81c0t5d3Fpb29Ia055OC9vV3VjdzBhbkFrY01D?=
 =?utf-8?B?WEhVK3cxbFZCaG0xT1RKcjhuUGk3VjErRWdJdHZsTlZ2Sm9ZZUJiQjVlU1Bi?=
 =?utf-8?B?MjNubnlhcGVnWm11TFVUd2llMHFPQmxGbkRRWjRXc1FISnhwTENCWDNLYldI?=
 =?utf-8?B?aitieCsvZzFMLytFRTJVYk83U1I1eHpZVU1YWXh0b0dFaHgwVGFlVThWTmdK?=
 =?utf-8?B?c255b21RUXl2NFZKSnkwRWhTV3dlaGprTGlyZkx3VVNNaHdWb2M1eXh3YTQz?=
 =?utf-8?B?eGRqV00wSnRtUkNQemFwRVpHMWNGQWF2RGs2M2xsUmZDNWlsVEphOTlnRWVa?=
 =?utf-8?B?enMvSlMxQ2pUK1N5NlpPSGVXbjlhUVllOGFKTkVBZ2RXNUM2WlVCL0lPTzVq?=
 =?utf-8?B?S25Ed29RYUtSSVBCNjh1ZGYwMTllVjdXUHJGVFpPY3dmTmtHTnNMMStQZlNX?=
 =?utf-8?B?Q2ZSUzUxL2FMQ3pWaHRsRU84bk1nRDd6SURYcHpEeFFwVlZwMTk0V3g2bGIv?=
 =?utf-8?B?TTdFcG5HZEE2RnV1cXBmWFRsdnJaTERyZEV0endLT2hkaThVUEJCMXdab0NZ?=
 =?utf-8?B?RVVtVDVYcjZlcjN6VFpybEpYMy9oeG56ZEQ0WkdEb2ZLd3RNUlpxYnJyYThn?=
 =?utf-8?B?ZWhRUVJhR2J3Q3A0a2RUUHVTZk11ZzlUTUpnYldCN1NsWElmWmVOZnNuMGRE?=
 =?utf-8?B?RisxK05ZelFLcUtOZkk0VXpBdUJqQ1FQQ0RFd1lpa3B6b284VTBxMFU5eGov?=
 =?utf-8?B?Q1dJY1pmVVgrNjk4aVhFWkkwSUlVbGxmSFgyVWYyTDFQcGtpZmhCNHUxQ1Vu?=
 =?utf-8?B?Q0h6U0tJeUZxemkvT25LbXBZYzI5L0o3RHBJeFVHeHpDSEx5dElrY0t2SVBE?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vl6W3REwcpYniUq2k6thV1EhAxonJx5a1GXU8gY03HCcpufkN6avQ0/KW4rl/Gvc+OaFsD+qpitB6EFCr9xjt3hqilQ/AHaSy3msRIElWzVa1nys5Uxn5gqX2y3cIxkDBKKgLOsi0d3RFsq2qIIONzz1Bt0qCEyfk1Wi92DHNtaCm4IdGuXnbjX5MmtXT0kEz2FMhZyAHo0eRPdS0k78dAIXMf2Vcnm9diL2VIIetPSGFNqaoz3E6B3aN8nnVOSRVzOaoS8YqBhz6z69wSd0wnxzBrju6ZSnLF+rnCUTw35fXZ4bsHVHyPBluBg4Aq/JMhoXXIIlxPkqk2XoIt7JbnQ/jckXxkOyZYXpwdl2bNsnFP1CRkooj/m/wSLba5tAORLmwX6KrCUKPEi/iTJYETp1NH2Vqw/wEAXAb9NZbAjFUIQVjEdAZGbFCbNExGNiCdGgNxbO1CiicXCrMu5pvRHaiQWSGxA5XQB1kbMYcpFCfSsrnGXFpFSdjiHACtL2RN/Bu28fJkoyZO6gZR4UPeXjOx7JMzzAADJCIjG6ODOpcexB0MfkYSSLTCB2Za/XbPdTmC06Ymk/tUEtNwQJJp5j0SPvQ92kWzSrtzR0vy8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9454f4-b79d-4555-35ea-08dd9d567da7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 19:41:35.9033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5Lpis+fy5co+XEiqbeYzXmtrDnj/HX5GKhtL0N7oAAc2nH/W+fiEFJsK1NnIE/WqahrOpLx7yDZCY6Upsu9Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_09,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505270165
X-Proofpoint-GUID: N7wtL8nj3EKfpS881nnv4CLrCq09-ce5
X-Proofpoint-ORIG-GUID: N7wtL8nj3EKfpS881nnv4CLrCq09-ce5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDE2NSBTYWx0ZWRfXwPnY3KBh5Bbf 5U0gnhKb/DlHUD4gIIA8/raKiesi2Vq/za1NX3B7mI1kcbiERnOZRIOyZvtq51ozMt+oqdG18a+ ORM9tr16AH1k1IdmfklT70NO9pMYacMCgGgwRnRhtQ/lO28IZ4/nRq8olR0FfoYS1bt8tbzJdat
 qUoLuEan3VtBFLSS5u0Icr1jkiBIJGfP6ayy/buq720W/y3Xqt2qpKRCTIrOZ56tUKOva/Z3Tep 5Y/VHs44+krk7ZYzRkmjywj44FQQBhIQu/cL8XIj4+KgKSRNqGIWQnLxWfaO4UF5LZ5W8VHaP1k PEXk2Q/mWL2k/OdljrXDrnYAGceadF6HroPevPP4OhRavTjsplIDkTe8SBUpeXD3NsRiCDic6+D
 958PMAOgpJR46zIgHSVkK/eT27wP7ScDpOpDjb+x2xNBk4tJS7maDYBHdVmYfktNMK2/t2D0
X-Authority-Analysis: v=2.4 cv=c8qrQQ9l c=1 sm=1 tr=0 ts=68361573 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=A1X0JdhQAAAA:8 a=mEza3si5AAAA:8 a=VmTLJXlr-ypnv_8QofwA:9 a=QEXdDO2ut3YA:10 a=rjRlSLlayDNRPJ6elN85:22

On 5/27/25 3:18 PM, Benjamin Coddington wrote:
> On 27 May 2025, at 11:05, Chuck Lever wrote:
> 
>> On 5/25/25 8:09 PM, NeilBrown wrote:
>>> On Mon, 26 May 2025, Chuck Lever wrote:
>>>> On 5/20/25 9:20 AM, Chuck Lever wrote:
>>>>> Hiya Rick -
>>>>>
>>>>> On 5/19/25 9:44 PM, Rick Macklem wrote:
>>>>>
>>>>>> Do you also have some configurable settings for if/how the DNS
>>>>>> field in the client's X.509 cert is checked?
>>>>>> The range is, imho:
>>>>>> - Don't check it at all, so the client can have any IP/DNS name (a mobile
>>>>>>   device). The least secure, but still pretty good, since the ert. verified.
>>>>>> - DNS matches a wildcard like *.umich.edu for the reverse DNS name for
>>>>>>    the client's IP host address.
>>>>>> - DNS matches exactly what reverse DNS gets for the client's IP host address.
>>>>>
>>>>> I've been told repeatedly that certificate verification must not depend
>>>>> on DNS because DNS can be easily spoofed. To date, the Linux
>>>>> implementation of RPC-with-TLS depends on having the peer's IP address
>>>>> in the certificate's SAN.
>>>>>
>>>>> I recognize that tlshd will need to bend a little for clients that use
>>>>> a dynamically allocated IP address, but I haven't looked into it yet.
>>>>> Perhaps client certificates do not need to contain their peer IP
>>>>> address, but server certificates do, in order to enable mounting by IP
>>>>> instead of by hostname.
>>>>>
>>>>>
>>>>>> Wildcards are discouraged by some RFC, but are still supported by OpenSSL.
>>>>>
>>>>> I would prefer that we follow the guidance of RFCs where possible,
>>>>> rather than a particular implementation that might have historical
>>>>> reasons to permit a lack of security.
>>>>
>>>> Let me follow up on this.
>>>>
>>>> We have an open issue against tlshd that has suggested that, rather
>>>> than looking at DNS query results, the NFS server should authorize
>>>> access by looking at the client certificate's CN. The server's
>>>> administrator should be able to specify a list of one or more CN
>>>> wildcards that can be used to authorize access, much in the same way
>>>> that NFSD currently uses netgroups and hostnames per export.
>>>>
>>>> So, after validating the client's CA trust chain, an NFS server can
>>>> match the client certificate's CN against its list of authorized CNs,
>>>> and if the client's CN fails to match, fail the handshake (or whatever
>>>> we need to do).
>>>>
>>>> I favor this approach over using DNS labels, which are often
>>>> untrustworthy, and IP addresses, which can be dynamically reassigned.
>>>>
>>>> What do you think?
>>>
>>> I completely agree with this.  IP address and DNS identity of the client
>>> is irrelevant when mTLS is used.  What matters is whether the client has
>>> authority to act as one of the the names given when the filesystem was
>>> exported (e.g. in /etc/exports).  His is exacly what you said.
>>>
>>> Ideally it would be more than just the CN.  We want to know both the
>>> domain in which the peer has authority (e.g.  example.com) and the type
>>> of authority (e.g.  serve-web-pages or proxy-file-access or
>>> act-as-neilb).
>>> I don't know internal details of certificates so I don't know if there
>>> is some other field that can say "This peer is authorised to proxy file
>>> access requests for all users in the given domain" or if we need a hack
>>> like exporting to nfs-client.example.com.
>>>
>>> But if the admin has full control of what names to export to, it is
>>> possible that the distinction doesn't matter.  I wouldn't want the
>>> certificate used to authenticate my web server to have authority to
>>> access all files on my NFS server just because the same domain name
>>> applies to both.
>>
>> My thought is that, for each handshake, there would be two stages:
>>
>> 1. Does the NFS server trust the certificate? This is purely a chain-of-
>>    trust issue, so validating the certificate presented by the client is
>>    the order of the day.
>>
>> 2. Does the NFS server authorize this client to access the export? This
>>    is a check very similar to the hostname/netgroup/IP address check
>>    that is done today, but it could be done just once at handshake time.
>>    Match the certificate's fields against a per-export filter.
>>
>> I would take tlshd out of the picture for stage 2, and let NFSD make its
>> own authorization decisions. Because an NFS client might be authorized
>> to access some exports but not others.
>>
>> So:
>>
>> How does the server indicate to clients that yes, your cert is trusted,
>> but no, you are not authorized to access this file system? I guess that
>> is an NFS error like NFSERR_STALE or NFS4ERR_WRONGSEC.
>>
>> What certificate fields should we implement matches for? CN is obvious.
>> But what about SAN? Any others? I say start with only CN, but I'd like
>> to think about ways to make it possible to match against other fields in
>> the future.
>>
>> What would the administrative interface look like? Could be the machine
>> name in /etc/exports, for instance:
>>
>> *,OU="NFS Bake-a-thon",*   rw,sec=sys,xprtsec=mtls,fsid=42
>>
>> But I worry that will not be flexible enough. A more general filter
>> mechanism might need something like the ini file format used to create
>> CSRs.
> 
> It might be useful to make the kernel's authorization based on mapping to a
> keyword that tlshd passes back after the handshake, and keep the more
> complicated logic of parsing certificate fields and using config files up in
> ktls-utils userspace.

I agree that the kernel can't do the filtering.

But it's not possible that tlshd knows what export the client wants to
access during the TLS handshake; no NFS traffic has been exchanged yet.
Thus parsing per-export security settings during the handshake is not
possible; it can happen only once tlshd passes the connected socket back
to the kernel.

And remember that ktls-utils is shared with NVMe and now QUIC as well.
tlshd doesn't know anything about the upper layer protocols. Therefore
adding NFS-specific authorization policy settings to ktls-utils is a
layering violation.

What makes the most sense is that the handshake succeeds, then NFSD
permits the client to access any export resources that the server's
per-export security policy allows, based on the client's cert.


> I'm imagining something like this in /etc/exports:
> 
> /exports *(rw,sec=sys,xprtsec=mtls,tlsauth=any)
> /exports/home *(rw,sec=sys,xprtsec=mtls,tlsauth=users)
> 
> .. and then tlshd would do the work to create a map of authorized
> certificate identities mapped to a keyword, something like:
> 
> CN=*                any
> CN=*.nfsv4bat.org   users
> SHA1=4EB6D578499B1CCF5F581EAD56BE3D9B6744A5E5   bob

I think mountd is going to have to do that, somehow. It already knows
about netgroups, for example, and this is very similar.


> I imagine more flexible or complex rule logic might be desired in the
> future, and having that work land in ktls-utils would be nicer than having
> to do kernel work or handling various bits of certificate logic or reverse
> lookups in-kernel.

I agree that the kernel will have to be hands off (or, it will act as a
pipe between the user space pieces that actually handle the security
policy, if you will).


-- 
Chuck Lever

