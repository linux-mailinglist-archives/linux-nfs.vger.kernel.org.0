Return-Path: <linux-nfs+bounces-4751-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E0B92BC3B
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2024 15:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 466D2B276C4
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2024 13:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56E51891AF;
	Tue,  9 Jul 2024 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VNEeABPb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iIUG2o6O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69B617E46D
	for <linux-nfs@vger.kernel.org>; Tue,  9 Jul 2024 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533342; cv=fail; b=MsBYDX9aC7l1wxRL3lzZgQqcpqcaTIP1TMd5360YY0mCoBqSZgLhBh4Nqh3MgCbWKC6N0wsXwWZ44e3fllPRSQKXZw1Ka+kmxoPQ4rYiXhWRMJecuxQihZH2ckdH4fTHJVB1arZ+V0ow40HYnhXM7OkkP8cm7A/+XHqVgy8lowU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533342; c=relaxed/simple;
	bh=tv6DfMdpgeJ20e/Uq+ytzNCycDBVgi4DGqVbEIkjLSs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GMDj5sGMba3FUdj/q7Y4RgD2n2g/+ey7i2FvNQFw8A2PhJNTAzgs26TzsYE99v+aIprkbBSRszxjLx3Bf69f3uUzrgXHkc6C2pb5B3GMNPBcgtfVGrpWE+UeNlt08UtXZzqn6TCnjamdfiGvBdJzXXfOTbPUnCYh9p6xy5QgXTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VNEeABPb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iIUG2o6O; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469CT1Fh007970;
	Tue, 9 Jul 2024 13:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=tv6DfMdpgeJ20e/Uq+ytzNCycDBVgi4DGqVbEIkjL
	Ss=; b=VNEeABPbMXEJFcB+QqaEEqCS34kgXmwIfiwc03dNNbfIEplH9ohykOpD+
	JZhKiuEsxiBZsKfeYGPwXfYqvX12RLzJfv4q4LpdSUTpOxCWL1ZXcXeCHDPVF7cj
	qEyAKwy+KA4wYnmW5fQnx7pTJyJ8aRn8UM6SmfqdE1PZQKTerEUxA8h993K+4ZmA
	Y8Giu5gJgTBtaDGQVUD50bmmSDUt1cg4alHR9LqyYIYiDVNfsrxXww43CwAfNM3h
	CdvWiPcP/vsmNv8yuoVPcWkb+IHng4t3ySmEK9qnlpSnRXY1lq7aVlqcOCPku6Gv
	3RhUmLp1cCQ+ZsoA7R2nramBphMqQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybn199-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 13:55:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469DXne6038248;
	Tue, 9 Jul 2024 13:55:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tv1brrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 13:55:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9S9H/khFh50RGMXEHw+G2WgcCfZ8dgpIUQRtBNLXIIHiqbsGN5EzSjhuXD34WbwtmLDApQQ32CWKO86WgzdGaz3kKAMXnVxiy4aX/UsyfYtkvme5LxQFjVXKkVcyGGDg2D2Buze+T/iljOx/cyDKOdEABjvmtZtZ4sRGj2zqtlNiEgU8ObwBdvqXqzWNfq6SOYMRN4WhWwU+ktHo0FA/RdiyDhwcLwyiEyO/wVW7EBToilutttIRwKDBvymuE9wwSx6+IaZhBk9gNqXMweHfm0Dgsqh80ApwBv84TyrrhPKuapDpAD30K+UdhdECLT3MNBR7e95X3K+5Lb9dUwPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv6DfMdpgeJ20e/Uq+ytzNCycDBVgi4DGqVbEIkjLSs=;
 b=hLz4zaEac5agSTqLVVeu/XaVjFbQnXODeLH1l1Yx0OY0RV1vDEcPu4iXK0W+KxWGTrhi6mtcgQPurhKoslsa1EcILLm0ZqIPUt2J91UCWRC0YFwBff8fOc2tXJ9p1nlMWP+858CgH5OsLNeas82hvm1BrUl1UYSO4mB9+LK7yEptYIq5KXWMAsb+nCeX2rSXrYm6jecmlcRdNq9gYaJ+/+yUIG7z+A8/gXpyZH+uWCZDewImjpEmhW1/GH7LTEFm3TqIWFBwocrrM++lGXhRqU86RDlzqDE3fIv9VGf6DjblLzyls4Lz0M+SENkAMDX7AN0dOJyQQ5CQ/au3ex1x4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tv6DfMdpgeJ20e/Uq+ytzNCycDBVgi4DGqVbEIkjLSs=;
 b=iIUG2o6O+6f5b8C7lPmOHp/MNFuMXUDPIlTzgLFgLV/64jIdTbV/cjO+65kHVZX0pZ+QouMWHyZXX7b4UNRAARxYbVspsT/Z/qtUxXw5Sna6po4TLwyHFlk08zvOVd5UJeE8tHF7mFjlxoeBgCnnFYfDeaWz3uD+frRGy+slYMA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5595.namprd10.prod.outlook.com (2603:10b6:510:f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 13:55:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 13:55:31 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
Thread-Topic: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
Thread-Index: 
 AQHaz/XBfwkxQ1O/ZU+jeIGo74rnYLHrG52AgAHH5gCAADhFAIAAFU8AgAAuOwCAAKE2AIAAbtIA
Date: Tue, 9 Jul 2024 13:55:31 +0000
Message-ID: <53440FD0-58F1-4B92-BCC3-20CB91BB529C@oracle.com>
References: <20240706224207.927978-1-sagi@grimberg.me>
 <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
 <9156BC30-78C3-4854-8BC3-510E586B4613@oracle.com>
 <3b4ec3b0-5359-4f95-81a3-1d558756bddd@oracle.com>
 <5a071e49-f214-41d3-b29f-aa1860b12455@grimberg.me>
 <e23bb0d4-7f83-45fd-8df1-b127e1f749db@oracle.com>
 <9b9430e9-845b-4e21-b021-cfc387cbd01e@grimberg.me>
In-Reply-To: <9b9430e9-845b-4e21-b021-cfc387cbd01e@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5595:EE_
x-ms-office365-filtering-correlation-id: cca07b4b-5dd2-4989-d858-08dca01ecc28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZjRtTHZMYmNEUmFVcytHdS8vNDhWeVVSQmpEc1Ayd2N1cEF4WVZ0UUFHQm5t?=
 =?utf-8?B?aExOTzBhWEJqa0xVdWx6ZFp1QU55emx6a3hwNFNSK0M5amEzZmwxeTVwcWF4?=
 =?utf-8?B?TE5DOUQzaTEyMnFoZWpxVkMvZFJwVHd6MFVOWlZjS25BNzQxT2RUSDBhN0xT?=
 =?utf-8?B?WVRIUWNFeC9ZbzhwMHp5bU1yYVd1TWpqOHRhOHFKQk96elhHNXhkSlVoSzlT?=
 =?utf-8?B?S3JGVVNwOWtDL29jZ05DQzZGU1FoU0lyNnB6Q0NiUE9vZEVoWkxmSHpNN1lD?=
 =?utf-8?B?SWpQSHd1M1NtcHVpOEJQY1Fzd1lnUmxMSXg2ZGVCMWhRRlNZZVQwSmRobEdx?=
 =?utf-8?B?ZHRqdklyaExNR1dsaUl6WFV4d3cwaXIzdk5WakVhSUdKaUhwSW12ejlpRDM3?=
 =?utf-8?B?M2hvTVVPZ0tLc3V6ZUVQc1kydnh6OE9vNW9LN3NnNkh4NEx2WmYzbmt5RFdn?=
 =?utf-8?B?Z2VCa1dhT3NsOFlpdzhlZGQwZnBNUkJjb1p3VFBLb21ycE52Q1NDYWRFK29i?=
 =?utf-8?B?TWxWT3p1WW1FRDVvK2JrZXlGRkRnbnQwcGpiWWdHSkI1ZkpaaDJLZWlURGRo?=
 =?utf-8?B?bjZGbVlHYmpGZXFRMnZicmhYQ3h2SWNtRWVOT0VJT1Yra2hPaktkUEx1S0dE?=
 =?utf-8?B?WTFzUmJHQSsrS0lsa05WL2IyZ1c5M0tWcXVMZjdtalVHRkFBWG1yUFFyZDh2?=
 =?utf-8?B?Rmd4czB3MUJKVi9zMVJkL2VYRWlpS2VucVJrWERDd1dBdVRhVVN0Q3lsYVZm?=
 =?utf-8?B?eVJOc2pPdUl6L2lrbkR2TVhOTU1oLy82UDBwcnMyY3I0VVp3Qkl1VDVRZzMy?=
 =?utf-8?B?cTdaOTFycWY5ekxWRlhDczFWTDhOeEo3ZUZjdU81bmxXeTAvbzZpdnozWWs0?=
 =?utf-8?B?ekxnSWRSWVJLZmZ1TkZrOGY2Z2xtRFFDelBXcHBZamVmYkZ3UkZmMG1jR05V?=
 =?utf-8?B?OXhMdXJOckJqQ29kdGE1STJEWEZTcllCclU5ZGNYTkp3R3k5VHJEYlpFUzls?=
 =?utf-8?B?NmQ1ZExqNXNiMjVheVBOeG9VYWIyV0RIY0JKcjNIY290Z0szSlVZcVRmWTh5?=
 =?utf-8?B?T2MzOVNsMGRuMVBhRWpEaVJHZm11S3I4ck55dEpBaDBIT09DNHlSVnFqU2hK?=
 =?utf-8?B?VEZ0dWRFRGxxTUwzcW4wOG5rbnNWdFlDeTd3dHVUVkp3a2tLTHBVUExvYkFE?=
 =?utf-8?B?bXcrdVpwQ1JlUmJHek9vR1NMMkd2SWgyNWRWR1hBbXJUZmVYZlZsWk9Fa282?=
 =?utf-8?B?REdKZ1l5dWNkNVlOTk9YSUFvbTVTNlJpdWFTRCtPSHB5MDQ4UTAvU05vcld5?=
 =?utf-8?B?dkdUZC9aa1pxUjl4TlVKL3k0MDNmYmhjSjJhbXJwaEc0cG9kRXVTMmJuOVdi?=
 =?utf-8?B?ZDA4SDNlY2xTTHQvNEtJKzNuQWFVVDh2aE5ZWlUyNFpEMGhaa2hTMm5tQ1Qw?=
 =?utf-8?B?SXdxeHI4eEJWWE5VTm5Jdm5QVXhaaEs0VzZ1em5RSXlNcVFseVlESFhJSnlJ?=
 =?utf-8?B?UGJpa2Q4bTNvN3p2WG5PcEloOWNKMUViQ3NhVXdOazJkR05QQ2M3dTBVM0FU?=
 =?utf-8?B?OVFieTREdnlXSEhWY3lJOFB2c3lobSs3NFh2ZDF0NGRiSnJFd3h1c1pUK2xO?=
 =?utf-8?B?ZUZKalRCRDBvSmZmVis5YWVQYm5CY0VUT29aTnB6cXl6dENpdU1wbkNnN3lH?=
 =?utf-8?B?Mzc5SjNmbzhpNjBLVlYyTlFZeDJVSnJWcGtFbGxTaWphRHJiKy9vZDYwVUJS?=
 =?utf-8?B?aDVZSHMyZGc1N3V6WHBXYVUrYmVjUWNCTnAza05ZWVpuUS9SZmtuNmt6N3BZ?=
 =?utf-8?Q?LAGtNj9rE86SYSZ7MlX/aH0ItOucj820kcZrE=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T3o0WS91c2ZPWFpFRXI5RDRhMzZCOTRUbDhmRTh6SEpjR0xqbHFLTzk3UUtL?=
 =?utf-8?B?SXRwV0o3NG11QS9mbEJCUFBCcXFvY3ZQUGRKOU1GZkJGWExGY0lNNUwwNnB6?=
 =?utf-8?B?ZmV2U3ViRU84bUMzbnVOUktneWJpWnBWelNiM1p6N200ZENyazlSWDh0WmpF?=
 =?utf-8?B?Q2dzdWVYNG4vT05HYU9TblJ5MXpsbzNOcXRsd0tESkdiSWxHTzBjNHdLb1pC?=
 =?utf-8?B?TksxN3RYWVJOZ2hKbHhFQ3RCYWgzOXRmRUoveGRmK3o3VkhTa0pIcnZ4Z2lZ?=
 =?utf-8?B?a0NUdTY5WTNaNnN4UzdBQzhnUVRqV1h0bXVIeXNVMlJVVkRjQ1BLRTJyZ1BL?=
 =?utf-8?B?UkZNUng3blZVTXdoM3ppdDhzbUs1a1grQ0NFb1lkT3dZRDgyVCtoVGFIc2Vx?=
 =?utf-8?B?WWdFY3Y1MWRTYjEwOXF1RkV5bCtOZmEzTFhwU2kzR1c4RkRoNHBiMkZPZGZP?=
 =?utf-8?B?TnBpcjZLcUphV0R0ak5HOHgvMDV5MFh0Q1kxRzVpejhXVW9zeElhSnZiVHpE?=
 =?utf-8?B?MGxEREpJb1hvTkhuYkhCenJQVWZTMHNHR1JKUlIvN2Q4cTZ4T2ZXUnljVGsy?=
 =?utf-8?B?TUkxSHVrTW1CZFRTYXRsTlNzMWY3ZThhSFBWYVV4OXBoaUx1WURHckFMMGVq?=
 =?utf-8?B?Qzl5MzM5Qiswa1dncmt0WG5PcDJ2OHpFajQ5WVRrN3FPdlFlbkIrbmltNkZX?=
 =?utf-8?B?eGJSNTRwZEFOako3eGJLRmh5QllIMTdzWi9LaEV4WEdPd0VaZEFlQThJa3Ru?=
 =?utf-8?B?L0szSFRRamtxU003Q3BWZGF0RE1HR0xIY0Y2WGpZMTg2OFo4SVFjOU13cWgx?=
 =?utf-8?B?LzJ3eFJ6WHBFUzVNUGdtbnJ3RUpjN1YzL0pRSXMxKzQ1VEdNSnpYbXZ1cngv?=
 =?utf-8?B?REtoUTYweEhuSEVaNjE1RGhZVG40VE5ac0t0Z3ZCMG9jcWZyS1pBcUxuRzAw?=
 =?utf-8?B?T2NaVVlDNFl4ZEdhUXF4bHZ5N2hRRENEMmZIWWx2WDBXZE1mMWYzdnlRMGwy?=
 =?utf-8?B?emdtUjRlNExzMWVhdWhPSm5zQXpBeTdOL01ZMjk4MndWbmJadm9LaFpsNmlZ?=
 =?utf-8?B?Zm1JRnFVQUw5SUF0VUJIclVoM2NkaXB6Tlkxa3hjaGJFRUtSMThUNExFaXNp?=
 =?utf-8?B?YVZLK2pjcmh5VW42WG94VkorUjM3Y0NrZit0TzBtKzNvbzJLcFJhZGJ5UGl2?=
 =?utf-8?B?S2NZRGhhK2FDUUlabk1weUNWYjJVMEM1YTlYRlA2dThCeVhiL0UyRDdwNEp0?=
 =?utf-8?B?eUN1cW51bjNxNTdnbThmZk5FcWdVRDFmeHNGUHU0WkU3TDZXRGlISC9ETEly?=
 =?utf-8?B?RUxEcXAvT1ZZWDY5N3dGWWFXa3dTNUhSVmltRVU1bmZsNElmR3haTFk5b3hu?=
 =?utf-8?B?UG1XbGtIUW0wbDJybE1XZU9IUm9MNlpFdWhYVmNnc1I2a0pIeE0vbC8zSENG?=
 =?utf-8?B?b1hvc0IweVJsZHBTcUI3aUxxNHJQbEw2TUlIL2NvNzJmOTArSXA4UmFUK0Ny?=
 =?utf-8?B?SVJBTVMwSUNWN3RPN2U5eGFIeWxJRHJsK203WmNPa1o3UWdvTys3eXFlQmtX?=
 =?utf-8?B?UjN5NmFZUUNhRytqeW94ZUw0U0syeTJULzlvcnplaVNBQkhsdlFHRGhSOTNm?=
 =?utf-8?B?WFdtMTZRWU9EaXZKbnF2dFV3ZXdkZGNMNEdyeDdMVm83UDFrVEgybDZhMWdM?=
 =?utf-8?B?OE1qd0Q2R29LZUJMaXErZndJSDVFSW1VTDMwTnhpQUF0dnR6Z3ErYU4zTWMw?=
 =?utf-8?B?MExqSHhRTVdFRENKNzQxclpDSC9VVXNYMGgzNzVZNVd5eVVRTFJ3R28rZkx6?=
 =?utf-8?B?VXFGUnlBNTRlN2R0UnIxRzA2SHNON3ljeHhGUkxVbFk2Tk5SYVdFK2JDcVUy?=
 =?utf-8?B?QWVUb3FTcjVIZllyZXExOFJxL25ZaUpnSldvcnZZSjN0bXhBSkJGWERJTk9K?=
 =?utf-8?B?RnBOTytBUUg5eHY2d3h3L29PMVRmV1BhU1FRcUlMczlFbjBieHA2Zkc2VlB3?=
 =?utf-8?B?aHhZV3owOC9zVzY4UmF4ano5eGZheXkzV2VWbVcvdWxhdEI4dlBGY2tBNVJs?=
 =?utf-8?B?UWJXUzJFS293NzFISnVhWDBGVkVFVEZjbjFwREsvdHhwWE9uR1FDMm9nQ0FX?=
 =?utf-8?B?YlltaUZVOVl6NDgwY1JsYWhLRVRiUWF4R3BTdFpHR3VJS2dHSW94YjBCRjJB?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB3B11BA9B6BC34FB1B43965CE882F55@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8oygDSuZudirPPFoqsIpIcPpWah3naH9QndvsihBwV7aEmJvFaSQPohLd7+el/FJILjzCq9ottUlchDB0O+VeuJ9c8YNaa3Zwu5d8+ES86xQNY3FxRlL2KZGqNqxF6WCI+sMwAXxTNw4Ay95zMBqQ3nUb0TJb3+hx82gOkrQjMUGs7bcxXLymXjX5igbouDK5yOcJTeTjPwbLwZRfGK2BO+9PH/ylR3PqoaN+ZVmIXXPL3kwTCDlaJG40c9KSRid6Wf4XFUJLiztbXn5DM8EzXE74qha4OjJKe8uLYb7iivl3EqTRd+COszYjMVV4MA1P7UBujFBrSSIskq0U0hqNXr+TxDrCgEbjQum7alml25s1eUJvyvoVZq6KAPf42lHlIxR5Xo+maDk0ckO8T2ftlwHTAC3u3CrZ9jNfKtNjMK/itDPW0aq3JMhLSF1lTMQVn1bSDKD370n51E6c3HP+1qR/7iSAHZzwv7NgYFn8E8dt2vjOj01kZhX/+b5x8IiTh5Ngf96UK/us5hEPoy2HvlAxPeWn1CTVqtlwP1wlToA1JjDPPRDOIRqDWBrz/QlPn+LefHeYOLfL18Qz/wMf4SbK6WJY48xnB3LNa0xZyg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca07b4b-5dd2-4989-d858-08dca01ecc28
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 13:55:31.4268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJIIlzDce6KHYLzmdRcQSB/eNi94oWjyqEJw10G4/K3QNuj1fayleS9fxtuSBBeslIs7UiD2MtqK+bjGh/4AMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_03,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090089
X-Proofpoint-GUID: 2Xa4aHRovjVnT9wvp2IKHZ8gopiNIIHb
X-Proofpoint-ORIG-GUID: 2Xa4aHRovjVnT9wvp2IKHZ8gopiNIIHb

DQoNCj4gT24gSnVsIDksIDIwMjQsIGF0IDM6MTjigK9BTSwgU2FnaSBHcmltYmVyZyA8c2FnaUBn
cmltYmVyZy5tZT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+IE9uIDA5LzA3LzIwMjQgMDo0MSwgRGFp
IE5nbyB3cm90ZToNCj4+IA0KPj4gT24gNy84LzI0IDExOjU2IEFNLCBTYWdpIEdyaW1iZXJnIHdy
b3RlOg0KPj4+IA0KPj4+IA0KPj4+IE9uIDA4LzA3LzIwMjQgMjA6MzksIERhaSBOZ28gd3JvdGU6
DQo+Pj4+IA0KPj4+PiBPbiA3LzgvMjQgNzoxOCBBTSwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0K
Pj4+Pj4gDQo+Pj4+Pj4gT24gSnVsIDcsIDIwMjQsIGF0IDc6MDbigK9BTSwgSmVmZiBMYXl0b24g
PGpsYXl0b25Aa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4+Pj4gDQo+Pj4+Pj4gT24gU3VuLCAyMDI0
LTA3LTA3IGF0IDAxOjQyICswMzAwLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPj4+Pj4+PiBNYW55
IGFwcGxpY2F0aW9ucyBvcGVuIGZpbGVzIHdpdGggT19XUk9OTFksIGZ1bGx5IGludGVuZGluZyB0
byB3cml0ZQ0KPj4+Pj4+PiBpbnRvIHRoZSBvcGVuZWQgZmlsZS4gVGhlcmUgaXMgbm8gcmVhc29u
IHdoeSB0aGVzZSBhcHBsaWNhdGlvbnMgc2hvdWxkDQo+Pj4+Pj4+IG5vdCBlbmpveSBhIHdyaXRl
IGRlbGVnYXRpb24gaGFuZGVkIHRvIHRoZW0uDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBDYzogRGFpIE5n
byA8ZGFpLm5nb0BvcmFjbGUuY29tPg0KPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1i
ZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KPj4+Pj4+PiAtLS0NCj4+Pj4+Pj4gTm90ZTogSSBjb3Vs
ZG4ndCBmaW5kIGFueSByZWFzb24gdG8gd2h5IHRoZSBpbml0aWFsIGltcGxlbWVudGF0aW9uIGNo
b3NlDQo+Pj4+Pj4+IHRvIG9mZmVyIHdyaXRlIGRlbGVnYXRpb25zIG9ubHkgdG8gTkZTNF9TSEFS
RV9BQ0NFU1NfQk9USCwgYnV0IGl0IHNlZW1lZA0KPj4+Pj4+PiBsaWtlIGFuIG92ZXJzaWdodCB0
byBtZS4gU28gSSBmaWd1cmVkIHdoeSBub3QganVzdCBzZW5kIGl0IG91dCBhbmQgc2VlIHdobw0K
Pj4+Pj4+PiBvYmplY3RzLi4uDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBmcy9uZnNkL25mczRzdGF0ZS5j
IHwgMTAgKysrKystLS0tLQ0KPj4+Pj4+PiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQ0KPj4+Pj4+PiANCj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2ZzL25mc2Qv
bmZzNHN0YXRlLmMgYi9mcy9uZnNkL25mczRzdGF0ZS5jDQo+Pj4+Pj4+IGluZGV4IGEyMGMyYzlk
N2Q0NS4uNjlkNTc2YjE5ZWI2IDEwMDY0NA0KPj4+Pj4+PiAtLS0gYS9mcy9uZnNkL25mczRzdGF0
ZS5jDQo+Pj4+Pj4+ICsrKyBiL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4+Pj4+Pj4gQEAgLTU3ODQs
MTUgKzU3ODQsMTUgQEAgbmZzNF9zZXRfZGVsZWdhdGlvbihzdHJ1Y3QgbmZzZDRfb3BlbiAqb3Bl
biwgc3RydWN0IG5mczRfb2xfc3RhdGVpZCAqc3RwLA0KPj4+Pj4+PiAgICogICJBbiBPUEVOX0RF
TEVHQVRFX1dSSVRFIGRlbGVnYXRpb24gYWxsb3dzIHRoZSBjbGllbnQgdG8gaGFuZGxlLA0KPj4+
Pj4+PiAgICogICBvbiBpdHMgb3duLCBhbGwgb3BlbnMuIg0KPj4+Pj4+PiAgICoNCj4+Pj4+Pj4g
LSAgKiBGdXJ0aGVybW9yZSB0aGUgY2xpZW50IGNhbiB1c2UgYSB3cml0ZSBkZWxlZ2F0aW9uIGZv
ciBtb3N0IFJFQUQNCj4+Pj4+Pj4gLSAgKiBvcGVyYXRpb25zIGFzIHdlbGwsIHNvIHdlIHJlcXVp
cmUgYSBPX1JEV1IgZmlsZSBoZXJlLg0KPj4+Pj4+PiAtICAqDQo+Pj4+Pj4+IC0gICogT2ZmZXIg
YSB3cml0ZSBkZWxlZ2F0aW9uIGluIHRoZSBjYXNlIG9mIGEgQk9USCBvcGVuLCBhbmQgZW5zdXJl
DQo+Pj4+Pj4+IC0gICogd2UgZ2V0IHRoZSBPX1JEV1IgZGVzY3JpcHRvci4NCj4+Pj4+Pj4gKyAg
KiBPZmZlciBhIHdyaXRlIGRlbGVnYXRpb24gaW4gdGhlIGNhc2Ugb2YgYSBCT1RIIG9wZW4gKGVu
c3VyZQ0KPj4+Pj4+PiArICAqIGEgT19SRFdSIGRlc2NyaXB0b3IpIE9yIFdST05MWSBvcGVuICh3
aXRoIGEgT19XUk9OTFkgZGVzY3JpcHRvcikuDQo+Pj4+Pj4+ICAgKi8NCj4+Pj4+Pj4gaWYgKChv
cGVuLT5vcF9zaGFyZV9hY2Nlc3MgJiBORlM0X1NIQVJFX0FDQ0VTU19CT1RIKSA9PSBORlM0X1NI
QVJFX0FDQ0VTU19CT1RIKSB7DQo+Pj4+Pj4+IG5mID0gZmluZF9yd19maWxlKGZwKTsNCj4+Pj4+
Pj4gZGxfdHlwZSA9IE5GUzRfT1BFTl9ERUxFR0FURV9XUklURTsNCj4+Pj4+Pj4gKyB9IGVsc2Ug
aWYgKG9wZW4tPm9wX3NoYXJlX2FjY2VzcyAmIE5GUzRfU0hBUkVfQUNDRVNTX1dSSVRFKSB7DQo+
Pj4+Pj4+ICsgbmYgPSBmaW5kX3dyaXRlYWJsZV9maWxlKGZwKTsNCj4+Pj4+Pj4gKyBkbF90eXBl
ID0gTkZTNF9PUEVOX0RFTEVHQVRFX1dSSVRFOw0KPj4+Pj4+PiB9DQo+Pj4+Pj4+IA0KPj4+Pj4+
PiAvKg0KPj4+Pj4gVGhhbmtzIFNhZ2ksIEknbSBnbGFkIHRvIHNlZSB0aGlzIHBvc3RpbmchDQo+
Pj4+PiANCj4+Pj4+IA0KPj4+Pj4+IEkgKnRoaW5rKiB0aGUgbWFpbiByZWFzb24gd2UgbGltaXRl
ZCB0aGlzIGJlZm9yZSBpcyBiZWNhdXNlIGEgd3JpdGUNCj4+Pj4+PiBkZWxlZ2F0aW9uIGlzIHJl
YWxseSBhIHJlYWQvd3JpdGUgZGVsZWdhdGlvbi4gVGhlcmUgaXMgbm8gc3VjaCB0aGluZyBhcw0K
Pj4+Pj4+IGEgd3JpdGUtb25seSBkZWxlZ2F0aW9uLg0KPj4+Pj4gSSByZWNhbGwgKHF1aXRlIGRp
bWx5KSB0aGF0IERhaSBmb3VuZCBzb21lIGJhZCBiZWhhdmlvcg0KPj4+Pj4gaW4gYSBzdWJ0bGUg
Y29ybmVyIGNhc2UsIHNvIHdlIGRlY2lkZWQgdG8gbGVhdmUgdGhpcyBvbg0KPj4+Pj4gdGhlIHRh
YmxlIGFzIGEgcG9zc2libGUgZnV0dXJlIGVuaGFuY2VtZW50LiBBZGRpbmcgRGFpLg0KPj4+PiAN
Cj4+Pj4gSWYgSSByZW1lbWJlciBjb3JyZWN0bHksIGdyYW50aW5nIHdyaXRlIGRlbGVnYXRpb24g
b24gT1BFTiB3aXRoDQo+Pj4+IE5GUzRfU0hBUkVfQUNDRVNTX1dSSVRFIHdpdGhvdXQgYWRkaXRp
b25hbCBjaGFuZ2VzIGNhdXNlcyB0aGUgZ2l0DQo+Pj4+IHRlc3QgdG8gZmFpbC4NCj4+PiANCj4+
PiBUaGF0J3MgZ29vZCB0byBrbm93Lg0KPj4+IEhhdmUgeW91IHJlcG9ydGVkIHRoaXMgb3ZlciB0
aGUgbGlzdCBiZWZvcmU/DQo+PiANCj4+IEkgc3VibWl0dGVkIGEgcGF0Y2ggdG8gYWxsb3cgdGhl
IGNsaWVudCB0byB1c2Ugd3JpdGUgZGVsZWdhdGlvbiwgZ3JhbnRlZA0KPj4gb24gT1BFTiB3aXRo
IE5GUzRfU0hBUkVfQUNDRVNTX1dSSVRFLCB0byByZWFkOg0KPj4gDQo+PiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1uZnMvMTY4ODA4OTk2MC0yNDU2OC0zLWdpdC1zZW5kLWVtYWlsLWRh
aS5uZ29Ab3JhY2xlLmNvbS8gDQo+PiANCj4+IFRoaXMgcGF0Y2ggZml4ZWQgdGhlIHByb2JsZW0g
d2l0aCB0aGUgZ2l0IHRlc3QuIEhvd2V2ZXIgSmVmZiByZXBvcnRlZCBhbm90aGVyDQo+PiBwcm9i
bGVtIG1pZ2h0IGJlIHJlbGF0ZWQgdG8gdGhpcyBwYXRjaDoNCj4+IA0KPj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtbmZzLzY3NTZmODRjNGZmOTI4NDUyOThjZTRkN2UzYzRmMGZiMjA2
NzFkM2QuY2FtZWxAa2VybmVsLm9yZyANCj4+IA0KPj4gSSBkaWQgbm90IGludmVzdGlnYXRlIHRo
aXMgcHluZnMgcHJvYmxlbSBzaW5jZSB3ZSBkcm9wcGVkIHRoaXMgc3VwcG9ydC4NCj4gDQo+IEkg
c2VlLCB0aGFua3MgZm9yIHRoZSBpbmZvLiBJIGluaXRpYWxseSB0aG91Z2h0IHRoYXQgdGhlIGNs
aWVudCBoYXMgYW4gaXNzdWUuIEJ1dCBub3cNCj4gSSBzZWUgdGhhdCB5b3UgcmVmZXJyZWQgdG8g
bmZzZCB0aGF0IGlzIHVuYWJsZSB0byBwcm9jZXNzIGEgUkVBRCB3aXRoIGEgd3JpdGVkZWxlZyBz
dGlkDQo+ICh3aGljaCBpcyBhbGxvd2VkKS4NCj4gDQo+IElzIHRoZXJlIGFueSBhcHBldGl0ZSB0
byBhZGRyZXNzIHRoaXM/DQoNClllcywgYXMgYW4gTkZTRCBjby1tYWludGFpbmVyLCBJIHdvdWxk
IGxpa2UgdG8gc2VlIHRoZQ0KUkVBRCBzdGF0ZWlkIGlzc3VlIGFkZHJlc3NlZC4gV2UganVzdCBn
b3QgZGlzdHJhY3RlZA0KYnkgb3RoZXIgdGhpbmdzIGluIHRoZSBtZWFudGltZS4NCg0KDQo+IE9y
IGFyZSB3ZSBmaW5lIHdpdGggbm90IGhhbmRpbmcgb3V0IGRlbGVnYXRpb25zDQo+IGluIHRoZXNl
IGNhc2U/DQoNCldlbGwsIHdlJ3JlIGZpbmUgaW4gYXMgbXVjaCBhcyB0aGUgY3VycmVudCBzaXR1
YXRpb24gZG9lcw0KYWxsb3cgTkZTRCB0byBoYW5kIG91dCAvc29tZS8gd3JpdGUgZGVsZWdhdGlv
bnMuIFdlIGtub3cNCnRoZSBvcGVuIHIvdyBjYXNlIGlzIHdvcmtpbmcgY29ycmVjdGx5LCBhbmQg
Y2FuIG5vdyBtb3ZlDQpvbiB0byB0aGUgbW9yZSBvYnNjdXJlIGNhc2VzLg0KDQooTGlrZSwgSSB3
b3VsZCBsaWtlIE5GU0QgdG8gcG9wdWxhdGUgdGhlIGRlbGVnYXRpb24gQUNFDQp0b28sIGF0IHNv
bWUgcG9pbnQpLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

