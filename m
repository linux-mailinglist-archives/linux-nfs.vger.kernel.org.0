Return-Path: <linux-nfs+bounces-14216-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97877B51B27
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 17:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344581884A3A
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 15:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D95329F3C;
	Wed, 10 Sep 2025 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qd4rCZUL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IoAulHza"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D1273D67
	for <linux-nfs@vger.kernel.org>; Wed, 10 Sep 2025 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517043; cv=fail; b=RZuN8RGtm/OOjIf4k5uj9snQYt0n5Sxe5W0dpKi9mzgNXeM3tLwjOzVOM7ZCKMn3WAbBQEkJxWcdgJFD5qq10m/SQ19YS9hGT4kpekehyIc031zpOC0/dhf046cavtR/nsRsVssniU0Xdd49Nlr403YWjqTM7R4kT8R4+bTc7XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517043; c=relaxed/simple;
	bh=Km1++zYdVtdm71gIONv/bXrutjr9evzMd2NFSJrbb5w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dg04MOyPKvJ4T+Bkc9WmZL/xBb5fFnCWDvjdWW43ZfsFwQ/BqQjQj7QhawywCuomKJvTNrobmifBozPNS7Y5gQs76EPOyDMvxhm4QxZjKVTvO8Ps7OKy+HUMJ097a+pIZAutGORWcjGr5tG+vqTAJHSO6cLQNE1kISuWY7sIE0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qd4rCZUL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IoAulHza; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ADC0Bu004341;
	Wed, 10 Sep 2025 15:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FUpPkLJNF4nqVnOGLCGZx8qUgn33HtQOii61XUOdQTE=; b=
	Qd4rCZULVecknN2Y7JTdXtupAFKeShBvF3xseFfTX+7WlsGc/6ImI0SV4xmFvQGk
	SQVYYFj03SSIdmtGc1Q3OfZyyV8LPUfdGgXE3gRe10bzNfiHJrPFVwNDqjyVCDDB
	tV1FafAqo9rOg9yOCFOwXinEtHPN4/v1Raj7pIXeCeVC/4Qr2S5FJGb0jQcxZ5KA
	3NH++7xfzwtA29a4mhPF18goj8xJlZwd/OHRaJeH1/dg+ZEaqBh9+v7gaojaluUh
	cVTqukbLueCITwnF5/a+/yNqySOoeGZkbCoQF8Zv4MPccLSD/vxb+zm7WBM8nbrW
	WlVEJZ/x/+W+sqiQDb+89w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921pecevn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 15:10:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AF2LQc030711;
	Wed, 10 Sep 2025 15:10:27 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdb47kw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 15:10:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jH+Wwj6ZNv3LUoKP+ytuac9MEaHAo9Q3a5waBli/ygs/tCFEat6YDbgDmqnZAWhQ8bqc+ereObA7/ePxUdKE0L8YJ6UCiU22VsYPEATlMQthH3cg+Vx0qNetP47kZMPPfR2tzM2jKb1Te/BAIcjltoYEp71Xp5gArmwPC733xrksvP+u3Gr4fxwfEC7qpBgdc8QjjQWTQnmiVN6iXIUrtakT4ElDXzMLHNdOqjmEaIwgjTpB1nmg1FG2m7zXcE4943WWh+nGctDbKlxCq0qQEJUJRd1ig1YBgPqhN5jBOIiggdE6GZun8xbdWfv5ec7Nj+qpthPHXwgS9r7q5V28nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUpPkLJNF4nqVnOGLCGZx8qUgn33HtQOii61XUOdQTE=;
 b=EEzIR8CBAs16G2XYd0daJ2wJ5QGuaKBMCe7tzvj5iggkKh6gvKuO/d7GxuZcW5+U0PMhm6sw6RdpQ9q+Oc3TASCHICcrzqivSp0hayTgQ9am9ZHUI9cDBSFzb0p3JOUahMBHFeOu9I6WLwRQd+jv5IV89+uGpulrun7ZnmlrXdP6uYCvUBliHix+pfaNFXUxKWXWdrf8vIqrLK8U0KV8lnrenjOl9/LYG5nEjjQ/qwyDFpK52yb8OtNYCElNtUG1PIef5Cl2yg3CNMHz7VJaqIMOBSjAeC1oTv17g/k4URNLqxigb4qc8QjBosm2J6ZVD+tQi3ZQgz06rwOAZNYWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUpPkLJNF4nqVnOGLCGZx8qUgn33HtQOii61XUOdQTE=;
 b=IoAulHzaeho+DOiB2Y3B204GkwykOWcF9kdzvaiwUoo5rooy89vgb0DuVBLAGmMr4DKzZao8tQZqmqC6aGmPrH287NFQmANvjQma0dXcXGGYjc4IDITQB0/81OZ9hvPMHhuqIXQvD8sea4pUOIvbCtvzXccvhP7yaE/Dk+EWa0Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6978.namprd10.prod.outlook.com (2603:10b6:806:34d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 15:10:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 15:10:19 +0000
Message-ID: <08216553-b703-48d1-a321-22079216ec5d@oracle.com>
Date: Wed, 10 Sep 2025 11:10:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: client can crash nfsd4_encode_fattr4() by setting bit 84
To: Jeff Layton <jlayton@kernel.org>, rtm@csail.mit.edu
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
References: <53032.1757512512@30-10-113.wireless.csail.mit.edu>
 <f4b122ca21ca772ea66d2f5b335cb751d116c3dc.camel@kernel.org>
 <0f0c9878-b45f-49c1-b9e8-9ee4b830d51e@oracle.com>
 <7dcc3c5228fd4fbe7f9d7746d2fd0f99c6dc3a99.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <7dcc3c5228fd4fbe7f9d7746d2fd0f99c6dc3a99.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:610:59::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5fa835-5eab-4c06-318f-08ddf07c2811
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Nk8yYXZ3THdXY25xWlBRN0dhVXJyL1kyU1hTWGVPMEt4dlZ1QisvaVhqWExH?=
 =?utf-8?B?cTQwRHlQaHg2eVQyVXk4bjJ0OUhSNkpONitzUzkyNlU0dXUrQnVZRXI2bEZN?=
 =?utf-8?B?WEpJaXBWVWJxaGJpNDhCUENxU0MzV0hTcmUxcWJFVi9PblcvcFRoWGY0YmNs?=
 =?utf-8?B?UEFmclpZN3k1Wm1LRmZiRVpQWTdkMUJwdHByS2dtUlo3NFJuQ21GVkdkMG5m?=
 =?utf-8?B?RWlNSm9UbG10aHdDTEl1QVlCR1dqR29zVDhUOVdUUWtUUUtwSFp0R3IyMHdP?=
 =?utf-8?B?UGFlTzdlWUdXeCtWVlR4SDJjV0h2RzQ0am5rN2tENEJjaU1rbUpVRkpTL3dG?=
 =?utf-8?B?RG05WUpVZklsdjJWTk54ZmVSekFwZjMvZ0pLdjZYSnVTUkFZOExySGFyUHhr?=
 =?utf-8?B?S2IzSXpOVC91RWsrVXgvZVlrcFJhQnc4QlVwRFgyRlZ3enl3aFpkK1cxak9E?=
 =?utf-8?B?RjVJMktXUmFCdkRLaXdXNW5tYmtNK2puaUhuWU41V2NDaE4wN3BxRGE1YzJK?=
 =?utf-8?B?T2kxOW1sZ1A2elNXTS9jYnZGanlMUlNtL016SFcvR0U0b0lISU5sY0Ftb3ox?=
 =?utf-8?B?bFRUWjRVcTNaUHBRb3lSaHRCWGQ2dkZValprRUlLK3k0VklTa1FZTkVBTjNp?=
 =?utf-8?B?d3lyTDM5akNmZWcxbm1LSkFaWXpYL2hUT3lYTkpPS1Z2amdTd3FIOTdjZ0NM?=
 =?utf-8?B?M0M4eFJIM1Y2SWJVTTdLcnh0L2JhVktKejJ2QUlkZjZsbWI1QkdtaGxpeHdt?=
 =?utf-8?B?Q1h3NHVZOVdJRUFZTXVxY0FON3VxZVFkWmhaL0U4UjdDcXQ4ckdGdklRUEph?=
 =?utf-8?B?YVMrZ0tXTWF2SjJYVFJxTXBTbmd3dVVYM25HQ0NsQjRjUGJ4OExVdlNDa1RY?=
 =?utf-8?B?NVdWYWczNnY2S01EdVNySWhuaTdyYlVoejNrdllmRHZXY0w4QTcvTktEYkdp?=
 =?utf-8?B?dVpTaXM2eXF4eFp2M2VJb1luR2NpQUl4b1FNRDVXK01MbVg4U0V5WG5HV3pY?=
 =?utf-8?B?bFZDWXB6d05jeEJ0emNqSk4rMkc2T1FVWHl3alRvbjl0ZmxqVVByWkh1VW1O?=
 =?utf-8?B?QUtPSnFhNjV1S09sQkN5dUZMcENoeDlYc3BiellYY25TTzAzRm55UVM3NFNY?=
 =?utf-8?B?SzJiUnVrdXcxT0hmSnhnR0VMN3M0MlVDaVNPUXQrUHFZTlZNcGpUQVYwVHFM?=
 =?utf-8?B?OC9KZFlnNTlKYUE2SjdyMGlaaEYrMTU1ZUhUd2I4MCtoVjBIV3gwN1NuNjVm?=
 =?utf-8?B?RFFpWTN3cXp6YnhNQ0l2bU5jMlFHZnZtWmptWWNHdmFxMFJ4Z1crRmdUREpK?=
 =?utf-8?B?VlpzUVd0K216SjlzSElMcFltZGc3ampxZllveUpjRDk2aDFvQUdZZ1h0VjR2?=
 =?utf-8?B?MU40QzA4eVFDMlI2QVZHc0sxK3VlUlZ1UFMrZUYzZkFwUmJ6akFtWUV1VlJC?=
 =?utf-8?B?RnhrOThoRERLOTJqcG5Jb2dHdlQxYVh2SnQwMkgrTURUTmo2YzZDSC9TWDhz?=
 =?utf-8?B?TUxrdlZnWnREeWdrbitDRnNrUWo1WDQ0dTVKYjJ2empYT0lmK3hOTHdRZjNy?=
 =?utf-8?B?MHpJRFpndWVwN1NSdVlOa2ZWYmlzck9paEJMRGR3REFXTGlRQnVpS0ZtU2Fv?=
 =?utf-8?B?bEdBMk56dDFFZE5ZTjF2YVFTb2lOOWRTWkFEUmtFNzBLejlLaGd4Q2g2ZUtj?=
 =?utf-8?B?S2xIK2d5L1VPbUJ6M0lVZ2twSzBRSU1rQXVBRWJSWGE5UHVsMm85UnNvUnpm?=
 =?utf-8?B?YmQ3bUppZysycFpXaEVMeHN1ekorQkI5RERIUDFVTmQzT1ExNEpYUlY0K2Fm?=
 =?utf-8?B?RllFQlpVaGk4VHE1QndmZ3hSMXNNOWd1U3BxT29lT2t5M0xGY3IrRWErU1d6?=
 =?utf-8?B?TkxZL2Rhc2FiOHFyTTdwZGRxYjVIM1ZydlBVWU04dGhzVStTbnIzT0UwcGpB?=
 =?utf-8?Q?0Pb0O+xqtk4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Q0RWU1FtSDlNTVZlSjlGK2tkYzQ3YlpRb21KYXJ3U2tESElWWmVadmZWZUI5?=
 =?utf-8?B?bGZxWS9IVmlMTkthTElNTjlPS1F0d1c3RE1PeGV4Umk0ZzBUc0hoODVSb2ly?=
 =?utf-8?B?aUliRlJBVGNGR1hnTDNPaEk3MXA1Ui9xbk0vOFVjOUdkTTd0L3FGalF6TkZX?=
 =?utf-8?B?eHUyRS9qdmVHa0EwUlJSeGR0dUlHa0lnUTNPaW10dnVRbTF0YkR1YUVCYkJX?=
 =?utf-8?B?OFM0eFlxT1pram9YenkwVnFxdWZvUGpMUTVRQk5hZFZkQnZURWFhTXY3QUtG?=
 =?utf-8?B?dmhvNk53NDZUWmlwVmRqZEx1eTkzRHdtMEFSMkVvTnRJMlJxN2E3SkM3Z3Np?=
 =?utf-8?B?dmNocmFQOHRyNFpxblUyeTM5TVUzaTN4LzQ2bFVWcTZRc2tCelBFNGcxR0JG?=
 =?utf-8?B?d0krOWI0V0lCWEJWYUFyeXdwTHV0M2VOOUkzdlJJVjBVTVJUWDFGRzRwZXFG?=
 =?utf-8?B?SzAwT3FjVkI1UE5RbC9ud2IvMVR3NFFvUXVTMXpINlRVTm1NNVJxUHQ2THg5?=
 =?utf-8?B?NTArc0lyUWtZdDBMa2RxZkZtVUM5ekgycE9LTXVEMElMOGdzWUJUWHEwbXdI?=
 =?utf-8?B?WFRFZHhHWWJ6MUo1bVpkemhSd1hWcFM4MHVoYnMxdHRaUmxGVTB4NHZFZmVl?=
 =?utf-8?B?eW15MFBaVjMxN3IxUmJEVlVtUnN0eG9DdWFrRU5GUUVHVWxudHUvNk5GUk1I?=
 =?utf-8?B?ekNJcllCUDEvS2tkazZFdXB4VmpaU1ArVmRYWDV2NmcxNCtNdHNSak4rY0Va?=
 =?utf-8?B?bTJhTHh2a29KU092VWZEL0EzMUkvZ1REajgxV2gwY3FLZmR1N21UenFkTUN0?=
 =?utf-8?B?T05iS0QvbSttMm5oWXFUaFViWWpraHlaQ3E4dlE3TEU2WFl0eE9xMkZlaFR4?=
 =?utf-8?B?MXpWK2c3RGhVOHdXb00vemk2NFJqOW5tcHFFTmI4dHlMMGNnVGhDNjFhTDZM?=
 =?utf-8?B?SHo4aDJiWEZqdmJVdUw2QXNnaUNKUUdMN3FITzFsQnIvZkJHVlZ4ZUFXTU9j?=
 =?utf-8?B?SmVWTWwzUWRmdjBXTG14bkRLdVJTcUVFSWc2Z09EQ3cxck1uV3hRN0NRSlFX?=
 =?utf-8?B?RFVnY25jamJvOHRPbFh5YXdSbk9xLzNFTkVEaXNBMi9sekNuV0V5Z1lvUy9l?=
 =?utf-8?B?eXlnakZJaWRGSHBlbVU1WVRlOFJKbVJSVEwyN3VOMURYY0VZS0RGVFBsWUUz?=
 =?utf-8?B?Q3drczBrb2ZkZ0d0K0hXYnZJVkh3V0EzQ1Y3YnllNlF2K2llQU9Uc3ltMWVY?=
 =?utf-8?B?UHhONG9DZUpGZlhhYVRhREFlMmpGT2p3MGkvdTRhbUY2NGRVSFVibVNYSkVU?=
 =?utf-8?B?TnZRMTBaK1h1TFYvcHR0MXloQmRhUm9UL0c4c0hHVHZyTndZd3p0U2hsaVRL?=
 =?utf-8?B?UjhkczIyK3lRZklqeU9jOCtlZEFzTGpvT0hjWTd0Z2dwMmN2WXJuZlpEWTBR?=
 =?utf-8?B?NHBTUVRodEp1bjg5VUVHblVkdzZydFV5QWdtRFlseHNPeWx4Qk9scmFaSnVt?=
 =?utf-8?B?VUpHT0R3ZDNPNlVRbGMrZ1NNc2wzc1lvVVh6OGtsRzBTaXlUNFVpa3NDMm1G?=
 =?utf-8?B?OGtaaXFjNW9wRlROSHViNFpsOTQyQzZZcnRPejNGZ21sRnFTZlJJcE1WV0Ni?=
 =?utf-8?B?bEQ5RkJjcXZoUlV2YncyMll6Q0tRTTczTXc2VWptNVRRZlRoSDQ4T2IyNEw0?=
 =?utf-8?B?SWlNUk53N2dtWE1VSVNIbFJPc05MSklyVEVpWXZGcmhDY3RSbThMdTAxdHg5?=
 =?utf-8?B?VDRZUmU3dUlBNmRFeXlyM25PMTJDOWhSTHlmY29wTzdFQ3hRcUZCWFJXVlYw?=
 =?utf-8?B?TVNBSHRDSmxCMzVLWThhandud0p2YmRhMnpYQmIrRXJ6Z0FibHpQRHprRzgx?=
 =?utf-8?B?ZGdLL2pZb1lDaUpKelR5T0xQdktiZmtHbHhwWkZFUm0vV3Y2Wk5xb2JldGhF?=
 =?utf-8?B?T1VSUDJZdm80V0hydXRQSElDdWNkWlNBTDk2R3NOVWt4M1paYWRXYXRlUG53?=
 =?utf-8?B?aTdZS3N0YmgzbENTeXU5eGs2OW1hcjJ5UGlhUVdjYjJxaXdHMDdXYWZaS2RI?=
 =?utf-8?B?SUxUYWdYOEdCWlFFUkdXMGZhTUptMDZDZ1ZLQ1FhS0k5Zyt0czQ2c0ZRRVk1?=
 =?utf-8?Q?C1A53W9u51qxRB+AgqfPGZKUF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z5DYcoQLLGBx1dbYeSVM+Z9GvhwzyjhTzjk4YoyAFdhi0LeglEwcCvh4h7uecFJn1IH4neljYFsjlPIsC7BfXWh5fmpGgfh6U2HEmVlTRHhgM+W6sdztCmLjbF21Flxx/vU6LoIdJd3OsiGR3J7IuCO6hcWtuBzpJmtAUkWSsOFIsMrD3a3+TZDUxJtPM4B2tFDan2ktEkmHGCLlRJWGsMSs4YC/aYKLLqBkI06SgXQLR6C6QQYIAzJMBgPW70Le5BiJ+LBwA9UQ39TjjWiYevlwZzaSXzkbbdWgij/vM6lP4FaXIQF8rDQzaDm+nDEB2kt5e4NPSNEi1x9i2d63dhk8OvU65/o/Xd5k3CW+UIAdv42LOQI30yCt/9kfLJ/sUNdpUPDDHl3G1wDc/JJF1ukJSU2Toy7QYa0zB9UWJgTznW1X00UC8PxxJYUbFXWMfPlwea+ZtsTr3dvobZr9XLhn3tf3PEZegyCZkAD6JlmFSm315Yp+QPqywoawY6b5m6jy5ZWJQo9PSY2TVaptQILYcD8vKRqeyg12D1h9GTRtByC4fXhAjxCxn45h1P4GUHSbV+Z6uu/MKzfRVOt/BZtodWIqW4n1mHruzZoiEJs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5fa835-5eab-4c06-318f-08ddf07c2811
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:10:19.8642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K31Z2EVU81987FvzZG/HO/7W3DoMbdo5udyv5AA+3wp07ULjVEkKwXPiBdEIW5fVvINPsofiAXlleRvQnidUUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_02,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=882 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509100141
X-Proofpoint-GUID: vl1jRZwTqjw__zqqw_dIBoqlkLSHEqHZ
X-Proofpoint-ORIG-GUID: vl1jRZwTqjw__zqqw_dIBoqlkLSHEqHZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfXyIHjphM1ZRpC
 fh6K7X/F4N/8rIc94wS7ZU6LsBGqjN/KzpBf081jye6pgF/yEQspZQ+je1oY9LheTT0j5/98nEW
 ka/LcsCW0WvTZ5Z8aWj4SmP6v0pi8UFFPpAhvcUNKodS26oWoVnMo5GzFbxOGJtOFn0C7gbt83X
 R/eBnngMcp4g86lFaXKO3xDIDiFg/1A/OLALmsqFIzypoGVVD1Lskm3wKg8xlI+/Hh8pfoe1lJj
 t13zvueUXLyyXxv8e9rgqt8rUrCFhAvYATtcIY6qlDso9eJNKJUEzplUyw1ss8YgtFPNTRwYU4f
 SAGrEyz/olRPR37hlbCkhGIXha1HwAbCJjPaITpqscxDC7ypJk06livq2sxo0SJCalSSoitraZU
 n+E4l11F
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68c194e4 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=z-Wz3_ggCtNy0W2wkjQA:9
 a=QEXdDO2ut3YA:10

On 9/10/25 11:08 AM, Jeff Layton wrote:
> On Wed, 2025-09-10 at 10:53 -0400, Chuck Lever wrote:
>> On 9/10/25 10:49 AM, Jeff Layton wrote:
>>> On Wed, 2025-09-10 at 09:55 -0400, rtm@csail.mit.edu wrote:
>>>> Entry 84 (and a few neighbors) in nfsd4_enc_fattr4_encode_ops[] is
>>>> NULL, so if a client sets that bit in an OP_VERIFY bitmask, the server
>>>> will crash here in nfsd_encode_fattr4():
>>>>
>>>>         for_each_set_bit(bit, attr_bitmap,
>>>>                          ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops)) {
>>>>                 status = nfsd4_enc_fattr4_encode_ops[bit](xdr, &args);
>>>
>>> Thanks. That looks like a real bug, alright. I think we just need to
>>> check that nfsd4_enc_fattr4_encode_ops[bit] is non-NULL before calling
>>> its handler.
>>>
>>> Care to propose a patch?
>>
>> 597 #define FATTR4_WORD2_XATTR_SUPPORT      BIT(FATTR4_XATTR_SUPPORT -
>> 64)
>> 598 #define FATTR4_WORD2_TIME_DELEG_ACCESS  BIT(FATTR4_TIME_DELEG_ACCESS
>> - 64)
>> 599 #define FATTR4_WORD2_TIME_DELEG_MODIFY  BIT(FATTR4_TIME_DELEG_MODIFY
>> - 64)
>> 600 #define FATTR4_WORD2_OPEN_ARGUMENTS     BIT(FATTR4_OPEN_ARGUMENTS -
>> 64)
>>
>> I think entries for time_deleg_access and time_deleg_modify are missing
>> in nfsd4_enc_fattr4_encode_ops...
>>
> 
> Those are typically requested in CB_GETATTR calls. I'm not sure those
> are legit to request in a GETATTR. Are they?
> 

I think GETATTR needs to skip those, and not return an error. So they
need to be defined as noops, probably.

-- 
Chuck Lever

