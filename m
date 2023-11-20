Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00EE7F1DEB
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 21:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjKTUTn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Nov 2023 15:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKTUTm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Nov 2023 15:19:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50071CB
        for <linux-nfs@vger.kernel.org>; Mon, 20 Nov 2023 12:19:37 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKIn3fl012401;
        Mon, 20 Nov 2023 20:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=c9nUXbjkInC6ckfJYtInKi5zgP6V07aFlEcRYMl8yRg=;
 b=zFTMLHwsHc/aaBTld+GOxodji2BW6E2wr9Sgg4ghX+ypsoi9VOGIEhX1x8Q6VckU74wK
 /2vCleySv3dD9oNONXTx0xObIUqoqAnwU3GMnzXOfzNljDy5EilHLkwGnQ1iYzIgfcpy
 U4pxZidmsWJyGg5JvGKnVF/Xoe6syzvBSl6KdLjddrLUuwFyZ77B/gqebjmwYdpKqMUb
 6H/Df4cx4j5pyzkub8uN41Ubp8/s10GfO4gvVHX4StKjv9vSQHZZJ8DUsPA8jDdgjc1E
 zZPZj6Dd0wptqEs5z5bu/rBRdgVbZJdpPRl/Sp8RSYzbQhjPED+vcEt/S9Zg5RXke/O0 +Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uemvubhem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 20:19:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKJoTVM037636;
        Mon, 20 Nov 2023 20:19:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq5wn43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 20:19:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKtzP/wpj0VGIU9XfLqixTe4UAGBEE5THaTQdupHqO6naKeHm+dQ00ESnE08qdyZxVkLHScmj5FomcpHg1gSVfwRFgGkxaf2+8Yq5VDNR7d7SmjfnDAYlqO3dGq+7Lhb810CFrDH9PW+UOx6ltd6Qgyax2Jt6b1WHCmy20V1vz5AJVjipqK/8xvas2zES9uLa2MZMfjzLEMGNPFfIgHQxzaJRAxJRatZ1nH0oTDuyQbi9L3ozmWpog2dL1VVcUSr2fIWaJc1uT14It4gWubrGQSldFQRbY9tKxwOTx5hG5ob4yohYm7LST4HAYGzd5AL5nT+X3YPX+wp4cafjypPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9nUXbjkInC6ckfJYtInKi5zgP6V07aFlEcRYMl8yRg=;
 b=AlNsjqgmOw0jkrTSypROq3qHaHIk0KiVKmwjZpxR4sIX/yVwrTJ2RZ5qPW8Y1whvcpCzB4CJ0zzsAkU5TRtb88pEVLiZUlLzwmfzyGg/exCgZGMkt+LSZXttyNS1RlUF15paj5WERZ4MevxXJsx06Q3fWjc2dL8sRfHvnZZgnOdXgr42vut26OrAhloc3rqN7P2hb2ruT6mjn3IAWuD0Bq3Ym80m8Tm0jSB5PhKhYCH5fN8oetRMnShA+1xeyRpl4vYWJz93F2z5qbF1kzJ7sxv9wxlZWswnUOOIfLn6fFjlXBdxibw8DsC+Wk3LehxJmNCyCNzTMHrtQUnyDP81Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9nUXbjkInC6ckfJYtInKi5zgP6V07aFlEcRYMl8yRg=;
 b=bk5S8GsFXvYjMqOa64rQ6HT0Fav+4kxm1ZyIAlJ1I5FoklNq7IiCLnRRc48apqP6+8Ti88+g63/ZgXMPr/I6R1+60lTIc9ZVksetTcSFkwnSWONDAaueugLzYhgDG5HCBTkNt7UsmIoF5UahYMthwr7kW7+3t7apCQYq/Ewxfx8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4875.namprd10.prod.outlook.com (2603:10b6:610:de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 20:19:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 20:19:31 +0000
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
Thread-Index: AQHaGSnEPMpWeNwF5UG1EZJYD3+ecbB/omOAgACniYCAAAIOAIAAA+qAgAA+NgCAAc04AIAADi6AgAAPmgCAANKjAIAAX58A
Date:   Mon, 20 Nov 2023 20:19:31 +0000
Message-ID: <B9DFA4B8-D118-477A-9A47-9162A595104F@oracle.com>
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
 <AAFBF47A-A9A6-408A-BFB3-2F21071EFD2A@oracle.com>
In-Reply-To: <AAFBF47A-A9A6-408A-BFB3-2F21071EFD2A@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB4875:EE_
x-ms-office365-filtering-correlation-id: ca5f8cbb-5e6b-422f-c117-08dbea06013d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WMv8IrxIJUrnrvXHa4IDPvy2dtdfZAWX4jy99qjQyo8aD7lOkYuas1VL3HGXpx1bp6sjbAEjJSIv7RZnnz+b1kz1SdJ5q9Wlo3PBY5EZEWaH+eSAPkSVSpZ5IE7bca4p+Y4fL5ajpheSfGU+p85YyjGI6KSeDuiqT5gmbKb74UjzsV7s3Zs2RRMgK38IHw1y0EGpi8XuajktRGh0E+xrk6EKLnHooTHcxODr+PjnqJ1YFfqPCoC/iLZEcEWDJVPtCx86WPFFfUbXZ0bRdqe+yyQVlwaTejUtmpz81eh2by7NPNoFt4RFvrBOMRMPybTZiOW/ptEgYJeoZv88PP6Vo5xxu8g2sDlDQQxfY3yz1Ja1OPwCPFt9p02+vin1uyEnpoMSCaDKv6sL1vdYw/gyMTyYSq5/XdBPRkGQ+toBX1y99uM7jt25o1/5wzF2Iq7yVhjHIpULmwwEC4MLsCXelT8XL4pnM+JupnZe9MwVMIGG0bQ37wEWsPtwU2RtXN/m4WyBa/pxHx/no690C38+Vvqf1byrIocz0Ryqwz35kJwxiOOHXPY8GBrL8xTa/86TjTNwbwDBIHeKbbjlhvfOzpLuAxJIUMswLueta3dz0iDbSHP1EHn0SGckSTy4irF34BSAVWIrvy2R1gNwotH6Ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(36756003)(86362001)(33656002)(5660300002)(4744005)(2906002)(38070700009)(6512007)(26005)(2616005)(478600001)(71200400001)(122000001)(966005)(6486002)(6506007)(53546011)(38100700002)(76116006)(91956017)(4326008)(8676002)(316002)(8936002)(6916009)(66556008)(66476007)(64756008)(66446008)(66946007)(54906003)(43043002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFBHZk1sSDRsVUROSGFOQmxrVGFVZ0NhVWJmZzZNZWNRTklKMGFkWlc0NHl2?=
 =?utf-8?B?M1B6cXppQU5TVjRxUEdwRklScTBKNjk5RHNDakJXbkxvd1RpdytHTnN0TlNE?=
 =?utf-8?B?WmNmcXdvbjMvSkF1MFdXV3htVTFvaHRMcTdtZGRubEprdjJoTUhqSjJFOUFS?=
 =?utf-8?B?ZWRhZVBtVDdobkkva3NPN3hBN0l2YU1majFHdnpFZEZ2VnEzS1U5bk9vTlJq?=
 =?utf-8?B?aCt5Ym9WdUNBQ2pzcjU0QitpVXVZQmhQcGhUNEwvMUE0M21EVjkyZU15aWFu?=
 =?utf-8?B?RUw5Sm5jTk9xaWJIMFhXSCtxVW9jemhiRVVmZk9qUlpzK2prb2g4UEJ1U1VZ?=
 =?utf-8?B?L2IrUVBjMVFTeWU5NmFmNVcwN0pPZkNuY1U1d3NrVkJjUFdHakdGLzFVRVBt?=
 =?utf-8?B?ekNJek9jT1RWenF0c1kzQVkvNUMxVEZJR1ZOTTMrTjJGbG42UFVRMTdUc1Ey?=
 =?utf-8?B?cEp1b1l6RzNqT29KRGppVnJSbnJyaGtaWk5SbTFXbEZhUGlaS1crNFp1RzZS?=
 =?utf-8?B?d0VYYUdwYmVtbEpZaTAwdjVyYjVPeGNaZnl3WkNwN3VNT3FBV2svUnVYYTBG?=
 =?utf-8?B?VEZUdHduTytUNUZMd0dRS1h4a29NVGM2dmI2SmlRdGRTU2xhNTZFWmFEenEv?=
 =?utf-8?B?TXBqandXRVBvQkN1TXkvYTU1VGJMNWpGOXJTNHd2YXRsekxmK0tGTFJNMVFL?=
 =?utf-8?B?RUxTaUc4Q0NKNktMbDFTOC9GUmJBWmFkL1ZOWUdLeG9yTHY3Z2U4RVBUcksx?=
 =?utf-8?B?UXJFVUEvWmRvRXJZdzZ5NnJuVktnT3VicXM4WUhIeDZ0bDFwRDdUazBJd3Z1?=
 =?utf-8?B?Uk0rNm10ZC96cGZmYnQ4NEYyaWlVaHBGQ25UdkRlV1lESmo1R1J5NFp5bCtX?=
 =?utf-8?B?di9EQWdNTVdha1lFN3RERUZ6L2F3aVM0ZkthaUg1ZHpIU216bFhycjhoVW1I?=
 =?utf-8?B?VkxrcnQ2RW0xS0MrVDRzNTIvOGZMcXVzdzk3S3laeFlOMEpVc2pxRm00UzNv?=
 =?utf-8?B?UEJRNnoxdlRPNUt5UUZhU2hrR1daaUFvZkNJSWJGU0ZnKzdrUkVGd3NJaGZn?=
 =?utf-8?B?b0FHUDgyTU5OYm1tUXVqZjNDTTMwVlRzZzdnWmJndmlTelFKb1lLcjRqelBy?=
 =?utf-8?B?bVVtK1JJVElVZjBSMU1jSStIMEtJOXVXK0VSQjVaUy8zNldGSkJMMjdpQ2ti?=
 =?utf-8?B?a1ZjeEQ0em8vN0tLQ2FJOWY3NGUvRXFsRkFPRUsyUjRvK3VaeGVIS0xDdWVs?=
 =?utf-8?B?UXMwVzhJTjliRU1KcW1ta3hoeC9TdDNxQStaRWRBRUFiajdLN2dHWjFlRmtx?=
 =?utf-8?B?Qk9kQXVUbnMxYVgwcnRTb2NjSzNqSFM5dGRmcEFvSUVjVXBSM2d0MWg1Tkxy?=
 =?utf-8?B?MzkrcVVoazZZWWtXUXNwRHlTOEMwMnFzcGhzUWYxODIrY0llN1MrYjZyZXVp?=
 =?utf-8?B?N3pxaWFyTWpTcTN6SXhsT1dhKzdDeDc2cGNId1MvTzRjYnZRbEdZbUZDbFkv?=
 =?utf-8?B?QXNVOWZtSFR6U3R6YnpXK3Z6WkRHaC85ZzJkM3ArbFQxN0t5TVUzMjdtMHI5?=
 =?utf-8?B?S3lpNDZtekxKcE1CUTFDUW9aYm1VbTVCRXk2djF3eC85M3BkUUpuWUxtY3hW?=
 =?utf-8?B?bUNtMDF6Mk5yNjBEbFh6cmRwSWg5YTRLTmF1Vnp1WkZKbEwzNlM0MXpSaUsy?=
 =?utf-8?B?V1FZZXlNcHRWSGNnN0lQQmFWOER1bktDL1JrZEF1OUNGaVpnTHc1czMrSi9G?=
 =?utf-8?B?TUdyQVpHV044aHJTWjhsNGUvN2F2cTJIcmZRTmFqbWp4ek00MHgrV2pkQjRJ?=
 =?utf-8?B?WDVSazVjelpPQUJrYjJSSnUyQ3VQakFjQ0hVZ3RlREJ1clQzMHF1cWdIVnFL?=
 =?utf-8?B?WWg2dWZMRUdKdkpCMXB1RzJrZ1VFcENPL09sUXhXOWMwMXpzUDE0TW9WdU9w?=
 =?utf-8?B?L2Rmc0RpZGdrM2N4bzY3YlVtS1RkckhYSmJlanVKQ0IxZ0dpNS9adjNaVmdj?=
 =?utf-8?B?VkVZdHc4UnMyeWsyaXFIczJBTjBoZGlDM1UvcGpISGNtNkNPOEFDcDhuZlpj?=
 =?utf-8?B?ZGg1WW1mdUYrQ0F6OUJ2MFZ3bkw3VWI3K2RIemI1VXNZaUJXY1Fjb2JSenFU?=
 =?utf-8?B?aW55OVAraVE2aHRpUFlVZFB4aS92OVUvN3VJQUZ1aXR6citiamc3MytQck5k?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <218916289146B544A2C2BC0D1C511389@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: shBwKaFpBxk4vODzDWUTQ9tRecyceaZf51Ss9SxH9cG89xSSuuLIprnX8VCzXWfLbgY06jG2k/XVNWLaRsoyFm5Tn3k5q0DCBVomQCR3QwQhnT0q+VGWbQy2umN/bsRX23mV6Lz2ATosq0wzySBAzZh1M7HTScqm5mljM9AaoN+CEevZJ+FSVtaMQ6R8nm0hl8yo2Kjek2S2fIZ7IyokZWNpXJ4ptY3/weciWQHUX85C1pIjQ8Xoal3d4V/blXQWDRbOMummRQHGgZKZQuCD8xZHatzkFTRct2KWKlC1F7Ea7+GlGQeQ+/fhrVYeV+Pc+kdWW5k1IyJFAEbxCdnslkPsB7qRygFrJima5xW4Au++qxKX2Vy8KPFuYYpaUKXggGD2dnxHmY8t6iVnuDQVd+r4FPfv0Ln9nr13etfYkx/6Q7O3gSu+u3QAVveWIlooNlgVX/0Ohq/BuPLOdgy/J7xpZ9X7ZmRCtztAMlHF1NgZ8wtORsjXvgioi/dVu1GuljQYPIliqeoi9bLUJ/Go3ltRxYPm9o5M58y3WDW9JdinIXxL9rT7X/sg25fY5GKb0DtuPi+Y/dwQHUx0OoAW3Nyk5OxoNb18sjl3hBvT5BrKAMGxJXYPZWMTuCjhOcQzNLeIxFXWsqCRc3diXJ4P+1sVbeIDWc90Xhdzo+qAcQdsLMZdIlwzpN97ecxLXZWRL6+EWqqxqAOdWVvJElWO6/suudnxkBdE1Wb7cqaHSxBskVKv7be6kFerCJGwvY5TBX4OYuFAepqO9uOtpn82srbS2o3gykeqB5v/25zaumqVTbyzetGptCo2H+NPWg3hWC5QQLgWv6itB10DvyG7UQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5f8cbb-5e6b-422f-c117-08dbea06013d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 20:19:31.4217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34Yka0vrQFse2XBir/LreigV0RehEZRKv14ukQzyjLZmQTs5+PnRGArv9KkL1LkAQiGUz6dnW7yhqtWWP4aLyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4875
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_21,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200148
X-Proofpoint-GUID: zLFIQv3thr5NNiarQm2N14cpxhV4KkuO
X-Proofpoint-ORIG-GUID: zLFIQv3thr5NNiarQm2N14cpxhV4KkuO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IE9uIE5vdiAyMCwgMjAyMywgYXQgOTozN+KAr0FNLCBDaHVjayBMZXZlciBJSUkgPGNodWNr
LmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gRmluZGluZyBhIGhvc3RlZCBidWd6aWxs
YSAoc3VjaCBhcyBkZXZ6aW5nLmNvbSA8aHR0cDovL2RldnppbmcuY29tLz4pIGFuZCBtaWdyYXRp
bmcNCj4gdGhlIGFjdGl2ZSBidWdzIHRoZXJlIHdvdWxkIGhlbHAgd2l0aCBhbGwgdGhlc2UgaXNz
dWVzLiBJIGhhdmVuJ3QNCj4geWV0IGxvb2tlZCBmb3IgaG9zdGVkIHdpa2kgc2VydmljZXMsIGJ1
dCBJJ2xsIGJldCB3ZSBjYW4gaGFuZGxlIA0KPiB0aGF0IGluIGEgc2ltaWxhciBmYXNoaW9uLg0K
DQpBIGNvdXBsZSBvZiBpbnRlcmVzdGluZyBob3N0ZWQgd2lraSBzZXJ2aWNlczoNCg0KaHR0cHM6
Ly93d3cuYTJob3N0aW5nLmNvbS9hYm91dC8NCmh0dHBzOi8vd3d3LmVkaXRtZS5jb20vYWJvdXQN
Cg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=
