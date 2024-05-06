Return-Path: <linux-nfs+bounces-3180-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5198BD626
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 22:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D843B225F0
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 20:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E2E15B0EF;
	Mon,  6 May 2024 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Qt06fBpX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2129.outbound.protection.outlook.com [40.107.92.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A765E56B76
	for <linux-nfs@vger.kernel.org>; Mon,  6 May 2024 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027135; cv=fail; b=AjR5q1UzztDjHdR6wHDz2q0aiWJYdy2kzsdECqp5+CDDTVL+pZ3A3WwOXA1TXHcOcRarUkloQJ0deSK5qlPcaPSWj9W5Payp45sFv5TO9wSUbx4EImt/UZdqVwGJuFdvHfdZaXQ+Mj4IoQImjNCMLo1s1ofbvMGxHX6DwsYgCdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027135; c=relaxed/simple;
	bh=r+kaKnONgVTO+xW+s51Fs6HK+2BsnFC1Xi97GM4esqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CbOxZQAyO1x69Y07i8aqtUm5+Ewo0do1qbYRvY2yg/b6ubV+LRl4QHBrVEGt6moC70qls32rWhOmBfDlefFzF9HAqRGipWsVB4z0+NsvNA4hkrOUFRa30pnVa2NYAf5uVTEkfpzscNYJOnyV9pedkjl/A35+p4mJBMaQh2Djb34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Qt06fBpX; arc=fail smtp.client-ip=40.107.92.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCr08FF6VefWLjnK3r7M/NbCtOUNs7tBwUDa9d7hEdi2rGRxQTDfDfzqikDChKAYmBiPK/ge2XSylCZ/sG6UKdM4RScfpMJ22aHLam1b4Y1ZmddgIBe2n4rjmepUpthCmLd56aayHv1IVQ0rYbbptsMRM2aamf58Tf7aSGnI4AM62AHxJ+sVxyIlgNqBLcwK39RR5lP86DUGZeMYU7/9ByiPvuae8wPgd1YKCvH/7BpiKn8otelRLXthSSrTuoYVT0g1o7NIbVCIIuh56vaubF1ZsPd1DdDUHqXip4B/eC6pri2D3brJZ07T+IIxSPmUBJFvi/GbvSuIwxnYXb+GHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+kaKnONgVTO+xW+s51Fs6HK+2BsnFC1Xi97GM4esqI=;
 b=DIOXZWCoXhe3cKYCBf5SSaXHJtv2WfJPnYYbLxuvh3bWm/2ztI2d42G4aL6K6Egsg3AIfNC60l6PPLL/HnCdcwZPvT1ic+d6TDVPX6v2vuzy84DqvDyidABTNc1bCg0x9cnCirFVl9Wqb5JagxjazI4mRYAscL0dRRGT6or8rJU9PPmLRQgWk1Fq7+gngIBL6KGzcoXve5zWcv0kzVC3bIIsmo9GqhnInh83nRfdn9ANjGImWkwVmM03+T/Qr4SCy3E+/5iFrCWTlCAH7OAV/O2rlUH4s6tyfslryCjs4TJjF0FveN9wS8ItMagHabUbrLl4GQ8o8NQ6a+zuoBAK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+kaKnONgVTO+xW+s51Fs6HK+2BsnFC1Xi97GM4esqI=;
 b=Qt06fBpXjXJMCD7/v982xGieT/1yUyRuwQ/J1xPWGNmpiKKOpCGPHaVsylqRaO+rFO8kIWgZubr8cY07YVVOhbH1lSMWuPnuhuZUUYfMFyKpf6P6bvk9kMJAK/TKOXHsIlzYC5sXoboUOQcMHvW8CXHBEOdYhW4nRrfNCL7b9l0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW5PR13MB5927.namprd13.prod.outlook.com (2603:10b6:303:1c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 20:25:29 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 20:25:29 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
CC: "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"sagi.grimberg@vastdata.com" <sagi.grimberg@vastdata.com>
Subject: Re: [PATCH v3] rpcrdma: fix handling for RDMA_CM_EVENT_DEVICE_REMOVAL
Thread-Topic: [PATCH v3] rpcrdma: fix handling for
 RDMA_CM_EVENT_DEVICE_REMOVAL
Thread-Index: AQHan5lXyB5yxoeSc0uiz/rs9N8ntrGKonUAgAAFaQA=
Date: Mon, 6 May 2024 20:25:29 +0000
Message-ID: <006aa86371df14c831e00e5411fedaee34f1efad.camel@hammerspace.com>
References: <20240506093759.2934591-1-dan.aloni@vastdata.com>
	 <Zjk4LuOnti/ouaVw@tissot.1015granger.net>
In-Reply-To: <Zjk4LuOnti/ouaVw@tissot.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MW5PR13MB5927:EE_
x-ms-office365-filtering-correlation-id: 5040eedd-9dc0-429c-9dce-08dc6e0aac00
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?VXdxK3dFQk5RTmtJQ2owcXlic0o0U0tjUWNpTDlnSmdIaXBsc1FmRDY0aHlr?=
 =?utf-8?B?dmpZWXZWT1ZHcFBaU0N1YUo3VnJxNmFSQmo5djhwZk5KSzR1UUNLR3JaQTFY?=
 =?utf-8?B?UDNkcWtDQXdoNHJ1bVhSQVZ3YXRWdFhvekxqRjJLOExtZWlPc0I2Qll0STVT?=
 =?utf-8?B?NHZGV2JUSmdhRWx2ZDhBenhwVDJxQnFNMUw3OG5aWUVvdjkzLzg2VWFuQnIy?=
 =?utf-8?B?aW5MNk84eEpSdHpHV0JqNGVsZk9xaml1cEQ3R2s2N1pIbFR2ZWNDSUJGeUZB?=
 =?utf-8?B?K1l2Q3hDdlVpQmx0TWswUmw1eDQxajRKa0p0MVlsQzk4L2JsaXJ4WUN3YktP?=
 =?utf-8?B?ODRNclptY3Y2LzBVM29GTCs1dEpIWFBtZ3FXeU1ZcHk5MWNLOVFwa0dQMUJa?=
 =?utf-8?B?Z2hsZUxzTW11SlJLYmsxOW9SKzNaSkxwcm9MTGhsNFJmK3k3NzYxeE40VXNU?=
 =?utf-8?B?UHlTc0NrL1gwT3BCQWd2TVhPYnZrMzdLNGlYMEE5R2FHQUdEZGZzZGcxT1pa?=
 =?utf-8?B?K3NlOXM3ZVYrbFNucWM4SDl5SmpZOXROVE8rUDVVTHRqU0xGcHpYNitmU0J3?=
 =?utf-8?B?bjRpb2dsa0psV2hlbHpvbTRkVldBVDJWNkpBaFdEaUNPajQxd2JXSHBkMmhx?=
 =?utf-8?B?Nlk3VTg1YWtQcHoyMHVEK0dud1MrOEs5aHNINlhpbnFKTUU3dm84TExZeXh3?=
 =?utf-8?B?ejNRUkNZUVQzMWY4eElpMXRoNGRlZjlFNzFLdG01QW1mZXpFMUFuWkxhM2Q1?=
 =?utf-8?B?Z3JMZ1kzRkEreTdidWViSzdsbXR1eDVqRnFYTmJPbmF1ZGEyVHpvYTZWMmV0?=
 =?utf-8?B?VnBtWnpiVC8xY3VhRURWc0l4VHl5VHdob0kvQWU3R0U5QTZ5MENacDJmcUc2?=
 =?utf-8?B?QTcwWlEvNUVoZWV6Z0RIeGY0VnIxK0k5VWk4SjhHSVo3QmljZTVHS09SU2Vy?=
 =?utf-8?B?Z3dkSlFxc0FyRmFQOERTOC95R0pIcGhqUXZLeTcvbzcwRm8xdFZUNS94eVNH?=
 =?utf-8?B?MTlxNlpXTlQwNmU1djNKSWJIbjF6TEg0Zm5wTkd1c3lUa1ZsWFhRYkpNbS84?=
 =?utf-8?B?KzhJdjVaRGdVSWUycjdESVFVM3A0MVpuZzBXSnN4SWhQZEJnS1paWG8xYmVq?=
 =?utf-8?B?aWFJcG94ZEc4MlhETkZjOXB6Zlg5Uk5BbFBwYk5QMUVXZEREUVcyS080TXkr?=
 =?utf-8?B?Wld5ZkJvQUJOTVhNcnpxeWdDeitLamZnRXVhZzNicHBmNXo1d3JxdXBCRGUw?=
 =?utf-8?B?aWJKMVZnekZqaFNwZ3VhaW00WGdrTVZhd245aVZFcHFtVW80dlZEVUdSczJH?=
 =?utf-8?B?M0VCb0NkWHFORDdSVnVHTEZiejRvaGgrUmZObTFlK1dpOEpIU0JRWlBHUjVn?=
 =?utf-8?B?ZDltVlYxKzl1RHJmVnJrS2ZUR2NWWk4ybWM1YXNmTGVhSjVpTkZWc1JNd1gv?=
 =?utf-8?B?RFNaNzJpWXBDZ2JzemFLNWpmZm5aUjl4T25kZEhhNXh2UUV3TWdPNTArbDdB?=
 =?utf-8?B?SG8xcHY0T3N4RFVqQXRNdlA0S0s3VC9IWjdZUTRaZXhacHpRSWZBTkhSaUJ2?=
 =?utf-8?B?VDhLUDFaV1ZlQlFkUVlaZ2kyeVIrdGpQOFZrQUM2YUt2dFVhdStid08wS092?=
 =?utf-8?B?TnYzZzE5QzVTS0xkTDFTVjhzblY2NVRkTFJhcmxycFdsOG1sR1dHYnFpVGV1?=
 =?utf-8?B?aDJDUm94Kzkxc1QxMnhOK3hoMmZVN01hOW85d21LandvZERDOEZ5QmhwRmMw?=
 =?utf-8?B?OXJVS0pRNzc4ZjBUa1Z2aVBMbnNHaXN0WWcwMmVNYmFDZmh5OCtnVUhlL2Qz?=
 =?utf-8?B?TmhtbVpDT2Q0TkQwbkVuUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGcrTTI3b1pKUHcxbEZIeXRUSkJ5SWJWVGRIZ0t5SFlTS3RRekk1bndDWnFl?=
 =?utf-8?B?RXJpbTE4MlltbHErTlJxbUZpUW9meTBjTlJ5bW1hVDRrSzlDeVRXeitCYVhY?=
 =?utf-8?B?K05xYWV1cEVHLzNCMzRMMk50dDE3VU8vYy9IbGRaMm0vakFIWXArN000d1Bw?=
 =?utf-8?B?RTgycUcycVNSaVpMOHVyeWNCWTB2ZHFkQWlFa0t5N05qQUpGNzRNendpWTYx?=
 =?utf-8?B?SStLdU5XekpseVBZZStXRmI1VFg2Q3UxNWRrMFBGdHg3andLaGxxNWF5OHli?=
 =?utf-8?B?SXFNYTMrK1dTOG9YUFlSa3NkQTk0WVdBOVdMbUZpWFdsaVZkMmJCTThrdE8y?=
 =?utf-8?B?Q3g1RHF0YkRPSVpvSHRUcDFOZ3dhY0pNd1dBREF5RmRQSnFZckFHWUdTaG5M?=
 =?utf-8?B?ZWxIT3d4a2FmZFMvdXcrbU43RUYxTnNKQXR1TG9DSzZ0cGEzdFE1NTVMc2hX?=
 =?utf-8?B?djlaZWlzTUZDSGtYNGx1WWxiSHRxdWhONThtaHFXRlA1cVdWU1ljYzdwOXlG?=
 =?utf-8?B?RC9yL2pMKzhlZVFIWHBSVEwxVUZpMmVjMnFKb3ROSXR0Q1g1OEVsSVVlcEFO?=
 =?utf-8?B?Z0hJUmlTR0FQRldmdEtVU2Q4MFhJNlBPUGM4SGlDUDVxb0RJMXJHbWN1ZytJ?=
 =?utf-8?B?UDAvMUNhU3N3Rmg2cFRiZVMxb3U4SFRmWGhCZURLVGgwM3pxTUpja2FEaGIz?=
 =?utf-8?B?Z2JraGxHRG8rYVI3bTVvVStMY090WVoyV1hzbWgrNzl4TWdQdi9rUXlUMzZw?=
 =?utf-8?B?MmJWRjNMekIvRHdPdVI5QUJmM1prSlRkNWhMeWZvekM5R051akZBNThaTjdY?=
 =?utf-8?B?VmtwVS9vNi8rT1p3VW9QRXpielRmbEEwUmpHR2swWnFWaG1IbGJ3Q3Y5RjFS?=
 =?utf-8?B?MTRMTzhVaGVzVnR1QzdtQzdZbDAxbVRsdjJOUXphWmhTL29jcjRIV3J4TzNs?=
 =?utf-8?B?Vnc0OGFvSTZ2cHpockRHekQ1UXNTYmJuNmZDbWF0S1ZPN2Z5R3pEdDJTQkdh?=
 =?utf-8?B?QUZ1MlVrM0pNaS9xdS85TVhEeGF6RUNqei93WHNUTDNEaEh2cU1jVzJ2bUlz?=
 =?utf-8?B?dzNRN1ZWc0RoTmRHU1JzNks0ZHVzQUYzTG1KZUhkTy9CbGMwWVg0cTRaNXhT?=
 =?utf-8?B?WlZ4dnNORTkxbFRpeVRjZ3o2bHdaZ2VyN28yUEhMQmpSRDdBYUJsTzNSZjJ1?=
 =?utf-8?B?Zk5mbkZEOG80a2hPOEtnSW9YdktUSktlTDQ4OGc4d0ZZL3lOZzRDaktqS1hT?=
 =?utf-8?B?QzdjRE9ycHpib3R3WGpqYUVYcWgwK2UxVnp4YVZ0dTFMbmtSczQwTjgrM3JM?=
 =?utf-8?B?c0I1L3R1dGMwcTVGTGNGRWZ5dWczWkFHOUtjank2a3JWdXhpd0lVakFRanRq?=
 =?utf-8?B?VUE3OXBSMmtSUzZNcXBudWtGWTVYUUs4VE90em51RFZubzhkQXRmUjZ3cjgy?=
 =?utf-8?B?OTdsT29kZ012cm1wRDBQQ1piZVZ1MG9Cdk9rOHZXVEpXVTVhamZwcGVyYTh4?=
 =?utf-8?B?RXFtMCt0WEN0OGpkaVlYMEJZam9ZNUd2U3ZKQU5kU0RtS2JHUW5COHNEZWw4?=
 =?utf-8?B?eFlaTnBOTXAyODlyMGdpOGpHWlV1TGdTdjNjRUI5aGdBd2crOXBFd0xlWFBt?=
 =?utf-8?B?a2ZwL1NrL3pRaGxnc3BPWG90MU44dDhMaDhvM2FhbFpUN2xzSEtlVFFuOWkv?=
 =?utf-8?B?SjV0eUxZSExWeEFzYTJKaStQb0orVWtOcTRoMW9FNW1YWHJFRWtHUFgrT1BT?=
 =?utf-8?B?elM2aFBxWllzWitXRzM5d0R1R3RSK0FFOHp5M2c1RHZTRG1zbE5RM2JkVUt2?=
 =?utf-8?B?STV5bisrYWJwNmRmY3hUaXlndGlhMndnZzIybE85S0VuNlVBTjhMRjh3QkRH?=
 =?utf-8?B?R3UwRVJqRjdwYmhWY3c4SGFrcHk1YnplcDU3RmpmelpYLzBvK3p2eEZhTGVM?=
 =?utf-8?B?MjNGWS93cUh3bnV5UEVZUmp2QlZOTXI4blBsZDdPZ2ZlWmlpOENLS1VjWkhp?=
 =?utf-8?B?eTNaTit0ZkFWZURab3FiV0p5RXhlNXNyVzFEbUpyZ0JLRVlxUmZnbzZiNVpm?=
 =?utf-8?B?OXVUQWwxNUdHRGxyajBibTU0UWU5UlRDeXZkdHlyekZaRmNhUkVNaEJGR1Fs?=
 =?utf-8?B?SWdrSHlLazk5bDVTeURnYTlaN2R4ZENaNUsvYm5oTWtkS28wWHNEQVk5TUda?=
 =?utf-8?B?RlhVNWtyZVM3aDViMkNLWjBIMlpYWmJOSmd1NmVld3pGY1lSbG9MMmdmZFQ3?=
 =?utf-8?B?VlJ6Ynp2RVZLSXFoZGFhT3FCMlpRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AC292E2E8442D40A8529C62B4DBC820@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5040eedd-9dc0-429c-9dce-08dc6e0aac00
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 20:25:29.3753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thbjh9DMfGwxCqP9Tnmu7w+4HDsREunxFmtgpevJ/CRsuI5ETHhNX39j6yfYM0fE6cnt3Hs50d0sVADObgmb3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5927

T24gTW9uLCAyMDI0LTA1LTA2IGF0IDE2OjA2IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
T24gTW9uLCBNYXkgMDYsIDIwMjQgYXQgMTI6Mzc6NTlQTSArMDMwMCwgRGFuIEFsb25pIHdyb3Rl
Og0KPiA+IFVuZGVyIHRoZSBzY2VuYXJpbyBvZiBJQiBkZXZpY2UgYm9uZGluZywgd2hlbiBicmlu
Z2luZyBkb3duIG9uZSBvZg0KPiA+IHRoZQ0KPiA+IHBvcnRzLCBvciBhbGwgcG9ydHMsIHdlIHNh
dyB4cHJ0cmRtYSBlbnRlcmluZyBhIG5vbi1yZWNvdmVyYWJsZQ0KPiA+IHN0YXRlDQo+ID4gd2hl
cmUgaXQgaXMgbm90IGV2ZW4gcG9zc2libGUgdG8gY29tcGxldGUgdGhlIGRpc2Nvbm5lY3QgYW5k
IHNodXQNCj4gPiBpdA0KPiA+IGRvd24gdGhlIG1vdW50LCByZXF1aXJpbmcgYSByZWJvb3QuIEZv
bGxvd2luZyBkZWJ1Zywgd2Ugc2F3IHRoYXQNCj4gPiB0cmFuc3BvcnQgY29ubmVjdCBuZXZlciBl
bmRlZCBhZnRlciByZWNlaXZpbmcgdGhlDQo+ID4gUkRNQV9DTV9FVkVOVF9ERVZJQ0VfUkVNT1ZB
TCBjYWxsYmFjay4NCj4gPiANCj4gPiBUaGUgREVWSUNFX1JFTU9WQUwgY2FsbGJhY2sgaXMgaXJy
ZXNwZWN0aXZlIG9mIHdoZXRoZXIgdGhlIENNX0lEIGlzDQo+ID4gY29ubmVjdGVkLCBhbmQgRVNU
QUJMSVNIRUQgbWF5IG5vdCBoYXZlIGhhcHBlbmVkLiBTbyBuZWVkIHRvIHdvcmsNCj4gPiB3aXRo
DQo+ID4gZWFjaCBvZiB0aGVzZSBzdGF0ZXMgYWNjb3JkaW5nbHkuDQo+ID4gDQo+ID4gRml4ZXM6
IDJhY2M1Y2FlMjkyMyAoJ3hwcnRyZG1hOiBQcmV2ZW50IGRlcmVmZXJlbmNpbmcgcl94cHJ0LT5y
eF9lcA0KPiA+IGFmdGVyIGl0IGlzIGZyZWVkJykNCj4gPiBDYzogU2FnaSBHcmltYmVyZyA8c2Fn
aS5ncmltYmVyZ0B2YXN0ZGF0YS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGFuIEFsb25pIDxk
YW4uYWxvbmlAdmFzdGRhdGEuY29tPg0KPiA+IC0tLQ0KPiA+IMKgbmV0L3N1bnJwYy94cHJ0cmRt
YS92ZXJicy5jIHwgNiArKysrKy0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy94cHJ0
cmRtYS92ZXJicy5jDQo+ID4gYi9uZXQvc3VucnBjL3hwcnRyZG1hL3ZlcmJzLmMNCj4gPiBpbmRl
eCA0ZjhkN2VmYTQ2OWYuLjQzMjU1N2E1NTNlNyAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvc3VucnBj
L3hwcnRyZG1hL3ZlcmJzLmMNCj4gPiArKysgYi9uZXQvc3VucnBjL3hwcnRyZG1hL3ZlcmJzLmMN
Cj4gPiBAQCAtMjQ0LDcgKzI0NCwxMSBAQCBycGNyZG1hX2NtX2V2ZW50X2hhbmRsZXIoc3RydWN0
IHJkbWFfY21faWQNCj4gPiAqaWQsIHN0cnVjdCByZG1hX2NtX2V2ZW50ICpldmVudCkNCj4gPiDC
oAljYXNlIFJETUFfQ01fRVZFTlRfREVWSUNFX1JFTU9WQUw6DQo+ID4gwqAJCXByX2luZm8oInJw
Y3JkbWE6IHJlbW92aW5nIGRldmljZSAlcyBmb3INCj4gPiAlcElTcGNcbiIsDQo+ID4gwqAJCQll
cC0+cmVfaWQtPmRldmljZS0+bmFtZSwgc2FwKTsNCj4gPiAtCQlmYWxsdGhyb3VnaDsNCj4gPiAr
CQlzd2l0Y2ggKHhjaGcoJmVwLT5yZV9jb25uZWN0X3N0YXR1cywgLUVOT0RFVikpIHsNCj4gPiAr
CQljYXNlIDA6IGdvdG8gd2FrZV9jb25uZWN0X3dvcmtlcjsNCj4gPiArCQljYXNlIDE6IGdvdG8g
ZGlzY29ubmVjdGVkOw0KPiA+ICsJCX0NCj4gPiArCQlyZXR1cm4gMDsNCj4gPiDCoAljYXNlIFJE
TUFfQ01fRVZFTlRfQUREUl9DSEFOR0U6DQo+ID4gwqAJCWVwLT5yZV9jb25uZWN0X3N0YXR1cyA9
IC1FTk9ERVY7DQo+ID4gwqAJCWdvdG8gZGlzY29ubmVjdGVkOw0KPiA+IC0tIA0KPiA+IDIuMzku
Mw0KPiA+IA0KPiANCj4gSGkgQW5uYSwNCj4gDQo+IFBsZWFzZSBhcHBseSB0aGlzIHBhdGNoIHdp
dGg6DQo+IA0KPiBSZXZpZXdlZC1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4N
Cj4gUmV2aWV3ZWQtYnk6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPiAN
Cj4gDQpBbm5hIGlzIGJhY2sgb24gbGVhdmUgZm9yIGEgZmV3IHdlZWtzLCBzbyBJJ2xsIHRha2Ug
aXQuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIs
IEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

