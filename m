Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00207AC9CB
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Sep 2023 15:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjIXNj3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Sep 2023 09:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjIXNjR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 24 Sep 2023 09:39:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64DD26BC
        for <linux-nfs@vger.kernel.org>; Sun, 24 Sep 2023 06:28:28 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38OAFp02022209;
        Sun, 24 Sep 2023 13:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=qajigVttxG4ztIUqLw9gWEvBkOqOpv3RLfwrPq2wPXU=;
 b=hQ7ACJK5MECafYA9lVLU/JTkX/0sBw+P86XFIhzZQDaRchFT5TQFs+b2lqelgJmEZAw7
 PWp+1rr/oZJMsCFWryOOFsW2GD9UnTLaijUWcq+V7mopie3bRa03KYTxQw/ql6wCkGJt
 IfYDOq5gVaWBS8nLzzr8qAjjBdHocmQnjyIY4iOlH1EOK8fTo30VqebfLd5IUWyaLGDo
 PnNrqgFyY9jMCfQg398sLLwlqFUW4W1nN2UrCcCEVK9+YR8PgQjfYKgZJQ16KjEDW9Lw
 tQujsO+a3NTBQEx0jmeV1VLwHVh9/H/tAsX5wX2jp8C4Dr7l2xJe7N6V81e4rIioPQr6 KA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwba072-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 Sep 2023 13:28:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38OCQ4lb030583;
        Sun, 24 Sep 2023 13:28:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf38btp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 Sep 2023 13:28:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzoFU07URnd67tCFeWtiqjJrMQlz8m5yZfcCgf25LcBhFIL69Gz1f0ir2/AYG1pyx5wowe0wHofOMQzYnM8cj1qPe25UzXybvpNtpLddOZXMkTPkwjdLGxvOcnCFSugAblw6m4tiCAAqjgK64GSoh+XPCq0bFM0eVNGawoAdAvRwTKrhXeyehjzgYrCWiMx5eu1Q2bYSOs5m8UamkBwBQn9MkGZsbImVQDpmyub6h5dKTOiyO/aW+XAaQCOmNTpTE0NM+ITQM8fZNdvjX8TE/gbJhNPLZJvRiZNRrscgKeuVcLw7AoF0doJff4X/8vt0iyudZxIsszGi8d+3w/kMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qajigVttxG4ztIUqLw9gWEvBkOqOpv3RLfwrPq2wPXU=;
 b=n66cgohwm44QpLBgWxUEf0GWrz2tPZ/AvRdLNX9RPTTAsCO4fnQuStp5Zh3a0Nre+33JqeRq4DewcyX/nWJ4MOO0PnPckRjoXc2X+knBE56hJRHoC3+GBKbeMNwo1e++CcX4/+vpyHIa8t3dlgVBbqxyYVUi8iWP2xuaWYazSTW7PbiyMus11Np5y+hNu9JRJkUGmxvwf4f4PdKEbW7D8I3xtcpU/HvOp4b6m0qgtTufk4Ip5hYBazdoWlGn917cn8A0GG3v2EB0YACTVqkXlX4gDG75c/RE3SejYPuR2R9ZVgElpd+lvp9HJ/PAfJz1AslW9hhsrtVJ7i1Lh2ikBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qajigVttxG4ztIUqLw9gWEvBkOqOpv3RLfwrPq2wPXU=;
 b=RSDcae+SYvc0IDRl+W4Ft7nom0w57a4Qs4rYbEzpni0NYL5DijAKvXeCLK6bSbrMQswzNJyy9gw5qPaizMKftqYGLZBTYPw5gOaGqtaot0RlRPqKJZ+pTa8meCYVYRa+ra6lkz6iadgqMTndRukQQUXgLLTcL6dBR0y/+aFPmKA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7169.namprd10.prod.outlook.com (2603:10b6:930:70::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 24 Sep
 2023 13:28:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.017; Sun, 24 Sep 2023
 13:28:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     =?utf-8?B?TWFudGFzIE1pa3VsxJduYXM=?= <grawity@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Data corruption with 5.10.x client -> 6.5.x server
Thread-Topic: Data corruption with 5.10.x client -> 6.5.x server
Thread-Index: AQHZ7uglcAk7YvaB4kSAn1xCF15i5rAp+BsA
Date:   Sun, 24 Sep 2023 13:28:20 +0000
Message-ID: <6E4B8EB9-FA7E-4ABD-81AB-6FB0EF07EA46@oracle.com>
References: <f1d0b234-e650-0f6e-0f5d-126b3d51d1eb@gmail.com>
In-Reply-To: <f1d0b234-e650-0f6e-0f5d-126b3d51d1eb@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB7169:EE_
x-ms-office365-filtering-correlation-id: e9b2bf1d-54d1-4aa4-b605-08dbbd021ec4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 31saeo9hsjw/Quysqd1yuEUMbmz2bfLFqgUS4wGv3yI4xlW2wy561kJKRH7G9iRW4WMrmM/fq946+px+Syii6ssGFPTO2m0T/JF8mUUJ/6LYkTgPsj6b5nmNUQH+3YD6romdCBMfKb9kR5Jy/xuCZywmB+ccKFLqyLt3ZIF+n7cBUUgvRHe0+xfP18NG74KJMjlqffFPK2o0XBk5SnailxM3fex8tge1xdOrrGMzzMKZ0LZ5DR0o9MSuDmn/5UqZvcPDiORDdkpQuolgDuT9Mr4veBYKaTrDqRXUomVJA4dUHS+h3u8FdAnezyP3Ojq8Ey7GHJREc35n4DDcI6EY+8tOGEkbLedgDQlJbQ9fuYTYGkHzAXMbCpck2AoQjNaz/TGSmQmwB+7G006Hw6ZWkDVRdK19rZ1j3SRMVSna8/exfoWlEGSbikNoIbxMKIi+R/vZk3k4ZmWpGaYcKHNW7G8iss3RfA0b1pXq+GiYBUBJQ8nC+x3AiNoWQld8Mf7OyRG93DPk9EqADYnT4OAVBFLzh7Pdob3lBx9oUYbOhwaBMf6vpJqhobIlddfmJxYWWGR4DSxWnkn/wLyMoVl47i7et4jl/aq6dzOqdfIbUdW9oc0wygC3Eba8V/I2KAl/yqHzWHBME92/H/Mbw4ThhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(186009)(1800799009)(451199024)(2906002)(83380400001)(38070700005)(122000001)(38100700002)(53546011)(66946007)(66556008)(66476007)(66446008)(64756008)(91956017)(6512007)(76116006)(71200400001)(6506007)(6486002)(26005)(5660300002)(66574015)(41300700001)(6916009)(316002)(478600001)(8936002)(8676002)(4326008)(2616005)(86362001)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjlWaXdDb0ZCRXVwYzNaR3RZdFVOdjkwL0lQOCtxVlJLTU1jeEFwcSsrSU5L?=
 =?utf-8?B?U0duY1BVTCtQd1pMei9XdEE2UTcyYXA2alJDSjRvRDhnemZhYkptZzFuK3R1?=
 =?utf-8?B?TTVlM1J1NVl3a0xFOEtCYW1wbTN4YXdHRzUzejdDdjNZK1lPbmE4YUlOdHBW?=
 =?utf-8?B?aDUrZ05yTGN5MUNLdGZ4VFFSWW9aRitNS0tETDVQN1RIcy93ZlUvQ29adkNM?=
 =?utf-8?B?bGZ5bldDelZHSUtaVnUrV1VFMUlrekI3QVZ1a2gvQ1Q0S2N4N0kvTk56UEFa?=
 =?utf-8?B?UUF0cFNJbGVOb0lHSHBMZlZYL0hPU2JrajZHeWwwUWp2alIvc2hsSXBoQlI4?=
 =?utf-8?B?Ynh2d0RGUk5ZUkhrTm1rZkp3NjVKeVR2d2RpTTNuSlpiTDNZTi9lOHRCbzBh?=
 =?utf-8?B?UTZyUDZRNTZwMW1jS1lHZzdjMGIxUTNFRG9obzY4cHBneTM5c3JRalZZdjU3?=
 =?utf-8?B?c01DTWdQUGRqWDEwRzVRZ3hiV0h1NDVaM1ZxdlNhcEJrTm5KVG5kNnlsN0t3?=
 =?utf-8?B?QTlpTTBudGpRWng0VWJ6M0RDZkg3Q3NjTTIwY3g2S0FuYjdGdXBJWnlKeTBU?=
 =?utf-8?B?SVIyc0toRUJRY1RWcUVNMlNvODkxWEdPTXN5bi9Yc3dVT2xlWi9heGUrUzk5?=
 =?utf-8?B?d05OTXR6bTFrZGloSkNOZ3VhVmlNc1FoSVdJSFBiWm1sb3B3dGhaYnNLVUc1?=
 =?utf-8?B?VG5iazFVb2wzZVVmenZPYStpclE5Ny84RVNTWUJzbkZScDZvRmdiTGgzNk1V?=
 =?utf-8?B?aXB1K1lWZjA1TU1DZ2JCSkJIazFaYVRVN2NiK3Q4dHpzN3UyTGJ4SGl3a2k3?=
 =?utf-8?B?clpIcDR5bEYwZjBtREd4VXdzME1waHRtdmZzdlpmRW9DYWRVUUNKK0Z4aS9D?=
 =?utf-8?B?RjZSZlc1WnpteEtVRVNHZnp4YldjM1NoUktHTUpwNkxqaW5DZFJzOVkrcHBk?=
 =?utf-8?B?V0F4OU9hcExZWVdqWHhIMEpNR1QzNnFjRVZjU0FDYWZpcUxmeEhhcSs2c2V6?=
 =?utf-8?B?aGh2SnRJbXNOT0VVRmdBckd1WlNkaXZwQ05qNno5VlpDeTc5UmpMT0w1T2p1?=
 =?utf-8?B?ci9CblhZTXJtSFNJVGFGWFZablcxV3RscTEra2FwMU5qM0dTKzJpeDVSMXB6?=
 =?utf-8?B?UkxUdU16MTJQVm43cnFEck1wYjAzd29LWWJuWFkvSDF0b0VNeEI5YVg3b2p4?=
 =?utf-8?B?K05YemF1UGhBelJUNnFCVHV2UTFaQ3VsNmhKeEpZSXpORGF6OEp2TWN6YTVF?=
 =?utf-8?B?TGRyVkVFSDlTUVFtbjZ0VVc5WEdYOG5vRUVuaThXYTJ2Z2lYRTJIbUpWRjZw?=
 =?utf-8?B?TEFqeW1kVnBFN0MzZXR0RjhlRGdOOXFSUWFYWDFSb0ZrNklHNU1peURmeGJG?=
 =?utf-8?B?ZFN5cTY4MFVxeGMwT0tyQ3JsQy9xK2pvSjY4NWhzUHpRQjM0TlRFeFNRbjBG?=
 =?utf-8?B?eWYvV0lVQ2lnbmRsL0VHQUZLc09vdld6bTJYRy9yL1M4TkZhN09lMHdiR05h?=
 =?utf-8?B?UHZKczBScENzMEo5eEI1R2s0Mmx5dzlDL3FOaGhWYm9Rei8xUy93Z1hrSmVO?=
 =?utf-8?B?MzFZamlMbkFRTEZORkdIaTJSalZ3b1QwOWczN0c3VzgxMmpLN09ueUZ0L2Zx?=
 =?utf-8?B?SzBmMTZ5OUV3a3VOcTVMd3gySmkrM0N1Tko4VXFjL1IzN0xXY0tJRys3MmVF?=
 =?utf-8?B?TFdtMG1IZ2pvSk5ZU2d0SUxkV29SY3NMUThDZmNpaS9QbHFocEVJUXg2LzdU?=
 =?utf-8?B?Z2FvaDlVcFdpZWw5b2ZXVXVGeFFHYklYU1JCVFFtbEFzYTVrNEJxc1VwZmV6?=
 =?utf-8?B?a3JhZnh0L0c1ZUdPeHhUbVRXQURocjlHWURyRUZBZVZ0THJkQVkwSXVGMTNG?=
 =?utf-8?B?T0NiWHZaTE80UnN1RXArZ2dJYldBMHF1QmJiSGpjSWtaNitDR1N3UkV0SVJm?=
 =?utf-8?B?NU41bmFrb0U2UXVxOE1QbTc2MjI3cmVWWmlRamc3Ni9IWlNmeUk3Mzl2dmF4?=
 =?utf-8?B?Z1diWDBXcmpqSjY1NU9HV1hNTTF6MnhsTWRkZm1YSzdkMllHNWh1b1cvWFF6?=
 =?utf-8?B?NEdjTm5PclBxN3ZNUEtvQTkvbm1sL1ZZc3JzZkNXT1RWaGtZaUdPRXZ2TmZO?=
 =?utf-8?B?VHB0R3A0ak5GekVZUXFXQkxRektCd3pRWEVIejNaQm1nYW5sUW1BaFB4QWRE?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A217DBBFD3AEC47ADEFD03608AEBEE2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: w8fmCo09zSxOTUBStDI43pBf85YLFyvtWgcL0Bze5Cje4NohPQI8LhuKDCAwU34HHsNa4fszOuJzdRF9i0ibWHnx7WdIWIrP8I4iNMTtjhgI3gYHpemavqzCN4LNOM1cUcRJ/wMo0Kqycasnlo9dkZae8JcUagviGaOIIsp2lzS6kPXXhVHiOeYWXHQi9R7HrUB/Z9yMYy9dz3+SnzUgeVSPXlx9WB349u0skgPtxfHBH4fuOQLlHCCLJWRFwTYWxlVN5E2aT60qvfzAuAybOkb9H5lwnXol8gvV+2PhZa6hRz3Ui+Gn1zvRpxHHC6Y2M8fGu4EX6Ux89umzlNWTTki3gdnL9U1kHwAdAlI7ZH88Q2Nz/GDWmjINQq1g/eWTsFmFaPch2gxQFsVOkGv3zXwsaTiX6JIDJ7a8ADws7zZbcsmVurIgulCAhfwTmi+sAKmkLW0xtIGAQTE9RrJsrsOZ+0AShJGxyJOu8bonupf900aBcplCBsCyMndStvQhQANyvKyNqQdcg9oGsKp+bzb56jVwyxe5ZqNa7z+oi1LnIza/wBfRpcP+0FQKPRrNDyQ/Ez31RIKgo1O1mFiWExtPK9PwU3L4SKv4lDhC2M7yhmuRBPcR+pcU2z3fSn6wVmJx6x6Dpbmk6pymcQD8V28YTT6M+g8JScE5f0/469hvOT+0d70+p6BePZOY5oR6FBymni6+Ya5tW81dnrNyQb0Grp7imV3JaeUb8szU2KtXaoSZhUXw+hYzGFFkp91lJKBMMnZb9Bjfj1zUIysaCEwwmbEcitp+fU+kBrEk/VA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b2bf1d-54d1-4aa4-b605-08dbbd021ec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2023 13:28:20.6832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2YM/RQqK6Z6ysWm4YCtGGuAVZk11JEA7ZD063EBeJTWB253G9BfxGDXT+vJGBfzBop2oqvZtoAzYW5F5SNetPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_10,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309240118
X-Proofpoint-GUID: MYXsmtKVrXNMU2gC8owRjoY1PKx19Y6T
X-Proofpoint-ORIG-GUID: MYXsmtKVrXNMU2gC8owRjoY1PKx19Y6T
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gU2VwIDI0LCAyMDIzLCBhdCA5OjA3IEFNLCBNYW50YXMgTWlrdWzEl25hcyA8Z3Jh
d2l0eUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gSSd2ZSByZWNlbnRseSB1cGdyYWRlZCBteSBo
b21lIE5GUyBzZXJ2ZXIgZnJvbSA2LjQuMTIgdG8gNi41LjQgKHJ1bm5pbmcgQXJjaCBMaW51eCB4
ODZfNjQpLg0KPiANCj4gTm93LCB3aGVuIEknbSBhY2Nlc3NpbmcgdGhlIHNlcnZlciBvdmVyIE5G
U3Y0LjIgZnJvbSBhIGNsaWVudCB0aGF0J3MgcnVubmluZyA1LjEwLjAgKDMyLWJpdCB4ODYsIERl
YmlhbiAxMSksIGlmIHRoZSBtb3VudCBpcyB1c2luZyBzZWM9a3JiNWkgb3Igc2VjPWtyYjVwLCB0
cnlpbmcgdG8gcmVhZCBhIGZpbGUgdGhhdCdzIDw9IDQwOTIgYnl0ZXMgaW4gc2l6ZSB3aWxsIHJl
dHVybiBhbGwtemVybyBkYXRhLiAoVGhhdCBpcywgYGhleGR1bXAgLUMgZmlsZWAgc2hvd3MgIjAw
IDAwIDAwLi4uIikgRmlsZXMgdGhhdCBhcmUgNDA5MyBieXRlcyBvciBsYXJnZXIgc2VlbSB0byBi
ZSB1bmFmZmVjdGVkLg0KPiANCj4gT25seSBzZWM9a3JiNWkva3JiNXAgYXJlIGFmZmVjdGVkIGJ5
IHRoaXMg4oCTIHBsYWluIHNlYz1rcmI1IChvciBzZWM9c3lzIGZvciB0aGF0IG1hdHRlcikgc2Vl
bXMgdG8gd29yayB3aXRob3V0IGFueSBwcm9ibGVtcy4NCj4gDQo+IE5ld2VyIGNsaWVudHMgKGxp
a2UgNi4xLnggb3IgNi40LngpIGRvbid0IHNlZW0gdG8gaGF2ZSBhbnkgaXNzdWVzLCBpdCdzIG9u
bHkgNS4xMC4wIHRoYXQgZG9lcy4uLiB0aG91Z2ggaXQgbWlnaHQgYWxzbyBiZSB0aGF0IHRoZSBj
bGllbnQgaXMgMzItYml0LCBidXQgdGhlIHNhbWUgY2xpZW50IGRpZCB3b3JrIHByZXZpb3VzbHkg
d2hlbiB0aGUgc2VydmVyIHdhcyBydW5uaW5nIG9sZGVyIGtlcm5lbHMsIHNvIEkgc3RpbGwgc3Vz
cGVjdCA2LjUueCBvbiB0aGUgc2VydmVyIGJlaW5nIHRoZSBwcm9ibGVtLg0KPiANCj4gVXBncmFk
aW5nIHRvIDYuNi4wLXJjMiBvbiB0aGUgc2VydmVyIGhhc24ndCBjaGFuZ2VkIGFueXRoaW5nLg0K
PiBUaGUgc2VydmVyIGlzIHVzaW5nIEJ0cmZzIGJ1dCBJJ3ZlIHRlc3RlZCB3aXRoIHRtcGZzIGFz
IHdlbGwuDQoNCkknbSBndWVzc2luZyBwcm90bz10Y3AgYXMgd2VsbCAoYXMgb3Bwb3NlZCB0byBw
cm90bz1yZG1hKS4NCkRvZXMgdGhlIHByb2JsZW0gZ28gYXdheSB3aXRoIHZlcnM9NC4xID8NCg0K
Q2FuIHlvdSBjYXB0dXJlIG5ldHdvcmsgdHJhZmZpYyBkdXJpbmcgdGhlIGZhaWx1cmU/IFVzZSBz
ZWM9a3JiNWkgc28NCndlIGNhbiBzZWUgdGhlIFJQQyBwYXlsb2Fkcy4gT24gdGhlIGNsaWVudDoN
Cg0KIyB0Y3BkdW1wIC1pYW55IC1zMCAtdy90bXAvc25pZmZlci5wY2FwDQoNCi0tDQpDaHVjayBM
ZXZlcg0KDQoNCg==
