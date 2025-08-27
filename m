Return-Path: <linux-nfs+bounces-13917-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69C4B38B2A
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 22:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6B916B1A4
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 20:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBDC3093D2;
	Wed, 27 Aug 2025 20:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K9A7Fn4+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SGfo5AvH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD712D0C7E
	for <linux-nfs@vger.kernel.org>; Wed, 27 Aug 2025 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756328182; cv=fail; b=ZocV/cPD6gQ/uTQe2thOgMeLMURjYT6OFhNQgA4OLJ+t9Q+SuwOBMggtkeqrADAG3dKyUNQ5rF1U1lvz0Le1G0/MixTnHMX3PQIxXseBw57EqnsH+j/iTSMpOzUhcPZ0TlAqmvArG1I3X5y5UsWkQHNDP11MYxtYiONipIqZW0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756328182; c=relaxed/simple;
	bh=bne6EDczo+WHoOa95QX7TzUOpOUGfVZmHyU/FWvbqqY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AexxCeLsEvwSzjkUHNaSHAajeotft+tsepbSrkhtXMRP7/Zh1qAk3USMEqi2eHlfYDLe/DE9sM4QgQNZhvm8YYXwjRVk3iXVKO/es/ay9VQ9Yshb2eyND+FppylvW+cZ4i2OXH7Ug1K+m73T2ATYcuURFNPF97aDr9VBhX7AMmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K9A7Fn4+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SGfo5AvH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RJu8mY011415;
	Wed, 27 Aug 2025 20:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9Y8lyUirdaX1lvXV0GAuDleJbd4x6p5WJGLHohhfc7s=; b=
	K9A7Fn4+Xd9L4+7UAZC201S+Q7uK4HrlgI2BxLgbKCRMKgOxNph4iOZouETPlpXH
	gwclPSzT/Km7Q7jJ0rfa279ceNNtUe8Ez5ZxaIdFl63oHo1rHLCf0kehAQ1wK+88
	0GdsP8JUMolVxrQXht1S0yJgByjq+NsqyXjBqjQUTp6UevxXOGmbYlpu1TBnhxp+
	PTQTlJbkgzhzeerHE81bvpluKUshf1gXXn6s0x9OSUolz97TjBIHEoJxDBpfYzmP
	k9MLb7gjD1wadRllyFrGdWMZSTV/SehaSEq8OFWjqYgnDRdM1PzeikWlNAnpShQE
	b0Z+zkSnTHdi9luMmEfi6Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q42t75ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 20:56:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RKms0K005107;
	Wed, 27 Aug 2025 20:56:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj8bbrts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 20:56:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPUR96cIpBHX+ZxIsTk0AW/cIcrsDgyhhkuBJ+XCqK+ox4z1pDVK4ds9Ng5lh1FdiihK2NcqWmdJWZGxEvzcbJCYrfwKhBOL2kwfJ7aEqv+GbC1sSFxWhaGIa4A1IcCclJ9QA5SdA936Ukk9ljqhw3Ex0A4QJwzyjRka3+fzLdKczsuWpfmjgsAOoNKj4rKrXXMcG5ynGvfW+CbU2TXhrZsHZl6r7dmWPveE7puiww7vY5FjGjgC1eniV4HuLrVrGHTRgZl+wTJsJm7fECbibjXLPd53joN+Hv/Ps1mG8m7huk/R2iIpi+MnEl9uJLG4dHX7fEY0EnvPOoWCf58jhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Y8lyUirdaX1lvXV0GAuDleJbd4x6p5WJGLHohhfc7s=;
 b=SWxGLO+JN1coMjq74VDdwjsHBS5WnyaSl2Dkl2a189Vjkw3MYZwtdeFMumY+66ODnewZSQ160o8D0UZ2hsfDYNYlL9zX7A36BI8CEh6jPmPKWrdvR5EG/Wa3d/PQdVo2EE4YhDHyEcviqsIBOW+Ij0mKlsijzaf1z2/dDQmf/rUvbxVp6nwuxm7qGTpMyQxqjTTy8cGeoeOuWY//vw8NlTVxootzU9RSPToyFQVKLNmXtD/hQY9y+p7GOL+Gc/Y0WhqxvUn6BpDDyMEq458zkgFpYQFtS1orGXDZpPJb8cMEGihFn7C3lSlu0bsBWK+UZuhGPx1DRNqBDS3b18jZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Y8lyUirdaX1lvXV0GAuDleJbd4x6p5WJGLHohhfc7s=;
 b=SGfo5AvHDGhuYL0GkAn5giHKHhJC9xMLWB2g+b+YRIaE/W2lEkst7oFjkkkiYuzffXzUFXG/SbnUuQ8OrrwkNhBkhlCq8fNKRKitz9m6uaLtRYTkL43LIX5rZlqF8zGBm9+sz+113AOpzQYklGx9far8FNnZMolSR5ArjDZpTYk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5001.namprd10.prod.outlook.com (2603:10b6:610:c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Wed, 27 Aug
 2025 20:56:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 20:56:10 +0000
Message-ID: <6f5516a5-1954-4f77-8a07-dacba1fb570c@oracle.com>
Date: Wed, 27 Aug 2025 16:56:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/7] NFSD: issue READs using O_DIRECT even if IO is
 misaligned
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <20250826185718.5593-1-snitzer@kernel.org>
 <20250826185718.5593-6-snitzer@kernel.org>
 <f7aee927-e4fc-44da-a2b6-7fd90f90d90e@oracle.com>
 <aK9fZR7pQxrosEfW@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aK9fZR7pQxrosEfW@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0002.namprd14.prod.outlook.com
 (2603:10b6:610:60::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad69064-0692-4565-b167-08dde5ac2687
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WGY1akpDcFJzaHVqcGx5N1hBMGNQdmdrU0tzYXdDMVJINTBsMnJGMFd4dEh6?=
 =?utf-8?B?dXU3QjBmQzNqZHI0R2J1TFgvbmlDUW8wb0ViMUowd3VSdXR5TGVTSzZBdW5F?=
 =?utf-8?B?KzF5MzRsS2ZCV3YxOEg0VGl4UGxaNWpqMXh1YzQrK0Y4RDRrVEpWeEo1K3k2?=
 =?utf-8?B?TXlVRHBqRFdtWXIrZ2tCcmp4TE9qU2grejNJSXBxVld2bkova0FBdXpjUEJu?=
 =?utf-8?B?TXBmVi8vS1Q0Z3k4U1NESGV3SUJhNFlXKzFoTElBUW9vblZHekxicDMvWC94?=
 =?utf-8?B?eDRFVjRaTVNqaytzcDBQdmFmYlIzdEQyYmVocHZqb1ZuaGJQNWtPSjN4WGta?=
 =?utf-8?B?NVczSjZVKzkzVWJsZEROOVpJbDRqeUNFeXlla1R4Z2N3ZXZvalhpeVlqNzFH?=
 =?utf-8?B?N0daUDdmWC8yWHBvMHFQaUxIOUNYUy8xOGpzVFdjTDBZYlpiVkErajBmdVVD?=
 =?utf-8?B?cnJpSC9vZkEzcTFMN1RpNEVxWjZxLy8reG9yUHFNZi83dC9IdGx4NzFMWm5j?=
 =?utf-8?B?enM1c1ZucXZuL3JSZ0kvRlhFQTlaeEVwRHhaNXROQ0t0RzhKeFE5Tm5qQjVZ?=
 =?utf-8?B?MEQ5WnRWeDZ1RVFwanBwSWFLdkM0WmM1Q0t4RkpVT3NxcVM2dzhwZDQ1QkdT?=
 =?utf-8?B?Skc3OElndGc2SjVYcWFLRE4rY1lHTlg3QXFUU2VPZ1p1TzlBYkZLdFNQREZY?=
 =?utf-8?B?eiswaEU1SGdFRlVodElocXJYVEhjTW43YThGaFBoa0tqT29nMVlVNTVkbThy?=
 =?utf-8?B?WGVqVGhQM3QweEJSQ3paZ0dIWDNOSmlWSEYxanFFN1crRTcrUjNyV09IRWZu?=
 =?utf-8?B?V2pDSEUxc2F2U3pSQnp5eHFybEg2VVVtREZTTC9UdUlqTWNDRWsxZHhTbktq?=
 =?utf-8?B?YnFPbE5TaldPVmx3TkxsNldHaEtUQVRHQUpBVUlhRUlPYmxZRGthcENDZDBs?=
 =?utf-8?B?L25mUllObFFIcGxHb0I4eXFjRk5hTGdPM3FOVXV2c3p3cXNPdEloSEErVi85?=
 =?utf-8?B?N3FGdmtubWYvQzZOSXh6K3BLT2R6SFlsSWNwNmhjTXZJR3hwSGNMUTA5OGRZ?=
 =?utf-8?B?bzh6NUdYYnp3Rm8wcmRvZ3ZPRTRGVlQ4TGdYdVJGZjZXYTAyNGZ0SStjZUpH?=
 =?utf-8?B?MVkxN2RPMWdhL2ZPUGJnREIzRTVmTXVxeGlkek5UVk91NjlZTVdPajNiakht?=
 =?utf-8?B?NUdZc1k1NVZiWDRHWEhMZ2ZMUjlqV2QreThtQXpZUWNkMkZOckRVaTlSWnd4?=
 =?utf-8?B?b2FSOVJtYXFOUDZoVVcyOXNHaWtpd212cmJzZGtIQzVIcXRNRmZ1aFRYTVAv?=
 =?utf-8?B?QzZTY3Qzcm9iOWZxM3RrVlI2WHU1N3VOQXJjMkRPMWk0cG91YmYrR2JGMmo1?=
 =?utf-8?B?WG5pOE0xWVlqZGtwekFzYXpNVkc4VE51UFYvanlMUzdjakNaOG45N0M0RUFP?=
 =?utf-8?B?MFhLOTJBKzl3MkNqenhWSXZjY3NXaG15cVJSemExMWo5NHdtbElLSkVPWUda?=
 =?utf-8?B?cTdNMTc4d3hVVlovYW8zUEw4NVQ3Zm9udXk1NnJWd3ZQQ25UOWNKUTlQK01v?=
 =?utf-8?B?Z2w1Y0JtMGZrTUlodFh0Y2RURUtydzRQQ0lYU0JLaytuRXMxd3pGYU9CY3Vv?=
 =?utf-8?B?Mk9GUlBuMUlwbWM4TWd2a01UUHcxdkkvYmowM1RhYk1nWE5QTDBTNDdzZmxV?=
 =?utf-8?B?UnNUeWVuYUVpbmNRSmxqck9YMHpWY2JCdVU4T3RqK3A1TkRKaCtCK3Z2V3NU?=
 =?utf-8?B?RU0yRHpabEJsQ0lRNDNHQXNBOHp5b1Y4ajZ3Ujh2MnNmWHB1U2hsZko2TTNj?=
 =?utf-8?B?SHBLN0o2bWIxcEY1Sy9EblNTQkJ5elJ6c1czM1NUMGR3amtua3dxcmpRTHVF?=
 =?utf-8?B?ZFFPTmJJSDJyZWdkd0p3YjUxQTRzRkJqc2RMbEZCNzBVUVlyRGE5WWY0N1FH?=
 =?utf-8?Q?LGmk5PA8wA8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?azQ4ZzVncnBsR3oxaDhwRmpPMnJUV3ViejlJdC9EY3V0R0I5R1VDN3JCN0RW?=
 =?utf-8?B?cnVTK1J5emhPMGR6RkQ5dTFybDhVZHRxbDVTVER0RFBoTFdWNnZBSk0zdCtt?=
 =?utf-8?B?QlRNeEVQajY2V0hESTlqOEdWZHhHWWNtQUZ4RW9SN2cwcHRlckgwOG95S1hi?=
 =?utf-8?B?dzUyOEVhWHllc2d1NFhaUTFEY1ZGejRvVnFaT0pEamFJaGFwVmNLT3hRNGtX?=
 =?utf-8?B?bXc0bHJlTFdmdkJFSzVkQWU2VHVKRVY1TFpWTVM1Vi9rVGtkcWRYL3RmTkFw?=
 =?utf-8?B?MWE1ekNiQVltejl1U3E3Zk9vdVN5R1owUTQ3WllPWFUvYXBUZWx3MUtkOUM1?=
 =?utf-8?B?d2IyOHVJZHg2SWtBWDViMUJSL1VRY0NXSzR2bGg0OUZKVTdHV0dVUlBKRGYx?=
 =?utf-8?B?b0p2U3ZtM3ZPdG95NjRjRlRRYVd4ZUM5K2d6SFNEcjQ1N3dnbzZ2QzRtR3NQ?=
 =?utf-8?B?Z1RjUHFFa09neGdGaUlOVnJBMzRLL3RvZmhUYVRybkxLVC9MMkVTNnhVSE10?=
 =?utf-8?B?ZzVLb0cyK0tOT3lwcU9DMmJvVDZKeTlwM01Nc1Q3N2VoVVB1b0NzK1M4aWNq?=
 =?utf-8?B?K04wNE1UWGdMZ1lyQUVQbDR1SU5JK0RsU1pmdHJ5WHV3Q2ptZGV4dUpxdG9B?=
 =?utf-8?B?WGVXVFhsVjNIM3ZIRXJEYUFuMFhRb3pjUU4rMVJ2eGlzNVQ0ZGN1ZUowNXpN?=
 =?utf-8?B?Njl1KzdmOTBJdXlUY1NQYkQ0M29PQVAzeEt2R1VVeHhrNkw3QitMY3JpTVlD?=
 =?utf-8?B?dWpUZDBCQ0Rrb0R2MFJWenpVcUp6Mi9MbTNsMnRoWlpYcXUwREk4bW8vdGEx?=
 =?utf-8?B?ODV6dkVBbHlsUE5aVmR3enJKQTRnUk9EdWRyWnJzQnNmMCtjLzdKOXR4SGlr?=
 =?utf-8?B?RW10aDh4eXpxeVpBUUFTMitiSFlIMCt0SStSTXZ0dHBpdFlkeW5zVHB0OEc1?=
 =?utf-8?B?WUp0aVlaNGZlVUVLOHhVdHdFZkhIVjd4Z2xCelVpdUhOdWw5bVdJMEVBYUIr?=
 =?utf-8?B?aTlPM2s5RnpyU3dZVnVyaXR4RjNFMEw3YkRZMUdYT0NBMTNxMVJGRi9FQXBx?=
 =?utf-8?B?NXNucmJiNzFTRVBNSGx6Q01tdjNMRHYzMFZLTzV2bGdOVmdqTFN4SDFRTFpu?=
 =?utf-8?B?S2YvSmtHRDNjY2VZWHl0SjVRd0RjanB6TUpjbEg2bWpvLzcydElneU80NmFs?=
 =?utf-8?B?bUt6eHZkQlNrbElkKzR0VVdMSHNsbTVVM0VRU2k2TkdTK09KS20wdWdFc0Vv?=
 =?utf-8?B?OFRNdDRseCt3YUZXK3FoYWVZSnZUeFVRR3JKWUJyWTJVOXFXYVpZR0wxSzYx?=
 =?utf-8?B?SXlrMFRNMUo5c1Z6aHJ4S1N3Ym9FbElOMVdDdTV1dXJoZ0ZGV1VkV3orN0dP?=
 =?utf-8?B?Tm82cXcxTHFyTTFpNE9lNDRBUVNSUk0xbi9IeU93R3Zab2hFREFrTUljeXFZ?=
 =?utf-8?B?L1AwSU5tTmMzeUtybXhjRVI3Y2tUbWVLQWozaUg1SkI1SEpvdzhraU5kSU1u?=
 =?utf-8?B?ZVlZM3ZJWFM0RFhhNUN0MldNSGhXeXhCYUMyOW96M1VCUjltNTRsT2hURWda?=
 =?utf-8?B?bVkyUFJFZ2pkaW5sZzhoYnBabC81WXB5K1R4eS83SGJmZFZTSysxaUlTaWNG?=
 =?utf-8?B?NVBwSDliR2oycmtsVHpCWmZOT2xnK3d0ZjUydUtqS1o4bHJWWjN4ZXBNOVc5?=
 =?utf-8?B?bDFXVFVadjVyVDZxd04yVGdWYUVhZVpPd1o1YTl1cnY1VXdTQVlQR3VRUGtX?=
 =?utf-8?B?ZDAzV0s2T0tsQVpLd2t6YWlWRlp5TnMwUXY2dDZRVFFtSzhEaFpZOFJ4cVFr?=
 =?utf-8?B?NmxEQ1hWR1VDN0hLUDNPdFV1eitTM3NkSVlEdUUwMFZic1duM29mSXdEdGZa?=
 =?utf-8?B?eW9lNllKVmVXb2NTUDFqaGZXOGhHUlgxRi8vKzNtWHpIeS9aNFVkY1N1MU5R?=
 =?utf-8?B?S1U3aGQ0WW85NHpRc2ZtdE00MDFHVTIvNytpMlpnZ3p0aitEaEFoTDlwQXBS?=
 =?utf-8?B?VTJscmY4UGVQWmhDS2NXT2NIMVppdmMwcldTSVNxWDh4cURXMmZINzgzaGlr?=
 =?utf-8?B?UXd1eFMyVHdVZDdzcGxOVVV3TnZEYWFqU0xkT0NRTzZmMWh2djlMOFFydGhh?=
 =?utf-8?B?VWlmZk5rbHlKaTkzNm9jVERiMFVUczZXRk4xeGRkOERhb1kwYU42TFhtdWlH?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xPdqPrOTdN0imE/n93ohgsO1Lt7kfIi6DJcN+wqa6zUWkwm4C0qd3m+bw5OpxqmKEYeFyCxVWEpsc5Rg3RZ1txsHrfkYPAhtSazN/TlPZfA2D28HlFg2hzfJ9ryhzd11qTMlYfSl3p+lUTpGTcjl6I36z2h7cRkygE7wTU7dBaHsQODHNaP06JQ9ET8V3EuHGGdFsc+Oy5AWWeoIq988bcuCVa2NKIqDmJ7KCH5Ue8ZiF9YW7Wqsb4y7P1908L8aYvn6oX2x2IkXkvYJybFpnPlZzKepiJqrCcLKFfM5pOLuMfwwNSfR86wvLP8BnFgKsBddEFD76rmvCPJdq1ViN2YxzpcYFRIM98UdStFnbpBMbbz+J7VVobY77HXvGSFwdlbN3Q84JBIgGDeNd0cavNqjxE2REM2gd9lzh8+a0fiem9WyGICjYod9YH6iF+TNG1no2hhOYzpyrbGHMAMe31+q1/mG5DLuHlDNOXmW4fz3zujzDdq+jMvCEHsxf/U4z9d2ewgfPuNs8LiXhp92MUC79fLvJe4jhUQX1TX5YDnK09jCOGo0TO184/2vm6T7GE/bPgwjWHuI5O6mk8ADkXTGLfzieaKGyLsOOVfPIO8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad69064-0692-4565-b167-08dde5ac2687
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 20:56:10.3644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGEr+VJ9B21rnzy6zVX2oJ7Yk2g6kXnZG4Fln25Bdxv4p2/jA3Nmwbsln0PuxKdPwDW/JLUdd87srlCSK3kyQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508270179
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMyBTYWx0ZWRfX5bNXW1k3tfeG
 exewpf31xbCD/2AgzEf4Nw0UO3IuzEEny0jQMIC32bbhPEW5DTU3YhGYiS9+KxzLzJMrUNU9ajy
 ZehGExaTMoF5tR9zOWQNNM5zQjcFxYR8PB0FgYpRzeBtGfAmBBGUskb+KLpG9tXymYartVcxBTL
 Rtd810K+orKoVCdPZZGtKt9D2LwUeWIS09dIUKBHHq7VayU2wTcqzIlgGBLIogA2JxtK4LAH3LF
 wwkkcgt8o8ixhJvfjgCvspx8zBBz6i47LiuIXg/+LSuDVTJDP5lwZzJ5XEN7M1QP0481j9fC912
 M1Dad4bilmYRn89uFECQh5/J8FlLyw0rbR0IU2BfcozFSVezgMBvAuEXEn3cCMFD35nuCTWP6Gy
 X/SF7f4v0InwfAqx3OgQge5IGlLmmg==
X-Proofpoint-ORIG-GUID: mg2Xn-ZZ8j-Pmh04c_3ZYwijBft3qtZZ
X-Authority-Analysis: v=2.4 cv=RqfFLDmK c=1 sm=1 tr=0 ts=68af70f0 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=oTe7agPLaSDZxHoEikAA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12068
X-Proofpoint-GUID: mg2Xn-ZZ8j-Pmh04c_3ZYwijBft3qtZZ

On 8/27/25 3:41 PM, Mike Snitzer wrote:
> On Wed, Aug 27, 2025 at 11:34:03AM -0400, Chuck Lever wrote:
>> On 8/26/25 2:57 PM, Mike Snitzer wrote:

>>> +	if (WARN_ONCE(!nf->nf_dio_mem_align || !nf->nf_dio_read_offset_align,
>>> +		      "%s: underlying filesystem has not provided DIO alignment info\n",
>>> +		      __func__))
>>> +		return false;
>>> +	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
>>> +		      "%s: underlying storage's dio_blocksize=%u > PAGE_SIZE=%lu\n",
>>> +		      __func__, dio_blocksize, PAGE_SIZE))
>>> +		return false;
>>
>> IMHO these checks do not warrant a WARN. Perhaps a trace event, instead?
> 
> I won't die on this hill, I just don't see the risk of these given
> they are highly unlikely ("famous last words").
> 
> But if they trigger we should surely be made aware immediately.  Not
> only if someone happens to have a trace event enabled (which would
> only happen with further support and engineering involvement to chase
> "why isn't O_DIRECT being used like NFSD was optionally configured
> to!?").
A. It seems particularly inefficient to make this check for every I/O
   rather than once per file system

B. Once the warning has fired for one file, it won't fire again, making
   it pretty useless if there are multiple similar mismatches. You still
   end up with "No direct I/O even though I flipped the switch, and I
   can't tell why."


>>> +	/* Return early if IO is irreparably misaligned (len < PAGE_SIZE,
>>> +	 * or base not aligned).
>>> +	 * Ondisk alignment is implied by the following code that expands
>>> +	 * misaligned IO to have a DIO-aligned offset and len.
>>> +	 */
>>> +	if (unlikely(len < dio_blocksize) || ((base & (nf->nf_dio_mem_align-1)) != 0))
>>> +		return false;
>>> +
>>> +	init_nfsd_read_dio(read_dio);
>>> +
>>> +	read_dio->start = round_down(offset, dio_blocksize);
>>> +	read_dio->end = round_up(orig_end, dio_blocksize);
>>> +	read_dio->start_extra = offset - read_dio->start;
>>> +	read_dio->end_extra = read_dio->end - orig_end;
>>> +
>>> +	/*
>>> +	 * Any misaligned READ less than NFSD_READ_DIO_MIN_KB won't be expanded
>>> +	 * to be DIO-aligned (this heuristic avoids excess work, like allocating
>>> +	 * start_extra_page, for smaller IO that can generally already perform
>>> +	 * well using buffered IO).
>>> +	 */
>>> +	if ((read_dio->start_extra || read_dio->end_extra) &&
>>> +	    (len < NFSD_READ_DIO_MIN_KB)) {
>>> +		init_nfsd_read_dio(read_dio);
>>> +		return false;
>>> +	}
>>> +
>>> +	if (read_dio->start_extra) {
>>> +		read_dio->start_extra_page = alloc_page(GFP_KERNEL);
>>
>> This introduces a page allocation where there weren't any before. For
>> NFSD, I/O pages come from rqstp->rq_pages[] so that memory allocation
>> like this is not needed on an I/O path.
> 
> NFSD never supported DIO before. Yes, with this patch there is
> a single page allocation in the misaligned DIO READ path (if it
> requires reading extra before the client requested data starts).
> 
> I tried to succinctly explain the need for the extra page allocation
> for misaligned DIO READ in this patch's header (in 2nd paragraph
> of the above header).
> 
> I cannot see how to read extra, not requested by the client, into the
> head of rq_pages without causing serious problems. So that cannot be
> what you're saying needed.
> 
>> So I think the answer to this is that I want you to implement reading
>> an entire aligned range from the file and then forming the NFS READ
>> response with only the range of bytes that the client requested, as we
>> discussed before.
> 
> That is what I'm doing. But you're taking issue with my implementation
> that uses a single extra page.
> 
>> The use of xdr_buf and bvec should make that quite
>> straightforward.
> 
> Is your suggestion to, rather than allocate a disjoint single page,
> borrow the extra page from the end of rq_pages? Just map it into the
> bvec instead of my extra page?

Yes, the extra page needs to come from rq_pages. But I don't see why it
should come from the /end/ of rq_pages.

- Extend the start of the byte range back to make it align with the
  file's DIO alignment constraint

- Extend the end of the byte range forward to make it align with the
  file's DIO alignment constraint

- Fill in the sink buffer's bvec using pages from rq_pages, as usual

- When the I/O is complete, adjust the offset in the first bvec entry
  forward by setting a non-zero page offset, and adjust the returned
  count downward to match the requested byte count from the client

If the byte range requested by the NFS READ was already aligned, then
the first entry offset value remains zero. As SteveD says, Boom. Done.


>> To properly evaluate the impact of using direct I/O for reads with real
>> world user workloads, we will want to identify (or construct) some
>> metrics (and this is future work, but near-term future).
>>
>> Seems like allocating memory becomes difficult only when too many pages
>> are dirty. I am skeptical that the issue is due to read caching, since
>> clean pages in the page cache are pretty easy to evict quickly, AIUI. If
>> that's incorrect, I'd like to understand why.
> 
> The much more problematic case is heavy WRITE workload with a working
> set that far exceeds system memory.

OK, that makes sense. And, there is a parallel writeback effort ongoing
to help address some of that problem, AIUI. It makes sense to keep a
close watch on that to see how NFSD can benefit, while we're working
through the complexities of handling NFS WRITE using direct I/O.


> But I agree it doesn't make a whole lot of sense that clean pages in
> the page cache would be getting in the way.  All I can tell you is
> that in my experience MM seems to _not_ evict them quickly (but more
> focused read-only testing is warranted to further understand the
> dynamics and heuristics in MM and beyond -- especially if/when
> READ-only then a pivot to a mix of heavy READ and WRITE or
> WRITE-only).

Starting by examining read-only workloads seems like a nice way to
simplify the problem space to get started.


> NFSD using DIO is optional. I thought the point was to get it as an
> available option so that _others_ could experiment and help categorize
> the benefits/pitfalls further?

Yes, that is the point. But such experiments lose value if there is no
data collection plan to go with them.


> I cannot be a one man show on all this. I welcome more help from
> anyone interested.

I think it's important for you to learn how the NFSD I/O path works
rather than simply handing us a drive-by contribution. It's going to
take some time, so be patient.

If you would rather make this drive-by, then you'll have to realize
that you are requesting more than simple review from us. You'll have
to be content with the pace at which us overloaded maintainers can get
to the work.

It's not the usual situation that a maintainer has to sit down and
do extensive rewrites on a contribution. That really doesn't scale
well. That's why I'm pushing back.


-- 
Chuck Lever

