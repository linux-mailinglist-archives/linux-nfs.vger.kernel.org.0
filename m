Return-Path: <linux-nfs+bounces-17187-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB21CCD6E0
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E5463018324
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 19:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878851DB54C;
	Thu, 18 Dec 2025 19:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fIpPLblq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GYWItLeX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11D8185B48
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 19:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766087121; cv=fail; b=H0dvUNBpYDY6hqlswdP/jMYcXvlMZonQSg5OyXdycjGGaLNQ6gQDkXuK23abfJipX6t9d0ADiLwzxgteoHgs1J7L55F3yrll3l55RiwAJb9JiBOghW16ZO6SYX/W4Rqx3fMOetivKnA9VinHul6levI/hSuptikbUr80ADZwveg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766087121; c=relaxed/simple;
	bh=NAJ0sf5XTzi3MyVn+zXO4N5AZS8nKgqx9/M7J5RfNws=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AhlJBMHacakRDYWn061TQbNRfeK3MA010RYWhSkfpsLP5l5QlYA2A+MnIle7lBN6WFcK6rSZz//MenASlaIlw1KbzS4s5fJqBybwq3OziRyvxUeosrc6jcKIurgJswXNCD9brcQUcMr6VbWZ6eWYzSLJ+Se249+GhoPBlKovHIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fIpPLblq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GYWItLeX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIJNGbi2255553;
	Thu, 18 Dec 2025 19:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rXumc2JU2iKh5SmfqEaZwE67P/r547ktTHyYIO+RGD4=; b=
	fIpPLblqZIfrAaFc6/EzxL5JHrunWsY2CB348slZSNe8F6sczyw+Ld7LRxlhSzMO
	0UzvQjLpCUZT3OLyarMYv7f314Y8CfisbM9y7uFoKNQMu0mj9qH6RvfA4dm8Dgod
	L2Jn4nw5lsX0QfdwliGfYU3/6wPHL9ChBW4N7fjsufmALyP4ZTqmV4LHYkvHBBuv
	Y4CpYIuPs65uUpaiRY0tj9P+ZJSnqZQ4hX85yIBMZO0MyjZGkqw8SJYQtOlWS3Xr
	IRLg1Oo/WzSo5V0N5rRMmkDy1zZQPBCGrtc/2ekcnD7IqkELvMZzxWrPB6qDJXHM
	myaTpkNKd5OdvXj4BcWN6w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b106cge39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 19:44:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJTIN3014038;
	Thu, 18 Dec 2025 19:44:59 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qth0mb2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 19:44:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnIJDISmSEXW3zZk7sOvR8wXFtf8UhBNGPi7ZwBhWsGvJ+AwlOq30QrS1ZWGeDQjN2yhMLcSNTO7u3ZkeeYj0BZWDn+/VVvgVX97dCT4TuL0ZDdtm/Dd/lpOeYEPK1KAMHe6LyY60YO/SRuYixs18StH37IPLmjPxMryRsOu+kv3mb4rREqFqqSqfjmYx24//NhIgSEHn+9rYS4lWOdboimskvUT1bZi7/aIfFPiZZF3HQnN/lyZCB3eujNKJU/sXyx6BgHLvumQtfVtKbXJeDjgu0SsPRPOTbaCPNg0nMMePJJ1kmAXMR4O+rzi9PESMG53OvEeRJ4P1ltvqJM1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXumc2JU2iKh5SmfqEaZwE67P/r547ktTHyYIO+RGD4=;
 b=Rdxukq5VtUSE8qirHZMm71cI/r09RRl9kIhAwmCbpfxf2uXAG1qMDdN6ectlHZPGDQBI/RdZxlFEaFJlZGYVtUGcUXFCj4H/i62lAQNfvN+oAlQKLrQNOtrr8r5hPmFNkqsxfTMyyNoAxWxDnexfL73ywA3LCBtGK/FDyF08MpLNB6ksXSjl01t04BjnTJouXtyoiYu8U9iPNxDYtUCNQ9DzLvV0lWvyFe9AHEFb3gxTRlo4QNG2wPENp0DgTIBmuh8n4Kg/wFPGZZ3tO0hiqGlSAat5waKxDJoiIqWkmmE+hB4GpoAMkpwCNUUY1fOyjoo4q+Lnn+i5fwVQkZ3LXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXumc2JU2iKh5SmfqEaZwE67P/r547ktTHyYIO+RGD4=;
 b=GYWItLeX9WBZpEZWDvrsgk/prKGy8CtYYTVsM2WIGsBXBFu+k2ggN6Ze9QpZaH+vQNYcwFpp5R5yHy+/RQ88+W8I5SD0RnmpP3JCS7iUs/yYZBcwi+ijSV7TyecP6dXKptdZ7vfK+/bxPy+nag94L/6zHvXcrKgCnAk1qaG9xJE=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by IA0PR10MB7206.namprd10.prod.outlook.com (2603:10b6:208:402::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 19:44:55 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 19:44:55 +0000
Message-ID: <33dd403b-bc18-4887-8004-b6a6bd24d63e@oracle.com>
Date: Thu, 18 Dec 2025 11:44:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] NFSD: Add infrastructure for tracking persistent SCSI
 registration keys
To: Chuck Lever <chuck.lever@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: jlayton@kernel.org, neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
        linux-nfs@vger.kernel.org
References: <20251215181418.2201035-1-dai.ngo@oracle.com>
 <20251215181418.2201035-3-dai.ngo@oracle.com> <20251218093434.GB9235@lst.de>
 <ecc09cc9-a0c9-499d-9d47-e90aa1f1815d@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <ecc09cc9-a0c9-499d-9d47-e90aa1f1815d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH1PEPF000132EA.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::2e) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|IA0PR10MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a4b0ca-a408-4e15-b75e-08de3e6deb73
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SDVzQUt3U0lLUU9UWTVVQXpTUUY4a3lLTUNsTXhtMnRNUVNDS2lHaE8vaWpm?=
 =?utf-8?B?WkRkQ0xFMU1mU3ZaaEEzVDlqdHdnQk1aSGhscGw5TDFmd2xZRFlMU3VMb21I?=
 =?utf-8?B?NDMydm1IZlRjVTk1RlAwWEhQb1N6QzM1UUh5OTd2YzYyaXVEUVpXa2JFKzNa?=
 =?utf-8?B?NUJxL1MvZ29zenoyL1YvWXZBSWErSGRFVUtvak8vcUtmdXBkRk5JaWZrVXp6?=
 =?utf-8?B?MVQrNVFuODRWMDZWNGJCbFphUFdrdEQ3VWIxYlZQOXg5bFVIMHdJZWhGcWRh?=
 =?utf-8?B?ME5ldCt2ZHprSDlKUnp6dGZNdHczTEtCMGMvakkwaWw5V3d1OFowZHZBekIz?=
 =?utf-8?B?TnZCVFFONmsvSWd2ZmNzcnBFNHZwRzJPZWkxNFd0dzEvT0t1OFlqZmFuVzNS?=
 =?utf-8?B?VHp2cXZQNkpwVjRpc1B6emJ0S2xhYkV1ZUpXaWhoWTMxOVVDUTFlMlB0djNv?=
 =?utf-8?B?WS94RGUvOVpybEdWNkxHRGVEcXNYYnYwN3lqVHRYbmErMmxvTitudXhZQkN4?=
 =?utf-8?B?aXlTdXVjOHpFWmJaYjZtV0Evejh4WHJlYUxQeUhpR2RYdTF4OVJBckY5Y3F5?=
 =?utf-8?B?R0NMa2F3dUpQRGZXUUtpK0RjSkFVSXZ3TkdSdnpoSzlLbXZBbXN4WHBGdHV3?=
 =?utf-8?B?WWkvb0FYbGluMUNxQ05mOUR1RS8rdE9kRUo2blFVVm4xR3p6dFUxTEZvQ1VS?=
 =?utf-8?B?Wm1NSmtEbGxqOTVzVzc0Z1dueFBXZjZvRlpRQi96dGZHRWlqL3UrRUNGc0V2?=
 =?utf-8?B?eUtlN3ZGOTFSZkNUaTdvS0o1bTF0blI1eDNyUkNHdk5IV25xKzBSS0x2ek00?=
 =?utf-8?B?T1hsRDZERWRORWZ6NWFYTWxTSUlxQ2FEQzNFajNBcm9qR01MbHJSOGpzd2t0?=
 =?utf-8?B?aUdLbDl5VzYvUyt1YTlEWTFkcmhOL1ZQd1BoeU9KZHFqb0dLRXhuRFBHVUlT?=
 =?utf-8?B?UTdSYmdXMVhjUU82RDFBa05VQUsyY0tVNEttaXlBNEwzUFpHQkV5a3EvaFNs?=
 =?utf-8?B?Z1pVUUtabnpmMysweHRzRGNxU3B2ZnYrWXpnVWxWZkhkL1dHb0J5SlUxQitP?=
 =?utf-8?B?UUdHYWtHMmhoZ051ZHNDMnRDb293TENVSkl3UldXL2xRY1hScEw0YldxRnE2?=
 =?utf-8?B?c2daUGMyL0xmb3NiSGJKSE5URkJyUjk0ZEJJaHhQcDF0Wmh6N3dGdVZnMW1I?=
 =?utf-8?B?di9aVzAwZXhYTWpSQW13YTlWTlhOSi9MMm0xM25UM0dYSXF1VHBTNmoyd2VF?=
 =?utf-8?B?T002WmtpcS8yYWJicVY0bkRPYVNyWk1YTTdZUXM3K0lHY1NlVUEwKzh0alZq?=
 =?utf-8?B?NEdCNVovZXNjakRTVG9HUTlRTFF1RC9yaTRFU3VaR3IyWlZzaEhYQlM5bDJJ?=
 =?utf-8?B?Q1NsZ1FQNGk4OGVZTTdjWjc4WGlKa2lEcjhsYk0xVVl2V1lTTmRLKzRLUi9j?=
 =?utf-8?B?MmdkeW9HTS9OcXB2dHdDdnVYVFBHK0F1VGtoNEFUb2tkRXN1ZEZncENmajQ1?=
 =?utf-8?B?UHh1aTdsNGpXNFZBWHhSSWN4Tlg0MTFZNFZSbzFlWkV3ZWJrQjBYTzB6OENz?=
 =?utf-8?B?OG5YT0Z2VThIL2g4eStxbEJMQ3VBMkwwdnNlMzR4eHlmVnF0T29PVElKTFkw?=
 =?utf-8?B?ODZpMm9SVmJobGhtQTE2YmY4QXJhdGgyQmQrRXFzN2NCRjc1bzU5MUVPdzlo?=
 =?utf-8?B?NXpCUVQxMlJQUzBuQXpWN0xKZUdISzR0T0dqL1paK25QZUs2TDhNbWhjc09J?=
 =?utf-8?B?dmhGZ2J3TVJxRm1PeFo3VGRXaUFkQXA2WDBSQmtPdHRMbjZSS2hzVlIzVzdR?=
 =?utf-8?B?TkEzbEw5L1BlVCsrekc1WlZRSGNLbTV2R0hJOHVQVFRmRk1oVU9nWHZLS1hl?=
 =?utf-8?B?dEY1eTN1VmZVYnBhNjBORjU2VFJWMW5ibnZmaW5Fdzg0UlpPTlBraEJrUmE5?=
 =?utf-8?Q?37SwtQWv+QOTZG4EgDjD20jsyssidJs/?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?L1pScHYvSTZlWjZMaTMvTWQvdTJWbnd4WkNxRWhRdEt5NmFzTVlmVFh2d1FH?=
 =?utf-8?B?NExpK0F1Q3dEZVc0d3NVcXZkMHNVemJuby9aeEhBd2F2U1RFN0s4OXFjZjlw?=
 =?utf-8?B?eGcrQ3BuM3JLKzAwNEFXeEowZTE2OEZxeHdOdUdrUWc1VHRpOURLN21vckdW?=
 =?utf-8?B?cm8vU2pRMld0M240UjR4TVBxV1V2R0hKN3BSLzhQT0Q4MGhjcXo1TnZhVS95?=
 =?utf-8?B?OVo2eElmVm1KcG1LQWh5WWZ2c2FwelZPYXBYTEp6R3pLeHFtbzVvU0RkbkY1?=
 =?utf-8?B?TzNueng4cU5vVGIxUHovZWZhY0lXRlg3RWE2TjJpekRRbzE5ZXFERHErNG9s?=
 =?utf-8?B?VEtxUW9TZmFtWWZLaUJndUgwY21hTDlWcXRGQ2ZZZHB6YXpnSGwwYTV2c2NP?=
 =?utf-8?B?NVladHJZVnJjUFZyMTdpQS9vaEFLd2s4NDF0dmtzYnh3UTgzRWNwc1BtcHky?=
 =?utf-8?B?K3ZLRWV1eFh6OEZIU2RMQ0xDSzBUZEtPWFJuRHh4bHJYcG45NlJqUmVBMkV4?=
 =?utf-8?B?c2x6YmIyTjdYLzJtQkNhNjZRSTVqeGlRS3RyWm5wSEhjYUpGRm9sTDgydzZa?=
 =?utf-8?B?cG5OUlZ6YXRFZy8zOE1qTERmMGI3WGNBQ0hoNGJ3Uko0aVRiaDAxQ00rTjV2?=
 =?utf-8?B?dnVCdVNWTVdYblByOCs2YXUyWmRWejBuRFRwa2xLc01MOFdXT2U0TFNEVHhm?=
 =?utf-8?B?aXE1L0RReTlZVWR2cWdSbUZIQWlVZ08rMTZlZDVib1lpOVFDOGNvZ01RQ0lX?=
 =?utf-8?B?akE2ZG85VGdOcXpDZTdTUWh4SUIreWN5TjJkZ3dJOEtKYytQeG4rSEJ3TnhV?=
 =?utf-8?B?QlptTU9GbjM0d0trY3lOL0xuSHorZmJZZ0g4L2YvejNOWEF0Wmxuem9JbkNl?=
 =?utf-8?B?UUZCcE1hRzFTTzhqU2JlSE5lMmhlR0tFTzVNSnl3UlNXUXhTdG5aOEE1OW55?=
 =?utf-8?B?L21qUzJJTWJHdmEzVEhFTlRCODNRUThkT2U3aW5TMkFHTVRQa2poTS96bXVV?=
 =?utf-8?B?anUwaERHTkQ2Q3VCTUZrb3l1S2svVGtrSER1Ui9XM044MVBlcC9RTDJaMEVu?=
 =?utf-8?B?elpUNXB4QTZ6TmZiU3c3SzVqSTZFV3BZUjk5ZEFBUmk3bDJRY2ZjSG13dHBM?=
 =?utf-8?B?cmMvenV3TEhTWDlnaFhsN1VWdWlRL3dsRXBPRWhFR2xGeFBkWmpVcW9ZdzMz?=
 =?utf-8?B?cis2eHZoaU5uMTB3ZUxMN3hLNUlCQW5XaFpxVFRuWTVVMnFZSXh5aEFXcWZh?=
 =?utf-8?B?TnpvRHQxMEFQZkJGY3RQWWhFbGJISjZaemJYdkoyWndRTzQzYThwa0tpam4x?=
 =?utf-8?B?ek9ESS9MdzdleHBZdFVBUUIzNHhpNk5lbXl1OGhvSUhsQS9UUGNTd0Fvc1Uv?=
 =?utf-8?B?dmhldU9MeEZuMVpXVWVFZnhnN1ZvYmNPVHd3VFIvd1hCTWFEMU9XaE5Wc1U4?=
 =?utf-8?B?bFhVSkR6L2NYeiswZ1EvZUNiWXRvcC9OTUtLYktXQytZbnk3YmUzbnlzUkRM?=
 =?utf-8?B?d21EeUtTSmpXZ2dONkdsaXlYT2lWMVBXQUFIT3Vta3Byc0JULzVVdGQ4VENB?=
 =?utf-8?B?YnVaOW03dlFtK2FTN3d2eVZYUnBua0tEVTBUSmpzS2JxNnhublY0cVBIMlQw?=
 =?utf-8?B?SWFmWXBUNVhLNnBRUW5BTk0wOEMwczBib1M5cEJMVUlERTBROE1lREtsVUx3?=
 =?utf-8?B?Sng2c3gxWEFkNjlycnB3RTdiaWp2cXFaWDBvdkFFdC9lMVVBMU4yVDVQRmxV?=
 =?utf-8?B?WkQzOWlaUGZscDNJSU1qamc1a1lneDF6YkwxZjZQOGZCV3NYZUZXZFlka2ds?=
 =?utf-8?B?UVNpZzFlclpJSk9kb21xd1R1bVdKeTJEekt1aW5WeU4xc0ljek96elBaaXVH?=
 =?utf-8?B?UkVwZ0NEcnpmakVYcGxPSldjeUMydVh1WW4vZjFqYzhrcExVTzRPdlRCaEl0?=
 =?utf-8?B?UXVCbHYyUS9BYnhpYVdwM1RhRlZzVFlha2VZSHYyMXQxR0t5T3U5VytCMGhZ?=
 =?utf-8?B?YVhaVFo3ZHFBVUJMTlpOald1WmFIV0V3ZUNmd1o2OWIrTnlCMGVjcjlLYTd0?=
 =?utf-8?B?QTVIaEZ1VmRkeWY1dXdQVTE0V0lsZm5ESG1RT2R1V3p0QzIxU0Z1dVBFSy92?=
 =?utf-8?Q?aoI5ObilzKGehFnOtaqEPlS6X?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ItQtTb2ILiLz6sbQg9vvZJm2Bq1ia+NyET9XxoDwf2j5Z3xt76SaGZAjFiWAIXvr5XQRw+rd2K6GJEY6FWVcW+UpLuJHKQQtT1vOZhOiNwJtKtSnkhsTFMl3mQYOpG7lSMwmVtHFAwTPAjMUxJenGUyJi+ulLQcBZsY4lgtC0ckgC7FgG+bIZnnzEIpHbHPcgRZrIEHaBLZOqOB0oeJ4uDfLOARceOG3MOT47S/C9E/WHquYA1o5YAVGUb9u0XOFeMH6JSs6Fy4oHVo7cYFWdMaW2Gfl/sFQ0i97ltmVus6p7FNp5+Zo36rujpu2EhNTAV6dd023JcxcvxlYJGmxAKrhngTCFMEqHxR1GErxRklX/jHdKJwkKUEtnhBF2QIka+5PYCz4N/nPty8j/ivEvgXwStiLtC3Z/PGYZNP3dyQL+quP9dWgOgKdEVDjKc94RhmqjlaQCShjuh7GVLm6sVUbbB/4SBh/CNKyTBB/bHnqjCXQ+gC7AIZ6Kz77mlvZzb7+o8PeIykvkTI+7pk6lUwfh7m30jUHhICCE3FP7K1qSiUsI6C70BdLFXkh86XRY8gJFzxuC7AsxEfYYcnalkcWBUpqkcIMqYemGnfD+fQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a4b0ca-a408-4e15-b75e-08de3e6deb73
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 19:44:55.7144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FI7Ay1LQB630Xjv0AobHIUuO6DzfJ0OWQnadmxDba5UeiMBPXu8D7Dml1exkNedercKLe923Lw++AX35oPqM+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512180163
X-Proofpoint-ORIG-GUID: dqW-3dpzIVRzW9mcP-RwENzcvvceexMR
X-Proofpoint-GUID: dqW-3dpzIVRzW9mcP-RwENzcvvceexMR
X-Authority-Analysis: v=2.4 cv=et/SD4pX c=1 sm=1 tr=0 ts=694459bb b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gnLUaJ6WcZaRInvumP4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDE2MyBTYWx0ZWRfX7Gfs6q5/kNta
 9F/1cBRVO5IGfuV8RQFJwymVC0K5ZMzT3Eg0fAtu+b/WdBYSdC+z4W39MNYND7X9V3n202RskPj
 48Ud8yb5B51GVDYunyagyJDbGq3EYHxMROGo8I00vjM38W8PtqipSMg/6TfUqrOighiJ6V1SPkR
 iMrHdYp/qjE2ThqsNeokayDftjdaPjQcom2ugNwj3JEDaeXLSTBT1eA4TneApZo933S2V1h6W72
 YjFGA5bbYAj5F3xl1LzpD6J+pCuR5jukcZN/J/vk7YquEhRP1/lQPyRbGVBmPX/KemRmBInDfAC
 6WBQR41bMZguT8TnCqVAp1j1h9e6ygwRcPweSBQfsu+1iFLpPZ2Jpcd/WeE6weckdRG5Zot3hFZ
 Zrmhis/LiI0yEEYOlyx8l6UvvSD6QEzsKOw4SgMuuNjE2lR6yUw=

On 12/18/25 8:00 AM, Chuck Lever wrote:
> On 12/18/25 4:34 AM, Christoph Hellwig wrote:
>> On Mon, Dec 15, 2025 at 10:13:34AM -0800, Dai Ngo wrote:
>>> +
>>> +int
>>> +nfsd4_scsi_pr_init_hashtbl(struct nfsd_net *nn)
>>> +{
>>> +	int ix;
>>> +
>>> +	nn->client_pr_record_hashtbl = kmalloc_array(CLIENT_HASH_SIZE,
>>> +					sizeof(struct list_head),
>>> +					GFP_KERNEL);
>>> +	if (!nn->client_pr_record_hashtbl)
>>> +		return -ENOMEM;
>>> +	spin_lock_init(&nn->client_pr_record_hashtbl_lock);
>>> +	for (ix = 0; ix < CLIENT_HASH_SIZE; ix++)
>>> +		INIT_LIST_HEAD(&nn->client_pr_record_hashtbl[ix]);
>>> +	return 0;
>> I guess there is precendent in the nfsd code in using this fixed size
>> hash table, but they are not very scalable.  And using the rhastable
>> API is actually relatively simple, so it might be easier to use that
>> than rolling your own hash.
>>
>> If you stick to the fixes size open code hash, you should use a
>> hlist_head here.  There is no advantage in having a pointer to the tail
>> entry for hashes, and the hlist saves half of the memory usage and
>> improves cache efficiency.
>>
>> But taking a step back:  why do we even need a new hash table here?
>> Can't we jut hang off a list of block device for which a layout
>> was granted off the nfs4_client structure given that we already
>> have it available?
> My question is: how many items will this table need to track,
> on average? at maximum?

I don't have the exact answer but my guess is a NFS client would not be
configured to access too many shares with SCSI layout type. The maximum
maybe less then 100 and the average is less than 10?

-Dai


