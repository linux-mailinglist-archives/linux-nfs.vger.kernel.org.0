Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8886D7B04F9
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Sep 2023 15:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjI0NJJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Sep 2023 09:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjI0NJI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Sep 2023 09:09:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB61F10A
        for <linux-nfs@vger.kernel.org>; Wed, 27 Sep 2023 06:09:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R9O9wu019120;
        Wed, 27 Sep 2023 13:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4p38Zk1hP8Lc+domKJnN6fy5AdRY6GCo/UfNTOSbL+4=;
 b=MtjxEgiZxwln/xLkrOQaNAL+M48KfBwFhcr+hbNxewhTPHQt2qBjSrqTG6qUvEXtsfC/
 awSJcraaw0+XQgvKiyAXPepzc3rvpHoe/GuyUBLrxR5JTDcyRBqJnLN7kLpZr8vr5Bga
 F+T0N6Ygze6O6bH0dkQYMWHo9Mi04msye8BW0URkwlcEYCh1nf0/o8ct/ZDj81OKD2dc
 /TF+SL/5YbnGGuZgdzlM79j803rX7sEWYJFd2NHXOp9/RCLibnQBDqhxoPk7nP9kDlYJ
 isgZqyea0SRjskMYOhE9Pb2xZspyIRPeIjDpMmAV5QhkkdkuzbVJQ7+IqTZ+I/PyVXiu Zg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjuhf6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 13:09:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RD4s11039522;
        Wed, 27 Sep 2023 13:09:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfdxrm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 13:09:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Irf3P37hBeTwrYjUphJqocp2nG4f3xz3g/LdP0nTVCwi55uu/bRGI0Jj9AGG6f5wCOEJCwbwB4t0umRudVSA2ghAV42V8dFh3rsFbBu8VSyEII5Ts+rglkMRpgZ69IJ75U1wU3VM5vndY6wnnjkDPJBHdDkNj55ymqtcPX9McDts5+XiX8EtXFmir/Qn5CwTC/rgqnJVK7kfUo3dWljvBwuhKQEktCMoKnqtPG4N9pHXMVY4pD3+/AU9W9+ueU2hnO3E/FhSMpxmzONIC9xI8HvaepDugx5U5GTVmzPyfzD4LdFqRmTBl8mzxVEgADUIuKOQI6y7F0nN6+Vm3/SfVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p38Zk1hP8Lc+domKJnN6fy5AdRY6GCo/UfNTOSbL+4=;
 b=GSdJ3bBkvkOb26wVjytv9Gad3cb86RnkoAkhHavglEC5/kxt4bIRlag9RmPDG1QEvWpDGI4O4BZK1zbeHj1t1TR6R4RfVOXdwcLUgbc1LIc7Et4WuWOj7AK1Fb3iAxRmYldOkrryZH5o1KDj+hPSR1kw9w9x7TJXG0StA1YcaQWH2rBJEEfCqyur8Op3zDi31EHxfUNUEpwjIgJYsz0AeBAv86gcM8Qijo7fzM2ufYIFmq0TRLAn1ti49clewKN85tQkiTgpuMZO2DVJuwGBnjjH+6oJtq7yy1ZMw7WFeVjwLRhnhWxsMuFRlch4PXKVGAexAIX8Nj6rdiXnXJaB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p38Zk1hP8Lc+domKJnN6fy5AdRY6GCo/UfNTOSbL+4=;
 b=lwIrMl5CsUyd6+QcxQltFzcBKzSPbjlUmXLj1m1Lraj0Lvu9LO2f24PX0uCwBc0sgHLkad869bZBZ9o06g3iV4NEQxDvNAJAZRejlMEYPfTjqVSMrnSXf1gtFoqvE0lbJQ3uDRl8wTkt8bhdsd/cLKcv1uASUitpXcV+eTYXLeE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6410.namprd10.prod.outlook.com (2603:10b6:510:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 27 Sep
 2023 13:08:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 13:08:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     =?utf-8?B?TWFudGFzIE1pa3VsxJduYXM=?= <grawity@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Data corruption with 5.10.x client -> 6.5.x server
Thread-Topic: Data corruption with 5.10.x client -> 6.5.x server
Thread-Index: AQHZ7uglcAk7YvaB4kSAn1xCF15i5rAp+BsAgAAR7gCAAAN6gIAAI0qAgAAaJQCAAaJvAIAAnDyAgACbWYCAATstgIAAD76AgAA5yAA=
Date:   Wed, 27 Sep 2023 13:08:53 +0000
Message-ID: <AE05C6FE-42BF-4AFA-A149-26CF8E94961C@oracle.com>
References: <f1d0b234-e650-0f6e-0f5d-126b3d51d1eb@gmail.com>
 <6E4B8EB9-FA7E-4ABD-81AB-6FB0EF07EA46@oracle.com>
 <f90866e3-8c54-8a9c-c100-f5550c31b664@gmail.com>
 <9691788F-2B62-4EB5-8879-CEDABD1B9D4B@oracle.com>
 <78c81a97-4324-c2df-27c0-917436ddee07@gmail.com>
 <6908E735-6912-4AEC-8AD7-995F2F8A144A@oracle.com>
 <CA1D7203-72FB-4681-AD60-F1D80A57C154@oracle.com>
 <8cb19861-7fd2-4d12-bd76-78bbb8fcee7c@gmail.com>
 <2660F09A-5823-4581-8977-4F41153724D6@oracle.com>
 <5048a7a0-d2fe-41f3-be3b-4eead930c414@gmail.com>
 <6f927572-5296-47ec-ac8b-d12cabd2c566@gmail.com>
In-Reply-To: <6f927572-5296-47ec-ac8b-d12cabd2c566@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6410:EE_
x-ms-office365-filtering-correlation-id: 696f813c-f83a-4cfc-ab8c-08dbbf5ae617
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4VA5eA7YCLe1Nin2j2VED7XxfnQUymKXQZlL6QmmNSZEO3nyf9FOsv66Bi5JpjOz4poKCNg4PL2oftPvVAFtmt2fyJhH+rvq8P5XisAakLxHbDCLC+E2/MiJwgKQuML7lusdrubKhhg+1NNgNd9uLwoQL2Jif1fJWXs9OL0X2sQ1A5ZVSVZaKBPLumh5W+R67cvss0eRV1P/bFi+BUTZ2xrjx5Wb9TfA8prcX6+p+PWakBBlKDPZnUBemCbAJ4AM58vNpb0b/ODiBlihGPRSEGX5WYdScGOrNwmL0bO8U0zr3A7vWpFGyB47K4E8vdhGtn+Kd4TdTC6o1HujOwKawJRzSYjAdr6Gs9CpIZvbFjJDDngTM8KP//+tYPkaRT6zJoJ32DOE6FeteflpNZu0fr+PRmFa1jf1aijQOUC2dzX1rUuo5ZjSao05Imiwfv7ub4sSeha9tZXuOxoLDFAca3ioVMmr5zru1H1A13kZ3j0NFkm4Je1KPA/YPmkyqi/mzA+BXV4/c+Mi7Hxf6Pn3SDq1AneUOsQxEALn8RY6qY/44rHK4aBEU4YBVFRbi0x77NTPh3U6tjjMVl5YOxwhyRvilfAJeO5zLvy/BJ8N3/gcJYrandl6SAwKQrueAS07BiBjtHpuWX7ZBSFywib4fQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(39860400002)(366004)(230922051799003)(186009)(1800799009)(451199024)(2906002)(6916009)(316002)(5660300002)(4326008)(41300700001)(8676002)(8936002)(66476007)(36756003)(66446008)(76116006)(33656002)(86362001)(478600001)(71200400001)(91956017)(66574015)(6486002)(6512007)(6506007)(53546011)(66946007)(2616005)(66556008)(38100700002)(38070700005)(64756008)(122000001)(26005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0tRYjVCdVovYndHdnVGeGlLZHhiNmlieThVSXFJNTZKNUhMODFvNGhFZWIy?=
 =?utf-8?B?VUM4YnlRZXlNdUJtYXdCeFNOZDFWR2VSNW1KQU1DelI1VUtDNERHbUlYSkNw?=
 =?utf-8?B?K1FFNlRlMS82czBQaHR2cVlOTGRFVkF6UDdKMS9MaXJtWGtvRU01V3lXTGNT?=
 =?utf-8?B?YXhPNE1UZWtEdFZUQ0lFSmZYeXVRbnl4aHk5clVHQjF1MWoyZGRuL1lWQzlt?=
 =?utf-8?B?S3JrTk54SjVRSmhkYndCYlVZRmJaSzN2Uy9NYVVvalVwR2ZrRDJGaTRxVTNt?=
 =?utf-8?B?TlVnRFpHaDdxaXE0VnpkVjdaemNaeXFhVmFKTmpyUS9QY3Y3em5IZU11SnJa?=
 =?utf-8?B?QTdENGhnSVN1R0N5eXovQ2YxVnZnYXd4MGgrcU5CZkdzYmNYT3pjNGlwa3h4?=
 =?utf-8?B?T3NndEwwbTFVMjIrNXAzZ0NlUXhBcTBNckFpUEZaYkhiNjkxUG8zSHFHajZi?=
 =?utf-8?B?Ri85WEdIcDVnQkNNK1VnQU85eitmV3V0UE1CYk5BK00yTXNXR0J1bjZWSUNw?=
 =?utf-8?B?bTB6ckRCZWtQZlVMWmNLOTJUK2lBYmN1UW1DV2NCdEZ6bENoMXorRXZKVGF6?=
 =?utf-8?B?RDNsa3o4SUtNVjlGWTR5aENENEdxTktRQk9HTExKdEZVb2JDVVVZOTVKMHgw?=
 =?utf-8?B?Vzl6RHNrSkFqQndNS1VEVzhLN2g4VElpbEU2bkt1RHBNYUFrSEgxSWZ3T2pi?=
 =?utf-8?B?UXdFUmZ1ZEQ0MjZYdjExNzFrMGQyZDlmTFRyc1Baa2tlMDNnSDAvY2dZTlFD?=
 =?utf-8?B?bktXZzlWeUF4aUs1SFVnVHpEYTBmWTFheEtFMGFGSzMxVU5JbzV4NGY1S2lL?=
 =?utf-8?B?L0E3VWM2YkdOb0JaMjRsaUlad1lzNDFWMW9uZms2SWVLYlBHVGxHTGsrR2J5?=
 =?utf-8?B?UXZQb3o4L2ZuK0xFRG5peFV1VU5TMjd6ZlM2eXhEQXlNcjlKMGdCNm9vWXUx?=
 =?utf-8?B?bDg2bkswUEVGNksxVzJSbzdLQWJ1YVB1dG5oN1dFVmF3U0pmaFBQMzl5NXdD?=
 =?utf-8?B?c2RwZmRXaGdESEgrdWhDbEhubDR3cnRTVXcyVkJUTHlEVDVXVlFrdS9Yak9B?=
 =?utf-8?B?b2VZdmpOejFqNXN0bXpnTEhZRlI1R3FxZEpJQ3VUMnRhcWpjWTg2RE1xcXlp?=
 =?utf-8?B?K2tmR0kzTVhmOTNia0REZ2RIMWJDS1RRNjZDb1A2T3MxV1BaRFZELytRbnl2?=
 =?utf-8?B?M3gyaFhjREpTeXV1eXlYcVhCTVlOTWVnU3RUeXNqOTEwc2x0U2RwaWJGRndt?=
 =?utf-8?B?SEdVeHN1VjlzOUozZGczWmNvbDJ3Nmxmd3lUUDVCZUNVcHpqM3BweDZOOHZJ?=
 =?utf-8?B?QzlydCt5QXl1amg2S3VnOHlYYUovMTkwLzkwdGNIK3h3d0JSK0xpYytmK0Jo?=
 =?utf-8?B?ZW5tYVZYY0dxVVF1QjF2VEVyZW0vUldjd2p5UUprSk53c09rajFvZVZManhY?=
 =?utf-8?B?aTErZnJrYklGMW51a3o0eDY4TWFGT0sxaVRLZWF2d3krcURrVkVQRXF5SlEv?=
 =?utf-8?B?UFZnOHEyWm12QjlGYk5GTGtxQWZDMzV4VWpnU25SZkxXQVFCSjhHdC9hM3BQ?=
 =?utf-8?B?SjJEMGdZd0F2ZFpnMlNIMnhHL0R5aGNRWndKZjV3YUEyem5NRDVkMGV6Zklm?=
 =?utf-8?B?bm55RHhkTXJSc0FSbURMek5EUDBuNHRKRTBTc0gyTjV3c0lITDAvclhoQjFR?=
 =?utf-8?B?RG9xSC9ySUl4c1hVbndMcTBSK2p4RHdmeVNiQjhac0hTV01rVXE1KzRsZ0xs?=
 =?utf-8?B?YzAxa1l3TXpUMjVDQnlNaDNkeG1ndWdnSFNqUkZSaEcwaVFyK1poNXRWR0ZB?=
 =?utf-8?B?VGhJRTVtQlZpUWxseGdUREtOOXdFS3dJK1NYK3JRcGg5c29PVTF2MzR2dzRs?=
 =?utf-8?B?alRXb1NEckVJK0ljV2xKQVdOYlJnUjF4Kzh2NlZ3bnJCQ25TV0hiUk9aQWhK?=
 =?utf-8?B?STl1d0lNaWxhTlFFdmE2VERkek5kOXh4TnZmdU0wVkd2a2VwQ3ZmTkxKd3k3?=
 =?utf-8?B?cE5lSjljU013NVJnaUErVEx4SlhtOTJZZHZQM0hPd0RCV29XWmRjQytSc1hG?=
 =?utf-8?B?RGRlcWxacVV6WmJ1NGZwK1Vkd1g2YmN5RlVOK0tNSnJBY0hqM3cxQmRlM1l4?=
 =?utf-8?B?Mzk5dlQySVMvYTVRODA1QWFuYkEyL3I5Y2FNMHBrVzErT3pGdllGMkNpd3BS?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4676D768DE337943B9AC04E0F44EB408@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MY3yXdoeEv3Pff8mcpYNfnRKZwbo5FsW6bTfF3k19ddnSYHI7nTTHfW6DBtbOQTl2qKhB4CM10TJmF+haX05FTuWnZHfTsaImDNYcyEvvIpKnr8aSqJhYNCfUu0GEfw8faYjkABMQ8j2B+m6on9G7+ycaare5RGSvbreb/Q6nySmUfXVI9s/QAgTi8EZf6VZoWMsefYaX944qG0A/DbvVDWNsLrUaMfFN0sHDkrYoJ3ck+Y0Ito4DLKRQ03WBYNAQtXRfHTgj5TH4TqwHC2DDk1tS0MpoBt/vLuTA5iLjoo9Mp2n446Gb2Z0jJuZmn9STYcYi4wEgzsyvrIIXEgXyQ+OY0FxBjj0hKSg698cIMMMAR2faPnnJUvMe1K7NNv1FDlGjtglSzFQVSOktmq71UgvlSPgvn7ZKgV8M40PouFDUQPcQK/XOQa/hnim1Sl6NHUC4iBpUD9u9NyH63S6Bb0bn7KfEv2bk7QkmMXWxZ3qOnaJ8JTZzMZWA6gjHT9+hyu/xhQVKnLcjJWeJ2pvNikpbAW4mR4E1FFRVpBTS/a25+3wQUxcf1iSVYLM3Uy1juQOf7jQXbIql9tLFiZbGPnY1Yi+S9gcgZb7EgPQWmWyHXnXN8+t2XXJCyOXpwQziep+iTp9wVi98uoIAlBKmj+KbLurOnyDy6Vvvns5vm/juwUK08Rq8W6clgSDBIQCJpUAYJXsCKHvGnNMKDVukHQ91ZkvIEvvl0aarmudDpeVfG9ah8eeuzo1hJZ2+dRoDK5F9HGk4TG3fkYclz/duY01aiibSHHM+KLqEeGxB0A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696f813c-f83a-4cfc-ab8c-08dbbf5ae617
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 13:08:53.0987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BPAjSVdT36loXCbM8NnydWcDA6M556Vlr05HCOjpHjyoiIgCmhsMszUmvKNS9WEpkayxniKqUl4ByqrAuJwmLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6410
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_07,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270111
X-Proofpoint-ORIG-GUID: skkXiGSURC58CLnBlvnpt3a5zo49uzTn
X-Proofpoint-GUID: skkXiGSURC58CLnBlvnpt3a5zo49uzTn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gU2VwIDI3LCAyMDIzLCBhdCA1OjQxIEFNLCBNYW50YXMgTWlrdWzEl25hcyA8Z3Jh
d2l0eUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gMjcvMDkvMjAyMyAxMS40NSwgTWFudGFz
IE1pa3VsxJduYXMgd3JvdGU6DQo+PiBPbiAyNi8wOS8yMDIzIDE2LjU3LCBDaHVjayBMZXZlciBJ
SUkgd3JvdGU6DQo+Pj4gSSdtIHdvbmRlcmluZyBpZiBJIGNhbiBnZXQgeW91IHRvIGJpc2VjdCB0
aGUgc2VydmVyIGtlcm5lbCB1c2luZw0KPj4+IHlvdXIgdjUuMTAgY2xpZW50IHRvIHRlc3Q/IGdv
b2QgPSB2Ni40LCBiYWQgPSB2Ni41IHNob3VsZCBkbyBpdC4NCj4+Pj4gWWVhaCwgSSB3aWxsIHRy
eSB0byBiaXNlY3QgYnV0IGl0J2xsIHByb2JhYmx5IHRha2UgYSBkYXkgb3IgdHdvLg0KPj4gDQo+
PiBJJ20gKm5lYXJseSogZG9uZSB3aXRoIGJpc2VjdCAobW9zdCBvZiB0aGUgYnVpbGRzIHdpdGgg
ZGlzdHJvIGNvbmZpZyB0b29rIG92ZXIgYW4gaG91ciBvbiB0aGlzIGFnaW5nIFhlb24pLCBhbmQg
SSdtIGN1cnJlbnRseSBpbiB0aGUgbWlkZGxlIG9mOg0KPiANCj4gTm93IGl0J3MgZG9uZSB3aXRo
Og0KPiANCj4gNzAzZDc1MjE1NTU1MDRiM2EzMTZiMTA1YjQ4MDZkNjQxYjdlYmM3NiBpcyB0aGUg
Zmlyc3QgYmFkIGNvbW1pdA0KPiBjb21taXQgNzAzZDc1MjE1NTU1MDRiM2EzMTZiMTA1YjQ4MDZk
NjQxYjdlYmM3Ng0KPiBBdXRob3I6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29t
Pg0KPiBEYXRlOiAgIFRodSBNYXkgMTggMTM6NDY6MDMgMjAyMyAtMDQwMA0KPiANCj4gICAgIE5G
U0Q6IEhvaXN0IHJxX3ZlYyBwcmVwYXJhdGlvbiBpbnRvIG5mc2RfcmVhZCgpIFtzdGVwIHR3b10N
Cg0KVGhhdCdzIGV2ZW4gYSBwbGF1c2libGUgYmlzZWN0IHJlc3VsdCENCg0KVGhlIGRpZmZlcmVu
Y2UgYmV0d2VlbiB0aGUgdjUuMTAgY2xpZW50IGNhcHR1cmUgYW5kIHRoZSB2Ni40DQpjYXB0dXJl
IHlvdSBzZW50IHVzIGlzIHRoYXQgdGhlIHY1LjEwIGNsaWVudCBhc2tzIGZvciBvbmx5DQo0MDky
IGJ5dGVzIGluIGl0cyBORlMgUkVBRCByZXF1ZXN0LiBUaGUgdjYuNCBjbGllbnQgYXNrcyBmb3IN
CjQwOTYsIHNvIHRoZSBzZXJ2ZXIgYnVnIGlzIGF2b2lkZWQuDQoNCk9sZ2EncyByZXByb2R1Y2Vy
IHRpY2tsZXMgdGhlIGJ1ZyBieSB1c2luZyBPX0RJUkVDVCB0byBmb3JjZQ0KdGhlIGNsaWVudCB0
byByZXF1ZXN0IGV4YWN0bHkgNDA5MiBieXRlcy4NCg0KTGV0IG1lIHRha2UgYSBjbG9zZXIgbG9v
ayBhdCB0aGlzLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==
