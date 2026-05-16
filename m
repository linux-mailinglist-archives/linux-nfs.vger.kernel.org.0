Return-Path: <linux-nfs+bounces-21653-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGVoCzrTB2qDKQMAu9opvQ
	(envelope-from <linux-nfs+bounces-21653-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2026 04:15:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 881CE559DD4
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2026 04:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57FC33019067
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2026 02:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FF71427A;
	Sat, 16 May 2026 02:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LvQF/Le3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cWsWrDnb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D615ECCC;
	Sat, 16 May 2026 02:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778897719; cv=fail; b=BbQ3IidFKWUIbcVEd92j11e/5beMYXRsBRHQ3J1i3kRKYko18pKcZ+fEXKA4AKuWaK5A+s+jtc0SeXyUMtiS8ssYOfpSXFCz6sxZLGzZdfecCzBUzkqLTsm5JGb6NnPkORMwUJEsbhxFdXP1UxobTHzTxkoDjBNX4M72SvS7c/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778897719; c=relaxed/simple;
	bh=a1Lp/SMxhKs7vgo5TrAeLip6lbTlTkymQgc2JjAavrA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DgLiPCvhx7zYQUO3xnBT+zbUgQIxdQ3Hvi9znKh64C+aLvnG7YFMvpdDA9WZbwt3Mp/mdZpFweUsq7xRkAvee+bsR7D7iypKnoNxcef6C3Vc3bSrhhCrj2SFwVRHhEUn9WxUa3sWkg+i0wdQz9SSa1T+H2bCojCM/a/9MPaBkSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LvQF/Le3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cWsWrDnb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64G1vQ8n2051028;
	Sat, 16 May 2026 02:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=a1Lp/SMxhKs7vgo5TrAeLip6lbTlTkymQgc2JjAavrA=; b=
	LvQF/Le3NeZmJhoh3Ue/dM5NYn/f9/2XlGPiSgSfhg3LgKKDwpkQ+h2TmguGpys0
	lBatY5xL0oxznPioWq9I1OFOpqKpUaOmiZD/yxMkYDUBS8Tf8aKvXZFHmufu3Jqg
	rYgfVggnDD6wGJf7adxCXxCY/iXNVXnNVyfP0nR0Pddlxx1RXJiKDmjkrpfyGeuy
	zi4Jfp0lRagdwMFr1Q0RevaT7OQSkXBbeXDf9B6C5p7cKyHFrLsfyTW7z8cDpjeo
	rPrP/CaNTibq69ojx8U3zgNdwS/shS0Mh0Tg8EwP3WF5ay+SwyFEOaz78lJS5L3+
	jNt4QqR9VxveQdq/23C/qA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6fc480b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 May 2026 02:14:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64G2ErW2003857;
	Sat, 16 May 2026 02:14:53 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1cgtw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 May 2026 02:14:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3a/q2Yv4ux9Jbc/EVvT6AprttpkFyH0YBDV97Pzk5+NtAYbEmsj3E9XgbPW/jcr6rwe9G/OcY6vCjvOlr4MDvxcOc/CLjQZmd6zEBekvRUv9R4CH3H9bk1NSFNiHaRrYDAkOx6A90bq1aZl9UdDX9RB5VCUFUMbHLVRJDFlkDY6pZYDY2QL93Uc6J4g1NuF6K22EGBP1t2bveDa18KHzDeXdJd3bxP9jalm0xwIeEqMI/eLuwLqPsizBvyGtFD49nXZD/U9mS+lo/tAHpEZa3W55eSaPc7Vo49loJEAXS/TM+Gx3nI1usHUFFHLoGgheU3v/08obt2jinF6bPuklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1Lp/SMxhKs7vgo5TrAeLip6lbTlTkymQgc2JjAavrA=;
 b=OB9jXohWXGV+N9d8qg9bdy+fCcgnCEHpmPAeYWGa8fTnd9fCTLtfj0NBtuOZoc6bD84EOX2Pp46SVw7a/psWskHuetZXO1epEKO57v6qHu/638DKKf9SarBpSQxKS0Xpz6NhPBV7lgioCqoqPl8fkU+HNVglrMQhiCBn3MpipS2ox9IXo102gwlkBSJvXhErm2sDWtl842J2BaWcXXokjDRF92cOIbJ2ayRz2QpuYn0gpNR0alJJcR1m7WgyrH2It6g99VQBqyg0GRVpx+oblNu2QTy/7RmFfaVmRia6tZ4enjyCX1iuC95GOcfK03JeKpB+Wsi1GZT6y6R8J/91UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1Lp/SMxhKs7vgo5TrAeLip6lbTlTkymQgc2JjAavrA=;
 b=cWsWrDnbSb1m3nJygvLEJpFlR+OdRj86gSLUgfTmXo0FMX1LRjfnjjKwyF7NbAkbnHoq4hgRmXdKBZ+nRKE76XQHJ/uYWyJIlbFGD4FKLZywp+2O8akJ4io2vYEzw6K3eolMB/IywmEMCFedzu+1atRaymEzghMO8CMY/1AOE+A=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by PH7PR10MB6378.namprd10.prod.outlook.com (2603:10b6:510:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Sat, 16 May
 2026 02:14:31 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9913.009; Sat, 16 May 2026
 02:14:31 +0000
Message-ID: <b9860332-7b1e-448e-869a-ad59d8d5b7c0@oracle.com>
Date: Fri, 15 May 2026 19:14:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
To: Dave Chinner <dgc@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260512172238.2495085-1-dai.ngo@oracle.com>
 <agQhzg-0aeISwOGW@infradead.org>
 <961eb355-2f52-47a0-9399-e050a4e535a2@oracle.com>
 <06d9b1ae-e46f-459c-bcb4-1a5ca4ded4b0@oracle.com>
 <20260514002513.GQ9555@frogsfrogsfrogs>
 <26365a46-bdac-4e8a-a951-de904c3e5606@oracle.com> <ageSguSyf2kBY33a@dread>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <ageSguSyf2kBY33a@dread>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|PH7PR10MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e93c02-87ed-42ce-785e-08deb2f0dd64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	17YCrzbQjgcQHDP1erCR4/6EJmwrw4CtUIz0vA3AflWEEHLgQVNturP+3Pdyp9EfJxK0D3xWOuTwD72gRnRn0EvKthdBtYTrx5lHSos5uz63zFSjgbk/CizU2/45nJ1XjS6bp3yh6Ldw1wBefP2rOrH24wP4NhsVqnYbxFoSjgHV2UXXpv4p7M9TbUFlwLYD1sQemCNNwua8JTiABAFHpTHmg7zscRYWtuV3U2uNpXqyQj4tbcF0H1zLYcjIULIhwPuZ6g3j4DPeGW+DV8DfNVQnzM+19uWISq4ixFx4pbqIc9jR3Ej8pDvDsBP1eBU65CdMG8Pl65ZCgjkWXYOUpBiYXROkUWXMsQiva5vSK8KcrTF9awcQNvZl+VzLEVRrYkCoLT+95YbSyowTPHCiyKPzYM+A04S8a4AVGpnsg7vIZ6Oh06NdWwGBocYFdTzKgLKQR+jDRJrkXT5XZ6LlNIMq6FpKiVAbCkA0KAUXhTQ30LkQcT+ABoQzpXk/XuHSbrnF+0e0MojNKz13ZefE4RCEPkS/iJpbaWoRm/lcxyAJjVD93BIHxetgpSt7BGoWTXI3wq2M5BKZCOOc5PqUBU+fE2aJONhdJYYvv3AT+FpyIi/Xd0WYowNKLMRRXjP3VmeMglFSCMHw8lOU1at3QJpW6czdxuVz9Pzz6tOKDsJicNom22F8gvmCdH7L9lnl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1FzZkc2U3hKUUpVVnVTM280clkvUjZrZWtxcEI5MjA2L0d2NWRNUi9BcTVR?=
 =?utf-8?B?bS9vQ0xSQlY4b3N2Sk9uM2kra3FDQzYyUWFyK2NaYmVUUFVONlhwZlRNYXFh?=
 =?utf-8?B?R3lJRDNCN2lIcDc1RldEWTlNWHpHR2J5blJwTnAwT0xKZGRKQ1oralNFWlVR?=
 =?utf-8?B?c3Jma3JEU3doeUF4TTBYRGwrZ3dUWW9KdzBxMUM5ZzRhWVJzY2Exck9vd3Ev?=
 =?utf-8?B?bXhFMFRoalo5WisrU0xpOUg1VGFKaGtoYzk1YmJJaGFnald4SVdCanU3Ukk2?=
 =?utf-8?B?UXoxTmYrcnF6RTR2Z3BoUmo1NTQ3c3NBa3ZMMlJNYzN5aDE4L24yVUNMNjUy?=
 =?utf-8?B?LzMrVFFEZ0JlWUxPSXNWd2FhMERWQ08yR05wYkUrL2dqR3ZlU0JKZHRTdXd2?=
 =?utf-8?B?V1NRd2hrRjltdmQ5NVFxaGdWdEJSWk8xWENlaHJkMm1oVGRzZ1NscGZ3bzlB?=
 =?utf-8?B?NlZaaFdoWm9qeWpxdldaR0RtTitDL2owNWtSUUdxYzRtTFZ5RnZ6ZjVKTjdI?=
 =?utf-8?B?dklmODBsSjlaMlgzOVppVWhSUlBHd3RnYTM4SlkxdElmZWorZHduWmhjUmkw?=
 =?utf-8?B?N0tYZ04vSyttRlpLYUQxYldaSTZYVGJXZ1BpR0U5VlF0TGh5SnZwcDRFNmFY?=
 =?utf-8?B?clBKV3RIVi83akNmZ1lxeXlYZzhwZFBBemhNSnc1cTdoa1crUXk5aUxLVUVy?=
 =?utf-8?B?bXNDZ1RKWERxb01SaitTQUxaZFNQRDREMkxZOXFheUJpcmlwdGs4UGpVcU02?=
 =?utf-8?B?eFdTcyt4WmJlcTVmTGZNdnZKMDBiVjRGWkU4dG1BU0czY01VZlVjRUxCd0p1?=
 =?utf-8?B?N0ZacXFZQkgvMmt6Mzh2WXRRSmpEUGZTRzZ6ZTgxRDMwcnFROElTZTg2eFFa?=
 =?utf-8?B?NUpYUU9MQUwxN01HN0lwM2E5K0RMcDBtY0ZTMzkrejZNMW1jMDlZWUZ1cEhr?=
 =?utf-8?B?NEVYSXFxbFZNSTNseHZYTWxFamNtcjFGVElLU3MrV0lvYXhCZUZxWUYvSEwx?=
 =?utf-8?B?MzBXRjhzcERueDBsUi9yeUVCaFdrT0lpejVyM05palphdDVCbWN3QWt6Z01i?=
 =?utf-8?B?SFRpMG1jbW5PZnZJbWM0R1U3aFNPZGxRSkk4bWVxdnpJV0l4RkhQUHBpTHBj?=
 =?utf-8?B?WjBSeCtGY2EyakV5cDk1NURaR0JWSE40MmFsekluLzNmSERhamFJSWtyVzVG?=
 =?utf-8?B?SU02Y3h3SXRZU1RkQVNzWUdVa1pGUVlMSk05VzhxOHNUWjQ3MTdISGhqNmhB?=
 =?utf-8?B?S3dETk45dlJrRmFqbThUTW85b1pGL0NnOFJvTnhMUUkrM2ZJQ3p6ZEhkNmxL?=
 =?utf-8?B?VXhNSHNuaVBSc1hJR1FtNjVMeWNMNk5LeG9yeEg0NFh5NFdMMWo0U0FjZXBi?=
 =?utf-8?B?VFNHMnFYTWY4VU83TkN1eVlDZnJsMzA3bjI1bzcweWZxSlNvRkhzQzNobith?=
 =?utf-8?B?TWZuandla0pNN2htbjI0V0ZaZndORlVXeVR1WjkzS2ltMTg4NlQ4Z21CdERI?=
 =?utf-8?B?d2FwejJZZDFyYS90VFhRTEdOZG5jVUwwQUxjNThkazR2V0UzMVRCTUl1S2tC?=
 =?utf-8?B?Y0VZQXNDV0RwQmxTR0JkRnc2YzNaZG81MFl1NjFRaDJpZFZkL3RLQnBGN25D?=
 =?utf-8?B?TWlRYUFUTnpkck9WM3pTZ1ZFaVZ4U3d5TWZwaGtDZWluZC9aZXZiRC80Z0Nl?=
 =?utf-8?B?WTFtN29jemVjS1Z0bU5tay9KaGlSMVdmbW1hd0tHMFR3emRCdjdrTWdzV2ky?=
 =?utf-8?B?dUlRNVZVWFNsNUxRN2FrT0JHTGxYUEFwZGtSVUhWZ2dIZ0VpS2hyUmdPMFVh?=
 =?utf-8?B?TmhURDBGWVBzeDRJS0VudVBaUzA1SThvZzhPb1gzMG5HNjZvWVNLeDlZV240?=
 =?utf-8?B?RS9lMkFSaDhycjNZcUZDbE11YjFUdlAxRmppTFhyVzZuaSs3cDlRNitsSjV1?=
 =?utf-8?B?S284bHp4MGwwaXhwZmEyL1JWR2o1N054UFM2eHVTaitlb3RWZGp5dkl6bnBQ?=
 =?utf-8?B?QVpiY2g5eXpHdEVOSm1iUFMwTnV2ZHF1emJRUU1UZVBPVVBidTMrc0s1NWQz?=
 =?utf-8?B?aEZiNGxHTnB0V0R5SHB0NTN4SlVVRzVQb3dmTXZyT3h5dkJPamFMWVhMTjVr?=
 =?utf-8?B?UDRSQUlyL0oxRm9ucU52cjRiekh5VFVUVGpUY21kUm9NMm1VM1pmUThnMkVl?=
 =?utf-8?B?ZTJHRG9raXNnMFFxTDdBWG1VODVSTmFyaWF6MXB3Nm93ejY2Z3JtUG8wZlNE?=
 =?utf-8?B?Y3o0T1dxcFFxVkpaTEdvSVNPSXM0NVE5U2RpZVEwVGZSdkloMTRUK25hY3dl?=
 =?utf-8?B?enh1K2ZoQnNzRkgrUjNKRklBYjhjNStZRG5BODFPQndZTFVhSDNTdz09?=
X-Exchange-RoutingPolicyChecked:
	j/vOpfSKDC5OnxEMebZSTQOZyZg7BaT2VzMbogrLvYEXXkko5d0HhCJKREJlG7ubrIaBmZZAl2UVAsJhe631oPXbaJDPsw/jjbgoYxiWl6M+FImYJyZBuRYoXRs8gKii7uzKwr7BJSA2nWgZ8Uy8WtY3m66ST9IHEVu4pIb7MCwlQIFWYEp225/kKZXTQPyA2bchDFsue7ascm9qXkH1gRxuRrMPMXj7QDE/K9/QzNeUSSqCwza5MkRuJMwKFWs/bMPxD+YiR+io8y3L/rK6HwdYQmtZPc4YcG65bZTMCOs583iLibsVp0AaAb3y1FERhEk3LIC6SW0gIL2QKDeOAg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	refpdGs0WrurNV+VyzYg+PjFFrCI7HkbJxElCdPTEn9fuOm3Gt1kwC8F7N+QrO2ZSAjgNXyJNyEzImMhe8t4rlrhAygXs33FwSTP9LLLTZlr9Y2k86WogH8Rn4JmocyoqDIMh2a2kDuF/Q28Ld8JNOIBAItOisxZb8YpBBMHYuC1al4s/7LLFggZZScJXZGiT3tFXv1yjeMUxJ+qDP6tmleKX8fHbNDTxh6ED/Z4lRCoWHWgYPNBJ0wupgp/19vtprbpN8e4NyQA4XkA/KGFZGDZebNE0QC31oHJlaCsQ6kNGYVIOIfakmfPeXuYlB+7dVmolkbT5L/kLdl116p5WYH3UFPArltwHN2xg4J7pQnucVNYTk7g+doYVl69HneOmGzQu5JvsEOjjAd04cXjf0gc0wFHLVYh4WYeeToNelA3l6VS5XXb50g1TAecW1Dg9Q+Jxa2Ij1NCiZ8CcJdZfNiBfmI8HwUVqejqZyKblvk3KGfUCOORsT7ljVUZE3rBU/fPQNshbmBvX6L732lpDbY+S7LleGRX67m/5DTl+0Att9Wn6bFFtr2NOfwzby303UNgzgDwu4uNUuKmjd63Exq7IjcVGLB8EFvmgqZr2Gk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e93c02-87ed-42ce-785e-08deb2f0dd64
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 02:14:31.1161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FizJWYns56OWfZh5FGqcbVT1sPDWQu2Ko9+bpjOnqgS95yOWbHekdwPY+13abCgHa1RKV+fGYfhRRoj5S0P5oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6378
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=879 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605160019
X-Proofpoint-ORIG-GUID: YKuE4c5tPuvomcE9leIoJYRTVLAWAe9L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDAxOCBTYWx0ZWRfX2zOlQvDQwanF
 /nRbyipo9cTTAkeFWcL5D44dwwwN/3wpdUUAF/X5UVUYXpqZIL8mBt6AkWoOjt3SiRF5P5l4u7V
 7ZQdHqcjmm47vBGIsagxU3rdkJKtxLI5tm6bNICmcGOci8olUo7l3VpE30XdeYGe9qGUi2bwAJf
 GLr29K7x8Xs42KgAduW+nAACQByHz+k7gWtnoNjDZLuNRibmypPSBJfrsyh+MC45pGiqFwMlJvL
 nauM7LjH0zjpKLM9RzZvDH3eQLw7Lo1JtlNdgs/p0FGh9dbHJQEhBhvJEX5mQs95+w9iSQl7B2Y
 cXvnAsFv9CcY7NPv3hF2BO+ty6Am/qmqTqux9TgUP0iBGI4jBDO7NO+lBmjjpKMtUlTM+jV6t1+
 J6kxR6sDzo4BfAPx7SN/dW4PSd+ZyhLk4OLxRAvvduaEhSOVo2UpsBtI/+59YyiLYhDfaiY1AGI
 MnVp+gM3s2FmZUwYq8G65TQe1cqqx0zU6AisBn50=
X-Proofpoint-GUID: YKuE4c5tPuvomcE9leIoJYRTVLAWAe9L
X-Authority-Analysis: v=2.4 cv=FIErAeos c=1 sm=1 tr=0 ts=6a07d31e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=BknJsMtBOfDUz9pBjiUA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12299
X-Rspamd-Queue-Id: 881CE559DD4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21653-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi Dave,

Thank you for your feedback.

On 5/15/26 2:39 PM, Dave Chinner wrote:
> On Thu, May 14, 2026 at 10:19:14AM -0700, Dai Ngo wrote:
>> On 5/13/26 5:25 PM, Darrick J. Wong wrote:
>>> On Wed, May 13, 2026 at 10:28:31AM -0700, Dai Ngo wrote:
>>>> IMHO, I think we still should fix xfs_fs_map_blocks() to avoid any overhead
>>>> and complication in ext_tree_insert having to handle overlapping extents.
>>> I don't know enough about the nfs blocklayout code to say for sure, but
>>> it seems like you want to upsert the mapping returned by
>>> xfs_fs_map_blocks into the "ext_tree" right?
>> This is currently done on the NFS client side by ext_tree_insert(). The
>> question I have is should we enhance the server side by passing '0' to
>> xfs_fs_map_blocks() so the client does not have to do the work of
>> handling the overlap extents.
> I think you've all missed the optimal solution to the problem.
>
> The problem is not the use of XFS_BMAPI_ENTIRE on the first mapping
> call, it's the use of it on the -second- after the first call didn't
> return a range that mapped the -entire- request range.

Currently the map_blocks() API between the NFS server and XFS does not
provide a way to specify whether XFS should use XFS_BMAPI_ENTIRE or '0'.
xfs_fs_map_blocks() just uses XFS_BMAPI_ENTIRE.

On the first mapping call, NFS server always specify the whole file
range that requested by the client in the LAYOUTGET.

So if xfs_fs_map_blocks() can not return the requested mapping range
with '0' on the first mapping call then I think using XFS_BMAPI_ENTIRE
in the first mapping call makes any different.

-Dai

>
> Hence the second and subsequent calls need range trimming so that
> they don't overlap with the first range that was returned.
>
> IOWs, we keep the use XFS_BMAPI_ENTIRE for the first mapping call
> so we retain the optimisation that minimises the number of pNFS
> client mapping calls needed, but if it needs to make a second call
> we drop the ENTIRE flag and append extents trimmed to the range
> being asked for (which doesn't include the first extent already
> returned).
>
> That was we get large extents reported most of the time, and in the
> corner cases where we have a race like this one or an extent
> boundary lies in the middle of the requested range, we will get
> correct, non-overlapping behaviour.
>
> Best of both worlds, yes?
>
> -Dave.

