Return-Path: <linux-nfs+bounces-10-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82AE7F32AC
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 16:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83151282886
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 15:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEC44779F;
	Tue, 21 Nov 2023 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mQirymBq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xfsUQmud"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC94D97
	for <linux-nfs@vger.kernel.org>; Tue, 21 Nov 2023 07:48:13 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALFctdq018740;
	Tue, 21 Nov 2023 15:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Pgq/qBrQMf5X6DQhWy0w70qGfUHKQVEf1iyatXQSm70=;
 b=mQirymBq8bE1WDMWQP8TZVF34YFQQtn+ruozE9BWdT+8gOCSuq3wBIgBsrSpzvSbCVh7
 YF2NAw7a8hxcyNdknaFoC4GqgOrDHIRYqzwDX11MKl1X3NR1Yja6vqHFyqFLK8OL0OJn
 utV+iDIdyz96sTjc98w/91cTcGpYN3oYFa0lxJmkYxVe84st784e6s7qHj3RTPJGYggJ
 fm0YlElPgofJDyToRDoXwo6WqajlyHU52oB8mUGymfX4f8U199Uood7UnD2hii8LS4KC
 YGsfSuCJgejvT/kcz8Hu5oQUOWaqkqj+bBxjvmqWSyER3Ney9eovmgU7WphMclHAqWYz pg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uem24wcnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Nov 2023 15:48:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALFkFYT031214;
	Tue, 21 Nov 2023 15:48:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq79tdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Nov 2023 15:48:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlZad5A5Ss14TpyANJ6thJXOMwSTcYbOdsXg3T6t6lFItyFsevcmjWgrU6otCfXuVAjcCC9CyVL0umo5RORCFX6rXUYtgKFn9WiOrvC2/sT/xgODDubBqiOLxidmEJtxg5hgSwoLIIQpQXjex88ret78SQ+9BwhcLfKkEFfY10EBuOPZN13Gsmbho620AFuRobcp9PiR7LOekOcG2STZ0IcJsgGZgSc4yCYG9U1BOesEmwLHKWx2yooOGO1IFdjFSsVrvzZq3IKB+ZbN2mAY44TSM2GS42kEktiXkaAzSS42wHZAC4nv6t2+RcYpQIqe/8CzsISWquPy9aPYtQrdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pgq/qBrQMf5X6DQhWy0w70qGfUHKQVEf1iyatXQSm70=;
 b=Zf/WJbOLm+VOiUyVThnPcGV5mJqzvyGJZRZY/bp2XiRuPSSHOX5bZtP5U3eipWgdfmmecr/8ukBwW9+nlorGfmdrFed+xMuPjrqD75Uk6JqwsN5P//cy8AS3DAKotDuOsjdaaN3s094OUcG6STXTZMCnHinNgrypf4yX1ly3RnWsp8H1ee6WdvWvgVAGNoQfmHGLXckUsPxmSCcEHG/33fEjh9WNeNn/PUFR488d+QID1uE7pXDXBCVqKTiXXGv0WYoNzr7PEKku97w+QXqT1s5ptFP2FTXCpijngdecwBN3U/u4puDDFVSeLAq5EVosb/DkxL8+g4MvXBWt468Ygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pgq/qBrQMf5X6DQhWy0w70qGfUHKQVEf1iyatXQSm70=;
 b=xfsUQmud52L97IUgTAJP0PApgyNDM6hwbE9PNPl1+mQ0eU+1cS9qgwPGmbD6x3t9pDuWDOnEHpN/O08P1RA24rPh/JOo4Hs+WhzDbuRqvsWCrqrhH0yxgMZKWiGjk/ev4k+50KKFvhBEjXF+DyYqktjwEZK599Boelqbpe3HWvc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4696.namprd10.prod.outlook.com (2603:10b6:510:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 15:48:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 15:48:05 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Chuck Lever <cel@kernel.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 0/5] Possible changes to nfs-utils junction support
Thread-Topic: [PATCH RFC 0/5] Possible changes to nfs-utils junction support
Thread-Index: AQHaG+Lh5GJB3YfmqU+85mdG033FiLCDjyQAgAFdRAA=
Date: Tue, 21 Nov 2023 15:48:05 +0000
Message-ID: <716105A7-B177-48AD-AB1C-1767C40C669E@oracle.com>
References: 
 <170050610386.123525.8429348635736141592.stgit@manet.1015granger.net>
 <BC1CE17F-3A09-49F8-81F1-C6D5730F2A20@oracle.com>
In-Reply-To: <BC1CE17F-3A09-49F8-81F1-C6D5730F2A20@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4696:EE_
x-ms-office365-filtering-correlation-id: f722440b-1056-4244-0689-08dbeaa94099
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 awhYsj10P8+Y0ravfm57dBNbCGk68wIoC7IJ/KCiv4VVAA+Lb7U12OtbWWkEhIK17UaWck5P/nmdGbJKyyZsacHAvSg89mjzbAfybqI5MwERb49ubJIZY1l4hLabL6LloFm+dID7LX/FLyP/O6BtyyA6yL39l2iDzTV3Z7zBInLTroXNAOm8VkZMcZy6ftR21Q/wuicNIEetNasqENRVeT5ZT2hxN1nvubQcTId8IIOqioPJkLSjbBqlKQm3mkPKBx8hhmGq3U0PFuul0dCmu6opguzE+3SHNjjPdkS0vGhGOofG04SnWcN2KYTUSe3KC8z/GbDmiQhEUfGoKkUcl/ASIuu8bERqk8RYBghh6SBoUAcjyWYd6scH7NaUN5qxQlfEc1vZQfct4ZfcAFOiaDQUtStOTx3cygsOBOEEhDHj/GxMxV02avzc58Dcs1b8DJhITcNibjin0fEwrDvbY7aLMim/aPBsEcQ408n0ZQPtTBCEupfp4KHTLHS2IKTlUmM8u98GwCxDAJkvFFGklRjLWLqwgDTSeUTdxAwSx9gomic4cspnUuniCYcjsTR3KI1CWqOYvb+c67wjV3LRgz7ZSSVjhrY9lyyP2F4OjExk2FRDwU4M0VmmFZDGwNGieNTGu96qAs2MaN7sZKB6xA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6512007)(71200400001)(6506007)(6486002)(122000001)(478600001)(83380400001)(316002)(6916009)(8676002)(4326008)(66946007)(38100700002)(8936002)(2616005)(91956017)(66446008)(76116006)(66476007)(64756008)(66556008)(53546011)(2906002)(5660300002)(33656002)(26005)(41300700001)(86362001)(36756003)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Ni9nSS8xZHg4ZlhqTWZSQ25nQXQvRG9TbFlSbW9BdFUwMVFHa2t6RWl5UjMv?=
 =?utf-8?B?eGpCVXdxMktiUktDMTI1U2x3TFZWRjNFbFYrdEdIOXRCRGZzanF2ejhpaCtu?=
 =?utf-8?B?d0VFdHg3aFlRdFVIdzZjN0Q2SVl2a3NoK2RkcXEwVXZjcUw5bGtTbTVNcVUy?=
 =?utf-8?B?Q0dtQysyUEdUR1lYUmlLNThnc1hZVlpSeGYrZnR3bWY1b0EzUDl5MDF3czR2?=
 =?utf-8?B?cmhEU0N5UWVQbVdQOFpwVEVOMWJVYXVZWmpVMVBUck9PeDVRd3hXS2p6aTEv?=
 =?utf-8?B?UFNiY0xvODZxVG80d00zczgwSVVrM0hBd0QzMHBWak1DVXZleFN2eWRtZE9I?=
 =?utf-8?B?SExraXRaT29WTVlrTmRJeWY2bDhUVTdUd3JOWDRod0dIWDJEaFZ1dFA5QUZw?=
 =?utf-8?B?bEpNS0ViSkxOSlp4SXEvK2xxc0c3d2JhTGhnUlU5M2NUMVFvN0tSNVRSbGR2?=
 =?utf-8?B?WWR2OEZKVHMzVDhXUzRuK3l6UnlJR2VtMUpJUEZXc2FhM3U2WjVSYndnRS90?=
 =?utf-8?B?S1cwVmp0dkI4SnZqWjNST1pMNVBRbDRHSTI5c3pKSnhkR2lqZmRZRlFWcmFs?=
 =?utf-8?B?WjdTaXkxZkE4RXRRTlpERE9BbUJoYUxONW9NUGE2TFJCUnkzWHkwckdrWXdI?=
 =?utf-8?B?Zkw3Yit6ZkVqeU1MejJFTWowVERLMVN1eVdZNGhnWmNuVEJ4RmUxdjZMMmJR?=
 =?utf-8?B?V0NPZXJaYTh2MndrOWIvajhCOHN5RzAvMDhMaWdYb29SQ2w1RndvdnVzVE5q?=
 =?utf-8?B?dElUZmhaUlozK1ZJUmVDSG9SYmszZDRhTDVoZ01zQXBycHY3eWpzRXRLYndh?=
 =?utf-8?B?TlVXNHdvK3RPMFcrMHoxbVphTHpuMFFiYzl3QzA3V01yTE5GZTdmdVdCTkhJ?=
 =?utf-8?B?Wk8vakIvVnBHaE0yaUR5RHIra0lMbEhXako1SGNlTFZMbERGUFhMSDV3WktE?=
 =?utf-8?B?eDZmK1FCTTlQblBGdzFoczZrTzNTeU9aMzcwNURVMTFsUHY0dVBIUis2dXpq?=
 =?utf-8?B?cGoydGIzTUJWNTRCaGlvMklyNlVUc1hUUldROHA0RGtXcXgweGV6L2hkdVk4?=
 =?utf-8?B?NG5vb01tL1A2Y0dramt2N3JzMXIwdnZISWFCeGtqaFNMWVlHckRCaFJTaFkv?=
 =?utf-8?B?cU9VSHI2d3pqeVZUY3ZyNmx5b0UyN0NkWHRGTVJnczBSdVp3ZkF4MmxCbTJC?=
 =?utf-8?B?dlphYUkzWVdXYWxERGZJNXJ3V1pia2ZMRlRuWDlyNzl3VlNUK1FmaURpTDFz?=
 =?utf-8?B?K0dlQkQvRGRxcUd1ZzJXREgzd0dVUmtFNitzbktEejBEczRYREVnV3VuaGhC?=
 =?utf-8?B?NXpwK2p3aTUvcGxjK05QeEorZEtDZTJ6V1daaVFVT01sSHFsL2hjdVJkUmEx?=
 =?utf-8?B?UDd2d3NnZkc5RXl0ZUl5UmI0Y1lGdm5EVVZ5ZDZoMFE3cjlBam15YlVPWUJo?=
 =?utf-8?B?RU55KzZoSnRoVHhVSFN6cVF0V2tQQVBvMzBkeUdodlZmbE5CNW43eUJRVXhy?=
 =?utf-8?B?QXJWckhoUnIxbHdPV0M5TkFCSmJHcFlvZ21FNTkxRjExbjVpSm8xb1V3ZGNn?=
 =?utf-8?B?bFl0YVVxZFprenhzbVBxenNVdkd5Q2o2bDlMWFRKVDRWTUdrWkRpc2xnUVBU?=
 =?utf-8?B?Umlld2Z5a1RUcEV6NTZLVXNPMlM2aVR1cGhjTTVwd0xJbHNiaUxIUitsSCty?=
 =?utf-8?B?SE5BdnhpN2ozUUVQVEpCYXBOQ0ZmOUNlWXVhK042SFNwUWZiVThvMVhzNk9k?=
 =?utf-8?B?aWo0UXdpMC95YkxQN1RYNFRvMzBpdlZvc09DWElEQVo5WGIwbjFRSVRYdjll?=
 =?utf-8?B?M2p1TnFVcHpBSXRQQjVUemFIalc5SUgydGkrb2JEQWxZTU4xTnM3ZFRBa3N1?=
 =?utf-8?B?UEVKeGpHci9VMzRwMHM2akpwYjF2UjZmaDhZSEtaOVRaMVZabUtVaFVhL2Qy?=
 =?utf-8?B?ak0zeC9OemVwZFFUbkZZUncySzRsY3MvOGtPMk5Ld3ZhWGN3Qi9DeEgycUVp?=
 =?utf-8?B?TTlwemRWOVhWbUppV2phczhaUVk1R1dJVGNmRjNjZGtCcXlDckhvWFpjVjIz?=
 =?utf-8?B?U0tLcXM2cUdwVDF6MVNWdmVzb1oreTNibnNvSitvUGJCclRTblVqMXNQTzEv?=
 =?utf-8?B?aXRreFdZd2FlNGhrSnRqbVVGTHFrOUtwNWxER1B6Qkw3ajAwemxYZDIrejBy?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D28016F804E1D64EA58F6ADAD7196202@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FY5XwKg9TihIRsQtl+9AWkWZwhC4msqm2uivzaQhFNZTLdr15GZgROTjKwUu687tHUwh23nM8tJrmxncfyHSRjFxrWqi7pxj3pFBjwx+iAd5prtS+T6b/632QxWT/ft066cRDJTj+6VDakTwIlP0NE0CbeF4rl6roJNoHMBJohD8NMPfqRKaua6ffE4jNKR9IqJrAHyTC1ooKMysrlUCa6jnz4YNg3Lsw5TNjFt8S/QD+x0KSxVvaN9/cE6YqLqZQ4FkoP/CdvkV5Mc4Vy2porUsjymoHg0D5tWSz7JG1uH9qcETPCMvY1+His/xUUDu/cGU9Mg91coYRFcyBcKoVNc28MDzE9UnSniO2HMLXl0FPZKuVqyps9jg5eruqpH9kDghSfjjXrvCP4jFnFrAqtbLNkeZ4nVuLKGfSnrmNef4gDwNdwR7KtqmcTkSQXsimhZLSJP9QYMfchohZ+1jG5oVSVuwB+a/rg39MnCCcZGNyzr30ZnhDnLosZPKLSEJ4l/ZxeB6c7BMrUzzI2Kpx2ARGCw3ubJ6k/KGOMtnWU5g30QDSAQkT/ucodTuDi/a+/mMLThiP/SW7ElBfHRKtBUxMFGXdCjJNm6e8vYaqOntxDVEfCgo34VImruniHu5tcEsjAd6qATooAYadXC69EOWlerkjVHjpCjChZ8kTxQColz8prGDUNeLjcxN5DrkKUFpVUJM4ocuYLgpgdzbPzo4N/FaUo5GYkXh4WQ5gP0lNhd6XlJqJk2vvEZ9NBxhQVVuEeBxFNYCGwMv+EaHVitD06KovYMnXmoZJ/V9TVc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f722440b-1056-4244-0689-08dbeaa94099
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 15:48:05.7164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BdxSD5FrIaEPh5RbaOp7bIMqLcpmo6UrgxYBm0PZn/VKm0tscb/udzyWpslkG+bIr3mRYcFkbfLOISJPs6OKkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_09,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210123
X-Proofpoint-GUID: hd_1BMea29SgHJEPnbiXNiweGuip5ssF
X-Proofpoint-ORIG-GUID: hd_1BMea29SgHJEPnbiXNiweGuip5ssF

DQoNCj4gT24gTm92IDIwLCAyMDIzLCBhdCAxOjU44oCvUE0sIENodWNrIExldmVyIElJSSA8Y2h1
Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBOb3YgMjAsIDIw
MjMsIGF0IDE6NTPigK9QTSwgQ2h1Y2sgTGV2ZXIgPGNlbEBrZXJuZWwub3JnPiB3cm90ZToNCj4+
IA0KPj4gQnJ1Y2Ugc3VnZ2VzdGVkLCB5ZWFycyBhZ28sIHRoYXQgdGhlIG5mc3JlZiBjb21tYW5k
IHNob3VsZCBiZWNvbWUNCj4+IHRoZSBwcmVtaWVyIGFkbWluaXN0cmF0aXZlIGludGVyZmFjZSBm
b3IgbWFuYWdpbmcgTkZTRCdzIHJlZmVycmFsDQo+PiBiZWhhdmlvci4NCj4+IA0KPj4gVG93YXJk
cyB0aGF0IGVuZCwgc29tZSBjbGVhbi11cCBpcyBuZWVkZWQgZm9yIHRoZSBuZnNyZWYgY29tbWFu
ZCBpbg0KPj4gbmZzLXV0aWxzLCB3aGljaCBpcyBwcmVzZW50ZWQgZm9yIHJldmlldyBoZXJlLg0K
PiANCj4gSSBmb3Jnb3QgdG8gbWVudGlvbjogdGhlIHNlcmllcyBpcyBtYXJrZWQgUkZDIGJlY2F1
c2UgdGhleSBhcmUNCj4gY29tcGlsZS10ZXN0ZWQgb25seS4NCg0KSSd2ZSBkb25lIHNvbWUgbGlt
aXRlZCB0ZXN0aW5nIG5vdy4gVGhlc2Ugc2VlbSB0byB3b3JrLg0KDQoNCj4+IEknbSBoZXNpdGFu
dCB0byBpbnRyb2R1Y2UgbW9yZSBkb2N1bWVudGF0aW9uIGF0IHRoaXMgdGltZSBmb3IgdGhlDQo+
PiByZWZlcj0gYW5kIHJlcGxpY2E9IGV4cG9ydCBvcHRpb25zIGlmIHdlIHBsYW4gdG8gcmVtb3Zl
IHRoZW0gaW4gdGhlDQo+PiBtZWRpdW0gdGVybS4NCj4+IA0KPj4gLS0tDQo+PiANCj4+IENodWNr
IExldmVyICg1KToNCj4+ICAgICBqdW5jdGlvbjogUmVwbGFjZSB4bWxQYXJzZU1lbW9yeQ0KPj4g
ICAgIGp1bmN0aW9uOiBSZW1vdmUgeG1sSW5kZW50VHJlZU91dHB1dA0KPj4gICAgIG5mc3JlZjog
UmVtb3ZlIHVubmVlZGVkICNpbmNsdWRlIGluIHV0aWxzL25mc3JlZi9uZnNyZWYuYw0KPj4gICAg
IG5mc3JlZjogSW1wcm92ZSBuZnNyZWYoNSkNCj4+ICAgICBjb25maWd1cmU6IE1ha2UgLS1lbmFi
bGUtanVuY3Rpb249eWVzIHRoZSBkZWZhdWx0DQo+PiANCj4+IA0KPj4gY29uZmlndXJlLmFjICAg
ICAgICAgICAgfCAgNiArKy0tLQ0KPj4gc3VwcG9ydC9qdW5jdGlvbi94bWwuYyAgfCAgMyArLS0N
Cj4+IHV0aWxzL25mc3JlZi9uZnNyZWYuYyAgIHwgIDIgLS0NCj4+IHV0aWxzL25mc3JlZi9uZnNy
ZWYubWFuIHwgNjAgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+
IDQgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgMzYgZGVsZXRpb25zKC0pDQo+PiAN
Cj4+IC0tDQo+PiBDaHVjayBMZXZlcg0KPj4gDQo+IA0KPiAtLQ0KPiBDaHVjayBMZXZlcg0KPiAN
Cj4gDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

