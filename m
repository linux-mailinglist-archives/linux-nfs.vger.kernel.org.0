Return-Path: <linux-nfs+bounces-10110-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 481F9A353F6
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 02:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1DA43ABC9B
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 01:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA5381727;
	Fri, 14 Feb 2025 01:59:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020089.outbound.protection.outlook.com [40.93.198.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA678F41
	for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2025 01:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498372; cv=fail; b=fQrLZM8gedgYiGd+WaCSXJ7UTrkoMc1fDRYEvtfiInjyR7GVfXEnHAE45Llnd9HY1lEJUvuUJggwBzbGiprkpd138y6PYdSK0Sq8jw6VIiPw1B1PWbv3/cJM88BK7YPVaMfEQcBS984eiARobOlURWinrAgs+azO8SDZJxrT1xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498372; c=relaxed/simple;
	bh=xitfXrbdkGgHcHLoeRADlVrhAQiXJkTtBtxGa9fTMHw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QjRVhP9wMzY07XH/wSl6jsnm3rLYWWiJ8JOXHXXFniKYPhVXB4Bm2OOjBxygP31w5n2rXAaTgJokyOYMH8wPaV2QTVXIKUnrsAVvHRbpCaMlzixemmYB0IKM6f0khxZTIltrcH4AUbmIanBbc5hbZDRswm7LK9taLXMSBD+1iGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.93.198.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRpIDOkFq+rqCxpL3TDHFpuk3MGhfYeWuy4bq3ZNkQ6Mzxe49MP2N253Ehcxextd2r2FJt2WOyQth60D5WBTlvqPpORPRNp83kVgd6Np9GGVXztdIYCcAkLha7LvjPSVJKEwGTAkUJlZEY5yECbB3LdtNrWKehR8RU7wvZLnJOUNg0yOJbv2Vx9XcSQzsQgDlrfgGzck43wNG2ImFecOa6spg/neMGl/H6pdRVK1lRLMQgqtrUijF6P89ii4ENAAOSKE5R3B6AA1pkkhzje0E/7EZdhfTR4g6zdNvE+YyhHd9c28mRPgIfor7LYHaKmM8Z7gTsWf0ShGQGOk73LkfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWIp8p0YrEZatLBAhNEItSwZOV6BFqKyPA9o7P9eLLk=;
 b=nmr0hpO6wYDeitKe8GDqyVQSdWwZfDbvQQWpaL2dTdCsjgGm4nYFcC1xuekg3m32xXKyhTxQPvGU/xscu0xW1L5Fhk99D3EpKIMYBXDD0hdV5WxJttI36QWiwwuKYV51ZMu+tIg28cZSXj6sU4W65128nF6e2JMDyxAQD0YdeyJMyQAmVOJjCn5QQ/JoU3hQCJ45V0GEJuX1yBY/rgzRAXDRYqZOAP3UUiFEgrbSDM2d1m2VSuEFkCl8j4dsX4zR/SOZ/mewAwOiCCjs8DkFMMlESepzhzX5vy9J0fCuIXVy0dzl420Hk4eFBVxPjJbnxhzj5hu0eEAHHIGZzpaYEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 PH0PR01MB7399.prod.exchangelabs.com (2603:10b6:510:10a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.8; Fri, 14 Feb 2025 01:59:26 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%7]) with mapi id 15.20.8466.004; Fri, 14 Feb 2025
 01:59:25 +0000
Message-ID: <b8b9fa85-5fc2-4f72-b382-6fd44a3aa422@talpey.com>
Date: Thu, 13 Feb 2025 20:59:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: resizing slot tables for sessions
To: Rick Macklem <rick.macklem@gmail.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
 "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <CAM5tNy4f9YyMhYRydudNkCqzVp5f8Np6N25NOT=-+TjJN2ewqg@mail.gmail.com>
 <884876492c56e76fd6fbb4c5c4fb08ee14de9fe1.camel@hammerspace.com>
 <CAM5tNy5yv1CkVc3z0dTJ_Fed9mP-ZBug1L39Jnau48s=OnSPvA@mail.gmail.com>
 <a9127b76-29f3-4782-ba9b-dff1ebf6f647@oracle.com>
 <e937d6d9-9d58-4c09-aeed-9b7e676d8799@talpey.com>
 <8e25d16b9d94179cd9214f46ca214012116ff7bd.camel@hammerspace.com>
 <CAM5tNy4wnvpinT58wOJtAObdadn-hffb5XqvTfmtFoG30sG7AA@mail.gmail.com>
 <d7c63c2e-460c-48c3-8eb5-48dbaeefd527@talpey.com>
 <CAM5tNy4tGm18OEHiFSjMXyqjutvuCfgaF9fOV6VD9gv+NSy_mA@mail.gmail.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <CAM5tNy4tGm18OEHiFSjMXyqjutvuCfgaF9fOV6VD9gv+NSy_mA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:207:3d::18) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|PH0PR01MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf5ac14-1667-4d32-b0a5-08dd4c9b355f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TSsrK0RISGNNZCtmamR4U3I3UXNZNVZ2OG9GcWZLS2pIeHhmU2xHbG53djdE?=
 =?utf-8?B?V3hvU3RGV1g5ZFl3QlpBNFJyMEtZc1d1OGc4U21pRjdpNmRub2ZUblF4OWN4?=
 =?utf-8?B?aSsyU3VQWnlobDdFbnM4aDhuSjFNZEtEZVZnVm12b3B0a3NBck1ZeC9sWUtl?=
 =?utf-8?B?Wm5qUVRaQ0xQdGh1dUt4SEhaYlIzNkRJTWVrYWk5Yk9xRWVZMzZaNDY2OElp?=
 =?utf-8?B?WHY4OHdwNHJucFVKVElrdHc5dUp5Znd6bXE0eHNhTE42WnFwVzA4dzNwcHlx?=
 =?utf-8?B?UjMyRy80TlRmY05oWlIwK1ZkWGVvejV2dElUUG5rU2xsTDR6TlNmcndmWndE?=
 =?utf-8?B?QkVKRzFBaENuZGtZcjBGZTBXZjgzUEhZcjY3dXQ5dTRmRXhRa21LNlE5MU5s?=
 =?utf-8?B?czQwN0RoN3I5aVlsTGp4WFUxYU5PcHhMWGZDZFJlcGJUZkFRa3RFZERBMGtT?=
 =?utf-8?B?ci9EZ3F3V1hWOHJSTTc2RmtsNmtZNTVPMUUrckpkbkVScGcydS9WZThxWVhj?=
 =?utf-8?B?eDdlRkxmMDREaEFCN3dBc0FlZzJXTTFsWGdoandObU5lZXg4YmY1TnpaUHBz?=
 =?utf-8?B?SWFqRit2bkkyTXpmUEYwejdBRXE2UEtONWZITC9VVU5FbVlEYXZkczhFZHcv?=
 =?utf-8?B?NHh0M1dGRXNHRkhuTkxLTXkyOWQwK1hTQjcxOHhvOEtoVklGaHU3Zkx1aE9L?=
 =?utf-8?B?a095bDRLRzd3akFCbnlQcjIwNm5LNzVDVTRnWFV3elBuVjZJS0JiREtlNmdU?=
 =?utf-8?B?VEo5d0NabWZYSkVHR2R0UGZvL1V2SitxUmlMNW5nQktwWEF4WUZLUXpQZ0xm?=
 =?utf-8?B?blhKa25PazJmLzlER2ordmpMTEs4ekdNSlJXVFJiai9DbjE1cmpob3VwQU9W?=
 =?utf-8?B?bURaanc0Vzlzc2s0TXB3ZERkVmxMVC9tQTVIT3Z3bkQwUzBQUlFBZG9KNzdN?=
 =?utf-8?B?STc5Z25sQXJXL2pQQVFzYjcrMnZSTERKQkJaUHVZVFZCMnNjQ2pjdEFJYUpa?=
 =?utf-8?B?YWNLTE1XeW1wRWpCNXNHRVFhSkMvbXcxc1BBZ1hHY3NHS2Z3bFJqV04wOTd1?=
 =?utf-8?B?cEtXYnd1anpkUkZHaGRpSnJ5YWxzS2ZiL3l3ZHZYV1RzOEFmZHU0QlRIZXlP?=
 =?utf-8?B?WElQaHltQ1VsU1l5enE4eGtkRy9qcXBIUVZGK1FzZVF3L2h0ODl5b0d1WjY3?=
 =?utf-8?B?MGVmRS8xcDdPelpncEpZLzRscmFyK3RSMFNsUWEwMDluVzI2aFlySG45aUpl?=
 =?utf-8?B?ZW5YVVcwbmRvWVJSb3liK0Jhc0oyTWF1Y2k0elBNVzhaUE5ZTkl6UGpkTmgw?=
 =?utf-8?B?elBKelR2d29CdHhCdG55UW50TEorMUtUMHdjd0VFcFQ1QVZKTGJnMks1cVRH?=
 =?utf-8?B?clg3NmNXd25zTzVab2ErVFIyMEU2K3dDTkZ5bGhjc094UWp4RExCTU9oSEdO?=
 =?utf-8?B?aHJkcURwcTEvMnpVS2dLcUZzQmRvdHR0RTJEQmFDai9QVCtDZW5waDhka1Iv?=
 =?utf-8?B?QmRBUmVGKzM3MnFvanFxZ09zQXRqUXg4TFhBazlXVENjODJJc2xaZ2lkSXEr?=
 =?utf-8?B?dUNNV1lERnlZak5sb3FVbFcvWjltcFJjTUJoRkExVGhhcW9MWXM2a0RwU1FM?=
 =?utf-8?B?Yks0eHp0WFZWZWpMRUJuSHRtdEFKZ2RrYlZTTkVITDBwNVUyaHhJbjNEMlZX?=
 =?utf-8?B?VDB2Mk56ay94c1lOU1FPWm5FWitxaWpQYmR6ZlAyakxoTm53WGhUeEtqeUI0?=
 =?utf-8?B?QnVtdjZCcmZuc0FZTnpxcnQzYTMrNUdMUTJZQjE3bGtFbHphZkh2L3JXek9q?=
 =?utf-8?B?RlJuNFVPMndXQnBKcFZFVTA2eHNyZTFuSFRsemYxL3hOaldwZGkySjh2V29C?=
 =?utf-8?Q?9/IemVje+zjHx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0VNVUpwa0dNQmRBenhrU25QeHkrZDdVbDJsQWdrMHhxMWVCUDcvTVhZeW5o?=
 =?utf-8?B?QVpnTEtuQVkraXZOeGdVMDdTYnRvUXYwaUdHbXVWOGdsOUFpVGVnTEhoK2pP?=
 =?utf-8?B?SGd3UWxJeS9WdnczRU14a1BXYWw5WXl1czRQREhEcWZEY01GL2NOdlBTSGR4?=
 =?utf-8?B?aXl5VzlXUkRoSUlOMy9lV0lYbDBScUF3bzI1UFU0ZWtlazhQRXd2TVBBVCtC?=
 =?utf-8?B?TUdNUzJPTWJGcEtWa3RSM2xCNitibXV4SVc5aEV2NzJuMXdOVWhwampwUnU4?=
 =?utf-8?B?cFhIRldndC9vUVdZYzN1S3RMR0FLODJ4SG5SVkU5VjVsa0Q1cEpjVm5rYzV2?=
 =?utf-8?B?eFdVOHRpTEgwRElqMjdwTGlyMzVDS1dxVGFZVktLeXpDTDdZeHZEV3EzdExl?=
 =?utf-8?B?eVkxdDdRbE5GYVBvRTBPdkFFb2FYeFFxckJFTU1zYmN3M01UNTRETWg4MkJ6?=
 =?utf-8?B?c2FpTTFESzRlNkduek1JSDUwazIweUczWS9NajlnOFNKdnJPdHN6WVluN09y?=
 =?utf-8?B?MzZhUVlZVnRzVnlVcTNpL3BOQktyQjhJMkZ4c0lNaENSQW1wUlBOdCtEMmQ5?=
 =?utf-8?B?a1NyM1k3TU4zVEw1S0kvUXFLeFVRbE1IODdEcHpEK2JRVysvZ3A3MFZ6SXBt?=
 =?utf-8?B?ZnFER0d6d09MYXE0U1B6bW0xVUlMaG0vdFdsSm5PVVgwOG9mTm5QTDh6TWl2?=
 =?utf-8?B?MlZtUllIYzVYUTlVcTM1YlFLVHAzNzM4WkxtQUo3MjJlVDBuTjJYTm9wQlQ0?=
 =?utf-8?B?eGt1U3o0MnFVeFBScmdvK291Vk9NNm1kTUVYZ1lQUGRwQ0tMV0Y5akFGeFdB?=
 =?utf-8?B?Yklxa0w5UlFheXNnVTJIazhCTGFVVTM1TUZOeldTTnRYdk1MQjNCRXcrZEhW?=
 =?utf-8?B?eXZINy9ycE0wNFhZNDhDUDVsSWwxSW5TRGZSTXYyN2NTakREOTFyZUt6QkY2?=
 =?utf-8?B?RFViSXFIK1VXZmJQTHF2NVNHU2dMNVovMFcwaHJpb2UvSm1OUW5tS3hoRUtK?=
 =?utf-8?B?SnlqSkZHOGtTcHJxSHV1Z1hyS2F4YlRBZjBhVkJzZElDWXVyMm5JaFhnd1ZM?=
 =?utf-8?B?ejlpalVNTEtwek5JOGQyQVBUV3JFVmRVUkF4c0QyRlNGbmJ3NWRRdG13REFo?=
 =?utf-8?B?WitUdnBOMGlyb1puUzhJaGoxN3BmMXJyUkdsMGdIcDFwdjJQZUQyTis0Tk9p?=
 =?utf-8?B?K0g2L0NYWjh3YnIxc3pIVUd5T2VDaUQyUVUzcUZUUU1HdFZ4QjlsbXBYQkVN?=
 =?utf-8?B?QjdKYWJhQXRnWWk4ckIrOEF2WnIzNkNGZTBWSklZREdCay9CbUNpS09nZkJm?=
 =?utf-8?B?eW9NUjBacGRGb2YzWnFHb1VjQ3RINWpJMUVyZXdIREVjSFVnTytCb1dwZUF3?=
 =?utf-8?B?NVZSQytZZ2l3dzl4NHFFTmhyWDFLQ0lyN2VueHhzd1F1Sm02RlVid2ppVWtB?=
 =?utf-8?B?WHRYaFVzMktXM2ZDSWJ3eTBqSzRtQ1lpQVB1ZWRkbERCalRzMXFyeWNMYm52?=
 =?utf-8?B?NDRqbkMwL242TVJjVjdPVSt1b00rRjltRDROakxMRysxd2ozeWJqQWY1Ymx3?=
 =?utf-8?B?SDBjZUNNNWhac0F2T3psaEtyejl0c2Z6RnFwb25ObW00OUxjK1MxTWhKWXdz?=
 =?utf-8?B?UEY0UzFnWmllQmF4MVA2OEJoRWRzQjhJcWgxNzB2M05iNnpsVHZ2ZmszQmg2?=
 =?utf-8?B?VU5rdmRUcFl3Sm5uQnFTK24yUm9kQlJvUUE4Rk5mS2JnWFdLOGNDcUJDZ0Vy?=
 =?utf-8?B?YStFMWRQNkNoUzNhNkg1amZpWnlBUktoVi9BbStHWjB2aFZEbzM2cGJwOUg4?=
 =?utf-8?B?cFRPWjczR1piYVZsMFlEVldhb3l2b3VtV3c1RDJwMjVxWVNEdnJ3WUtkNGVF?=
 =?utf-8?B?VTk5cVNwOU0wcm93T0VaSVZkKzVlcUVyb09vd2hsbzJYOUNqdjBveGxuSVVy?=
 =?utf-8?B?UnVVZGlXc0duaEZkRGtGQnJpd1cxZHB5aTBFT0lPVy96TzQ5NWh1VmdhWGhn?=
 =?utf-8?B?UGVUTzZmeEx0SnpTb0VXaXdVMG5hZnpFdDRMcDdacGExd2tod0QvZ2NHTkla?=
 =?utf-8?B?TDNOa2d0bGdXdEpNTEhmdFplVFdydEVHQXAxMFphUVBnMWdaYUh4ai9LRGpI?=
 =?utf-8?Q?nsZQ=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf5ac14-1667-4d32-b0a5-08dd4c9b355f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 01:59:25.7143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0MOmtsSDYF2sR91RVdLHXhy/BDJ4uG2vEkdxu3d6vYHOUQaNpUgGqz8FP60WCEb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7399

On 2/13/2025 7:55 PM, Rick Macklem wrote:
> On Tue, Feb 11, 2025 at 11:05 AM Tom Talpey <tom@talpey.com> wrote:
>>
>> On 2/11/2025 7:26 AM, Rick Macklem wrote:
>>> On Mon, Feb 10, 2025 at 11:11 AM Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>>
>>>> On Mon, 2025-02-10 at 13:07 -0500, Tom Talpey wrote:
>>>>> On 2/10/2025 8:52 AM, Chuck Lever wrote:
>>>>>> On 2/9/25 8:34 PM, Rick Macklem wrote:
>>>>>>> On Sun, Feb 9, 2025 at 3:34 PM Trond Myklebust
>>>>>>> <trondmy@hammerspace.com> wrote:
>>>>>>>>
>>>>>>>> On Sun, 2025-02-09 at 13:39 -0800, Rick Macklem wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> I thought I'd post here instead of nfsv4@ietf.org since I
>>>>>>>>> think the Linux server has been implementing this recently.
>>>>>>>>>
>>>>>>>>> I am not interested in making the FreeBSD NFSv4.1/4.2
>>>>>>>>> server dynamically resize slot tables in sessions, but I do
>>>>>>>>> want to make sure the FreeBSD handles this case correctly.
>>>>>>>>>
>>>>>>>>> Here is what I believe is supposed to be done:
>>>>>>>>> For growing the slot table...
>>>>>>>>> - Server/replier sends SEQUENCE replies with both
>>>>>>>>>       sr_highest_slot and sr_target_highest_slot set to a
>>>>>>>>> larger value.
>>>>>>>>> --> The client can then use those slots with
>>>>>>>>>          sa_sequenceid set to 1 for the first SEQUENCE
>>>>>>>>> operation on
>>>>>>>>>          each of them.
>>>>>>>>>
>>>>>>>>> For shrinking the slot table...
>>>>>>>>> - Server/replier sends SEQUENCE replies with a smaller
>>>>>>>>>      value for sr_target_highest_slot.
>>>>>>>>>      - The server/replier waits for the client to do a SEQUENCE
>>>>>>>>>         operation on one of the slot(s) where the server has
>>>>>>>>> replied
>>>>>>>>>         with the smaller value for sr_target_highest_slot with
>>>>>>>>> a
>>>>>>>>>         sa_highest_slot value <= to the new smaller
>>>>>>>>>          sr_target_highest_slot
>>>>>>>>>         - Once this happens, the server/replier can set
>>>>>>>>> sr_highest_slot
>>>>>>>>>            to the lower value of sr_target_highest_slot and
>>>>>>>>> throw the
>>>>>>>>>             slot table entries above that value away.
>>>>>>>>> --> Once the client sees a reply with sr_target_highest_slot
>>>>>>>>> set
>>>>>>>>>          to the lower value, it should not do any additional
>>>>>>>>> SEQUENCE
>>>>>>>>>          operations with a sa_slotid > sr_target_highest_slot
>>>>>>>>>
>>>>>>>>> Does the above sound correct?
>>>>>>>>
>>>>>>>> The above captures the case where the server is adjusting using
>>>>>>>> OP_SEQUENCE. However there is another potential mode where the
>>>>>>>> server
>>>>>>>> sends out a CB_RECALL_SLOT.
>>>>>>> Ouch. I completely forgot about this one and I'll admit the
>>>>>>> FreeBSD client
>>>>>>> doesn't have it implemented.
> Btw, I just coded this for the FreeBSD client and used a fake server
> to test it. I found that wireshark doesn't know how to decode the
> argument for CB_RECALL_SLOT, which is another hint that it is
> not being used. (It will take a while to get into releases.)
> 
> I, personally, think CB_RECALL_SLOT is pretty useless, since it can only be used
> for sessions with backchannels (no sessionid argument).

The primary reason for it is for managing RDMA credit resources used by 
idle clients. If the client is sending no traffic, there are no 
opportunities for the server to send back target slot changes. Since 
RDMA credits consume significant memory and RDMA NIC-based resources, 
releasing these, or sharing them more usefully without just closing 
connections, becomes a big win.


>>>>>
>>>>> The client is free to refuse to return slots, but the penalty may be
>>>>> a forcible session disconnect.
>>>>>
>>>>> I agree you've captured the basics of the graceful-reduction
>>>>> scenario,
>>>>> but I do wonder if nconnect > 1 might impact the termination
>>>>> condition.
>>>>>
>>>>> Because nconnect may impact the ordering of request arrival at the
>>>>> server, it may be possible to have a timing window where one
>>>>> connection
>>>>> may signal a reduction while another connection's request is still
>>>>> outstanding?
>>>>
>>>> Not if the client is doing it right. It doesn't really matter which
>>>> connections were used, because the client is telling the server that "I
>>>> have now received all the replies I'm expecting from those slots".
>>>>
>>>> IOW: the client is supposed to wait to update the value of
>>>> sa_highest_slot in OP_SEQUENCE until it has actually received replies
>>>> for all RPC requests that were sent on the slot(s) being retired.
>>>> It shouldn't matter if there are duplicate requests or replies
>>>> outstanding since the client is expected to ignore those (and so the
>>>> server is indeed free to return NFS4ERR_BADSLOT if it has dropped the
>>>> cached reply).
>>>>
>>>> Now there is a danger if the server starts increasing the value of
>>>> sr_target_highest_slot before the client is done retiring slots. So
>>>> don't do that...
>>> Well, I think both you and Tom are correct, in a sense...
>>> Here is what RFC8881, sec. 2.10.6.1 says:
>>>
>>>        The replier SHOULD retain the slots it wants to retire until the
>>>         requester sends a request with a highest_slotid less than or equal
>>>         to the replier's new enforced highest_slotid.
>>>
>>> I think the above is at least misleading and maybe outright incorrect.
>>> So, if the above were considered "correctly done", I think Tom is right.
>>
>> I think both Trond and I are right. :) In any event we're not disagreeing,
>> it's just thaty the client implementation needs to be careful.
>> If there are multiple forechannels, they all need to be taken
>> into consideration. The server doesn't have any protocol-specific
>> guarantee that the client has done so. Therefore it's on the client.
> All the client needs to do is not use the slots above the new target_highest.

Pretty much, yes.

> To me, it is the server that needs to be careful to not throw away the slots
> above target_highest before any RPCs issued by the client before the
> target_highest was lowered might still be in flight.

Also correct. The slots can be retired (and freed by the server) when 
the client reduces its slot highwater.

Tom.
> 
> At least that is my current understanding of it, rick
> 
>>
>>> I did the original post in part to see if others agreed that the server/replier
>>> must wait until it sees a SEQUENCE with sa_highest_slot <= the
>>> new sr_target_highest_slot on a slot where the new sr_target_highest_slot
>>> has been sent in a previous reply to SEQUENCE. (Without this additional
>>> requirement of "a slot where..." I think the SEQUENCE could be in an RPC
>>> that was generated before the client/requestor saw the new
>>> sr_target_highest_slot.
>>>
>>> I might post about this on nfsv4@ietf.org, but I do not know if it could
>>> be changed as an errata?
>>
>> I'm not sure it's wrong, but it could perhaps be clarified if there is
>> an ambiguity that leads to a flawed implementation. Adding informative
>> text can be a slippery slope however, it can lead to new ambiguities.
>> Either way, it's an IETF matter.
>>
>> Tom.
>>
>>>
>>> Thanks for all the comments, rick
>>>
>>>
>>>>
>>>>>
>>>>> Tom.
>>>>>
>>>>>
>>>>>>>
>>>>>>> Just fyi, does the Linux server do this, or do I have some time
>>>>>>> to implement it?
>>>>>>
>>>>>> As far as I can tell, Linux NFSD does not yet implement
>>>>>> CB_RECALL_SLOT.
>>>>
>>>> No, but according to RFC 8881 Section 17, CB_RECALL_SLOT is labelled as
>>>> REQuired to implement if the client ever creates a back channel. So
>>>> other servers may expect it to be implemented.
>>>>
>>>>>>
>>>>>>
>>>>>>>> In the latter case, it is up to the client to send out enough
>>>>>>>> SEQUENCE
>>>>>>>> operations on the forward channel to implicitly acknowledges
>>>>>>>> the change
>>>>>>>> in slots using the sa_highestslot field (see RFC8881, Section
>>>>>>>> 20.8.3).
>>>>>>>>
>>>>>>>> If the client was completely idle when it received the
>>>>>>>> CB_RECALL_SLOT,
>>>>>>>> it should only need to send out 1 extra SEQUENCE op, but if
>>>>>>>> using RDMA,
>>>>>>>> then it has to keep pounding out "RDMA send" messages until the
>>>>>>>> RDMA
>>>>>>>> credit count has been brought down too.
>>>>
>>>> --
>>>> Trond Myklebust
>>>> Linux NFS client maintainer, Hammerspace
>>>> trond.myklebust@hammerspace.com
>>>>
>>>>
>>>
>>
> 


