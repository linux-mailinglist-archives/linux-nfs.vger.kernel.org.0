Return-Path: <linux-nfs+bounces-7540-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26B99B37CA
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 18:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 013C5B229A7
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 17:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C4A1DF73A;
	Mon, 28 Oct 2024 17:38:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020077.outbound.protection.outlook.com [52.101.46.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17B91DF75D
	for <linux-nfs@vger.kernel.org>; Mon, 28 Oct 2024 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137092; cv=fail; b=YAqZNJQGZex4nDUKZ8cOCenGZXrnNYumpQTqoKnAL78stsPFqF+hNzKiUhqKIwnQqBI2Cqx397/3r/rXMOWhLG9t4qAWTK0YpCtPeaRjgnOn/zhmJPluu6fqwugPTpjcb5oAvQMAtRuB/FULXeWaZYTPhxZqrcFiVZpNBU5DVPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137092; c=relaxed/simple;
	bh=DL8asozl/dpjr2wpiZpk130/tv+Vw0RWD133BYSI/3g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QUqo9Uk89h1YPAhNub8j2LrUDTPy4lWJV06qr2gcrjAc2yFgQ58lGDZ0oppArj4a0LJumzP3s44Em8kPJVX/03q/CBHQFnbuAh0HaBKKo+NHSsRTZgh6wxRzTKX/xFlKR+gLSUIb4J2x/hH8J8M/6hVCkb7n4UzjKdqULhmGack=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.46.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Di/S6T/Pxp6mUTFgZmni6fPJ8BxkNlamWYlrXOsPo+LKZNC4nFJbvYd/nsceu8lysFpcDqm1Rm9u3fK0C+rIYkcQq9EqRhIQXOuQnuZ7MJwF9FlN3ae2pwWng00dMiqQ/z9a1URjtnqPFMeOxiNbwEGFP52OaCRu5HGXyvxfYVNL66LgsRgW2FeI0Q95PaJVxhqcYOAEccY+o+iFlukHV7h0zANllkg87X5uyZiAFuZ3A0j1+ej21BZdFIWyQpNe1Fh3SzmmN8Lu4EF0aDCrPgnwTG4/oRiJdrQ1jYJsE7VjpDP1kHBdg6DGvoXQENq0uNu/KXUTbWWvoa+myVeIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcEvlpz/uqjpLGySnEDemZxkSqGDYkGk0gHtDjwDkGg=;
 b=Uh0+jg65Bl6PXsCnHihR3ssuzhmK3mx5QNzP7xjanbRK2T4XTcsUEGh/NdzEcH9R7eVU4k1PR2rdG9AKtmlpwPF3KJimB6vO1hveK+F+062i2QNtlPpxI/CSAcy/kW5fkOrLdxT8dhuAlBHtXkLr2y6keyXE3xrNL94fZrZlahWzaqZk5BzEOjpFbnacD9g1bhqCCMlJHOz1euFA2T2sA0r00tpwUPsxQzmpPDtDVQMxevNeMB/khBcUrSRFVeHeiGoistB+p4PUrr9zomJ4OwyWJp0OsJBhqs1++LqYXN52U1G3Rk90uQ/q7+YFia54YRKu97MkPQC2KyqPgQK0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 DM8PR01MB7127.prod.exchangelabs.com (2603:10b6:8:3::19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.13; Mon, 28 Oct 2024 17:38:06 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%3]) with mapi id 15.20.8069.019; Mon, 28 Oct 2024
 17:38:06 +0000
Message-ID: <181cdcf6-2cc2-4f71-92e1-8ac2ab3fbfb0@talpey.com>
Date: Mon, 28 Oct 2024 13:38:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd stuck in D (disk sleep) state
To: =?UTF-8?Q?Beno=C3=AEt_Gschwind?= <benoit.gschwind@minesparis.psl.eu>,
 Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1cbdfe5e604d1e39a12bc5cca098684500f6a509.camel@minesparis.psl.eu>
 <4A9BFCA9-7A15-4CA7-B198-0A15C3A24D11@oracle.com>
 <f7aec65eab6180cf5e97bbfd3fad2a6b633d4613.camel@minesparis.psl.eu>
 <509abdda-9143-40da-bbf2-9bfdf8044d4c@talpey.com>
 <a4db98210dddb49b8810721b9c699a4d1c4915c1.camel@minesparis.psl.eu>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <a4db98210dddb49b8810721b9c699a4d1c4915c1.camel@minesparis.psl.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0577.namprd03.prod.outlook.com
 (2603:10b6:408:10d::12) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|DM8PR01MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: effa401b-ad42-48c8-5fc3-08dcf7774808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEp6MEQ3VmkrQWRKVnhMblhKUXBsNEtlbyt0MDk4Y01nSHFBMkRsWHhQNmtS?=
 =?utf-8?B?MHpWVDhlMHR0Q2kyTE5yNUx5dnJYT09oYlo0YVRQMWFud3JJdWQ4akU1MFpu?=
 =?utf-8?B?ekd6MTBNQzduNXpEYWpod3pObXdCdGsyaHlGREo5elBJUVJ2M0cyS1cwVWhP?=
 =?utf-8?B?aUFxd2JlSUpXZDBrODBjR1dlNHVzamh2V0hMNnRnY3poakhCVXBFTVgrdXpL?=
 =?utf-8?B?Rjc0Zm9yU0NiOEh2MWp2ZW05aW5MMXNwV3loWnR5cld5eW9IRlhhMEZSd0do?=
 =?utf-8?B?ZUtENUVsMnN0akFrNnJyTWROenZVR0swSmZpMW8rN2lONzljWS9nQ3JNWHUx?=
 =?utf-8?B?R2FwTk5uYWQzUzYrUU54cmdYYnNXaHZpYllpNzY1ZGZLQVJDWmNKTytieUFk?=
 =?utf-8?B?dUFwQWMwUmYyZG1FK0RRUUZMS0hBd1dUaklkcVVOMFRKMnBMOFY0OFk4bSts?=
 =?utf-8?B?YzhWTFFhU1EvNSthMGZrcmNzN1NkVUlyUVp0UHgweVVncG5qSHR4NzRudFc1?=
 =?utf-8?B?cHhyUFcrWWlYZCtlNWJKYStmQkJsRUlkWGpUMWdwVnpxVU5BWGV6ZXRXS2Nx?=
 =?utf-8?B?NFAyS2daOWc4K0pOUXcra0tyRjZkdDRlQy93L2V4a0pBT3JzYlM1eFB1ZS95?=
 =?utf-8?B?ZHJod1NMbTc3QTJXbU1jS3Uwa1AyV1ZESmtzd3dYNlU2M0RWWHg5OUZOWkRT?=
 =?utf-8?B?WDc3Yk8vMURZbElEUHFTWGVodkJZS0d6NytzRzRJSDJQYUphQWpVOVRFakJ6?=
 =?utf-8?B?TWhYNUZVWEVUdWtQbzlBZkdHOTA2RFRBTjFQam5SVms5cnpESzVxb3JrenJy?=
 =?utf-8?B?YjdVbmg4OEk4bS9kY1hPdm50ZkxMZmYrNytqRFBZNFVRNmxsbU1pNXJ2SU81?=
 =?utf-8?B?RmFpOG5Xemg0WEIwSHdMdW1yN0Fpd1d0WEYzcUNucE9LZG0ybk5Rbk1sTWVY?=
 =?utf-8?B?MnJ2M3hNbWxIWEE3M3F1VFZ1cVZOWkRBdjI1Sm13akJDU2Y4cWczTmphQzFZ?=
 =?utf-8?B?ZmFjem9xZVRQc0liNTlWWVBXM2xaa3U3U1hia25CRWV0N0UyNU1sbitYT2lp?=
 =?utf-8?B?bUxiVmhHSHBicGhycFA4UCs5bGdkUlovNjI1ODRudzc5QS9iajFFSHM1QXNq?=
 =?utf-8?B?c2d4cTI2VFhHeUJ6b1hRYU9oSk5qcGhDd0FhWFBoSHZyZFhDZUtVRWhnRUdu?=
 =?utf-8?B?TGt2WDdYL0RKYkpYamtPemcwUjl0ZWgzV2thYVR1eHl2YkhZQ3BBellzRDUw?=
 =?utf-8?B?TVV1c2lQV3B1SXJ0cG41d0hsYTJ4YzJTRnprSzMwUG0yUXIxa0lFcElaN1JT?=
 =?utf-8?B?OFI1OEJzWjZza2VBS1BJTXFpUVNJdkhrV29wNGgwNTBITWFWaEFFWUJ3NGxk?=
 =?utf-8?B?Z2dJMThhMmtJcjhKUTJxRkRqaFFDcXlGV3B3Nms2MzBSU1RjSzBaVzA0d3RP?=
 =?utf-8?B?eDAwNzE0OURUL3JjS3RtVjQvaWdKaGdRcmtHenVxb2x2MWdXVlBETGFOenlL?=
 =?utf-8?B?RE43UkpqUHBnWWVCSldHSnZ6aitnNzhPbHA4ZXE2ZWh2NzNNQWZma2NhU2F2?=
 =?utf-8?B?SnNNd0ZFeVZyYlpiWWlMaWVUY2hwdzZNSDdCQXYzY0h1bFlJVDhrTEppQnZE?=
 =?utf-8?B?dHJ6SWVuZUYra0J6SEZZN1ZNbnVsbEVrSXNlcm1BSW5UMmR3dGVUV3hPelJu?=
 =?utf-8?B?cGg2ZVZOOSthZ3J3YXNnV1ZDZVBPNnhETzhwalNHdnFiblVFR0M5TjlnTjM1?=
 =?utf-8?Q?JIZjOVq2PGlGddzlWXamZ9FmWT8X809T5GSY1C8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2VKYXVPa2V0OU5SZEtXenRFbWZmL1gyTE1mUXpTZnNMMU16V0ZuKzcveUd1?=
 =?utf-8?B?UldUc1dia1ZXVXA5L2lmZE05a2F3YW8yU3l5eWNvL3pXQ2NwQnd3ZTFnR1NC?=
 =?utf-8?B?NlRwYUlrcFhhRHhwZENYRVNwMlVFemZsVlBOdjJtVE9mR1lxVzJDUmtsbEpq?=
 =?utf-8?B?YVRNSFVIWUh0djZQWmhaTjVlaWtlUzc2U3M1ci9PNmk4VGFTdCt6blg3dlE3?=
 =?utf-8?B?NW1jSXdxMXl4LytjU1FoM0pqdEhra2J1N2ppKzIrRGJGTExFbyswQ0orNTJM?=
 =?utf-8?B?MTN2YjVoRllCYTQ3QkJXaTFQSkxLNnhEQXFIY1lTZEtWRWxzWUYyY1Q0UDRu?=
 =?utf-8?B?NGhKUjBLalRsTkdReVowNFNpR0kyUUpFMCtJSjRVWlpXNWY1YVNKQzJURW4y?=
 =?utf-8?B?aE1MeU1BMXAraW0ybkNiUFZjOGY5dmZqNlo2clcrWlNnRjAyNmxzRjVwUHFr?=
 =?utf-8?B?S21UcWpmWCszbHA2UHVFT295RGhDeFhvRTlGdWVYWEk3a0VjY1NraENyaTUv?=
 =?utf-8?B?ZnRxbGVxQnBWTG52QitHVmhhY0JCbmJuV2xsQmcwS2RYazVyYWJ1cmlldGZH?=
 =?utf-8?B?ZERqTFdMbE4xVmZISXdEOWIvVWpwaDM2VkszYnkwM1Q0VU9NZ3pOKzRSRzd1?=
 =?utf-8?B?dDFkbDduYURWbjVGcmNpekhVZzJPT0tXMlp4RHVHZUZST2VwSi9pNG9QS01F?=
 =?utf-8?B?b0I2TFFlWE5FUTU4MjRDSHpiS1E2Y2ljNmc0TXZ1RDFOZDV6UG1aYlVEZzdx?=
 =?utf-8?B?cjJSUEV1anZQUmtYNDdmVkxvZ2VUQ0p1S0pqcHRHSmIwQjZhQmFTcUJLS2tt?=
 =?utf-8?B?NFNWLzZ6NUpWYmcwb3VjcHlqc2tLbGkxSE96NFJTTFYxQ0JOVTh4L0E2U2xO?=
 =?utf-8?B?QS8xYUpBOG0zUEVaSlVidVZJY0JHZjlVZWx1Z0FFVGpFa3oxK0tucm9YeThw?=
 =?utf-8?B?cXB2aS9WeDBqbkwxM21CVTZSK2RwdGpMMFlwZFI4NE9oRGtJYlJ0dVp3Rk1y?=
 =?utf-8?B?YTY3VUxKck9ycDZneXIvcUZDZC8rTFRiWlJtVEkxaWh2ZGs4SDFCTURpeVNN?=
 =?utf-8?B?OGdEWXRBejBDL2lUTVBtOERZeXM2cERyQ0h5ZzFIS0VlQ1FNRkFDclh6eHB0?=
 =?utf-8?B?aENCcjNrM1JWUkFYTldZUkZPUDlQT0lpVGIyZDRLMFcwcVhmd3dFU0NjUEFI?=
 =?utf-8?B?Tm96UDg1NnE3am13U1NONk5VUVRCbThOanlsVmQwa1d3bWYrdjBlOHd1ejg4?=
 =?utf-8?B?T05RWkNZMDJUSGliVW1qaWlrM2RuamkvMnEyM09XbkVncUFTZ3BWcnE3S2pt?=
 =?utf-8?B?cThCYThnTFFFaGNZZWQ4dWw2OEwvVUJPZmJEWlhndU1kclN3SGJtR2hXREFy?=
 =?utf-8?B?QlBPeEJXMGQ5RHVjaFpSbjlNdlRaK2RmeXpYTldWT0VVREdXZnBUaUQweHlO?=
 =?utf-8?B?OWVuNTdHMGZuOFZsZUFVU2g3TkJBaGtwNXRqMnFjOGh0aUhwZ0svVTlLK3FU?=
 =?utf-8?B?Y0pjQllUL2xvdVZ6a09PYTB2RklUL0VaMkRkcXdoaDFVVnNCMVFYRzBxaU1D?=
 =?utf-8?B?a3pZSlRVNEtJODVnUXF2V2o3eWJraTRITVdZTkFiNWtEbG1rQ1pXMWZTT3pJ?=
 =?utf-8?B?OERFVkMwNmZqclVXbitaZXNGOXFtTWkwRzhHeGkrZTlPN3FmNlhjSitJS3A3?=
 =?utf-8?B?Rk9mVFZETmVqOGMvMWJqKzFmSmF6OXdwb0ZhOVozaW9yU2t2VENVMVhwWDgv?=
 =?utf-8?B?VmMwSm1GU0VUZmN6eDJreEQ2bGROamg4SmFnOVplTERTYXFWS2ZPbzFFT1p1?=
 =?utf-8?B?NVgxa29aODY3Zmt1emlyN1d1RkYxTllyelg0ZjNVMGluRTlSUEU2OUU1VjFE?=
 =?utf-8?B?TEF0emsvd3ZpRVYrQlZnZ1JXbVRKQUhXK1ljUXk3a2FrRmpLZlZxby9XNklj?=
 =?utf-8?B?OStSTnpGV1F1Wll2Ny9sWnhPbjJRa2t3V1d4MldkQXp6UmRGRmNvLzhFVTVi?=
 =?utf-8?B?RzZUMXFIak5EMVpFbW5vaXBtTktvN1o0THk1Qzg5SHY0aEVVTm91YThmVGU2?=
 =?utf-8?B?cFdadjRFaHF3YlJzTS8xNCsyci9CVlIzMFhXajVDQ3R2VUtaQVp2dk1FRzEy?=
 =?utf-8?Q?brCQ=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: effa401b-ad42-48c8-5fc3-08dcf7774808
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 17:38:06.3013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6vnU6yrmFkFh/iHNkoRJLkE4V0GabVbJ2mVSMEjz4gLQ5zEDnIpVkTdSEb/CVqG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7127

On 10/28/2024 1:01 PM, Benoît Gschwind wrote:
> Le lundi 28 octobre 2024 à 08:46 -0400, Tom Talpey a écrit :
>>
>> Was the client actually attempting to mount or unmount?
> 
> The servers were running for a while, thus, as far as I know my setup,
> there is no ongoing mount or unmount. Moreover none of the clients were
> rebooting, starting or shutting down.
Interesting. I would therefore suspect the create_session was simply a
reconnect after some kind of transport connection error/loss, and the
destroy_session callers are hung for the same reason. And I agree with
Chuck that a network trace will help identify the patch which is needed
here.

You may have to let the trace run for a minute or two to detect all the
retry traffic between the client and server threads.

Tom.

