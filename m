Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734FC4739D9
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Dec 2021 01:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhLNA6T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Dec 2021 19:58:19 -0500
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247]:37047 "EHLO
        esa10.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229672AbhLNA6S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Dec 2021 19:58:18 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2021 19:58:18 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1639443498; x=1670979498;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZPBxmADtzCKxR3QEkW0t4pw3oODdswRpAay+dYMUNAk=;
  b=eWp12MZo63ZvQI5bOwVbSy+VXoRYYSAkSPHfp2mhveZoJDoXu0ZufRb2
   eLs+HW2vjUwT0ilfMCEeZNu/clIH9cGAsTTgmWsMysO5171oLJtTEDrbx
   I0RG+k69BpA5DxRnHTYQ03DdGRjGhz6r2XYG12/jYBTd5bCXSfhFy+xLC
   Uk+30MeelVxa+IRZimStubbPeC5+vup7WPihhz7FjZR4GKOngsJKAe6cu
   1rSLRM32VCvbw/4QWhsdZhGmw3i9L6i2t0Izj1WGLfA6sZ7TiLy1M6U4F
   gC1xbHevQ4FkXSbsiEyp5AU229gb5vf5ZtF9h55a7eYfnyvIcA1Gu8b8K
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="45872821"
X-IronPort-AV: E=Sophos;i="5.88,203,1635174000"; 
   d="scan'208";a="45872821"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 09:50:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkjTpnLaRtn1rBXb8fkODffRWPzy0CbVzA/cdVSgF7XZEAfbUbhnPH2UjtJT0aOwic5z1mBcXHL+LYowK+omdERILHGH2zOevyPv+9s5+hvXUSeCNxx+K50ujLC+TmMMZ5xVZUaFsINSc779bkBxn0tlL+h0hVg1orVVF8w4fxSiN4ftYdwQtvjtBkeDoouZ+2Pp2+jXCr/p5QLYM/tt9Rtc5FAvmkbhcFT9rClIHV7+xi780l3yO699c1wOU/HelHC2ruLz4WwzSRxKjzkOhVL3kbrtWdSucdDiuNDAlPbwWvQors4nRTPHYrNzGeiAQHYifNz0vm1ouE14/3rT1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPBxmADtzCKxR3QEkW0t4pw3oODdswRpAay+dYMUNAk=;
 b=JlZwHEEomhztkCzrxIi/Q8uy7Q1chnR+6R3v9BkqRV3sNsfgH7APHQfyhDEh8KVFWMMFlFrDyvYOHRQKSpZkIp+4ron7bWxFJJ2MPVoEcv4gb1gL+m+c1vTLwLXNAr/XizosuvCbaHQuJdGukPOj50PoiEtJFuhzdIY91BQFL9Rd2uuJfYszyekqNYLLAYZWjOV65bPB53CKtejD4Unz7gN9Sgt5avhkDOpZugVDLb7L37ZwWxRa0NXKYm/QvZmH79bYBuglFq1EcphVAbDuSjAsZfQaEd7FQl9NVQoE0hCoVyHP5u1rPmUaZKImXwq3P46P9nb3AXrwFgviG1MMbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPBxmADtzCKxR3QEkW0t4pw3oODdswRpAay+dYMUNAk=;
 b=VQIrKHzWgiuYpVfD5fpbT6Xb2PV8qVsTQPBeNSRHSKJqeDQE+SfKaPygYDeN7OmnOBNqzB3aAZzoSdX000XpU969jDNZX2cyjYZPhXizMCqVhg6Puae8a0BW2tSu1pzvmFdX05bTelAKmyX5u7DU6gcvryf4F21fVdrzqdnkE94=
Received: from OS3PR01MB7705.jpnprd01.prod.outlook.com (2603:1096:604:17c::12)
 by OSZPR01MB8218.jpnprd01.prod.outlook.com (2603:1096:604:1a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 00:50:53 +0000
Received: from OS3PR01MB7705.jpnprd01.prod.outlook.com
 ([fe80::f435:c43f:4ecd:969e]) by OS3PR01MB7705.jpnprd01.prod.outlook.com
 ([fe80::f435:c43f:4ecd:969e%3]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 00:50:53 +0000
From:   "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [bug report] nfs clients fail to get read delegations after file
 open with O_RDWR
Thread-Topic: [bug report] nfs clients fail to get read delegations after file
 open with O_RDWR
Thread-Index: AQHX79JfuINHTbm/MEyB8s/TllCT9qww+L0AgAAuQ7U=
Date:   Tue, 14 Dec 2021 00:50:53 +0000
Message-ID: <OS3PR01MB770504D572DE88FD1E51BD3689759@OS3PR01MB7705.jpnprd01.prod.outlook.com>
References: <OS3PR01MB7705959736BA3A5BDF9C0AFD89749@OS3PR01MB7705.jpnprd01.prod.outlook.com>
 <20211213215550.GA2230@fieldses.org>
In-Reply-To: <20211213215550.GA2230@fieldses.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 6d23d552-dbeb-dc04-e011-24fa81b67746
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcddcb49-2b0e-4c2e-ec7a-08d9be9bc7d3
x-ms-traffictypediagnostic: OSZPR01MB8218:EE_
x-microsoft-antispam-prvs: <OSZPR01MB8218CB94AF65B18A4B50916989759@OSZPR01MB8218.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cz/33vKpdIPAGWe2GIXlVz6xF0vXDg/c3I0R9Tah/bJTndH9Qvh5b2tFYjCgcxpaseYs77InEz82zJp87xAeinekW25j2uGueiFQEhAgtBq+vogad/wpRhaQrotbfqZn04UQEX6dM+KdJTMJElIw6yENKnkMaafbQkahMnN5OGEf4Ysa8SQGR3ONQ2eCyqUv6f4+agvlPcBIoI6tlnTSFumz4NFzO4X9Lb4PXWtK/w8ILd3eLPfVXkMtibs9WavMHF4aDtcnJOBMsxoO4VqxDztOmnSnNT3+30WedSR6y3NuM5V2pkpeOv2KzieTdgZaq3sEkPcfMXRw1VEz78XAlZKs4PJu1Z7/OarqlN8ZuqTAP2eWcD/XmNIOaCGwTi1zq/iaBjslkDPUjHIKtFz+DCdULy87g52X0BCDTNxE6J558oL91IlWJXL0o+rEjFq7At7FcV/nPui7LcXnkrFK+ZQXghLigyW3UdTg4h4EFbEzr571wdnCB5vRgYq96kkYMiqRuvWri4p/x4D9GZt4uXnLc9gbGYFeh7uMdKtSi0cDGsGFZDvLolFMsfHOnPgNcYVRa/EJ1sVnxImxcRJhbxGzkFslj1caKtu3nlivQKD5uowVUSzXH7/NtD53s754tkoK5KAFXAtp/sHGaEtCq2tgiJeufp/kFkaLW4Zuc8g/dlXu9J0zWu/53J+TaIv5kMjmaxv7btlHPcyMcezQqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7705.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(91956017)(76116006)(83380400001)(26005)(66476007)(66556008)(64756008)(66446008)(2906002)(82960400001)(85182001)(508600001)(186003)(52536014)(38070700005)(9686003)(53546011)(86362001)(316002)(6506007)(71200400001)(33656002)(5660300002)(4326008)(55016003)(54906003)(7696005)(122000001)(8676002)(6916009)(38100700002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Q0JFMXBhaFUxNHhBdDB4RFQrY3FKend0QnJHZlNhMHpRMkkxM3pFVlB3L1hM?=
 =?gb2312?B?YjcwWWtMU3FQSEh3VWUrQUpSa0VJV3ozVWlJMGR6LzVBVmQwUktPTG8wY3pa?=
 =?gb2312?B?S2FsNy9panRnUFRKOUVQSFVFYzJPT2pwZ2M0NHcyUWVaa1FDUjFMejhBVTIw?=
 =?gb2312?B?U0tSTGJLSEc4Wkg4ZkZiSUVnNjJUS1l2dC92S0EwUkNyQjFXRXJ2VkNoQkk3?=
 =?gb2312?B?LzlMU3o3aHhoK3YveWVIS2MrRUR3SERqR3JLakxLZndEOUZoRjRzUEMvZHpo?=
 =?gb2312?B?enJyMlNWRkJrejhqSEwvQWZqWE1KLytXT0R5c3RRNnFHWFlydG16NzZWeE1X?=
 =?gb2312?B?MDFacWVkektZSGllTTFkQkVXd2tBMVZIM0o5dUN0RUQ5Q2QwQ20vbXRwbkFq?=
 =?gb2312?B?UVBFVDJ2NkR4SkdDYjQ3OStQSGNGWXF4L2JrVTV0VVVDNmhTNE9aTllaQzFy?=
 =?gb2312?B?TnJWdWZJYWFkdUFTMExNM2Zveno5dG1lR25qMmdkWUJvbGpud2NadFZnbVlY?=
 =?gb2312?B?cERnU2tGb0EvdkNtc2NoZUh3SjRQMWxlZEhjZmJXdUlRdk1wR1ZqUXVvNUdM?=
 =?gb2312?B?YTNqdzR6Mm5EUm5FOGMxNHFLRTM3Um5GeloycVl1TlBYOUtyemNnejcvU05P?=
 =?gb2312?B?dFJMeVJsL2NKLysrZndYNXE0VjlocHNkSkp2RDNNczZPazA5elhtSmhWNzNa?=
 =?gb2312?B?ZTNZaHEvL1F4QXh6VVJwWnNZeVVkbGt5a0NLdmZhcFkzZnBnUm01THNTTVMy?=
 =?gb2312?B?dEhFNmtsNUU0TVllQVY0RUs2UjhCRjlrSmtnRitpcHhIMHB1Rkx4YlpHb0x5?=
 =?gb2312?B?VDlQMExEWEVudldGSWhlZlgyUXNVYSt5aGtmSWRLOEhkL1hDTzVlaFg3L0Y0?=
 =?gb2312?B?dVZOYTVjS3p3a0hBdFNRajNEQ0twQzFscmpOSUhzQUpJV1FJckgranlscEdE?=
 =?gb2312?B?RHR3SXNadzhSd3haVWZkZTNyMHBnbTU4aWdmbER3d1pLUVcwYTczWTRHRWcv?=
 =?gb2312?B?VzdVNTFHOFN4M0tsdVQ0T2VRNFQ1SjhObVJKdW1odW95ZmJsQ2FJa09aWWly?=
 =?gb2312?B?alNjWWhZSnAxdm9Pb2NyaXN0WEtzSnhodUpwaWJkeTBNL0tZYjhsZEE4S25I?=
 =?gb2312?B?NHBITFVZeHIySmgvVHE1S3VMWGQxY0VWbUU1Q3N5RnEyMmt3MXA2UlRKTkph?=
 =?gb2312?B?R1kxMC81WnluV0hqbHkyTlZTQXBnRXpuQjdvQStGYnY5NFNZUXY0anRLYTk4?=
 =?gb2312?B?UXRsWEhoTnIyMlo5THN1MXBJcFh3OE8xWXRXdW5NK05yelV0V0Vad0JYMUZK?=
 =?gb2312?B?Z3BXU3NVU3FmWUtpQTlnMlhveGg2akQ4YjVTR1V1N25ZcTRMdnRxRzNWNE1H?=
 =?gb2312?B?ZlltNkFnRXBBdmx6emc5YWpLSndZVThoV0oxY0hKNW1kN3hjRjNkU1dkcGU1?=
 =?gb2312?B?QjhpWDV4TlM3cE1aWVEvV2pvV2lnRWw5QkFZNkR6aTNCa3dUQlEvL25Wekow?=
 =?gb2312?B?RXZxcGl5bzJjcW9yNzQveFBuYmVjRmdVWFBaRDJ4cDZrWFgyYThuNGhZYWEv?=
 =?gb2312?B?dVRReVZkSlNzUHMzVU5zZkxIVEhGNWRuQ2VJQ01HL05ub1dzRTNZMFNXQ1lY?=
 =?gb2312?B?eTNkQ0pCaHF6cEdMOUgwQkVIOUJoSzJFYU9VVzkyQzM2a3RtaTdEdzFoU3p3?=
 =?gb2312?B?ZUJHcExML0lLZE9rY0pHOWtiZXUxYmlYVUJUVnJ5WDZldmF6Y1dHaGVreHZZ?=
 =?gb2312?B?cHY3RXp0K29iREhQMVlqRkdLNi8reVlZckU2UUtjUThIU0Y1STdTaUp5a29x?=
 =?gb2312?B?RStCUk5SNDJHcWgzak1DWFlUZnlrbEptalpUTW5IT0xMTkNTQlBHd3dHS1dM?=
 =?gb2312?B?VHR0OVo0S1hFMWlMTnUrMTBhbDA5b3FNUXMxR2E4NTRTK2RRRy9kcjJTeGpn?=
 =?gb2312?B?VThrVU50cTgvVmxiVDcySzJoNEJ4VElnR2JZSkF3ZlBmbjNCcGpJVkhhVzdu?=
 =?gb2312?B?VkRzWXB4b0UrZmdUVzU3OEl0NVBrY21Dcklsb1dUYllIYlE5VW9pUUgyR0Vl?=
 =?gb2312?B?aEdGOUZsUXdoOVgzTmFURzAwREtnYU05VEEyWDlUU056d3BxVW1oZ3BwSHFG?=
 =?gb2312?B?REtuYkRQb2o1Z3VYYWVaUkhGMXExUURYd1NHY3dHbHdIVWRDVTljMktNMXhW?=
 =?gb2312?B?aGc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7705.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcddcb49-2b0e-4c2e-ec7a-08d9be9bc7d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 00:50:53.0761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUbPetePrB3oTDY5BDZUIgIF6pEfLOxGyTl5tfShd+fMi/70WF/+Bhn1iZj/NH1uZ/FmyOSG6yDukS0L6fWjtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8218
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIHF1aWNrIHJlcGx5IQ0KDQo+PldpdGhvdXQgbG9va2luZyBhdCB0aGlz
IGNhc2UgaW4gZGV0YWlsOg0KDQo+PkRlbGVnYXRpb25zIGFyZSBncmFudGVkIGF0IHRoZSBzZXJ2
ZXIncyBkaXNjcmV0aW9uLCBzbyB0aGlzIGNlcnRhaW5seQ0KPj5pc24ndCBhIGJ1Zy4NCg0KR290
IGl0Lg0KDQo+Pkl0IG1pZ2h0IGJlIHN1Ym9wdGltYWwgYmVoYXZpb3IuICBJZiB0aGVyZSdzIGV2
aWRlbmNlIHRoYXQgdGhpcyBjYXVzZXMNCj4+c2lnbmlmaWNhbnQgcmVncmVzc2lvbnMgb24gc29t
ZSBpbXBvcnRhbnQgd29ya2xvYWQsIHRoZW4gd2UnZCB3YW50IHRvDQo+Pmxvb2sgaW50byBmaXhp
bmcgaXQuDQoNCklmIEkgdW5kZXJzdGFuZCB0aGUgY2FzZSBjb3JyZWN0bHksIHRoZSBtb3N0IGNv
bW1vbiB3b3JrbG9hZCBpdCBpbmZsdWVuY2VzIGxpa2U6DQoNCk9uZSBuZnMgY2xpZW50IG9wZW5z
IGEgZmlsZSB3aXRoIGZsYWcgT19XUk9OTFkvT19SRFdSLCBjbG9zZSBpdC4NClRoZW4gc29tZSBu
ZnMgY2xpZW50cyBvcGVuIHRoZSBmaWxlIHdpdGggT19SRE9OTFkgcmlnaHQgbm93IHRoZW4gaXQg
d2lsbCBwcmV2ZW50DQpzZXJ2ZXIgdG8gZ2l2ZSBhbnkgZGVsZWdhdGlvbiB0byBvdGhlciBjbGll
bnRzLiAgSXQgbWF5IGNhdXNlIG1hbnkgdW5uZWNlc3NhcnkNCnJlcXVlc3RzIGZyb20gY2xpZW50
cyBiZWNhdXNlIGxhY2sgb2YgZGVsZWdhdGlvbnMuDQoNCi0tDQpTdQ0KPj4tLWIuDQoNCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkZyb206IEouIEJydWNlIEZpZWxk
cyA8YmZpZWxkc0BmaWVsZHNlcy5vcmc+DQpTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAxNCwgMjAy
MSA1OjU1DQpUbzogU3UsIFl1ZS/L1SDUvQ0KQ2M6IGxpbnV4LW5mc0B2Z2VyLmtlcm5lbC5vcmc7
IGpsYXl0b25Aa2VybmVsLm9yZzsgdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbTsgYmZp
ZWxkc0ByZWRoYXQuY29tDQpTdWJqZWN0OiBSZTogW2J1ZyByZXBvcnRdIG5mcyBjbGllbnRzIGZh
aWwgdG8gZ2V0IHJlYWQgZGVsZWdhdGlvbnMgYWZ0ZXIgZmlsZSBvcGVuIHdpdGggT19SRFdSDQoN
Ck9uIE1vbiwgRGVjIDEzLCAyMDIxIGF0IDAzOjM5OjI2QU0gKzAwMDAsIHN1eS5mbnN0QGZ1aml0
c3UuY29tIHdyb3RlOg0KPiBTbyBJIHdvbmRlciBpZiBpdCdzIGEgcmVhbCByZWdyZXNzaW9uL2J1
ZyBvciBhbiBleHBlY3RlZCAiY29zdCIgb2Ygc3BlZWR1cCBvbg0KPiBuZnNkIGZpbGUgY2FjaGVz
Pw0KDQpXaXRob3V0IGxvb2tpbmcgYXQgdGhpcyBjYXNlIGluIGRldGFpbDoNCg0KRGVsZWdhdGlv
bnMgYXJlIGdyYW50ZWQgYXQgdGhlIHNlcnZlcidzIGRpc2NyZXRpb24sIHNvIHRoaXMgY2VydGFp
bmx5DQppc24ndCBhIGJ1Zy4NCg0KSXQgbWlnaHQgYmUgc3Vib3B0aW1hbCBiZWhhdmlvci4gIElm
IHRoZXJlJ3MgZXZpZGVuY2UgdGhhdCB0aGlzIGNhdXNlcw0Kc2lnbmlmaWNhbnQgcmVncmVzc2lv
bnMgb24gc29tZSBpbXBvcnRhbnQgd29ya2xvYWQsIHRoZW4gd2UnZCB3YW50IHRvDQpsb29rIGlu
dG8gZml4aW5nIGl0Lg0KDQotLWIuDQo=
