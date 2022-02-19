Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4B54BC6FC
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Feb 2022 09:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiBSIgA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Feb 2022 03:36:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbiBSIf7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Feb 2022 03:35:59 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Feb 2022 00:35:40 PST
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432D6674CB
        for <linux-nfs@vger.kernel.org>; Sat, 19 Feb 2022 00:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1645259740; x=1676795740;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=vlcCs1k7BmD31ifSVsgZC8VzFBa9EasPMsI6SqxoRZI=;
  b=a7keDCvpXMSSp8tkwa+ML5lVQ63FfnT3Ie5Mi+HYFTXjIHgmJVtc338s
   FypWNTmYRkCR9ZyfiBIviwSGMMCUuR1dD6XfakIjDcXAJGi9Se1/0Vbt/
   QQKW+6XEdSOMn+BJIlUxNfZj7aMQ5oNu4ymj/hVdcN8Pbat19hOg2B5fA
   EbVfdLxzkgytppF6LyQPsFuDpqQWh7gUSOuUocaknfAUjwUa4oMm7D0oe
   7rBuXQ+dVzXfhn+IXTr0UDtdnZF9fO7lYGAVpb21SFvDP10dCGLTIvvGM
   hKtjeGTyNw3kI2QUdRc1RZJtnuUKCYaTuWI60tTztZ7vQCxY4Icj14x+d
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="58134587"
X-IronPort-AV: E=Sophos;i="5.88,381,1635174000"; 
   d="scan'208";a="58134587"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 17:34:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJ6XTH7zJdLpOAuNDu0tWYMebZywbUOkYlrXdW9HiKnn8p4+67aKZ/6VZrjXxjaPIuzxZ4mhCZOCZ5DqCdD9L/NyThHJKBg6imhEpD4k61dYplA2knTYQamsQuFhL+uSEFpB2EjINhXTCInT5myc9qVjgwu/oLNO1Dg4nPiXkeh+XGvHXIIWiVKXarmD902bRNknOcOHtpsW6nenH9DsIa34V7mZGNkT+e+t0SX/qpvJxyNOOz6foaTcTH0XD001xfWhrhdIP/D0AihiVbdtGHwDYwo8M9XQGkkQ0tZvoN6urWDfWPE/J5y1WjGGU+k2P4UIvo+2wHSAjDycaqZjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlcCs1k7BmD31ifSVsgZC8VzFBa9EasPMsI6SqxoRZI=;
 b=at28HhOBKNWqchoT8YUn5E0fjuewYOj2lW72AalUO9r/xgWcbyjMkCtQqkVNozIfM887D2cx9FqPkE/9wFKuZ3yU5nwO2HXD66D5crqzndJZnkenRwpLQQTp3kntXC9uZczVPDe1EdzHAOj/pHg9Fdhj5vCCg8w5yJsC+XfYUgZ6z2IGnkeirAK6S+QJfbb58ZQHaT0tYg/5fRbwP09AoZjFg6KsGUjCOpx/eSXd57QB67nonF0oIP06SuJ2RoS52p5tRWoRYL32yjlxW4dlVlg/VotqjSTvTrs85BbDiBP7/nNUErhYhnZm6sEERcxe7M7JkeohWq+ysOy7bVOrcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlcCs1k7BmD31ifSVsgZC8VzFBa9EasPMsI6SqxoRZI=;
 b=NUi4IHrM8HXNnYVjgUanQnwzHrxTg3v+fzu9PgWxvb63GLnBQ48HOol1v7+LVcBCezNb06Asyjfzpop4NvWyDtXrLGd9UyrW8zLOnVhIX4vT2Sp6b8rO5NVL8C+ieSYsKkirRxtHyycWNX86P2t92FulFshGyYuZ/1sA3prLU0I=
Received: from OS3PR01MB7705.jpnprd01.prod.outlook.com (2603:1096:604:17c::12)
 by OSBPR01MB3765.jpnprd01.prod.outlook.com (2603:1096:604:4e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Sat, 19 Feb
 2022 08:34:30 +0000
Received: from OS3PR01MB7705.jpnprd01.prod.outlook.com
 ([fe80::c08a:827b:f11d:aadc]) by OS3PR01MB7705.jpnprd01.prod.outlook.com
 ([fe80::c08a:827b:f11d:aadc%5]) with mapi id 15.20.4995.024; Sat, 19 Feb 2022
 08:34:30 +0000
From:   "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "l@damenly.su" <l@damenly.su>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>
Subject: [bug?] nfs setgid inheritance
Thread-Topic: [bug?] nfs setgid inheritance
Thread-Index: AQHYJWjCc3uFudjLBEiBihXxNl6DhQ==
Date:   Sat, 19 Feb 2022 08:34:30 +0000
Message-ID: <OS3PR01MB770539462BE3E7959DAF8B5789389@OS3PR01MB7705.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 3471e9c8-3432-2312-be7c-f7084454d2a3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8951ebf4-dd66-4014-5bdd-08d9f382a5ea
x-ms-traffictypediagnostic: OSBPR01MB3765:EE_
x-microsoft-antispam-prvs: <OSBPR01MB376526E3BEC2517D8E6E3A6089389@OSBPR01MB3765.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gp3FfxHAbLW5Rt7qYfITeNMNu+Jl4WkLpv3T90noskO6WB9Pc+Bsgf9PFz4c5AEbBKBZ4o29tyjtGhSLNhmDBk3tfaStFVLRoxF4NQ3qXY1Wt/JLv7XA0OHBU8kjRPRk4EvN67qvS+bOuTTo7BDxsYjmuQgYW5RLjc+7Q2uVYbD021qMz09SQTRSsyHD79V0fRDj77z/qJzSAiMBgCCTs9Q8+OhWtq9AGtzxip6hRXlSu9l4lpRYucs6jBycXBsMgGd7dgWK5aQN56GCn19qYNAp+ZgNl78tXBbt3LRa/edoO4w1b39tXbGgBopFbUAWCXiXRlMC0/EucET1ncMeephXsLeLX5DSLgMsS4CPxcPnryTdKpM7sEdx0WRZegWQ3zfgjV5AwKwz2BgXue7h7rgfGDklItPBbQbYw2cbDoOcws3+ySj2Dn7UfbD3aA4IiLSlOoK+Ji5Q/Z2Y3fYj6RxQpsa88srEOI7Hldbp52bg1NOX6YFvL4rpAIevD6xKNv6ohWzmukhe1Ht9N/2SnuGau0c+IUKC1Ks4GVp7as35X30FcQIUBxqxDGgDH5oD8jxGvvxH8puef+g44Wf1ifEvL/7pe28EJH9Hk6057T3yBkivkwsl/Pax6GOdm31k2/IhvjS2hdug/Bffe8mFQoOklEu2p+oirdWcISxJxvUEpzQzAHRZAV6uvr5Rr6urvgE/xhj3UuHEkTByyB9Z+SF4A6ixGd0hxi5kOXDB2zA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7705.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(52536014)(66556008)(64756008)(8676002)(122000001)(5660300002)(66446008)(91956017)(66946007)(76116006)(4326008)(71200400001)(186003)(26005)(82960400001)(83380400001)(55016003)(33656002)(6506007)(7696005)(508600001)(38100700002)(316002)(8936002)(9686003)(86362001)(6916009)(54906003)(2906002)(38070700005)(218113003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?d21OeHhTc2o0K2NQZDJEV1lheFJHQTlhdlMvUjNERzk2RFE0cFZ6c0s1Uk9H?=
 =?gb2312?B?TlJONWJpNXpsU3JDVVliK0xLWnoxMGU3eTYzSXdYZTgvK0ZVQTlXeGYyYTNO?=
 =?gb2312?B?dFdVQ1lyak9nNG1TY0ludVlKY0JMRytMSlZpZUhvMnArRStFdlF4N3k3eTJO?=
 =?gb2312?B?SlpZamx2VHk0bjdER3dpVGlRQXErbmU1akRSa0hvZVJCSUIxVlFjbXUwQVBo?=
 =?gb2312?B?b2NtVmJnS3kxbVlNNjA2RGtvcjZVU3prRVdGZFBZTVFGUWQ2dDIySHlvd0Zw?=
 =?gb2312?B?WlJhTC9zOGxVVnNnSDZiVFpzb2xHaDlkU0ozWTd5RFJ0a0l6MFZ3eUR4VjJR?=
 =?gb2312?B?UnVWUlV6R1FSZ0hFWFVhYUZYbm15cER0S2V5UUNMZGhGdVY0eTNBbDhKZVo5?=
 =?gb2312?B?cXpFWVVLNlFCUWZkcnlXbTJIUWZqZDRIckdqUDZWWFJIR1lwU0NYbzNxbmVx?=
 =?gb2312?B?N0swL2hEQ2IrVHZ2NkthRStsRkJ4ak1wZHZyY0xoQUtjTUJrT2w0Q1ZBeGMx?=
 =?gb2312?B?MG5LV2hlS04zOUNuWVRBYmRKVlFHUEk2TU1ZL2FBSmpKZWRxNmZPc2JMUGFC?=
 =?gb2312?B?M2FTa3NEY3ZnQWM5SmhSOG1wajBFRzc5RXR3RDVqMXkzSVU1UWZieWNXRkhL?=
 =?gb2312?B?NXlVK2hrSUoyOFRxUGs4QWVyUmxEdUZISkU1U29aSnVoSlZNRlpFUEI5dWhr?=
 =?gb2312?B?TW5LaGM2L2QvTWZEbnJ6VTRvc0VKWXBXS2lsamdUWTdNMzcyOGtDNENmUG13?=
 =?gb2312?B?aThFeWZHdERYemMrTUdlcitXSllHRkkrWHV3UTdmNzU4V1NKYUNqMll1MzFX?=
 =?gb2312?B?L2h5MStPZkIrdWo3R0ZIdElXRzJGKzkzRUh0VUc1bzRqWWc2OEVwUnM0VDJ5?=
 =?gb2312?B?TWx2bFJKRndHV3M0dTUzRy9NMkpORTlTRUF4alhnMjZSRGJSYkhDa2p1dEsw?=
 =?gb2312?B?SnVPVVBPQmlkdXBPYXVNbURCNDJzK2c3R3YxWmkxdXdNRlhMUzY4Y3k2bFlq?=
 =?gb2312?B?YU01OFQ0MTlUTFowUVBtS3U3aFFaSXUyczBTdng3RnBxbFpMSXNPRjJYTWtK?=
 =?gb2312?B?YjFsVjJOeGdEbENDMnB3c1FxY1B4S3V6TFA2UWh1KzlTc2dMVG54QlYweUhn?=
 =?gb2312?B?ODFVenA2S2RLTlk2cGJ5Smh3UVBhSGNVdGJKUkVQV25MWS95UzNsS3hBbU5n?=
 =?gb2312?B?Y21BTmhyY2tFbFVQNFJ0M0w4bjNlcDJ4ZVdCblJienpZTEJpOXdzaldGejRH?=
 =?gb2312?B?aEFnQlVYK2Q0NGhUM2hRNk9xYlRWcnVXMENndEc3WTNyS29qSGNaOFY1MmJP?=
 =?gb2312?B?T1BvNEpTejZ3b0d5ZnBxTE45STY5ZXVxSGZDdUpDb3FSTkZyNGNMbkw4SG5a?=
 =?gb2312?B?NHJ5eHlYajRDTGN0SDhZUDV1SENxOUIwLzliNXU2dXZIYmkwdEZZQnhFSU1X?=
 =?gb2312?B?Qk13QmNVOEFJdzYyRGw2enpzTmxQUkVTZkFDd2l0Sm9taUtvU2czcTN3a3J4?=
 =?gb2312?B?cjVSS0NWLzRVY0hjcXBhUU0yV3RKaW5NSjQwekNJcXV5T3BSM2JaemJHcVVk?=
 =?gb2312?B?aWNPS3pieG5CdVdkRGQxRmlCNTFBSVBDYjk1M1Y2enV0RlllcUg1bzhJd1h0?=
 =?gb2312?B?ZWxISWpUNExhdHFxNm92RjhSWHM4YURGLytTK1FnOFJXaE1rMUVuaEptNGti?=
 =?gb2312?B?ODRwWnAwRDFadzdLOFdKeG1SV0h4QUJOSDRMVWFOSW82QTlURXk0WTF6d2hL?=
 =?gb2312?B?TzFLVkFoaUJDWThhUStNZ3loNW1SU1NiU0hGYkF5ZWhlT0ViTlQxOEJlWWVj?=
 =?gb2312?B?RGpLcjZrcTRERnFkQyt1akl6Qk1CS1NuVnF3QjJCbXhLZXVGUk5xRTJKM3cr?=
 =?gb2312?B?d1NMZ2Z5VkIrVFl0K1kxNHJpR3VIVHhOUW5sQ1BrSm1vQ2NQd0RwTVR6bWdM?=
 =?gb2312?B?T0JhRlIxdlZQSHhqbWRja3c5cUpENzlZaXR1dzZSS1AvVG92QWM0S0N4d3Yx?=
 =?gb2312?B?cFR6WkVKUWczNElSd3hLRU1RaVFhRjByMkZaYUljYy9QUXJ3RjJCOEtId0VQ?=
 =?gb2312?B?c3RsdlRhRXREUUVkNlJ1WGZpYnVrSlY4b2JKMVMyQUhDWWdYeUlvb3Y1b0tL?=
 =?gb2312?B?cWJqL1dkTVJnM1V1ZWl4NXVhNmtaWjlINldieU9NN3BQTUFTNXI1NTJyTDho?=
 =?gb2312?B?MUE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7705.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8951ebf4-dd66-4014-5bdd-08d9f382a5ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2022 08:34:30.3908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C9ehDVml7Mkdy7p6DB8pa5VNd5Zqc3bJ7a+oP+5eBX5AsrSGtDidYCexlJtTcxXKvzuFWkdZvs6VGyy5iugwxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3765
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTkZTIGZvbGtzLAogIER1cmluZyBvdXIgeGZzdGVzdHMsIHdlIGZvdW5kIGdlbmVyaWMvNjMz
IGZhaWxzIGxpa2U6Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
CkZTVFlQICAgICAgICAgLS0gbmZzClBMQVRGT1JNICAgICAgLS0gTGludXgveDg2XzY0IGJ0cmZz
IDUuMTcuMC1yYzQtY3VzdG9tICMyMzYgU01QIFBSRUVNUFQgU2F0IEZlYiAxOSAxNTowOTowMyBD
U1QgMjAyMgpNS0ZTX09QVElPTlMgIC0tIDEyNy4wLjAuMTovbmZzc2NyYXRjaApNT1VOVF9PUFRJ
T05TIC0tIC1vIHZlcnM9NCAxMjcuMC4wLjE6L25mc3NjcmF0Y2ggL21udC9zY3JhdGNoCgpnZW5l
cmljLzYzMyAwcyAuLi4gW2ZhaWxlZCwgZXhpdCBzdGF0dXMgMV0tIG91dHB1dCBtaXNtYXRjaCAo
c2VlIC9yb290L3hmc3Rlc3RzLWRldi9yZXN1bHRzLy9nZW5lcmljLzYzMy5vdXQuYmFkKQogICAg
LS0tIHRlc3RzL2dlbmVyaWMvNjMzLm91dCAgIDIwMjEtMDUtMjMgMTQ6MDM6MDguODc5OTk5OTk3
ICswODAwCiAgICArKysgL3Jvb3QveGZzdGVzdHMtZGV2L3Jlc3VsdHMvL2dlbmVyaWMvNjMzLm91
dC5iYWQgMjAyMi0wMi0xOSAxNjozMToyOC42NjAwMDAwMTMgKzA4MDAKICAgIEBAIC0xLDIgKzEs
NCBAQAogICAgIFFBIG91dHB1dCBjcmVhdGVkIGJ5IDYzMwogICAgIFNpbGVuY2UgaXMgZ29sZGVu
CiAgICAraWRtYXBwZWQtbW91bnRzLmM6IDc5MDY6IHNldGdpZF9jcmVhdGUgLSBTdWNjZXNzIC0g
ZmFpbHVyZTogaXNfc2V0Z2lkCiAgICAraWRtYXBwZWQtbW91bnRzLmM6IDEzOTA3OiBydW5fdGVz
dCAtIFN1Y2Nlc3MgLSBmYWlsdXJlOiBjcmVhdGUgb3BlcmF0aW9ucyBpbiBkaXJlY3RvcmllcyB3
aXRoIHNldGdpZCBiaXQgc2V0CiAgICAuLi4KICAgIChSdW4gJ2RpZmYgLXUgL3Jvb3QveGZzdGVz
dHMtZGV2L3Rlc3RzL2dlbmVyaWMvNjMzLm91dCAvcm9vdC94ZnN0ZXN0cy1kZXYvcmVzdWx0cy8v
Z2VuZXJpYy82MzMub3V0LmJhZCcgIHRvIHNlZSB0aGUgZW50aXJlIGRpZmYpClJhbjogZ2VuZXJp
Yy82MzMKRmFpbHVyZXM6IGdlbmVyaWMvNjMzCkZhaWxlZCAxIG9mIDEgdGVzdHMKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KClRoZSBmYWlsZWQgdGVzdCBpcyBh
Ym91dCBzZXRnaWQgaW5oZXJpdGFuY2UuIApXaGVuICBhIGZpbGUgaXMgY3JlYXRlZCB3aXRoIFNf
SVNHSUQgaW4gdGhlIGRpcmVjdG9yeSB3aXRoIFNfSVNHSUQsIApORlMgIGRvZXNuJ3Qgc3RyaXAg
dGhlICBzZXRnaWQgYml0IG9mIHRoZSBuZXcgY3JlYXRlZCBmaWxlIGJ1dCBvdGhlcnMKKGV4dDQv
eGZzL2J0cmZzKSBkby4gIFRoZXkgY2FsbCBpbm9kZV9pbml0X293bmVyKCkgd2hpY2ggZG9lcwp0
aGUgc3RyaXAgYWZ0ZXIgbmV3X2lub2RlKCkuCkhvd2V2ZXIsIE5GUyBoYXMgaXRzIG93biBsb2dp
Y2FsIHRvIGhhbmRsZSBpbm9kZSBjYXBhY2l0aWVzLiAKQXMgdGhlIHRlc3Qgc2F5cyB0aGUgYmVo
YXZpb3IgY2FuIGJlIGZpbGVzeXN0ZW0gdHlwZSBzcGVjaWZpYywKSSdkIHJlcG9ydCB0byB5b3Ug
TkZTIGd1eXMgYW5kIGFzayB3aGV0aGVyIGl0J3MgYSBidWcgb3Igbm90PwoKVGhhbmtzLgoKLS0K
U3U=
