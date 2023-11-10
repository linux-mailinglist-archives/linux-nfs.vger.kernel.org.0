Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773367E806A
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 19:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344252AbjKJSLl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 13:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345382AbjKJSLC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 13:11:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776C638222
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 05:56:04 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAAWarh006322;
        Fri, 10 Nov 2023 13:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=couNgn0g+s6Ok0y/VJA1cVdmf5DseVk6Z3CpUPREDPI=;
 b=QJfZWx9zU7osDYLKGhCXVmW50WrbvdY+6CFP54frGGVuvc35+HIUTtES5fYPv4ofClcK
 +1OnOr4kb/O2YyvAP7lNsUgMo1Hq41ZF3wfdS+ShuFPaDWFsjeQITev9ovOmixFvc9Rh
 zYAJZ5cZwxbVtetUqAzDuHKvItU1N9nPmiRo3toVLQcMj8iKOliJo7k4lSHvj8JCS9se
 S1Rpn9F1iZovHIZ14awgxP2serOVdJW8urwIsmbjb4ornMEhyoI6p/AIAfQRtOH9ZLCu
 xRr1NvXxqgAbnPp+4VkCycWoPqw/L/4K4WDK+rF6C/+3uAplUnlSCWKOUukpi0ty4lef 2A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22p91j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 13:56:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AACBmdJ010951;
        Fri, 10 Nov 2023 13:56:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1xxg6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 13:56:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cksaV9QjPRCe+3BMicCZQKVVWd4r+62LyCBjCZXUBoNlowCqxiPG6s5KxycTHm0Sb39yG3Q3v7/0HbR0b1wYb3en/7WRqq5S8ZtOUWGy//CELEwX271oXqdc/BMVbaIL74PK5QRRn5u8IenKlb0un+FuZCBe/5UBT1RiJBL+SCU/Zl60/bZUrNAcsPVpqUmkA52QfSvS3vkQcPy2qdM6KXJENatgGRD6PvGBdDZKAHMa2WlVf753jCurm/3sAW2hloP0Swamo4Wl2kTsmQMzxrHi3PjajOXVFXedlEU6R2G93Ko9RE1NLjdXe8XK+dSnojtfSXw95QIJTHbYgrVu9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=couNgn0g+s6Ok0y/VJA1cVdmf5DseVk6Z3CpUPREDPI=;
 b=Br64DXoWDI7sy7jLk4Kh/nrJw9CwwAmGx87tGSyEJZqQGcjyU4dBJWpwFXXKb8nXQ0IhTx+Kf0GVUIcypcIFxO7RJJFnSJD184pClejG94f6a2XHoMWQPDoaS9k8ocuzGq7EkV4QqYGiN15FkhBNSReOn2Ue5UJ0pvknchzsB4ONuZcgnidBPZAxPkOpNEzHDlvR+xyriAz7hg4XRV+odOodt5cLcJ8UZ8lRh9vbcbeJidliPbqxclX2NhvGb11v9ZlkCggAzMa4ZQ85ha6RADMTEve2u0dOY5Vjx0oFxOR39jZNCznxOxCzX/Q/iyX+XZsDtnz/mZuHk6HMD3dN/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=couNgn0g+s6Ok0y/VJA1cVdmf5DseVk6Z3CpUPREDPI=;
 b=V518VBl3Vir13sFl/8Pi+ps0NwVqa0wQPKTSlkytHpT8ETl+Z2jNqKcvaVP9Nuwu41GQsRgJW40nKSzxH4d3AReLe6NUoGuCVXSF0rA5X1dJCUrncZ+Q5spoEPGsyc6j52NOaplHk0YvOsptsFn4Jr6oGFK2zCZjm44o8Ki7Vvw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4865.namprd10.prod.outlook.com (2603:10b6:208:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 13:55:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.6977.020; Fri, 10 Nov 2023
 13:55:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Martin Wege <martin.l.wege@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4 referrals - custom (non-2049) port numbers in fs_locations?
Thread-Topic: NFSv4 referrals - custom (non-2049) port numbers in
 fs_locations?
Thread-Index: AQHaDKK/5xxTBJcRKkGtisdr07fPibBlifCAgA4WNoCAAAHLAA==
Date:   Fri, 10 Nov 2023 13:55:59 +0000
Message-ID: <DFBBA6DD-7F22-4A38-BAA2-DBD40EB81BB9@oracle.com>
References: <CANH4o6Md0+56y0ZYtNj1ViF2WGYqusCmjOB6mLeu+nOtC5DPTw@mail.gmail.com>
 <DD47B60A-E188-49BC-9254-6C032BA9776E@redhat.com>
 <CANH4o6NzV2_u-G0dA=hPSTvOTKe+RMy357CFRk7fw-VRNc4=Og@mail.gmail.com>
 <2EA6162E-1CF9-49E8-8A05-9E5246606F89@redhat.com>
In-Reply-To: <2EA6162E-1CF9-49E8-8A05-9E5246606F89@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4865:EE_
x-ms-office365-filtering-correlation-id: 39eb3dce-4827-4c74-73d2-08dbe1f4c4b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uL/yl2XQ6/UL6nwU2Zzx0rmFxMaVHV5BOZKExn7WnY6rWfhRFaQI2/P+7URy7CHKnO+8u2nOG3KKHniXr8sRPoj9rjr/g8mJzIy9SdZXOy3+5I86GkUaUaMmOy32eQNPBqRHf8Za/yceU2xOu3GJi5XzkgtotRuDX8hzVaRO3mgpyA1eXJGmecwjDAckODA0YSyQK8cHTA8PZpAF72vyaT7PJJi/Um3H7rab36uQmUL2jEJJUnw2ww9Q4Pe5TW3Cb1klr8x6ZS4r35GYUtLJAsgxiTDASwkkm+4LGlyUESVYAONDD2R0acqme7WHet6mIlpdp+f0ppkl1DVY4nSM2UhXbDmqcuAqrE9jOxrBwi7f7yyit+UiNp1FU6oEx1ln6LBpIm6GOS8ypJCZY6jGF2wdGasGd9zXmFlqSnhMnyI6qTUZC2wIXoSBSr3mFcHlBKg5fTDjGZvL31t4spS+lvyTCezbijwgoIpvUD2cX3vS4eEHTgu7J3jgsAG8v8QpEdTZgyE3O00cgxgOOmBkMRhfCRC5+Lx2mgoWpv7ichJTP5lxbkPGL0nfHqs+9IayMuZ1Nv/5EOeVA0fVg/F9UwpiiM6M5r84pi59hmuKCqy5B71wmu0F2Twav4GPRUPzIaBfahv5m6ivZbVMdiBR2koln8otZvsbkiN1OkqneIo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(36756003)(71200400001)(8936002)(38070700009)(122000001)(91956017)(316002)(8676002)(54906003)(66556008)(66446008)(6916009)(66476007)(66946007)(76116006)(86362001)(4326008)(38100700002)(478600001)(64756008)(966005)(33656002)(6486002)(6512007)(6506007)(53546011)(41300700001)(2906002)(83380400001)(26005)(2616005)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3ZQSHJHLzM4ajNDRS9PSDRMNEZYQ1p4clA3b01HYkhtc2tMZzJpdW1QQ1dR?=
 =?utf-8?B?SUc4VkRFMENCMGpxMEREKy82cjZLVE5RSHJMK0xkem5DMU56ZnNrbk1oVzRS?=
 =?utf-8?B?VEFua2ZvdUtEMUlPT1ZGTGY0cFBzdmh2clFPSlp2dHNYZVRZTFdudWxLdyty?=
 =?utf-8?B?Sm0vZTdWYkJpckFmQk54dE9zcE9yRHVPM2lka2U0OXpTdTNpNHk4OW04WlU1?=
 =?utf-8?B?K0Exbk5vSjhmUkNLbHM4cHJIdklHN3p2NjM1cUZRN2tEYjhadmR3RXA0VlMv?=
 =?utf-8?B?eE5nNDB0UFFKNlRzbWdBVlZxdkM4MVU2MkI5SmpVMU9ZYWh3UzN0dG13RGtX?=
 =?utf-8?B?TVVYMWxhSFd2OHpBUHVkNkdmU0wvMFBEc2FFaHc5VExjcFpRQXg0bWtCd0ZR?=
 =?utf-8?B?NW5PZm1WYzhjczRYSXMxZndSUVkxY0laU2hxRjdoVmdESFVsRjBEcmxGMzZH?=
 =?utf-8?B?eVlHRlZ0ZDJLaGVzNG1FOEpXaFZIUkk1TTFaVncwbUNkZkVHYjJwZEtvZzNP?=
 =?utf-8?B?bTBFZUlGUzNKQjZYeFp3YkN1Q0J4Qys1TjUxNEN2empjM2o0ejhqYUN1cjgy?=
 =?utf-8?B?Uit2QUhGODQ4alorRThBaWZVQnJHdUh4bGcrODlTT1RPTXVwTjdZcTdaY2VT?=
 =?utf-8?B?ZVZDM3drOUNHYXB1ZzZzOFM0ZmtlQmd6U2dWWWg5T3lFZDBtbG9iaVc2K3kw?=
 =?utf-8?B?ZGZGVnNsbXpQWTF6QkNUQ3VLWTg5dzMrOGlXNUZxUkVvY3VHbUNlVVFrUE1B?=
 =?utf-8?B?VDJaZkJWbyttQUZIQVlRdHQ2bjBMeUxRSkgzUFNrRm13WlpJZlhUSlRFaS9R?=
 =?utf-8?B?Tm1NbXpzTTBaaDJ0MWZLZStHdHc1Y1ZUdmNMa1g0QmNBL2xGc21RdzVEVWJP?=
 =?utf-8?B?NTdxbFNOdGdhSXkxWmdKRURMVHp2NGNjT1c0NCtVS2RKSUlaa2hVNStGM0Rv?=
 =?utf-8?B?MTdHUURoL0QxcWxBWURENzRLVG5pMi9NYlI5ajB4Y0hXaThaT3ByNTRDMEJv?=
 =?utf-8?B?VFgrQXgzUGFLOGR2V1hYUml5dmxqZmJYQmlqNWVBcDlibFpsaGtGUXZKNm82?=
 =?utf-8?B?Wnl5eDQ0UkJ4RVMrZmxtR1F4VjJJTUY4a3U1SHY1Vk94QWJYbytOVlBzdml6?=
 =?utf-8?B?Nmd0M1pXS1JGY1l6ejc0NlZpMHFPNXpseXlxNGUwRDRIRDJoUmhEU3VoNDQ2?=
 =?utf-8?B?c2pCcG5XUmdQUldVcGNpbWZpTWR0RW1JTitHVTZCTHlWNjNjT2xyN3JQNExu?=
 =?utf-8?B?UXdRdGxKbnoyYktXcWZpTHhJeGVzSkJqMmlycFp1MVRwd2pyQzNOM0M3NUdO?=
 =?utf-8?B?Qkx1VkRTU3hWU21PU2lYQTlmUlVEYm5OOVc4MjM2RWdYbTVzUWladEppU1lI?=
 =?utf-8?B?Nk1UbllPS21JVGJteHdUNmc2UVA1RlUwSjl5c3pHdzRucnVHRVllcmUyRmp6?=
 =?utf-8?B?RmYvRjBaRWdmaDBUeU84QktTUDVoellZMXN0dkRYYVZidkczNkd5Q1lQeC90?=
 =?utf-8?B?UVhHYWVsdURxeFlyYTBBVStaVHBpeCtib3g0VzJwTU15MDJIaUxHQ2dpcFd5?=
 =?utf-8?B?ckhLa09EYUFUbG1DMVkydW9ReU1rbmZJV1VsMkhiNERiWjZ0bWtWbUdDWG1I?=
 =?utf-8?B?SVBXTUNFbWpMckRZcHYrTmJTczZqb2dha24yUGthdmJGbWlPRGdtQnBzUndn?=
 =?utf-8?B?bHRkZWVhNUEvMW5HVWdheFgwbXBVQ3N0bXlzM1pwRHdkVzh3ZE9tT3hjOUpV?=
 =?utf-8?B?TTlpQVlkMktmNWJ2NUhHMGdVMmtiNzNmTlFUeVpuWmszbCtrbVAzNGRnOWJT?=
 =?utf-8?B?enMxYnFUQ2V1L2Q1VjVyZ3FMYjBadUZjdkxybms4ZFk1ZVgzeFlGVVJTQjVR?=
 =?utf-8?B?RVFmclBoSDdwY21SU2VPL01rMUVKc2pCT0Q2SGJYUnI2Tm95OVN5TjQya1hM?=
 =?utf-8?B?VGNVYU9YeFdjNElKTVhWY1VPUGREV3hxU0ZVaGl5eXZZckg0QXN5U3lNeEFH?=
 =?utf-8?B?cEhpWGVlQ3FtWHFMWnYzSkZTRS9jZEFCbENvT3h5RzRXb21oaDBzYlFoZGdj?=
 =?utf-8?B?S0dWajVYTkhWdWcxcXRraSt2dTMwbDlLUXVFQmREVTFRSDBEVGE4d2k3L2ZK?=
 =?utf-8?B?TVd0MWp1QkFxMGltYTlqZmxIMGY2NVgvSG5uUk9sdGxZdXAwVXRnWjVqQWlT?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AC9533E4601F44CA3441DCF1D400A2A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UR0r1KorEsyCzALyz4NUKXahZvnJJ59WS9sBb6WozedVDMkVW7xuaEemBW10Z0EZrLXKhe1TJ8UVMLg2GIv3dScRfsMsKM8Llm/RUoFuBRMUJLdD4VJbdEtSR2pJbsPHmZGMJ1xp6g/lBJwIH1KxiecsBSroxNAgeplRkGzxivtdwJAbTA/8j+3oi0pzy1YVQCXv/aqlsaKM04n423PwVe9p0pl53g6Z9V751Eg+5hAOLI8Mm76vrVQ5ZznWBqiWm1UcvGsmiKso+aM2riCzM6r9ZvHNZDNY80Lb8k+LQRdke2t+UEPZ/UCgFpjHfTB3exa7MJ0xMydFKChidvijmGJd9gwpdmO6MNLT5vxdh5iJ155K4WvyyzAAj20NOYQXkT5I7piV+iJGACWZRlg8FH74ia7AIxbTzn7B//AWeZs5CjKNzigOupKD91aBmElSLjSvUh5eZV8V2fVQGA6MYlfs9aEj7IBqSPDUCffEhmkeivmGVTWzSHzV+QWvnnacA9l6gqiYv+lsXJOKx0EOHidwaHRf8SCi4Zm5apxEEpWGLpAJ3+fBb0s2UrCR+SoJuxl8j5idI67MeYjw5JYAxCxZdXPyh2Wk1fnGPXyHIdM+ASu1D6RFzVpkpAW+v48fKeb4cYuLIcFt3FoVVZzEaKwbbjdJP0/gk8T2JeJ8AtfPiZRRoZV47hN87SGqMnRcVbvbtBezWYbX5BWHe0u3v9Y4Lcu8OlCi5KnhshTQJc19NBL98iXkjLw6HKX+2ZOklwjtbulN9d0tb9pkKsM42z81q8PDlSD97/2ZfykttMpe7nLgoHV7xPnRrVTJ4GLG
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39eb3dce-4827-4c74-73d2-08dbe1f4c4b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 13:55:59.1668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9KFAqOL0pa8YEH7CDJG61KHfNFKIKFdZDxAFRAtAmRQ6GIhnQRLPD8xoeDurRGkG/5lSb+tDf0aFj/MkVVq5hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100115
X-Proofpoint-ORIG-GUID: pZFKx-_1bneQ2nK2RoxmYeRErrVqD8ds
X-Proofpoint-GUID: pZFKx-_1bneQ2nK2RoxmYeRErrVqD8ds
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IE9uIE5vdiAxMCwgMjAyMywgYXQgODo0OSBBTSwgQmVuamFtaW4gQ29kZGluZ3RvbiA8YmNv
ZGRpbmdAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAxMCBOb3YgMjAyMywgYXQgMjo1NCwg
TWFydGluIFdlZ2Ugd3JvdGU6DQo+IA0KPj4gT24gV2VkLCBOb3YgMSwgMjAyMyBhdCAzOjQy4oCv
UE0gQmVuamFtaW4gQ29kZGluZ3RvbiA8YmNvZGRpbmdAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4g
DQo+Pj4gT24gMSBOb3YgMjAyMywgYXQgNTowNiwgTWFydGluIFdlZ2Ugd3JvdGU6DQo+Pj4gDQo+
Pj4+IEdvb2QgbW9ybmluZyENCj4+Pj4gDQo+Pj4+IFdlIGhhdmUgcXVlc3Rpb25zIGFib3V0IE5G
U3Y0IHJlZmVycmFsczoNCj4+Pj4gMS4gSXMgdGhlcmUgYSB3YXkgdG8gdGVzdCB0aGVtIGluIERl
YmlhbiBMaW51eD8NCj4+Pj4gDQo+Pj4+IDIuIEhvdyBkb2VzIGEgZnNfbG9jYXRpb25zIGF0dHJp
YnV0ZSBsb29rIGxpa2Ugd2hlbiBhIG5vbnN0YW5kYXJkIHBvcnQNCj4+Pj4gbGlrZSA2NjY2IGlz
IHVzZWQ/DQo+Pj4+IFJGQzU2NjEgc2F5cyB0aGlzOg0KPj4+PiANCj4+Pj4gKiBodHRwOi8vdG9v
bHMuaWV0Zi5vcmcvaHRtbC9yZmM1NjYxI3NlY3Rpb24tMTEuOQ0KPj4+PiAqIDExLjkuIFRoZSBB
dHRyaWJ1dGUgZnNfbG9jYXRpb25zDQo+Pj4+ICogQW4gZW50cnkgaW4gdGhlIHNlcnZlciBhcnJh
eSBpcyBhIFVURi04IHN0cmluZyBhbmQgcmVwcmVzZW50cyBvbmUgb2YgYQ0KPj4+PiAqIHRyYWRp
dGlvbmFsIEROUyBob3N0IG5hbWUsIElQdjQgYWRkcmVzcywgSVB2NiBhZGRyZXNzLCBvciBhIHpl
cm8tbGVuZ3RoDQo+Pj4+ICogc3RyaW5nLiAgQW4gSVB2NCBvciBJUHY2IGFkZHJlc3MgaXMgcmVw
cmVzZW50ZWQgYXMgYSB1bml2ZXJzYWwgYWRkcmVzcw0KPj4+PiAqIChzZWUgU2VjdGlvbiAzLjMu
OSBhbmQgWzE1XSksIG1pbnVzIHRoZSBuZXRpZCwgYW5kIGVpdGhlciB3aXRoIG9yIHdpdGhvdXQN
Cj4+Pj4gKiB0aGUgdHJhaWxpbmcgIi5wMS5wMiIgc3VmZml4IHRoYXQgcmVwcmVzZW50cyB0aGUg
cG9ydCBudW1iZXIuICBJZiB0aGUNCj4+Pj4gKiBzdWZmaXggaXMgb21pdHRlZCwgdGhlbiB0aGUg
ZGVmYXVsdCBwb3J0LCAyMDQ5LCBTSE9VTEQgYmUgYXNzdW1lZC4gIEENCj4+Pj4gKiB6ZXJvLWxl
bmd0aCBzdHJpbmcgU0hPVUxEIGJlIHVzZWQgdG8gaW5kaWNhdGUgdGhlIGN1cnJlbnQgYWRkcmVz
cyBiZWluZw0KPj4+PiAqIHVzZWQgZm9yIHRoZSBSUEMgY2FsbC4NCj4+Pj4gDQo+Pj4+IERvZXMg
YW55b25lIGhhdmUgYW4gZXhhbXBsZSBvZiBob3cgdGhlIGNvbnRlbnQgb2YgZnNfbG9jYXRpb25z
IHNob3VsZA0KPj4+PiBsb29rIGxpa2Ugd2l0aCBhIGN1c3RvbSBwb3J0IG51bWJlcj8NCj4+PiAN
Cj4+PiBJZiB5b3Uga2VlcCBmb2xsb3dpbmcgdGhlIHJlZmVyZW5jZXMsIHlvdSBlbmQgdXAgd2l0
aCB0aGUgZXhhbXBsZSBpbg0KPj4+IHJmYzU2NjUsIHdoaWNoIGdpdmVzIGFuIGV4YW1wbGUgZm9y
IElQdjQ6DQo+Pj4gDQo+Pj4gaHR0cHM6Ly9kYXRhdHJhY2tlci5pZXRmLm9yZy9kb2MvaHRtbC9y
ZmM1NjY1I3NlY3Rpb24tNS4yLjMuMw0KPj4gDQo+PiBTbyBqdXN0IDxhZGRyZXNzPi48dXBwZXIt
Ynl0ZS1vZi1wb3J0LW51bWJlcj4uPGxvd2VyLWJ5dGUtb2YtcG9ydC1udW1iZXI+Pw0KPj4gDQo+
PiBIb3cgY2FuIEkgdGVzdCB0aGF0IHdpdGggdGhlIHJlZmVyPSBvcHRpb24gaW4gL2V0Yy9leHBv
cnRzPyBuZnNyZWYNCj4+IGRvZXMgbm90IHNlZW0gdG8gaGF2ZSBhIHBvcnRzIG9wdGlvbi4uLg0K
PiANCj4gSnVzdCB0ZXN0IGl0IQ0KPiANCj4gSSB0aG91Z2h0IHRoZSBuZnNyZWYgcHJvZ3JhbSBh
Y3R1YWxseSBwb3B1bGF0ZXMgdGhlICJ0cnVzdGVkLmp1bmN0aW9uLm5mcyINCj4geGF0dHIsIHdo
aWNoIGlzIHBhcnQgb2YgdGhlICJmZWRmcyIgcHJvamVjdCdzIG1ldGFkYXRhIHRvIGxpbmsgZmls
ZXN5c3RlbXMNCj4gdG9nZXRoZXIuICBJIGRvbid0IHRoaW5rIHRoYXQncyB3aGF0IHlvdSB3YW50
IGhlcmUuDQoNCk5vLCBuZnNyZWYgaXMgd2hhdCBNYXJ0aW4gd2FudHMuDQoNCg0KPiBDaHVjayAt
IGFtIEkgcmlnaHQgdG8gc2F5IHRoYXQgdGhlIG5mc3JlZiBwcm9ncmFtIGRvZXMgbm90IHBvcHVs
YXRlDQo+IG5mc2Q0X2ZzX2xvY2F0aW9ucyBvbiBrbmZzZD8NCg0KbmZzcmVmIGlzIHRoZSBwcm9w
ZXIgdG9vbCB0byB1c2UuDQoNCm5mc3JlZiB0dXJucyBhIGRpcmVjdG9yeSBpbnRvIGEganVuY3Rp
b24gYnkgZG9pbmcgdHdvIHRoaW5nczoNCg0KMS4gSXQgYWRkcyBhIHRydXN0ZWQuanVuY3Rpb24u
bmZzIHhhdHRyIGNvbnRhaW5pbmcgdGhlIGluZm9ybWF0aW9uDQogICB0aGF0IHRoZSBzZXJ2ZXIg
cmV0dXJucyB3aGVuIGEgY2xpZW50IGRvZXMgYSBHRVRBVFRSKGZzX2xvY2F0aW9ucykNCiAgIG9u
IHRoYXQgZGlyZWN0b3J5DQoNCjIuIEl0IHVwZGF0ZXMgdGhlIGRpcmVjdG9yeSdzIG1vZGUgYml0
cyB0byBtYXJrIGl0IGFzIGEganVuY3Rpb24NCg0KSXQgaXMgbW91bnRkIHRoYXQgdGFrZXMgZWl0
aGVyIHRoZSByZWZlcj0vcmVwbGljYT0gZXhwb3J0IG9wdGlvbg0Kb3IgdGhlIGp1bmN0aW9uIHhh
dHRyIGFuZCBmZWVkcyB0aGF0IHRvIHRoZSBrZXJuZWwgc28gaXQgY2FuDQpjb25zdHJ1Y3QgYSBH
RVRBVFRSKGZzX2xvY2F0aW9ucykgcmVzcG9uc2UuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K
