Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B177ACB51
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Sep 2023 20:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjIXSZF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Sep 2023 14:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXSZF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 24 Sep 2023 14:25:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FE5FB
        for <linux-nfs@vger.kernel.org>; Sun, 24 Sep 2023 11:24:58 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38OIMYWk013924;
        Sun, 24 Sep 2023 18:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FWgYtTDXLdYdczOJgPp1EsSNg1pWEgGagsdSOXGT5xY=;
 b=OUCERKWGI4kWlp4UXdiLYiAhlNS+UJsrazQDZJP4B4XitRvkABab/Jb5on9krD0pccV6
 cPWGhzohoLwwEIOP8T1hymVQ2TXE1ZR1QskdmGQ/SWYgoRJWl/ViO/RXCCcZAdIf+AzT
 846mtV+0bhdUwoboN3/fK0UABrLrmY1P0RiTYnLUA3qlOcNsn4JjjD/G8QAA43u1P5e+
 gKRAdkQ7FdUIea34h2bH01SePiWbFMCierD3K/U6PFI3ENEYvdtN+ipEp6pQLIUFFhp3
 DFDHYcXHvruFAIisl86AM2y+oWF5I5E6VVm5ipp4X8OWdDyyN034WEa2dTfMpnHLlbQv Kw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwba52f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 Sep 2023 18:24:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38OD23ee034932;
        Sun, 24 Sep 2023 18:24:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf3u5b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 Sep 2023 18:24:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtnxnZiqw12rr5GO+YJOdLSd1c5CjBL4n7e8xagez/Jjfi3AOWPnUFqi2YJxCB4eo/dXg2er7OU9atlcfVzBfqIprqI4YIt4KSrxLhacCo7bhXWzMyhgVpCkESrSms57LJ24sFWtv5IGeV/APyipZ/6yiiDlK9zVv8Svbky5/CZE3IvUcBxZefbMQkoN56wVSJ5As9aSBxPv/KywUHqsNr56fuaNyPxWhosCrbMvqo9Z1/Rh8ldZfuH+7AZsRq4ujclAl8MOvMS1tOaPVDvrrkXzcy+6vstpQUUfQWR9EikLxFhKPjWQ3Rc+B8vsGcVo/JLQ7RDEFXTpwcCo7CNJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWgYtTDXLdYdczOJgPp1EsSNg1pWEgGagsdSOXGT5xY=;
 b=HWGDKxjG9HbaHrUjH7LUj4Thmo+4Gox3lq8ntjstzJbzxI87uT82kSNtCtElj6dtC1dJUfXLUVX1qrpI6uJa6PCjVR9ZJYt89GLvFfd15+IxIREVPM3J7HOtOhkAkVGp736nioye55nLey+9QcNkEhqEgLSKaKZlD2tM6uU9s+F2ytmd9e2jpwcqrnBOZ9wzaS/HIWNpj9TPK5aBxfm0wRJDAl1om7Z2O27/uMFS93c/q4jh+/BhNFUAYzlqNRv9PwIFosjXbTiS4gZftrTu3SRAegEeONcHdiEB2xnELq634it9ul6s0L8c4g061PK9x4AvuqtEAhsJOJWYWC2Yhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWgYtTDXLdYdczOJgPp1EsSNg1pWEgGagsdSOXGT5xY=;
 b=DAnC0mRwrxhQgpNZ1GqDkWkOlAlRwE9McP5EVwggjXuhTeioPK5h7zJ4+cmxbb2lyII30xsviOLHCqKMDYvRZic+Jr77SqnRXRul/55N90z+mH80rEZk5INpJnTQf6uh03LbvoEJmtWmY/tr8Q3SzdvTMtcF5UwlTRJPMdhxjaY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4365.namprd10.prod.outlook.com (2603:10b6:208:199::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 24 Sep
 2023 18:24:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Sun, 24 Sep 2023
 18:24:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     =?utf-8?B?TWFudGFzIE1pa3VsxJduYXM=?= <grawity@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Data corruption with 5.10.x client -> 6.5.x server
Thread-Topic: Data corruption with 5.10.x client -> 6.5.x server
Thread-Index: AQHZ7uglcAk7YvaB4kSAn1xCF15i5rAp+BsAgAAR7gCAAAN6gIAAI0qAgAAaJQA=
Date:   Sun, 24 Sep 2023 18:24:51 +0000
Message-ID: <6908E735-6912-4AEC-8AD7-995F2F8A144A@oracle.com>
References: <f1d0b234-e650-0f6e-0f5d-126b3d51d1eb@gmail.com>
 <6E4B8EB9-FA7E-4ABD-81AB-6FB0EF07EA46@oracle.com>
 <f90866e3-8c54-8a9c-c100-f5550c31b664@gmail.com>
 <9691788F-2B62-4EB5-8879-CEDABD1B9D4B@oracle.com>
 <78c81a97-4324-c2df-27c0-917436ddee07@gmail.com>
In-Reply-To: <78c81a97-4324-c2df-27c0-917436ddee07@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4365:EE_
x-ms-office365-filtering-correlation-id: 7ab7cc63-9984-4e84-9441-08dbbd2b8aa8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gloFaI9nEbHQJ3FFjGdU7ZbfhoCnhOGm5gki/sfafol+HJltuvMx4BnKC1QcHFhsySsjGEtEa8eGj+n/6dEQhiM/aHUdxPg7bAC5tBUfarSiM1yBk4NSQ5eWI1u3Kv4FDNcAclrUblU7B0+zg6+cY7IAybl+IPXAq62m20f8k/vVmCe6BZquxY7B2CL/hWL8+7aaJqIqCjnd5yDr0SmsYf0ckl7FUMTpL1WsHh5ZDapqto6+mevHIxEgttzBfNfT1kqznj5hUgsDe8YMgqWzXI4MRf4pVTZ7F4NmUedGocReOUky70XMs8X8cxbRmG+lkdPCndduBgWuYKDDlYz0+39lzPj4kWQGU78vejyBV6cGZRm1GlgertCQgkXd4+GydTgm1AqTWdOVXcX4Xou7L9MTlNmHRf0feH2Lm4lhkRWOL022ambQQ5oKNCLS1XT+z+qfMFU+KHsYAguf7ehxg8VH8X6ziZCANdm6mB5EerL87Oz3d4eIO5m732rI+O/zD4xc86AINdCLgg9nizPcDl+iEbiA4mgctTQt3gwzqck9vqH0nJ4/BWuY024RQsJ+5rvWxWLa/Fjs3D2em12fhGfLy0D7LGA57nr616p2CJnk6WzCPIIBZqjbBsaJCmENuzaASM3+jgXvvpN+Pzk+eQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(1800799009)(186009)(451199024)(33656002)(36756003)(122000001)(38100700002)(38070700005)(86362001)(53546011)(5660300002)(6512007)(2616005)(2906002)(478600001)(66476007)(41300700001)(76116006)(316002)(6916009)(64756008)(66446008)(66556008)(91956017)(66946007)(71200400001)(6506007)(6486002)(83380400001)(66574015)(4326008)(8676002)(8936002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ym03bWUvcVZDYkdTbjVUT0JER1BldnFib3pqbjJSbGdMNVA1TEVoSzlqU2N0?=
 =?utf-8?B?am5McXM4QkZoWjRZeXlyVmtVZEFJY09NMHRneU5QNXg3QzAxdU1YMmNYM1Mr?=
 =?utf-8?B?eE4vSGNFdHVsVTNNVUwzbjRvem5taWVHUGdoTmNrZDZLSng0L1RwZXFEWkN3?=
 =?utf-8?B?SXNWL2JkeVArbmdoeVBqa3BqRWhwMGU0bk1teTY0TTZINi85TFFhQVlPQUJW?=
 =?utf-8?B?K3hCM1hxV0dISUNOSzRKWUZsanFmdGtYNHRhMjA3cXdSeDMzTnB5Sk5IaHpB?=
 =?utf-8?B?aWlhSWk2QUJ4YmtFajliMU5MSDUxY1Y4YWFTRmllUzFITStFRkFLNWJzWkZS?=
 =?utf-8?B?blg2YjViY2lNeU5YbWlJeVdWaW9zY2xtaUZhdTFDbTZ1NHBzM3l1Z1JGRzNO?=
 =?utf-8?B?Q3hBWnVsR2FYVXNxT1Mxc2dwNXFKVThMbzJ3RnBueUQzTkRCZE92QkNBU0dY?=
 =?utf-8?B?bXk1Y1E3Z0xlTTgveGc1ZHJRbThod21yOHFDb2ZDbVcwd01UY0drdW1wNjNI?=
 =?utf-8?B?b3NkVWxtSVdwWXRLSGE5U2dQcGRndmt4UzR5TnQzRkVwQWZoTEh2dXlBemhk?=
 =?utf-8?B?UTR2ajM3RlpYbktlN1FabS9adDRWWG54a09hNEVPQmovZER2cEkrZUlrMXph?=
 =?utf-8?B?enZNNkkwaXVPQ0h6UEpRd2ZMbHlJbmFFSkZ0NXl5NzR0VGhROGIxSjlkc0JU?=
 =?utf-8?B?d1VrUE5TU0g0VmVRSDRTRm96cjk4UC9nZFA0eFMyR2RUK2xZdUVrS2lpU1J4?=
 =?utf-8?B?OTFOM3hjdmZyRHRWd1Y5aUdzcUEyV3BMditpbU5jTjZSZHp6ckljc0hKNHQr?=
 =?utf-8?B?bksvUHl6OGJWNXRra1gzdTE5WXlMQ2NVdHNyU1NXdHJCZGNwZmk1OUhHeFJu?=
 =?utf-8?B?Y0lDaWpVMHdGMlV2bjFEdUx3eUo4VjFidmMzT2xpdTNEbnd4a25jQlI4Vkgv?=
 =?utf-8?B?UGtGMENYWHNneGVmNmZKK3dOaGdVaHJzak5sNGkwNjFudTBOeDB2WXUxdGFM?=
 =?utf-8?B?bGV3cUxkZ2NrQ2sxWjFiUUtVNnF6QTlTMk9pMFdPM1dETXJxUXR6RHNvYldV?=
 =?utf-8?B?NnBGL2xDWEZmUXh2TUZNWjFSZllaRE53enhiZ2FLbFRLeVhRUW1pTVY5My9L?=
 =?utf-8?B?U2xrbWZSUkQyZkExY1NCajQzOFI2eUVUdC80UFlESUxEMzQyTUlDUUFjWDRj?=
 =?utf-8?B?NkMxbjFXK2hCaU1FY0ZsK3Y2enArM3Q0enhXcW5tUGtUUlNnczhKY1czNDhS?=
 =?utf-8?B?QUwwUEdvVGYyK0JJNXlPelpBRmNGUTBZczZ1ZkZrTWttRitKdTVOMlBZWnEv?=
 =?utf-8?B?cnhUQjhYM2VxRXpBTUMwcmxKNWRQT0FzTWdjRFdXRWdYSVptaW1HcVROZlhs?=
 =?utf-8?B?MUxIZWFtMVN5SWwzZXdIT20xMVFKVjUzeTBQNXZwekJ0dXpVNmNoZ0xPTmZu?=
 =?utf-8?B?Z0w5aE0yc0xJWjFFVGUwWTBDRVRFWGdtVjVmN01ZNm5mYUx6WU4raUNFeG5w?=
 =?utf-8?B?VUxmM1J3cXNKbDNZMkVPRzhXVjhicm9FakJVVFJwMkVmdlAxajFHUGc3Uzdu?=
 =?utf-8?B?RDA5VE1raDNDSEkwTit3SXJtK0FOQWlzNit4RUpKREdkajhzcW5MZS92M2RZ?=
 =?utf-8?B?ZWVyQ0JOZlVGbzhFcGlXMFdyNHFWVXdybXFYbmdJRXk3N3NaeFIwdVBzcEg5?=
 =?utf-8?B?VHN1SmZiSTUrQ1p3WUEzcU1ZOUwvVTVvNWlaTWR2dlR3elluckkwYWU3RS9O?=
 =?utf-8?B?cFBDN0RtNk9VTnJrNXBnRUxzU1NsSkhXRzNFQTgyUnU2YUtyUkt5TXFZK3BT?=
 =?utf-8?B?MUxOM21WbG5jSUw2UXNwNzFFTjJSU0Y3c2QwZGxPR0lHWStJWXdnZFpPdlY3?=
 =?utf-8?B?MGFTZ2VuQUxSbnFZQ1lZRzI2WUhNKzBZRTExUU5DN1FSZU1sOVFiVUpSTjhS?=
 =?utf-8?B?eURLOGFHR1dTVW1OWm9UQ3ZIZEtRZ28xRGh2bnRhOE9rV2lyM2VBMEFFWjdW?=
 =?utf-8?B?Nk9CQjU0b0UrUE0yT210MU4rR3hHMkx2WGdyeTJ1REorRGlyUzVxWHFHZW5h?=
 =?utf-8?B?Q3ZIUTBsSXhoMGp4NjE0L0tqeWl5MTIxTzdXQTZVVHhkK1QxSW5WWFpjWWlB?=
 =?utf-8?B?RTE1eGFRTUE5bkZBQjNEVGxRSWJhNkY1QzFCYlJmN2NqRW9nSG1FenpNSUxL?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6704A39011C77046AE42A41BB21516D8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CzOHz9PYH0bNcXn39x3s46GRIV9RA3f0cqY0gngFBmMnva3PgMkGaEa6oG/Af9vms8dTArt9M/1qS9bWYtYYr04wwUTUKHRCaiJRdZPRjdd1IslbkAac6D7wgutNu0gxS8SwSr9TV/iZRlIshTlspKkbsmqeGzSwV24mKQ5JgOhxUmetW9Lq3VKAxvgSQMKHJ/d5VBLMGPYLeF2tUqzT370ZldVa8ru5ZnhvQPID1YTJtx7JfX00SlHMWvVCFjxLrOIeCSUiZAF6ijyQ42x24SfC4duyBemRs2BKlE4KrMVdA08Cf2/0oQ7LIv+/9uB99TljkN8YLJC+pHDrkm14vDN8RNLn59ulGzSxcGNQTilKL77QPNYIpf0t1vKqbB4YLzYInuakFi+KBDfWZXN34wR5ua2Z/LgAcdKrnFR7dCjywpgIFESJw5R4wARyXaxNPuyVyQqiWBqF2qpE/+DKVIJ1WEyC0T6rXx0ZGxtgH60Ero7G2maAfxxY9TyKE/3IOAbDxZdbsH7iwFykk5cCxsACsSUSKd/G9gORDJ6tngToUoUYKArB9uJWPVDu2m54QYdavctnRtLxqEcCsBeQ79GTshjG7GN3kkWjKwT6rjrcaFaOQG5bakfr+nV/NZ6qtYV77ov7OMaGly1das/IUcyG3AO4mFAmcxfbLACGqD6txYSjBfw8RaNi1hCfOkJootD9dEs6/umxoPY7SL6W07HW12vb8G2ewaB+j7y/CXt/q1UTxDYGJDz7AsME9DkVhLYz5m/rFqZT0+XH8LfLo3pOneC5T+WOOfIe53ct+OQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab7cc63-9984-4e84-9441-08dbbd2b8aa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2023 18:24:51.0218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSi9HTW3KUGUGm7yrk6/sdzh+k7JU9U25dhzGNZ8zYf61DEfLcIN+709ad2sBrU/ZI579bzz6p0JKVEzu/u+wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4365
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_15,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309240162
X-Proofpoint-GUID: qF1joHJxXK7jEAL0dSBA5wv9td7bu6Ic
X-Proofpoint-ORIG-GUID: qF1joHJxXK7jEAL0dSBA5wv9td7bu6Ic
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gU2VwIDI0LCAyMDIzLCBhdCAxMjo1MSBQTSwgTWFudGFzIE1pa3VsxJduYXMgPGdy
YXdpdHlAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDIwMjMtMDktMjQgMTc6NDQsIENodWNr
IExldmVyIElJSSB3cm90ZToNCj4+PiBPbiBTZXAgMjQsIDIwMjMsIGF0IDEwOjMyIEFNLCBNYW50
YXMgTWlrdWzEl25hcyA8Z3Jhd2l0eUBnbWFpbC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIDIw
MjMtMDktMjQgMTY6MjgsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+Pj4+IE9uIFNlcCAyNCwg
MjAyMywgYXQgOTowNyBBTSwgTWFudGFzIE1pa3VsxJduYXMgPGdyYXdpdHlAZ21haWwuY29tPiB3
cm90ZToNCj4+Pj4+IA0KPj4+Pj4gSSd2ZSByZWNlbnRseSB1cGdyYWRlZCBteSBob21lIE5GUyBz
ZXJ2ZXIgZnJvbSA2LjQuMTIgdG8gNi41LjQgKHJ1bm5pbmcgQXJjaCBMaW51eCB4ODZfNjQpLg0K
Pj4+Pj4gDQo+Pj4+PiBOb3csIHdoZW4gSSdtIGFjY2Vzc2luZyB0aGUgc2VydmVyIG92ZXIgTkZT
djQuMiBmcm9tIGEgY2xpZW50IHRoYXQncyBydW5uaW5nIDUuMTAuMCAoMzItYml0IHg4NiwgRGVi
aWFuIDExKSwgaWYgdGhlIG1vdW50IGlzIHVzaW5nIHNlYz1rcmI1aSBvciBzZWM9a3JiNXAsIHRy
eWluZyB0byByZWFkIGEgZmlsZSB0aGF0J3MgPD0gNDA5MiBieXRlcyBpbiBzaXplIHdpbGwgcmV0
dXJuIGFsbC16ZXJvIGRhdGEuIChUaGF0IGlzLCBgaGV4ZHVtcCAtQyBmaWxlYCBzaG93cyAiMDAg
MDAgMDAuLi4iKSBGaWxlcyB0aGF0IGFyZSA0MDkzIGJ5dGVzIG9yIGxhcmdlciBzZWVtIHRvIGJl
IHVuYWZmZWN0ZWQuDQo+Pj4+PiANCj4+Pj4+IE9ubHkgc2VjPWtyYjVpL2tyYjVwIGFyZSBhZmZl
Y3RlZCBieSB0aGlzIOKAkyBwbGFpbiBzZWM9a3JiNSAob3Igc2VjPXN5cyBmb3IgdGhhdCBtYXR0
ZXIpIHNlZW1zIHRvIHdvcmsgd2l0aG91dCBhbnkgcHJvYmxlbXMuDQo+Pj4+PiANCj4+Pj4+IE5l
d2VyIGNsaWVudHMgKGxpa2UgNi4xLnggb3IgNi40LngpIGRvbid0IHNlZW0gdG8gaGF2ZSBhbnkg
aXNzdWVzLCBpdCdzIG9ubHkgNS4xMC4wIHRoYXQgZG9lcy4uLiB0aG91Z2ggaXQgbWlnaHQgYWxz
byBiZSB0aGF0IHRoZSBjbGllbnQgaXMgMzItYml0LCBidXQgdGhlIHNhbWUgY2xpZW50IGRpZCB3
b3JrIHByZXZpb3VzbHkgd2hlbiB0aGUgc2VydmVyIHdhcyBydW5uaW5nIG9sZGVyIGtlcm5lbHMs
IHNvIEkgc3RpbGwgc3VzcGVjdCA2LjUueCBvbiB0aGUgc2VydmVyIGJlaW5nIHRoZSBwcm9ibGVt
Lg0KPj4+Pj4gDQo+Pj4+PiBVcGdyYWRpbmcgdG8gNi42LjAtcmMyIG9uIHRoZSBzZXJ2ZXIgaGFz
bid0IGNoYW5nZWQgYW55dGhpbmcuDQo+Pj4+PiBUaGUgc2VydmVyIGlzIHVzaW5nIEJ0cmZzIGJ1
dCBJJ3ZlIHRlc3RlZCB3aXRoIHRtcGZzIGFzIHdlbGwuDQo+Pj4+IEknbSBndWVzc2luZyBwcm90
bz10Y3AgYXMgd2VsbCAoYXMgb3Bwb3NlZCB0byBwcm90bz1yZG1hKS4NCj4+PiANCj4+PiBZZXMs
IGl0J3MgVENQLg0KPj4+IA0KPj4+IChJIGRvIGhhdmUgUkRNQSBzZXQgdXAgYmV0d2VlbiB0d28g
b2YgdGhlIDYuNS54IHNlcnZlciBzeXN0ZW1zLCBidXQgaW4gdGhpcyBjYXNlIGFsbCB0aGUgY2xp
ZW50cyBJJ3ZlIHRlc3RlZCB3ZXJlIFRDUC1vbmx5LCBhbmQgdGhlIGhvbWUgc2VydmVyIHRoYXQg
SSBvcmlnaW5hbGx5IG5vdGljZWQgdGhlIHByb2JsZW0gd2l0aCBkb2Vzbid0IGhhdmUgUkRNQSBh
dCBhbGwuKQ0KPj4+IA0KPj4+PiBEb2VzIHRoZSBwcm9ibGVtIGdvIGF3YXkgd2l0aCB2ZXJzPTQu
MSA/DQo+Pj4gDQo+Pj4gTm8sIGl0IGRvZXNuJ3QgKG5laXRoZXIgd2l0aCA0LjApLg0KPj4+IA0K
Pj4+PiBDYW4geW91IGNhcHR1cmUgbmV0d29yayB0cmFmZmljIGR1cmluZyB0aGUgZmFpbHVyZT8g
VXNlIHNlYz1rcmI1aSBzbw0KPj4+PiB3ZSBjYW4gc2VlIHRoZSBSUEMgcGF5bG9hZHMuIE9uIHRo
ZSBjbGllbnQ6DQo+Pj4+ICMgdGNwZHVtcCAtaWFueSAtczAgLXcvdG1wL3NuaWZmZXIucGNhcA0K
Pj4+IA0KPj4+IEF0dGFjaGVkLiAoVGhlIHNjcmlwdCBJJ3ZlIGJlZW4gdXNpbmcgZm9yIHRlc3Rp
bmcgbW91bnRzIHdpdGggLW8gc2VjPWtyYjVpLCBjYXRzIHRocmVlIGZpbGVzLCB0aGVuIHVubW91
bnRzLik8bmZzX2tyYjVpLnBjYXA+DQo+PiBJIHNlZSB0aHJlZSBORlMgUkVBRHMgaW4gdGhlIGNh
cHR1cmUuDQo+PiBUaGUgZmlyc3QgUkVBRCBwYXlsb2FkIGlzIGFsbCB6ZXJvZXMuIFRoZSBzZWNv
bmQgcGF5bG9hZCBjb250YWlucw0KPj4gIkhlbGxvIFdvcmxkICg0MDkzIGJ5dGVzKSIgcmVwZWF0
ZWRseSwgYW5kIHRoZSB0aGlyZCBjb250YWlucw0KPj4gIkhlbGxvIFdvcmxkICg0MDk2IGJ5dGVz
KSIgcmVwZWF0ZWRseS4NCj4gDQo+IFJpZ2h0LCB3aGVyZWFzIG9uIHRoZSBzZXJ2ZXIsIHRoZSBm
aXJzdCBmaWxlIGlzIGZpbGxlZCB3aXRoICJIZWxsbyBXb3JsZCAoNDA5MiBieXRlcykiIGFzIEkg
b3JpZ2luYWxseSB0cmllZCB0byBuYXJyb3cgZG93biB0aGUgaXNzdWUuDQo+IA0KPiBNZWFud2hp
bGUsIDYuNC54IChBcmNoKSBjbGllbnRzIGRvbid0IHNlZW0gdG8gYmUgaGF2aW5nIGFueSBwcm9i
bGVtcyB3aXRoIHRoZSBzYW1lIHNlcnZlciwgYW5kIHdpdGggc2VlbWluZ2x5IHRoZSBzYW1lIG1v
dW50IG9wdGlvbnMuDQo+IA0KPiBUaGFua3MgZm9yIGxvb2tpbmcgaW50byBpdCE8bmZzX2tyYjVp
X3dvcmtpbmdfNi40Y2xpZW50LnBjYXA+DQoNCkkgZm91bmQgL2EvIHByb2JsZW0gd2l0aCB0aGUg
bmZzZC1maXhlcyBicmFuY2ggYW5kIGtyYjVpLCBidXQNCm1heWJlIG5vdCAveW91ci8gcHJvYmxl
bSwgYW5kIGl0J3Mgd2l0aCBhIHJlY2VudCBjbGllbnQuIFNjcm91bmdpbmcNCmEgdjUuMTAtdmlu
dGFnZSBjbGllbnQgaXMgYSBsaXR0bGUgbW9yZSB3b3JrLCB3ZSdsbCBzZWUgaWYgdGhhdCdzDQpu
ZWVkZWQgZm9yIGNvbmZpcm1pbmcgYW4gZXZlbnR1YWwgZml4Lg0KDQoNCi0tDQpDaHVjayBMZXZl
cg0KDQoNCg==
