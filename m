Return-Path: <linux-nfs+bounces-1870-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 715AE84EEE0
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Feb 2024 03:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE941C24598
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Feb 2024 02:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982C315C8;
	Fri,  9 Feb 2024 02:37:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2093.outbound.protection.outlook.com [40.107.220.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C8A4A29
	for <linux-nfs@vger.kernel.org>; Fri,  9 Feb 2024 02:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707446277; cv=fail; b=EI/OP5gcugfi40NT6Kn115x4LgagflUBDLzvF6iEVvdnIwvEVAu46ykdClI7tnkOLpHV2CK5/M3T8ON4NUTrDM5co1r1R6g89Vf72wrAZaEsQA19RMto6XFO+dJmO3HjDyYaUfqj+y71Hb+V1MIRSWnbbZxiC6QiPUjz68QYCj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707446277; c=relaxed/simple;
	bh=UOaBPFe9jXjsFWINdk4nA3oSGaocbXa3sch3+ZUIhtA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XHuhHWs7h+faUxT5RbO8mpuhKMNLNjBM52HRunMhXVzMmAXY05WDwDznT5ud/ngR/h95Xd6y5yh6KnhgwQv3ga0wZYRf4MWryd6WJ3nyfq/kG1b9lPUvHEB+kwhhnIZlZxEg7S5SyfnSciGGTvp1hNHPue1FjbFHazjv4Rnna8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.220.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+a9kbIMLlNqtmgj1Ivrgs38a5t+hVxkBxmg7waMju7suS42/H0hdZHwwmlfdkni8H/XOYXppN+aSAI4NZf9FE+BXBq0rHWqeCheswkBK4lr8CQDJZpYrsGiwXbEjP1x7jpxn0qnSeLEAl5D2HWzRhzXSKU2HlKrjpOE3Y/rRNOuwXYH9Od513FVh+3BX5PWDMDopQjznKTx2cBB0NWklzND6AeMa5OdTdhJ7BYsLE/9Ok/NFNWjdVYOSreiWjp3YdcYX5+Yn+VJa1rvLJc+QsPs9dNO10k+uJ4hBINHdC6cRgxWwmqR+eqQpXPodf1YG0dvSfEuzAHsvh062x++0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdB0WUXjfbmOol+J/gD6p+GI2qWGdNcPi0Q3SS1wudQ=;
 b=CExvLljMgbDkrlusZkLt7C3xbd4rqAk03I0xJA74MKKENW2DGLNyYcHU227Xg3pHAQNmrT58nuAG+H6b++KiDNaAOswFkQh25optvWe8GC1vcL5B35yDSOlEeirNxFaRCC9s2w8kVGiNZMY/5bNNANfNeS3hJcBOR2SbhKove4h7ifWGX0SUkF/YWFmbbDc60vuwRPo/YR9ZmSC05hhrwixl/IRIB6xnXNC7tecXTP20RXgciwE+rK6oF1Yg6/39GRbdaPi3Bvq/ttKd2kQneEeePQSAvOF1OXPncrorZ+u7TyzU6Y1clyjjMBlLlyE1PUdgJCZ1NLscRfATEGisrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from DM6PR01MB4666.prod.exchangelabs.com (2603:10b6:5:6a::23) by
 SA1PR01MB7230.prod.exchangelabs.com (2603:10b6:806:1e5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.39; Fri, 9 Feb 2024 02:37:52 +0000
Received: from DM6PR01MB4666.prod.exchangelabs.com
 ([fe80::fea4:7445:bd36:ba9f]) by DM6PR01MB4666.prod.exchangelabs.com
 ([fe80::fea4:7445:bd36:ba9f%6]) with mapi id 15.20.7270.024; Fri, 9 Feb 2024
 02:37:52 +0000
Message-ID: <b14648b0-a2f7-451a-a56b-6bb626c4ffa8@talpey.com>
Date: Thu, 8 Feb 2024 21:37:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Public NFSv4 handle?
To: Dan Shelton <dan.f.shelton@gmail.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAAvCNcBvWjt13mBGoNZf-BGwn18_R6KAeMmA7NZOTifORLEANg@mail.gmail.com>
 <CAAvCNcAkZFkLU-XtmJy30AT7ad_MvSzZTMEk86PiZXLdcMg4fA@mail.gmail.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <CAAvCNcAkZFkLU-XtmJy30AT7ad_MvSzZTMEk86PiZXLdcMg4fA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:208:d4::44) To DM6PR01MB4666.prod.exchangelabs.com
 (2603:10b6:5:6a::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB4666:EE_|SA1PR01MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e8d06c-7df6-42c2-df95-08dc29181ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K4/i8zfCjf++r0ZQPklZm/FQLtO0k4H/tkDPeXqOvxR/U9H7NlwB1ABCsPj5FjsMk8LCG4OxRxzzLtC6NkjWOi0dL9ohbasTRC842cqYhBNNpOJSB+dvXmLkWQgFkyyUdlYE0NzlrJFPX1ur+IntG7RubkaTfPDbJMT6ckBzTrQCEf6vk6rlb5t0Eezx2JsbCuudyjkDp/uX+50cubDsj7ReiHlJdK5iwbZHnjyiDYdsCG12oNXVw2Nn1f7R8U8vrjDQp/r/73yKbuNvKeUnRhr3/QTR9LnxvSWN1uqTau9vnP4z5drbl+DLF4bRBnbRTbcahm30hXD3NznEUUjSZzKa3LYg2Nkp7Otd9eCdmguLPT+mYrN4rJxrYEneJntZA/fKb3k01gklSt2n6cxc16KSsyaDzo+TF2VGwnVgcckFJ/KzYfg641WJB/9G5rHVLOu+RSR4u3USqTSn6atxRakTttw6bApgV+00SNzdTwIyYaUt6NNQ4Ws+KGqCOTkMAaWHWi05oYq90ZBEuf+Hs6XKAXbWo9kUvwDFRdyLtyhWtSLBzQeSrYxxJV1a6gVE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB4666.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39830400003)(346002)(366004)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31686004)(7116003)(5660300002)(8936002)(41300700001)(2906002)(8676002)(4744005)(31696002)(86362001)(36756003)(6486002)(110136005)(66476007)(26005)(6506007)(6666004)(53546011)(66946007)(66556008)(38100700002)(2616005)(316002)(478600001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0MwV1Y3TSt5aE9iUmozb1pUd1dRZnpwa0dsMUNISldVc3Aya29OMjdBV1Zj?=
 =?utf-8?B?VnFRWGcyOWpvKzY2NkVDQnBwTFhDOGdWb2VjN3lqMWQvamVSaU5ITGJCVnVx?=
 =?utf-8?B?akVQeURGL0JVQzRRNThCRDc4RHBPdmg4SnJzR2FvMFlhMndvcEdZU3RmbWYw?=
 =?utf-8?B?NDFVYXVzOHNjUWZpUmpYZjZMNlRHM1RJVHhaTmcwYzRqbmdjWWxwQmV4UU1y?=
 =?utf-8?B?cXVVamdGSUVGbk5ISVQvREl5YWRna0NsMFYxK3pYZFFZL0lLaTlxZ29sSnlp?=
 =?utf-8?B?WGp3eXBQNnZ3UzgzQndEV2ZrOHEwZElhaDhSdmZPR01vbHdFWDFHc3lWRHoy?=
 =?utf-8?B?UnhtcGJUWWUySWc5WFRkWFNWeExaaXBFd3JaYzMzd0lrejV3VnFCTU5lTklK?=
 =?utf-8?B?K1pRY1dEZzI1VVNxK2REQkxlMUJVZDJnZ1pjT0o3ckxOU1FRTEZwc3Mwc1Az?=
 =?utf-8?B?VSt3ZlRmUkphZFZrcURGRSs3TCt2VXZ5RXVvOTNkM2hFdVZHekhhYktZMmRh?=
 =?utf-8?B?UGdlVW5nMFl6cWUwZXYzTG1IajlRMUFpUkcxUW5WYXRiU2dWUklGMlVYYVli?=
 =?utf-8?B?bmw4TEZpVE01Qy9UOW44V2gvT1BiMjRlbGliVXliUm0xUTRKaUVoVGdrZE93?=
 =?utf-8?B?SkhWaVpUZk1xaTNQOVdMa1QzQlFVVWZaUExLaW5KQ1ZTYUJVdHhhcUtLYm9i?=
 =?utf-8?B?cG15RzI2bHNyTmNpZlZhTjBxQlNMazduNXJFaGNWYm1CRkV5dTkyY1FjS2hi?=
 =?utf-8?B?SjhBT0s2ME5COEtkL3hod2ErMWpJRGEzLy9lTmM5MDh3c3cxVHkva1o0SGtD?=
 =?utf-8?B?VTNMMG9YY1hRdGpYOUtveTJkZmVqaG5pTWF2eGZHWTFBUFhPZCt2WlRBTFN4?=
 =?utf-8?B?V2dSeE04MEtpK2ozNWEyejY2ekdHc3IxcjVnWG8zOTBZajFIZkQrUWRZaXly?=
 =?utf-8?B?SytIWkd5YWF3RkdlVThwYkdvdTNMS1BRbG1Sc09WOFkyL1V4WmFWa0xPcDFj?=
 =?utf-8?B?and5b3ltY2Qrb1crenAvVDBVc0NZY1VmL1JHaGdraVB1WEtLK21wZnZJRmMr?=
 =?utf-8?B?MkQ4VVVKVWNyNFZFTzFNZ1FZYzgyMjB1cU5xNnZxTG5KaWJEZFQzZGtMTDVL?=
 =?utf-8?B?K0xvWFI5QXlZd1Y2WllQRHhDWk9xem45bHpHTlRIYkpHeEcrdVpLUHJ1d2Fp?=
 =?utf-8?B?MzNWWXl1dHhncGhGQmZYeElNT0NKdmFrbGg3RVRGd2VyU2pobUJrRi9hVGU4?=
 =?utf-8?B?L0xNOHFVZlUvem5lME5Bdks5RlBRWU1zTlU1K21WL1Y4S05oTVlmbXRUSkVS?=
 =?utf-8?B?dFJXRmlkMVRQOTNjSlM5ckpwa2ROWmJKS2JwZG85Y3pyVnFFUmRlaStaeGF5?=
 =?utf-8?B?Z2tkVTJ0a0MwdS9JYm5lSFJ4dm9EOGg3ODVRWnBBMS9wajJsRVFHRmJBYmxZ?=
 =?utf-8?B?TDBnVmw3aXI3NWQrejVqSlNqT0xXclIzK2FKOEhXYXFqejNLUSt1MUlESXBU?=
 =?utf-8?B?VXhtSnozMzFXemUzV3dFNmNuWXVPTDlCMzhJQm40eStKa2pDR3NqQjNqNUxX?=
 =?utf-8?B?UWoveHd2OTc5YzFSZE00US9QdzR3Q2U4Q3ZYUHZJUmcxK0MrTnhMVGNGN2Qw?=
 =?utf-8?B?VGt6Wk5NeXlJdUtkeHZaanpUWEZVOGlhdmJ0Z1NzaTNpcHFYME9FcVl6M3k2?=
 =?utf-8?B?VGVpT0svMmlXVmFWcmRzY2JLWTh6QlNIdEhwMENqQVA4UE42eUlTWWhvVTYw?=
 =?utf-8?B?RmwwRjM5RUhrNTZvUUV2NWo1Z01nNkVMdFlZWmE1M1lqdzhLSEFPN3YzSXpH?=
 =?utf-8?B?RDZlSitYajluYXNqWllSRUliT3JjY1owQXh1TGZpVEZjWkIzcFU0WlZyTTNU?=
 =?utf-8?B?OUp3VjNDc0pVYW02dkNINmdkOWltOVorMnpsTVR1T1lwa201d2xVQURiZWRY?=
 =?utf-8?B?L3pqVWl4eEhsNGE4d0d3aExFTklEQmVyOFNveXpBVjhrUmJnNTJ3Q3k0Z3V4?=
 =?utf-8?B?cUswZTBkbVdKaHRxYXVvMEhjNFFWNWFiL3dJMmZQZVNJR3J6cEJFQXRXWmhy?=
 =?utf-8?B?WDRkRzVMV1ZHRi9vSlNIclBuNHdMOUpHcXdFYlJSWVRZRGpTYlBmN3MyMkN1?=
 =?utf-8?Q?pw9w2xOJIAB4A6ff6O1CZnnbn?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e8d06c-7df6-42c2-df95-08dc29181ca0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB4666.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 02:37:51.8203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGjBND5G7tcQeQRphw02ewyhvKwcAYX4RmJZfY/K9QzUezKD9N4W4E3raN3jbbDn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7230

On 2/8/2024 7:19 PM, Dan Shelton wrote:
> ?
> 
> On Thu, 25 Jan 2024 at 02:48, Dan Shelton <dan.f.shelton@gmail.com> wrote:
>>
>> Hello!
>>
>> Do the Linux NFSv4 server and client support the NFS public handle?

Are you referring the the old WebNFS stuff? That was a v2/v3 thing,
and, I believe, only ever supported by Solaris.

Tom.

>>
>> Dan
>> --
>> Dan Shelton - Cluster Specialist Win/Lin/Bsd
> 
> 
> 

