Return-Path: <linux-nfs+bounces-4635-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DCA9289DD
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 15:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456E31C23DE9
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 13:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCFF14A096;
	Fri,  5 Jul 2024 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aiT8505E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bg0JuDMl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C20E145FFE
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jul 2024 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186533; cv=fail; b=euByEKmw6J7unAPPRor0zrewatly0rXu+smrUTYK+wtHvgRDiLTTiE3/Pbo3C0hEEiDjR8hRVA1qgI/hP+cd8hXH9C470Q0t9weBWwDhHS146gqWJU1rZ9iM9zHWb9fhBV5zkO/XwyXZS1nJws63G7FFIKxHL6GssryMa9z1/Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186533; c=relaxed/simple;
	bh=pN52fQLV14PJgM1iJCF7ahiD4hZ/v3oNDQtVh7VUJuI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I2v8mHiQh8oQ4I4aSpWS5qk6AmS2LsyGxHQRkIZ/wffg0PESGh1kG1Mk+Dvgo0HYY5BuweTHhyZUBlF+0g8xOT2jFD60UB/ZBofcsS+1D09FjzvPqN/7rW5mXKAMV4D4YCLuKO9MPK3zIZ7dEEVwcfAHELiQy9grXaMiVdRxFtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aiT8505E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bg0JuDMl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465CtS0w007752;
	Fri, 5 Jul 2024 13:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=pN52fQLV14PJgM1iJCF7ahiD4hZ/v3oNDQtVh7VUJ
	uI=; b=aiT8505EQ3lYEBwM8R2/41DkTZxKTbM1YfH8fCEncYTDUb+m23lxKiEHU
	PeXzK0QJYBcaJxRIkW+0Cit1MXvtzp63bsSqEZu7ZP/C0s5eV3czaLmImlZpnw5a
	m2ECcrhpcIOG9IAkoW8xGDdc2cnRIEeoz0t8dSOk/MxvPJnpSL8wX5k6CLPoPvde
	mgP1v5iIYk5HBzf27QYz6r9E7N8CLa8YyYag0FYeDRCxHLfmqWMJJXuCWfPgL1/8
	eDVpbXFay7jBXYk3LWOydmZL3eWlt2KdKVhqdQy9TcJKYLlZSiK72ybeNpSx25C4
	9pxA78/0y60K8LIeg29AbrjRljwpA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029233x3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 13:35:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465BFxZl010273;
	Fri, 5 Jul 2024 13:35:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qhs443-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 13:35:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JT80by0Odr1s8luj2FGmvNKbpQ6bBebwU1zVrHNPIZ6YZnEv1Zwqj+hrBBgB+//1XGEmM0v+phC8f7FC7UjD7dr5JLwh6F1a9GN8XUGCH/6YfSmIdFK7lcxRuDhVfInixEu27CU3sDxZRsdToVpszXbjkgXVr+dToAQpqNjslWLUPdcO+6RFjkwGr34SXW6byGQ4+PKY6iOOnVck13UXSuNWobsjSniD9WuogvJ2mjwM4TTNpThjaMCu97rcKM5eadUH60kkPDjMkwoLUxIPJ31GJzEGOaLq46gN+yw0v9bzqkbxjO5fQC3brIcRNEXkHmAOaAj0elrVj5nWBQWaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pN52fQLV14PJgM1iJCF7ahiD4hZ/v3oNDQtVh7VUJuI=;
 b=AB87qdTQWzNyWPX2Tgw4sfA9tL3lb5a0aDyLTxxGuZf0uR4ODs+ZU76OS6i5WLZU81CLFQo2FWjzQUs0jDep2FB4UFmGicgI7f2hz1tfeVgAcw2OJVGH44d+l7qabMGrgX4xzLb+MdNOIDo3ZfZUoZgomoj2pnkbpvt6bVqwbUmrSK+2D+enWVnmjiQmIw9DgffyBEzvXFVgxY/tI8FyOV2xMD/3wtOh+C1Lv+M4PTJf2CO84lyIq4LgwhW/8gOKV6xIGKOP+kkUG9QgzJGtbJ4bOMC2IHYZrVQiG7yPMx91NCWETiswRxYwEodYJIgvcRr98CK57z659ayohpm2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN52fQLV14PJgM1iJCF7ahiD4hZ/v3oNDQtVh7VUJuI=;
 b=Bg0JuDMlf5GMh13LSvkIOr6Zsj2nXUTfiZcs1pI1cWyRZfljypbZ9ESyvD5YgzffO/sMk3JYR4URfLrrQhUga8+lskbaAH4dfzM0gnQaqqeeRY/W8wW85DO+DmGHMreRyk6f4I9zMMpsx+LwVz4alP98WjObNlxoCHANvTiQgHo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW6PR10MB7638.namprd10.prod.outlook.com (2603:10b6:303:248::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 13:35:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 13:35:18 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@kernel.org>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond
 Myklebust <trondmy@hammerspace.com>, Neil Brown <neilb@suse.de>,
        Dave Chinner
	<david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Thread-Topic: [PATCH v11 00/20] nfs/nfsd: add support for localio
Thread-Index: 
 AQHazJzmgcDeJH7XRUCD8QiVhiofhbHju8AAgAC4HQCAAD+aAIAAWoOAgAAPdYCAAAG7AIAAAbOAgAADUgCAABligIAA2CSAgADR6gCAALSggIAAitOA
Date: Fri, 5 Jul 2024 13:35:18 +0000
Message-ID: <57C1CB2B-3B46-48F3-A095-417845001C3E@oracle.com>
References: <ZoTb-OiUB5z4N8Jy@infradead.org> <ZoURUoz1ZBTZ2sr_@kernel.org>
 <ZoVdP-S01NOyZqlQ@infradead.org> <ZoVqN7J6vbl0BzIl@kernel.org>
 <ZoVrqp-EpkPAhTGs@infradead.org>
 <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>
 <ZoVv4IVNC2dP1EaM@kernel.org>
 <4486ee80a487c174ec88c7e12705d99e22ae812a.camel@kernel.org>
 <ZoY6e-BmRJFLkziG@infradead.org> <ZobqkgBeQaPwq7ly@kernel.org>
 <ZoeCFwzmGiQT4V0a@infradead.org>
In-Reply-To: <ZoeCFwzmGiQT4V0a@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW6PR10MB7638:EE_
x-ms-office365-filtering-correlation-id: 16a08e90-5e44-462b-bcd9-08dc9cf74f45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bTFqQU1YaGRwS09nR0dVbFJSNS8veEF0M2N6TkV5MjJkMGVlZnBDVjYycXl0?=
 =?utf-8?B?MUg4elJXUEo0OG0vZ0o4RkZnMFZKR1hsVkRuRGx5OGNWaWk1eVRUb0o0Ykpv?=
 =?utf-8?B?WFhsZWtwajlwUTVNNXJXbGxBa0llYTRLSmF6dWM0ZkwrR05xcGhjZ2xoMWNG?=
 =?utf-8?B?MDVDY2hPRlc2dm1wQmUzT2xoRzAraFQyZVlyNmJmenp1WS80MTY1N1FjdWlm?=
 =?utf-8?B?Zm1VZlF2UVdJaEZJRG85RVNMRWJsNHNBWHREbDl2QXU1OVprSnNvd0dFT1d5?=
 =?utf-8?B?a2d2SmVXV1ZHM3dRaEEzQ3BCQllsT1o5OWd6bXpZK3Z6M3B0NU1QdVNNd2hi?=
 =?utf-8?B?VmgyZ0w0OW56bGExdkw0QTEvQkFvNTEwRExnOTI4dWdyRDZhY1lwREl1RUcy?=
 =?utf-8?B?b0twOSs5N3hUaHBKNjNqclB4OGZvV0RSWmFONmpTSndUVFpadGNyRVI4NDFM?=
 =?utf-8?B?dXM1V2tBUFJNWkdIQURhRFpMS0JuV1l6eUh3WjNvV085dGZiTStySUIvSE84?=
 =?utf-8?B?eERtNnZDNGRTeU1FdVR5NE1yMHJBeGx0MThqV2kwcUtLeGtPcXc4VmlqL1h0?=
 =?utf-8?B?c1laTjkzOWhQTlNaVWljM2xxUDhkRUtKQ2ZGNFd0UFFod2VqdEc2UTI3TXBi?=
 =?utf-8?B?aUE0WTJ1ZC9id2lLSzJwTklucm5kOGRIRU50alp6clBOUG1qZEdHRVRaN0Np?=
 =?utf-8?B?alIyaGUrT2tuYWZMbXNNcTZCRFdsSmxlSkN3SHhwQTZBOVFGbHRzRkJYTW9Z?=
 =?utf-8?B?VGVZYk9QejJmNnpBVkFVZ0tuK0cwKzhTSnUwRVVpYkFvS0hlV29NWDZFZi82?=
 =?utf-8?B?U1p6UTZ1cUYwNExnd1pNTW8xSjZKUEtBMHo1ZHNCZGwvSjlDZ3N5eXdWYWcw?=
 =?utf-8?B?Q01mYkxhb1NnWWh1L3E2UURnNi9RSDJ5Wmd3dzZ1WWh6dXVxUS94UWNzOVdH?=
 =?utf-8?B?Y0djSjV5amNjQkdOeVJ4Nmw2UlhhWjh3NkRkQXEwVTYwcHdmc1VUMUxaWFlP?=
 =?utf-8?B?Yjc4NmtBU2piRGI1cGpCckhiNGM4akR1SDRwNTVneUQ4bW9rNUpRZEFucFlT?=
 =?utf-8?B?YjM4aTVVT1hpM0g0OWgzcWZUZXl1UGJqaTlUM09DYmJzVHdaK1NWMFE3b2Zl?=
 =?utf-8?B?OEZpVmlWejI0TFBhcVMyWTZkTVE0SU5jWkhFRjRMV1UyV21lMDI5QkhDS3cw?=
 =?utf-8?B?eEVVQlJhM2ExQk5HZFpKalNrNGFDY3lCMUdpSG5iY1hQMTB1MklMYnE3cE1K?=
 =?utf-8?B?SHROZzBaT25FZnJiRmhwU21kTEp3MHpGYjNpUHloU2ZVMHptRjQzKzJnRVJ6?=
 =?utf-8?B?ZXhJTFowRndYdVorekovcjZjN095YnFGRHpzaldqVytwVDVVM3g1U3Y5TXNL?=
 =?utf-8?B?TlZQMXVGa1F2L3hMS3ZWLzlBWFk3UGtmSTRScjlJVnJ3NXZka2FSbVFCSWN5?=
 =?utf-8?B?NmZJcGtydEQ2Z2sxQVBJdjVYYjQvYitqWlVWUW1NREFrcjVtR1YxVi8zSTlD?=
 =?utf-8?B?aDJ0WlpnWW5oVVZXazRXTllsaVc4WDdYMUNFTzcwMDRINm43WEpiQXVNcEZo?=
 =?utf-8?B?S2F1NHh2VjNDaDJiZXJadGZHcVZoYkplcnJsaGpCNk14ay85V2VmTEJLUm42?=
 =?utf-8?B?N1hqaWcwNVY0bU51bDNFNCtFYmxWMFluN0J1dWU5WnJQSWtJRm54Mm9CVWo5?=
 =?utf-8?B?UmxZSWgrZHlQTzdIVVQxSXJGOUVycFV0TXlCcU5XeDVkanpXM2pNZEZXc0hD?=
 =?utf-8?B?Tkk4cTNMR1dtUFp6amhnTXdFVFZiT2tZSG84enhKOS82dHQrYWNUVUY4bGFG?=
 =?utf-8?B?aUxxS2ZTL0MveStGUmFrejU4dkJ5QXlNb2g3Ri9RQkF1OVliZWw1M2I5YWcy?=
 =?utf-8?B?dFpySGJoTzZ5OTV1U29PblRMNkpUb2dOYzVKcmZ2OWNaRVE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZWhLbkhCdU1zMzNEcHBZT3ZtbjVDY2wrcXZ5RDduQnlJbkltQTBndEp6VDN5?=
 =?utf-8?B?eE9UVGFRKzEzQ0ZWQ2lQT29lS3NoRkEyS0daK3ZvYVJwVmVQV1IrQlRBeGtC?=
 =?utf-8?B?dUlucmY2MGNBWkkwMG1aMFEwRm1MaTRXRFh5dGZIQUMrNFF6NFhsbXg2Nlor?=
 =?utf-8?B?ZmU3QUM4bmRWQ3BSU0ljWDRyRFJidFkzZUVkTHIvcW8xSTZXNGNwMktLaXho?=
 =?utf-8?B?aURuK0VGb3JURTlJVTVTZStlOWVZakR3aEFETUViTE5XRGd3b3lwQjJSRHRq?=
 =?utf-8?B?cUZTYmF6dUw4dkNrVTZvZVEvdS9GQWVaby9qUTdlamgvSVU2VXpCWVFBUGw1?=
 =?utf-8?B?ZlF0TUdSdUxwY3lXRC9rMG9OU05FVEsyRWZZczBrSGRicGE4cHhOc3ZPdTdm?=
 =?utf-8?B?d3ZWT1BJb1l5bUs0Ykt5UVpTc25XVUluZXk3MmU0MTFPaUZPUG1TMW9LYkZz?=
 =?utf-8?B?cWRZTlBiYVlmYkdCUHZOZG00MFFwWkJ6ZUtNNDdQK3dvaUFZS3JQeU91NHZy?=
 =?utf-8?B?c0E3bFZaQ2l6bi9weHVKcXlMTTd2WHMwcENYcXRjOTdMdW82M09YVzlodEtR?=
 =?utf-8?B?ZHVNZWwwelJMVjJycXlYenZWOE1sRHRyOEdzQ3orUUM0NFhtMnJ5YlFzcTVl?=
 =?utf-8?B?OUVNeVQ4THFVOVQzV1krUVBlbjBpUmpXSjVSSHNKbk9RUVBpUFdtbUkyaVRJ?=
 =?utf-8?B?VW9PQnd1SGprdnpjWE9ycHdscWNCYldzVEorNnhvRWcxamJYQnBZTkpJY3pn?=
 =?utf-8?B?Y1MvRGs5UEJFU2tOa3YvdldmbjUvbWUzWks5TmF2ZWJrdVdXUHRPbkJIWWFH?=
 =?utf-8?B?NnFLVmE1M2Y3YXpDQ0pHV1QyTys2N3lBZWdyeTJvY2dTS3pnS1RzNGdHK2o1?=
 =?utf-8?B?WW41Ty9JY0lMcG5sQW1JclRkbmQ3YW1SRU96RjBwbjg0NTNoRGM3WFg2TlRI?=
 =?utf-8?B?cURqMUxmRFErTk1YUXNpdzNaQzJuZCtjQ3ZldDMvdmR1ZmlTY21SSDJ1Q2Zn?=
 =?utf-8?B?bUtWVzhrQ1MzUjFneVJpT2xGc3BTaENhdk9qNDRCazYzY2VxQlhqVWxZMjY0?=
 =?utf-8?B?M1pqQk92eXhaaEtkd0pJMEt5TG5NSXgrbm9lOGFhYyt6bWlIczhmSFpQMnFx?=
 =?utf-8?B?ZXd3TkMvc3RJZGdQRzJHQ0F0M2xnVE8wUDFUK0YxKzFMeHpHWER0TnJyaEpl?=
 =?utf-8?B?WUx6dm5FaE04ZWozRUo2S09TQ243UElYQlluNU9LOXJ4dDJQMTVFMnVQOUhk?=
 =?utf-8?B?SzJqamplLy9BV2ZocEY4dWx1YmtrNHppVllFN2RRUW9iVFVEQ2tPVlZjUnI3?=
 =?utf-8?B?VjlMQU9rQk9XZDViVkw5K0lHN2luZ2ZXUDBuWnRadXFiZ2Q4M20zQTVLV09l?=
 =?utf-8?B?OHRXZi9FaUxoTktaQnFZUXN0Nml2ekNDZkh4THBBNnJIWVFkeHRUSGlSVVpI?=
 =?utf-8?B?VTJxZ1dqMlhtTmRuUnRkbEkvWlVRcTNmbnJQSGlBZ1hFY0diaVJNYlJ4REtj?=
 =?utf-8?B?bVBmRGxVcXJ4VTMwZmVxU1VKcldvZEtLMDR1T1ROM1Z1VTR3TzlDLzJOVU1T?=
 =?utf-8?B?Y0w2d3VpdGtzTU1OaFljWWQrOUwvRitqUXN0OVdKOXkxNHowUisyY1dXbWdE?=
 =?utf-8?B?N0F6WWlGMXFubmdvQUxMeW1seVFObW5ESHljdndzdjhSSFlMODZrQmdleG0z?=
 =?utf-8?B?akg2b29OTGhXcUpzR2FYVi8yQXJPVXR1TktUemV1TngvVmhuVVlrK2U5VW1U?=
 =?utf-8?B?bFVKcmZTSU01ZE96SzBkUzVidThOVWJycnB4RThtYTgvQkltbUV1YVlnWkdX?=
 =?utf-8?B?ODZnQ2lUVWdoQmRneDVuYllKNWV6TFROZDVVUE9iWVpBYkZwd1JUUGJmdVhX?=
 =?utf-8?B?bzAyMHV2S2EzekRLNlJuc2hQN0VXY2ZwdEZLakFDT0w0b2lMemhKS2drYldI?=
 =?utf-8?B?ZVI5TitmdFd2TkFzbnNsWGQweUxCSW9NdVE2blNzVkxvbTJtT0tYNDR6Rjkz?=
 =?utf-8?B?cGFKam1tTTluNFZzRXFPTXc0WFh5NUJ6NitiOURhTmpKaW94VEJuRDlPd3F4?=
 =?utf-8?B?TXI2dVBwWnBSMW15ODUyUFo4TzFkVTMyMGErZHRuR2NORTI0RmU0Wlg3YnNK?=
 =?utf-8?B?UVpqblBud0RvcTZaNGtQckJ0SjJmSFU5cTBQdy83a2pZcy9FdVBUMEwvQi9K?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7D6A1593475804DB1C8444F586D4242@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+diTw8ajvYj8MRX7RSPMD87/eFk8qr6OuH3dRujoq2X8wFq+I9rLIcpOe6UI7A2T9ZpryOB7z/lbKN/dCdJsnwTVIYx2CO/5wOK+onpklp2FV5ehRDvXXRlSh9hWCsJgZODE7QZSQ/zwRB1R3iZl1VD4uc5QL/5UAYQc0UzI+vKu5TQNYIgdI53LUabqmi8dvqZi16uS+tjjq5KIb7egfHrwcIo0R7os3k2McOdSiPBD9nD4hDVzOUSMA78azWuLPhMSZk2tVMurG+vf8IPjXuJnbZ2jUMGUzdVk7ZLHvAr+9u3AN2iUcc6A6ygZrEul085ucA2G0kfHjX7iRURNKncG9YQ29/Uj0WAAJpVRnGVKGV3We9T6Iy+6pVQD1IyCb4xeSazg7j1wBdWZAGR1igbuE6VB0sGmriqvMpvGOU7eDlrfsI0t82+UtOHHg992+qhZsKBIQjkp9kntYriPOfuipNwdhHYDDz110PiBIAGyQWgXz0XGa5rKB3UWqEZL4+GZnimvHS7bhVAPeXnVMukAB6xABQbnfs63Ynx5SdezRId3HM1mQYefye24p8tLYtz2XI4CYv2jcn7H0Kgq7BhGMXf0Nt3hHJ4Id5SKtMk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a08e90-5e44-462b-bcd9-08dc9cf74f45
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 13:35:18.0300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OaVcp0++NBhaQLd7wnuRcVGlynn6m8qTw6yNA3DieS7QYGN54wOXHI0mcRo6Bv+YMowN7vxipeRlCyGng7k9ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=648 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050097
X-Proofpoint-GUID: VlvzGif_zP53BPAuAXKgLRbvJlyKG0gY
X-Proofpoint-ORIG-GUID: VlvzGif_zP53BPAuAXKgLRbvJlyKG0gY

DQoNCj4gT24gSnVsIDUsIDIwMjQsIGF0IDE6MTjigK9BTSwgQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBpbmZyYWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgSnVsIDA0LCAyMDI0IGF0IDAy
OjMxOjQ2UE0gLTA0MDAsIE1pa2UgU25pdHplciB3cm90ZToNCj4+IFNvbWUgbmV3IGxheW91dCBt
aXNzZXMgdGhlIGVudGlyZSBwb2ludCBvZiBoYXZpbmcgbG9jYWxpbyB3b3JrIGZvcg0KPj4gTkZT
djMgYW5kIE5GU3Y0LiAgTkZTdjMgaXMgdmVyeSB1YmlxdWl0b3VzLg0KPiANCj4gSSdtIGdldHRp
bmcgdGlyZCBvZiBicmluZ2luZyB1cCB0aGlzICJvaCBORlN2MyIgYWdhaW4gYW5kIGFnYWluIHdp
dGhvdXQNCj4gYW55IGV4cGxhbmF0aW9uIG9mIHdoeSB0aGF0IG1hdHRlcnMgZm9yIGNvbW11bmlj
YXRpb24gaW5zaWRlcyB0aGUNCj4gc2FtZSBMaW51eCBrZXJuZWwgaW5zdGFuY2Ugd2l0aCBhIGtl
cm5lbCB0aGF0IG9idmlvdXNseSByZXF1aXJlcw0KPiBwYXRjaGluZy4gIFdoeSBpcyBydW5uaW5n
IGFuIG9ic29sZXRlIHByb3RvY29sIGluc2lkZSB0aGUgc2FtZSBPUw0KPiBpbnN0YW5jZSByZXF1
aXJlZC4gIE1heWJlIGl0IGlzLCBidXQgaWYgc28gaXQgbmVlZHMgYSB2ZXJ5IGdvb2QNCj4gZXhw
bGFuYXRpb24uDQoNCkkgYWdyZWU6IEkgdGhpbmsgdGhlIHJlcXVpcmVtZW50IGZvciBORlN2MyBp
biB0aGlzIHNpdHVhdGlvbg0KbmVlZHMgYSBjbGVhciBqdXN0aWZpY2F0aW9uLiBCb3RoIHBlZXJz
IGFyZSByZWNlbnQgdmludGFnZQ0KTGludXgga2VybmVsczsgYm90aCBwZWVycyBjYW4gdXNlIE5G
U3Y0LngsIHRoZXJlJ3Mgbm8NCmV4cGxpY2l0IG5lZWQgZm9yIGJhY2t3YXJkcyBjb21wYXRpYmls
aXR5IGluIHRoZSB1c2UgY2FzZXMNCnRoYXQgaGF2ZSBiZWVuIHByb3ZpZGVkIHNvIGZhci4NCg0K
R2VuZXJhbGx5IEkgZG8gYWdyZWUgd2l0aCBOZWlsJ3MgIndoeSBub3QgTkZTdjMsIHdlIHN0aWxs
DQpzdXBwb3J0IGl0IiBhcmd1bWVudC4gQnV0IHdpdGggTkZTdjQsIHlvdSBnZXQgYmV0dGVyIGxv
Y2tpbmcNCnNlbWFudGljcywgZGVsZWdhdGlvbiwgcE5GUyAocG9zc2libHkpLCBhbmQgcHJvcGVy
IHByb3RvY29sDQpleHRlbnNpYmlsaXR5LiBUaGVyZSBhcmUgcmVhbGx5IHN0cm9uZyByZWFzb25z
IHRvIHJlc3RyaWN0DQp0aGlzIGZhY2lsaXR5IHRvIE5GU3Y0Lg0KDQoNCi0tDQpDaHVjayBMZXZl
cg0KDQoNCg==

