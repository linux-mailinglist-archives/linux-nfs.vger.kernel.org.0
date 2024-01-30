Return-Path: <linux-nfs+bounces-1598-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D7B8424AA
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 13:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C519285C9C
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 12:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C2A67E69;
	Tue, 30 Jan 2024 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="bTyuB5dL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D38A67E66
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jan 2024 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706617146; cv=fail; b=DSyQE1vnTYOV7lASEBT2LUWfc1/i3RByFOoA9rkFjyNUuRyD1dypWVMT1Of3BxhOrePYjl2s+o/FiIoQpokUGjm/OAuXGhbA7JivNXYtMTw+jyOg+dNXxPU8MWewNEdEN+FPMjtUl4TwAW7Zqmhj8zkTObXrIJh7buG/uR9edAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706617146; c=relaxed/simple;
	bh=jvH7EzFXdBLgCMiY7wPDZK2LXhbv7UlgnJ6etwUOffM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MyXd6gNp4kLlb1LNgLqAkUXe52P42VCjScISetf+mtFFsJBKkD7g6gblPzcyEPqMlXnH7AOG3sX/8+Ty8TCeb8SKOhuJZskyeEVQ/LsDuIyjU2+qUk7TjAD1Wan+gYzbD7JRX03Do9JZCgzUNz00CeSzYd650f+H5bBLeBPHL4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=bTyuB5dL; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1706617143; x=1738153143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jvH7EzFXdBLgCMiY7wPDZK2LXhbv7UlgnJ6etwUOffM=;
  b=bTyuB5dLzY709CrXrgPHC/NGcMg4CtlzRfBSbN7r2rI81Ev+W1hm861m
   LAeITwg9ARD8BrQ7hFYlxS/pe/U3Cc3Bm9/77q2flC17jHp2x971W0pVT
   KPU487y8EZ5zFQax3ltzBmwUXJE8j8Fpr0ojPA6HGMaOv5MuwXkggSADI
   MubrwNiOC99xQdGPjWsGeijHhODiFNth/IO5yjTdc3Rbf4dNzbRDvWtAY
   q0m7qxVRmoTJucRq+U/RVdEj0w4FQKxS4B1aeZnvWsYRp0a3aGbkOGJ54
   UpDQYqYiVXjuS3PNUj0pZwL+rAi5pq1sWwSMOHMJAIJRl7C12Tcxk3dJt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="109654632"
X-IronPort-AV: E=Sophos;i="6.05,707,1701097200"; 
   d="scan'208";a="109654632"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 21:17:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bo5ofpiUAZkWDg+klfY/b/A5ylXC9BlXBXEEIbT9OxLj4F3EFEVhAIQzZUQZKHqB6isrQtD318gTji/sSvyfpSnMQMdUAT/LdIZiuDsmcFhAjhG/HUvSLzsdH60IKhIDgb2bDVaI/G4p084zKzXg8U7m8ndWzSqXkm/Ozd7fELopg26Sq9+P3g6oVHi4CQu5pmXgn/Ljl8bd/BDXMHwFXRPmX3lM8GOro5LtIsEAP+xOdV1yY+K0UQeq1NON4szr/3WFDZX/1bETBkkVm3ZFKa3OGgYvUtO3pPXvMJurbOTim0BR9TUk9JRtVKRKXgac5i2O4MvuDKzn45g+bJna6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvH7EzFXdBLgCMiY7wPDZK2LXhbv7UlgnJ6etwUOffM=;
 b=YlmuE2fxJvAzQiCywvQhQtVITrM6dUqe4oc4pt6R8O3pTb/khxGM8LYpf1KmidW5fFe0E9aY72u2XoxwV4ArieJnN/YklJMqeApcWX9sGsH5ib18mjRsqeYljJKBqZOt3QfT3TtDg5TedhiHm5lHWu0cZSrlSEO8tk5zSRFMX0poO29h36eDWMFEImxOTJu4JXwuabrehmqhgWnTkjMXrSxlTJzFs3JPb6W3JWo85KdYylWSHexlkuz9YrMJ54nJr3+zLXTHpuxMu5HBql0NPAG5B7PDyQ/h1x4D8b/iGBjyUqqsxc+L/3leE/5/vpn1YG5dPDQcXW3KdqedIKqJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by OS7PR01MB12083.jpnprd01.prod.outlook.com (2603:1096:604:262::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Tue, 30 Jan
 2024 12:17:46 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::fdb2:f9ea:e915:36ce]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::fdb2:f9ea:e915:36ce%5]) with mapi id 15.20.7249.017; Tue, 30 Jan 2024
 12:17:46 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker
	<anna@kernel.org>
CC: Jeff Layton <jlayton@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: fix regression in handling of fsc= option in NFSv4
Thread-Topic: [PATCH] nfs: fix regression in handling of fsc= option in NFSv4
Thread-Index: AQHaTtTbByyxSQeqJkmkCP1P+n/7GLDyTv9A
Date: Tue, 30 Jan 2024 12:17:46 +0000
Message-ID:
 <TYWPR01MB12085B5565010EE4B5E9D7BF1E67D2@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <20240124143755.2184-1-chenhx.fnst@fujitsu.com>
In-Reply-To: <20240124143755.2184-1-chenhx.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=19502722-1267-4154-9cab-1769301dfd53;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-01-30T12:15:18Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|OS7PR01MB12083:EE_
x-ms-office365-filtering-correlation-id: 18bcee0b-228c-4702-6503-08dc218d780e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 swGWnUiaq/iopBVsFWcghvjxfCJ+HtoGIQhTUeRfkwVnRA5GRH5imALUko2ttPMV0rtBVhZw8Uo7wY6MYCO2PgL2AxlGEkvGMMZtPd7UDmoNhcf5tD99wrlogAUNFUGkc6tTj0O34kUZaYdZs43hHROZ1JZV7ppD8M5s2zleOoiuPs7dWedxqElWsg6JWyUYoA6CvfpoqldJHbbFWVN+MC/BVGVrhXT4VEWY0aqycEe9C+aqCNrUcb5NYyjxeZ/k2pZDtgpLGHFlJIn7IiTUnX2xLIdmYPy8r3xAPwX11VMNFYeIwsEmgIRaEGn2W8Cb812q4KLb4lST23Vg70juFiiMi4Zqi8ZSBF0rerBp8IXRwWF6kHPSaXHmVcN8n6olCGukhSsOwkJy+YBN2qsb5cLRI0t5I5PEBaVc9YKfgZ8ZHxQ33Uyam/7O8JAPfxhJObEfo0+AVgRY6Hw1u6MK/DLgVmfxl9ybIfaar6WlbmDJHBhl7H6tl1sLsmr/K0IIg8E5vf+MtWqiDHgnxUthAz1Rx2kY5EDsoNjwwx2YN88kYN51YRzzvJzoekLwgkzPec7FtiqVHMaPXh3shIgh25evGkr8hpBHMipZFXq4FpLdRLoTosa/ZZzgGzfIfHwIs6b1cpMWB6pMJ4efnMsvJw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(1590799021)(1800799012)(186009)(451199024)(64100799003)(26005)(41300700001)(55016003)(38070700009)(316002)(54906003)(64756008)(85182001)(66446008)(66476007)(478600001)(9686003)(7696005)(6506007)(71200400001)(38100700002)(82960400001)(122000001)(66556008)(1580799018)(33656002)(5660300002)(4744005)(2906002)(86362001)(66946007)(76116006)(110136005)(8936002)(4326008)(8676002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MkZBNHNuYUFzTWRRVTY5MFprbnYwblNMSUEyb01ncjZONk5uVk8vWU1UMWtF?=
 =?gb2312?B?eWlIYXN0c2NCaWMvcWdyUytUam9RNmU0T0E5LzBicTVFNkxuWXNmWEQrQm9w?=
 =?gb2312?B?d1FRUDVoM1ZDZGp4S3djY3N3cXJTUkJoM0xkME84NkduZTB1WVltd1BJWnVu?=
 =?gb2312?B?b3NHL2VqczhtRGhVS3Y5ZVJyWlV6b3FkQmUrbGtLMUk5QWlQS2kxWllHTFE3?=
 =?gb2312?B?Q2hLY1RlUUZDSHg1bE9Ba3FBNWQ3bE95SU0wTDVlemVtSGdpb2d5VHFoazFv?=
 =?gb2312?B?TDJORDdMWjFQVnJHWi9aRWxZdkp6OVdEL1E0Z1JvNVdPRkhHQ3Y0TnFDQWEx?=
 =?gb2312?B?eGltWUZmWm5wT3JhY2FuMlB5UHBRWC9YVi9GeWZHbjN4d3JjaURQUzVGK0gz?=
 =?gb2312?B?WkRORW9sSWdudFhmUTNqWlkxbEduaklvMm9FYmxsamhxWUQweDBJMzBkYnA2?=
 =?gb2312?B?N0lEQjJIem90am05Y2F0d2tPclAwbHVKNnI5ZG9rVUN5MFAxNzgzMFdJcGNU?=
 =?gb2312?B?ZmpBbHJBZjJPQVJoalFEY1VXYlNuMHNNcUlINjJ2KytzUld0VDh3N05OczA5?=
 =?gb2312?B?ZEgvZC9TcHQxQ29rRTZISHZaSkV5RC9VZ3JWUnVnQlhkNmVNYkFmSzZFalpR?=
 =?gb2312?B?cG5NR3R5cHR0WjZMcjAxdVhZNzl1VU1EUzh3VGhjdWY1U0tSUUljRlpXQU4w?=
 =?gb2312?B?TlMzVUg0VThONEhHTmNzV2RoTGdCZDJIMEM2Z2hudllhVlpudUMrVVhKOTRJ?=
 =?gb2312?B?TWxnSmMzSVJ1MENaSjhUcTZCSndhV05YQWs1bldVb0dpRWtWeVdYc1FHbUhs?=
 =?gb2312?B?SEhJV0t4VmJERlIwUSszTzBmYm0rTXBQQUJCc3JjREQwMkZYSnQ3VU9IYytq?=
 =?gb2312?B?ZW5CelVMQTVZeGhmazQ4RGNSTjBONnpBQUVoWWc3V3lwMndBT3dTd2ZlM0dh?=
 =?gb2312?B?QnRVUkdwTjVkcXJtYy9iclFueUxzYjI2VUdkNGdZYitEM1BEMzJ6WGhGaWlz?=
 =?gb2312?B?M0tLM1RBYXpBcERLVmJnd05tMUg5cmpPZFhRTzg3K3lPeHRtamhWWnJlUzF0?=
 =?gb2312?B?a2VGb3lhV1ZIM3NsYXdxOGFYTzdpZWJOeUd4N1c5WlhKM1Q4UzIzcmh1MHZw?=
 =?gb2312?B?c2ZINnZmN1g0QVRnZ1ZsdWNMSFk4WjhXUlFKUWgrUkw5Wk5LZWVUY0grNTZT?=
 =?gb2312?B?c2FrRHhob3FwZ3VxREY2VUxOcUI4eTRrNHVCRDJOM2M2TWdoWjJlbitFTzFF?=
 =?gb2312?B?Y2dDQndKWk42Um9Sd3N3aTRkWWM5SnM2SmhpRU03K0hmVkJ1Z1RtblBNaHZY?=
 =?gb2312?B?TVVLRjg0cHptd0xxL0pjaE1BVnJHdWk2ZmJCYncreS8vd0FUWlo2YWlWVTVD?=
 =?gb2312?B?c0VPZi9NSFRrSmYwTHN4TFZOODJnMmNDYlRVWG4yTnJZaEZPbUM4b29ETkY0?=
 =?gb2312?B?OXY0MTdndWFlTEFpakRNYVpKdHYrRm5XL3d3Y3YwcHI1TW1JODF3Umk3Kysv?=
 =?gb2312?B?M1B2cnYybHdLOUZ2UUErSFJOOVJtV0NGSGM5NUlFZFQ2VDJkd2hqZkg4NVlv?=
 =?gb2312?B?OVNpMkpkK2NIcitHNGU1Ti81V1BXOGp6WXRlU3pOUUZ2RFNEcWkxOUIvNGVn?=
 =?gb2312?B?aVBxTExaMm9XNVJZUDFTWWJIc1Voai9MTE9id3kxTGQ4SURSUTFJdzBpSUth?=
 =?gb2312?B?ekNpVVZOQWZzcVRRZkFKcW5sZ2RKVmJFeDJ0NjlFSTgxT3VrOXdkZWloSkFF?=
 =?gb2312?B?MnFJMm16bEZrTmZyZlFIdkpabjlucFRSaEtaVTNIZ1JpMktYRmowZ1JNZDZv?=
 =?gb2312?B?WkpFM3JQaDNCMTlGeWk4bGhxbm81TUs5ZWJpV0ZJTkhmdmt2d0xneE9MMUVE?=
 =?gb2312?B?OGVyQzZHWWFqSHVUNjRwM2I1RUkyNDZFbmQ5VWJWd1E4WTh6VzE4ZGdUdDc3?=
 =?gb2312?B?akpqWmNjOGxHYkJNZnUwU2lCcjF4TkNvT3FvRXFaTWtUdURFV3FidllwZURB?=
 =?gb2312?B?ZjB6TnFpaE1jb1duQ2QyaVJRR2VRTzUvZ0xDVlMvSjliRnN3R3grRFB3Wk9W?=
 =?gb2312?B?cG16R2QwWXppUHg2WmNrTldxNG5OdW9LN3lLU1pVdnhXNHVxblpXTkczTjht?=
 =?gb2312?Q?yDBMz3m1pmcyzyZrNsQuvo3rt?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rhdPCE6LAh0MRkshwk9I2Ck6YxwwztqF9QB9xPkfNpy6fGOTfbW8m7C3/soA8Nu1XYltt/EhhaIGOL0xdDq3WUQphzDPoEleglrXCFfhXkrC+K54sG++ry/O1iWKl6Xio23ijyWk+LzEk1po9aiyuLFh04mjxGzza+otJPkbw4lq+EyDrO9pKzcGJvkR9fNdTUo58H3+hvCveMTbpUe+xabbZD26ta8sP4Y5ooIYTcsVVu1x71PCJnrRjgNG/qBzen6iC8fhrOKaOvxPv8qQGQ7FHds0x9KrWKqtwoDulsh199sGaBpXt3Mo1U2HG16iGpYXVt8Q8+eGM3k7wGJPXshoKl5+Y3ny9dzlTZtSh5CaGTCCGFER8/7R9ByTAuACQyoe24M43czFGxZeNU5c6smtuySa5WBL2HRNH3jTT2lCuHzlpkto/chbRw8OU47yzJynI8mSs2DPPRGTKC5b/nWgVYt90hLVOeDyTGmYZOdi5t2yFGE5nUj4J+6uEnggqMgCClWsW15rFMSrlRCklx3+MJnxZCgOVx3n/nLoRPdAEIU0hqlMsG3R9GySY2AV4dynhLFYY0EA7gw2zQE627qBZhpOIFVkDGwemwkoWlgVMYtLV4BNz55LfHcKv1Pm
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bcee0b-228c-4702-6503-08dc218d780e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 12:17:46.7932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WoSS8/GkMFsdVqB7GvbofaxXBx6xeyzyScgJ4ClqHHoN6IzJLQYtUtt2S9oclo2lalnsT3y4VnFt+ll4tfhEWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12083

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogQ2hlbiBIYW54aWFvIDxjaGVuaHgu
Zm5zdEBmdWppdHN1LmNvbT4NCj4gt6LLzcqxvOQ6IDIwMjTE6jHUwjI0yNUgMjI6MzgNCj4gytW8
/sjLOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+OyBB
bm5hDQo+IFNjaHVtYWtlciA8YW5uYUBrZXJuZWwub3JnPg0KPiCzrcvNOiBKZWZmIExheXRvbiA8
amxheXRvbkBrZXJuZWwub3JnPjsgbGludXgtbmZzQHZnZXIua2VybmVsLm9yZw0KPiDW98ziOiBb
UEFUQ0hdIG5mczogZml4IHJlZ3Jlc3Npb24gaW4gaGFuZGxpbmcgb2YgZnNjPSBvcHRpb24gaW4g
TkZTdjQNCj4gDQo+IFNldHRpbmcgdGhlIHVuaXF1aWZpZXIgZm9yIGZzY2FjaGUgdmlhIHRoZSBm
c2M9IG1vdW50DQo+IG9wdGlvbiBpcyBjdXJyZW50bHkgYnJva2VuIGluIE5GU3Y0Lg0KPiANCj4g
Rml4IHRoaXMgYnkgcGFzc2luZyBmc2NhY2hlX3VuaXEgdG8gcm9vdF9mYyBpZiBwb3NzaWJsZS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoZW4gSGFueGlhbyA8Y2hlbmh4LmZuc3RAZnVqaXRzdS5j
b20+DQo+IC0tLQ0KPiAgZnMvbmZzL25mczRzdXBlci5jIHwgMjQgKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQ0KPiANCg0KDQpQaW5n
Pw0KDQpSZWdhcmRzLA0KLSBDaGVuDQoNCg==

