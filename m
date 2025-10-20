Return-Path: <linux-nfs+bounces-15423-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE45BF31AD
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 21:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6ECA3B768C
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 19:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F050D1E511;
	Mon, 20 Oct 2025 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b="l5gq96tZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020109.outbound.protection.outlook.com [52.101.61.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D27242D6A
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987006; cv=fail; b=M7jHcg1B2hWz5WBW1DC7P2anXcsuqvHnHI36+evfEsmcVMr5U4qeQeumicpdLD7E5Vkystg4GcKfF0kqqSrAAosPoD0csTTDCf/d0cg8vVjHz3HcR85/JSGiR/TztwxUwp5MddaG9fa1CPxh1iOOGp+1jxHu/mcMFUikAoWa0z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987006; c=relaxed/simple;
	bh=bebbQYT2U4B+VXjHeHyhDXi+cWGDmoBoDeyyPP/bnqw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TD71NVlH4NaAlnefERaPfoabcpa3jK2EFqZis2Zt7+xy5ktfwq1wkugg7amwC34SNxyPENmXVLlphtH6CmSpIVZ7HTFYki0Mo5Oeq0jBbrAHmYfJ3eRw4qqGQriRZrAD7D5Rj5sgLJ7PWHvjppz04w7pCu7Z9KMpQIIt6eU7P/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu; spf=none smtp.mailfrom=rutgers.edu; dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b=l5gq96tZ; arc=fail smtp.client-ip=52.101.61.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rutgers.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKeZPa75+gFhf3J46h/znkF6d1djWp/RyzDUzlN5J4kztQeT1Bs6Qk3L1/Ez/AEk1pPfNw70RDpKTQE9jF63etHm8ZKJMKGD48JGA3rXUHl1D+QjfJoJA2GPNDwtmnHMPxr0nwev4bHcG/OczquZVkzW09Yoe91scY8aDrScJ5/lBxZkG/euqybC2Uo5uBCL/UaIqjFoC8G8iclcN8yiBAXfr9BPWSEaNXIREcC4QspSA+zIZhxUmNJngCAHjbdMwSSozH0iiAfQQ/L9OsQIN6HqSjvZmN7Fhq1LeyeG0MQOT/qo8AnkdBcDhvEMF+Yg8z8hrdgQMTXLDXAJww0efA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bebbQYT2U4B+VXjHeHyhDXi+cWGDmoBoDeyyPP/bnqw=;
 b=lS1LvouNw8C4vcvFdvLHxCyfbySXFsWFyWSbkTC+P4z3dUYG3mr/Dp67pTuCvPmQZKoAoYOt+ur/Ct9PUrpTDbcrKT7h5nHVxseyHVdGMNR3mqhnBC1boCJrwyCAulIxQXHpClxwliL5PlRUwuEQFjqVNcPpwh+SDyp1w0T92MQwM1hzz4Tetmj1W+ym30LseG03DGgr35UUFgHdi+JoHmSkIRsjoB5wr051j09r89244f27AvtB7luMv0CnwFEa5PHjFX6czMWV7esEcMaEpwjkmGpskuEVdyorCU0+btXDklu7Es5Uz4Zm3jfHjVqoaDhIdSXZP7BB7UF4GqAbgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bebbQYT2U4B+VXjHeHyhDXi+cWGDmoBoDeyyPP/bnqw=;
 b=l5gq96tZ+R0PCLlq6i9WX/1Dj6wsBGqbXuTyEhU08HwFqIe7NEdJOWacyBOnNo9yfYCYYs9r6QQA2nlrf87znDliYTnvHJ0Gj/uFEWzi+aB2VXJThUpZxHGbo88BUTeKrV2VL7JiyykyXjj5XbSJxdDNXjDZAlA5vH15S57vmgyh6+i4E5Xo3uTSEcFbsIQLKhVZNgWxebzBbdFnEYs0KycCvOJ8bDAl88eo6XuAirUCrs8YiGPnp/m3YWPJRrYmwKk3eJs8l1Grzg0N+xsIjqS8djkRkPr5aFzht77d4Cl4qxSktkQ5iK/WBc8D/wM7+uwxvfngnZ0VOZ7F59QoiA==
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by CH3PR14MB6890.namprd14.prod.outlook.com (2603:10b6:610:12f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 19:03:22 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 19:03:22 +0000
From: Charles Hedrick <hedrick@rutgers.edu>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: redhat patch missing upstream? excessive getattrs
Thread-Topic: redhat patch missing upstream? excessive getattrs
Thread-Index: AQHcQfQ00dAdyCCflEicyVD6a9yZNA==
Date: Mon, 20 Oct 2025 19:03:22 +0000
Message-ID: <e1201a1b-1ac2-4408-8a71-95b86b60a13d@cs.rutgers.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|CH3PR14MB6890:EE_
x-ms-office365-filtering-correlation-id: 8cd5c590-ca7c-4d48-4853-08de100b573a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aXorQjNraFlVclNNYW1wYkJ2cTRubTNyWG5WMlF4NXVQdDY2eVQ4dGtmYVYz?=
 =?utf-8?B?WEYwZWI2Smp4Mm83Y1Z4cmZOQVE5dlZORFhjd2UrWk9HYXAwUEY2LzJSTVcr?=
 =?utf-8?B?NytSVmg0V1ladnZaVkZkM3F6V0lJdXc5cS92Nlo4Y3NmZ3JYSlJYc1VqTWpY?=
 =?utf-8?B?KzdKR3FYWmRUS3k4MDV6TTN3Y0JIemNuT3RFdTFHbFhIMjdwZU02eXBsU3Bz?=
 =?utf-8?B?aFd5VGZDSnNNaWFHVjNhdWJTUHRZWCszdHhESTVCK3UxaTdpQ1ZlMTRqdHQ1?=
 =?utf-8?B?N2hhQnF6V1dESU42aHd0ekh6RWN1U1BqeU5lUDVEMjY0bndKdjl0Uk5lZFk5?=
 =?utf-8?B?R3N2N3RScS9ueG5ua1NSM01hWjNiRFc3TE1mSnJFRS9kbGdzVS9UMVErSlBK?=
 =?utf-8?B?bmZ6eldhMVJjK3ZNS0syZmFaZHAwT2NQQjJyNGpzWUJwNjAwRldvMzFIeFdT?=
 =?utf-8?B?Ti9zK0JXeWN6d1cyeFJ2MDQrVFlFMHVqRVZzZFFXNXNxVERGK0t2TDVqSm5v?=
 =?utf-8?B?RkFFVnFKUDNNVjFJMjFTdTdOQlJXWHhDK0Z3ZmQxR1VRaWwvaW02TnZEOFZk?=
 =?utf-8?B?WjBzN2I3Vkw0NWVQS1M3Q3pIVFNNaC9tSEdSWDBZQWoxUUN3OGNFWjNTRXEw?=
 =?utf-8?B?a2RTaXl6WTVOd1RnZWxxcE1CeVloVExTeGIwUklmOVJ6QitSVkhsV0lGWHVC?=
 =?utf-8?B?Z3Z3S0lTUDJnQjR0U3ZmTDV3ZlRFMmFrQlRUSk9qMkVFZ1l1WVBSMFBBZHBD?=
 =?utf-8?B?RDIvY2RFdW80N1NMS2pEdkhYZkFGdkhFaWNld0MzSHArd3dXKzdFUGF2c0lV?=
 =?utf-8?B?Q2Nrb1kxZUFDUXBwQ2xmNW1kTFB4K0IxZkgrK3hhQVRZRm03dC9qWWZxSVRT?=
 =?utf-8?B?THdUNGRJOSt4QnhMZGpWTlo5OXBEY3BpYW45c3NCSU9WL1cwb0V6NUpEUzdP?=
 =?utf-8?B?SGVjUHpRZjR6eHEzSFg2QmJpVFhQdGpNOWNpdXFWRGl4RjJPVFNtUnpJcUhC?=
 =?utf-8?B?MndUS2ZiT0tNUm1hWG02WjBBcFlZdTV1SllwcFFRcmhiNllNMzlVZU51bjlX?=
 =?utf-8?B?MCtwRlIySm42ZGZZangwQXU4UFhhL2I5R2JnZ1JiN0FGajVvb0FQcFR5Yk9l?=
 =?utf-8?B?eHg3NSthV2VUUUI0eFB1a2wyT0o2Ulo3YUQ1MEZ5NUFYVjVDM0wrbVN1MHBP?=
 =?utf-8?B?cFBySStMd3V1SkluMStHWVk3TzJxTGJmdmxsU0ZIYUxLMWpST1VTT043V1Ur?=
 =?utf-8?B?VmZtdW9uc2ZtSUk3V3hJd210SmYrbjBCUzhiT0JOQUdBYnVnSDJsRnlBZlJJ?=
 =?utf-8?B?MndHdWRpbHJtMmlkSWhKdmNJT2FGUDV6Q1UvMnI4dlZHU25uMndsUkEvbUdE?=
 =?utf-8?B?M25CM24vRkVzSCtZbEh2bEF6SDdHVHRJR01rUHg2ZXdqSWtBNjZ6N2RGUWVC?=
 =?utf-8?B?N0JkdUVmL3lyNll2ZTk1Q1IxV1lKblptMk96RG1QVWRwYVhocTVjZTVJMHVC?=
 =?utf-8?B?YUI0RENkU29reXB4Mnp6a1ZSekk4TTJSbXhnZmpxaVd0Q2Z3aDFYa1UxeHJh?=
 =?utf-8?B?VjVWWHg3eVBmdUV5LzVEeGxyVmxBQ2lWQWRHZldiS2gvMEMrbE5nY3VRbTJT?=
 =?utf-8?B?d1BvK3lxTVNBck9oVUFJRk1jQ0k0ZmRIWm1PeEZmVmNpaDI0YTZTSDN3eEEx?=
 =?utf-8?B?RThlcXJEcTNtZUQrN1dNdWFQTnk1YzRGQWJBNDQrYkZ5Yk5qNnNwamRpWE94?=
 =?utf-8?B?RHE0TUVFOE5ab3FxNHlXWkJIN1VNQiswUDRheFY3QTdSMHpwZmVpcy9EY1I3?=
 =?utf-8?B?QjZVZ1g0a3RtMUxlNUI3OTE4QlBtM3phOWwvSGdjSkxkak5uVnRxWTVVS3Nz?=
 =?utf-8?B?KzVLa1hTbmVMaG1oTC9UQ3pINHo5dEZwalFuL0FFTklYOXdqR2lvVXdMSmM4?=
 =?utf-8?B?Z0E1RVp5cnpkMFVXTUdNQ2p0RWE2N2dkR1FPVkFIM0c3amFOZEJTSjNDRnhr?=
 =?utf-8?B?N3Z2RVB4ZTh3MkxlaTR2QWZCR3NTbXhtWjd5K3lvaSs2VkpaZTdBVm5xeUJm?=
 =?utf-8?Q?PV7etC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azgrd2dURnFFY1RGKzdTdUxsUG13cm1URlJRZ09LalFyNmJNRWhOSDF5ZDVp?=
 =?utf-8?B?NUw5MVhCY0x5VzJLMzBPdXFzR0sxMG5nR2JiRU1YbTBXcUJWRXc0dFEwSm83?=
 =?utf-8?B?NUo3a2hYdDhRcUFrZlByRHRYNEFqQjhEbkd5d3dzaWRqTWVObFBxMGRsZlJF?=
 =?utf-8?B?ZlFZRHpxaVMwcU9TSkZINnBuSU1uRjVDUHZqU05kc0Y5V0tGNldWVzhNdWpH?=
 =?utf-8?B?eGZjRzFucENnWEhPYm95cDAzd2pYU0d2cmlmN3R6MXR4d3dQdzMyUEZmZWFM?=
 =?utf-8?B?QkMvQTZFSmxEcUpOZFlWRjB4bG5RckJHMmpnZU1rZnhzZ09Za3hJMmJoaGpI?=
 =?utf-8?B?djBwcEN1Qk43S2xBUnBKZVhwTWM1bEE1VVZJZUhwN0dqV21WeVg2cTBVcmVl?=
 =?utf-8?B?UUx5NG5hWDNrZDNJenBKeXV4VVRVdEhOTVhJNTJVSjIvTUtYNG05MHJRajdF?=
 =?utf-8?B?czgxRGpvZmhFeUlQMUgwNFBra2JENzA2czExTGJLZVh4ZDNMNnRXODVhNWlv?=
 =?utf-8?B?NGhScWNvTFBOVVU5S2RvT3QvWjRxNE9LdnhHbC9MZlI5VjRZWGxpMWNLT1FC?=
 =?utf-8?B?MDF5cm1HM3V1NXVjY2FZUTVhLzVXMU82eWcrMEJGaVk4UEx0cGRjOVJGM2pQ?=
 =?utf-8?B?ZUI0MFo2U1VyK1l1RWttZURaVzc3b3plbnBGS1dIOVZTTXI5dWpuQ1JGanEz?=
 =?utf-8?B?eG1UcU50Y1ViK1pyNE5ZMkEzQkRPWklQU3gwd1pDMm9UV2gwZW9YcU13ZGVp?=
 =?utf-8?B?SnhJOFBpOW5nOFZKUmQ2RGdGYXhUeVFXTnhhWDFzZTZ1b3JxeDdJYnoxQjdX?=
 =?utf-8?B?UkRLZE5zVkVuSlRYOWFXaFNhVlFaWnA5eUVvWjBIZXpiMnRENlRDL0dqQ2U1?=
 =?utf-8?B?MHpiR0ErTzFzQ3B1NEhrcmlldEpPYlp6NmJWNFV2S1pYN3JZdWtZSTBjdk56?=
 =?utf-8?B?YXVTdWRKcEtCdU9mTEdISWdYVTVsYWhNUHZxS2UvMUxrVHg2ZERKdnYya293?=
 =?utf-8?B?T001MkhQZzhGWFMyd0R6NmhtZGZwdGdQRE1oTXRVVjU4ZC9mbUJ4emNLWVdS?=
 =?utf-8?B?U2RNWmFDL2hxVWZRRDEyYjdoZU5tc1FYV0NSR2Y2Yk9RKzlLQVdnMFc2VTJw?=
 =?utf-8?B?NzM2UXdqVVduNStEazJhc0M2U25BVWN5SnptaEc1Y210dlFVcFNlUUhhSHlw?=
 =?utf-8?B?TkRYS0pFUUQzZDh5d01Jbm5TTGphcUJpVHpwd2tPN01QTFZMaGUzNFJBVFZu?=
 =?utf-8?B?MjlyOUZaRmE1SE9Ia1owK01TdkI5UTZXNGFDVHVpTWdoazNKTVlpZklsRHI3?=
 =?utf-8?B?UW5QSTdLRTdrcEhIUjFLTFBiMFhRVVhZQzkreUI2KzBvSlBHZVpTZEJLNTR5?=
 =?utf-8?B?b2gzU1h2cnZLQlVZaXhwbm9yemFEd1RNVG0rVitjbWZqOGRyVlFRTmgrdTJn?=
 =?utf-8?B?cFZNSEtBdHlhOXk3UWZJTEwvS3Y0c0JWWUwrYzRZcXluTVhBTFBMc3hnVzhk?=
 =?utf-8?B?YnB4ZnY5K1h4ekJYQmRvRXZRVXJDZ1RVcG5ZMmZjeDc4MjNBMklndG9SWjZ5?=
 =?utf-8?B?QWRmTUxCd05lU3NaMXdxZXJ2OUEzeHNKc2NvN0cwYkFObjUzdWdBRTRZTFQr?=
 =?utf-8?B?aVhFSnRpSlppMW5EdkpUMUFoeVo0Z3MzNW5DakxYem81NFZVTDE4elZ1Wngz?=
 =?utf-8?B?Z0paNUQzNXRFdE9qOExISUY3eXhjUzFqd0JYSE1KYStCNEJIeGViTlRwTnl1?=
 =?utf-8?B?WkxaWWhBV1QvaWFneEoxT2lKbDM2QkVzdDQvbkszMVJWUmdQVVBGNHVxS3Ns?=
 =?utf-8?B?QnVjb0FrOW12SVVvY2hVMENNS3U2blZpZTU5YW5mVElyam9aZXo4dWdsOTdH?=
 =?utf-8?B?RFZzbTBLb1liRXRnWVFMdktoUkNBdzl2bEloUC93UGtjcE14UjFzaGFDSG5D?=
 =?utf-8?B?eGphMTdZcUdVQUd5UWNhYXBLT05iVWdaNkRiTTlYY3Zpb0xlem9nYkh5ZG9y?=
 =?utf-8?B?WitWdHNsWWdnOUJIa2hGOUczNVUydGhselNpaGF6ZTY5UDNOYWpURHFHU0M1?=
 =?utf-8?B?WTVzTklNaTRjcXU2T25GRmJ3TTUxQURGdnNjVTJoRGF2WStPVklreVREbTFT?=
 =?utf-8?B?V015WlhUVnp2Tm1Pelk1WlpnelM3SHdDam1XMExna3cra3JNZTJuM2tCcmxF?=
 =?utf-8?Q?qCm+Kpz12D0vrGaQGdqOyro=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5D1A6D9735FE044B9487F11647039B7@namprd14.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB5493.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd5c590-ca7c-4d48-4853-08de100b573a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 19:03:22.6910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: umh8c9C+Llk3Tq+NwJMVGMA3rnvVBCJygM6unaD631hXYgnH2uLHbQ/v0MBCLeHjl9mJK24qNkR32UNrU+gM+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR14MB6890

SSByZWNlbnRseSB0cmllZCBkb2NrZXIgb3ZlciBORlMuIEl0J3MgcXVpdGUgc2xvdyBzdGFydGlu
ZyBjb250YWluZXJzLiANCkV2ZW4gd2hlbiBhbGwgdGhlIGRhdGEgaXMgY2FjaGVkLiBUaGVyZSdz
IG5vIEkvTyBmcm9tIHRoZSBmaWxlIHNlcnZlciwgDQpidXQgbG90cyBvZiBHRVRBVFRSIGFuZCBB
Q0NFU1MuIEl0IHRha2VzIGFib3V0IDE0IHNlYyB0byBzdGFydCBhIA0KY29udGFpbmVyIHdpdGgg
YSBtaW5pbWFsIFVidW50dSBzeXN0ZW0NCg0KZG9ja2VyIHJ1biAtaXQgdWJ1bnR1DQoNCkkgdHJp
ZWQgbW91bnRpbmcgd2l0aCBhY3RpbWVvPTM2MDAwLiBObyBkaWZmZXJlbmNlLiBJbml0aWFsbHkg
aGFwcGVuZWQgDQpvbiBVYnVudHUgMjIuMDQuIEkgdHJpZWQgdGhlIEhXRSBrZXJuZWwgKDYuOCkg
YW5kIGZpbmFsbHkgb24gMjQuMDQgdGhlIA0KbGF0ZXN0IG1haW5saW5lIGtlcm5lbCAoNi4xNy40
KSwgdG8gYXZvaWQgYW55IFVidW50dSBjaGFuZ2VzLiBObyBkaWZmZXJlbmNlLg0KDQpPbiBSZWRo
YXQgMTAgaXQgd29ya3MganVzdCBmaW5lLiBTdGFydHMgYWxtb3N0IGltbWVkaWF0ZWx5LiBCb3Ro
IHRlc3RzIA0KdXNlIHRoZSBsYXRlc3QgZG9ja2VyIGluc3RhbGxlZCBwZXIgZG9ja2VyJ3MgaW5z
dHJ1Y3Rpb25zIChub3QgdGhlIG9uZSANCmZyb20gVWJ1bnR1KS4NCg0KRGlkIGEgcmVkaGF0IHBh
dGNoIG5vdCBnZXQgZmVkIHVwc3RyZWFtPw0KDQpBbHRob3VnaCB3ZSBoYXZlIGEgUmVkaGF0IHNp
dGUgbGljZW5zZSwgd2UgaGF2ZSByZXNlYXJjaGVycyB3aG9zZSANCmNvbW11bml0eSB1c2VzIFVi
dW50dS4NCg0KVGhlIHNlcnZlciwgYnkgdGhlIHdheSBpcyBSZWRoYXQgOS42Lg0KDQpJIGNhbiBy
ZXBsaWNhdGUgdGhpcyBpc3N1ZSBvbiB0ZXN0IHN5c3RlbXMuDQoNCg0K

