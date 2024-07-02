Return-Path: <linux-nfs+bounces-4567-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C909248C8
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 22:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7FB5B22BE2
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 20:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C03E200103;
	Tue,  2 Jul 2024 20:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VqaJd9H9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ykEz5c0o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF971D3638
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719951036; cv=fail; b=ZauMWPw7URH9mkoG9Q4unZOIGrKIxK4nz4JaRIkTrCV4DJsmZ4Hxr5uJLSTOkXWGYL5FqEE9fVNEnBDxbLD8KNIrqlJZnieXkIh3ZvkLRaYMGNv9wC+N5TwZp5TKL9EqPmIkhcXdsYx2IqNCK/l7EnO2DiI1Ns5zoHzL/q+EhQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719951036; c=relaxed/simple;
	bh=OWqhoyEcgJw/IQ+qET7mq2Uhp3HM1+jNoVNgXh0ReYg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KcyI8KZsKkNmZkGyR0EygkZFHlv+qfMj6ET5MGi675rAFLq33JfG0j5HDR2n6NqfH+Jit4193FH1Al7UsTnX9JZedQKtXbo/AlkebYc5czIVREGJY/JBNWovlaR9u04fcm/8Lh20xthNsgXhTLZEQXDPTZTX90xpKSDtCByfDHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VqaJd9H9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ykEz5c0o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462HfVVH006956;
	Tue, 2 Jul 2024 20:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=OWqhoyEcgJw/IQ+qET7mq2Uhp3HM1+jNoVNgXh0Re
	Yg=; b=VqaJd9H98OAVicc5xsBJEAObpfqCq0WlaJAkmLkl4ddwPhUuYbAaV2VaV
	mmdkLYhTkmVQ11trfx7LnAxjMgh5NYoMqFYjTnq0qIZ7+ZAQcZGzzHLkC1oKkpbn
	BBqiPDJdMl7rxurSG1dccVcWo4mpE0AKs1nGnW59uOhfIYG2QYWivEJm+EFWV3FN
	KieQh+IDfTRSIfUME/EKiYJK8lvoMo7d/O/F1DVSMpN820LOLzWFO2ecAo/Zci7w
	b3iib+rPmvk88cZTetop+mKp4K7kVdGMqP9RTN65Gt5ni04lN53jujAZW5ujI+OK
	goHLm/lDQbv1b5I7M1elzq9EtdX2Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a596kbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 20:10:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 462JkJtE023698;
	Tue, 2 Jul 2024 20:10:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n0y87ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 20:10:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIkXgWZ6SCJ8iXodalNNzynlq+V79Gy0teiY95SFEPEwBJLoWEJcE+noaPnV1dFZj1kQW8TZwi4FcrE7w7Iu33f96fsPdRLVJy6he1QJSmZrxw6m1/CF8+u3SMwEI1Z1VgGMqQrLgyQSIrujzCy38qqTvUwD9CVTTEeSc3fCYNbSAZAUpk3tHASqHrk+NQeeaB6RBLGkypCp3O+3Yocz3GCzAj9x4f8ZQ3BFpMjlGqUvzNvpjHQVkwf3q0WBJ8aiDjbaY2fY9I9ZW8K6kjp/IDOUwjscmxVAgBMzesOpL95URe37NgCq0btrO85639Fc+cpMk4GRoXTxmoRhvVXFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWqhoyEcgJw/IQ+qET7mq2Uhp3HM1+jNoVNgXh0ReYg=;
 b=W1XBt5exn8Als0NRoacGnQJnIxUre6BdHP4yzJ6f/4qexffmGWZ5mcY7SO2MKLoQscfxRAzLVD6h2ApfCFyavbgichkRYJhvWP9CgyGJSMSsZG+1UX9C0RMAjqMMHckjEVDhmqO4YHIBc4teKoCvFMoVMsFwcNoCb0mWCKPZfsi6IekeYOZ8twMcriTIcDYzbSCigFn74m47s1gK6rinN/EQGqLHwM2jcFT2v4V9qz3OlnXYHnzx4a5Ckf3lY+Ss0HDS2WdvUkgD9CgVZgZEc9RGSBbzbgbmPzH4AbkwYqn5bTqrPKlZQShKI4UtXFuq56jSBAj1dwrogX99DF4iyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWqhoyEcgJw/IQ+qET7mq2Uhp3HM1+jNoVNgXh0ReYg=;
 b=ykEz5c0oQJCFDMTuUTzBmPmn7IxJUBOXb3kXnRO0Su54TB3OXkwACffxfyfcranhjpAdF688KBfalTsvPnU17v8g1O9WmYOYXZLOvc3Vx4Wl23TYCiPU9RK/u7wMsfOVoH90+x9FFSCARtzWpRwQcAiNbTz8WPWXErRuaxOHIFI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5569.namprd10.prod.outlook.com (2603:10b6:303:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 20:10:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 20:10:13 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton
	<jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust
	<trondmy@hammerspace.com>, Neil Brown <neilb@suse.de>,
        "snitzer@hammerspace.com" <snitzer@hammerspace.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Thread-Topic: [PATCH v11 00/20] nfs/nfsd: add support for localio
Thread-Index: AQHazJzmgcDeJH7XRUCD8QiVhiofhbHju8AAgAAHYoCAABtIAA==
Date: Tue, 2 Jul 2024 20:10:13 +0000
Message-ID: <D59D6432-0D47-427C-9549-EF60C59595C4@oracle.com>
References: <20240702162831.91604-1-snitzer@kernel.org>
 <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
 <ZoRHt3ArlhbzqERr@kernel.org>
In-Reply-To: <ZoRHt3ArlhbzqERr@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO6PR10MB5569:EE_
x-ms-office365-filtering-correlation-id: 9a9513d9-6c35-4124-e31b-08dc9ad2fb96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?anUwcnJTUkNzRHoxWHU1L3ZnZ1F2aUtvMXVqVzNaY3Rxd0VqdG01N1hoZDBz?=
 =?utf-8?B?VFFqZW5jMlRRbUhJcENpTWdxYk9DdUtKa2hJR2VRUWovV0x4ckE2ZUFxMlBQ?=
 =?utf-8?B?d2VZc1BKazJSaFhkZVFPT2JMY0JFMEROWWJQd0hMN0JrOW9CdUNNdXkyVk5I?=
 =?utf-8?B?eUd5d0FWM1U5eEdtTXZWRGFVZWFHNkQxemlEeTNhbWhvRTlVNS8yZllLY3BU?=
 =?utf-8?B?U1oyWWtPU3cwRTVEaUxBUkZzRGtpZDA0SDB1eGJsRjhhTS9qenBYMC9NQkRi?=
 =?utf-8?B?NWxub0VCNnpZZU1iSC9IUnh2eStZRG1sR1I2LzFWRFhqQmk0VHlMQ21oQVNr?=
 =?utf-8?B?dkd1UXpMLzE5RmlEU0szb3pLeFRrNkpXcFg5NXdrWjZ1M0dxbjhRWEhtR2c3?=
 =?utf-8?B?d1NTUzZsVjQ1eEdDQTJ2TVZJS1lpbzI0MHlkQlorZnQ1TDl3ZmxtU2pUMkJh?=
 =?utf-8?B?VGRhaDRNNmJUd1RnbUxXbEYrMFIveFJUWG11dklwMnRsY2JOc2pOYm51N1Rw?=
 =?utf-8?B?SFc2eEllKytmaVQwQnhVUzd0SU95TE9PNXFlSVNMSDhWUDNDTE1UZFhyOG1U?=
 =?utf-8?B?MFU0UDlNVy9YM3hUeWlvbUVwK0UrUS9Sejh5N1VaTmlIZ0dhcDNXVzhwYWEv?=
 =?utf-8?B?WkdRU3BIcXN2Z29XZ1B2SmZtWTZ6SWlydW5vZ1oreGxIYkJGaElNck5Sdkt6?=
 =?utf-8?B?ZDhrbHVFeG10dkJnYXhNamF6VTdNaWdmc2I2UEh5RTBPdmxIN2RnWXp0bTE0?=
 =?utf-8?B?UVJqWjViKzFWWXhYc2JveUUzTmd3cE9YVTdxRTlRb0dneDhzZHpCMFZYK3Qz?=
 =?utf-8?B?MlhFMW12d3VOSDkwS3ZkNUtqYkVJTGlrRUV0S2ZJdjhxcTYybkNGL0tvcmJl?=
 =?utf-8?B?cGExc3RVdmhEZzVSMEsvazBpU3V5bzA3K0dUTXVBTXVRRk13Q2lGRzVwNGhF?=
 =?utf-8?B?alV2cFN4MXFsNTZvajZBcjVTSFR3c2ZrMGR0cXljNm5XTE9zSXh0V0MrekJ3?=
 =?utf-8?B?aTlocWxYRDlsVDlLa2IyVzk5cE9menVtK1NuMDgrRVFEeGxDSWhCcTN4d21Q?=
 =?utf-8?B?OTkvczBXcmRFUGZBQ2tEcHVxUys3TkZBenJ3dmlkeDdCZk5Td3hkZC9KWG0x?=
 =?utf-8?B?WE5VckhJZCtrSHV3dU9YUS9KdlJpTDlhcEZmOVR4SkNZM2pZSlBPN08zdHBJ?=
 =?utf-8?B?MW12eW11eXhuWE5zTERQYzBzV05GRjZ6QTluaDRYK3hXR0xSTkVETEFNenZR?=
 =?utf-8?B?bi9SeTZlWkJDSGsrYndVVitUa1V3YkM3d1RXRHdXUjdTOFQ2eEVjWnN5Z0FR?=
 =?utf-8?B?ZitoRUVTbFFhaGo4TndrRGFSMXFDRGx0ckswUVduamtMT3RkNnlXYmd0dW5i?=
 =?utf-8?B?T1dJUGtzRlJjZGprTlR2NW5QVGI0dllhQUFpQTZwdzltNmx3K01JSHR5NDd5?=
 =?utf-8?B?RmFHU2I3OWgxdHprd0NweHVGU0VVQ1JzSk94YS9CZzFnY3FscUJjMU9VZnha?=
 =?utf-8?B?cm5qaGVnRjBSeTRma2hkZWxBRmgwK2pjZ3R6enFqVUlJNHQ1R09sSDh5d1V6?=
 =?utf-8?B?elZQOC8yRHNyQ0c3SXoxeDdDRXlLelBwZ0hYK0dhQ3BvQ0s5czF2KzlFWTFu?=
 =?utf-8?B?TzFBYmI2Z2xzWDdGUnF2azdDdGUwNnllT1ErbTg0czAyaStiN1lsWlBFRktP?=
 =?utf-8?B?Uy85RkpiNVBXRDJDTXhtK3lCT2xsNC9lN3ZnM05MQk5yMSt6Nkp3SURQZHJw?=
 =?utf-8?B?Wk85MTdrZ3k2L01uaHIycFY0Q2J5OTFnMElLL3QxVWpOK2hyZytUV3BNR21D?=
 =?utf-8?Q?YJmOelWZ+kdrWVsJgBHWM4Sq2BXNrFi+gtAAU=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?b1JXclY3OVdyZ3RzT2k3aVN3cWZhM2g4NlNYa1ZZYXpCT0dWdGU5QVFCTDJR?=
 =?utf-8?B?VCtrcjlITk9STndEaHo3MTV4VTBFU0swUDlpb1ZJMzlZdEFEczUzeUx5MnUw?=
 =?utf-8?B?NVV0Smx1TWIrRFZHVmZ5ZmRtb3hsVU1JY0hCRXhCSVVJNDY3Y2VQeDllRWFs?=
 =?utf-8?B?bjdXQ1N0Z05TNVR3aFdFdWRRRE1OblpkcGF1ZGE1elRWWnpscW84cWprd2pK?=
 =?utf-8?B?K3lvM3JlZXpXcGtZTjdCMW9JZGY0WjVLUlFkVytMRjZZUVhFM0huTnpydU8v?=
 =?utf-8?B?NkdRWGxPK1lDMDBCV3ZDYzJSbE1TQ3RVQms0UlpRZ1ZLZkh3b0RVSE5hajIx?=
 =?utf-8?B?OWQ0M0dVSENLZXpvL3U3NVRvbnRJdlpmWktCNFlyQzl2TjI4MWtIMlJmZy9O?=
 =?utf-8?B?RzZsS3R6dUV6UUpJQkhrVSsvWEw2d0pNSXVzM1IyYTNLemVnSUVYTHBwUy82?=
 =?utf-8?B?UVJ4SHVpMStkNW5iY0s4akZWaXJqOHAzaHJoMVRsZisvUXJ4N1RlZUU2TDJs?=
 =?utf-8?B?YnlzOE9BTDNDa1VtbC8wV0dhZjhCVUg4a251ZEZXQkFKbnFEMVptOTRuM3Er?=
 =?utf-8?B?V1pBbytZdUF2eEpiWU9saWNmMG4ycjg3ZE4xbHhhcW53Um9vWnV5dzhYRko1?=
 =?utf-8?B?Z3RtYk84Z0IwOXNqR1JZUWFKTDBkUDdJN2FzNTJzZDJnb0FKQ1cyaEpiTWMx?=
 =?utf-8?B?bWtqaWVyMCtpcWl5RkdWdFBkK3YxQ1hoOTJqalo4dzk0V0huaWYvWGR1R1Ez?=
 =?utf-8?B?NkdWZ0hxbUJrdnVTLzZZWk1LYWg3dWdmbHRyc2gvTHU4dDVZSXdjVWhxQWpB?=
 =?utf-8?B?eSszUjdhVEVNeDY4cHV6ZVkyYlllN3FOVE9LVzNKUGcwQUhKbkREODBnak9v?=
 =?utf-8?B?bDM3eHU1RHZxdWdhZ3BTeE02Z2FoaWFDd1RDb1ZEMU9vRVlFMXoxMHNoaUZJ?=
 =?utf-8?B?SFU0WldOLzN4OHNKTEdKUkdXd2VXeXhHTzU2MkJqUHdNWm1wODB3MXdSanBV?=
 =?utf-8?B?SlBjL0YxSEZCS2d5RmpIbm5OTDJDL29mSTNtOTF4WnB5Y1JRTkVDdWV0S01V?=
 =?utf-8?B?YThRSDc2NHZaekpvSmRVQ1hTWVQyUmdXRWdsVWFPMmVMc0U0eEZOLzZFSXN2?=
 =?utf-8?B?RmEybE1pRGRCV3dvbm0wNG5ES2dNQi9hUmZEWWtyYTFMUkhtZTdTY01zd2JG?=
 =?utf-8?B?czNJR1JHTjd2N28wNmhNNng5elhHNmlKWDdHeFNYY1pyUTFEYk55ZFMyZzdY?=
 =?utf-8?B?Y0FXRGo5c1lhVGdxYmdXZVNwZ2FTbUZuL0dTdmUrS2J6cURXODY5WEVXZ0t0?=
 =?utf-8?B?eDBnak9QTDNxWEtDYmxYeWE2L0IyNnFxOGNLV0hOTERseVFuS29TSExFc2Ix?=
 =?utf-8?B?WWxldDZ4VmpKbHFxT3pUdldjb29Ga1NoMkY4dG8wblpORjlCazNUS3NUSG9H?=
 =?utf-8?B?TktVb0J3SnZvWTM0UTM5NG5RMEJWckJzVXVlRklObHUxZ05mRnFpTDU3WDhZ?=
 =?utf-8?B?SnF4MVozd0RZby9pMGRONVNOZEE4NUtIMGFUR0lsaVBWMXBGYXRHV3dvRG8y?=
 =?utf-8?B?YjZTYjg3YTh1a0J3akptbldXWE9DcE96YWIwak5kS2lJL1ZOREJFRkZNb1lZ?=
 =?utf-8?B?R1BBNFUyVzNmTmNPSkhsZmhQcmhKczY2QUc1YVJtQkRPUUNDK1N4dWJTekpO?=
 =?utf-8?B?cHpjSmxWVG5uZThrck9QVFhVbXlheEkzZE5FdUZaKzdVanhUdit1QUsvRGxF?=
 =?utf-8?B?WVhZRFNoc0dvek8wZW1ERWprb3luVDRsUE1LdlcxU2sxdnVMajE5UVdtaFRS?=
 =?utf-8?B?TFlwWVdLWHA2MWFWajdMZnd0aEJzZ29PNmZTeGpqWmxZMmdjaXg1R1FseHpa?=
 =?utf-8?B?Q0RrNDB5cVFRbGM3RTRBRXhWUnE0MHhIVVNWQjhXc0w3emVpblVKSnV6WkY0?=
 =?utf-8?B?N081b3ZyQ2NnSVBEZjc1cERwbkJXY2VSeTNvS0oxc1dpVnNZOS9ZR3p4RVdX?=
 =?utf-8?B?VEszT09mdmFBZWFZamZqYWlEbnNWTHZtNmk4TEZEK1hGSU5rV1g0eG5vKzU2?=
 =?utf-8?B?cXRyVlNrSVZJQ1ppTjVOMU1Yc0Y0cEt0QlBDbVdKMExuUE5zVEV1dHJiL0FR?=
 =?utf-8?B?MDRCZDdQVUNrT1FzRllwWFB4b0FCaTZUTTlHVnR0alNsZkNCM1Z6a2pRa3VM?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3304FE6151D19F42828EF7E637197E68@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qh16rlAmBgvo8RNTfdO+tYKN0MYnLKkv0rr/AGdiI8ETI0Mmtm3mABCWQlp2uamtwD/g3c0KTeLX5vaj/dfqXg75kmDCg0AfHm1OXENygJosyo/d4TkgdscmvqsKbh2kOHR8alXXLwFK6I2pU+qMbZwDAsIM4NbMkQ8F+gGrQFDoy2QC6x7WzGLcHud81mJC+pTvUlJpfK27EyIJhKO4n6K6b5a9q/zLZF9eOOG00/3YnblUQS8/44ra2IDQNijO1seQSyf1X1v4KQ+XcTRbG9c/AM7iH6Xh72867ztoUaSUVNr/iFYXFmoKmKvlwXpRBTGgGLYX2Num5TXp7xCdSm1D3c+mlOE1Dghn/D3TK+N2y84Fk6nq7hfVu/FeyIcSAWnJSl0cHo3ORTohtBqF9TBLf253/rpjKWZfefgtPx/cDnTaSRv4jI6zZWLK0+q6tmkz+cYK3A64ulhfy1NaH5Ft0AqKAiDeKzbcNMvKIuCU7IkhMSxsdkETiB7eaaRCOb8iuX/G0L3E3GagdVUfOjHI8DWfBFnyu77YtL+m8/bw1WhnqlgvQ50bBu/NmuUsvAVV2QRcKgvrjA2dDE7VuB+lNrnsdTKTm0DVI4rG+ms=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9513d9-6c35-4124-e31b-08dc9ad2fb96
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 20:10:13.4015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVCas5yNSGoWYZlRdR1ygEMIq7gfctf7HJCEv87epStjw4G/mytSeGvRGggc11NKpFd6nT4ecvmMU93MGXeRcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5569
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_15,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407020148
X-Proofpoint-GUID: voeNaarKSpbK0aB53kGxq-RZ_j0kWhkK
X-Proofpoint-ORIG-GUID: voeNaarKSpbK0aB53kGxq-RZ_j0kWhkK

DQoNCj4gT24gSnVsIDIsIDIwMjQsIGF0IDI6MzLigK9QTSwgTWlrZSBTbml0emVyIDxzbml0emVy
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBKdWwgMDIsIDIwMjQgYXQgMDY6MDY6
MDlQTSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4gDQo+PiANCj4+PiBPbiBKdWwg
MiwgMjAyNCwgYXQgMTI6MjjigK9QTSwgTWlrZSBTbml0emVyIDxzbml0emVyQGtlcm5lbC5vcmc+
IHdyb3RlOg0KPj4+IA0KPj4+IEhpLA0KPj4+IA0KPj4+IFRoZXJlIHNlZW1zIHRvIGJlIGNvbnNl
bnN1cyB0aGF0IHRoZXNlIGNoYW5nZXMgd29ydGh3aGlsZSBhbmQNCj4+PiBleHRlbnNpdmVseSBp
dGVyYXRlZCBvbi4NCj4+IA0KPj4gSSBkb24ndCBzZWUgYSBwdWJsaWMgY29uc2Vuc3VzIGFib3V0
ICJleHRlbnNpdmVseSBpdGVyYXRlZA0KPj4gb24iLiBUaGUgZm9sa3MgeW91IHRhbGsgdG8gcHJp
dmF0ZWx5IG1pZ2h0IGJlbGlldmUgdGhhdCwNCj4+IHRob3VnaC4NCj4+IA0KPj4gDQo+Pj4gSSdk
IHZlcnkgbXVjaCBsaWtlIHRoZXNlIGNoYW5nZXMgdG8gbGFuZCB1cHN0cmVhbSBhcy1pcyAodW5s
ZXNzIHJldmlldw0KPj4+IHRlYXNlcyBvdXQgc29tZSBzaG93LXN0b3BwZXIpLiAgVGhlc2UgY2hh
bmdlcyBoYXZlIGJlZW4gdGVzdGVkIGZhaXJseQ0KPj4+IGV4dGVuc2l2ZWx5ICh2aWEgeGZzdGVz
dHMpIGF0IHRoaXMgcG9pbnQuDQo+Pj4gDQo+Pj4gQ2FuIHdlIG5vdyBwbGVhc2UgcHJvdmlkZSBm
b3JtYWwgcmV2aWV3IHRhZ3MgYW5kIG1lcmdlIHRoZXNlIGNoYW5nZXMNCj4+PiB0aHJvdWdoIHRo
ZSBORlMgY2xpZW50IHRyZWUgZm9yIDYuMTE/DQo+PiANCj4+IENvbnRyaWJ1dG9ycyBkb24ndCBn
ZXQgdG8gZGV0ZXJtaW5lIHRoZSBrZXJuZWwgcmVsZWFzZSB3aGVyZQ0KPj4gdGhlaXIgY29kZSBs
YW5kczsgbWFpbnRhaW5lcnMgbWFrZSB0aGF0IGRlY2lzaW9uLiBZb3UndmUgc3RhdGVkDQo+PiB5
b3VyIHByZWZlcmVuY2UsIGFuZCB3ZSBhcmUgdHJ5aW5nIHRvIGFjY29tbW9kYXRlLiBCdXQgZnJh
bmtseSwNCj4+IHRoZSAoc2VydmVyKSBjaGFuZ2VzIGRvbid0IHN0YW5kIHVwIHRvIGNsb3NlIGlu
c3BlY3Rpb24geWV0Lg0KPj4gDQo+PiBPbmUgb2YgdGhlIGNsaWVudCBtYWludGFpbmVycyBoYXMg
aGFkIHllYXJzIHRvIGxpdmUgd2l0aCB0aGlzDQo+PiB3b3JrLiBCdXQgdGhlIHNlcnZlciBtYWlu
dGFpbmVycyBoYWQgdGhlaXIgZmlyc3QgbG9vayBhdCB0aGlzDQo+PiBqdXN0IGEgZmV3IHdlZWtz
IGFnbywgYW5kIHRoaXMgaXMgbm90IHRoZSBvbmx5IHRoaW5nIGFueSBvZiB1cw0KPj4gaGF2ZSBv
biBvdXIgcGxhdGVzIGF0IHRoZSBtb21lbnQuIFNvIHlvdSBuZWVkIHRvIGJlIHBhdGllbnQuDQo+
PiANCj4+IA0KPj4+IEZZSToNCj4+PiAtIEkgZG8gbm90IGludGVuZCB0byByZWJhc2UgdGhpcyBz
ZXJpZXMgb250b3Agb2YgTmVpbEJyb3duJ3MgcGFydGlhbA0KPj4+IGV4cGxvcmF0aW9uIG9mIHNp
bXBsaWZ5aW5nIGF3YXkgdGhlIG5lZWQgZm9yIGEgImZha2UiIHN2Y19ycXN0DQo+Pj4gKG5vYmxl
IGdvYWxzIGFuZCBoYXBweSB0byBoZWxwIHRob3NlIGNoYW5nZXMgbGFuZCB1cHN0cmVhbSBhcyBh
bg0KPj4+IGluY3JlbWVudGFsIGltcHJvdmVtZW50KToNCj4+PiBodHRwczovL21hcmMuaW5mby8/
bD1saW51eC1uZnMmbT0xNzE5ODAyNjk1Mjk5NjUmdz0yDQo+PiANCj4+IFNvcnJ5LCByZWJhc2lu
ZyBpcyBnb2luZyB0byBiZSBhIHJlcXVpcmVtZW50Lg0KPiANCj4gV2hhdD8gIFlvdSdyZSBpbXBv
c2luZyBhIHJlYmFzZSBvbiBjb21wbGV0ZWx5IHVuZmluaXNoZWQgYW5kIHVudGVzdGVkDQo+IGNv
ZGU/ICBBbnkgaWRlYSB3aGVuIE5laWwgd2lsbCBwb3N0IHYyPyAgT3IgYW0gSSBzdXBwb3NlZCB0
byB0YWtlIGhpcw0KPiBwYXJ0aWFsIGZpcnN0IHBhc3MgYW5kIGZpeCBpdD8NCg0KRG9uJ3QgYmUg
cmlkaWN1bG91cy4gV2FpdCBmb3IgTmVpbCB0byBwb3N0IGEgd29ya2luZyB2ZXJzaW9uLg0KDQoN
Cj4+IEFnYWluLCBhcyB3aXRoIHRoZSBkcHJpbnRrIHN0dWZmLCB0aGlzIGlzIGNvZGUgdGhhdCB3
b3VsZCBnZXQNCj4+IHJldmVydGVkIG9yIHJlcGxhY2VkIGFzIHNvb24gYXMgd2UgbWVyZ2UuIFdl
IGRvbid0IGtub3dpbmdseQ0KPj4gbWVyZ2UgdGhhdCBraW5kIG9mIGNvZGU7IHdlIGZpeCBpdCBm
aXJzdC4NCj4gDQo+IE5pY2UgcnVsZSwgZXhjZXB0IHRoZXJlIGlzIG1lcml0IGluIHRlc3RlZCBj
b2RlIGxhbmRpbmcgd2l0aG91dCBpdA0KPiBoYXZpbmcgdG8gc2VlIGxhc3QgbWludXRlIGFjYWRl
bWljIGNoYW5nZXMuICBUaGVzZSBhcmVuJ3QgZHByaW50aywNCj4gdGhlc2UgYXJlIGRpc3J1cHRp
dmUgY2hhbmdlcyB0aGF0IGFyZW4ndCBmdWxseSBmb3JtZWQuICBJZiB0aGV5IHdlcmUNCj4gZnVs
bHkgZm9ybWVkIEkgd291bGRuJ3QgYmUgcmVzaXN0aW5nIHRoZW0uDQoNCkl0J3MgeW91ciBzZXJ2
ZXIgcGF0Y2ggdGhhdCBpc24ndCBmdWxseSBmb3JtZWQuIEFsbG9jYXRpbmcNCmEgZmFrZSBzdmNf
cnFzdCBvdXRzaWRlIG9mIGFuIHN2YyB0aHJlYWQgY29udGV4dCBhbmQgYWRkaW5nDQphIHdvcmst
YXJvdW5kIHRvIGF2b2lkIHRoZSBjYWNoZSBsb29rdXAgZGVmZXJyYWwgaXMgbm90aGluZw0KYnV0
IGEgaGFja3kgc21lbGx5IHByb3RvdHlwZS4gSXQncyBub3QgbWVyZ2UtcmVhZHkgb3IgLXdvcnRo
eS4NCg0KDQo+IElmIE5laWwgY29tcGxldGVzIGhpcyB3b3JrIEknbGwgcmViYXNlLiAgQnV0IGxh
c3QgdGltZSBJIHJlYmFzZWQgdG8NCj4gaGlzIHNpbXBsaWZpY2F0aW9uIG9mIHRoZSBsb2NhbGlv
IHByb3RvY29sICh0byB1c2UgYXJyYXkgYW5kIG5vdA0KPiBsaXN0cywgbmljZSBjaGFuZ2VzLCBh
cHByZWNpYXRlZCBidXQgaXQgdG9vayBzZXJpb3VzIHdvcmsgb24gbXkgcGFydA0KPiB0byBmb2xk
IHRoZW0gaW4pOiB0aGUgY29kZSBpbW1lZGlhdGVseSBCVUdfT04oKSdkIGluIHN1bnJwYyB0cml2
aWFsbHkuDQoNCllvdSBzaG91bGQgYmUgdmVyeSBncmF0ZWZ1bCB0aGF0IE5laWwgaXMgd3JpdGlu
ZyB5b3VyIGNvZGUNCmZvciB5b3UuIEhlJ3MgYWxyZWFkeSBjb250cmlidXRlZCBtdWNoIG1vcmUg
dGhhbiB5b3UgaGF2ZQ0KYW55IHJlYXNvbiB0byBleHBlY3QgZnJvbSBzb21lb25lIHdobyBpcyBu
b3QgZW1wbG95ZWQgYnkNCkhhbW1lcnNwYWNlLg0KDQpBbmQgcXVpdGUgZnJhbmtseSwgaXQgaXMg
bm90IHJlYXNvbmFibGUgdG8gZXhwZWN0IGFueW9uZSdzDQpmcmVzaGx5IHdyaXR0ZW4gY29kZSB0
byBiZSBjb21wbGV0ZWx5IGZyZWUgb2YgYnVncy4gSSdtDQpzb3JyeSBpdCB0b29rIHlvdSBhIGxp
dHRsZSB3aGlsZSB0byBmaW5kIHRoZSBwcm9ibGVtLCBidXQNCml0IHdpbGwgYmVjb21lIGVhc2ll
ciB3aGVuIHlvdSBiZWNvbWUgbW9yZSBmYW1pbGlhciB3aXRoDQp0aGUgY29kZSBiYXNlLg0KDQoN
Cj4gU28gcGxlYXNlIGJlIGNvbnNpZGVyYXRlIG9mIG15IHRpbWUgYW5kIHRoZSByZXF1aXJlbWVu
dCBmb3IgY29kZSB0bw0KPiBhY3R1YWxseSB3b3JrLg0KDQpJJ2xsIGJlIGNvbnNpZGVyYXRlIHdo
ZW4geW91IGFyZSBjb25zaWRlcmF0ZSBvZiBvdXIgdGltZSBhbmQNCnN0b3AgcGF0Y2ggYm9tYmlu
ZyB0aGUgbGlzdCB3aXRoIHRpbnkgaW5jcmVtZW50YWwgY2hhbmdlcywNCmRlbWFuZGluZyB3ZSAi
Z2V0IHRoZSByZXZpZXcgZG9uZSBhbmQgbWVyZ2UgaXQiIGJlZm9yZSBpdA0KaXMgcmVhZHkuDQoN
CkhvbmVzdGx5LCB0aGUgd29yayBpcyBwcm9jZWVkaW5nIHF1aXRlIHVucmVtYXJrYWJseSBmb3Ig
YQ0KbmV3IGZlYXR1cmUuIFRoZSBwcm9ibGVtIHNlZW1zIHRvIGJlIHRoYXQgeW91IGRvbid0DQp1
bmRlcnN0YW5kIHdoeSB3ZSdyZSBhc2tpbmcgZm9yIChhY3R1YWxseSBxdWl0ZSBzbWFsbCkNCmNo
YW5nZXMgYmVmb3JlIG1lcmdpbmcsIGFuZCB3ZSdyZSBhc2tpbmcgeW91IHRvIGRvIHRoYXQNCndv
cmsuIFdoeSBhcmUgd2UgYXNraW5nIHlvdSB0byBkbyBpdD8NCg0KSXQncyBiZWNhdXNlIHlvdSBh
cmUgYXNraW5nIGZvciAvb3VyLyB0aW1lLiBCdXQgd2UgZG9uJ3QNCndvcmsgZm9yIEhhbW1lcnNw
YWNlIGFuZCBkbyBub3QgaGF2ZSBhbnkgcGFydGljdWxhciBpbnRlcmVzdA0KaW4gbG9jYWxJTyBh
bmQgaGF2ZSBubyByZWFsIHdheSB0byB0ZXN0IHRoZSBmYWNpbGl0eSB5ZXQNCihubywgcnVubmlu
ZyBmc3Rlc3RzIGRvZXMgbm90IGNvdW50IGFzIGEgZnVsbCB0ZXN0KS4NCg0KSXQncyB5b3VyIHJl
c3BvbnNpYmlsaXR5IHRvIGdldCB0aGlzIGNvZGUgcHV0IHRvZ2V0aGVyLA0KaXQncyBnb3QgdG8g
YmUgeW91ciB0aW1lIGFuZCBlZmZvcnQuIFlvdSBhcmUgZ2V0dGluZyBwYWlkDQp0byBkZWFsIHdp
dGggdGhpcy4gTm9uZSBvZiB0aGUgcmVzdCBvZiB1cyBhcmUuIE5vLW9uZSBlbHNlDQppcyBhc2tp
bmcgZm9yIHRoaXMgZmVhdHVyZS4NCg0KDQo+Pj4gLSBJbiBhZGRpdGlvbiwgdHdlYWtzIHRvIHVz
ZSBuZnNkX2ZpbGVfYWNxdWlyZV9nYygpIGluc3RlYWQgb2YNCj4+PiBuZnNkX2ZpbGVfYWNxdWly
ZSgpIGFyZW4ndCBhIHByaW9yaXR5Lg0KPj4gDQo+PiBUaGUgZGlzY3Vzc2lvbiBoYXMgbW92ZWQg
d2VsbCBiZXlvbmQgdGhhdCBub3cuLi4gSUlVQyB0aGUNCj4+IHByZWZlcnJlZCBhcHByb2FjaCBt
aWdodCBiZSB0byBob2xkIHRoZSBmaWxlIG9wZW4gdW50aWwgdGhlDQo+PiBsb2NhbCBhcHAgaXMg
ZG9uZSB3aXRoIGl0LiBIb3dldmVyLCBJJ20gc3RpbGwgbm90IGNvbnZpbmNlZA0KPj4gdGhlcmUn
cyBhIGJlbmVmaXQgdG8gdXNpbmcgdGhlIE5GU0QgZmlsZSBjYWNoZSB2cy4gYSBwbGFpbg0KPj4g
ZGVudHJ5X29wZW4oKS4NCj4gDQo+IFNhdmluZyBhbiBuZnNfZmlsZSB0byBvcGVuX2NvbnRleHQs
IGV0Yy4gIEFsbCBpbmNyZW1lbnRhbCBpbXByb3ZlbWVudA0KPiAodGhhdCBuZWVkcyB0aW1lIHRv
IHN0aWNrIHRoZSBsYW5kaW5nKS4NCg0KWW91IGFyZSBzdGlsbCBtaXNzaW5nIHRoZSBwb2ludC4g
VGhlIHBob255IHN2Y19ycXN0IGlzIGJlaW5nDQpwYXNzZWQgaW50byBuZnNkX2ZpbGVfYWNxdWly
ZSgpLiBFaXRoZXIgd2UgaGF2ZSB0byBmaXgNCm5mc2RfZmlsZV9hY3F1aXJlIChhcyBOZWlsIGRp
ZCkgb3IgcmVwbGFjZSBpdCdzIHVzZSB3aXRoDQpmaF92ZXJpZnkoKSAvIGRlbnRyeV9vcGVuKCku
DQoNClRoaXMgaXMgbm90IGFib3V0IGdhcmJhZ2UgY29sbGVjdGlvbiwgYW5kIGhhc24ndCBiZWVu
IGZvcg0KYSB3aGlsZS4gSXQncyBhYm91dCByZXBsYWNpbmcgdW5tZXJnYWJsZSBwcm90b3R5cGUg
Y29kZS4NCg0KQW5kIHN0aWNraW5nIHRoZSBsYW5kaW5nPyBJZiBhIGZldyBnb29kIGZzdGVzdHMg
cmVzdWx0cw0KYXJlIHN1cHBvc2VkIHRvIGJlIGdvb2QgZW5vdWdoIGZvciB1cyB0byBtZXJnZSB5
b3VyIGNvZGUNCmFzIGl0IGV4aXN0cyBub3csIHdoeSBhcmVuJ3QgdGhleSBnb29kIGVub3VnaCB0
byB2ZXJpZnkNCnlvdXIgY29kZSBpcyBPSyB0byBtZXJnZSBhZnRlciBhIHJlYmFzZT8NCg0KDQot
LQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

