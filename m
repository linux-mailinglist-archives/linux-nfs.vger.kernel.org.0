Return-Path: <linux-nfs+bounces-18600-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GWuKKkfe2msBQIAu9opvQ
	(envelope-from <linux-nfs+bounces-18600-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:51:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C178ADC1F
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FB5C3024183
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 08:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB53837E2EB;
	Thu, 29 Jan 2026 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="JaaHBR36"
X-Original-To: linux-nfs@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010060.outbound.protection.outlook.com [52.101.229.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D7237E2F5
	for <linux-nfs@vger.kernel.org>; Thu, 29 Jan 2026 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676692; cv=fail; b=n6CAz9TwCRgLI3SIVPI3sbb58qdS4CZLEWBnqYVfYdPiITRDszMuwdP+boMdOkRED6glY8eVtL1wrFGoRKM3DFBJMjnE4hwtxCRR7GSBqLHA8K7qbUX8dLyUN320RMpHoOER40764lIvAOXEkpkEaX0+mGX7CUd7tx+CcSMDU4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676692; c=relaxed/simple;
	bh=RSJ0IKft5vh/5Lg/2438cuqqsulJDQLg5bqlpsA4P8Y=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BVI5meQXyp9FIqeX4GEU1chrOBEkP/Eaz21ptd1NNpfh+qZKqqpnzSuNLqwioMYFyY53+wA8oeGcYGwdBCrSV/lmbKzhC9BzboYNc//Nv6zaD70yThx8QlOElq6TFYqfg10wfJDcRTZquC6SqzS4vW1ofDvaOh1+XDRu87aYZo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=JaaHBR36; arc=fail smtp.client-ip=52.101.229.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijHAaudyxaRQT5Y1hD5jUJH3Q1aj8gatc+0UHbyrHBvG3biaOXhBl60R6ZSMsn95lMsSHHdb3RddTtqR8PHF06Ndtrr0GtCoHC4AsItlU+uVMPEy4T80ssRMByAjIaxzy1FGmtskjBW6fEQe5o/8XzojEaDkHB40J6b6d7R2OtLz/yO8vbart5S368mXiDDcz3nklLTHsZpEAAKxMqqjn2cBhFmc+hg9wch++LRTpOXMpzKlherw8haW87NyHWrIVw3lbxRMIUatxmFDoNJ18AvTwUwbPOGTWWe+tZlQN9iRO+W9C4DvIGj3TAwhCari0Br6VlCrmf78SLp5M+ygOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXeQK+5NYaEUYjV7KOLaDi/cYog7NwVntNuEz6urV7I=;
 b=zG5XTXPlXv6Yk+sFhaN9i6z7g9XSwZN8EiMnY52KoQPC1I47Tx9Y/OOmD/4bDvDCyW5ciphf3Bu1BDW/BiLeCIY1GZmBcK4fsh4+9roMrnKO1A/uNzItRTKAOXW1jwdq96hu0EQNfdnsovp+QuFHLWGq1QWZFjJPhvImrqQTdCISuXlev5o3rj6gIolBdfN/eUfYMGpV/BIixWHZeQ8kO2Upp9HJqc/n72AY9q9b4G+cd4R2bSPK/FDn//jqFQ6TXKZxbhUXp9Ni3kiw2JPobH5PUO7judDgxeRaBHBe6xIvAXNAYMBYYG2VAdOm7SMhgWlVPhkoGLsoBUKQlxi4xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXeQK+5NYaEUYjV7KOLaDi/cYog7NwVntNuEz6urV7I=;
 b=JaaHBR369anaX63NR6EdGENo1SIszjKkQr8ISJ5OgaeXtVK9reOsz7Y3M0NN3Ouk86Txlq4MOOEwMyuA4eBNSG7mRzC9YsrjBhbWvTnmI6L3139NLFGKLfsqYgPZgpNBCuHo3iobyYhVRbHRSLUq0eDIRKJeDn5qAjkjX2waJtJB8NOWeX5ijRpT159EmxiNProA3mbIXo/O/PA1prr+9ZP21MjF8wJ1ORhOH62Dg/td2tTiAadAM0QiWyyiwyPVIz3YsHnGvXr4lYwghr8Mrd+auLwrIe8wUt6rOS4NGD6ly9x/MS9YT+Bt2xVKZoFLqaB2q++1eC+gg73Mpv7OYQ==
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com (2603:1096:604:1b4::7)
 by TYYPR01MB15165.jpnprd01.prod.outlook.com (2603:1096:405:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 08:51:17 +0000
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a]) by OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 08:51:17 +0000
From: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
To: "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: [nfs-utils PATCH 09/10] nfsd: fix a typo in man page
Thread-Topic: [nfs-utils PATCH 09/10] nfsd: fix a typo in man page
Thread-Index: AdyQ+uD3ey6Mej7QQjWP8iDnZAAfpg==
Date: Thu, 29 Jan 2026 08:51:17 +0000
Message-ID:
 <OSZPR01MB77728AE530C27FA2DADE411C889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=1ffc93d6-df9c-4a07-95bf-46c259fbb93d;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2026-01-29T08:33:58Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7772:EE_|TYYPR01MB15165:EE_
x-ms-office365-filtering-correlation-id: b3509d58-9f27-4c58-14c3-08de5f1390cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?Q1kxOTRaR1lXeWxIb1k5Tlc5cStBci9MZ3JQWVlGTlhteGtsVmVlTkRZ?=
 =?iso-2022-jp?B?dkxoZmpveGpqdFgzWlhNc29sblVDSmhGTjBCODRmTnVTZkdtSk14dEM2?=
 =?iso-2022-jp?B?c3BoamFkckNtWExDaDRtK0JhT2JZNmh1cUsxRXVNemRNMXJqeWFCN0VP?=
 =?iso-2022-jp?B?R1U1ejBndUsvTmdwNmpuVmk2cTFFeG05Z25KVktJNkpIRE9iU2VJbk9i?=
 =?iso-2022-jp?B?eTVvY1h2cU1wblByTGtKbThmUWViNXZ0U09tYTQ3U0xSeWNycEFhc29m?=
 =?iso-2022-jp?B?SnRpZDY5ZHVnMDVhV3lqbDJ2MVVmNEEwT0FWTG41QUZ3cGhMaFc1elhP?=
 =?iso-2022-jp?B?NW5aVCswWHlQdmxLQ2pTcGZjVnQzUjBSUXpadlhIazh3d1ZYdlRwcmVI?=
 =?iso-2022-jp?B?aGdSd3pQQWxPdmtGNTRqVjNMSXlFSlFiMWI5Z0s2b25IeTVGYlc4b1Nj?=
 =?iso-2022-jp?B?bjdlYmpoTnJmcTNmb3NrRHpoSURQK2E4S2hacmdlRzFqNDVZR1FJUFo0?=
 =?iso-2022-jp?B?RzQxeTF0TWlCTmo4MUZ0OVlvcmVGcmNieXF3YWhLUGdOYWZSMlVQdk1S?=
 =?iso-2022-jp?B?RFNhL3doM2lyTkNra0tJdnRNMHdTZ1AvTWFPV2Irbmpsa2NrN1ZBV2Vp?=
 =?iso-2022-jp?B?d01hclNLS1VMcnBhTDRzVjg0a3VGcmswaFRTYkdlYTZMd1BFcldqL2E5?=
 =?iso-2022-jp?B?L0h6eUk1WFNnaGNaWXFjUXBFZXJIbWh1QkprL0wrNVRIdGxxMUJRdTk1?=
 =?iso-2022-jp?B?UUJsYkFWTHFvWmtoQ0NhTHFWbmJQdWxPaTRTaXg2eGJpR2hNNXlMMXFr?=
 =?iso-2022-jp?B?S0JCTUkxTzZZWE1Sem45cEhKbDlGTEJML053SzM2Yi9BT1M2UFdtUmtL?=
 =?iso-2022-jp?B?L0VidW1HK1Q5WTlNNU1WSk5tcmlkNEpKZHBLNXNvc3VQMkRXR2NYckZW?=
 =?iso-2022-jp?B?c1ZpZk9TUUpjSm05ZXFMOTFBMkU5TGM2RzFkUEhjUS9MbUtxdUVKdmFW?=
 =?iso-2022-jp?B?NTIvR3RReDdJeG5PUGpEeVg5cTRURGxyeTZRVk43dHBQNExBVEdkeGhm?=
 =?iso-2022-jp?B?T29Pak9MUTdzN3N6M2hzZ0NiUjNOOFVQVXZ5K2diUmJjM0pyYmhBZ3lw?=
 =?iso-2022-jp?B?bWZyNGwvZ0FXcTRMVVdDbGliL2dSSWduZ0p3djdUUkdBNG95U1huUis3?=
 =?iso-2022-jp?B?eXEzR2lXN284RTZwME5MSmpNSFVibnpadDlYZ1dIc3llK09CaFNNSFFD?=
 =?iso-2022-jp?B?SUJIeGRma3pZQUFqKzZibU4rYzltclMyVFRGOGUvb0JrMGtoWEVhL0R2?=
 =?iso-2022-jp?B?czkvNjBMWTN4c2ZEYWJ5dWtCYXFtT1FQTm1lVXVOVnF1VnRpZzlMV2xM?=
 =?iso-2022-jp?B?cUZVQ2Q3Z3ZIZmlFNTlCclpWNXlVdHZ0OFZ5eWl1Q1VKeFdiaWFVTkVr?=
 =?iso-2022-jp?B?b1loeVBvRk1BdTVYTTQ2QmhJamFPQWx0dDUwemVLYi9zVjlZRUdxYzkr?=
 =?iso-2022-jp?B?dURMZTdJek56ek1ZYTdmellDSjViUGtUZWlmQ1VqaDFIV2dITFJWR1Rm?=
 =?iso-2022-jp?B?alpxV0lhb1hJUDJQa3VuWHZicEZwQnkyZmZubWRyTWRoV2RHSU16TDZs?=
 =?iso-2022-jp?B?dS9DanAzdk91cEhvR2oyV3BlTzh3VkMweVg1cmFDRFUrT0JyVE1kWG9O?=
 =?iso-2022-jp?B?dGV5aUZXWXlRL0FYNUJ6eHg5QWt4SFp3Y3pnYzZrRm5CNExYMXVsSENK?=
 =?iso-2022-jp?B?QkpoSU9OZktaN2F6K2thYUdHWGpDWXAyUUFsWGg1Q0N6bTllbEpEaXFR?=
 =?iso-2022-jp?B?YTFsQ0NuemZQZWt0bmNpblYva0RBY2laV0lPaEdYWGhjZVBweHZRdWZo?=
 =?iso-2022-jp?B?UkN0bjkrenFsRzNtdEFGVUcrOS9meHlJZzdKZFFvTmppeTVSYitCQ3Nt?=
 =?iso-2022-jp?B?TG9TcWtLa1d5L2oxUHJUa0VDb29sb3c1WnZ6NFE5VE80RmZESHB0YS9N?=
 =?iso-2022-jp?B?dWFTQUpkQnVvUG9KYmxyZ2ZtS3ZHNFcrZUhYdTBPZlMySWgwNXRsY3Nz?=
 =?iso-2022-jp?B?Z3VwWGFYT3ByTkpqN2pPbjQ0SDZFMDRKa2orMlczeG45SlYxOGdaZ1pD?=
 =?iso-2022-jp?B?WWJXLzBjR1NHSWhIMHJvZUFTTWE5WEsyS0F1QmhKTHV4ai9vckR0RCtS?=
 =?iso-2022-jp?B?dEcxWGRtbzBiOHVFb3hramVYNjEyT1J3NzVKVlVBM00yTHB2d29zb0FK?=
 =?iso-2022-jp?B?VjlPUVRoVERaVWxRVkFhSjg4NThZZFNpcGI2U1g5WHFocFo2UlNhTU8r?=
 =?iso-2022-jp?B?M3l1Vzc1NnRnVEVlVHFhaFRoZlRJcEREbUZiYm0xQ2tzZHZFakJGc0JO?=
 =?iso-2022-jp?B?OWZ3eGZxbW5rOUx2cmxsVGlXVDhVQmszN2w=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7772.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?VTdUWk9ScDZNN0FsYXp1V3kwakJrOGlKZE1xSzkzU0tKRkcyU0M1Sitr?=
 =?iso-2022-jp?B?bWNZQjgvd0puK2hMUzdaNGx3REN3UVE3dU9wN0xXSUxTbEx3UUtvSm5W?=
 =?iso-2022-jp?B?bFY4WjFvcEwzRFNaNzB3dUNHU2pUc05maGhtd0szMnlhVEFKWUxId2k3?=
 =?iso-2022-jp?B?cFMrYmliZWJKK053dDJha2VtSGl1bTduKzNxUkZWaWZSZkZWUm5sMzlY?=
 =?iso-2022-jp?B?SGlBY3UvcHRMUzhTYnhFZjlOY09pT0RZNnBWVmU3Yk1HeVg0bmdRUFAz?=
 =?iso-2022-jp?B?b0NiNVA3OGZCSktIU0h0bXExZlJhZTNSNU1VR0RmeU5Ec1F1cXZRM0Z3?=
 =?iso-2022-jp?B?LzhSRVdqbmc2QmdOS1BNV29kOGMrQm9hM1puUzJrZkh0MTFYV3F6ZFZK?=
 =?iso-2022-jp?B?bzZCVTh4aVJ2YlhiSnVPbzRGbENaMStsblQ0Wms2MFByMS9lZ3Q5WGVW?=
 =?iso-2022-jp?B?YUs4RGhnaEV4dFFETVNZN3RBZ01haXluOEtXcWx3Y2lUem1pRE12d0lu?=
 =?iso-2022-jp?B?TDVFTHo2ZFlkeTVvMWdBb3BhUjBxS0NyTTRCeTczd2VoMEVPeEcyWmxS?=
 =?iso-2022-jp?B?NjZ6eWhUQW1PeitoSU9wd3ordUljdWVwREFBK0dWNkZaL2NDVkp1OEpr?=
 =?iso-2022-jp?B?bTZydVhtY2I3bXp0eWlGSURsaXBLUVZvNlM1WVdjKzJaR25yV3MwNEc5?=
 =?iso-2022-jp?B?eHo5dTJTMzEyaE1xNWRzZDZqZ1RCYnJ6WStHczI0UFRWbmNFMmRmYUo0?=
 =?iso-2022-jp?B?Q1hUUVo0Vm5ZcnU1Z29hT1YwSWcxTFJ1YXhGbzl1Tkovbk9ISUk5bDFy?=
 =?iso-2022-jp?B?ZzJJdDFUMGJQM1R5UURreWdhNjBwa2srcTlXcFdYZXVCSVAvTkpGYUkw?=
 =?iso-2022-jp?B?cTNOS2tGOW4wRWxESHFIWms1aEtSOFcrNmZUcXpQYzZYeVBrTXNjQ0dm?=
 =?iso-2022-jp?B?YWxSb1VzY0lRVmdrbjVPMURSQUYxbkUwZ1YrRUFYekhSNE15QWRURDBD?=
 =?iso-2022-jp?B?blhtTmdZL01PaXhUOW1qY3R3aElIRHFHY0ozVUthNTMvb2l0V003cWlz?=
 =?iso-2022-jp?B?Mld4YWp0WExzS3I5VUozc3ZrdDVYVE94M3dITmtXY0JEQjIvVjFQbG5B?=
 =?iso-2022-jp?B?TWUyays4OW8ySUV4ZWFDMC9ubWl5eHN1R1BKRTB3eHZjc2kvV1VHZnll?=
 =?iso-2022-jp?B?NHduYXZpMTYrejFtVHRhMHhMcmV0bUNaR1FjdzdUQzRZaVMrWEY4em8x?=
 =?iso-2022-jp?B?dmtZaXZwSTVaZWNUdXpEYUZwNlliMWVOY05rY3VxYm9KWUVPVWY3V1lM?=
 =?iso-2022-jp?B?MHovcThSclNWcEt4RkRtcGlDMmVPb0xIbFhzaXJXWUxGWndVSHVpSFlz?=
 =?iso-2022-jp?B?QkpGMENNalZwTkI0WjFpR0M0eXliN0xGQUI0c1N6UGZycXI5T2NUWWc2?=
 =?iso-2022-jp?B?ajNVdGJoVkhTS0h2VS9ZN2VlajJHQjNqUHF3NkRuNnNoTXVTS0xIRXRy?=
 =?iso-2022-jp?B?MmlWemJoem1UWjZHQlk5aEdGWWF4WlUxYzgyWDZkV1BCRkdJVGx3SE9x?=
 =?iso-2022-jp?B?UW9ab3A1WVZHQzBnY2U2Y0hWNVE5UGtrYnZGVG5GaEc3QnhWWXNLMmh3?=
 =?iso-2022-jp?B?bU1UZk90NUdXdWMyMkY0ZWZtak1sSXNLZ0JuUWVKUnZSUUo4bGVIQVpL?=
 =?iso-2022-jp?B?Qkl3WWlrdjZDak01bkxKUWNmL3RiaTg5cy9BTDJNWnIyQXR3U2R5UHps?=
 =?iso-2022-jp?B?RXFQVEhXVkhwRGZlOGo2OFFYQUJiN0NNRDhuSWcwdHlnZGdnRmEyUXBp?=
 =?iso-2022-jp?B?T1Q5TWxvYjRwSXg4SFluU25CT0pneXVmQit1c1o0S0NVa0JBQ2l6ZHFx?=
 =?iso-2022-jp?B?Sm9IU3dIU1pISmJvNzVISjNyWlVpallYTVo2U1V1Z2RKVXRTUWQ3YlZF?=
 =?iso-2022-jp?B?NUxVRHJudC9BRDRzUzhWSmxsdVU0aFlMQzF6VjdzeGlobVNjWVZXUjBE?=
 =?iso-2022-jp?B?bG5BUFYzVjR2WlE1K1NTOEhzYXdzY0JQeDlGM0hrUnduWWJyV1N2RU5Z?=
 =?iso-2022-jp?B?UTl5dEZTeTVqcGFRaXRMY1ZRY05xdFoxblk1NnMwUUpkaVVOZEdnTTM4?=
 =?iso-2022-jp?B?N2UxR0ZjYU1OQVh4WVRyZ3EzUVJLemppZWxkWTJ6TEhXVFZieGZFa25n?=
 =?iso-2022-jp?B?djJaSzRxZXA5YWNmU3QxRFB3V0huN0J6V0ZrdkMvaTBENUUvV2ZQN1dm?=
 =?iso-2022-jp?B?WjBpN0xibEdEcVpYeXlZSnU1dndqa2pvRkdKazFGYzl5bHNaYTZiQjlB?=
 =?iso-2022-jp?B?NU81NUMxa0pacllCdVhNTThrRTlzc1RENzh4R0JuRnFRY1RSaU93RmEr?=
 =?iso-2022-jp?B?VWo3NHhKaG5weDJ1RlBiRDVWeVovcnp6c3g5eVNJSklFdnA4K1cwUUJ6?=
 =?iso-2022-jp?B?N0JnZk16U1o3SWl0NTl2a2hxUWV6RWk3c1ErZzZyc09peDRSbjZ5ZWdZ?=
 =?iso-2022-jp?B?RlVTWC9EVFV1ODZwNzZTUTFqV2NWYUhLZ094Zz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7772.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3509d58-9f27-4c58-14c3-08de5f1390cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 08:51:17.1569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nI2FiGB6V9QAJdPPPNtn5QruHT7Ph/BhgZt3JGTXCDUrxwg8u+UP6q+4E8tXoHWMCzhBaxNb/byDDvjAaChKPhD+NLsE3Dzkifm2Dyyqh88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15165
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[fujitsu.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[fujitsu.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18600-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[fujitsu.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.ikarashi@fujitsu.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C178ADC1F
X-Rspamd-Action: no action

Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
---
 utils/nfsd/nfsd.man | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/nfsd/nfsd.man b/utils/nfsd/nfsd.man
index 6f4fc1df..26eef607 100644
--- a/utils/nfsd/nfsd.man
+++ b/utils/nfsd/nfsd.man
@@ -43,7 +43,7 @@ NFSv4.1 and later require the server to report a "scope" =
which is used
 by the clients to detect if two connections are to the same server.
 By default Linux NFSD uses the host name as the scope.
 .sp
-It is particularly important for high-availablity configurations to ensure
+It is particularly important for high-availability configurations to ensur=
e
 that all potential server nodes report the same server scope.
 .TP
 .B \-p " or " \-\-port  port
--=20
2.47.3


