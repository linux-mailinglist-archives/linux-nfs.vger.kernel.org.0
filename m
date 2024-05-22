Return-Path: <linux-nfs+bounces-3333-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FDC8CC102
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 14:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B7D28579B
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 12:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1184C13D604;
	Wed, 22 May 2024 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="U/hBr/5y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2135.outbound.protection.outlook.com [40.107.101.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1507213DBAC
	for <linux-nfs@vger.kernel.org>; Wed, 22 May 2024 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716379922; cv=fail; b=L+W5Jft2R8rr+o6rdCD7HHkusR+qDJ5EjFvjp9N+r7ROjtAp/R/9B/ds5tTEqBbejlGNNPQfnvkDtMIXzqaCes+q90LshAznmi9O/Jm6s/OR8NQB4y4N/Zay+yl6B+Qca7ngWyu5ERCuhdvXd4j4P37ZhgcC7k6TU/YCHbh4dhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716379922; c=relaxed/simple;
	bh=n+BbnQQODjYIvC7I9erldmWL8wKd7H4OgBwduXJLNao=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TN0rwbcSdpKGtFXmH8XJo7Boowamf40fjAGX83aNa2NgXWitGiZVlLyNuS2EP9tp1ftxn44TImHJXEnpb9XiPxYn6eI4H7iw3oLME0nGa0bA8o4RGvvj+x2lW6QUIdozhRNKMdNyn7CKbYMoe1r5X1kxB/7eFKnEuZz+KjBwwIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=U/hBr/5y; arc=fail smtp.client-ip=40.107.101.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kB7R8brJyhybdxmKWEhnzyq4kOwTI6iN3tF/ZHXr3eJsRkLIAeErrSCLQZ4IC+nuaE94TiuFCiLlVRjsee2nBWH2+PARiSIzOh/neConegGHlVtwlauqAVDdsQGd8e7KrOrh94UZGfveK7TmR1oPZQ+WI+E7vOpjUl2srIqsFsqdFQjQrOVyuQKigCSXYndC+TcsXHHoQ04tU87Yes2QRJDOQE1An17FRWA4+9sgQFdTIezC4etaYUlXEtXSe9kOJYCVSvHEBDG7s5FPPGdzbRFVlU0dcF3RYvpqDo0ZBTiZUsY4i5RgNT4kW7ZXkYCQDFaq7xJscq/o2O1/ZgC8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+BbnQQODjYIvC7I9erldmWL8wKd7H4OgBwduXJLNao=;
 b=GmEPXhwfX87gUXQKx6EjtDa0B8gu6BTayoHB2zMQ/XUIp7geiONM5lR0Bvhr9m+TwLZLKJmS4ePRQdO48KVpgdqDrBpNGGvNLjImopEBwIt/8/pNtZO4qUW/TupNf8dvF9cFRaDTge+dXiOmCzsBCONzkgfKHFgXI9xCC5AvG4k035Q0QlxtcxB5zh0nLD43mVV3zFQ+J0Ywvrp8r682CBWxuOzN8effYGSoeEU3eXoaa/VxqNh1RxuwEUZlU3js7I1BjBWHmqaoerq3yZDoN8jB7OWgs3VVdRNKcLbsH+Efp9ViqdesZ2ll1g4W91qH4q86yYewib4iSqmC/QBOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+BbnQQODjYIvC7I9erldmWL8wKd7H4OgBwduXJLNao=;
 b=U/hBr/5yEwuqsLPI+PSGff/EqOn6/ok+KvL/OK25xl151TXyNSroneBBb7Ue5g/iB8jEfVUYuNFFzFRMZWAaB77cOyGwqPHJBtICgdiFXzVm4RloDSJnXF/vdlp3myxiXAn/l69DXaidqSLKKfq97rwxnYHiF9nwA85sU3sj+9g=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SN7PR13MB6302.namprd13.prod.outlook.com (2603:10b6:806:2e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.16; Wed, 22 May
 2024 12:11:56 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 12:11:55 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
Thread-Topic: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
Thread-Index:
 AQHaq36jqWobVAzhLU+0cOtTOPPg4LGhrPIAgAAczACAAAIIAIAAAyKAgADeowCAAH3vAA==
Date: Wed, 22 May 2024 12:11:55 +0000
Message-ID: <07266080ebd62d5d6cad9eca6742d96e2eed9ec6.camel@hammerspace.com>
References: <20240521125840.186618-1-sagi@grimberg.me>
	 <fa1a77fee6403454444fffce839924157778df95.camel@kernel.org>
	 <ac2bfa20-d952-4917-8a70-1e821f9b57ca@grimberg.me>
	 <d5409ff9ce51e439f442abb1cded7c7ab732b726.camel@hammerspace.com>
	 <53269EF0-4995-474B-9460-29A640E8A46F@oracle.com>
	 <20240522044110.rwqyldj6u6523alm@gmail.com>
In-Reply-To: <20240522044110.rwqyldj6u6523alm@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SN7PR13MB6302:EE_
x-ms-office365-filtering-correlation-id: 732ae8f0-7df2-4638-f502-08dc7a585f8a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?bnB0WkxtcmtMUGZKaGtJS2JBZFhXWGk2ZDdwU1JXZHZaU3Nodis0Tmt2VUZC?=
 =?utf-8?B?U09iWlJ3MTdJeDhqWXZUOTJMTUdjQW0yVk5TYjdDV09kblBZdHo3QWJxS2NN?=
 =?utf-8?B?ZnJ4ZE1xMVJYTmhieGtvcVlRaWhCM0IzTGFSblBBRUpHMEtreUt0NVZlKzI2?=
 =?utf-8?B?SWtJeUJIV2lSbGZSUktvNHVreFVLSEdRQmF1bmNSTTIzemxIdFlmS3pta0tM?=
 =?utf-8?B?cUErR0RFRlpNNVVuOFN3amV5QTd2MmZGM1JISEZzLzQ3Rys5MVlxbVlLZ2hK?=
 =?utf-8?B?TWRZM1N3YUJ4OHFEazZPS2RXTVYvdHlsZm1nQXQrV25mR2E0OHJTRVNHVm42?=
 =?utf-8?B?cGdoYjBUT08yd3c2dHE3eGYxTTRiMlRCdHF1NjFrVXF4M1pyM05ld3FXSHBx?=
 =?utf-8?B?Zk14dHNPdDZIaXFJVkQ4YTRrWHdoVFJqL3VQcWtRdUYzNFdvbkZONnpkSTNQ?=
 =?utf-8?B?S2o5RU5vK3BTVVpJQTR3Q3M0Yi9BZVdmYVZ5MTdjUmFWREV6alVvZVdpSVlE?=
 =?utf-8?B?SFhwK2FiMjg2cjljTUxSb01FVlJMSlptMGF5WEtuMlllbWE0WUVJeEs1MDBy?=
 =?utf-8?B?N3gzU1FTK2FzWFZLNFBrUzhndE0vcElFMkdFdWpiQ3QxOXN2cmViMEl0QnZl?=
 =?utf-8?B?eDYvV0xBRHdrcW9uUldQbVJxbVlzbnFzTTh2Sk9RMTVuY3hQZ2I0bS9BM0hh?=
 =?utf-8?B?N3gzb3A3N1RDNmhPQTFwNE1LSytLaDN3TkgxUEZoVjRyYU43WkNRMExZU1dt?=
 =?utf-8?B?bGRlNHVwajlDeURPTTFVUDk2ODhWZDRkYUtYOGN3STZwYXg3Rklxd1g5aGNE?=
 =?utf-8?B?QzZ2ZjczNWh6ZDRJT0J6Q2dFSlV4S0QrNytuRDhzUnh5Ukk1VzNBeVhLemlO?=
 =?utf-8?B?eklOWXFTbEt5QkpQdHJIY1VJTmdzcUprOVFYUVhlK1lZR0V2VEVmUFQxQlVN?=
 =?utf-8?B?Q244R3pCL2FDYzJCckJxZzdoOVZ5UFA5dTBpd0o1aTVObjQyOVcwK2xoMWZo?=
 =?utf-8?B?VlRjK0drN2VxYlEvSEd2bTh6Yy83c0dmU2lWWHJFNlY0QlFtZWRham8rK0l3?=
 =?utf-8?B?ZEtTNUgzOVB1NW9kRmo2Y2ducVpUVTlmQUVaSkRyR3k2cCtUUzd6b202RHFT?=
 =?utf-8?B?dDcyOXZVb3FEL0hZckpMWXVydmxDejlwRE1HSnpUVjVzelc2NklkSzNSZXV2?=
 =?utf-8?B?U0dmeGFRcituR09IVWhzckFvY0N2aDg2NWJoOCs5Y1JRaTJ4c1IxOEVQMllC?=
 =?utf-8?B?OGlBQWl0ZWVtRlR0alRyUWxlZ3ZHbUtWMis3MHdsMGxTeThKbEF5NWkvT3ZR?=
 =?utf-8?B?MGhZSHZyUXJEc2FtK3o5TVd4NE94MmFjS2x4SXVvcGtEdkYzSmpIUyswVWlZ?=
 =?utf-8?B?dXpBMm1zMUpGRVdsWFpUQ21YUE9yc1U4TmVZZDBRNnJ4QUJXaGU2MUJmVWFt?=
 =?utf-8?B?bG51Yi9RYnh3UVhTR2pSeVNDekNTUDRJZVJtSFFzWktRcysyakVoR0FoSWxi?=
 =?utf-8?B?Z1BhOW5hU3phaDdrM1dWMnBkeSsxVUV0M0VodFArRUlMWWs2c1NEb2xIUkVG?=
 =?utf-8?B?eVMySHphZXV4QzZsK0NXUGl3aTlDNTlSNXNKNURLWVZsczhwYXNvOFE0aE4z?=
 =?utf-8?B?MVJZL01sdU1sK0ZVcEJGeFVyY1Uxb0hDajNKSlEwbzgyZW02T0hWbUgzOWts?=
 =?utf-8?B?ZWVIZDR4emsyVnRvc1pXaVVGR2tuL0tYUjBiOW4yblNmN1BselcyT0FSMFdJ?=
 =?utf-8?B?Z0lmUlBYVDErTmVUNUpTT0Vmc0Vyc1A3cklqYXluNmZ4ZmhxREdqOUl2YUg0?=
 =?utf-8?B?M0ZSK2RZSHNpYWRrS202Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MndBSzBnakR0SjZscWUzV0hYdDNVeG4vT09WcW9xbkszRXlrSzUrTjJhSzJV?=
 =?utf-8?B?bUJ4dlJVakt1V0hFQzQzcFQvcytWSm1hNzZmanVldDFtOHJWMTlNQ09jTmNI?=
 =?utf-8?B?d3Rrd1pJbzhXcWlaaW9JMGpxMEZsNnY1WUJ3OFVJRDJXd0hTem9xVWZuZWpq?=
 =?utf-8?B?L2ZBSzcxYjRxY0M1TDlwSGlwZ3NPTjJvOTJERG5rUXdCUTk0Wk9kVERpUU9u?=
 =?utf-8?B?Yml6V2JzZC9vamU2bCtkWityNUkwdkIyL1ZMckd0SHFLb1NpNXQrZTgvZXds?=
 =?utf-8?B?d2VVdzFnRlJTMFFITy8zY1p3K1NDYS9vanZHU0ZoNWpaejlkS09jMUs0clVj?=
 =?utf-8?B?Z0g3bTJlV3JiVkFOYktsa3huM3lTTFZFaldHZEJUNXlCTHBSeWhiN2ZPL2xB?=
 =?utf-8?B?eEhGM2pwdkNJc2FkYllIRVZQUXM2ZVdQZ3o5ODdzSjBpUEVaakk3QVhKY3lK?=
 =?utf-8?B?aDBxVHBOcm1pVGJDMmpiOFdEOGxwVVVxN3MvbzcrRjh1Um9TWTJDM3pCaHVz?=
 =?utf-8?B?eFplc0tkd1BXYUlOUlVmbFZRR2FyY3hjUDhHS0xNMHdjeVFkVkpRWUtjc2ZW?=
 =?utf-8?B?STF5cGpNVC8xYTRhaXBWTWR3TnZoSTVlOHBqV0dIYmFJajVqZHhBYXdjdWt4?=
 =?utf-8?B?ZCtQRmVoZmo1MitqbDRxSlBZLzFETVFuTkF2L0tsYk5YWW5Kak5Bdk9UNGd2?=
 =?utf-8?B?S2pWUkFVbDZENUMwMmpucGtEUHlhNCtkQ29JVStlbVZoTTVjb3ROVEhsRHlD?=
 =?utf-8?B?TjF1Um1QajBZandnM0dua2VKREdmdUFwRWZ2Zkc4eVRySTY0Q0Z3Ykt5bEp4?=
 =?utf-8?B?Nkt1UUdJaUJVSEFpVVlLWXVheWhKcEdFTXlKT1VzdXhUbjgyeExZVEF0ZkdU?=
 =?utf-8?B?YkwxU21aNUtsSnlxTmJSbG5FR0dPQjZLUXVaVW1nMk5wZkRrbS9Ka1h6a25F?=
 =?utf-8?B?WnMzWnJHVW96aCt3dS9UQVRmT1FWOFRXR0dQNlJVUGxtNHJ0MjlNSXdCQXp4?=
 =?utf-8?B?YlFHSzc3Z3cxVE82TWlkNEk5VDlWM0ZpZWdJT2tBWFVHRzlPTFJLSmdMa21v?=
 =?utf-8?B?OFFSRmdSOXdFSEpxVFh6bDBCWm95ekJIbGdaSFUrZW5XOWdOUUtvRWpWcmZ1?=
 =?utf-8?B?b2xLUFZtRUhvdlhTQnIrSHE3YjJ4anpuNC8waVBJOXR5d1g1b2NlS2tyOVJR?=
 =?utf-8?B?ODdNc2o4RXZ4MXp1K0xEOWgvcUlocUlEWVBveWl2OWF5MVRabUhRc3FBYzVw?=
 =?utf-8?B?NmMwVjlNYTNSZTI5SjQxNElrTTdJcGZKcUVkZ2NIWEdHOGNoM082cXdoTWph?=
 =?utf-8?B?Wnovd0FEL2NQNkQyWjhzdWJBK2xUbzB6dEFyckRoOU1OOS9qN2twbGQ0bURw?=
 =?utf-8?B?allIM3U2TTRuN2F4Q01CVnN6c2kvRW9ZeFN0c0Z0eTdsR1BUNmdldGszMmdO?=
 =?utf-8?B?Rzd4NFhPd1RDby91RGVwTy9uQlBsQ0d5ampNMVVPYjB3L1NqRG9zVCtQTERz?=
 =?utf-8?B?bzJFbFdKRGtNU0pNTkhURzRzbFhCSEp4Y2x5UXI4My9UNUt1VDZSSHQ5RW1j?=
 =?utf-8?B?Nkx3L1pYSGVoblNNMjV1NGVsNS9PdTFyMS9CbDhxTUo0bnpaVU80a0VVSTl1?=
 =?utf-8?B?S2ZPU0xUMktzZHkwRUpRbkFpdituRlU1TTRLUXFBVzVPSEVPYVlRb2o1bUlU?=
 =?utf-8?B?SHpvUTNmaCtBNmcrQm4wa1JqNkNQaDNCekcvYmh1MUR3a29nSC90NFdEL25v?=
 =?utf-8?B?RXNmWklmd3ZpeVJ0a2g2ZUZkOXdpODhxN3haeVpnNVBreXFRRkdXaTBkUkxN?=
 =?utf-8?B?dUhSd3M5ZTU1Z24xaFB6d2Z6QWZNNEczbWtMdllvbzNIbkdPUm1uQ3RrSkR3?=
 =?utf-8?B?ZVJYVXhsbmhsM0hmUE5UOTV6eitMbng4UGJzTGVJZU1XTVJUalYrSEZRSE8z?=
 =?utf-8?B?RkIzL0paWlhkSDh2ZGlIbDkrak8vVzFDQlJNWTMydzVOSVNnWSttS3RaRUFw?=
 =?utf-8?B?L1ZOd1ZUTStFbEdvYnNzejFMOGEvN2dGMFdleXpiNXV0dDJzMEp4c2lpQ3RP?=
 =?utf-8?B?T25EQ0d1NlhqNVZvNGErMngxaHhxK3BPekVRQUFsdXozaE05ZXByWHVnakJ2?=
 =?utf-8?B?VUYvYi9sS0xDZGYzSFREdEQ0Wm1QWEVhM2pKN1plMmloZFpjNnZubm90QlBN?=
 =?utf-8?B?Sm5RNDBETGEwcnFtOGNVYzh6ckdCM2RSb2NQajdhUENMZUw5QndrckFHTDlS?=
 =?utf-8?B?TWNLeGk3dUV2NlZCMnJQNXRLbGNRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <685C29F3C9367649A349D788FD0B3207@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 732ae8f0-7df2-4638-f502-08dc7a585f8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 12:11:55.7989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c760MbE8tTdNGYbSKiIpJ4K/5JA8JOh6ZFGF2Opr87gALesIOUpp+Cmjp2SK7bz/JQfy/V6ieuaX4l6C5yF4IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR13MB6302

T24gV2VkLCAyMDI0LTA1LTIyIGF0IDA3OjQxICswMzAwLCBEYW4gQWxvbmkgd3JvdGU6DQo+IE9u
IDIwMjQtMDUtMjEgMTU6MjQ6MTksIENodWNrIExldmVyIElJSSB3cm90ZToNCj4gPiANCj4gPiAN
Cj4gPiA+IE9uIE1heSAyMSwgMjAyNCwgYXQgMTE6MTPigK9BTSwgVHJvbmQgTXlrbGVidXN0DQo+
ID4gPiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBPbiBU
dWUsIDIwMjQtMDUtMjEgYXQgMTg6MDUgKzAzMDAsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+ID4g
PiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gT24gMjEvMDUvMjAyNCAxNjoyMiwgSmVmZiBMYXl0b24g
d3JvdGU6DQo+ID4gPiA+ID4gT24gVHVlLCAyMDI0LTA1LTIxIGF0IDE1OjU4ICswMzAwLCBTYWdp
IEdyaW1iZXJnIHdyb3RlOg0KPiA+ID4gPiA+ID4gVGhlcmUgaXMgYW4gaW5oZXJlbnQgcmFjZSB3
aGVyZSBhIHN5bWxpbmsgZmlsZSBtYXkgaGF2ZQ0KPiA+ID4gPiA+ID4gYmVlbg0KPiA+ID4gPiA+
ID4gb3ZlcnJpZGVuDQo+ID4gPiA+ID4gPiAoYnkgYSBkaWZmZXJlbnQgY2xpZW50KSBiZXR3ZWVu
IGxvb2t1cCBhbmQgcmVhZGxpbmssDQo+ID4gPiA+ID4gPiByZXN1bHRpbmcgaW4NCj4gPiA+ID4g
PiA+IGENCj4gPiA+ID4gPiA+IHNwdXJpb3VzIEVJTyBlcnJvciByZXR1cm5lZCB0byB1c2Vyc3Bh
Y2UuIEZpeCB0aGlzIGJ5DQo+ID4gPiA+ID4gPiBwcm9wYWdhdGluZw0KPiA+ID4gPiA+ID4gYmFj
aw0KPiA+ID4gPiA+ID4gRVNUQUxFIGVycm9ycyBzdWNoIHRoYXQgdGhlIHZmcyB3aWxsIHJldHJ5
IHRoZQ0KPiA+ID4gPiA+ID4gbG9va3VwL2dldF9saW5rDQo+ID4gPiA+ID4gPiAoc2ltaWxhcg0K
PiA+ID4gPiA+ID4gdG8gbmZzNF9maWxlX29wZW4pIGF0IGxlYXN0IG9uY2UuDQo+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IENjOiBEYW4gQWxvbmkgPGRhbi5hbG9uaUB2YXN0ZGF0YS5jb20+DQo+
ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1l
Pg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiBOb3RlIHRoYXQgd2l0aCB0aGlzIGNoYW5n
ZSB0aGUgdmZzIHNob3VsZCByZXRyeSBvbmNlIGZvcg0KPiA+ID4gPiA+ID4gRVNUQUxFIGVycm9y
cy4gSG93ZXZlciB3aXRoIGFuIGFydGlmaWNpYWwgcmVwcm9kdWNlciBvZg0KPiA+ID4gPiA+ID4g
aGlnaA0KPiA+ID4gPiA+ID4gZnJlcXVlbmN5IHN5bWxpbmsgb3ZlcnJpZGVzLCBub3RoaW5nIHBy
ZXZlbnRzIHRoZSByZXRyeSB0bw0KPiA+ID4gPiA+ID4gYWxzbyBlbmNvdW50ZXIgRVNUQUxFLCBw
cm9wYWdhdGluZyB0aGUgZXJyb3IgYmFjayB0bw0KPiA+ID4gPiA+ID4gdXNlcnNwYWNlLg0KPiA+
ID4gPiA+ID4gVGhlIG1hbiBwYWdlcyBmb3Igb3BlbmF0L3JlYWRsaW5rYXQgZG8gbm90IGxpc3Qg
YW4gRVNUQUxFDQo+ID4gPiA+ID4gPiBlcnJuby4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
QW4gYWx0ZXJuYXRpdmUgYXR0ZW1wdCAoaW1wbGVtZW50ZWQgYnkgRGFuKSB3YXMgYSBsb2NhbA0K
PiA+ID4gPiA+ID4gcmV0cnkNCj4gPiA+ID4gPiA+IGxvb3ANCj4gPiA+ID4gPiA+IGluIG5mc19n
ZXRfbGluaygpLCBpZiB0aGlzIGlzIGFuIGFwcGxpY2FibGUgYXBwcm9hY2gsIERhbg0KPiA+ID4g
PiA+ID4gY2FuDQo+ID4gPiA+ID4gPiBzaGFyZSBoaXMgcGF0Y2ggaW5zdGVhZC4NCj4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gwqAgZnMvbmZzL3N5bWxpbmsuYyB8IDIgKy0NCj4gPiA+ID4gPiA+
IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL3N5bWxpbmsuYyBiL2ZzL25m
cy9zeW1saW5rLmMNCj4gPiA+ID4gPiA+IGluZGV4IDBlMjdhMmU0ZTY4Yi4uMTM4MTgxMjlkMjY4
IDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZnMvbmZzL3N5bWxpbmsuYw0KPiA+ID4gPiA+ID4g
KysrIGIvZnMvbmZzL3N5bWxpbmsuYw0KPiA+ID4gPiA+ID4gQEAgLTQxLDcgKzQxLDcgQEAgc3Rh
dGljIGludCBuZnNfc3ltbGlua19maWxsZXIoc3RydWN0IGZpbGUNCj4gPiA+ID4gPiA+ICpmaWxl
LCBzdHJ1Y3QgZm9saW8gKmZvbGlvKQ0KPiA+ID4gPiA+ID4gwqAgZXJyb3I6DQo+ID4gPiA+ID4g
PiDCoMKgIGZvbGlvX3NldF9lcnJvcihmb2xpbyk7DQo+ID4gPiA+ID4gPiDCoMKgIGZvbGlvX3Vu
bG9jayhmb2xpbyk7DQo+ID4gPiA+ID4gPiAtIHJldHVybiAtRUlPOw0KPiA+ID4gPiA+ID4gKyBy
ZXR1cm4gZXJyb3I7DQo+ID4gPiA+ID4gPiDCoCB9DQo+ID4gPiA+ID4gPiDCoCANCj4gPiA+ID4g
PiA+IMKgIHN0YXRpYyBjb25zdCBjaGFyICpuZnNfZ2V0X2xpbmsoc3RydWN0IGRlbnRyeSAqZGVu
dHJ5LA0KPiA+ID4gPiA+IGdpdCBibGFtZSBzZWVtcyB0byBpbmRpY2F0ZSB0aGF0IHdlJ3ZlIHJl
dHVybmVkIC1FSU8gaGVyZQ0KPiA+ID4gPiA+IHNpbmNlIHRoZQ0KPiA+ID4gPiA+IGJlZ2lubmlu
ZyBvZiB0aGUgZ2l0IGVyYSAoYW5kIGxpa2VseSBsb25nIGJlZm9yZSB0aGF0KS4gSSBzZWUNCj4g
PiA+ID4gPiBubw0KPiA+ID4gPiA+IHJlYXNvbg0KPiA+ID4gPiA+IGZvciB1cyB0byBjbG9hayB0
aGUgcmVhbCBlcnJvciB0aGVyZSB0aG91Z2gsIGVzcGVjaWFsbHkgd2l0aA0KPiA+ID4gPiA+IHNv
bWV0aGluZw0KPiA+ID4gPiA+IGxpa2UgYW4gRVNUQUxFIGVycm9yLg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IMKgwqDCoMKgIFJldmlld2VkLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwu
b3JnPg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEZXSVcsIEkgdGhpbmsgd2Ugc2hvdWxkbid0IHRy
eSB0byBkbyBhbnkgcmV0cnkgbG9vcGluZyBvbg0KPiA+ID4gPiA+IEVTVEFMRQ0KPiA+ID4gPiA+
IGJleW9uZA0KPiA+ID4gPiA+IHdoYXQgd2UgYWxyZWFkeSBkby4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBZZXMsIHdlIGNhbiBzb21ldGltZXMgdHJpZ2dlciBFU1RBTEUgZXJyb3JzIHRvIGJ1YmJs
ZSB1cCB0bw0KPiA+ID4gPiA+IHVzZXJsYW5kIGlmDQo+ID4gPiA+ID4gd2UgcmVhbGx5IHRocmFz
aCB0aGUgdW5kZXJseWluZyBmaWxlc3lzdGVtIHdoZW4gdGVzdGluZywgYnV0DQo+ID4gPiA+ID4g
SQ0KPiA+ID4gPiA+IHRoaW5rDQo+ID4gPiA+ID4gdGhhdCdzIGFjdHVhbGx5IGRlc2lyYWJsZToN
Cj4gPiA+ID4gDQo+ID4gPiA+IFJldHVybmluZyBFU1RBTEUgd291bGQgYmUgYW4gaW1wcm92ZW1l
bnQgb3ZlciByZXR1cm5pbmcgRUlPDQo+ID4gPiA+IElNTywNCj4gPiA+ID4gYnV0IGl0IG1heSBi
ZSBzdXJwcmlzaW5nIGZvciB1c2Vyc3BhY2UgdG8gc2VlIGFuIHVuZG9jdW1lbnRlZA0KPiA+ID4g
PiBlcnJuby4NCj4gPiA+ID4gTWF5YmUgdGhlIG1hbiBwYWdlcyBjYW4gYmUgYW1lbmRlZD8NCj4g
PiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSWYgeW91IGhhdmUgcmVhbCB3b3JrbG9hZHMg
YWNyb3NzIG11bHRpcGxlIG1hY2hpbmVzIHRoYXQgYXJlDQo+ID4gPiA+ID4gcmFjaW5nDQo+ID4g
PiA+ID4gd2l0aCBvdGhlciB0aGF0IHRpZ2h0bHksIHRoZW4geW91IHNob3VsZCBwcm9iYWJseSBi
ZSB1c2luZw0KPiA+ID4gPiA+IHNvbWUNCj4gPiA+ID4gPiBzb3J0IG9mDQo+ID4gPiA+ID4gbG9j
a2luZyBvciBvdGhlciBzeW5jaHJvbml6YXRpb24uIElmIGl0J3MgY2xldmVyIGVub3VnaCB0aGF0
DQo+ID4gPiA+ID4gaXQNCj4gPiA+ID4gPiBkb2VzbicndCBuZWVkIHRoYXQsIHRoZW4gaXQgc2hv
dWxkIGJlIGFibGUgdG8gZGVhbCB3aXRoIHRoZQ0KPiA+ID4gPiA+IG9jY2FzaW9uYWwNCj4gPiA+
ID4gPiBFU1RBTEUgZXJyb3IgYnkgcmV0cnlpbmcgb24gaXRzIG93bi4NCj4gPiA+ID4gDQo+ID4g
PiA+IEkgdGVuZCB0byBhZ3JlZS4gRldJVyBTb2xhcmlzIGhhcyBhIGNvbmZpZyBrbm9iIGZvciBu
dW1iZXIgb2YNCj4gPiA+ID4gc3RhbGUNCj4gPiA+ID4gcmV0cmllcw0KPiA+ID4gPiBpdCBkb2Vz
LCBtYXliZSB0aGVyZSBpcyBhbiBhcHBldGl0ZSB0byBoYXZlIHNvbWV0aGluZyBsaWtlIHRoYXQN
Cj4gPiA+ID4gYXMNCj4gPiA+ID4gd2VsbD8NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IEFueSBy
ZWFzb24gd2h5IHdlIGNvdWxkbid0IGp1c3QgcmV0dXJuIEVOT0VOVCBpbiB0aGUgY2FzZSB3aGVy
ZQ0KPiA+ID4gdGhlDQo+ID4gPiBmaWxlaGFuZGxlIGlzIHN0YWxlPyBUaGVyZSB3aWxsIGhhdmUg
YmVlbiBhbiB1bmxpbmsoKSBvbiB0aGUNCj4gPiA+IHN5bWxpbmsgYXQNCj4gPiA+IHNvbWUgcG9p
bnQgaW4gdGhlIHJlY2VudCBwYXN0Lg0KPiA+IA0KPiA+IFRvIG1lIEVOT0VOVCBpcyBwcmVmZXJh
YmxlIHRvIGJvdGggRUlPIGFuZCBFU1RBTEUuDQo+IA0KPiBBbm90aGVyIHZpZXcgb24gdGhhdCwg
d2hlcmUgaW4gdGhlIHNjZW5hcmlvIG9mIGByZW5hbWVgIGNhdXNpbmcgdGhlDQo+IHVubGlua2lu
ZywgdGhlcmUgd2FzIG5vIHNpdHVhdGlvbiBvZiAnbm8gZW50cnknIGFzIHRoZSBkaXJlY3RvcnkN
Cj4gZW50cnkNCj4gd2FzIG9ubHkgdXBkYXRlZCBhbmQgbm90IHJlbW92ZWQuIFNvIEVOT0VOVCBp
biB0aGlzIHJlZ2FyZCBieSB0aGUNCj4gbWVhbmluZyBvZiAnbm8gZW50cnknIHdvdWxkIG5vdCBy
ZWZsZWN0IHdoYXQgaGFzIHJlYWxseSBoYXBwZW5lZC4NCj4gDQo+ICh1bmxlc3MgeW91IGdvIHdp
dGggdGhlICdubyBlbnRpdHknIGludGVycHJldGF0aW9uIG9mIEVOT0VOVCwgYnV0DQo+IHRoYXQN
Cj4gd291bGQgYmUgYWdhaW5zdCBtb3N0IG9mIHRoZSBQT1NJWC1zcGVjIGNhc2VzIHdoZXJlIEVO
T0VOVCBpcw0KPiByZXR1cm5lZA0KPiB3aGljaCBkZWFsIHByaW1hcmlseSB3aXRoIG1pc3Npbmcg
cGF0aCBjb21wb25lbnRzIGkuZS4gbmFtZXMgdG8NCj4gb2JqZWN0cyBhbmQgbm90IHRoZSBvYmpl
Y3RzIHRoZW1zZWx2ZXMpDQo+IA0KDQpUaGUgTGludXggTkZTIGNsaWVudCBkb2Vzbid0IHN1cHBv
cnQgdm9sYXRpbGUgZmlsZWhhbmRsZXMuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K

