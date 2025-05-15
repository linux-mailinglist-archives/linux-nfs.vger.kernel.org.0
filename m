Return-Path: <linux-nfs+bounces-11750-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB7AAB89B3
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 16:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C77A0165A
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 14:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC7D1E5B9A;
	Thu, 15 May 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OmKdTpQG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GmC6u7Li"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2324174A;
	Thu, 15 May 2025 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320297; cv=fail; b=nDxEZKahi9s7ukb5YZgLMdgzkfVhO+toIxkZR0tMUAORxuTaVfPzForE/vaO9LkSkmOdXgjmy70XDQ0tmAyJ8kh5lZpY/QBWgU3WjLrDR9BO0c70A9MUxuY4PHAE8brGVFt95QqYHQpcQ9fxhpeW9Q8446c1co7o1vNgYoE0rh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320297; c=relaxed/simple;
	bh=HcPkW7LlsQFAe4Q+IvtjIVLMzpNhrYwNQPtBaaztY+k=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=shoTu2dlxwLDcnNYMlsOT0M5eu8O5dnCaYZ6h/gA8oy2PdVbstYCQVBHJyoMutGCnedDVKuXIMP8I75Jw9PiDIn+mO+JZCdM+Ux03nkaFl/28DoG4rGl5lrp+HukYOfS42Qa7AIzNBgaxoTP1augBZ9lc26+DGBxN2dgYate0rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OmKdTpQG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GmC6u7Li; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7C3mF023255;
	Thu, 15 May 2025 14:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jngUMo99wjE7BR8/q9kNrkquOaL3cRDx7gaaV8MV3D0=; b=
	OmKdTpQG19JwXxAAs/XfzawU9n+XlC/sP9bAMlHugSG+x8EsK08I5mvZBtFkL8Wb
	UP/U4C2oqXfrc/AEiFtBBnrQbvm+p5nkorC8E9eFv/tqpT4j91Tzv8QNhenO95Pr
	SdqRg3308qfxpTLAJA6j4oUeaTuDSUHfZLxDpWPqR0NMURr98V1nefbc1pw+J3JV
	So5TkCfeH+Re1uzk1prfnu/OkFICU3IDKqi7xv16JNoPhYkBPZFtdNaf3aJL+9RS
	G+4yjaOAF5oNHX6PHiicMq0x9uP8AJa8D2XSQIZrEmbh+aHIRjXsrONtXo9unbCF
	pnDCYQ9CKaxAlvv1236syA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcgv7bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 14:44:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEMAof004936;
	Thu, 15 May 2025 14:44:46 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011027.outbound.protection.outlook.com [40.93.13.27])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mrme6gck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 14:44:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRJ9TcMgynwmsbarhpJ6bTks/XJRuP3lfjbNSYeezoZFkH1ZpDkLEG9JJVS0lC/Jj/EGIoxT592Fgx8al0Lr9vhyYp6Al6cpL3xZ5RJbpGwbRPWrbJwRR+mxMdmqliUSMZRJg2qzP1Gcf5wIdTUzyTnftNbM30y+QmQ2p4mkbZmX4K3kEM81wdKgash2cMH3zMEQF/oH/RKy/AKB56yF18vgW2ReYzg29tRGsWFo5OBS7rNRftW5rtBh5AySDrByPo5Q8PBT/Z7RAIAYhniyZDl/uTm9JAmfflQkm4Xe5DX0FTQtVWHAN9inMv6ZsUrX4uonToYBJ2EmCrTVjVbrJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jngUMo99wjE7BR8/q9kNrkquOaL3cRDx7gaaV8MV3D0=;
 b=qO28cI2nEfWIDYFOg9SFkkz1I1Q8w365n43bPacQxx7U9KgsQaARKvxIid+B+/ieFuBEmrYBiaNCrLlPj7CFg22uy1Zw9CPQcAgdgrdWVLop5jU71daZVH0Xs/wtOK75HbY5LqB/BDBJy5JlizxFsN0HeLZOmQa12E4bSZYDYsJ6aTb9IQyTHyGFTclLIFpWwdPQK7HVc5NN/h1Cu5FDRvdiz4WEdQDCNi5Q0jufOD3699LE/XKToWgCsnpbe7ycOUfrQMivPhb/NqyqFL1KZ5slHrd7ReH/twvd54OT951amgzP9EiKOJB7BhRB0eYW8bCjttajDbc4+Dd7oFFIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jngUMo99wjE7BR8/q9kNrkquOaL3cRDx7gaaV8MV3D0=;
 b=GmC6u7LiREXU/w/elUk8+xGgaFQP6sG9LrtEx+9ucj2+WE1wIhoGsVrLuJdTfIKwLfAlO7VTdugoCqbd0/0WC1NSHJIPrKAOywhEiTRO5FZTMA20b8o0+LIkTyUPPlNMggzPSQaoz3q0DiRnrvNhW52ALGYzIW2VLikkmrXzHnY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB7508.namprd10.prod.outlook.com (2603:10b6:8:17d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 14:44:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Thu, 15 May 2025
 14:44:42 +0000
Message-ID: <20d1d07b-a656-48ab-9e0e-7ba04214aa3f@oracle.com>
Date: Thu, 15 May 2025 10:44:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: RPC-with-TLS client does not receive traffic
From: Chuck Lever <chuck.lever@oracle.com>
To: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Steve Sears <sjs@hammerspace.com>,
        Thomas Haynes <loghyr@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>
References: <0288b61b-6a8e-409d-8e4c-3f482526cf46@oracle.com>
Content-Language: en-US
In-Reply-To: <0288b61b-6a8e-409d-8e4c-3f482526cf46@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:610:74::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3c6826-2855-47d8-48c3-08dd93bf0757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGQ4cnJmSzRtMlVCQmFuUnNYTkNBNGlVUTJGcTN1T09qS0FCQTBRVCt3ZHFG?=
 =?utf-8?B?bHFxNmZPTVNkdmRvdGJLN2NORHE0K2tucDVyRDQrTDNsQVk1dVVUSFgxZWNk?=
 =?utf-8?B?M2x0Q0hVU01adS8zNTZ2emFSWkxFRFU5d2RRODRIQVNUaEEyY2pSK0gzbm5p?=
 =?utf-8?B?QnRZVFJlWk41L3ZHVHdIYVZwd1B5cmpzWnpEZWprRmd3dnYzaEw0RnhPbHV4?=
 =?utf-8?B?RWVhdklNc1VUb1ZpWjRhZ1d5MW9aT1BOT0k4aVRBeE5ObUwzNTdiU1FrbUtL?=
 =?utf-8?B?ZW9JRHpObmh2WnhYNmxueGRZTVNZYmFvMG5KNzZIZDNzTzNxT2Q2WVdMenMx?=
 =?utf-8?B?SEwyM0wyRVM0UTlveVRKekc2WTBiZnk1N3ZTbGk1KzVuN2s2U3EvZGdsKzRw?=
 =?utf-8?B?OGpNMEYvamMrd1dKNnd0QUEySkgyWmtINXZFK2ZnUkt4OU9vVk5QdmlMa29Q?=
 =?utf-8?B?cll6Q0pYTk5rM3pnQk1kUEVKbXFNbXArRG8wUWFxdDFJS0cydFZQdmJ1VkxY?=
 =?utf-8?B?dit4bGF3Qld5Z3hpc05aM1cwTzlWTjh4Y1VKSzg1NmMvT2t0YTRFbUlkQ0Y2?=
 =?utf-8?B?WHZkd0VNTWZyVjN1OGQzTHRIRlJWL3RsS0dIcWMvTVFEeUpac3IwOFB4TWJS?=
 =?utf-8?B?Z2NOQ2pMRHRWSW1DcTgySGFObGE2K09ENDQ2WEFGbGFDWVBVU3BJeXFteUc0?=
 =?utf-8?B?TnRYYjRqcXd5NFRKUmlLMkpETFF0eXYwM0dOM1FDSVJLWHVNclRWTFZwZit1?=
 =?utf-8?B?aS9HK0h1VzBvZjhxNnpjK210WUZhbjB4S1NKZHNEQ04wQU93VEkrQXJZV1p0?=
 =?utf-8?B?KzhFWGJ3bW9rNzd6cGtXU2hrN1BLQUNmWlIzY2lQemxYcVZZYlkxQWFDL3h3?=
 =?utf-8?B?NzhLdENyQXl1VGVOdS9WOC9KNFM2enI3em9uR3l5ak1ZbEF2cXVEMmIyYWtu?=
 =?utf-8?B?SDJjWG1oR0c4cHpxNHpwaVhWZ2RlbC96d2h4Y09XaldYczZZdlA5dWFrU2N3?=
 =?utf-8?B?dngvWmVWeWdMU0dNUXdBbmxCdXBRK0xsZXFUL0tTOTlpdmtJUm1TdzdQclcr?=
 =?utf-8?B?Wm0wUC9aWUtOMXNueThLZHp6anlXdmJQRm9QZTZmTUM5R3llUStKbkdSRnZK?=
 =?utf-8?B?R3UvVFRHL0VZOEwyRDZyUUNZVis2SitoWmQvODZQV0pVU3hSbE9jNjhGamw0?=
 =?utf-8?B?ZXRRUks0R0ovSTUzMCtqTHppaWV1R3gva3IzTWdESWdjVUNTamQzZkdQSU96?=
 =?utf-8?B?WGVZeXV5OE9QQUplMFdpSzlONUo2VlBnOVFwa2xDTXBhcGNocWFndlV5c3Vt?=
 =?utf-8?B?bDM4ODYyaFVGRCtnQ0JjMXYwTm1kZm5wQ0VHOWpYak1pUWtYdkExaGR4MVc0?=
 =?utf-8?B?cGIyRSsyMWp2Q3R6Tit3Z0tlejBuSmt6cjVRL3NxcXB3L2NVcHNVMWl1eGUw?=
 =?utf-8?B?T0owciszd1VyYUE0RUVmRTlrQTUyUjh3Y1JrdWxTRlVkTElXeitMd2Nnb21s?=
 =?utf-8?B?a3YvR2pWNHpDZlpQT3dTNlY3M2Z5ZmZHR3hCWnlKczJTRTVFaHU2NkROT05K?=
 =?utf-8?B?NlBZaTBuRDRETnJIbmYxNEw4bWRWVE43MFg3aS9adzRrUVM1ZS9WREkwbVAy?=
 =?utf-8?B?TVIzWlkzRDliZXN5N0QxbFZsVW04elhFSi9sQm4wNitnenJEVDRaWGh1a0Jl?=
 =?utf-8?B?UldhNWR0OHV2Z1RFZ2ZSNCtDU1FRVFRIcExLc1JXMHh3ejlmZ3dKSXVVV3Vl?=
 =?utf-8?B?RE1lVzVjckR3WlNDeDM3K0RsZ3JnbVl0MmlOTWZCYjhjTXBiOThmNitrTG0w?=
 =?utf-8?B?MHp1Q2NaRzdwMzJGRHlqN0o2b2ZLV29uQ1ljMVUyWGhoUy9wR0l0Z0ozMktm?=
 =?utf-8?B?MWQ3ZW1iZW1WNlFJVGh1WVh5NXBvb0lpZTMrdlhkRmpJcUFDVWRWeDMzd3BK?=
 =?utf-8?Q?dIW6sJVPcio=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXF3Y3ZQN21jNWROcUJrYnovN3lyYUI1d0VvRDZkcTFPcVh1cExiY3VYUGlM?=
 =?utf-8?B?b1l6dk10d3VQT2ZRd1FwWG1qR2RCbmlmRGxoK0Z6NnRyUUpQY09XNE1RKzZz?=
 =?utf-8?B?TXQ3UEc1Vm9URXV6UHhUVmRLZ2dxSXVEbDJ0d2F6ZWsxZlQ0NFlRYzEySVV1?=
 =?utf-8?B?TVRlNFE1a0VxZWRGbXFna1FWMWZUSjNqQ25GZnlXOW9oeHRmSytiRkRqUXFr?=
 =?utf-8?B?NzBpdjV1Q2FlT3hiNURzanh3VGgxVGQ3d0UyK2hteEp6Mkl5SVowV0M3VUFY?=
 =?utf-8?B?WllqOUIrK3JmKzNLSUpVK1BjTUFVK25XRTd1eUxaNDdQck5VKzFkSUVNRTkw?=
 =?utf-8?B?M0FNY3NyN2VRNytQOVRGcTAvcW5HMmtIakdRektuRW1zdEZVRjcvYmhyY09D?=
 =?utf-8?B?OGxuYzR5YWxGeXNoL1RGeWNEdHdPNzRmWW5pa2lrdmpEMjd5T01Nci9SaXg3?=
 =?utf-8?B?ZTFIZVVJOTF3dUJlWmdpSnJreFdUSUI2SktOOS9sY0pLQVJIelpYL3dUaEtq?=
 =?utf-8?B?UUUySklPTXRRZWVWVnlSTEpsaVBob2N0OTN6L243VERpb2V5cVRSUFp6ZTgy?=
 =?utf-8?B?OTh6WGFjOG5lN1B6NExRR3BDRUxubHQ1WTJ0WVZEalFUeVN2cXoxaDFNcmtR?=
 =?utf-8?B?NThKVkpQSUxxb0czVWRUb1prOGNZV1dRY25wVzhRaUhDc1l5dy9tMzRCWFNR?=
 =?utf-8?B?dUVUN1ozN0F1OGxWeW5PbThzbktGdnNLbHFOU2ZObk1Fb3BpNk1qZ2FNUkhz?=
 =?utf-8?B?ajl1Q3NWcmZlQjlMbVJoKzVtbmtBTG8rS3pRaktMcVVoMGtBVld4RzdsaThT?=
 =?utf-8?B?N3NvMlZwNFFZN2lYMHZ5WEMyRjlKQk92UGpqSW5rTjI0NW5CRXRCalozSk1i?=
 =?utf-8?B?NEVvY1I2RjZjcjIxMmVSemxHSk5uUDcrdlFCV1lLa2c5bVVWZ0hsWWRmcHR6?=
 =?utf-8?B?TjV4MkdQcFg1bWlReDhYOTRWSWQxMFkydlQ2dTFmWk5iZXpaZkg0Q2taMjda?=
 =?utf-8?B?VSsyMHdGa1pQdEdYRWNJWFZ1SjJMdlg5VkdoR3BjVGJpRkd5LzZyeWtqSFh5?=
 =?utf-8?B?aEZmclNaSzdoVW1nNFlRbHJkQ25MOU9BWUw2TElXU04rTFZpV0ZtcXNJMDkr?=
 =?utf-8?B?ZlJFa2V5MnJZcEp0Nk9ZVE9yODJ6WUc1WGw2WG4xRTI0WFBJU2h6eHQveVZR?=
 =?utf-8?B?VlphbEZJQWJYemRZWHBjWGpiZDNmQ3RNSVFmREQ4M2J1ckNnMGRIZnZSNmlG?=
 =?utf-8?B?MjJVMUl4WXpLWWkrTS90OVk3MFpQQXo0ZGF0VW9nWWErcVhEYkZvWnpDMnBu?=
 =?utf-8?B?WTJSY1U0N2dMR1A0V1BXb2UwUTFwNG1xSVpQTWsrK2lTc3QzdU9CeWJlTmhz?=
 =?utf-8?B?ZGs0VUl4NXdlalZYY09nd3U4cHVXdCs2OEJpZk12RTYxdUFPaHg1MmxJL3J6?=
 =?utf-8?B?S291VWM3WnJxQWQ2TWhuOE9qQXQ4eFRlQ1VraWxYTi9ZNitMMmwvUW5vblNh?=
 =?utf-8?B?eWE0OGxxTXBxWUVJcUVYNHg3UjRrRVIvZGpyZWc5c2dFTmp0K253YnA5QUt6?=
 =?utf-8?B?dFBFYndzTk9Ya3pacmpXUVNqdldaa0dHMGdRZktnQ2RZZk1CSXRrMDd3SDVz?=
 =?utf-8?B?ejlWbzFLWXhFVE1YTE9kMFp1SHNRTGEyK2VxckdsZVFkeWJreGpNKzRYOVBw?=
 =?utf-8?B?OGlxeDVZcWE0cDlmZ21aeXVtNWppbzArZzVnZ25mTUMrcWRJZis3cHl2a2hY?=
 =?utf-8?B?RWlBS3dsOEo5YWlVc3pJc29iMUduR3Z3MCt2ajJhTmtIMHh0R0dyMEZKZ1J0?=
 =?utf-8?B?MzNDZ0YvczNJRk5FTXVLSWtxUSsyai9jYjNldU51OXliaWczRHp1MVFvYThu?=
 =?utf-8?B?emJaRHdOQjQ2VEQ1NDJqZXlPZllHbEtUZ2JlMEJVSDZ3RzRFQXZscHorTnZ0?=
 =?utf-8?B?c1JURUxGUUNlamptQXpkTnNPZ2ZXdWNFNVdsUGpxbzBBOWtpYjBUVkMxR3JT?=
 =?utf-8?B?WEVUS0w5eWxLbWFONEN5aGJjV0MvU1B4TEVaSXA1RysvYllXNnpsOHV6TDgr?=
 =?utf-8?B?Y0J0S1BLT1pFOXFpT2VMZ2pHc21rUURWNjduOWpIV1FMNXhXTWJBV2xDcWpZ?=
 =?utf-8?B?dlk0YW5RVEs2TDUrTjVGVzRiK0g1N1EvNG1jR0d1ZXdteUtubVY2T0lhK3dY?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4XzA0MeH6ck99+S/IJ1AWxK/CnwN9eKOoaw8A8iNxXrOb4ppJtaSKNAW3VT5YforKL1yVDsf5OO7wcNQphNGoRfPgOzW5ULEKA5CE3YARoH0Buc7gnEPCHdDJ6NPtqaYp2MKnxE8ANSjOhBOZNO4yh4msMpBcOJp5cH/s+qRQZyIV1/L4XzLzSZb9zENw3vHhhx0Kb46BsV07Feqgr6ZIKxlo/iuLtHot3romfL6FzlTdT1FZlmm/Z+CmAPhkF+3nPTm/ef8DRjDtKFo4hXcJNNVCiGXW32vk14/j+LgJ2Ub7C0qZasBEUI9SLjtB9LMfe2cVytldVrFJ/owNw78aUqixeejbZakyO3iqSSJ2H3UJ5cl6ZYDgJ0nIIUJhYoTCDQj1Ano5qjYc+Chn78X6ghfDNT4AA0sieBDkPvy8FSC9+VhQ4YwWF3aLbPSupxkdMw3OrE11yxB3NfyoI0tRSFw2KfZXr0WLL/pbD5/8MQiyPYvaJR32c5ScVhujUJVyR5IbpfZ1/olXXekvbj0YSbqLwV0TCsa6QlMqKhJbPXKOMLLjZE4BMVCeA1uaa+G4+JfoDkRySfha1Wl5qku8Wa2BK8y0k0ieOiZWImJUmY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3c6826-2855-47d8-48c3-08dd93bf0757
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 14:44:42.9352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYCqV6XGTmLzo5Q0JA9fdZrOtLjv85L+XN1ylzAB/W6Z8Fi6yPuKfO8NSecRidPaiabrML8LGZv8A040Bl6Duw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7508
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150145
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE0NSBTYWx0ZWRfXwmtxGW1Z07SX fX0qRkA6pQ8cnaSj3afE7rgTlCUtsIrGAz7z7Tf/KNDvugG96GP9Hkv/vQ0t9+XQsBWaeTYxNyn 708A0F9NLGuHnClTBH82H6jY5NVpZPdQl9SbjaSSuPQuYWZb8kDaQnRvUiuFN/cbBzCCvdCJcdj
 v3xtxKASe4inpoJllM4Urur8aBWYa0kHWPvN2LRxhKNbnlWUwna37Nostyo15Dd5nMsX1aeclU0 TMPW1jHWlWnOGTnPoNv5YddKd+RRZ9XeAp7O7THBru6h63xfERckZj2dLMmrDDFj1kgJUSXEJmV nieCNMcNPIDYMd6RPe25VmatKrZB9uCDCR3g5FnskZZJ0VLyS3eHW2zo+NgBpQY3WC4YCZ73IzW
 RLowQmslK2CAMyah3QXWh0z5G1Zgj9XCLcXQ/bnld7NvXzxo7fr2H++NRb4RUZwKI8duPXAg
X-Proofpoint-GUID: CufCGAlnANUpv9QLIUKNxFlavIO5lL0f
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=6825fddf cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=EFlj6mK3JSbaIrlheMcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CufCGAlnANUpv9QLIUKNxFlavIO5lL0f

Resending with linux-nfs and kernel-tls-handshake on Cc


On 5/15/25 10:35 AM, Chuck Lever wrote:
> Hi -
> 
> I'm troubleshooting an issue where, after a successful handshake, the
> kernel TLS socket's data_ready callback is never invoked. I'm able to
> reproduce this 100% on an Atom-based system with a Realtek Ethernet
> device. But on many other systems, the problem is intermittent or not
> reproducible.
> 
> The problem seems to be that strp->msg_ready is already set when
> tls_data_ready is called, and that prevents any further processing. I
> see that msg_ready is set when the handshake daemon sets the ktls
> security parameters, and is then never cleared.
> 
> function:             tls_setsockopt
> function:                do_tls_setsockopt_conf
> function:                   tls_set_device_offload_rx
> function:                   tls_set_sw_offload
> function:                      init_prot_info
> function:                      tls_strp_init
> function:                   tls_sw_strparser_arm
> function:                   tls_strp_check_rcv
> function:                      tls_strp_read_sock
> function:                         tls_strp_load_anchor_with_queue
> function:                         tls_rx_msg_size
> function:                            tls_device_rx_resync_new_rec
> function:                         tls_rx_msg_ready
> 
> For a working system (a VMware guest using a VMXNet device), setsockopt
> leaves msg_ready set to zero:
> 
> function:             tls_setsockopt
> function:                do_tls_setsockopt_conf
> function:                   tls_set_device_offload_rx
> function:                   tls_set_sw_offload
> function:                      init_prot_info
> function:                      tls_strp_init
> function:                   tls_sw_strparser_arm
> function:                   tls_strp_check_rcv
> 
> The first tls_data_ready call then handles the waiting ingress data as
> expected.
> 
> Any advice is appreciated.
> 


-- 
Chuck Lever

