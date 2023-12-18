Return-Path: <linux-nfs+bounces-690-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB938174CB
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 16:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94CF28100D
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 15:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691DD37888;
	Mon, 18 Dec 2023 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cZkGbKZ0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yOUf4RNA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700901D15F
	for <linux-nfs@vger.kernel.org>; Mon, 18 Dec 2023 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIEuMPN017703;
	Mon, 18 Dec 2023 15:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=npihawIQAukhcPurKHj/ZNeNRaAgaadOLyL9gMHJQWs=;
 b=cZkGbKZ0pxV3odZjJgp7Sva5d45/1mK2etAuJUlZHuiWzpErY/rYCgVinfOqABuq+n0A
 RA4Bmh+7ZEhSmP7pdQ7U9bI7ZDpASHevyHeKjHMKwpo1Um0ltFM7zMAhO8CygA1ZV18c
 5yLp5kTkrq1x6B9iEDwiejPXvI/ihfIshBON5g06OV1OCYna2xvr8dkYbR5WDmkmUPKA
 JMv40w7wan/0u5JI8k3i5wrg86rBIzvP/MtqzMGKpgRXKNPui6QAxOXWL5NFIz8IBoGK
 wjDA3oJAbfg8v3ISU/EYp7FyV0bSLoDfelStFypvrRgPLJUdvGLg5wl7Yx2KKqiT3e1v kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v14evbdvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 15:05:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIENa0o029159;
	Mon, 18 Dec 2023 15:05:32 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b5915a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 15:05:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaGQtb6el0ML0bgGkAkEKUD1Gj/bvJhsNgQCwbVVv+oEoKIXYLmLNPL1xPmEPWiH1TtzETkurzeZsogfnveWWzfcw5X3Mh6Pjd593khcc5A9L3jynLADb7TABy9XaAPsWVLdD0N066OjLYZp1KKg799KxWMw/FccBoyl3DK1lDq0AWaQmYwX0zhB3H/axfq6kX1hIFx3B/AtPRx/LpLz+Zfs6xj0zUkVo8Tz68MRSz97Ij0AaMYrZosEwU4vLgo4D+D9VRSL6apz+msl6stJKtyUkcw1pISKq5plMAQh/Zx3Hrs1dyfv5SDffmZH/3QwrHf925EuyF2An4QNfgP8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npihawIQAukhcPurKHj/ZNeNRaAgaadOLyL9gMHJQWs=;
 b=HQAvaU/lxlhSxCvIdPSkeYPcYsWdq4fD50PgesRxvaS8kJE1jn1E9LAOdjEWJKv1QgVdXSLaUuKh3Gx6vFVW0iX3+DuXSYfbDpRJq7PRzEMB9koIVgW93gEc2X2YgA4HqnGZ6GBVgFuxEyr8R+uhvIUeXXVD6tM45oHn7g9fLrOZyALQzv+w/pnInvezv9W0vTMNy9knh3uGqlIjAEFseF4ott6UcN1/pzykFFh5lf6wWDziG/nEFDmkfWhvIZaSrN+xGrxzG9Ph3vSlJLXqiRkj90f3zkB4BW80F0hopvS/5AWj2+805DSOPXFjJPooIY4wqQEnSaKPS8IRIQGfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npihawIQAukhcPurKHj/ZNeNRaAgaadOLyL9gMHJQWs=;
 b=yOUf4RNAvm2WmWeEymdmtx/2WaN8G8VZ0XDoiOkHXtDTd0HQpTIYQJpbv2SZZYl0QL+/foylaKoDGhE1nObmc7Zh7BAL+5kUb/G/lDqvk0Gc3Aqo6YOLanM+DdJFalCFN4spfi4o9BzaCMXfOdxMSw44pIr/7bWmnHUTM6pXqb8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5810.namprd10.prod.outlook.com (2603:10b6:303:186::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 15:05:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 15:05:26 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
CC: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>,
        "linux-nfs@stwm.de"
	<linux-nfs@stwm.de>
Subject: Re: [PATCH 1/3 v2] SUNRPC: remove printk when back channel request
 not found
Thread-Topic: [PATCH 1/3 v2] SUNRPC: remove printk when back channel request
 not found
Thread-Index: AQHaL6BODuJxHzRsvEmtdxXl8tg1rLCrwk6AgABbIwCAAuRWAIAAJi8A
Date: Mon, 18 Dec 2023 15:05:26 +0000
Message-ID: <AD542840-D60F-4446-8669-13123FF00703@oracle.com>
References: <1702676837-31320-1-git-send-email-dai.ngo@oracle.com>
 <1702676837-31320-2-git-send-email-dai.ngo@oracle.com>
 <66BB600A-2C0D-457A-9A13-0F1D7F5E44B7@redhat.com>
 <A958C4F7-7DA4-4BA2-BAA5-9552388F5498@oracle.com>
 <689A6114-B5B2-47DF-A0D6-6901D8F52CBE@redhat.com>
In-Reply-To: <689A6114-B5B2-47DF-A0D6-6901D8F52CBE@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB5810:EE_
x-ms-office365-filtering-correlation-id: 58dd43a6-e15f-4d44-6df8-08dbffdac45e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DP4qP8GxR8sgvnHfDpHOa1abXF8aXfh0fjeP6WGw//NUUXOgaanHl4itkHfBE8WjJ6bF4a5tqI2KkqJyl0v3lUrvobdC5lGpm0lkj22yxOEePstDx2qkRsJ6ewkTRo1UTLCfULOnDi6uFoWmW3zynzaZPjdNoDmJYJcLLiJw8ETqWqWpPA5Ps6s0zEZr6EQ7hXomWja/h6bQ9/z+4E3vesRPVAWucdd5n/LYkBMglZTyY6SpFwYxr6+0lcHL0x9veFQMqcp+jlwYxBIqmw/80PJc0SO/Ta/DkDBJ2ohYXLslR4f1n/fv8jKNFevFgXvwmDnz4uX1dsuE5EWy315WuypzhVsx5GUxA3AQ2Xmn9XL2R2XQ2vJVgRINRimECgSF7+cYawoT8TFiP/uQ7dqjCzR6cdgwaLBpmkgEFyMkFkJPOYCV6qs1e4ZRrWhn2Pczm1YinO0izGSQ2+Boybt/phMtUkLir8r4rpG4dubxwCInqK2vr9+o+OOR03pb5KWjJoxMMx1JVt9tN4ogqzQT6t/ZljBVOdbb+Xt4UimI1MXG9API0k09eQz7x5l1l9PqI84xK2APHragtEGE4ue8HdBlC1eFqb3u8Xau+Xkqua+O9ZPZfVjPpWvwrHWf1UnlLzypj1jdMa62yM+fCxDamch9l4ZerMD9Ilet9EOd4KRhP6sXmXVmuLQHYAprMSI7
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230273577357003)(230922051799003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(2616005)(26005)(6512007)(53546011)(6506007)(83380400001)(5660300002)(8676002)(41300700001)(2906002)(478600001)(316002)(54906003)(91956017)(4326008)(8936002)(6486002)(66946007)(76116006)(66556008)(66476007)(64756008)(66446008)(6916009)(71200400001)(86362001)(33656002)(36756003)(122000001)(38100700002)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RnlQMHR2YmNDVEs4ZERYalRTVlZyU0Z6d2VOUmxMdWpsRHYrc211NlloVCtv?=
 =?utf-8?B?MXQzRUZ3L0tRM0xKVXQzRmtlZWh3YnN6VGoxM2JMQzV0cDVueklHeVlSYm81?=
 =?utf-8?B?N1dhdmMvN0Q3bFhhd0VqSEZxVTRuSjRzelRISE04bWQyREpEbndmRmhrLzZF?=
 =?utf-8?B?N2VuQUVidHVmd2ROUzRRSGFBR2hQZFB5QW1oMzNlR2hXb2daMUZOSjhydlRL?=
 =?utf-8?B?YWxLVnZ5RTA0aVVVVEwzOCtSZkUvM0hBZHhyUVBsZVRSbnBQZGJQbld3MlBp?=
 =?utf-8?B?SjhMd3ZlczI3SEg2Y1FLRjN3Q2tONmFUYi9lVTZkQkRKeHgwTGhFb2RUU2Y4?=
 =?utf-8?B?aHZncXYrSVc5VmNxMWV3ZEFNWVZOOHQzU2dXR2lUOFFVdmNwbVZvVzIwWS9w?=
 =?utf-8?B?L3ZUN0UyTXYwSXp0YzF4WnNFeVJDZTJsZFlWV1U0NkRqenRLZU5zSFNaaUVo?=
 =?utf-8?B?WmhMNTlkSFRlTG05b1VFR25rQWorUWlGR04xUm1MWS9Na0VvR2NNVGRQbzVp?=
 =?utf-8?B?SlZna3pVcXBURGgzeSt2cW1mL3BsNnZETFBsbTd4bnBHV1RMZlMzRXBXaE9h?=
 =?utf-8?B?QVZzNFIvcVhpeCtZM2x6dEhXY1ZvMlZpczEyY3lFMXFrSzU0OFNuYVFUaksx?=
 =?utf-8?B?OU0rdjlVMjkyMGhiQVZkT201N3UrRU1kemtXK1MyaDNjWnhGQ2krVlUycnM1?=
 =?utf-8?B?ak50VFVoTDJMYmJTb0NyWXFCQkdRTzNVKytDY0Y0M1U5d0lIek9rVUF6dG1k?=
 =?utf-8?B?Umt1Zzk2UHhWSmY5Sno4R0h3aUZINnFjUFFDWWV5YVNQbzRQUUpTMFVsWHBS?=
 =?utf-8?B?V29ncS9uZWNRZHBVU1F5bkJtNzJzdFlrWFZBVlRiY3Z2aFhGS0p3V2oxSktp?=
 =?utf-8?B?Z1RBbGZVRGVuOWY1VmFQd1VLOWZZRStiN3QzVVk4dHdFME1QZ1pNMXhEODZl?=
 =?utf-8?B?M1VHeS8yU2pwclNXWWZZZlhyOTdWVS9lMEJKaUsxK2hmK1ZxRnRhN1h0M0VB?=
 =?utf-8?B?aERWMEZIa1JsbVhhdW1ibVhEZmJGWkNOSjIxZC9hditPbllueDJBejdIYUtM?=
 =?utf-8?B?ekNYa29TelJGYjJTa1R1eWZpMS9pVyswZm9rWHIyYksvMVdGQ2FDQ3NSazg5?=
 =?utf-8?B?T1IrVTZndkYzNy8yUWErdTBiS2tzQlV5ZFE0VlVlVkw1S21IdTZQdC9qNHpX?=
 =?utf-8?B?NnI1bHVvYkJyR0xUaHkyNXR2VTd1dHNPRzE0NDNoOVlzb29ISWdTVDZnUEY4?=
 =?utf-8?B?SDMveVdMYU5FSFNmZThZb0MwbVF1RmxqWUhzN3RmL3Z6T1Rzb3hmY1U3c3cy?=
 =?utf-8?B?MWc4K1g5eThBYXB4WldLc0NhZWJXcG5mQXppTVdhQVpjTnFaNGhFeFM0dkZN?=
 =?utf-8?B?OHFMZ2VDUFZDY2RHMzlOcUVxNEpOT2xrUnRqeWpJckN3SzVCY0dGZGJwQmJ0?=
 =?utf-8?B?VkNlME5RL2ZiQjJpVklKNFQvMmxkd1Zpbkk4eXdneHVLdDBMa1czTk9CWmpS?=
 =?utf-8?B?SHlHQW5zQ3pFc1hkUzNuSG45MTNYYUtTU3o4KzE1TUIrT3lvSDRqUGV1MTdy?=
 =?utf-8?B?K0ttMFBRWEozVFRuOWJGbERvSHk2aEtPK1huUUc0Z2dNeit5VjhsazBRcE1x?=
 =?utf-8?B?NTZTMDN1Y2hpNTAvUTZSZU5MbWF6WEVtaGlmbDBjVE9xWkJZUXFDcEV5K2lK?=
 =?utf-8?B?SDFwVSs2ZUpOdnZjcnA0Z25yRWdUNUxYK0JFVS9uZURjcTk2MGpBMmI4Yll1?=
 =?utf-8?B?S2g2cXA1SGVYNlN6cUVzeTdjQnlqc04vQWV1RU5La3JUekpzUndTZXBqVk13?=
 =?utf-8?B?WlQwN1c1YjhDaFFGUGZ4dEF0OVN6Zmd5OWx5VE9wbDJiR1lWcGlYU3lWYUE1?=
 =?utf-8?B?NVUwSnZCWExpZktwa3RhUEdCTmtrVWJoOGlrT1VNOERsMFFaVGlsbWlxVTNE?=
 =?utf-8?B?TXc0SXJTcVN4NEdYVERPUEhuTVVlVkd4cXhsdXUvczFRajd0MWRiY3FVNUJi?=
 =?utf-8?B?dmh5V0lROHp3akxoTERMZFFDWnVOZFRoZVdiUERqWFFtbld3cElDdmtISW8z?=
 =?utf-8?B?aUhYbFhFTTBGU2RJQkRFSnVVYlladlVQK1J6T21oRWdEQ2tFc05YSnBhSGV2?=
 =?utf-8?B?VGRwcW5FeDVRY0lWcG5DS0tYTXVMazNDV1pNdjVPeW9IbEtqWEVzL0R2SFkx?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE0E30BD986C5242BB0900D6C5D74AE4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8SFGrzzTian3EqWoVrf9T+Glklvdjq6me9BGKspXea3/M+8NDXZOIgX9/T+ydGEd+MhvQgJQNd4tCfhzFIaEyqUQeSIw54NpsWvd1E/zh+uBh3/AKCBqp+K3tAGQpGIij/ektoLI57X5bvb5+UIr7XfGE+o6wE6rufp471m1FEwfWEMw5gw+ilFNUPUE7/uu+Q4Yh/Vs7MlfXIRnRQm0l3p0SfIozGhbELjQV7cTp1VnHrcPyMAEeLFr1Y4sW/YFfspVRRPzCl0BOh+UJSm0JOvBZm5vdCwA43xKirbGHx8rchCRDPHWmYLsiSvOpgRPzR+MMoF/cPHX698lwOvnnPM6N+UWez+dkRXBC/8ieEOdapFOPlWTzSXU/Rx+TjmuakVqz2uUuBah9SAhfuNEmKRYbDTPjCHvqINvhzPYWEniSBmXA010r4cwx5URcti9CjmRa3MRX824b44cEJkMjMm1qntU+RMRMqa8ABEDdx4nsTDqqFdbv2Mqhx+9CXQpAG3ZMc7ieo/RhYnb8cAsUerZbLHU7aoKoPipPjdr5WR5Va33zFjjBYyNkf04ZBVzAcKQGYgfVS8UI9pe9r0TdaWArwafUx3YmrhLqpQkAmQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dd43a6-e15f-4d44-6df8-08dbffdac45e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 15:05:26.4967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIjMiC/lqMysj3W7OQaO7qjVAsWGC8fqqn0Cy9oengPrssSPdYxhlOLYoauc4/Y7uBdGEtR6fTpDKn0uPX4sDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=987 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312180110
X-Proofpoint-ORIG-GUID: lQCIiz_kn0NaWTNrN9WNxoq7VZxaE_M3
X-Proofpoint-GUID: lQCIiz_kn0NaWTNrN9WNxoq7VZxaE_M3

DQoNCj4gT24gRGVjIDE4LCAyMDIzLCBhdCA3OjQ44oCvQU0sIEJlbmphbWluIENvZGRpbmd0b24g
PGJjb2RkaW5nQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gMTYgRGVjIDIwMjMsIGF0IDEx
OjM5LCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+IA0KPj4+IE9uIERlYyAxNiwgMjAyMywgYXQg
NjoxMuKAr0FNLCBCZW5qYW1pbiBDb2RkaW5ndG9uIDxiY29kZGluZ0ByZWRoYXQuY29tPiB3cm90
ZToNCj4+PiANCj4+PiBPbiAxNSBEZWMgMjAyMywgYXQgMTY6NDcsIERhaSBOZ28gd3JvdGU6DQo+
Pj4gDQo+Pj4+IElmIHRoZSBjbGllbnQgaW50ZXJmYWNlIGlzIGRvd24sIG9yIHRoZXJlIGlzIGEg
bmV0d29yayBwYXJ0aXRpb24gYmV0d2Vlbg0KPj4+PiB0aGUgY2xpZW50IGFuZCBzZXJ2ZXIsIHRo
YXQgcHJldmVudHMgdGhlIGNhbGxiYWNrIHJlcXVlc3QgdG8gcmVhY2ggdGhlDQo+Pj4+IGNsaWVu
dCBUQ1Agb24gdGhlIHNlcnZlciB3aWxsIGtlZXAgcmUtdHJhbnNtaXR0aW5nIHRoZSBjYWxsYmFj
ayBmb3IgYWJvdXQNCj4+Pj4gfjkgbWludXRlcyBiZWZvcmUgZ2l2aW5nIHVwIGFuZCBjbG9zZXMg
dGhlIGNvbm5lY3Rpb24uDQo+Pj4+IA0KPj4+PiBJZiB0aGUgY29ubmVjdGlvbiBiZXR3ZWVuIHRo
ZSBjbGllbnQgYW5kIHRoZSBzZXJ2ZXIgaXMgcmUtZXN0YWJsaXNoZWQNCj4+Pj4gYmVmb3JlIHRo
ZSBjb25uZWN0aW9uIGlzIGNsb3NlZCBhbmQgYWZ0ZXIgdGhlIGNhbGxiYWNrIHRpbWVkIG91dCAo
OSBzZWNzKQ0KPj4+PiB0aGVuIHRoZSByZS10cmFuc21pdHRlZCBjYWxsYmFjayByZXF1ZXN0IHdp
bGwgYXJyaXZlIGF0IHRoZSBjbGllbnQuIFdoZW4NCj4+Pj4gdGhlIHNlcnZlciByZWNlaXZlcyB0
aGUgcmVwbHkgb2YgdGhlIGNhbGxiYWNrLCByZWNlaXZlX2NiX3JlcGx5IHByaW50cyB0aGUNCj4+
Pj4gIkdvdCB1bnJlY29nbml6ZWQgcmVwbHkuLi4iIG1lc3NhZ2UgaW4gdGhlIHN5c3RlbSBsb2cg
c2luY2UgdGhlIGNhbGxiYWNrDQo+Pj4+IHJlcXVlc3Qgd2FzIGFscmVhZHkgcmVtb3ZlZCBmcm9t
IHRoZSBzZXJ2ZXIgeHBydCdzIHJlY3ZfcXVldWUuDQo+Pj4+IA0KPj4+PiBFdmVuIHRob3VnaCB0
aGlzIHNjZW5hcmlvIGhhcyBubyBlZmZlY3Qgb24gdGhlIHNlcnZlciBvcGVyYXRpb24sIGENCj4+
Pj4gbWFsaWNpb3VzIGNsaWVudCBjYW4gdGFrZSBhZHZhbnRhZ2Ugb2YgdGhpcyBiZWhhdmlvciBh
bmQgc2VuZCB0aG91c2FuZA0KPj4+PiBvZiBjYWxsYmFjayByZXBsaWVzIHdpdGggcmFuZG9tIFhJ
RHMgdG8gZmlsbCB1cCB0aGUgc2VydmVyJ3Mgc3lzdGVtIGxvZy4NCj4+PiANCj4+PiBJIGRvbid0
IHRoaW5rIHRoaXMgaXMgYSBzZXJpb3VzIHJpc2suICBUaGVyZSdzIHBsZW50eSBvZiB0aGluZ3Mg
YSBtYWxpY2lvdXMNCj4+PiBjbGllbnQgY2FuIGRvIGJlc2lkZXMgdHJ5IHRvIGZpbGwgdXAgYSBz
eXN0ZW0gbG9nLg0KPj4gDQo+PiBJdCdzIGEgZ2VuZXJhbCBwb2xpY3kgdG8gcmVtb3ZlIHByaW50
aydzIHRoYXQgY2FuIGJlIHRyaWdnZXJlZCB2aWENCj4+IHRoZSBuZXR3b3JrLiBPbiB0aGUgY2xp
ZW50IHNpZGUgKHhwcnRfbG9va3VwX3Jxc3QpIHdlIGhhdmUgYSBkcHJpbnRrDQo+PiBhbmQgYSB0
cmFjZSBwb2ludC4gVGhlcmUncyBubyB1bmNvbmRpdGlvbmFsIGxvZyBtZXNzYWdlIHRoZXJlLg0K
PiANCj4gT2ssIGZhaXIuDQoNCkZ3aXcsIHRoYXQgcG9saWN5IGlzIHRoZSBwYXJ0aWN1bGFyIHJl
YXNvbiBJIGZhdm9yIGFwcGx5aW5nDQp0aGlzIG9uZS4NCg0KDQo+Pj4gVGhpcyBwYXJ0aWN1bGFy
IHByaW50ayBoYXMgYmVlbiBhbiBleGNlbGxlbnQgaW5kaWNhdG9yIG9mIHRyYW5zcG9ydCBvcg0K
Pj4+IGNsaWVudCBpc3N1ZXMgb3ZlciB0aGUgeWVhcnMuDQo+PiANCj4+IFRoZSBwcm9ibGVtIGlz
IGl0IGNhbiBhbHNvIGJlIHRyaWdnZXJlZCBieSBtYWxpY2lvdXMgYmVoYXZpb3IgYXMgd2VsbA0K
Pj4gYXMgdW5yZWxhdGVkIGlzc3VlcyAobGlrZSBhIG5ldHdvcmsgcGFydGl0aW9uKS4gSXQncyBn
b3QgYSBwcmV0dHkgbG93DQo+PiBzaWduYWwtdG8tbm9pc2UgcmF0aW8gSU1POyBpdCdzIHNvbWV3
aGF0IGFsYXJtaW5nIGFuZCBub24tYWN0aW9uYWJsZQ0KPj4gZm9yIHNlcnZlciBhZG1pbmlzdHJh
dG9ycy4NCj4gDQo+IEkgaGF2ZSBuZXZlciBzZWVuIGEgY2FzZSB3aXRoIGEgbWFsaWNpb3VzIE5G
UyBjbGllbnQsIGFuZCBJJ20gYWxzbyBzdXJlIGlmIEkNCj4gd2VyZSB0byBydW4gYSBtYWxpY2lv
dXMgY2xpZW50IEkgY291bGRuJ3QgdGhpbmsgb2YgYSBiZXR0ZXIgd2F5IG9mIHJhaXNpbmcNCj4g
bXkgaGFuZCB0byBzYXkgc28uDQoNClJpZ2h0LiBNYXliZSB0aGUgcGF0Y2ggZGVzY3JpcHRpb24g
c2hvdWxkIHNheSAibWFsZnVuY3Rpb25pbmcNCm9yIG1hbGljaW91cyBjbGllbnQiIG9yIHNvbWV0
aGluZyBtb3JlIGdlbmVyaWMuDQoNCg0KPiBJJ3ZlIHNlZW4gYSBsb3Qgb2YgbWlzYmVoYXZpbmcg
bWlkZGxlLWJveGVzLCBvciBpbmNvcnJlY3RseSBzZXR1cCBzcGxpdA0KPiByb3V0aW5nLCBvciBt
aWdyYXRlZC1hY3Jvc3MtdGhlLW5ldHdvcmsgY2xpZW50cy4uDQoNCk9LLCB0aGVuLCB0aGVyZSBt
aWdodCBiZSBzb21lIHZhbHVlIHRvIHRoaXMgd2FybmluZyBvdXRzaWRlDQpvZiBjb2RlIGRldmVs
b3BtZW50LiBCdXQgdGhlIGN1cnJlbnQgd2FybmluZyBtZXNzYWdlIG1pZ2h0DQpiZSBiZXR0ZXIg
YXQgZGlyZWN0aW5nIGFkbWluaXN0cmF0b3JzIHRvIGxvb2sgYXQgbmV0d29yaw0KaXNzdWVzIHJh
dGhlciB0aGFuICJoZXkgSSBkb24ndCByZWNvZ25pemUgdGhhdCBYSUQiLg0KDQoNCj4+PiBTZWVp
bmcgaXQgaW4gdGhlIGxvZyBvbiBhIGN1c3RvbWVyIHN5c3RlbXMNCj4+PiBzaGF2ZXMgYSBsb3Qg
b2YgdGltZSBvZmYgYW4gaW5pdGlhbCB0cmlhZ2Ugb2YgYW4gaXNzdWUuICBTZWVpbmcgaXQgaW4g
bXkNCj4+PiB0ZXN0aW5nIGVudmlyb25tZW50IGltbWVkaWF0ZWx5IG5vdGlmaWVzIG1lIG9mIHdo
YXQgbWlnaHQgYmUgYW4gb3RoZXJ3aXNlDQo+Pj4gaGFyZC10by1ub3RpY2UgcHJvYmxlbS4NCj4+
IA0KPj4gQ2FuIHlvdSBnaXZlIHNvbWUgZGV0YWlscz8NCj4gDQo+IEkgZG9uJ3QgaW1tZWRpYXRl
bHkgaGF2ZSBtb3JlIGRldGFpbHMgYXQgaGFuZCBiZXlvbmQgd2hhdCBJJ3ZlIGFscmVhZHkgc2Fp
ZA0KPiAtIHdoZW4gYSBjdXN0b21lciBzYXlzIHRoZXkncmUgc2VlaW5nIHRoaXMgbWVzc2FnZSBh
bmQgTkZTIGlzIHNsb3cgb3INCj4gZmFpbGluZyBpbiBzb21lIHdheSwgaXRzIGEgYmlnIHNob3J0
IGN1dCB0byBmaW5kaW5nIHRoZSBwcm9ibGVtLg0KDQpXZWxsIEknbSBtb3N0bHkgaW50ZXJlc3Rl
ZCBpbiB1bmRlcnN0YW5kaW5nIHdoeSBhbmQgd2hhdCBraW5kDQpvZiBwcm9ibGVtcyB5b3UgZmlu
ZCB0aGlzIHdheS4uLiBpdCBjb3VsZCBtZWFuIHdlIGNvdWxkIHJlcGxhY2UNCnRoaXMgd2Fybmlu
ZyB3aXRoIHNvbWV0aGluZyBhcyBnb29kLCBvciB3ZSBjb3VsZCBmaW5kIGFuZCBmaXgNCmEgY2xh
c3Mgb2YgcHJvYmxlbXMgaWYgeW91IHNlZSBhIGNvbW1vbiBlbGVtZW50IGFtb25nIGlzc3Vlcw0K
cmVwb3J0ZWQgaW4gdGhpcyB3YXkuDQoNCkkgd2Fzbid0IHJlYWxseSBnb2luZyBmb3IgInB1dCB1
cCBvciBzaHV0IHVwIiwgbW9yZSBsaWtlICJob3cNCmNhbiB3ZSBpbXByb3ZlIGJhY2tjaGFubmVs
IG9ic2VydmFiaWxpdHkgd2l0aG91dCBibGF0aGVyaW5nDQphbGwgb3ZlciB0aGUga2VybmVsIGxv
Zz8iDQoNCg0KPj4gSXQgd291bGQgYmUgT0sgd2l0aCBtZSB0byByZXBsYWNlIHRoZSB1bmNvbmRp
dGlvbmFsIHdhcm5pbmcgd2l0aCBhDQo+PiB0cmFjZSBwb2ludC4NCj4gDQo+IE9mIGNvdXJzZSwg
YnV0IHRoYXQgdHJhY2Vwb2ludCB3b3VsZCBoYXZlIHRvIGJlIGVuYWJsZWQgaW4gb3JkZXIgdG8g
c2VlIHRoYXQNCj4gYSBzaWduaWZpY2FudCBkaXNydXB0aW9uIGluIHRoZSBjbGllbnQtc2VydmVy
IGNvbnZlcnNhdGlvbiB3YXMgb2NjdXJyaW5nLg0KDQpBIGNvdW50ZXIgbWlnaHQgd29yayAtLSB0
aGF0J3MgYWx3YXlzIG9uLiBJIGNhbid0IHNlZSB0aGF0IHRoZQ0KcGFydGljdWxhciBYSURzIHJl
cG9ydGVkIGJ5IHRoaXMgd2FybmluZyBhcmUgdXNlZnVsLg0KDQpJZiB5b3UgaGF2ZSBvbmUgb3Ig
dHdvIGJ1Z3MgdGhhdCBhcmUgcHVibGljIEkgY291bGQgbG9vayBhdCwNCkkgd291bGQgYmUgcmVh
bGx5IGludGVyZXN0ZWQgaW4gd2hhdCB5b3UgZmluZCB3aXRoIHRoaXMgZmFpbHVyZQ0KbW9kZS4N
Cg0KDQo+IFRoYXQncyBhbGwgSSBoYXZlIGZvciB0aGlzIHBhdGNoIC0tIGp1c3QgZ2l2aW5nIHNv
bWUgZmVlZGJhY2suDQoNClRoYW5rcywgYXBwcmVjaWF0ZWQhDQoNCg0KLS0NCkNodWNrIExldmVy
DQoNCg0K

