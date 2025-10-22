Return-Path: <linux-nfs+bounces-15515-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 843F7BFC33F
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 15:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC7EE54261B
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E223F2FD1D9;
	Wed, 22 Oct 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DnoO9eB1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WTEfUb1X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCF26ED33
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140065; cv=fail; b=l7Hiy12dAqrRHkYt9D9GO2ForWiSD8LHJJ3lVipMDP7JAD+TWu1JhveO5i6QXv53DTMkV/hCXIGUiQe3uodWCY+3kbGIu0TieKlUbTtCOm+SosW3Lpr/RrmvzcyzSgw39YwacW96hsRCOGbXY1jqv8x1ipzqHZD5aNNt9KNngVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140065; c=relaxed/simple;
	bh=VWgWpNmC5TeOZ44BRQvKl5ji2q7VTaeCNwy/lwHOpp4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DCrL8kpF/JaeTW9IFHTPeHtalk9E3M2P1hsSU9Cx0kVsmP2ejAUr6pZDDXMNQK5ErzhB/4z6Zp9ubNwpozFMeGJqkXcK9uMSqiIb1gNN8lZHdWMAcA3toGsls5pl2908satWXPHe9n9YZnl9N8VcEB9BdUnk0SpJLuUard7VWBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DnoO9eB1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WTEfUb1X; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MCehDT006133;
	Wed, 22 Oct 2025 13:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MGfovvRAMZVAZ4E+nOxznePzKSZBP6AGDglSXwsQIcM=; b=
	DnoO9eB1kSOZKeVwWs/i2f+flSxy9XBaDXTfy8q4JVCJ3PSgt9JfzPYcEQ8tdDnj
	9VHq56AZ5sYaFwr2Eo/PSbPicRXnscuIyNKBvWjRtQbT4pq49DDqtd6MP73ks3PI
	yMMaaRZO2PVZedywwv9AqQwI/OG9f7us3g4gsIFTfoRJ/NGdS2LH75G9xCqsv3L6
	RoFNaCjKc1PwDRg9mrngZ8CFP91zhtMZVIV5An6R47HLFaUnjcv2JyEPp4+4nqO/
	c+zP/on2uryK+QxdZPcJH6GegziFrtZg84CuQnrlLUYtZGGqKDkopFHYViiBCThR
	L6oROXB+tdusOBefgbSH6A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xvcy8dya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 13:34:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59MCcmQA012175;
	Wed, 22 Oct 2025 13:34:11 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bde4e7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 13:34:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0BId+vbzQP8/ad8wkJJ8Y6EHunoo+LU7IwVgRx2RQzzamJO9osnVKqDnNMuc6RNIaMcsU5ez2J5txYS9RMuOK3tmF+TF6lvd1DwyksGwSI5UIDNvyGYjOZ5oX4d7cTSG8epfYWkCWo9TSQZgPwxFtvLGCXeYyXXsU7GdP7ooeRPP5JqlVxCNgyJOawjyZLYj2CmOJxrAFTooxlSfQ0Gi6eJIhVh/bs3vHdfZ3cIHgmWYxMETX0c2umvmuQW+13Hk/WSNXIpGgNKBMYKQ6pTwhxtOwle+rMj9RAUyzaS7QSmKfPJQkDy1bYAjYWk56z1rFslyGmtyNw+pwRAaN1ctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGfovvRAMZVAZ4E+nOxznePzKSZBP6AGDglSXwsQIcM=;
 b=a6L+P7vrgH5Nu0EQ5orMnPjRf5Ii5FEJwxFrcHcYBJRuKF239PiKtPGjqORtdBxXBv6RO/gUBPTFvcr01xm62b8KnJDlvSyBGmnVHJXojKNs0z4dkB19eOpNapdrKNdWmSQdIZMd56lgtAFp9Qbr57QVzq5MmRI+seJOp5JFwbfbufXCXOnWYtg9UgDh2DGctMXh7ChePMl4QxpKNNfvTV19qnRVo74kZ81sTPvhVjjETAL3SHehtVx8cGiUPouFonZhxt1XdtZUOhDPtIvVeeTH2aEtAFlrI9VgkPz6MbcEh9I3fXjcFoUch7drScrvx9KVaCFqe+o7atws1/No9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGfovvRAMZVAZ4E+nOxznePzKSZBP6AGDglSXwsQIcM=;
 b=WTEfUb1X37ieFZlerzfjtjjS0VNM++0/XFQ/7a2pXypWajmQq9o/fgXKjMWGo3o8kb9ncfq+Vzn76/ZyDH+OJP9mBNj1rkQIDPyrKKVy6hF1rWKcaQ0bjofa6ETZjo5gu0Rwi3gFjFNtsIth9ysjpiXzqeV7w5zJw074BaMKm3M=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7825.namprd10.prod.outlook.com (2603:10b6:a03:56e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:34:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Wed, 22 Oct 2025
 13:34:08 +0000
Message-ID: <953be593-41aa-4d4a-809e-7614150ee778@oracle.com>
Date: Wed, 22 Oct 2025 09:34:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add a nfsd blocklayout reviewer
To: Christoph Hellwig <hch@lst.de>, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <20251022114533.2181580-1-hch@lst.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251022114533.2181580-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:610:4f::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 0128c29a-65c7-448f-904e-08de116fad81
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RkdJUFBJVjBDVkkvVGh1d0laeTdVTFZpWTdWSXh2N3JIRzVwVjRlRnN0WVM5?=
 =?utf-8?B?SWtnU2JNd3YrL01naXB6ZU9peG55WjBkeUdMczUwNzJDQ2x6NDZJMUdodnMx?=
 =?utf-8?B?T1NPNE02TmVWVGRtZS9DWEc5YzdBcXMva2tkSkpWeUY4dUdOQ0lHZjBDbkEv?=
 =?utf-8?B?cXIzUU84L0doQm1aMkhwVXA4ZENKb25BcENsaXJpd205SnhPWGtpZ3dEc0pq?=
 =?utf-8?B?TmMyYU1kTkRxK0pFMS9ra3hLV0FBTEh4Z2FVNkR0d2ljVHdXeXdvRFVwWDJF?=
 =?utf-8?B?SGl0Tm92QWdvREphNmptQjVrcVZaay80cjh1Y1M5MzJ4NVNPYnVOLzE5NDQy?=
 =?utf-8?B?VkFMVHhxNXlaTytwMlU5U1lTWHhyVTc4a0hqVWpLUFJ4VmZBTk54YTRMeEFp?=
 =?utf-8?B?cjNRNDVkMExwNVF1Wm5NNFpkNlltTFM4Z2RxN0xJb3AzdUlhMWgyZWRGV0VJ?=
 =?utf-8?B?NU5CNEFGWHMwMVVQZWZ0bWI4V21EajRxM1p0K3pvYVYwWjZRNUhYSmpISEw1?=
 =?utf-8?B?UXVMRVd3TjlyeUJtQnNzRVNydlAyaUdVb0NQSG9hcUY4VStMTUlOeXdMZ3RQ?=
 =?utf-8?B?MExjYjNhRUxJN3NSamxZWVZHYWVkUzJqdkhGMjNpQ2xxZUplOGE0NlA1ZkZt?=
 =?utf-8?B?WnExMHhMcFZTTUNja0dWVUdOQUlLNFJ2N3J3ZDZkTDBROWJSdFdjMXF0bHJ2?=
 =?utf-8?B?Zmw5N0tTTjJHUk1RQnNWRXc1ejQwUzBoMElHcGRmMnllRDJhdzkrM1BKOUtS?=
 =?utf-8?B?SzcxNDRvS25GQm13NGR6eU04SGJrdG4rNk9wWUdoZkJtdk84ZXZsRzJFVk4x?=
 =?utf-8?B?T1pTRC83NlBJS0RidSszcHVRdURxWHFsTmNoNzRwQUluUWNUZWp2ZW96blVJ?=
 =?utf-8?B?ZjZiV1JXSTcwVTI0OFhCMHRxTk42SnV4NzlEM2pIemVrd29lUi9UcEZodENi?=
 =?utf-8?B?anRYZE9iaW1ja0pVU0RlOEdFakNDdTE1eFJCUkFOS1B2Zm9GRjkrQ2djaExz?=
 =?utf-8?B?UjRidTJSUzdnOG1RdGlGekplTzBrMnFOWjhaaytkM1VtaUlaRGwrNGwyZkdn?=
 =?utf-8?B?RXFLd01zUTlPbU5LNnRKT0s3Q1hRRGhiK083aENWRXN4dEh1UlVFbko3REtt?=
 =?utf-8?B?Vks0eVlPazRsZ0JVK0FMQjFETnFrTHFIMEJKN0d1NkJmMlNFWTdNVzZHSCtq?=
 =?utf-8?B?RGtkWGdKTVZrNEg3cnN3c2FOZmxzUnJzcG03Vy9hb1o1akxBdkxTaitNV0dH?=
 =?utf-8?B?alV3NUNRa0JEMXZHbnlCaG9jU3BhUXZMbWlOY3ZJelRNcC91Z0JNRWhmaFpv?=
 =?utf-8?B?dU5VaEpCVVhlMFZGbUx1NHRQS0tCeXA5eVN5RHFQTlFxVVpUWE9IclIrNjBr?=
 =?utf-8?B?eWljazhsKzZOUFlscTFrbi9nbEJMeFpvNW5rMWx2N3gzRXJIRTJySnQzaEhQ?=
 =?utf-8?B?VEZUV0Jnb1JkSmYyUjlzSC9YQlVwVTUvZ0p6cmZhUXZrZzhMNUpSL3BXZnBu?=
 =?utf-8?B?djd4Nlp2MUNMRStkUjlsV3lkUkNOZy9yRXFEZjk1dndVQjdUM0R3YnNYRDFU?=
 =?utf-8?B?eW5kTmtJemUzUXc5dUJIekx6cUpMTlFvTlhaTThMSUdNTTluSlVUUURrNmRi?=
 =?utf-8?B?cXhUcnRYNmdnRjl3Ti8veEZ5MVQ2OFFtWGN2TExqbTRrK0xKek4zcjY3OU5s?=
 =?utf-8?B?NjJRREZzdzc0bVhCM01wNVpDRVVXMyttWGNYMEhTU3Q1S1kzZGpHdDY3bjVS?=
 =?utf-8?B?MDNES1pSQ0J4YlRIZlFNTy9zcWdnTjh5d2xiM2FWNUREYkZSR3V4cGN5RHhm?=
 =?utf-8?B?TkRtdDI4Sm1EM3k1VmJRWTVJVlN6dHJHRyt3U1FZWkJIVC8rTzRaT0Y5OEFv?=
 =?utf-8?B?aXp6THBFZmNRMkdUTk95dUpxRitnU1FkRGVsRUFNRHNLVlR4TkxpSGJ4a1JD?=
 =?utf-8?Q?eOCdYMyr7dLoCvvbTsCzTMIMW90dd4pa?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RUZpNTVScUF0cXV1enkvTkRDSjI1QkhHT085YzhXQnRwemJHKzRFeHNldkxI?=
 =?utf-8?B?eTNyWDAvYWlHcHNwOXZIVTNGalJPUnl1MHlicXQrZ3ZkOHFGek9CcjU0V2dR?=
 =?utf-8?B?bndHaEtBb1BhOFNiYkdSTnlOMWhtMm80Vk5SWUNXZ2xFMW0vbis4eWZEWUZI?=
 =?utf-8?B?am1haFR4MEQzVGJRNGZGZFlCUWNZYmwxajVBQklaREJFT1haOG5rWTZHbGs5?=
 =?utf-8?B?RVpSd1pBbFJJOGJLZWg4N1Y2WDVIMkQrMUEycHRjTVpqaHNQK1VJSmpqcGdz?=
 =?utf-8?B?dHdYQkJ0WElFMEJGTVhsQVN6MWlDcG5GQUFpWlFDSXFPREJjRStlUXBSL214?=
 =?utf-8?B?VTZlbHBCekE3a3lzT0c5SFRGYS9ZWHM0UkJoT3E5UGpRVGdVZ3E0Z010YmI4?=
 =?utf-8?B?Z3FhWlZXeERrVmlSRzFvdHhDQURsZ1lKQzhEazRVbVJDOUR1R2xPSnFBbzl2?=
 =?utf-8?B?VmNxKzNIeEFWWFRmeUdXU21zbytxUGx5ZDdoQTArcThKcElzK0l1RTJRMFBs?=
 =?utf-8?B?dndoamZhOFN1TDdCOGs4Z1BLZ1BEZ1hoVTZ3RkFVbTRvZS9OWVBxTTJCZU5p?=
 =?utf-8?B?aGh6Z0xsSlVYcjV2NjlUMmxNUFdTSTBlOWQvUjBiVnhyVDg3MjZNU3Q5S0xO?=
 =?utf-8?B?eGtnaGxSMEhHYXlvTW5NeDFwNzBENllEL3JxaEFJQzdTcXNKOFprci9PbDU4?=
 =?utf-8?B?SklVc2hPZ3BOOFhwcXUrM0NOaWF6WEpvbVNhZmw3Sko1enhoRThNZXU3RDV1?=
 =?utf-8?B?YjdkMWVFUUpYbm4vTHdaeFg5TjJTT0tuV2F4aDBnVlpwQnJNcERsaFFhRGtP?=
 =?utf-8?B?enRxVTNpc2ZwUVp3ZlRJYks2S3VBUkdYRGNyYXBWZ0ZLYzNyZEtCRXRYNXVI?=
 =?utf-8?B?L1RQL1R1by80elJEZWUwN3hMMHVpd1NWRE5rVFUvdWJTN2p2UXhmbGhTZWxj?=
 =?utf-8?B?VldwcElwOExnQkx0OW82am4yWHVLKzQ5R2c1T2krZWh0eEpMeUJvc2lEdjM5?=
 =?utf-8?B?YWtvaVpIQkZDRlBJT0lrQ0xYalhEaEVIOXZvOWtaSTRrWnhYMjkvL2lYVVNH?=
 =?utf-8?B?Ykp6aTBBeDBtdUU5TStRQnAvR1RhTVY2elJSWVpTNHNhL2grTklQS051cHRI?=
 =?utf-8?B?ZnRRYlZvbVFHVVJ0MWgzNHVmYjZvMWdGM2RFKzUzZVVkb0NZbTVxbkJTN2Uz?=
 =?utf-8?B?SHFSWjVHVi91d3cvNGxVRTZvREUvanhZTHlMd0E0L28rV25OUmFIRmFmUWpo?=
 =?utf-8?B?VWl2ampaMnJTL0xoMDdqRWg4RWZGdEo2YS9mL3Q1SWc1VHJjWkZpbk5jaE9V?=
 =?utf-8?B?OEoxUkRUWkN3MUJieWZibTR6RmxWU1dlUUtXMnlYYWtQUTIxVmNXYlVTYWVJ?=
 =?utf-8?B?endNM1kyN2FDSi9VT0hIZ2VnOTl1RjJDOGYyVTExMEY2U1luVkxyMG43NEdi?=
 =?utf-8?B?d2FFdjdsb2MxQUVNL2hqRGZCejRURU5BWmJOYlJnTE1xWXRlekN4MzNRMTFs?=
 =?utf-8?B?K3EwM0kyWXB1YTh6UFNMRzc4QVF6MmUrNFFFL05NMExBZVgxOHF2ZjdmeXN2?=
 =?utf-8?B?N2dnSGcvdGxZU25OQStNUDJuNVhpL2k2V0dKSTFXS2JSWnN4SVMwd3Bta0tZ?=
 =?utf-8?B?dUFLQ1cwRlhoWkJyemM0c3I3dzljOW1xY1lySFJzcVRXdUpqcnJXSjhIcXNo?=
 =?utf-8?B?bUxsc1pzQWJZTVJkTWZWejlhSTVrdWVYaXA0SVdzQkNSNzR2ODJ1OEhzeXo5?=
 =?utf-8?B?c1RzT2FHMUlqNFkrdHNhamFIUHJCZGFZekM3cGIzRWpRdFlETkNma29QL243?=
 =?utf-8?B?eXdFMDV1L2h6ektJRzNoR0ZLZ2ZNL2gzWW9aRFA1OXo0QldPTkVWZjBNNC9N?=
 =?utf-8?B?SHAyVDZwTU1TcWZ4ZDNFbnBjNkluZERHd0YrV2VtZ0pERC9OVkFwNnFEL3Iw?=
 =?utf-8?B?RFpJSGFnMzlUVTJhZWUrOWxJQ1VvZXFQZVRFQ25HSi9vY2tORDJEYkFtemUw?=
 =?utf-8?B?OVFuZmdMUzJwN0dQaS9GWEtjT0JQcWpqT0RxUHNMZjdqbFF5NmlhdkJOVUVR?=
 =?utf-8?B?Qm4yMHpwZkwrRFNrZVAzMW9iUFJzSGlmUG01MkYxcndUNnZGZE9mN0NneENS?=
 =?utf-8?Q?7Gich5b0Tq2c3JO2vBBLvIBYA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P/ju0qnJW90Bf1CEqF2HpChK0iUrT2Q+OaREQlb0BUHgSWEYlwwGQ4CbDY0kYBT0gpV29xgrRys0X+YQcWGK+KcDkQPEm0q1kIBOolN9rbhhCFEqUSHtQ6GKzxuiOaamSOkZIeldKWPTasZ4O/1B79I5ebyccH+V/Pm0qG+kTeKt2p+5tZ+edVPoztZdlGADwP/vlQXLQFyXxBhL6/K7FYg7T6SpV3v0Ilj6b6Zzlu8cvpE2r3eePyaOiXXv1oH0pZnJ4InOchPvXWjMthVBIdt27Xn4WQKGDKC/L9nb/NdbCUdL95+FHyWJ8SpDDIq+HErT/FEAerqcXNQmJNuljBGw0GFjpB2rzkxGOwAUn5ZVAjmn0tE1di5ELVR8nkYOGEnkY4xKvHcFYPCgKbOHBeKT1hh4GfqvjWn/x3g88LBUrItoOyMyOsedjDFMl7GtPP9LNWhZtOMuZ9gFsBjmJYjAPdoCT0D3+Mdo650N+aBfyBjGb3j9+/KUQZl1SLeVuQzTcwwgwIadOw1Cm5t8IwUqv5WEn+O/fUTkRPIQJcgFUW+R3McbMFseJmyLMe9L/ZYOmV64HeEDKmKi5p5qwIyRsObNsWFTO7kPMgjisCk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0128c29a-65c7-448f-904e-08de116fad81
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:34:08.4438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHvP4HWgQG9cIJmn50kv07XpcbmYUNlbZ38k0THmvt8+q2y0F4PX6X4nIF5y5aUAdjt8CZ2DKWBslp5/fT/fQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510220111
X-Authority-Analysis: v=2.4 cv=GqlPO01C c=1 sm=1 tr=0 ts=68f8dd54 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VTue-mJiAAAA:8 a=qmU6OyjKAAAA:8 a=S3e0d6BWkA9axjcLr_sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=S9YjYK_EKPFYWS37g-LV:22 a=iNQtemt1gxbOOLyaF_ST:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MyBTYWx0ZWRfX/mJV++iY18+5
 4721s2NddCLuif5taU+p+spjQVVrS65lsaqjzkzqxDkpbfyU/+SFv+2dz8V28asBdujMbUEtEgy
 yFzCxe2hw4YG2tOKDlosej+WFMn/hxQU+xlw7etxq9Pv6Jaro1jC633INeDfgh9mu8LUNuTk5I/
 7HjNSG4qHNfxWg8XGl2aT3TQ7U8S2yFCH9FRw+I3Ro3FJMMAnOQukJr0+iHRAK71IDgFVH85zyR
 Lmqo0k+issWyVW2BhNu7DmxO9z+LTHyIb/J8aCpLHaFHHyF6jpQFMTHy1VbvFYs+EzF78EA5BkL
 rikVOcCvDy6PhI5VKaSQ3LJU4xezTVGeX753QGoNsGXIDXsTfOFgwwLrGFpUcp29o/fKHr9pnhi
 jB7zLZELvgWrlbqWO3F1qbKtgWxv2w==
X-Proofpoint-GUID: GD5BeSBIEf5oXpmV2HslD9d-c2d7mc5F
X-Proofpoint-ORIG-GUID: GD5BeSBIEf5oXpmV2HslD9d-c2d7mc5F

On 10/22/25 7:45 AM, Christoph Hellwig wrote:
> Add a minimal entry for the block layout driver to make sure Christoph
> who wrote the code gets Cced on all patches.  The actual maintenance
> stays with the nfsd maintainer team.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f2bc6c6a214e..1dbdf64bc362 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13586,6 +13586,10 @@ F:	include/uapi/linux/sunrpc/
>  F:	net/sunrpc/
>  F:	tools/net/sunrpc/
>  
> +KERNEL NFSD BLOCK and SCSI LAYOUT DRIVER
> +R:	Christoph Hellwig <hch@lst.de>
> +F:	fs/nfsd/blocklayout*
> +

It would be sensible to copy the other fields from NFSD for this, yes?


>  KERNEL PACMAN PACKAGING (in addition to generic KERNEL BUILD)
>  M:	Thomas Weißschuh <linux@weissschuh.net>
>  R:	Christian Heusel <christian@heusel.eu>


-- 
Chuck Lever

