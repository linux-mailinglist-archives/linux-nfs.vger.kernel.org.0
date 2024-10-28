Return-Path: <linux-nfs+bounces-7529-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7299B30D8
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 13:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94DD1B23FB8
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 12:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C28D1D6DDA;
	Mon, 28 Oct 2024 12:46:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020136.outbound.protection.outlook.com [52.101.193.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77321DA100
	for <linux-nfs@vger.kernel.org>; Mon, 28 Oct 2024 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119606; cv=fail; b=Fdo9TRbiqH0x7ZULis1ADesfCtp16DfdjnbKVKPO/L/AmwFg43skNK6G5kpza8Eim3NhwbrF03pAd+iJ9JFIpwja6ynOWuaQX+B0j72KfkgPPEMNTrs6ZmAFkgA7+PYpM1xTYDP0nuCOX6aBg5Tt67sjcrPbrnWdXkgYnaphmaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119606; c=relaxed/simple;
	bh=SEn8iDjb25gxpbnFvy070mjDMGFziSfK4navk53+2Zo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=imV38Jsiwr1BBDPm1Se7I08HvJ6xWKP6/hZXj3r69/FTYyULgBUW7/DqQ48w1dsUv26zmVclcPWQucjnmkIKIgwq6Du2uvvJ6OZ3+wef0GpwdxU7NbGuVoecucpzJSNRnSWJ0TG2tfaFUvF0Du9ykugkQMKA+TRHbSR/uHO5RlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.193.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNVbnFFO43c7eJl9WDIeUpPM27TCtFEYzjSHDWvM52bIn2L10MMFHxVr48gnQ8JlD8LpQXBkkQKkWbDQY7NhWvhtxFFyqHyF/vOydUa5wmMLiwQpx8EW8Td1KnxwnW3o+D6COOla57fAkziJust//p4MpvswcqBprkI9q9f0aCqpsfFONExnuqPlCcMDPygU36Ylx9kWk+3mpwunOkaHW0VWiWtVuBbRzEn6tLyQiITg0HdX4OVCMcWxhGBU7ogCsbdZijmXy01REoyUtM6LAhfyJ38IJ1D/VDw3sNUgmQajKikB6Uz5cfhjKlSUjhUvYEwmgpngJs60mhNExsAA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kCmIbWBDBuInsJDYwsDxnar85ylsDBKBrICqVXjzTs=;
 b=Pe0n5dlKfHSTS97QooC/rqToczLE+Zj7ww0pLjPLeluOdxLkDG1IIO0DKwbTlzwk8B+s8rK3G0nlljmpQajzQKbdiGlU127giiv1TBl/oxGE9VMyRLJ+oQn7He0d2T8S/wwIjPxizi+o1aFlrVgPnmKSOGuOnqFpMH/u1UbqBsX4duOUu+4R9cXUqR3X/DQyt+mb/0KxVr9qrhCiksn3CPV64FuR5IxU0X5N2djvyBARPkgrn3W2NggZvfVY8wJA180VyhK47wT/UHolwyVRv8CRstnr6InPWAiH27bbk5RFt8l6dCTQ5glrUH1tkiL8huY8efwnBQU6DsKBptBncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 DS1PR01MB8845.prod.exchangelabs.com (2603:10b6:8:21c::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.12; Mon, 28 Oct 2024 12:46:40 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%3]) with mapi id 15.20.8069.019; Mon, 28 Oct 2024
 12:46:40 +0000
Message-ID: <509abdda-9143-40da-bbf2-9bfdf8044d4c@talpey.com>
Date: Mon, 28 Oct 2024 08:46:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd stuck in D (disk sleep) state
To: =?UTF-8?Q?Beno=C3=AEt_Gschwind?= <benoit.gschwind@minesparis.psl.eu>,
 Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1cbdfe5e604d1e39a12bc5cca098684500f6a509.camel@minesparis.psl.eu>
 <4A9BFCA9-7A15-4CA7-B198-0A15C3A24D11@oracle.com>
 <f7aec65eab6180cf5e97bbfd3fad2a6b633d4613.camel@minesparis.psl.eu>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <f7aec65eab6180cf5e97bbfd3fad2a6b633d4613.camel@minesparis.psl.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::35) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|DS1PR01MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: 913a9249-2480-4463-ee2d-08dcf74e91bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVNmTHJhbC8vZ2V4Y2JTZUJCR2poa1N3ZHRkNGdOZW1ZN1BMTUY0Mzc4Y0Vk?=
 =?utf-8?B?L0V2UlI2eWtUSS93bEhwR0tSQlFSSG9mUDdhak9mNXh6enRaMCtJSUh1SlNC?=
 =?utf-8?B?anh1U0NDdjREVG5WanduVy8yZFp6T3JOejN4TmlVd2hGTktGaXFpUlFBajhX?=
 =?utf-8?B?ZmNMTGsvQTVaQUJKdURMMUUwU05lR0Nrb0I4eW93NGdBdUphdkJSZ2ZaZXBu?=
 =?utf-8?B?SUdBTFlxRHJleWNaNUM4eERyV1lVUSt3Yk90WHRlaUNLMTdzeGxvVUUyQ3Zv?=
 =?utf-8?B?eDFvWEdaVENkRDh1STlhaVpUOEhzdHdYZnEwaWpSZWhnK25tQ1VSRjloSHpG?=
 =?utf-8?B?VSs2RGxXSEhVeU1ZVzBSZlRKSmZnd0dBQWFJYTdGT1NkL0gxQzhDMnFLWnFR?=
 =?utf-8?B?YmZrTlZvQ3FaRlhlbFE4bGFla1RrOGlRL2FrMmc2M2xtMEJ3bUhaTmlBSm9k?=
 =?utf-8?B?WC9GYnY2U010QmVqUzducHdzcEJFZTl6bHNZS2hQQlNsYjFBS25kYVBqZ1Yw?=
 =?utf-8?B?T1dGM2ZrTXVjOGkvQ050MytvekxaVzJxMm5TYm52ejRlenBjcUxZSlhST3Z3?=
 =?utf-8?B?NVRrZ3pHYUlJZWpOMzc1TEd1UFR3cEZUNmM5Vkd3U2lrcmg5QVlQT0ZJcndh?=
 =?utf-8?B?SnNHNTMvNzRBcm9pMXJ1TWM2QVE0N1kvVzVka3dPZWtZYlM1OGQ5cFJXREFx?=
 =?utf-8?B?NXpZdnAzOFkrbVFMU3ZQbzNsSTM1NWppS3AyUnJqTkI4YW1UVm0wU1JOeFhn?=
 =?utf-8?B?VCtkK3l5cEdBVFdCT1BGQklVcGw2NC84eS8rOHBKR05GVmVLQjhVQXkwb2ZP?=
 =?utf-8?B?YWxRdm9iOS9pbnpBQ1AvMk9LNGFrQkJ5YkpzcUdUT3dNUnoxK1lOQ1dZdlVj?=
 =?utf-8?B?MFpUTTdxeUg0cWJPZkJ0bWhNaTZNM0NKbHY0c1IralYrc2FyUFZJUUE0dTJs?=
 =?utf-8?B?Rjd5QmZwY0hudDRNNHZ3MkhEZmMxUDFaamRDc3doaDRDVmpOQ1JmM0wwUUJ0?=
 =?utf-8?B?RE84b2x2bFMzZjdZQ2RTbWpHREM1NGxCZldXMkxEeFJLOVhqVExUMnl0R3Yw?=
 =?utf-8?B?MlJXbm94bkZ5MzI5WldMSlQ2dFJ0Wmx2anpOK0xlcUdLcUd3NDhyZU5oRXhn?=
 =?utf-8?B?ZzVRVXhwdlQwUGdqOEVyZ3JiZHlZNXRXM1ZYMjhMUmlaYkp2WlBqS0h6V1hu?=
 =?utf-8?B?Mm9UNzJJUGFld0l5UlJrYXlWL21WTHVoNTdkc3hIeWhnS05wU3Nmc2NLS2NW?=
 =?utf-8?B?U1VaL1l5NnRMQWZBUldJRnBOMEE1QURGdWVnUFZEd3AwTkVNdU9rcGM4YzUr?=
 =?utf-8?B?bFZXSHRPeDZwM0lqR09IMHhZcDduRE5vaEtqbE44aVI3YmdWbnpYaTdtMkRa?=
 =?utf-8?B?ZmxRamk2WGVUZXBVY2xDWjdCYUVSalNHYUswRVh2bGFwVzhTZ21Hbnl0QVdX?=
 =?utf-8?B?Z1ZRZVhxYTRRcnBML1JKalRoVVV2MjJtWkMyRWNxcXRIZTlGOFB3dW9tREZR?=
 =?utf-8?B?dm1hci96OXh1NFZuaVQ2MXZtckQ0eUpJZXcxME5Ca2JiRHJjWUIzTHJZdmJm?=
 =?utf-8?B?cTlnTDhUeFluc3dmZm1OM1NjZng0bDVGS1d2SkI1TWppQ0kxL2t1K3FMRXps?=
 =?utf-8?B?dlFCank1cnFnOTVzUTE2R1NIWFZkZU5KVGp0MXRqQkF6UVJwcTNhRWdocytG?=
 =?utf-8?B?cjF4M2QrM0huRkxYRHduaDJNMDhUREY4SjJHbUwxUUM1Mnp5czFjeHhid2R3?=
 =?utf-8?Q?IjH0yDGpOdqT4OGAsfOA+P1yFlzmFfj9Z6QcySo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bENlSjhqRVNVRCt3VDdvNXFLUWNvQnVLem14NnN0S3hKQUhrNzhuWFE4VXgv?=
 =?utf-8?B?OXN6MGRwcFNuQzFGMU5wMG1LNm9MYWJoZUdMUVNtWURMZStkQTJVbjRuMGFT?=
 =?utf-8?B?RjRjWGF0MHc2TkZldzhaZncxMmoyQW9KcmNmK1hOcUd4USs0QmdLdkpTT1VP?=
 =?utf-8?B?cDJLeFVvV3ZsZ2RlUHE1YmFkV2M5ZXArbkdKZ290RU1lSWhRdVpFeWtPOGJw?=
 =?utf-8?B?Wmg1L3ZLUlQzaDc2MXR4Q0JpZlo0b2Eva3BmeUZ2TW5VYXNMb20xOUF6SHdZ?=
 =?utf-8?B?TXVKbXZtK0FySk4vMHdIWkVQYWw5L2toQjVkK1ZtZ1VKSjlBVnhHOG5Rd290?=
 =?utf-8?B?NVdMMEJZWEhCWjVZOFNqMjlrU3ZjcHVxSWFjUm1GT25melM0cnVwQk5ybEYw?=
 =?utf-8?B?VWtXYXM4R3M1cXprYmppd3RwMktyMjQrY1dqSHdSVGdVam9sVUMySFRjbXpi?=
 =?utf-8?B?RzJHa0NkZ0hxL2RPejQ0ZTN4VTY1U294SHdLMnVNV1FpNERrT3ZTeSs1TUt0?=
 =?utf-8?B?M2NKVm5ZbTd5WTBKajhwY2FwdkRiYkt2WnVEMTVwUVRrdE4yR1p3dU8wdlJI?=
 =?utf-8?B?Q0pENHhIbFcyT1V1aGdhaWsxbzVOSCtLWkdYVElLVUhIWTdVUis3cG92bFBu?=
 =?utf-8?B?dUhFMTVjRFVZTWdxLzlaY2dZQ1dJekhTeElwdWFmOWdHOHliQk5EK1JoRCtK?=
 =?utf-8?B?M21mcDlQYzVkL0wreVZBUFUyRG52YzZlMDZVUXd3eXc2L0lsSXVjWTF2UFdm?=
 =?utf-8?B?dFJ3Zm55TUZhb0V0WWRKbWlMMjMwMmFkMFRxSEV0aWtOa2RwWjFmN3QyZVBO?=
 =?utf-8?B?bVo2dHNQck5ubE1JNi93OGVVdFh6QlpEc3pBWWEySnZZc3psR3JNOG9BN05t?=
 =?utf-8?B?Q0ZsSXo4NGdhSmpxeWQralVrc1hJYWN1YUVsdUNkQUl1TFdZQmZPNnZFTU5s?=
 =?utf-8?B?alBBM084OE5WdmpPRHZJclZWVExXM096aCtmSEMrZFJzc3hSUlZPOW44QTFU?=
 =?utf-8?B?VXREQjZtZ3hGdlo2VGNKaHUvVjRHL3ZnS3JZOFpkQzJmZWp6MWIycFprL1Er?=
 =?utf-8?B?dmxwdllPc3hmNDFRbUg2MGRBSExaKzR6ODFQTmRIcWc1SUZiYVlhTnJpK3NJ?=
 =?utf-8?B?LzdnbjB0TlRVLzF1Z3gyOFlVaUNoaTNqb3NuRUM2YzJPZExOS2pYTENCWlRq?=
 =?utf-8?B?TkJJd0RHN0VZNCtRa29oR1RxcXorMmUvT3V0WFFSOHNldS82ZFhSZzFBanIv?=
 =?utf-8?B?T3FHcHVvTjFzQnAyNitZVXFHRnFvTE1KdnJya3pNNWVYRmhtS2dJRjkvQVU2?=
 =?utf-8?B?TzRZVzhNQzJYNDJtK3pVQnQ3QWJGRzUyL3ErRFB4azZaai9iKzBvZXU4ay9Q?=
 =?utf-8?B?SnY3Ry9QaGpRLzBtK2VFeCt1Zi9kK2NKajg3Q0MrRzlhcktyWmxObDRubGZa?=
 =?utf-8?B?U1BmalhCUGxFT3F6bCs3cENaYWZ3NVlwcTBENTJrQjhic0F4OUhWbDBuQmR6?=
 =?utf-8?B?a3AyTDRXcW1rZHo1bGRtNGkwMVpNd3RsYlR3SE1DZnYweUlZNHhtVW9YQ2Qz?=
 =?utf-8?B?SjJNYmhibFgzTEprazBOSjY1dXN2a2NZOVBhTEg5Y3lLK01FSHpjVG5NYjJM?=
 =?utf-8?B?ZEtldi9XZFRCZzVQTjVXQkJBTXNSbFJyYVhVY25ncjE5OFhyR2UwTlFEdjVx?=
 =?utf-8?B?cEFSNE9qT0xrZ1NFUTV4YjBmaFNXcE5wcUIxbjhlZmZmQ3graExidmNKNG1P?=
 =?utf-8?B?NUE2M2VGMTM3N25KZWRNSXVBeC9BcndzSVFGWlFrbkVTR1kxOVJhaHZTSWJ1?=
 =?utf-8?B?M1lxZzFMMlYzTlFDMzkzbXhXL2FoaGRIV0tFQWlJMVBiMkNYTDNuUmRmN3Jo?=
 =?utf-8?B?MmtvRnBZZXV0NkxCZTdpbGZaOXJXREM5MHNNNlFWczdUZloyRjBaVHZJQk92?=
 =?utf-8?B?cEx5a3dobFdpanFvZ3FsQzV2NXBwMWtlbjMyWHZyWCtISWltOTFld3RjTUxq?=
 =?utf-8?B?Ky9nM05lRFU2Q0ZHaWYzczRvQzFSbzZZOHZpRC8veDFEMTJ5V1Zkb0kvSFJV?=
 =?utf-8?B?QjMvNTdoaGdINWJUZ3ZBVFB2bHdydmwxMTl3MnlITFYvV20xblZTRzlrajIw?=
 =?utf-8?Q?8N4Q=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913a9249-2480-4463-ee2d-08dcf74e91bb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 12:46:40.5819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bM589YhHIeFxMFZlWLO9rOwtzIEqsIQyq2cWW77pJx5GEdF/6A9dU8DCRViOqoYl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8845

On 10/28/2024 5:18 AM, Benoît Gschwind wrote:
> Hello,
> 
> The issue trigger again, I attached the result of:
> 
> # dmesg -W | tee dmesg.txt
> 
> using:
> 
> # echo t > /proc/sysrq-trigger
> 
> I have the following PID stuck:
> 
>      1474 D (disk sleep)       0:54:58.602 [nfsd]
>      1475 D (disk sleep)       0:54:58.602 [nfsd]
>      1484 D (disk sleep)       0:54:58.602 [nfsd]
>      1495 D (disk sleep)       0:54:58.602 [nfsd]

Hmm, 1495 is stuck in nfsd4_create_session

 > [427468.304955] task:nfsd            state:D stack:0     pid:1495 
ppid:2      flags:0x00004000
 > [427468.304962] Call Trace:
 > [427468.304965]  <TASK>
 > [427468.304971]  __schedule+0x34d/0x9e0
 > [427468.304983]  schedule+0x5a/0xd0
 > [427468.304991]  schedule_timeout+0x118/0x150
 > [427468.305003]  wait_for_completion+0x86/0x160
 > [427468.305015]  __flush_workqueue+0x152/0x420
 > [427468.305031]  nfsd4_create_session+0x79f/0xba0 [nfsd]
 > [427468.305092]  nfsd4_proc_compound+0x34c/0x660 [nfsd]
 > [427468.305147]  nfsd_dispatch+0x1a1/0x2b0 [nfsd]
 > [427468.305199]  svc_process_common+0x295/0x610 [sunrpc]
 > [427468.305269]  ? svc_recv+0x491/0x810 [sunrpc]
 > [427468.305337]  ? nfsd_svc+0x370/0x370 [nfsd]
 > [427468.305389]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
 > [427468.305437]  svc_process+0xad/0x100 [sunrpc]
 > [427468.305505]  nfsd+0x99/0x140 [nfsd]
 > [427468.305555]  kthread+0xda/0x100
 > [427468.305562]  ? kthread_complete_and_exit+0x20/0x20
 > [427468.305572]  ret_from_fork+0x22/0x30

and the other three are stuck in nfsd4_destroy_session

 > [427468.298315] task:nfsd            state:D stack:0     pid:1474 
ppid:2      flags:0x00004000
 > [427468.298322] Call Trace:
 > [427468.298326]  <TASK>
 > [427468.298332]  __schedule+0x34d/0x9e0
 > [427468.298343]  schedule+0x5a/0xd0
 > [427468.298350]  schedule_timeout+0x118/0x150
 > [427468.298362]  wait_for_completion+0x86/0x160
 > [427468.298375]  __flush_workqueue+0x152/0x420
 > [427468.298392]  nfsd4_destroy_session+0x1b6/0x250 [nfsd]
 > [427468.298456]  nfsd4_proc_compound+0x34c/0x660 [nfsd]
 > [427468.298515]  nfsd_dispatch+0x1a1/0x2b0 [nfsd]
 > [427468.298568]  svc_process_common+0x295/0x610 [sunrpc]
 > [427468.298643]  ? svc_recv+0x491/0x810 [sunrpc]
 > [427468.298711]  ? nfsd_svc+0x370/0x370 [nfsd]
 > [427468.298776]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
 > [427468.298825]  svc_process+0xad/0x100 [sunrpc]
 > [427468.298896]  nfsd+0x99/0x140 [nfsd]
 > [427468.298946]  kthread+0xda/0x100
 > [427468.298954]  ? kthread_complete_and_exit+0x20/0x20
 > [427468.298963]  ret_from_fork+0x22/0x30

There aren't a lot of 6.1-era changes in either of these, but there
are some interesting behavior updates around session create replay
from early this year. I wonder if the 6.1 server is mishandling an
nfserr_jukebox situation in nfsd4_session_create.

Was the client actually attempting to mount or unmount?

Tom.

> 
> Thank by advance,
> Best regards
> 
> Le mercredi 23 octobre 2024 à 19:38 +0000, Chuck Lever III a écrit :
>>
>>
>>> On Oct 23, 2024, at 3:27 PM, Benoît Gschwind
>>> <benoit.gschwind@minesparis.psl.eu> wrote:
>>>
>>> Hello,
>>>
>>> I have a nfs server using debian 11 (Linux hostname 6.1.0-25-amd64
>>> #1
>>> SMP PREEMPT_DYNAMIC Debian 6.1.106-3 (2024-08-26) x86_64 GNU/Linux)
>>>
>>> In some heavy workload some nfsd goes in D state and seems to never
>>> leave this state. I did a python script to monitor how long a
>>> process
>>> stay in particular state and I use it to monitor nfsd state. I get
>>> the
>>> following result :
>>>
>>> [...]
>>> 178056 I (idle) 0:25:24.475 [nfsd]
>>> 178057 I (idle) 0:25:24.475 [nfsd]
>>> 178058 I (idle) 0:25:24.475 [nfsd]
>>> 178059 I (idle) 0:25:24.475 [nfsd]
>>> 178060 I (idle) 0:25:24.475 [nfsd]
>>> 178061 I (idle) 0:25:24.475 [nfsd]
>>> 178062 I (idle) 0:24:15.638 [nfsd]
>>> 178063 I (idle) 0:24:13.488 [nfsd]
>>> 178064 I (idle) 0:24:13.488 [nfsd]
>>> 178065 I (idle) 0:00:00.000 [nfsd]
>>> 178066 I (idle) 0:00:00.000 [nfsd]
>>> 178067 I (idle) 0:00:00.000 [nfsd]
>>> 178068 I (idle) 0:00:00.000 [nfsd]
>>> 178069 S (sleeping) 0:00:02.147 [nfsd]
>>> 178070 S (sleeping) 0:00:02.147 [nfsd]
>>> 178071 S (sleeping) 0:00:02.147 [nfsd]
>>> 178072 S (sleeping) 0:00:02.147 [nfsd]
>>> 178073 S (sleeping) 0:00:02.147 [nfsd]
>>> 178074 D (disk sleep) 1:29:25.809 [nfsd]
>>> 178075 S (sleeping) 0:00:02.147 [nfsd]
>>> 178076 S (sleeping) 0:00:02.147 [nfsd]
>>> 178077 S (sleeping) 0:00:02.147 [nfsd]
>>> 178078 S (sleeping) 0:00:02.147 [nfsd]
>>> 178079 S (sleeping) 0:00:02.147 [nfsd]
>>> 178080 D (disk sleep) 1:29:25.809 [nfsd]
>>> 178081 D (disk sleep) 1:29:25.809 [nfsd]
>>> 178082 D (disk sleep) 0:28:04.444 [nfsd]
>>>
>>> All process not shown are in idle state. Columns are the following:
>>> PID, state, state name, amoung of time the state did not changed
>>> and
>>> the process was not interrupted, and /proc/PID/status Name entry.
>>>
>>> As you can read some nfsd process are in disk sleep state since
>>> more
>>> than 1 hour, but looking at the disk activity, there is almost no
>>> I/O.
>>>
>>> I tried to restart nfs-server but I get the following error from
>>> the
>>> kernel:
>>>
>>> oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104
>>> when sending 20 bytes - shutting down socket
>>> oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104
>>> when sending 20 bytes - shutting down socket
>>> oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104
>>> when sending 20 bytes - shutting down socket
>>> oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104
>>> when sending 20 bytes - shutting down socket
>>> oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104
>>> when sending 20 bytes - shutting down socket
>>> oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104
>>> when sending 20 bytes - shutting down socket
>>> oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104
>>> when sending 20 bytes - shutting down socket
>>> oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104
>>> when sending 20 bytes - shutting down socket
>>> oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104
>>> when sending 20 bytes - shutting down socket
>>> oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104
>>> when sending 20 bytes - shutting down socket
>>> oct. 23 12:00:09 hostname kernel: rpc-srv/tcp: nfsd: got error -104
>>> when sending 20 bytes - shutting down socket
>>> oct. 23 12:00:09 hostname kernel: rpc-srv/tcp: nfsd: got error -104
>>> when sending 20 bytes - shutting down socket
>>> oct. 23 12:00:09 hostname kernel: rpc-srv/tcp: nfsd: got error -104
>>> when sending 20 bytes - shutting down socket
>>> oct. 23 12:00:10 hostname kernel: rpc-srv/tcp: nfsd: got error -32
>>> when sending 20 bytes - shutting down socket
>>> oct. 23 12:00:10 hostname kernel: rpc-srv/tcp: nfsd: got error -32
>>> when sending 20 bytes - shutting down socket
>>>
>>> The only way to recover seems to reboot the kernel. I guess because
>>> the
>>> kernel force the reboot after a given timeout.
>>>
>>> My setup involve in order :
>>> - scsi driver
>>> - mdraid on top of scsi (raid6)
>>> - btrfs ontop of mdraid
>>> - nfsd ontop of btrfs
>>>
>>>
>>> The setup is not very fast as expected, but it seems that in some
>>> situation nfsd never leave the disk sleep state. the exports
>>> options
>>> are: gss/krb5i(rw,sync,no_wdelay,no_subtree_check,fsid=XXXXX). The
>>> situation is not commun but it's always happen at some point. For
>>> instance in the case I report here, my server booted the 2024-10-01
>>> and
>>> was stuck about the 2024-10-23. I did reduced by a large amount the
>>> frequency of issue by using no_wdelay (I did thought that I did
>>> solved
>>> the issue when I started to use this option).
>>>
>>> My guess is hadware bug, scsi bug, btrfs bug or nfsd bug ?
>>>
>>> Any clue on this topic or any advice is wellcome.
>>
>> Generate stack traces for each process on the system
>> using "sudo echo t > /proc/sysrq-trigger" and then
>> examine the output in the system journal. Note the
>> stack contents for the processes that look stuck.
>>
>> --
>> Chuck Lever
>>
>>
> 


