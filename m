Return-Path: <linux-nfs+bounces-4068-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACE890EEE9
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 15:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A98BB260C5
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 13:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42B2147C85;
	Wed, 19 Jun 2024 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="alEuYQ42"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2120.outbound.protection.outlook.com [40.107.223.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6C71E492
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804000; cv=fail; b=mcOrFxwjEhRLiCQbYD38HlOf8WVff87+H6sjkPc3lyohK3Sdu67sQaIfVf4+/yCLm9cV+225drtg4lMHBeUPw1vuhdWW02QjfWAprskXuwEaknVTrebyf0uj1AnzWq2tpuVwl0OYjLjBYzNXNaWB+OP4bnaWRquIeT5GAOeiNXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804000; c=relaxed/simple;
	bh=X0DiX8qBE1D5OAcVmtruZmjNQeqIxRORFfZTxLPaF+A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h/2j46un1wPGp/s7zYwxk6NcF5B7sNIate7yyebNzeYQlp4+BX9K8RBd1Ik5BaJ1WDCIOnt3LHMepnGiX7MvUBvW4anZunD07y292m18Kg/JAI1T4PEOixgyj4EodnGcQqRqLQLZim/LEGN9/hov9hKZJNKgwUHkqN7EINLS9+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=alEuYQ42; arc=fail smtp.client-ip=40.107.223.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4zvvxm5uzcU+GeqQ6PwyI/X50LTQ1cYF8TEr3mU3A8bdNRKiXajVKf2QmrZUcOdD/tHnJSuaeXZnrRLinEX/+yxGEgrPhQjFZkAsJucCf9LmIMByw8nxn2tpB+6oMp7IUkWHmomCT7zQfk90+Sif7R0BmwLAZNLQARB7x9nZfJMO/31eVdlTsie7LCFSuracNF1p+QryRynlyZOMqsJuDJzC9wavdgtP6y+n6LRDfrA972Ne2uQ98AQ5lWaaP1WXOPRES6NEwMOYlJdFxdDPZD8KFKXWIOqxHip3ZxD44iH6/yFEWrF4M3RUP2AFlsxmEYnwqDGKqPNtwpXI3Jwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0DiX8qBE1D5OAcVmtruZmjNQeqIxRORFfZTxLPaF+A=;
 b=FG6V+5UNnEdbB3YX0aDEkUUHQYFHi6c+7Gvm3OYL6p57yb4BUTuVLlXuq2N/sEjgvnx1UA/yDL1ESxn7EvOvvm+CL4ASqumw+snBGfLNjj0W38xE7vsxDcsUOJ1fF0tmbN0OMVWqrl0eZqAMrCLBd7aPx2nrIPA21adqe2j3/kGoqHnG6vp3C556pOF7Az4PekmkOWJOGfNObet08XD4bkhhsgI+2uR+E5cYKScfJNvUw0mRHeNTJuMYusWz5dsUhLmyZEXx1/59FyvldwdlxJ+a/ZFcnwYGzAqbv8vmGv/Ks3iWlB2Rl4AI0eVnJExAIQepIhHHSi5fS8ta2RQRSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0DiX8qBE1D5OAcVmtruZmjNQeqIxRORFfZTxLPaF+A=;
 b=alEuYQ42SYqxiGXq7khpx6hirC0ei51iDd6tGQJNVjDeY4aynnHrfT2QEGVlRtFkkqLZWsAxZMzP+7hRKbQguYQ2jSrlJZ+Nhf5uHwb6WWa7a2dg6ogbUPR6s9GYo1+gPptEkOYKKSn9buChCPKLcQo+geC+nOo2i+y3+qlex0A=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA6PR13MB7133.namprd13.prod.outlook.com (2603:10b6:806:407::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.20; Wed, 19 Jun
 2024 13:33:11 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 13:33:11 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>, "hch@infradead.org"
	<hch@infradead.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: add 'noextend' option for lock-less 'lost writes'
 prevention
Thread-Topic: [PATCH] nfs: add 'noextend' option for lock-less 'lost writes'
 prevention
Thread-Index: AQHawZTgISFLcUQ41kCD6EOpRxYIYrHOlGqAgACCv4A=
Date: Wed, 19 Jun 2024 13:33:11 +0000
Message-ID: <3cd6df545d9230758db38a4b7e5921dd57089153.camel@hammerspace.com>
References: <20240618153313.3167460-1-dan.aloni@vastdata.com>
	 <ZnJwTaTw5JEOnuLw@infradead.org>
In-Reply-To: <ZnJwTaTw5JEOnuLw@infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA6PR13MB7133:EE_
x-ms-office365-filtering-correlation-id: 03d65008-3ddc-43a3-99f5-08dc90645d06
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?cW15S01QQTVhSWlzZTYrUFhxL0tQeDBvZGkxY2d1SSswcXNyaC9LemFXaEg0?=
 =?utf-8?B?S1U3S1ZIa3l0NlFuLzZNSXNGMjRaazhLbC9hTmc1M2pXUXFPTXF0UzJ6aHV6?=
 =?utf-8?B?Rlg5SGdreW0wbVhPZ05RRFo3YW1jZlEwU1JxdTFUMm9GUjV5SUw0QzhlQlB2?=
 =?utf-8?B?SVZSclpIclNQT0FYQVZSa1NVaCtZSnBEemNYRnBBcytOTHBtMzNOLzFGQ2FP?=
 =?utf-8?B?RVM0OWVsTjhxaDhRWWgvWmtoVFMwNUNVcC9uMG5pQW9SK1FmUEloN2ZnV1lC?=
 =?utf-8?B?R2tHZUFzV2R5NGZGOGRKYWN6TlZtQWRSWUxkZjNDelpvakhZdEFDNnU0Vmsv?=
 =?utf-8?B?cm82SWRhQTVHeVJNVE11bXp5Z3VKdUltNS9PcW5QNjdGcFRCaDdqK3NoRXhK?=
 =?utf-8?B?djJadkVMb0h3Q0lpYkhHQ3NRdUY4OFJEdGFrZUIwcHQvN2lYTWlrSTVIdFgw?=
 =?utf-8?B?ZGVlZ0hjOUhmZCtQY0tXVGhucnEzeTJVUTB6aWdIMXJqS1pyYTNNaEpDRTZG?=
 =?utf-8?B?bUJmdDdzeVlNZTJGbnZXNjZpd3dka1V3K1R4SWxwam1tbGdFT1kyWitXTVpm?=
 =?utf-8?B?d0s2V3VZbmlGbE1BdDR6VEFSMVYxaGlDU0lhT21pTlNLS0JPSG02WDJHWUpD?=
 =?utf-8?B?azdsdWZOOE1PUmdwWWx4V2F1a09ydjVKeFBUZ3VsS2R5Skw2WGsyU3N2MDN5?=
 =?utf-8?B?bk9hakorQXMwTWx1WVBVMUJwSys3SnUxa01BQStjelBxTkRUVmd4cmF3ek8v?=
 =?utf-8?B?Q0dtQnZiQStJVzZ0ZkFWWGxjOGh3NU95RmpqVVVRWnhIQ3Z2MjJrSjR4M09B?=
 =?utf-8?B?SFJYRVZXREo4K1VsS1RnbVFBaFJLd2hxYmF3UVBZOHh4K1NPdEMvamx5K2Vr?=
 =?utf-8?B?Vzk3OFNvQ3E4dWdTRmtoTVk2WTFKRVpCc2FQTndneTc0Z0RPSmdzNlJFd1Ft?=
 =?utf-8?B?c3hkQWkzVWFBWWJNTnJQSUZFRTV0blJPRlBhbjFYVldnRWZZdnI3aVh1Y0Vt?=
 =?utf-8?B?d0U1RjhKc1ZCZG8zWDc2dDdNaUJmL05JQmFXdGowbHUyRCt5UE1ISUU0K1Ez?=
 =?utf-8?B?MVczdXh3bHhQYS9KYkRQbWJITVdKbkRhbXFLWTU0a2dHRlpNcXJjakRERmJw?=
 =?utf-8?B?eC9QUzUzT0U1Y056bThTQ2JraXAzbmNzbHV2K3hFd0tpVGFodERzMVhXZzcz?=
 =?utf-8?B?TWM2YzhmUTIzL0IwcHY0dncyT2VXYVBDbW9icEVETnJJWnhyL1prenQzL1N2?=
 =?utf-8?B?czNVZHEvczc5bXZkcmFkY1phcVhNT2t2N1AwRHJWbm82N1VlbzF2MXlkTjVl?=
 =?utf-8?B?dnJSaURuNUNjd3NFcTliZEx5WittOTVXbDNJMlc3ZXdaaHZwL1NhTG1vZldF?=
 =?utf-8?B?K2RVWS85T3RCNVM0OHlqUFA3d3lpT3Z5NjJMOWl0RXRvZStkVUgwQzlHRHg0?=
 =?utf-8?B?THhUTXl0eWZKVDhBeVhaZG1WT0lTdTdjQktNUElsZUs0RzhiL3VPOC81dlBF?=
 =?utf-8?B?NDl1MURLa3V3amFqZ0pOQUY1ZXdXTVFSNFhocG5mdDJyVVRCY29lazNhYjY3?=
 =?utf-8?B?c2tNSE51c3hNNDlQN1pBNDVJaXZqZnVQMVpMM3FOK0NQRXBlbzlGUlhPMVJu?=
 =?utf-8?B?Yk9MWTd1MmdTRVBETGdMZzlKQlNYMDFXWW4yNDdoTk1jcDNLQkxCUzJDZWd0?=
 =?utf-8?B?Vml1eVFwOGFLVlNRc0RObVBueXo1S3hhRmdjR25vUjlnelEvS3o3UnoxbGV6?=
 =?utf-8?B?L0NDSVlvTkdGTUYyZHkrM0JIYkF4UWhWWWNFR2s1aDdDOGN0anZYQ0tKWHVS?=
 =?utf-8?Q?8eWbZwjt0u4ELY5sZlLn6LAVSImCqnlywUzjE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vm56MFY2Z3VJQVBmNW9ZcDhNRmx3VmZsQmYzaUFQUFhkckxqM2x3SFBlR1V4?=
 =?utf-8?B?M2xvSjhncTRjWS9JZjJRNE1WbHFVOW5lcHh2cjQ4djR3Vyt6cm5WS1Jxb0tx?=
 =?utf-8?B?K3ZxYUJuei9DcjBqcDVHVTF0c2F3RkpIbEVLWGhQQU9GZDdmQ2FBMi92ajJF?=
 =?utf-8?B?NmdXZ2JMdkh1Y1ZRTnlOV3E2c3ZFMDlIb2N3OGE5ZG41Q2RKRGhVSXhPQmpW?=
 =?utf-8?B?Wk42ZHdmWjZ1ckF4Q2cvSkxUbERlWGQ2R0diMWIxSnFtY1VTWG9zbkJ4VnVZ?=
 =?utf-8?B?MEV3S3A1blJ0WnJhVENLNW8xaEI1NWVpTXQ3RSszMTFwd3dXOXVCMUtaNXlF?=
 =?utf-8?B?Z3RENEZMd2lOc1B0RzZON3p5VTZJcUVzOEYxOUVsZDM3cHhCMEZIdWhQTjhG?=
 =?utf-8?B?SmVPb09qZ2pibjRBQUhPalh2SEo5UndKRlA0NTNNYWJ3VzRuQlZkOEJkZTE2?=
 =?utf-8?B?ZjBEZVVEam00S3ZMRHc4SVROZklKWk1mdGRaY0Vsd2FQSlFyeE5sbFV4RlZK?=
 =?utf-8?B?UGhmWFZSdGJ4V2ZpY0c1QmtTTTZQcHMxVTdIQjJFcHdPT0VnSEhXc1owK2d3?=
 =?utf-8?B?SXVPT0JoTXJ3clJjRWE5L0djbTVGQVdiQ082SEdLdTBsYVB1cEJ4MUxwQUZj?=
 =?utf-8?B?bDVpWUdnWjFRbUtqOXRaQ1hJZllJdnBqT0ZBV2l3Q0FGdVFrclF6TkZLL0dI?=
 =?utf-8?B?MEdtblJmbEpKYW4xRE5oMzhGQ2pVN0dsUkp1eTYwZUliR0pYV0loS0Z0aGpH?=
 =?utf-8?B?YzZva3pORDYzakFUVnFPMUZOMWdDSE8vZVBsWHB1d2VlWFhKa2VxcVNwdDhk?=
 =?utf-8?B?dS94bTY1cUdIc050L0xqbzdhZVg2ZjY4amwrN000M3BJNFZEMzBKb3NSa3dL?=
 =?utf-8?B?Nm8wek54RVZSeXVVU2hNUXJDMEt5dFdxdkhFOTB6Z0ZvQkZXTXBKNVYrZ1ZJ?=
 =?utf-8?B?TmZXRkRjZnpvRkp3MERUTlRUdFpKWG1EakVOSVljVTBVb0lwVlpQT2RKZVc0?=
 =?utf-8?B?UGhqV00xbjlocHlVT2lScXloZkxOY29JNDc0WGlpS3RXcy9Tdkhpdlo1bXY0?=
 =?utf-8?B?cDhHeXBGa2F3WmdkOW1PelVhTjZXQVJBN2VlSzNIMmg4cDdiU0dzTW4yYmpx?=
 =?utf-8?B?ZFFCWHN3cDFBTG4wZDFaSFVCYmptbjVzYU1VSzJ6Qk5nWW9lY0Z2N0gvY1hL?=
 =?utf-8?B?bHRuL0RkOFhOcVJIUTZodXY0ZXdBMjlFaWJVbDc0N25oOGdpSFBnb0pJekxE?=
 =?utf-8?B?ZzVkQmcvbzYyZlBRRzJVc0VMVWNnYnRmUE8wQWNhQk8yQzZOSTQzRk5DcHFY?=
 =?utf-8?B?by9VQWxUZURndENiUDA4bWlPaU5rOTVqcGgwcVJ1RUl1aS9UdVVnZFl1aHNr?=
 =?utf-8?B?TlRjSGhJejJsQjE1YlQ5MTQ0QTdNMzBtMzRtSmF3bnBwMHhGb2hXRXhUN0dJ?=
 =?utf-8?B?VHROMi9uMVRuczNtUmhjQ3JnaDd3YmNacmhXT1RxdWpWeWlqVVplVTFPZlFj?=
 =?utf-8?B?RUNRd1VtMEdVYk9WenlxUDdTc1c0NmpaeXJvRDQrQ3A4Z0d6Y3NSbUVtQUpY?=
 =?utf-8?B?ckxhQXNwSUEvVDZ1djVtSkMxT1ZDYm5QTWhGZSs3eDJaWjlCYXRDMXdlcGY2?=
 =?utf-8?B?R0s2Y3BWUHBERWs5MnBqMW9hQWdoOWxjWENsUDVJbU1jbnloeXdUYmJ1T1B4?=
 =?utf-8?B?L2xiRy9iTVZ6ckdTVmJxcWpCaUkvN2ZuV0lVSStwV0tqYnBOQmlZMWppaDQr?=
 =?utf-8?B?L1c1Yk9VYzVlUGx2TktMZ1NVbXhIYmNMSm5iVXdmS1k3TW8raWhTY1VJN2lG?=
 =?utf-8?B?bUR0QWwrR3o3U3FOMk9DQkh2M1FoRUtnWllvZmpBcTE0bXFoNUtrMlAyS1A5?=
 =?utf-8?B?Q1JLU1hLWDVQVEZvTDdOUDhHc0xyekRZT1lDeWFjdUxDZzY4S3JYeCtPM3dt?=
 =?utf-8?B?MXA3SCtEREJLamM5TmRhWTFqNXB0MUUyNVpJRVFOWnlCY2twVGRpRmRlWEFk?=
 =?utf-8?B?cTRNayt3cWhCZ0J0OTQ1MzhJb2R5MW5Xd1h0K05wN3ZnL1AvNENHRjFETGJy?=
 =?utf-8?B?Y2FnRTNMNnYzMmg5eFJyUXp2dldldkFxYS9sUitMWkRUNHFWR2Mrdjh0VHkv?=
 =?utf-8?B?Qng2ODRpTkdWayttYmdkYWExeVpjNy9kUHNIckRIa3crMkZ6ejlYeVhTVXVV?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB1933D5595EF84BAC8D8A41F48BFF3F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d65008-3ddc-43a3-99f5-08dc90645d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 13:33:11.1204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hNBiJl63uMLdBAUJHLKAapHOxJ1dICgmCr1heMMi0ou+aJOd7Xim5qe1OtW93ky8wt9SGTPyOZEsSft1PZltw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR13MB7133

T24gVHVlLCAyMDI0LTA2LTE4IGF0IDIyOjQ0IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gVHVlLCBKdW4gMTgsIDIwMjQgYXQgMDY6MzM6MTNQTSArMDMwMCwgRGFuIEFsb25p
IHdyb3RlOg0KPiA+IC0tLSBhL2ZzL25mcy93cml0ZS5jDQo+ID4gKysrIGIvZnMvbmZzL3dyaXRl
LmMNCj4gPiBAQCAtMTMxNSw3ICsxMzE1LDEwIEBAIHN0YXRpYyBpbnQgbmZzX2Nhbl9leHRlbmRf
d3JpdGUoc3RydWN0IGZpbGUNCj4gPiAqZmlsZSwgc3RydWN0IGZvbGlvICpmb2xpbywNCj4gPiDC
oAlzdHJ1Y3QgZmlsZV9sb2NrX2NvbnRleHQgKmZsY3R4ID0NCj4gPiBsb2Nrc19pbm9kZV9jb250
ZXh0KGlub2RlKTsNCj4gPiDCoAlzdHJ1Y3QgZmlsZV9sb2NrICpmbDsNCj4gPiDCoAlpbnQgcmV0
Ow0KPiA+ICsJdW5zaWduZWQgaW50IG1udGZsYWdzID0gTkZTX1NFUlZFUihpbm9kZSktPmZsYWdz
Ow0KPiA+IMKgDQo+ID4gKwlpZiAobW50ZmxhZ3MgJiBORlNfTU9VTlRfTk9fRVhURU5EKQ0KPiA+
ICsJCXJldHVybiAwOw0KPiA+IMKgCWlmIChmaWxlLT5mX2ZsYWdzICYgT19EU1lOQykNCj4gPiDC
oAkJcmV0dXJuIDA7DQo+ID4gwqAJaWYgKCFuZnNfZm9saW9fd3JpdGVfdXB0b2RhdGUoZm9saW8s
IHBhZ2VsZW4pKQ0KPiANCj4gSSBmaW5kIHRoZSBsb2dpYyBpbiBuZnNfdXBkYXRlX2ZvbGlvIHRv
IGV4dGVuZCB0aGUgd3JpdGUgdG8gdGhlDQo+IGVudGlyZQ0KPiBmb2xpbyByYXRoZXIgd2VpcmQs
IGFuZCBlc3BlY2lhbGx5IGJhZCB3aXRoIHRoZSBsYXJnZXIgZm9saW8gc3VwcG9ydA0KPiBJDQo+
IGp1c3QgYWRkZWQuDQo+IA0KPiBJdCBtYWtlcyB0aGUgY2xpZW50IHdyaXRlIG1vcmUgKGFuZCB3
aXRoIGxhcmdlIHBhZ2Ugc2l6ZXMgb3IgbGFyZ2UNCj4gZm9saW9zKSBwb3RlbnRpYWxseSBhIGxv
dCBtb3JlIHRoYW4gd2hhdCB0aGUgYXBwbGljYXRpb24gYXNrZWQgZm9yLg0KPiANCj4gVGhlIGNv
bW1lbnQgYWJvdmUgbmZzX2Nhbl9leHRlbmRfd3JpdGUgc3VnZ2VzdCBpdCBpcyBkb25lIHRvIGF2
b2lkDQo+ICJmcmFnbWVudGF0aW9uIi7CoCBNeSBpbW1lZGlhdGUgcmVhY3Rpb24gYXNzdW1lZCB0
aGF0IHdvdWxkIGJlIGFib3V0DQo+IGZpbGUNCj4gc3lzdGVtIGZyYWdtZW50YXRpb24sIHdoaWNo
IHNlZW1zIG9kZCBnaXZlbiB0aGF0IEknZCBleHBlY3Qgc2VydmVycw0KPiB0bw0KPiBlaXRoZXIg
bG9nIGRhdGEsIGluIHdoaWNoIGNhc2UgdGhpcyBqdXN0IGluY3JlYXNlcyB3cml0ZQ0KPiBhbXBs
aWZpY2F0aW9uDQo+IGZvciBubyBnb29kIHJlYXNvbiwgb3IgdXNlIHNvbWV0aGluZyBsaWtlIHRo
ZSBMaW51eCBwYWdlIGNhY2hlIGluDQo+IHdoaWNoDQo+IGNhc2UgaXQgd291bGQgYmUgZW50aXJl
bHkgcG9pbnRsZXNzLg0KDQpJZiB5b3UgaGF2ZSBhIHdvcmtsb2FkIHRoYXQgZG9lcyBzb21ldGhp
bmcgbGlrZSBhIDEwIGJ5dGUgd3JpdGUsIHRoZW4NCmxlYXZlcyBhICBob2xlIG9mIDIwIGJ5dGVz
LCB0aGVuIGFub3RoZXIgMTAgYnl0ZSB3cml0ZSwgLi4uIHRoZW4gdGhhdA0Kd29ya2xvYWQgd2ls
bCBwcm9kdWNlIGEgdHJhaW4gb2YgMTAgYnl0ZSB3cml0ZSBSUEMgY2FsbHMuIFRoYXQgZW5kcyB1
cA0KYmVpbmcgaW5jcmVkaWJseSBzbG93IGZvciBvYnZpb3VzIHJlYXNvbnM6IHlvdSBhcmUgZm9y
Y2luZyB0aGUgc2VydmVyDQp0byBwcm9jZXNzIGEgbG9hZCBvZiAxMCBieXRlIGxvbmcgUlBDIGNh
bGxzLCBhbGwgb2Ygd2hpY2ggYXJlDQpjb250ZW5kaW5nIGZvciB0aGUgaW5vZGUgbG9jayBmb3Ig
dGhlIHNhbWUgZmlsZS4NCg0KSWYgdGhlIGNsaWVudCBrbm93cyB0aGF0IHRoZSBob2xlcyBhcmUg
anVzdCB0aGF0LCBvciBpdCBrbm93cyB0aGUgZGF0YQ0KdGhhdCB3YXMgcHJldmlvdXNseSB3cml0
dGVuIGluIHRoYXQgYXJlYSAoYmVjYXVzZSB0aGUgZm9saW8gaXMgdXAgdG8NCmRhdGUpIHRoZW4g
aXQgY2FuIGNvbnNvbGlkYXRlIGFsbCB0aG9zZSAxMCBieXRlcyB3cml0ZXMgaW50byAxTUIgd3Jp
dGUuDQpTbyB3ZSBlbmQgdXAgY29tcHJlc3NpbmcgfjM1MDAwIFJQQyBjYWxscyBpbnRvIG9uZS4g
V2h5IGlzIHRoYXQgbm90IGENCmdvb2QgdGhpbmc/DQoNCj4gDQo+IEJ1dCB3aGVuIGZvbGxvd2lu
ZyBnaXQgYmxhbWUgb3ZlciBhIGZldyByb3VuZHMgb2YgZml4ZXMgKHRoYXQgYWxsDQo+IG5hcnJv
dw0KPiBkb3duIHRoZSBzY29wZSBvZiB0aGlzIG9wdGltaXphdGlvbiBiZWNhdXNlIGl0IGNhdXNl
ZCBwcm9ibGVtcykgdGhlDQo+ICJmcmFnbWVudGF0aW9uIiBldmVudHVhbGx5IGJlY29tZXM6DQo+
IA0KPiAJLyogSWYgd2UncmUgbm90IHVzaW5nIGJ5dGUgcmFuZ2UgbG9ja3MsIGFuZCB3ZSBrbm93
IHRoZSBwYWdlDQo+IAkgKiBpcyBlbnRpcmVseSBpbiBjYWNoZSwgaXQgbWF5IGJlIG1vcmUgZWZm
aWNpZW50IHRvIGF2b2lkDQo+IAkgKiBmcmFnbWVudGluZyB3cml0ZSByZXF1ZXN0cy4NCj4gCSAq
Lw0KPiANCj4gV2hpY2ggdG8gbWUgc3VnZ2VzdHMgaXQgaXMgYWJvdXQgc3RydWN0IG5mc19wYWdl
IGFuZCB0aGUgb24tdGhlLXdpcmUNCj4gUlBDcy7CoCBJbiB3aGljaCBjYXNlIHRoZSBtZXJnaW5n
IGluIG5mc190cnlfdG9fdXBkYXRlX3JlcXVlc3QgdGhhdA0KPiBtZXJnZXMgY29uc2VjdXRpdmUg
SS9PIHNob3VsZCB0YWtlIGNhcmUgb2YgYWxsIHRoZSBpbnRlcmVzdGluZyBjYXNlcy4NCj4gDQo+
IEluIG90aGVyIHdvcmRzOsKgIEkgc3Ryb25nbHkgc3VzcGVjdCBldmVyeW9uZSBpcyBiZXR0ZXIg
b2ZmIGlmIHRoaXMNCj4gZXh0ZW5kaW5nIHdyaXRlIGJlaGF2aW9yIGlzIHJlbW92ZWQgb3IgYXQg
bGVhc3Qgbm90IHRoZSBkZWZhdWx0Lg0KPiANCg0KVGhlIG1lcmdpbmcgaW4gbmZzX3RyeV90b191
cGRhdGVfcmVxdWVzdCgpIGlzIG5vdCBzdWZmaWNpZW50IHRvIGZpeA0KcGF0aG9sb2dpZXMgbGlr
ZSB0aGUgYWJvdmUgZXhhbXBsZSwgbm8uDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K

