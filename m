Return-Path: <linux-nfs+bounces-14824-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5179FBAE5C8
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 20:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84E73C3450
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 18:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0D22264CD;
	Tue, 30 Sep 2025 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bWyUBvTP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fnfIzIrF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE8F185B67
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258382; cv=fail; b=bj3jS8XqBeOGa6qNMBuCWN7xw9Z8gzV08BkcjRx4I2ZFDHlmEtULqrPGooRST670wH7BbIUTdJ7+zCP6Vd7LNj+0czLd5NXrZL8R54FWrq8q/hH0YF5sX1W1q5w+EUwzi4N2W/CNB5jiUjZJE4ZaSPYQ0etdfnC4G4s3omNpV5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258382; c=relaxed/simple;
	bh=UuOaR85NdakgKfAfl8TZOzzWSIXFXERxVLhmAzEuA7w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LdTzyesaYFsKy8W3ZhaVLcC1V8npHJdAAQvOm9ts5GtfIP4q4dNeOMA21//MbA/SbvxfjGMrmORNqJcIUDP5Hn6PwJyx+ImikquzJwAAjDeC8GJyRbwKa1AVVIIapsF2unbSDPsi0ICyhirzD3wkkDoylNKg61MvEVZy+xqOXH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bWyUBvTP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fnfIzIrF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UIELlB006967;
	Tue, 30 Sep 2025 18:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/XBd1fhw7YB63f/jx9vw1NcBDBDCti8GK1thSh7LJPg=; b=
	bWyUBvTP7VCRG707iJLiqov3pnlknA7og+oYtBcYcPyEQmxeBk4s4lTE+LAWl0mO
	JZibiV7uPqWAolRDNYQEf85nwAXanYTgxffqhobziWqpRfxr9LJt+BJirCU9P2yE
	jN57Vyz27FRFkWNUWx8dUs49hFR9xdliqlAShH6XwIjk5ykxDyRKzS+01OpONH2N
	cmldldB+j9NDcmvtHPLCWzvX6CMDXq0JLIYkekcXH/Q6shro2qbAS2oRSas3o8I2
	Q0dIDdDVHMwt2VPGdI3YCbpHb3CxfKLqNRtKPF0geAj7Tll0TdPW4C4/tmiCSQ3J
	kU0r7RM6ymU0v5/lYU2PMw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmabg2aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 18:52:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58UIWN2L001949;
	Tue, 30 Sep 2025 18:52:51 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6cesdt2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 18:52:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y63KRgbErEnaj+qRM1kb91iwvLX5q6MiwMNSEFR4am4MOiaaYEPVH+lZOsnFRAEiPErcZo4psGGeg0sQkCj4MMWFZFxq6h4uone2y/+gNrnIiyQiJEKosKxezwM5rC01FZcFThyR1Y/gzcNbqH4OfLbAQr0NcqSqPwxdshud6jSoqHQ/MnoDwNi/dXjwQzaYV8qzb2B+NM115VXalgrv3QaQ/cxsEom47oAyvemZA8mTatCnWqbq2clxL3qQiUHC7CriClVt9p/kMDBnW7+nhY+moGOPZpvPe7fW8Wxah8I0ineaXvLJ3M+s45LC2h9Q/VdKe6acr/h3ux3NvuWcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XBd1fhw7YB63f/jx9vw1NcBDBDCti8GK1thSh7LJPg=;
 b=nCoSKNUVdaD7i7sur+yWPN1xlFWlpTcrHTb2uPQQlhVMh1aHbJV6qV7WNe0RbNT3Bgy5eVrf31sYlwQs+Ll8PJnj8xZFarhcpfGAjQ8ALndpiswjKaTVALKtcxwcxA8IMWZkeHl/imckb1z4v8S4Y+5hCV/IGcs8kIXsn5ieA0bq9lXTS1gKwSe0si+6xO7SL3zkbFuUC3HghSJJKaAiwQP3fK4Rn2vW6bVCPHiQlYP/7G9eC/h5P7Lt+W0wkHTG9xUtdGCCGiwU04sgQ8UkCL8BWNFRGw7Sc8ViR4UPVoXJVzrqr8IuO+pqJp0Sa7XLBandRV33YU4HAY21e9djBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XBd1fhw7YB63f/jx9vw1NcBDBDCti8GK1thSh7LJPg=;
 b=fnfIzIrF2VtCseNALWrGAvszlP8RbzQM2/s0X3Vj09ZQY0CjWdcHJT16b3Hfrj1wZgI5H1GSGGiWq0xO2lT5mwi5ICL8B6X2I4uaZAsf3R978vPD6CzFmzhzXVDDHi+kAgWVY+YRupqGHB3QHBlUaA7qeaPJ9ZwL9haG/Ab13hc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB8216.namprd10.prod.outlook.com (2603:10b6:610:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 18:52:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 18:52:48 +0000
Message-ID: <ced615aa-1aab-40ff-87bf-bdfcb64cd9af@oracle.com>
Date: Tue, 30 Sep 2025 14:52:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nfsd: Avoid strlen conflict in
 nfsd4_encode_components_esc()
To: Nathan Chancellor <nathan@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna.schumaker@oracle.com>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Simon Horman <horms@kernel.org>, linux-nfs@vger.kernel.org,
        patches@lists.linux.dev
References: <20250930-nfsd-fix-trace-printk-strlen-error-v3-1-536cc9822ee6@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250930-nfsd-fix-trace-printk-strlen-error-v3-1-536cc9822ee6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:610:cd::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: d9388016-e0dc-40e2-b060-08de00528ce2
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?R01pSFo4RXJla0tPRWZWcXpEQ1lsck94NUttYTdPM1Z2bU5MQ3JadFY1UzMw?=
 =?utf-8?B?dWM3MWdwRzh0ZjVWa0JCTVRNeE1DR0wxZEdBbWtjUkVqUkRMZkNEbjBZVWJS?=
 =?utf-8?B?bU5wYUxJY3JtL1ZKZDF0WXo3NVZkd1lZM1M2UGhaMFlyZDV6VE4xTEg3U1JU?=
 =?utf-8?B?T1BISkphaGdhVmY4L0NmeTErVXVrQmZlWVVoejJ6QTBqWUo0ZGJpa2xuZjR1?=
 =?utf-8?B?RUNnVEZHN0VveC95RllXZDlGZjVxa0k0K0llODBCUkp3bmNXWVlrN3RMQTBq?=
 =?utf-8?B?ZFdxZFJVVHRya0lWcStoRldnOVJtcVZpeDNRZEswUG1Vd2VpOGxxVDRIUFNM?=
 =?utf-8?B?SmtDdzZVa1lFTW5rRWpUV1NSRjRwRGNCa1JpRHNPQXJtZTJQMzZUSXB1SmJr?=
 =?utf-8?B?cTFBeVpadWtMM216SStWT0pjeVRVOVlLWExvVEhpYmwwM2Zvb3B2Z3R6UndJ?=
 =?utf-8?B?S2FtN290dmdqQzNxM0dvTUpQcHBaV1B3aFlEQWVxYTZFRGw3eUkwUjFsWmpG?=
 =?utf-8?B?M1ZPRlYyL3kxaWJwVzV4UDhRT3p2d0xMU01HM1ZyTElZRStyYnE2d1FZaFhn?=
 =?utf-8?B?dzFFS0MraHJBR0dRTVZhR21mazB5VkhIazh2TWxLY3RRdmVmMlZLRzJPamRZ?=
 =?utf-8?B?US9KZlB2ZUhYSFJqQW9zalJBWktydCsrS1RoSXcrSlhKSjBIR1lzSHFuWUsz?=
 =?utf-8?B?SEZLcURSWTNXZ095bzdTV21CQ0hGaWhrcWRGUldwTmpkWElsYzNBbldxVU15?=
 =?utf-8?B?NGZTbEhjcWQ5K2pMeUlnSWVPL2tpTjFBTXlzWnFiRFBJcGgxUHZFa0RoM09x?=
 =?utf-8?B?RENwd0Y5NlQrOHJtcERlRUdQeTBiRDlFN2Z1UklNbE0vNktVYVE1RnU3Tm1k?=
 =?utf-8?B?dXJIZFFkeFNhZDJRcU10SmMwdUNpSkdkRFRzYWJWY1l3R3QzRHRmNmZjVEw4?=
 =?utf-8?B?Uitxb0J5aW91R2hwaDNKSjlsR0pTWFYrZndvSi9jNDNXT1d2RnY2eWpPZjZ5?=
 =?utf-8?B?THdtcGIrQ0hzdTNMb1FhaFJ2VGlKZFZLVkdKelJwdkRRRWtZWkJhaVFtdUx5?=
 =?utf-8?B?QjBXRVNjZWdiUUI4ekgyWDZxc2RtSUVFV0FqRWdaYzRIcXY1eVY2OTl1OWg5?=
 =?utf-8?B?SWNOUU1GejRBVDB0NG9xTGdpVTZINklVdEZhbWpxUStLeDVDNys4Yi9Mcmh2?=
 =?utf-8?B?YVpJYXVnVGRRL3crRW90MVlBYjVQdDQvclRjeXBjZlFCdUhSNVZ5WHRFZXlS?=
 =?utf-8?B?TVhuWSt6eG1mTDZjRFFUM3hSWDl5aVl5MDRkRWtlQ1JmVUxSQXRJS1dqRktQ?=
 =?utf-8?B?dEJKWUtLZDY0dFZma1ZoVy85M2N6VzdBRTdlaXd2SmZoUDlFS2RjY1l2c3BK?=
 =?utf-8?B?T21pRDJqMUFzZzQ1QlR4MG9iWG5WQ2Riajd5YmNrR1pQSURzRTFBN3paeFMy?=
 =?utf-8?B?LzJGUEFwUUxpQisyNEFOeXBZeTlPWUxyWVpPU3VEeVh0dUsySHRjYitnVFdj?=
 =?utf-8?B?WktrR2ZHSUZQSEZXc3ZoWVdqSDY1N2JoTXM4bjUyUnhTUTNqQ2xkc2NXc1ll?=
 =?utf-8?B?UWFwcEx3WldjOWp6STczMms4ZzVvWUZRTmxKV3ZlY0ViZDZ0Q3dpSlVBRDEx?=
 =?utf-8?B?dzkyRXZNVjVHQlkybWF0RExSZjZiNUowRkpZeks4WFdQNXN4L3A2VVgxNERu?=
 =?utf-8?B?eHFvaytadkdsVnhscktMbFdtY2thY2E0eklRVVNicWFBbkNWK042V2Uxd1BH?=
 =?utf-8?B?V1l3QlgvRGo2WHJheEhScis3aFhMRGZVNTJZcFYvSkdjVzhmUmYwd3lxWm5C?=
 =?utf-8?B?UWNITnU2MmpCcFJ4VFl2c3U2T3ZJaEhQbWE4ODM0WEFMMjhCZVZMeHRTTUlN?=
 =?utf-8?B?NkJuUzd6OGdjdkNCSmxORXBlTG43UVZwbkR0RC9TamtXZ25DYi90M1NRc3FU?=
 =?utf-8?Q?PZ+4KnBHWuo=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?c0NVbHUzVlFTUlFsOEV5MWZBY3I0azNUZE5vaXVUQjRtWXRWSit5dGRrNFg0?=
 =?utf-8?B?ZU5zTW9pU0p3WEZ3M2RNRjZxYUlGQ0FiMVN0Y21jY3M5QmpuMzhCbFk3M2Zv?=
 =?utf-8?B?OGtjdVV6T21nRk5maGJoeU5ic3ZqYS9VeEhSTE56OGtQd2trb3BvVjRPUURx?=
 =?utf-8?B?VnQ0TytvdlNqY0pYUkpVc3VGcVhKeDFJdTJtbERPOHhrZUtMRUNrWDY2a253?=
 =?utf-8?B?TUJLNEd5b09ubFljTFg4K1ovL1VnVzMzay8ybjBNc3NGY1BEWTFNMzJzdkFo?=
 =?utf-8?B?a3pJQ2l1VTJoTU1NL1kyTWZpUDM2bzFTVmpUc3pQMUlPM2tyUFdXNkU1U3BP?=
 =?utf-8?B?eXl4SHZKbEpNTWF4MEJoSTJDamZlWndpdjA5Nzh6L3NrNnREMmRBTnVzSkt0?=
 =?utf-8?B?dVBIRTFKSVdmVXZLbUtIbERTaFh6MEVLTlBwamNiNE1JWWJTOHJDV05OMmo1?=
 =?utf-8?B?cjBFaXBhUE1pU1FwMXl6SnFOMVN0eVI4ek1BaFF1c21sUGxyWm1NSGhSMDRO?=
 =?utf-8?B?UDM5KzRnZFREaXphb0E4a1RRZ2JYTnVGMWpLZXBQL3UrN0JpQVVDeXo0bE1x?=
 =?utf-8?B?RndlNTBPdFhOOVJTekpkQnZ6bkxLZnVxNjdNdk1lYXFrOXhFWEdRajhNRkRi?=
 =?utf-8?B?ZVVVYnJuL1IzNzV1a1ZFVDI3d2NQbW1NSkQzdTVtMkVzUjdsQ2FabExJemJE?=
 =?utf-8?B?MXZTUFFvYUNieXpoeUJXZWhXMTV0ek9TYjE2OE0yZEZjUERaZStDWW1wTFll?=
 =?utf-8?B?M1J1QUVSSmJrUzEydlI4VXZLRmpSVkxEV3JDR3B2M3R2eGtJRVpQYTVRRXRU?=
 =?utf-8?B?SmNQTTJVWmNkdWZxeXFBVFkvZ2JhNm9McmtlanoxeTF1cUlscy9lU2V6T2Vj?=
 =?utf-8?B?TSsyTnljeGVWaFZVQXRBcmVIQll0dzdvc0ZzR3FiZmlYOFp1eWRwVERJSzJF?=
 =?utf-8?B?UUlIb1o3b1U2SEI0RmVWdnZzYWRJYVJzVWtiZkg5OG5XSkR6aUdmbXh0N1ox?=
 =?utf-8?B?VkdjRExobnVaaDBwQkVUeXZhWVhGNU90L0ZqMTUvY0ttek1rRzNSZ0Z6bDZp?=
 =?utf-8?B?R3ZSaWhmTFpFbWlqejlUNzNUMmY3eXZ2cVNoaWxEcjVTdGVrVWtUdk9mVWpD?=
 =?utf-8?B?bDZUVjdKQVhScnQ3Um1uM1hzSndrODB1RGN2TTQ1b2tONGs1NUpjZ2FacVRP?=
 =?utf-8?B?OTRJdWwrRUNycnk0Ym5kTmtlSjJPL3BVeTFRR3VuZjNxamdGeXpRdHhyQkF3?=
 =?utf-8?B?OUhvV2pkT01pSU1yUmYyeWgzTk1vVmV1M2JFL3lWNGFxUVlVUkV6S0NqUDhs?=
 =?utf-8?B?Y1MxQSt1aG1QalNUbTJvRlIxYTNMa2Z4N1pSckRMMmlSUUVUVnV0NnBMVk9Z?=
 =?utf-8?B?dExKeGYvQkJXWFBuakhReHY3WlRFYmxLVEJMbFA3L2oxcVduNUZIOWtFRUxV?=
 =?utf-8?B?WGM2NjlScERMbHZvSXZWd08yTTZqcktjNnlIdFIrY01NME9yb3llb2NrbW1i?=
 =?utf-8?B?WnRYQnpTYVpEZWxicjlySXloWUw1am93cG55eUQxbFVncUZZT3BwZnNmbzJ0?=
 =?utf-8?B?VVlmMjFUYVFZdHNzckJIMkNSczA1MjI5Rm1XaWxnNWlvRjVPcUZTQjF0Q2Ny?=
 =?utf-8?B?K01NMmxKb25kS1F6SjVRa25nRzkwZXdHd01NVmRlWUgzNTVQMzhSQm9ZdlhT?=
 =?utf-8?B?TmdVMENDVlJsNmtCVUoraGVNRFAwVDNSSVZqby94M3N6c08xWGpWbDJ1UVlr?=
 =?utf-8?B?ZkhCL1hOOTI0RmJwblo3OWUvM0NJTVhTMlZJblljN2ZkRFRmQVBxL25rbSsr?=
 =?utf-8?B?QWk4YjM3THNBMGxoZEEvcW5DdVJFR0M4cVhZM0hucmVtYkNJSEhTSkZ0Y2FH?=
 =?utf-8?B?c3BqRUlxd0d3c0F6MHY1KzFwbDc3U0F5emRtSnJ5TW83Rlo5OWpZS3d2UlZi?=
 =?utf-8?B?cFF2bDF3dUpBdlJ4UFErWS9INHdLcDZickdjNmV2bE55bzhFblpzQStkVnc0?=
 =?utf-8?B?NWZiMGxUaXJyM0Q5L1M0c3hxaTNuaXZJcm0xenBxYTJMRkVrT01lSXRlS3ox?=
 =?utf-8?B?dEZ6Vittc01QR2lXY25ibkVGTkFCUFlmYWJSQVRGb3NkSnF2YWNUdzdxUXBl?=
 =?utf-8?B?ZjE5dnpZL04yNnpSUTkyU2FzZHZYN3U0emZ5ekV4RUkwZENRKzhuQXZxNi8x?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uhb/HgDTSeNVdYN9rz6Nio9opcnWClS4f8f9UHZ6CLob9Vx6mSpNnoYdmP/1ofNXsu0xoN79aFWHTXN0j0Rq76eCbRTr1sDp0XLOCxa0fz5aBNECdDxhrKpwZmxu85Ow0QIMuNKj78qgCdtiJG7juP8ndkD6mCFm9z9Ngdcy8l640geJm0ADQJ0+J5ODOiDrR2P8uryPW5Ko7PRLyD2lfQm/uqmPqPjF3tC6JwJjNs9vJ63XB1cJoSwhf0jTH0GBHLocOVNojz5sH2h3CC+Frl0kMJo5sw+J2ZSP666yrxxGJvQSo5ShwGR2TNCAIKCy4vQkInMJpph1UnzXjzJNtalxpRy+eowiIDYzHGZ+9b7aKnwClkIo2g71ihbz17BAGfFx7ivdWrMXUsvRm/7JpqxzPEExN8WvlYgqTYpHvP9iToD9GpnzNC+44QVLgFeikMB7GhaLORAkJ/n/Oimugio5Y1Y1FnDQlA/rAZxKlo3L0W+Jkn9QXiXkbfS6czU4nofURRQM9qjJ5INxUFeiHe8TdTIcUXmOipHU7kwzxcQnblU+LMWdhGiRYzgHl1ZGlnweNQXwNMfOPfwKukx4Tubsy963aJGJ1/IE7+bzUE4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9388016-e0dc-40e2-b060-08de00528ce2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 18:52:48.5715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhrG7L9bygaL9jHLUpGzWn1N2LZwyB1321JizFwHpWQpF1Nx9der6KbaxDsmWDHYBMW32aW+z1OfJfCDmfAw/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB8216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300170
X-Authority-Analysis: v=2.4 cv=SI1PlevH c=1 sm=1 tr=0 ts=68dc2704 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=vvBIxY26ws3Y3L3KfksA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 cc=ntf awl=host:12089
X-Proofpoint-ORIG-GUID: zY0uc_R1Szw6oNN_N1OC3FyFNHli5uKG
X-Proofpoint-GUID: zY0uc_R1Szw6oNN_N1OC3FyFNHli5uKG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NSBTYWx0ZWRfX2wzE/TsrmLfd
 4mk94vyPPHeio8hQil27Y9gmIvy+5r9LAJ8QcS6ysRhZZeqEHP83xeLSzx0o71A/Lc2BnONGnZa
 sa1L4YS/uKNo6f6Pr7m07mTbhW8F+dDP5SYOCLN6ufuqrLFePvu/aaix+0zpG+OVMzEKzKh8p/m
 mei0AOMq+gCz0HNvt7sykmPlLE5KxRD8MciQiwX30yiWCJZLoXr/NlVz0HvJ6lcfwmcAb8rX7RX
 AIIfwUU7xhsVOt1DHf32pLp3AWhYW/vCcxoybUsRwnhcAI/3zTDx4JmzWNkHLKa2xnHVIzWDxpg
 Pu+OLwjxeiRUtn8o24s3/HGQijNoTQ3JXgl5zzKgLhvYq9SSqGVFvPOErt+U2nRSbnXdhCJCoPN
 OGmpxqZDB2AWpYbJOR28NQAv6+OPOltFWlyr4RGRy/E/fFyx2/U=

On 9/30/25 2:31 PM, Nathan Chancellor wrote:
> There is an error building nfs4xdr.c with CONFIG_SUNRPC_DEBUG_TRACE=y
> and CONFIG_FORTIFY_SOURCE=n due to the local variable strlen conflicting
> with the function strlen():
> 
>   In file included from include/linux/cpumask.h:11,
>                    from arch/x86/include/asm/paravirt.h:21,
>                    from arch/x86/include/asm/irqflags.h:102,
>                    from include/linux/irqflags.h:18,
>                    from include/linux/spinlock.h:59,
>                    from include/linux/mmzone.h:8,
>                    from include/linux/gfp.h:7,
>                    from include/linux/slab.h:16,
>                    from fs/nfsd/nfs4xdr.c:37:
>   fs/nfsd/nfs4xdr.c: In function 'nfsd4_encode_components_esc':
>   include/linux/kernel.h:321:46: error: called object 'strlen' is not a function or function pointer
>     321 |                 __trace_puts(_THIS_IP_, str, strlen(str));              \
>         |                                              ^~~~~~
>   include/linux/kernel.h:265:17: note: in expansion of macro 'trace_puts'
>     265 |                 trace_puts(fmt);                        \
>         |                 ^~~~~~~~~~
>   include/linux/sunrpc/debug.h:34:41: note: in expansion of macro 'trace_printk'
>      34 | #  define __sunrpc_printk(fmt, ...)     trace_printk(fmt, ##__VA_ARGS__)
>         |                                         ^~~~~~~~~~~~
>   include/linux/sunrpc/debug.h:42:17: note: in expansion of macro '__sunrpc_printk'
>      42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);                    \
>         |                 ^~~~~~~~~~~~~~~
>   include/linux/sunrpc/debug.h:25:9: note: in expansion of macro 'dfprintk'
>      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>         |         ^~~~~~~~
>   fs/nfsd/nfs4xdr.c:2646:9: note: in expansion of macro 'dprintk'
>    2646 |         dprintk("nfsd4_encode_components(%s)\n", components);
>         |         ^~~~~~~
>   fs/nfsd/nfs4xdr.c:2643:13: note: declared here
>    2643 |         int strlen, count=0;
>         |             ^~~~~~
> 
> This dprintk() instance is not particularly useful, so just remove it
> altogether to get rid of the immediate strlen() conflict.
> 
> At the same time, eliminate the local strlen variable to avoid potential
> conflicts with strlen() in the future.
> 
> Fixes: ec7d8e68ef0e ("sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Changes in v3:
> - Eliminate local strlen variable altogether (NeilBrown)
> - Link to v2: https://patch.msgid.link/20250928-nfsd-fix-trace-printk-strlen-error-v2-1-108def6ff41c@kernel.org
> 
> Changes in v2:
> - Remove dprintk() to remove usage of strlen()
> - Rename local strlen variable to avoid potential conflict in the future
> - Link to v1: https://patch.msgid.link/20250925-nfsd-fix-trace-printk-strlen-error-v1-1-1360530e4c6b@kernel.org
> ---
>  fs/nfsd/nfs4xdr.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index ea91bad4eee2..07350931488d 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2640,11 +2640,9 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
>  	__be32 *p;
>  	__be32 pathlen;
>  	int pathlen_offset;
> -	int strlen, count=0;
> +	int count=0;
>  	char *str, *end, *next;
>  
> -	dprintk("nfsd4_encode_components(%s)\n", components);
> -
>  	pathlen_offset = xdr->buf->len;
>  	p = xdr_reserve_space(xdr, 4);
>  	if (!p)
> @@ -2670,9 +2668,8 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
>  			for (; *end && (*end != sep); end++)
>  				/* find sep or end of string */;
>  
> -		strlen = end - str;
> -		if (strlen) {
> -			if (xdr_stream_encode_opaque(xdr, str, strlen) < 0)
> +		if (end > str) {
> +			if (xdr_stream_encode_opaque(xdr, str, end - str) < 0)
>  				return nfserr_resource;
>  			count++;
>  		} else
> 
> ---
> base-commit: 3fadfaec904dffab02ebf63dd9c2ae8fa15c6d32
> change-id: 20250925-nfsd-fix-trace-printk-strlen-error-2a24413eb186
> 
> Best regards,
> --  
> Nathan Chancellor <nathan@kernel.org>
> 

There are fewer implicit typecasts now. Very good.

This one also deserves some testing IMO. But, if Anna still wants to
take it:

  Acked-by: Chuck Lever <chuck.lever@oracle.com>

Given how late it is, I would postpone it until post -rc1 if it were
solely up to me.

-- 
Chuck Lever

