Return-Path: <linux-nfs+bounces-8292-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7409E04AB
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 15:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F88F2832A3
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 14:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19911202F7B;
	Mon,  2 Dec 2024 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jEqeDoqQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LRvP76px"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E44A1FECAA;
	Mon,  2 Dec 2024 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149167; cv=fail; b=jGoSCWBCWX5EhCtCzG/Uya5GtblCciU7+MfNPSVF5RgP1BrqjDOLiGzJUm9TDIBoMXElPoJkeUA/l2C+qr8zK2ANM8+1kZpAz1zXmeLYZFBbvCwRLnLI5GlSNIjOCQvSn1tnjHnFBgkCx0QIHfEyCcQH3FcG6qP5VS6C0E86BwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149167; c=relaxed/simple;
	bh=dzED0Nj5XvYBCAOVDvXj3qOVdQ9D0cYFei6zl4k4r1M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TyxZLFb5FAgprSWlUmFm9Rnql9ti7U4by4itO1NJWQ5xDR8IUUbU23jAyA0L4C6HWyHN7QI/yp4gPPZB/hw/xhr3r9iw0gvVIpzgADng3uxs+fHTsS6qDKf4AOagZtOvEHfJ8ctOBN97VRubG4SGaC4FhWhLF//C86I4SGfNQVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jEqeDoqQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LRvP76px; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2DOvEG012253;
	Mon, 2 Dec 2024 14:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dzED0Nj5XvYBCAOVDvXj3qOVdQ9D0cYFei6zl4k4r1M=; b=
	jEqeDoqQsWrT6UY8iftt1dd7hUFnIiErz9jIaM7pzoM+duAiWbeESogfNYBVUd94
	tYoG/Ei6FIfes5P9clMYLLZa6X6hdQ1sDZOpwOab1invOmAJ28COCMgOJdQbyCUz
	nUAWetFvlzVEd3F+AjUfSBiFY0iXPKtaGf7CTvULuBoGg6iGwLm1XUZKBCKpg8ZJ
	LdxlT2J+JmW3kR3TCY6jECOC6MG6rFmBSXEJOsKUDi2p15jyCyr0iUpsESL/6kgv
	jv3Ny8g9wXkgCxQNvfLg0OsbfGx66l0QKya4Upzd4N+DUV+eZaJD1PepXf7yNAqm
	Hz2vBSN3eARQI9GEdh/Sfg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s9yubxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 14:19:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2Dc4lD032195;
	Mon, 2 Dec 2024 14:19:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43836sj977-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 14:19:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTOUxn5PuJ9g3JTCKf+ps0L+U0m+tBXZzVp1OBhL220gl77hugi9ERZy0HwzgjCBe6IU0KhsBFgsBDFwlCXQhR3Fn879paWK7g7xJIxqd9harRIbmS73anWtOjK1e4INIouElvPBaBLaYJL6g0vyidNrIChAOJQpzpyLabveUstd9q+g5oON8P+AtMwHY8DLD9fiWj9iGc72e6wgUOGCAxDC0MNM7BShQp7H+0wi+eThpUjxxCEqLVGx7X8SGFr5cMDQ0dj29SFybDg1BgHhN3w+gmzGF2bjkp22kmbYElXyWOViRzmJu50bRpRvV8AVf/q6ordQ0ZGVCxFRtTHc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzED0Nj5XvYBCAOVDvXj3qOVdQ9D0cYFei6zl4k4r1M=;
 b=vWtQj56zqMqfq3PYM8nlfqhNHYhA6cd/9zwh02fY0XXaHsNlwSeS7kub8Sr7aJ+W67IucIQKNChzW6P7E/F/aycMf4DzC6U4cGWUeEzyBvg2dtUOAUwOb46ul4dewUasLYlU/N3vQv7qSnP2olZGmyogmjExZOcpwo+Zvft+VyRlzdkUWR7rPHBO8YeJ8xjtvCvxq5XK5buhXoW51cf8YtOWe6kS4Tg0LBpfzfYKV59H24hKhPt1Pv0F48AUkZSfAVsMBYeYsgsZ3A1BM/9dPB3PAjL8x3Cbu6ndyIoBJGpdr0/Rwk+IYzYS/6tEyctXJK4f8jSTmszzKV3ZVUvQuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzED0Nj5XvYBCAOVDvXj3qOVdQ9D0cYFei6zl4k4r1M=;
 b=LRvP76pxDY8mbA/VW2eWMkDgp5cwJvbt2eoltUZyP8+EAYguq4ow7kLBgaFYdHivP98OSTyJyvxQVGd1IsftTp8pWAmyF4cx2twBVHb8VH3npivy4zcMck/y+DVMKYqAXr8eSwYkMyiKImNELIDsxKKZ6n2D1p0dxVhmImJHr6o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7117.namprd10.prod.outlook.com (2603:10b6:610:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 14:19:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 14:19:13 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Chuck Lever <cel@kernel.org>, linux-stable <stable@vger.kernel.org>,
        Linux
 NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton
	<jlayton@kernel.org>
Subject: Re: [PATCH 5.4] NFSD: Force all NFSv4.2 COPY requests to be
 synchronous
Thread-Topic: [PATCH 5.4] NFSD: Force all NFSv4.2 COPY requests to be
 synchronous
Thread-Index: AQHbO4BM9xZ+CqFwB0u6wSc9QL1+wbLSvK8AgABWl4A=
Date: Mon, 2 Dec 2024 14:19:13 +0000
Message-ID: <E476A582-052A-4455-B53E-729EB8D654C9@oracle.com>
References: <20241120191315.6907-1-cel@kernel.org>
 <20241120191315.6907-2-cel@kernel.org>
 <2024120226-unearned-ragged-ab69@gregkh>
In-Reply-To: <2024120226-unearned-ragged-ab69@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7117:EE_
x-ms-office365-filtering-correlation-id: 374391c4-4652-464a-45a9-08dd12dc4c4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VVNKMEErODZTK3Y1WW85Zm05MXgzR1VDL3Npb1IvV0ZaYWJjQTZQWGg5NDZs?=
 =?utf-8?B?eVJYbkpDNkk5N04zT243b29WekQrZDRUVkh6MGNFMGxJL2llZDVlZnRKRUxi?=
 =?utf-8?B?c1Q4K0NwQkpDVFlGcXNybDNvZ1F5TXJ3VDlKZDhmZ0hVQ1JJK1VEWUQzMGh0?=
 =?utf-8?B?SVVUbmtpQzFOMkx6K0tKWTlvOFJxS2F5VlJTaHR1d0I2eGpCbzMyTjJxUGxo?=
 =?utf-8?B?SFErZjJiVkw5L0FpamxNNkw0S3JnSzA1eFFEano0RTc3ZjBISDRWZ3JhNEl1?=
 =?utf-8?B?SVJ3dHRRRHBNNjNzZUhmL3J6bU5sVk56S1doR2VCbks1RmE5NjV2WGo0eHRM?=
 =?utf-8?B?RVM5cDh6akg3dnNTSlJRYjVMc3p1VUNXeG1vcGh0bDJwV25PMG53NzlpOVlo?=
 =?utf-8?B?RGJVa290dDl4THMvTjlwL2VNVTF4S0l1Y0xnbGNML2hSenNGUGtGellRdGx2?=
 =?utf-8?B?Q2dHMkY5UTdjcnUxU2VLMzFZVjVjaFVzZVF5K1dRdTNSMjI4S0pSTmJPaDBH?=
 =?utf-8?B?VXpPa0thOUxkdmc3amUwVG9QVzRtclkrWjZUMDNxR0EvY2JpZGNIWUM1RzlF?=
 =?utf-8?B?SzZWSHpjN3FaL0lKZy93dWdIZ2ZYaDYvOGFhN1kybWhSTGxQYmRLZit3STJ2?=
 =?utf-8?B?cjQ0ZXVKT2M5VlBlSWNucncrdU9oekxYRFZXK1dCVWdMWVNnUGkwS016WXFp?=
 =?utf-8?B?WVZhUU56NEhsdHVqS1BmYnN1NFh6Q1dIbWd6Y3VRVHI2MnozOU81YjN1cCtE?=
 =?utf-8?B?UlowRDdOdlZuR0hveG1XcUVxUXFqWm9uMDNFbXJhRmhPS25qZEg3V2piL3I5?=
 =?utf-8?B?cERIQ20vaVNUL0dZYXV5N3BKdjVjejlSSkd2RVpJRGZLUHVhWkpoTFRMK1Uz?=
 =?utf-8?B?RVZKU2dXLzl6WTUyZlJCWWhWeTVQWko0NHlxSUVpS05JWmdqMlRZUEkwNFFM?=
 =?utf-8?B?VUlxbHB2RUFDR2xsYUQzUW1FdmlGYVM2WjJqemI3RU85cjNLVUxrcFk4ZW43?=
 =?utf-8?B?VlpqanJuRnh0eUxJSnJxMjZJdlIxN1pCai9OVFhLNjk5dEUzOW1EZ2JVVGtE?=
 =?utf-8?B?MW16ckZSd29uUmFkNUVhcGNnSENkL05tODlJdk9jd2xsczZxYXN1UDdmSGlI?=
 =?utf-8?B?NFdOR3VFM3RzdWhTbDc0QjhjWm5JUmN2N2FmQWRIMXBHWitibkFSNmwzTnRZ?=
 =?utf-8?B?TlVFdklrR0dvNm9NakUrL2d3c2VqV0ovdDhsOHQvdTNubmJ5c2xrM2p6YlpL?=
 =?utf-8?B?c0oxdm9hZHZPenpjdzFQOG81cjk4bVdJL2E2emNPSVpFNlJiVUlnTU11OHNo?=
 =?utf-8?B?R3loOTFOYnBRTDVycDhTdzAxMjNMM3NaWWNCcW5jSDk5OGpzRG5QdHdzRGZv?=
 =?utf-8?B?SkVmZC9GT09sNUdtUnZVbzRPNklMcWw4OVlzdnBESzBYR09ocVk5eVk0ZE04?=
 =?utf-8?B?OVhiU0FEMU9xQ1NVVFNsRGlqeHFmM0pPcXBVOEZ4M0dLV0Z5YWJMYWZwaWEr?=
 =?utf-8?B?bmJQWVNaMWpsNnVFRkI3cEE2Q1U3anNkM3kvNVRMRTlkY0tPcXQ4UXdURm8z?=
 =?utf-8?B?S2FtQldlaTBadnVGbEh6djhuMHVtd2ZnV0MyQko1ZFNucE9OZUNZZi9Pblcv?=
 =?utf-8?B?ai9aYnBWRGhmTXo0YVJMSnUrM3dHaC9DRTkrOGpiUnNpWFNVdFVlLzRPSUYv?=
 =?utf-8?B?cUNQRkIycS9HMk54cENjM2xpYTJqSkJ6alBJZ3hGcmEyTW9VYlZJdVd0ZzMy?=
 =?utf-8?B?N3BVWDRzcDZrbjNNakNrbWJkTkpYZW1wdjBtREhmbWRCQW52bXI1K08rakxL?=
 =?utf-8?B?WjBkeFJhbE1zc0ZwNlpHaDJvRDRYQlViS2xnZFhrdHg5bmo3RDZMdVJKcFRw?=
 =?utf-8?B?dkVKQk44Q1paWG1yUEN3NDRYU2ljYmVqMGFGSVh6WlVTTkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGYrSlBIQlhsSjhQYzFPbEQ4R2N5ZXQ4U0d4VmtyRFlkUnZyNXpUU2gxYy91?=
 =?utf-8?B?TXlOdmhLN2l4cXZOSEZzUDcwdytGRCtTT2t0aGN2NGgyTGlMRW10UmNEc1pJ?=
 =?utf-8?B?U1Z0ZUttUmgwbDBvZFJMdVQxK1YyOFgxQTBaSE5XTDNNc0Y1ZEhYL2dPYnI5?=
 =?utf-8?B?K2NtOGpSTTlrUFFwZkszY2dKVzQwSzZ5M1FlVDV0WnExdFpncjFnUElLSlhy?=
 =?utf-8?B?UitjVGVwTXV4RnhqU3ZBUGZZUVVYZU9pUTI3cDZsellsOTJkeTRGb1MwM1h3?=
 =?utf-8?B?bE1lZDBOMmlXQ1hLYW90NHBJbVhtbVQxcm4xQzFQdnJJRWxEbXhnbzlYTjZa?=
 =?utf-8?B?U21uVUM4MWxobWMrQ2w0TzlZV01Tc1AxTXhkQ3p2VDdkd1pQMFhmb1YwaDRX?=
 =?utf-8?B?MDJ2NTdtQ05taUhNTXd0VWhJZG5TcVArVU0yUVlQTUtxVEp5WUM0MjlUbi9w?=
 =?utf-8?B?UGlUaHIyWFlOaTdKQnZuY056dFJmSkVwYnBqeFJJK0poZmUxOVdUYjB3UEdX?=
 =?utf-8?B?WVBVZFBHWis4Y0ZiOURndTg4NXhrNmlKeVRKWFo4SWFuc292VUhXckJ6MWUv?=
 =?utf-8?B?NFZ1am5jdisrejM1cDdCdWFZM1pxcXF2Y2NsT2VGa2w1c21uR2xBLzBLRWxu?=
 =?utf-8?B?cHZxYzNidm10TTRwcmNBbFRJcTNWNlhXQTFPNGVocHRYem9tUXIrUHZmRUlr?=
 =?utf-8?B?TGVwNW1UZkpkMW43T1Y0OTlITElhUE1FVVl3SjJ2ZHc2L3dVWXJVQnBrdVhm?=
 =?utf-8?B?cnhDcUdTbUlodFY3ZElVUWgwcFpUWFkzNXVwVDNQbGh0bndDb0dTUDR4czJC?=
 =?utf-8?B?b1NDV21pRUJaTWo2anVPa2lCTmdONWQ4MXVtZE11YVdGQVVuRUxIbWZGQmto?=
 =?utf-8?B?bkxUL3hsRktKMUtzeklGYTl5MDhoYS9jelp5M2J4c01FSHhJdXNoUXM3OW1L?=
 =?utf-8?B?VEpRMXQ0Y2JjY2UyNXZmaGpUeFFNUXFtY3ZvaDZRK3JqZVJ1UHV4b2hoeUEv?=
 =?utf-8?B?S2NsUXJjTTNiZHR3WnNkaHJLeHJmQmljakkyTjhCZU4vTlorUzE0SndrSFJq?=
 =?utf-8?B?S0tBQzN4QnhEbE9TY0txaEVHVkVxcXRpRkNoaHRxRTQwTERMNDJQK1lqWnAv?=
 =?utf-8?B?UFdYNk9lWWZuQjZnNFNTeVdYVkcyZmJGL3IxeWplSkM4QnpLcXNwdHVhcUVV?=
 =?utf-8?B?UWtBZVBVbHgrSkxBZGZOWnUzY3RrTThxMWl3SDdOdjhkMVZNckJuMndtNlZ0?=
 =?utf-8?B?SHJabmdMOCsycnlNNld5VHZXTVl6cGZxc3dtdlhXVkt0T2FPSmNOc3hHc3Jx?=
 =?utf-8?B?aTdTa1ZLR2dCODVnZ0R2ajVvbnR3L0xkdnhPbVU4VmY1bC9HakVSMHA0Zzdx?=
 =?utf-8?B?U2lMVnVrVDAzVmgxbGlkZ21Ucy9zSGlFK3dMZitsdEhmNmNkQjU0WUlURnBx?=
 =?utf-8?B?M3FpZU9peVhJMGZGTURUTXlnNHpyRzlZREdjSG1lREErMFUxOWVyTDd4ZEcz?=
 =?utf-8?B?UUQ5YlBnRTcyd0tpclIxNDYwN3dFcmVzRE14dDdITkxQeXNBajNjWlRXOXRM?=
 =?utf-8?B?N1pqR1FldEpXS1g0cXVaeGJyY1V6ZVU5cnVUK2U0N2FXUWFoYVFkYjR3ajJO?=
 =?utf-8?B?VzFhVVlyUVAzRDdreDFSSXJvQ3BycVYwZ3dtWmhNWjk3cGxWQnFzK1BMZXk4?=
 =?utf-8?B?QVF4OWpwNldKSmtvaUREa3JDMGpKYllJMHNNR3VCSi8rTVBNVFFNNVI2c1JF?=
 =?utf-8?B?ZTRVbHZhdXNZWDRiSmpjUU8vMHphR1J1ZUZmQkpFbkZLK3VLOUZUMndZMkVs?=
 =?utf-8?B?WkF5MC9XaGtGVVltSUk5b2dseE00Y2tCSDI1cDN6L2NGZFBqS1ByUEJiUENP?=
 =?utf-8?B?Um5XZjVpOU1uaXVBTk40NlM0MjN2VFFBTnNKRGpwTHdIK2FYc3Yzc284U1NF?=
 =?utf-8?B?N21OMVQvVjZHRllNL0R4YzI4UEZ6QTQ5N1NRbHNwa2hyU0NvWWsvZms3SXk4?=
 =?utf-8?B?Q3lZekVwZ0Q4dFBZbmpNMjIxanU3VkJnRmRHdUppd0JsMXFWY29tRC85Skx2?=
 =?utf-8?B?Y0FNeFB1ZDI3aFhJNFMrYXl0cmhYbWdlTUJJaGQ3bWRhY3YzbEtwT2k1VHpt?=
 =?utf-8?B?cGFqZVh2MWNrU00xZjdaYWI4TWZHWGFBMTh2QmNaOGpRd2pzSkdKSzRlTU9U?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F1AAA893D21A346A6230ABCFBE14ABC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8wMBwwAUlCHSirT+huFhFx2/okK9/n0xslbiBxVBmsyUHjIhH8rCYnS/yuOE1kkNMX8u7+GUA4oKkL8uA5M5nCnUL+ZwYMqG6jRVJsmmVkUkwVT9XcUFwduRNt4fjDz0su7HyO+hdMbb21Obm0lV7YqVN++HM5M1H5CtaJ0hR8xmVrcH45UWphMofd+5gCHf7U1RQcNeredWU/TmEQ2GoFKJLB2BYKO58nOcNZnlGP+brO8hvsqyU3Vsizy3oeDn7j2NTzyv72waYHIJzD/SC2FK5gzUtbRA+g3iTFfoaSPelh3vNMiee8JzMkiqkg6Eox0hvpJtfZwcmUqAycZZ6SK7xVh14ypziWNtpCuVACdd8wATsQ5xCLr1A21QIHmMN0hKwCyyOVfrZpwmTv53VT0HzX2FlSJOdap7naG/OpsZLKB30GYxeSqykDW8EQG9lhGMWy6sKOHN842lbA6HH33d9J85H9P9+8PLQiEqyPlK91eVNmPjXeSqyo/wlO7ueCV1SEv6aTfp4A7Wgex+Ik6BkZGczKNRuKtjtmJ7Re/iHTgMxAsDuX68MVvIx5ZI01BYg/RLlbQHAw/Q47EEor/KXUT4zvQ5YSNIZxoXL34=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374391c4-4652-464a-45a9-08dd12dc4c4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 14:19:13.8294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVW/Md4BOd5FleRKtJs9k/F8ssZwfV4P/XD+ZGVfdFe6wLaZTo5jlTxCVygIpBYhesmTGoMmmnxj4YwZPWqt8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_10,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412020123
X-Proofpoint-GUID: D3YTbeWnVooQ1K0xjRkX1H14KQdpQrtc
X-Proofpoint-ORIG-GUID: D3YTbeWnVooQ1K0xjRkX1H14KQdpQrtc

DQoNCj4gT24gRGVjIDIsIDIwMjQsIGF0IDQ6MDnigK9BTSwgR3JlZyBLSCA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBOb3YgMjAsIDIwMjQgYXQgMDI6
MTM6MTVQTSAtMDUwMCwgY2VsQGtlcm5lbC5vcmcgd3JvdGU6DQo+PiBGcm9tOiBDaHVjayBMZXZl
ciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+IA0KPj4gWyBVcHN0cmVhbSBjb21taXQgOGQ5
MTViYmYzOTI2NmJiNjYwODJjMWU0OTgwZTEyMzg4M2YxOTgzMCBdDQo+IA0KPiBXaGF0IGFib3V0
IGtlcm5lbCB2ZXJzaW9ucyBncmVhdGVyIHRoYW4gNS40PyAgTGlrZSA1LjEwLCA1LjE1LCA2LjEs
IGFuZA0KPiA2LjYgZm9yIHRoaXMgY2hhbmdlPyAgU2hvdWxkbid0IGl0IGFsc28gYmUgbmVlZGVk
IHRoZXJlPw0KDQpHb29kIGNhdGNoLiBNeSByYXRpb25hbGUgaXM6DQoNCkFzeW5jaHJvbm91cyBD
T1BZIG9mZmxvYWQgaXMgbmVlZGVkIHRvIGltcGxlbWVudCBORlN2NC4yDQpzZXJ2ZXItdG8tc2Vy
dmVyIENPUFkgb2ZmbG9hZC4NCg0KVGhlIHVwc3RyZWFtIHBhdGNoZXMgdGhhdCBhZGRyZXNzIHRo
ZSBDVkUgZG9uJ3QgYXBwbHkNCmNsZWFubHkgdG8gbGludXgtNS40LnkuIEhvd2V2ZXIsIDUuNCBr
ZXJuZWxzIGRvIG5vdCBoYXZlDQpORlN2NC4yIHNlcnZlci10by1zZXJ2ZXIgQ09QWSBvZmZsb2Fk
LCB0aHVzIHRoaXMgY2hhbmdlLA0Kd2hpY2ggc2ltcGx5IGRpc2FibGVzIGFzeW5jIENPUFksIGhh
cyBubyB1c2VyLXZpc2libGUNCmltcGFjdC4gU28gSSBkZWNpZGVkIHRoZSBlYXN5LCBsb3ctaW1w
YWN0IHdheSB0byBhZGRyZXNzDQp0aGUgQ1ZFIGZvciB2NS40IHdhcyBhcHBseWluZyBvbmx5IHRo
aXMgcGF0Y2guDQoNClRoZSBuZXdlciBMVFMga2VybmVscyBkbyBoYXZlIHNlcnZlci10by1zZXJ2
ZXIgQ09QWSBvZmZsb2FkLA0KdGh1cyBpZiB0aGlzIHBhdGNoIGlzIGFwcGxpZWQsIHRoZXkgd291
bGQgc2VlIGEgYmVoYXZpb3INCnJlZ3Jlc3Npb24gd2hlbmV2ZXIgQ09ORklHX05GU0RfVjRfMl9J
TlRFUl9TU0MgaXMgZW5hYmxlZC4NClRoZSB1cHN0cmVhbSBwYXRjaGVzIHRoYXQgYWRkcmVzcyB0
aGUgQ1ZFIGFwcGx5IGNsZWFubHkgdG8NCnRoZXNlIGtlcm5lbHMsIGFuZCBJJ3ZlIHNlbnQgdGhv
c2UgdG8gc3RhYmxlQCBhbHJlYWR5Lg0KDQpBcyB0aGVzZSB3ZXJlIHNlcGFyYXRlIHBhdGNoIHNl
cmllcywgdGhlcmUgd2Fzbid0IGFuDQpvYnZpb3VzIHBsYWNlIHRvIGFkZCBhIGNvdmVyIGxldHRl
ciB0aGF0IGV4cGxhaW5zIHRoaXMuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

