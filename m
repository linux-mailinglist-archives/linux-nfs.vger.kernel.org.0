Return-Path: <linux-nfs+bounces-15087-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FB6BC9257
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 14:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 026BA4FA9C4
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 12:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728C733D8;
	Thu,  9 Oct 2025 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A8iJd85D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YBH2XfC0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8EE2E6CBD
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014616; cv=fail; b=XGZXNgNNU0qi2lK+zdy+rOL0CrDwNYrvrDG4o+0TYIbEN4Kxvn+4XmJ4tAYBiTCixvMp8c2A/9xSiIArALxnQqeGMZ35M4L3+gMEsOFQjo/riKlHEXxg0G+cyNM120aW5XR072Ba9k18uGThZgLBs9jU5gLHAbDwi7d2bNp4aIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014616; c=relaxed/simple;
	bh=nS/1h6O7ctgtBzff2TihxmFElNFvHr9etRqPma3axQI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ysg2AqKyp5H/GbiLNU0baUPqFNeFOQ2jXMyiAVQ6+1fIM3EWcRImiPUBQ/727ymBnKaDqOxCn7w/5ot0zIBTmjR3ddebiw9cBWry6JJLmgw9ia+8ovnS6ixgwQD+qJnvmupq1+NhUQoLLtyPr4zU7XC8cAFmlK6/YQcNhzXXmqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A8iJd85D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YBH2XfC0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5997u3WD018023;
	Thu, 9 Oct 2025 12:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=So3++/9vru2yUOgsUzouRhLhOmy4qD1IGAbJLGE4l94=; b=
	A8iJd85DY8ouDhfiPQj9d9a/5UafPVfGqkA9LP+tVBLSHcXPuwC+wVjQYSiAAKLh
	Py2+ai94ByoMtS0YGn74t6c1yt7GQzWh51RCaRzixDAsKhDKRmq+kdnW+wsMC0YL
	GhjIYgr0WwIF00rm5sUHZfJ4M9R57dE0Q4opHHS1NOfE9GM5eDOnFTEhvO7TGLDp
	LZnpYKqQMeOurhcJdPfxHOxIVRkZKExyrKrqDrrGgxfm4j8/3Bihxn1Q0L3eonj/
	71tJsgl8sll4nwLvZfVxRqcUG4KlgABCKkxa8HwvVohxCrTRXnTSiAStDNhTUej/
	BZviS/Mm8MOedr/FKUXzFA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv69sj1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Oct 2025 12:56:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 599BFf5L029101;
	Thu, 9 Oct 2025 12:56:47 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011057.outbound.protection.outlook.com [40.93.194.57])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv67v9jy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Oct 2025 12:56:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdxwK75pXWztTwZHIBp/O3ydsIrbDpDK/aQh77LWT0ZxTZWVEBCsfoGjnPmn7tCDgaVDtjLiWLUlB6FoBTd++bovXXZBKM8QRzItE/LH0evkk9uuVPpAGh9TJDhCNlgGJcNNMYkxvEf2oalcvwwEZ9yZj+q1/+AfAkOzMA3HIKTOAZjMi3MWF8DNAlmCsZI/l46tnApJ9e8OOLfdiZ9VC/SF9uXgf1X92dnMgk8o9Qb55dyVkfNwJ42u6a0pBMwGhCTjK8ZFv3P8jzdxlFjfU4Q4Lu/zIydVL8hbiyQ7hZEsU26ZsmrXZb3VpfjPaFBC64E9ou6//FEoYa2nft/Icw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=So3++/9vru2yUOgsUzouRhLhOmy4qD1IGAbJLGE4l94=;
 b=rm9KE9gJuKdpaLloFwvCtg9T53BUud/QJnbCzNkNsn7gQ5pScEbv+qJGbdkeLQPo3f4g61lyh15fgKSaB06sBcQEty61ZBU9bmY3Yir/P2+ku3DnTl2UppRT14Myq1oy2drXG5+GECAyxLoVE/iOxjb30mTjI0aAhrhMgHTUML+z1x2re2RdXDIukV2mVJfCwsAjAhKfwVJeQvMryErF0klEHoCoWjyBzWP1gqtYPUrrp6J/99vBIwAzJtK2gNgeI8QFNU2tBl22tl3O3N1y67z27pPTUYvyL5S3zFDGwzdceynUuSKSE1VQn5pimDeBNNhbIoOs8oAT5Cm0Zff2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=So3++/9vru2yUOgsUzouRhLhOmy4qD1IGAbJLGE4l94=;
 b=YBH2XfC01sYgW/Lva5pC5PklrVkKmWyeiz5aZHO3iE7UF1/Fssy4JFE4OOSsRdOAvWvl9/z/Vld/e9kbTsIyLoqoxjYtcG50T7PgUg2br+8ZQEDnEagnA8yEnkRweyHyht8vbCaYwPwrftt0yi0PHF5JXP2BxwQIfBVOIOUKrDg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5655.namprd10.prod.outlook.com (2603:10b6:806:20e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 12:56:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 12:56:43 +0000
Message-ID: <468cdcfe-971b-4ed7-a7ef-b1d70117a579@oracle.com>
Date: Thu, 9 Oct 2025 08:56:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] NFSD: Do not cache solo SEQUENCE operations
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251007160413.4953-1-cel@kernel.org>
 <20251007160413.4953-4-cel@kernel.org>
 <98277504-3d4b-4aff-9810-1847e6bf4030@oracle.com>
 <175987517335.1793333.17851849438303159693@noble.neil.brown.name>
 <711bd35a-78b3-4309-9cb7-9e2c7a83a87e@oracle.com>
 <175996099762.1793333.16836310191716279044@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <175996099762.1793333.16836310191716279044@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:408:e4::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN4PR10MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e41d8a-6358-4285-b88e-08de07334c1f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eEhTODBWMFUwUDhPREduOWtDR045R3hqY2YvdFJ5dW53ejk1ZGorV0Q0Rlp0?=
 =?utf-8?B?cXJoUUROZ3pTVE4xaWQ4ekpYYUVEMTdhcjdGTWd0VUx2YkVrL1dwRnJCekxj?=
 =?utf-8?B?d0ZpbnU4QUFoMkFEa01XaldJV2N5V2NBU1FEL3Q3ODE2QVdnQjdOcjZSZnRN?=
 =?utf-8?B?UGNTZkpXWVFhdENvcnRDQ3FhdW45dnBOUzhCa0svWHJCUW5JS0IwaWp1aXEr?=
 =?utf-8?B?Qk1YejJvTTR6czZxZ2srMThKNklLRHZSNjE2dlk3OUliblc1a0ZVaTFxRWRu?=
 =?utf-8?B?YzdKUTIwN1o5U1htQWxuU0g3UkE4NW9qTGNVNG1OYVBVSjd3WmhKQUg4amtC?=
 =?utf-8?B?akhpcFl5aUxvQ3cwMkJGRE1KZ0dGWXdHbXRBVEY2enh1N05NZEo3bHo0dE56?=
 =?utf-8?B?bG4rWm1tMEQxUm9HbkZvWG14Z2MzOTVLcHhPRTFhUjNiU21va2FvTGFtblVL?=
 =?utf-8?B?elAzWTYxQzh1cXZ2THY1aVBZdUlxalphZ0xVdUs3UUR4T3ljSEhxZ1NLeVpS?=
 =?utf-8?B?L2YxNVk5cmVoUnJ1ZXNaSUdnc041QURkOXRmNWpISjdRa3F3WWtEOEYzMlZo?=
 =?utf-8?B?ZTFweWhzb0c0dDZEYzFyWUI5VFRzdTR5WGpMN3VUYzFmWXhJVTQ3Ymp6NVYr?=
 =?utf-8?B?bVB3WURmaGEwZThuSjVOOTcyWHVITmEvYnlvWTQyR3VpQjlVNytnMHRHYUZ1?=
 =?utf-8?B?WXdDbUFnaFhIMXhUaVUwOXR3bklmRnlZY1JFWFhLYWxLZzFMa2pIdVNCY3dD?=
 =?utf-8?B?Yk4xU243RFBUeUh6K3l0Nk96eW95clF3ZGZNUHdXMklZWVorRjRNcnEyMjY1?=
 =?utf-8?B?aS9IZzRwQTBkVm9mVHFzbWZXVDdlSjVjUkNWZUZSbmllb096MWlrWkQ5SnY4?=
 =?utf-8?B?UWlNZ0Rob09XQmhCUDBRcWRuRjNuYzdyZGhiQWZORnBqZ05JWUlMMXRKVFJD?=
 =?utf-8?B?aFZuWkRMa2x5TXNXWEorVEtRNlNsc1pPUWtRWXVRbW4ramlSRnJ0ZFJRSndB?=
 =?utf-8?B?SThBa2o4dnd3TUtzWWxSalFQbitDVmo3blZYRFM5WTB1Tjl0dXlFK2hscGhl?=
 =?utf-8?B?V2JTa0tpNXluZHhIUHlUZkpVa3l0RktMaisxaVRaNis3a1BkaU0vN3NjSFdk?=
 =?utf-8?B?aFBLc2daTGxQeW9WQ1htOThZSDMzVXZFNEFxMExuOGJsWkhWRGE2TFFCeERZ?=
 =?utf-8?B?SUdvVWZRTXNvcGV1N0hNRkVCUmVveDBEL3JCMklJWFZCaC9UbkNDL1BpdlJv?=
 =?utf-8?B?Q0pYaUs5M0l3MWpQVE84aml4WlhxK3prV2w1d3ROVnFnSXpqc1dNL2o2YkhP?=
 =?utf-8?B?TU8yS1U0dlNZSmY2cklsVllad2xGVlZhc1VPZmsvaWlRUjA4MkFHVU1CeEtn?=
 =?utf-8?B?b3V1YXphY2tsZUhyNVVHSUtlQW0vVmpWZVpkOU80dGp2UG9lWTRhU0FpUERk?=
 =?utf-8?B?eEZ3Y2xURDRDWjhONWJFc0JHV0wrZ25vVEtlK0tKSXc0Vmp3cEhhV0RNT1ND?=
 =?utf-8?B?bGIvbUM1c1Z5Smhta2VLYlFSSmNVM2l0YXdJMkpIbkJjZEJsU0o3RE4reFNC?=
 =?utf-8?B?V3MyTWd2K24xNTZXcUJOeWpKeXUxL2YvU0E2MngzdDZOZU1QR2VncEhUbmZQ?=
 =?utf-8?B?VEtBZ2NFdkZTWCtEYXZkVEdWZTdsa3JoQ1NZOHVsZ1RDbzRXd05XZEZJTUQr?=
 =?utf-8?B?V3EvSjlYVU0yZGJHZ1hyMmNLd295WUZJdTdyeGZmOHJTblExaFlMOEpWNncr?=
 =?utf-8?B?L2g1Zk5hY2VtVjhnN0crRitYVHFuRzFuKzZpUnY3RFQ1M3EyN05EcmhrOTlF?=
 =?utf-8?B?eUtMV1l2M294K042ZHZCSDBVWXF6cnltY1pXQ0tGYk5nUEUvdW55UitycHZQ?=
 =?utf-8?B?ZW5kWnljclZFbkNKTGlrSHRhVTkxdnJNb0N1VkN6cnpCVlNIaEp4VmF6S3V1?=
 =?utf-8?Q?BJI/7vxCzhYV9M7FbKpywms8umPNtZsZ?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SFhvUExoczFpd3Z5cVRnTVBBTSs4SUFhSW5jZEd2Vk92aE1VMXdEOE5qejVH?=
 =?utf-8?B?ZWFtWjRyeE91OXBNUzN3eWYzUzZNVTBTdWYyWTNjcHhrVnBSTGZpTSt0VlpK?=
 =?utf-8?B?cGFzdjYrNUhzb1pBVXFETENMY1lNRFB1Szk4Wnd3RU5zUUh0ZWtDdzZUckVF?=
 =?utf-8?B?cTVoVzVoVWRYS3hXTnpXUjEydFpJSFpNNlR2VmFWQm1mdE5HZDkrRXlFeENt?=
 =?utf-8?B?ZUxiS09uVVlYai9tV2xHYzE1ZWwzbXhzdmQyR0FRV0hYcXFmVnZJQVpnTGhR?=
 =?utf-8?B?bU80dTN2YjIrYXNENmNEZ0tKRXRTN2ViT2VHdEIrNGFsWXNFWEdUemd4d2dI?=
 =?utf-8?B?c2diUlR4dGZZUU9IT2FjTWJ6S0twdmJQckloTFROWm83WlJlOVBkQkp5cU1a?=
 =?utf-8?B?dDdyNHlLZ0taOHc4dmNieXRsVE9KTjVsaFNuMGFWYitOWDVWejRnSkNwTThY?=
 =?utf-8?B?RkpocElPejArS1hOSGd5TWJzbzFJdDdUWUdCZ0R2Q3BLSG5mS3V2KzFJVlpL?=
 =?utf-8?B?WlFyajQybFVPWndZRm1YK2p3WGczOTFNVnNxZ0UxSnNScndFYTRpVUpkMjV4?=
 =?utf-8?B?SzQwVlEyVG1CdHFkL2pxUStiVVRSMlNGeHg4SithZVlNRmp3RWJOOWJaaWxj?=
 =?utf-8?B?QldsK255SWxkK0dkNXRUV084NHF1OEtCcEdNWHJNMnl1RWE4ajlFaUhlZEdr?=
 =?utf-8?B?VWhrRWw1aHRJMTFVNEJidUxza3J4UU5IbHo3SVVrT1JLc3lCT1NiV3NnS0Ix?=
 =?utf-8?B?czVjOFdQb0pPZmxFRENSZVk1Y3FYMGRJckY1dCtzaTJ2dHpveGx6RDNFOG53?=
 =?utf-8?B?OWlBcHVTVENiNHhTVlpDd0hnUGZNdmZMTzNBY3JkdHZUYlRTdVRaRzcwaklw?=
 =?utf-8?B?ZUVwWUVCUmN2VXdaa3prVmF5citjQTVpY3g4Zks1SVhPeUk5MmRKT0lIUUtI?=
 =?utf-8?B?alMyWUk3UTlva1dGeUVSb2xjWVlLdXUyUUt3OTRhSnJpMnhjZ2JmY0VTV3cz?=
 =?utf-8?B?U0I1SzlZV0xuclhYeUovcUNpSk95SGlIOGk0SFU1aVNQbVRCVGNlWGx6Q1NN?=
 =?utf-8?B?eUgxQ2R0bW1icmt5YkVRelJYUTJxZG5pOXRyeFB4azB3bzdwbVh2Uy9BN0VX?=
 =?utf-8?B?MlRGUVl6ZHdjazNRRVRsd2t2QTNleW43VFNQdzdvK2RZbWd6ZkRrZkNHejIz?=
 =?utf-8?B?YWNibEZ0SmQxdVZtQzl0cElDK0IwbG5GUmcybjNpemxheFFOOEpwVzdwbm5Z?=
 =?utf-8?B?UE9MaFB3MFM3eWNCSi9ON0ljS1QyOFJxZVZHZjd0ejFLMkdibkswRDZRRmhZ?=
 =?utf-8?B?a1hkaTFKWVZJM21kSVFBT09vNjcvNnZrcFV5WDR1UFVBbE9tWEtPZFlJMFBJ?=
 =?utf-8?B?QWlQZ1pQcm91Z042aDI0TzBlSnVmSngwT0lWOEp1VE0yMG1pSXJCVWVvQVQw?=
 =?utf-8?B?S3M5eTg0b3E4ck81WE1OczRON2dXditkd2NjVFpOek9qZG9xc3JxT1NZZW0y?=
 =?utf-8?B?TnUxbGFpME1CSi9VR3loWWJ3b3ZCQVFWb0JNSGVpWk8zWGt2R3JBQTJ6VlUz?=
 =?utf-8?B?TTg5czJtd3ZGR1doYmpXa1dBcnZiZ2JOUEpZa1E3WE1YY0wrL2hoQWMrNTBE?=
 =?utf-8?B?UWpHcGs0L0ZzbGsxZWl1UnBOSlFNUHNjRktOQnYvaXNXRjU3QkZNUTVGRHNF?=
 =?utf-8?B?M3h2TjVGZm1MQi9SOGdCQjlQMi9hd1RkOTBpREdyejNzWll3amRYYXJPdU1z?=
 =?utf-8?B?ZzRGeTZxVkVsS2hQdHNzNXBxbDR4MXo3b01vQXFmZTNhMzI5ZHh2aUM4MUhj?=
 =?utf-8?B?ZXRpM0czQ3JoWlV2WGFLUnBmTnNQeVNkWWM3YXlydk5Ld3pHbEZBTURLUXVT?=
 =?utf-8?B?YU5paXdBdmIvei9vcGFBdExnK24xTjZ0ajJWaG11L1U2OFMxODRPZnpXZ2Ji?=
 =?utf-8?B?cjNSL1B1TW1qYmdSV0VwNlNNRFdQL3drUGM2MW1xVmN2R2VKZlJWNlk1WG5P?=
 =?utf-8?B?cjE3a1Y3a1V3bzE3WlFFa0MrUnl3OHNCK3BUWkpsMDl5WFY4RW9oZTRIenRV?=
 =?utf-8?B?TUwrdVF2YnRsU1FkMW1nYmUxQ1VLSHV1NWp6K1Y2Q3BGK1pXVjRONFIyYWs4?=
 =?utf-8?Q?XqwxT3299w2JQGkLj7uYrsvQ6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tdvNptU5unG3Y3sko2ttQobn+14uhXWIQdqw8fs33CSVs7531L3yrFuQ4FIjiafFGavS2Jn8cTGj64qJQjXvPqbJhb85A/lFvhMEooznnlU9oiADYAy13ytMvAalYy3UoOkxsdcnVlC5eSzgJHGpLJiog4d7PCafV79Le+QPNCOIgdUYiX0CvCHHThvctg66c71LzRd2FevqQaLNPRSBmnBaKy65++XRvK9lUd2CbTyB9eXpDuoPcyLmE5uXlRoAghubBs9E0yOYt2mLitlwGCWGVN0nDAoKJ4nOY23vRntsLNJeVi4rUg67kt2hRDmF2bOHGaspW54qrTvKQDkYVzlMLZati+i8tZ5BxEJ+munza2ez3FGLaV6P8g7kmMKYSieVGc3dE55m4vWz+xQWHS5AYGGd93NDcONFwU0fUwaOBeS7Tf6lZXws8om584C9wgBkmWqJirFcuJbttHINNi590+qMKTJCV1ney7Vx58yZc6bQqlvej4Ou35IGJq05FGUp/bKNxh5czUcCGp7BH//1ePaRyZl4yJ/wF4J0TpU2XOKmNfhx/c2vENWmTyWmvaxjX3eB0IhsX9uhHzkaCeTcntUQ+4rDBWFmaMmdyMc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e41d8a-6358-4285-b88e-08de07334c1f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 12:56:43.6459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlCU2MWVSN6/oMdeur9HLSsCFW48pXZkoJLvAs3sUtLi6VWLD1W3Xc+IMl7OoZZGbZowuVYkCONokIP6HF19kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5655
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510090076
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX/iAk8YRKV+3C
 02HHN0TtlCLPNtxtYL1sQSHmhfmXLexZH433bysAUCw4QtR39V2m8OdKNkXbR7+i2VowmqM4jiM
 1BgiyoJxbUH049rVa3h/ZkbFIYK77b+1BDj0LHkKr8mT9vC8JuzjTjLtxXcM4Xu+R9NjWh9U8QN
 WnJqBwed/TlXkmyqlT3ZxRovXaLMM+2liq/FIGdKfoH2Tm9hDmoJRIi6bQ/3o7Llhfykv9Uk+Uv
 Kp31KiLHlLX9DyJQdmFjqcRiFTaipZJc7CgR/F/ovuvZl/kAwTBbss9+icCZWBZCI0/MbgO44Mp
 QsyGXRAgS0GbiQc5lwAFKQCgriCi7u+C1diZCuoKIZeeY1PZn0yqV2t9DR7PlmHESnwOo3+T6Ad
 Aj6v4BaptMqn/hROtAjLGL8Y5seNnkJzgRwMRGXS7s1i9DFa+Ck=
X-Authority-Analysis: v=2.4 cv=dtrWylg4 c=1 sm=1 tr=0 ts=68e7b110 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=48vgC7mUAAAA:8 a=C6FDmSC_iuezwpThvTMA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12092
X-Proofpoint-GUID: -jClNEat0vp4ZK7cShpCjWKZ0kTEwB8i
X-Proofpoint-ORIG-GUID: -jClNEat0vp4ZK7cShpCjWKZ0kTEwB8i

On 10/8/25 6:03 PM, NeilBrown wrote:
> On Thu, 09 Oct 2025, Chuck Lever wrote:
>> On 10/7/25 6:12 PM, NeilBrown wrote:
>>> On Wed, 08 Oct 2025, Chuck Lever wrote:
>>>> On 10/7/25 12:04 PM, Chuck Lever wrote:
>>>>>  RFC 8881 Section 2.10.6.1.3 says:
>>>>>
>>>>>> On a per-request basis, the requester can choose to direct the
>>>>>> replier to cache the reply to all operations after the first
>>>>>> operation (SEQUENCE or CB_SEQUENCE) via the sa_cachethis or
>>>>>> csa_cachethis fields of the arguments to SEQUENCE or CB_SEQUENCE.
>>>>> RFC 8881 Section 2.10.6.4 further says:
>>>>>
>>>>>> If sa_cachethis or csa_cachethis is TRUE, then the replier MUST
>>>>>> cache a reply except if an error is returned by the SEQUENCE or
>>>>>> CB_SEQUENCE operation (see Section 2.10.6.1.2).
>>>>> This suggests to me that the spec authors do not expect an NFSv4.1
>>>>> server implementation to ever cache the result of a SEQUENCE
>>>>> operation (except perhaps as part of a successful multi-operation
>>>>> COMPOUND).
>>>>>
>>>>> NFSD attempts to cache the result of solo SEQUENCE operations,
>>>>> however. This is because the protocol does not permit servers to
>>>>> respond to a SEQUENCE with NFS4ERR_RETRY_UNCACHED_REP. If the server
>>>>> always caches solo SEQUENCE operations, then it never has occasion
>>>>> to return that status code.
>>>>>
>>>>> However, clients use solo SEQUENCE to query the current status of a
>>>>> session slot. A cached reply will return stale information to the
>>>>> client, and could result in an infinite loop.
>>>>
>>>> The pynfs SEQ9f test is now failing with this change. This test:
>>>>
>>>> - Sends a CREATE_SESSION
>>>> - Sends a solo SEQUENCE with sa_cachethis set
>>>> - Sends the same operation without changing the slot sequence number
>>>>
>>>> The test expects the server's response to be NFS4_OK. NFSD now returns
>>>> NFS4ERR_SEQ_FALSE_RETRY instead.
>>>>
>>>> It's possible the test is wrong, but how should it be fixed?
>>>>
>>>> Is it compliant for an NFSv4.1 server to ignore sa_cachethis for a
>>>> COMPOUND containing a solo SEQUENCE?
>>>>
>>>> When reporting a retransmitted solo SEQUENCE, what is the correct status
>>>> code?
>>>
>>> Interesting question....
>>> To help with context: you wrote:
>>>
>>>    However, clients use solo SEQUENCE to query the current status of a
>>>    session slot.  A cached reply will return stale information to the
>>>    client, and could result in an infinite loop.
>>>
>>> Could you please expand on that?  What in the reply might be stale, and
>>> how might that result in an infinite loop?
>>>
>>> Could a reply to a replayed singleton SEQUENCE simple always return the
>>> current info, rather than cached info?
>>
>> If a cached reply is returned to the client, the slot sequence number
>> doesn't change, and neither do the SEQ4_STATUS flags.
> 
> Why is that a problem?  And importantly: how can it result in an
> infinite loop?

My remark was "could result in an infinite loop" -- subjunctive, meaning
we haven't seen that behavior in this specific case, but there is a
risk, if the client has a bug, for example. I can drop that remark, if
it vexes.

The actual issue at hand is that the client can set the server up for
a memory overwrite. If CREATE_SESSION does not request a large enough
ca_maxresponsesize_cached, but the server expects to be able to cache
SEQUENCE operations anyway, a solo SEQUENCE will cause the server to
write into a cache that does not exist.

Either NFSD needs to unconditionally reserve the slot cache space for
solo SEQUENCE, if it intends to unconditionally cache those; or it
shouldn't cache them at all.

The language of the spec suggests that the authors did not expect
servers to cache solo SEQUENCE operations. It states that sa_cachethis
refers to caching COMPOUND operations /after/ the SEQUENCE operation.


>> The only real recovery in this case is to destroy the session, which
>> will remove the cached reply.
> 
> What "case" that needs to be recovered from?

When the session slot has become unusable because server and client have
different ideas of what the slot sequence number is.

The client and server might stop using a slot in that situation.
Destroying the session is the only way to get rid of the slot entirely.

But IMHO this is a rat hole.


>> We've determined that the Linux NFS client never asserts sa_cachethis
>> when sending a solo SEQUENCE, so the questions above might be academic.
> 
> It would still be nice to have clear agreement on what the spec allows
> and expects.
RFC 8881 Section 2.10.6 does not provide any guidance about how a server
MUST respond either when sa_cachethis is asserted on a solo SEQUENCE,
nor does it say explicitly how to respond when a client replays such a
SEQUENCE operation.

I can ask on nfsv4@ietf.org, but I suspect we will not get a consensus
response there either.


-- 
Chuck Lever

