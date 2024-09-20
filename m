Return-Path: <linux-nfs+bounces-6576-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083CD97D994
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 20:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2521D1C21907
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 18:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D877518EB0;
	Fri, 20 Sep 2024 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SGXfxdZr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JcPOUz5B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F024F13D8A4
	for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2024 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726856311; cv=fail; b=qNBAL6I+yWi7ccKwF5PEKwxn9v5lLrEOjTe23U7nKyXpyxV3Wg2L+r+prQClxnViuYo0UlqJsqIKK6kIocSHf3urTaRUzSeH11veks+hcTCl5nqZZoCuvy9KCZGNaADuzTQHzjdK4YXX8PBFGrzxNSUOK7jApkrcpMoxkBvKYOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726856311; c=relaxed/simple;
	bh=i2A5ycYY2C4ryEU1VEcKoVGeY6oyTWirDde984NqIdg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C6Wd50lkAMeeCrwHZjuUE0Z5lIFDjVXWayIQpWRPogL502P3+/41qkPiTXW9x6pBsvFnyTeIXHJqHx4/5WwkWS8W/5++kaPtJSrk9zn6cMgBHPMSfAMTzxu3dirsrAJqhcaiF0ElYYC2Tu3lMf34eT3AP2ZHtZRjtk8kopAcErM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SGXfxdZr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JcPOUz5B; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48KGfx3X019317;
	Fri, 20 Sep 2024 18:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=i2A5ycYY2C4ryEU1VEcKoVGeY6oyTWirDde984NqI
	dg=; b=SGXfxdZrYzOLrF1ohU6VdphNV8RjwPbnxrAIQ7CimGdtdbr6RYH9NFW/z
	raM2yZvLUyAk4NF0vZxZ72fyjcyCU1zQMNwdeqHtsOrMJAEhP5oPkQ1zlnrjoz9i
	HsJFT05x7JF2GVbc6OMwuvy/QJz1oVsgV8MHE9wRjs+/9ZMbEsIpi2ziL37tJv03
	43xoYWXkxPJEXd0lrpZ04BOwcHONbUwTjV1ytJbJK75oNVXUuOSYt2GoVONxq4GQ
	/KxYvoobhsK/dTBJpDOm6YIEDK987/g3jy4nRlmbLe2BL28w1ZJrBEdv8vd6FOgq
	zI8sMbzWzVxXwayHDNWXtSpIkf5Dw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3sfydbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 18:18:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48KIGMwk017894;
	Fri, 20 Sep 2024 18:18:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nyd25nrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 18:18:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omSxEraKyrMs1A5ZFNAub5d+QU010Emz9ERA38BtfUaw0CfkoExw5/t8WPfihYoeeyJd228ZbI6OWPyQbPYGcuZyH4kSocP7M77NwkJBUffUsY0h7Cp3cOJW3KrBGUC+zpbkVFkOpIxQqux1WV4H40N4vmpZqK+I2M8RExGLcdIlCCAFVdf5Tabdj0roxpNZ0QiRscQo6GAlCMZKcvfVBQV1rPNAwVFbGADkwzJf0OntWwBh2tKbH/SopoAv5ml8Y4hZO0BTW/d9W3OfhAc8ZtD3w7YWlU5TBKGZVRB21IoUdA/RXpI8epqoFHHc/JxQ3c3soLDzIWNrCg3XtwP/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2A5ycYY2C4ryEU1VEcKoVGeY6oyTWirDde984NqIdg=;
 b=OYtpd7ho53cZr6DIscUPf5yLXD2+3PdOFwNjFgnO/KUi1ThsM53smr2ahTYGmYANP9eU58tczKxwNt+Cn3Pz1Nl9HRUWkbnxP539K81ywX8cde3+Rrotjh9gn5Dy/fHeJsNLT/PHY6/huj+2UR0V1QGQ1LpzvMXOqPD6AzucLXgGwv+33y/gBxO6rn4HlxNhiyYqqrQ1EmAc3CujTeauWelnZ8hImv25jvedmHdtZn49fyifCFSx9N5Mpd7Px9RF35HKBSgxtu18wsQmwwpz3Zbdm433ZKPRfa4Bats6RoZbRkKmDsGv5Pfd3Izo/O5bs3Drz8rGK7OcQnMJFcPnKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2A5ycYY2C4ryEU1VEcKoVGeY6oyTWirDde984NqIdg=;
 b=JcPOUz5BYGfZMCn1e5yVchTBB3YXxrOczqtVk/fQv3el1rBaSFFo5EBp7Qhldw13S5sD9mI9s4m6395deDPz23tLHYaZja1LlRFo0UjkOFR1XCAEXiMjnsPzXX67teigIus3YNe/X+pzzOrnKtO2dW+JZHivCVXLrFUs58vTHyg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6813.namprd10.prod.outlook.com (2603:10b6:8:10b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Fri, 20 Sep
 2024 18:18:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8005.010; Fri, 20 Sep 2024
 18:18:10 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Olga Kornievskaia <okorniev@redhat.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfsd: fix handling of WANT_DELEG_TIMESTAMPS on open
Thread-Topic: [PATCH 1/1] nfsd: fix handling of WANT_DELEG_TIMESTAMPS on open
Thread-Index: AQHbC3cD2MFUE3Eu80a1Wg7izEAaprJg3EEAgAABrQCAAAD+gIAAHP8A
Date: Fri, 20 Sep 2024 18:18:10 +0000
Message-ID: <2B9EA862-208A-4327-AFE5-4C24B3C6C56F@oracle.com>
References: <20240920160551.52759-1-okorniev@redhat.com>
 <995712d148b21cd238c9604c58f42fe7a4b1581a.camel@kernel.org>
 <FA97862C-82C5-4879-B9AE-F5F5B813150B@oracle.com>
 <1b1135a9a2388df5aa9eabe85b85a8a624b87fe6.camel@kernel.org>
In-Reply-To: <1b1135a9a2388df5aa9eabe85b85a8a624b87fe6.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6813:EE_
x-ms-office365-filtering-correlation-id: 361fa55b-616e-4648-30c9-08dcd9a095a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bkprYkx1WTAwWHNOdytUSXVERzVDOURKNGNqK0VqWnY0TXJScEd6di9ibitE?=
 =?utf-8?B?d0V0UURhUnExeDI2K21hQXN2RkhXR2JuV2JXbEZZMVpqMUFETVFCaWZwUUV5?=
 =?utf-8?B?TnlKOE5VN1Z2akNUTGlRdXJDZDdaaGJ6Skx2QVN6NVdzWVVJVHhLVDFZQUZk?=
 =?utf-8?B?TEZsOEF2TlRERmJpNXBqd0dJMDBaUU9pY21UTHdRMko0Z29jeTRFeDlCVVRy?=
 =?utf-8?B?bjhseWl5QWZWV1kxblpzSWM4amZhMnQ5ZE9hRGdnVVFNWFJNWW9ZUTMrK0pr?=
 =?utf-8?B?bzhVNEJ4aG5GeEF4Tnh5ZW1iOFY1bUMrV1J3alpLb1hHUXo0NnRwdVVkcDJh?=
 =?utf-8?B?SGtkb2xTY21NY1F2OFV0c1dsZEFjb0VWbzNKOXo1aDBxU1dLRHFLYXJxL1VJ?=
 =?utf-8?B?TThYalczdGJpK01RZGN3TWVHNFJ2c2lYemdaQzgvcmkrY0s5YXI4b1hJZURx?=
 =?utf-8?B?MG5zN2hlWUdCU3MxNk9BMWJnL2kvbjN3U1V3aW9IeUlBUkk3K2pwWnNxaEhL?=
 =?utf-8?B?QUlxdVg4SDljTDVtZVp4REh4V3BOUUw1dUg3SFlCN3ZhWUJ0RVVNTm9SR1FD?=
 =?utf-8?B?Z29nSFZLVjZOQ0YrNWttWW5RcjdsMUUvU3gyUFJpdlZ6bTlza2VWSEMzeFZy?=
 =?utf-8?B?Umxta0FadW5CYWtxRVV2bDYzUU5keFlhNWhtVS9lOVVLTUpvTis5OFVxUHhy?=
 =?utf-8?B?ZnZWMWErdnVCZFljRmwyb1RNSXBmQ3MxSkUvdDE2Znh6Zm96TzNhYS9nV28v?=
 =?utf-8?B?T0FOQlgralVFKzZmUy9aR0U3bi9OZnJNNGpjZzN1T2hoeWVwdWl1bFlyaEFm?=
 =?utf-8?B?eUNBTCt2MERtR3JVVHZGSHZYTm5pcVUyUzdUR1hucThjaTRhUXVsVXhVV3Ft?=
 =?utf-8?B?MDhEZGRjTGRWRkorS3pWbFZBYlhFSnpyQlU2ZmduN21sM0krc0xQNUVPTjlh?=
 =?utf-8?B?eW5GaTdxNXhzYXplUzAxazBIcmZxRUNKZFdyUFlUOWk4QUlHalYrL0RqTEV0?=
 =?utf-8?B?S2hzQkdHMDRjR045MFUwanJVZzNNNDJTVjJBVnZnV1E5WlNVZElkNWhzQ3pa?=
 =?utf-8?B?UldPWks0UGxiQzFmWmdBaXFVcC9ZMUgycjZ2WVU0L3JwaEJlcTlzbzNWVExV?=
 =?utf-8?B?QlpLcnFyNldjeGg5VTlSUHR6U3JITnkwc1JEVm5OT2ZGQUdXaHAxTzlCR242?=
 =?utf-8?B?RzU5dm9TbGcxUElNNjZybDFVY0JROXY2ZVYzV1NRaHMxYnV0ZFJSeVBzUklT?=
 =?utf-8?B?UHRLQ0lzcU1WUFJ2L2dRZGNiVFJ4MDZqaGZxMnVhY3YwaXo4bzB4MGI1V1JT?=
 =?utf-8?B?S1p2RVFZRVhKdTZHYzRseUJoTFBjbE5WYXZxZ0FuSGU5NVR5NTdwcm1pcHNT?=
 =?utf-8?B?dVJydE9WUnZaMVN6VHV3S0RQZ01xZ1AyMkFVZys5Ujh6OU9uODZXbDFycHVO?=
 =?utf-8?B?SWp5Y0JEWXVUZk9TY2xXbDRzeEdjNDdhaFpRRFRQMVQ5dFpybHRKUVlWNWJZ?=
 =?utf-8?B?SkVqc2tSSzczMkNUR1pnSTFSbXhIQ2dwbzUyOWR2bFVCaC9pbmlhNncwWkR4?=
 =?utf-8?B?eGV1bUh1NXdDV01QZVRycGNYNjJ6ZEJSWkc3aTUrUWxWZFFZMlVqSDNzVy9k?=
 =?utf-8?B?bTBwUjhmNm1uQS84a291bitkb1pNRHFNaGZITGYyeVZCQXdFT1N1bGZjSy9D?=
 =?utf-8?B?YlVhWHlKM0lNemViVlNFaFdYM0xTL0dCajdGbURHQzZZTGtIbG51ZWpGTFdG?=
 =?utf-8?B?ZWI1ZGxZVHFnTWJaOXltZmhxV0F1NXZZWE9pSFNtOEZaYWd1RXJPdTczRXQr?=
 =?utf-8?B?QittQUxROUxYbnJJRHd2VUQ0T3BqVVNNVDN6TDF5QTRqeWdzU2V0aDJINWcx?=
 =?utf-8?B?MGxpODh1cFJieThwWWx6b21HOW9ZeHVVWEhPWDFPUmhrTVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1EvUHZUS3JOdUtObng2OEVlaWRRNW5oK0ViemtzcFhyYU5QZEdyZTdoc3Zi?=
 =?utf-8?B?UGVLVWFLSVNvWU4yd01sR2YrWTR3YXJ0WmtHN1dIYmJhZXBHVUsyamV2ZEkw?=
 =?utf-8?B?SEJFMVNLamZYTnBhNHVXcWNUSUEvZEJqUEZSRWVtQzBNUEsrWmNJSmtYeHAv?=
 =?utf-8?B?QnBJYSt5cU5BTWVOVXFNUGNiK1pLc1Z5UjF3MTV0bTlqaEZxaTN5aDhJV3FF?=
 =?utf-8?B?a25ibFdMVFU2R0g1Wmh2MGwyazd4UmJiNHpwZVNRaThKKzVoS0h2dzlybnhQ?=
 =?utf-8?B?aE5zdWJ0RUpvQjdJQ2pSMVVnSUtpanh4ZXF3NjhoaGRLTnhuZTFDVjJRVi9V?=
 =?utf-8?B?WHJMYlF5Z1B1dDNjWDJ5NmJsOFkyS2E0Y0hRZzJaUllLeDg3bkRNSlJ3emRS?=
 =?utf-8?B?RnI5NENrRnhxYkZCTjZuWUtsK2hnUXNYNjZqR3pLZUI2dm1RYnhQa2pab3Zy?=
 =?utf-8?B?Y0wrbnByYVJvWnVKc2dSMWdVT3VFMFJzYnRjTnppY2lEQjBncDBUeC9HRmwz?=
 =?utf-8?B?RGRNY0I4THcvQWpJb2JieENKMWZ0di9KOXNZSFV1aEdkYk5MNFdIOU1yT0VR?=
 =?utf-8?B?b2F5c3p0NTlyTWc2MFl4Q1NVWmpPLzZQSWROZHhteEtzQXlXeU5ZelRhNDAv?=
 =?utf-8?B?UkcxVDQrMG02ZFdtSUtYTHAwODA5UEpMTjBqRytmR3pFWXVqVDNuZjhKbHNi?=
 =?utf-8?B?czV4bnZwUXVTUnArQXZibTNIQnlFRTNxTnpJSGdkUTN5ckhLRGdtRkM2dDJQ?=
 =?utf-8?B?NnhyaHd6VkVqRU1sWFZCZVhPNCtYeWUvWHJQOG1KVVNXcE5iNW5HalBuc09N?=
 =?utf-8?B?ZGZ6Mm9kb0NVRThZdW5Gd1YzOEs4UGs3SFFWQjArSlJuOG5oZDFrVlNPT2ZI?=
 =?utf-8?B?ZDBxcmc1TnRuVE9HTUNrYi9rYlYxMlUwak5scFVTNHlpSmxFaXJzQXJ0TGNI?=
 =?utf-8?B?RUVDWk5FSW4wSUdPVFhZeFliZVdBZEl2d1lVNk5uaEFlRHBVR0hqTjM0akM4?=
 =?utf-8?B?d0RZQ2twaVBJeXVkUXFvRU0rNFFXV0ZQL1VHMUlRN3lFbUdOZEVsa25KT3c3?=
 =?utf-8?B?Y2F3dUtpNDRFRXRCeFFFZDhOWkl5SDNsTHdjZVpMRHZrSFMrNkVnSjBRWVkw?=
 =?utf-8?B?NXJBYVVzSjI1a25HQnZIT2xSK2dNV0w4MkJWRGtPNlg0ZmZQb29CM1ptRG5i?=
 =?utf-8?B?RGJRdU1iUUI1TEVVTk9Rd0R6YjR3ZDdxVS9SakIxUGgwMVFMQWVKRWtNRXBh?=
 =?utf-8?B?aEdiT1FydUNCTC91emRVOHo0TE9mOXRNK3hnaHVraEo1WHdlb0VGQ1NWRWJV?=
 =?utf-8?B?S3dBcjZVVzRwNk5kSlFKOUFzTG8yWUVkeXdrRXZmOElDYVcrRjJ2L2Z1bXlS?=
 =?utf-8?B?cllLaWZBclZpVlVsVVdJZUZJcEhDUEdrYWsxNWFSOWUwLzY2ZnJ3clI4dXJR?=
 =?utf-8?B?VVRBU2JYZjZwUk95WEU3NDk3Tjc5Tk00VmZtZWhrUHlubm5lSUh4L3g2cU5o?=
 =?utf-8?B?aFpGUVhEU251ZzJid3BvWDlVNG55MFVnanlJZWhncUljZWpyUzl0b25RZXVo?=
 =?utf-8?B?NlcvRjN2czdtb1RzelJWd2V3bWVrbDNJZmhWNy9hSkIyQ2VWenZGYyttWW9x?=
 =?utf-8?B?WERZekRkMnhFbTA3c3hhR1ZTU2Zra0FJWDdubkdPWmg4eVJFR0ZEZm9iSVRk?=
 =?utf-8?B?OHJYOS92TFQ2VFNHWDc3dDVZa1dqK1BoaXl2ZFZ5bElvcWswM2gwaGVveUhK?=
 =?utf-8?B?Nm1UeENOcnNYVlpNbktZWXRWb014WmVYWTdVSXRRNGtFTzRRVk1ic1BRK2Vq?=
 =?utf-8?B?UHFPdU5OVkxUeEF3WTlpdzZSVzN1MzlwQXJ4QS8wbml1WDVnTll0WEVrZ2Zt?=
 =?utf-8?B?Y0VmcGZ2K1RDMkV5dWd1TmoyZGFjK244NHJqbzVPKzdzUGRtTUhYSW83aHR0?=
 =?utf-8?B?bjV4eXBIb0g0dHpOMEQzRmdSeS96OTQvVnFjS0hYVHVjTlpqanBreG5id0sr?=
 =?utf-8?B?VjlQVXgrelNndkUrRk5WOE01UmYyS1dUbGk2NUFXWnRNT1hIL1pXM0J3Q3My?=
 =?utf-8?B?NXpOSlYxQyt4eFlwQXU5aUhhaTJmeTR2NVRvWSt5WTU4RWV3TVhmSnNhWm1F?=
 =?utf-8?B?WlZuYUQvcWlOL0xVejZPakxCTGJQY2xtaUVzL2QzN1ZoeHZ0WTFEYkp1aUEx?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6EF91FC65EE6C4FA22F8AFA2C5278DC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lzq6mh70HeYe1TRZJWkkK2i8uE3tyDW/1yKd8eSS0RWmAM0nXuwJ+I5IelQ9ujRE0iqRy7U6xPkBlwMeSFw1b1zMcBi1ovGNDlRkeJM3lIqxSIfhGdsDmXwusHtqih8d9XfW6rIUxjDzUUKmbuv53e/3JpYPQ5XVKwkEP0uFHb5KBYJjBnprHtJmgiiB5mp9PccIdSP7Y6i3mKnldznjcHuryrnhkQqo9IpBdXaS0pkKLvDSvc7Tj8Rt3h1H8Sv3QyyTmvfAi/svG9jt/SBWs42pHTwx37aJy6Sj594fzJ3nGygxD4+KBpAn+baGWOElncT9dyTRt/cBb2Q7JETslydN+AoaeQztSOGVvifHL/NK/VxbviXDYJGVmyBTiDypt0wS8sw8D2sYyLW8wsZqKg0lcu6wNlBiVIMI0U8XwrnSPyiTEnfdxReR38dc4IBVU/3ffDlBTQUIVmv/0egWQ7z6kklahGwODcfILIpa/+KVvVBMuwnOZCVq1ejqWwtdxbpoh9QMqHW23aEmb1vD2k00QdSsRGTJ17nW9iM9m/VvXSOvlYOYHH85ySB349zMa8DIhz7RhYbxWJBhJSpxm5m25x91E94uZaBzwFvzE6c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361fa55b-616e-4648-30c9-08dcd9a095a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 18:18:10.8109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MupSePaCctcvhUUyYBXmGBO4Sn05TxQUWxSA15SgjGtlrGwX2F2/zOnhvHYhKZpT/M0Ad93ETLIr+7+FGW7gug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_08,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409200133
X-Proofpoint-GUID: 5KzqI51NvOBuybfExisoGAaSau4V-exr
X-Proofpoint-ORIG-GUID: 5KzqI51NvOBuybfExisoGAaSau4V-exr

DQoNCj4gT24gU2VwIDIwLCAyMDI0LCBhdCAxMjozNOKAr1BNLCBKZWZmIExheXRvbiA8amxheXRv
bkBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgMjAyNC0wOS0yMCBhdCAxNjozMCAr
MDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4gDQo+Pj4gT24gU2VwIDIwLCAyMDI0LCBh
dCAxMjoyNOKAr1BNLCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4+
PiANCj4+PiBPbiBGcmksIDIwMjQtMDktMjAgYXQgMTI6MDUgLTA0MDAsIE9sZ2EgS29ybmlldnNr
YWlhIHdyb3RlOg0KPj4+PiBDdXJyZW50LCB0aGUgc2VydmVyIHJldHVybnMgdGhhdCBpdCBzdXBw
b3J0cyBORlM0X1NIQVJFX1dBTlRfREVMRUdfVElNRVNUQU1QUw0KPj4+PiBidXQgd2hlbiB0aGUg
Y2xpZW50IHNlbmRzIHRoYXQgb24gdGhlIG9wZW4sIGtuZnNkIHJldHVybnMgYmFjayB3aXRoDQo+
Pj4+IGJhZF94ZHIgZXJyb3IuDQo+Pj4+IA0KPj4+PiBGaXhlczogZDBlYWI3M2Q0OGEwICgibmZz
ZDogYWRkIHN1cHBvcnQgZm9yIGRlbGVnYXRlZCB0aW1lc3RhbXBzIikNCj4+Pj4gU2lnbmVkLW9m
Zi1ieTogT2xnYSBLb3JuaWV2c2thaWEgPG9rb3JuaWV2QHJlZGhhdC5jb20+DQo+Pj4+IC0tLQ0K
Pj4+PiBmcy9uZnNkL25mczR4ZHIuYyB8IDEgKw0KPj4+PiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCj4+Pj4gDQo+Pj4+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mczR4ZHIuYyBiL2Zz
L25mc2QvbmZzNHhkci5jDQo+Pj4+IGluZGV4IGMwYmFkNTgwYWI2ZC4uYWRkYThiNDg5MTc1IDEw
MDY0NA0KPj4+PiAtLS0gYS9mcy9uZnNkL25mczR4ZHIuYw0KPj4+PiArKysgYi9mcy9uZnNkL25m
czR4ZHIuYw0KPj4+PiBAQCAtMTEwOSw2ICsxMTA5LDcgQEAgc3RhdGljIF9fYmUzMiBuZnNkNF9k
ZWNvZGVfc2hhcmVfYWNjZXNzKHN0cnVjdCBuZnNkNF9jb21wb3VuZGFyZ3MgKmFyZ3AsIHUzMiAq
c2gNCj4+Pj4gY2FzZSBORlM0X1NIQVJFX1BVU0hfREVMRUdfV0hFTl9VTkNPTlRFTkRFRDoNCj4+
Pj4gY2FzZSAoTkZTNF9TSEFSRV9TSUdOQUxfREVMRUdfV0hFTl9SRVNSQ19BVkFJTCB8DQo+Pj4+
ICAgICAgTkZTNF9TSEFSRV9QVVNIX0RFTEVHX1dIRU5fVU5DT05URU5ERUQpOg0KPj4+PiArIGNh
c2UgTkZTNF9TSEFSRV9XQU5UX0RFTEVHX1RJTUVTVEFNUFM6DQo+Pj4+IHJldHVybiBuZnNfb2s7
DQo+Pj4+IH0NCj4+Pj4gcmV0dXJuIG5mc2Vycl9iYWRfeGRyOw0KPj4+IA0KPj4+IE91Y2guDQo+
Pj4gDQo+Pj4gVGhlIHByb2JsZW0gaGVyZSBpcyB0aGF0IHdlIGhhZCB0byBkcm9wIHRoZSBwYXRj
aCB0aGF0IGFkZGVkDQo+Pj4gT1BFTl9YT1JfREVMRUdBVElPTiBzdXBwb3J0LiBUaGF0IHBhdGNo
IHJld29ya2VkIHRoZSBmbGFnIGhhbmRsaW5nIGluDQo+Pj4gdGhpcyBmdW5jdGlvbiBpbiBhIHdh
eSB0aGF0IGFsbG93ZWQgdGhlIG5ldyBkZWxzdGlkIGZsYWdzIHRvIGJlDQo+Pj4gcHJvcGVybHkg
c3VwcG9ydGVkLg0KPj4+IA0KPj4+IEkgdGhpbmsgd2UgcHJvYmFibHkgd2FudCB0byByZXN1cnJl
Y3QgdGhlIHBhcnRzIG9mIHRoaXMgcGF0Y2ggdGhhdA0KPj4+IGFsdGVyIG5mc2Q0X2RlY29kZV9z
aGFyZV9hY2Nlc3M6DQo+Pj4gDQo+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbmZz
LzIwMjQwOTA1LWRlbHN0aWQtdjQtOC1kM2U1ZmQzNGQxMDdAa2VybmVsLm9yZy8NCj4+PiANCj4+
PiBPbGdhLCB3b3VsZCB5b3UgYmUgT0sgd2l0aCB0aGF0IGFwcHJvYWNoIGluc3RlYWQ/DQo+PiAN
Cj4+IEF0IHRoaXMgcG9pbnQsIEknZCBsaWtlIHRvIGNvbnNpZGVyIHBvc3Rwb25pbmcgdGhlIGRl
bHN0aWQgcGF0Y2hlcw0KPj4gdW50aWwgdjYuMTMuIFRoZXkgaGF2ZW4ndCBnb3R0ZW4gZW5vdWdo
IHRlc3RpbmcgaW4gdGhlaXIgY3VycmVudA0KPj4gZm9ybS4uLg0KPiANCj4gSXQncyB5b3VyIGNh
bGwsIGJ1dCB0aGF0IHNlZW1zIGxpa2UgYW4gZXh0cmVtZSByZWFjdGlvbiB0byBhIGZsYWcNCj4g
aGFuZGxpbmcgZml4LCBnaXZlbiB0aGF0IHdlIGhhdmUgc2V2ZXJhbCB3ZWVrcyBvZiAtcmMncyBh
aGVhZCBvZiB1cy4NCg0KSXQncyBub3QganVzdCB0aGlzIHNtYWxsIHByb2JsZW0gdGhhdCB3b3Jy
aWVzIG1lLg0KDQpJIHB1bGxlZCBpbiB2NCBvZiB0aGUgZGVsc3RpZCBwYXRjaGVzIHByZXR0eSBt
dWNoIGF0IHRoZSBsYXN0DQptb21lbnQgZm9yIHY2LjEyIGRldmVsb3BtZW50LiBTbyBmYXIsIHRo
ZXJlJ3MgYmVlbiBhbiA4MCUNCnBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24sIGFuZCB0aGUgc3VyZ2Vy
eSB0byB3b3JrIGFyb3VuZCB0aGF0DQppc3N1ZSBpbnRyb2R1Y2VkIGFub3RoZXIgYnVnIHRoYXQg
aW52YWxpZGF0ZXMgYWxsIE5GU3Y0LjIgdGVzdA0KcmVzdWx0cyBzaW5jZSB0aGF0IHN1cmdlcnks
IGp1c3QgYSB3ZWVrIGFnby4NCg0KVGhlIGRlbHN0aWQgcGF0Y2hlcyBpbXBhY3QgYW4gYWxyZWFk
eSBoZWF2aWx5LXVzZWQgY29kZSBwYXRoDQooT1BFTikuIFlvdSd2ZSBhbHJlYWR5IGZvdW5kIG9u
ZSBvciB0d28gYnVncyBpbiB0aGUgY2xpZW50DQpzaWRlIGFzIHdlbGwuIFRoaXMgaXNuJ3Qgc29t
ZXRoaW5nIHRoZSBjYW4gYmUgZGlzYWJsZWQgYnkNCmRpc3Ryb3MgdW50aWwgaXQgaXMgcmVhZHkg
LS0gaXQncyBiYWtlZCBpbnRvIGEgcG9wdWxhciBjb2RlDQpwYXRoIGFzIHNvb24gYXMgaXQgZ29l
cyB1cHN0cmVhbSwgYW5kIE5GU3Y0LjIgaXMgdGhlIGN1cnJlbnQNCmRlZmF1bHQuDQoNClNvIEkg
Y2FuJ3Qgc2F5IHdpdGggY29uZmlkZW5jZSB0aGF0IHRoaXMgY29kZSBpcyBzdGFibGUgYW5kDQpy
ZWFkeSB0byBtZXJnZS4gSWYgd2UgaGFkIGFub3RoZXIgd2VlayBvciB0d28gYmVmb3JlIHY2LjEx
DQpmaW5hbCwgdGhlcmUgd291bGRuJ3QgYmUgYSBxdWVzdGlvbiwgYnV0IGl0J3MgYWxyZWFkeSBh
IHdlZWsNCmludG8gdGhlIHY2LjEyIG1lcmdlIHdpbmRvdywgYW5kIEkgbmVlZCB0byBzdWJtaXQg
YSBwdWxsDQpyZXF1ZXN0IGluIHRoZSBuZXh0IGZldyBkYXlzLiBBIDYuMTEtcmM4IHdvdWxkIGhh
dmUgYmVlbg0KZXh0cmVtZWx5IGhlbHBmdWwsIGJ1dCB3ZSBkaWRuJ3QgZ2V0IG9uZS4NCg0KRXhw
b3NpbmcgdGhpcyBjaGFuZ2Ugc2V0IHRvIHRoZSBjYXVsZHJvbiB0aGF0IGlzIGJha2UtYS10aG9u
DQp3b3VsZCBiZSB2YWx1YWJsZSwgSU1PLCBmb3IgYm90aCB0aGUgY2xpZW50IGFuZCB0aGUgc2Vy
dmVyLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

