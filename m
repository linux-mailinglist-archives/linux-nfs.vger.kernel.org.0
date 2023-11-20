Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8197F15D5
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 15:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjKTOhj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Nov 2023 09:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjKTOh2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Nov 2023 09:37:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342EC1AA
        for <linux-nfs@vger.kernel.org>; Mon, 20 Nov 2023 06:37:25 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKDnjBo004535;
        Mon, 20 Nov 2023 14:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2TH/mum7mYvDQrnPQ3slfhYYjSwBLzjnTgDBULIb6dc=;
 b=Eg6peybBkqVpzLXsNU542N8DcKxnSBysU2NQkmY3LyF9KYEw9fa83iV9Ad5fgIq65Rv3
 DeGKKbrnMdmcbtZ2a9vmT5789rZqJ+3KGD6Qyg0fOeah5R3KNHbIoqdq5iquJzAjpg1B
 WkqGDPvl8j9+wlv6byg1Moydj0LoqRz/RS9hkxsNBHzA9t9Y8WecsiO3e9NDJ73/920F
 YP0x4NGvhSQkhiv+iYKqqxG4GePTEuKv0cE6YH5hb74VPb2INE7qLp5HhFa9+3y4QGKj
 6KQfS1XMInr8PpDWMFoY1hWWGoUZ2aOfVrw0lglKnJAYrtaVzkw+wPN0Z0taIsElljA2 wA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uekpejtn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 14:37:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKDd6ZM002436;
        Mon, 20 Nov 2023 14:37:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq5f7b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 14:37:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3MFegOm0daX4jS4VlFS+8XJDqBx2E2sKD/PKAX0lOpv5UMbmZhUgLRL0h13g5jVZHpmdSUDTg2jRg7JSjP/W0d4+kCz2soqnCie6LXgJEkdoOGZ8VlzvZRkcS0NVpSJyueFjdX0tovYSxh8kT9dMfxgqKkXapfqT3mHuRqCMbcrHDEoHFFtxqmYtKWzcSwAuil3Xo5WWdzIdyYAG5xdrWZtBBEE4zQto5LujKejL+dEww7VIdgevoOT7mge47DF7cpM8HQOuf4RPclne9vvtro+M3QqgeauBpt61+ArQRbI4OgJuHjKDkJNsK3DgkA0IJocwd6sfEK/VY6QoEFhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TH/mum7mYvDQrnPQ3slfhYYjSwBLzjnTgDBULIb6dc=;
 b=Dr2Da9CHYlcboFQ1FUP4MRkwZOrivAB6mZlfK06v8x5qUT5fusNmMiEI/f8vlkVPbcJNnwBEIthQaJeG/M7pLulIJ0doaenZi4wg/WgRnzjY/K7aC6Q4R6ZuSJIA89ApbLkbonBFRXTV8DWtNTw82TmtWRJRE6Tql9LsZ9XVR6+PMLSJC5gLzx283x6xroSlEzKgIeyc/NSpv6Y4jCTw090VfHdqoqdzZTgScZIbZ41NOGrl9phZ3rJLM+7K474CYcunxdw25pB2uVX2lPaRQ/7BR8K0cJdddf+6rz+ZVvrLXyoK42SEPy8C3Nm4jayMJqHp8xu6w3yHIS7m/23gNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TH/mum7mYvDQrnPQ3slfhYYjSwBLzjnTgDBULIb6dc=;
 b=D4csPwK1JX1AyXAbgNMecPzLjf6v4YHiNZAM7ZUNxhKA2RJy1UCr09kavwDUCZq+byK5SAlbTgO5592TxCIk5NUyZRopPRuuMCCgoLVpFc41DKBlIAZNbjSZffzm6Z6R3qdDXPy7UoVuqFPBYPEp+wYvhn6UClRHniIGQ2OX5Zw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 14:37:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 14:37:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>
Subject: Re: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Topic: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Index: AQHaGSnEPMpWeNwF5UG1EZJYD3+ecbB/omOAgACniYCAAAIOAIAAA+qAgAA+NgCAAc04AIAADi6AgAAPmgCAANKjAA==
Date:   Mon, 20 Nov 2023 14:37:18 +0000
Message-ID: <AAFBF47A-A9A6-408A-BFB3-2F21071EFD2A@oracle.com>
References: <bug-218138-226593@https.bugzilla.kernel.org/>
 <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
 <CALXu0Ucz2MGCYdMw74ZKGUj_hpGcLP-pxC=MSgpUFGU58=jc=g@mail.gmail.com>
 <CALXu0UdY=ZgcAqvC6Y-X6htxPQ9=XWemt8V4dxTA99wQmHKz=w@mail.gmail.com>
 <959BB15F-5B91-4413-BCFC-EDAC78EE32F6@oracle.com>
 <d8bb0bf43c8fe38ef83248fb55a9549919530cf2.camel@hammerspace.com>
 <095736A1-C749-4B8C-900C-C0471D8F8422@oracle.com>
 <9bb44f33-9900-44e1-813d-df1c60d8307c@redhat.com>
 <35ffafefb1596f4941513bc8dd51470fbee842d4.camel@hammerspace.com>
 <F12175F2-9CA3-4C6A-9089-BF5E62A196D0@oracle.com>
 <ec326d7e13d12c02fabf8a5fe46f2ad8bf66d368.camel@hammerspace.com>
In-Reply-To: <ec326d7e13d12c02fabf8a5fe46f2ad8bf66d368.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4497:EE_
x-ms-office365-filtering-correlation-id: a778a6d3-3cc3-4aa1-97e5-08dbe9d63267
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TML0bir3GzWO596j86MzuU/wi14yJ8nhABO0hHQo/VhoIY0AdUFFF7eJ85jzpw+73F1i0WCTgRLP7ynyvqh4Q/49eSQgUrnYtVf7ke0i/3Sd5pYuFkHWx13i5xK711mW6ORPf8smO+ZZo/5iFWR4hu5Tl4RhJD+psLLYq0D3U48cPbc0kOBcKYZYF0BmNdut1K3AC5h+kIkdVCgT/Q2Zuu5f4IZLuD436BKJSE+VJs1kuF05R9uQV97RkREwWRWJfmUZ7hLLUB3VwkmUi7J68jQVej2JtoKdJkVbtOOKJ7RGv5yyKt6rIwsJ2T4VMOuDqP3E9ZRt4SU5vC8jA0oG4AHQ7op92hFLzrm36S8wQOYY6RKLW93Ogo5XpDliy7loSXez2Ly7RId/TSyjvwkgEH0SimIwFjQsX8P53qLW2xwJdmxBCtd9EpLVrVjRj0BEJYjr38tnEAIBAXuKN7p+8YrVvhxWWjQRWU1cP8IeKiMOKhB94LNje3ClZ+i/26nPIs0G1dVmzM4HqbrziEoGe8dFyEg+X8hZEBMdCQvP8v5lc+ozTdhpLgGJy+j/NMtvK8XizOm5tKQ5D0xgpO1+xBqEohEq27eiKzD6RVtLNrJvJIej24vwdGurzfXN5aEvlTSC4v1GOSc74csr4LW/yqY90F7NjJseqezuoZQTFJUYugnKVbV0EjFemfSHBuDi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(66899024)(36756003)(5660300002)(15650500001)(86362001)(4001150100001)(2906002)(33656002)(38070700009)(91956017)(83380400001)(122000001)(6506007)(53546011)(478600001)(71200400001)(6486002)(26005)(6512007)(2616005)(38100700002)(8676002)(4326008)(8936002)(66476007)(64756008)(66446008)(66556008)(6916009)(54906003)(316002)(66946007)(76116006)(43043002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjU4ZXNRZlB0QUFVUW1ZSEJyMktlRDNmeW80aGpBWDhYaTd5dzJyaTRJRHFC?=
 =?utf-8?B?ZnkwMFB5bDR3dUx2Sm1rd0E5N2tBOWtkcEtsV0VPMUI0ZHo2QVZSUXptb2J4?=
 =?utf-8?B?RXU0LysxaTZxNzJXRHdqNkVncHIvZ1V3cG9sbVE5NnFWRldIbnA1WEdWT2RW?=
 =?utf-8?B?R0x4elp0UmF4MmZaR3NIaUtJaENoVkJoQlROR2Q4clZ5Z01PYmc1bjJkd1pC?=
 =?utf-8?B?TmR3RitGajF2V3Q5UC9lRCs0WHFoelh3OGZZZzRBdkZwMmh3aXVPZ0diQ3Yy?=
 =?utf-8?B?N2JZSEZZUEc1ekR5eFQzK0V3ck1raG5SLzAwbGNja1dSRWd1TFFydlVlcVV3?=
 =?utf-8?B?c0pPYStMdVF0dndHc2JZRnk3Q0xPMUJlU0RjZENIQ1hWcGt1Z25HcE5qR1Bo?=
 =?utf-8?B?bHM3ak85ZWdtUmRGcEtuMUhZZXQ0Y3Q1QiticlZEcDloWkRRMTZYbTd6dTBW?=
 =?utf-8?B?WndVQ3lrdGZxbldFZWtaT0hxQlByakdwSU0xT01GRjBXSXhBa3YzcjJ5NXVz?=
 =?utf-8?B?a0ExaUJGdWE5SkdIZ0VjamkxSUVNRU5GWllXNFc4ZE1kL2JGeEVwTTRjVkVi?=
 =?utf-8?B?UW1yUTdaWk55ODdyZmFhMStuVkRhYkFMNDNSUnB3SjVFWWV3UXdyMUtHZmNY?=
 =?utf-8?B?bzBuVzZIV0I2OVBsbHZhWGc0T1V6MjFyYTVOV2gxUXVycTJsdmhWY1JCUGk5?=
 =?utf-8?B?cnNyUHM2OSt6dm9oRG81eHRnZzg0T2ZPbmhRT2Zvc3YrN0g4c2p5ZW81NWU4?=
 =?utf-8?B?bitDOGYxMTZTdWRibTlNSkozS2lTWmRkSm9IR1hJME1jSENaSHpJOTByeVhF?=
 =?utf-8?B?eldyZFNLV2VMUjM1OUNuRzhXTXN4WWdnYUxRMzhZZnh4UzFna0hQTmFGSDBD?=
 =?utf-8?B?aWVWTzhnNFdhamNuL1hBcEVua2JHUVZ6VFhmdmFVR3hGeVQ2ejJPVzJVM3lB?=
 =?utf-8?B?VkxyRlZZeG8xNlFCM3FnVXhKZkJ1QmV0WHEzNjFtam9FUkdzdmJ2VE4vUlBZ?=
 =?utf-8?B?VGkxb0tmaVJaOGlEaEptbXVBbldUNFZ5eTZ4YXBSYVoxbFd3bGtrczd2QWF5?=
 =?utf-8?B?WUZGWE95QmNCdGJBQlZUTWFLRzQ0eXZCZVV4a1hGdERqNThTM1B4Mm15ZEtv?=
 =?utf-8?B?SVN4R3QxRFl0eUNMUHR3SjB3S3ppQTFkY3kxYVAvQnVQb0FBQVFSQm9tSk9y?=
 =?utf-8?B?NTVnOExVSE5ibk4wSlM0MGxHNzE2MmtESDdnQWhWU0NFcUlhWjU0T3FLUU9l?=
 =?utf-8?B?WkhKLzRGUm5rdng5Zk9zUDc2bHhFaE1SUktPRmlHSDdrUXdzK0FPT1JSbGV3?=
 =?utf-8?B?enBsdG5neTIxaTYzNlJxenVqYjk4MUxObnYwcHpTdHJsNTl2MFRVTVlrTmth?=
 =?utf-8?B?YXk0YTBTNFN2bXJQaUt3NXBzTExYT2JKWmlZTTVOOSszSHdsa0VVT0NYM3hJ?=
 =?utf-8?B?aHBmOFVsK3E0ejR4WXc1dUNJQnpIS3hDRSttcmFCWitxdUNrUjJPMXkvT2Zh?=
 =?utf-8?B?STJ6aTN1Z1RMYVc1b05FRlFMeWlpYW9vTXI1ZC9XeTk2b2twSEJ1TU1HV1pQ?=
 =?utf-8?B?VlFUcDhmWWZmcFRobXQrMUNQNTBEc042ZkMzRWVmMGk3a2hIeDgzZ05mNHNh?=
 =?utf-8?B?a0pYY0dCMWtHNlRwQ21QK1NqOXZJNXEzbmFjTDVnd1pQaTd6SVhFOE9wdnZM?=
 =?utf-8?B?aFZzQ2paRWpJRVk5bTFYSUxLbjNlMjhwR3dQNUlFY3YzQU0rWTVkK1FWSmY2?=
 =?utf-8?B?NjgxSW1iL2FiK1k5dWhreXN4azhsZGRKaWhPdTZMaG9hRWFHdCtISWM5ZlIv?=
 =?utf-8?B?ZVp6QWx4Wm9GU1dDbkcwOU11ZmpyUlllRGZOZHNYcElsSVdGN3FaRER1L3Vk?=
 =?utf-8?B?YXByU09ncStMZFQrQjFXWDNkTkl3QUdaQWtnblFVWTdCRHB1VHozdlFQMWJn?=
 =?utf-8?B?YnpvK3IvRHBseW5SU2VrZUY3NU5QWDFZU0p1TzJZS2hsalAybnBuUnBSYkEx?=
 =?utf-8?B?TTNDak02OThyRzR4VFEwNi9iQkF2QWNVYUxOaFpLNUhwY21NY2UvNjVsUDhp?=
 =?utf-8?B?Vng2anIraUtGT3AwVFBmZHZrV0NOK3dhNkcrTzNSaTBwSUtNMlk1dmt2TGZu?=
 =?utf-8?B?UWFEd0d3elZFV1RxdnVuN0lVMDVDYzNXenQ3OXdBNkM5UThpY1lidG9KMlVF?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50F611616F4E174EB9E053C4946EBFCA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ri4yaNWrrotikstswym6QHqBHFp3zAT2E0FByq8cwijjEpJMr1vRX8S9j1eprsLRiE/VIeaEDcadFs4rfFeUea4ytfioffXx50ZkemStfQlO/9ct1y7liP3nAIemcbAV/9Yt+YFsyZAtyk+mYpmLw62DWBY2QLY29vxUWOfnCszCefeznz4zz9Ki5JVmtYY7k/tITyvI+ZsZYSeO0bw6y8BL2jYbWTAL0/LWiLKXe9yAp4XQ1nQZndVNtf4NYwqR18bdOOw2CvrpdmGBY4i6bhX/E17ajf2UeLRYW3l2jBC8w82h0yJOgNn7a9HVD0bQkrmcGDaSBnEXfi1dqFg4KzOMsw2jbe7rADvlTrKuWxTnGPbt7VGqlAOhE29F15md5+yFJ4CfjGn6oH5le1b0e+weuZCuJCNJv/Fu5a0XK00ZqSj2pLiI8plGxMTa6y8tqHU9K2WFIq9KkM5a/aVa5AR/H7YmHbFhrSrQ1U6naSEZDPaEcbolguiNNCVOzEyYo/hSoQzOsGYRR5Z0Z9qo40/1vF0+caT0FXQ8T9MvTqLHPLFKE1qXcyKt2TrtetRxFSJxeyFasuthXm2I60Tx02wCga66FJtQJ+ByEJ5HJXoGRcKgc+nU+b61kPfaST7/1VnsePCxYRQBFJRtByFioUTIX0wqTjQmHKFoqRW9jUeFvKONdQdkyVnpNu6pTAUUElKR7GYI2dTxpAHOphmX8/+kMFm8WQO0gHQSY87d/9gzKhF9C7Kob3qGphfs/Z3y/ZYbkKd2M5TecvE6LH0vPGc8+pxnjVAm6pgnCiaF4gQ6mJNsZHDqS9/7L+X5QgOca47N3SsKGYwrnufInSNRHQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a778a6d3-3cc3-4aa1-97e5-08dbe9d63267
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 14:37:18.0397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xuAznY9RNLMJ6Wa/iQMozrZwVcIWSDwxuoMgy/dFvWxNIKH3K4S/RufWJIi0o4TNIxTQd8whwjKz+aJKjWDCDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_14,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200101
X-Proofpoint-GUID: ejugKVBaZdvVjsqCHYp3SR8t7r9N8-Xr
X-Proofpoint-ORIG-GUID: ejugKVBaZdvVjsqCHYp3SR8t7r9N8-Xr
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTm92IDE5LCAyMDIzLCBhdCA5OjAz4oCvUE0sIFRyb25kIE15a2xlYnVzdCA8dHJv
bmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiANCj4gT24gTW9uLCAyMDIzLTExLTIwIGF0
IDAxOjA3ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIE5v
diAxOSwgMjAyMywgYXQgNzoxNuKAr1BNLCBUcm9uZCBNeWtsZWJ1c3QNCj4+PiA8dHJvbmRteUBo
YW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIFNhdCwgMjAyMy0xMS0xOCBhdCAx
NTo0NSAtMDUwMCwgU3RldmUgRGlja3NvbiB3cm90ZToNCj4+Pj4gDQo+Pj4+IA0KPj4+PiBPbiAx
MS8xOC8yMyAxMjowMyBQTSwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4+Pj4gDQo+Pj4+Pj4g
T24gTm92IDE4LCAyMDIzLCBhdCAxMTo0OeKAr0FNLCBUcm9uZCBNeWtsZWJ1c3QNCj4+Pj4+PiA8
dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+IE9uIFNhdCwg
MjAyMy0xMS0xOCBhdCAxNjo0MSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4+Pj4+
PiANCj4+Pj4+Pj4+IE9uIE5vdiAxOCwgMjAyMywgYXQgMTo0MuKAr0FNLCBDZWRyaWMgQmxhbmNo
ZXINCj4+Pj4+Pj4+IDxjZWRyaWMuYmxhbmNoZXJAZ21haWwuY29tPiB3cm90ZToNCj4+Pj4+Pj4+
IA0KPj4+Pj4+Pj4gT24gRnJpLCAxNyBOb3YgMjAyMyBhdCAwODo0MiwgQ2VkcmljIEJsYW5jaGVy
DQo+Pj4+Pj4+PiA8Y2VkcmljLmJsYW5jaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+Pj4g
DQo+Pj4+Pj4+Pj4gSG93IG93bnMgYnVnemlsbGEubGludXgtbmZzLm9yZz8NCj4+Pj4+Pj4+IA0K
Pj4+Pj4+Pj4gQXBvbG9naWVzIGZvciB0aGUgdHlwZSwgaXQgc2hvdWxkIGJlICJ3aG8iLCBub3Qg
ImhvdyIuDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IEJ1dCB0aGUgcHJvYmxlbSByZW1haW5zLCBJIHN0
aWxsIGRpZCBub3QgZ2V0IGFuIGFjY291bnQNCj4+Pj4+Pj4+IGNyZWF0aW9uDQo+Pj4+Pj4+PiB0
b2tlbg0KPj4+Pj4+Pj4gdmlhIGVtYWlsIGZvciAqQU5ZKiBvZiBteSBlbWFpbCBhZGRyZXNzZXMu
IEl0IGFwcGVhcnMNCj4+Pj4+Pj4+IGFjY291bnQNCj4+Pj4+Pj4+IGNyZWF0aW9uDQo+Pj4+Pj4+
PiBpcyBicm9rZW4uDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBUcm9uZCBvd25zIGl0LiBCdXQgaGUncyBh
bHJlYWR5IHNob3dlZCBtZSB0aGUgU01UUCBsb2cgZnJvbQ0KPj4+Pj4+PiBTdW5kYXkgbmlnaHQ6
IGEgdG9rZW4gd2FzIHNlbnQgb3V0LiBIYXZlIHlvdSBjaGVja2VkIHlvdXINCj4+Pj4+Pj4gc3Bh
bSBmb2xkZXJzPw0KPj4+Pj4+IA0KPj4+Pj4+IEknbSBjbG9zaW5nIGl0IGRvd24uIEl0IGhhcyBi
ZWVuIHJ1biBhbmQgcGFpZCBmb3IgYnkgbWUsIGJ1dA0KPj4+Pj4+IEkNCj4+Pj4+PiBkb24ndA0K
Pj4+Pj4+IGhhdmUgdGltZSBvciByZXNvdXJjZXMgdG8ga2VlcCBkb2luZyBzby4NCj4+Pj4+IA0K
Pj4+Pj4gVW5kZXJzdG9vZCBhYm91dCBsYWNrIG9mIHJlc291cmNlcywgYnV0IGlzIHRoZXJlIG5v
LW9uZSB3aG8gY2FuDQo+Pj4+PiB0YWtlIG92ZXIgZm9yIHlvdSwgYXQgbGVhc3QgaW4gdGhlIHNo
b3J0IHRlcm0/IFlhbmtpbmcgaXQgb3V0DQo+Pj4+PiB3aXRob3V0IHdhcm5pbmcgaXMgbm90IGNv
b2wuDQo+Pj4+PiANCj4+Pj4+IERvZXMgdGhpcyBhbm5vdW5jZW1lbnQgaW5jbHVkZSBnaXQubGlu
dXgtbmZzLm9yZw0KPj4+Pj4gPGh0dHA6Ly9naXQubGludXgtbmZzLm9yZy8+IGFuZA0KPj4+Pj4g
d2lraS5saW51eC1uZnMub3JnIDxodHRwOi8vd2lraS5saW51eC1uZnMub3JnLz4gYXMgd2VsbD8N
Cj4+Pj4+IA0KPj4+Pj4gQXMgdGhpcyBzaXRlIGlzIGEgbG9uZy10aW1lIGNvbW11bml0eS11c2Vk
IHJlc291cmNlLCBpdCB3b3VsZA0KPj4+Pj4gYmUgZmFpciBpZiB3ZSBjb3VsZCBjb21lIHVwIHdp
dGggYSB0cmFuc2l0aW9uIHBsYW4gaWYgaXQgdHJ1bHkNCj4+Pj4+IG5lZWRzIHRvIGdvIGF3YXku
DQo+Pj4+IA0KPj4+PiBJZiB5b3UgbmVlZCByZXNvdXJjZXMgYW5kIHRpbWUuLi4gUGxlYXNlIHJl
YWNoIG91dC4uLg0KPj4+PiANCj4+Pj4gVGhpcyBpcyBhIGNvbW11bml0eS4uLiBJJ20gc3VyZSB3
ZSBjYW4gZmlndXJlIHNvbWV0aGluZyBvdXQuDQo+Pj4+IEJ1dCBwbGVhc2UgdHVybiBpdCBiYWNr
IG9uLg0KPj4+PiANCj4+PiANCj4+PiBTbyBmYXIsIEkndmUgaGVhcmQgYSBsb3Qgb2YgJ3dlIHNo
b3VsZCcsIGFuZCBhIGxvdCBvZiAnd2UgY291bGQnLg0KPj4+IA0KPj4+IFdoYXQgSSBoYXZlIHll
dCB0byBoZWFyIGFyZSB0aGUgbWFnaWMgd29yZHMgIkkgdm9sdW50ZWVyIHRvIGhlbHANCj4+PiBt
YWludGFpbiB0aGVzZSBzZXJ2aWNlcyIuDQo+PiANCj4+IEkgdm9sdW50ZWVyIHRvIGhlbHAuIEkg
Y2FuIGRvIGFzIG11Y2ggb3IgYXMgbGl0dGxlIGFzIHlvdSBwcmVmZXIuDQo+PiBBbmQgSSB2b2x1
bnRlZXIgdG8gbGVhZCBhbiBlZmZvcnQgdG8gZWl0aGVyOg0KPj4gDQo+PiBhKSBmaW5kIGEgcmVw
bGFjZW1lbnQgaXNzdWUgdHJhY2tpbmcgc2VydmljZSwgb3INCj4+IA0KPj4gYikgZmluZCBhIHdh
eSB0byBhcmNoaXZlIHRoZSBjb250ZW50IG9mIHRoZSBidWd6aWxsYSBpZiB3ZSBhZ3JlZQ0KPj4g
dGhlcmUgaXMgbm8gbW9yZSBuZWVkIGZvciBhIGJ1Z3ppbGxhLmxpbnV4LW5mcy4NCj4+IA0KPj4g
T3IgYm90aC4NCj4+IA0KPj4gVGhlcmUgaXMgbm8gd2F5IGZvciB1cyB0byBrbm93IGhvdyBtdWNo
IGVmZm9ydCBpdCB0YWtlcyBpZiB5b3UNCj4+IHN1ZmZlciBpbiBzaWxlbmNlLCBteSBmcmllbmQu
DQo+IA0KPiBUaGUgcG9pbnQgaXMgdGhhdCBlbWFpbCBoYXMgZXZvbHZlZCBvdmVyIHRoZSAxOCB5
ZWFycyBzaW5jZSBJIHNldCB1cA0KPiB0aGUgdmVyeSBmaXJzdCBsaW51eC1uZnMub3JnLiBJIGhh
dmUgbm90IGhhZCB0aW1lIHRvIGtlZXAgdXAgd2l0aCB0aGUNCj4gcmVxdWlyZW1lbnRzIG9mIGFk
ZGluZyBzdXBwb3J0IGZvciBETUFSQywgU1BGLCBldGMuIHdoaWNoIGlzIHdoeQ0KPiBDZWRyaWMn
cyBhY2NvdW50IHNldHVwIGVtYWlsIGlzIHByb2JhYmx5IGluIGhpcyBzcGFtIGZvbGRlciwgYXNz
dW1pbmcNCj4gdGhhdCB0aGUgZ21haWwgc2VydmVyIGV2ZW4gYWNjZXB0ZWQgaXQgYXQgYWxsLg0K
PiANCj4gRnVydGhlcm1vcmUsIGJvdGggdGhlIHdpa2ltZWRpYSBhbmQgYnVnemlsbGEgaW5zdGFu
Y2VzIGFyZSBmYXIgZnJvbQ0KPiBydW5uaW5nIHRoZSBtb3N0IHJlY2VudCBjb2RlIHZlcnNpb25z
IGFuZCBJJ20gc3VyZSB0aGVyZSBhcmUgcGxlbnR5IG9mDQo+IHdlbGwga25vd24gc2VjdXJpdHkg
aG9sZXMgZXRjIHRvIGV4cGxvaXQuIFNvIGJvdGggY29kZSBiYXNlcyBoYXZlIGJlZW4NCj4gbmVl
ZGluZyBhbiB1cGdyYWRlIGZvciBhIHdoaWxlIG5vdy4NCj4gDQo+IEZpbmFsbHksIHRoZSBWTSBp
dHNlbGYgaXMgc3RpbGwgcnVubmluZyBSSEVML0NlbnRPUyA3LCBhbmQgSSdkIGxpa2UgdG8NCj4g
c2VlIGl0IG1pZ3JhdGVkIHRvIGEgcGxhdGZvcm0gdGhhdCBpcyBpcyBzdGlsbCBtYWludGFpbmVk
Lg0KPiANCj4gQWxsIHRoZXNlIHRhc2tzIHdvdWxkIG5lZWQgaGVscCBmcm9tIHRoZSBwZXJzb24g
KG9yIHBlb3BsZT8pIHdobw0KPiB2b2x1bnRlZXJzIHRvIG1haW50YWluIHRoZSBidWd6aWxsYSAr
IHdpa2kgc2VydmljZXMuIFNvbWUgb2YgdGhlbSB3b3VsZA0KPiBuZWVkIHRvIGJlIDEwMCUgb3du
ZWQgYnkgdGhhdCBwZXJzb24sIGFuZCBvdGhlcnMgKGxpa2UgdGhlIHBsYXRmb3JtDQo+IHVwZ3Jh
ZGUpIHdvdWxkIG5lZWQgYSBsb3Qgb2YgY29vcmRpbmF0aW9uIHdpdGggbWUuDQo+IA0KPiBJT1c6
IEknbSBub3QgYWR2b2NhdGluZyBlaXRoZXIgd2F5LiBJIGNhbiB1bmRlcnN0YW5kIHdhbnRpbmcg
dG8gbWlncmF0ZQ0KPiBhd2F5IGZyb20gdGhlIGN1cnJlbnQgc2V0dXAgdG8gc29tZXRoaW5nIHRo
YXQgaXMgbWFpbnRhaW5lZCBieSBzb21lb25lDQo+IGVsc2UuIEhvd2V2ZXIgaWYgYW55b25lIGRv
ZXMgd2FudHMgdG8gdGFrZSBvbiB0aGUgam9iIG9mIGhlbHBpbmcgdG8NCj4gbWFpbnRhaW4gdGhl
IGN1cnJlbnQgc2V0dXAsIHRoZW4gdGhleSBuZWVkIHRvIGtub3cgdGhhdCBpdCB3aWxsIGludm9s
dmUNCj4gcmVhbCB3b3JrLg0KDQpVbmRlcnN0b29kLCBhbmQgYWNjZXB0ZWQuDQoNCkZpbmRpbmcg
YSBob3N0ZWQgYnVnemlsbGEgKHN1Y2ggYXMgZGV2emluZy5jb20gPGh0dHA6Ly9kZXZ6aW5nLmNv
bS8+KSBhbmQgbWlncmF0aW5nDQp0aGUgYWN0aXZlIGJ1Z3MgdGhlcmUgd291bGQgaGVscCB3aXRo
IGFsbCB0aGVzZSBpc3N1ZXMuIEkgaGF2ZW4ndA0KeWV0IGxvb2tlZCBmb3IgaG9zdGVkIHdpa2kg
c2VydmljZXMsIGJ1dCBJJ2xsIGJldCB3ZSBjYW4gaGFuZGxlIA0KdGhhdCBpbiBhIHNpbWlsYXIg
ZmFzaGlvbi4NCg0KSXQgaXMgYWxzbyBzZW5zaWJsZSB0byBoYXZlIG9uZSBwbGFjZSBmb3Iga2Vy
bmVsIGJ1Z3MsIGFzIHlvdQ0KcG9pbnRlZCBvdXQuIEl0J3MgdGhlIHVwc3RyZWFtIHVzZXIgc3Bh
Y2UgaXNzdWVzIHdoZXJlIHRoZXJlIGlzDQpsaWtlbHkgc3RpbGwgYSBuZWVkIGZvciBhbiBpc3N1
ZSB0cmFja2VyIGluZGVwZW5kZW50IG9mIHRoZQ0Ka2VybmVsLm9yZyA8aHR0cDovL2tlcm5lbC5v
cmcvPiBvbmUuDQoNClRoZXJlIGFyZSBsaW5rcyB0byBidWd6aWxsYS5saW51eC1uZnMub3JnIDxo
dHRwOi8vYnVnemlsbGEubGludXgtbmZzLm9yZy8+IGJ1Z3MgaW4gdGhlIGtlcm5lbCdzDQpjb21t
aXQgbG9nIHRoYXQgd2UgbmVlZCB0byBjb250aW51ZSBoYW5kbGluZyBzb21laG93IC0tIGEgcmVh
ZC0NCm9ubHkgYnVnemlsbGEgaW5zdGFuY2UsIGlmIG5vdGhpbmcgZWxzZSwgbWlnaHQgYmUgZWFz
eSB0bw0KbWFpbnRhaW4gZm9yIHRoYXQgcHVycG9zZSwgYnV0IHRoZXJlIGNvdWxkIGJlIG90aGVy
IHdheXMgdG8NCmRlYWwgd2l0aCB0aGF0Lg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==
