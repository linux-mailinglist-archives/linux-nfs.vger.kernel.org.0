Return-Path: <linux-nfs+bounces-12290-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A38C0AD4593
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 00:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A9D173D11
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 22:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3825728C2B5;
	Tue, 10 Jun 2025 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gHl6HSMk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gnmUQ7F0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE53288C05
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593041; cv=fail; b=aTc013dvsNZL/ZlwY/Efr5InjlXQ+WljrelnzGTN4/tpQFTgII/QgrE8hKtnwddg7J/i7HmsLxTbqCm7UQt5kSU9feXSgWQcz4L+4zE0PZEGudA5rEafhVHCcL4EVNafMomKyBnxkRKfYCtNzLwXxa3MqV4ogtr4cVSDm5vXJQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593041; c=relaxed/simple;
	bh=3gL0fW5IJoOEsNOr5pcJXp1/RNWSeVMQbQIWCuHCQe4=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DPJ8c+5P5YUyw9ORUJ4i6EMj1A6kBLOMIrxwE7GFtRwUpClo6W71YREva+0hMGNPu4POb+92VQZbv9htagQ97mpEkiBxc1mTePzJs8KeKPHmTxyM3kynikDm4OourAjGAqdhX9u5mkMk+50VEkeODhKz1DNdN2NqSKl4wGxK8hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gHl6HSMk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gnmUQ7F0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ALtYlt016759;
	Tue, 10 Jun 2025 22:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vhDhVONQYjIWZmz9otgFfOIJWsxsuMU4VWq6GQkEESo=; b=
	gHl6HSMkASQM2kqZi0QU8w5KA95ceHjCOclWU/Mb0Mz1vQay9hgp42ab8JmOVaW2
	yeFE0WUxu8zwfd2UYk2Y+MhmpLrafgPVmIzg9/cVnEwykvXp+wMZNWhj8n6JLrUB
	DIU8FNmipntvrRgNLoxTgkw+HhOzyPKG03ZIls84Q4etuQmbvhmUiiinCuRfvBWJ
	/G9a1HkTe2EnXKmOCqFoKmA4OknbXvDDLu/z9GJ1JvbOeFMeQBM1T3/wJBOI8Sv5
	r7IwyJdJ+NhhHJgXM4/2MvntDKzQuAbLc9YvMpQp+eqhqPkzZ77/qWhnwZhDoyYR
	qyHHaSrfmwSeAHsA1Kyi7Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474buf56jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 22:03:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55AKuEBX008873;
	Tue, 10 Jun 2025 22:03:45 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazon11011018.outbound.protection.outlook.com [40.93.199.18])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv936mn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 22:03:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HE1dD7rlYHogk80SRD4ddB/hrIVvGb0E/ebYgJs6zzIMEyAXV5mLCg4dmrtbV4er8QeIf5dgKQb4RnFmXPLZWJpaA+8ZrzCeU3hEZj/Uw8xyYnukP5Vyi+wPB9+y6+RPOhJ9/NToIAutfNZAoiV5ZUTkSFbkfGWVFddBSIKymReU84/l8MPaOUrM6FdkSsbPBk0vs+JwDnp7sOUoDKljRJp4AnQEUBpqc7VQJWzXk/37sE2dgrSjMVwTEj5SKJzn9ZFxMDVYwx4og6MCCPxJ/7aw32xEmTiJXbirWvhrzdT2dsF3y52kpbnqg/uS/Hp2eJwlfJfaa2OmBSrZ409JEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhDhVONQYjIWZmz9otgFfOIJWsxsuMU4VWq6GQkEESo=;
 b=LBD2t0ID7/q8XBvdFAilmUsfi1KuZNAu32kLqQBvSQuitJep5pdzpxmSFuzZDv0Q/50+SHYXy7A4qMAIZAyjBR66Rp06JUgZYnT7PXzf7E69TuMdKabW9WMj6OMudljKqAMzU+8VbcZZt126aXAwFArGjTJNrrLK8p8c2Ja3DqBvBrryCfyOgknT7i/xFhUgESFbqE0yy18sdKpaFaqSFFwIk9Q70dzRMonnZX99Mp6mf3TTjPQwF2Kgf+X11u8YiGqBaCbandhc8ef8aUUItJl5sRWOtrXqpwGO2IK88aa6Rq5qe/WNb6o84vkzQOY2zQjwYNfQds88NyxbI5nGuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhDhVONQYjIWZmz9otgFfOIJWsxsuMU4VWq6GQkEESo=;
 b=gnmUQ7F0a5L9H613n7SGbv04zQAhEp8Z56eR/0RPy4mojzKxvMlM0EUnCtNZXYhVh8/sPt+9BFajcqYvkh0SpC7ARmuRpXSdIuDgb++Mh/rYOTCUF29rdf523qJSU4ZfqVomxnj61pRGVmNGWl20Rt1HZQGlKPVyaTSgOJUQGRw=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by SJ0PR10MB4592.namprd10.prod.outlook.com (2603:10b6:a03:2d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 10 Jun
 2025 22:03:35 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 22:03:35 +0000
Message-ID: <97a02804-ae0a-4402-a615-1fd3c2e276f2@oracle.com>
Date: Tue, 10 Jun 2025 23:03:32 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: detect mismatch of file handle and delegation
 stateid in OPEN op
To: Dai Ngo <dai.ngo@oracle.com>, Frank Filz <ffilzlnx@mindspring.com>,
        'Chuck Lever' <chuck.lever@oracle.com>,
        'Jeff Layton' <jlayton@kernel.org>, neilb@suse.de, okorniev@redhat.com,
        tom@talpey.com
References: <1749562875-28701-1-git-send-email-dai.ngo@oracle.com>
 <f580a2f30274ca61f44d4b8d4b5e9779acd84791.camel@kernel.org>
 <6bc66030-adba-48c0-a992-82f7bbb153f3@oracle.com>
 <7993b2bf9c38041f8963e9161aaa25984b50d3f1.camel@kernel.org>
 <c187763c-09a3-4027-9833-a78244a4329b@oracle.com>
 <34500150-e2b9-4b88-acae-aebeb1694916@oracle.com>
 <11364da2-761a-4f67-9bb6-908e9d718f5b@oracle.com>
 <09eb01dbda17$6e4f8610$4aee9230$@mindspring.com>
 <03241ae7-7f58-48cc-b163-767cb348ddaa@oracle.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 xsFNBF8EmckBEADY7zXjHab4thpE0tJt04MQJYJKBt72eXTweUlzrny8e55IrVpNI6ueSzD9
 bmTRscSqXNgBHbxOxDpajZpELgLm5c6nXjrmc7H01jWvMbrXheWWYJqp3rAohb2TgKn3iU/X
 1JasxFPghPyAvPgvJkRVzBuiKpcg3iPOUId7Q6GNinXZvOKvEWaP7G5abVZUQOT4DTTCPDWY
 ENTDwEL8nonRCIw/ip26WBoFsuUrW981X/Vch46otvSZay5ewiBL/ZO45JxIJdtMglLGoEC0
 AVrTb3TU/EHMCO5GjoWPt9xxMixG/Wtl/8Ciz0PHnJGT4a0LcNgXYWdecIS0GsBxCznGcLnI
 NLYCdoY17DuUsFC3P7EBpiS0ew0hlHAJt/jjX2AjqI/GXptzUm/sc8td99of2ksYZ8O+vmgK
 As/mbNuPyvd6skTh8R8xEZZ9zGhNmGxPP7Xd/Eud3ShF9oqx4lTj0eZYy5oWzmLFTN1D1uBj
 U+aitbp9TPyPVgqxm57p430CY9EiRocvfarWTOEEswgorumrPQzdtspxtqCZd3AfN3EMvKT/
 YtBO+OQHW9ljZNi3VjBgeH7DlXBQDLaJh6MzqX3htRIDumPhTA0kMaQQahcGicoe6GP/Eox2
 m7fulWq8AGDpwufNdV4WOSt86D4h8orUCz5sctIDnxg9PZjzUQARAQABzSZDYWx1bSBNYWNr
 YXkgPGNhbHVtLm1hY2theUBvcmFjbGUuY29tPsLBjwQTAQgAORYhBNRgW60GIMfKPVXcPoUj
 7wBtwVPiBQJkkc1SBQkJT/ynAhsDBQsJCAcCBhUICQoLAgUWAgMBAAAKCRCFI+8AbcFT4plv
 D/96ncpPbwpw61mb1yDlyrJLpivpaRDHoTSAsJ1Ml+o6DkdIPk8VaGdtE1qMBY8fSF/EUsOI
 qBknBYGSqO4ORihswqYwFPoIUWXgvfzxjA5U2XJ9X6ofi4PLpDmuuYf57iMbDunCDNYzS6vw
 g+dblX9cmlBnms9vQ4oMaIGFB4UOxlXrUiz2wJxbPfL3Km7Vfnu1lvhXj2gadcVQJ0lRe3Fl
 nwYDzXxHEgWOkRKO5251NWSCtPpyWg7HXrwtWSndhAgq5WNV0+j6J3Qz/MotlysgeTRsfpdo
 ioGp4GSSELoQ2h0omgzMAugkvjhOHJJS2NQ107eThfecJJ7QPRVnZTpBY2uV35cesciGNmbD
 h1EKXn8A5VzkWDLf7u450lDcFUb4AXoc1W+1/22nCer1Hen0ZVVerSHAwV/VijVCEVrT7Dky
 zXoWSvte4ChM01/SY5vvU9bnlnRx0Ne3QiTPeb+ajO+M5htlGeLtP7uKTM4yJNj1qn8jFV9Z
 U28zUinmJfdjxTiGmVkiEPmK1bc6Y7WPi3xAcIjV4qnEOPjpndYaJBLNyuuPa48vf++RT682
 nofgpa3k308cGuPu1oRflNtGLpGHO/nsRsdRgRU1nKHr9UaoEDl9xjmPjdTSFDuQRGb1Olxj
 K44wDqhZmlP6caR1C5PxYDsm7VYJlCh8OB2Hs87BTQRfBJnLARAAxwkBdfVeL7NMa2oHvZS9
 LOy2qQO3WVN/JRmyNJ4HF/p33x9jwemZe8ZYXwJBT7lXErZTYijhwTP4Ss6RFs8vjPN4WAi7
 BkBU9dx10Hi+UrHczYrwi7NecBsD4q2rH4xs/QoN9LNJt4+vLzh9HqlASVa+o2p5Fs3TyNSB
 qb4B7m55+RD6K6F13bfXM84msz8za2L9dxtjtwOyOYFeoODMBhdkMourO+e2eSxOtecJXpld
 x1LZurWrq7D79wmVFw/4wP+MOAHKPfpWo/P18AfXEW9VD5WBzh9+n8kquA0C8lnAP9qRxtTs
 IAicLU2vIiXmiUNSvAJiDnBv+94amdDGu6aJ+f2lT2A5+QHNXb0QeaV2ob8wzCOOwZZG5hF9
 9zbS0iVR+7LgnJsoJYcKVrySK5oYfAFMQ8tUA102dZ6lHkVdRw77mIfbaXB637SAIxJGpwI1
 bDw3+xLqdqJW/Rs3BDSGrJRMPE1MnfvaAPfhqWSa9aFZ7wZPvO9sm9O5zO3R08COqCLgJxNO
 AVnJCw9aC5X1XzWyQvE3NA94Afl3KVAU1uxtgTpnwP5J05SllpSXeF4DpnH+sFX4+ZS4Cx+V
 96DgYY3ew6/SUGdMbEfJsqelCqz62vHguMA4cLIMbOnbh9CkGsYeJEURixCywgft5frUtgUo
 5StuHFkt4Lou/D0AEQEAAcLBhgQYAQgAJhYhBNRgW60GIMfKPVXcPoUj7wBtwVPiBQJkkc1T
 BQkJT/ynAhsMABQJEIUj7wBtwVPiCRCFI+8AbcFT4vFgEADQa03pwUyFOuW2gSiiEHA5EfvV
 VTAFOSaEO6vPGqjQBJFlNJ3lnkKhqWZNVN04QF/gMD6oZ9f4N5R8TMzPILloR63GTDCns0/r
 SIYaHE4T8OOmBx/vznygacaif5UVHs3hKxq+7ib+Jq/lxli5m9Ysa+lcbZhrNJftxf4BCqGm
 apdIfjniEnH/AXnYFro8U02WbE3vi2MiCunzpJ08/7NRfda7xVzsGDyohonNgu3UK3wdIDL3
 L0TaQYLgyAUIoZVOlAnu6G2DSStT23/4vkTdfC84EMVnUfixI552MsZGohLw8b+fiYUpzNKL
 UfQ1FgHObaQHlOnhg7CNDoLyoboAPfg04g9EHkz9DFzyyvb71olBg+CnSjDNkW4t4ZVfDGDS
 auwmk8dSYiKEq5DWQPrTCvovIdyfvyi3tb0ftjx5UmFFkXtmFsT4uHk8VV3JxKfXAiQAA4h/
 VXlAMWC8UjfPnz134MyB7HflfcdsEt7tWcH2D2yOeTqExQI+uPSd07SDh12eP/MV370xbRIG
 +K5591/cwhDpyIiIbqUTMDxQmH2G87jaAW1l9u7iZvaPCdg2HxqFBEWszJyONgIM1H4YvoBe
 FRB7zTVxmpqVkYS673d1UWIe4y3SQgl3fnN6pIUyWEgse0a3RZS7jJ0clsX1hKC7yZGDhHMz
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <03241ae7-7f58-48cc-b163-767cb348ddaa@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0405.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::33) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|SJ0PR10MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: d12de72e-f784-4a03-b5f5-08dda86aa55d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VFZkdkFpU2paWmcwOWNPTWw1NmZZd2twdVQwZkZFS3BPdnhmUnNsT3RRaGJP?=
 =?utf-8?B?VnN6RTdTT3d2aEZuQTlxL3c2Y29OWis2ZkgxUzZZaEtLb3cvZUVKMEVqUlln?=
 =?utf-8?B?ZVp4TTliRHpoQmVKQzFiZWJTQWMvK0E5Yjh0MW9SclBaZERsbXAvblFyVHpo?=
 =?utf-8?B?SnBGRnZNZ0t4VHFuTmxub05DWGNpODRUZ2cwVm9HcjBHbDhEUjdTNmpqcGQ3?=
 =?utf-8?B?Z3JwQUxBWHNHR2tqRXJXb2N6Rjhkczg0eWJPVFo0cU5tNmFHNTRRa0p1UjM0?=
 =?utf-8?B?RlBtdGpkTHRSMUF1VUl3cFZpRjdKWmszc0x5cTFRS2pZZy9TN0xlMTllYk83?=
 =?utf-8?B?aEFEcGZEQ0lSbmMwSXlHaGRHYm44THp6MUVzdUZuUlNHTzhNN0JHK25JVEYw?=
 =?utf-8?B?WXNrVGVZU3owcVYwcm5NQU94N2RNdnRXaDVoalJudkY2N3oxdlpzSWdjRFk2?=
 =?utf-8?B?QlBLOFlxbFJrN2pEbm5Jd1Z0MU9XTmdNKzRRYThPOUFqbW1ZM0trZmpQdDVo?=
 =?utf-8?B?NW16SHZra045QnBLWUx0ajU3NUlsc1F4SE02eVhUc2FDbWtYN2pPcVUxNUN1?=
 =?utf-8?B?S1NSaTJMMEw0Y05WNDBwU1BtTWZqKzg1cGI1YXRHSjZGUklMTW9KRjRlYSs5?=
 =?utf-8?B?YlYvOVV0akJObkdtV2QvemdLNDJCR05qZkc0aTU4Si9xSzVuTUs2eUc3TDdq?=
 =?utf-8?B?SWJ5QVVOVkdBVWRYMVgxWWxkeFBnSEhJUk0yUDhpWDVzazNPUWFQS0ZwQWdt?=
 =?utf-8?B?M1dYUzIyVURhNVF0VHgxZlZWbmVYSlkzcHBSVWhDSEQvaTJrWWZRNzM3STFD?=
 =?utf-8?B?cXNKQ0xkYXJDbTBiT1hFZ3dSTmRiTjN2RFZuRmlzVzlkM0Q4QkpFSElpaGU2?=
 =?utf-8?B?MGdYMWp4aDZweFZLTzF3NW1YdHB6d0hSWjMyaG42T1pKYWhybktHbytySytq?=
 =?utf-8?B?N0pPZE5jakhHajFVZGxZWUZIN2tyRVd5YkRIZ3FIS0tNb3ZtWk45US8wbXRG?=
 =?utf-8?B?NitOTW5KNit1LzZ6bmxVWGJpVGdYMVRaUjduWVFsaVJEanVTamxCYU11K25O?=
 =?utf-8?B?WmtZOTJ2N1Q5Mnh5UFU0Nk1qRUtMTHE1SDNzd0JmSlA3QjRQVURoWGMzb1cz?=
 =?utf-8?B?TkpiVDZLYWRoMEtJd1d5Z2FtRUZVN0IxYzZpRUMzQTlwTFZ1czV5Sk9rOU1l?=
 =?utf-8?B?ZDFiejVqcldEN1prdnZDOGFuRDVZaHBQY3dTblFJR0NZSTNWQWVvenlkV1hF?=
 =?utf-8?B?RFoxZ2I0WEQ5Zmd1djNsU3JTNXRYcUpQRkwrSUVFMlgxc2ZIbXhkNkNWalF4?=
 =?utf-8?B?Q0hsMTNFU3pKUnRRLzV1V2xDT1NrbU9wb2FCMHM3eXJnYys2Sk1oODc2NGJ1?=
 =?utf-8?B?bEY3elpvK1pmSzI0OGRtR3FZL29ncEl2anE0VGI5N0p1YktsYnhzaTRzQXV4?=
 =?utf-8?B?NmpreEcyenBDWjB2dUN0U3lkN2NPQ0svK3dnUnNpcTRNcDFVWnNtSzR2Zkgx?=
 =?utf-8?B?L3pNVlBvaGl6VHNJbWxtYnIxOEdCQ2czQlNuMGNCdzNCL3JSZC9kOWgxU1Qx?=
 =?utf-8?B?S3orU2FJYmNuaTFvMjllNlI3UzJFc2RXcXZ5TEhIYW9yRy9nTE5xWVU3RU5K?=
 =?utf-8?B?YkM3VWpkMlEzd0xKMlY4cWhtbkhpR1dTamxGZkJFU2wwaHRLZFRkcU5zRFpJ?=
 =?utf-8?B?RG1FZ3Bsdjd4dXgwY2ZuaVpNSlF6eVpYdlNBc1YxY2tYT1JZWXkvNVZXVUZM?=
 =?utf-8?B?VHZSeWdUZDl2OU1yTUNIYnhxcXFGMEFkQmxTNE5OamVUZ0ZxVlVnc0w1bTJw?=
 =?utf-8?B?bnJyWFIxSlk3ZjNldWt4bHF0SUsvWTR4N1NPMlpwVXR1WTR2UTFia3NzamMr?=
 =?utf-8?B?L09QbEZLV2RyQ3MwaXBXV3phVGNxVHZxeU9pRlhMZWRnS0V2WVZBVWR6UHVS?=
 =?utf-8?Q?kgJcx0XzCh4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?c0NMQU5iTTVnVUFCZzlUNGJ0akxJNWxzTTNjYXZMUW5xYWN6RnR1VE1IM2dY?=
 =?utf-8?B?YjVLZ1VSNUlvVHZ0bkZQcXVJRzJDbnVtU1gweEtPM0dGUkZBSldwQzdWcy9B?=
 =?utf-8?B?c2tEWlBPb3QxS21IcXZFaVNUR0lGcDRtTWZ4S0g0bTNDYlpQWTNvR21LTk9W?=
 =?utf-8?B?ZnVHTjUxa0NBZ3crOHdtaVIwcUIyWWNPSGFqeFhLUDJxWGViT3lvb3VNRGxY?=
 =?utf-8?B?SnE0WElOQ2hIMmVNNjVqZXhlSDZsUG5nWUVjdXlCMGZwVlVhMG5wZTVNRFFU?=
 =?utf-8?B?VmI2cFNjM1BrRWhKNFVlOTlJbXRDd1ZLVkdBQlpuR0c2VVgrMFcxUStOcGNB?=
 =?utf-8?B?VUg4dDFZQmJWdGhqWVpiNGIvdW1CaE42YTFrMHZqcjlPSmRoVzBONW54eUg3?=
 =?utf-8?B?aHc0UDVmdjNnMmt6bWJid0toYURYWjRaTC9oMVBicmVvTmFXSWtoRkIvQzRs?=
 =?utf-8?B?akRWcEN3M0ZSaENPNE9QSDZHMzE1WnF6SE5iQjRMNGhoNzdZanl3SCswdkFG?=
 =?utf-8?B?azFjems2SXBSR2RYZ0lDN1FaWEV2RU5BcXUwempmTTZGNndST25nNUlnKzVP?=
 =?utf-8?B?T3RFeCt4UExYb2VoS0lTNFdYcm9vT21PSXFENVh4VTZXVzNQRldBU1B4bnpj?=
 =?utf-8?B?dG9Jc0tVc2hRUzJlVmhzcnIwQllHWUVuSFhveWxaa2RjRm1hSTJkQlc5U1ZN?=
 =?utf-8?B?dmpUbWg3OHo1K2VhZys3dzBUSHFLc1dXc2kxNEV2QkZ3VGptR3NqcXk0Zi9S?=
 =?utf-8?B?QjRKY2E4aXBvSTJUWXdLV2JBVVpBTkpmMklZMC9LMjBCNlY4ZDBsQjFkOVZX?=
 =?utf-8?B?eUg5c2pTbjNORy91SGhNMjhHMkxOaS9tU25sczhRR2FLUUFWMmhJeXYxOHVm?=
 =?utf-8?B?c294MXpBRldXOTQzNlNWaG5HNlRRdWJDSnNVWG5sS2cvOXdwdXNjS2VzbVYx?=
 =?utf-8?B?UEo5V3JwcDIxQXZrUVN2cjRTa2VGQlJ1OVEySCtyZmxnaSt1RTJ0UTB2YzlO?=
 =?utf-8?B?SkM3amxoZllqdUUwK2VtMU1naytKNEl3d0c5bGo1TlhSNlBTakZIdXhrT2FS?=
 =?utf-8?B?R3JVWmEyZXFxdjY2QW5XN3BoU1g4UXhyU2s0eE1nYnVmK05VN3BvUUZmZG4x?=
 =?utf-8?B?NGFybE5IN3pjUVhUUE4vZnFITlN5UTZnc1ZWeVUya1FOOVcvamsvcjFJbFZQ?=
 =?utf-8?B?YSs2SzlvTmsxaHpOWXQrVTJTa2tkNGFxbmxCS0xWUjBhc2cvZlpxVzlvYjA5?=
 =?utf-8?B?SWhBby84ZitGc0NtZHhVYXZucGR6U0xKbEZuVWhuc2NCT1hocUJNT1hwd1R1?=
 =?utf-8?B?Q2NCYWk4ZE1XangvSjQrTW9HMzZaMnhZZDBnUmFRb2ozeVZLeVZhK1JLR29n?=
 =?utf-8?B?b29iRmRldTRaeVpHTGdpWFZzOTNKVGcrTytjSHVPcFNPaTlUSXpROW5JZmI4?=
 =?utf-8?B?dURVaHZFMjcvWklnUUR2VDdvYkxpY1Y0d2N0WnhsUE9aMWFxM3c3UzBxOTBF?=
 =?utf-8?B?TE5UVm50YWVKNHlrWTRXbjFoWHVHZmFKeVJ0dUh6NitZck56ZUxwMWc2aFZ0?=
 =?utf-8?B?SUNBNk5nTy9BdmtqRXdGcWJsMno3aDZIaTZlT3F5cjlMeWlwMVRKem5oeERL?=
 =?utf-8?B?T2xBOU0vT0RWekp1WFhDTEw1Uk5qYjczaHI1cmFrR3V3cGNWU1Z1UXVMc2dh?=
 =?utf-8?B?Rkpaa2tmV2J3TXgrdllMQklwM0dCM2RYcXpwcXRLa1d4cFV6RFozNTc5NTRJ?=
 =?utf-8?B?T1VCZDFnWEgvUEZLMGxqWG8zd3luVmVsblZjUUVuRzJTQ05tZkM2b0ZPSlJH?=
 =?utf-8?B?Y3VzOEs0bjV2OHZaM3lHdjNxN3I3UXduNUpRYXU2YmN6bXZ5NEFnOTV0TU13?=
 =?utf-8?B?VWw1QXk5Zmh3a3ZQR2V3dnpieDh0ekg4RERRNHd3bUYwTUV2djU4bWI2Zzds?=
 =?utf-8?B?NGpkQmM1U3RWTG9yRHFKV0QwVlZ6U0JRNE5rM2haOTJjd1J4QVR3d0RURlBr?=
 =?utf-8?B?SDJJUTZIcTFzUzZIVjRqNjNud2UzODZndkVlalB4N0N2Sy9pMzNFWDV5b0tm?=
 =?utf-8?B?d1N2Mlo2NUVxMnhDYlovNnkvLzF3b1BaZFNycUZoZ1hpYkFoZDJobFFyUlNh?=
 =?utf-8?B?QW5RZzZEVFIvZ05kK0J3eHJPcnlCM1pUT2tyNnFYUXovY1BsY2tGZmFZRWFq?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Sb7i8AKSluhLOh8foTG0JgJdyAPxS4JzsQ3BkS4BbQET7vzc1H2+rJUQyD3Fs5Dmuzwor+mpSfq+YSjO0vroAtfHpoMtjKuNRzlbN6wUcBOMcrVr/Uj0EA0iDE9pbcAZ7YTpiEN8l5m1qg+ISHVv7vrx/IkbQkzRFflI5aGeJ9dje8wbiHUT7A4zF99by+pjDRaB0cFYDf7PTjWXKus/YAjpX99u9Y6wq6d/uRXTSw8Nd9hllgzvpsU2llPOchuEprrFo/+JGa2tqjH2ImtOeJbnoQyr8tEGdiQn/3iJQ06vilhQD4wLTSEw2N51cdsvh3II0+k2I/V1+aFVHKCn1n/9gta8RrAV9lmbMAi7g+klPegT9NtZsDj6iMuhLM8ABbyXbGigApo51dxBu8doMM3s8LlyjI24GR88O/pF/2CKthmpYZH4UiuS6280QTZWwAWBPfYYlKYulayqYkMopgnVYWJihu0x01cAx02xRpTFsU2gNKvQtY70QNZeRIL+qZBvJPhp5zVtuHTsxJ0Y8Bx9Ey5+nmeMFggxyEjsXXgvheZ/ATayRTa137gkbTAa79q9jAj2PUZrHPfWqGYpUPwueXZo76s4wNC3WKAj7H8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12de72e-f784-4a03-b5f5-08dda86aa55d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 22:03:35.3067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLFC5Y1oT0vD6mknQ72v5VMIER0FtcBtLOizFRlqqEeoAB5DC6cwFVEOj5Phe1D9bXMEoRn6QTHVzTmX5Q9Mdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_10,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506100182
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=6848abc2 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Rmr7pf523Czb_bvJwTwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Q7IcuGa4jLF-LcCIuA12yBa9yGK3a6xk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE4MiBTYWx0ZWRfX11DPWJ+ehMwF qBXXRINP1IXhqPST9Neo0T92AiardFjYQ9lpPxTS4WeCZqGlIFNh5GvDUVxdkd2nvoS6nfBkxh8 22AA4HT6mWRN3LaJ4LPF8jBrmIwlB40DXNxLmgaIVwI9JTQShzBoGerwTthcaQlvugHF4RZ1a+d
 w4kmmTFOcJm6Lm17X0nY52gtxV6c2jYSnvQuijyn/AHs+gwcu9jHqkzZ+lxdJ8k1LQGO2NPwqIb NW28dX4se163li7rFS7iZ+BgIhD7f9d5DV2oLwBDbzoIDRAQvqBUC15uMQqQhnsHA9XHIerg2jx koiKArWLuZwswnKyCFiuTFbpaCgbssAt7u6qcxZARwTyJ+cfaVPXgnHODSd7ivT5aNmS0AW3z2i
 /44F8zGZgucPJuD+gJ4cMU1pnmuXuyWrC6a04fCvAFxthcpcxeNY/FkJ3ICeOXp9SREQ+pQn
X-Proofpoint-ORIG-GUID: Q7IcuGa4jLF-LcCIuA12yBa9yGK3a6xk

On 10/06/2025 4:05 pm, Dai Ngo wrote:
> 
> On 6/10/25 7:53 AM, Frank Filz wrote:
>> From: Chuck Lever [mailto:chuck.lever@oracle.com]
>>> On 6/10/25 10:12 AM, Dai Ngo wrote:
>>>> On 6/10/25 7:01 AM, Chuck Lever wrote:
>>>>> On 6/10/25 9:59 AM, Jeff Layton wrote:
>>>>>> On Tue, 2025-06-10 at 09:52 -0400, Chuck Lever wrote:
>>>>>>> On 6/10/25 9:50 AM, Jeff Layton wrote:
>>>>>>>> On Tue, 2025-06-10 at 06:41 -0700, Dai Ngo wrote:
>>>>>>>>> When the client sends an OPEN with claim type CLAIM_DELEG_CUR_FH
>>>>>>>>> or CLAIM_DELEGATION_CUR, the delegation stateid and the file
>>>>>>>>> handle must belongs to the same file, otherwise return
>>> NFS4ERR_BAD_STATEID.
>>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>>> ---
>>>>>>>>>    fs/nfsd/nfs4state.c | 5 +++++
>>>>>>>>>    1 file changed, 5 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c index
>>>>>>>>> 59a693f22452..be2ee641a22d 100644
>>>>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>>>>> @@ -6318,6 +6318,11 @@ nfsd4_process_open2(struct svc_rqst
>>>>>>>>> *rqstp, struct svc_fh *current_fh, struct nf
>>>>>>>>>            status = nfs4_check_deleg(cl, open, &dp);
>>>>>>>>>            if (status)
>>>>>>>>>                goto out;
>>>>>>>>> +        if (dp && nfsd4_is_deleg_cur(open) &&
>>>>>>>>> +                (dp->dl_stid.sc_file != fp)) {
>>>>>>>>> +            status = nfserr_bad_stateid;
>>>>>>>>> +            goto out;
>>>>>>>>> +        }
>>>>>>>>>            stp = nfsd4_find_and_lock_existing_open(fp, open);
>>>>>>>>>        } else {
>>>>>>>>>            open->op_file = NULL;
>>>>>>>> This seems like a good idea. I wonder if BAD_STATEID is the right
>>>>>>>> error here. It is a valid stateid, after all, it just doesn't
>>>>>>>> match the current_fh. Maybe this should be nfserr_inval ?
>>>>>>> I agree, NFS4ERR_BAD_STATEID /might/ cause a loop, so that needs to
>>>>>>> be tested. BAD_STATEID is mandated by the spec, so if we choose to
>>>>>>> return a different status code here, it needs a comment 
>>>>>>> explaining why.
>>>>>>>
>>>>>> Oh, I didn't realize that error was mandated, but you're right.
>>>>>> RFC8881, section 8.2.4:
>>>>>>
>>>>>> - If the selected table entry does not match the current filehandle,
>>>>>> return NFS4ERR_BAD_STATEID.
>>>>>>
>>>>>> I guess we're stuck with reporting that unless we want to amend the
>>>>>> spec.
>>>>> It is spec-mandated behavior, but we are always free to ignore the
>>>>> spec. I'm OK with NFS4ERR_INVAL if it results in better behavior (as
>>>>> long as there is a comment explaining why we deviate from the
>>>>> mandate).
>>>> Since the Linux client does not behave this way I can not test if this
>>>> error get us into a loop.
>>> Good point!
>>>
>>>
>>>> I used pynfs to force this behavior.
>>>>
>>>> However, here is the comment in nfs4_do_open:
>>>>
>>>>                  /*
>>>>                   * BAD_STATEID on OPEN means that the server cancelled
>>>> our
>>>>                   * state before it received the OPEN_CONFIRM.
>>>>                   * Recover by retrying the request as per the
>>>> discussion
>>>>                   * on Page 181 of RFC3530.
>>>>                   */
>>>>
>>>> So it guess BAD_STATEID will  get the client and server into a loop.
>>>> I'll change error to NFS4ERR_INVAL and add a comment in the code.
>>> Thanks, we'll start there. If that's problematic, it can always be 
>>> changed later.
>>>
>>> Maybe someone should file an errata against RFC 8881. <whistles
>>> tunelessly>
>> An interesting case. Ganesha doesn't handle this. It would definitely 
>> be good to see an errata for it. Also a pynfs test case.
> 
> Here is the pynfs test I used to test CLAIM_DELEG_CUR_FH:

Thanks Dai; would you like to submit that as a pynfs patch, please?

ta,
c.


> 
> def testClaimDeleg_CurFh(t, env):
>      """Test OPEN with CLAIM_DELEG_CUR_FH with mismatch file file handle
>         and delegation stateid.
> 
>      FLAGS: writedelegations deleg
>      CODE: DELEG32
>      """
> 
>      sess = env.c1.new_client_session(env.testname(t))
> 
>      # create file-1 with read-only access (0444) no delegatation wanted,
>      # and leave the file opened
>      filename1 = b"file-1"
>      res = open_create_file(sess, filename1, open_create = OPEN4_CREATE, 
> attrs={FATTR4_MODE: 0o444},
>              access = OPEN4_SHARE_ACCESS_BOTH, want_deleg = False)
>      check(res)
>      deleg = res.resarray[-2].delegation
>      if (_got_deleg(deleg)):
>         fail("Not expect to get delegation")
>      fh = res.resarray[-1].object
>      stateid = res.resarray[-2].stateid
>      print("----- CREATED ", filename1)
> 
>      # create file-2 with access RW and delegation wanted
>      filename2 = b"file-2"
>      res = open_create_file(sess, filename2, open_create = OPEN4_CREATE,
>              access = OPEN4_SHARE_ACCESS_BOTH, want_deleg = True)
>      check(res)
>      print("----- CREATED ", filename2)
> 
>      wfh = res.resarray[-1].object
>      wdeleg = res.resarray[-2].delegation
>      if (not _got_deleg(wdeleg)):
>         fail("Could not get WRITE delegation")
>      wdelegstateid = wdeleg.write.stateid
> 
>      # OPEN for WRITE with CLAIM_DELEG_CUR_FH using the file handle
>      # of filename1 and the delegation stateid granted for filename2.
>      # Since the file handle and the delegation stateid do not belong
>      # to the same file, expect server to return NFS4ERR_BAD_STATEID.
> 
>      claim = open_claim4(CLAIM_DELEG_CUR_FH, 
> oc_delegate_stateid=wdelegstateid)
>      owner = open_owner4(0, b"My Open Owner 2")
>      how = openflag4(OPEN4_NOCREATE)
>      open_op = op.open(0, OPEN4_SHARE_ACCESS_WRITE, OPEN4_SHARE_DENY_NONE,
>                          owner, how, claim)
>      res = sess.compound([op.putfh(fh), open_op])
>      check(res, NFS4ERR_BAD_STATEID)
> 
>      # close file-1
>      res = close_file(sess, fh, stateid)
>      check(res)
> 
>      # return the write delegation
>      res = sess.compound([op.putfh(wfh), op.delegreturn(wdelegstateid)])
>      check(res)
> 
>>
>> Thanks
>>
>> Frank
>>
> 

-- 
Calum Mackay
Linux Kernel Engineering
Oracle Linux and Virtualisation


