Return-Path: <linux-nfs+bounces-6641-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B159856CE
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 12:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B95A1C21276
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 10:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C9A139563;
	Wed, 25 Sep 2024 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Mg9PGdAC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA601EB36
	for <linux-nfs@vger.kernel.org>; Wed, 25 Sep 2024 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727258466; cv=fail; b=Vh0ufJtkEGVwKlb9wRifsWCY/yRiHlnvMdWmtfq2qxdn0pv/mJAmw43vjxyWiaITT6Raa1YxDF9bhAELjsOja3yvLIyo6mNf9He5WOypARJo2wvJP4ySr/x76cMAC97HGQucP9WctQ/5BxayMLqQnVJf4YtKOT061Jv+pA/sc44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727258466; c=relaxed/simple;
	bh=Pi7Rdq5iLEYYWeDFSqZc6jHeNY/C/HarK6RO+vRaXiU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u+JnLWuSy2W0EMw+nB+KQt+7JaUY13FaLMG4+Z+e+HdgG0QDeLoJcJO0jitFla6a9cfbIkRdaH7hh/ZkpxWW5d2SaJkP+J5uEWiZle016e6qXpRyzvCEh/0T37YFbdyHYwZ9NgZHWEj891FTOIGQolxAPIaajps6nc0oh5vQn7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Mg9PGdAC; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1727258465; x=1758794465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pi7Rdq5iLEYYWeDFSqZc6jHeNY/C/HarK6RO+vRaXiU=;
  b=Mg9PGdAC3v9tCVDo94I478Doq4tkkG+5lOhJHszUby092cZgtFe+JhtX
   d/RIt5fFUkk+gHG783gNGDs7OPfMy2ahC6EKF4oRGSGzdaXA393lGvTgy
   kjB98aj3v9PODTEIXCKokyhLSSAhZbiLd0hgYUrBHHKciVoOG8+MrOww6
   msUL7wRSpjmm4fntG0B1QjFcH9e7SMWhQM/vnGpjqGn9Rv5nSGLW57+Ek
   ir/smyeu8lMRunjhEMsGcvfPdEqw+mMPiGzcqiD4ojKRdYR5x1lkoIt0l
   4FB2SK0h/GygciDjgirU+40FWGL1EAWdF/GH+mJfWAYdjvPZ/AAbdDqy+
   Q==;
X-CSE-ConnectionGUID: xw1NVaC/QA2OSLLJk3myGQ==
X-CSE-MsgGUID: dfR+j5IxSKSrmYHWwgrxnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="131310561"
X-IronPort-AV: E=Sophos;i="6.10,257,1719846000"; 
   d="scan'208";a="131310561"
Received: from mail-japanwestazlp17011031.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.31])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 19:00:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5RfpCT6fUNAtxFjQo9Bzysx3Ix7zZbf7opONU9ccdU39wEKfDctMgBQsdNTc820kBomBo3xNRrp3Xcctg6NhaGg8OxCxhEFGghgwzLd77cucK6oHw2KdeLEmJroqrYoho6sMQjYvdM06EThgZKDHlUp27WNGT9WeQXwZ1sjb5c9Nl5kwEO5xqJfVz13Wcdfwf8wjoHj9lkZhyMeB9iMsDQN62Er3xgnyVsgIdmdWLNX2zdshTUYrudTvUeliSesiiOMkPe/pRGqkSD2zLBgNi3kCgj6Q8Bj9uTRcLD3Zyxu7VPuD0NcNeobwau7ovDECOME0NNygr4ANTJrdI/2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pi7Rdq5iLEYYWeDFSqZc6jHeNY/C/HarK6RO+vRaXiU=;
 b=UmtG5YQM1PLznkTspty8fmNk7Ene2e+iXLIPfAwU/DvYgURIs+kPzqOZ+hj963uejEPnqwHv1iehIVdJPbkH2jZ1uLHJaxWCkQ3Pfwfl88cF6y5+ytSUAcJ4KEzkvCajvBVKFA1a2rOenZah1J9Ev4sEojWDr9r+PWCULCqR4CSMqkyOgrtM/4nMlYmyAHkfcmqD3rzAMqQPPhE/AZgb4flgVLbazvbI54mVOyW7I7ZmurXBgNjBaGl65013t6r3hfHWjrveQ0MnqCx3C/BZUlnkwh1z5Gb0xFWn7xGjwTmrlaeVtm2u6+Mevx7eZp/X51lgh6gj1RyDDaMkxcmh7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by TYVPR01MB10654.jpnprd01.prod.outlook.com (2603:1096:400:29b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 10:00:51 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::c7ba:1496:7444:dfe3]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::c7ba:1496:7444:dfe3%5]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 10:00:51 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: Chuck Lever III <chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"ltp@lists.linux.it" <ltp@lists.linux.it>, "Xinjian Ma (Fujitsu)"
	<maxj.fnst@fujitsu.com>, Steve Dickson <SteveD@redhat.com>
Subject: Re: TI-RPC test failures; network configuration related?
Thread-Topic: TI-RPC test failures; network configuration related?
Thread-Index: AQHa+kqUwHC9Nu16i0Wh/dCilVxUmbJUYksAgBQMtXA=
Date: Wed, 25 Sep 2024 10:00:49 +0000
Message-ID:
 <TYWPR01MB12085B32EDB006F5C99DD8E95E6692@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <662B8BF1-099A-4CD0-94AB-267BE738130F@oracle.com>
 <FB5CBAAE-D2A4-42A2-93D3-FE2C893871AD@oracle.com>
In-Reply-To: <FB5CBAAE-D2A4-42A2-93D3-FE2C893871AD@oracle.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9NGU1MzAwNjctMzNlMi00YzIyLWJhZDgtOTE0OWM0NDU3?=
 =?utf-8?B?ZGY3O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA5LTI0VDA5OjAwOjEwWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|TYVPR01MB10654:EE_
x-ms-office365-filtering-correlation-id: 09a65026-1224-46dd-f781-08dcdd48eed6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UE8wRlk2MHNEL0grbWJiL3lnTzlzWm1JLzFmNGIxZjkyV1VCS0EyUTJxUUNL?=
 =?utf-8?B?T3RDcGEwQnJCdldobi9XZkV0Yk1SeUhvcHlPUExxRXh5clArTGNFdkdSTG56?=
 =?utf-8?B?YWpBOG5oUVZEUDVHTDlMQU5EZ1lJSm5BQjE3UC9lOU0yNkpwNURGTWQrV2Iz?=
 =?utf-8?B?NkVEQStPOHFwTzFsQXU2bVRxZjQ3b1ZWeHEvandIaDVrZWdja0toMGpsUkxu?=
 =?utf-8?B?NVYzbzBTRjNzUDFLTy9FdzFFU2pUa3dsNWg2YjBoWmFNRlM3QndYbHExQ2dM?=
 =?utf-8?B?djZxOEx3RzJYU2N0d2Y5elJvUHR3QUNKZVJrUWl3YzZvUlRabEo4Q2YzcHNi?=
 =?utf-8?B?TVJMdUxFVjFFOEo4VkJiRm10ai9DSHI3Ykk5bWRTbFhFQ0lXU2czeit5dGMw?=
 =?utf-8?B?bkNaL29oM2k1MG1kaE9oMFZQRFFTQW40Tlp2Y0RDR2JPUVR5cDZDQ0wrQUlV?=
 =?utf-8?B?bW9YZ0UrTm1oU0srOXdSNEFlSFozTTduTjNCOUNQUDYyOGljQWlBZThXNEUv?=
 =?utf-8?B?d25SZHA0dmJNeEhjb29oZHVjalZ1emhMVmpnMjk3SUJaTm1vSHFsWjhyanE0?=
 =?utf-8?B?TDNKeFZyczhGS2NvNDdubkJrQ1ovNktodTFHaEFFVGNicFNYdllSVE11YmF0?=
 =?utf-8?B?U2dlaEZYLzJ5VHhJclRIbHFka2VpaWVaTzBnNmJ5SXVsNkU1QmV3blV4OUtZ?=
 =?utf-8?B?Qy9NUnNUN0ppVkxxYUJBTmMxVzV3TnNyL1FJVHFoK0NVeGlneUZ1VldXUTNR?=
 =?utf-8?B?SnRqS2VnVTEreUNpSzNXbjBJT1REcFRnL3p1UW80dXlvVXNCS1ZDZlBwQkow?=
 =?utf-8?B?QXJyRE5OekxlN3krMit5aW91YTVhL3crem5vMXh4YStiaVN0TmMrSGpEdW5n?=
 =?utf-8?B?aFBFTlkrOEpaMEFveUlNNGVTL2tUUms5cDJPYWhkY1Nxdkh0dzVobmhTVmVr?=
 =?utf-8?B?VFNtbWY0SUJ1NDhkQmNzQ2JMYk5NcUFEaS9oV2IwZlNUVjljUjFEZll3aFRK?=
 =?utf-8?B?Ykp2aHdDU1Z3S3RRRXJpK3V4OUFYTlI1WWRHWGpFZTZBNmV2Rk5vcFRkd0E3?=
 =?utf-8?B?bVN1RHpsSDdRWTVzbERzTFpPOVhJNTludVJoUHFlSzA4UE0rUzFTU2FZbk9Q?=
 =?utf-8?B?NDJNODN4UitRM2xlOTVKR0UrK3FDUDFNeFh3b0JiQWMyRTM2eE9pTzM4UmUz?=
 =?utf-8?B?ZWQ2aXJ1RTVnTXhBVFJETnh2Lzlvdm9icTV2MlN4UXJtN05Mbm8vOFBUMEZl?=
 =?utf-8?B?emFaSlFTTmg5MHNqZjhCRTVsck9UdUppbjJRc1hTYXNrUDdPYW9wdWplVmpP?=
 =?utf-8?B?MlhxL1pGUlBxME41aUpKSklxWkVISUFkL2dmdmhlbFpBZXhBdExzaGdlK2hI?=
 =?utf-8?B?UUdYai9xZFl5b3B1UE1zQjlLZzg3dUVxMHl6MjVOTDNhOHUvMjl6SzJVOVIw?=
 =?utf-8?B?STNzbWJjZFkxNm9adVhkZEQ1YTdPaE9kWjQzL2pLUDRXSlhDSGJGWndmd3N1?=
 =?utf-8?B?cWdpc256UEJVN1c5cGlTRjFXUHVxcGgyTlRnTzdWd3BqRmt1dFptb0dTdlNN?=
 =?utf-8?B?ZXhjR0JUZCtjMHNTRVFqMnZFaDBoWHdjQWhOZXBFSmZZSXdNSGh0bnVCOEVL?=
 =?utf-8?B?bC83czQ4QVhhUnROVWE4cmdWVkRHSlExQWVKcEd5clBISW4yWXE4WTd6Y1ZB?=
 =?utf-8?B?RGdmc0tVczNUbDN6Q0FkaWM5a2RwOFRNSm4wTUNCdGFLTjFPN244eUJuQTRv?=
 =?utf-8?B?cmZUMUhIMWFzZ1NWUWJTeHBYK3BPa3Vpd1M5WkFTWTllUlhDUjl1QXZSY0tl?=
 =?utf-8?Q?weg8R+dhPidl74tNeVF+DRVQktyDZoUZFMnkA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVBaODZMSHFRWHNUeDVGVEk5bnUzTjRJNmRlTDViZnkzNHZMRWJGbTNqTW1l?=
 =?utf-8?B?YzRBZ1c1RG40NXJCNmFPejhlRTV6TCtLK2ZKMmxER0pRYlBqa3VqdW1ISklI?=
 =?utf-8?B?WUU0eWpGVmxIYngxVGNVdWt0SytreXd2dWJIam9rb2pwTjhXZjUwcDloNkp4?=
 =?utf-8?B?T2VsSUtGdGVqU0hNYllWdGN3dnhTMUNFcGx6Yk9jU21mUE5zZ2RwTytNb3RU?=
 =?utf-8?B?cmJNcW85dDc3UVI4QjJDQmZPMnZ1TmlVNmFESUNybmxVcXh0ampHZzN4OUdl?=
 =?utf-8?B?YlhoMzdCMm9rZWtZNS9sTzY0QWVZZWM2VXlxS2V5ajhRWjJxWWU2OHF4TXV3?=
 =?utf-8?B?Vi9NaElBOHdlYUVRblo1RU5zZkwvNHdqUnI0c0hFbDluWW5reE4wRlBSaTV6?=
 =?utf-8?B?dk5BUTlJMW1FOGE2TlRXVXFpTHU3Z1ZPR2NpRXozZWdzWXFZODIrU0x6Y3hL?=
 =?utf-8?B?dkpBSGhoZ00rNVd6R1EwVVN4NjBKd2NWVWQwczF6cENmMzNoWjJBWGROOWNM?=
 =?utf-8?B?R1JPQ2ZyNTdqakN4OEpmQlcyWHk5MzVvTEJUcExzZTRBNnFBblhRd1BZVHdR?=
 =?utf-8?B?eUJocWRNUlE3VWd0Y3VLRjIrZ25NcExGWHprbnl4NGZUK1lMelJRYWQ3REt5?=
 =?utf-8?B?Z1VBSmlxRktVY1d6QUZ4SGlOUE16UGxxWi9ZT2k5djc1RmxzbkRUMExDNjhQ?=
 =?utf-8?B?NUhueUhsZU0rTTViWnhXaVZPQkFuUmVDK0M0a2RoZ1Z2VmdiMDZpZXBWLzhC?=
 =?utf-8?B?NkZYbURObEJRWXp4dXdBWkdGcis5Qkp4TEM1MkFZbDVNZDM1QzNmNS9nbmVu?=
 =?utf-8?B?M2JEMUhKQmQvaWpLWkFONWNCc3MrVHgxOGxoUlNHWEhFbVU0WjZNSHIvUTZH?=
 =?utf-8?B?M2FZNTJVRGZMWXJDUnNJNGh1d0tHVHBCNERTeW9jVU5PM2R5VmJETGdROGMz?=
 =?utf-8?B?RHNldFhYaE9XSFhVZmNMd2MxZW9LbEJqV2FiS0JLTm9KYW5ZRWJEVjRDZE5p?=
 =?utf-8?B?VkkwWURuMnF2YmNZRHZELzhKd2x3UDFhRnNkalFOZ3A5VElDSGFibS91azdt?=
 =?utf-8?B?VnUzQW8wQjFBc1JOZ0ZxZW9aZVIrNGxoOFBnN0l2MCtCMk5VTXpyRUNYNDZ1?=
 =?utf-8?B?QlpsbzN1ZGRONERCb0N0Z0ZRODNUbXcxZDh4NkduNitaTnZBYTlXbTFDWDNK?=
 =?utf-8?B?bk5CY2FPWkVrVUk3MUF0WmVhZE80Y2VjbVQrdUZCbndKLzByQjBoT1hpc1lP?=
 =?utf-8?B?RTNWOERQRlkybTE2TnUxN2h2YXgrRnZkbkpnVXpGK3FJL1JwNGhmcUE4QVRX?=
 =?utf-8?B?c2IxcUZRa3B0RGFwaUQyNms1WnRVMUZ0bjNuN2s0UWNsRjVVTFByR1U5Z09k?=
 =?utf-8?B?aEoxRDBnbWh5WFU1dlFJbFQrWDlzVmRhU0pwL05KZzMra2VEZ2JHMVEvNmtj?=
 =?utf-8?B?R3Z0cWdOUDhTM202bTZRQTJSMFU5SHpkVU9qa2pQVGU3QU1jSDRYcVBFVkFw?=
 =?utf-8?B?KytpalFrclZ2aUEvYXFFKzMwQTE5VjRqamFVRVgxcXd0SXUrVGpFMHZsWGxP?=
 =?utf-8?B?bmFNK3JTN0hBVzJoL1UvQUtvOFpNK1hkNjVFWVg3aVhvL1NlQlFXMEVHMWND?=
 =?utf-8?B?UmVTSmJrRGh3S0Q4WVVYUVdiK3RVSWVtVzRXVi8rNXV1cXZVd0hsM0h5VTJl?=
 =?utf-8?B?dWltY1lVcEp0Y2pOY0xWZU01WnFsVFNkM05oN3hXSEJaTEk3MS9wT29Dcktx?=
 =?utf-8?B?WlhaV3VtSWZCKzV2WmRnM2lhMjhJeHAyTVB1MFIwbER4bUR0MGtQc2g3MEwz?=
 =?utf-8?B?ZHEzNmxzZ3Vzb205djN4WEhkb216WWQ4Y1luRHJuV2RBNHN6RXYveWlDSXlQ?=
 =?utf-8?B?YktwcGlJQnBCYXN4bXNaRk1QZXpsNVZnRTI1a3NEWnhCYlRibEJLNWI3b2xw?=
 =?utf-8?B?clZLMytVWTdJb1B2M2lhaUNRQTh6U1BhbzNCS1dYd2pCdGxRSGpBSlJJYS9o?=
 =?utf-8?B?YkhHQWxSTkJhT2s1S1BoMFdBa3B3eVJ0K3M3alA2cVVUbkZndnRpTWlXNjJa?=
 =?utf-8?B?L3ByVlFXRnAzeW9QM0RiVjlmL1lnU1hTa1RFU2w5My84UmRNODZZYUhBOFYv?=
 =?utf-8?Q?jCzyGfrL3j/kaIMutut+9IDND?=
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
	sBKCnZZvryGHH2o7MSSS7ICDMpC6EigUF0paHt7af+0++tantbZwxcIrhoIV4wecnn0cUu/MaorpQFr47ZR/qZiuEApzlPLeuoBfxRPl+49vLBK0LBS5BgEne32yjNXTnlDPznrhKqyykOZUfZJw1VkaPbqIMa3TCfTOxx6Jg52b5Y1cLruQ80ozsFEspLE+sUCj0H2TyI1gGCmWdek7U/QEs2p9GoeHCGwP/ONPdxNr9hpoyEOF8jUGRZozDGkNm7ojV3BeoujXn+BLrvYz8j+hb35pqRP/Q6rlFzSU4Rlykt6rboCvVTe/7NeT8zbuM76zpgr++utykRc9d4HpdhffNUDhCa2EJLRK0D1iSufHroWlvXhhnY/5P1JGSbfch1p6xZWmb2ClKoa0ntiCZ2TCD/f7NsbbLDoUgzCAvL/BmF6SSDH1TtyI6eY5ps8EWHHB1T0UDteFh6f9yKr3WaS7Bwaee6QL7SWJUu+jRfr111HCnn/gE1LDn8xH2E4gACTVsqvwJROPMQM9zefhxZIPaGGde7A4dmNLfhguIvhOmj+HUoBKMARUDLMGrAaujOy03Tw5jJwIpuoYRyxX60FKT7uEIm1NNIj5nhnJ67ngQTgXE/53mLpt0JLzBFeW
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a65026-1224-46dd-f781-08dcdd48eed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 10:00:49.3830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vt166pT80bPVbMr7XGUhjKiSjLyysY/mQ0yS1t80qEIrguD8AXK+2x2V55frjps2ZwTYdQ/I7NU1kR9AyW6fjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10654

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IGx0cCA8bHRwLWJvdW5j
ZXMrY2hlbmh4LmZuc3Q9ZnVqaXRzdS5jb21AbGlzdHMubGludXguaXQ+IOS7o+ihqCBDaHVjaw0K
PiBMZXZlciBJSUkgdmlhIGx0cA0KPiDlj5HpgIHml7bpl7Q6IDIwMjTlubQ55pyIMTLml6UgMjM6
NTANCj4g5pS25Lu25Lq6OiBsdHBAbGlzdHMubGludXguaXQNCj4g5Li76aKYOiBSZTogW0xUUF0g
VEktUlBDIHRlc3QgZmFpbHVyZXM7IG5ldHdvcmsgY29uZmlndXJhdGlvbiByZWxhdGVkPw0KPiAN
Cj4gDQo+IA0KPiA+IE9uIEF1ZyAyOSwgMjAyNCwgYXQgMzozNeKAr1BNLCBDaHVjayBMZXZlciBJ
SUkgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gRm9yIGEgd2hp
bGUgbm93IG15IG5pZ2h0bHkgInJ1bmx0cCAtZiBuZXQudGlycGNfdGVzdHMiIGhhdmUNCj4gPiB0
aHJvd24gYSBidW5jaCBvZiBmYWlsdXJlcyBidXQgSSBoYXZlbid0IGhhZCB0aW1lIHRvIGxvb2sN
Cj4gPiBpbnRvIGl0IHVudGlsIG5vdy4gV2l0aG91dCBtb2RpZmljYXRpb24sIGFib3V0IGhhbGYg
b2YgdGhlDQo+ID4gY2xpZW50IHRlc3QgcHJvZ3JhbXMgc2VnZmF1bHQuDQo+ID4NCj4gPiBIZXJl
J3MgYSBzYW1wbGUgdGVzdCBmYWlsdXJlLiBJIGluc3RydW1lbnRlZCB0aGUNCj4gPiB0aXJwY19j
bG50X2Rlc3Ryb3kgdGVzdCBjYXNlIGFuZCB0aGUgcnBjX3Rlc3RzLnNoIHNjcmlwdCBhcw0KPiA+
IHNob3duIGJlbG93LCBidXQgSSBzdGlsbCBkb24ndCB1bmRlcnN0YW5kIHdoeSBjbG50X2NyZWF0
ZSgzdCkNCj4gPiBpcyBmYWlsaW5nLg0KPiA+DQoNCkhpLCBDaHVjaw0KDQpJIGNhbiByZXByb2R1
Y2UgdGhpcyBpc3N1ZSBvbiBteSBDZW50T1MgMTAgc3RyZWFtIG1hY2hpbmUgd2l0aCB1cHN0cmVh
bSBMVFAuDQpsaWJ0aXJwYy0xLjMuNS0wLmVsMTAueDg2XzY0DQpycGNiaW5kLTEuMi43LTIuZWwx
MC54ODZfNjQNCg0KSW4gbXkgbGltaXRlZCBpbnZlc3RpZ2F0aW9uLCBpdCBsb29rcyBsaWtlIGxp
YnRpcnBjIHJldHVybnMgTlVMTA0Kd2hlbiBMVFAgdHJ5aW5nIHRvIGNyZWF0ZSBjbGllbnQuDQoN
CjkzNyBfX3JwY2JfZmluZGFkZHJfdGltZWQocHJvZ3JhbSwgdmVyc2lvbiwgbmNvbmYsIGhvc3Qs
IGNscHAsIHRwKQ0KLi4uDQoxMDIzICAgICAgICAgICAgICAgICBDTE5UX0NPTlRST0woY2xpZW50
LCBDTFNFVF9WRVJTLCAoY2hhciAqKSh2b2lkICopJnZlcnMpOw0KMTAyNCAgICAgICAgICAgICAg
ICAgY2xudF9zdCA9IENMTlRfQ0FMTChjbGllbnQsIChycGNwcm9jX3QpUlBDQlBST0NfR0VUQURE
UiwNCjEwMjUgICAgICAgICAgICAgICAgICAgICAoeGRycHJvY190KSB4ZHJfcnBjYiwgKGNoYXIg
Kikodm9pZCAqKSZwYXJtcywNCjEwMjYgICAgICAgICAgICAgICAgICAgICAoeGRycHJvY190KSB4
ZHJfd3JhcHN0cmluZywgKGNoYXIgKikodm9pZCAqKSAmdWEsICp0cCk7DQoNClRoZSB1YSBnb3Qg
IiIgb2YgbGluZSAxMDI2DQoNCjEwMjcgICAgICAgICAgICAgICAgIHN3aXRjaCAoY2xudF9zdCkg
ew0KMTAyOCAgICAgICAgICAgICAgICAgY2FzZSBSUENfU1VDQ0VTUzoNCjEwMjkgICAgICAgICAg
ICAgICAgICAgICAgICAgaWYgKCh1YSA9PSBOVUxMKSB8fCAodWFbMF0gPT0gMCkpIHsNCjEwMzAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBhZGRyZXNzIHVua25vd24gKi8NCjEw
MzEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBycGNfY3JlYXRlZXJyLmNmX3N0YXQg
PSBSUENfUFJPR05PVFJFR0lTVEVSRUQ7DQoxMDMyICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZ290byBlcnJvcjsNCjEwMzMgICAgICAgICAgICAgICAgICAgICAgICAgfQ0KDQpNYXkg
YmUgcnBjYnByb2NfZ2V0YWRkcl9jb20gb2YgcnBjYmluZCBicm9rZW4/DQoNCkhpLCBNYQ0KDQpD
YW4geW91IGZpeCB0aXJwYyBjYXNlcyB0byBsZXQgTFRQIGdldCByaWQgb2Ygc2VnZmF1bHQ/DQoN
ClJlZ2FyZHMsDQotIENoZW4NCg==

