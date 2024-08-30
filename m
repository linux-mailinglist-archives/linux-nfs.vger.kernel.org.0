Return-Path: <linux-nfs+bounces-6050-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C149966311
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 15:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35301F21413
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 13:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0E31ACDF2;
	Fri, 30 Aug 2024 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhoOZAQV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A142165F05;
	Fri, 30 Aug 2024 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025205; cv=fail; b=Q1q6Ec1Pe7BYk27RJjzI8spUunsHTlnFbS51ADgE/t9EglsekuAZlhb0qn/LhYhFmxAb6d5gBNcdBr+WIN93BZEMdLxqdSAt54giU7ITmFaRwDtABTIaaKnT0TV/B+pd9pJ1AcPmt9NpjPn1yKs5A0iS0rU1Na3CPokwyTIDxL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025205; c=relaxed/simple;
	bh=sW4AsWlzB278vdnZAqDFnA76MAGhT9TzbbJ0fm6v994=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S054uwnuCWDX5uvQZMCGIdLq6/CJqRI5TNzzH44y7ut2mbjVQobCPT/xDwHHblHUp03Ckb506CYMaWpKaf9M4jHJop1XpR+/SIlqtUXVoyNQQVAzvNvjY9GFMGspLYnE5RCNOjQru8iKl3QJabzQqSl7zXAnkAjePIVor5SVVDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhoOZAQV; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725025204; x=1756561204;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sW4AsWlzB278vdnZAqDFnA76MAGhT9TzbbJ0fm6v994=;
  b=jhoOZAQVMTjfqJVZiYldYZUvI1XNUB9HtTUEnskWZCx/2sl9BahLxlHJ
   XcrspMLXTsCvSDe9ORNGm/UYe46jGU/70Umr9wLMiI9XxaA1J5I4qwDmV
   VjDJIshsdmGLMeJpmfXm1jVMg7CNJsS87FY+SQdvy6BLjSb1TiDcIJXqF
   5jmM1crHkFxzHdwy6aS9LX+2J6ptmFDTEotPhRm2M/kFDzTpZD2nMis9c
   Wx1ywnlLcQKpxobNBQX0WbCW16dFwRfwasughIQlaGo430Fwz5ylwVFEV
   5JSwvTelz5L0g6Cg6IAOL/rzmMbmafyDcP6S9dHvFcelZu8p8ITv+xEAV
   g==;
X-CSE-ConnectionGUID: qzyD9gKiTROcgVMAxZs4gQ==
X-CSE-MsgGUID: bkc/dTVgRHGEFj7p4hkYJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23547234"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="23547234"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 06:40:03 -0700
X-CSE-ConnectionGUID: wI5UrvCCS6CaKDrZlXL8ug==
X-CSE-MsgGUID: Q5UFfh7aTHy0M10szYaYuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="63910147"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 06:40:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 06:40:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 06:40:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 06:40:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=en/+r01raDVYPObAaX+VlB3J5pUV7xmZFshTfOu8QFDObHXnC1VJckqXuMPutBhQ6aqmUgrgbdJ2wMkbHxawLrEmD6yN5qjiDSnNr52jExYIG882wIuuc59pmk7hX699Vz4P9eRrg+Vf6kYXRL+FIrdZeedEWBcUxxWf0tZg9cN2FJA2317JiBFeWCJtmWAALHo6K1D5wF/cAbxP64soXTuKKCdfKAqTn8Qli3UQe7n2An8CdZu5hDjcGGzs8dtQEzpGQfh6I4gN8iSvzyb4Oe53/+1qNEGo4Za+2hMfjXwU1SblF8iyViq6IE9/BX/o3V5aHWL664nKRiX27ORprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+369MW/p1lz/ShlduTiolE7MeLFt/Ipv8L2YHoyaLQs=;
 b=wyxQXK0o/57t1qUolcVNnRzWeykYUjx/pyhomVrNM4dOgS8//s9rd7YPs2A0ow21bKaEFGcFgPclwbuybp0Gb32lcTT+z4sI1HWb8LhlCTygbS8Z1cDZr2CreNYO5EaBp+HG+2vlHJH2Xn9gwK4SOFflG8025xn5RPVCFs1ZT0oZuY6lVB6clGiwH8OLEM5NrqlSIBq6ZWB+dKYAe/QD2kVlSsBoVMi+q+k027uBC18AjaJ5fsL4eVYXjLh3SgXWKSHolNG8O0kugwSiJomIc6IA/2vz1Vwv6/8HYlZhoi3739QuiO869mLUKTJjLomb6yPg/YISUM43PSioIAX06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA2PR11MB5132.namprd11.prod.outlook.com (2603:10b6:806:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 13:39:55 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Fri, 30 Aug 2024
 13:39:54 +0000
Message-ID: <92e3c3f9-3ee7-43d4-a4af-70ca87adacb2@intel.com>
Date: Fri, 30 Aug 2024 15:39:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] sunrpc: Use ERR_CAST() to return
To: Trond Myklebust <trondmy@hammerspace.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>, "anna@kernel.org" <anna@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "yanzhen@vivo.com" <yanzhen@vivo.com>,
	"opensource.kernel@vivo.com" <opensource.kernel@vivo.com>,
	"okorniev@redhat.com" <okorniev@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tom@talpey.com" <tom@talpey.com>,
	"Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "neilb@suse.de" <neilb@suse.de>
References: <20240830014216.3464642-1-yanzhen@vivo.com>
 <dd97ad2754112d8b9251fc1a1ce0cd15fbfa7eb4.camel@hammerspace.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <dd97ad2754112d8b9251fc1a1ce0cd15fbfa7eb4.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0352.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA2PR11MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ca0d3e-1fad-435b-184d-08dcc8f93b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?am1GQ1g2b3E0ZkdVLzlTVjNFRVdtbHFqVmhKQVkxQzVmQk44eGpXOGtidnJ6?=
 =?utf-8?B?WlRrQnltd2QybDY3RXI3YTBEa3NMeFV6WjBOWU0zRzQrZTdsSGk5bndtV2Mz?=
 =?utf-8?B?WUQ3V2IrR2VWWE1Nd0NHTzJ1cm13Q2ZsdktlSXYrMkd4Q0pJNGZqRHY5MUdL?=
 =?utf-8?B?S0JOdXl6SFQwMC9xQlRFakdIcDZiUDFLY3pReEdNcURBWktRTzJOeHFsSTNh?=
 =?utf-8?B?dGRsSnlDcllkSHR5RmRSTGZWZ040SkdlSzl5LytDZG9QRlVpTlVxbUI2b2gy?=
 =?utf-8?B?RTFDNC9zMy9ScDREMkw2RTNhbUpBNVlQSEU4QURtL00wN2VXUG9Fd2E1bith?=
 =?utf-8?B?S0MxL0pDaCtoMEJlU3loS3FDVXhCWXR4b1pGMHMrM0JTRk85dDlQNEdSQ2Ex?=
 =?utf-8?B?dmdnREZucWJYRGdCUkFWSWEzYlF6NmVha2VHc1JUempieHZSU1V6Vm5ONVRl?=
 =?utf-8?B?bW5sUEI3NFJINWJlcHpwa1hhcHpGMmhEd0NxNFFWOGNlbGdiVUQ1NWxEWDNy?=
 =?utf-8?B?dEQvT0pJRzQwRUNTZjJabmJtc2RyV0gzZzhFL3hXeUpjRzUxd0czTGJqbTEr?=
 =?utf-8?B?ME5vZUZURDduU0IyT1pVNWF2Njg2NkQ0cVBlcTdjTGhIQkRjejV4czJGYy9Q?=
 =?utf-8?B?SUNpZGc2ek9iRi9WWEZwb3BHSE5TZWR3R3laTlR2YU8wWlNybSt0ajgxdy9G?=
 =?utf-8?B?bFhZZVVoL0M1TUNQbmVuUXp2cmlyZjZXbENsajR4ekxJMUU0NTJKaDd2UHhj?=
 =?utf-8?B?NFRBejJ6ZGFOVjFVN2JVMXA0cklsbmh1RWdLdkp2amFYVXRSY3dTT0ozSUs3?=
 =?utf-8?B?V2VkaGgzQlgzcUY4U2pzRzV4bkxWMDhOd25keTRsRVNYcHVpeEZyenk0cTVH?=
 =?utf-8?B?TjdKTzdoZUpaLzk1L0RxUGdEYkpQZTloNzlHRHllQWZIeFY2SlQ1U3FOKzJs?=
 =?utf-8?B?RmxGemtWRWNOV1BFTWE1TDh2M2tkTTFpaU5iSkw5eTYrL0xCNFozaGtMdEVi?=
 =?utf-8?B?dFQ0YjB0WGNJcnZKdEQwL01MRnNrTnd3aExacXBUMDJHRVhScng0WjB6OXh2?=
 =?utf-8?B?d0I4ZGZ3dFQ3TVNRM0ptRlJCUlB5N0UvcG4veEhzSGY0dG1lbEROK3VNOTdD?=
 =?utf-8?B?RDFKUDE5N2dXZE14YmJySzJEOEtLa2dPSE9BNm5GcVJtbktsQUJPd0hxRmQv?=
 =?utf-8?B?K3lObVBIdlR2YmFWejQ3aFc4WW9OOEo3NjEva01SOG9uZmhnZDEreVpRTkNV?=
 =?utf-8?B?V2VCaG50R0FSQkdSYjdOLys3TGxwMWs2bllmQ0VKVnJJeVhzaFR4aW5oM3gx?=
 =?utf-8?B?ZEJyQllSRUVKdUJVa2tsdG5CNkp5QWREZ0VrZkxCMml4cmZMU1lRTHoyRkdO?=
 =?utf-8?B?TVBwV2dUUXNvbGNsdHpMWm5Ub2w2a2xrVTVMT2k3MWlSTCtGenBubjNzYnA2?=
 =?utf-8?B?VTFiNGRuWlAremNJYlNIYS8rWnFZanJ2Um9xTlVJMExIMUh1UXRleGllYndI?=
 =?utf-8?B?V2dwSlptdmJOOGdkajBqb3BGY2lOZndOWVBZQnV6amtndGZjbHgybjhZVFJx?=
 =?utf-8?B?ako1eWJRaThXSEhlVzJWeG53aXFuMSt4dUNUaVlaNUoyRnV3NW0wSXY0ZWVv?=
 =?utf-8?B?VDZ4am54SGMveG9DcE4vTHdONTMrK1ZJbnFwUmFQTzlESHhBNFd6dnd2cmpz?=
 =?utf-8?B?eG9qL1M2L09PblpVbjdRV2ZYcGkwNHViMjE1aUdsU1NUcWtqazJBTG5XcWpj?=
 =?utf-8?B?U3lXNVVHbFMybzhSclQrN0g1T210MFZ0a2RtV3hFSVVzUWx1K3pmTkR6MUx1?=
 =?utf-8?B?ZW1jeVFOMU5sNlI4bndXdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXFNWXY1OS9WbGNRd2d5amxmOWpKSWs3VXFQOVZicEtQYm9zMVRqb21aeGlP?=
 =?utf-8?B?WXVFNFFXV05kZHJtTzVuTDZNaVcvUWlkS1pxNUdzVnJzWDZJZ1BVZTFNMCty?=
 =?utf-8?B?SHd5WEFTVnFqaWUwTGNrcE1ubFRmMUNzdnlUV2hLOU05L0poVE5rR2k5djR6?=
 =?utf-8?B?R3BXRE9KNVR5MFdjUkp0b3FxVGQzem5lSnlFWlkrR3VTZ1pxbFdnWWM3ZTB2?=
 =?utf-8?B?SHNNYzhzSUNUQm5xditNcU8xOUpHckY2U2hmSHl3Mzg5ZGxRQUc3SXhYVW5y?=
 =?utf-8?B?cjcxTkQrbFRubGxwUEphOVVLRFFuKzVuelp3QkdqR3pqYmx4ZDM2TXl4ZWtL?=
 =?utf-8?B?MnEwSjFlMEx2WWUrcTNWbGliL2pXK1pDa2ZtL1czczNXcHZxWE1kYmpCRWlH?=
 =?utf-8?B?YU1WY0p2eWhvQ1E0SDBWdmRVdFZxYTZMbEhSdXY4SENGOWdwWG43STlvUG1B?=
 =?utf-8?B?WGNhR2I5a1krYlo4RVBGNitVTVNFankvUzNMcmxyYURFUllFU1Z3ZDJiZ0Yz?=
 =?utf-8?B?RGNEL1E0b1pUMFNQUDlWT2NJYVpUTnlqLzdOcjdBL2FrdzBOd1BRVml2dEsx?=
 =?utf-8?B?am5qeXh1a1dUbHg0RGsvV3dyT1dxbDI3YlFoQW1XdEV6NVRiTjZGUmxSQTBU?=
 =?utf-8?B?emZLTWJBL2NXdmdVR09wd2lJckNTNVNoeFM0Yi9NTFdZdzVlQ0xTNUExcEYz?=
 =?utf-8?B?bWNZTCtoWmZCc2loRmZMUGw5MHViWjh4NTgwK1dxQ2M5TUNhdVIwKzN2ajB1?=
 =?utf-8?B?REh5RmxsSjNYUGt6cTRNOWtXZXVZUmtxbERRRWtNWnByVEdFUWI3ejZQZWND?=
 =?utf-8?B?TlFuYitUWmZEaWdhQzJ1S3hveVQySXZzVjFUR3MzczBPMzV0RlcrZ1RKNk11?=
 =?utf-8?B?WWJUMG1ycjZiUXpyNk9XUVJYS2VvbHEwOVpNSndGclZvMkw4M0ZTOWNMMXlI?=
 =?utf-8?B?YVU2RE1leWpQMzRqVjVOYzZMOEw4ZWRVOEtwVGhFU2JlUFozR1k4a1MyN1BP?=
 =?utf-8?B?L3EyK1piMVVMQ2JSNE1meEd5ZC9NSWNVZkcvNXBodjhsaDRIL2prbi9KWUFT?=
 =?utf-8?B?dndON3RTTFNFL1ZNbkI3ek91czV5VW9pVDB2SHRGNTJQUlI4d2licnBMZ1Za?=
 =?utf-8?B?M3lSV3JMZWxGV2ZaWE9FNGdTMUpjU3hOYks2RWNqRGVBVURPbDZNb1Z3c0dE?=
 =?utf-8?B?RDJ5bjF5cTZkZ09abHRQTEJJY0RWMGZTZHc4OW1adW1GVmNZdmoyMWhKQUxY?=
 =?utf-8?B?clcrQ0huNkpqNjZHUjYzN0FFNkJudS8zcjU3M1FHd2c3TGorSWs5c0xNSjhF?=
 =?utf-8?B?NFNwcHU4RDlHcHJrd3ROcXQ2cCtqSnp3YXU3M3Z5QnMrNkZlU25FQUpxZGxG?=
 =?utf-8?B?WnNuUGd1UURVWUozWDZhN1ljbDBqTC9xTVRVS2JmY2p5c24xellveDNMQ0lk?=
 =?utf-8?B?Z2RaTTZKcUk3TU5hV3ZNakFQRVpJNzNYWVZCUHJTNU82aHVkNWxUdHhsVE9J?=
 =?utf-8?B?eDJLOFNNNjZiUjJodi90OWdHZ0k0bkFiWndLZEUwSVgvRVdQSWh1dThSTHBq?=
 =?utf-8?B?RWJnMTJ1enQrZHMzYXpPK2FlaFJyMTRpMFZtVzhvUTdvaWR4c2pjUnZyZTQx?=
 =?utf-8?B?LzN1cEZhWWJ5a0dvbFk5TElIOWxTNGNDejhXbnBlanBDc0tCWS9aQUxFcktZ?=
 =?utf-8?B?RWVPMWNmM28vSG44czZtT0tjemg5MGRVOHZqcFphNnRuSWpBd3g0bm9Mbm9h?=
 =?utf-8?B?SjIwbVNFYkdCVWdraUxybXdPdCt0YVdocWx5V1FMUVEyN01pc1o0bFFXVUJo?=
 =?utf-8?B?elFyc2ZRYjVWb1dWcjJINENsdk93bDBhb2EzQU10YU1rUTV1ZThGZEZrZDlG?=
 =?utf-8?B?a1VCZmp2Z200ZVU2ek1QMEtCVTRXTUpmNFhsNGRDSHFObGNwNzdlbVhMLzRE?=
 =?utf-8?B?ME1XUU95L2I2aDV0a1c1K0wxNTRjTDdtMWt6TzFhQzV0WGNuT0NkZU5ZTS9R?=
 =?utf-8?B?OEVIYkRXcmxuQmFqY3l4dVZqSDQyQ0xzejhJSVR6cGZRLzR0NGI3dlI5SGpX?=
 =?utf-8?B?Rlc0WTZzK0wrZTRRcTdNYlJzL1lqRy9VRitwYzk2UzZEcy9KU3c1Zk1uN3A0?=
 =?utf-8?B?MnlqZ1FGTEtwWEsxTndkTS9haDlCendSemd3Ti9PbmZMajBCT0VQV3JCUmRE?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ca0d3e-1fad-435b-184d-08dcc8f93b3c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 13:39:54.8637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88AEWwmmfRjMaJIHLPcInLHAet+7De1/IkgsMQre4j3GuKd0sueVkoac0gCKYyzW6l2Eqn8mcg7KCJPmWVb5biClN0EArskF9Af/wHSonmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5132
X-OriginatorOrg: intel.com

From: Trond Myklebust <trondmy@hammerspace.com>
Date: Fri, 30 Aug 2024 02:08:09 +0000

> On Fri, 2024-08-30 at 09:42 +0800, Yan Zhen wrote:
>> Using ERR_CAST() is more reasonable and safer, When it is necessary
>> to convert the type of an error pointer and return it.
> 
> static inline void * __must_check ERR_CAST(__force const void *ptr)
> {
>         /* cast away the const */
>         return (void *) ptr;
> }
> 
> That function is literally just doing an implicit cast from whatever
> pointer type it is now, to a 'const void *' and then to a 'void *',
> which then gets implicitly cast to whatever type the caller is
> expecting. Exactly how is that "safer" than the current explicit cast?

I think we might want to reimplement ERR_CAST() using _Generic() to not
cast away const when the argument itself is const.

> 
> While it is great that ERR_CAST() exists, and I agree that it should be
> preferred in newer code for the (sole (!)) reason that it documents
> that we expect this to be an error, I see no reason why it is
> imperative to apply that change to existing code. Particularly not as a
> standalone patch.
> 
> So NACK for now.

Thanks,
Olek

