Return-Path: <linux-nfs+bounces-13776-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B667B2C915
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 18:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089B31890412
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 16:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F00284883;
	Tue, 19 Aug 2025 16:07:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2117.outbound.protection.outlook.com [40.107.237.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280CE1D5146
	for <linux-nfs@vger.kernel.org>; Tue, 19 Aug 2025 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755619654; cv=fail; b=IDiSunvmrrIFKlJMYVX4BCFopEP4Za2cBYXIuGeKQMXy/YQJhrpAThz4v9C5Ehqlx1105Ea+eRP5lhr71R9dZWt+cWzswBvtoSMOZINGVABRoDNR481WKEfVhYTmWSxXnI+b6TVQm/5PKmNJB5e0kG1oSp1mVQbt4KloPXB4+bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755619654; c=relaxed/simple;
	bh=dA2cfHqPYe3WiDnZsulkN6quqMEV3D2Zl1Foo7b/du4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W/07x0HcIrZMH1q8LZTNuwBvmbVjhM2QIwr7llMtsplFhJWoIREoK1NryTI3GiIcS9WV/i98Y6ap/EUq4ulta65iYG2FORe+sgg+ZsFQP+5ThA22UoWwQy33XCshuUF2nzB7RICwlMpSdkfrUdPPhF9TbOS6rruakcAtgv+b42o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.237.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uM8uQm/r+JxYtodskT5c/u9DpSntfHu/glaa+RIBktlxI4I07ctFKbViCv6RVe/RNXLrNnwLIebCGoWMpZaTkzU4M6dhzm1b04ESfjPadDEWGaSpzRKshf46dG9dXDKRStN6KV3plU2yImZm9q/KwQaB3SCuwimMuK3SS2N2UFy0EFhPR+LISOHISYSZBEhvlYL+IBqse/M2yBNPJJg1fkAWWHY1DddDM+cQztSe8yWXbkN+ZrQh42tkQZCvD3kimUGD1pXCKwrw+5TRQqxMrufOaFN6KXwRhoH4mNwE0vpvtfJs5ZVghy2TvVmDFDRaLqA2BoCJpMYiT7X79F5KIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNt7XgVGGtfgisrRl8aJPYPP8vELmflN+ihbDGHLkVA=;
 b=YQiuF35w2t0AQfklHY8LsW1kG0382nLQVK0aLagpC1UDCpNk1xPysXw6jZZwXVW8wVHWZK4uN9ftd9uwzzj9zhQYhqvtwtbCRY+giseQQCClR4QK7WNoNy0VpagzMsxbS+z/McazJfLTWSjqUxmPgkp4C0Pu4ZpcmZrSf/n6LGsLg4HAFNC7MuEvZvVx2Tl9yOddBzsCnNFyEc7wtEWTdvkcNF9X9fh6+wcwkdQKXbm1jpDVOCl05CZqp482OV3KN4JyOLfJqm2wsPH7AnxVzW1MAT9Hl7SAzlW+9dzAdLQif41ylrWM8tQPKZXLxae/9RmyENWlIGUvjCDNTf77yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from DM5PR0102MB3414.prod.exchangelabs.com (2603:10b6:4:a8::22) by
 BL3PR01MB6996.prod.exchangelabs.com (2603:10b6:208:35b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.25; Tue, 19 Aug 2025 16:07:28 +0000
Received: from DM5PR0102MB3414.prod.exchangelabs.com
 ([fe80::cc85:45b5:e6fe:e2db]) by DM5PR0102MB3414.prod.exchangelabs.com
 ([fe80::cc85:45b5:e6fe:e2db%5]) with mapi id 15.20.9031.021; Tue, 19 Aug 2025
 16:07:28 +0000
Message-ID: <23c4483a-1798-47aa-90d4-299adf4679f6@talpey.com>
Date: Tue, 19 Aug 2025 12:07:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfsd: unregister with rpcbind when deleting a
 transport
To: Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org,
 linux-nfs@vger.kernel.org, neil@brown.name, Dai.Ngo@oracle.com
References: <20250818182557.11259-1-okorniev@redhat.com>
 <c4722c18-57a5-49b5-818b-1e46cb4733b8@oracle.com>
 <CAN-5tyHincZxuNL3z5QDZ8Sv1F=fqT1b-3nUt2DVvFhr0MePRw@mail.gmail.com>
 <CACSpFtB3WDtWL7sv3FEyBh7UYiYSwiQwDr42vDck_nVQB_Z2ww@mail.gmail.com>
 <ff15eec1-3827-4057-a116-1f1bbc9bc8fd@oracle.com>
 <CAN-5tyFhDq1Po4ekSYFVkhWTO42CAZJMYWf6GTGQVGo2ndUD4Q@mail.gmail.com>
 <bcf2689f-2aa3-4e6c-be55-7ee42763d0b0@oracle.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <bcf2689f-2aa3-4e6c-be55-7ee42763d0b0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0002.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::15) To DM5PR0102MB3414.prod.exchangelabs.com
 (2603:10b6:4:a8::22)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3414:EE_|BL3PR01MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 09267291-e896-4d13-e6e7-08dddf3a7e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnJNVkRBcE1CcFhhbHI2UndYRTltOEd2SjltbFRWSHdOZ2QxYjdGK2lvakhU?=
 =?utf-8?B?SUJWNjBOWkxOYVhVd0c1dHRvSEZ2bTFRRERjY1hJYUVGQ3FnNlF6UEVVTEVq?=
 =?utf-8?B?Um1aU3ZEK2V2WWw3U3VWZ2xqWS9XUWpFMGxpQ2I0dStVYUJtZXhYOU5pZWxz?=
 =?utf-8?B?c3MxenE3c1pPUzhadUk5cVB6cmtxU1hPNGpoRkpZOGR5anV3dVUxRmFGUU8r?=
 =?utf-8?B?aTNFYVJqeHdwa25BcFJJamNyMnlpditkT003akJ5RWFwZHJMeCtreDJiLytF?=
 =?utf-8?B?RWRISllWYjNxckdkT1dLZml5T1R6aHptOC9TQUl6WGYrTVFkaVR0aTNOVjRt?=
 =?utf-8?B?TjBUakdXTm0xTUd5QVZOaXlWeDZoOGJZbUs3ZHZxMTBUR2oyUXhHeHlyVnpi?=
 =?utf-8?B?NzdOWGZCcEdlS0ZuVnh1cncrZTVmdm9NWTlWbll1ejJ0V0JubklxWklKQXJK?=
 =?utf-8?B?OFVFeGZyK1pkSDNveUlzdzh0MVJSK0paMUt5Y3dNZ0MxcWRyRlNndm16ZWxk?=
 =?utf-8?B?M0tPNWQvVUlhdE8rV1d6cFU5bHNLam9JWW5CNHRaYjUzNGpTZXgrM01LRnJy?=
 =?utf-8?B?MUZnT25lRXN2K2F5WXEyekg4TEtuRUtOeERtalA5L3hrUlZrNy8wYkpsYUwy?=
 =?utf-8?B?eE9oaUxQY2FjbUtCRUJJdmxjdUQ4cVA1RERUVzBHMDI4ZlF2NFJBOUpyZjFS?=
 =?utf-8?B?aW9XM1p0MXhsKzdXUGp6K1RjSDk5alBZTnc2SWtSZUozdmw4MHAvaDNNUUVR?=
 =?utf-8?B?eElHZG1pRStJeDl6bVcyaXliOGUzbWJETkdWdG1OVGNtMEVudXhGL2ZZZWY0?=
 =?utf-8?B?dHUzTlJBVm5pUmRFOTdveENObUFCdWZmRGdsUlMxVUdzYThnTFYvY1ZOaG1C?=
 =?utf-8?B?Z0VMNUVXdXdVNWVBd0pqNlJEb3VrQnc0dnNMWGtMLzhmLy9meCtIeHBDVmV3?=
 =?utf-8?B?cXN6T1gwM2lPdDYxbFo4cSsrYURKSkN6KytRd0IwQ1ZQL29La2lneGZhZE13?=
 =?utf-8?B?aUxNNlJnWnNxb2RHRUxIa2lVaEYxTVNwaStlYXdjc3JhNE4vUjFLc1N5Zkky?=
 =?utf-8?B?eFV4cHhMVCtUS3VxNFFjcDJTN1B1YWVKamE5ekpBRkk4aUVvbUVwRUJHSFpU?=
 =?utf-8?B?YU5HdnFjRXJtZ2l5aU5WL0JwbkxQNFllcmpKNmZqZFRHRWMyb0UxUGZLeEVX?=
 =?utf-8?B?VGpnbkczdnNGeHo2ajZqbklLSUNUREdnUXFkcmVVbkdpQXVRWEE4YzNxTEdj?=
 =?utf-8?B?TkxXa3l3eC9MbWd4V2QxN2RUVTc3bnZ5QTVVNDJ2dWJvRE0zNmRyWWZoLzZE?=
 =?utf-8?B?SnZRL001c1crVUR3VFdheHdjcjRhcmpyMHNoL2ZyK1huTTlLYlVZT01nM3JE?=
 =?utf-8?B?Qm9nNTFXc3dpQ0R0TXNWbnVCYXFpdFgyN1Fab3F4WXNjUlVIQkZrT2R0SE5X?=
 =?utf-8?B?YmpyZUdrSnZZcUpJYW5BN3g2dDNIRVcvcnJVOXVXS0F6cFJsRkZLazhQN1l2?=
 =?utf-8?B?WmlxeHhHcCtLdUtxUFJUd09Ra2QyMWlpU2JqOEhCZDFxNjArSEsxOHQ4SWdG?=
 =?utf-8?B?aEkvNHZKdk1peUN0SnROWGVYZ1FETGhRSFVCNVR6VzlRVFV1NXhsK3E5bWRt?=
 =?utf-8?B?T29nZFY3QXVvdTk3TlF6WWNjMlhDOFhYbW10V3dwSWI5VkVwMEdZUUFyS1M0?=
 =?utf-8?B?Y2VhSDJ3T091djQ3L3lQa1lwUlB2NDhUQ3FwV3U5UGxGcDY3Nkl3dE5ucFZl?=
 =?utf-8?B?VXRLNE5nbjZ5LzRWcGJ2Q0Y3anA1M3dCUk5IVm0wSVpHVktGbWErNFFONzQr?=
 =?utf-8?B?bmtyakdvT3crekxqM2l4d0VoWmVhUk52M1NTdFgzUmJ4R2VPTHdnZFF6Yk1Q?=
 =?utf-8?B?dVIxVTU3ZVpNVFhQcmpUdVFlbEhSRGJROVh4UDhkRnQ5d29SUUYyOW9lSmNC?=
 =?utf-8?Q?MZMu/an4vBU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3414.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk9MNU91cis1a3BpMitzcWd1L0puZkF6NkZXUEU3Y3RhcTM0V1Zlb0lFNXFq?=
 =?utf-8?B?c3VWYUNLanZDMHkrRjFhaDdzeDFqKzkwYmJWczViOUh6VDFHaDhwU2poYnlR?=
 =?utf-8?B?ZS81aDFwOUVHWjZLTHdSa3JBNzZybS9LSjR1RDhSWUZaRDlZTWlXWDdiR3dD?=
 =?utf-8?B?cUh2MXJPckdRM3laTjNVZmJxeGlKL1V5d1FSZmprRUFGQXdDSTNGbnh4eU5z?=
 =?utf-8?B?YjFzTHVrR0hvd2Y2Z2dzTHVRYzVWUG9wY202K3NiQjZNSUdrM0RkRTRPT1VZ?=
 =?utf-8?B?Yzk2b0g2VCtKd0RHUXFoM3ZXVGlzUm9TeXVjMHpLTVFYTXNxMDNsNXlFMDQ5?=
 =?utf-8?B?L1hTT1plRy9TNmp2cllId3BUbTdJakZqYUJQTHhJT2VCNVNzd0VXSVE3V0t5?=
 =?utf-8?B?aGwrZ09hWTFZWk4wUG9sQW5YUU1RdWwwYTZyWmpNeE56a0VldEd6cDJocFA5?=
 =?utf-8?B?bzdpdnlKUy9DOGhscGo0S2dNM0pqZm1ZeEJUMDRJWHM5bzhIcmVSMUVsSkFw?=
 =?utf-8?B?aTFTT28wVDgrbTdQMkdHVWdYNC9YSFhSay9uKzFucTFqUFlPaFBWZ3piUS94?=
 =?utf-8?B?cXlYMGRESlRJWTlQSDh3a2h5SDJaMDNXQm5PN2J3VmxubHJ5T2hsNmgySFdY?=
 =?utf-8?B?Qld0SmxPdk1EVVB6cytPdmFvdXEyWWNpM05zN1hUdi9hTzdLTWUzWWRHU2o2?=
 =?utf-8?B?WUd2TjF0Nm93WXJESFNrVVhaSEZFdWdGMDBkYmx3dDdLNzh1eUZxVVZtR2dR?=
 =?utf-8?B?N3dzZGltTmVEN0QrdDhoQTNUbWk1TVNHTFk3c2xnTTJXUEFvTmlaWVZnZ0o0?=
 =?utf-8?B?Y1dnWWZUUVMyMS90T0s3SVc2QmxvVzE1dExTTjNhSjVtMkRZaDF5SUtLdzRJ?=
 =?utf-8?B?TUpBL3QwQmpxb2FjYmtKZGV5dGNXclo4QXE5dlFFWHdkUVJMalZEcGxyVzlt?=
 =?utf-8?B?R09kM2E3dW9QdkVENUYvSkc2aE1qRWM0b0ZIYXZNaks4OHFGTWlEMG0vVGRD?=
 =?utf-8?B?TXJJU0hlR2VNS2h2OVdaN08raE1RZnlVTktlVi9mczlNT093Mk9tbC9iTTdz?=
 =?utf-8?B?VFpDU25ON0orV1V5OCsvZ2JxMXBmK3c2MG9CMW1wNXNYOVRnUkRoWHZsKytZ?=
 =?utf-8?B?UXNsSmgyOUFKeFVVSGFuWlhpREpFSng3TG1wRlh0QWJZYTZjaDViS1dIUWhH?=
 =?utf-8?B?SFJ3c3BuL0VQa1ppUm5xRGhxWkcxall3WVhyQWNwRDdmcnN1STJjcitjdmxF?=
 =?utf-8?B?Wlkxd3ZUdUtUQ1dYcHlpdXU3YUwxYWl1Qng3ak4rejZDWUJsVTdCVmY3VjNJ?=
 =?utf-8?B?ZjR3dUVXRXV0TnRoam14bmhjSnhaQWtJMFI4cGVvMDJ4cWFtTDNBOEdpcXc4?=
 =?utf-8?B?MFFDblcxTUxvUnV5TEo1enN2ZDBvUWVnMVdZVDZtaXNkYlhDYUlxL3M2cVQy?=
 =?utf-8?B?YWNNWlp5MGRrMVdxb0FNVXJSVmNJNWYwWmh1bXhkS1BRVk4xcE1XSzllVXQ0?=
 =?utf-8?B?UXYwQ1pYTFhMR2kyNVRuTUhzTUpIbHRnc0pRb0oxdUNURzVqQjkxcHp0Zkh3?=
 =?utf-8?B?Rzdrc0x0Yko5UFZ4clNaRFYvWVd3TFBtWlRuRVZidnV5M25vb3g0MjBxbjl3?=
 =?utf-8?B?UkRmNkhGQWRTZExwQ1A3OUFpSUlROE9mRlVvTDkwS084RVdWTTJ6d1BsVERW?=
 =?utf-8?B?c1JoS2tqSHZuWEJFT0hpYlM0aDA5dCtFM096eVVsd0ZIdGVWWlhGWGkrM25a?=
 =?utf-8?B?dVh5Y3UycDRXdDFMZjBCcFhpaDQ2emRzMUU2dlhSMGlxNkZSVnJiTXcyK00x?=
 =?utf-8?B?dUJxUkd4blN5ZFZtV3U0NE5TZmt1THVXRmRaMGUxbFpCYkhmSzVaQk5kcE5F?=
 =?utf-8?B?aFpxRnFPMENwZy9Qc0ovOVhyTkJxNmZTL0ZiSVRWb1oxTk9YaEc2anBoYU1Y?=
 =?utf-8?B?bWVFQ3lXNFJ5MEx6bVlvc1NPdEZVd3dWUEJoVm1FeVBQV2pyWXFxNitWVlBr?=
 =?utf-8?B?OWZiRC9sem5yNGZ0VWU4bW5xTnhNVlp5UjJLem9PVEcyOHhPSUx3WDhKeVVl?=
 =?utf-8?B?bDRaZWw5MXI4N0hhK0R3dGlTNEpFUmZIVUdpY3ZHTDN0bVo5UWU4bmdNV1VK?=
 =?utf-8?Q?hKf+6Fky6UeuvRrQp/sCduemC?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09267291-e896-4d13-e6e7-08dddf3a7e93
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3414.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 16:07:28.2496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzXWqmXPZbuFX2KyJD6w/tGx9xgevMu/whegHTV18uwJ20K+mUEyLDmwrhyldKoy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6996

On 8/19/2025 11:28 AM, Chuck Lever wrote:
> On 8/19/25 11:14 AM, Olga Kornievskaia wrote:
>> On Mon, Aug 18, 2025 at 3:36 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>
>>> On 8/18/25 3:04 PM, Olga Kornievskaia wrote:
>>>> On Mon, Aug 18, 2025 at 2:55 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>>>>>
>>>>> On Mon, Aug 18, 2025 at 2:48 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>>>
>>>>>> Hi Olga -
>>>>>>
>>>>>> On 8/18/25 2:25 PM, Olga Kornievskaia wrote:
>>>>>>> When a listener is added, a part of creation of transport also registers
>>>>>>> program/port with rpcbind. However, when the listener is removed,
>>>>>>> while transport goes away, rpcbind still has the entry for that
>>>>>>> port/type.
>>>>>>>
>>>>>>> When deleting the transport, unregister with rpcbind when appropriate.
>>>>>>
>>>>>> The patch description needs to explain why this is needed. Did you
>>>>>> mention to me there was a crash or other malfunction?
>>>>>
>>>>> Malfunction is that nfsdctl removed a listener (nfsdctl listener
>>>>> -udp::2049)  but rpcinfo query still shows it (rpcinfo -p |grep -w
>>>>> nfs).
>>>>>
>>>>>>> Fixes: d093c9089260 ("nfsd: fix management of listener transports")
>>>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>>>>> ---
>>>>>>>   net/sunrpc/svc_xprt.c | 17 +++++++++++++++++
>>>>>>>   1 file changed, 17 insertions(+)
>>>>>>>
>>>>>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>>>>>>> index 8b1837228799..223737fac95d 100644
>>>>>>> --- a/net/sunrpc/svc_xprt.c
>>>>>>> +++ b/net/sunrpc/svc_xprt.c
>>>>>>> @@ -1014,6 +1014,23 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
>>>>>>>        struct svc_serv *serv = xprt->xpt_server;
>>>>>>>        struct svc_deferred_req *dr;
>>>>>>>
>>>>>>> +     /* unregister with rpcbind for when transport type is TCP or UDP.
>>>>>>> +      * Only TCP and RDMA sockets are marked as LISTENER sockets, so
>>>>>>> +      * check for UDP separately.
>>>>>>> +      */
>>>>>>> +     if ((test_bit(XPT_LISTENER, &xprt->xpt_flags) &&
>>>>>>> +         xprt->xpt_class->xcl_ident != XPRT_TRANSPORT_RDMA) ||
>>>>>>> +         xprt->xpt_class->xcl_ident == XPRT_TRANSPORT_UDP) {
>>>>>>
>>>>>> Now I thought that UDP also had a rpcbind registration ... ?
>>>>>
>>>>> Correct.
>>>>>
>>>>>> So I don't
>>>>>> quite understand why gating the unregistration is necessary.
>>>>>
>>>>> We are sending unregister for when the transport xprt is of type
>>>>> LISTENER (which covers TCP but not UDP) so to also send unregister for
>>>>> UDP we need to check for it separately. RDMA listener transport is
>>>>> also marked as listener but we do not want to trigger unregister here
>>>>> because rpcbind knows nothing about rdma type.
>>>
>>> rpcbind is supposed to know about the "rdma" and "rdma6" netids. The
>>> convention though is not to register them. Registering those transports
>>> should work just fine.
>>
>> Question is: should nfsd have been registering rdma with rpcbind as well?
> 
> Solaris doesn't register it's RDMA services, so I didn't implement it
> for Linux. There's no reason we couldn't, though. But probably not worth
> spending time on if there isn't a practical need for it.

My opinion is definitely no to registering RDMA, until there's
a desire to use it on unregistered ports. And even then, the
clients allow specifying the port as a mount option.

Really, portmap and rpcbind are (IMO) artifacts of the 1990's
Sun Microsystems computing ecosystem. Let's try to innovate
in other ways.

Tom.

>> __svc_rpcb_register4() takes in: program (i'm assuming nfs, acl, etc),
>> version, protocol, and port.  Protocol is supposed to be a number
>> (below). I don't see how "rdma" can be specified as a protocol/type.
>>          switch (protocol) {
>>          case IPPROTO_UDP:
>>                  netid = RPCBIND_NETID_UDP;
>>                  break;
>>          case IPPROTO_TCP:
>>                  netid = RPCBIND_NETID_TCP;
>>                  break;
>>          default:
>>                  return -ENOPROTOOPT;
>>
>> We can register nfs, tcp, port 20049 but nothing that would indicate
>> that it's rdma. I have grepped thru the rpcbind source code and didn't
>> find occurrences of rdma.
>>
>>
>>>>> Transports are not necessarily of listener type and thus we don't want
>>>>> to trigger rpcbind unregister for that.
>>>
>>> Ah. Maybe svc_delete_xprt() is not the right place for unregistration.
>>>
>>> The "listener" check here doesn't seem like the correct approach, but
>>> I don't know enough about how UDP set-up works to understand how that
>>> transport is registered.
>>>
>>> A xpo_register and a xpo_unregister method can be added to the
>>> svc_xprt_ops structure to partially handle the differences. The question
>>> is where should those methods be called?
>>>
>>>
>>>> I still feel that unregistering "all" with rpcbind in nfsctl after we
>>>> call svc_xprt_destroy_all() seems cleaner (single call vs a call per
>>>> registered transport). But this approach would go for when listeners
>>>> are allowed to be deleted while the server is running. Perhaps both
>>>> patches can be considered for inclusion.
>>>
>>> You and Jeff both seem to want to punt on this, but...
>>>
>>> People will see that a transport can be removed, but having to shut down
>>> the whole NFS service to do that seems... unexpected and rather useless.
>>> At the very least, it would indicate to me as a sysadmin that the
>>> "remove transport" feature is not finished, and is thus unusable in its
>>> current form.
>>>
>>> An alternative is to simply disable the "remove transport" API until it
>>> can be implemented correctly.
>>>
>>>
>>>>>>> +             struct svc_sock *svsk = container_of(xprt, struct svc_sock,
>>>>>>> +                                                  sk_xprt);
>>>>>>> +             struct socket *sock = svsk->sk_sock;
>>>>>>> +
>>>>>>> +             if (svc_register(serv, xprt->xpt_net, sock->sk->sk_family,
>>>>>>> +                              sock->sk->sk_protocol, 0) < 0)
>>>>>>> +                     pr_warn("failed to unregister %s with rpcbind\n",
>>>>>>> +                             xprt->xpt_class->xcl_name);
>>>>>>> +     }
>>>>>>> +
>>>>>>>        if (test_and_set_bit(XPT_DEAD, &xprt->xpt_flags))
>>>>>>>                return;
>>>>>>>
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Chuck Lever
>>>>>>
>>>>>
>>>>
>>>
>>>
>>> --
>>> Chuck Lever
> 
> 


