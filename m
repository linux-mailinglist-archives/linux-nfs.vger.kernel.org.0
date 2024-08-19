Return-Path: <linux-nfs+bounces-5472-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A70A957500
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2024 21:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D74281DDE
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2024 19:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39FF188CC5;
	Mon, 19 Aug 2024 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X3dG4tkr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EsIIR8YL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA854196C9C;
	Mon, 19 Aug 2024 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097099; cv=fail; b=TbNmb+Ul9kgzT9jiVc0fS/u4v43a1NHzQki23QLVOXccUWocQJB1uEHDRJH7prYCikapX6bVsyU74AOMSHSr70cJmGimVvmx7gec221U1A7nRmilVfZ9Jj2MOmAj7yCkwteRVgM8sLzbxZ6VQiFhl/NP7NDTRcpaVjv3fKaiuEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097099; c=relaxed/simple;
	bh=56Us0nJG8/MwW7+jZ2HYvNb40wHqPACEPnM8b9limjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GAl2YcTWlLWn0gZrX9obkUna/ibnmMWZHszZ52eF4hHjylXio+MjEHacIhnO1NIMWxa5CGCERLjiGHyJqOeJbKYmvQM1wY1obK/UhftU4nvrYDNPIRgctv7SSL8Q4HupIhiijZf4Z4+JZy5ZL5HI8yqFJgN6fP+wWdqhlKmipsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X3dG4tkr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EsIIR8YL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JIK6Nd027058;
	Mon, 19 Aug 2024 19:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=56Us0nJG8/MwW7+jZ2HYvNb40wHqPACEPnM8b9lim
	js=; b=X3dG4tkrx3wBBn9dEO/DiRJgRXSzPMa/e2g6Kgn4nuWssz6m3qFrFm235
	iaEZ8gKICp2OCh4pOrfgZNfrjWbLkn20gnRywWLPXK6khrI8jD4qtd8vDBQb6IH5
	1ate09slgEIWqkM+JUzWErL+/n3n1Ate5PL6js9g9/dp/+u/JxCM3mVLqlBpAMMA
	M3fVeHpUtYSfYsb7G2lRX9XMNnAJB44BfOWAjl0pqIWacZR/d9zEIzdIV79VXbRE
	qWBT14UZv32fkxQhF0TCl8Y45OUTPBScH0SI4e6bFBuM6FEEWyNf+CNTvlG6IBtf
	fY4PtPuCO8jrMStE+SpHNbWM0bPKA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3hkej7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 19:51:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JJTCRj007806;
	Mon, 19 Aug 2024 19:51:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 413h3pmdvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 19:51:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gw1GAkzvr8tZrVhf1r6b7fOXEKndFMzAwjyuzS2jEzj/9zpkV3fOJEF2gZ7GYKyK0JP5PnkMg7qb1pFSu7unYpc31f/mkySIJPVffgCA0fjiS2tI/PHkTcpwvZBNYWHlrf4KVpwyklQFN9vswbUkUwTIWn+VerIxCc7fHY1rCa1V8kd/BzW7EAHkUj7dloALQPlaTi0cwBlE1ZbpjPf7WMdJvcB3TEV7gueLPryMGzu9Fjwybt4NhgP4RYibLMwasYoBP+6UlERt/E+W7WjFdmU4X4iU2b4HPWPWw9fT2X+z67SmLEj6lK4vBnPeKQb0qjK47W5mdfirBkTpEPNkOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56Us0nJG8/MwW7+jZ2HYvNb40wHqPACEPnM8b9limjs=;
 b=Jj4iNnDU+JqOc/+Bz5URPKUnDFcLYXkbhtg0Z4za6oCKoOgSLqSH/4dOpxqUTlDYA8aPdQdpYtf6bE2LNO2mufKuOuRqI5xVXBF5pbD8gNMImnWQyhm4gLJJ6XWbQMFM9l/HbY6Xh0gVIZQvAv2WKph0flWypbG+AYe/mjRFwDAR0h/XS3q9aiDv7OBGr6iogDUdcFJ2IbZoouOKYDFe1HcUGc3QTGDNOwd9T0jFv6dVvmRzywb2IIEI61cVlz8uEkdbnFz/CQekAE+F/bJhRfBBE3WdljhHgDlQfYKP3IjsrOipX1CYKl2m5AS+HzBA3+3iqSdtTRl/rq8wxcE0SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56Us0nJG8/MwW7+jZ2HYvNb40wHqPACEPnM8b9limjs=;
 b=EsIIR8YLa8q/QHrSgZ16TFa3P1XgBq8yOQcTdbZxasWNt89PRk3w1rK4JvJlWf1TmQltkyyVQcm5iDNdy3yWdGw7ffQZtcLF8YyBiz3BtHXCbH2Wci3oOlI9sDzK5HW8Fq8r1LQqK2y8zLbwsh7CKwppcRxMYUQJ4raXk4P91wI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4495.namprd10.prod.outlook.com (2603:10b6:a03:2d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Mon, 19 Aug
 2024 19:50:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.010; Mon, 19 Aug 2024
 19:50:23 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Neil Brown <neilb@suse.de>, Dai Ngo <dai.ngo@oracle.com>,
        Olga
 Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Trond
 Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Tom Haynes
	<loghyr@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] nfsd: bring in support for delstid draft XDR encoding
Thread-Topic: [PATCH 1/3] nfsd: bring in support for delstid draft XDR
 encoding
Thread-Index: AQHa79nI8OZMU5h3VEKSAxjt3QjJK7IttuIAgADDuYCAABsBAIAAAXqAgABrOYA=
Date: Mon, 19 Aug 2024 19:50:23 +0000
Message-ID: <3DB9A299-B55F-45BB-8B28-65F44F14F6A2@oracle.com>
References: <20240816-delstid-v1-0-c221c3dc14cd@kernel.org>
 <20240816-delstid-v1-1-c221c3dc14cd@kernel.org>
 <172402584064.6062.2891331764461009092@noble.neil.brown.name>
 <6c5af6011ea9adfd45abe4b5252af7319a3dbc94.camel@kernel.org>
 <E7E5447E-AD50-437D-8069-C77FFF516DCE@oracle.com>
 <f0ac4b0489da5f6198cb7c70f312e2889e97ea4e.camel@kernel.org>
In-Reply-To: <f0ac4b0489da5f6198cb7c70f312e2889e97ea4e.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4495:EE_
x-ms-office365-filtering-correlation-id: de297458-39b6-40bb-312b-08dcc0882a19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bUVaOHpDZzlGa21oc01rWHpvNDhtMDVYNTd1aHNxYjQ0ajhROXM2R1E4ejB5?=
 =?utf-8?B?RzY5ZjNQKzRXdDFBVGtIZnlLVEJ5UlJVVFdUZ01EcjlCMnFxWm1YaEFxNWVN?=
 =?utf-8?B?aDdQV1FBbDFNcHEvR3AxNFhPV1BnTnQrN1hMWFgvcHVJUlZwajBkcFlXMW93?=
 =?utf-8?B?eUNFcXBCL3RDVmtiNGZuUDhCcGNvYmpTUVBvelU2N2tQRjlWQ1M5TzZnYXNO?=
 =?utf-8?B?bEE4QklrQzJ2aFowSWpSeHl0NW9ZZTY5eW9sZUw3KzBDNXlwQitpSGxDSUFO?=
 =?utf-8?B?dHk5bGRwQlJBeGZkeWNPK0J2T2M4RE14bmpPZ0o3STBqY2pUNzNGUWlzRkYw?=
 =?utf-8?B?bG1DN3JKTGhpMUJnVitiZGw2dC9LVlBLcUo2MThBa2ttcXorTDFDRGlmVXR5?=
 =?utf-8?B?aWkzMHNTR2dybXI4ZmRpL0VCdG1GOE9QVjRkWjFlaHJaSkhtTVd6cXZ3THpI?=
 =?utf-8?B?akdzOGl4YndKNGc4RmwvMTBualIveGVZcEZmbXZPcHRHQzNLeGx5S0xOUFlH?=
 =?utf-8?B?R2RRNjhTREhOZ0NJbjJtNThqdU44cm8xSXBpeXhGZmVPSHpUOU5hQjBrdk5N?=
 =?utf-8?B?RlozMFpiLytHcmNZbVNhQ3duQW05bmpRYkhOVDZDUWNuS3djcVhnY3RIV1RU?=
 =?utf-8?B?RGc2QUh1Q3NxbmdvenRYNUlQMnRTYjZKWThJalY5WVVDTER3WCtRK3JkenBi?=
 =?utf-8?B?MmE4RnRYTUxOdCszWDZYMTRQTGhzSGxIU2p5KzY4a010d2svakdrbVhiMm9p?=
 =?utf-8?B?QTZQbGUzRE5Sc3FqRTZMZEh3blc1TUhWYjZlaUtWK0ZFS0xISTlKemJzM0p3?=
 =?utf-8?B?cUVtWUFybXJ4dTNMNFUyMy8zZ0Y5VWlHejdJWXZqNWI4YWttTFpmS1lZVURO?=
 =?utf-8?B?NFp4LzJLcFlWQjdKc2M4Q3k0WjZuZjJJS2dJdjM5dVdURmY3L1djN2RtSDNt?=
 =?utf-8?B?WDAzMmVZa0wyc01mUm15c2pON1lOTHdtTFFtblNmczJkcjdmeFpHdklUNm1U?=
 =?utf-8?B?NlNXa3BXbDhUaWZWaHB6MkIxclcwRlFyR1hzY0xxNnJha3dhUFhmbkxPUzRt?=
 =?utf-8?B?bWxXUnRwVEUxVkl0ekhCemJyNVl2dHhobFNLYWYyRGFNZm52WGsxYTJ0K0Za?=
 =?utf-8?B?OWhKUG1Cczl4V0hGMG1zUDdoVkVLUmV5d2ZlT3dIZVladFE5VGRSTkxtYnln?=
 =?utf-8?B?Nm02aVh3M2FGMHVnMFIxRFdaRVlkQVVhSWw1RTBJRkVJWGpLUlNZZzR4aEZN?=
 =?utf-8?B?eHBPNElKdHB1REZsQ0RkVWxpeEVIZUhCU3RTVHNWOUFLaEw0U1B0S3Zldm9V?=
 =?utf-8?B?WlBMUk8vbWg5M3FtNHBPa3JxQmYwWDRNN0hZcFBKOTBWMEZlUG5RY0hGSUtP?=
 =?utf-8?B?USs5ZDJrK2lFUDZoKzhhNGVlQzFLQWVSbkNGMVFWdzAvTmNRRHg5eEoxN2li?=
 =?utf-8?B?Q1BOZTUwQk9UZUdVZ3hvN05rdEg0WHlBN2UrckQzWXNYaFRnNVB2SE8yRURi?=
 =?utf-8?B?K1dDQTNNZUF3NFl4SzFFN0p2cGdSb3JOdFJCY0IyOXU3b2RhSnIrVDZ5U2tm?=
 =?utf-8?B?WHJWb3lQTURGZUkyNmpJV0R3UXdsY2VJVnREN2gweXZRdGwrM2l0a0lxQ0Jx?=
 =?utf-8?B?YWh6MFVjd2x2SVdtUUdVZlBzSlVMdEcvS21pbUM0aTBhQTAzcTRpSTNCMnkv?=
 =?utf-8?B?VStpRGNuaUhRZ3hoQU9MVFhoUDNVKzVtbml5YlpFNHdXY2dyTTFGMzFZOEdz?=
 =?utf-8?B?VlJycFk0c2t5cm5QVGNwdFNiM2VBQ1ZUT0pDRjNPWWNSY0Ztb3VyaU1LQndl?=
 =?utf-8?B?bnlSNjRsdlJvQWpzamlHbFFxVEFQQm5WMUt6T1h6TXpuNTVxd20wQjNwMVg0?=
 =?utf-8?B?TTE4VmZHZzlJQXFyR051azRSNzNCekxtQUhEdGtqUGYxNGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qmg2THlCWmc3eUljQ2xkZHh4L1VNOWtocjE3SHVSbUprU3k2WDNsMEpzRHli?=
 =?utf-8?B?dWFhRUdMY3ZuU0s0L3c0MDhpQnN4NElPV1doWkRlbCs2MWRiUEdSZUxKK0Qv?=
 =?utf-8?B?Qm4xdU9pNjNQV0Judm9GL1hSNGcwcVp4dzl1dnBDeVZpVDhUa0kybW14cXhX?=
 =?utf-8?B?UWx5WDIwNktRTzhuRGY4UXpTd2xOZE1WaG5oN0FpSjlBN1JaQWVteFdENmJa?=
 =?utf-8?B?WHNmTVFvS1RiNmpTVE5zV2pMTjV6M291eFBUWFJtVGc5Sko1U2crU09pelU4?=
 =?utf-8?B?aVo1NlVORTMwUnpUVy9CS1YrUHhBbDVSSTNXK01nWDBrdldMZjd3OURYMDR5?=
 =?utf-8?B?SlJ6SUFMZkdyeGgwaXpjam9vdU1uUEZ3cC95Ykp1bU43dzc1L3d1aFdPcDhz?=
 =?utf-8?B?bFl5SWtJYXpCZXpteEVERmhKcXJ2Vi9uWFU3bnFvSzV5a1FQeEkvS1BNQnVw?=
 =?utf-8?B?UitQR01jRWJpYTBYNm1wRjhjRCsrN3FjRDZvOVZQSkFZT0FSTmE5ZUNXcERK?=
 =?utf-8?B?d3dKMGdEWVUyaDNHQndOd25uVlVIbTJSOTBlR3JGNGFldGxaRXJ0TnFyeXY4?=
 =?utf-8?B?SGNaMGh5am51YWtsbFRUelhEbzczZXd2YWpkejZVWkRNOEpPVzRtMGxXM1h0?=
 =?utf-8?B?cFo4UTJqc0hvYnZBbmxKRGtjTTY2NHZySitOWmMvR0p2eTlFUjQrSkFkODRi?=
 =?utf-8?B?NXBJMytlU3YxbjJkUVlWSjk5N0Zsb3RjbG14cEc1dmtFUnFlK1ZQK0tyZklR?=
 =?utf-8?B?WWxqS1prVXNuTDFZZitEYVVHbnVBNldLMnIzRG85M3pSd3YycXBQNyttTVlC?=
 =?utf-8?B?eWRUN083UkRTQTE1RnFLM1FLaVd1V2UxVTh2ek9ibXV1dVlMYzcyYXE1dEY5?=
 =?utf-8?B?dGg2WVp6YWtzQUZKOEtxWVBJMk5PTjk1NEFsSzlxT3FYaFpEdEZuQ0kxbDlY?=
 =?utf-8?B?b01YYjBSbVFlUkRGTlVXYnJjM3RzWHlhT3ZYN3luSVlNaWdpa2tGaWFmSVBP?=
 =?utf-8?B?R0dOYkdmbGZvU0FnTHAxeVlad2FyZEhLWUZWQW04ZFNnRmFzTUhVR0I1T2ZF?=
 =?utf-8?B?ZnhzMG1pc01BdGxuRjlIK0pwQ3dzc2h4SytiTGo0NGcyRGE3VXoxTDE3RktW?=
 =?utf-8?B?OVhkWUxOT3JPRi9CRVduZWdIQmZuSmUvb3h1YWZlMW4wdUZidWU2SDh0MW5w?=
 =?utf-8?B?TnY4SDRZbmtKWWJSOUtRS1N3bHFmS2RjaUtPbmdIV3EwcGUwb1Z6TENGcmJT?=
 =?utf-8?B?TnBMZFdPNWVCZm93T29BMGxNc1Fsc2ZzYUQwejVUaEhFSjlvc1owYkpsSmNr?=
 =?utf-8?B?aDBTelZTczRlUlZkZTZ0Zy9KcERxN2wxSXhwbHpIeVRWYllDaVVFOHlReEpx?=
 =?utf-8?B?ZHFsTENXRGtiaDh0M1VNd1FsaEE1c1hNWmV5NlN3cjlEbjJQa21UUXUvbk5S?=
 =?utf-8?B?SVFCcDE2WG5KSjkrZFVRcGRLQzY2Z2M1Uk8ySW0yTFhiQlVXWkR2QXJSdGN3?=
 =?utf-8?B?YURjamgxQ25QYm4yUEFuekZSN2tmN05TV2tEYS9pV0FrdVFVVGlOWEY4UUov?=
 =?utf-8?B?bHd5ajJCSGsvVExrLzFpTGVwaWJaVVZnRGkwMm1CN1E5WWFUSWxEK2ZIZVps?=
 =?utf-8?B?MlJtTUNYekE4MEN2Q1BjZ2dEalpsd1NVRG1QNGdMazBOWFppUVJ6V3ZJOWsx?=
 =?utf-8?B?SGVROUg1Vjh4a3ExbDlhaksrZ2M3Qk1DdTBHT0pnandxWTYxY3NOQXJ3NDRP?=
 =?utf-8?B?VU1HK2w0VWJBUFE5N2JERXBvY0JoYXdjLzA0OG4wYW9OUm5SbGxrRzMzcW1Y?=
 =?utf-8?B?bnJlaW9ZUjJiZmFRUkgzZlQrRGRTY2NrT3hod2g4VElISnlQQm1ZU3pjc2Fl?=
 =?utf-8?B?VzJLQXJFWlRHWnpic0ZvcFplVGVwUjZWQ1gzZzJoa2Ria0dyQVdtdkNuSGQ5?=
 =?utf-8?B?YXpTUDZkSGxVZ3NhM2w0bjBzQVVkejJqd1A2b0xMeW9xVFhhRDh6aEZJeDNv?=
 =?utf-8?B?enZXVXVHNUdSWitxc2RwdUM0L3lLU3BuU0Jxa0JYMzI5Q1JXQzk1SzNEc09q?=
 =?utf-8?B?Q1dRQXp0enF2b0NhQ2JyZjNsY0QxUisyL1R1UDRQYmlFa2F3WkdjWkxNN2o0?=
 =?utf-8?B?cVVPaEZOOVFPL1d1Sk04R1Z0MWErK3VaeVNTRTBGTDJ5bSs5MXZydEdTbXRL?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71835AD7E79C1147A2D3881EB0565911@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xmvPUtdokAjcCzFbxOhj88SoukK2nnoaQZ4D8bCHNbfHjEMCUwyrvuCdu3zUGE43UMPLZYqdbKDjtJhGuEbbOguZAsL+se1DTxCBcxUeBE8XXUDDU9AJmVpo6IiI4CtWAZQj9ORQXchcguZyxEEOKx4Bbs0aE5+yw/tYOjbFb629Xtf91s27ewsPV3YFCyLQfV6oa+egGmExjiDOnDX8rUeifnGLt3sKZkcxbFpmR7bvAX0hFY0MA5bi8uCKhrGhTx023UyfBCSMGSCWBn7CepzuAIsJeFs5mSkeNPXsADs/tDsZcmqMUhAPlnZQLGDFvQdcnokPR2R3S+6g0q22ZRONVHSHoLQXsLW91liICJv9YcpYPw6TWiyulHXn0staToS49FiUMRISWcydSHpijWhadyZE/IsBWfta1LgNe29eUXMacwbZb+i47dMLr6UMyj4/Z+jz8fXPuHImAaK+RIzgvY/Q+HVl7cLimiStTWDz7x77fo8MJ4163a6GeNePAOFn8CoxahaA+8nLc0jLazk+lKFhrGUHijPzF0WTalIO6F9296YM0V9ZvhQ9qp5npThgNraJ+kSwyELLIiJzPLMr0NDKNzoIvtATjj+3aHQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de297458-39b6-40bb-312b-08dcc0882a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 19:50:23.3803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZgt7ZSUnKoxVjSTQEbmAwyf7sXmWMeYHFAcHztsat0a5EOo8Q+uLKyZ4PB4u6lq6qOgUeeCc/iFOi8p8yRnjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4495
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=965 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408190135
X-Proofpoint-ORIG-GUID: KudjGkNYtaojjmnEgwl4-tTF61o-UDLN
X-Proofpoint-GUID: KudjGkNYtaojjmnEgwl4-tTF61o-UDLN

DQoNCj4gT24gQXVnIDE5LCAyMDI0LCBhdCA5OjI24oCvQU0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gSSdtIHBsYXlpbmcgd2l0aCB0aGUgbmV3IHZlcnNp
b24gbm93IGFuZCBpdCBzZWVtcyB0byBiZSBtdWNoIGltcHJvdmVkLg0KPiBPbmx5IHR3byByZWFs
IGJ1Z3MgSSd2ZSBoaXQgYXQgdGhpcyBwb2ludDoNCj4gDQo+IDEvIFNvbWUgb2YgdGhlIHN0cnVj
dCBzcGVjaWZpY2F0aW9ucyBuZWVkIHRvIGJlIHR5cGVkZWZzIGFzIHdlbGwuIEZvcg0KPiBpbnN0
YW5jZSwgdGhlIGRlbHN0aWQgZHJhZnQgcmVmZXJzIHRvICJuZnN0aW1lNCIsIGJ1dCB0aGUgYXV0
b2dlbmVyYXRlZA0KPiBzdHJ1Y3QgZGVmaW5pdGlvbiBkb2Vzbid0IGhhdmUgdGhlIHR5cGVkZWYg
Zm9yIGl0LiBJdCBtYXkgYmUgYmVzdCB0bw0KPiBqdXN0IGFkZCB0eXBlZGVmcyBmb3IgYWxsIG9m
IHRoZXNlIHNvcnRzIG9mIHN0cnVjdHMuDQoNCldoYXQncyB0aGUgc3BlY2lmaWMgc3ltcHRvbT8g
SSd2ZSBiZWVuIGFibGUgdG8gY2F0ZW5hdGUgbmZzNF8xLngNCmFuZCBkZWxzdGlkLngsIHhkcmdl
biBidWlsZHMgdGhlIGhlYWRlciBhbmQgc291cmNlIHdpdGhvdXQgdG9zc2luZw0KYW55IGV4Y2Vw
dGlvbnMsIGFuZCBnY2MgY29tcGlsZXMgaXQgd2l0aG91dCBjb21wbGFpbnQuDQoNCkFGQUlDVCwg
eGRyZ2VuIHdpbGwgYWRkICJzdHJ1Y3QiIHdoZXJlIGl0J3MgbmVjZXNzYXJ5Lg0KDQpJJ3ZlIGJl
ZW4gc3F1aXJyZWxseSBhYm91dCB1c2luZyAidHlwZWRlZiIgdG9vIG9mdGVuIGJlY2F1c2UNCnRo
ZSBMaW51eCBrZXJuZWwncyBjb2Rpbmcgc3R5bGUgaXMgdG8gYXZvaWQgQyB0eXBlZGVmcyBmb3IN
CnNob3J0aGFuZCBzdHJ1Y3R1cmUgbmFtZXMuDQoNCg0KPiAyLyB4ZHJnZW5fZW5jb2RlX25mc3Rp
bWU0IHdhbnQgYSBwb2ludGVyIHRvIHRoZSBuZnN0aW1lNCwgYnV0IHRoZQ0KPiBhdXRvZ2VuZXJh
dGVkIGNvZGUgZm9yIHhkcmdlbl9lbmNvZGVfZmF0dHI0X3RpbWVfZGVsZWdfYWNjZXNzIGFuZA0K
PiB4ZHJnZW5fZW5jb2RlX2ZhdHRyNF90aW1lX2RlbGVnX21vZGlmeSB0cnkgdG8gcGFzcyBpdCBi
eSB2YWx1ZSBpbnN0ZWFkLg0KDQpIZXJlJ3MgbXkgZ2VuZXJhdGVkIGNvcHkgb2YgeGRyZ2VuX2Vu
Y29kZV9mYXR0cl90aW1lX2RlbGVnX2FjY2VzczoNCg0KLyogdHlwZWRlZiBmYXR0cjRfdGltZV9k
ZWxlZ19hY2Nlc3MgKi8NCnN0YXRpYyBib29sIF9fbWF5YmVfdW51c2VkICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeGRyZ2VuX2VuY29kZV9mYXR0
cjRfdGltZV9kZWxlZ19hY2Nlc3Moc3RydWN0IHhkcl9zdHJlYW0gKnhkciwgY29uc3QgZmF0dHI0
X3RpbWVfZGVsZWdfYWNjZXNzIHZhbHVlKQ0Kew0KCS8qIChiYXNpYykgKi8NCglyZXR1cm4geGRy
Z2VuX2VuY29kZV9uZnN0aW1lNCh4ZHIsICZ2YWx1ZSk7DQp9Ow0KDQpMb29rcyBsaWtlIGl0IGRv
ZXMgdGhlIHJpZ2h0IHRoaW5nLi4uPw0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

