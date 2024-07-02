Return-Path: <linux-nfs+bounces-4523-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CC5923DEE
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 14:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BDA61C24075
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 12:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255EE15B14C;
	Tue,  2 Jul 2024 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="V+rr8jSR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2138.outbound.protection.outlook.com [40.107.237.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F6D10F9;
	Tue,  2 Jul 2024 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923639; cv=fail; b=Fpp89L/62WEeh5E/moPZS9LEMIfZDg4jJF5rgsCDu4rOhpuP5Gl4enQSEOLcsiDpUBndV6ThIA9Q1JHZ18D+44glhsFLkbwP8ULjoGPc0q0kx3QJWBExdtGUiznCzGsaE7k2a6oLKy3OH1KGhj9zqklvCuFTZQ1lPGlKixaZWsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923639; c=relaxed/simple;
	bh=D4tR2B4p1RUo+EG3do+z4js8W06Q7jhQke0VkpyCYck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hKZP4U4sUvxumX7OK/AsnOcek7QpD3RkctqQkY8E3rzMWe2KI0/w3QfVD0NcIINOLKfr7QG7WciBR6s1QJ44K3/DxNn3VRv/uEtAMMqsMuyqxz3o7deQEolz7urV2ULmfvcx1EZ3UkSew2eDE0LIPUUAC77IwQbkiqmNV4pg+Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=V+rr8jSR; arc=fail smtp.client-ip=40.107.237.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEL7r7Vi14ckWGjh1DXoV6Snz3se9i+TiMDegFlYXe2LwaNUKB2LBxDGZgMFa/5BbV5NQk8BLEBSgX9DTEBlMDAwKGOAxausW94RWWxIAFMoOjtJaPM3X8NxZbK/3zNBc3qutBE04N+cIMe1RKjTFQ1mre75fxm2x1hxiEt76wgtlj8VEO84lXvwM37ziMVgoceswgGrhXZNCRSbSG1K6Ehgd4kJazxWi3mns5E0++QxBMLku23g9OqkaT69FYOnOeipethyOH72LHG3KMhg/7WvcrCp/HyFifQdb3pKOeZdLDXPuKRubm/na8StLvBDjhXxCLmEWhS9Co+8Jog0SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4tR2B4p1RUo+EG3do+z4js8W06Q7jhQke0VkpyCYck=;
 b=EiATsmTNOA6DL3fsQkrB4ZaaxNSOMXLVxuH4GP+AxfzymCxpdyN52A5uMirjP6nD2Lknz/62BKWq3lBP2n33z3qdzzsMBgCFzd/gjS8RPghRKP1QsRE5rOpXalOwTOvLqJ2EDBAu7z3XY7gYtC2WeYTvW7MS5VyizYAwN0aI0RZmoGgM4GOU+FrJ8Gfq+R7X322VWOxDoGzm4ntKmIVfaQ6jZH6N8wMF9ZIW/HsVAE/Frh68X5SA3bAwFeenxUrlhn69XujsKGKLbO5ovXDXS30h1DDZZ/D7Vw/Elj+C+ve5+eqHOujhCEg8Jmh7GNHMXTbElPZFXUzGMDZ61zc9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4tR2B4p1RUo+EG3do+z4js8W06Q7jhQke0VkpyCYck=;
 b=V+rr8jSRinWqZAMmCHpwTkQXiQhWVU4R3n/33o4lWFpBsC5EGfeBZSB4eo74neounl+qEbqN5vd80qbzzGFQnnwDkFtyZbtjvXi7NKIVSHMPQv7wDLZtu+UoGlsQtJsAVhrE2m6uww7+z/83vVQpjO064mHnvFigfs1xNs4S4Q4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB4679.namprd13.prod.outlook.com (2603:10b6:408:125::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 12:33:54 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 12:33:53 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "snitzer@kernel.org" <snitzer@kernel.org>, "david@fromorbit.com"
	<david@fromorbit.com>
CC: "bfoster@redhat.com" <bfoster@redhat.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
Thread-Topic: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
Thread-Index: AQHaywuEBap/iEadlEORNNEJmrHSZLHh65UlgAF2hAA=
Date: Tue, 2 Jul 2024 12:33:53 +0000
Message-ID: <f54618f78737bab3388a6bb747e8509311bf8d93.camel@hammerspace.com>
References: <Zn7icFF_NxqkoOHR@kernel.org> <ZoGJRSe98wZFDK36@kernel.org>
	 <ZoHuXHMEuMrem73H@dread.disaster.area> <ZoK5fEz6HSU5iUSH@kernel.org>
In-Reply-To: <ZoK5fEz6HSU5iUSH@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BN0PR13MB4679:EE_
x-ms-office365-filtering-correlation-id: 021228a1-6bd1-4328-b548-08dc9a933c15
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TUJGN2Eyb2NvcUw0Tk5zVHVlS2ZGNXhuN0lFVkRPQU55dDBwTEJKbFdaM0tl?=
 =?utf-8?B?YkFNVCt2cndkakdGdDU0emFXbGxtbGVCUm1GUHJPRUpFZXR0VmMxSUVvbFpD?=
 =?utf-8?B?VE94emNpeHNMaWtzcXRTNjBiS0kvZy9XMFFpNmxxdmVQNXdFbkZDQVRicDZo?=
 =?utf-8?B?M1N6SHczNnFOZEVkZ28zcUpRYWMxMHZXREJ0dnJ5ZlJOSmE1UVRaSEFyMk14?=
 =?utf-8?B?djREWTFhRW5iQjR3eFlBNzRVZlVDOXFMUlpuMGdnR1JZZ1krMVAwSUk3d3Ix?=
 =?utf-8?B?ZjhMSmN0UWxBc3dkNkpPdEVhTXV4bkd1NE9jKzMxK0o0YXF4bHdFV0JESFZr?=
 =?utf-8?B?K1B4VnlRT1BkSzJSVkprWGFYODBVM1AwTy9MNzRiQ2U2bEZ5ektOTmcrS3VT?=
 =?utf-8?B?N2dSUGNEeTV5cXRnNmtJMi81Mk5uT25Kc1o4VnBmaTZqWDlwT3JuZFhEeHBG?=
 =?utf-8?B?R3RtYWlXT09mbXlkWUtZWk9BWHlrZkRLdU1Rc0lqcnNoWGt2bHRpYUk0QkNX?=
 =?utf-8?B?UjFscDhmczdmWEY0N0lYZUFQeWNkbXVYYldSMzBOeHZ1c2ZpMEZzMGl1a0Yx?=
 =?utf-8?B?ZURER2JaVUhxc1Bzam5vb1IwTy9TNlMyL0FNbW5yQ0hodkZuMS9YZS9NWUIr?=
 =?utf-8?B?ZkZhUUlVZ0w0Y2pkTW1hcHFldTFjRThIdnpMNzlkMVh4NXFENk9KMzJMUzUx?=
 =?utf-8?B?dVlLaGRwNkhkcmdqWnRYTFM0enF3QlBDQU56QStSNXJSTm9XS1JkR25jSlFm?=
 =?utf-8?B?STdGZ0RnVmlNSEEwQVFuN25WWjBpMkYyNlNYcGpTRkRlOUo1M0JRNXFsV2Rk?=
 =?utf-8?B?WTNkVW9kR0R2UW9wWVo0b3lybmVnQXZ2QytqNE9kbmk4Z2ZBSWVtbHFzVVdB?=
 =?utf-8?B?STV0UGNuSW5XMExsUDVIMThBM2crYTlVaXNDM0hmREhoa0lxblVra1pZMzJi?=
 =?utf-8?B?cENGSWN1QnVpWmZvNHJXcHAweVdTbzd4YTl0RG9QQjJwUmZpMit4MDBEMlZl?=
 =?utf-8?B?Vy9wMEduaWcyZHpnb1hYNXUzZGo2VkhOcG5uQnZTcjhnYy9XQS9idGpJUnlJ?=
 =?utf-8?B?YTBENEpOcVI1L2xuNTBMZERWanlTdUtwN2tORHJhOFFJQytoMUtTbG1zOGRh?=
 =?utf-8?B?ODN3UkFpYXY2bUlCVnBDZGlhdGp1dGtJdFNSZ201UDFSNWJpNy9jNUY0ZUZV?=
 =?utf-8?B?SmZnbkxNd2dzVDZsbE9LWDVQWWJVVEdubXBkUHZCMGsvYXdiV3lybitRUmRu?=
 =?utf-8?B?STJmQ1JSOG1IUWJrd1RKc2pad3RhaXFCR0oxQVI3OWxwQlVQaFFwZU9TUTJt?=
 =?utf-8?B?dEZUNU9SOEloVDhGdTFWRkx4WkxtSExYa0VQYk55dFhnTCtxK0JUSXZENm1P?=
 =?utf-8?B?ZUc2TmhvQnR6TFRCd1R6L2F2dFU4cERWWmo3ZHpuS3VJT0hGaXlGako0TjM1?=
 =?utf-8?B?SC9hR2hZb2NYMVgyczZCYWVsTkxOTVgvdTI1NVhwb0c3Tnp5cHpjcE1SSGw5?=
 =?utf-8?B?QXUzUmVtUGtleHZjb2krYW1qTmw2b3hxelpiV3NXWFVxWGdEZ0ZSbmFHUTRu?=
 =?utf-8?B?Zkd1UnJTQ1crWjBWRTFQWC9nZjNFNW84V3daMWkwcDFTMGVQWWJnb1p6aWpp?=
 =?utf-8?B?U3VLTTN6L3MrOUZ6Rkl5dmlwV2ZjN2FlMWI1cEhiL3FiMFVNeUIyeDVpNEhM?=
 =?utf-8?B?clNLcnk1TVZXY2V4QVBWTjViS1NLVndOTFczWXJ0bS9Rd2ZPMkhMYXVwczVI?=
 =?utf-8?B?R1RITnB3UFhNMFpHQ2cxQ1hDWVl1cktwODlmTG4wQW40RDU0elJLZUVtbWtu?=
 =?utf-8?Q?oAEj2AGugHXjJedMQoIbLwejHHZVo+lJQWZzE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cTFPOWdFd3BEOWFLbHNGMTZmM2pMZ2xxRjhSNHBMa0krSEhTYzkzUnhNZmhJ?=
 =?utf-8?B?UjV1Zy9QMHhEMzVXU2JSZ01uVS92MFRiRHJTdkhhNFcvZmpQUlBDZzVTZ3ZJ?=
 =?utf-8?B?Uk9nMkoycGVGb1R6Q0ZVZkw5ZTZES1pNd0tXNG1tU3R6MkhCenNJM2k5YWtL?=
 =?utf-8?B?ZjI0ZGVlam5PWUtNNXlRRVVmLzAzbFpTMFBmdWJzZys4YVRvRVZnUlNiS1JN?=
 =?utf-8?B?VXBZd2gybjB0cjYvNXhQVmkvdDZ3V3BLRlJlTVpHWGhLTUNxUm1RSjczVTN0?=
 =?utf-8?B?OVB1bHRHenpiRk8zVVEzSUlBb2FGbjJXRDlTbE1uVmU2RzlKV0VGYVlYdlQ1?=
 =?utf-8?B?TzBTc0ttQ3U5Z3dWZGRYRXdVRFIrc3VIYnJ5Qm9aTGR2TVZVTDNOTkszN243?=
 =?utf-8?B?eXRlMFI3dkZrMEVPdGJVenY4T25HTDB6SlpScGJlMU55aU1zN1ZIbDJqQnB2?=
 =?utf-8?B?Q0JwcjIvUnNuMGp2S1BSTWMzNDN1a2dMSjVHbzQ3NlVORnN2MTBUTGNGVU42?=
 =?utf-8?B?Q3dyT21PdEg3RHo0QUxYWU85clNzSkNlUHdycURHMERwK2lEeEhzWnl5T0RZ?=
 =?utf-8?B?Z2VEN0JNbXZWU1RWNlI1ZmxYR1NrMVFDU2M5a1ZuLzUxYndrMUEwQlFBN3ZM?=
 =?utf-8?B?S2hGOWRubzJKUnc2RnhHRkU3V1VveTd4dk5TRCtMZEdWcXloa1hJQWkyc2lu?=
 =?utf-8?B?aUV4TEQvMnRTek5EWk1RVnF5TGY0VjlsQXB1TjhTbkhIN2pFQ2gxRURLVXdR?=
 =?utf-8?B?M3VvcjliMHkzbDRWNmVSMHBTU01sVi93VUJiQk84MUh6blBFcFVKTVlmQnpD?=
 =?utf-8?B?UEVxaDZmRnl5Y0JBWWwzeC9PZE0xU3IrdUFVamd4ZzVvamJkcFV3YnVHYzBT?=
 =?utf-8?B?N0wyL3QyczhnYzVIMHVjUmhNTTV4TzQ1Nm5CdHdWZDR3RzVoQTl3bSt0Y1JN?=
 =?utf-8?B?L2hUZ2NQUitXR3NkWmZXSXBGNCtNUStwUjk1QlVJdnF0c2lXa0E3ZzA0Z3Jq?=
 =?utf-8?B?QTNDTWdtVlJFdXNMNWE1MkhQS1BLOHdMYitUSyt1aHBvWFdmQnlrVTNacXhB?=
 =?utf-8?B?eVkyWU1kMVFrdTFMQzVETm9HTFJqRG9uTGh4M2gxeW5KNW5WODJTTE1XSUla?=
 =?utf-8?B?OUs3UlVFdVNSbnhaVUU5RlhEU25KRzdFN2JNcXZRbHN1SU9iZkN6VzBJUGFt?=
 =?utf-8?B?UkVUeUhzTDVCYW9BZHd6cW03aXpMSmRsV0ptZjVIT3QyMHFtQzAzQ0NxbkFn?=
 =?utf-8?B?QXpCNXhSRTRsRlhEb2tBdmt0SGl5OEs2SXcwcG1WaksweFp2eFllbVBnQWdI?=
 =?utf-8?B?MjFGemRlQUoybFZXTjNTL0llZjF4ZWpuREMvQmMrakVGN1ZwN0VPQjhUdTBk?=
 =?utf-8?B?UDJielRXVjUzUVBUb1BUd1lwdjJCbkZ1bTAzTDFwOHFxa2ZuYi9XYjJJd1FR?=
 =?utf-8?B?Sjl4a0paTE9OODM5M3lEaXc5Vk96TFhlZzZNOCtmc05Jb25RQUQrTU5PTHZF?=
 =?utf-8?B?aEhmbjlRaCs2dVJJQXFqUFdwN0VoOGhqbFN4aWFWalJYVUJrc1BxZ2Z5M3p0?=
 =?utf-8?B?NHkzNUFHU3ppRmhDc3I4bE5SZ2ZDTG9KU2lzRTNRR2FwVHV0R294UkNzVXRn?=
 =?utf-8?B?SldIWm8zM1E3L0t0Q1dPMksveisvQWRFU3FQaVo2R0dOS0xuZXQwblUzbmRO?=
 =?utf-8?B?ZUNxdW55NkJvZW5OdWhFbXM1UC9TWUVzK0xHaUtGa0JnNWVvRnBVV2w1UUdM?=
 =?utf-8?B?cUJhYWhmRGVuUmp4bC9UL0owcEZXN2JIMWpyamlSVUVzcFo0c3JrKzdEN0NL?=
 =?utf-8?B?UEU4RVBvUis4R29BelJBQ1QvZzZ0Q1hTYUxKVWpGaTY5aFdpa1oraTk4ZzNu?=
 =?utf-8?B?b0hXZStEMk43TEFLekJTT2dtVUhabElRNlpiYjdYWUdZaC9ETm12Q0tUYkYw?=
 =?utf-8?B?ZTFBdm5tN0tIbkJ0NHRNdVc0SUJLbG5UbGVWUkRxaUdBQ2RSL2s3Z1Q0b2Ns?=
 =?utf-8?B?eU9xcU1VZUhGK25lMVpJTXRCeUpZUzdFU0l6R3ZVbEJpUlFySFF0emlYYkll?=
 =?utf-8?B?V3RGVVA1NEdHc1cwek9aQ2ErVjJtVFlROTRsbTNkbjM3SHdseXU4WWEzZTlo?=
 =?utf-8?B?TUU3dWRqT0VkTTRPVDBhU1N3RTNaRE5RQ3Z5QUlNMVcwbGVRNXhlNnVmWmJo?=
 =?utf-8?B?N05TN1psWlhaVE51OHpKMVJUaFAzemV4Y1IyUittTXBtN3MzN2wyN29EcVM5?=
 =?utf-8?B?U1lUT1hPSmxST2ZxZVVuVTVNUUN3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F78530F8B13A144EB11F37D601FDC47E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021228a1-6bd1-4328-b548-08dc9a933c15
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 12:33:53.8559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sIDM2J3bToXTnWnZwBd3KlYMua/do7cidFDyCv79c66RpiBpiZj5oeW15FnD/J2tnkz+3xvqp5qF9eOXtbnOtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4679

T24gTW9uLCAyMDI0LTA3LTAxIGF0IDEwOjEzIC0wNDAwLCBNaWtlIFNuaXR6ZXIgd3JvdGU6DQo+
IE9uIE1vbiwgSnVsIDAxLCAyMDI0IGF0IDA5OjQ2OjM2QU0gKzEwMDAsIERhdmUgQ2hpbm5lciB3
cm90ZToNCj4gPiBJTU8sIHRoZSBvbmx5IHNhbmUgd2F5IHRvIGVuc3VyZSB0aGlzIHNvcnQgb2Yg
bmVzdGVkICJiYWNrLWVuZCBwYWdlDQo+ID4gY2xlYW5pbmcgc3VibWl0cyBmcm9udC1lbmQgSU8g
ZmlsZXN5c3RlbSBJTyIgbWVjaGFuaXNtIHdvcmtzIGlzIHRvDQo+ID4gZG8gc29tZXRoaW5nIHNp
bWlsYXIgdG8gdGhlIGxvb3AgZGV2aWNlLiBZb3UgbW9zdCBkZWZpbml0ZWx5IGRvbid0DQo+ID4g
d2FudCB0byBiZSBkb2luZyBidWZmZXJlZCBJTyAoZG91YmxlIGNhY2hpbmcgaXMgYWxtb3N0IGFs
d2F5cyBiYWQpDQo+ID4gYW5kIHlvdSB3YW50IHRvIGJlIGRvaW5nIGFzeW5jIGRpcmVjdCBJTyBz
byB0aGF0IHRoZSBzdWJtaXNzaW9uDQo+ID4gdGhyZWFkIGlzIG5vdCB3YWl0aW5nIG9uIGNvbXBs
ZXRpb24gYmVmb3JlIHRoZSBuZXh0IElPIGlzDQo+ID4gc3VibWl0dGVkLg0KPiANCj4gWWVzLCBm
b2xsb3ctb24gd29yayBpcyBmb3IgbWUgdG8gcmV2aXZlIHRoZSBkaXJlY3RpbyBwYXRoIGZvciBs
b2NhbGlvDQo+IHRoYXQgdWx0aW1hdGVseSB3YXNuJ3QgcHVyc3VlZCAob3IgcHJvcGVybHkgd2ly
ZWQgdXApIGJlY2F1c2UgaXQNCj4gY3JlYXRlcyBESU8gYWxpZ25tZW50IHJlcXVpcmVtZW50cyBv
biBORlMgY2xpZW50IElPOg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9zbml0emVyL2xpbnV4LmdpdC9jb21taXQvP2g9bmZzLWxvY2FsaW8tZm9yLTYu
MTEtdGVzdGluZyZpZD1mNmM5ZjUxZmNhODE5YThhZjU5NWE0ZWI5NDgxMWMxZjkwMDUxZWFiDQo+
IA0KPiBCdXQgdW5kZXJseWluZyBmaWxlc3lzdGVtcyAobGlrZSBYRlMpIGhhdmUgdGhlIGFwcHJv
cHJpYXRlIGNoZWNrcywgd2UNCj4ganVzdCBuZWVkIHRvIGZhaWwgZ3JhY2VmdWxseSBhbmQgZGlz
YWJsZSBORlMgbG9jYWxpbyBpZiB0aGUgSU8gaXMNCj4gbWlzYWxpZ25lZC4NCj4gDQoNCkp1c3Qg
YSByZW1pbmRlciB0byBldmVyeW9uZSB0aGF0IHRoaXMgaXMgcmVwbGFjaW5nIGEgY29uZmlndXJh
dGlvbg0Kd2hpY2ggd291bGQgaW4gYW55IGNhc2UgcmVzdWx0IGluIGRvdWJsZSBjYWNoaW5nLCBi
ZWNhdXNlIHdpdGhvdXQgdGhlDQpsb2NhbGlvIGNoYW5nZSwgaXQgd291bGQgZW5kIHVwIGJlaW5n
IGEgbG9vcGJhY2sgbW91bnQgdGhyb3VnaCB0aGUgTkZTDQpzZXJ2ZXIuDQoNClVzZSBvZiBPX0RJ
UkVDVCB0byB4ZnMgd291bGQgaW1wb3NlIGFsaWdubWVudCByZXF1aXJlbWVudHMgYnkgdGhlIGxv
d2VyDQpmaWxlc3lzdGVtIHRoYXQgYXJlIG5vdCBiZWluZyBmb2xsb3dlZCBieSB0aGUgdXBwZXIg
ZmlsZXN5c3RlbS4gQQ0KInJlbWVkeSIgd2hlcmUgd2UgZmFsbCBiYWNrIHRvIGRpc2FibGluZyBs
b2NhbGlvIGlmIHRoZXJlIGlzIG5vDQphbGlnbm1lbnQgd29uJ3QgZml4IGFueXRoaW5nLiBZb3Ug
d2lsbCBub3cgaGF2ZSBhZGRlZCB0aGUgZXh0cmEgbmZzZA0KbGF5ZXIgYmFjayBpbiwgYW5kIHNv
IGhhdmUgdGhlIGV4dHJhIG5ldHdvcmtpbmcgb3ZlcmhlYWQgaW4gYWRkaXRpb24gdG8NCnRoZSBt
ZW1vcnkgbWFuYWdlbWVudCBwcm9ibGVtcyB5b3Ugd2VyZSB0cnlpbmcgdG8gc29sdmUgd2l0aCBP
X0RJUkVDVC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRh
aW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

