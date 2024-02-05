Return-Path: <linux-nfs+bounces-1799-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA61C84A778
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 22:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6571F2A88A
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 21:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391D082D7C;
	Mon,  5 Feb 2024 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OgX47jDO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p7zKOYsE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DBA4D5A2
	for <linux-nfs@vger.kernel.org>; Mon,  5 Feb 2024 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162640; cv=fail; b=ngh1iG8AM3SWf5QklFHs/weCmMQTSA28Da/uXGCxkfjMREMEGlh7B5kRT31TfCgF+Yhtd1hMgANjYO1zg4wrMnRvWxlleg2En8jsmu7sVs7gyhZFAdJ9mRd8WTUGqpooPESYkTw0hYzh2RKtwSIpq4rP+KF/UCAe/DJGETnamyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162640; c=relaxed/simple;
	bh=p5jrFgzVKWOS2QBBk3xCCmXQ7iMEgcK1Ekf0n4SEASw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XC9PXppPlxlY7gQeHs5MdE8icVr6qVMoxDi25LoscZgM4494589lhNcxuSUN9JyKdzmofeKPcePWgm33FiDquwrRi90BZKop7j3hvflPamIGbTpwZ2Dak1ktInA74pK5qYcp9+X14096y6XToA5fAyy9aHwz0b+FDQMkfRKr8Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OgX47jDO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p7zKOYsE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415J3sAx029094;
	Mon, 5 Feb 2024 19:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=p5jrFgzVKWOS2QBBk3xCCmXQ7iMEgcK1Ekf0n4SEASw=;
 b=OgX47jDORG9/xBRflL1ZOopAexSlbISk5IwUjyzA84zhId6ZpZiFUAOTrnSzgSL3tSu+
 jL9CFTG7NNIumqbUurnCbbYFB+CBitWXQW8iof2cnfW5rxsNxKJj5wIGOovJSthdKKzC
 0ll4nck3VLo8sX1SG+HdshVCvYbba8h1rc/gTjBYSd1HzY+HYVVqljivQKEhPOAqdq2x
 O8+qsHd6GDH02YN5ZlJyyKwwQvU3qCaaetyVowedctHdyerKODHWuEgoY+CgSjS1P2wi
 4DhMZRroXQRMbFoEYvlZziWX1K/oXnHJBmN5fe89UzF6tvLKREyY6aEF3hT9VLqrWkwy vw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c93w0qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 19:50:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 415It4Bm038392;
	Mon, 5 Feb 2024 19:50:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx617wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 19:50:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmkZ2sD3XemttNo9Y/ZV3kx+Y4Zz/wKpLGTbxuj6yD9sMRUQLaufk1mBuUyQpQmT781AcmPcjLkd9ytrKvxkTsMC0Qu4lVu3pp+1ZcBH3SGI7WJWjTurrgXBRklwTVnibbEgq/4UW33QyhNr15zhZT+m26WGCdjexjCXZoiVxRw0K4esofmXZN+a79h2jSAyFEu8EFQXQ1cZM7sG2s2GBOzOms1ZK6T7JLgQ2XuZbACiPDYtroyyR+QqaDDBlBPbvQGUWjXCL2YvqXCjIMXNFBoANwBjGnI5u9TDBoJArvKyEWvU8DPCSp35WBL7W5BjQ215G0nXRIMvnhdqGwHYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5jrFgzVKWOS2QBBk3xCCmXQ7iMEgcK1Ekf0n4SEASw=;
 b=H7PyyjgQrKwvf2c+8kXlT4z9NQi7L8CRYRWZA3B5tHhOFmmWvkLd6IscIJTSy5JKZxbyHVnjKYvlzZwCKW9lTpnAoE3MDNTckiR7HuOARxuQJF0j6HMKHXjn7CMgnjvbybBf5KF+m8I+od2vuT4HjAXyvPDbk9YD2IH014vZxmbAmTNhBwE51ICqxgh2jMGcmLSbBGzwjM1Vxbv7pYim9PWJnnEY5+7NGMm8i4DSRFv1IsLPaUCEsDkGmRmqcQ6/7cevvmFn8f19GAR8it30FdCDGDwkvp//IJQzLxsFQ+wvgNVGh0hVaBP/q4JocsD8IpvQF1o2qvI76UoLdOE/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5jrFgzVKWOS2QBBk3xCCmXQ7iMEgcK1Ekf0n4SEASw=;
 b=p7zKOYsEtyA/NOP0wro8bN0N0tX5UqqJmWn7X43B3KMmYeu8HatVERD4DbKzAAI0f22OvyZANPDxVA1nis9afFmD17yyKFQsQpItol+MZXuIICpnsu+lSmxGKluPJNvPbs2tOL864JbCJiVPt6ZbvHCnRSMUFgSjTs+Z0B0R72Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB6326.namprd10.prod.outlook.com (2603:10b6:a03:44c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 19:50:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 19:50:25 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Jeff Layton
	<jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        Olga Kornievskaia
	<olga.kornievskaia@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing
 List <linux-nfs@vger.kernel.org>
Subject: Re: Should we establish a new nfsdctl userland program?
Thread-Topic: Should we establish a new nfsdctl userland program?
Thread-Index: AQHaT8Zp476+VGqpskq8+ahQ0OuBVrD3VWAAgAANTACABKNogIAAMeGAgAABkYA=
Date: Mon, 5 Feb 2024 19:50:25 +0000
Message-ID: <DD7F51B6-B0BC-4412-BA19-164272120158@oracle.com>
References: <8a7bbc05b6515109692cb88ad68374d14fc01eca.camel@kernel.org>
 <Zb0hlnQmgVikeNpi@lore-rh-laptop>
 <e706a77b4ddbceeb8b0ebac4dcbca03f8196e8a5.camel@kernel.org>
 <ZcEQzyrZpyrMJGKg@lore-desk>
 <170716227903.13976.3838162060222642711@noble.neil.brown.name>
In-Reply-To: <170716227903.13976.3838162060222642711@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB6326:EE_
x-ms-office365-filtering-correlation-id: 0e713cd8-222b-4aba-0c5c-08dc2683b28d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rfgVA6y+LUFdTjshRo2IL6nTZc6dGbGIKekSMYcDYV0JeEAEhhg3+4kFn6/rBcr1nCDMo9R0Et26H0Vk6jDTiS1ph2Fz6h9+YRdXhi8SDAZVyoefQagRMoEjOrriZu3WeTghcMvPVaheP1w/7iDgJpj2wbbLOzeRzeektuGxcjpAKiAGqj1hubQ6MVgGGzpLfObtNvGfM6ToFq550dKAXqY/1dYgKU2lzAOYNTBFNk+9AyG4bEDd+52OzUD8qax+86HJOkJPp3ldDyxNzXqT6uCLawd9cVSsyEhwmhhmRxVUrHupLQMY7MUm50aq0mZ6ScT4M4Wj9bYmXxcIdP5oi7JkLa8zuIEoDQaZ57GpRG+W1xSjAfyO2FFqEz3mgoduzyqKiSJU9NwPkiRfcdQJ4MrLbLcWxy9JBMSxZ50EkjtyRhQX6h7zUFGMT5HCL9+iJmh1YYcYNnSqWIAsgMkye27yGe7mR5zpPPidebiyOUHhX3sGVzHiamgkHmdz2nCqAekkwtn7hAqSk3iHM4/plde0cv+sNDmXCTQBLg3DgORA8HNHHUWSNNgoMewHRZJo8qPb/2OdQa6zF3N6CAiBN16fkFL5oEVU6aWbbh920lg5m2iysvXIWyDJE66Q5ldUkZAs9JftTP5tShTaQePd6uoQjfkw/JuTf28+7mr+5WoMilmU+6zv2q2xEMVw1Fpi
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(376002)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(66899024)(83380400001)(54906003)(76116006)(122000001)(38100700002)(8676002)(5660300002)(4326008)(8936002)(64756008)(6486002)(66476007)(66446008)(316002)(66556008)(966005)(66946007)(478600001)(2616005)(6916009)(2906002)(71200400001)(26005)(53546011)(6512007)(6506007)(36756003)(41300700001)(33656002)(86362001)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aE9hdGJxaFE5VWtDeHlWTTEwZ1hXYno2SldSNlFYZmtPdkhma1dWRUJFSm5Q?=
 =?utf-8?B?dmxDVGMrR2lMWEFDQVpReFBVZ0ZrMFZlcUVqd0pTTXhLMDNHWm1GRnIwUk5O?=
 =?utf-8?B?WUlOREUyai9NcWhhRGlDOW42b1pyVi9XRWtYRDg2Nmxsd3FKZkF2ZUJTamlm?=
 =?utf-8?B?SDY2NDNrUTl2T0d6T29CajcwODJodjVoc3c2bHRIdGo0QWdWdVdwdUtTc0pI?=
 =?utf-8?B?T1JqanVkQnFtV2R3Uys5V3IyOHEwWnFBTjRtWm9vVXV3Rk91cW1ibk9IWUZX?=
 =?utf-8?B?QUw0WTNSYWo4WFFDbFBGTzJqUGtGYXlpRkxRbkhGaUxHWE1TazU3eEVGTEt5?=
 =?utf-8?B?MkIvd0s3akwrVTdUQ3BpOGkxdXlGSnltWC9mMjVyNmdnLzFlUzE3OFdCS2la?=
 =?utf-8?B?OVF3bW1QNjZQZVBlazdwN1daVVhFMzZ2d240RDFYdU1WVGo0emJMQW9tdlU4?=
 =?utf-8?B?ZUd6ODR4S2xrZUFSNFVlQ2NiaGQ5TkhycWtrcVFXUkpVN1BQRC9kS2E5VnNp?=
 =?utf-8?B?VGhaOFl0dEd2aFVFZGpjRDdGd05LdzRRVzNVTVpmczE2TkhGdjc1RDVZNk8w?=
 =?utf-8?B?Y1lQNWdaMTBOUXREazNMRWhDekZkYWsxSTZCLytLY09hRW8zbzhrcE1sUUl6?=
 =?utf-8?B?TTA4TDRlL2dNQkJiVk9zNVQyU1RkM0xJNVNqelZpR1NEb0RzSXV4c3ZuT3kx?=
 =?utf-8?B?S1F3N2g5MERiOU5zYlRJeEtrL1dRYUJEUExQOGtmdG8xaFdxRm50UmlST1hz?=
 =?utf-8?B?TG1NVk1FZnplR3JZRngySzRCa2pVWkR0T2U5OTR1d0o4MFl1aEIvVUcySFE1?=
 =?utf-8?B?S2VtR2ZZNXZ5SWpxbDlWQkhJN2RaQmhZQ3pmcW04cjMxNFgxTHJaMEJkTlZi?=
 =?utf-8?B?ZERiM2FneXdvK05tVlNPVEcxdHExaWFGdWM2Ynpla3A5STg2NnVsbHNSaUpD?=
 =?utf-8?B?QjdFTlZ5WDZPM0J1cFF6UkhvalNST09FNXBtNUo5Q3IwNG1aY1BMNGhhVy9v?=
 =?utf-8?B?QTBBcXQ4M0dUeGloVTk0VHZ5VXJQT2l6RXgwY1BkcG5jcHhpUXM3YTg5a1ZU?=
 =?utf-8?B?TDFoMDczS1g4NjlxN2tKalRZdi9DZm5kZmZpSk1mZzRwVVFmaVQvYUhoUEVX?=
 =?utf-8?B?Ky9hb2hwNkZhcEMxSlRuMHh5cFVWVnVtUXEwcHU1aThyWjR4TTNJbTNyMEdl?=
 =?utf-8?B?YmN1RklXY3lUVG9qS25PeU84YkJ4YTVHWk4yVU02ODBKUWdwbXdrTDdjQUJF?=
 =?utf-8?B?cUR1K0hNVGJnSUVqODlhdHdhSEZZUytkZ2FDNDdEeGhRNkMwZlJEM1ZvVGR0?=
 =?utf-8?B?dkkxNEp5ZFRERXFoazF2VE1KWDBKK01Pc3RONnVLdXJLb2ZDbTQ1MndDc0dq?=
 =?utf-8?B?ci9DZ29tRU9zWGxXekE5cGdEcFVjeWRFcnZWQWx0Q0kzVnFyN1c3Y0VLOThz?=
 =?utf-8?B?MmVyeHgySU93dnJvU0ZTWjVwNExQNWlRVmg0dFlMUWVpQ0hQcFZ4bndHL0RZ?=
 =?utf-8?B?REZjMWtmYWFuWnY1U1krNkRzcVo4bjRjQnlIWGdZL1VxU0VsT2x6SHRIeE5j?=
 =?utf-8?B?WUNoZFU0d2lhQnVJMnhrSStSUDNWR0w0THFwcFg2VitnZ0F2Qll3UVg0em5p?=
 =?utf-8?B?YTVyZU1VOW5PTllybHF1T1o4MTNIVytabmlva21pY0t3VW1KblI1V2F5ZTV6?=
 =?utf-8?B?RTcvaER6TzJwYzZDK0hudDlvanBIQXVLM0RkNmlkUFRaeFpjQlVsY2xxL3Zy?=
 =?utf-8?B?Y1Z1WW1RZnJ1U0Z1QWZXTWd2OTFIR1p3djloM3l2Q3BEMGxIVWdwU2UreitZ?=
 =?utf-8?B?dnRWYUhqcmZUcFJXdUhPUDJGUzJDM2hLZWdqY1RNSU1xY0hEZGgrRjlPeG40?=
 =?utf-8?B?eXBmZnFnY0VxNXZPVWpHamh2dkg4MExRbWNRWXVZMHVaYi9xYkpka2dMVXlH?=
 =?utf-8?B?WmUvRU1WYjdYVWxCZEJvSVdrVUJVTUlTZGVvMWhDaW5MVEF6ejdTQnMvbU1i?=
 =?utf-8?B?YXdqNjJTT3RNM0NqMWxTVXh0dGVYNVRZQ0RKb1lyNU5KcUc4ZXN1bzhyOWN6?=
 =?utf-8?B?aEh3YjRtbktVbkhCYWFxSEpjRjQwckgrY3cwMWhJOXZ2bHg5R2h1Szh0WUFK?=
 =?utf-8?B?VDRoZUpLYkxwRUxGbFRVZzNleGZQcnZldmxUTTlmLzFVOGY4TitlaERLQjM4?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DB4AF79CB764449A0210DA197C49E2C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	N5chZdarRP0ETmIcNcopqGh+13GPy5ukY7K5XNgvwF8p6/iROmH/mvs4metbxvCBrJlqKAZ5Uq4HC0M/WW2NmKhDF9qvaigo9MNKrYb0tv7xxsqkmO5sGD7jWWZlAAej1zHZrQJ+6/mGWbVHqGTsKptFFu307fdB40ZTtlLptzw/oJJiNAnjdEEttwlYtfTKV1YELv3cIyvmd9N+/FMH0i6wYMJXpjoblK1nZicTZlDsMEhdywWXyLyoaNSDWupvpeyT6BN5uT9amcoS85mTZJ2lm84k9o4Ykqtx9KX/tNPiKuaitfUT9W775pYPhGeK7O/R3h6uRLYD7de1jjmEuvKSPAwnWGAZ2vG10l5gSb+VlY3hHtcu5gSUPad4xRiCj0TbTm/QDkKQcfM56xGIZs1p5WkVPQ2x86tvZr9c0sPa8djqU4EqezxLT1aj5YMvtGPZGM3moCQqliIk87OaECoBr2Vb1weW/QhS6cB4bVupWw6VIDOLzgiy8n//ZxhKj5ilnXGT8+ovPX76CLvvpBN4rLJjGRjy9XTdrTBSIndH1PCQ7vhOg9Ys2X4Iz2aYc5cpcXnIe/NKpYCvWjrCFONdIRrOYkEb7nbFDg5VOj4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e713cd8-222b-4aba-0c5c-08dc2683b28d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 19:50:25.7893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7rL+wPKP24G0mwCCJRkERZ/kPBl73QPcWI+Qy2RKm9HyNe27KkQ8YM3w8J7BiL5VErIobRWex24spmjBJwBtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050148
X-Proofpoint-ORIG-GUID: sYYmBNzXO6NCQcG8Ec51OIJFYpHFBxKg
X-Proofpoint-GUID: sYYmBNzXO6NCQcG8Ec51OIJFYpHFBxKg

DQoNCj4gT24gRmViIDUsIDIwMjQsIGF0IDI6NDTigK9QTSwgTmVpbEJyb3duIDxuZWlsYkBzdXNl
LmRlPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMDYgRmViIDIwMjQsIExvcmVuem8gQmlhbmNvbmkg
d3JvdGU6DQo+Pj4gT24gRnJpLCAyMDI0LTAyLTAyIGF0IDE4OjA4ICswMTAwLCBMb3JlbnpvIEJp
YW5jb25pIHdyb3RlOg0KPj4+Pj4gVGhlIGV4aXN0aW5nIHJwYy5uZnNkIHByb2dyYW0gd2FzIGRl
c2lnbmVkIGR1cmluZyBhIGRpZmZlcmVudCB0aW1lLCB3aGVuDQo+Pj4+PiB3ZSBqdXN0IGRpZG4n
dCByZXF1aXJlIHRoYXQgbXVjaCBjb250cm9sIG92ZXIgaG93IGl0IGJlaGF2ZWQuIEl0J3MNCj4+
Pj4+IGtsdW5reSB0byB3b3JrIHdpdGguDQo+Pj4+PiANCj4+Pj4+IEluIGEgcmVzcG9uc2UgdG8g
Q2h1Y2sncyByZWNlbnQgUkZDIHBhdGNoIHRvIGFkZCBrbm9iIHRvIGRpc2FibGUNCj4+Pj4+IFJF
QURfUExVUyBjYWxscywgSSBtZW50aW9uZWQgdGhhdCBpdCBtaWdodCBiZSBhIGdvb2QgdGltZSB0
byBtYWtlIGENCj4+Pj4+IGNsZWFuIGJyZWFrIGZyb20gdGhlIHBhc3QgYW5kIHN0YXJ0IGEgbmV3
IHByb2dyYW0gZm9yIGNvbnRyb2xsaW5nIG5mc2QuDQo+Pj4+PiANCj4+Pj4+IEhlcmUncyB3aGF0
IEknbSB0aGlua2luZzoNCj4+Pj4+IA0KPj4+Pj4gTGV0J3MgYnVpbGQgYSBzd2lzcy1hcm15LWtu
aWZlIGtpbmQgb2YgaW50ZXJmYWNlIGxpa2UgZ2l0IG9yIHZpcnNoOg0KPj4+Pj4gDQo+Pj4+PiAj
IG5mc2RjdGwgc3RhdHMgPC0tLSBmZXRjaCB0aGUgbmV3IHN0YXRzIHRoYXQgZ290IG1lcmdlZA0K
Pj4+Pj4gIyBuZnNkY3RsIGFkZF9saXN0ZW5lciA8LS0tIGFkZCBhIG5ldyBsaXN0ZW4gc29ja2V0
LCBieSBhZGRyZXNzIG9yIGhvc3RuYW1lDQo+Pj4+PiAjIG5mc2RjdGwgc2V0IHYzIG9uIDwtLS0g
ZW5hYmxlIE5GU3YzDQo+Pj4+PiAjIG5mc2RjdGwgc2V0IHNwbGljZV9yZWFkIG9mZiA8LS0tIGRp
c2FibGUgc3BsaWNlIHJlYWRzIChwZXIgQ2h1Y2sncyByZWNlbnQgcGF0Y2gpDQo+Pj4+PiAjIG5m
c2RjdGwgc2V0IHRocmVhZHMgMTI4IDwtLS0gc3BpbiB1cCB0aGUgdGhyZWFkcw0KPj4+Pj4gDQo+
Pj4+PiBXZSBjb3VsZCBzdGFydCB3aXRoIGp1c3QgdGhlIGJhcmUgbWluaW11bSBmb3Igbm93ICh0
aGUgc3RhdHMgaW50ZXJmYWNlKSwNCj4+Pj4+IGFuZCB0aGVuIGV4cGFuZCBvbiBpdC4gT25jZSB3
ZSdyZSBhdCBmZWF0dXJlIHBhcml0eSB3aXRoIHJwYy5uZnNkLCB3ZSdkDQo+Pj4+PiB3YW50IHRv
IGhhdmUgc3lzdGVtZCBwcmVmZXJlbnRpYWxseSB1c2UgbmZzZGN0bCBpbnN0ZWFkIG9mIHJwYy5u
ZnNkIHRvDQo+Pj4+PiBzdGFydCBhbmQgc3RvcCB0aGUgc2VydmVyLiBzeXN0ZW1kIHdpbGwgYWxz
byBuZWVkIHRvIGZhbGwgYmFjayB0byB1c2luZw0KPj4+Pj4gcnBjLm5mc2QgaWYgbmZzZGN0bCBv
ciB0aGUgbmV0bGluayBwcm9ncmFtIGlzbid0IHByZXNlbnQuDQo+Pj4+PiANCj4+Pj4+IE5vdGUg
dGhhdCBJIHRoaW5rIHRoaXMgcHJvZ3JhbSB3aWxsIGhhdmUgdG8gYmUgYSBjb21waWxlZCBiaW5h
cnkgdnMuIGENCj4+Pj4+IHB5dGhvbiBzY3JpcHQgb3IgdGhlIGxpa2UsIGdpdmVuIHRoYXQgaXQn
bGwgYmUgaW52b2x2ZWQgaW4gc3lzdGVtDQo+Pj4+PiBzdGFydHVwLg0KPj4+Pj4gDQo+Pj4+PiBJ
dCB0dXJucyBvdXQgdGhhdCBMb3JlbnpvIGFscmVhZHkgaGFzIGEgQyBwcm9ncmFtIHRoYXQgaGFz
IGEgbG90IG9mIHRoZQ0KPj4+Pj4gcGx1bWJpbmcgd2UnZCBuZWVkOg0KPj4+Pj4gDQo+Pj4+PiAg
ICAgaHR0cHM6Ly9naXRodWIuY29tL0xvcmVuem9CaWFuY29uaS9uZnNkLW5ldGxpbmsNCj4+Pj4g
DQo+Pj4+IFRoaXMgaXMgc29tZXRoaW5nIEkgZGV2ZWxvcGVkIGp1c3QgZm9yIHRlc3RpbmcgdGhl
IG5ldyBpbnRlcmZhY2UgYnV0IEkgYWdyZWUgd2UNCj4+Pj4gY291bGQgc3RhcnQgZnJvbSBpdC4N
Cj4+Pj4gDQo+Pj4+IFJlZ2FyZGluZyB0aGUga2VybmVsIHBhcnQgSSBhZGRyZXNzZWQgdGhlIGNv
bW1lbnRzIEkgcmVjZWl2ZWQgdXBzdHJlYW0gb24gdjYgYW5kDQo+Pj4+IHB1c2hlZCB0aGUgY29k
ZSBoZXJlIFswXS4NCj4+Pj4gSG93IGRvIHlvdSBndXlzIHByZWZlciB0byBwcm9jZWVkPyBJcyB0
aGUgYmV0dGVyIHRvIHBvc3QgdjcgdXBzdHJlYW0gYW5kIGNvbnRpbnVlDQo+Pj4+IHRoZSBkaXNj
dXNzaW9uIGluIG9yZGVyIHRvIGhhdmUgc29tZXRoaW5nIHVzYWJsZSB0byBkZXZlbG9wIHRoZSB1
c2VyLXNwYWNlIHBhcnQgb3INCj4+Pj4gZG8geW91IHByZWZlciB0byBoYXZlIHNvbWV0aGluZyBm
b3IgdGhlIHVzZXItc3BhY2UgZmlyc3Q/DQo+Pj4+IEkgZG8gbm90IGhhdmUgYSBzdHJvbmcgb3Bp
bmlvbiBvbiBpdC4NCj4+Pj4gDQo+Pj4+IFJlZ2FyZHMsDQo+Pj4+IExvcmVuem8NCj4+Pj4gDQo+
Pj4+IFswXSBodHRwczovL2dpdGh1Yi5jb20vTG9yZW56b0JpYW5jb25pL25mc2QtbmV4dC90cmVl
L25mc2QtbmV4dC1uZXRsaW5rLW5ldy1jbWRzLXB1YmxpYy12Nw0KPj4+PiANCj4+Pj4gDQo+Pj4g
DQo+Pj4gTXkgYWR2aWNlPw0KPj4+IA0KPj4+IFN0ZXAgYmFjayBhbmQgc3BlbmQgc29tZSB0aW1l
IHdvcmtpbmcgb24gdGhlIHVzZXJsYW5kIGJpdHMgYmVmb3JlDQo+Pj4gcG9zdGluZyBhbm90aGVy
IHJldmlzaW9uLiBFeHBlcmllbmNlIGhhcyBzaG93biB0aGF0IHlvdSBuZXZlciByZWFsaXplDQo+
Pj4gd2hhdCBzb3J0IG9mIHdhcnRzIGFuIGludGVyZmFjZSBsaWtlIHRoaXMgaGFzIHVudGlsIHlv
dSBoYXZlIHRvIHdvcmsNCj4+PiB3aXRoIGl0Lg0KPj4+IA0KPj4+IFlvdSBtYXkgZmluZCB0aGF0
IHlvdSB3YW50IHRvIHR3ZWFrIGl0IHNvbWUgb25jZSB5b3UgZG8sIGFuZCBpdCdzIG11Y2gNCj4+
PiBlYXNpZXIgdG8gZG8gdGhhdCBiZWZvcmUgd2UgbWVyZ2UgYW55dGhpbmcuIFRoaXMgd2lsbCBi
ZSBwYXJ0IG9mIHRoZQ0KPj4+IGtlcm5lbCBBQkksIHNvIG9uY2UgaXQncyBpbiBhIHNoaXBwaW5n
IGtlcm5lbCwgd2UncmUgc29ydCBvZiBzdHVjayB3aXRoDQo+Pj4gaXQuDQo+Pj4gDQo+Pj4gSGF2
aW5nIGEgdXNlcmxhbmQgcHJvZ3JhbSByZWFkeSB0byBnbyB3aWxsIGFsbG93IHVzIHRvIGRvIHRo
aW5ncyBsaWtlDQo+Pj4gc2V0IHVwIHRoZSBzeXN0ZW1kIHNlcnZpY2UgZm9yIHRoaXMgdG9vLCB3
aGljaCBpcyBwcmltYXJpbHkgaG93IHRoaXMgbmV3DQo+Pj4gcHJvZ3JhbSB3aWxsIGJlIGNhbGxl
ZC4NCj4+IA0KPj4gSSBhZ3JlZSBvbiBpdC4gSW4gb3JkZXIgdG8gcHJvY2VlZCBJIGd1ZXNzIHdl
IHNob3VsZCBkZWZpbmUgYSBsaXN0IG9mDQo+PiByZXF1aXJlbWVudHMvZXhwZWN0ZWQgYmVoYXZp
b3VyIG9uIHRoaXMgbmV3IHVzZXItc3BhY2UgdG9vbCB1c2VkIHRvDQo+PiBjb25maWd1cmUgbmZz
ZC4gSSBhbSBub3Qgc28gZmFtaWxpYXIgd2l0aCB0aGUgdXNlci1zcGFjZSByZXF1aXJlbWVudHMN
Cj4+IGZvciBuZnNkIHNvIEkgYW0ganVzdCBjb3B5aW5nIHdoYXQgeW91IHN1Z2dlc3RlZCwgc29t
ZXRoaW5nIGxpa2U6DQo+PiANCj4+ICQgbmZzZGN0bCBzdGF0cyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8LS0tIGZldGNoIHRoZSBuZXcgc3RhdHMgdGhh
dCBnb3QgbWVyZ2VkDQo+PiAkIG5mc2RjdGwgeHBydCBhZGQgcHJvdG8gPHVkcHx0Y3A+IGhvc3Qg
PGhvc3Q+IFtwb3J0IDxwb3J0Pl0gICAgPC0tLSBhZGQgYSBuZXcgbGlzdGVuIHNvY2tldCwgYnkg
YWRkcmVzcyBvciBob3N0bmFtZQ0KPj4gJCBuZnNkY3RsIHByb3RvIHYzLjAgdjQuMCB2NC4xICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwtLS0gZW5hYmxlIE5GU3YzIGFuZCB2NC4x
DQo+PiAkIG5mc2RjdGwgc2V0IHRocmVhZHMgMTI4ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgPC0tLSBzcGluIHVwIHRoZSB0aHJlYWRzDQo+IA0KPiBNeSBwcmVmZXJlbmNl
IHdvdWxkIGJlOg0KPiANCj4gICBuZnNkY3RsIHN0YXJ0DQo+IGFuZCANCj4gICBuZnNkY3RsIHN0
b3ANCj4gDQo+IHdoZXJlIG5mc2RjdGwgcmVhZHMgYSBjb25maWcgZmlsZSB0byBkaXNjb3ZlciB3
aGF0IHNldHRpbmcgYXJlIHJlcXVpcmVkLg0KPiBJIGNhbm5vdCBzZWUgYW55IGNyZWRpYmxlIHVz
ZSBjYXNlIGZvciAneHBydCcgb3IgJ3Byb3RvJyBvciAndGhyZWFkcycNCj4gY29tbWFuZHMuDQo+
IA0KPiBQb3NzaWJseSBuZnNjdGwgd291bGQgYWNjZXB0IGNvbmZpZyBvbiB0aGUgY29tbWFuZCBs
aW5lOg0KPiAgbmZzZGN0bCBzdGFydCBwcm90bz0zLDQuMSB0aHJlYWRzPTQyIHByb3RvPXRjcDps
b2NhbGhvc3Q6MjA0OQ0KPiBvciBzaW1pbGFyLg0KDQpZb3UndmUgZ290IHByb3RvPSBsaXN0ZWQg
dHdpY2UgaGVyZS4NCg0KSSdtIG1vcmUgaW4gZmF2b3Igb2YgaGF2aW5nIG1vcmUgc3ViY29tbWFu
ZHMsIGVhY2ggb2Ygd2hpY2ggZG8NCnNvbWV0aGluZyBzaW1wbGUuIEVhc2llciB0byB1bmRlcnN0
YW5kLCBlYXNpZXIgdG8gdGVzdC4NCg0KDQo+IEl0IHdvdWxkIGFsc28gYmUgaGVscGZ1bCB0byBo
YXZlICJuZnNkaW5mbyIgb3Igc2ltaWxhciB3aGljaCBoYXMgInN0YXRzIg0KPiBhbmQgInN0YXR1
cyIgY29tbWFuZHMuICBNYXliZSB0aGF0IGNvdWxkIGJlIGNvbWJpbmVkIHdpdGggIm5mc2RjdGwi
LCBidXQNCj4gZXh0cmFjdGluZyBpbmZvIGlzIG5vdCBhIGZvcm0gb2YgImNvbnRyb2wiLiAgT3Ig
d2UgY291bGQgZmluZCBhIG1vcmUNCj4gZ2VuZXJpYyB2ZXJiLiAgRm9yIHNvZnQtcmFpZCBJIHdy
b3RlICJtZGFkbSIgImFkbSIgZm9yICJhZG1pbmlzdGVyIg0KPiB3aGljaCBzZWVtZWQgbGVzcyBz
cGVjaWZpYyB0aGFuICJjb250cm9sIiAobWRjdGwpLiAgVGhvdWdoIHByb2JhYmx5IHRoZQ0KPiBt
YWluIHJlYXNvbiB3YXMgdGhhdCBJIGxpa2UgcGFsaW5kcm9tZXMgYW5kICJtZGFkbSIgd2FzIGEg
Yml0IGVhc2llciB0bw0KPiBzYXkuICBuZnNkYWRtID8/ICAoc2VlIGFsc28gdWRldmFkbSwgZHJk
YmFkbSwgZnNhZG0gLi4uLikgQnV0IG1heWJlIEknbQ0KPiBqdXN0IHRvbyBmdXNzLg0KPiANCj4g
SW4gbXkgZXhwZXJpZW5jZSB3b3JraW5nIHdpdGggb3VyIGN1c3RvbWVycyBhbmQgc3VwcG9ydCB0
ZWFtLCB0aGV5IGFyZQ0KPiBub3QgYXQgYWxsIGludGVyZXN0ZWQgaW4gZmluZSBjb250cm9sLg0K
DQpUaGlzIGlzIGFuIGludGVyZmFjZSB0byBiZSB1c2VkIGJ5IHN5c3RlbWN0bC4gSSBkb24ndCB0
aGluayBjdXN0b21lcnMNCm9yIHN1cHBvcnQgdGVhbXMgd291bGQgZXZlciBuZWVkIHRvIG1ha2Ug
dXNlIG9mIGl0IGRpcmVjdGx5Lg0KDQoNCj4gInN5c3RlbWN0bCByZXN0YXJ0IG5mcy1zZXJ2ZXIi
IGlzDQo+IHRoZWlyIHNlY29uZCBwcmVmZXJlbmNlIHdoZW4gInJlYm9vdCIgaXNuJ3QgYXBwcm9w
cmlhdGUgZm9yIHNvbWUgcmVhc29uLg0KPiANCj4gWW91IG1pZ2h0IGJlIGFibGUgdG8gY29udmlu
Y2UgbWUgdGhhdCAibmZkY3RsIHJlbG9hZCIgd2FzIHVzZWZ1bCAtIGl0DQo+IGNvdWxkIGJlIGNh
bGxlZCBmcm9tICJzeXN0ZW1jdGwgcmVsb2FkIG5mcy1zZXJ2ZXIiLiAgVGhhdCB3b3VsZCB0aGVu
DQo+IGp1c3RpZnkga2VybmVsIGludGVyZmFjZXMgdG8gcmVtb3ZlIHhwcnRzLiAgQnV0IGhhdmlu
ZyBhbGwgdGhlDQo+IGZpbmUtY29udHJvbCBqdXN0IGluY3JlYXNlcyB0aGUgcmVxdWlyZWQgdGVz
dGluZyBuZWVkZWQgd2l0aCBsaXR0bGUNCj4gcHJhY3RpY2FsIGdhaW4uDQo+IA0KPiBOZWlsQnJv
d24NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

