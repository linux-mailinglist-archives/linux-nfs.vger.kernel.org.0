Return-Path: <linux-nfs+bounces-8968-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EB3A05CDE
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 14:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712011669D9
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C405A1FBEAC;
	Wed,  8 Jan 2025 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cjVCCaM8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aXNJR3FR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40031F2C50
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736343224; cv=fail; b=J5vTL6jq8J8rKSzVuj2V3UsIZXvhMwNRw4VROhnikQUhZB12iqcUiwe5NmT0kfuYFQLiNTcr7WTF71HU1A957spxh2IL1yTZl+WuRKw8C/dY06UtUpYf+Hl52HEC9qloIQzFPV5qLUeeHwoYUccB96KBmxxtk18BX/lkWczWxVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736343224; c=relaxed/simple;
	bh=Bkn+SMjeCvsS6WH1yePz0hk7qP2IghFkU9ukuOkjQyQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kFwHBgksxYzVhWSq4DLDXXIow0OpqfjQPHuHewPfpqS1Y1/z9ncFGQC6+hWsymhXbsH2EwU6aVU685n00fseOgH6SVSVGLcRkEyL9QXp0Dd/CWIhFrBpzYINOc/6VHxWUKVxLLrY7YUYTeq154+l6qCmNKqpOds/ij/HIEdPllc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cjVCCaM8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aXNJR3FR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5081vT8o014689;
	Wed, 8 Jan 2025 13:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6ZQYs7I8lE3UwaS3IulsypP9Ud4GBqWEU4Uym1D3Y48=; b=
	cjVCCaM8kv8HKTaBenyHFywxJv4yOOAEtnPT6CbNsQMbtCl+9kjBRpuWwd43OEHg
	wrdxLTANZxK9stDuLWXM9Uhy/m5oqUfUUROr085j0KTGyghz0WPL5MOaz4qG/TxZ
	wwg75hSQY+99//eGbt6nf9Dzy+QBDbtVJA3QqRT9XW/2HhvN8VccNxsUYFf6FSYz
	XNakFnBCHnnEeWHTHC4ekyijTMgba4whCKSqz9UZdEhROzcMulSEZjSMCyWxINW/
	yWNGhW+bxb4tdUALuIW2NNwmYcl30qcpTbTVyxzZqMEeIctnhOy1CkWOAcDykSYv
	PyJULB3ffDctpt2NE3FO0w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xvksxhyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 13:33:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508BQJ80008547;
	Wed, 8 Jan 2025 13:33:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xue9k0hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 13:33:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hA9e/3ldKDV2VAvhqDauzxQigMbzmQN0vsfzEcQEV8AU0EnqdREkiBDqgkZcExDwD/u6gIE+x8i+QvTqIuHz8YLn9LzcRKeehy7DwB7LqIqF8wkIJzkFZJzAax4qrvLi4GeX09L+VtdnrgsDTs7tfNtYykDfAQGhgcMxR7ceN9kP0J6C402VimAL5AP2DKaVSp9fZK+mLKhlkZAWbSqgceBtlFWWH/zsG2gTWicOQax/BpQb+RB7fOrQDDT4xJQs6a0wXr4QI2Dmlm5nX5syCtlcbC3fMTaPyyXOTp1ubAN+/VCMKTPXOfGtURTKvuMHaIwkVCNN/970Nv5YhGSdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZQYs7I8lE3UwaS3IulsypP9Ud4GBqWEU4Uym1D3Y48=;
 b=X1TUW/cIh4doUhXy6IA/th+WL/jHrapIHliDkLbMRLAIdO404jdUCzLuWYrxN6r7wMsFgls92dyiP2hn5V9agc4fcYqdYXud2OGgDEYNyYtNwVJIb4oBDDW4Os2xxgpZLi1enJuNe/3XH+YLB1yKwqHT9tIykCVZwrnlzoSqE31HDzW3wqogcov5sVjGgPmPzueBvqHjVr4nypQoG8KYL1YqacOEogZFKor5F9M5iY4qIyrG4orC3P35n9aGUTL1Jfsev1Ib9StYK4x9L53u2UWoGPJQ4Cy2AVX6NOnRFyz4RdkKMv3QDKgrPi3DcOoZTzxh5Zkni5OD9vdq4bziHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZQYs7I8lE3UwaS3IulsypP9Ud4GBqWEU4Uym1D3Y48=;
 b=aXNJR3FRzc06Mh/ZvEOG3WMN2aJRtUnat2gkFAxf7vF57xptef8DPRGMX0ZsN/osouCvLX1reva6RH2vFIdodIbyI17rhJeO17OMS57hr9FQ1J1Pgmhhi/NlTppjuBpeEi3bISVrusOrhsBrbcUkIDYhbhCs6aDK03VURGUsepM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5201.namprd10.prod.outlook.com (2603:10b6:208:332::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Wed, 8 Jan
 2025 13:33:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 13:33:24 +0000
Message-ID: <3cdcf2ee-46b3-463d-bc14-0f44062c0bd0@oracle.com>
Date: Wed, 8 Jan 2025 08:33:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd blocks indefinitely in nfsd4_destroy_session
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Harald Dunkel <harald.dunkel@aixigo.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        herzog@phys.ethz.ch, Martin Svec <martin.svec@zoner.cz>,
        Michael Gernoth <debian@zerfleddert.de>,
        Pellegrin Baptiste <Baptiste.Pellegrin@ac-grenoble.fr>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <Z2vNQ6HXfG_LqBQc@eldamar.lan>
 <ecdae86c-2954-4aca-bf1c-f95408ad0ad4@oracle.com>
 <Z32ZzQiKfEeVoyfU@eldamar.lan>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z32ZzQiKfEeVoyfU@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:610:11a::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5201:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1e7c3e-22ae-4996-64cb-08dd2fe906f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEdjcjAxQkpzWjdnZ2tBSkM2WjdHS1ZDWVNlZE13SVNOekY5YVUwZWVLcm5R?=
 =?utf-8?B?UXpUdG1aRENEZkhlV3g0ZXZYZk5Kb0ZHNXFqa1NKazVraEJkNlVNME9JTkR2?=
 =?utf-8?B?ZXdYcndUWnE1TUc1U2JUaGJCM3kxSkhFL3NzNWJ3NDhEcTN1bDZKeVoySnpt?=
 =?utf-8?B?ZjhxTzNaQlRlRnY3Z2ltR2FjdjZqOHNSRG5WVnFuQktPbXVVSVdtVU1KcjZU?=
 =?utf-8?B?ejJrTGh3VU1qMnF0M3Y4K3pGVDhZbWx0ODZQVC8xc0dzRDdYL2xKQ0ZsUE1n?=
 =?utf-8?B?dXV0UE42ZUttRFBRck1uRjNTc28rZWsvRzhETk5uTDZmc2xnQk05VHFWQnZ6?=
 =?utf-8?B?ZUFGQ2lIZXpXdWhCRGRXUXdIcy9MVlFDUFlJVlZjRXFHRjVPRmNQdHh0MEQv?=
 =?utf-8?B?eHNzSG9tU3Z3cVpsSGp1REhzSjZmNFVoQTh0UGpqb3VFZSt3d0M3WEFwaUlt?=
 =?utf-8?B?SytyVkdpaWVsdS9TblZkdGRhVXUrNmtBMlAxdXFrTUloU3ZkUENQM0pwRTlM?=
 =?utf-8?B?RytpQnpzcnZlQzR2c2NweFZxa21vaU5zck5BUENITnVqb1BCOWJZOVVSbUtH?=
 =?utf-8?B?RGNpWXBYNGxZSEZ5QStKdU44TnNpZUtxbGtMQUJJa3R4cUJ5ck80b0U3TXB6?=
 =?utf-8?B?L25hci9Rak9YTHdXQ2Jvcng2NWlBdWpaYzdYaHNaNVZxT21rakJsOWJFSXY5?=
 =?utf-8?B?clVTb0I4Y1RXZDE2MW1hK2JiUG42ejIxSWpyRjc4Y0kxVVg0R2pIT3BpSVQ5?=
 =?utf-8?B?Mnd5U2FvbjM1UEJ6dmFiaEE5SGJzaG84TmxzbllnajhUVTZwUU9LSWJZQmxR?=
 =?utf-8?B?SS9SZXBxQXJ6VHJocVY0djJNdENmbzFIK2daKzhKdWQ3SE8zUE5MUnhCVWRJ?=
 =?utf-8?B?OGhURkJ4R2xRY0xkOHpUOGw4MW5HNHRjTW81blZ2bFVUTmFMTGtOMUo4cTA5?=
 =?utf-8?B?dFFRMDRFV2ZwQitNVmFPY0tTZlY5NWpXMVc5LzlOU2xGTDVEaDY2aTRpV3lv?=
 =?utf-8?B?bkUxdTlnTFpxbk1YTncwK0JVZXYyQXhJdEdMZUlPSGhEZDkyZFJVK1ZmeThq?=
 =?utf-8?B?TFVwdDc3VTc3cFJ2aHVMYnhIR1o4dTByblBTQ1VxWTIrK3BUZUxOdUJvaktB?=
 =?utf-8?B?OXFicVNqemd0OEhuaFFsVHQ2cVl1dlJBRWVsZElXQzdWVjNYSENod3B2bGd1?=
 =?utf-8?B?NlpwNkpMSWNLQVhsWDcva29ITUZCQTRnbWFBazRBbW9seDV2MDZWRHNPRmFs?=
 =?utf-8?B?c2twSFJNcXZ4WFpjT2ltN1NZaXNFTWtYSUdEV3BSZXV2Sk1tQUZRUnA1NTcr?=
 =?utf-8?B?RXBvSlVjR0hKUlp0K3JCcEUyQm0yWFFJWGRHR2hycjBmT2NyYjRldlhocXBK?=
 =?utf-8?B?WVlZdXpja0VUUmpPcjJ6eU91ajd0T3lxYklEWDZlRzMzWnI5S2p3SnRORlZm?=
 =?utf-8?B?MFFmNmt1eWwxdkdoWFJOcHJySWg4ajRxdnYrcEpQTThVdjVoSlVVZU1JMERK?=
 =?utf-8?B?ZkZXS0JkUFZqN1QwQXJVSDR6eXFWbVRQS1loaGpLNEsyTUhQTG1qS281OUww?=
 =?utf-8?B?c2srME1ac1B3cWJwTXVJS2ZUamZUVmVSdzJzUUtnYjVoamJFaGlMbmhzWk9N?=
 =?utf-8?B?UlhUOU1vZ2gyVm1ST0Jmb3BSVFFxYjlaL2NROEpSRnZGM0ZzekFZc1JTczhx?=
 =?utf-8?B?MVFaMjV2V2VBVDNZaysxZEEvNTI2QmswczhiUWM4VVZZUVJYSElQb2tKUXhz?=
 =?utf-8?B?UzZsdkNaYW1zU0VMc0dSaGFKYlRkVkd6WEQvbFM3S1c0UW96Zm0yMWE4b3lx?=
 =?utf-8?B?d1VzVFFJVHhiUEYyKzA2dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHJCWnhlTzlUeTJwcEcvSStsOFZBL0dPU0t5dWtUMThBRExGNlo1cnN5T0lO?=
 =?utf-8?B?MDhCRjJEMEo2MVlYNEVZK3AwRlY5aUtLemhtMStzNHl6akJVYmY2WWxTbklT?=
 =?utf-8?B?dTlySDdOQjRJTEN1ejZmNnc1QlVxUThobVUrZ2Joa055RVlBeER2djdBbWth?=
 =?utf-8?B?UEh1S1hKTEZGdXN0c0tWSSttQVgvMklsZ1Z5WlNsTytNU1B1Wng0aVJIeEcw?=
 =?utf-8?B?Z1QrYTdlYlRpeTJzcWdSMU5Lb09ENThOSmVTYmIwS0xQVjdYTnU1VDRTVzY5?=
 =?utf-8?B?QWsvZFoxa1QyYitBZktPcksrN2NMVEZDRytkS2Q2aEUyazRsUXZ1b3hibHJ1?=
 =?utf-8?B?WjRPWWVZYkdkNkhhWkpsU1RZcTkxalA1VXp3dEJkNlZQL09hdXNaWGp0M2Iw?=
 =?utf-8?B?QTdQeVR2WUhwL01EL3lBKzcxZlRHT2VRUGtKMjVYeHVvZ2FOSFUxdjhxN25N?=
 =?utf-8?B?Qk4wNCtsZWF6aTZFOU5CSjFobVVYVW15UzR0TndFcVgxWUttWSttTW5DTVJN?=
 =?utf-8?B?Vjl3dUF1UFFZZEg4dW5HNkpqOTdWK0Q4akpuZ2wrdzFBZlBxNVBMaEJibDBM?=
 =?utf-8?B?NTl4ZW5NbENOTTVBN25iRGE5akVzdXAwaWovbjRQcjEvZ1NBWGhvbUpKZlNH?=
 =?utf-8?B?cE5aUktxdEl6VitjdUZRRTh6V2lVN25OaG1MNmZlOTBIZHNNTXlpeVVpc0Yv?=
 =?utf-8?B?MHdqVzVRTVNGYUppb2puNmRkV0gzQS9wTEp3ZlJ6RVVaM0paTk9FL2FYa1g1?=
 =?utf-8?B?TmJsY1VQQUFjR2ozVXRDUlRUbjZ5VU96OExhamdKQjgwdi9WWE1sMU1hMkcz?=
 =?utf-8?B?a21ydWZXNmxSS0hHaG1zNkhYOXhDVTRDdFJVVlZuVkFvUTBjUFhYbUk2cEd6?=
 =?utf-8?B?OVRocURsR2xGUE1JQWZSMmxxVFBkSjM0UC9QcENpaHhWZmRzMEtsdXFoZnVX?=
 =?utf-8?B?eVJ6SGUzemFVNFUzZkN4dy8xQ2Z6dTZPY0JXTzMzVXVNeG9jS1NhTDV6MlVu?=
 =?utf-8?B?RDd3Q1JjclFFNGRDS2MyaHRMS1dDbE1TNjZURjhkWkxEb0VLWFlOclJUNXMz?=
 =?utf-8?B?S1FKZHU2QVNFK051SklTeUY1bkVyT0MyTm9GcTR3cld5S1BGeWV3SFp3WUs3?=
 =?utf-8?B?Ui92V2VOaDNCWlJITmVWSXR6Yms0MlZqR0YybjluT2xEUHhwcDY1N29ROEVT?=
 =?utf-8?B?alViOGdGbXJURjE2ZGJrTEVRVDNqL3RmTDJubm51bHFLVjBkdiszd2pmNHRp?=
 =?utf-8?B?aHVlcjNlN0dnUjhHbkZ5YUxhWHFyRWtObnJmdFEzNVQrcllYbXpBSjJLaVBD?=
 =?utf-8?B?NS9rdVYvMUN2ZHQxUTN4anRFRm1PWStKdUJiWGNGeUZzN1VoQ09kZTFIKzFE?=
 =?utf-8?B?Z1ZSNDNZSWxBc3MvWTFZVDlzbERLMkhrM1ZTMktEZk93S3dLbjdBOXgvaXVQ?=
 =?utf-8?B?WVdWSitZbmdoZDdSNnVBbWhZWlpNd21Ra2xtSUhaZ01yYkc3a29BY2xua3RC?=
 =?utf-8?B?Y1JQYnVBOVZFeHEzUEg0Z0E0NTB0Slh0cThyTHBSa2NhV0FOcTJPbXZrRDFt?=
 =?utf-8?B?TzJLUXAwUDJwOGR5WGJ2Rjk0MHEzU1hsckppR1JCUlBQZkdINVZhbVlyLzIw?=
 =?utf-8?B?cVZKcXliN2JuVWhzbTRhQzlNajBhUEc2MlZsNnUwbTFoV0tBRUpzTkZ3ZHRj?=
 =?utf-8?B?SnBVUkM5QWRteE4xOTZLTnU5Y2N4a09WeWFQd0VCVXl4Vjg5cllLYWl1amgv?=
 =?utf-8?B?VFpuRkhUc210UjFoekljaEEwUi9VSFhHeU1NbHRVWmdISTZNdUNqaEV1TG55?=
 =?utf-8?B?OVphUGo5L005cmhkbzZlTW91cVJuelhpMitmbzV1Tkwxa0JjZW1NNlptSHZo?=
 =?utf-8?B?cTVZTTBCRGp0L3M5eER3RnIwNmdjZFN4OXFuQk53UTBIU1M2ZGZTNDVMZzgr?=
 =?utf-8?B?Y0k3WXpnRFNFcWhneFVLdFB3em9LdUdSbzd3NGxHTWFMZCtZNHc4dTJsNnhC?=
 =?utf-8?B?K0pkbGZna2hkcjdVc1FvaENYTjN3Mm5yWkRTU0xyRDRiZXI0ditENEdtQW9o?=
 =?utf-8?B?UU1KcWtKRm9XTFVTcGRXSHNZWktyeGozK0ZwNXJWS3lGODE1L3dJN2JIaFl5?=
 =?utf-8?Q?sDGOYhumDkBT2wTKje1msLhoU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LGYQ3vo6p0WYyeY20n4oYtwdB91Wx7HEQ9ru/NID45VpiND+Qmkgjm3WFCbtHZ7WkCqUJz/W/jPUm1r9AipueFACVCqoSbSRwngpe1q6hdti5eHoyVhWF68WuT6UmU/lHAqaM68+sr6l/B1KljFU4LkQzhA7w3Y+hi7vp/HIc13IyAtU+PiwkwJRoSMAXwksZJt/AVfWQWVoEEYcCg1p+CBvwWmPMycIqIMtBo7JKjnLtzM6VxHZwJgm4hrowXN+AUIwxLl8VehG6jkQEBsc6SBerDrpajoFSVXeVv7kjcXzCULEjcSlQN9MeEE1G+x254tj6OUSWJfTWiMzT72GGPJvV8Iszu698mW2Kwf50hUPyyqBsC98FHkKW2miI4Wmngap4GknwulZ7TEFvskb01iGCbmfzoBHKH197eCYGyLiaBRut188R2CCVz3zBvUe28PY6dywYBgbPSEMzvAR7yL4PmwJYj8vrprsgT/McDKR5nOSR2AbVkm4gNVlT/wKI5Dmr/tJ/LleFN9TfFikBCpxIMrsCt/ABl3o+tNYBUv0PaBjoTZIZ9HqlkC03W0j9oz6SYp9shRn8fEMHI4qeJYZ/sLSQWFjMhRWc+DoUew=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1e7c3e-22ae-4996-64cb-08dd2fe906f8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 13:33:24.8649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwQ7x6QccRorX4I91acrnB147hcw1F1j/HOekhAuSlbnCYNrN9qFQvJhavcAbMtRt0nkKxCgFSItIkPKogWSXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_03,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080112
X-Proofpoint-GUID: UIagMClzmHAoX7y3fLcgbYbnEPq_Ok2C
X-Proofpoint-ORIG-GUID: UIagMClzmHAoX7y3fLcgbYbnEPq_Ok2C

On 1/7/25 4:17 PM, Salvatore Bonaccorso wrote:
> Hi Chuck,
> 
> Thanks for your time on this, much appreciated.
> 
> On Wed, Jan 01, 2025 at 02:24:50PM -0500, Chuck Lever wrote:
>> On 12/25/24 4:15 AM, Salvatore Bonaccorso wrote:
>>> Hi Chuck, hi all,
>>>
>>> [it was not ideal to pick one of the message for this followup, let me
>>> know if you want a complete new thread, adding as well Benjamin and
>>> Trond as they are involved in one mentioned patch]
>>>
>>> On Mon, Jun 17, 2024 at 02:31:54PM +0000, Chuck Lever III wrote:
>>>>
>>>>
>>>>> On Jun 17, 2024, at 2:55 AM, Harald Dunkel <harald.dunkel@aixigo.com> wrote:
>>>>>
>>>>> Hi folks,
>>>>>
>>>>> what would be the reason for nfsd getting stuck somehow and becoming
>>>>> an unkillable process? See
>>>>>
>>>>> - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562
>>>>> - https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2062568
>>>>>
>>>>> Doesn't this mean that something inside the kernel gets stuck as
>>>>> well? Seems odd to me.
>>>>
>>>> I'm not familiar with the Debian or Ubuntu kernel packages. Can
>>>> the kernel release numbers be translated to LTS kernel releases
>>>> please? Need both "last known working" and "first broken" releases.
>>>>
>>>> This:
>>>>
>>>> [ 6596.911785] RPC: Could not send backchannel reply error: -110
>>>> [ 6596.972490] RPC: Could not send backchannel reply error: -110
>>>> [ 6837.281307] RPC: Could not send backchannel reply error: -110
>>>>
>>>> is a known set of client backchannel bugs. Knowing the LTS kernel
>>>> releases (see above) will help us figure out what needs to be
>>>> backported to the LTS kernels kernels in question.
>>>>
>>>> This:
>>>>
>>>> [11183.290619] wait_for_completion+0x88/0x150
>>>> [11183.290623] __flush_workqueue+0x140/0x3e0
>>>> [11183.290629] nfsd4_probe_callback_sync+0x1a/0x30 [nfsd]
>>>> [11183.290689] nfsd4_destroy_session+0x186/0x260 [nfsd]
>>>>
>>>> is probably related to the backchannel errors on the client, but
>>>> client bugs shouldn't cause the server to hang like this. We
>>>> might be able to say more if you can provide the kernel release
>>>> translations (see above).
>>>
>>> In Debian we hstill have the bug #1071562 open and one person notified
>>> mye offlist that it appears that the issue get more frequent since
>>> they updated on NFS client side from Ubuntu 20.04 to Debian bookworm
>>> with a 6.1.y based kernel).
>>>
>>> Some people around those issues, seem to claim that the change
>>> mentioned in
>>> https://lists.proxmox.com/pipermail/pve-devel/2024-July/064614.html
>>> would fix the issue, which is as well backchannel related.
>>>
>>> This is upstream: 6ddc9deacc13 ("SUNRPC: Fix backchannel reply,
>>> again"). While this commit fixes 57331a59ac0d ("NFSv4.1: Use the
>>> nfs_client's rpc timeouts for backchannel") this is not something
>>> which goes back to 6.1.y, could it be possible that hte backchannel
>>> refactoring and this final fix indeeds fixes the issue?
>>>
>>> As people report it is not easily reproducible, so this makes it
>>> harder to identify fixes correctly.
>>>
>>> I gave a (short) stance on trying to backport commits up to
>>> 6ddc9deacc13 ("SUNRPC: Fix backchannel reply, again") but this quickly
>>> seems to indicate it is probably still not the right thing for
>>> backporting to the older stable series.
>>>
>>> As at least pre-requisites:
>>>
>>> 2009e32997ed568a305cf9bc7bf27d22e0f6ccda
>>> 4119bd0306652776cb0b7caa3aea5b2a93aecb89
>>> 163cdfca341b76c958567ae0966bd3575c5c6192
>>> f4afc8fead386c81fda2593ad6162271d26667f8
>>> 6ed8cdf967f7e9fc96cd1c129719ef99db2f9afc
>>> 57331a59ac0d680f606403eb24edd3c35aecba31
>>>
>>> and still there would be conflicting codepaths (and does not seem
>>> right).
>>>
>>> Chuck, Benjamin, Trond, is there anything we can provive on reporters
>>> side that we can try to tackle this issue better?
>>
>> As I've indicated before, NFSD should not block no matter what the
>> client may or may not be doing. I'd like to focus on the server first.
>>
>> What is the result of:
>>
>> $ cd <Bookworm's v6.1.90 kernel source >
>> $ unset KBUILD_OUTPUT
>> $ make -j `nproc`
>> $ scripts/faddr2line \
>> 	fs/nfsd/nfs4state.o \
>> 	nfsd4_destroy_session+0x16d
>>
>> Since this issue appeared after v6.1.1, is it possible to bisect
>> between v6.1.1 and v6.1.90 ?
> 
> First please note, at least speaking of triggering the issue in
> Debian, Debian has moved to 6.1.119 based kernel already (and soon in
> the weekends point release move to 6.1.123).
> 
> That said, one of the users which regularly seems to be hit by the
> issue was able to provide the above requested information, based for
> 6.1.119:
> 
> ~/kernel/linux-source-6.1# make kernelversion
> 6.1.119
> ~/kernel/linux-source-6.1# scripts/faddr2line fs/nfsd/nfs4state.o nfsd4_destroy_session+0x16d
> nfsd4_destroy_session+0x16d/0x250:
> __list_del_entry at /root/kernel/linux-source-6.1/./include/linux/list.h:134
> (inlined by) list_del at /root/kernel/linux-source-6.1/./include/linux/list.h:148
> (inlined by) unhash_session at /root/kernel/linux-source-6.1/fs/nfsd/nfs4state.c:2062
> (inlined by) nfsd4_destroy_session at /root/kernel/linux-source-6.1/fs/nfsd/nfs4state.c:3856
> 
> They could provide as well a decode_stacktrace output for the recent
> hit (if that is helpful for you):
> 
> [Mon Jan 6 13:25:28 2025] INFO: task nfsd:55306 blocked for more than 6883 seconds.
> [Mon Jan 6 13:25:28 2025]       Not tainted 6.1.0-28-amd64 #1 Debian 6.1.119-1
> [Mon Jan 6 13:25:28 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [Mon Jan 6 13:25:28 2025] task:nfsd            state:D stack:0     pid:55306 ppid:2      flags:0x00004000
> [Mon Jan 6 13:25:28 2025] Call Trace:
> [Mon Jan 6 13:25:28 2025]  <TASK>
> [Mon Jan 6 13:25:28 2025] __schedule+0x34d/0x9e0
> [Mon Jan 6 13:25:28 2025] schedule+0x5a/0xd0
> [Mon Jan 6 13:25:28 2025] schedule_timeout+0x118/0x150
> [Mon Jan 6 13:25:28 2025] wait_for_completion+0x86/0x160
> [Mon Jan 6 13:25:28 2025] __flush_workqueue+0x152/0x420
> [Mon Jan 6 13:25:28 2025] nfsd4_destroy_session (debian/build/build_amd64_none_amd64/include/linux/spinlock.h:351 debian/build/build_amd64_none_amd64/fs/nfsd/nfs4state.c:3861) nfsd
> [Mon Jan 6 13:25:28 2025] nfsd4_proc_compound (debian/build/build_amd64_none_amd64/fs/nfsd/nfs4proc.c:2680) nfsd
> [Mon Jan 6 13:25:28 2025] nfsd_dispatch (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:1022) nfsd
> [Mon Jan 6 13:25:28 2025] svc_process_common (debian/build/build_amd64_none_amd64/net/sunrpc/svc.c:1344) sunrpc
> [Mon Jan 6 13:25:28 2025] ? svc_recv (debian/build/build_amd64_none_amd64/net/sunrpc/svc_xprt.c:897) sunrpc
> [Mon Jan 6 13:25:28 2025] ? nfsd_svc (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:983) nfsd
> [Mon Jan 6 13:25:28 2025] ? nfsd_inet6addr_event (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:922) nfsd
> [Mon Jan 6 13:25:28 2025] svc_process (debian/build/build_amd64_none_amd64/net/sunrpc/svc.c:1474) sunrpc
> [Mon Jan 6 13:25:28 2025] nfsd (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:960) nfsd
> [Mon Jan 6 13:25:28 2025] kthread+0xd7/0x100
> [Mon Jan 6 13:25:28 2025] ? kthread_complete_and_exit+0x20/0x20
> [Mon Jan 6 13:25:28 2025] ret_from_fork+0x1f/0x30
> [Mon Jan  6 13:25:28 2025]  </TASK>
> 
> The question about bisection is actually harder, those are production
> systems and I understand it's not possible to do bisect there, while
> unfortunately not reprodcing the issue on "lab conditions".
> 
> Does the above give us still a clue on what you were looking for?

Thanks for the update.

It's possible that 38f080f3cd19 ("NFSD: Move callback_wq into struct
nfs4_client"), while not a specific fix for this issue, might offer some
relief by preventing the DESTROY_SESSION hang from affecting all other
clients of the degraded server.

Not having a reproducer or the ability to bisect puts a damper on
things. The next step, then, is to enable tracing on servers where this
issue can come up, and wait for the hang to occur. The following command
captures information only about callback operation, so it should not
generate much data or impact server performance.

   # trace-cmd record -e nfsd:nfsd_cb\*

Let that run until the problem occurs, then ^C, compress the resulting
trace.dat file, and either attach it to 1071562 or email it to me
privately.


-- 
Chuck Lever

