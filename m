Return-Path: <linux-nfs+bounces-2570-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4129F892C33
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Mar 2024 18:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC75D1C20EAE
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Mar 2024 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E461E89E;
	Sat, 30 Mar 2024 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nNwi5e3x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ad9kivD5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BE01E865
	for <linux-nfs@vger.kernel.org>; Sat, 30 Mar 2024 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711820781; cv=fail; b=BO9dohQNCKx0JphFdWjGpotrnh+ZcIM+n2EX8z+uaSruF9RgGUqlS0nlP0iFkJlzd/hHu4a04KP2tgULumMFHm0CUSdi+Me6EHg8E6zQ/chaJICa06jIJKljtm1AgJ1TUlRWJNKzjUZay0NMMCil8x1fD49RIgicdL8Gim5xsSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711820781; c=relaxed/simple;
	bh=k6hRTcwQH/kSiAGt/uvqR7sIpogG3zTbJ4nqzUagT3U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Km9EpXVsMyHJBWdjOGttfDziTG8gRY+KXdoG3R/dzf3W8MAqvK61TB4a2wD0lDfdPSA2Pxw+SAjdh7Z5Vlg9fpYhn1UC98eqFLmxvCoIglQrlF0g2ZKM3mHshIarMzpMnEZhlKwLHGckvysSFJAk8JSQXMzLZyWXlPE7+1PSlbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nNwi5e3x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ad9kivD5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42UHGTDa006149;
	Sat, 30 Mar 2024 17:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2iHNjCs9fbGhLSrVVYlJnlnsB9O2Z61dd6/A8XcAPKs=;
 b=nNwi5e3xNog22vjvolb1dJ633X9d2918lRF0uFaaj8rHgTIWiNMN3FbPMpvcYDaH69jH
 kOcy3J6C507opTWrkyX9ox6jkLdYxlpOWilRHBxYGWFoBpgCEzSXYKPWDGtmO7mLEizI
 5Lh/Ezu2Pt+Zzj+q8DfNlUrGpsK1Rw97lT9GuAa1bhvTj4W38EtjfG73ja2qDCVDdq0v
 quXOP0JASSVyVOG25vcwdtm/HLPGk2zr3Nrmhvp4pQH+REIdR9fm1CYRMHpFCzTIAxp1
 3+xBLrAOVk0BeS0U8NmQga298EhKjz6e1oeiJf+k332nWWUZM75FovWEnz3PAv+ssGaX bQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x69h4gh99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 30 Mar 2024 17:46:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42UGewuO018549;
	Sat, 30 Mar 2024 17:46:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x696a6va3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 30 Mar 2024 17:46:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQEl9Qs59h6/QMVSbInX77uourLQ8+orudGexxB/h2j4mxmUJ7Rcka63L6JifRs23JmbNuO/Q29n5LEL7zG3i4QQOZz8HMPVAPFf3JpZdv8Lh6LwKWDm2II6SnlNPkKu1R/7EGUDWxZMBHVkwXJpaWk/AS5lWfvD/nVxwdjxVR2dQ5/KPsRxRAeeguSRzMrX78DRaRGI7PEKqZs3yNoVcNuLBDeliMoVkGsFsXbpwsrleYe8uWZk9bCuKKiKQdwfkp8tdnAhAXrjKbfN7E3gulNFxDRT4irk+Nb8YgqPgR0EsW3XmczEDlMG0Ql1Ree4+8AhstOqdYszkJBbZAX2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iHNjCs9fbGhLSrVVYlJnlnsB9O2Z61dd6/A8XcAPKs=;
 b=gNEeqkvN96iyfob/wyY8vbN6iTvHPUox9uB0GOQ7XZ1KRxW9UWFrqSqbtjALn1Ruu+ABlwcaN1KGz8AQE7pk3q9XqGBJjlEPVMPWg8mwUYwSMTEmZ/hN980PDyj1hOU65m0it1VrqbFo+reCZq294+uPWETrv34PqmLHHzPjgW5IiM4BUBSZwqFPqR6l7aZ+VoySN5hgMFgjngoNxLWS9RYridiUkNZwP9QEPmsgfmqxfPCfwN4bKowUxfzKZqIt0zVjVxYmsW/8Din8+lgRHo1dHcgbVv/y7YUVkb870gqMGezm3K69KdG7qLqjj/BZHXy0JWAokpkxLqFw38GHxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iHNjCs9fbGhLSrVVYlJnlnsB9O2Z61dd6/A8XcAPKs=;
 b=ad9kivD5XRjRruF+Rf3RejekkyqPpHLz67icooCK+BiQqavBXJHavd4qQNBfHB0SsKsinfMk1OlM3lhUZJeoPn9HDuZqSAuaNEmRcOlIWwNJrc4lRD8dAx1eHvSxaoxGAktPF+JIm0d6SKZEQ5AXixr0KTA1e67YBL4aV6gyfEA=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MW5PR10MB5807.namprd10.prod.outlook.com (2603:10b6:303:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Sat, 30 Mar
 2024 17:46:12 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3%3]) with mapi id 15.20.7409.042; Sat, 30 Mar 2024
 17:46:12 +0000
Message-ID: <09da882f-4bad-4398-a2d0-ef8daefce374@oracle.com>
Date: Sat, 30 Mar 2024 10:46:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
References: <1711476809-26248-1-git-send-email-dai.ngo@oracle.com>
 <ZgMToHNkkGEHNb/y@tissot.1015granger.net>
 <69914825-e9d5-4859-a5a8-60d17e8e8bf6@oracle.com>
 <ZgV5zwR0q/vjBAtI@tissot.1015granger.net>
 <88fac8af-c194-452b-94eb-7658b9056246@oracle.com>
 <c97be8b9-c0ba-4f2d-9340-78368008ba4b@oracle.com>
 <ZgbWevtNp8Vust4A@tissot.1015granger.net>
 <97387ec5-bcb4-4c5e-81af-a0038f7fc311@oracle.com>
 <ZgdR48dhdSoUj+VM@tissot.1015granger.net>
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <ZgdR48dhdSoUj+VM@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0031.prod.exchangelabs.com (2603:10b6:208:10c::44)
 To BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|MW5PR10MB5807:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fwCZGvxaXWfH2qkPg2T3Lh9kX4xfMVEFJ5FMyzagz6Mq+P2M0gqCSqtsLuoKPEMB/15iW2Wy7g/Vacr5ke5Ar/aw8oS/vyZUlqyS7jfOqkLGpJGtRIKQfqORC9/QcTPJTCxE/2nJLWea4usSwfUUlh6ZeoFyBmNysaMkdIPWz3wk7C0XzSkna+x1QvKImRKfXkfqgsSjlH9ExhKvYY1bkltf2+YxmIlX01PbZNDxdREjgE/ja24qK6jQyu07cR8yfzjMzg+b1z/T+8Y60WjTLshS++mxtDj2xJaWYrGA2fb9Ceo7bM9GjwqrtFyhbzX7JqGuOQAFn+7rvT+5wpXWhyfj8Rifgl8Gw0bbCwRJCCGYKvIwoOglhdWy1UKzxCYTj7zyF8d38dwJNoU7QQVCQvX2X/3Vk7cP+ziNgZW8/+pEYNPOO5vsnp3Fd7b2Ov6FaZAtLhtPJ0PKiIQbyIkhK6ZTYklz9vLH2bBSGKYJ5LUTR+xKsPLfkSgNGMub3xmxCPbHqL/pizNTlIClq2sWrbpWi1sveOA1jEopoggdfW8ss7vYGWbZjdmhnt41e+zdtBuAY0M1sG/hNSguc5waEKRqkMbdTQr0WqpPgdBfpVsAGkl8mDDd6ciVct1OgHg8asmaFkBVVmJRP+asiw0xcBmEfyLUUeVofSyAwOpTQ80=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eEdpQ0w2aUx1YlNldFB0M2EweG93ZXBseWladWg4WVd3cUROWHh3dXVEc1Ft?=
 =?utf-8?B?cmpCSFJCOXIxQ29JNExiRGpBdFJSdmVVcHZOcElrdFJVY0VNRHpDT0FIQ2Rn?=
 =?utf-8?B?c0xwbk1MNGdKYVgralpneGwxTS80TkdlZ1ZIUG9BVW0wQSsvUWdTTWNXTDhr?=
 =?utf-8?B?VWtZVm15dzc2bThUaktmUTdSM1FrRGJNd050SDZqbjVxNTFqa21qQ2ZzZHJj?=
 =?utf-8?B?UzNiUTVxMEFFWkU3NGd3dUdaMGVUcHQvdVcwZEk1NVlER2xUYkR0UFE1Ym1B?=
 =?utf-8?B?TFNwMXNmdUhHNDFjaFdkQUZwbFRoRXpFc0JJY21GYWVWZVRZaktYakdCdHJ1?=
 =?utf-8?B?d0ZRS0VyaFZ3NVdtbERtcFFudmVaZDJVdmZmTXk1RnZ5c3M0Z0FHZVljRjZa?=
 =?utf-8?B?VHM1bVcxaTVKeUZ1K0N2SjhFcVlaZ1M5SEh5NkNpRFlnWUQ5cXU0MjVnL2Vz?=
 =?utf-8?B?d0w1ZEg0MEF2ZnZ4WUc5OG5XaTNqYS9pMFU0MGpsTFN2amR6M1BMbmdZVVhY?=
 =?utf-8?B?WnNhaW51MTNlTE1DWEV6QitoRW92dk91Qnh2YUd4bjhoUjh1MWVPR09mcmk3?=
 =?utf-8?B?RVBpN0xSYjl3V3QwVjk0TVVEVlF6SlIrUTJMOGo0SUhKaWZlNTZKVGdGRjF2?=
 =?utf-8?B?djZLMUk0Z3N0QjBmNElBbk11SDRoak1WQmRocDJOS3I1bUJZQ1c2R2ViZHNK?=
 =?utf-8?B?bmJXeis0VmJ1R1dmNDh2emRseGpzSEpVNXQ5ZFIvRnRidDJ3cllpQVJGSnlx?=
 =?utf-8?B?NllGYkpGVStmTjEvYmFlNXg4ZzRuZDRCeXJJOGh2a2pXcjNNSUhtblR4UTF0?=
 =?utf-8?B?SDI1V2pCdC9haXVGYzVEMlF0MDJBTS9UOGdpT2FzemgzUkR4MC8yb2ExYUpL?=
 =?utf-8?B?SHZuWjdzRU8rMVpMMVlXUTVUU0JGc3BwcTZWSFhLYW1KR3RwUURkakZSV0ZI?=
 =?utf-8?B?TTVZejJ4QnJ4MXNKcC9RKy9HNlRsS01NanB5SHNaeVlwRDRqb1N5R0ttaVRH?=
 =?utf-8?B?MWVwa3JNbWxNYlNwTDR4Mm1Teml0N2pTNEF0UFV6RmJ2NWxMWHBITWZuMGZI?=
 =?utf-8?B?aW5EWDZhNnVRQWp1WWczL1VsdjVjLytURlhJSHJhNTgyK3RRdktheGhOWGRj?=
 =?utf-8?B?ZzE1Sy8vVXFBYTZsd3NYVS9vNHJxNU5Qdmd2RHkwMENQTG5RZWJOT3NuVlVV?=
 =?utf-8?B?ZVJrSThSbUp5SzlSZnBZY1VVY0pQWjhuZXFPaFVjWS9abEZRMnp6RFp5QjM0?=
 =?utf-8?B?WTM4Sjk4NE5ERlRpQ3RDT0MxRW5nVUN2OGZjSjFUOXVvZmNLUHhVajMwaTFI?=
 =?utf-8?B?N1o3djZPU1ZCK2h1NnRWZ3liY2N4MC94Zm1mVlVkUENNTWtnMm42dkliR1Fk?=
 =?utf-8?B?ZHo5bzhiZEd4bDNaaHc5YU5LWm1BVDRxNDRwZjJUZDdqTjhPZnRqbHp4OFJ4?=
 =?utf-8?B?YVdwTXlZcFdlWk9sKytGbFRTSHdiV2ZvN21zbWVtUy9UZUh5eE9YYzB6SWdG?=
 =?utf-8?B?RzhHUlFqVlNndjRVcGVtZFBQQW0ycXdvL1JEMnVoa3hRRDRnT1hkUG5uMUlZ?=
 =?utf-8?B?bFJDYitkRU55SVQySW51dXo3WXhZMzI5WTFXcTNvZDN0anRWWG5jMjZGN3VH?=
 =?utf-8?B?M3VINFlnTlRYMFM1aEIrS0xaTmFqTkZHLzJLN09MR3BkODFWUW9kZWlEaHdY?=
 =?utf-8?B?cTZxMFhjSWt4UjVWeFkvby9qaHRSNWNEZ2xzRXhmNGNoZkVjUTBoaXF2bUNt?=
 =?utf-8?B?ZlpoSzRtdFRMeDVETjloM3pTM203d3EydE05d2FNWDRVd3NPNEVKaDljQjJ1?=
 =?utf-8?B?d0tFSjcxcjNGN2ltdDlzRGdJRzZFSGQrbmg4c3krQTVXdzN1cXBwS0pFVHdh?=
 =?utf-8?B?bGN6Tm1hZUFXQkl5T2oxWVV4V2UyZVlpOW1zMDNxQldIVUQ2T2FucVhDa0JL?=
 =?utf-8?B?THlRZ2lNNEtqWW04Z080QTZKbFVmM2FJZVFFYTc5VzhWbHk3RmkyWllxbnUr?=
 =?utf-8?B?TU95R2pGcUxPT20yajZqS25UdHNJbXd0aW4xWkpQRlBqQytqVCtzSUhxQWRL?=
 =?utf-8?B?MnJ1TytoaWpiQ2FxTE1Tc1AyWHJXa05YVVRWZ3RiMG44WEJaWGtxYjUrUmhZ?=
 =?utf-8?Q?i/3IDWaEDNaEuHh14EBvOmr4t?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kJ22GjlEOxA3HK4u0v9DvZJTRvbTmeJ8E97+N/Y8UefuWaoDpfNecGcgyJ9OJmYkhirkgQQrl2Mmd+x8pEz4NToVIGCZ3WIGWHsvffvQtOmNTbE9b9DiV39qFcIqVa/NMuPgdnKb5BTQX1HVfynGu4swIM80sBNaw8c9o+N8bbdSYV/HoR0u2bh8SuYFPav4+YP1vd5h3j54FA473UudtvL+8rrd3U++AG841FIQ6d/aBelJt4gk9Oich5KRJuz864WgmBFqwpX98UFUWRDT0wXlED8H9wSK2jbXUI2rxU1kPA81MDcHdovkxscWT3CiMtftWyqTmK6nrKYzdgwmmnRFWKOZvV9OrhDnQoqUEicQ5Zpk0CtjTcL1b5+5QD0fQxx4vfTEFidy4g6PC7BauYcA4NQfdHCo0JcVvsiKTVLBlp0sZK1zBv9McW6yI8kVe3va6hLG+YlefGZIuDgRe081bnQgvJykSfwt1mi5JxsA/PXOEI6oz/LRT7IzTGkNFsFYDVPrQESxZlB12//ZQbM1lMu37iE92GPWezuTkMJEqfiA8rexpmUoixw0ujo3KJunKWzk0DMOL1tAeG1a3Vst3ZQTjwZvNpwrENCE3UM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d8ce4e-7de4-42ec-d080-08dc50e14a30
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2024 17:46:12.4250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6tAUHUO+o6uuNrOQeQIGKouVIDxsTABmf0DPfKZ1PBmSfTYcWbYPE0WFUOCsXBevCXttzgt1ZK3Z45NwHPgng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-30_12,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403300145
X-Proofpoint-ORIG-GUID: 1tCrRE7IytrowuihnKSc7BcpmuEmawds
X-Proofpoint-GUID: 1tCrRE7IytrowuihnKSc7BcpmuEmawds


On 3/29/24 4:42 PM, Chuck Lever wrote:
> On Fri, Mar 29, 2024 at 10:57:22AM -0700, Dai Ngo wrote:
>> On 3/29/24 7:55 AM, Chuck Lever wrote:
>>> On Thu, Mar 28, 2024 at 05:31:02PM -0700, Dai Ngo wrote:
>>>> On 3/28/24 11:14 AM, Dai Ngo wrote:
>>>>> On 3/28/24 7:08 AM, Chuck Lever wrote:
>>>>>> On Wed, Mar 27, 2024 at 06:09:28PM -0700, Dai Ngo wrote:
>>>>>>> On 3/26/24 11:27 AM, Chuck Lever wrote:
>>>>>>>> On Tue, Mar 26, 2024 at 11:13:29AM -0700, Dai Ngo wrote:
>>>>>>>>> Currently when a nfs4_client is destroyed we wait for
>>>>>>>>> the cb_recall_any
>>>>>>>>> callback to complete before proceed. This adds
>>>>>>>>> unnecessary delay to the
>>>>>>>>> __destroy_client call if there is problem communicating
>>>>>>>>> with the client.
>>>>>>>> By "unnecessary delay" do you mean only the seven-second RPC
>>>>>>>> retransmit timeout, or is there something else?
>>>>>>> when the client network interface is down, the RPC task takes ~9s to
>>>>>>> send the callback, waits for the reply and gets ETIMEDOUT. This process
>>>>>>> repeats in a loop with the same RPC task before being stopped by
>>>>>>> rpc_shutdown_client after client lease expires.
>>>>>> I'll have to review this code again, but rpc_shutdown_client
>>>>>> should cause these RPCs to terminate immediately and safely. Can't
>>>>>> we use that?
>>>>> rpc_shutdown_client works, it terminated the RPC call to stop the loop.
>>>>>
>>>>>>> It takes a total of about 1m20s before the CB_RECALL is terminated.
>>>>>>> For CB_RECALL_ANY and CB_OFFLOAD, this process gets in to a infinite
>>>>>>> loop since there is no delegation conflict and the client is allowed
>>>>>>> to stay in courtesy state.
>>>>>>>
>>>>>>> The loop happens because in nfsd4_cb_sequence_done if cb_seq_status
>>>>>>> is 1 (an RPC Reply was never received) it calls nfsd4_mark_cb_fault
>>>>>>> to set the NFSD4_CB_FAULT bit. It then sets cb_need_restart to true.
>>>>>>> When nfsd4_cb_release is called, it checks cb_need_restart bit and
>>>>>>> re-queues the work again.
>>>>>> Something in the sequence_done path should check if the server is
>>>>>> tearing down this callback connection. If it doesn't, that is a bug
>>>>>> IMO.
>>>> TCP terminated the connection after retrying for 16 minutes and
>>>> notified the RPC layer which deleted the nfsd4_conn.
>>> The server should have closed this connection already.
>> Since there is no delegation conflict, the client remains in courtesy
>> state.
>>
>>>    Is it stuck
>>> waiting for the client to respond to a FIN or something?
>> No, in this case since the client network interface was down server
>> TCP did not even receive ACK for the transmit so the server TCP
>> kept retrying.
> It sounds like the server attempts to maintain the client's
> transport while the client is in courtesy state?

Yes, TCP keeps retryingwhile the client is in courtesy state.
  

>   I thought the
> purpose of courteous server was to more gracefully handle network
> partitions, in which case, the transport is not reliable.
>
> If a courtesy client hasn't re-established a connection with a
> backchannel by the time a conflicting open/lock request arrives,
> the server has no choice but to expire that client's courtesy
> state immediately. Right?

Yes, that is the case for CB_RECALL but not for CB_RECALL_ANY.

>
> But maybe that's a side-bar.
>
>
>>>> But when nfsd4_run_cb_work ran again, it got into the infinite
>>>> loop caused by:
>>>>        /*
>>>>         * XXX: Ideally, we could wait for the client to
>>>>         *      reconnect, but I haven't figured out how
>>>>         *      to do that yet.
>>>>         */
>>>>         nfsd4_queue_cb_delayed(cb, 25);
>>>>
>>>> which was introduced by c1ccfcf1a9bf. Note that I'm using 6.9-rc1.
>>> The whole paragraph is:
>>>
>>> 1503         clnt = clp->cl_cb_client;
>>> 1504         if (!clnt) {
>>> 1505                 if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags))
>>> 1506                         nfsd41_destroy_cb(cb);
>>> 1507                 else {
>>> 1508                         /*
>>> 1509                          * XXX: Ideally, we could wait for the client to
>>> 1510                          *      reconnect, but I haven't figured out how
>>> 1511                          *      to do that yet.
>>> 1512                          */
>>> 1513                         nfsd4_queue_cb_delayed(cb, 25);
>>> 1514                 }
>>> 1515                 return;
>>> 1516         }
>>>
>>> When there's no rpc_clnt and CB_KILL is set, the callback
>>> operation should be destroyed immediately. CB_KILL is set by
>>> nfsd4_shutdown_callback. It's only caller is
>>> __destroy_client().
>>>
>>> Why isn't NFSD4_CLIENT_CB_KILL set?
>> Since __destroy_client was not called, for the reason mentioned above,
>> nfsd4_shutdown_callback was not called so NFSD4_CLIENT_CB_KILL was not
>> set.
> Well, then I'm missing something. You said, above:
>
>> Currently when a nfs4_client is destroyed we wait for
> And __destroy_client() invokes nfsd4_shutdown_callback(). Can you
> explain the usage scenario(s) to me again?

__destroy_client is not called in the case of CB_RECALL_ANY since
there is no open/lock conflict associated the the client.

>
>
>> Since the nfsd callback_wq was created with alloc_ordered_workqueue,
>> once this loop happens the nfsd callback_wq is stuck since this workqueue
>> executes at most one work item at any given time.
>>
>> This means that if a nfs client is shutdown and the server is in this
>> state then all other clients are effected; all callbacks to other
>> clients are stuck in the workqueue. And if a callback for a client is
>> stuck in the workqueue then that client can not unmount its shares.
>>
>> This is the symptom that was reported recently on this list. I think
>> the nfsd callback_wq should be created as a normal workqueue that allows
>> multiple work items to be executed at the same time so a problem with
>> one client does not effect other clients.
> My impression is that the callback_wq is single-threaded to avoid
> locking complexity. I'm not yet convinced it would be safe to simply
> change that workqueue to permit multiple concurrent work items.

Do you have any specific concern about lock complexity related to
callback operation?

>
> It could be straightforward, however, to move the callback_wq into
> struct nfs4_client so that each client can have its own workqueue.
> Then we can take some time and design something less brittle and
> more scalable (and maybe come up with some test infrastructure so
> this stuff doesn't break as often).

IMHO I don't see why the callback workqueue has to be different
from the laundry_wq or nfsd_filecache_wq used by nfsd.

-Dai

>
>

