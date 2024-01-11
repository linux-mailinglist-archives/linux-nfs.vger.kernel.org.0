Return-Path: <linux-nfs+bounces-1027-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0A382A6B4
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 04:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1611F250AA
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 03:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC029EC0;
	Thu, 11 Jan 2024 03:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="s3Fytmt7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6288CED2;
	Thu, 11 Jan 2024 03:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1704945330; x=1736481330;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LkTj1GCBVKp7yB37QhbX1djS0JFLpOqxpyr4Rfj6JLk=;
  b=s3Fytmt7CbRLFh8w9GYgSKsHc5+13VDmANjyOfh7KJxKcB4SuKdUgNKE
   nchzQytTZQ4A/ag0SbdxDiGUjw/T0kn8f0BjXe+C1F/HqIF7/FWh0q+Go
   JIZN2mZXx20gl2H6oK0577itkLtXD/R2B9QcYmZWjMpMxH91Noycg9lTu
   m6SfJklSyNd353M7UnyhbRbAPfjIkbKnQMxwm8paPKIq7Fw5CTC6MhpeG
   BHXEAO7XNGfG4wjAqfr7h0x6hA9bRseeIR4kN3zziaRP7I8dTVxKBJfY1
   N7WSr8ZhkyqR2QH1KPWeOCp1yNDx62KpWpVYx2nDC5HA+aPXsNp7Wa7TV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="108019377"
X-IronPort-AV: E=Sophos;i="6.04,185,1695654000"; 
   d="scan'208";a="108019377"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 12:54:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brMCjqpAwhOlK2fuU6HLAaizLQheGnIHdTAvGQgFJ9ZBJ7N94r1zM9iaduuZTaAVof1KyFYDt2gMrZ0jpLUDkfgAv0yskqs9wb5XYaRtiAT6O2ksoDPEOv16k5lfzXSJXLxkRYHt72M+aPFscEmZe/yTQvHUecWk2Np5OsjPYKtl2es2bp71CZUMaaM2ab2qgAgmdigODak8ChM9rDwMFMRXGnRf2/WbSLrBOVQ3AlV1KvYoUB7K/iFmswsuQgIwwpUBa6iD8gy51E5CSN/ncBtFqsEb87vSJBDASwFUZeEi80HPuDgZHw2P5zRVNXB+wU2cAAJfFEhiu2rDLwDgIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkTj1GCBVKp7yB37QhbX1djS0JFLpOqxpyr4Rfj6JLk=;
 b=ImFuuQ2SQ6VodhbYcZm0V6uDRNvfNciM48UXrvwyJYxewi5wuMtZRZB6y/rCp9m1EVZ8WSq/yV2sYwf3AhdL2g6kNRlyVXE1lvtNK8EB0f5k+2SgHcBMhCq/3v1fNkM6YpgM6aZ4X5X3AWlVpDVEo1J2qldNkVN/XFFkUZO1/CPwtcXx2AA1kQDZRMM5kdoO8nkZ23+b7r8k894TcGIRfdLkLKaQsvwb4O24S9l0I6teyGLJNF2lMugmhlhrSpOT5eQHEKdtvaZAXPJ25wyvl0bWkVpbDRGiKFkH0+Qscah7V8XIY5NPoCg5YDnm37TiXlfPsYligFbUWRlrqeLabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by OS3PR01MB9947.jpnprd01.prod.outlook.com (2603:1096:604:1e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 03:54:12 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::6f98:dea4:77ac:1184]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::6f98:dea4:77ac:1184%4]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 03:54:12 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trondmy@hammerspace.com>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>
CC: "anna@kernel.org" <anna@kernel.org>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBmc3Rlc3RzIGdlbmVyaWMvNDY1IGZhaWx1cmVzIG9uIE5GUw==?=
Thread-Topic: fstests generic/465 failures on NFS
Thread-Index: AQHaQ9GtXms5WPAcbku71FJeyWIgibDTThAAgACo9/A=
Date: Thu, 11 Jan 2024 03:54:12 +0000
Message-ID:
 <TYWPR01MB120850DD18DC03A9D56321073E6682@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <2f7f6d4490ac08013ef78481ff5c7840f41b1bb4.camel@kernel.org>
 <f5f673da8b03413a9087f7a71ae73a66065ef384.camel@hammerspace.com>
In-Reply-To: <f5f673da8b03413a9087f7a71ae73a66065ef384.camel@hammerspace.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9NzAxMGYyMjUtMDRhNi00NDMwLWFmZWYtNzUzOGJlZTgw?=
 =?utf-8?B?ZTc3O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTAxLTExVDAzOjM2OjM0WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|OS3PR01MB9947:EE_
x-ms-office365-filtering-correlation-id: 8ce914a6-3ffe-4f35-247a-08dc1258f938
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ILOfVn0MyMvTFYmgCcz32i6o+eoHvlH4KDSrrfVOwGnfDMM7NiwNLdzgBspu6HTplFdHJH6eQQcaM9CrI9dSZ4ZLE58UfWYVUdawU57y6ecWvbxAG8bBZW24ULZik5mhoLY7VEP4TOrtZq8TOf2Va0hexspSwmmHf3yTs4F9a/LJTKuIl24gxvAKpXEbQb4rzzznI61XF1YqpIUtuetwgjvJW0LJ6DwmR+OG7LK2OYo8ciFykHzI/Su7TWa3oVKWvjkYIy6t2IT9rjARGw4MIrx9jqDk776nj0sU8GnJEJpihjIN36TkQzex2lmrHuorc1dbyw3XjSSXWvOylHFyNwr7PDI1tre180clahfHpGDYY82C7VqNBvr/pqzrLmC/+LoxpUt3m5XczglF7ohZxD2dPB8kwLN76OZXVDFVnYnl+geTteJl3781kK91wvk7RjRqkRJfh2bQmwmFJAT6nUscdZ/6gfHDlZVgPkaqFgLQoJkDvEQzJU9TVyLvIxc6o/2cqRoFUo2fpHei4ZW4qYeOUopXAcol9h9L9IVhFYM0fd7eei3+sxtcZ1IwU8V1W3oU79R+L0W73mngzP87HV2QEfVcCETeLyI7u7d8VcatqwmFAiOp/MOhFGL3jsgMQSU7y7ctL+LLURiEetntMRSquYI2CdPQHpfXv0CGmQw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(1590799021)(64100799003)(186009)(451199024)(1800799012)(5660300002)(66946007)(2906002)(122000001)(41300700001)(38100700002)(82960400001)(224303003)(33656002)(86362001)(85182001)(7696005)(6506007)(9686003)(478600001)(26005)(71200400001)(83380400001)(4326008)(52536014)(66446008)(66476007)(54906003)(110136005)(66556008)(76116006)(316002)(64756008)(8936002)(38070700009)(1580799018)(55016003)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzdHc0xINFh6ZkludTBPcXVodlNEM0E4UW1UQVFzUlc5ZzJCNTFpeWV0SWZl?=
 =?utf-8?B?dmNHOFN0SFVOSjEyazBBZXRDWlQ4ZmJVRVNNaGhkZDNJaTdnbncrOG1Balln?=
 =?utf-8?B?ZVBvSGtTM0Y3ZTlEMG9sdlZHS1A4QVhCaW10ZjE1WFRvekFVemRSOU5Ua1Fh?=
 =?utf-8?B?aXdyanJaRy9ZdnlGTVplNnhUSmwvK0lPT05FMkRPU2FsUGxhTlNMSVczN3FH?=
 =?utf-8?B?Q2VEV0U3SmdJTGVHZkJuSHkvT29mbEhmYlp5UU9yUkU4WTVheDl2TXlpTXlw?=
 =?utf-8?B?c0N3bU53ZTAxS1YyR2tpMUpyOW1iYlNydEpyd3I3TkM3RmpMek1VZlVhS2F2?=
 =?utf-8?B?TzVXRlhUZ01qYU1DZENkMlVwWnZKblVpR2wrTDBsQ3U4aFJkdUV0c25aVnpD?=
 =?utf-8?B?QjFNcUY2Vng4d1RxWEFGbG40MU1sMmVhelE4WmU5QkJSTGdIRld3NkdLdlRP?=
 =?utf-8?B?aDYyblhtK044d3pwZFJZQTd4V2I2NXV0aXRMUW9kNGpaTThuaTEvSmc4WUdx?=
 =?utf-8?B?b1lYQkI5cHAvY20zb1lOcWVSMFZnemQ0OXRKd2N2cUlyNVgrZ1hPMTRoZ3da?=
 =?utf-8?B?cXROOXd1WGNyL0V1U0xCeUxQZzFwM3QzOGx4a2trS2JHOW9hcEt2eHZWRjRs?=
 =?utf-8?B?THVxMkh0WlhxTlNrZjN2UnhndkhnNzlwNkZBeHdJcDZnMmQzc01keWxJQ1hu?=
 =?utf-8?B?YWdna3NpTWdyUk1ISnJmeGlQVmV4eTBLUVBhVDNzM3ZVaE9US0tyK1JqN3dm?=
 =?utf-8?B?Nnl1ZlVmbHkrSmo2YWhpblF1bmNYSmRwTEgxbXJRQzZNdGU5M29WVjZ0ZkVN?=
 =?utf-8?B?bUE4WXFRUWUvd1AvUmVGcmp5aXBRbUhzVlBjaWl2cU90Zm9hS0FycW5NQXhl?=
 =?utf-8?B?SForWktuUS9SV1lqdGUxRHk5UlRVQ2FqZzFCY0RqTGFEdDA5Q3NDMFlqcEl0?=
 =?utf-8?B?RU0zaVNRZ3d5VVp1bTVRY2NhL1B6Ty9zWUNNZXFKRDV4MkttM09Pc0tVdnQ5?=
 =?utf-8?B?UzBnNFdxMkZBd3ZPUzJ5UXl3dDczbVhUMC93Q3Rab2ZxdmIyT3FTWHIzMDZD?=
 =?utf-8?B?cGViWkd0Mk5yVHpRQW5rWXNwVU9ZeTBPejU0azdkUWUyaCsyZTg4MUxtRVRS?=
 =?utf-8?B?bWsycHB2SkpwNWFraE5aSURDaEJXL3A4UVZSNnVpZlVHejZ1Qlk1am55c0kr?=
 =?utf-8?B?UisxRjU2RG55cndnbUxCQjdOcTVvamtIaTI2NVdiclI3WmgzeEw5VGhRQUdH?=
 =?utf-8?B?ZldCYTJXNmxraXdOWk12L2IzNjdLWktFUkxkc3EyYzBTR3FJMzhGUG1FdkFk?=
 =?utf-8?B?M0NDSGRST21kTGNRbXZyWi80elRnUlJ3L0Z3WXNBcnZld3ZudzMzeHVoeHZn?=
 =?utf-8?B?d2dQUUpuZVZkaWdaQ3YvNFZRSi9Ma2ZmQ1dPRmNqdnJhdFNRRlpBN1ZPbTlS?=
 =?utf-8?B?aExubnk1cEJacmVpYk13aEo4UGNsQlFZdVpwaDRJT3lzdzc2SVVnQXBuQ05s?=
 =?utf-8?B?YjNOSVdGNkV6TjBGUlNObHRqT0l0TVNuLzFXYnZ1YStsV3lJK1B0NDJLaTlR?=
 =?utf-8?B?Rm1xc1ZFeHFsL01xdUJLN2wvc0FWQ0FMbDlYOEVHcVdNeDUzVHFQeUtuVnNy?=
 =?utf-8?B?bCtYbmJkcFJzSlJkMWt4Tjc5d2JNYnljUzZMdkxhdW50MXY5R3VZTDc5cGZk?=
 =?utf-8?B?TktVc1d4cFRvTXVNZkQ1cmdQU1N6UHZzWGlJMm1XOXBHTDJTRHNNVjRGcDE3?=
 =?utf-8?B?RlptbUgrT3NQaGVIOWFiUUNiU2FzR2kvWnU5eXZEWVR0dW1jcE9mZFlTeWR0?=
 =?utf-8?B?TjFnamRkbys5MWtVVW9Sd2xEY3N2bVYvYVJIdjVVbDhmU3FKU1lXQmJjQXNw?=
 =?utf-8?B?UFFWVXdvdDcwTlNuQS9YRTFKZVV3NDYwV3JNdjhBN2xiSDJ4blcwNFViZkJz?=
 =?utf-8?B?VHkyZndtNmFJWGthb2RhVGhINzJ3K3R2NFRTaUczbXhCYU8wRWZ2WEdTS1dY?=
 =?utf-8?B?VWY4YTV4aDAwekNOQ2RPSElWTHdyTDdzaU1pUE1hK21veFFjekxld056NUZs?=
 =?utf-8?B?d2hZL1p1TXR1Y0FzMEE5cVUrZDdJRjBScmhwZEgrcDJkV1VNQ00wcDBLMys0?=
 =?utf-8?Q?BPUNzYiFlS0iB3ayuniYi6WOK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZNKy9vUPIHjDtdgjdxz6ztJzbatQESV+nOuvOSIwP7gm7MXnw7PC/Cp1fnZcMcUcGIZlT1DxBYG0DsZ93H4eEPa4fxkRRSiT+7bf1n0F2HvLFtKuf/1aIul9USs/gd20+RUlQrHoyolY/xQo8uHLguLLcktDDKXLdodTspv8QikdDLBC+7P/UmciW+GV36Rej4GMtYu0c7otGjGN6/DXAQ+iWH2vhq2mgIONQ5INU8lZPy4r+zey9mgZI+CY8v/wAUbaOa2d/+u4F29QTyXhyKQGe2g8uVMmPQAF7gieoqZK8lGZF9q2XNzskOJAkbqH9pwV5FF86Mr+IIB5+GBTbLB4Pw+83pflUChLTmGi81bTlpM9U5birxctZFrQpEsOwkWnMyHhVTc+gkAQsfiUbGv2ZYjgcp8ErM0/fWZVhZBouKLHzK77u+cjv8BhhfFLAZD2RYZyCxUjk/0nyqe4CrO+7hO2WXUvtL6y1bcn86CmcS45PwExs6rpfA+CSKDrkflaMqpE5EOouBC0VI9WqFoFzjI2yR0JQ3JxbrZpmxiIZN61yADb6ghUTUO1Nfj2uK61HjNrNPoqvFodZqFbe1Y3T13KSlYF576L8jAQww42hyIE2bLZgyafgj9V/NLW
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce914a6-3ffe-4f35-247a-08dc1258f938
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 03:54:12.7302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +01vbBjdEU9xvXsOzAq5rbXN6WuySHxbzTQrJBmaMuAch6FCssKgLIzr8fSFWqYnXNSfwhsJI7IdCIs9F9cC+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9947

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IFRyb25kIE15a2xlYnVz
dCA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+DQo+IOWPkemAgeaXtumXtDogMjAyNOW5tDHmnIgx
MeaXpSAxOjMyDQo+IOaUtuS7tuS6ujogZnN0ZXN0c0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW5m
c0B2Z2VyLmtlcm5lbC5vcmc7IGpsYXl0b25Aa2VybmVsLm9yZw0KPiDmioTpgIE6IGFubmFAa2Vy
bmVsLm9yZzsgY2h1Y2subGV2ZXJAb3JhY2xlLmNvbQ0KPiDkuLvpopg6IFJlOiBmc3Rlc3RzIGdl
bmVyaWMvNDY1IGZhaWx1cmVzIG9uIE5GUw0KPiANCj4gT24gV2VkLCAyMDI0LTAxLTEwIGF0IDA5
OjMwIC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCi4uLg0KPiA+DQo+ID4gSXQgbG9va3MgbGlr
ZSB0aGUgRElPIHdyaXRlcyBnb3QgcmVvcmRlcmVkIGhlcmUgc28gdGhlIHNpemUgb2YgdGhlDQo+
ID4gZmlsZSBwcm9iYWJseSBpbmNyZWFzZWQgYnJpZWZseSBiZWZvcmUgdGhlIHNlY29uZCB3cml0
ZSBnb3QgcHJvY2Vzc2VkLA0KPiA+IGFuZCB0aGUgcmVhZF9wbHVzIGdvdCBwcm9jZXNzZWQgaW4g
YmV0d2VlbiB0aGUgdHdvLg0KPiA+DQo+ID4gV2hpbGUgd2UgbWlnaHQgYmUgYWJsZSB0byBmb3Jj
ZSB0aGUgY2xpZW50IHRvIHNlbmQgdGhlIFdSSVRFcyBpbiBvcmRlcg0KPiA+IG9mIGluY3JlYXNp
bmcgb2Zmc2V0IGluIHRoaXMgc2l0dWF0aW9uLCB0aGUgc2VydmVyIGlzIHVuZGVyIG5vDQo+ID4g
b2JsaWdhdGlvbiB0byBwcm9jZXNzIGNvbmN1cnJlbnQgUlBDcyBpbiBhbnkgcGFydGljdWxhciBv
cmRlci4gSSBkb24ndA0KPiA+IHRoaW5rIHRoaXMgaXMgZnVuZGFtZW50YWxseSBmaXhhYmxlIGR1
ZSB0byB0aGF0Lg0KPiA+DQo+ID4gQW0gSSB3cm9uZz8gSWYgbm90LCB0aGVuIEknbGwgcGxhbiB0
byBzZW5kIGFuIGZzdGVzdHMgcGF0Y2ggdG8gc2tpcA0KPiA+IHRoaXMgdGVzdCBvbiBORlMuDQo+
IA0KPiBUaGlzIGlzIGFuIGlzc3VlIHRoYXQgd2UndmUga25vd24gYWJvdXQgZm9yIGEgd2hpbGUg
bm93LiBJIHJlZ3VsYXJseSBzZWUgdGhpcyB0ZXN0DQo+IGZhaWxpbmcsIGFuZCBpdCBpcyBpbmRl
ZWQgYmVjYXVzZSB3ZSBkbyBub3Qgc2VyaWFsaXNlIHJlYWRzIHZzIHdyaXRlcyBpbiBPX0RJUkVD
VC4NCj4gVW50aWwgc29tZW9uZSBkZXNjcmliZXMgYW4gYXBwbGljYXRpb24gdGhhdCByZWxpZXMg
b24gdGhhdCBiZWhhdmlvdXIgdG8sIEknZA0KPiBwcmVmZXIgdG8gYXZvaWQgaGF2aW5nIHRvIGNh
bGwNCj4gaW5vZGVfZGlvX3dhaXQoaW5vZGUpIG9uIHRoZSBvZmYgY2hhbmNlIHRoYXQgc29tZW9u
ZSBpcyBkb2luZyBhbiBPX0RJUkVDVA0KPiByZWFkIGZyb20gdGhlIHNhbWUgc2V0IG9mIGRhdGEg
dGhhdCB0aGV5IGFyZSBkb2luZyBhbiBPX0RJUkVDVCB3cml0ZSB0by4NCj4gDQo+IElPVzogSSdk
IGJlIGhhcHB5IHRvIHNlZSB1cyBqdXN0IHNraXAgdGhhdCB0ZXN0Lg0KPiANCg0KICBBZ3JlZS4N
Cg0KICBGb3IgTkZTLCBpdCBzaG91bGQgYmUgdGhlIGFwcGxpY2F0aW9uJ3MgZHV0eSB0byBlbnN1
cmUgdGhlIGNvbnNpc3RlbmN5Lg0KDQpSZWdhcmRzLA0KDQotIENoZW4NCg0KDQoNCg==

